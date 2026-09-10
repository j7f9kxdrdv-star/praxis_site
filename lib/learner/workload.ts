// ─── Unified planned workload ──────────────────────────────────────────────
//
// THE PROBLEM THIS SOLVES. A week's work spans questions, flashcards, missed
// questions and lessons, and there was no honest way to say how much of it was
// done. Adding the counts is not it: 350 cards + 120 questions + 3 lessons =
// 473 "items" asserts that a card and a lesson are the same unit of work, and
// finishing the cards alone would then read as 74% of the week.
//
// So the common unit is MINUTES. Modality counts are kept alongside, because a
// student wants to see "40 of 120 questions", not only a percentage.
//
// EVERY DURATION IS MEASURED WHERE THE EVIDENCE EXISTS.
//
//   questions   question_attempts.time_spent_seconds, which is populated on
//               all 1,314 rows: median 60s, p90 122s, p99 274s, max 1,333s.
//   flashcards  gaps between consecutive reviews, since the table has no
//               duration column. See measurePace in recommendedLimits.ts.
//   lessons     lessons.estimated_minutes, authored per lesson.
//
// Defaults are only for a student with too little history to measure, and they
// all live in DEFAULTS below rather than scattered through the code.
//
// BACKLOG IS NOT PLANNED WORK. The overdue queue can be thousands of cards;
// what belongs in the week is what the daily limits actually admit. Letting the
// backlog set the denominator would mean a student who did everything asked of
// them still saw 12%.

export const WORKLOAD_ESTIMATOR_VERSION = "1.0.0";

/**
 * Fallbacks, used only when a student has too little history to measure.
 *
 * The question figure is the median of all 1,314 real attempts in the bank
 * rather than a guess; the flashcard figure is the median review gap across the
 * two heaviest accounts. Both are starting points for a student with no history
 * of their own, and both are replaced by that student's own numbers as soon as
 * there are enough of them.
 */
export const DEFAULTS = {
  secondsPerQuestion: 60,
  secondsPerFlashcard: 9,
  /** Only for a lesson with no authored estimate. */
  minutesPerLesson: 25,
} as const;

/**
 * Durations outside this range are not study time.
 *
 * Under the floor is a misclick or a double-submit. Over the ceiling is a tab
 * left open over lunch: nine real attempts exceed ten minutes and the longest
 * is 22, which would drag a mean badly. Both bounds trim rather than discard,
 * so an unusually slow but genuine attempt still counts as slow.
 */
export const DURATION_BOUNDS = {
  minQuestionSeconds: 3,
  maxQuestionSeconds: 600,
  minFlashcardSeconds: 0.5,
  maxFlashcardSeconds: 120,
} as const;

/** Below this many samples, a student's own median is noise. */
export const MIN_SAMPLES_TO_PERSONALISE = 20;

export type Modality = "QUESTION" | "FLASHCARD" | "MISSED_QUESTION" | "LESSON";

export interface ModalityPlan {
  modality: Modality;
  planned: number;
  completed: number;
  /** Seconds per item used for this modality, so the maths can be checked. */
  secondsPerItem: number;
  plannedMinutes: number;
  completedMinutes: number;
  /** False when secondsPerItem came from DEFAULTS rather than this student. */
  measured: boolean;
}

export interface WeeklyPlan {
  modalities: ModalityPlan[];
  plannedMinutes: number;
  /** Everything actually done, including work beyond the plan. */
  completedMinutes: number;
  /** What counts toward the percentage: capped per modality. See weeklyPlan. */
  creditedMinutes: number;
  remainingMinutes: number;
  /** 0 to 100, clamped. Null when nothing is planned. */
  progressPercent: number | null;
  version: string;
  /** Everything needed to explain the number back to a developer. */
  diagnostics: {
    secondsPerQuestion: number;
    secondsPerFlashcard: number;
    questionSamples: number;
    flashcardSamples: number;
    personalisedQuestions: boolean;
    personalisedFlashcards: boolean;
  };
}

const median = (xs: number[]): number => {
  if (xs.length === 0) return 0;
  const s = [...xs].sort((a, b) => a - b);
  const mid = Math.floor(s.length / 2);
  return s.length % 2 ? s[mid] : (s[mid - 1] + s[mid]) / 2;
};

/**
 * Seconds this student spends on a question.
 *
 * Median, not mean, and bounded first. A mean over these rows is dragged by the
 * 22-minute attempt; a median is not, and bounding removes it before it can
 * reach the median either.
 */
export function questionSeconds(durations: (number | null | undefined)[]): {
  seconds: number;
  samples: number;
  measured: boolean;
} {
  const usable = durations
    .filter((d): d is number => typeof d === "number" && Number.isFinite(d))
    .filter(
      (d) =>
        d >= DURATION_BOUNDS.minQuestionSeconds && d <= DURATION_BOUNDS.maxQuestionSeconds,
    );
  if (usable.length < MIN_SAMPLES_TO_PERSONALISE) {
    return { seconds: DEFAULTS.secondsPerQuestion, samples: usable.length, measured: false };
  }
  return { seconds: median(usable), samples: usable.length, measured: true };
}

/**
 * Seconds this student spends on a card, from gaps between consecutive reviews.
 *
 * flashcard_reviews has no duration column, so the time spent on a card is the
 * gap to the next review in the same sitting. Rows must arrive OLDEST FIRST.
 */
export function flashcardSeconds(reviewedAt: string[]): {
  seconds: number;
  samples: number;
  measured: boolean;
} {
  const gaps: number[] = [];
  for (let i = 0; i < reviewedAt.length - 1; i++) {
    const gap =
      (new Date(reviewedAt[i + 1]).getTime() - new Date(reviewedAt[i]).getTime()) / 1000;
    if (gap > DURATION_BOUNDS.minFlashcardSeconds && gap < DURATION_BOUNDS.maxFlashcardSeconds) {
      gaps.push(gap);
    }
  }
  if (gaps.length < MIN_SAMPLES_TO_PERSONALISE) {
    return { seconds: DEFAULTS.secondsPerFlashcard, samples: gaps.length, measured: false };
  }
  return { seconds: median(gaps), samples: gaps.length, measured: true };
}

export interface WeeklyPlanInput {
  /** What the plan ASKS for this week. Never the backlog. */
  plannedQuestions: number;
  plannedFlashcards: number;
  plannedMissedQuestions: number;
  /** Authored minutes for the lessons planned, one entry per lesson. */
  plannedLessonMinutes: number[];

  completedQuestions: number;
  completedFlashcards: number;
  completedMissedQuestions: number;
  completedLessonMinutes: number[];

  /** Raw evidence; the estimators bound and median it. */
  questionDurations: (number | null | undefined)[];
  flashcardReviewTimes: string[];
}

const minutes = (count: number, secondsPer: number) => (count * secondsPer) / 60;

/**
 * The week's workload, in minutes, with the counts preserved.
 *
 * progressPercent = completedMinutes / plannedMinutes, clamped to 0..100.
 *
 * Clamped at the top because a student who does more than asked has finished
 * the plan, not 180% of it, and a progress bar past full reads as a bug. The
 * surplus is still visible in the modality counts.
 */
export function weeklyPlan(input: WeeklyPlanInput): WeeklyPlan {
  const q = questionSeconds(input.questionDurations);
  const f = flashcardSeconds(input.flashcardReviewTimes);

  const modalities: ModalityPlan[] = [
    {
      modality: "QUESTION",
      planned: input.plannedQuestions,
      completed: input.completedQuestions,
      secondsPerItem: q.seconds,
      plannedMinutes: minutes(input.plannedQuestions, q.seconds),
      completedMinutes: minutes(input.completedQuestions, q.seconds),
      measured: q.measured,
    },
    {
      modality: "FLASHCARD",
      planned: input.plannedFlashcards,
      completed: input.completedFlashcards,
      secondsPerItem: f.seconds,
      plannedMinutes: minutes(input.plannedFlashcards, f.seconds),
      completedMinutes: minutes(input.completedFlashcards, f.seconds),
      measured: f.measured,
    },
    {
      // A missed question is re-answered, so it costs a question's time.
      modality: "MISSED_QUESTION",
      planned: input.plannedMissedQuestions,
      completed: input.completedMissedQuestions,
      secondsPerItem: q.seconds,
      plannedMinutes: minutes(input.plannedMissedQuestions, q.seconds),
      completedMinutes: minutes(input.completedMissedQuestions, q.seconds),
      measured: q.measured,
    },
    {
      // Lessons carry their own authored minutes, so there is no per-item rate.
      modality: "LESSON",
      planned: input.plannedLessonMinutes.length,
      completed: input.completedLessonMinutes.length,
      secondsPerItem: 0,
      plannedMinutes: input.plannedLessonMinutes.reduce(
        (n, m) => n + (m > 0 ? m : DEFAULTS.minutesPerLesson),
        0,
      ),
      completedMinutes: input.completedLessonMinutes.reduce(
        (n, m) => n + (m > 0 ? m : DEFAULTS.minutesPerLesson),
        0,
      ),
      measured: true,
    },
  ];

  const plannedMinutes = modalities.reduce((n, m) => n + m.plannedMinutes, 0);

  // SURPLUS IN ONE MODALITY DOES NOT PAY FOR A DEFICIT IN ANOTHER.
  //
  // Found on real data: a student had reviewed 5,894 cards against a planned
  // 4,200, and because flashcards were 82% of his planned minutes the week read
  // 100% complete while 60 questions and 87 missed questions sat untouched.
  // Extra cards are extra cards; they are not the questions he did not do.
  //
  // Each modality therefore contributes at most what was planned for it. The
  // raw completed counts are untouched, so the overdelivery is still visible.
  const creditedMinutes = modalities.reduce(
    (n, m) => n + Math.min(m.completedMinutes, m.plannedMinutes),
    0,
  );
  const completedMinutes = modalities.reduce((n, m) => n + m.completedMinutes, 0);

  return {
    modalities,
    plannedMinutes: Math.round(plannedMinutes),
    completedMinutes: Math.round(completedMinutes),
    creditedMinutes: Math.round(creditedMinutes),
    remainingMinutes: Math.max(0, Math.round(plannedMinutes - creditedMinutes)),
    progressPercent:
      plannedMinutes > 0
        ? Math.max(0, Math.min(100, Math.round((creditedMinutes / plannedMinutes) * 100)))
        : null,
    version: WORKLOAD_ESTIMATOR_VERSION,
    diagnostics: {
      secondsPerQuestion: q.seconds,
      secondsPerFlashcard: f.seconds,
      questionSamples: q.samples,
      flashcardSamples: f.samples,
      personalisedQuestions: q.measured,
      personalisedFlashcards: f.measured,
    },
  };
}
