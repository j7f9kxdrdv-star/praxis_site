import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { runRefresh, runSucceeded, RECENT_RUN_MINUTES } from "@/lib/learner/refreshRun";
import { ACCOUNT_PAGE_SIZE } from "@/lib/learner/accountUniverse";

// ─── A SCHEDULED RUN DISCOVERS ACCOUNTS; IT NEVER REMEMBERS THEM ────────────
//
// The failure these guard against is not a crash. It is a run that looks
// perfectly green every day while quietly never touching an account nobody
// added to a list.

/** A fake database and admin API, with a universe the test can change. */
function fakeWorld(opts: {
  users?: { id: string; profile?: { account_kind?: string | null; day_start_hour?: number | null } | null }[];
  lastComputedAt?: string | null;
  rpcFails?: Set<string>;
} = {}) {
  const users = opts.users ?? [];
  const rpcCalls: { user: string; states: number; studyDay: string; computedAt: string }[] = [];
  const world = {
    users,
    rpcCalls,
    auth: { admin: { async listUsers({ page, perPage }: { page: number; perPage: number }) {
      const start = (page - 1) * perPage;
      return { data: { users: world.users.slice(start, start + perPage).map((u) => ({
        id: u.id, email: `${u.id}@example.com`, created_at: "2026-01-01T00:00:00Z", last_sign_in_at: null })) }, error: null };
    } } },
    from(table: string) {
      const q: Record<string, unknown> = {};
      const api = {
        select() { return api; },
        eq() { return api; },
        order() { return api; },
        limit() {
          if (table === "learner_concept_states") {
            return Promise.resolve({ data: opts.lastComputedAt ? [{ computed_at: opts.lastComputedAt }] : [], error: null });
          }
          return Promise.resolve({ data: [], error: null });
        },
        range(from: number, to: number) {
          if (table === "profiles") {
            const rows = world.users.filter((u) => u.profile !== null).map((u) => ({
              id: u.id,
              account_kind: u.profile?.account_kind === undefined ? "STUDENT" : u.profile.account_kind,
              day_start_hour: u.profile?.day_start_hour === undefined ? 4 : u.profile.day_start_hour,
            }));
            return Promise.resolve({ data: rows.slice(from, to + 1), error: null });
          }
          return Promise.resolve({ data: [], error: null });
        },
      };
      void q;
      return api;
    },
    async rpc(_name: string, args: Record<string, unknown>) {
      const user = args.p_user_id as string;
      const states = (args.p_states as unknown[]).length;
      if (opts.rpcFails?.has(user)) return { data: null, error: { message: "writer refused" } };
      rpcCalls.push({ user, states, studyDay: args.p_study_day as string, computedAt: args.p_computed_at as string });
      return { data: { user_id: user, rows_received: states, rows_upserted: states, rows_deleted: 0,
        final_row_count: states, model_version: args.p_model_version, study_day: args.p_study_day,
        computed_at: args.p_computed_at }, error: null };
    },
  };
  return world;
}

const u = (id: string, profile?: { account_kind?: string | null; day_start_hour?: number | null } | null) => ({ id, profile });
const NOW = new Date("2026-10-07T09:00:00.000Z");

describe("the preflight runs before anything is written", () => {
  it("an auth user with no profile stops the whole run", async () => {
    const world = fakeWorld({ users: [u("a"), u("b", null), u("c")] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("INTEGRITY_FAILURE");
    expect(r.integrityOk).toBe(false);
    expect(r.integrityFailures.join(" ")).toMatch(/b.*no public\.profiles row/);
    // NOTHING WRITTEN. Refreshing the healthy accounts and reporting success is
    // exactly how an account stays invisible.
    expect(world.rpcCalls).toEqual([]);
    expect(r.attempted).toBe(0);
    expect(runSucceeded(r)).toBe(false);
  });

  it("a profile missing day_start_hour stops it too", async () => {
    const world = fakeWorld({ users: [u("a"), u("b", { day_start_hour: null })] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("INTEGRITY_FAILURE");
    expect(world.rpcCalls).toEqual([]);
  });

  it("a healthy universe proceeds", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("COMPLETED");
    expect(r.integrityOk).toBe(true);
    expect(r.attempted).toBe(2);
  });
});

describe("EVERY ACCOUNT IS PROCESSED, INCLUDING THE EMPTY ONES", () => {
  it("an account with no evidence is written with an empty batch, not skipped", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(world.rpcCalls.map((c) => c.user).sort()).toEqual(["a", "b"]);
    expect(world.rpcCalls.every((c) => c.states === 0)).toBe(true);
    expect(r.zeroState).toBe(2);
    expect(r.succeeded).toBe(2);
    // The distinction the whole invariant turns on.
    expect(r.attempted).toBe(r.authAccounts);
  });

  it("all three account kinds are refreshed identically", async () => {
    const world = fakeWorld({ users: [
      u("s", { account_kind: "STUDENT" }), u("d", { account_kind: "DEMO" }), u("i", { account_kind: "INTERNAL" })] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.attempted).toBe(3);
    expect(world.rpcCalls.map((c) => c.user).sort()).toEqual(["d", "i", "s"]);
    expect(r.accounts.map((a) => a.accountKind).sort()).toEqual(["DEMO", "INTERNAL", "STUDENT"]);
  });
});

describe("A FUTURE ACCOUNT JOINS THE NEXT RUN BY EXISTING", () => {
  it("an account created between runs appears automatically", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")] });
    const first = await runRefresh(world as never, { now: NOW, force: true });
    expect(first.attempted).toBe(2);

    // Someone signs up. No code, config, migration or list is touched.
    world.users.push(u("brand-new"));

    const second = await runRefresh(world as never, { now: NOW, force: true });
    expect(second.attempted).toBe(3);
    expect(second.accounts.map((a) => a.userId)).toContain("brand-new");
    expect(world.rpcCalls.filter((c) => c.user === "brand-new")).toHaveLength(1);
  });

  it("an account deleted between runs disappears, with no deregistration", async () => {
    const world = fakeWorld({ users: [u("a"), u("b"), u("gone")] });
    expect((await runRefresh(world as never, { now: NOW, force: true })).attempted).toBe(3);
    world.users = world.users.filter((x) => x.id !== "gone");
    const after = await runRefresh(world as never, { now: NOW, force: true });
    expect(after.attempted).toBe(2);
    expect(after.accounts.map((a) => a.userId)).not.toContain("gone");
  });

  it("discovery is paged, so account 201 is not lost", async () => {
    const world = fakeWorld({ users: Array.from({ length: ACCOUNT_PAGE_SIZE + 3 }, (_, i) => u(`u${i}`)) });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.authAccounts).toBe(ACCOUNT_PAGE_SIZE + 3);
    expect(r.attempted).toBe(ACCOUNT_PAGE_SIZE + 3);
    expect(r.pagesFetched).toBe(2);
  });
});

describe("one clock, and each learner's own study day", () => {
  it("every account is computed at the same instant", async () => {
    const world = fakeWorld({ users: [u("a"), u("b"), u("c")] });
    const r = await runRefresh(world as never, { now: NOW });
    expect(new Set(world.rpcCalls.map((c) => c.computedAt)).size).toBe(1);
    expect(world.rpcCalls[0].computedAt).toBe(NOW.toISOString());
    expect(r.runNow).toBe(NOW.toISOString());
  });

  it("but a different day_start_hour can still mean a different study day", async () => {
    // One run clock does not mean one study day. At 09:00 a learner whose day
    // starts at 4 is on today; one whose day starts at 10 is still on
    // yesterday, and the model must be told so.
    const world = fakeWorld({ users: [u("early", { day_start_hour: 4 }), u("late", { day_start_hour: 10 })] });
    const r = await runRefresh(world as never, { now: NOW });
    const days = Object.fromEntries(r.accounts.map((a) => [a.userId, a.studyDay]));
    expect(days.early).not.toBe(days.late);
  });
});

describe("failure policy", () => {
  it("one account failing does not stop the others, and is never reported as success", async () => {
    const world = fakeWorld({ users: [u("a"), u("broken"), u("c")], rpcFails: new Set(["broken"]) });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("COMPLETED");
    expect(r.attempted).toBe(3);
    expect(r.succeeded).toBe(2);
    expect(r.failed).toBe(1);
    // Current state is replaceable and the writer is atomic, so a failed
    // account keeps what it had: stale but coherent. Stopping the run would
    // punish every other learner for one learner's problem.
    expect(world.rpcCalls.map((c) => c.user).sort()).toEqual(["a", "c"]);
    const bad = r.accounts.find((a) => a.userId === "broken")!;
    expect(bad.error).toMatch(/writer refused/);
    expect(bad.stage).toBe("WRITE");
    expect(runSucceeded(r)).toBe(false);
  });

  it("names the account and the stage, so a retry knows where to look", async () => {
    const world = fakeWorld({ users: [u("x")], rpcFails: new Set(["x"]) });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.accounts[0].userId).toBe("x");
    expect(r.accounts[0].stage).toBe("WRITE");
  });
});

describe("overlapping runs", () => {
  it("stands down when another run landed moments ago", async () => {
    const world = fakeWorld({ users: [u("a")], lastComputedAt: new Date(NOW.getTime() - 60_000).toISOString() });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("ALREADY_RUNNING");
    expect(world.rpcCalls).toEqual([]);
  });

  it("proceeds once the window has passed", async () => {
    const world = fakeWorld({ users: [u("a")],
      lastComputedAt: new Date(NOW.getTime() - (RECENT_RUN_MINUTES + 1) * 60_000).toISOString() });
    const r = await runRefresh(world as never, { now: NOW });
    expect(r.outcome).toBe("COMPLETED");
  });

  it("a dry run is never blocked, and never writes", async () => {
    const world = fakeWorld({ users: [u("a"), u("b")], lastComputedAt: NOW.toISOString() });
    const r = await runRefresh(world as never, { now: NOW, dryRun: true });
    expect(r.outcome).toBe("COMPLETED");
    expect(r.attempted).toBe(2);
    expect(world.rpcCalls).toEqual([]);
    expect(r.rowsStored).toBe(0);
  });

  it("force overrides the guard", async () => {
    const world = fakeWorld({ users: [u("a")], lastComputedAt: NOW.toISOString() });
    expect((await runRefresh(world as never, { now: NOW, force: true })).outcome).toBe("COMPLETED");
  });
});

describe("the scheduler's own boundaries", () => {
  const strip = (s: string) => s.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
  const run = strip(fs.readFileSync(path.join(__dirname, "refreshRun.ts"), "utf8"));
  const route = strip(fs.readFileSync(
    path.join(process.cwd(), "app", "api", "learner", "cron", "refresh", "route.ts"), "utf8"));

  it("NEVER EXCLUDES AN ACCOUNT BY KIND", () => {
    expect(run).not.toMatch(/===\s*["'](STUDENT|DEMO|INTERNAL)["']/);
    expect(run).not.toMatch(/CALIBRATION/);
  });

  it("holds no account identity and no account count", () => {
    expect(run).not.toMatch(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/);
    expect(run).not.toMatch(/@praxisprep|@gmail|@yahoo/);
    expect(run).not.toMatch(/\b(accounts|users)\.length\s*[=!<>]=*\s*[1-9]/);
  });

  it("mutates state only through the atomic writer", () => {
    expect(run).not.toMatch(/\.insert\(|\.update\(|\.upsert\(|\.delete\(/);
    const rpcs = [...run.matchAll(/\.rpc\(\s*"([a-z_]+)"/g)].map((m) => m[1]);
    expect(rpcs).toEqual(["replace_learner_concept_states"]);
  });

  it("writes no source table", () => {
    for (const t of ["concepts", "question_concepts", "flashcard_concepts", "flashcard_user_state",
                     "flashcard_reviews", "question_attempts", "learner_state_snapshots", "profiles"]) {
      expect(run, t).not.toMatch(new RegExp(`from\\("${t}"\\)[\\s\\S]{0,80}\\.(insert|update|upsert|delete)`));
    }
  });

  it("the route refuses anyone without the cron secret", () => {
    expect(route).toMatch(/authorization/);
    expect(route).toMatch(/Bearer \$\{process\.env\.CRON_SECRET\}/);
    expect(route).toMatch(/status: 401/);
    // And refuses when the secret is not configured at all, rather than
    // comparing against "Bearer undefined".
    expect(route).toMatch(/!process\.env\.CRON_SECRET/);
  });

  it("the route fails loudly rather than answering 200", () => {
    expect(route).toMatch(/INTEGRITY_FAILURE[\s\S]{0,200}status: 500/);
    expect(route).toMatch(/report\.failed > 0[\s\S]{0,200}status: 500/);
  });

  it("the schedule actually exists in the deployment config", () => {
    // An endpoint that is implemented but unscheduled is not automatic refresh.
    const vercel = JSON.parse(fs.readFileSync(path.join(process.cwd(), "vercel.json"), "utf8"));
    const entry = vercel.crons.find((c: { path: string }) => c.path === "/api/learner/cron/refresh");
    expect(entry, "no cron entry for the refresh route").toBeDefined();
    expect(entry.schedule).toBe("0 9 * * *");
    // And the existing weekly report cron is untouched.
    expect(vercel.crons.some((c: { path: string; schedule: string }) =>
      c.path === "/api/reports/cron/weekly" && c.schedule === "0 4 * * 1")).toBe(true);
  });

  it("gives the batch the same execution budget the other cron has", () => {
    expect(route).toMatch(/export const maxDuration = 300/);
  });
});

describe("every batch job discovers accounts the same way", () => {
  const strip = (t: string) => t.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
  const backfill = strip(fs.readFileSync(
    path.join(process.cwd(), "scripts", "learner", "backfill-snapshots.mjs"), "utf8"));

  it("the snapshot backfill uses the canonical loader, not profiles", () => {
    // It used to read profiles unpaginated, which capped silently at one page
    // and treated profiles as the account list — the exact fault that hid two
    // accounts for six months.
    expect(backfill).toMatch(/loadAccountUniverse/);
    expect(backfill).toMatch(/integrityFailures/);
    expect(backfill).toMatch(/readyAccounts/);
  });

  it("and no longer reads profiles as an unpaginated universe", () => {
    // Every profiles read it still does is paginated with .range().
    const selects = [...backfill.matchAll(/from\("profiles"\)[\s\S]{0,200}?;/g)].map((m) => m[0]);
    expect(selects.length).toBeGreaterThan(0);
    for (const sel of selects) expect(sel, sel.slice(0, 60)).toMatch(/\.range\(/);
  });

  it("refuses to run on a broken universe rather than skipping an account", () => {
    expect(backfill).toMatch(/INTEGRITY FAILURE/);
    expect(backfill).toMatch(/process\.exit\(1\)/);
  });

  it("maintains ONE definition of the account universe", () => {
    // No second pagination of auth users anywhere outside the loader.
    for (const f of ["scripts/learner/backfill-snapshots.mjs", "lib/learner/refreshRun.ts",
                     "app/api/learner/cron/refresh/route.ts"]) {
      const src = strip(fs.readFileSync(path.join(process.cwd(), f), "utf8"));
      expect(src, f).not.toMatch(/listUsers\(/);
    }
    const loader = fs.readFileSync(path.join(__dirname, "accountUniverse.ts"), "utf8");
    expect(loader).toMatch(/listUsers\(/);
  });
});
