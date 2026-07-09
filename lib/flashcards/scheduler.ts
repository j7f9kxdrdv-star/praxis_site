// ─── Spaced repetition ladder ─────────────────────────────────────────────────
//
// Lightweight scheduler — not full SM-2. Easy to reason about.
// Inputs: current interval (days) + user rating.
// Outputs: new interval (days) and the absolute next_review_at.
//
// Behavior (intentionally gentle — shorter intervals, more frequent review):
//   Again  → 10 minutes (sub-day re-show; resets reps/lapses).
//   Hard   → max(1, current * 1.4), capped at 60d.
//   Medium → max(1, current * 1.8), capped at 60d.
//   Easy   → max(1, current * 2.5), capped at 90d.
//   First review OR a card that just lapsed (Again dropped it below 1 day)
//   re-seeds from the first-review values below, so the three grades stay
//   DISTINCT instead of all flooring to 1 day right after a miss.

export type Rating = "again" | "hard" | "medium" | "easy";

const TEN_MINUTES_IN_DAYS = 10 / (60 * 24);

// Seed intervals for a first-ever review, and for a card re-learning after a
// lapse (any interval below 1 day, which only "Again" produces).
const FIRST_INTERVAL: Record<Rating, number> = {
  again: TEN_MINUTES_IN_DAYS,
  hard: 1,
  medium: 3,
  easy: 5,
};

// Caps in days
const CAPS: Record<Rating, number> = {
  again: TEN_MINUTES_IN_DAYS,
  hard: 60,
  medium: 60,
  easy: 90,
};

// Multipliers applied to an existing (>= 1 day) interval
const MULTIPLIERS: Record<Rating, number> = {
  again: 0,
  hard: 1.4,
  medium: 1.8,
  easy: 2.5,
};

export interface ScheduleInput {
  rating: Rating;
  /** Current interval in days (0 if never reviewed). */
  intervalDays: number;
  /** Previous reps count (for lapse tracking). */
  reps: number;
  /** Previous lapse count. */
  lapses: number;
}

export interface ScheduleOutput {
  intervalDays: number;
  nextReviewAt: Date;
  reps: number;
  lapses: number;
}

export function nextSchedule(input: ScheduleInput, now: Date = new Date()): ScheduleOutput {
  const { rating, intervalDays, reps, lapses } = input;

  let newInterval: number;
  if (rating === "again") {
    newInterval = TEN_MINUTES_IN_DAYS;
  } else if (intervalDays < 1) {
    // New card (interval 0) OR a card that just lapsed to a sub-day interval
    // via "Again". Re-seed from the first-review values so Hard/Medium/Easy
    // produce visibly different next-review dates instead of all multiplying a
    // ~10-minute interval and flooring to a flat 1 day.
    newInterval = FIRST_INTERVAL[rating];
  } else {
    newInterval = Math.max(1, intervalDays * MULTIPLIERS[rating]);
  }
  newInterval = Math.min(newInterval, CAPS[rating]);

  const nextReviewAt = new Date(now.getTime() + newInterval * 24 * 60 * 60 * 1000);

  const newReps = rating === "again" ? 0 : reps + 1;
  const newLapses = rating === "again" && reps > 0 ? lapses + 1 : lapses;

  return {
    intervalDays: newInterval,
    nextReviewAt,
    reps: newReps,
    lapses: newLapses,
  };
}

/** Human-readable interval label for the rating buttons in the study UI. */
export function previewLabel(intervalDays: number, rating: Rating): string {
  const next = nextSchedule({ rating, intervalDays, reps: 0, lapses: 0 }).intervalDays;
  if (next < 1) {
    const mins = Math.round(next * 24 * 60);
    return `${mins}m`;
  }
  if (next < 30) return `${Math.round(next)}d`;
  return `${Math.round(next / 7)}w`;
}
