import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { runRefresh, observationCycleDate, type RunMode } from "@/lib/learner/refreshRun";
import { CONCEPT_STATE_PAYLOAD_COLUMNS } from "@/lib/learner/conceptStatePersistence";

const ROOT = process.cwd();
const MIGRATION = fs.readFileSync(
  path.join(ROOT, "supabase", "migrations", "20261007_05_concept_state_history.sql"), "utf8");
const ROUTE = fs.readFileSync(
  path.join(ROOT, "app", "api", "learner", "cron", "refresh", "route.ts"), "utf8");
const strip = (s: string) =>
  s.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "")
   .split("\n").map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");

// ─── IDENTITY IS THE CYCLE, NOT THE STUDY DAY ───────────────────────────────

describe("THE OBSERVATION IDENTITY", () => {
  it("BOTH UNIQUE KEYS ARE NAMED, which the first apply attempt proved necessary", () => {
    // The parent carries two unique constraints: the cycle identity, and the
    // pair the child's foreign key points at. On the first attempt to apply
    // this file the second one was written unnamed, directly beneath the
    // CONSTRAINT keyword belonging to the first, so it silently took that
    // name. The identity then covered (id, user_id), which is unique for
    // every row and therefore enforces nothing: a retry of a cycle already
    // recorded would have written a second observation. The migration's own
    // catalog check caught it and the apply aborted, changing nothing.
    //
    // Naming both is what stops it recurring, so the names are asserted here
    // and the columns under each are asserted in the migration against the
    // live catalog.
    expect(MIGRATION).toMatch(
      /CONSTRAINT learner_concept_state_observations_cycle_identity\s*\n\s*UNIQUE \(user_id, observation_cycle_date, model_version\)/);
    expect(MIGRATION).toMatch(
      /CONSTRAINT learner_concept_state_observations_owner_ref\s*\n\s*UNIQUE \(id, user_id\)/);
    expect(MIGRATION).toMatch(/expected exactly 2 unique constraints on observations/);

    // No named constraint may have a comment between its name and what it
    // binds to. That is the exact shape of the original mistake.
    const lines = MIGRATION.split("\n");
    const detached: string[] = [];
    lines.forEach((line, i) => {
      const m = /^\s*CONSTRAINT\s+(\S+)\s*$/.exec(line);
      if (!m) return;
      let j = i + 1;
      while (j < lines.length && (!lines[j].trim() || lines[j].trim().startsWith("--"))) j++;
      if (j > i + 1) detached.push(m[1]);
    });
    expect(detached).toEqual([]);
  });

  it("is (user_id, observation_cycle_date, model_version)", () => {
    expect(MIGRATION).toMatch(/UNIQUE \(user_id, observation_cycle_date, model_version\)/);
    expect(MIGRATION).toMatch(/the observation identity is \(%\), expected \(user_id,observation_cycle_date,model_version\)/);
  });

  it("is NOT the learner's study day, anywhere", () => {
    const body = strip(MIGRATION);
    expect(body).not.toMatch(/UNIQUE \([^)]*study_day/);
    expect(body).not.toMatch(/PRIMARY KEY \([^)]*study_day/);
  });

  it("the cycle is the UTC date of the run, independent of every learner's zone", () => {
    expect(observationCycleDate(new Date("2026-10-08T09:00:00Z"))).toBe("2026-10-08");
    // 09:00 UTC is the previous day in Los Angeles and the next in Sydney; the
    // cycle is the same for all three, which is the point.
    expect(observationCycleDate(new Date("2026-10-08T23:59:59Z"))).toBe("2026-10-08");
    expect(observationCycleDate(new Date("2026-10-09T00:00:00Z"))).toBe("2026-10-09");
  });

  it("A REPEATED STUDY DAY ACROSS TWO CYCLES IS REPRESENTABLE", () => {
    // The fixture the whole identity decision exists for, asserted against the
    // migration's own live probe:
    //
    //   cycle 10-08, timezone NULL -> UTC   -> study_day 10-08
    //   learner opens the app from California, zone captured
    //   cycle 10-09, America/Los_Angeles    -> study_day 10-08 AGAIN
    //
    // Two real observations, one local label. A unique key on study_day would
    // have refused the second and lost a day with nothing to show for it.
    expect(MIGRATION).toMatch(/a second cycle with a repeated study_day was refused/);
    expect(MIGRATION).toMatch(/expected 2 observations sharing one study_day/);
  });
});

// ─── ZERO STATES IS NOT A GAP ───────────────────────────────────────────────

describe("A SUCCESSFUL EMPTY OBSERVATION IS NOT A MISSING ONE", () => {
  it("is why there are two tables at all", () => {
    expect(MIGRATION).toMatch(/CREATE TABLE IF NOT EXISTS public\.learner_concept_state_observations/);
    expect(MIGRATION).toMatch(/CREATE TABLE IF NOT EXISTS public\.learner_concept_state_history/);
    expect(MIGRATION).toMatch(/state_count 0 means observed with no concept state/);
  });

  it("a zero-state observation still records a parent", () => {
    expect(MIGRATION).toMatch(/a zero-state observation was not recorded/);
    expect(MIGRATION).toMatch(/the zero-state observation recorded state_count/);
  });

  it("state_count 0 is legal, and negative is not", () => {
    expect(MIGRATION).toMatch(/state_count >= 0/);
    expect(strip(MIGRATION)).not.toMatch(/state_count > 0/);
  });

  it("a failed account leaves no observation at all", async () => {
    // The gap case, driven through the real orchestration.
    const world = fakeWorld({ users: [u("ok"), u("broken")], rpcFails: new Set(["broken"]) });
    const r = await runRefresh(world as never, { now: NOW, mode: "SCHEDULED", force: true });
    expect(r.failed).toBe(1);
    const bad = r.accounts.find((a) => a.userId === "broken")!;
    expect(bad.historyStatus).toBeNull();
    expect(bad.observationId).toBeNull();
    // And the healthy one still got its observation.
    const good = r.accounts.find((a) => a.userId === "ok")!;
    expect(good.historyStatus).toBe("RECORDED");
  });
});

// ─── ONLY THE SCHEDULED RUN WRITES HISTORY ──────────────────────────────────

const NOW = new Date("2026-10-08T09:00:00.000Z");
const u = (id: string, profile?: { account_kind?: string | null; day_start_hour?: number | null; timezone?: string | null } | null) =>
  ({ id, profile });

function fakeWorld(opts: {
  users?: ReturnType<typeof u>[];
  rpcFails?: Set<string>;
  alreadyRecorded?: Set<string>;
} = {}) {
  const users = opts.users ?? [];
  const calls: { name: string; user: string; cycle?: string; states: number }[] = [];
  const world = {
    users, calls,
    auth: { admin: { async listUsers({ page, perPage }: { page: number; perPage: number }) {
      const start = (page - 1) * perPage;
      return { data: { users: world.users.slice(start, start + perPage).map((x) => ({
        id: x.id, email: `${x.id}@example.com`, created_at: "2026-01-01T00:00:00Z", last_sign_in_at: null })) }, error: null };
    } } },
    from(table: string) {
      const api = {
        select() { return api; }, eq() { return api; }, order() { return api; },
        limit() { return Promise.resolve({ data: [], error: null }); },
        range(from: number, to: number) {
          if (table === "profiles") {
            const rows = world.users.filter((x) => x.profile !== null).map((x) => ({
              id: x.id,
              account_kind: x.profile?.account_kind === undefined ? "STUDENT" : x.profile.account_kind,
              day_start_hour: x.profile?.day_start_hour === undefined ? 4 : x.profile.day_start_hour,
              timezone: x.profile?.timezone === undefined ? null : x.profile.timezone,
            }));
            return Promise.resolve({ data: rows.slice(from, to + 1), error: null });
          }
          return Promise.resolve({ data: [], error: null });
        },
      };
      return api;
    },
    async rpc(name: string, args: Record<string, unknown>) {
      const user = args.p_user_id as string;
      const states = (args.p_states as unknown[]).length;
      if (opts.rpcFails?.has(user)) return { data: null, error: { message: "writer refused" } };
      calls.push({ name, user, cycle: args.p_cycle_date as string | undefined, states });
      if (name === "record_scheduled_observation") {
        const already = opts.alreadyRecorded?.has(user);
        return { data: {
          user_id: user, observation_cycle: args.p_cycle_date,
          history_status: already ? "ALREADY_RECORDED" : "RECORDED",
          observation_id: already ? "existing-obs" : `obs-${user}`,
          history_rows_inserted: already ? 0 : states,
          current_rows_received: states, current_rows_final: states,
        }, error: null };
      }
      return { data: { user_id: user, rows_received: states, rows_upserted: states,
        rows_deleted: 0, final_row_count: states }, error: null };
    },
  };
  return world;
}

describe("manual versus scheduled, enforced structurally", () => {
  it.each([
    ["SCHEDULED", "record_scheduled_observation"],
    ["MANUAL", "replace_learner_concept_states"],
  ])("a %s run calls %s", async (mode, expected) => {
    const world = fakeWorld({ users: [u("a")] });
    await runRefresh(world as never, { now: NOW, mode: mode as RunMode, force: true });
    expect(world.calls.map((c) => c.name)).toEqual([expected]);
  });

  it("a MANUAL run records no history at all", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")] });
    const r = await runRefresh(world as never, { now: NOW, mode: "MANUAL", force: true });
    expect(r.observationCycle).toBeNull();
    expect(r.observationsRecorded).toBe(0);
    expect(r.historyRowsWritten).toBe(0);
    expect(r.accounts.every((a) => a.historyStatus === null)).toBe(true);
  });

  it("a DRY run writes neither", async () => {
    const world = fakeWorld({ users: [u("a")] });
    const r = await runRefresh(world as never, { now: NOW, mode: "DRY" });
    expect(world.calls).toEqual([]);
    expect(r.observationsRecorded).toBe(0);
  });

  it("a SCHEDULED run carries the cycle to every account", async () => {
    const world = fakeWorld({ users: [u("a"), u("b"), u("c")] });
    const r = await runRefresh(world as never, { now: NOW, mode: "SCHEDULED", force: true });
    expect(r.observationCycle).toBe("2026-10-08");
    expect(new Set(world.calls.map((c) => c.cycle))).toEqual(new Set(["2026-10-08"]));
    expect(r.observationsRecorded).toBe(3);
  });

  it("a same-cycle retry reports ALREADY_RECORDED and writes no history", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")], alreadyRecorded: new Set(["a"]) });
    const r = await runRefresh(world as never, { now: NOW, mode: "SCHEDULED", force: true });
    expect(r.observationsAlreadyRecorded).toBe(1);
    expect(r.observationsRecorded).toBe(1);
    expect(r.accounts.find((a) => a.userId === "a")!.historyStatus).toBe("ALREADY_RECORDED");
    // Current state is still replaced for that account: it is replaceable.
    expect(world.calls.filter((c) => c.user === "a")).toHaveLength(1);
  });
});

describe("the route cannot be talked into writing history", () => {
  const body = strip(ROUTE);

  it("no query parameter can UPGRADE a run to SCHEDULED", () => {
    // Query flags only ever make a run do less.
    // Only two query flags are read at all, and both only ever downgrade.
    const params = [...body.matchAll(/searchParams\.get\("([a-z-]+)"\)/g)].map((m) => m[1]).sort();
    expect(params).toEqual(["dry", "force"]);
    expect(body).toMatch(/searchParams\.get\("dry"\) === "1" \? "DRY"/);
    // SCHEDULED is driven by a header-derived flag, never by a query value.
    expect(body).toMatch(/: isScheduled \? "SCHEDULED"/);
    expect(body).not.toMatch(/searchParams[^\n]*SCHEDULED/);
  });

  it("becoming SCHEDULED needs a header signal, not an omission", () => {
    expect(body).toMatch(/headers\.get\("user-agent"\)/);
    expect(body).toMatch(/vercel-cron/i);
    expect(body).toMatch(/headers\.get\("x-praxist-run-mode"\)/);
    // Default is MANUAL: omitting everything does not buy history.
    expect(body).toMatch(/: "MANUAL"/);
  });

  it("still requires the cron secret before any of that", () => {
    const secretCheck = body.indexOf("CRON_SECRET");
    const modeDecision = body.indexOf("isScheduled");
    expect(secretCheck).toBeGreaterThan(-1);
    expect(secretCheck).toBeLessThan(modeDecision);
  });
});

// ─── THE SCHEMA ─────────────────────────────────────────────────────────────

describe("what an observation carries forward", () => {
  it("stores the timezone it USED, not a join to today's profile", () => {
    expect(MIGRATION).toMatch(/timezone_used {3}TEXT {4}NOT NULL/);
    expect(MIGRATION).toMatch(/A learner may legitimately change either/);
  });

  it("distinguishes a declared UTC from an unknown one", () => {
    expect(MIGRATION).toMatch(/timezone_source TEXT {4}NOT NULL/);
    expect(MIGRATION).toMatch(/CHECK \(timezone_source IN \('PROFILE', 'DEFAULT_UTC'\)\)/);
    expect(MIGRATION).toMatch(/distinguishable from "we did not know where they were"/);
  });

  it("stores the day_start_hour it used, constrained 0-23", () => {
    expect(MIGRATION).toMatch(/day_start_hour {2}INTEGER NOT NULL/);
    expect(MIGRATION).toMatch(/day_start_hour BETWEEN 0 AND 23/);
  });

  it("keeps observed_at separate from study_day and the cycle", () => {
    for (const f of ["observed_at", "study_day", "observation_cycle_date"]) {
      expect(MIGRATION, f).toMatch(new RegExp(`${f}\\s`));
    }
  });

  it("the orchestration supplies all of it from the run's own context", async () => {
    const world = fakeWorld({ users: [
      u("known", { timezone: "Asia/Tokyo" }),
      u("unknown", { timezone: null }),
    ] });
    const r = await runRefresh(world as never, { now: NOW, mode: "SCHEDULED", force: true });
    const known = r.accounts.find((a) => a.userId === "known")!;
    const unknown = r.accounts.find((a) => a.userId === "unknown")!;
    expect(known.timeZone).toBe("Asia/Tokyo");
    expect(known.timeZoneSource).toBe("PROFILE");
    expect(unknown.timeZone).toBe("UTC");
    expect(unknown.timeZoneSource).toBe("DEFAULT_UTC");
    expect(known.dayStartHour).toBe(4);
  });
});

describe("the child rows", () => {
  it("carry exactly the per-concept fields, and none of the batch facts", () => {
    const table = MIGRATION.slice(
      MIGRATION.indexOf("CREATE TABLE IF NOT EXISTS public.learner_concept_state_history"),
      MIGRATION.indexOf("PRIMARY KEY (observation_id, concept_id)"));
    for (const col of CONCEPT_STATE_PAYLOAD_COLUMNS) {
      expect(table, col).toMatch(new RegExp(`\\b${col}\\b`));
    }
    // The temporal and version facts live on the parent, not repeated per
    // concept. user_id is the deliberate exception and is covered below.
    for (const parentOnly of ["study_day", "computed_at", "model_version",
                              "observation_cycle_date", "timezone_used"]) {
      expect(table, parentOnly).not.toMatch(new RegExp(`^\\s+${parentOnly}\\s`, "m"));
    }
  });

  it("belong to exactly one observation", () => {
    expect(MIGRATION).toMatch(/PRIMARY KEY \(observation_id, concept_id\)/);
    expect(MIGRATION).toMatch(
      /FOREIGN KEY \(observation_id, user_id\)\s*\n\s*REFERENCES public\.learner_concept_state_observations\(id, user_id\)\s*\n\s*ON DELETE CASCADE/);
  });

  it("REPEAT THE OWNER, AND MAKE IT UNFORGEABLE", () => {
    // The owner is derivable by joining the parent, so copying it onto the
    // child looks like redundancy. It is there because the account reset
    // deletes every table in its scope with one statement shape -- delete
    // where user_id equals the caller -- and a child table it cannot filter
    // that way fails the whole reset halfway through. Leaning on the parent
    // CASCADE instead would delete the rows while reporting a count of zero,
    // which tells someone their history was already empty on the day they
    // asked for it to be erased.
    const table = MIGRATION.slice(
      MIGRATION.indexOf("CREATE TABLE IF NOT EXISTS public.learner_concept_state_history"),
      MIGRATION.indexOf("PRIMARY KEY (observation_id, concept_id)"));
    expect(table).toMatch(/^\s+user_id UUID NOT NULL,/m);

    // A copy that can drift is worse than no copy. The composite foreign key
    // is what makes drift unrepresentable rather than merely discouraged, and
    // it needs the pair to be unique on the parent to point at.
    expect(MIGRATION).toMatch(/UNIQUE \(id, user_id\)/);
    expect(MIGRATION).toMatch(/FOREIGN KEY \(observation_id, user_id\)/);

    // Proved behaviourally too, in a way that cannot pass by accident: the
    // probe targets an observation with no children, so a primary-key
    // collision cannot stand in for the foreign key, and it also checks the
    // same row with the right owner IS accepted.
    expect(MIGRATION).toMatch(/a history row named an owner its observation does not have/);
    expect(MIGRATION).toMatch(/a correctly owned history row was refused/);
    expect(MIGRATION).toMatch(/obs_zero/);

    // And both filtered paths get an index, because this is the one table
    // guaranteed to grow without bound.
    expect(MIGRATION).toMatch(
      /CREATE INDEX IF NOT EXISTS learner_concept_state_history_user_idx\s*\n\s*ON public\.learner_concept_state_history \(user_id\)/);
  });

  it("the row-level policy is an own-row check, which the key makes safe", () => {
    // An EXISTS against the parent would also be correct, and is what this
    // started as. The own-row form is only sound BECAUSE the composite key
    // guarantees this user_id is the parent's; without the key it would be a
    // policy trusting a column anyone writing the table could set.
    expect(MIGRATION).toMatch(
      /CREATE POLICY "Users read own concept history"[\s\S]{0,120}USING \(auth\.uid\(\) = user_id\)/);
  });

  it("the reset statement shape is exercised against both tables", () => {
    // Not an assertion about the reset's source, which lib/account covers.
    // This is the migration proving the shape works on the schema it creates,
    // children before parent so both counts are truthful.
    expect(MIGRATION).toMatch(
      /DELETE FROM public\.learner_concept_state_history WHERE user_id = u;/);
    expect(MIGRATION).toMatch(
      /DELETE FROM public\.learner_concept_state_observations WHERE user_id = u;/);
    const children = MIGRATION.indexOf("DELETE FROM public.learner_concept_state_history WHERE user_id = u;");
    const parent = MIGRATION.indexOf("DELETE FROM public.learner_concept_state_observations WHERE user_id = u;");
    expect(children).toBeLessThan(parent);
  });

  it("hold the same integrity the current table enforces", () => {
    for (const c of ["coverage_contract", "memory_contract", "memory_ranges",
                     "application_contract", "application_bounds"]) {
      expect(MIGRATION, c).toMatch(new RegExp(`learner_concept_state_history_${c}`));
    }
    // Including the measured Wilson tolerance.
    expect(MIGRATION).toMatch(/BETWEEN -1e-9 AND 1 \+ 1e-9/);
  });

  it("SURVIVE ONTOLOGY LIFECYCLE: concept deletion is restricted", () => {
    expect(MIGRATION).toMatch(/REFERENCES public\.concepts\(id\) ON DELETE RESTRICT/);
    expect(MIGRATION).toMatch(/the concept foreign key is %, expected RESTRICT/);
    // Proved from the catalog rather than by attempting a delete: a probe that
    // tried one would hard-delete a production concept in exactly the case it
    // exists to catch, and would make this a migration that writes the
    // ontology, which the write-scope lint rightly refuses.
    expect(MIGRATION).toMatch(/PROVED FROM THE CATALOG, NOT BY ATTEMPTING ONE/);
    const body = strip(MIGRATION);
    expect(body).not.toMatch(/DELETE\s+FROM\s+public\.concepts/);
  });
});

describe("immutable, but deletable", () => {
  it("refuses UPDATE on both tables", () => {
    expect(MIGRATION).toMatch(/CREATE TRIGGER learner_concept_state_observations_immutable[\s\S]{0,120}BEFORE UPDATE/);
    expect(MIGRATION).toMatch(/CREATE TRIGGER learner_concept_state_history_immutable[\s\S]{0,120}BEFORE UPDATE/);
    expect(MIGRATION).toMatch(/an observation was updated/);
    expect(MIGRATION).toMatch(/a history row was updated/);
  });

  it("does NOT block DELETE, because privacy is not semantic mutation", () => {
    // Scoped to the CREATE TRIGGER statements. The function's own error
    // message mentions DELETE on purpose, to tell a reader it is still
    // available, so searching the whole block finds prose rather than a rule.
    const triggers = [...MIGRATION.matchAll(/CREATE TRIGGER \w+_immutable[\s\S]{0,160}?;/g)].map((m) => m[0]);
    expect(triggers).toHaveLength(2);
    for (const t of triggers) {
      expect(t).toMatch(/BEFORE UPDATE ON/);
      expect(t).not.toMatch(/DELETE/);
      expect(t).not.toMatch(/INSERT/);
    }
    expect(MIGRATION).toMatch(/account reset and account deletion/);
  });

  it("lets a deleted account take its history with it", () => {
    expect(MIGRATION).toMatch(/REFERENCES auth\.users\(id\) ON DELETE CASCADE/);
    expect(MIGRATION).toMatch(/expected CASCADE so deletion can remove history/);
  });
});

describe("security", () => {
  it("learners read their own and write nothing", () => {
    expect(MIGRATION).toMatch(/ENABLE ROW LEVEL SECURITY/);
    expect(MIGRATION).toMatch(/CREATE POLICY "Users read own observations"[\s\S]{0,120}FOR SELECT/);
    expect(MIGRATION).toMatch(/CREATE POLICY "Users read own concept history"[\s\S]{0,200}FOR SELECT/);
    expect(MIGRATION).toMatch(/expected exactly two SELECT policies/);
  });

  it("revokes every write privilege from anon and authenticated", () => {
    expect(MIGRATION).toMatch(/REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public\.learner_concept_state_observations FROM anon, authenticated/);
    expect(MIGRATION).toMatch(/REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public\.learner_concept_state_history FROM anon, authenticated/);
  });

  it("the writer is service_role only and SECURITY INVOKER", () => {
    const decl = MIGRATION.slice(
      MIGRATION.indexOf("CREATE OR REPLACE FUNCTION public.record_scheduled_observation"),
      MIGRATION.indexOf("AS $fn$\nDECLARE\n  current_result"));
    expect(strip(decl)).toMatch(/SECURITY INVOKER/);
    expect(strip(decl)).not.toMatch(/SECURITY DEFINER/);
    expect(MIGRATION).toMatch(/GRANT EXECUTE ON FUNCTION public\.record_scheduled_observation[\s\S]{0,120}TO service_role/);
  });
});

describe("one model, one validation contract", () => {
  it("the scheduled writer CALLS the current writer rather than reimplementing it", () => {
    expect(MIGRATION).toMatch(/current_result := public\.replace_learner_concept_states\(/);
    expect(MIGRATION).toMatch(/second interpretation of ConceptState that could drift/);
  });

  it("history is inserted from the same payload the current write validated", () => {
    expect(MIGRATION).toMatch(/FROM jsonb_to_recordset\(p_states\)/);
    expect(MIGRATION).toMatch(/Reading it back[\s\S]{0,24}out of learner_concept_states instead would be a second source of truth/);
  });

  it("both halves are one transaction, proved by a failing batch", () => {
    expect(MIGRATION).toMatch(/a failed scheduled write still changed current state/);
    expect(MIGRATION).toMatch(/a failed scheduled write left an observation behind/);
  });

  it("THE PROBES CANNOT PERSIST ANYTHING, rather than cleaning up after themselves", () => {
    // The probes have to call the real writer, and the real writer only takes
    // a real account because a foreign key ties it to auth.users. So they
    // borrow a live learner.
    //
    // That is only safe because nothing they do is kept. The first version of
    // this migration cleaned up by deleting the rows it had written, which is
    // not the same thing: replace_learner_concept_states replaces a learner's
    // entire current state across every model version, so the first probe
    // destroyed five real rows belonging to the borrowed account, and no
    // delete of the PROBE rows could restore them. The count check caught it
    // and the migration aborted.
    //
    // So the probes now run in a subtransaction that is always discarded.
    expect(MIGRATION).toMatch(/BEGIN\s*\n\s*EXECUTE 'SET LOCAL ROLE service_role';/);
    expect(MIGRATION).toMatch(/RAISE EXCEPTION 'PROBE_ROLLBACK';/);
    expect(MIGRATION).toMatch(/IF SQLERRM <> 'PROBE_ROLLBACK' THEN/);

    // The sentinel is raised unconditionally. A rollback that only happens on
    // failure would leave the probe rows behind on success, which is the case
    // that actually occurs.
    const reset = MIGRATION.indexOf("EXECUTE 'RESET ROLE';");
    const sentinel = MIGRATION.indexOf("RAISE EXCEPTION 'PROBE_ROLLBACK';");
    expect(sentinel).toBeGreaterThan(reset);
    expect(MIGRATION.slice(reset, sentinel)).not.toMatch(/\bIF\b/);

    // And no probe cleans up by hand any more. A delete of PROBE rows would
    // mean something was expected to survive the block.
    const body = strip(MIGRATION);
    expect(body).not.toMatch(/DELETE FROM public\.learner_concept_states WHERE model_version = 'PROBE'/);

    // The rollback is verified, not assumed.
    expect(MIGRATION).toMatch(/survived the probe rollback/);
    expect(MIGRATION).toMatch(/current state went from % to %\. The probes borrowed a real learner/);
  });

  it("the tables commit empty: no retrospective backfill", () => {
    expect(MIGRATION).toMatch(/the observation table must commit empty/);
    expect(MIGRATION).toMatch(/the history table must commit empty/);
    const body = strip(MIGRATION);
    // Nothing reads current state or old snapshots to manufacture history.
    expect(body).not.toMatch(/INSERT INTO public\.learner_concept_state_history[\s\S]{0,400}FROM public\.learner_concept_states/);
    expect(body).not.toMatch(/learner_state_snapshots/);
  });

  it("does not make history an input to the pure model", () => {
    const model = fs.readFileSync(path.join(ROOT, "lib", "learner", "conceptState.ts"), "utf8");
    expect(model).not.toMatch(/learner_concept_state_history|learner_concept_state_observations/);
  });
});
