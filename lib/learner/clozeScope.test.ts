import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  buildConceptStates, durabilityOf, type ConceptEvidence, type Role,
} from "@/lib/learner/conceptState";

const MIGRATION = path.join(process.cwd(), "supabase", "migrations",
  "20261006_07_flashcard_concepts_cloze_indices.sql");
const sql = fs.readFileSync(MIGRATION, "utf8");

// The two real reviewed cards, by full id.
const CARD_B = "b393432e-665c-47fc-9b13-c66af880a80d"; // c1 glucose, c2 chylomicron remnants
const CARD_D = "7d0c69e5-1e1d-4061-826a-dd4ad94dc426"; // c1 LDL,     c2 de novo
const TRANSPORT = "2bd9f11e-36cc-47d7-ab4f-4daa827b46be";
const SYNTHESIS = "066ad4c3-e5b1-49b4-b8a2-951a8f721eed";
const NOW = new Date("2026-10-06T12:00:00.000Z");
const WEAK = 0.5, STRONG = 25;

/** One two-cloze card, each cloze given its own stability, scoped per concept. */
function scopedCard(
  cardId: string,
  scopes: { conceptId: string; role: Role; clozeIndices: number[] | null }[],
  stability: { c1: number; c2: number },
): ConceptEvidence {
  return {
    concepts: [TRANSPORT, SYNTHESIS].map((id) => ({ id, objectType: "CONTENT", status: "ACTIVE_SEED" })),
    flashcards: [{ id: cardId, clozeCount: 2 }],
    cardMappings: scopes.map((s) => ({ conceptId: s.conceptId, flashcardId: cardId, role: s.role, clozeIndices: s.clozeIndices })),
    schedulerRows: [
      { flashcardId: cardId, clozeIndex: 1, stability: stability.c1, reps: 4, suspended: false, lastReviewedAt: "2026-10-05T00:00:00.000Z" },
      { flashcardId: cardId, clozeIndex: 2, stability: stability.c2, reps: 4, suspended: false, lastReviewedAt: "2026-10-05T00:00:00.000Z" },
    ],
    questionMappings: [], attempts: [],
  };
}
const durabilityFor = (e: ConceptEvidence, conceptId: string) =>
  buildConceptStates(e, null, NOW).find((s) => s.conceptId === conceptId)!.memoryDurability!;

describe("CONCEPT ISOLATION: card b393432e", () => {
  // "...excess dietary {{c1::glucose}} ... plus fatty acids retrieved from
  //  {{c2::chylomicron remnants}}."   c1 = Synthesis,  c2 = Transport
  const scopes = [
    { conceptId: SYNTHESIS, role: "SECONDARY" as Role, clozeIndices: [1] },
    { conceptId: TRANSPORT, role: "PRIMARY" as Role, clozeIndices: [2] },
  ];

  it("a poor c1 drags Synthesis down and leaves Transport untouched", () => {
    const e = scopedCard(CARD_B, scopes, { c1: WEAK, c2: STRONG });
    expect(durabilityFor(e, SYNTHESIS)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(STRONG), 10);
    expect(durabilityFor(e, TRANSPORT)).toBeGreaterThan(durabilityFor(e, SYNTHESIS));
  });

  it("a poor c2 does the reverse", () => {
    const e = scopedCard(CARD_B, scopes, { c1: STRONG, c2: WEAK });
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(e, SYNTHESIS)).toBeCloseTo(durabilityOf(STRONG), 10);
  });

  it("WITHOUT the scope, one failed blank contaminates both", () => {
    // The defect the column exists to prevent, demonstrated rather than asserted.
    const unscoped = scopedCard(CARD_B,
      scopes.map((s) => ({ ...s, clozeIndices: null })), { c1: WEAK, c2: STRONG });
    expect(durabilityFor(unscoped, SYNTHESIS)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(unscoped, TRANSPORT)).toBeCloseTo(durabilityOf(WEAK), 10);
  });
});

describe("CONCEPT ISOLATION: card 7d0c69e5", () => {
  // "...uptake of circulating {{c1::LDL}} or by {{c2::de novo}} synthesis."
  //  c1 = Transport,  c2 = Synthesis   (the mirror image of card b393432e)
  const scopes = [
    { conceptId: TRANSPORT, role: "PRIMARY" as Role, clozeIndices: [1] },
    { conceptId: SYNTHESIS, role: "SECONDARY" as Role, clozeIndices: [2] },
  ];

  it("a poor c1 drags Transport down and leaves Synthesis untouched", () => {
    const e = scopedCard(CARD_D, scopes, { c1: WEAK, c2: STRONG });
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(e, SYNTHESIS)).toBeCloseTo(durabilityOf(STRONG), 10);
  });

  it("a poor c2 does the reverse", () => {
    const e = scopedCard(CARD_D, scopes, { c1: STRONG, c2: WEAK });
    expect(durabilityFor(e, SYNTHESIS)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(STRONG), 10);
  });

  it("the two cards scope the SAME concepts to OPPOSITE clozes", () => {
    // Which is why a scope cannot be inferred from the concept pair; it has to
    // be read off the card, which is why a human set all four.
    const b = scopedCard(CARD_B, [
      { conceptId: SYNTHESIS, role: "SECONDARY", clozeIndices: [1] },
      { conceptId: TRANSPORT, role: "PRIMARY", clozeIndices: [2] }], { c1: WEAK, c2: STRONG });
    const d = scopedCard(CARD_D, [
      { conceptId: TRANSPORT, role: "PRIMARY", clozeIndices: [1] },
      { conceptId: SYNTHESIS, role: "SECONDARY", clozeIndices: [2] }], { c1: WEAK, c2: STRONG });
    expect(durabilityFor(b, SYNTHESIS)).toBeCloseTo(durabilityOf(WEAK), 10);
    expect(durabilityFor(d, SYNTHESIS)).toBeCloseTo(durabilityOf(STRONG), 10);
  });
});

describe("the frozen model behaviour is unchanged", () => {
  it("NULL still means every eligible cloze", () => {
    const e = scopedCard(CARD_B, [{ conceptId: TRANSPORT, role: "PRIMARY", clozeIndices: null }],
      { c1: WEAK, c2: STRONG });
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(WEAK), 10); // weakest wins
  });

  it("a multi-index scope takes the weakest within scope", () => {
    const e = scopedCard(CARD_B, [{ conceptId: TRANSPORT, role: "PRIMARY", clozeIndices: [1, 2] }],
      { c1: WEAK, c2: STRONG });
    expect(durabilityFor(e, TRANSPORT)).toBeCloseTo(durabilityOf(WEAK), 10);
  });

  it("one card is still one vote, scoped or not", () => {
    const e = scopedCard(CARD_B, [{ conceptId: TRANSPORT, role: "PRIMARY", clozeIndices: [2] }],
      { c1: WEAK, c2: STRONG });
    expect(buildConceptStates(e, null, NOW).find((s) => s.conceptId === TRANSPORT)!.memoryItems).toBe(1);
  });
});

describe("the migration's integrity design", () => {
  it("scopes exactly the four reviewed mappings, by full uuid", () => {
    const uuids = new Set([...sql.matchAll(
      /'([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})'/g)].map((m) => m[1]));
    for (const id of [CARD_B, CARD_D, TRANSPORT, SYNTHESIS]) expect(uuids).toContain(id);
    expect(sql).toMatch(/expected exactly 4 scoped mappings/);
  });

  it("the scope writes touch no governance column", () => {
    const writes = sql.slice(sql.indexOf("The four reviewed scopes"), sql.indexOf("Invalid scopes are refused"));
    for (const g of ["mapping_status =", "source =", "role =", "concept_id =", "confidence =",
                     "reviewed_at =", "reviewed_by ="]) {
      expect(writes).not.toContain(g);
    }
    expect(writes).toMatch(/SET cloze_indices = ARRAY\[/);
  });

  it("validation is a trigger, not the rejected subquery CHECK", () => {
    expect(sql).toMatch(/CREATE OR REPLACE FUNCTION public\.validate_cloze_indices/);
    expect(sql).not.toMatch(/ADD CONSTRAINT[\s\S]{0,200}CHECK[\s\S]{0,200}SELECT/);
  });

  it.each([
    ["empty array", /may not be an empty array/],
    ["null elements", /may not contain NULL elements/],
    ["indices below 1", /must be >= 1/],
    ["duplicates", /contains a duplicate index/],
    ["non-ascending order", /must be stored in ascending order/],
    ["a missing flashcard", /flashcard % does not exist/],
    ["an index beyond the card", /but flashcard % has only % cloze/],
  ])("rejects %s", (_label, pattern) => {
    expect(sql).toMatch(pattern);
  });

  it("proves each rejection with a probe rather than asserting it", () => {
    for (const probe of ["empty array", "zero index", "negative index", "duplicate index",
                         "index beyond cloze_count", "descending order", "null element"]) {
      expect(sql).toContain(`array_append(leaked, '${probe}')`);
    }
  });

  it("proves a valid [1,2] scope and NULL are both accepted", () => {
    expect(sql).toMatch(/a valid multi-index scope \[1,2\] was refused/);
    expect(sql).toMatch(/NULL, meaning all clozes, was refused/);
  });
});

describe("the parent card cannot orphan a scope", () => {
  it("a mapping-side trigger alone would not catch a card edit", () => {
    expect(sql).toMatch(/CREATE OR REPLACE FUNCTION public\.protect_scoped_cloze_mappings/);
    expect(sql).toMatch(/BEFORE UPDATE ON public\.flashcards/);
  });

  it("the card edit is REFUSED, not silently repaired", () => {
    expect(sql).toMatch(/Refusing to edit flashcard/);
    // None of the three silent repairs the brief forbids.
    const fn = sql.slice(sql.indexOf("protect_scoped_cloze_mappings"), sql.indexOf("The shared guard learns"));
    expect(fn).not.toMatch(/SET cloze_indices = NULL/);
    expect(fn).not.toMatch(/DELETE FROM public\.flashcard_concepts/);
    expect(fn).not.toMatch(/flashcard_user_state/);
  });

  it("proves shrink refused, growth allowed, unrelated edits untouched", () => {
    expect(sql).toMatch(/reducing cloze_count below a scoped index was allowed/);
    expect(sql).toMatch(/increasing cloze_count was wrongly refused/);
    expect(sql).toMatch(/an unrelated card edit was wrongly refused/);
    expect(sql).toMatch(/a NULL-scoped card was wrongly protected/);
  });

  it("skips the check when nothing cloze-bearing changed", () => {
    expect(sql).toMatch(/NEW\.cloze_count IS NOT DISTINCT FROM OLD\.cloze_count/);
    expect(sql).toMatch(/NEW\.cloze_text IS NOT DISTINCT FROM OLD\.cloze_text/);
  });
});

describe("THE GUARD EXEMPTION IS PER TABLE", () => {
  const fn = sql.slice(sql.indexOf("CREATE OR REPLACE FUNCTION public.protect_human_validated_mapping"));

  it("uses TG_TABLE_NAME to choose the exempt columns", () => {
    expect(fn).toMatch(/TG_TABLE_NAME/);
    expect(fn).toMatch(/WHEN 'question_concepts'\s+THEN ARRAY\['evidence_strength', 'evidence_strength_set_at'\]/);
    expect(fn).toMatch(/WHEN 'flashcard_concepts' THEN ARRAY\['cloze_indices'\]/);
  });

  it("A FUTURE question_concepts.cloze_indices WOULD STILL BE PROTECTED", () => {
    // The specific trap: subtracting all three keys for both tables would
    // exempt a column nobody reviewed, on the day it was added.
    const qcBranch = fn.slice(fn.indexOf("WHEN 'question_concepts'"), fn.indexOf("WHEN 'flashcard_concepts'"));
    expect(qcBranch).not.toMatch(/cloze_indices/);
  });

  it("and a future flashcard_concepts.evidence_strength would still be protected", () => {
    const fcBranch = fn.slice(fn.indexOf("WHEN 'flashcard_concepts'"), fn.indexOf("ELSE ARRAY"));
    expect(fcBranch).not.toMatch(/evidence_strength/);
  });

  it("any other table gets no exemption at all", () => {
    expect(fn).toMatch(/ELSE ARRAY\[\]::TEXT\[\]/);
  });

  it("still compares the whole row, minus only the exempt keys", () => {
    expect(fn).toMatch(/to_jsonb\(NEW\) - exempt\)\s*IS NOT DISTINCT FROM\s*\(to_jsonb\(OLD\) - exempt/);
  });

  it("keeps both original refusals", () => {
    expect(fn).toMatch(/Only a HUMAN_REVIEWED write may amend a human decision/);
    expect(fn).toMatch(/Refusing to delete a HUMAN_VALIDATED mapping/);
  });

  it("proves both tables still refuse governance changes", () => {
    for (const probe of ["question_concepts.role", "flashcard_concepts.role",
                         "flashcard_concepts.source", "flashcard_concepts.confidence"]) {
      expect(sql).toContain(`array_append(leaked, '${probe}')`);
    }
    expect(sql).toMatch(/step 4b evidence-strength exemption was broken/);
  });

  it("probes refusal on a row whose source is NOT already HUMAN_REVIEWED", () => {
    // The first run of this migration failed here, and the failure was correct.
    // The Synthesis mapping carries source HUMAN_REVIEWED because a human
    // created it, and on such a row the guard PERMITS amendment by design. A
    // probe expecting refusal there asserts the opposite of the intent.
    const guard = sql.slice(sql.indexOf("The HUMAN_VALIDATED guard, both tables"));
    const refusals = guard.slice(0, guard.indexOf("And the documented HUMAN_REVIEWED path"));
    expect(refusals).toMatch(/concept_id = tid/);
    expect(refusals).not.toMatch(/SET (role|source|confidence)[^;]*concept_id = cid/);
  });

  it("and proves the HUMAN_REVIEWED path still works on the row that carries it", () => {
    expect(sql).toMatch(/the established HUMAN_REVIEWED amendment path was broken on flashcard_concepts/);
  });

  it("appends with array_append, not the ambiguous array || literal", () => {
    // `text[] || 'x'` resolves to array_cat, which tries to parse 'x' as an
    // array literal and raises 22P02. It only ever executes when a probe leaks,
    // so the bug hides until the moment a guard actually fails.
    expect(sql).not.toMatch(/leaked \|\| '/);
    expect(sql).toMatch(/array_append\(leaked, '/);
  });
});
