"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import { estimateScore, estimateBasis } from "@/lib/scoring/scoreEstimate";
import { canonicalTopicKey, titleFromKey } from "@/lib/analytics/topicKey";
import type { FlashcardAggregate } from "@/lib/analytics/flashcardAggregate";
import { localDayKey } from "@/lib/analytics/dailySeries";
import {
  buildCombinedSeries,
  runsFor,
  bridgesFor,
  quietCount,
  seriesCaption,
  type CombinedSeries,
  type ModalityPoint,
} from "@/lib/analytics/combinedSeries";
import {
  topicIntelligence,
  STATE_LABELS,
  EVIDENCE_LABELS,
  type TopicIntelligence,
} from "@/lib/analytics/crossModality";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import {
  PraxPage,
  PageHeader,
  SmallCaps,
  PraxCard,
} from "@/components/dashboard/PraxUI";
import {
  RecentProgress,
  type ProgressSignal,
} from "@/components/dashboard/DashboardCards";

/* ─────────── Types ─────────── */

interface Attempt {
  is_correct: boolean;
  created_at: string;
  question_id: string;
  questions: {
    section: string;
    /** The CHAPTER. Canonical join key against a deck's subtopic. */
    topic: string | null;
    subtopic: string;
    difficulty: string;
  } | null;
  /** Null on rows written before the column existed; see scoreEstimate. */
  is_first_attempt?: boolean | null;
}

/** A deck IS a subtopic in the flashcard library: one deck per subtopic. */
interface DeckMeta {
  id: string;
  section: string | null;
  topic: string | null;
  subtopic: string | null;
  title: string;
}

interface DailyActivity {
  activity_date: string;
  questions_completed: number;
}

type Period = "7d" | "30d" | "all" | "custom";

/**
 * Questions a week needs before it appears on the trend.
 *
 * One constant, used by the series, the per-section split inside a tooltip and
 * the caption that tells the student about the exclusion, so the three cannot
 * drift into describing different charts.
 */
const MIN_WEEK_QUESTIONS = 5;

interface ChartWeek {
  key: string;
  label: string;
  total: number;
  correct: number;
  accuracy: number;
  /** 0-100, left to right. */
  xPct: number;
  sections: { section: string; label: string; total: number; accuracy: number }[];
}

const SECTION_LABELS: Record<string, string> = {
  bio_biochem: "Biology & Biochemistry",
  chem_phys: "Physical Sciences",
  psych_soc: "Behavioral Sciences",
  cars: "CARS (Reading)",
};

/* ─────────── Helpers ─────────── */


/**
 * Lower bound of the Wilson score interval for a proportion.
 *
 * Ranking subtopics by raw accuracy is wrong when the counts differ. A student
 * who got 1 of 3 wrong in a topic they barely touched would outrank a topic
 * they have failed 200 times, and the advice would send them at the noise. The
 * Wilson lower bound asks "how bad could this plausibly be, given how little we
 * have seen", so a small sample cannot jump the queue on the strength of a
 * couple of unlucky cards.
 */
function wilsonLowerBound(passed: number, total: number, z = 1.96): number {
  if (total <= 0) return 0;
  const p = passed / total;
  const denom = 1 + (z * z) / total;
  const centre = p + (z * z) / (2 * total);
  const margin = z * Math.sqrt((p * (1 - p) + (z * z) / (4 * total)) / total);
  return (centre - margin) / denom;
}

/**
 * How far below your own recall a subtopic has to sit before it is called out.
 *
 * The delta itself is never SHOWN. It was displayed as "-57 pts" and on an MCAT
 * product "points" means scaled score points, 472 to 528, so a student could
 * read a topic delta as a score. It also said the same thing three times on one
 * row, next to the percentage, the raw tally and a pill that exists because of
 * it. The bands below still carry the comparison; the subtitle names it.
 *
 * Bands are RELATIVE, not absolute. A 61% subtopic is strong for a student
 * averaging 57% and mediocre for one averaging 80%, and the question this panel
 * answers is "where should I spend my time", which is a question about your own
 * distribution rather than about a fixed pass mark.
 */
/**
 * Display names for FLASHCARD deck sections.
 *
 * Separate from SECTION_LABELS, which covers the question bank and uses an
 * entirely different taxonomy: "bio_biochem" and "chem_phys" there against
 * "biology", "biochemistry", "chemistry" and "organic_chemistry" here. Reusing
 * that map left seven of the eight flashcard sections falling through to their
 * raw slug, so the panel read "organic chemistry" and "biochemistry" in
 * lowercase.
 *
 * The deck `topic` column cannot stand in for this: biology spans two topics
 * ("Molecular and Cellular Biology" and "Body Systems"), and psych_soc is
 * recorded inconsistently as both "Psych / Soc" and "Psych/Soc".
 */
const FLASH_SECTION_LABELS: Record<string, string> = {
  biology: "Biology",
  biochemistry: "Biochemistry",
  chemistry: "General Chemistry",
  organic_chemistry: "Organic Chemistry",
  physics: "Physics",
  psych_soc: "Behavioral Sciences",
  scientific_reasoning: "Scientific Reasoning",
};

/** Last resort for a section slug nobody has named yet. */
function flashSectionLabel(section: string): string {
  return (
    FLASH_SECTION_LABELS[section] ||
    section
      .replace(/_/g, " ")
      .replace(/\b\w/g, (c) => c.toUpperCase())
  );
}

function buildSvgPath(points: [number, number][]): string {
  if (points.length === 0) return "";
  if (points.length === 1) return `M${points[0][0]},${points[0][1]}`;
  let d = `M${points[0][0]},${points[0][1]}`;
  for (let i = 1; i < points.length; i++) {
    const [x0, y0] = points[i - 1];
    const [x1, y1] = points[i];
    const cpx = (x0 + x1) / 2;
    d += ` C${cpx},${y0} ${cpx},${y1} ${x1},${y1}`;
  }
  return d;
}

function buildAreaPath(points: [number, number][], height: number): string {
  if (points.length === 0) return "";
  const line = buildSvgPath(points);
  const last = points[points.length - 1];
  const first = points[0];
  return `${line} L${last[0]},${height} L${first[0]},${height} Z`;
}

function filterByPeriod(
  attempts: Attempt[],
  period: Period,
  customFrom?: string,
  customTo?: string
): Attempt[] {
  if (period === "custom" && customFrom && customTo) {
    const from = new Date(customFrom + "T00:00:00");
    const to = new Date(customTo + "T23:59:59");
    return attempts.filter((a) => {
      const d = new Date(a.created_at);
      return d >= from && d <= to;
    });
  }
  if (period === "all") return attempts;
  const now = new Date();
  const cutoff = new Date(now);
  cutoff.setDate(now.getDate() - (period === "7d" ? 7 : 30));
  return attempts.filter((a) => new Date(a.created_at) >= cutoff);
}

/* ─────────── Donut Ring ─────────── */

/* ─── Performance over time ───────────────────────────────────────────────
 *
 * TWO MEASURES, ONE CALENDAR. Question accuracy answers "what can I apply".
 * First-look recall answers "what do I remember". Apart, each hides the
 * question the student actually needs: is recall climbing without transferring
 * to questions, or is application improving on memory that is still weak?
 *
 * BOTH ARE GENUINE PERCENTAGES, which is the only reason one 0-100% axis is
 * honest here. Neither is computed in this file: the question side comes from
 * dailySeries.ts and the recall side from the aggregate endpoint, which is fed
 * by the FSRS grades. The chart draws; it does not decide.
 *
 * ONE POINTER MODEL FOR MOUSE AND FINGER. Pointer events carry both, so a
 * cursor gliding and a finger dragging run the same path. The nearest measured
 * bucket to the cursor's x is selected, so the whole column is a target and
 * nobody has to hit a three-pixel dot. touch-action: pan-y keeps a vertical
 * swipe scrolling the page.
 *
 * COLOUR IS NEVER THE ONLY SIGNAL. Recall is dashed as well as gold, so the
 * two lines stay apart for a colour-blind reader and in a grey print.
 * ─────────────────────────────────────────────────────────────────────── */

type ChartMode = "compare" | "questions" | "flashcards";

const Q_COLOR = "var(--color-prax-green)";
const F_COLOR = "var(--color-prax-gold)";

function PerformanceOverTime({
  series,
  periodLabel,
  mode,
  onModeChange,
}: {
  series: CombinedSeries;
  periodLabel: string;
  mode: ChartMode;
  onModeChange: (m: ChartMode) => void;
}) {
  const [active, setActive] = useState<number | null>(null);
  const [dragging, setDragging] = useState(false);
  const wrapRef = useRef<HTMLDivElement | null>(null);

  const showQ = mode === "compare" || mode === "questions";
  const showF = mode === "compare" || mode === "flashcards";

  const X0 = 0, X1 = 1000, Y0 = 20, Y1 = 280;
  const yFor = (v: number) => Y1 - (v / 100) * (Y1 - Y0);
  const xFor = (i: number) =>
    series.points.length === 1
      ? (X0 + X1) / 2
      : X0 + (i / (series.points.length - 1)) * (X1 - X0);

  // Only buckets visible in the current mode can be selected: snapping to a
  // point the student cannot see would open a panel about nothing.
  const selectable = useMemo(
    () =>
      series.points
        .map((p, i) =>
          (showQ && p.questions.value !== null) || (showF && p.flashcards.value !== null) ? i : -1,
        )
        .filter((i) => i >= 0),
    [series.points, showQ, showF],
  );

  const selectNearest = useCallback(
    (clientX: number) => {
      const el = wrapRef.current;
      if (!el || selectable.length === 0) return;
      const r = el.getBoundingClientRect();
      const ratio = Math.min(1, Math.max(0, (clientX - r.left) / r.width));
      const targetX = X0 + ratio * (X1 - X0);
      let best = selectable[0];
      let bestD = Infinity;
      for (const i of selectable) {
        const d = Math.abs(xFor(i) - targetX);
        if (d < bestD) { bestD = d; best = i; }
      }
      setActive(best);
    },
    [selectable, series.points.length],
  );

  const step = useCallback(
    (dir: number) => {
      if (selectable.length === 0) return;
      const at = active === null ? -1 : selectable.indexOf(active);
      const next = at < 0 ? (dir > 0 ? 0 : selectable.length - 1) : at + dir;
      if (next >= 0 && next < selectable.length) setActive(selectable[next]);
    },
    [active, selectable],
  );

  // The note below the chart explains bridges, so it appears only when one is
  // actually drawn. A chart with no gaps should not carry a caption about gaps.
  const bridged = useMemo(
    () => ({
      questions: bridgesFor(series.points, "questions").length > 0,
      flashcards: bridgesFor(series.points, "flashcards").length > 0,
      quietQuestions: quietCount(series.points, "questions"),
      quietFlashcards: quietCount(series.points, "flashcards"),
    }),
    [series.points],
  );
  const showBridgeNote = (showQ && bridged.questions) || (showF && bridged.flashcards);

  const point = active !== null ? series.points[active] : null;
  const grainWord =
    series.granularity === "day" ? "" : series.granularity === "week" ? "Week of " : "";

  // ── Observed segments, and the joins between them ───────────────────────
  //
  // A GAP CANNOT BORROW THE FLASHCARD SERIES' DASHES. First-look recall is
  // already drawn dashed, which is how a reader who cannot separate the two
  // colours tells the series apart. Spending that same signal on "no data"
  // would make a dashed flashcard line ambiguous with a bridge.
  //
  // So a bridge is distinguished three other ways at once, none of which the
  // series identity is using: it is faint, it is thin, and it is STRAIGHT
  // while every observed segment curves. Straightness is the strongest of the
  // three, because it is the one thing real data never looks like here.
  const line = (modality: "questions" | "flashcards", color: string, dashed: boolean) => {
    const runs = runsFor(series.points, modality);
    const bridges = bridgesFor(series.points, modality);
    return (
      <g key={modality}>
        {bridges.map((b) => {
          // THE MIDDLE OF A BRIDGE FADES OUT. A join drawn at one flat opacity
          // is fine over a weekend and wrong over a month: on a real account
          // with questions on two days out of thirty, it stretched the width of
          // the chart at a near constant height and read as "accuracy held at
          // 55% all month", which is the one thing a gap must never say.
          //
          // Fading the centre leaves the ends attached, so the eye still tracks
          // one history, while the trail visibly goes cold where nothing was
          // measured. Long gaps fade harder than short ones because they are
          // less known, not because they are less important.
          const id = `bridge-${modality}-${b.fromIndex}`;
          const x1 = xFor(b.fromIndex);
          const x2 = xFor(b.toIndex);
          const centre = Math.max(0.05, 0.4 - 0.04 * b.missing);
          return (
            <g key={id}>
              <defs>
                <linearGradient id={id} gradientUnits="userSpaceOnUse" x1={x1} y1={0} x2={x2} y2={0}>
                  <stop offset="0%" stopColor={color} stopOpacity={0.55} />
                  <stop offset="50%" stopColor={color} stopOpacity={centre} />
                  <stop offset="100%" stopColor={color} stopOpacity={0.55} />
                </linearGradient>
              </defs>
              <path
                d={`M${x1},${yFor(b.fromValue)} L${x2},${yFor(b.toValue)}`}
                fill="none"
                stroke={`url(#${id})`}
                strokeWidth={1.25}
                strokeDasharray="1 6"
                strokeLinecap="round"
                vectorEffect="non-scaling-stroke"
              />
            </g>
          );
        })}
        {runs.map((run, i) => (
          <g key={`${modality}-${i}`}>
            <path
              d={buildSvgPath(run.map((r) => [xFor(r.index), yFor(r.value)]) as [number, number][])}
              fill="none"
              stroke={color}
              strokeWidth={2}
              strokeDasharray={dashed ? "5 4" : undefined}
              strokeLinecap="round"
              vectorEffect="non-scaling-stroke"
            />
            {run.map((r) => {
              const m = series.points[r.index][modality];
              const thin = m.evidence === "LIMITED";
              return (
                <circle
                  key={r.index}
                  cx={xFor(r.index)}
                  cy={yFor(r.value)}
                  r={thin ? 2.5 : 3.5}
                  fill={thin ? "var(--color-prax-cream)" : color}
                  stroke={color}
                  strokeWidth={thin ? 1.5 : 0}
                  vectorEffect="non-scaling-stroke"
                  opacity={active === null || active === r.index ? 1 : 0.4}
                />
              );
            })}
          </g>
        ))}
      </g>
    );
  };

  return (
    <div>
      {/* ── Mode toggle ─────────────────────────────────────────────── */}
      <div
        className="flex items-center p-1 rounded-full gap-1 mb-4 self-start"
        role="radiogroup"
        aria-label="Which series to show"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
          width: "fit-content",
        }}
      >
        {([
          ["compare", "Compare"],
          ["questions", "Questions"],
          ["flashcards", "Flashcards"],
        ] as [ChartMode, string][]).map(([value, label]) => (
          <button
            key={value}
            role="radio"
            aria-checked={mode === value}
            onClick={() => onModeChange(value)}
            className="px-3.5 py-1.5 font-semibold uppercase rounded-full transition-all"
            style={{
              fontSize: 10,
              letterSpacing: "0.16em",
              background: mode === value ? "var(--color-prax-green)" : "transparent",
              color: mode === value ? "var(--color-prax-cream)" : "var(--color-prax-ink-mute)",
              cursor: "pointer",
              border: 0,
            }}
          >
            {label}
          </button>
        ))}
      </div>

      <div className="flex gap-3">
        <div
          className="flex flex-col justify-between shrink-0 w-8 text-right"
          style={{ height: 220 }}
        >
          {["100%", "75%", "50%", "25%", "0%"].map((l) => (
            <span
              key={l}
              style={{
                fontSize: 9,
                fontWeight: 600,
                letterSpacing: "0.1em",
                color: "var(--color-prax-ink-mute)",
                fontVariantNumeric: "tabular-nums",
                lineHeight: 1,
              }}
            >
              {l}
            </span>
          ))}
        </div>

        <div className="flex-1 min-w-0">
          <div
            ref={wrapRef}
            role="group"
            tabIndex={0}
            aria-label={`Performance by ${series.granularity}. Left and right arrows step through, Escape clears.`}
            onPointerDown={(e) => {
              try {
                (e.target as Element).setPointerCapture?.(e.pointerId);
              } catch {
                // Not capturable; dragging still works inside the element.
              }
              setDragging(true);
              selectNearest(e.clientX);
            }}
            onPointerMove={(e) => {
              if (e.pointerType === "mouse" || dragging) selectNearest(e.clientX);
            }}
            onPointerUp={() => setDragging(false)}
            onPointerCancel={() => setDragging(false)}
            onPointerLeave={() => {
              if (!dragging) setActive(null);
            }}
            onKeyDown={(e) => {
              if (e.key === "ArrowRight") { e.preventDefault(); step(1); }
              else if (e.key === "ArrowLeft") { e.preventDefault(); step(-1); }
              else if (e.key === "Escape") setActive(null);
            }}
            className="relative"
            style={{ height: 220, touchAction: "pan-y", cursor: "crosshair" }}
          >
            <svg
              className="w-full overflow-visible"
              viewBox="0 0 1000 300"
              preserveAspectRatio="none"
              style={{ height: 220 }}
              aria-hidden="true"
            >
              {[20, 85, 150, 215, 280].map((y) => (
                <line
                  key={y}
                  x1={0} y1={y} x2={1000} y2={y}
                  stroke="var(--color-prax-cream-border)"
                  strokeWidth={1}
                  vectorEffect="non-scaling-stroke"
                />
              ))}

              {showF && line("flashcards", F_COLOR, true)}
              {showQ && line("questions", Q_COLOR, false)}

              {active !== null && (
                <line
                  x1={xFor(active)} y1={Y0 - 10} x2={xFor(active)} y2={300}
                  stroke="var(--color-prax-green)"
                  strokeWidth={1}
                  strokeDasharray="3 3"
                  opacity={0.45}
                  vectorEffect="non-scaling-stroke"
                />
              )}
              {active !== null && showQ && point?.questions.value !== null && (
                <circle
                  cx={xFor(active)} cy={yFor(point!.questions.value!)} r={6}
                  fill={Q_COLOR} stroke="var(--color-prax-cream)" strokeWidth={3}
                  vectorEffect="non-scaling-stroke"
                />
              )}
              {active !== null && showF && point?.flashcards.value !== null && (
                <circle
                  cx={xFor(active)} cy={yFor(point!.flashcards.value!)} r={6}
                  fill={F_COLOR} stroke="var(--color-prax-cream)" strokeWidth={3}
                  vectorEffect="non-scaling-stroke"
                />
              )}
            </svg>

            {point && (
              <div
                role="status"
                className="absolute rounded-xl px-3.5 py-3 pointer-events-none"
                style={{
                  left: `${point.xPct}%`,
                  transform: `translateX(${
                    point.xPct > 70 ? "-95%" : point.xPct < 30 ? "-5%" : "-50%"
                  })`,
                  top: 6,
                  zIndex: 10,
                  minWidth: 186,
                  background: "var(--color-prax-green)",
                  color: "var(--color-prax-cream)",
                  boxShadow: "0 10px 30px -12px rgba(3,56,48,0.5)",
                }}
              >
                <div
                  style={{
                    fontSize: 9.5,
                    letterSpacing: "0.16em",
                    textTransform: "uppercase",
                    fontWeight: 600,
                    color: "rgba(246,244,227,0.6)",
                  }}
                >
                  {grainWord}
                  {point.label}
                </div>

                {showQ && (
                  <TooltipRow
                    label="Question accuracy"
                    m={point.questions}
                    unit="correct"
                    absent="No question activity"
                    dot={Q_COLOR}
                  />
                )}
                {showF && (
                  <TooltipRow
                    label="First-look recall"
                    m={point.flashcards}
                    unit="recalled"
                    absent="No flashcard activity"
                    dot={F_COLOR}
                  />
                )}
              </div>
            )}
          </div>

          {/* ── Axis ends, then the legend ─────────────────────────────
              TWO ROWS, NOT ONE. Sharing a justify-between row with the legend
              pushed both date labels into the same left-hand group, so a
              thirty-day span read as "Aug 17 Sep 16" side by side instead of
              marking the ends of the axis. The dates own their row now and
              span the plot they describe. */}
          <div
            className="flex justify-between mt-3"
            style={{
              fontSize: 9.5,
              fontWeight: 600,
              letterSpacing: "0.16em",
              textTransform: "uppercase",
              color: "var(--color-prax-ink-mute)",
            }}
          >
            <span>{series.points[0]?.label}</span>
            <span>{series.points[series.points.length - 1]?.label}</span>
          </div>

          {/* The quiet-day count used to sit in the subtitle, where it read as a
              complaint about the student every time the page loaded. It belongs
              next to the thing it explains, said once and quietly. */}
          <div className="flex justify-between items-center mt-2.5 gap-3 flex-wrap">
            {showBridgeNote ? (
              <>
                <p className="sr-only">
                  {showQ
                    ? `${bridged.quietQuestions} ${series.granularity}s with no question activity. `
                    : ""}
                  {showF
                    ? `${bridged.quietFlashcards} ${series.granularity}s with no flashcard activity. `
                    : ""}
                  Faint joins connect observed days only. No values are estimated.
                </p>
                <span
                  aria-hidden="true"
                  style={{
                    fontSize: 9.5,
                    letterSpacing: "0.04em",
                    color: "var(--color-prax-ink-mute)",
                    fontStyle: "italic",
                  }}
                >
                  Faint joins span days with no activity. Nothing is estimated.
                </span>
              </>
            ) : (
              <span />
            )}
            {/* Clicking a legend entry isolates that series, which is the same
                thing the toggle above does. Two routes to one behaviour, since
                a legend is where a reader's hand already is. */}
            <div className="flex items-center gap-4">
              <LegendItem
                color={Q_COLOR}
                label="Question accuracy"
                on={showQ}
                dashed={false}
                onClick={() => onModeChange(mode === "questions" ? "compare" : "questions")}
              />
              <LegendItem
                color={F_COLOR}
                label="First-look recall"
                on={showF}
                dashed
                onClick={() => onModeChange(mode === "flashcards" ? "compare" : "flashcards")}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

/** One measure inside the tooltip, or an honest absence. */
function TooltipRow({
  label,
  m,
  unit,
  absent,
  dot,
}: {
  label: string;
  m: ModalityPoint;
  unit: string;
  absent: string;
  dot: string;
}) {
  return (
    <div className="mt-2.5">
      <div className="flex items-center gap-1.5">
        <span
          aria-hidden="true"
          style={{ width: 6, height: 6, borderRadius: 999, background: dot, display: "inline-block" }}
        />
        <span
          style={{
            fontSize: 9.5,
            letterSpacing: "0.14em",
            textTransform: "uppercase",
            fontWeight: 600,
            color: "rgba(246,244,227,0.6)",
          }}
        >
          {label}
        </span>
      </div>
      {m.value === null ? (
        // NOT 0%. A day with no activity has no rate, and printing a zero
        // would draw a collapse the student never had.
        <div style={{ fontSize: 12.5, color: "rgba(246,244,227,0.6)", marginTop: 2 }}>
          {absent}
        </div>
      ) : (
        <>
          <div className="flex items-baseline gap-2" style={{ marginTop: 1 }}>
            <span
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                lineHeight: 1.1,
                fontVariantNumeric: "tabular-nums",
              }}
            >
              {m.value}%
            </span>
            <span
              style={{
                fontSize: 11.5,
                color: "rgba(246,244,227,0.72)",
                fontVariantNumeric: "tabular-nums",
              }}
            >
              {m.numerator} of {m.denominator} {unit}
            </span>
          </div>
          {m.evidence === "LIMITED" && (
            <div
              style={{
                fontSize: 9.5,
                letterSpacing: "0.14em",
                textTransform: "uppercase",
                fontWeight: 600,
                color: "var(--color-prax-gold-soft)",
                marginTop: 2,
              }}
            >
              Limited evidence
            </div>
          )}
        </>
      )}
    </div>
  );
}

function LegendItem({
  color,
  label,
  on,
  dashed,
  onClick,
}: {
  color: string;
  label: string;
  on: boolean;
  dashed: boolean;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      aria-pressed={on}
      className="flex items-center gap-2"
      style={{ background: "none", border: 0, cursor: "pointer", opacity: on ? 1 : 0.4 }}
    >
      {/* The dash pattern repeats the line's own, so the legend distinguishes
          the series the same way the chart does rather than by colour alone. */}
      <span
        aria-hidden="true"
        style={{
          width: 16,
          height: 0,
          borderTop: `2px ${dashed ? "dashed" : "solid"} ${color}`,
          display: "inline-block",
        }}
      />
      <span
        style={{
          fontSize: 9.5,
          fontWeight: 600,
          letterSpacing: "0.14em",
          textTransform: "uppercase",
          color: "var(--color-prax-ink-soft)",
        }}
      >
        {label}
      </span>
    </button>
  );
}


/** The row-level action pill. One definition, so both actions match. */
const rowCta: React.CSSProperties = {
  borderRadius: 999,
  padding: "6px 12px",
  border: "1px solid var(--color-prax-cream-border)",
  color: "var(--color-prax-green)",
  fontSize: 9,
  letterSpacing: "0.13em",
  textTransform: "uppercase",
  fontWeight: 600,
};

/** Tone for a cross-modality state, reusing the existing band palette. */
const STATE_TONE: Record<string, { bg: string; fg: string }> = {
  BROAD_WEAKNESS: { bg: "var(--color-prax-gold)", fg: "var(--color-prax-cream)" },
  APPLICATION_GAP: { bg: "var(--color-prax-gold-soft)", fg: "var(--color-prax-ink-soft)" },
  MEMORY_GAP: { bg: "var(--color-prax-gold-soft)", fg: "var(--color-prax-ink-soft)" },
  BALANCED_STRENGTH: { bg: "var(--color-prax-green-tint)", fg: "var(--color-prax-green)" },
  LIMITED_EVIDENCE: { bg: "var(--color-prax-cream-deep)", fg: "var(--color-prax-ink-mute)" },
  NO_EVIDENCE: { bg: "var(--color-prax-cream-deep)", fg: "var(--color-prax-ink-mute)" },
};

/**
 * One topic, collapsed to its two numbers and expandable to the reasoning.
 *
 * A button rather than a div, so it is reachable by keyboard and announces its
 * own expanded state. The chevron is decorative and hidden from screen readers;
 * the accessible name carries the topic and both measures.
 */
function TopicRow({
  topic,
}: {
  topic: TopicIntelligence & { deckId: string | null };
}) {
  const [open, setOpen] = useState(false);
  const tone = STATE_TONE[topic.state] ?? STATE_TONE.LIMITED_EVIDENCE;

  return (
    <div style={{ borderBottom: "1px solid var(--color-prax-cream-border)" }}>
      <button
        onClick={() => setOpen((v) => !v)}
        aria-expanded={open}
        className="w-full flex items-center gap-3 py-3.5 text-left"
        style={{ background: "none", border: 0 }}
      >
        <span
          aria-hidden="true"
          className="shrink-0"
          style={{
            color: "var(--color-prax-ink-mute)",
            fontSize: 10,
            transform: open ? "rotate(90deg)" : "none",
            transition: "transform 160ms ease",
          }}
        >
          ▶
        </span>

        <span
          className="flex-1 min-w-0 truncate"
          style={{ fontSize: 14.5, color: "var(--color-prax-ink)" }}
        >
          {topic.label}
        </span>

        {/* Both measures, each with the evidence behind it. A percentage
            without its denominator is how a 2-of-3 topic starts looking like a
            strength. */}
        <span className="shrink-0 hidden sm:flex items-baseline gap-4">
          <span style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}>
            <span style={{ fontVariantNumeric: "tabular-nums" }}>
              {topic.application.pct}%
            </span>{" "}
            <span style={{ color: "var(--color-prax-ink-mute)" }}>
              apply ({topic.application.trials})
            </span>
          </span>
          <span style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}>
            <span style={{ fontVariantNumeric: "tabular-nums" }}>
              {topic.memory.pct}%
            </span>{" "}
            <span style={{ color: "var(--color-prax-ink-mute)" }}>
              recall ({topic.memory.trials})
            </span>
          </span>
        </span>

        <span
          className="shrink-0 rounded-full px-2.5 py-1"
          style={{
            background: tone.bg,
            color: tone.fg,
            fontSize: 9,
            letterSpacing: "0.13em",
            textTransform: "uppercase",
            fontWeight: 600,
            minWidth: 96,
            textAlign: "center",
          }}
        >
          {STATE_LABELS[topic.state]}
        </span>
      </button>

      {open && (
        <div className="pb-4 pl-6 pr-1">
          {/* On a narrow screen the two measures do not fit in the row, so
              they appear here instead of being dropped. */}
          <div
            className="flex sm:hidden gap-4 mb-2"
            style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}
          >
            <span>
              {topic.application.pct}% apply ({topic.application.trials})
            </span>
            <span>
              {topic.memory.pct}% recall ({topic.memory.trials})
            </span>
          </div>

          <p
            className="m-0"
            style={{
              fontSize: 13.5,
              lineHeight: 1.6,
              color: "var(--color-prax-ink-soft)",
              maxWidth: "58ch",
            }}
          >
            {topic.interpretation}
          </p>

          <div className="flex items-center gap-3 mt-3 flex-wrap">
            <SmallCaps>{EVIDENCE_LABELS[topic.evidence]}</SmallCaps>

            {/* BOTH ACTIONS NOW LAND SOMEWHERE REAL.
                A deck is a route, so Review opens exactly this topic's cards.
                Practice carries the canonical topic key to the session builder,
                which has always been able to filter on topic and simply had no
                way in; it opens pre-filled rather than launching, so the
                student sees what was chosen before starting. */}
            {topic.action?.kind === "REVIEW" && topic.deckId && (
              <Link href={`/dashboard/flashcards/${topic.deckId}`} style={rowCta}>
                Review cards
              </Link>
            )}
            {topic.action?.kind === "PRACTICE" && topic.application.trials > 0 && (
              <Link
                href={`/dashboard/practice?topic=${encodeURIComponent(topic.key)}`}
                style={rowCta}
              >
                Practice questions
              </Link>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

function DonutRing({ pct, label }: { pct: number; label: string }) {
  const r = 36;
  const circ = 2 * Math.PI * r;
  const offset = circ * (1 - pct / 100);
  return (
    <div className="flex flex-col items-center gap-3">
      <div className="relative w-24 h-24">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 88 88">
          <circle
            cx="44"
            cy="44"
            r={r}
            fill="none"
            stroke="var(--color-prax-cream-border)"
            strokeWidth="8"
          />
          <circle
            cx="44"
            cy="44"
            r={r}
            fill="none"
            stroke="var(--color-prax-green)"
            strokeWidth="8"
            strokeLinecap="round"
            strokeDasharray={circ}
            strokeDashoffset={offset}
            style={{ transition: "stroke-dashoffset 1s ease-out" }}
          />
        </svg>
        <span
          className="absolute inset-0 flex items-center justify-center font-medium"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 24,
            color: "var(--color-prax-green)",
            fontVariantNumeric: "tabular-nums lining-nums",
          }}
        >
          {pct > 0 ? `${pct}%` : "—"}
        </span>
      </div>
      <SmallCaps>{label}</SmallCaps>
    </div>
  );
}

/* ─────────── Performance panel ─────────── */

function PerfPanel({
  title,
  period,
  pct,
  stats,
  breakdownLabel,
  bars,
  empty,
  emptyText,
}: {
  title: string;
  period: string;
  pct: number;
  stats: { value: string; label: string }[];
  breakdownLabel: string;
  /**
   * THE DENOMINATOR IS NOT OPTIONAL, and this component previously had none.
   *
   * Two panels drew the same bar from different quantities. For difficulty,
   * `count` was correct answers and `pct` was accuracy, so it read "5 · 42%".
   * For card grades, `count` was reviews and `pct` was that grade's share, so
   * it read "40 · 12%". Identical shape, opposite meanings, and in both cases
   * the number the percentage was taken over was invisible: 5 of 12 and 5 of
   * 500 looked the same.
   *
   * `unit` names what the percentage is OF, so the two panels can no longer be
   * read as saying the same kind of thing.
   */
  bars: {
    label: string;
    count: number;
    denominator: number;
    pct: number;
    unit: string;
    color: string;
  }[];
  empty: boolean;
  emptyText: string;
}) {
  return (
    <PraxCard variant="secondary" className="flex flex-col">
      <div className="flex items-center justify-between mb-5">
        <SmallCaps>{title}</SmallCaps>
        <SmallCaps style={{ color: "var(--color-prax-ink-soft)" }}>
          {period}
        </SmallCaps>
      </div>
      {empty ? (
        <div
          className="italic text-center py-8"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 13,
            color: "var(--color-prax-ink-mute)",
          }}
        >
          {emptyText}
        </div>
      ) : (
        <>
          <div className="flex items-center gap-5">
            <DonutRing pct={pct} label="First-Try" />
            <div className="flex-1 space-y-3">
              {stats.map((s) => (
                <div key={s.label}>
                  <div
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 20,
                      lineHeight: 1,
                      color: "var(--color-prax-green)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {s.value}
                  </div>
                  <SmallCaps style={{ marginTop: 3 }}>{s.label}</SmallCaps>
                </div>
              ))}
            </div>
          </div>
          <div
            className="mt-5 pt-5"
            style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
          >
            <SmallCaps
              style={{
                color: "var(--color-prax-ink-soft)",
                marginBottom: 14,
                display: "block",
              }}
            >
              {breakdownLabel}
            </SmallCaps>
            <div className="space-y-4">
              {bars.map((b) => (
                <div key={b.label}>
                  <div className="flex justify-between items-baseline mb-1.5">
                    <div
                      style={{
                        fontFamily: "var(--font-prax-sans)",
                        fontSize: 12.5,
                        fontWeight: 500,
                        color: "var(--color-prax-ink)",
                      }}
                    >
                      {b.label}
                    </div>
                    <div
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 16,
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {b.count.toLocaleString()}
                      <span
                        style={{
                          fontSize: 12,
                          color: "var(--color-prax-ink-mute)",
                        }}
                      >
                        {" "}
                        / {b.denominator.toLocaleString()} · {b.pct}% {b.unit}
                      </span>
                    </div>
                  </div>
                  <div
                    className="rounded-full overflow-hidden"
                    style={{
                      height: 5,
                      background: "var(--color-prax-cream-card)",
                    }}
                  >
                    <div
                      className="h-full rounded-full transition-all duration-1000"
                      style={{ width: `${b.pct}%`, background: b.color }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </PraxCard>
  );
}

/* ─────────── Page ─────────── */

export default function AnalyticsPage() {
  const { user } = useDashboard();
  const [allAttempts, setAllAttempts] = useState<Attempt[]>([]);
  const [, setActivity] = useState<DailyActivity[]>([]);
  const [, setLessonsCompleted] = useState(0);
  const [loading, setLoading] = useState(true);
  const [flashAgg, setFlashAgg] = useState<FlashcardAggregate | null>(null);
  /**
   * The same aggregate, filtered to the chart's subject.
   *
   * SEPARATE FROM flashAgg ON PURPOSE. The headline First-Look Recall card is a
   * range figure across every subject; the chart's recall line has to follow
   * the subject dropdown. Sharing one fetch meant one of them was always
   * wrong, and the way it was wrong was invisible: picking Chemical & Physical
   * filtered the question line and left the recall line showing everything, so
   * the chart looked like a comparison and was not one.
   */
  const [flashSeriesAgg, setFlashSeriesAgg] = useState<FlashcardAggregate | null>(null);
  const [progressSignals, setProgressSignals] = useState<ProgressSignal[]>([]);
  const [progressLoading, setProgressLoading] = useState(true);
  const [period, setPeriod] = useState<Period>("30d");
  const [chartSection, setChartSection] = useState<string>("all");
  /** Which series are drawn. Kept here so a mode change cannot touch the range. */
  const [chartMode, setChartMode] = useState<ChartMode>("compare");
  /** Index of the week whose detail panel is open, or null. */
  const [activeWeek, setActiveWeek] = useState<number | null>(null);
  const [sectionDropdownOpen, setSectionDropdownOpen] = useState(false);
  // Flashcard taxonomy. Fetched as two small lookups rather than joined onto
  // every review row: the card list is ~4k rows and the deck list ~70, against
  // tens of thousands of reviews that would each drag a copy of the taxonomy.
  const [openQuestionSections, setOpenQuestionSections] = useState<Set<string>>(
    new Set()
  );
  const [openFlashSections, setOpenFlashSections] = useState<Set<string>>(
    new Set()
  );
  const [deckMeta, setDeckMeta] = useState<Map<string, DeckMeta>>(new Map());
  const [customFrom, setCustomFrom] = useState("");
  const [customTo, setCustomTo] = useState("");

  const [hasDailyReport, setHasDailyReport] = useState(false);
  const [hasWeeklyReport, setHasWeeklyReport] = useState(false);

  useEffect(() => {
    async function load() {
      const [{ data: attempts }, { data: act }, { data: progress }] =
        await Promise.all([
        supabase
          .from("question_attempts")
          .select(
            "is_correct, created_at, question_id, is_first_attempt, questions(section, topic, subtopic, difficulty)"
          )
          .eq("user_id", user.id),
        supabase
          .from("daily_activity")
          .select("activity_date, questions_completed")
          .eq("user_id", user.id)
          .order("activity_date"),
        supabase
          .from("lesson_progress")
          .select("id")
          .eq("user_id", user.id)
          .eq("completed", true),
      ]);

      // Deck metadata only: 73 rows, shared by every student, and enough to
      // turn a canonical topic key back into a deck route.
      //
      // The whole flashcards table used to be paged in here to build a
      // card-to-deck map, purely so the browser could attribute reviews to
      // topics. The aggregate endpoint does that attribution server-side now,
      // so neither the cards nor the reviews need to travel.
      const { data: deckRows } = await supabase
        .from("flashcard_decks")
        .select("id, section, topic, subtopic, title");
      setDeckMeta(
        new Map(
          ((deckRows as DeckMeta[]) || []).map((d) => [d.id, d])
        )
      );

      setAllAttempts((attempts as unknown as Attempt[]) || []);
      setActivity(act || []);
      setLessonsCompleted(progress?.length || 0);

      setLoading(false);
    }
    load();
  }, [user.id]);

  // Check whether saved reports exist (for badge display)
  useEffect(() => {
    async function checkReports() {
      const { data } = await supabase
        .from("performance_reports")
        .select("report_type")
        .eq("user_id", user.id)
        .order("created_at", { ascending: false })
        .limit(10);
      const rows = (data ?? []) as { report_type: string }[];
      setHasDailyReport(rows.some((r) => r.report_type === "daily"));
      setHasWeeklyReport(rows.some((r) => r.report_type === "weekly"));
    }
    checkReports();
  }, [user.id]);

  // ── Derived stats ──
  /**
   * Recent progress from the snapshot system.
   *
   * The same endpoint the dashboard calls, on purpose. Analytics recomputing
   * "topics improved" from raw rows would be a second learner model, and the
   * two surfaces would eventually disagree about the same week.
   *
   * The server does the work: the API reads stored snapshots and deduped
   * events rather than replaying history, so this costs one request rather
   * than a walk over every attempt the student has ever made.
   *
   * Additive. A failure leaves the card in its own empty state instead of
   * breaking the page, because progress is not what this page is for.
   */
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const { data: sessionData } = await supabase.auth.getSession();
        const token = sessionData.session?.access_token;
        if (!token) return;
        const res = await fetch("/api/learner/snapshot", {
          headers: { Authorization: `Bearer ${token}` },
        });
        if (!res.ok) return;
        const body = await res.json();
        if (cancelled || !Array.isArray(body?.progress?.signals)) return;
        setProgressSignals(body.progress.signals as ProgressSignal[]);
      } catch {
        // Leave the empty state in place.
      } finally {
        if (!cancelled) setProgressLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [user.id]);

  const filtered = useMemo(
    () => filterByPeriod(allAttempts, period, customFrom, customTo),
    [allAttempts, period, customFrom, customTo]
  );

  const totalQuestions = filtered.length;
  const totalCorrect = filtered.filter((a) => a.is_correct).length;
  const overallAccuracy =
    totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0;

  /**
   * The score estimate runs on FIRST ATTEMPTS ONLY, which is a different number
   * from the accuracy shown elsewhere on this page.
   *
   * About a quarter of all attempts in the bank are repeats of a question the
   * student had already answered. Those are useful as learning data and useless
   * as evidence of ability, because the answer has already been seen. Counting
   * them inflated the old estimate.
   *
   * Rows written before the is_first_attempt column existed are backfilled, so
   * the fallback here only matters if that migration has not been run yet: in
   * that case every attempt counts, which is the old behaviour.
   */
  const scoreEstimate = useMemo(() => {
    const eligible = allAttempts.filter((a) => a.is_first_attempt !== false);
    const correct = eligible.filter((a) => a.is_correct).length;
    const accuracy =
      eligible.length > 0 ? Math.round((correct / eligible.length) * 100) : 0;
    const sections = new Set(
      eligible.map((a) => a.questions?.section).filter(Boolean) as string[]
    );
    // Breadth, not just volume. 300 questions inside three subtopics is not
    // 300 questions' worth of evidence about a section, and the predictor now
    // moderates its ceiling accordingly. See evidenceStrength.
    const subtopics = new Set(
      eligible.map((a) => a.questions?.subtopic).filter(Boolean) as string[]
    );
    // Full lengths: none exist in the product yet, so this is honestly zero
    // rather than omitted. It starts paying out the day the type ships.
    return estimateScore(accuracy, eligible.length, sections, subtopics, 0);
  }, [allAttempts]);

  // Section stats
  // Difficulty stats
  const diffStats = useMemo(() => {
    const map = new Map<string, { total: number; correct: number }>();
    filtered.forEach((a) => {
      if (!a.questions?.difficulty) return;
      const d = map.get(a.questions.difficulty) || { total: 0, correct: 0 };
      d.total++;
      if (a.is_correct) d.correct++;
      map.set(a.questions.difficulty, d);
    });
    return ["easy", "medium", "hard"].map((k) => {
      const d = map.get(k) || { total: 0, correct: 0 };
      return {
        label: k.charAt(0).toUpperCase() + k.slice(1),
        ...d,
        accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0,
      };
    });
  }, [filtered]);

  // Subtopic stats (weakest first)
  /**
   * The same grouping the flashcard panel uses, applied to practice questions.
   *
   * Sections come from the QUESTION taxonomy (bio_biochem, chem_phys), which is
   * why this reads SECTION_LABELS rather than FLASH_SECTION_LABELS.
   *
   * NOTE ON THE THRESHOLD. Subtopics still enter at 3 attempts, inherited from
   * the card this replaces. That is too few to call anything mastery: going
   * 0 for 3 happens about one time in eight even when you know the material at
   * 50%, and 4 for 4 happens one time in sixteen. On the current data every
   * single subtopic sits at 1 to 5 attempts, so the labels below are describing
   * coin flips. The layout is being fixed first and the threshold deliberately
   * left for later; when it is raised, only MIN_ATTEMPTS needs to change.
   */
  /**
   * Which flashcard subtopics is this student actually weak on?
   *
   * Two decisions worth stating, because both change the answer:
   *
   * 1. ONE ATTEMPT PER BLANK PER DAY. Rating a card "Again" re-queues it inside
   *    the same session, so a card that was struggled with logs several rows.
   *    Counting all of them would score a topic by how stubbornly it was
   *    revisited rather than by how well it is known. Only the first rating of
   *    each blank on each day counts.
   *
   * 2. RANKED BY WILSON LOWER BOUND, not by raw accuracy, so a topic with a
   *    handful of attempts cannot lead the list on a couple of unlucky cards.
   *
   * The figure shown is the student's own accuracy against their own average,
   * because "eleven points below your baseline" is actionable in a way that a
   * bare percentage is not: it separates a topic that is genuinely lagging from
   * one that merely looks low because everything is hard this week.
   */
  /**
   * Canonical topic key to a deck id, so a topic row's Review action has
   * somewhere to go.
   *
   * Built from the deck table, which is 73 rows and shared by every student.
   * The alternative was carrying a deck id on every review, which is how the
   * old code got it and part of why it needed the reviews at all.
   */
  const deckIdByTopic = useMemo(() => {
    const out = new Map<string, string>();
    deckMeta.forEach((d, id) => {
      const key = canonicalTopicKey(d.subtopic);
      if (key && !out.has(key)) out.set(key, id);
    });
    return out;
  }, [deckMeta]);

  /**
   * Recall against application, topic by topic.
   *
   * REPLACES three sections that all answered "where am I weak?" from one
   * modality each: Section Accuracy, Recall by topic, and Topic performance.
   * Separately none of them could tell a student whether a weak topic was weak
   * because they do not remember it or because they remember it and cannot
   * apply it, which are opposite problems with opposite fixes.
   *
   * All of the interpretation lives in lib/analytics/crossModality.ts. Nothing
   * here decides what a state means; this only assembles the two counts and
   * hands them over. The FSRS scheduler stays the source of truth for memory
   * and the learner model for ability.
   */
  const topicIntel = useMemo(() => {
    const inRange = (iso: string): boolean => {
      if (period === "all") return true;
      const d = new Date(iso);
      if (period === "custom") {
        if (!customFrom || !customTo) return true;
        return (
          d >= new Date(customFrom + "T00:00:00") &&
          d <= new Date(customTo + "T23:59:59")
        );
      }
      const days = period === "7d" ? 7 : 30;
      return d >= new Date(Date.now() - days * 86_400_000);
    };

    // ── Application: eligible first attempts, by canonical topic ──────────
    const questions = new Map<string, { successes: number; trials: number; label: string }>();
    allAttempts.forEach((a) => {
      if (a.is_first_attempt === false) return;
      if (!inRange(a.created_at)) return;
      const raw = a.questions?.topic;
      const key = canonicalTopicKey(raw);
      if (!key) return;
      const e = questions.get(key) ?? { successes: 0, trials: 0, label: String(raw) };
      e.trials++;
      if (a.is_correct) e.successes++;
      questions.set(key, e);
    });

    // ── Memory: first-look recall per topic, from the server ────────────
    //
    // This used to walk every review in the browser to rebuild what the
    // aggregate endpoint already computes, which is the same 42,553 rows the
    // First-Look Recall card was downloading. The session-gap rule still
    // applies; it just applies once, on the server, where the rows are.
    const cards = new Map<string, { successes: number; trials: number; deckId: string | null }>();
    for (const t of flashAgg?.byTopic ?? []) {
      cards.set(t.key, {
        successes: t.recalled,
        trials: t.firstLooks,
        // The deck a topic's Review action opens. Resolved from the small deck
        // table the page already holds, not from review rows.
        deckId: deckIdByTopic.get(t.key) ?? null,
      });
    }

    const keys = [...new Set([...questions.keys(), ...cards.keys()])];
    const rows = keys.map((key) => {
      const q = questions.get(key);
      const c = cards.get(key);
      const intel = topicIntelligence(
        key,
        q?.label ?? titleFromKey(key),
        { successes: q?.successes ?? 0, trials: q?.trials ?? 0 },
        { successes: c?.successes ?? 0, trials: c?.trials ?? 0 },
      );
      return { ...intel, deckId: c?.deckId ?? null };
    });

    const MEASURED = new Set([
      "MEMORY_GAP",
      "APPLICATION_GAP",
      "BROAD_WEAKNESS",
      "BALANCED_STRENGTH",
    ]);
    // Weakest application first among the measured, because that is the
    // ordering a student is looking for.
    const measured = rows
      .filter((r) => MEASURED.has(r.state))
      .sort((a, b) => (a.application.lowerBound ?? 1) - (b.application.lowerBound ?? 1));
    const pending = rows.filter((r) => !MEASURED.has(r.state) && r.state !== "NO_EVIDENCE");

    return { measured, pending, total: rows.length };
  }, [allAttempts, flashAgg, deckIdByTopic, period, customFrom, customTo]);

  /**
   * Flashcard figures for the selected range, from the server.
   *
   * THE PAGE USED TO COUNT THESE ITSELF, over every review the student had ever
   * logged. On the largest real account that is 42,553 rows and roughly 3.7 MB
   * of JSON, downloaded so the browser could produce a four-bar chart and two
   * percentages. The endpoint returns about two kilobytes and stays there
   * however long the account lives, because its size is bounded by topics
   * touched rather than reviews logged.
   *
   * Shaped to the old memo's field names, so the cards below did not change.
   * What moved is where the arithmetic happens, not what it says.
   */
  const flashStats = useMemo(
    () => ({
      total: flashAgg?.total ?? 0,
      counts: flashAgg?.counts ?? { again: 0, hard: 0, medium: 0, easy: 0 },
      againCount: flashAgg?.counts.again ?? 0,
      firstTryTotal: flashAgg?.firstLookTotal ?? 0,
      firstTryCorrect: flashAgg?.firstLookCorrect ?? 0,
      firstTryPct:
        flashAgg && flashAgg.firstLookTotal > 0
          ? Math.round((flashAgg.firstLookCorrect / flashAgg.firstLookTotal) * 100)
          : null,
    }),
    [flashAgg],
  );

  // ── Question first-try accuracy (first attempt per question) ──
  const qStats = useMemo(() => {
    const inPeriod = (ms: number): boolean => {
      if (period === "all") return true;
      if (period === "custom") {
        if (!customFrom || !customTo) return true;
        return (
          ms >= new Date(customFrom + "T00:00:00").getTime() &&
          ms <= new Date(customTo + "T23:59:59").getTime()
        );
      }
      const cutoff = new Date();
      cutoff.setDate(cutoff.getDate() - (period === "7d" ? 7 : 30));
      return ms >= cutoff.getTime();
    };
    // Earliest attempt per question over full history; a question's first-try
    // is tallied only if that first attempt falls inside the selected period.
    const firstByQ = new Map<string, { at: number; correct: boolean }>();
    allAttempts.forEach((a) => {
      if (!a.question_id) return;
      const t = new Date(a.created_at).getTime();
      const cur = firstByQ.get(a.question_id);
      if (!cur || t < cur.at)
        firstByQ.set(a.question_id, { at: t, correct: a.is_correct });
    });
    let firstTryTotal = 0;
    let firstTryCorrect = 0;
    firstByQ.forEach((v) => {
      if (!inPeriod(v.at)) return;
      firstTryTotal++;
      if (v.correct) firstTryCorrect++;
    });
    return {
      firstTryTotal,
      firstTryCorrect,
      firstTryPct:
        firstTryTotal > 0
          ? Math.round((firstTryCorrect / firstTryTotal) * 100)
          : null,
    };
  }, [allAttempts, period, customFrom, customTo]);

  /** Attempts in the charted section, to tell "no content" from "not enough". */
  const sectionAttemptCount = useMemo(
    () =>
      chartSection === "all"
        ? allAttempts.length
        : allAttempts.filter((a) => a.questions?.section === chartSection).length,
    [allAttempts, chartSection],
  );

  /**
   * The range actually in force, as two dates.
   *
   * THE TRUST BUG THIS FIXES. Selecting a preset cleared both date inputs, so
   * the page showed "30 DAYS" highlighted next to two empty pickers reading
   * mm/dd/yyyy. Nothing was wrong with the filtering; the controls simply
   * refused to say what they were doing, which is worse, because a student
   * cannot tell a working filter from a broken one.
   *
   * All Time has no start until there is a first attempt, so it shows the real
   * one rather than an invented zero.
   */
  const activeRange = useMemo(() => {
    const iso = (d: Date) => d.toISOString().slice(0, 10);
    const today = iso(new Date());
    if (period === "custom") return { from: customFrom, to: customTo };
    if (period === "7d") return { from: iso(new Date(Date.now() - 7 * 86_400_000)), to: today };
    if (period === "30d") return { from: iso(new Date(Date.now() - 30 * 86_400_000)), to: today };
    const earliest = allAttempts.reduce<string | null>(
      (min, a) => (min === null || a.created_at < min ? a.created_at : min),
      null,
    );
    return { from: earliest ? earliest.slice(0, 10) : "", to: today };
  }, [period, customFrom, customTo, allAttempts]);

  /**
   * Flashcard aggregates for the selected range.
   *
   * REFETCHED WHEN THE RANGE CHANGES, which is the trade this design makes. The
   * alternative was shipping every review once and slicing it in the browser,
   * and that is what cost 3.7 MB. A request per range change is three clicks'
   * worth of traffic against a download that grew with the account forever.
   *
   * The range is sent as instants rather than dates so the server does not have
   * to guess the client's timezone.
   */
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const { data: sessionData } = await supabase.auth.getSession();
        const token = sessionData.session?.access_token;
        if (!token) return;
        const qs = new URLSearchParams();
        if (activeRange.from) qs.set("from", new Date(activeRange.from + "T00:00:00").toISOString());
        if (activeRange.to) qs.set("to", new Date(activeRange.to + "T23:59:59").toISOString());
        const res = await fetch(`/api/analytics/flashcards?${qs}`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        if (!res.ok) return;
        const body = (await res.json()) as FlashcardAggregate;
        if (!cancelled) setFlashAgg(body);
      } catch {
        // The cards render their empty state rather than the page breaking.
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [user.id, activeRange.from, activeRange.to]);

  /**
   * The subject-filtered aggregate that feeds the chart's recall line.
   *
   * Skipped entirely when the filter is "all", because that is exactly what
   * the unfiltered fetch already returned; there is no reason to ask twice for
   * the same rows.
   */
  useEffect(() => {
    if (chartSection === "all") {
      setFlashSeriesAgg(null);
      return;
    }
    let cancelled = false;
    (async () => {
      try {
        const { data: sessionData } = await supabase.auth.getSession();
        const token = sessionData.session?.access_token;
        if (!token) return;
        const qs = new URLSearchParams({ section: chartSection });
        if (activeRange.from) qs.set("from", new Date(activeRange.from + "T00:00:00").toISOString());
        if (activeRange.to) qs.set("to", new Date(activeRange.to + "T23:59:59").toISOString());
        const res = await fetch(`/api/analytics/flashcards?${qs}`, {
          headers: { Authorization: `Bearer ${token}` },
        });
        if (!res.ok) return;
        const body = (await res.json()) as FlashcardAggregate;
        if (!cancelled) setFlashSeriesAgg(body);
      } catch {
        // The recall line renders its gaps rather than the page breaking.
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [user.id, chartSection, activeRange.from, activeRange.to]);

  /**
   * The accuracy series, one point per day.
   *
   * WEEKLY BUCKETS HID TWO THINGS. A week with one forty-question day and six
   * empty ones looked identical to a week of steady work, and any week under
   * five questions was dropped entirely, which deleted most of a new student's
   * history rather than showing it as thin.
   *
   * All of the bucketing lives in lib/analytics/dailySeries.ts, including the
   * rule this chart turns on: a day with no questions carries a null accuracy,
   * never a zero, so the line breaks across it instead of diving to the floor
   * and back.
   *
   * Aggregated from the attempts the page has already loaded. No second
   * request: every other card on this page reads the same array, so a server
   * route for this one chart would mean fetching the same rows twice. The raw
   * load is worth moving server-side, but that is the whole page's problem
   * rather than this chart's.
   */
  const series = useMemo(
    () =>
      buildCombinedSeries({
        attempts: allAttempts.map((a) => ({
          createdAt: a.created_at,
          isCorrect: a.is_correct,
          section: a.questions?.section ?? null,
          isFirstAttempt: a.is_first_attempt,
        })),
        // Filtered to the chart's subject when one is chosen, and the
        // unfiltered aggregate otherwise. Both are bucketed by day on the
        // server, so the two lines cannot disagree about a date.
        daily: (chartSection === "all" ? flashAgg : flashSeriesAgg)?.daily ?? [],
        from: activeRange.from || localDayKey(new Date(Date.now() - 30 * 86_400_000)),
        to: activeRange.to || localDayKey(new Date()),
        section: chartSection,
      }),
    [allAttempts, flashAgg, flashSeriesAgg, chartSection, activeRange.from, activeRange.to],
  );

  /* ─────────── Loading ─────────── */
  if (loading) {
    return (
      <PraxPage bgVariant="study">
        <div className="flex items-center justify-center min-h-[60vh]">
          <div
            className="w-8 h-8 border-2 rounded-full animate-spin"
            style={{
              borderColor: "var(--color-prax-green)",
              borderTopColor: "transparent",
            }}
          />
        </div>
      </PraxPage>
    );
  }

  /* ─────────── Render ─────────── */

  // Period selector — shared across header
  const periodSelector = (
    <div className="flex flex-col sm:flex-row sm:items-center gap-3 self-start sm:self-auto">
      {/* Preset tabs */}
      <div
        className="flex items-center p-1 rounded-full gap-1"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        {(["7d", "30d", "all"] as Period[]).map((p) => (
          <button
            key={p}
            onClick={() => {
              setPeriod(p);
              setCustomFrom("");
              setCustomTo("");
            }}
            className="px-3.5 py-1.5 font-semibold uppercase rounded-full transition-all"
            style={{
              fontSize: 10,
              letterSpacing: "0.16em",
              background:
                period === p ? "var(--color-prax-green)" : "transparent",
              color:
                period === p
                  ? "var(--color-prax-cream)"
                  : "var(--color-prax-ink-mute)",
              cursor: "pointer",
            }}
          >
            {p === "7d" ? "Week" : p === "30d" ? "30 Days" : "All Time"}
          </button>
        ))}
      </div>

      {/* Custom date range */}
      <div
        className="flex items-center p-1 rounded-full gap-1"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        <input
          type="date"
          aria-label="Range start"
          value={activeRange.from}
          onChange={(e) => {
            setCustomFrom(e.target.value);
            // Editing either end takes the page off the preset, and the other
            // end keeps whatever the preset had rather than emptying.
            if (e.target.value) {
              if (!customTo) setCustomTo(activeRange.to);
              setPeriod("custom");
            }
          }}
          className="px-3 py-1.5 rounded-full border-0 outline-none cursor-pointer"
          style={{
            fontSize: 10,
            fontWeight: 600,
            color: "var(--color-prax-ink)",
            background: "transparent",
          }}
        />
        <span
          className="px-1"
          style={{ color: "var(--color-prax-ink-mute)", fontSize: 11 }}
        >
          to
        </span>
        <input
          type="date"
          aria-label="Range end"
          value={activeRange.to}
          min={activeRange.from || undefined}
          onChange={(e) => {
            setCustomTo(e.target.value);
            if (e.target.value) {
              if (!customFrom) setCustomFrom(activeRange.from);
              setPeriod("custom");
            }
          }}
          className="px-3 py-1.5 rounded-full border-0 outline-none cursor-pointer"
          style={{
            fontSize: 10,
            fontWeight: 600,
            color: "var(--color-prax-ink)",
            background: "transparent",
          }}
        />
      </div>
    </div>
  );

  const periodLabel =
    period === "7d"
      ? "Last week"
      : period === "30d"
      ? "Last 30 days"
      : period === "custom" && customFrom && customTo
      ? `${customFrom} to ${customTo}`
      : "All time";

  return (
    <PraxPage bgVariant="study">
      <PageHeader
        eyebrow="Diagnostic · Performance Intelligence"
        title="Performance."
        subtitle="Where your accuracy lives, where to push, what to fix next."
        right={periodSelector}
      />

      {/* ── Top bento — Accuracy / Questions / Score Estimate ── */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-5 mb-6">
        {/* Overall Question Accuracy */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>Question Accuracy</SmallCaps>
            <svg
              className="opacity-60"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="var(--color-prax-green)"
              strokeWidth={1.6}
            >
              <polyline points="23 6 13.5 15.5 8.5 10.5 1 18" />
              <polyline points="17 6 23 6 23 12" />
            </svg>
          </div>
          <div className="flex items-baseline gap-1">
            <div
              className="leading-none font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 48,
                color: "var(--color-prax-green)",
                fontVariantNumeric: "tabular-nums lining-nums",
              }}
            >
              {totalQuestions > 0 ? overallAccuracy : "—"}
            </div>
            {totalQuestions > 0 && (
              <div
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-ink-soft)",
                  fontStyle: "italic",
                }}
              >
                %
              </div>
            )}
          </div>
          <div
            className="mt-3"
            style={{
              fontSize: 11.5,
              color: "var(--color-prax-ink-mute)",
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {totalCorrect} of {totalQuestions} correct
          </div>
          {/* The range, on the card itself. Two cards showing different
              denominators is only confusing while one of them will not say
              what window it is counting. */}
          <SmallCaps style={{ marginTop: 6 }}>{periodLabel}</SmallCaps>
        </PraxCard>

        {/* First-Look Recall. See flashStats: session-gapped first looks, Again = failed retrieval. */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>First-Look Recall</SmallCaps>
            <svg
              className="opacity-60"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="var(--color-prax-green)"
              strokeWidth={1.6}
            >
              <polygon points="12 2 2 7 12 12 22 7 12 2" />
              <polyline points="2 17 12 22 22 17" />
              <polyline points="2 12 12 17 22 12" />
            </svg>
          </div>
          <div className="flex items-baseline gap-1">
            <div
              className="leading-none font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 48,
                color: "var(--color-prax-green)",
                fontVariantNumeric: "tabular-nums lining-nums",
              }}
            >
              {flashStats.firstTryTotal > 0 ? flashStats.firstTryPct : "—"}
            </div>
            {flashStats.firstTryTotal > 0 && (
              <div
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-ink-soft)",
                  fontStyle: "italic",
                }}
              >
                %
              </div>
            )}
          </div>
          <div
            className="mt-3"
            style={{
              fontSize: 11.5,
              color: "var(--color-prax-ink-mute)",
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {flashStats.firstTryCorrect} of {flashStats.firstTryTotal} on first
            try
          </div>
          <SmallCaps style={{ marginTop: 6 }}>{periodLabel}</SmallCaps>
        </PraxCard>

        {/* Score Estimate — primary green card */}
        <PraxCard variant="primary" className="overflow-hidden">
          <svg
            className="absolute opacity-15"
            style={{ right: -40, top: -50 }}
            width="200"
            height="200"
            viewBox="0 0 200 200"
            aria-hidden
          >
            <g
              fill="none"
              stroke="var(--color-prax-cream)"
              strokeWidth="0.8"
            >
              <circle cx="100" cy="100" r="80" />
              <circle cx="100" cy="100" r="55" />
              <circle cx="100" cy="100" r="30" />
            </g>
          </svg>
          <div className="relative">
            <div className="flex justify-between items-start mb-3">
              <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                Estimated MCAT range
              </SmallCaps>
              <svg
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="var(--color-prax-gold-soft)"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>
            </div>
            {scoreEstimate.low !== null ? (
              <div>
                {/* No confidence label on purpose. "Low confidence" reads as a
                    judgement of the student when it is a statement about how
                    little we have measured, and the opposite phrasing, "we are
                    confident you will score in here", is a promise nothing
                    validates: no Praxist prediction has ever been compared to a
                    real MCAT result. The line under the bar already says what
                    the estimate rests on and why it is wide, which is the
                    honest version of the same caveat.

                    scoreEstimate.confidence is still computed, for the admin
                    diagnostics the V2 spec calls for. It is simply not shown to
                    students.

                    The LIKELY score leads, with the range beneath it.
                    Two 44px numbers sixteen points apart read as "we have no
                    idea", when in fact the centre is a real estimate and the
                    width is mostly the cost of two MCAT sections we have never
                    tested. Leading with the centre says what we think; the line
                    under it says how sure we are. */}
                <div className="flex items-baseline gap-2.5">
                  <div
                    className="leading-none font-medium"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 46,
                      color: "var(--color-prax-cream)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {scoreEstimate.centre}
                  </div>
                  <div
                    style={{
                      fontSize: 10,
                      letterSpacing: "0.16em",
                      textTransform: "uppercase",
                      fontWeight: 600,
                      color: "rgba(246,244,227,0.55)",
                    }}
                  >
                    likely
                  </div>
                </div>
                <div
                  className="mt-1.5"
                  style={{
                    fontSize: 12,
                    color: "rgba(246,244,227,0.72)",
                    fontVariantNumeric: "tabular-nums",
                  }}
                >
                  {scoreEstimate.low} to {scoreEstimate.high}
                </div>
              </div>
            ) : (
              <div
                className="font-medium italic"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 24,
                  color: "rgba(246,244,227,0.5)",
                }}
              >
                Not enough data yet
              </div>
            )}
            <div className="mt-4">
              <div
                className="rounded-full overflow-hidden"
                style={{ height: 5, background: "rgba(246,244,227,0.18)" }}
              >
                <div
                  className="h-full rounded-full transition-all duration-1000"
                  style={{
                    width: `${Math.min(overallAccuracy, 100)}%`,
                    background: "var(--color-prax-gold-soft)",
                  }}
                />
              </div>
              <div
                className="flex justify-between mt-2"
                style={{
                  fontSize: 9.5,
                  letterSpacing: "0.16em",
                  textTransform: "uppercase",
                  color: "rgba(246,244,227,0.55)",
                  fontWeight: 600,
                }}
              >
                <span>{estimateBasis(scoreEstimate)}</span>
              </div>
            </div>
          </div>
        </PraxCard>
      </div>

      {/* ── Performance panels (Questions | Flashcards) ── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-6">
        <PerfPanel
          title="Questions"
          period={periodLabel}
          pct={qStats.firstTryPct ?? 0}
          stats={[
            {
              value: `${qStats.firstTryCorrect}/${qStats.firstTryTotal}`,
              label: "Correct on first try",
            },
            { value: totalQuestions.toLocaleString(), label: "Total attempts" },
          ]}
          breakdownLabel="By difficulty"
          bars={diffStats.map((d, i) => ({
            label: d.label,
            count: d.correct,
            denominator: d.total,
            unit: "correct",
            pct: d.accuracy,
            color:
              i === 0
                ? "var(--color-prax-green)"
                : i === 1
                ? "var(--color-prax-green-soft)"
                : "var(--color-prax-gold)",
          }))}
          empty={qStats.firstTryTotal === 0}
          emptyText="Answer questions to see your first-try accuracy."
        />
        <PerfPanel
          title="Flashcards"
          period={periodLabel}
          pct={flashStats.firstTryPct ?? 0}
          stats={[
            {
              value: `${flashStats.firstTryCorrect}/${flashStats.firstTryTotal}`,
              label: "Passed on first look",
            },
            { value: flashStats.total.toLocaleString(), label: "Total reviews" },
          ]}
          breakdownLabel="Grade breakdown"
          bars={[
            {
              label: "Again",
              count: flashStats.counts.again,
              denominator: flashStats.total,
              unit: "of reviews",
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.again / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-gold)",
            },
            {
              label: "Hard",
              count: flashStats.counts.hard,
              denominator: flashStats.total,
              unit: "of reviews",
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.hard / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-ink-soft)",
            },
            {
              label: "Medium",
              count: flashStats.counts.medium,
              denominator: flashStats.total,
              unit: "of reviews",
              pct:
                flashStats.total > 0
                  ? Math.round(
                      (flashStats.counts.medium / flashStats.total) * 100
                    )
                  : 0,
              color: "var(--color-prax-green-soft)",
            },
            {
              label: "Easy",
              count: flashStats.counts.easy,
              denominator: flashStats.total,
              unit: "of reviews",
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.easy / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-green)",
            },
          ]}
          empty={flashStats.total === 0}
          emptyText="Study flashcards to see your recall analytics."
        />
      </div>

      {/* ── Accuracy Over Time chart ── */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-start justify-between mb-6 gap-4">
          <div>
            <div
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Performance over time
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              {/* THE CAPTION DESCRIBES WHAT IS DRAWN, and only that. It once
                  read "all time, weekly, weeks under five questions excluded"
                  after the chart had become daily and range-scoped, which is
                  worse than no caption because a caption is believed.

                  The quiet-day count used to hang off the end of this line. It
                  has moved next to the legend, beside the faint joins it is
                  actually describing. */}
              {seriesCaption(series.granularity, periodLabel)}
            </SmallCaps>
          </div>

          {/* Section filter dropdown */}
          <div className="relative shrink-0">
            <button
              onClick={() => setSectionDropdownOpen((v) => !v)}
              aria-expanded={sectionDropdownOpen}
              aria-haspopup="listbox"
              aria-label={`Filter chart by subject, currently ${
                chartSection === "all"
                  ? "all subjects"
                  : SECTION_LABELS[chartSection] ?? chartSection
              }`}
              className="flex items-center gap-2 px-3.5 py-2 rounded-full"
              style={{
                background: "var(--color-prax-cream-card)",
                border: "1px solid var(--color-prax-cream-border)",
                fontSize: 10,
                fontWeight: 600,
                letterSpacing: "0.16em",
                textTransform: "uppercase",
                color: "var(--color-prax-green)",
                cursor: "pointer",
              }}
            >
              <span>
                {chartSection === "all"
                  ? "All Subjects"
                  : SECTION_LABELS[chartSection] ?? chartSection}
              </span>
              <svg
                width="10"
                height="10"
                fill="none"
                stroke="currentColor"
                strokeWidth={2.5}
                viewBox="0 0 24 24"
                style={{
                  transform: sectionDropdownOpen ? "rotate(180deg)" : "none",
                  transition: "transform 0.2s",
                }}
              >
                <path
                  d="M6 9l6 6 6-6"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </button>
            {sectionDropdownOpen && (
              <div
                role="listbox"
                aria-label="Chart subject"
                className="absolute right-0 top-full mt-2 z-20 overflow-hidden"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                  borderRadius: 12,
                  minWidth: 180,
                  boxShadow: "0 8px 32px -10px rgba(3,56,48,0.15)",
                }}
              >
                {[
                  { value: "all", label: "All Subjects" },
                  { value: "bio_biochem", label: "Biology & Biochem" },
                  { value: "chem_phys", label: "Physical Sciences" },
                  { value: "psych_soc", label: "Behavioral Sciences" },
                  { value: "cars", label: "CARS (Reading)" },
                ].map(({ value, label }) => (
                  <button
                    key={value}
                    role="option"
                    aria-selected={chartSection === value}
                    onClick={() => {
                      setChartSection(value);
                      setActiveWeek(null);
                      setSectionDropdownOpen(false);
                    }}
                    className="w-full text-left px-4 py-2.5"
                    style={{
                      fontSize: 10,
                      fontWeight: 600,
                      letterSpacing: "0.14em",
                      textTransform: "uppercase",
                      background:
                        chartSection === value
                          ? "var(--color-prax-green)"
                          : "transparent",
                      color:
                        chartSection === value
                          ? "var(--color-prax-cream)"
                          : "var(--color-prax-green)",
                      cursor: "pointer",
                    }}
                  >
                    {label}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>

        {series.measured < 1 ? (
          <div
            className="h-48 flex items-center justify-center italic text-center px-6"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 15,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            {chartSection !== "all" && sectionAttemptCount === 0
              ? `No ${SECTION_LABELS[chartSection] ?? chartSection} questions in the bank yet, so there is nothing to chart.`
              : "No questions answered in this range yet."}
          </div>
        ) : (
          <PerformanceOverTime
            series={series}
            periodLabel={periodLabel}
            mode={chartMode}
            onModeChange={setChartMode}
          />
        )}
      </PraxCard>

      {/* ── Focus Insight (weakest area + report cards) ── */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-5 mb-6">
        {/* ── Recent progress, from the snapshot system ──────────────────
            REPLACES Weakest Area, which ranked subtopics that entered at three
            attempts. Its own comment called that "describing coin flips":
            going 0 for 3 happens about one time in eight even when you know
            the material at 50%. Performance by topic now answers "where am I
            weak" on real evidence, and the finer subtopic grain it gave up led
            nowhere actionable, because the practice builder filters on topic
            rather than subtopic.

            The signals are derived events, so nothing here is a total: a topic
            improved only if a transition was actually recorded. An empty
            period renders the card's own empty state rather than zeros. */}
        <RecentProgress signals={progressSignals} loading={progressLoading} />

        {/* Daily Report Card */}
        <PraxCard variant="secondary" href="/dashboard/analytics/daily">
          <div className="flex items-start justify-between mb-3">
            <SmallCaps>Daily Report</SmallCaps>
            {hasDailyReport && (
              <span
                className="px-2 py-0.5 rounded-full"
                style={{
                  background: "var(--color-prax-green-tint)",
                  color: "var(--color-prax-green)",
                  fontSize: 9,
                  fontWeight: 700,
                  letterSpacing: "0.14em",
                  textTransform: "uppercase",
                }}
              >
                Ready
              </span>
            )}
          </div>
          <div
            className="font-medium mb-2"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            Last 24 hours
          </div>
          <p
            style={{
              fontSize: 12.5,
              lineHeight: 1.55,
              color: "var(--color-prax-ink-soft)",
            }}
          >
            Today&apos;s accuracy, section performance, and a personalised coach
            analysis.
          </p>
          <div
            className="flex items-center gap-2 mt-5"
            style={{
              fontSize: 10,
              fontWeight: 700,
              letterSpacing: "0.18em",
              textTransform: "uppercase",
              color: "var(--color-prax-green)",
            }}
          >
            <span>{hasDailyReport ? "View Report" : "Generate"}</span>
            <svg
              width="12"
              height="12"
              fill="none"
              stroke="currentColor"
              strokeWidth={2.5}
              viewBox="0 0 24 24"
            >
              <path
                d="M5 12h14M12 5l7 7-7 7"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
        </PraxCard>

        {/* Weekly Report Card */}
        <PraxCard variant="secondary" href="/dashboard/analytics/weekly">
          <div className="flex items-start justify-between mb-3">
            <SmallCaps>Weekly Report</SmallCaps>
            {hasWeeklyReport && (
              <span
                className="px-2 py-0.5 rounded-full"
                style={{
                  background: "var(--color-prax-green-tint)",
                  color: "var(--color-prax-green)",
                  fontSize: 9,
                  fontWeight: 700,
                  letterSpacing: "0.14em",
                  textTransform: "uppercase",
                }}
              >
                Ready
              </span>
            )}
          </div>
          <div
            className="font-medium mb-2"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            Last 7 days
          </div>
          <p
            style={{
              fontSize: 12.5,
              lineHeight: 1.55,
              color: "var(--color-prax-ink-soft)",
            }}
          >
            Daily accuracy trend, topics ranked by priority, and a 5-part study
            plan.
          </p>
          <div
            className="flex items-center gap-2 mt-5"
            style={{
              fontSize: 10,
              fontWeight: 700,
              letterSpacing: "0.18em",
              textTransform: "uppercase",
              color: "var(--color-prax-green)",
            }}
          >
            <span>{hasWeeklyReport ? "View Report" : "Generate"}</span>
            <svg
              width="12"
              height="12"
              fill="none"
              stroke="currentColor"
              strokeWidth={2.5}
              viewBox="0 0 24 24"
            >
              <path
                d="M5 12h14M12 5l7 7-7 7"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
        </PraxCard>
      </div>

      {/* ── Performance by topic ────────────────────────────────────────
          Replaces three sections that each answered "where am I weak?" from a
          single modality: Section Accuracy, Recall by topic, and Topic
          performance. None of them could say whether a weak topic was weak
          because the student does not REMEMBER it or because they remember it
          and cannot APPLY it, and those have opposite fixes.

          Measured topics lead. Everything still gathering evidence collapses
          into one line rather than filling the page with rows that say
          "Limited evidence", which is what listing every topic would do for
          almost every student today. */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-end justify-between mb-2 gap-3">
          <div>
            <h2
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Performance by topic
            </h2>
            <SmallCaps style={{ marginTop: 4 }}>
              {topicIntel.measured.length > 0
                ? "What you recall, against what you can apply"
                : "Recall and application, once both are measured"}
            </SmallCaps>
          </div>
          {topicIntel.measured.length > 0 && (
            <SmallCaps>{topicIntel.measured.length} measured</SmallCaps>
          )}
        </div>

        {topicIntel.measured.length === 0 ? (
          <div className="py-6">
            <p
              className="m-0"
              style={{
                fontSize: 14,
                lineHeight: 1.65,
                color: "var(--color-prax-ink-soft)",
                maxWidth: "56ch",
              }}
            >
              A topic is compared once it has enough of both kinds of evidence:
              practice questions to show whether you can apply it, and card
              reviews to show whether you recall it.
            </p>
            {topicIntel.pending.length > 0 && (
              <p
                className="m-0 mt-3"
                style={{ fontSize: 13.5, color: "var(--color-prax-ink-mute)" }}
              >
                {topicIntel.pending.length}{" "}
                {topicIntel.pending.length === 1 ? "topic is" : "topics are"} part
                way there.
              </p>
            )}
          </div>
        ) : (
          <div style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}>
            {topicIntel.measured.map((t) => (
              <TopicRow key={t.key} topic={t} />
            ))}
            {topicIntel.pending.length > 0 && (
              <p
                className="m-0 pt-4"
                style={{ fontSize: 12.5, color: "var(--color-prax-ink-mute)" }}
              >
                {topicIntel.pending.length} more{" "}
                {topicIntel.pending.length === 1 ? "topic is" : "topics are"} still
                gathering evidence on one side.
              </p>
            )}
          </div>
        )}
      </PraxCard>
    </PraxPage>
  );
}
