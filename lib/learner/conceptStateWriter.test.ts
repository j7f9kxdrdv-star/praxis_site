import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  toPayload, toPayloadRow, singleModelVersion, CONCEPT_STATE_PAYLOAD_COLUMNS,
  CONCEPT_STATE_COLUMNS, toRow, fromRow,
} from "@/lib/learner/conceptStatePersistence";
import {
  buildConceptStates, CONCEPT_STATE_MODEL_VERSION, type ConceptEvidence, type ConceptState,
} from "@/lib/learner/conceptState";

const DIR = path.join(process.cwd(), "supabase", "migrations");

/**
 * THE LIVE DEFINITION, not the first one.
 *
 * An applied migration is history and is never edited, so the function's
 * current shape is whatever the LAST migration defining it says. Pinning these
 * tests to a filename would have meant they kept describing a definition the
 * database had already replaced — which is the shape of the bug this very test
 * file now guards against.
 */
const defining = fs.readdirSync(DIR).filter((f) => f.endsWith(".sql")).sort()
  .filter((f) => fs.readFileSync(path.join(DIR, f), "utf8")
    .includes("CREATE OR REPLACE FUNCTION public.replace_learner_concept_states"));
const sql = fs.readFileSync(path.join(DIR, defining[defining.length - 1]), "utf8");
/** The migration that first installed it, kept for the claims that are its own. */
const original = fs.readFileSync(path.join(DIR, defining[0]), "utf8");

/**
 * Every migration that has ever defined the function, concatenated.
 *
 * Two different kinds of claim live in this file and conflating them is how
 * three tests broke when a third migration arrived. "The function behaves this
 * way NOW" is a claim about the live definition. "This property was driven
 * against the real database at some point" is a claim about the history, and
 * the migration that proved it is not necessarily the first or the last.
 */
const everyDefining = defining.map((f) => fs.readFileSync(path.join(DIR, f), "utf8")).join("\n");

const NOW = new Date("2026-10-06T12:00:00.000Z");
function state(conceptId: string): ConceptState {
  const evidence: ConceptEvidence = {
    concepts: [{ id: conceptId, objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [{ id: "f1", clozeCount: 1 }],
    cardMappings: [{ conceptId, flashcardId: "f1", role: "PRIMARY", clozeIndices: null }],
    schedulerRows: [{ flashcardId: "f1", clozeIndex: 1, stability: 9, reps: 3, suspended: false, lastReviewedAt: "2026-10-05T08:00:00.000Z" }],
    questionMappings: [], attempts: [],
  };
  return buildConceptStates(evidence, null, NOW)[0];
}

// ─── The payload contract ──────────────────────────────────────────────────

describe("A BATCH CANNOT DISAGREE WITH ITSELF", () => {
  it("the payload carries the 23 per-concept keys and none of the four batch facts", () => {
    expect(CONCEPT_STATE_PAYLOAD_COLUMNS).toHaveLength(23);
    for (const batchFact of ["user_id", "study_day", "computed_at", "model_version"]) {
      expect(CONCEPT_STATE_PAYLOAD_COLUMNS, batchFact).not.toContain(batchFact);
      expect(CONCEPT_STATE_COLUMNS, batchFact).toContain(batchFact);
    }
    expect(Object.keys(toPayloadRow(state("c1"))).sort()).toEqual([...CONCEPT_STATE_PAYLOAD_COLUMNS].sort());
  });

  it("THE SQL AND THE TYPESCRIPT AGREE ON EXACTLY THOSE KEYS", () => {
    // The writer rejects any key it does not recognise, so a key the model
    // sends and the function has never heard of fails the whole batch. These
    // two lists have to be one list.
    const from = sql.indexOf("allowed    TEXT[] := ARRAY[");
    const block = sql.slice(from, sql.indexOf("];", from));
    const fromSql = [...block.matchAll(/'([a-z_]+)'/g)].map((m) => m[1]);
    expect(fromSql.sort()).toEqual([...CONCEPT_STATE_PAYLOAD_COLUMNS].sort());
  });

  it("refuses a batch that names one concept twice", () => {
    expect(() => toPayload([state("c1"), state("c1")])).toThrow(/appears twice/);
    expect(sql).toMatch(/concept\(s\) appear twice in one batch/);
  });

  it("refuses a batch whose states disagree about the model version", () => {
    const a = state("c1");
    const b = { ...state("c2"), modelVersion: "9.9.9-other" };
    expect(() => singleModelVersion([a, b])).toThrow(/one batch, 2 model versions/);
    expect(singleModelVersion([a])).toBe(CONCEPT_STATE_MODEL_VERSION);
    expect(singleModelVersion([])).toBeNull();
  });

  it("a payload row round-trips back into a state once the batch facts are restored", () => {
    const s = state("c1");
    const ctx = { userId: "u", studyDay: "2026-10-06", computedAt: NOW.toISOString() };
    const restored = fromRow({ ...toPayloadRow(s), ...{
      user_id: ctx.userId, study_day: ctx.studyDay, computed_at: ctx.computedAt,
      model_version: s.modelVersion } } as never);
    expect(restored).toEqual(s);
    expect(toRow(s, ctx)).toMatchObject(toPayloadRow(s));
  });
});

// ─── The function the migration installs ───────────────────────────────────

describe("the atomic writer", () => {
  const stripSql = (t: string) => t.split("\n")
    .map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");
  const liveBody = stripSql(sql.slice(sql.indexOf("AS $fn$"), sql.indexOf("END; $fn$;")));

  it("every migration that defines it declares a prerequisite", () => {
    expect(defining.length).toBeGreaterThan(0);
    for (const f of defining) {
      expect(fs.readFileSync(path.join(DIR, f), "utf8"), f).toMatch(/^-- REQUIRES: \S+\.sql$/m);
    }
    expect(original).toMatch(/^-- REQUIRES: 20261006_08_learner_concept_states\.sql$/m);
  });

  it("takes the four batch facts as arguments, not as row fields", () => {
    expect(sql).toMatch(/p_user_id\s+UUID,\s*\n\s*p_study_day\s+DATE,\s*\n\s*p_computed_at\s+TIMESTAMPTZ,\s*\n\s*p_model_version TEXT,\s*\n\s*p_states\s+JSONB/);
  });

  it("is SECURITY INVOKER, so it cannot become a way around row-level security", () => {
    // THE DECLARATION, not the file. The header argues at length about why
    // SECURITY DEFINER was rejected, and the post-condition's error message
    // names it too — both are places the phrase SHOULD appear. The only place
    // it must not is between the function's signature and its body.
    const declaration = sql.slice(
      sql.indexOf("CREATE OR REPLACE FUNCTION public.replace_learner_concept_states"),
      sql.indexOf("AS $fn$"))
      // Minus its own comments: one of them explains why the search_path is
      // pinned "even without SECURITY DEFINER", which is the right thing to
      // say and the wrong thing to match.
      .split("\n").map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");
    expect(declaration).toMatch(/SECURITY INVOKER/);
    expect(declaration).not.toMatch(/SECURITY DEFINER/);
    // And the slice is known to be the declaration, not the whole file.
    expect(declaration).toMatch(/RETURNS JSONB/);
    expect(declaration).not.toMatch(/RAISE EXCEPTION/);
    // And asserted from the catalog at apply time by the migration that first
    // installed it, not only written in the file.
    expect(original).toMatch(/IF state <> 'false' THEN/);
    expect(original).toMatch(/the writer is SECURITY DEFINER, which would bypass/);
  });

  it("pins its search_path even so", () => {
    expect(sql).toMatch(/SET search_path = public, pg_catalog/);
    expect(original).toMatch(/the writer has no fixed search_path/);
  });

  it("is executable by service tooling and by nobody else", () => {
    expect(sql).toMatch(/REVOKE ALL ON FUNCTION public\.replace_learner_concept_states[\s\S]{0,80}FROM PUBLIC/);
    expect(sql).toMatch(/FROM anon, authenticated/);
    expect(sql).toMatch(/GRANT EXECUTE ON FUNCTION public\.replace_learner_concept_states[\s\S]{0,80}TO service_role/);
    expect(original).toMatch(/anon or authenticated can execute the writer/);
    expect(original).toMatch(/service_role cannot execute the writer/);
  });

  it("serialises per learner and never globally", () => {
    // A SINGLE SEEDED 64-BIT KEY. The pair form hashes a UUID into 32 bits,
    // where two learners collide once in a few tens of thousands of pairs —
    // harmless, since a collision only costs one of them a wait, but needless.
    expect(liveBody).toMatch(/pg_advisory_xact_lock\(\s*hashtextextended\('learner_concept_states:' \|\| p_user_id::text, 20261007\)\)/);
    // Transaction-scoped, so it cannot be left held.
    expect(liveBody).not.toMatch(/pg_advisory_lock\(/);
  });

  it("DOES NOT REGRESS TO THE 32-BIT PAIR", () => {
    // The live definition must not go back to the two-argument form, and the
    // original is kept as the counter-example proving this check sees it.
    expect(liveBody).not.toMatch(/hashtext\('learner_concept_states'\)/);
    expect(stripSql(original.slice(original.indexOf("AS $fn$"), original.indexOf("END; $fn$;"))))
      .toMatch(/hashtext\('learner_concept_states'\), hashtext\(p_user_id::text\)/);
  });

  it("the lock seed is fixed, because a changed seed is a different lock", () => {
    // Two deploys disagreeing about the seed would stop serialising the same
    // learner against each other, silently.
    const seeds = [...liveBody.matchAll(/hashtextextended\([^)]*,\s*(\d+)\)/g)].map((m) => m[1]);
    expect(seeds).toEqual(["20261007"]);
  });

  it("validates the whole batch before it writes anything", () => {
    const lock = sql.indexOf("pg_advisory_xact_lock");
    const firstWrite = sql.indexOf("DELETE FROM public.learner_concept_states s");
    for (const check of [
      "every element of p_states must be an object",
      "payload carries unknown key(s)",
      "payload is missing key(s)",
      "concept(s) appear twice in one batch",
      "these are not learner-facing CONTENT concepts",
    ]) {
      const at = sql.indexOf(check);
      expect(at, check).toBeGreaterThan(lock);
      expect(at, check).toBeLessThan(firstWrite);
    }
  });

  it("does NOT reimplement the model's own rules in SQL", () => {
    // The table holds 17 CHECK constraints and the ACTIVE CONTENT trigger. A
    // second copy here would be a second model that could disagree.
    for (const threshold of ["0.55", "0.30", "0.80", "0.60", "0.65", "wilson", "durability_of"]) {
      expect(sql.toLowerCase(), threshold).not.toContain(threshold);
    }
    expect(original).toMatch(/no SQL reimplementation of/);
  });

  it("deletes stale rows by concept, never by model version", () => {
    const from = sql.indexOf("DELETE FROM public.learner_concept_states s");
    const stmt = sql.slice(from, sql.indexOf(";", from));
    expect(stmt).toMatch(/s\.user_id = p_user_id/);
    expect(stmt).toMatch(/NOT EXISTS/);
    expect(stmt).not.toMatch(/model_version/);
  });

  it("reports what the database actually did", () => {
    for (const key of ["user_id", "rows_received", "rows_upserted", "rows_deleted",
                       "final_row_count", "model_version", "study_day", "computed_at"]) {
      expect(sql, key).toMatch(new RegExp(`'${key}'`));
    }
    expect([...sql.matchAll(/GET DIAGNOSTICS/g)]).toHaveLength(2);
  });

  it("was proved atomic on seven invalid batches when it was installed", () => {
    expect(original).toMatch(/invalid batch ' \|\| n \|\| ' was ACCEPTED/);
    expect(original).toMatch(/invalid batch ' \|\| n \|\| ' left the learner changed/);
    expect(original).toMatch(/FOR n IN 1 \.\. 7 LOOP/);
  });

  it("was proved to clear a learner, and only that learner", () => {
    expect(original).toMatch(/an empty payload did not clear the learner/);
    expect(original).toMatch(/clearing one learner removed another learner''s rows/);
  });

  it("was proved unreachable by an authenticated learner", () => {
    expect(original).toMatch(/an authenticated learner executed the writer/);
    expect(original).toMatch(/IF auth\.uid\(\) IS DISTINCT FROM u_a THEN/);
  });

  // ── The defect the first installation shipped ─────────────────────────
  it("TOUCHES NO SCHEMA ITS ONLY CALLER CANNOT READ", () => {
    // The first version validated its learner against auth.users. It is
    // SECURITY INVOKER, so that SELECT runs as the caller, and the only role
    // allowed to call it — service_role — has no privileges in the auth
    // schema. Every real invocation failed with 42501 before writing anything.
    expect(liveBody).not.toMatch(/\bauth\./);
    expect(stripSql(original.slice(original.indexOf("AS $fn$"), original.indexOf("END; $fn$;"))))
      .toMatch(/FROM auth\.users WHERE id = p_user_id/);
  });

  it("CHECKS NO LEARNER TABLE AT ALL, because neither one is correct here", () => {
    // profiles was the obvious replacement and is also wrong: 2 auth users
    // have no profile row, so a profiles check would silently refuse to write
    // state for two real accounts. The foreign key is the guarantee; a
    // pre-check could only ever have bought a nicer message.
    expect(liveBody).not.toMatch(/FROM public\.profiles/);
    expect(liveBody).not.toMatch(/no such learner|no such user/);
    expect(sql).toMatch(/NO LEARNER-EXISTENCE CHECK HERE, deliberately/);
  });

  it("proves the foreign key refuses an unknown learner, by SQLSTATE", () => {
    // Not by message: a refusal from some other rule would otherwise look like
    // this one passing.
    expect(everyDefining).toMatch(/EXCEPTION WHEN foreign_key_violation THEN NULL;/);
    expect(everyDefining).toMatch(/the unknown-learner refusal came from the wrong layer/);
    // And an empty batch for an unknown learner is a no-op, not an error.
    expect(everyDefining).toMatch(/an empty batch for an unknown learner raised/);
  });

  it("is now probed as the role that actually calls it", () => {
    // The original probes ran as postgres in the SQL editor, which CAN read
    // auth.users, so they passed while production could not call the function
    // at all. A test can be honest and still answer a question nobody asked.
    expect(sql).toMatch(/SET LOCAL ROLE service_role/);
    expect(sql).toMatch(/as service_role the writer FAILED/);
    expect(sql).toMatch(/cannot assume service_role/);
    expect(original).not.toMatch(/SET LOCAL ROLE service_role/);
  });

  it("reports the account mismatch rather than acting on it", () => {
    expect(everyDefining).toMatch(/auth user\(s\) have no profile row/);
    expect(everyDefining).toMatch(/profile\(s\) have no auth user/);
    // A NOTICE, not an exception: the writer no longer depends on either count.
    expect(everyDefining).toMatch(/RAISE NOTICE 'ACCOUNTS:/);
    expect(everyDefining).not.toMatch(/RAISE EXCEPTION 'WRITER FIX: % auth user/);
  });

  it("leaves no residue", () => {
    // Every revision cleans up after itself, whatever its probes wrote.
    for (const f of defining) {
      const text = fs.readFileSync(path.join(DIR, f), "utf8");
      expect(text, f).toMatch(/DELETE FROM public\.learner_concept_states WHERE model_version/);
      expect(text, f).toMatch(/the probes left the table at % rows, it held % before/);
    }
  });

  it("appends to the leak list, never concatenates onto it", () => {
    expect(sql).toMatch(/leaked := array_append\(leaked,/);
    expect(sql).not.toMatch(/leaked := leaked \|\|/);
  });

  it("creates no table and alters none", () => {
    const body = sql.split("\n").map((l) => {
      const i = l.indexOf("--");
      return i === -1 ? l : l.slice(0, i);
    }).join("\n");
    expect(body).not.toMatch(/CREATE TABLE/i);
    expect(body).not.toMatch(/ALTER TABLE/i);
    expect(body).not.toMatch(/DROP TABLE/i);
  });

  it("writes no source evidence", () => {
    const body = sql.split("\n").map((l) => {
      const i = l.indexOf("--");
      return i === -1 ? l : l.slice(0, i);
    }).join("\n");
    for (const table of ["flashcard_user_state", "flashcard_reviews", "question_attempts",
                         "flashcard_concepts", "question_concepts", "concepts",
                         "learner_state_snapshots"]) {
      expect(body, table).not.toMatch(
        new RegExp(`(INSERT\\s+INTO|UPDATE|DELETE\\s+FROM|TRUNCATE)\\s+(public\\.)?${table}\\b`, "i"));
    }
  });
});
