// ─── Recent progress ───────────────────────────────────────────────────────
//
// Answers "is my work producing progress" from real learner-state transitions
// rather than from totals. Topics improved and priorities resolved come from
// learner_events, which come from snapshot diffs, so nothing here is inferred
// on the fly and nothing can be double-counted: the events were deduped when
// they were written.
//
// THE ACCURACY COMPARISON IS EVIDENCE-AWARE, and that is the whole difficulty.
// Two questions this week against eighty last week can produce a forty-point
// swing that says nothing at all about the student. So both windows must carry
// enough evidence before a delta is reported, and the sample sizes are returned
// alongside so the caller can show what the number rests on.

// 1.1.0 widened the window and gave coverage milestones a home. See
// RECENT_WINDOW_DAYS.
export const RECENT_PROGRESS_VERSION = "1.1.0";

/**
 * How far back "recent" reaches.
 *
 * RAISED FROM 7 TO 30. At seven days this card rendered nothing for six of the
 * seven real accounts, and every one of the 23 derived learner-state events
 * fell outside the window. The system was computing genuine progress signals
 * and then showing almost none of them.
 *
 * Seven days is also the wrong shape for how people actually study. A student
 * on fifteen hours a week does two or three sessions; the accuracy comparison
 * needs MIN_PER_WINDOW eligible attempts in BOTH halves, and two sessions
 * against two sessions is noise. At thirty days one real account moves from no
 * comparison at all to an ADEQUATE one.
 *
 * Thirty is also the longest span still honestly describable as recent. Ninety
 * surfaces more, and was rejected for that reason: an improvement from three
 * months ago is history, not progress.
 */
export const RECENT_WINDOW_DAYS = 30;

/** Eligible attempts each window needs before a comparison means anything. */
export const MIN_PER_WINDOW = 15;

export type EvidenceLevel = "NONE" | "INSUFFICIENT" | "ADEQUATE";

export interface RecentProgressInput {
  periodStart: string;
  periodEnd: string;
  /** Eligible first attempts inside the current window. */
  currentCorrect: number;
  currentN: number;
  /** The window immediately before it, of equal length. */
  previousCorrect: number;
  previousN: number;

  questionsCompleted: number;
  cardsReviewed: number;
  lessonsCompleted: number;

  coverageAtStart: number;
  coverageAtEnd: number;

  /** Counted from deduped learner_events inside the window. */
  topicsImproved: number;
  priorityAreasResolved: number;
  /**
   * Highest coverage milestone crossed inside the window, or null.
   *
   * Surfaced here because it has nowhere else to live: a priority ADDED shows
   * up in the Priority Topics list, but a milestone crossed leaves no trace on
   * the dashboard at all unless this card carries it.
   */
  coverageMilestone: number | null;
}

export interface RecentProgress {
  currentAccuracy: number | null;
  currentN: number;
  previousAccuracy: number | null;
  previousN: number;
  /** Percentage points. Null unless BOTH windows carry enough evidence. */
  accuracyDelta: number | null;
  insufficientEvidence: boolean;
  evidenceLevel: EvidenceLevel;

  questionsCompleted: number;
  cardsReviewed: number;
  lessonsCompleted: number;
  coverageDelta: number;

  topicsImproved: number;
  priorityAreasResolved: number;
  coverageMilestone: number | null;

  periodStart: string;
  periodEnd: string;
  version: string;
  /** True when there is nothing at all to show; the card renders its empty state. */
  isEmpty: boolean;
}

const pct = (correct: number, n: number) => (n > 0 ? Math.round((correct / n) * 100) : null);

export function recentProgress(input: RecentProgressInput): RecentProgress {
  const currentAccuracy = pct(input.currentCorrect, input.currentN);
  const previousAccuracy = pct(input.previousCorrect, input.previousN);

  // BOTH windows, not either. A rich current window against an empty previous
  // one is not an improvement, it is a student who did not study last week.
  const comparable = input.currentN >= MIN_PER_WINDOW && input.previousN >= MIN_PER_WINDOW;
  const accuracyDelta =
    comparable && currentAccuracy !== null && previousAccuracy !== null
      ? currentAccuracy - previousAccuracy
      : null;

  const evidenceLevel: EvidenceLevel =
    input.currentN === 0 ? "NONE" : comparable ? "ADEQUATE" : "INSUFFICIENT";

  const isEmpty =
    input.questionsCompleted === 0 &&
    input.cardsReviewed === 0 &&
    input.lessonsCompleted === 0 &&
    input.topicsImproved === 0 &&
    input.priorityAreasResolved === 0 &&
    input.coverageMilestone === null;

  return {
    currentAccuracy,
    currentN: input.currentN,
    previousAccuracy,
    previousN: input.previousN,
    accuracyDelta,
    insufficientEvidence: !comparable,
    evidenceLevel,
    questionsCompleted: input.questionsCompleted,
    cardsReviewed: input.cardsReviewed,
    lessonsCompleted: input.lessonsCompleted,
    coverageDelta: input.coverageAtEnd - input.coverageAtStart,
    topicsImproved: input.topicsImproved,
    priorityAreasResolved: input.priorityAreasResolved,
    coverageMilestone: input.coverageMilestone,
    periodStart: input.periodStart,
    periodEnd: input.periodEnd,
    version: RECENT_PROGRESS_VERSION,
    isEmpty,
  };
}

/** The signals the dashboard card renders. Only ones with something to say. */
export function progressSignals(p: RecentProgress): { label: string; value: string; detail?: string }[] {
  const out: { label: string; value: string; detail?: string }[] = [];

  if (p.accuracyDelta !== null && p.accuracyDelta !== 0) {
    out.push({
      label: "Practice accuracy",
      value: `${p.accuracyDelta > 0 ? "+" : ""}${p.accuracyDelta} pts`,
      detail: `${p.previousAccuracy}% to ${p.currentAccuracy}%, ${p.currentN} questions`,
    });
  }
  if (p.questionsCompleted > 0) {
    out.push({
      label: "Questions completed",
      value: p.questionsCompleted.toLocaleString("en-US"),
      detail: "this period",
    });
  }
  if (p.cardsReviewed > 0) {
    out.push({
      label: "Cards reviewed",
      value: p.cardsReviewed.toLocaleString("en-US"),
      detail: "distinct cards",
    });
  }
  if (p.topicsImproved > 0) {
    out.push({
      label: "Topics improved",
      value: String(p.topicsImproved),
      detail: "measured against your previous state",
    });
  }
  if (p.priorityAreasResolved > 0) {
    out.push({
      label: "Priority areas resolved",
      value: String(p.priorityAreasResolved),
      detail: "no longer meeting the priority threshold",
    });
  }
  if (p.coverageMilestone !== null) {
    // BREADTH, NOT MASTERY. The wording says what was seen and makes no claim
    // at all about how well it went.
    out.push({
      label: "Question bank seen",
      value: `${p.coverageMilestone}%`,
      detail: "a new milestone this period",
    });
  }
  if (p.lessonsCompleted > 0) {
    out.push({ label: "Lessons completed", value: String(p.lessonsCompleted) });
  }
  // Four is enough for a card; more becomes an analytics page.
  return out.slice(0, 4);
}
