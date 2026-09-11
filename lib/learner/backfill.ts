// ─── Historical backfill ───────────────────────────────────────────────────
//
// Reconstructs what was true about a student at the end of each past study day,
// from the raw logs that were already being written.
//
// THE ONE RULE THAT MATTERS: a snapshot for 1 September must be built from
// attempts made on or before 1 September, and from nothing else. Leaking a
// later attempt into an earlier snapshot does not just make that day wrong, it
// erases the transition: if 5 September's evidence is already inside the
// 1 September state, the diff between them shows nothing happening. The whole
// point of the backfill is those transitions, so the cutoff is the thing the
// tests hammer hardest.
//
// DETERMINISTIC AND IDEMPOTENT. Snapshots are keyed on (user_id, study_day) and
// events on (user_id, dedupe_key), so a rerun overwrites the same rows rather
// than appending. Running this twice produces the same database as running it
// once, which is what makes it safe to rerun after an interruption.
//
// It is also RESUMABLE for free: each day is computed from the raw logs and the
// previous day's reconstructed state, so a run that stops halfway can be
// restarted and will rebuild the same days to the same values.

import { buildSnapshot, deriveEvents, type LearnerSnapshot, type DerivedEvent } from "@/lib/learner/snapshot";

export const BACKFILL_VERSION = "1.0.0";

export interface HistoricalAttempt {
  questionId: string;
  topic: string | null;
  section: string;
  isCorrect: boolean;
  /** ISO timestamp. The cutoff is applied against this. */
  createdAt: string;
  /** False marks a repeat; those are never evidence of ability. */
  isFirstAttempt: boolean | null;
}

export interface BackfillInput {
  /** Every attempt the student has ever made, any order. */
  attempts: HistoricalAttempt[];
  /** Study-day boundaries, oldest first, as YYYY-MM-DD. */
  studyDays: string[];
  /** Questions in the bank, for the coverage denominator. */
  totalQuestions: number;
  /** Local hour the study day rolls over; 4 by default. */
  dayStartHour: number;
}

export interface BackfillResult {
  snapshots: LearnerSnapshot[];
  events: DerivedEvent[];
  version: string;
}

/**
 * The instant a study day ends, as an ISO string.
 *
 * A study day runs from dayStartHour to dayStartHour, so the day labelled
 * 1 September ends at 4am on 2 September. Using midnight here would drop an
 * evening session into the following day, which is the same bug the rest of the
 * system already avoids by using startOfStudyDay.
 */
export function studyDayEndIso(studyDay: string, dayStartHour: number): string {
  const [y, m, d] = studyDay.split("-").map(Number);
  // Local time, then to an instant. The +1 day puts us at the NEXT boundary.
  const end = new Date(y, m - 1, d + 1, dayStartHour, 0, 0, 0);
  return end.toISOString();
}

/**
 * The distinct study days a student actually studied on, oldest first.
 *
 * Days with no activity produce no snapshot. A student who did not open the app
 * has no new state, and a row saying so would be a row asserting something that
 * was never measured.
 */
export function studyDaysFrom(attempts: HistoricalAttempt[], dayStartHour: number): string[] {
  const days = new Set<string>();
  for (const a of attempts) {
    const t = new Date(a.createdAt);
    // Shift back by the day-start hour, then take the date part: an attempt at
    // 2am belongs to the previous study day.
    const shifted = new Date(t.getTime() - dayStartHour * 3_600_000);
    days.add(shifted.toISOString().slice(0, 10));
  }
  return [...days].sort();
}

/**
 * Rebuild every historical snapshot, and the events between them.
 *
 * Each day is built from the attempts up to that day's end and from the
 * previous day's reconstructed state, exactly as the live route builds today
 * from yesterday. Same function, same thresholds, same hysteresis, so a
 * backfilled day is indistinguishable from one captured live.
 */
export function backfill(input: BackfillInput): BackfillResult {
  const snapshots: LearnerSnapshot[] = [];
  const events: DerivedEvent[] = [];
  let previous: LearnerSnapshot | null = null;

  for (const day of input.studyDays) {
    const cutoff = studyDayEndIso(day, input.dayStartHour);

    // THE CUTOFF. Everything at or after this instant is the future as far as
    // this day is concerned, and must not be visible to it.
    const upTo = input.attempts.filter((a) => a.createdAt < cutoff);
    const eligible = upTo.filter((a) => a.isFirstAttempt !== false);

    const snapshot = buildSnapshot({
      studyDay: day,
      attempts: eligible.map((a) => ({
        topic: a.topic,
        section: a.section,
        isCorrect: a.isCorrect,
      })),
      recentAccuracy: recentPct(eligible.slice(-100)),
      recentSampleSize: Math.min(100, eligible.length),
      coverageAttempted: new Set(upTo.map((a) => a.questionId)).size,
      coverageTotal: input.totalQuestions,
      // Memory health is NOT reconstructed. See the limitation note below.
      memoryHealth: null,
      previous,
    });

    events.push(...deriveEvents(previous, snapshot));
    snapshots.push(snapshot);
    previous = snapshot;
  }

  return { snapshots, events, version: BACKFILL_VERSION };
}

function recentPct(rows: { isCorrect: boolean }[]): number | null {
  if (rows.length === 0) return null;
  return Math.round((rows.filter((r) => r.isCorrect).length / rows.length) * 100);
}

/**
 * What can and cannot be reconstructed, and why.
 *
 * Written down here rather than in a commit message because the honest answer
 * is a permanent property of the data, not a note about one migration.
 */
export const BACKFILL_COVERAGE = {
  FULLY_BACKFILLABLE: [
    "topic states, from question_attempts with created_at",
    "topic improvements and declines, from consecutive reconstructed states",
    "priority additions and resolutions, same",
    "content coverage and its growth",
    "questions completed per period",
  ],
  PARTIALLY_BACKFILLABLE: [
    // flashcard_reviews has reviewed_at, so card counts per day are exact. What
    // cannot be rebuilt is the FSRS state as it stood on a past day: the
    // scheduler stores only the current stability and difficulty per card, and
    // yesterday's values were overwritten by today's review.
    "cards reviewed per period: counts yes, historical memory health no",
  ],
  FORWARD_ONLY: [
    // practice_sessions records started_at and completed_at, so sittings are
    // known. What was never recorded is which snapshot a student had seen, so
    // "changed since you last looked" cannot be rebuilt for the past.
    "what changed since the student last opened the dashboard",
    // The predictor is versioned; past ranges were never stored, and
    // recomputing them with today's mapping would attribute today's model to a
    // date it did not exist on.
    "historical predicted score ranges",
    "historical study status transitions",
  ],
} as const;
