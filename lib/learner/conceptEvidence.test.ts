import { describe, it, expect, vi } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { loadConceptEvidence } from "@/lib/learner/conceptEvidence";
import { buildConceptStates, type ConceptState } from "@/lib/learner/conceptState";

// ─── THE LOADER IS WHERE DATABASE SEMANTICS CAN DRIFT ───────────────────────
//
// The pure model's own tests prove what it does with evidence it is handed.
// They cannot prove the production path HANDS IT the right evidence, and that
// is now a separate place a mistake can live: a filter pushed into SQL, a
// column renamed, a role value the model has no branch for.
//
// So these drive the real loader against a fake Supabase client and assert on
// the ConceptEvidence that comes out, and then on the states the model builds
// from it. No database, so they run with the unit tests.

/** The smallest thing that behaves like the query builder the loader uses. */
function fakeDb(tables: Record<string, Record<string, unknown>[]>) {
  const seen: { table: string; columns: string; order: string[]; userId?: string }[] = [];
  return {
    seen,
    from(table: string) {
      const rows = tables[table] ?? [];
      const record: { table: string; columns: string; order: string[]; userId?: string } = {
        table, columns: "", order: [],
      };
      let filtered = rows;
      const q = {
        select(columns: string) { record.columns = columns; return q; },
        eq(column: string, value: string) {
          if (column === "user_id") record.userId = value;
          filtered = filtered.filter((r) => r[column] === value);
          return q;
        },
        order(column: string) { record.order.push(column); return q; },
        maybeSingle() { return Promise.resolve({ data: filtered[0] ?? null, error: null }); },
        range(from: number, to: number) {
          seen.push(record);
          return Promise.resolve({ data: filtered.slice(from, to + 1), error: null });
        },
      };
      return q;
    },
  } as never;
}

const USER = "11111111-1111-1111-1111-111111111111";
const OTHER = "22222222-2222-2222-2222-222222222222";
const CONCEPT = "aaaaaaaa-0000-0000-0000-000000000001";
const CARD = "ffffffff-0000-0000-0000-000000000001";
const Q = "99999999-0000-0000-0000-000000000001";

/** A complete, deliberately awkward bank: every exclusion rule has a victim. */
function bank(over: Partial<Record<string, Record<string, unknown>[]>> = {}) {
  return {
    concepts: [
      { id: CONCEPT, object_type: "CONTENT", status: "ACTIVE_SEED" },
      { id: "aaaaaaaa-0000-0000-0000-00000000000d", object_type: "CONTENT", status: "DEPRECATED" },
      { id: "aaaaaaaa-0000-0000-0000-00000000000r", object_type: "REASONING", status: "ACTIVE_SEED" },
      { id: "aaaaaaaa-0000-0000-0000-00000000000q", object_type: "QUANTITATIVE", status: "ACTIVE_SEED" },
    ],
    flashcards: [{ id: CARD, cloze_count: 2 }],
    flashcard_concepts: [
      { flashcard_id: CARD, concept_id: CONCEPT, role: "PRIMARY", cloze_indices: null },
    ],
    flashcard_user_state: [
      { user_id: USER, flashcard_id: CARD, cloze_index: 1, stability: 10, reps: 3, suspended: false, last_reviewed_at: "2026-10-05T08:00:00Z" },
      { user_id: OTHER, flashcard_id: CARD, cloze_index: 1, stability: 99, reps: 9, suspended: false, last_reviewed_at: "2026-10-05T08:00:00Z" },
    ],
    question_concepts: [
      { question_id: Q, concept_id: CONCEPT, role: "PRIMARY", evidence_strength: "UNREVIEWED" },
    ],
    question_attempts: [
      { id: "a1", user_id: USER, question_id: Q, is_correct: true, is_first_attempt: true, created_at: "2026-10-01T08:00:00Z" },
      { id: "a2", user_id: OTHER, question_id: Q, is_correct: false, is_first_attempt: true, created_at: "2026-10-01T08:00:00Z" },
    ],
    ...over,
  } as Record<string, Record<string, unknown>[]>;
}

const NOW = new Date("2026-10-06T12:00:00.000Z");
const only = (states: ConceptState[]) => states.find((s) => s.conceptId === CONCEPT);

async function statesFor(tables: Record<string, Record<string, unknown>[]>) {
  const { evidence } = await loadConceptEvidence(fakeDb(tables), USER);
  return buildConceptStates(evidence, null, NOW);
}

describe("the loader filters by learner and by nothing else", () => {
  it("asks only the six tables the model needs", async () => {
    const db = fakeDb(bank());
    await loadConceptEvidence(db, USER);
    const asked = [...new Set((db as never as { seen: { table: string }[] }).seen.map((s) => s.table))].sort();
    expect(asked).toEqual([
      "concepts", "flashcard_concepts", "flashcard_user_state",
      "flashcards", "question_attempts", "question_concepts",
    ]);
  });

  it("scopes the two learner tables to the learner, and no others", async () => {
    const db = fakeDb(bank());
    await loadConceptEvidence(db, USER);
    const scoped = (db as never as { seen: { table: string; userId?: string }[] }).seen
      .filter((s) => s.userId).map((s) => s.table).sort();
    expect(scoped).toEqual(["flashcard_user_state", "question_attempts"]);
  });

  it("loads the bank tables WHOLE, because breadth needs cards the learner has not seen", async () => {
    // Filtering flashcards or flashcard_concepts to the learner's own cards
    // would make memory_items_available equal memory_items for every concept,
    // and every concept would look fully covered.
    const tables = bank({
      flashcards: [{ id: CARD, cloze_count: 2 }, { id: "ffffffff-0000-0000-0000-000000000002", cloze_count: 1 }],
      flashcard_concepts: [
        { flashcard_id: CARD, concept_id: CONCEPT, role: "PRIMARY", cloze_indices: null },
        { flashcard_id: "ffffffff-0000-0000-0000-000000000002", concept_id: CONCEPT, role: "PRIMARY", cloze_indices: null },
      ],
    });
    const s = only(await statesFor(tables))!;
    expect(s.memoryItems).toBe(1);
    expect(s.memoryItemsAvailable).toBe(2);
  });

  it("keeps another learner's rows out of this learner's evidence", async () => {
    const { evidence } = await loadConceptEvidence(fakeDb(bank()), USER);
    expect(evidence.schedulerRows).toHaveLength(1);
    expect(evidence.attempts).toHaveLength(1);
    expect(evidence.attempts[0].id).toBe("a1");
  });

  it("orders every page on a stable key, so .range() cannot skip or repeat", async () => {
    const db = fakeDb(bank());
    await loadConceptEvidence(db, USER);
    for (const s of (db as never as { seen: { table: string; order: string[] }[] }).seen) {
      expect(s.order.length, s.table).toBeGreaterThan(0);
    }
    const order = (t: string) =>
      (db as never as { seen: { table: string; order: string[] }[] }).seen.find((s) => s.table === t)!.order;
    // flashcard_user_state has no id column; its natural key is the stable one.
    expect(order("flashcard_user_state")).toEqual(["flashcard_id", "cloze_index"]);
    // Attempts order chronologically with id as the tiebreaker, which is the
    // order the model's observation window reads.
    expect(order("question_attempts")).toEqual(["created_at", "id"]);
  });
});

describe("concept eligibility stays the model's decision", () => {
  it("hands over deprecated, REASONING and QUANTITATIVE concepts unfiltered", async () => {
    const { evidence } = await loadConceptEvidence(fakeDb(bank()), USER);
    expect(evidence.concepts).toHaveLength(4);
  });

  it("and the model emits a state only for the ACTIVE_SEED CONTENT one", async () => {
    const tables = bank({
      flashcard_concepts: [
        { flashcard_id: CARD, concept_id: CONCEPT, role: "PRIMARY", cloze_indices: null },
        { flashcard_id: CARD, concept_id: "aaaaaaaa-0000-0000-0000-00000000000d", role: "PRIMARY", cloze_indices: null },
        { flashcard_id: CARD, concept_id: "aaaaaaaa-0000-0000-0000-00000000000r", role: "PRIMARY", cloze_indices: null },
        { flashcard_id: CARD, concept_id: "aaaaaaaa-0000-0000-0000-00000000000q", role: "PRIMARY", cloze_indices: null },
      ],
    });
    const states = await statesFor(tables);
    expect(states.map((s) => s.conceptId)).toEqual([CONCEPT]);
  });
});

describe("evidence strength reaches the model intact", () => {
  it.each([
    ["UNREVIEWED", 1],
    ["STANDARD", 1],
    ["SELF_CONTAINED", 0],
    ["RECOGNITION_ONLY", 0],
  ])("%s contributes %i attempt(s)", async (strengthValue, expected) => {
    const tables = bank({
      question_concepts: [{ question_id: Q, concept_id: CONCEPT, role: "PRIMARY", evidence_strength: strengthValue }],
    });
    const s = only(await statesFor(tables))!;
    expect(s.applicationAttempts).toBe(expected);
  });

  it("refuses a strength the model has no branch for, rather than absorbing it", async () => {
    const tables = bank({
      question_concepts: [{ question_id: Q, concept_id: CONCEPT, role: "PRIMARY", evidence_strength: "PROBABLY_FINE" }],
    });
    await expect(loadConceptEvidence(fakeDb(tables), USER)).rejects.toThrow(/no branch for/);
  });
});

describe("cloze scope reaches the model intact", () => {
  const twoClozes = [
    { user_id: USER, flashcard_id: CARD, cloze_index: 1, stability: 40, reps: 5, suspended: false, last_reviewed_at: "2026-10-05T08:00:00Z" },
    { user_id: USER, flashcard_id: CARD, cloze_index: 2, stability: 0.2, reps: 5, suspended: false, last_reviewed_at: "2026-10-05T08:00:00Z" },
  ];

  it("a NULL scope means every cloze, so the weak one drags the card down", async () => {
    const s = only(await statesFor(bank({ flashcard_user_state: twoClozes })))!;
    expect(s.memoryItems).toBe(1);
    expect(s.memorySignal).toBe("THIN");
  });

  it("an explicit scope reads only the clozes it names", async () => {
    const tables = bank({
      flashcard_user_state: twoClozes,
      flashcard_concepts: [{ flashcard_id: CARD, concept_id: CONCEPT, role: "PRIMARY", cloze_indices: [1] }],
    });
    const s = only(await statesFor(tables))!;
    expect(s.memorySignal).toBe("DURABLE");
  });

  it("carries the array through as an array of numbers", async () => {
    const tables = bank({
      flashcard_concepts: [{ flashcard_id: CARD, concept_id: CONCEPT, role: "PRIMARY", cloze_indices: [2] }],
    });
    const { evidence } = await loadConceptEvidence(fakeDb(tables), USER);
    expect(evidence.cardMappings[0].clozeIndices).toEqual([2]);
  });
});

describe("scheduler eligibility stays the model's decision", () => {
  const row = (over: Record<string, unknown>) => ({
    user_id: USER, flashcard_id: CARD, cloze_index: 1, stability: 10, reps: 3,
    suspended: false, last_reviewed_at: "2026-10-05T08:00:00Z", ...over,
  });

  it.each([
    ["a studied card", {}, 1],
    ["a suspended card", { suspended: true }, 0],
    ["a card with reps = 0", { reps: 0 }, 0],
    ["an orphan cloze past the card's count", { cloze_index: 7 }, 0],
    ["a cloze index of 0", { cloze_index: 0 }, 0],
  ])("%s contributes %i item(s)", async (_label, over, expected) => {
    const s = only(await statesFor(bank({ flashcard_user_state: [row(over)] })));
    expect(s?.memoryItems ?? 0).toBe(expected);
  });

  it("hands the ineligible rows over anyway, rather than filtering them in SQL", async () => {
    // The exclusions above are the model's, and this is what keeps them there.
    // A `reps > 0` pushed into the query would be a second definition of
    // eligibility living somewhere nobody thinks to look.
    const { evidence } = await loadConceptEvidence(
      fakeDb(bank({ flashcard_user_state: [row({ suspended: true }), row({ cloze_index: 2, reps: 0 })] })), USER);
    expect(evidence.schedulerRows).toHaveLength(2);
  });

  it("treats a null stability and null reps as nothing built, not as a crash", async () => {
    const { evidence } = await loadConceptEvidence(
      fakeDb(bank({ flashcard_user_state: [row({ stability: null, reps: null, suspended: null })] })), USER);
    expect(evidence.schedulerRows[0]).toMatchObject({ stability: 0, reps: 0, suspended: false });
  });
});

describe("attempt eligibility stays the model's decision", () => {
  const attempt = (over: Record<string, unknown>) => ({
    id: "a1", user_id: USER, question_id: Q, is_correct: true,
    is_first_attempt: true, created_at: "2026-10-01T08:00:00Z", ...over,
  });

  it.each([
    ["a first attempt", { is_first_attempt: true }, 1],
    ["a repeat", { is_first_attempt: false }, 0],
    ["a legacy row with no flag", { is_first_attempt: null }, 1],
  ])("%s contributes %i attempt(s)", async (_label, over, expected) => {
    const s = only(await statesFor(bank({ question_attempts: [attempt(over)] })));
    expect(s?.applicationAttempts ?? 0).toBe(expected);
  });

  it("hands repeats over anyway, so the rule lives in one place", async () => {
    const { evidence } = await loadConceptEvidence(
      fakeDb(bank({ question_attempts: [attempt({ is_first_attempt: false })] })), USER);
    expect(evidence.attempts).toHaveLength(1);
  });

  it("carries the attempt id, which is how a timestamp tie is broken", async () => {
    // Two attempts at the same instant must order deterministically or the
    // observation window is whatever the database felt like returning.
    const tables = bank({
      question_attempts: [
        attempt({ id: "b", is_correct: false }),
        attempt({ id: "a", is_correct: true }),
      ],
    });
    const { evidence } = await loadConceptEvidence(fakeDb(tables), USER);
    expect(evidence.attempts.map((a) => a.id)).toEqual(["b", "a"]);
    const s = only(await statesFor(tables))!;
    expect(s.applicationAttempts).toBe(2);
    expect(s.lastApplicationEvidenceAt).toBe("2026-10-01T08:00:00Z");
  });
});

describe("roles reach the model intact", () => {
  it("keeps PRIMARY and SECONDARY apart", async () => {
    const tables = bank({
      flashcard_concepts: [{ flashcard_id: CARD, concept_id: CONCEPT, role: "SECONDARY", cloze_indices: null }],
    });
    const { evidence } = await loadConceptEvidence(fakeDb(tables), USER);
    expect(evidence.cardMappings[0].role).toBe("SECONDARY");
    // An all-SECONDARY concept is capped below HIGH confidence, which is only
    // observable if the role survived the trip.
    const s = only(await statesFor(tables))!;
    expect(s.memoryConfidence).not.toBe("HIGH");
  });

  it("refuses a role the model has no branch for", async () => {
    const tables = bank({
      flashcard_concepts: [{ flashcard_id: CARD, concept_id: CONCEPT, role: "TERTIARY", cloze_indices: null }],
    });
    await expect(loadConceptEvidence(fakeDb(tables), USER)).rejects.toThrow(/expected PRIMARY or SECONDARY/);
  });
});

describe("the loader writes nothing", () => {
  // EXECUTABLE TEXT ONLY. Both modules explain at length what they do not do,
  // so a check run over the raw file fails on the comment that says the rule.
  const strip = (s: string) =>
    s.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
  const source = strip(fs.readFileSync(path.join(__dirname, "conceptEvidence.ts"), "utf8"));
  const orchestrator = strip(fs.readFileSync(path.join(__dirname, "computeConceptStates.ts"), "utf8"));

  it("the loader issues no mutation at all", () => {
    for (const verb of ["insert(", "update(", "upsert(", "delete(", "rpc("]) {
      expect(source, verb).not.toContain(verb);
    }
  });

  it("the orchestrator mutates through exactly one call, the atomic writer", () => {
    for (const verb of ["insert(", "update(", "upsert(", "delete("]) {
      expect(orchestrator, verb).not.toContain(verb);
    }
    const rpcs = [...orchestrator.matchAll(/\.rpc\(\s*"([a-z_]+)"/g)].map((m) => m[1]);
    expect(rpcs).toEqual(["replace_learner_concept_states"]);
  });

  it("neither one touches the score predictor", () => {
    for (const [name, src] of [["loader", source], ["orchestrator", orchestrator]] as const) {
      expect(src, name).not.toMatch(/scoreEstimate|estimateScore|PREDICTOR/);
    }
  });

  it("captures the clock once and never again", () => {
    // A second `new Date()` during persistence would stamp rows with an
    // instant the model never saw, and the day would not reproduce.
    expect(orchestrator).not.toMatch(/Date\.now\(\)/);
    expect([...orchestrator.matchAll(/new Date\(/g)]).toHaveLength(0);
    // And the check is known to see one when it is there.
    expect([...strip("const x = new Date();").matchAll(/new Date\(/g)]).toHaveLength(1);
    expect(orchestrator).toMatch(/now\.toISOString\(\)/);
  });

  it("resolves the study day from the profile, never from UTC", () => {
    expect(orchestrator).toMatch(/studyDayKey\(now, dayStartHour\)/);
    expect(orchestrator).toMatch(/day_start_hour/);
    expect(orchestrator).not.toMatch(/toISOString\(\)\.slice\(0,\s*10\)/);
  });
});
