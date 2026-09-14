import { describe, it, expect } from "vitest";
import { canonicalTopicKey, buildTopicIndex, titleFromKey } from "./topicKey";
import {
  topicIntelligence,
  MIN_FIRST_LOOKS,
  RECALL_BANDS,
  explain,
  type ModalityEvidence,
} from "./crossModality";
import { MIN_ATTEMPTS_FOR_STATE, BANDS, wilsonLowerBound } from "@/lib/learner/topicState";

/** Successes out of n whose Wilson lower bound lands in [lo, hi). */
const scoreFor = (n: number, lo: number, hi: number) => {
  for (let c = 0; c <= n; c++) {
    const lb = wilsonLowerBound(c, n);
    if (lb >= lo && lb < hi) return c;
  }
  throw new Error(`no score out of ${n} lands in [${lo}, ${hi})`);
};

const ev = (successes: number, trials: number): ModalityEvidence => ({ successes, trials });

describe("the canonical topic key", () => {
  it("folds the two libraries' formats onto one key", () => {
    // The real shapes: question banks store human text, decks store slugs.
    expect(canonicalTopicKey("Carbohydrate Metabolism I")).toBe("carbohydrate_metabolism_i");
    expect(canonicalTopicKey("carbohydrate_metabolism_i")).toBe("carbohydrate_metabolism_i");
    expect(canonicalTopicKey("The Musculoskeletal System")).toBe("the_musculoskeletal_system");
  });

  it("spells out the ampersand rather than dropping it", () => {
    // "Functional Groups & Nomenclature" must not collapse to a double gap.
    expect(canonicalTopicKey("Functional Groups & Nomenclature")).toBe(
      "functional_groups_and_nomenclature",
    );
  });

  it("IS EXACT MATCHING, NOT SIMILARITY", () => {
    // The failure the spec warns about: joining two genuinely different names
    // because they look alike. Nothing here scores similarity, so near-misses
    // stay apart until someone adds an explicit alias.
    expect(canonicalTopicKey("Amino Acids")).not.toBe(canonicalTopicKey("Amino Acid Metabolism"));
    expect(canonicalTopicKey("Enzymes")).not.toBe(canonicalTopicKey("Enzyme Kinetics"));
  });

  it("resolves hand-written aliases for genuinely different names", () => {
    // Reviewable by design: each alias is a claim someone can argue with.
    expect(canonicalTopicKey("Embryogenesis & Development")).toBe(
      canonicalTopicKey("embryonic_development_and_gestation"),
    );
  });

  it("is idempotent, so a key can be re-canonicalised safely", () => {
    for (const s of ["Carbohydrate Metabolism I", "Functional Groups & Nomenclature", "Enzymes"]) {
      const once = canonicalTopicKey(s);
      expect(canonicalTopicKey(once)).toBe(once);
    }
  });

  it("KEEPS THE THREE COVERAGE CASES APART", () => {
    // A topic with questions and no cards is a CONTENT GAP, not weak recall.
    // Collapsing that into "weak" is how a library hole becomes a student's
    // fault.
    const index = buildTopicIndex(
      ["Enzymes", "Atomic Structure"],
      ["enzymes", "waves_and_sound"],
    );
    expect(index.get("enzymes")).toMatchObject({ hasQuestions: true, hasCards: true });
    expect(index.get("atomic_structure")).toMatchObject({ hasQuestions: true, hasCards: false });
    expect(index.get("waves_and_sound")).toMatchObject({ hasQuestions: false, hasCards: true });
  });

  it("gives a deck-only topic a readable name rather than a slug", () => {
    expect(titleFromKey("carbohydrate_metabolism_i")).toBe("Carbohydrate Metabolism I");
    expect(titleFromKey("rna_and_the_genetic_code")).toBe("RNA and the Genetic Code");
  });
});

describe("cross-modality requires evidence on BOTH sides", () => {
  it("REFUSES TO COMPARE ON THE SPEC'S OWN BAD EXAMPLE", () => {
    // Two card reviews and one question must never produce
    // "strong recall, weak application".
    const t = topicIntelligence("enzymes", "Enzymes", ev(0, 1), ev(2, 2));
    expect(t.state).toBe("LIMITED_EVIDENCE");
    expect(t.interpretation).not.toMatch(/strong|weak/i);
  });

  it("says which side is missing", () => {
    const noQuestions = topicIntelligence("enzymes", "Enzymes", ev(0, 0), ev(20, 24));
    expect(noQuestions.state).toBe("LIMITED_EVIDENCE");
    expect(noQuestions.action!.kind).toBe("PRACTICE");

    const noCards = topicIntelligence("enzymes", "Enzymes", ev(20, 30), ev(0, 0));
    expect(noCards.state).toBe("LIMITED_EVIDENCE");
    expect(noCards.action!.kind).toBe("REVIEW");
  });

  it("reports no evidence at all as its own state", () => {
    const t = topicIntelligence("enzymes", "Enzymes", ev(0, 0), ev(0, 0));
    expect(t.state).toBe("NO_EVIDENCE");
    expect(t.application.pct).toBeNull();
    expect(t.memory.pct).toBeNull();
  });
});

describe("the four measured states", () => {
  const qN = MIN_ATTEMPTS_FOR_STATE * 3;
  const cN = MIN_FIRST_LOOKS * 3;
  const strongQ = () => ev(scoreFor(qN, BANDS.stable, 1.01), qN);
  const weakQ = () => ev(scoreFor(qN, 0, BANDS.developing), qN);
  const strongC = () => ev(scoreFor(cN, RECALL_BANDS.strong, 1.01), cN);
  const weakC = () => ev(scoreFor(cN, 0, RECALL_BANDS.developing), cN);

  it("strong recall with weak application is an APPLICATION GAP", () => {
    const t = topicIntelligence("k", "K", weakQ(), strongC());
    expect(t.state).toBe("APPLICATION_GAP");
    expect(t.action!.kind).toBe("PRACTICE");
  });

  it("weak recall with strong application is a MEMORY GAP", () => {
    const t = topicIntelligence("k", "K", strongQ(), weakC());
    expect(t.state).toBe("MEMORY_GAP");
    expect(t.action!.kind).toBe("REVIEW");
  });

  it("weak on both sides sends the student to the cards first", () => {
    const t = topicIntelligence("k", "K", weakQ(), weakC());
    expect(t.state).toBe("BROAD_WEAKNESS");
    expect(t.action!.kind).toBe("REVIEW");
  });

  it("strong on both sides is left alone", () => {
    const t = topicIntelligence("k", "K", strongQ(), strongC());
    expect(t.state).toBe("BALANCED_STRENGTH");
    expect(t.action!.kind).toBe("MAINTAIN");
  });

  it("mid-range on both sides invents no distinction", () => {
    const q = ev(scoreFor(qN, BANDS.developing, BANDS.stable), qN);
    const c = ev(scoreFor(cN, RECALL_BANDS.developing, RECALL_BANDS.strong), cN);
    const t = topicIntelligence("k", "K", q, c);
    expect(t.state).toBe("LIMITED_EVIDENCE");
    expect(t.action).toBeNull();
  });
});

describe("the guarantees this must not break", () => {
  it("NEVER TREATS HARD AS A MEMORY FAILURE", () => {
    // The caller passes first-look SUCCESSES, where success is "not Again".
    // A topic where every look was Hard is a topic fully recalled, and must
    // come out strong, not weak.
    const cN = MIN_FIRST_LOOKS * 3;
    const qN = MIN_ATTEMPTS_FOR_STATE * 3;
    const allHardButRecalled = ev(cN, cN);
    const t = topicIntelligence("k", "K", ev(scoreFor(qN, BANDS.stable, 1.01), qN), allHardButRecalled);
    expect(t.state).toBe("BALANCED_STRENGTH");
  });

  it("never claims more confidence than the thinner side supports", () => {
    const deepQ = ev(40, 60);
    const thinC = ev(MIN_FIRST_LOOKS, MIN_FIRST_LOOKS);
    expect(topicIntelligence("k", "K", deepQ, thinC).evidence).toBe("MODERATE");
    expect(topicIntelligence("k", "K", deepQ, ev(60, 80)).evidence).toBe("STRONG");
  });

  it("keeps an internal explanation without exposing it as copy", () => {
    const t = topicIntelligence("k", "K", ev(20, 30), ev(20, 24));
    const e = explain(t);
    expect(e.thresholds).toBeDefined();
    expect(e.applicationLowerBound).toBeTypeOf("number");
    // The student-facing sentence carries no statistics.
    expect(t.interpretation).not.toMatch(/wilson|lower bound|0\.\d+/i);
  });

  it("is a pure read of the two inputs, defining no memory model of its own", () => {
    // Same inputs, same answer, every time. Nothing here holds state or
    // re-derives stability, difficulty or intervals.
    const a = topicIntelligence("k", "K", ev(20, 30), ev(20, 24));
    const b = topicIntelligence("k", "K", ev(20, 30), ev(20, 24));
    expect(a).toEqual(b);
  });
});
