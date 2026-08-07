// ─── Spaced repetition ladder (v2) ────────────────────────────────────────────
//
// v2 — strength/schedule split + per-card ease. Still not full SM-2, but it
// borrows SM-2's two load-bearing ideas after the v1 ladder proved unable to
// let cards mature. Found 2026-08-07: across ~19,600 real reviews at a 40%
// "Again" rate, almost no card ever escaped the 1/3/5-day seed range.
//
// The v1 flaw: interval_days did double duty as BOTH the card's earned
// strength AND the time-to-next-show. "Again" had to set it to ~10 minutes to
// schedule the re-show, which silently erased the card's whole history — the
// next grade re-seeded from scratch (1/3/5d) as if the card were brand new.
// At a 40% lapse rate the odds of the 6-9 consecutive passes needed to reach
// three weeks were a few percent, so intervals pinned at the seeds forever.
//
// v2 separates the two jobs:
//   • intervalDays  — earned strength. Never drops below 1 day once a card has
//     been passed. A lapse HALVES it (floor 1d) instead of zeroing it, so ten
//     good reviews cost one miss half their progress, not all of it.
//   • nextReviewAt  — when the card is shown. "Again" re-shows in 10 minutes
//     regardless of strength, exactly as before.
//   • easeFactor    — per-card difficulty memory. v1 stored this on every
//     review and never read it. Now: Again −0.20 · Hard −0.15 · Medium ±0 ·
//     Easy +0.15, clamped to [1.3, 2.8]. Medium/Easy growth scales with it,
//     so a card you keep missing earns short gaps and a card you breeze
//     through stretches out.
//
// Ladder for a learned card (strength i ≥ 1, updated ease e):
//   Again  → strength max(1, i × 0.5); shown again in 10 minutes.
//   Hard   → max(i + 1, i × 1.2), cap 60d. Fixed multiplier kept strictly
//            BELOW the 1.3 ease floor so Hard can never schedule further out
//            than Medium (adversarial review caught 1.5 inverting the two for
//            any card whose ease had drifted under 1.5 — which a 40%-Again
//            profile reaches within ~8 reviews). The +1-day floor still
//            guarantees progress; repeated Hards slow future growth through
//            the ease penalty rather than stalling the card.
//   Medium → max(i + 1, i × e), cap 60d.
//   Easy   → max(i + 1, i × e × 1.3), cap 90d.
// The additive +1-day floor guarantees visible progress at small intervals
// even when the multiplier alone would round to the same day. Caps never claw
// back earned strength: a card Easy pushed to 90d and later graded Medium
// keeps 90d (capped at max(cap, current)), it does not drop to 60d.
//
// A first-ever pass still seeds 1 / 3 / 5 days, so first-review button labels
// are unchanged. An unlearned card graded Again keeps the 10-minute sentinel
// strength (~0.007d, NOT 0): quota counting relies on the invariant that a
// review row with prev_interval_days === 0 marks a card's first-ever
// exposure, and storing 0 here would count relearning cards against the
// daily NEW budget on later days. Rows lapsed under v1 sit at the same
// ~0.007d and relearn through the seeds, exactly as v1 had them do.
//
// reps semantics changed in v2: lifetime successful reviews, no longer reset
// by a lapse (lapses has always been the lapse counter — nothing else in
// either app reads reps for logic, verified 2026-08-07).

export type Rating = "again" | "hard" | "medium" | "easy";

const TEN_MINUTES_IN_DAYS = 10 / (60 * 24);
const DAY_MS = 24 * 60 * 60 * 1000;

// Seed strengths for a card's first-ever successful review.
const FIRST_INTERVAL: Record<Exclude<Rating, "again">, number> = {
  hard: 1,
  medium: 3,
  easy: 5,
};

// Growth caps in days
const CAPS: Record<Exclude<Rating, "again">, number> = {
  hard: 60,
  medium: 60,
  easy: 90,
};

// Per-card ease: adjustment per rating, and hard bounds.
const EASE_DELTA: Record<Rating, number> = {
  again: -0.2,
  hard: -0.15,
  medium: 0,
  easy: 0.15,
};
export const EASE_MIN = 1.3;
export const EASE_MAX = 2.8;
export const EASE_DEFAULT = 2.5;

const LAPSE_FACTOR = 0.5; // a lapse halves strength…
const LAPSE_FLOOR = 1; //   …but never below one day
const HARD_FACTOR = 1.2; // must stay < EASE_MIN so Hard ≤ Medium always holds
const EASY_BONUS = 1.3;

export interface ScheduleInput {
  rating: Rating;
  /** Current strength in days (0 if the card has never been passed). */
  intervalDays: number;
  /** Per-card ease factor; pass EASE_DEFAULT when the card has no state yet. */
  easeFactor: number;
  /** Lifetime successful reviews so far. */
  reps: number;
  /** Lapse count so far. */
  lapses: number;
}

export interface ScheduleOutput {
  /** New strength in days — store in interval_days. */
  intervalDays: number;
  /** When to show the card next — store in next_review_at. */
  nextReviewAt: Date;
  /** Updated per-card ease — store in ease_factor. */
  easeFactor: number;
  /** Lifetime successful reviews (not reset by a lapse). */
  reps: number;
  lapses: number;
}

function clampEase(e: number): number {
  return Math.min(EASE_MAX, Math.max(EASE_MIN, e));
}

export function nextSchedule(input: ScheduleInput, now: Date = new Date()): ScheduleOutput {
  const { rating, intervalDays, reps, lapses } = input;

  // Guard against missing/garbage stored ease (old rows all carry 2.5, but a
  // null would otherwise poison every future interval on the card).
  const storedEase =
    Number.isFinite(input.easeFactor) && input.easeFactor > 0 ? input.easeFactor : EASE_DEFAULT;
  const easeFactor = clampEase(storedEase + EASE_DELTA[rating]);

  // Below 1 day = never passed (or lapsed under the v1 scheduler, which zeroed
  // strength — those legacy rows relearn from the seeds, as v1 had them do).
  const learned = intervalDays >= 1;

  if (rating === "again") {
    return {
      // Learned: halve, floored at 1d and belt-and-braces capped at 90d.
      // Unlearned: the 10-minute sentinel, never 0 — see the header note on
      // the prev_interval_days === 0 first-exposure invariant.
      intervalDays: learned
        ? Math.min(CAPS.easy, Math.max(LAPSE_FLOOR, intervalDays * LAPSE_FACTOR))
        : TEN_MINUTES_IN_DAYS,
      nextReviewAt: new Date(now.getTime() + TEN_MINUTES_IN_DAYS * DAY_MS),
      easeFactor,
      reps, // unchanged — reps counts successes
      lapses: learned ? lapses + 1 : lapses,
    };
  }

  let strength: number;
  if (!learned) {
    strength = FIRST_INTERVAL[rating];
  } else if (rating === "hard") {
    strength = Math.max(intervalDays + 1, intervalDays * HARD_FACTOR);
  } else if (rating === "medium") {
    strength = Math.max(intervalDays + 1, intervalDays * easeFactor);
  } else {
    strength = Math.max(intervalDays + 1, intervalDays * easeFactor * EASY_BONUS);
  }
  // Cap growth without clawing back strength already above the cap: a 90d
  // card graded Medium stays 90d rather than being cut to Medium's 60d cap.
  strength = Math.min(strength, Math.max(CAPS[rating], intervalDays));

  return {
    intervalDays: strength,
    nextReviewAt: new Date(now.getTime() + strength * DAY_MS),
    easeFactor,
    reps: reps + 1,
    lapses,
  };
}

/**
 * Label for the rating buttons: how long until the card would be SEEN again.
 * Note this is show-time, not strength — "Again" on a mature card halves its
 * strength but still re-shows in 10 minutes, so the label must read "10m".
 */
export function previewLabel(intervalDays: number, easeFactor: number, rating: Rating): string {
  const epoch = new Date(0);
  const next = nextSchedule({ rating, intervalDays, easeFactor, reps: 0, lapses: 0 }, epoch);
  const days = (next.nextReviewAt.getTime() - epoch.getTime()) / DAY_MS;
  if (days < 1) return `${Math.round(days * 24 * 60)}m`;
  if (days < 30) return `${Math.round(days)}d`;
  return `${Math.round(days / 7)}w`;
}
