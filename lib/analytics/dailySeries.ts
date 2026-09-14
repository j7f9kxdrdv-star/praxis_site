// ─── The accuracy series ───────────────────────────────────────────────────
//
// One bucket per calendar day, including the days nothing happened.
//
// THE DISTINCTION THIS FILE EXISTS FOR. A day with no questions is not a day
// with 0% accuracy. Plotting it as zero draws a line falling to the floor and
// climbing back, which reads as a catastrophic session that never occurred. It
// is the single most misleading thing a study chart can do, and the only way
// to avoid it is to carry the absence as null the whole way through rather than
// letting a sum-over-zero collapse to a number.
//
// WEEKLY AVERAGING HID THE SAME THING MORE POLITELY. Bucketing into weeks made
// every gap disappear into a denominator, so a week with one 40-question day
// and six empty ones looked identical to a week of steady work.

export type Granularity = "day" | "week" | "month";

export interface SeriesSection {
  section: string;
  correct: number;
  total: number;
  accuracy: number;
}

export interface SeriesPoint {
  /** Local ISO date of the bucket's first day. */
  key: string;
  label: string;
  correct: number;
  /** Eligible first attempts. Zero means nothing was answered. */
  total: number;
  /** NULL on a bucket with no attempts. Never zero for an empty day. */
  accuracy: number | null;
  /** Only sections carrying enough to say something. */
  sections: SeriesSection[];
}

export interface AccuracySeries {
  points: SeriesPoint[];
  granularity: Granularity;
  /** Buckets that actually carry evidence. */
  measured: number;
  from: string;
  to: string;
}

export interface SeriesAttempt {
  createdAt: string;
  isCorrect: boolean;
  section: string | null;
  isFirstAttempt?: boolean | null;
}

/**
 * Attempts below this in a bucket are shown but visually de-emphasised.
 *
 * NOT HIDDEN. A one-question day is real and a student is entitled to see it;
 * it simply must not look like a forty-question day. Removing thin days was
 * the old behaviour and it quietly deleted most of a new student's history.
 */
export const LOW_SAMPLE = 5;

/**
 * Where daily detail stops being readable.
 *
 * Roughly a point every few pixels at the chart's rendered width. Past this the
 * series aggregates, but only for display: the underlying days are still there
 * and a shorter range brings them straight back.
 */
const MAX_DAILY_POINTS = 70;
const MAX_WEEKLY_POINTS = 60;

/** Local YYYY-MM-DD, so a late-evening attempt stays on the day it happened. */
export function localDayKey(d: Date): string {
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, "0");
  const day = String(d.getDate()).padStart(2, "0");
  return `${y}-${m}-${day}`;
}

const parseKey = (key: string) => new Date(`${key}T00:00:00`);

/** Monday of the week containing this date. */
function weekStart(d: Date): Date {
  const out = new Date(d);
  out.setDate(d.getDate() - ((d.getDay() + 6) % 7));
  out.setHours(0, 0, 0, 0);
  return out;
}

function monthStart(d: Date): Date {
  return new Date(d.getFullYear(), d.getMonth(), 1);
}

/** The granularity a span can actually render. */
export function granularityFor(days: number): Granularity {
  if (days <= MAX_DAILY_POINTS) return "day";
  if (days / 7 <= MAX_WEEKLY_POINTS) return "week";
  return "month";
}

function bucketKeyFor(d: Date, g: Granularity): string {
  if (g === "day") return localDayKey(d);
  if (g === "week") return localDayKey(weekStart(d));
  return localDayKey(monthStart(d));
}

function advance(d: Date, g: Granularity): Date {
  const out = new Date(d);
  if (g === "day") out.setDate(out.getDate() + 1);
  else if (g === "week") out.setDate(out.getDate() + 7);
  else out.setMonth(out.getMonth() + 1);
  return out;
}

function labelFor(key: string, g: Granularity): string {
  const d = parseKey(key);
  if (g === "month") return d.toLocaleDateString("en-US", { month: "short", year: "numeric" });
  return d.toLocaleDateString("en-US", { month: "short", day: "numeric" });
}

export interface SeriesInput {
  attempts: SeriesAttempt[];
  /** Inclusive local day bounds. */
  from: string;
  to: string;
  /** A bank section slug, or "all". */
  section: string;
  /** Sections need this many in a bucket before they earn a line. */
  minSectionSample?: number;
}

/**
 * Build the series.
 *
 * EVERY BUCKET IN THE RANGE IS EMITTED, including empty ones, because the gaps
 * are the point. A caller that only wants the measured ones can filter; a
 * caller that draws a line needs to know where not to draw it.
 */
export function buildSeries(input: SeriesInput): AccuracySeries {
  const { attempts, from, to, section } = input;
  const minSection = input.minSectionSample ?? LOW_SAMPLE;

  const start = parseKey(from);
  const end = parseKey(to);
  const spanDays = Math.max(1, Math.round((end.getTime() - start.getTime()) / 86_400_000) + 1);
  const granularity = granularityFor(spanDays);

  const eligible = attempts.filter(
    (a) =>
      a.isFirstAttempt !== false &&
      (section === "all" || a.section === section),
  );

  const buckets = new Map<
    string,
    { correct: number; total: number; sections: Map<string, { correct: number; total: number }> }
  >();

  for (const a of eligible) {
    const d = new Date(a.createdAt);
    const key = localDayKey(d);
    if (key < from || key > to) continue;
    const bk = bucketKeyFor(d, granularity);
    const b =
      buckets.get(bk) ?? { correct: 0, total: 0, sections: new Map() };
    b.total++;
    if (a.isCorrect) b.correct++;
    if (a.section) {
      const s = b.sections.get(a.section) ?? { correct: 0, total: 0 };
      s.total++;
      if (a.isCorrect) s.correct++;
      b.sections.set(a.section, s);
    }
    buckets.set(bk, b);
  }

  // Walk the whole range so absences are represented rather than skipped.
  const points: SeriesPoint[] = [];
  let cursor = granularity === "day"
    ? new Date(start)
    : parseKey(bucketKeyFor(start, granularity));
  let guard = 0;
  while (cursor <= end && guard++ < 4000) {
    const key = bucketKeyFor(cursor, granularity);
    const b = buckets.get(key);
    points.push({
      key,
      label: labelFor(key, granularity),
      correct: b?.correct ?? 0,
      total: b?.total ?? 0,
      // The whole point: no attempts means no measurement, not a zero.
      accuracy: b && b.total > 0 ? Math.round((b.correct / b.total) * 100) : null,
      sections: b
        ? [...b.sections.entries()]
            .filter(([, s]) => s.total >= minSection)
            .map(([sec, s]) => ({
              section: sec,
              correct: s.correct,
              total: s.total,
              accuracy: Math.round((s.correct / s.total) * 100),
            }))
            .sort((x, y) => y.total - x.total)
        : [],
    });
    cursor = advance(cursor, granularity);
  }

  return {
    points,
    granularity,
    measured: points.filter((p) => p.accuracy !== null).length,
    from,
    to,
  };
}

/**
 * Contiguous runs of measured buckets.
 *
 * A line drawn straight through a gap asserts that accuracy moved smoothly
 * across days the student did not study. Splitting into segments means the
 * stroke simply stops, which is what actually happened.
 */
export function segments(points: SeriesPoint[]): SeriesPoint[][] {
  const out: SeriesPoint[][] = [];
  let run: SeriesPoint[] = [];
  for (const p of points) {
    if (p.accuracy === null) {
      if (run.length) out.push(run);
      run = [];
    } else {
      run.push(p);
    }
  }
  if (run.length) out.push(run);
  return out;
}

/** How much to trust one bucket, for the label under a tooltip. */
export function evidenceFor(total: number): "NONE" | "LIMITED" | "ADEQUATE" {
  if (total === 0) return "NONE";
  return total < LOW_SAMPLE ? "LIMITED" : "ADEQUATE";
}
