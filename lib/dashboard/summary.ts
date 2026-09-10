// ─── The numbers behind the dashboard's top row and status cards ───────────
//
// Pure functions over data the dashboard already loads. Nothing here queries,
// nothing here invents: every figure traces to a row the student produced, and
// a metric with no evidence returns null rather than a plausible number.
//
// WHY THIS FILE EXISTS. The old dashboard computed its statistics inline, which
// is how "expected precision gain" came to be displayed as +N% with no outcome
// data behind it at all. Derivations live here so they can be read, checked and
// tested away from the markup.

import { estimateScore, type ScoreEstimate } from "@/lib/scoring/scoreEstimate";

export interface Attempt {
  is_correct: boolean;
  created_at: string;
  question_id: string;
  /** Null on rows written before the column existed; those are backfilled. */
  is_first_attempt?: boolean | null;
}

export interface QuestionMeta {
  id: string;
  section: string;
  topic: string | null;
}

/**
 * An attempt counts as evidence of ability only the first time.
 *
 * A repeat of a question whose answer has already been seen measures memory of
 * that question, not the skill. About a quarter of all attempts in the bank are
 * repeats. The same rule the score predictor and the analytics page use.
 */
export const isEligible = (a: Attempt) => a.is_first_attempt !== false;

// ─── Top row ───────────────────────────────────────────────────────────────

/**
 * The score range, from the EXISTING predictor.
 *
 * Deliberately a thin wrapper: lib/scoring/scoreEstimate.ts owns every tunable
 * value and the version stamp, and a second mapping living on the dashboard is
 * exactly what that file was written to prevent. Flashcard performance is not
 * an input, because the approved model does not use it.
 */
export function scoreRange(attempts: Attempt[], questions: Map<string, QuestionMeta>): ScoreEstimate {
  const eligible = attempts.filter(isEligible);
  const correct = eligible.filter((a) => a.is_correct).length;
  const accuracy = eligible.length > 0 ? Math.round((correct / eligible.length) * 100) : 0;
  const sections = new Set(
    eligible.map((a) => questions.get(a.question_id)?.section).filter(Boolean) as string[],
  );
  return estimateScore(accuracy, eligible.length, sections);
}

export interface RecentAccuracy {
  /** Null until there are enough eligible attempts to mean anything. */
  percent: number | null;
  sampleSize: number;
  window: number;
  /**
   * Percentage points against the window before this one, or null when there
   * is no complete previous window to compare with.
   *
   * NOT a rolling seven-day figure. Comparing the last hundred questions with
   * the hundred before them holds the sample size fixed, so the number moves
   * when the student's accuracy moves rather than when their study volume does.
   */
  deltaPoints: number | null;
}

/** How many recent attempts before a percentage is worth showing. */
export const MIN_FOR_RECENT_ACCURACY = 20;

/**
 * Accuracy over the most recent eligible questions.
 *
 * Recent rather than lifetime, because a student who has improved should see
 * that, and a lifetime figure buries it under everything they did in week one.
 */
export function recentAccuracy(attempts: Attempt[], window = 100): RecentAccuracy {
  const all = attempts.filter(isEligible);
  const eligible = all.slice(-window);
  if (eligible.length < MIN_FOR_RECENT_ACCURACY) {
    return { percent: null, sampleSize: eligible.length, window, deltaPoints: null };
  }
  const pct = (rows: Attempt[]) =>
    Math.round((rows.filter((a) => a.is_correct).length / rows.length) * 100);
  const percent = pct(eligible);

  // Only against a FULL previous window. Comparing a hundred questions with a
  // stray nineteen would produce a swing that is about the sample, not the
  // student, and this card is read as a verdict on the student.
  const previous = all.slice(-(window * 2), -window);
  const deltaPoints = previous.length >= window ? percent - pct(previous) : null;

  return { percent, sampleSize: eligible.length, window, deltaPoints };
}

export interface WeeklyProgress {
  done: number;
  goal: number | null;
  percent: number | null;
}

/**
 * Questions answered this week against the student's own weekly goal.
 *
 * NOT a cross-modality "planned items" figure. There is no single plan object
 * spanning cards, questions and modules, so a combined number would have to be
 * assembled from parts that mean different things. This is questions, and it
 * says so.
 */
export function weeklyProgress(attempts: Attempt[], weeklyGoal: number | null): WeeklyProgress {
  const weekAgo = Date.now() - 7 * 86_400_000;
  const done = attempts.filter((a) => new Date(a.created_at).getTime() >= weekAgo).length;
  if (!weeklyGoal || weeklyGoal <= 0) return { done, goal: null, percent: null };
  return { done, goal: weeklyGoal, percent: Math.min(100, Math.round((done / weeklyGoal) * 100)) };
}

export interface Coverage {
  attempted: number;
  total: number;
  percent: number;
  bySection: { section: string; attempted: number; total: number; percent: number }[];
}

/**
 * How much of the bank the student has encountered.
 *
 * COVERAGE, NOT MASTERY, and the card is named for that. The old "Subject
 * Mastery" card showed exactly this number under a word it does not support:
 * answering a question once says you met the material, not that you know it.
 */
export function coverage(attempts: Attempt[], questions: QuestionMeta[]): Coverage {
  const answered = new Set(attempts.map((a) => a.question_id));
  const bySectionMap = new Map<string, { attempted: number; total: number }>();
  for (const q of questions) {
    const e = bySectionMap.get(q.section) ?? { attempted: 0, total: 0 };
    e.total++;
    if (answered.has(q.id)) e.attempted++;
    bySectionMap.set(q.section, e);
  }
  const bySection = [...bySectionMap.entries()]
    .map(([section, e]) => ({
      section,
      attempted: e.attempted,
      total: e.total,
      percent: e.total > 0 ? Math.round((e.attempted / e.total) * 100) : 0,
    }))
    .sort((a, b) => b.percent - a.percent);
  const attempted = bySection.reduce((n, s) => n + s.attempted, 0);
  const total = bySection.reduce((n, s) => n + s.total, 0);
  return {
    attempted,
    total,
    percent: total > 0 ? Math.round((attempted / total) * 100) : 0,
    bySection,
  };
}

// ─── Priority topics ───────────────────────────────────────────────────────

export type PriorityReason = "Recent misses" | "Weak application" | "Needs more evidence";

export interface PriorityTopic {
  topic: string;
  section: string;
  accuracy: number;
  attempts: number;
  reason: PriorityReason;
}

/** Below this, a topic is not weak, it is unmeasured. */
export const MIN_ATTEMPTS_FOR_PRIORITY = 5;
/** Enough attempts that the figure is about the student, not the sample. */
const CONFIDENT_ATTEMPTS = 12;
const WEAK_BELOW = 0.7;

/** Ranking a proportion when the counts differ; see the Analytics page. */
function wilsonLowerBound(ok: number, n: number): number {
  if (n === 0) return 0;
  const z = 1.96;
  const p = ok / n;
  return (
    (p + (z * z) / (2 * n) - z * Math.sqrt((p * (1 - p) + (z * z) / (4 * n)) / n)) / (1 + (z * z) / n)
  );
}

/**
 * Topics worth attention, weakest first.
 *
 * THE REASON IS PART OF THE CLAIM. A topic answered five times at 40% and one
 * answered forty times at 40% are not the same finding, and calling both "weak"
 * would be asserting more than the evidence carries. The thin one is labelled
 * as needing more evidence, which is what is actually true about it.
 */
export function priorityTopics(
  attempts: Attempt[],
  questions: Map<string, QuestionMeta>,
  limit = 3,
): PriorityTopic[] {
  const byTopic = new Map<string, { ok: number; n: number; section: string }>();
  for (const a of attempts) {
    if (!isEligible(a)) continue;
    const q = questions.get(a.question_id);
    if (!q?.topic) continue;
    const e = byTopic.get(q.topic) ?? { ok: 0, n: 0, section: q.section };
    e.n++;
    if (a.is_correct) e.ok++;
    byTopic.set(q.topic, e);
  }

  return [...byTopic.entries()]
    .filter(([, e]) => e.n >= MIN_ATTEMPTS_FOR_PRIORITY)
    .map(([topic, e]) => {
      const accuracy = e.ok / e.n;
      const reason: PriorityReason =
        e.n < CONFIDENT_ATTEMPTS
          ? "Needs more evidence"
          : accuracy < WEAK_BELOW / 2
            ? "Weak application"
            : "Recent misses";
      return {
        topic,
        section: e.section,
        accuracy: Math.round(accuracy * 100),
        attempts: e.n,
        reason,
        rank: wilsonLowerBound(e.ok, e.n),
      };
    })
    .filter((t) => t.accuracy < WEAK_BELOW * 100)
    .sort((a, b) => a.rank - b.rank)
    .slice(0, limit)
    // The Wilson figure was for ordering only; it does not belong on screen.
    .map((t) => ({
      topic: t.topic,
      section: t.section,
      accuracy: t.accuracy,
      attempts: t.attempts,
      reason: t.reason,
    }));
}

// ─── Study status ──────────────────────────────────────────────────────────

export type Trend = "Improving" | "Stable" | "Declining" | "Not enough data";

/** A swing smaller than this is noise, not a trend. */
const TREND_POINTS = 4;

export function accuracyTrend(deltaPoints: number | null, sample: number): Trend {
  if (sample < MIN_FOR_RECENT_ACCURACY || deltaPoints === null) return "Not enough data";
  if (deltaPoints >= TREND_POINTS) return "Improving";
  if (deltaPoints <= -TREND_POINTS) return "Declining";
  return "Stable";
}

export type CoverageBand = "Early" | "Partial" | "Broad";

export function coverageBand(percent: number): CoverageBand {
  if (percent < 25) return "Early";
  if (percent < 60) return "Partial";
  return "Broad";
}

