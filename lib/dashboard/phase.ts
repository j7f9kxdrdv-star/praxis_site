// ─── Where the student actually is ─────────────────────────────────────────
//
// The checklist is ordered by phase, so the phase has to be measured rather
// than asserted. It is, and the separation is not subtle. Across the five real
// accounts the day this was written:
//
//   Brody   1,400 cards   mean stability 20.6d   difficulty 4.8   relearning  0.1%
//   Mikko   7,146 cards   mean stability  9.6d   difficulty 8.2   relearning 26.3%
//   Demo      716 cards   mean stability  4.8d   difficulty 7.6   relearning  0.0%
//   Jon        25 cards   mean stability  3.0d   difficulty 3.9   relearning  0.0%
//
// Brody and Mikko are not the same student and should not be told to do the
// same thing first. Jon has twenty-five cards and no measurement worth making.
//
// WHAT THIS DELIBERATELY DOES NOT USE. Practice exams. There are none: zero
// passages, zero timed attempts, zero exam rows, zero recorded scores, and
// is_timed is null on all 1,314 question attempts. The signal today is
// flashcards, which is strong, plus question volume, which is thin. Exams slot
// in here when they exist rather than being pretended at now.

export type Phase = "building" | "consolidating" | "applying";

/**
 * Below this many card-blanks seen, nothing is measurable and everyone is
 * building. Jon's twenty-five cards give a mean stability of 3 days, which
 * says he started on Tuesday, not that he is struggling.
 */
export const MIN_CARDS_FOR_PHASE = 200;

/**
 * Bands, not thresholds.
 *
 * A single cutoff makes a student sitting on it flip phase between page loads,
 * and the whole panel reorders under them. Leaving a phase takes a clearly
 * better number than entering it did.
 *
 * Note the honest limit of this: real hysteresis needs the PREVIOUS phase,
 * which is not stored yet. What saves it for now is that both signals move
 * slowly by construction. Mean stability across 7,146 cards does not shift in
 * one session. A student near a boundary can still flicker, and that is the
 * argument for persisting the phase when the recommendation work lands.
 */
const ENTER_CONSOLIDATING_STABILITY = 10;
const LEAVE_CONSOLIDATING_STABILITY = 8;
const ENTER_CONSOLIDATING_RELEARNING = 0.15;

// ── Applying ────────────────────────────────────────────────────────────
//
// Named for what the student does, not for the calendar. The first version of
// this was called exam_ready and required the exam to be close, which was a
// bug Mikko caught: Brody's cards sit at 20.6-day stability with almost nothing
// relearning, and with three months to go he would still have been told to do
// flashcards first. Solid cards earn questions whenever that becomes true.
//
// Exam proximity only LOWERS the bar. It never substitutes for it, so two days
// out with a quarter of the bank relearning still means building.
const APPLYING_STABILITY = 18;
const APPLYING_STABILITY_NEAR_EXAM = 14;
const APPLYING_RELEARNING = 0.1;
const NEAR_EXAM_DAYS = 14;

/**
 * Share of study time that goes to flashcards, as a number between 0 and 1.
 *
 * CONTINUOUS, NOT PER PHASE. It used to be one constant per phase, which meant
 * a student crossing a threshold saw their day jump from 55% cards to 45%
 * overnight. Mikko: "things should be fluid." They are now: the share slides
 * with how strong the cards are, and the phase only decides the ORDER of the
 * list, which cannot be half-reordered.
 *
 * 55% at seven-day stability or below, 25% at twenty-one days or above, linear
 * between. Weak cards then buy back a little time regardless of stability,
 * because a bank with a quarter of it in relearning needs the minutes whatever
 * the average says.
 *
 * The endpoints are judgement, not measurement, and there is no outcome data to
 * calibrate them against: no exam scores, no full lengths. They encode a belief
 * that retrieval is the bottleneck early and application is the bottleneck
 * later. Worth revisiting the moment there is a score to check them against.
 */
export function cardTimeShare(m: { meanStability: number; relearningShare: number }): number {
  const HIGH = 0.55;
  const LOW = 0.25;
  const YOUNG_DAYS = 7;
  const MATURE_DAYS = 21;

  const t = Math.min(1, Math.max(0, (m.meanStability - YOUNG_DAYS) / (MATURE_DAYS - YOUNG_DAYS)));
  const base = HIGH - t * (HIGH - LOW);
  const weakBump = Math.min(0.08, Math.max(0, m.relearningShare) * 0.25);
  return Math.min(0.6, Math.max(LOW, base + weakBump));
}

export interface PhaseInput {
  /** Card-blanks the student has a schedule for. */
  seenBlanks: number;
  /** Mean FSRS stability in days across those cards. */
  meanStability: number;
  /** Share of cards currently in FSRS relearning, 0 to 1. */
  relearningShare: number;
  /** Days until the exam, or null if no date is set. */
  daysToExam: number | null;
  /** Carried across loads once it is stored. Null until then. */
  previous?: Phase | null;
}

export interface PhaseResult {
  phase: Phase;
  /** One sentence, shown to the student, explaining the order they are seeing. */
  reason: string;
}

export function detectPhase(input: PhaseInput): PhaseResult {
  const { seenBlanks, meanStability, relearningShare, daysToExam, previous } = input;

  if (seenBlanks < MIN_CARDS_FOR_PHASE) {
    return {
      phase: "building",
      reason: "You are early on, so cards come first.",
    };
  }

  // ── Applying ─────────────────────────────────────────────────────────
  const nearExam = daysToExam !== null && daysToExam <= NEAR_EXAM_DAYS;
  const bar = nearExam ? APPLYING_STABILITY_NEAR_EXAM : APPLYING_STABILITY;
  if (meanStability >= bar && relearningShare < APPLYING_RELEARNING) {
    return {
      phase: "applying",
      reason: nearExam
        ? "Your recall is holding and the exam is close, so questions lead."
        : "Your cards are holding on their own now, so questions lead.",
    };
  }

  // ── Consolidating ────────────────────────────────────────────────────
  const stabilityBar =
    previous === "consolidating" || previous === "applying"
      ? LEAVE_CONSOLIDATING_STABILITY
      : ENTER_CONSOLIDATING_STABILITY;
  if (meanStability >= stabilityBar && relearningShare < ENTER_CONSOLIDATING_RELEARNING) {
    return {
      phase: "consolidating",
      reason: "Recall is starting to hold, so questions move up.",
    };
  }

  // ── Building ─────────────────────────────────────────────────────────
  return {
    phase: "building",
    reason:
      relearningShare >= ENTER_CONSOLIDATING_RELEARNING
        ? "A lot of cards are still coming back, so cards come first."
        : "Recall is still settling, so cards come first.",
  };
}

/**
 * Reads the raw card rows the dashboard already loads.
 *
 * fsrs_state 3 is relearning in ts-fsrs. Rows written before the FSRS
 * migration can carry a null state or a null stability; they are skipped for
 * the mean rather than counted as zero, which would drag a healthy bank down.
 */
export interface CardSummary
  extends Pick<PhaseInput, "seenBlanks" | "meanStability" | "relearningShare"> {
  /**
   * Reviews a day the collection asks for at its CURRENT strength: the sum of
   * 1/stability across live cards. Not a permanent property of the collection.
   * Mikko's 7,142 cards want 3,830 a day today because 1,882 of them are in
   * relearning and come back almost daily; at Brody's card strength the same
   * 7,142 would want 347. It is the honest measure of whether adding new cards
   * is affordable right now, which is the only thing it is used for.
   */
  dailyDemand: number;
}

export function summariseCards(
  rows: { fsrs_state?: number | null; stability?: number | null; suspended?: boolean | null }[],
): CardSummary {
  let stabilitySum = 0;
  let stabilityN = 0;
  let relearning = 0;
  let demand = 0;
  for (const r of rows) {
    if (r.stability != null) {
      stabilitySum += Number(r.stability);
      stabilityN++;
      if (!r.suspended) demand += 1 / Math.max(1, Number(r.stability));
    }
    if (r.fsrs_state === 3) relearning++;
  }
  return {
    seenBlanks: rows.length,
    meanStability: stabilityN > 0 ? stabilitySum / stabilityN : 0,
    relearningShare: rows.length > 0 ? relearning / rows.length : 0,
    dailyDemand: demand,
  };
}
