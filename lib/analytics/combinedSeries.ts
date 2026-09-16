// ─── Two measures on one calendar ──────────────────────────────────────────
//
// Question accuracy answers "what can I apply". First-look recall answers
// "what do I remember". Plotted together they answer the question neither can
// alone: is recall improving without transferring, or is application improving
// on memory that is still weak?
//
// BOTH ARE GENUINE PERCENTAGES, which is the only reason a shared 0-100% axis
// is honest. Question accuracy is correct over eligible first attempts;
// first-look recall is retrieved over session-first card views. If either
// stopped being a proportion, this chart would have to stop existing rather
// than rescale one of them onto the other's axis.
//
// NEITHER METRIC IS DEFINED HERE. Both arrive already computed: the question
// side from dailySeries.ts, the flashcard side from the aggregate endpoint,
// which is itself fed by the FSRS grades. This file only lines them up by date.
//
// A DAY WITH NO ACTIVITY IN ONE MODALITY KEEPS ITS OTHER HALF. Dropping the
// date because one series is missing would silently delete the very comparison
// the chart exists to show, since "I reviewed but did no questions" is a real
// and common shape of day.

import {
  buildSeries,
  granularityFor,
  evidenceFor,
  type Granularity,
  type SeriesAttempt,
  type SeriesPoint,
} from "./dailySeries";

export type Evidence = "NONE" | "LIMITED" | "ADEQUATE";

export interface ModalityPoint {
  /** Null when the day carried no activity. NEVER zero for an absent day. */
  value: number | null;
  numerator: number;
  denominator: number;
  evidence: Evidence;
}

export interface CombinedPoint {
  key: string;
  label: string;
  /** 0-100 across the plot, so an HTML overlay can sit on the SVG. */
  xPct: number;
  questions: ModalityPoint;
  flashcards: ModalityPoint;
}

export interface CombinedSeries {
  points: CombinedPoint[];
  granularity: Granularity;
  /** Buckets carrying at least one of the two measures. */
  measured: number;
  questionsMeasured: number;
  flashcardsMeasured: number;
  from: string;
  to: string;
}

/** A day of flashcard first looks, as the aggregate endpoint returns it. */
export interface DailyRecallInput {
  date: string;
  firstLooks: number;
  recalled: number;
  reviews: number;
}

export interface CombinedInput {
  attempts: SeriesAttempt[];
  daily: DailyRecallInput[];
  from: string;
  to: string;
  section: string;
}

/** First looks below this in a bucket are shown but marked thin. */
export const LOW_RECALL_SAMPLE = 10;

const empty = (): ModalityPoint => ({
  value: null,
  numerator: 0,
  denominator: 0,
  evidence: "NONE",
});

/**
 * Roll flashcard days up to whatever granularity the question series chose.
 *
 * The two series MUST share buckets or the crosshair would point at one date
 * on one line and a different one on the other.
 */
function bucketRecall(
  daily: DailyRecallInput[],
  points: SeriesPoint[],
  granularity: Granularity,
): Map<string, { firstLooks: number; recalled: number; reviews: number }> {
  const out = new Map<string, { firstLooks: number; recalled: number; reviews: number }>();
  if (points.length === 0) return out;

  // Bucket starts, ascending, so a day can be placed by the last start at or
  // before it. Cheaper and less error-prone than re-deriving week boundaries.
  const starts = points.map((p) => p.key);
  for (const d of daily) {
    if (d.date < starts[0]) continue;
    let lo = 0;
    let hi = starts.length - 1;
    while (lo < hi) {
      const mid = Math.ceil((lo + hi) / 2);
      if (starts[mid] <= d.date) lo = mid;
      else hi = mid - 1;
    }
    const key = starts[lo];
    const b = out.get(key) ?? { firstLooks: 0, recalled: 0, reviews: 0 };
    b.firstLooks += d.firstLooks;
    b.recalled += d.recalled;
    b.reviews += d.reviews;
    out.set(key, b);
  }
  return out;
}

export function buildCombinedSeries(input: CombinedInput): CombinedSeries {
  const qs = buildSeries({
    attempts: input.attempts,
    from: input.from,
    to: input.to,
    section: input.section,
  });

  const recall = bucketRecall(input.daily, qs.points, qs.granularity);

  const points: CombinedPoint[] = qs.points.map((p, i) => {
    const r = recall.get(p.key);
    const questions: ModalityPoint = {
      value: p.accuracy,
      numerator: p.correct,
      denominator: p.total,
      evidence: evidenceFor(p.total),
    };
    const flashcards: ModalityPoint = r && r.firstLooks > 0
      ? {
          value: Math.round((r.recalled / r.firstLooks) * 100),
          numerator: r.recalled,
          denominator: r.firstLooks,
          evidence: r.firstLooks < LOW_RECALL_SAMPLE ? "LIMITED" : "ADEQUATE",
        }
      : empty();

    return {
      key: p.key,
      label: p.label,
      xPct: qs.points.length === 1 ? 50 : (i / (qs.points.length - 1)) * 100,
      questions,
      flashcards,
    };
  });

  return {
    points,
    granularity: qs.granularity,
    measured: points.filter((p) => p.questions.value !== null || p.flashcards.value !== null)
      .length,
    questionsMeasured: points.filter((p) => p.questions.value !== null).length,
    flashcardsMeasured: points.filter((p) => p.flashcards.value !== null).length,
    from: input.from,
    to: input.to,
  };
}

/** Contiguous runs of measured buckets for one modality, so gaps break the line. */
export function runsFor(
  points: CombinedPoint[],
  modality: "questions" | "flashcards",
): { index: number; value: number }[][] {
  const out: { index: number; value: number }[][] = [];
  let run: { index: number; value: number }[] = [];
  points.forEach((p, index) => {
    const v = p[modality].value;
    if (v === null) {
      if (run.length) out.push(run);
      run = [];
    } else {
      run.push({ index, value: v });
    }
  });
  if (run.length) out.push(run);
  return out;
}

/** What the subtitle says, from the range and the granularity. */
export function seriesCaption(granularity: Granularity, periodLabel: string): string {
  const grain =
    granularity === "day" ? "Daily" : granularity === "week" ? "Weekly" : "Monthly";
  return `${grain} performance · ${periodLabel}`;
}

export { granularityFor };
