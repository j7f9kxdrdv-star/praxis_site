// ─── Recommended daily card limits ─────────────────────────────────────────
//
// The limits are the thing that decides whether a day fits. Ordering the
// checklist changes emphasis; the limits change capacity, and capacity is what
// was actually wrong. Brody is capped at 150 reviews when his hours support
// three times that, and set to 5,000 new cards, which would bury him in
// reviews a week later. Neither number came from anything.
//
// THESE ARE RECOMMENDATIONS AND ARE NEVER WRITTEN. Mikko's rule: show the
// recommendation and let the student take it. So nothing here updates a
// profile. A student who has chosen their own numbers keeps them until they
// choose otherwise, and the cost of that is an honest one: Brody's checklist
// asks for his 5,000 until he accepts the suggestion.
//
// MEASURED, NOT ASSUMED. Seconds per card comes from the student's own review
// log, not a rule of thumb. Medians from the real accounts:
//
//   Mikko   10.0s a review   10.5s a new card   (33,610 and 7,090 samples)
//   Brody    7.7s a review   10.6s a new card   ( 5,671 and 1,385 samples)
//
// Two students, two different days for the same 600 cards: 100 minutes versus
// 77. A shared constant would have been wrong for both.

import { cardTimeShare } from "@/lib/dashboard/phase";

/**
 * Reviews a card costs before it settles.
 *
 * MEASURED, and the first version of this was wrong by half. It was 10, taken
 * from memory of Anki folklore. The real number from the review log is 5, and
 * consistently so: median reps to reach 21-day stability was 5 for Mikko across
 * 864 matured cards and 5 for Brody across 626, two students who otherwise look
 * nothing alike. At 10 the recommendation was handing out half the new cards it
 * should have.
 */
const REVIEWS_PER_NEW_CARD = 5;

/** Fallbacks for a student with no history to measure. */
const DEFAULT_SECONDS_PER_CARD = 9;
const DEFAULT_NEW_MULTIPLIER = 1.2;
/** Below this many usable gaps, the median is noise. */
const MIN_SAMPLES_FOR_PACE = 30;

/** Gaps outside this range are a break, not a card. */
const MIN_GAP_S = 0.5;
const MAX_GAP_S = 120;

export interface Pace {
  secondsPerReview: number;
  secondsPerNewCard: number;
  /** False when the numbers above are defaults rather than this student's. */
  measured: boolean;
  samples: number;
}

const median = (xs: number[]) => {
  if (xs.length === 0) return 0;
  const s = [...xs].sort((a, b) => a - b);
  return s[Math.floor(s.length / 2)];
};

/**
 * How long this student actually spends on a card.
 *
 * Rows must arrive OLDEST FIRST. The time spent on a card is the gap to the
 * next review in the same sitting, so the row is charged for the gap that
 * follows it, not the one before.
 *
 * A recent sample is enough and is cheaper than the whole log: 500 rows put
 * Mikko at 9.4s against 10.1s over all 40,700, and Brody at 8.2s against 8.3s
 * over 7,056. It is also more current, since students speed up as they settle.
 */
export function measurePace(
  rows: { reviewed_at: string; is_first_exposure?: boolean | null }[],
): Pace {
  const fresh: number[] = [];
  const repeat: number[] = [];
  for (let i = 0; i < rows.length - 1; i++) {
    const gap =
      (new Date(rows[i + 1].reviewed_at).getTime() - new Date(rows[i].reviewed_at).getTime()) / 1000;
    if (gap <= MIN_GAP_S || gap >= MAX_GAP_S) continue;
    (rows[i].is_first_exposure ? fresh : repeat).push(gap);
  }

  const total = fresh.length + repeat.length;
  if (total < MIN_SAMPLES_FOR_PACE) {
    return {
      secondsPerReview: DEFAULT_SECONDS_PER_CARD,
      secondsPerNewCard: DEFAULT_SECONDS_PER_CARD * DEFAULT_NEW_MULTIPLIER,
      measured: false,
      samples: total,
    };
  }

  const perReview = repeat.length >= MIN_SAMPLES_FOR_PACE ? median(repeat) : median([...repeat, ...fresh]);
  // The new-card figure is only used when there are enough first exposures to
  // mean something. Measured ratios ran 1.05 to 1.38, so the default sits between.
  const perNew =
    fresh.length >= MIN_SAMPLES_FOR_PACE ? median(fresh) : perReview * DEFAULT_NEW_MULTIPLIER;

  return {
    secondsPerReview: perReview,
    secondsPerNewCard: perNew,
    measured: true,
    samples: total,
  };
}

export interface LimitInput {
  /**
   * Drives the continuous card-time share. See cardTimeShare in phase.ts.
   *
   * Note what is NOT here: the phase. Once the share became continuous the
   * phase stopped affecting the limits at all, which is the right separation.
   * Maturity decides how much TIME cards get; the phase decides only the ORDER
   * of the checklist, which is the one thing that cannot be interpolated.
   */
  meanStability: number;
  relearningShare: number;
  /** Reviews a day the existing collection already asks for. */
  dailyDemand: number;
  /** Null until the student sets it. Nothing is recommended without it. */
  studyHoursPerWeek: number | null;
  pace: Pace;
  /** Reviews waiting right now. */
  cardsDue: number;
  /** Card-blanks never seen. */
  unseenBlanks: number;
  /** What the student currently has set, so the caller can show the gap. */
  currentReviewLimit: number;
  currentNewLimit: number;
}

export interface LimitRecommendation {
  reviewLimit: number | null;
  newLimit: number | null;
  reviewReason: string;
  newReason: string;
  /** Set when no recommendation can honestly be made. */
  blocked: string | null;
  /** Shown so the student can check the reasoning rather than trust it. */
  basis: {
    minutesPerDay: number;
    cardMinutesPerDay: number;
    secondsPerReview: number;
    measured: boolean;
  };
  /** True when taking this would meaningfully change their day. */
  differsFromCurrent: boolean;
}

const roundTo = (n: number, step: number) => Math.max(0, Math.round(n / step) * step);

export function recommendLimits(input: LimitInput): LimitRecommendation {
  const { studyHoursPerWeek, pace, cardsDue, unseenBlanks } = input;

  const empty = {
    minutesPerDay: 0,
    cardMinutesPerDay: 0,
    secondsPerReview: pace.secondsPerReview,
    measured: pace.measured,
  };

  // Without hours there is no time budget, and inventing one would be exactly
  // the kind of made-up number this dashboard has been getting rid of.
  if (!studyHoursPerWeek || studyHoursPerWeek <= 0) {
    return {
      reviewLimit: null,
      newLimit: null,
      reviewReason: "",
      newReason: "",
      blocked: "Set your weekly study hours in Settings and we can suggest limits.",
      basis: empty,
      differsFromCurrent: false,
    };
  }

  const minutesPerDay = (studyHoursPerWeek * 60) / 7;
  const cardMinutes = minutesPerDay * cardTimeShare(input);
  const capacity = Math.floor((cardMinutes * 60) / Math.max(1, pace.secondsPerReview));

  const reviewLimit = roundTo(capacity, 10);

  // ── New cards ────────────────────────────────────────────────────────
  //
  // THE HEADROOM CHECK replaced a backlog-in-days rule. That rule was a proxy
  // for the real question, which is directly computable: does the collection
  // the student already has fit inside the day their hours allow? Demand is the
  // sum of 1/stability across their cards. If it already exceeds capacity,
  // every new card makes tomorrow worse, whatever the backlog happens to be.
  const headroom = capacity - input.dailyDemand;
  let newLimit: number;
  let newReason: string;

  if (unseenBlanks === 0) {
    newLimit = 0;
    newReason = "You have seen every card, so there are none to introduce.";
  } else if (headroom <= 0) {
    newLimit = 0;
    newReason =
      `The cards you already have want about ${Math.round(input.dailyDemand).toLocaleString("en-US")} reviews a day, ` +
      `more than the ${capacity.toLocaleString("en-US")} your hours allow. New cards would add to that, ` +
      "so hold them until your recall strengthens.";
  } else {
    // Leftover time after the reviews actually waiting, and never more than
    // the queue can absorb long term.
    const reviewMinutesNeeded = (Math.min(cardsDue, capacity) * pace.secondsPerReview) / 60;
    const leftoverMinutes = Math.max(0, cardMinutes - reviewMinutesNeeded);
    const byTime = Math.floor((leftoverMinutes * 60) / Math.max(1, pace.secondsPerNewCard));
    const bySustainability = Math.floor(capacity / REVIEWS_PER_NEW_CARD);
    const byHeadroom = Math.floor(headroom / (REVIEWS_PER_NEW_CARD / 14));
    newLimit = roundTo(Math.min(byTime, bySustainability, byHeadroom, unseenBlanks), 5);
    newReason =
      byTime < bySustainability
        ? "What is left of your card time once the reviews waiting are done."
        : `Each new card costs about ${REVIEWS_PER_NEW_CARD} reviews before it settles, so this keeps the queue level.`;
  }

  const reviewReason =
    cardsDue > reviewLimit
      ? `About ${Math.round(cardMinutes)} minutes of cards a day at your pace of ${pace.secondsPerReview.toFixed(1)}s each.`
      : `Comfortably above what is coming due, so nothing gets held back.`;

  return {
    reviewLimit,
    newLimit,
    reviewReason,
    newReason,
    blocked: null,
    basis: {
      minutesPerDay: Math.round(minutesPerDay),
      cardMinutesPerDay: Math.round(cardMinutes),
      secondsPerReview: pace.secondsPerReview,
      measured: pace.measured,
    },
    // A few cards either way is not worth interrupting anyone about.
    differsFromCurrent:
      Math.abs(reviewLimit - input.currentReviewLimit) > Math.max(20, input.currentReviewLimit * 0.15) ||
      Math.abs(newLimit - input.currentNewLimit) > Math.max(5, input.currentNewLimit * 0.15),
  };
}
