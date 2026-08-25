import {
  fsrs,
  generatorParameters,
  createEmptyCard,
  Rating,
  State,
  type Card as FsrsCard,
  type FSRSParameters,
  type Grade,
} from "ts-fsrs";
import type { Rating as AppRating } from "./scheduler";

/**
 * The scheduler.
 *
 * WHAT CHANGED. The v2 ladder in scheduler.ts multiplied a card's interval by
 * a per-card ease factor. It had no model of forgetting: it could not say how
 * likely you were to remember a given card today, only how long to wait. FSRS
 * carries two numbers per card instead — STABILITY, how many days until recall
 * decays to 90%, and DIFFICULTY, how much each success actually buys — and
 * schedules the card for the day your predicted recall crosses the target.
 *
 * WHY THESE TWO NUMBERS. Both were simulated against the real review log
 * before being chosen rather than taken from the library's defaults; see
 * scripts/flashcards/sim/ and the PR7 commit message.
 *
 *   RETENTION 0.75. The library ships 0.90. Simulated over 39,624 real
 *   reviews, 0.90 costs roughly a third of what a student could otherwise know
 *   on exam day, because time spent re-reviewing near-certain cards is time not
 *   spent on material they have never seen. 0.75 also happens to be what
 *   students already experience: measured recall under the v2 ladder is
 *   73.0-77.5%. So sessions feel exactly as they do now, and only the
 *   placement of the intervals changes.
 *
 *   MAXIMUM_INTERVAL 60. This one is load-bearing, and an earlier version of
 *   this file had it at 180 for bad reasons. FSRS-6's default decay of 0.1542
 *   makes a very fat-tailed forgetting curve: a card with 2.3 days of
 *   stability is predicted to still be 52% recallable after 156 days. Dropping
 *   the target from 0.90 to 0.75 therefore multiplies intervals by about 5.6x,
 *   and replaying the real rating sequences at 0.75 sends 10.3% of intervals
 *   past 81 days — which is the longest gap that exists anywhere in the log,
 *   so everything beyond it is pure extrapolation.
 *
 *   That extrapolation is not trustworthy. Measured against the log, FSRS is
 *   accurate between 2 and 14 days (within 1.5 points) and 7.5 to 7.8 points
 *   TOO HOPEFUL beyond 14 days. Capping at 60 keeps cards inside the range the
 *   data actually covers, and costs about 1% of expected exam-day knowledge
 *   versus no cap at all. For a student sitting the MCAT in three months, a
 *   60-day interval already means "once more before the test" anyway.
 *
 * FUZZ IS ON. The simulation disabled it so that every retention target faced
 * identical luck. In production it must be on: without it, cards learned in
 * one sitting come due in one sitting, forever.
 */

export const RETENTION = 0.75;
export const MAXIMUM_INTERVAL = 60;

export const FSRS_PARAMS: FSRSParameters = generatorParameters({
  request_retention: RETENTION,
  maximum_interval: MAXIMUM_INTERVAL,
  enable_short_term: true,
  enable_fuzz: true,
});

const engine = fsrs(FSRS_PARAMS);

const RATING_MAP: Record<AppRating, Grade> = {
  again: Rating.Again,
  hard: Rating.Hard,
  medium: Rating.Good,
  easy: Rating.Easy,
};

const DAY_MS = 86_400_000;

/** What the database holds for one card-blank, as the route reads it. */
export interface StoredState {
  stability: number | null;
  difficulty: number | null;
  fsrsState: number | null;
  learningSteps: number | null;
  scheduledDays: number | null;
  reps: number;
  lapses: number;
  intervalDays: number;
  lastReviewedAt: Date | null;
  nextReviewAt: Date | null;
}

export interface ScheduleResult {
  stability: number;
  difficulty: number;
  fsrsState: number;
  learningSteps: number;
  scheduledDays: number;
  reps: number;
  lapses: number;
  intervalDays: number;
  nextReviewAt: Date;
}

/**
 * Rebuild the ts-fsrs card from stored columns.
 *
 * The interesting case is a row that predates FSRS. PR6's backfill replays
 * each card's real review history to derive a true stability and difficulty,
 * so most rows arrive here already populated. This is the safety net for one
 * that does not: rather than treat a card the student has drilled for months
 * as brand new — which would reset it to a one-minute interval and destroy the
 * schedule — it approximates.
 *
 * The approximation leans on FSRS's own definition: stability IS the number of
 * days for predicted recall to fall to 90%, so a card the v2 ladder had
 * settled at a 12-day interval had, near enough, a stability of 12. Difficulty
 * is mapped off the old ease factor, which moved in the same direction for the
 * same reasons (1.3 was the hardest a card could get, 2.8 the easiest).
 */
function toCard(s: StoredState | null, now: Date): FsrsCard {
  if (!s) return createEmptyCard(now);

  if (s.stability !== null && s.difficulty !== null && s.stability > 0) {
    return {
      due: s.nextReviewAt ?? now,
      stability: s.stability,
      difficulty: s.difficulty,
      elapsed_days: s.lastReviewedAt
        ? Math.max(0, (now.getTime() - s.lastReviewedAt.getTime()) / DAY_MS)
        : 0,
      scheduled_days: s.scheduledDays ?? s.intervalDays ?? 0,
      reps: s.reps,
      lapses: s.lapses,
      learning_steps: s.learningSteps ?? 0,
      state: (s.fsrsState ?? State.Review) as State,
      last_review: s.lastReviewedAt ?? undefined,
    } as FsrsCard;
  }

  // Pre-FSRS row with no seeded state.
  if (s.reps > 0 && s.intervalDays >= 1) {
    const card = createEmptyCard(now) as FsrsCard;
    card.stability = Math.min(Math.max(s.intervalDays, 0.5), 365);
    card.difficulty = 5;
    card.state = State.Review;
    card.reps = s.reps;
    card.lapses = s.lapses;
    card.scheduled_days = s.intervalDays;
    card.due = s.nextReviewAt ?? now;
    if (s.lastReviewedAt) card.last_review = s.lastReviewedAt;
    return card;
  }

  return createEmptyCard(now);
}

/** Grade one review and return everything the write path must persist. */
export function nextFsrsSchedule(
  stored: StoredState | null,
  rating: AppRating,
  now: Date = new Date(),
): ScheduleResult {
  const card = toCard(stored, now);
  const next = engine.next(card, now, RATING_MAP[rating]).card;
  const due = new Date(next.due);

  return {
    stability: next.stability,
    difficulty: next.difficulty,
    fsrsState: next.state,
    learningSteps: next.learning_steps ?? 0,
    scheduledDays: next.scheduled_days,
    reps: next.reps,
    lapses: next.lapses,
    // interval_days stays populated because the rest of the app reads it: the
    // UI's "next in N days", and PR4's same-day evidence rule, which asks
    // whether a card was already mature (>= 1 day) before this review.
    intervalDays: Math.max(0, (due.getTime() - now.getTime()) / DAY_MS),
    nextReviewAt: due,
  };
}

/** The four interval previews shown on the answer buttons. */
export function previewIntervals(
  stored: StoredState | null,
  now: Date = new Date(),
): Record<AppRating, number> {
  const out = {} as Record<AppRating, number>;
  for (const r of ["again", "hard", "medium", "easy"] as AppRating[]) {
    out[r] = nextFsrsSchedule(stored, r, now).intervalDays;
  }
  return out;
}
