import { describe, it, expect } from "vitest";
import {
  buildConceptStates, wilsonInterval, durabilityOf, freshnessOf, isEligibleAttempt,
  CONCEPT_STATE_MODEL_VERSION, LEARNER_FACING_STATUSES,
  DURABLE_FLOOR, THIN_CEILING, DURABILITY_HORIZON_DAYS,
  type ConceptEvidence, type ConceptState, type AttemptRow, type EvidenceStrength, type Role,
} from "@/lib/learner/conceptState";
import { wilsonLowerBound } from "@/lib/learner/topicState";
import { FSRS_PARAMS } from "@/lib/flashcards/fsrsScheduler";
import { fsrs, State } from "ts-fsrs";

const NOW = new Date("2026-10-06T12:00:00.000Z");
const daysAgo = (d: number) => new Date(NOW.getTime() - d * 86_400_000).toISOString();
const C = "11111111-1111-1111-1111-111111111111";
const C2 = "22222222-2222-2222-2222-222222222222";

/** A concept with nothing attached, so each test states only what it cares about. */
function evidence(partial: Partial<ConceptEvidence> = {}): ConceptEvidence {
  return {
    concepts: [{ id: C, objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [], cardMappings: [], schedulerRows: [],
    questionMappings: [], attempts: [], ...partial,
  };
}

/** n cards, each one cloze, all at the same stability and recency. */
function cards(
  n: number,
  stability: number,
  opts: { reviewedDaysAgo?: number; role?: Role; conceptId?: string; available?: number } = {},
): Partial<ConceptEvidence> {
  const { reviewedDaysAgo = 0, role = "PRIMARY", conceptId = C, available = n } = opts;
  const flashcards = Array.from({ length: available }, (_, i) => ({ id: `card-${i}`, clozeCount: 1 }));
  return {
    flashcards,
    cardMappings: flashcards.map((f) => ({ conceptId, flashcardId: f.id, role, clozeIndices: null })),
    schedulerRows: flashcards.slice(0, n).map((f) => ({
      flashcardId: f.id, clozeIndex: 1, stability, reps: 3, suspended: false,
      lastReviewedAt: daysAgo(reviewedDaysAgo),
    })),
  };
}

/** `correct` of `total` eligible first attempts, oldest first. */
function attempts(
  correct: number, total: number,
  opts: { strength?: EvidenceStrength; role?: Role; conceptId?: string; startDaysAgo?: number } = {},
): Partial<ConceptEvidence> {
  const { strength = "STANDARD", role = "PRIMARY", conceptId = C, startDaysAgo = 100 } = opts;
  const rows: AttemptRow[] = Array.from({ length: total }, (_, i) => ({
    id: `a-${String(i).padStart(3, "0")}`, questionId: `q-${i}`,
    isCorrect: i < correct, isFirstAttempt: true, createdAt: daysAgo(startDaysAgo - i),
  }));
  return {
    questionMappings: rows.map((r) => ({ conceptId, questionId: r.questionId, role, evidenceStrength: strength })),
    attempts: rows,
  };
}

/** Attempts in an explicit order, so window behaviour can be driven precisely. */
function sequence(results: boolean[], opts: { conceptId?: string } = {}): Partial<ConceptEvidence> {
  const { conceptId = C } = opts;
  const rows: AttemptRow[] = results.map((ok, i) => ({
    id: `s-${String(i).padStart(3, "0")}`, questionId: `sq-${i}`,
    isCorrect: ok, isFirstAttempt: true, createdAt: daysAgo(200 - i),
  }));
  return {
    questionMappings: rows.map((r) => ({ conceptId, questionId: r.questionId, role: "PRIMARY", evidenceStrength: "STANDARD" })),
    attempts: rows,
  };
}

const only = (e: ConceptEvidence, previous: ConceptState[] | null = null): ConceptState =>
  buildConceptStates(e, previous, NOW)[0];

describe("statistics", () => {
  it("the lower bound agrees with topicState, so the two cannot drift", () => {
    for (const [c, n] of [[0, 3], [1, 3], [2, 3], [3, 3], [1, 5], [8, 10], [12, 12], [52, 70]]) {
      expect(wilsonInterval(c, n)[0]).toBeCloseTo(wilsonLowerBound(c, n), 12);
    }
  });

  it("the interval brackets the point estimate and is ordered", () => {
    for (const [c, n] of [[0, 5], [2, 5], [5, 5], [3, 10]]) {
      const [lo, hi] = wilsonInterval(c, n);
      expect(lo).toBeLessThanOrEqual(c / n);
      expect(hi).toBeGreaterThanOrEqual(c / n);
    }
  });

  it("zero attempts cannot produce a bound", () => expect(wilsonInterval(0, 0)).toEqual([0, 0]));

  // The exact table the frozen contract was argued from. Computed, not estimated:
  // if any of these move, the struggle rule has changed meaning.
  it.each([
    [0, 5, 0.434], [1, 5, 0.624], [2, 5, 0.769], [3, 5, 0.882], [4, 5, 0.964], [5, 5, 1.000],
    [4, 6, 0.903], [5, 6, 0.970], [6, 6, 1.000],
    [2, 10, 0.510], [3, 10, 0.603], [4, 10, 0.687], [6, 10, 0.832], [7, 10, 0.892],
    [8, 10, 0.943], [9, 10, 0.982], [10, 10, 1.000],
    [9, 12, 0.911], [10, 12, 0.953], [11, 12, 0.985], [12, 12, 1.000],
  ])("wilson upper bound for %i/%i is %f", (c, n, expected) => {
    expect(wilsonInterval(c, n)[1]).toBeCloseTo(expected, 3);
  });
});

describe("durability", () => {
  it("the documented band boundaries correspond to the documented stabilities", () => {
    expect(durabilityOf(5.61)).toBeCloseTo(DURABLE_FLOOR, 3);
    expect(durabilityOf(1.80)).toBeCloseTo(THIN_CEILING, 3);
    expect(durabilityOf(DURABILITY_HORIZON_DAYS)).toBeCloseTo(1, 10);
  });

  it("is monotonic, clipped and compresses the long tail", () => {
    expect(durabilityOf(0)).toBe(0);
    expect(durabilityOf(1000)).toBe(1);
    expect(durabilityOf(-5)).toBe(0);
    expect(durabilityOf(5) - durabilityOf(1)).toBeGreaterThan(durabilityOf(104) - durabilityOf(100));
  });
});

describe("freshness", () => {
  it("matches FSRS's own get_retrievability", () => {
    const engine = fsrs(FSRS_PARAMS);
    for (const [stability, elapsed] of [[5, 3], [20, 10], [1, 30]]) {
      const mine = freshnessOf(stability, daysAgo(elapsed), NOW);
      const theirs = engine.get_retrievability({
        due: NOW, stability, difficulty: 5, elapsed_days: 0, scheduled_days: 0,
        reps: 3, lapses: 0, state: State.Review, last_review: new Date(daysAgo(elapsed)),
        learning_steps: 0,
      } as never, NOW, false) as number;
      expect(mine).toBeCloseTo(theirs, 6);
    }
  });

  it("decays with elapsed time and is zero without a review date", () => {
    expect(freshnessOf(10, daysAgo(0), NOW)).toBeGreaterThan(freshnessOf(10, daysAgo(30), NOW));
    expect(freshnessOf(10, null, NOW)).toBe(0);
  });
});

describe("eligibility", () => {
  it("true and null are first attempts, only an explicit false is a repeat", () => {
    const rows: AttemptRow[] = [
      { id: "1", questionId: "q", isCorrect: true, isFirstAttempt: true, createdAt: daysAgo(3) },
      { id: "2", questionId: "q", isCorrect: true, isFirstAttempt: false, createdAt: daysAgo(2) },
      { id: "3", questionId: "q", isCorrect: true, isFirstAttempt: null, createdAt: daysAgo(1) },
    ];
    expect(rows.filter(isEligibleAttempt)).toHaveLength(2);
  });

  it("the three-value rule survives into the built state", () => {
    const rows: AttemptRow[] = [
      { id: "1", questionId: "q1", isCorrect: false, isFirstAttempt: true, createdAt: daysAgo(3) },
      { id: "2", questionId: "q2", isCorrect: false, isFirstAttempt: false, createdAt: daysAgo(2) },
      { id: "3", questionId: "q3", isCorrect: false, isFirstAttempt: null, createdAt: daysAgo(1) },
    ];
    const s = only(evidence({
      attempts: rows,
      questionMappings: rows.map((r) => ({ conceptId: C, questionId: r.questionId, role: "PRIMARY", evidenceStrength: "STANDARD" })),
    }));
    expect(s.applicationAttempts).toBe(2);
  });

  it("a non-learner-facing concept produces no state at all", () => {
    for (const status of ["DEPRECATED", "DRAFT", "PROPOSED", "ACTIVE"]) {
      const e = evidence({ concepts: [{ id: C, objectType: "CONTENT", status }], ...cards(3, 10) });
      expect(buildConceptStates(e, null, NOW)).toHaveLength(0);
    }
    expect(LEARNER_FACING_STATUSES.has("ACTIVE_SEED")).toBe(true);
    expect(LEARNER_FACING_STATUSES.has("ACTIVE")).toBe(false);
  });

  it("a REASONING or QUANTITATIVE object never gets a state", () => {
    for (const objectType of ["REASONING", "QUANTITATIVE"]) {
      const e = evidence({ concepts: [{ id: C, objectType, status: "ACTIVE_SEED" }], ...cards(3, 10) });
      expect(buildConceptStates(e, null, NOW)).toHaveLength(0);
    }
  });

  it("a concept with no evidence is omitted rather than returned empty", () => {
    expect(buildConceptStates(evidence(), null, NOW)).toHaveLength(0);
  });
});

describe("memory row eligibility", () => {
  const oneCard = (row: Partial<ConceptEvidence["schedulerRows"][number]>) => evidence({
    flashcards: [{ id: "f", clozeCount: 2 }],
    cardMappings: [{ conceptId: C, flashcardId: "f", role: "PRIMARY", clozeIndices: null }],
    schedulerRows: [{ flashcardId: "f", clozeIndex: 1, stability: 10, reps: 3, suspended: false, lastReviewedAt: daysAgo(1), ...row }],
  });

  it("a suspended card contributes nothing", () =>
    expect(buildConceptStates(oneCard({ suspended: true }), null, NOW)).toHaveLength(0));

  it("an unreviewed card (reps 0) contributes nothing: unlearned is not forgotten", () =>
    expect(buildConceptStates(oneCard({ reps: 0 }), null, NOW)).toHaveLength(0));

  it("an orphan cloze above cloze_count is ignored", () =>
    expect(buildConceptStates(oneCard({ clozeIndex: 3 }), null, NOW)).toHaveLength(0));

  it("a zero or negative cloze index is rejected defensively", () => {
    expect(buildConceptStates(oneCard({ clozeIndex: 0 }), null, NOW)).toHaveLength(0);
    expect(buildConceptStates(oneCard({ clozeIndex: -1 }), null, NOW)).toHaveLength(0);
    expect(buildConceptStates(oneCard({ clozeIndex: 1.5 }), null, NOW)).toHaveLength(0);
  });

  it("an orphan cloze cannot drag a concept down through the weakest-cloze rule", () => {
    // The live shape: card fabe94ee has cloze_count 1 and an orphan row at
    // index 2 with stability 0.54. Including it would halve this concept.
    const e = evidence({
      flashcards: [{ id: "f", clozeCount: 1 }],
      cardMappings: [{ conceptId: C, flashcardId: "f", role: "PRIMARY", clozeIndices: null }],
      schedulerRows: [
        { flashcardId: "f", clozeIndex: 1, stability: 20, reps: 5, suspended: false, lastReviewedAt: daysAgo(1) },
        { flashcardId: "f", clozeIndex: 2, stability: 0.54, reps: 6, suspended: false, lastReviewedAt: daysAgo(1) },
      ],
    });
    expect(only(e).memoryDurability).toBeCloseTo(durabilityOf(20), 10);
  });
});

describe("cloze aggregation", () => {
  it("the weakest cloze supplies the card's value", () => {
    const e = evidence({
      flashcards: [{ id: "f", clozeCount: 3 }],
      cardMappings: [{ conceptId: C, flashcardId: "f", role: "PRIMARY", clozeIndices: null }],
      schedulerRows: [1, 2, 3].map((i) => ({
        flashcardId: "f", clozeIndex: i, stability: i === 2 ? 1 : 30, reps: 4, suspended: false, lastReviewedAt: daysAgo(1),
      })),
    });
    expect(only(e).memoryDurability).toBeCloseTo(durabilityOf(1), 10);
  });

  it("one card is one vote however many clozes it carries", () => {
    const seven = evidence({
      flashcards: [{ id: "big", clozeCount: 7 }, { id: "small", clozeCount: 1 }],
      cardMappings: [
        { conceptId: C, flashcardId: "big", role: "PRIMARY", clozeIndices: null },
        { conceptId: C, flashcardId: "small", role: "PRIMARY", clozeIndices: null },
      ],
      schedulerRows: [
        ...[1, 2, 3, 4, 5, 6, 7].map((i) => ({
          flashcardId: "big", clozeIndex: i, stability: 30, reps: 4, suspended: false, lastReviewedAt: daysAgo(1),
        })),
        { flashcardId: "small", clozeIndex: 1, stability: 1, reps: 4, suspended: false, lastReviewedAt: daysAgo(1) },
      ],
    });
    // Mean of two card values, not of eight cloze values.
    expect(only(seven).memoryDurability).toBeCloseTo((durabilityOf(30) + durabilityOf(1)) / 2, 10);
    expect(only(seven).memoryItems).toBe(2);
  });
});

describe("cloze scope, the two real cards", () => {
  // b393432e: c1 = glucose -> Synthesis, c2 = chylomicron remnants -> Transport
  // 7d0c69e5: c1 = LDL -> Transport,     c2 = de novo          -> Synthesis
  const TRANSPORT = C, SYNTHESIS = C2;
  const scoped = (cardId: string, c1: string, c2: string): ConceptEvidence => evidence({
    concepts: [
      { id: TRANSPORT, objectType: "CONTENT", status: "ACTIVE_SEED" },
      { id: SYNTHESIS, objectType: "CONTENT", status: "ACTIVE_SEED" },
    ],
    flashcards: [{ id: cardId, clozeCount: 2 }],
    cardMappings: [
      { conceptId: c1, flashcardId: cardId, role: "PRIMARY", clozeIndices: [1] },
      { conceptId: c2, flashcardId: cardId, role: "SECONDARY", clozeIndices: [2] },
    ],
    schedulerRows: [
      { flashcardId: cardId, clozeIndex: 1, stability: 25, reps: 5, suspended: false, lastReviewedAt: daysAgo(1) },
      { flashcardId: cardId, clozeIndex: 2, stability: 1, reps: 5, suspended: false, lastReviewedAt: daysAgo(1) },
    ],
  });

  it("b393432e: cloze 1 feeds Synthesis only, cloze 2 feeds Transport only", () => {
    const states = buildConceptStates(scoped("b393432e", SYNTHESIS, TRANSPORT), null, NOW);
    const synth = states.find((s) => s.conceptId === SYNTHESIS)!;
    const transport = states.find((s) => s.conceptId === TRANSPORT)!;
    expect(synth.memoryDurability).toBeCloseTo(durabilityOf(25), 10);
    expect(transport.memoryDurability).toBeCloseTo(durabilityOf(1), 10);
  });

  it("7d0c69e5: cloze 1 feeds Transport only, cloze 2 feeds Synthesis only", () => {
    const states = buildConceptStates(scoped("7d0c69e5", TRANSPORT, SYNTHESIS), null, NOW);
    const transport = states.find((s) => s.conceptId === TRANSPORT)!;
    const synth = states.find((s) => s.conceptId === SYNTHESIS)!;
    expect(transport.memoryDurability).toBeCloseTo(durabilityOf(25), 10);
    expect(synth.memoryDurability).toBeCloseTo(durabilityOf(1), 10);
  });

  it("without scope, a failed cloze contaminates the other concept", () => {
    // The defect the column exists to prevent, demonstrated.
    const e = scoped("b393432e", SYNTHESIS, TRANSPORT);
    const unscoped: ConceptEvidence = { ...e, cardMappings: e.cardMappings.map((m) => ({ ...m, clozeIndices: null })) };
    const states = buildConceptStates(unscoped, null, NOW);
    for (const s of states) expect(s.memoryDurability).toBeCloseTo(durabilityOf(1), 10);
  });

  it("a scope that matches no eligible cloze contributes nothing", () => {
    const e = evidence({
      flashcards: [{ id: "f", clozeCount: 2 }],
      cardMappings: [{ conceptId: C, flashcardId: "f", role: "PRIMARY", clozeIndices: [2] }],
      schedulerRows: [{ flashcardId: "f", clozeIndex: 1, stability: 10, reps: 3, suspended: false, lastReviewedAt: daysAgo(1) }],
    });
    expect(buildConceptStates(e, null, NOW)).toHaveLength(0);
  });
});

describe("memory confidence", () => {
  it("one reviewed card is always LOW, and can never be HIGH", () => {
    const s = only(evidence(cards(1, 30)));
    expect(s.memoryConfidence).toBe("LOW");
    // The band still reports what the one card says. Only the LABEL withholds.
    expect(s.memorySignal).toBe("DURABLE");
    expect(s.stateLabel).toBe("INSUFFICIENT_EVIDENCE");
  });

  it("the documented thresholds land where the contract says", () => {
    expect(only(evidence(cards(2, 10))).memoryConfidence).toBe("MODERATE");
    expect(only(evidence(cards(3, 10))).memoryConfidence).toBe("MODERATE");
    expect(only(evidence(cards(6, 10))).memoryConfidence).toBe("HIGH");
  });

  it("an all-SECONDARY concept is capped below HIGH", () => {
    const s = only(evidence(cards(12, 10, { role: "SECONDARY" })));
    expect(s.memoryConfidenceRaw).toBeLessThanOrEqual(0.6);
    expect(s.memoryConfidence).toBe("MODERATE");
    expect(s.memoryConfidenceLimitedBy).toBe("ROLE");
  });

  it("a mixed PRIMARY and SECONDARY concept is not capped", () => {
    const base = cards(6, 10);
    const mixed = {
      ...base,
      cardMappings: base.cardMappings!.map((m, i) => ({ ...m, role: (i === 0 ? "PRIMARY" : "SECONDARY") as Role })),
    };
    expect(only(evidence(mixed)).memoryConfidence).toBe("HIGH");
  });

  it("breadth separates learner coverage from bank coverage", () => {
    const narrow = only(evidence(cards(3, 10, { available: 20 })));
    const full = only(evidence(cards(3, 10, { available: 3 })));
    expect(narrow.memoryConfidenceRaw).toBeLessThan(full.memoryConfidenceRaw);
    expect(narrow.memoryConfidenceLimitedBy).toBe("LEARNER_COVERAGE");
    expect(full.memoryConfidenceLimitedBy).toBe("BANK_COVERAGE");
  });

  it("confidence has hysteresis, so a concept on a boundary cannot flicker", () => {
    const e = evidence(cards(2, 10, { available: 3 }));
    const raw = only(e).memoryConfidenceRaw;
    expect(raw).toBeGreaterThan(0.4);
    expect(raw).toBeLessThan(0.45); // inside the margin above MODERATE
    const asLow = only(e, [{ ...only(e), memoryConfidence: "LOW" }]);
    expect(asLow.memoryConfidence).toBe("LOW"); // held, because the margin is not cleared
  });
});

describe("durability bands and hysteresis", () => {
  const withPrev = (stability: number, band: "THIN" | "BUILDING" | "DURABLE") =>
    only(evidence(cards(6, stability)), [{ ...only(evidence(cards(6, 10))), memorySignal: band }]);

  it("bands sit where the contract freezes them", () => {
    expect(only(evidence(cards(6, 1))).memorySignal).toBe("THIN");
    expect(only(evidence(cards(6, 3))).memorySignal).toBe("BUILDING");
    expect(only(evidence(cards(6, 10))).memorySignal).toBe("DURABLE");
  });

  it("climbs only when the next floor is cleared by the margin", () => {
    // d just above BUILDING's floor but inside the margin: holds THIN.
    const justInside = Math.exp((THIN_CEILING + 0.02) * Math.log(31)) - 1;
    expect(withPrev(justInside, "THIN").memorySignal).toBe("THIN");
    const clear = Math.exp((THIN_CEILING + 0.06) * Math.log(31)) - 1;
    expect(withPrev(clear, "THIN").memorySignal).toBe("BUILDING");
  });

  it("falls only when the held floor is undercut by the margin", () => {
    const justBelow = Math.exp((DURABLE_FLOOR - 0.02) * Math.log(31)) - 1;
    expect(withPrev(justBelow, "DURABLE").memorySignal).toBe("DURABLE");
    const clear = Math.exp((DURABLE_FLOOR - 0.06) * Math.log(31)) - 1;
    expect(withPrev(clear, "DURABLE").memorySignal).toBe("BUILDING");
  });

  it("BUILDING to THIN and THIN to BUILDING both work", () => {
    const low = Math.exp((THIN_CEILING - 0.06) * Math.log(31)) - 1;
    expect(withPrev(low, "BUILDING").memorySignal).toBe("THIN");
    const high = Math.exp((DURABLE_FLOOR + 0.06) * Math.log(31)) - 1;
    expect(withPrev(high, "BUILDING").memorySignal).toBe("DURABLE");
  });

  it("a multi-band jump climbs rung by rung rather than falling back", () => {
    // The bug topicState paid for: more evidence must never mean a worse band.
    expect(withPrev(30, "THIN").memorySignal).toBe("DURABLE");
  });

  it("freshness has no hysteresis: it is supposed to fall", () => {
    const fresh = only(evidence(cards(6, 10, { reviewedDaysAgo: 0 })));
    // 730 days, not 60: the FSRS curve is slow, and a card at stability 10 is
    // still COOLING after a year. See the note on band reachability in the handoff.
    const stale = only(evidence(cards(6, 10, { reviewedDaysAgo: 730 })), [fresh]);
    expect(fresh.freshnessSignal).toBe("FRESH");
    expect(stale.freshnessSignal).toBe("STALE");
  });

  it("durable but stale is a distinct label from durable and fresh", () => {
    expect(only(evidence(cards(6, 25, { reviewedDaysAgo: 0 }))).stateLabel).toBe("MEMORY_DURABLE");
    expect(only(evidence(cards(6, 25, { reviewedDaysAgo: 730 }))).stateLabel).toBe("MEMORY_DURABLE_STALE");
  });
});

describe("signals report evidence, confidence governs claims", () => {
  // The correction: a band is what the evidence we HAVE says. Confidence is how
  // far to trust generalising it. Erasing the band at LOW confidence threw away
  // a real measurement to express a doubt another field already carries.

  it("LOW confidence with thin evidence still reports THIN", () => {
    const s = only(evidence(cards(1, 1)));
    expect(s.memoryConfidence).toBe("LOW");
    expect(s.memorySignal).toBe("THIN");
    expect(s.memoryDurability).toBeCloseTo(durabilityOf(1), 10);
  });

  it("LOW confidence with durable evidence still reports DURABLE", () => {
    const s = only(evidence(cards(1, 25)));
    expect(s.memoryConfidence).toBe("LOW");
    expect(s.memorySignal).toBe("DURABLE");
  });

  it("LOW confidence with stale evidence still reports STALE", () => {
    const s = only(evidence(cards(1, 10, { reviewedDaysAgo: 730 })));
    expect(s.memoryConfidence).toBe("LOW");
    expect(s.freshnessSignal).toBe("STALE");
  });

  it("LOW confidence still withholds the label", () => {
    for (const stability of [1, 10, 25]) {
      expect(only(evidence(cards(1, stability))).stateLabel).toBe("INSUFFICIENT_EVIDENCE");
    }
  });

  it("crossing LOW to MODERATE does not invent a new measurement", () => {
    // Same stability, more cards. The band must not move because confidence did.
    const low = only(evidence(cards(1, 25)));
    const moderate = only(evidence(cards(3, 25)));
    expect(low.memoryConfidence).toBe("LOW");
    expect(moderate.memoryConfidence).toBe("MODERATE");
    expect(moderate.memorySignal).toBe(low.memorySignal);
    expect(moderate.memoryDurability).toBeCloseTo(low.memoryDurability!, 10);
    // And the label appears, because the claim is now permitted.
    expect(low.stateLabel).toBe("INSUFFICIENT_EVIDENCE");
    expect(moderate.stateLabel).toBe("MEMORY_DURABLE");
  });

  it("durability hysteresis survives a spell at LOW confidence", () => {
    // Previously the band was erased at LOW, so the previous state carried
    // INSUFFICIENT and hysteresis reset. Now the band persists and sticks.
    const justBelow = Math.exp((DURABLE_FLOOR - 0.02) * Math.log(31)) - 1;
    const prev = { ...only(evidence(cards(1, 25))), memorySignal: "DURABLE" as const };
    const held = only(evidence(cards(1, justBelow)), [prev]);
    expect(held.memoryConfidence).toBe("LOW");
    expect(held.memorySignal).toBe("DURABLE"); // inside the margin, so it holds
  });

  it("INSUFFICIENT means no memory evidence, never low confidence", () => {
    // Application evidence only: there is a state, and the memory axis is empty.
    const s = only(evidence(attempts(2, 3)));
    expect(s.memorySignal).toBe("INSUFFICIENT");
    expect(s.freshnessSignal).toBe("INSUFFICIENT");
    expect(s.memoryDurability).toBeNull();
    expect(s.memoryItems).toBe(0);
  });
});

describe("weak card count", () => {
  it("counts cards below the THIN boundary without changing the band", () => {
    const base = cards(6, 30);
    const mixed: Partial<ConceptEvidence> = {
      ...base,
      schedulerRows: base.schedulerRows!.map((r, i) => ({ ...r, stability: i < 2 ? 0.5 : 30 })),
    };
    const s = only(evidence(mixed));
    expect(s.weakCardCount).toBe(2);
    expect(s.memorySignal).toBe("DURABLE"); // the mean still carries the concept
  });

  it("is zero when every card is above the boundary", () =>
    expect(only(evidence(cards(6, 30))).weakCardCount).toBe(0));
});

describe("application: the observation", () => {
  it.each([
    [[false, false, false], true, "0 of 3"],
    [[true, false, false], true, "1 of 3"],
    [[true, true, false], false, "2 of 3"],
    [[true, true, true], false, "3 of 3"],
  ])("%s observed=%s (%s)", (results, expected) => {
    const s = only(evidence(sequence(results as boolean[])));
    expect(s.applicationSignal === "MISSES_OBSERVED").toBe(expected);
  });

  it("clears once the recent five hold fewer than two misses", () => {
    const s = only(evidence(sequence([true, false, false, true, true, true, true, true])));
    expect(s.applicationMissesInWindow).toBe(0);
    expect(s.applicationSignal).toBe("NOT_ESTABLISHED");
  });

  it("two ancient misses followed by twenty correct clears", () => {
    const s = only(evidence(sequence([false, false, ...Array(20).fill(true)])));
    expect(s.applicationSignal).toBe("NOT_ESTABLISHED");
    expect(s.applicationAttempts).toBe(22);
    expect(s.applicationCorrect).toBe(20);
  });

  it("8 of 10 overall with two recent misses is still observed", () => {
    const s = only(evidence(sequence([...Array(8).fill(true), false, false])));
    expect(s.applicationSignal).toBe("MISSES_OBSERVED");
    expect(s.applicationMissesInWindow).toBe(2);
  });

  it("needs no hysteresis: re-running against its own previous state is stable", () => {
    const e = evidence(sequence([true, false, false]));
    const first = only(e);
    expect(only(e, [first]).applicationSignal).toBe(first.applicationSignal);
  });
});

describe("application: the established negative state", () => {
  it.each([[0, 5, true], [1, 5, true], [2, 5, false], [3, 5, false], [4, 5, false], [5, 5, false],
           [2, 10, true], [3, 10, true], [4, 10, false], [8, 10, false], [9, 12, false], [12, 12, false]])(
    "%i/%i struggling=%s", (c, n, expected) => {
      const s = only(evidence(attempts(c, n)));
      expect(s.applicationSignal === "STRUGGLING").toBe(expected);
    });

  it("below five attempts it cannot fire however bad the run", () => {
    const s = only(evidence(attempts(0, 4)));
    expect(s.applicationSignal).toBe("MISSES_OBSERVED");
  });

  it("wins precedence over the observation when both are true", () => {
    const s = only(evidence(attempts(0, 5)));
    expect(s.applicationMissesInWindow).toBe(5);
    expect(s.applicationSignal).toBe("STRUGGLING");
  });

  it("clears only once the upper bound reaches the exit margin", () => {
    const prev = { ...only(evidence(attempts(0, 5))), applicationSignal: "STRUGGLING" as const };
    // 2/5 upper is 0.769, past the 0.70 exit, so it clears.
    expect(only(evidence(attempts(2, 5)), [prev]).applicationSignal).not.toBe("STRUGGLING");
    // 1/5 upper is 0.624, below the exit, so a struggling concept stays.
    expect(only(evidence(attempts(1, 5)), [prev]).applicationSignal).toBe("STRUGGLING");
  });

  it("makes no positive claim at any depth", () => {
    const labels = [only(evidence(attempts(12, 12))), only(evidence(attempts(20, 20)))].map((s) => s.applicationSignal);
    expect(labels).toEqual(["NOT_ESTABLISHED", "NOT_ESTABLISHED"]);
  });
});

describe("application: evidence strength and confidence", () => {
  it("SELF_CONTAINED is excluded entirely, not down-weighted", () => {
    // With no other evidence the concept drops out altogether, which is the
    // sparse-storage rule: five self-contained questions are not evidence.
    expect(buildConceptStates(evidence(attempts(0, 5, { strength: "SELF_CONTAINED" })), null, NOW)).toHaveLength(0);
    // With memory evidence present, the state exists and the attempts do not.
    const s = only(evidence({ ...cards(3, 10), ...attempts(0, 5, { strength: "SELF_CONTAINED" }) }));
    expect(s.applicationAttempts).toBe(0);
    expect(s.applicationSignal).toBe("INSUFFICIENT");
  });

  it("row 27's shape: a concept whose only question evidence is SELF_CONTAINED stays INSUFFICIENT", () => {
    const e = evidence({
      ...cards(6, 20),
      questionMappings: [{ conceptId: C, questionId: "cec05f2f", role: "PRIMARY", evidenceStrength: "SELF_CONTAINED" }],
      attempts: [{ id: "a1", questionId: "cec05f2f", isCorrect: false, isFirstAttempt: true, createdAt: daysAgo(5) }],
    });
    const s = only(e);
    expect(s.applicationSignal).toBe("INSUFFICIENT");
    expect(s.coverageState).toBe("MEMORY_ONLY");
  });

  it("RECOGNITION_ONLY is excluded too", () =>
    expect(only(evidence({ ...cards(3, 10), ...attempts(0, 5, { strength: "RECOGNITION_ONLY" }) })).applicationAttempts).toBe(0));

  it("UNREVIEWED and STANDARD both count", () => {
    expect(only(evidence(attempts(1, 5, { strength: "UNREVIEWED" }))).applicationAttempts).toBe(5);
    expect(only(evidence(attempts(1, 5, { strength: "STANDARD" }))).applicationAttempts).toBe(5);
  });

  it("confidence bands follow attempt count", () => {
    expect(only(evidence(attempts(2, 3))).applicationConfidence).toBe("LOW");
    expect(only(evidence(attempts(4, 8))).applicationConfidence).toBe("MODERATE");
    expect(only(evidence(attempts(8, 14))).applicationConfidence).toBe("HIGH");
  });

  it("all-SECONDARY application evidence cannot reach HIGH", () => {
    const s = only(evidence(attempts(8, 14, { role: "SECONDARY" })));
    expect(s.applicationConfidence).toBe("MODERATE");
  });

  it("one PRIMARY mapping restores the normal band", () => {
    const base = attempts(8, 14, { role: "SECONDARY" });
    const mixed = { ...base, questionMappings: base.questionMappings!.map((m, i) => ({ ...m, role: (i === 0 ? "PRIMARY" : "SECONDARY") as Role })) };
    expect(only(evidence(mixed)).applicationConfidence).toBe("HIGH");
  });
});

describe("coverage", () => {
  it("memory only, because the bank has no questions", () => {
    const s = only(evidence(cards(3, 10)));
    expect(s.coverageState).toBe("MEMORY_ONLY");
    expect(s.coverageReason).toBe("BANK_HAS_NO_QUESTIONS");
  });

  it("memory only, because the learner has not attempted the questions that exist", () => {
    const e = evidence({
      ...cards(3, 10),
      questionMappings: [{ conceptId: C, questionId: "q", role: "PRIMARY", evidenceStrength: "STANDARD" }],
    });
    const s = only(e);
    expect(s.coverageState).toBe("MEMORY_ONLY");
    expect(s.coverageReason).toBe("LEARNER_HAS_NOT_ATTEMPTED");
  });

  it("question only, because the bank has no cards", () => {
    const s = only(evidence(attempts(2, 3)));
    expect(s.coverageState).toBe("QUESTION_ONLY");
    expect(s.coverageReason).toBe("BANK_HAS_NO_CARDS");
  });

  it("question only, because the learner has reviewed none of the cards that exist", () => {
    const base = cards(0, 10, { available: 4 });
    const s = only(evidence({ ...base, ...attempts(2, 3) }));
    expect(s.coverageState).toBe("QUESTION_ONLY");
    expect(s.coverageReason).toBe("LEARNER_HAS_NOT_REVIEWED");
  });

  it("both modalities when the learner has touched each", () => {
    const s = only(evidence({ ...cards(3, 10), ...attempts(2, 3) }));
    expect(s.coverageState).toBe("BOTH_MODALITIES");
    expect(s.coverageReason).toBeNull();
  });
});

describe("cross-axis labels", () => {
  it("need an established struggle, not an observation", () => {
    // 1 of 3: observed, but LOW confidence, so no competence label.
    const observed = only(evidence({ ...cards(6, 25), ...sequence([true, false, false]) }));
    expect(observed.applicationSignal).toBe("MISSES_OBSERVED");
    expect(observed.stateLabel).toBe("MEMORY_DURABLE");
  });

  it("durable recall with established misses produces the headline label", () => {
    const s = only(evidence({ ...cards(6, 25, { reviewedDaysAgo: 0 }), ...attempts(1, 5) }));
    expect(s.applicationSignal).toBe("STRUGGLING");
    expect(s.stateLabel).toBe("DURABLE_RECALL_APPLICATION_MISSES");
  });

  it("stale recall with established misses is distinguished from durable", () => {
    const s = only(evidence({ ...cards(6, 25, { reviewedDaysAgo: 730 }), ...attempts(1, 5) }));
    expect(s.stateLabel).toBe("STALE_RECALL_APPLICATION_MISSES");
  });

  it("thin recall with established misses", () => {
    const s = only(evidence({ ...cards(6, 1), ...attempts(1, 5) }));
    expect(s.stateLabel).toBe("THIN_RECALL_APPLICATION_MISSES");
  });

  it("unknown memory with established misses", () => {
    // One card: the band is measured, but LOW confidence withholds the memory
    // half of the claim, so the label says the memory side is unknown.
    const s = only(evidence({ ...cards(1, 25), ...attempts(1, 5) }));
    expect(s.memorySignal).toBe("DURABLE");
    expect(s.memoryConfidence).toBe("LOW");
    expect(s.stateLabel).toBe("APPLICATION_MISSES_MEMORY_UNKNOWN");
  });
});

describe("purity and determinism", () => {
  it("does not mutate its input", () => {
    const e = evidence({ ...cards(3, 10), ...attempts(1, 5) });
    const snapshot = JSON.stringify(e);
    buildConceptStates(e, null, NOW);
    expect(JSON.stringify(e)).toBe(snapshot);
  });

  it("the same input and the same now give byte-identical output", () => {
    const e = evidence({ ...cards(3, 10), ...attempts(1, 5) });
    expect(JSON.stringify(buildConceptStates(e, null, NOW)))
      .toBe(JSON.stringify(buildConceptStates(e, null, NOW)));
  });

  it("output order is stable regardless of input order", () => {
    const base = evidence({
      concepts: [
        { id: C2, objectType: "CONTENT", status: "ACTIVE_SEED" },
        { id: C, objectType: "CONTENT", status: "ACTIVE_SEED" },
      ],
      ...cards(3, 10),
    });
    expect(buildConceptStates(base, null, NOW).map((s) => s.conceptId)).toEqual([C]);
  });

  it("ties in attempt timestamps resolve by id, not by insertion order", () => {
    const sameInstant = daysAgo(5);
    const rows: AttemptRow[] = [
      { id: "b", questionId: "q1", isCorrect: true, isFirstAttempt: true, createdAt: sameInstant },
      { id: "a", questionId: "q2", isCorrect: false, isFirstAttempt: true, createdAt: sameInstant },
      { id: "c", questionId: "q3", isCorrect: false, isFirstAttempt: true, createdAt: sameInstant },
    ];
    const build = (order: AttemptRow[]) => only(evidence({
      attempts: order,
      questionMappings: order.map((r) => ({ conceptId: C, questionId: r.questionId, role: "PRIMARY", evidenceStrength: "STANDARD" })),
    }));
    expect(JSON.stringify(build(rows))).toBe(JSON.stringify(build([...rows].reverse())));
  });

  it("every output carries the one model version", () => {
    const states = buildConceptStates(evidence({ ...cards(3, 10), ...attempts(1, 5) }), null, NOW);
    expect(states.length).toBeGreaterThan(0);
    for (const s of states) expect(s.modelVersion).toBe(CONCEPT_STATE_MODEL_VERSION);
    expect(CONCEPT_STATE_MODEL_VERSION).toBe("2.0.0-provisional");
  });

  it("reads no clock: passing a later now changes freshness and nothing else", () => {
    const e = evidence(cards(3, 10, { reviewedDaysAgo: 0 }));
    const later = new Date(NOW.getTime() + 60 * 86_400_000);
    const a = buildConceptStates(e, null, NOW)[0];
    const b = buildConceptStates(e, null, later)[0];
    expect(b.memoryFreshness!).toBeLessThan(a.memoryFreshness!);
    expect(b.memoryDurability).toBe(a.memoryDurability);
  });
});
