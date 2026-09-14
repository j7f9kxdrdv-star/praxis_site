// ─── Memory against application ────────────────────────────────────────────
//
// The one question this file exists to answer: is a weak topic weak because the
// student does not REMEMBER it, or because they remember it and cannot APPLY
// it? Those have opposite fixes, and until now the analytics page could not
// tell them apart because the two bodies of evidence never met.
//
// OWNERSHIP, AND WHAT IS NOT RECOMPUTED HERE.
//
//   the FSRS scheduler   owns card-level memory state; this file consumes the
//                        first-look recall it already produces and does not
//                        re-derive stability, difficulty or intervals
//   the learner model    owns concept-level ability; this file consumes the
//                        Wilson lower bound and bands from topicState.ts
//   this file            compares the two and says what the comparison means
//
// NO SECOND MEMORY ALGORITHM IS DEFINED HERE. Recall arrives already computed.
//
// WHY "AGAIN" IS THE ONLY FAILURE GRADE. Again means the student could not
// retrieve the card; Hard, Medium and Easy all mean they did, at differing
// cost. That is FSRS's own semantics and it is the only reduction to
// correct/incorrect this file makes. It deliberately does NOT read Hard as a
// memory failure: historically Hard was partly used to ask for an earlier
// review rather than to report poor recall, so treating it as failure would
// convict students of weakness on a button press that meant something else.
// Hard still carries information, and it stays in the rating distribution the
// page shows descriptively; it just does not decide a topic's state.

import {
  wilsonLowerBound,
  MIN_ATTEMPTS_FOR_STATE,
  BANDS,
  type TopicState,
} from "@/lib/learner/topicState";

/**
 * First looks needed before recall evidence counts.
 *
 * Lower than the question threshold on purpose, and the asymmetry is not
 * sloppiness. A flashcard first look is a direct retrieval test of one fact;
 * a question is a multi-step application whose outcome depends on several.
 * Recall converges faster, so it needs less evidence to say something.
 *
 * JUDGEMENT, NOT MEASUREMENT. There is no outcome data to fit it to.
 */
export const MIN_FIRST_LOOKS = 8;

/** Recall floors, on the Wilson lower bound of first-look successes. */
export const RECALL_BANDS = {
  developing: 0.5,
  strong: 0.75,
} as const;

export type EvidenceLevel = "NONE" | "LIMITED" | "MODERATE" | "STRONG";

export type CrossModalityState =
  | "NO_EVIDENCE"
  | "LIMITED_EVIDENCE"
  | "MEMORY_GAP"
  | "APPLICATION_GAP"
  | "BROAD_WEAKNESS"
  | "BALANCED_STRENGTH";

export interface ModalityEvidence {
  /** Successes and trials. Questions: correct/attempts. Cards: first looks. */
  successes: number;
  trials: number;
}

export interface TopicIntelligence {
  key: string;
  label: string;
  application: { pct: number | null; trials: number; lowerBound: number | null };
  memory: { pct: number | null; trials: number; lowerBound: number | null };
  state: CrossModalityState;
  evidence: EvidenceLevel;
  /** A sentence the page can show. Plain, never motivational. */
  interpretation: string;
  /** What to do, or null when the evidence cannot support advice. */
  action: { label: string; kind: "PRACTICE" | "REVIEW" | "MAINTAIN" | "COLLECT" } | null;
}

const pct = (s: number, n: number) => (n > 0 ? Math.round((s / n) * 100) : null);

/** How much evidence is behind a claim, from the thinner of the two sides. */
function evidenceLevel(qTrials: number, cTrials: number): EvidenceLevel {
  const qOk = qTrials >= MIN_ATTEMPTS_FOR_STATE;
  const cOk = cTrials >= MIN_FIRST_LOOKS;
  if (!qOk && !cOk) return qTrials + cTrials === 0 ? "NONE" : "LIMITED";
  if (!qOk || !cOk) return "LIMITED";
  // Both sides cleared their floor. Depth beyond it earns the higher labels.
  if (qTrials >= MIN_ATTEMPTS_FOR_STATE * 3 && cTrials >= MIN_FIRST_LOOKS * 3) return "STRONG";
  return "MODERATE";
}

/**
 * What the two bodies of evidence say together.
 *
 * BOTH SIDES MUST CLEAR THEIR FLOOR before any comparison is made. The failure
 * this prevents is the spec's own example: calling something "strong recall,
 * weak application" on two card reviews and one question. With one side thin,
 * the honest output is LIMITED_EVIDENCE and no advice at all.
 */
export function topicIntelligence(
  key: string,
  label: string,
  questions: ModalityEvidence,
  cards: ModalityEvidence,
): TopicIntelligence {
  const qLb =
    questions.trials >= MIN_ATTEMPTS_FOR_STATE
      ? wilsonLowerBound(questions.successes, questions.trials)
      : null;
  const cLb =
    cards.trials >= MIN_FIRST_LOOKS
      ? wilsonLowerBound(cards.successes, cards.trials)
      : null;

  const application = {
    pct: pct(questions.successes, questions.trials),
    trials: questions.trials,
    lowerBound: qLb,
  };
  const memory = {
    pct: pct(cards.successes, cards.trials),
    trials: cards.trials,
    lowerBound: cLb,
  };
  const evidence = evidenceLevel(questions.trials, cards.trials);

  const base = { key, label, application, memory, evidence };

  if (questions.trials === 0 && cards.trials === 0) {
    return {
      ...base,
      state: "NO_EVIDENCE",
      interpretation: "No practice or review recorded here yet.",
      action: { label: "Explore topic", kind: "COLLECT" },
    };
  }

  // One side thin. Say which, and ask for the missing evidence rather than
  // guessing at the comparison.
  if (qLb === null || cLb === null) {
    const missing =
      qLb === null && cLb === null
        ? "Not enough practice or review here yet to compare recall with application."
        : qLb === null
          ? `Recall is measured here, but ${MIN_ATTEMPTS_FOR_STATE} practice questions are needed before application can be judged.`
          : `Practice is measured here, but ${MIN_FIRST_LOOKS} card reviews are needed before recall can be judged.`;
    return {
      ...base,
      state: "LIMITED_EVIDENCE",
      interpretation: missing,
      action:
        qLb === null
          ? { label: "Practice questions", kind: "PRACTICE" }
          : { label: "Review flashcards", kind: "REVIEW" },
    };
  }

  const memoryStrong = cLb >= RECALL_BANDS.strong;
  const memoryWeak = cLb < RECALL_BANDS.developing;
  const applicationStrong = qLb >= BANDS.stable;
  const applicationWeak = qLb < BANDS.developing;

  if (memoryWeak && applicationWeak) {
    return {
      ...base,
      state: "BROAD_WEAKNESS",
      interpretation: "Both recall and application are behind here. Start with the cards.",
      action: { label: "Review flashcards", kind: "REVIEW" },
    };
  }
  if (memoryStrong && applicationWeak) {
    return {
      ...base,
      state: "APPLICATION_GAP",
      interpretation: "You recall this reliably but lose it on questions.",
      action: { label: "Practice questions", kind: "PRACTICE" },
    };
  }
  if (memoryWeak && applicationStrong) {
    return {
      ...base,
      state: "MEMORY_GAP",
      interpretation: "You work this out on questions, but the underlying facts are not sticking.",
      action: { label: "Review flashcards", kind: "REVIEW" },
    };
  }
  if (memoryStrong && applicationStrong) {
    return {
      ...base,
      state: "BALANCED_STRENGTH",
      interpretation: "Recall and application are both holding.",
      action: { label: "Maintain", kind: "MAINTAIN" },
    };
  }
  // Everything in between: measured on both sides, neither clearly strong nor
  // clearly weak. Saying more than this would be inventing a distinction.
  return {
    ...base,
    state: "LIMITED_EVIDENCE",
    interpretation: "Recall and application are both mid-range here.",
    action: null,
  };
}

/** Copy for the state, kept out of the model so wording can change freely. */
export const STATE_LABELS: Record<CrossModalityState, string> = {
  NO_EVIDENCE: "No evidence",
  LIMITED_EVIDENCE: "Limited evidence",
  MEMORY_GAP: "Memory gap",
  APPLICATION_GAP: "Application gap",
  BROAD_WEAKNESS: "Needs attention",
  BALANCED_STRENGTH: "Holding",
};

export const EVIDENCE_LABELS: Record<EvidenceLevel, string> = {
  NONE: "No evidence",
  LIMITED: "Limited evidence",
  MODERATE: "Moderate evidence",
  STRONG: "Strong evidence",
};

/** Never shown to a student; kept so a state can be explained internally. */
export function explain(t: TopicIntelligence): Record<string, unknown> {
  return {
    key: t.key,
    state: t.state,
    evidence: t.evidence,
    applicationTrials: t.application.trials,
    applicationLowerBound: t.application.lowerBound,
    memoryTrials: t.memory.trials,
    memoryLowerBound: t.memory.lowerBound,
    thresholds: {
      minQuestionAttempts: MIN_ATTEMPTS_FOR_STATE,
      minFirstLooks: MIN_FIRST_LOOKS,
      recallBands: RECALL_BANDS,
      applicationBands: BANDS,
    },
  };
}

export type { TopicState };
