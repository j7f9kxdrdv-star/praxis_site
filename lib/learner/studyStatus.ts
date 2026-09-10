// ─── Study status ──────────────────────────────────────────────────────────
//
// A TRANSPARENT RULE-BASED MODEL, NOT A PROBABILITY. There is no validated
// readiness model here and there cannot be one yet: official_mcat_scores holds
// zero rows, there are no full lengths and no passages, so there is nothing to
// calibrate against. "83% ready" would be a number with no referent.
//
// So this names the stage the measured signals describe, and every rule below
// is a stated condition rather than a weight. There is deliberately no
// accuracy * 0.4 + coverage * 0.3 anywhere in this file: weights that nobody
// can defend produce a number nobody can explain.
//
// FLASHCARDS DO NOT REACH THE SCORE PREDICTOR. Memory health is one of the
// signals reported beside the status, and lib/scoring/scoreEstimate.ts takes
// only first-attempt question accuracy, the attempt count and which sections
// have data. That separation is a product rule, and this file does not bend it:
// memoryHealth is carried through to be DISPLAYED, never to move a score.
//
// EVERY RULE IS ORDERED AND EXCLUSIVE. The first matching rule wins, so a
// status can always be traced to one condition rather than to a total.

export const STUDY_STATUS_VERSION = "1.0.0";

export type StudyStatusCode =
  | "INSUFFICIENT_EVIDENCE"
  | "NEEDS_ATTENTION"
  | "BUILDING_FOUNDATION"
  | "ON_TRACK"
  | "PROGRESSING";

export type MemoryHealth = "STRONG" | "STABLE" | "BUILDING" | "NEEDS_ATTENTION";

export type EvidenceLevel = "NONE" | "THIN" | "ADEQUATE";

/**
 * Eligible first attempts before performance can be classified at all.
 *
 * Matches MIN_ATTEMPTS_TO_ESTIMATE in the score predictor, so the two systems
 * start speaking on the same evidence rather than one asserting a decline while
 * the other still refuses to give a range.
 */
export const MIN_ATTEMPTS_TO_CLASSIFY = 20;

/**
 * Points of accuracy decline that count as a decline.
 *
 * THE ONE JUDGEMENT NUMBER IN THIS FILE. Compared like for like: the last N
 * eligible questions against the N before them, so it moves when accuracy moves
 * rather than when study volume does. Four points is set so an ordinary run of
 * bad luck does not trip it; on a hundred-question window that is four
 * questions, which is inside normal variation for a single session but not for
 * a whole window.
 */
export const DECLINE_POINTS = 4;

/** Below this share of the bank, the material itself is still the constraint. */
export const FOUNDATION_COVERAGE = 25;

/**
 * How close to the target counts as on track.
 *
 * Compared against the TOP of the predicted range, not its centre. The range is
 * wide by construction while CARS and Psych/Soc are unmeasured, and a student
 * whose plausible outcomes reach their target has not been shown to be off
 * course. Claiming otherwise from an uncalibrated predictor would be the
 * strongest claim in the product resting on its weakest evidence.
 */
export const ON_TRACK_WITHIN_POINTS = 0;

export interface StudyStatusInput {
  /** Eligible first attempts. The gate on saying anything at all. */
  eligibleAttempts: number;
  /** Points against the previous equal-sized window; null when there is none. */
  accuracyDeltaPoints: number | null;
  /** Share of the question bank encountered, 0 to 100. */
  coveragePercent: number;
  /** Topics currently flagged, for reporting beside the status. */
  priorityCount: number;
  /** Reported, never used to move a score. See the header. */
  memoryHealth: MemoryHealth | null;
  /** Top of the predicted range from the EXISTING predictor; null when none. */
  predictedHigh: number | null;
  /** The predictor's own confidence, carried through unchanged. */
  predictionConfidence: string | null;
  /** profiles.target_mcat_score. Null when the student has not set one. */
  targetScore: number | null;
}

export interface StudyStatusResult {
  status: StudyStatusCode;
  /** Which rule fired, so any status can be explained without re-deriving it. */
  rule: string;
  evidence: EvidenceLevel;
  /** The signals shown beside the status, in display order. */
  signals: { label: string; value: string }[];
  version: string;
}

function evidenceLevel(eligible: number): EvidenceLevel {
  if (eligible === 0) return "NONE";
  return eligible < MIN_ATTEMPTS_TO_CLASSIFY ? "THIN" : "ADEQUATE";
}

/**
 * The student's current stage.
 *
 * Rules, in order. The first that matches wins:
 *
 *   1. INSUFFICIENT_EVIDENCE  fewer than 20 eligible first attempts. Nothing
 *                             has been measured, so nothing is claimed.
 *   2. NEEDS_ATTENTION        accuracy fell by DECLINE_POINTS or more against
 *                             the previous equal-sized window. A measured
 *                             decline outranks everything else.
 *   3. BUILDING_FOUNDATION    coverage below FOUNDATION_COVERAGE. Most of the
 *                             material is still ahead, so breadth is the work.
 *   4. ON_TRACK               ONLY with a target set, and only when the top of
 *                             the predicted range reaches it. Without a target
 *                             this rule cannot fire: "on track" toward nothing
 *                             is not a claim the product can support.
 *   5. PROGRESSING            everything else. Deliberately the default, and
 *                             deliberately modest.
 */
export function studyStatus(input: StudyStatusInput): StudyStatusResult {
  const evidence = evidenceLevel(input.eligibleAttempts);

  const signals: { label: string; value: string }[] = [
    {
      label: "Practice accuracy",
      value:
        input.accuracyDeltaPoints === null
          ? "Not enough data"
          : input.accuracyDeltaPoints >= DECLINE_POINTS
            ? "Improving"
            : input.accuracyDeltaPoints <= -DECLINE_POINTS
              ? "Declining"
              : "Stable",
    },
    {
      label: "Content coverage",
      value:
        input.coveragePercent < FOUNDATION_COVERAGE
          ? "Early"
          : input.coveragePercent < 60
            ? "Partial"
            : "Broad",
    },
    { label: "Memory strength", value: input.memoryHealth ?? "Not yet" },
    { label: "Priority topics", value: String(input.priorityCount) },
  ];
  if (input.targetScore !== null) {
    signals.push({ label: "Target", value: String(input.targetScore) });
  }

  const done = (status: StudyStatusCode, rule: string): StudyStatusResult => ({
    status,
    rule,
    evidence,
    signals,
    version: STUDY_STATUS_VERSION,
  });

  if (input.eligibleAttempts < MIN_ATTEMPTS_TO_CLASSIFY) {
    return done(
      "INSUFFICIENT_EVIDENCE",
      `eligibleAttempts ${input.eligibleAttempts} < ${MIN_ATTEMPTS_TO_CLASSIFY}`,
    );
  }

  if (input.accuracyDeltaPoints !== null && input.accuracyDeltaPoints <= -DECLINE_POINTS) {
    return done(
      "NEEDS_ATTENTION",
      `accuracy ${input.accuracyDeltaPoints} pts <= -${DECLINE_POINTS} vs previous window`,
    );
  }

  if (input.coveragePercent < FOUNDATION_COVERAGE) {
    return done(
      "BUILDING_FOUNDATION",
      `coverage ${input.coveragePercent}% < ${FOUNDATION_COVERAGE}%`,
    );
  }

  if (
    input.targetScore !== null &&
    input.predictedHigh !== null &&
    input.predictedHigh + ON_TRACK_WITHIN_POINTS >= input.targetScore
  ) {
    return done(
      "ON_TRACK",
      `predicted high ${input.predictedHigh} reaches target ${input.targetScore}`,
    );
  }

  return done(
    "PROGRESSING",
    input.targetScore === null
      ? "no target set, so ON_TRACK cannot be claimed"
      : `predicted high ${input.predictedHigh} short of target ${input.targetScore}`,
  );
}

/** Student-facing wording. The codes above are what the system reasons about. */
export const STATUS_LABEL: Record<StudyStatusCode, string> = {
  INSUFFICIENT_EVIDENCE: "Getting started",
  NEEDS_ATTENTION: "Needs attention",
  BUILDING_FOUNDATION: "Building foundation",
  ON_TRACK: "On track",
  PROGRESSING: "Progressing",
};

export function statusNote(r: StudyStatusResult, targetScore: number | null): string {
  switch (r.status) {
    case "INSUFFICIENT_EVIDENCE":
      return "A little more practice and this will start describing where you stand.";
    case "NEEDS_ATTENTION":
      return "Recent accuracy has slipped. The priority topics are the place to look.";
    case "BUILDING_FOUNDATION":
      return "Most of the bank is still ahead of you, so coverage is the thing to grow.";
    case "ON_TRACK":
      return `Your estimated range reaches ${targetScore}. Keep the plan going.`;
    case "PROGRESSING":
      return targetScore === null
        ? "Coverage and accuracy are both moving. Set a target score to track against it."
        : "Coverage and accuracy are both moving. Keep the daily plan going.";
  }
}
