import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  buildConceptStates,
  CONCEPT_STATE_MODEL_VERSION,
  COVERAGE_STATES, COVERAGE_REASONS, MEMORY_SIGNALS, FRESHNESS_SIGNALS,
  CONFIDENCE_BANDS, CONFIDENCE_LIMITS, APPLICATION_SIGNALS, STATE_LABELS,
  OBSERVATION_WINDOW, LEARNER_FACING_STATUSES,
  wilsonInterval,
  type ConceptEvidence, type ConceptState,
} from "@/lib/learner/conceptState";
import {
  toRow, toRows, fromRow, CONCEPT_STATE_COLUMNS,
  type ConceptStateRow,
} from "@/lib/learner/conceptStatePersistence";

const MIGRATION = path.join(
  process.cwd(), "supabase", "migrations", "20261006_08_learner_concept_states.sql");
const sql = fs.readFileSync(MIGRATION, "utf8");

/** The CREATE TABLE body, bounded at its own terminator. */
const createTable = (() => {
  const from = sql.indexOf("CREATE TABLE IF NOT EXISTS public.learner_concept_states");
  expect(from).toBeGreaterThan(-1);
  return sql.slice(from, sql.indexOf(");", from) + 2);
})();

/** One named constraint's definition, bounded so it cannot run past itself. */
function constraintBody(name: string): string {
  const from = sql.indexOf(`ADD CONSTRAINT ${name} CHECK`);
  expect(from, name).toBeGreaterThan(-1);
  // Constraints are chained inside one ALTER TABLE, so the next action or the
  // statement terminator ends this one. An unbounded slice would run to the end
  // of the file and pick up every later statement, which is a mistake this
  // repository has made three times.
  const rest = sql.slice(from + 1);
  const nextDrop = rest.indexOf("\n  DROP CONSTRAINT");
  const terminator = rest.indexOf(";");
  const end = nextDrop === -1 ? terminator : Math.min(nextDrop, terminator);
  return rest.slice(0, end);
}

/** The values inside `column IN ('A', 'B')` for a vocabulary CHECK. */
function sqlVocabulary(column: string): string[] {
  const m = sql.match(new RegExp(`CHECK \\(${column} (?:IS NULL OR ${column} )?IN \\(([^)]+)\\)\\)`));
  expect(m, column).not.toBeNull();
  return m![1].split(",").map((s) => s.trim().replace(/'/g, ""));
}

// ─── The vocabularies ──────────────────────────────────────────────────────

describe("ONE VOCABULARY, DEFINED ONCE", () => {
  // The drift this prevents is silent in the worst direction. If the database
  // accepts a value the model has no branch for, nothing errors: a row is
  // stored, read back, and falls through every comparison to whatever the
  // final else happens to be.
  const pairs: [string, readonly string[]][] = [
    ["coverage_state", COVERAGE_STATES],
    ["coverage_reason", COVERAGE_REASONS],
    ["memory_signal", MEMORY_SIGNALS],
    ["freshness_signal", FRESHNESS_SIGNALS],
    ["memory_confidence", CONFIDENCE_BANDS],
    ["application_confidence", CONFIDENCE_BANDS],
    ["memory_confidence_limited_by", CONFIDENCE_LIMITS],
    ["application_signal", APPLICATION_SIGNALS],
    ["state_label", STATE_LABELS],
  ];

  it.each(pairs)("the SQL CHECK on %s is exactly the TypeScript list", (column, list) => {
    // Sequences, not sets: order is part of the definition in both places, so a
    // reordering has to be deliberate on both sides.
    expect(sqlVocabulary(column)).toEqual([...list]);
  });

  it("every categorical column in the table has a vocabulary CHECK", () => {
    const columns = [...createTable.matchAll(/^ {2}(\w+)\s+TEXT/gm)].map((m) => m[1]);
    const constrained = pairs.map(([c]) => c);
    // model_version is the exception and carries a non-empty CHECK instead: it
    // is an open vocabulary by design, because new model versions are the point.
    expect(columns.filter((c) => !constrained.includes(c))).toEqual(["model_version"]);
    expect(sql).toMatch(/CHECK \(\s*btrim\(model_version\) <> ''\s*\)/);
  });

  it("the extractor can actually fail to find a vocabulary", () => {
    // A check that has never returned nothing is not known to be reading the
    // file. This is the counter-example.
    const m = sql.match(new RegExp(`CHECK \\(a_column_that_is_not_there IN \\(([^)]+)\\)\\)`));
    expect(m).toBeNull();
    expect(sqlVocabulary("state_label")).toHaveLength(9);
  });

  it("the learner-facing status in the trigger is the one the model uses", () => {
    expect([...LEARNER_FACING_STATUSES]).toEqual(["ACTIVE_SEED"]);
    expect(sql).toMatch(/s IS DISTINCT FROM 'ACTIVE_SEED'/);
    // A positive named set in both places. `<> 'DEPRECATED'` would admit a
    // future DRAFT status silently, on both sides at once.
    expect(sql).not.toMatch(/\bs (=|IS NOT DISTINCT FROM) 'DEPRECATED'/);
  });
});

// ─── The schema the migration declares ─────────────────────────────────────

describe("the table the migration creates", () => {
  it("declares its prerequisite so a fresh replay keeps the order", () => {
    expect(sql).toMatch(/^-- REQUIRES: 20261006_07_flashcard_concepts_cloze_indices\.sql$/m);
  });

  it("is identified by (user_id, concept_id) and nothing else", () => {
    expect(createTable).toMatch(/PRIMARY KEY \(user_id, concept_id\)/);
    expect(sql).toMatch(/IF defn <> 'user_id,concept_id' THEN/);
  });

  it("holds one column per ConceptState field, plus the three the model cannot know", () => {
    const declared = [...createTable.matchAll(/^ {2}(\w+)\s+(UUID|TEXT|DOUBLE PRECISION|INTEGER|TIMESTAMPTZ|DATE)\b/gm)]
      .map((m) => m[1]);
    expect(declared).toEqual([...CONCEPT_STATE_COLUMNS]);
    // 24 model fields (conceptId and modelVersion among them) + user_id,
    // study_day, computed_at.
    expect(declared).toHaveLength(27);
    expect(sql).toMatch(/IF n <> 27 THEN RAISE EXCEPTION 'STEP 6: expected 27 columns/);
  });

  it("every fraction is DOUBLE PRECISION, never NUMERIC", () => {
    // float8 is the same IEEE-754 binary64 the model computes in, so a value
    // survives the round trip. NUMERIC would need a scale, and a chosen scale
    // is a silent rounding of a model output.
    for (const c of ["memory_durability", "memory_freshness", "memory_confidence_raw",
                     "application_lower_bound", "application_upper_bound"]) {
      expect(createTable, c).toMatch(new RegExp(`${c}\\s+DOUBLE PRECISION`));
    }
    expect(createTable).not.toMatch(/NUMERIC/);
  });

  it("gives no column a database default", () => {
    // Executable text only: the table's own comment says "NO DEFAULTS", and
    // prose must not fail the build.
    const declarations = createTable.split("\n")
      .map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");
    expect(declarations).not.toMatch(/DEFAULT/);
    // And asserts it from the catalog after the fact, because a default added
    // by a later migration would be just as wrong.
    expect(sql).toMatch(/these columns have a database default, which the writer contract forbids/);
  });

  it("explains in the schema why model_version and computed_at have no default", () => {
    expect(sql).toMatch(/COMMENT ON COLUMN public\.learner_concept_states\.model_version IS/);
    expect(sql).toMatch(/a stale writer create rows that look current/);
    expect(sql).toMatch(/COMMENT ON COLUMN public\.learner_concept_states\.computed_at IS/);
    expect(sql).toMatch(/The now the pure model was given, not the moment of the INSERT/);
  });

  it("documents study_day as a study day, not a calendar day", () => {
    expect(sql).toMatch(/COMMENT ON COLUMN public\.learner_concept_states\.study_day IS/);
    expect(sql).toMatch(/NOT a UTC calendar day and NOT derivable in SQL/);
  });

  it("cascades from both parents, and says so in the catalog check", () => {
    expect(createTable).toMatch(/user_id\s+UUID NOT NULL REFERENCES auth\.users\(id\)\s+ON DELETE CASCADE/);
    expect(createTable).toMatch(/concept_id UUID NOT NULL REFERENCES public\.concepts\(id\) ON DELETE CASCADE/);
    expect(sql).toMatch(/confrelid = 'auth\.users'::regclass AND confdeltype = 'c'/);
    expect(sql).toMatch(/confrelid = 'public\.concepts'::regclass AND confdeltype = 'c'/);
  });

  it("references auth.users, matching every other learner table", () => {
    // learner_state_snapshots, learner_events, performance_reports and
    // user_insight_briefs all key on auth.users(id). profiles would be a second
    // convention for the same fact.
    expect(createTable).not.toMatch(/REFERENCES (public\.)?profiles/);
  });

  it("every ADD CONSTRAINT is paired with a DROP IF EXISTS, so a replay is a no-op", () => {
    const adds = [...sql.matchAll(/ADD CONSTRAINT (learner_concept_states_\w+)/g)].map((m) => m[1]);
    const drops = [...sql.matchAll(/DROP CONSTRAINT IF EXISTS (learner_concept_states_\w+)/g)].map((m) => m[1]);
    expect(adds.length).toBeGreaterThan(0);
    expect(drops).toEqual(adds);
  });
});

// ─── The constraints, against the real contract ────────────────────────────

describe("THE CHECKS COME FROM THE MODEL, NOT FROM PLAUSIBILITY", () => {
  it("the window ceiling is OBSERVATION_WINDOW", () => {
    // The one model constant the SQL hard-codes. This test is the reason that
    // is acceptable: changing the constant fails here and forces a deliberate
    // migration instead of silently invalidating every stored row.
    expect(OBSERVATION_WINDOW).toBe(5);
    expect(constraintBody("learner_concept_states_application_contract"))
      .toMatch(/application_misses_in_window BETWEEN 0 AND LEAST\(application_attempts, 5\)/);
  });

  it("the Wilson bounds are NOT constrained to [0,1], because they leave it", () => {
    // Measured, not assumed. Five correct out of five - the first depth at
    // which this model says anything about application - produces an upper
    // bound of 1.0000000000000002, so BETWEEN 0 AND 1 would have rejected a
    // correct row for a real learner.
    expect(wilsonInterval(5, 5)[1]).toBeGreaterThan(1);
    expect(wilsonInterval(0, 15)[0]).toBeLessThan(0);
    const body = constraintBody("learner_concept_states_application_bounds");
    expect(body).toMatch(/application_lower_bound BETWEEN -1e-9 AND 1 \+ 1e-9/);
    expect(body).toMatch(/application_upper_bound BETWEEN -1e-9 AND 1 \+ 1e-9/);
    expect(body).toMatch(/application_lower_bound <= application_upper_bound/);
    // The tolerance still has to catch a unit mistake.
    expect(wilsonInterval(5, 5)[1]).toBeLessThan(1 + 1e-9);
  });

  it("the clipped values ARE constrained to [0,1], because they stay in it", () => {
    const body = constraintBody("learner_concept_states_memory_ranges");
    expect(body).toMatch(/memory_durability\s+BETWEEN 0 AND 1/);
    expect(body).toMatch(/memory_freshness\s+BETWEEN 0 AND 1/);
    expect(body).toMatch(/memory_confidence_raw BETWEEN 0 AND 1/);
  });

  it("encodes no threshold arithmetic, so a recalibration is not a migration", () => {
    // Every band floor in the model is provisional by its own admission. A
    // CHECK that encoded one would break stored rows the moment it moved.
    for (const threshold of ["0.55", "0.30", "0.80", "0.60", "0.70", "0.40", "0.65", "0.05"]) {
      expect(sql, threshold).not.toContain(`BETWEEN ${threshold}`);
    }
    expect(sql).toMatch(/WHAT IS DELIBERATELY NOT CONSTRAINED: the threshold arithmetic/);
  });

  it("states the coverage contract in terms of the counts, not just the labels", () => {
    const body = constraintBody("learner_concept_states_coverage_contract");
    expect(body).toMatch(/'BOTH_MODALITIES' AND memory_items > 0 AND application_attempts > 0/);
    expect(body).toMatch(/'MEMORY_ONLY'\s+AND memory_items > 0 AND application_attempts = 0/);
    expect(body).toMatch(/'QUESTION_ONLY'\s+AND memory_items = 0 AND application_attempts > 0/);
    // NO_EVIDENCE is in the vocabulary, because it is a state the model has.
    // It is not in the contract, because absence of a row is how it is stored.
    expect(COVERAGE_STATES).toContain("NO_EVIDENCE");
    expect(body).not.toContain("NO_EVIDENCE");
  });

  it("does not claim a learner with memory evidence has a memory timestamp", () => {
    // It can legitimately be null: reps > 0 with last_reviewed_at null. Only
    // the reverse direction is safe to assert.
    expect(constraintBody("learner_concept_states_memory_timestamp"))
      .toMatch(/last_memory_evidence_at IS NULL OR memory_items > 0/);
    expect(constraintBody("learner_concept_states_memory_contract"))
      .not.toMatch(/memory_items > 0[\s\S]*last_memory_evidence_at IS NOT NULL/);
  });

  it("pairs the application timestamp exactly, because that one IS exact", () => {
    const body = constraintBody("learner_concept_states_application_contract");
    expect(body).toMatch(/application_attempts = 0[\s\S]*last_application_evidence_at IS NULL/);
    expect(body).toMatch(/application_attempts > 0[\s\S]*last_application_evidence_at IS NOT NULL/);
  });

  it("uses no subquery in any CHECK, which would not be legal", () => {
    for (const name of [...sql.matchAll(/ADD CONSTRAINT (learner_concept_states_\w+) CHECK/g)].map((m) => m[1])) {
      expect(constraintBody(name), name).not.toMatch(/SELECT/i);
    }
  });
});

// ─── Enforcement that a CHECK cannot express ───────────────────────────────

describe("only learner-facing CONTENT may carry state", () => {
  it("is a trigger, because a CHECK may not contain a subquery", () => {
    expect(sql).toMatch(/CREATE OR REPLACE FUNCTION public\.learner_concept_states_active_content\(\)/);
    expect(sql).toMatch(/BEFORE INSERT OR UPDATE OF concept_id ON public\.learner_concept_states/);
  });

  it("closes the repoint path on the first attempt", () => {
    // The same guard on the mapping tables was INSERT-only and an UPDATE could
    // move a mapping onto a deprecated concept unchecked. That cost a whole
    // extra migration; this one covers both from the start.
    expect(sql).toMatch(/UPDATE OF concept_id/);
    expect(sql).toMatch(/an UPDATE repointed state onto a REASONING concept/);
  });

  it("checks object_type and status in one lookup", () => {
    expect(sql).toMatch(/SELECT object_type, status INTO t, s FROM public\.concepts WHERE id = NEW\.concept_id/);
  });

  it("is driven against all four kinds of concept before the migration commits", () => {
    for (const probe of [
      "a REASONING concept accepted learner state",
      "a QUANTITATIVE concept accepted learner state",
      "a DEPRECATED CONTENT concept accepted learner state",
      "an ACTIVE_SEED CONTENT row was REFUSED",
    ]) {
      expect(sql, probe).toContain(probe);
    }
  });

  it("checks every refusal came from the rule being tested", () => {
    for (const wrong of [
      "REASONING refused for the wrong reason",
      "QUANTITATIVE refused for the wrong reason",
      "DEPRECATED refused for the wrong reason",
      "the UPDATE path refused for the wrong reason",
    ]) {
      expect(sql, wrong).toContain(wrong);
    }
  });

  it("appends to the leak list, never concatenates onto it", () => {
    // `leaked := leaked || 'text'` resolves to array_cat, not array_append, and
    // fails with 22P02 the first time a probe actually leaks - which is the one
    // moment the message is needed. Step 5 hit exactly that.
    expect(sql).toMatch(/leaked := array_append\(leaked,/);
    expect(sql).not.toMatch(/leaked := leaked \|\|/);
  });
});

// ─── Security ──────────────────────────────────────────────────────────────

describe("A LEARNER READS THEIR OWN STATE AND WRITES NOTHING", () => {
  it("enables row-level security and grants exactly one read policy", () => {
    expect(sql).toMatch(/ALTER TABLE public\.learner_concept_states ENABLE ROW LEVEL SECURITY/);
    expect(sql).toMatch(/CREATE POLICY "Users read own concept states"\s*\n\s*ON public\.learner_concept_states FOR SELECT USING \(auth\.uid\(\) = user_id\)/);
    expect(sql).toMatch(/IF n <> 1 THEN RAISE EXCEPTION 'STEP 6: expected exactly one policy/);
  });

  it("creates no write policy at all", () => {
    const policies = [...sql.matchAll(/FOR (SELECT|INSERT|UPDATE|DELETE|ALL)\b/g)].map((m) => m[1]);
    expect(policies).toEqual(["SELECT"]);
  });

  it("revokes write privileges as well, because the two layers fail differently", () => {
    expect(sql).toMatch(/REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public\.learner_concept_states FROM anon, authenticated/);
  });

  it("departs from the existing learner-table pattern deliberately, and says why", () => {
    // learner_state_snapshots, user_insight_briefs and performance_reports all
    // grant the student INSERT on their own rows, because their writer runs as
    // the student. This one must not, so the difference is argued in the file.
    expect(sql).toMatch(/WHY THE LEARNER CANNOT WRITE THIS/);
    expect(sql).toMatch(/A student who can POST their own\n-- row can tell the product they have mastered anything/);
  });

  it("proves the identity took effect before trusting any refusal", () => {
    // An isolation test that passes because auth.uid() is null proves nothing.
    expect(sql).toMatch(/IF auth\.uid\(\) IS DISTINCT FROM u_a THEN/);
    expect(sql).toMatch(/the probe could not become a learner/);
  });

  it("proves each layer separately, including with the privilege restored", () => {
    expect(sql).toMatch(/an authenticated learner INSERTED their own state/);
    expect(sql).toMatch(/an authenticated learner UPDATED their own state/);
    expect(sql).toMatch(/an authenticated learner DELETED their own state/);
    expect(sql).toMatch(/GRANT INSERT, UPDATE, DELETE ON public\.learner_concept_states TO authenticated/);
    expect(sql).toMatch(/with INSERT granted, RLS did not stop a learner writing their own state/);
    // And requires the refusal to be 42501, so a trigger refusal (P0001)
    // cannot be mistaken for an RLS refusal.
    expect(sql).toMatch(/did not report 42501/);
    // The privilege it granted has to be handed back.
    expect(sql).toMatch(/REVOKE INSERT, UPDATE, DELETE ON public\.learner_concept_states FROM authenticated/);
    expect(sql).toMatch(/the probe left % write privilege\(s\) behind/);
  });

  it("commits with no rows, and proves it", () => {
    expect(sql).toMatch(/DELETE FROM public\.learner_concept_states WHERE model_version IN \('PROBE', 'FORGED'\)/);
    expect(sql).toMatch(/probe row\(s\) survived\. The table must commit empty\./);
  });

  it("reads the ontology and auth.users without modifying either", () => {
    for (const table of ["concepts", "auth.users", "flashcard_user_state", "question_attempts",
                         "flashcard_concepts", "question_concepts", "flashcard_reviews"]) {
      const re = new RegExp(`(INSERT\\s+INTO|UPDATE|DELETE\\s+FROM|TRUNCATE)\\s+(public\\.)?${table.replace(".", "\\.")}\\b`, "i");
      // Comments discuss these tables at length; only executable text counts.
      const body = sql.split("\n").map((l) => {
        const i = l.indexOf("--");
        return i === -1 ? l : l.slice(0, i);
      }).join("\n");
      expect(body, table).not.toMatch(re);
    }
  });
});

// ─── The round trip ────────────────────────────────────────────────────────

const NOW = new Date("2026-10-06T12:00:00.000Z");
const CTX = { userId: "11111111-1111-1111-1111-111111111111", studyDay: "2026-10-06", computedAt: NOW.toISOString() };

/** A state exercising every nontrivial field, built by the real model. */
function bothModalitiesState(): ConceptState {
  const evidence: ConceptEvidence = {
    concepts: [{ id: "aaaaaaaa-0000-0000-0000-000000000001", objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [
      { id: "ffffffff-0000-0000-0000-000000000001", clozeCount: 2 },
      { id: "ffffffff-0000-0000-0000-000000000002", clozeCount: 1 },
    ],
    cardMappings: [
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", flashcardId: "ffffffff-0000-0000-0000-000000000001", role: "PRIMARY", clozeIndices: [1] },
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", flashcardId: "ffffffff-0000-0000-0000-000000000002", role: "SECONDARY", clozeIndices: null },
    ],
    schedulerRows: [
      { flashcardId: "ffffffff-0000-0000-0000-000000000001", clozeIndex: 1, stability: 3.7, reps: 4, suspended: false, lastReviewedAt: "2026-10-01T08:00:00.000Z" },
      { flashcardId: "ffffffff-0000-0000-0000-000000000001", clozeIndex: 2, stability: 0.4, reps: 2, suspended: false, lastReviewedAt: "2026-09-02T08:00:00.000Z" },
      { flashcardId: "ffffffff-0000-0000-0000-000000000002", clozeIndex: 1, stability: 19.2, reps: 9, suspended: false, lastReviewedAt: "2026-10-05T19:30:00.000Z" },
    ],
    questionMappings: [
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", questionId: "99999999-0000-0000-0000-000000000001", role: "PRIMARY", evidenceStrength: "UNREVIEWED" },
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", questionId: "99999999-0000-0000-0000-000000000002", role: "SECONDARY", evidenceStrength: "STANDARD" },
    ],
    attempts: [
      { id: "a1", questionId: "99999999-0000-0000-0000-000000000001", isCorrect: false, isFirstAttempt: true, createdAt: "2026-09-20T10:00:00.000Z" },
      { id: "a2", questionId: "99999999-0000-0000-0000-000000000001", isCorrect: true, isFirstAttempt: null, createdAt: "2026-09-27T10:00:00.000Z" },
      { id: "a3", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: false, isFirstAttempt: true, createdAt: "2026-10-02T10:00:00.000Z" },
      { id: "a4", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: false, isFirstAttempt: true, createdAt: "2026-10-04T10:00:00.000Z" },
      { id: "a5", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: true, isFirstAttempt: true, createdAt: "2026-10-05T10:00:00.000Z" },
    ],
  };
  const [state] = buildConceptStates(evidence, null, NOW);
  return state;
}

/** A memory-only state, for the null half of the contract. */
function memoryOnlyState(): ConceptState {
  const evidence: ConceptEvidence = {
    concepts: [{ id: "aaaaaaaa-0000-0000-0000-000000000002", objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [{ id: "ffffffff-0000-0000-0000-000000000003", clozeCount: 1 }],
    cardMappings: [{ conceptId: "aaaaaaaa-0000-0000-0000-000000000002", flashcardId: "ffffffff-0000-0000-0000-000000000003", role: "PRIMARY", clozeIndices: null }],
    // reps > 0 and no last_reviewed_at: the case that makes
    // last_memory_evidence_at legitimately null with memory_items > 0.
    schedulerRows: [{ flashcardId: "ffffffff-0000-0000-0000-000000000003", clozeIndex: 1, stability: 6.1, reps: 1, suspended: false, lastReviewedAt: null }],
    questionMappings: [],
    attempts: [],
  };
  const [state] = buildConceptStates(evidence, null, NOW);
  return state;
}

describe("ConceptState -> row -> ConceptState changes nothing", () => {
  it("the fixtures are the states they claim to be", () => {
    const both = bothModalitiesState();
    expect(both.coverageState).toBe("BOTH_MODALITIES");
    expect(both.coverageReason).toBeNull();
    expect(both.memoryItems).toBe(2);
    expect(both.applicationAttempts).toBe(5);
    expect(both.memoryDurability).not.toBeNull();
    expect(both.applicationUpperBound).not.toBeNull();
    expect(both.lastMemoryEvidenceAt).not.toBeNull();

    const mem = memoryOnlyState();
    expect(mem.coverageState).toBe("MEMORY_ONLY");
    expect(mem.coverageReason).toBe("BANK_HAS_NO_QUESTIONS");
    expect(mem.applicationAttempts).toBe(0);
    expect(mem.applicationLowerBound).toBeNull();
    expect(mem.lastApplicationEvidenceAt).toBeNull();
    // The case the memory_timestamp CHECK is deliberately one-directional for.
    expect(mem.memoryItems).toBeGreaterThan(0);
    expect(mem.lastMemoryEvidenceAt).toBeNull();
  });

  it.each([["both modalities", bothModalitiesState], ["memory only", memoryOnlyState]])(
    "round-trips %s exactly", (_name, build) => {
      const state = build();
      expect(fromRow(toRow(state, CTX))).toEqual(state);
    });

  it("preserves doubles bit for bit, not approximately", () => {
    const state = { ...bothModalitiesState(), memoryDurability: 0.1234567890123456, memoryConfidenceRaw: 1 / 3, applicationUpperBound: 1.0000000000000002 };
    const back = fromRow(toRow(state, CTX));
    expect(back.memoryDurability).toBe(0.1234567890123456);
    expect(back.memoryConfidenceRaw).toBe(1 / 3);
    expect(back.applicationUpperBound).toBe(1.0000000000000002);
  });

  it("keeps null meaning absent, never 0", () => {
    const mem = memoryOnlyState();
    const row = toRow(mem, CTX);
    expect(row.application_lower_bound).toBeNull();
    expect(row.application_upper_bound).toBeNull();
    expect(row.last_application_evidence_at).toBeNull();
    expect(row.last_memory_evidence_at).toBeNull();
    // 0 would be a measurement. The model distinguishes "no evidence" from "a
    // measured zero", and so must the row.
    expect(row.application_attempts).toBe(0);
    expect(fromRow(row).applicationLowerBound).toBeNull();
  });

  it("is idempotent, so a state read back and rewritten is the same row", () => {
    const once = toRow(bothModalitiesState(), CTX);
    const twice = toRow(fromRow(once), CTX);
    expect(twice).toEqual(once);
  });

  it("normalises timestamps to one spelling, because TIMESTAMPTZ stores an instant", () => {
    const state = { ...bothModalitiesState(), lastMemoryEvidenceAt: "2026-10-01T08:00:00+00:00" };
    const row = toRow(state, CTX);
    expect(row.last_memory_evidence_at).toBe("2026-10-01T08:00:00.000Z");
    // Same instant, one spelling, and sorting still works: the model compares
    // these strings with `>` to find the most recent one.
    expect(new Date(row.last_memory_evidence_at!).getTime()).toBe(new Date(state.lastMemoryEvidenceAt!).getTime());
  });

  it("refuses a timestamp it cannot parse rather than storing a wrong instant", () => {
    const state = { ...bothModalitiesState(), lastMemoryEvidenceAt: "last Tuesday" };
    expect(() => toRow(state, CTX)).toThrow(/not a timestamp/);
  });

  it("carries the model version from the state, never from the context", () => {
    const row = toRow(bothModalitiesState(), CTX);
    expect(row.model_version).toBe(CONCEPT_STATE_MODEL_VERSION);
    expect(Object.keys(CTX)).not.toContain("modelVersion");
  });

  it("attaches the learner, the study day and the model's own now", () => {
    const row = toRow(bothModalitiesState(), CTX);
    expect(row.user_id).toBe(CTX.userId);
    expect(row.study_day).toBe("2026-10-06");
    expect(row.computed_at).toBe(NOW.toISOString());
  });

  it("maps a whole learner's output in order", () => {
    const states = [bothModalitiesState(), memoryOnlyState()];
    const rows = toRows(states, CTX);
    expect(rows.map((r) => r.concept_id)).toEqual(states.map((s) => s.conceptId));
    expect(rows.every((r) => r.user_id === CTX.userId)).toBe(true);
  });

  it("NO NUMBER IN A STORED STATE IS EVER READ BACK INTO A DECISION", () => {
    // Why this matters: PostgREST renders float8 at 15 significant digits, so a
    // state read back over HTTP has already lost its last bit — 1.0000000000000002
    // arrives as 1. That is harmless only if the model reads no number off
    // `previous`, which it does not: hysteresis reads memorySignal,
    // memoryConfidence and applicationSignal, and all three are enum strings.
    //
    // Proved by perturbation rather than by reading the implementation, so it
    // keeps holding if the implementation changes.
    const first = bothModalitiesState();
    const mangled: ConceptState = {
      ...first,
      memoryDurability: 0.999999, memoryFreshness: 0, memoryConfidenceRaw: 0.123,
      memoryItems: 999, memoryItemsAvailable: 1000, weakCardCount: 998,
      applicationAttempts: 777, applicationCorrect: 0, applicationMissesInWindow: 5,
      applicationLowerBound: 0, applicationUpperBound: 0.01,
      lastMemoryEvidenceAt: "1999-01-01T00:00:00.000Z",
      lastApplicationEvidenceAt: "1999-01-01T00:00:00.000Z",
    };
    expect(buildConceptStates(evidenceOf(), [mangled], NOW))
      .toEqual(buildConceptStates(evidenceOf(), [first], NOW));

    // AND A CONTROL THAT BITES, so the test above is not passing merely because
    // `previous` is ignored altogether. The first control tried flipping three
    // enum fields on this fixture and changed nothing: its durability sits at
    // 0.66, clear of every hysteresis margin, so the bands could not move and
    // the "control" proved nothing. This one is built to sit INSIDE the margin.
    //
    // Stability 6.2 gives durability 0.5749: DURABLE read fresh, because it is
    // over the 0.55 floor, but it may not CLIMB there from BUILDING, which
    // needs 0.55 + 0.05. So the band the learner held last time decides it.
    const edge: ConceptEvidence = {
      concepts: [{ id: "cccccccc-0000-0000-0000-000000000001", objectType: "CONTENT", status: "ACTIVE_SEED" }],
      flashcards: [{ id: "dddddddd-0000-0000-0000-000000000001", clozeCount: 1 }],
      cardMappings: [{ conceptId: "cccccccc-0000-0000-0000-000000000001", flashcardId: "dddddddd-0000-0000-0000-000000000001", role: "PRIMARY", clozeIndices: null }],
      schedulerRows: [{ flashcardId: "dddddddd-0000-0000-0000-000000000001", clozeIndex: 1, stability: 6.2, reps: 3, suspended: false, lastReviewedAt: "2026-10-05T08:00:00.000Z" }],
      questionMappings: [], attempts: [],
    };
    const scratch = buildConceptStates(edge, null, NOW);
    expect(scratch[0].memorySignal).toBe("DURABLE");

    // Through storage, the held band survives and holds the concept back.
    const heldRow = toRow({ ...scratch[0], memorySignal: "BUILDING" }, CTX);
    const held = buildConceptStates(edge, [fromRow(heldRow)], NOW);
    expect(held[0].memorySignal).toBe("BUILDING");
    expect(held).not.toEqual(scratch);
  });

  it("a row read back can serve as `previous`, so hysteresis survives storage", () => {
    // This is what the round trip is FOR. The durability band, the confidence
    // band and the STRUGGLING flag are all sticky, and stickiness reads the
    // state the learner held last time. If that could not survive a trip
    // through the database, every recomputation would start from scratch and
    // the bands would flicker exactly as they did before hysteresis existed.
    const first = bothModalitiesState();
    const stored = fromRow(toRow(first, CTX));
    const concepts = [{ id: first.conceptId, objectType: "CONTENT", status: "ACTIVE_SEED" }];
    const empty: ConceptEvidence = { concepts, flashcards: [], cardMappings: [], schedulerRows: [], questionMappings: [], attempts: [] };
    // Same evidence, same now, previous supplied from storage: identical output.
    const direct = buildConceptStates(evidenceOf(), [first], NOW);
    const viaDb = buildConceptStates(evidenceOf(), [stored], NOW);
    expect(viaDb).toEqual(direct);
    expect(buildConceptStates(empty, [stored], NOW)).toEqual([]);
  });
});

/** The same evidence the both-modalities fixture is built from. */
function evidenceOf(): ConceptEvidence {
  return {
    concepts: [{ id: "aaaaaaaa-0000-0000-0000-000000000001", objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [
      { id: "ffffffff-0000-0000-0000-000000000001", clozeCount: 2 },
      { id: "ffffffff-0000-0000-0000-000000000002", clozeCount: 1 },
    ],
    cardMappings: [
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", flashcardId: "ffffffff-0000-0000-0000-000000000001", role: "PRIMARY", clozeIndices: [1] },
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", flashcardId: "ffffffff-0000-0000-0000-000000000002", role: "SECONDARY", clozeIndices: null },
    ],
    schedulerRows: [
      { flashcardId: "ffffffff-0000-0000-0000-000000000001", clozeIndex: 1, stability: 3.7, reps: 4, suspended: false, lastReviewedAt: "2026-10-01T08:00:00.000Z" },
      { flashcardId: "ffffffff-0000-0000-0000-000000000001", clozeIndex: 2, stability: 0.4, reps: 2, suspended: false, lastReviewedAt: "2026-09-02T08:00:00.000Z" },
      { flashcardId: "ffffffff-0000-0000-0000-000000000002", clozeIndex: 1, stability: 19.2, reps: 9, suspended: false, lastReviewedAt: "2026-10-05T19:30:00.000Z" },
    ],
    questionMappings: [
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", questionId: "99999999-0000-0000-0000-000000000001", role: "PRIMARY", evidenceStrength: "UNREVIEWED" },
      { conceptId: "aaaaaaaa-0000-0000-0000-000000000001", questionId: "99999999-0000-0000-0000-000000000002", role: "SECONDARY", evidenceStrength: "STANDARD" },
    ],
    attempts: [
      { id: "a1", questionId: "99999999-0000-0000-0000-000000000001", isCorrect: false, isFirstAttempt: true, createdAt: "2026-09-20T10:00:00.000Z" },
      { id: "a2", questionId: "99999999-0000-0000-0000-000000000001", isCorrect: true, isFirstAttempt: null, createdAt: "2026-09-27T10:00:00.000Z" },
      { id: "a3", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: false, isFirstAttempt: true, createdAt: "2026-10-02T10:00:00.000Z" },
      { id: "a4", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: false, isFirstAttempt: true, createdAt: "2026-10-04T10:00:00.000Z" },
      { id: "a5", questionId: "99999999-0000-0000-0000-000000000002", isCorrect: true, isFirstAttempt: true, createdAt: "2026-10-05T10:00:00.000Z" },
    ],
  };
}

// ─── The writer contract ───────────────────────────────────────────────────

describe("the persistence contract the next step has to satisfy", () => {
  const source = fs.readFileSync(path.join(__dirname, "conceptStatePersistence.ts"), "utf8");

  it("touches no database, so the round trip is testable without one", () => {
    expect(source).not.toMatch(/createClient|SUPABASE|process\.env|fetch\(/);
    expect(source).not.toMatch(/\.from\(/);
  });

  it("writes the contract down where the schema review can see it", () => {
    for (const clause of [
      "SERVICE TOOLING ONLY", "UPSERT ON (user_id, concept_id)",
      "DELETE WHAT NO LONGER APPEARS", "BOTH HALVES ATOMICALLY",
      "IDEMPOTENT FOR IDENTICAL INPUT", "NEVER TOUCH EVIDENCE",
    ]) {
      expect(source, clause).toContain(clause);
    }
  });

  it("derives nothing, so there is only ever one model", () => {
    // No arithmetic on a model output. If a value needs computing it belongs in
    // conceptState.ts, where the pure contract can be tested against it.
    const body = source.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*(\/\/|\*).*$/gm, "");
    expect(body).not.toMatch(/Math\.|[+*/]=|\breduce\(|\bfilter\(/);
  });

  it("lists every column, in the order the table declares them", () => {
    expect([...CONCEPT_STATE_COLUMNS]).toHaveLength(27);
    expect(new Set(CONCEPT_STATE_COLUMNS).size).toBe(27);
  });

  it("types every row field as the column's own vocabulary", () => {
    // A ConceptStateRow whose coverage_state were plain `string` would compile
    // with a misspelling in it, and the database would be the only thing that
    // noticed - at write time, in production.
    const row: ConceptStateRow = toRow(bothModalitiesState(), CTX);
    // @ts-expect-error a value outside the vocabulary must not typecheck
    row.coverage_state = "SOMETHING_ELSE";
    // @ts-expect-error nor a stray column
    row.memory_vibes = 1;
    expect(COVERAGE_STATES).not.toContain("SOMETHING_ELSE");
  });
});
