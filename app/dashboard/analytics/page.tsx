"use client";

import { useEffect, useState, useMemo } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import {
  PraxPage,
  PageHeader,
  SmallCaps,
  PraxCard,
} from "@/components/dashboard/PraxUI";

/* ─────────── Types ─────────── */

interface Attempt {
  is_correct: boolean;
  created_at: string;
  questions: { section: string; subtopic: string; difficulty: string } | null;
}

interface DailyActivity {
  activity_date: string;
  questions_completed: number;
}

type Period = "7d" | "30d" | "all" | "custom";

const SECTION_LABELS: Record<string, string> = {
  bio_biochem: "Biology & Biochemistry",
  chem_phys: "Physical Sciences",
  psych_soc: "Behavioral Sciences",
  cars: "CARS (Reading)",
};

/* ─────────── Helpers ─────────── */

function estimateScoreRange(accuracy: number): [number, number] {
  if (accuracy >= 90) return [519, 520];
  if (accuracy >= 85) return [516, 519];
  if (accuracy >= 80) return [513, 516];
  if (accuracy >= 75) return [510, 513];
  if (accuracy >= 70) return [507, 510];
  if (accuracy >= 60) return [503, 507];
  if (accuracy > 0) return [498, 503];
  return [0, 0];
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

/* ─────────── Page ─────────── */

export default function AnalyticsPage() {
  const { user } = useDashboard();
  const [allAttempts, setAllAttempts] = useState<Attempt[]>([]);
  const [, setActivity] = useState<DailyActivity[]>([]);
  const [streak, setStreak] = useState(0);
  const [, setLessonsCompleted] = useState(0);
  const [loading, setLoading] = useState(true);
  const [period, setPeriod] = useState<Period>("30d");
  const [chartSection, setChartSection] = useState<string>("all");
  const [sectionDropdownOpen, setSectionDropdownOpen] = useState(false);
  const [customFrom, setCustomFrom] = useState("");
  const [customTo, setCustomTo] = useState("");

  const [hasDailyReport, setHasDailyReport] = useState(false);
  const [hasWeeklyReport, setHasWeeklyReport] = useState(false);

  useEffect(() => {
    async function load() {
      const [
        { data: attempts },
        { data: act },
        { data: streakData },
        { data: progress },
      ] = await Promise.all([
        supabase
          .from("question_attempts")
          .select(
            "is_correct, created_at, questions(section, subtopic, difficulty)"
          )
          .eq("user_id", user.id),
        supabase
          .from("daily_activity")
          .select("activity_date, questions_completed")
          .eq("user_id", user.id)
          .order("activity_date"),
        supabase
          .from("daily_activity")
          .select("activity_date")
          .eq("user_id", user.id)
          .order("activity_date", { ascending: false })
          .limit(60),
        supabase
          .from("lesson_progress")
          .select("id")
          .eq("user_id", user.id)
          .eq("completed", true),
      ]);

      setAllAttempts((attempts as unknown as Attempt[]) || []);
      setActivity(act || []);
      setLessonsCompleted(progress?.length || 0);

      // Streak
      if (streakData && streakData.length > 0) {
        let s = 0;
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        for (let i = 0; i < streakData.length; i++) {
          const actDate = new Date(streakData[i].activity_date + "T00:00:00");
          const expected = new Date(today);
          expected.setDate(expected.getDate() - i);
          if (actDate.getTime() === expected.getTime()) s++;
          else break;
        }
        setStreak(s);
      }

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
  const filtered = useMemo(
    () => filterByPeriod(allAttempts, period, customFrom, customTo),
    [allAttempts, period, customFrom, customTo]
  );

  const totalQuestions = filtered.length;
  const totalCorrect = filtered.filter((a) => a.is_correct).length;
  const overallAccuracy =
    totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0;
  const [scoreLow, scoreHigh] = estimateScoreRange(overallAccuracy);

  // Section stats
  const sectionStats = useMemo(() => {
    const map = new Map<string, { total: number; correct: number }>();
    filtered.forEach((a) => {
      if (!a.questions) return;
      const sec = map.get(a.questions.section) || { total: 0, correct: 0 };
      sec.total++;
      if (a.is_correct) sec.correct++;
      map.set(a.questions.section, sec);
    });
    return ["bio_biochem", "chem_phys", "psych_soc", "cars"]
      .filter((s) => map.has(s))
      .map((s) => {
        const d = map.get(s)!;
        return {
          section: s,
          label: SECTION_LABELS[s],
          ...d,
          accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0,
        };
      });
  }, [filtered]);

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
  const subtopicStats = useMemo(() => {
    const map = new Map<
      string,
      { section: string; subtopic: string; total: number; correct: number }
    >();
    filtered.forEach((a) => {
      if (!a.questions) return;
      const key = `${a.questions.section}::${a.questions.subtopic}`;
      const s = map.get(key) || {
        section: a.questions.section,
        subtopic: a.questions.subtopic,
        total: 0,
        correct: 0,
      };
      s.total++;
      if (a.is_correct) s.correct++;
      map.set(key, s);
    });
    return Array.from(map.values())
      .filter((s) => s.total >= 3)
      .map((s) => ({ ...s, accuracy: Math.round((s.correct / s.total) * 100) }))
      .sort((a, b) => a.accuracy - b.accuracy);
  }, [filtered]);

  const weakestTopic = subtopicStats[0];

  // Weekly accuracy chart
  const { chartPoints, chartWeekLabels } = useMemo(() => {
    const empty = {
      chartPoints: [] as [number, number][],
      chartWeekLabels: [] as string[],
    };
    if (allAttempts.length === 0) return empty;

    const src =
      chartSection === "all"
        ? allAttempts
        : allAttempts.filter((a) => a.questions?.section === chartSection);

    if (src.length === 0) return empty;

    const weekMap = new Map<string, { total: number; correct: number }>();
    src.forEach((a) => {
      const d = new Date(a.created_at);
      const day = d.getDay();
      const mon = new Date(d);
      mon.setDate(d.getDate() - ((day + 6) % 7));
      const key = mon.toISOString().split("T")[0];
      const w = weekMap.get(key) || { total: 0, correct: 0 };
      w.total++;
      if (a.is_correct) w.correct++;
      weekMap.set(key, w);
    });

    const weeks = Array.from(weekMap.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .filter(([, w]) => w.total >= 5);

    if (weeks.length === 0) return empty;

    const X_START = 0,
      X_END = 1000,
      Y_TOP = 20,
      Y_BOT = 280;
    const points: [number, number][] = weeks.map(([, w], i) => {
      const acc = (w.correct / w.total) * 100;
      const x =
        weeks.length === 1
          ? (X_START + X_END) / 2
          : X_START + (i / (weeks.length - 1)) * (X_END - X_START);
      const y = Y_BOT - (acc / 100) * (Y_BOT - Y_TOP);
      return [x, y];
    });

    const labels = weeks.map(([key]) =>
      new Date(key + "T00:00:00").toLocaleDateString("en-US", {
        month: "short",
        day: "numeric",
      })
    );

    return { chartPoints: points, chartWeekLabels: labels };
  }, [allAttempts, chartSection]);

  const linePath = buildSvgPath(chartPoints);
  const areaPath = buildAreaPath(chartPoints, 280);

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
          value={customFrom}
          onChange={(e) => {
            setCustomFrom(e.target.value);
            if (e.target.value) setPeriod("custom");
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
          –
        </span>
        <input
          type="date"
          value={customTo}
          min={customFrom || undefined}
          onChange={(e) => {
            setCustomTo(e.target.value);
            if (e.target.value) setPeriod("custom");
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
      ? `${customFrom} – ${customTo}`
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
        {/* Overall Accuracy */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>Overall Accuracy</SmallCaps>
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
        </PraxCard>

        {/* Questions Done */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>Questions Done</SmallCaps>
            <svg
              className="opacity-60"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="var(--color-prax-green)"
              strokeWidth={1.6}
            >
              <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z" />
              <polyline points="14 2 14 8 20 8" />
            </svg>
          </div>
          <div
            className="leading-none font-medium"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 48,
              color: "var(--color-prax-green)",
              fontVariantNumeric: "tabular-nums lining-nums",
            }}
          >
            {totalQuestions.toLocaleString()}
          </div>
          <div
            className="mt-3"
            style={{
              fontSize: 11.5,
              color:
                streak > 0
                  ? "var(--color-prax-gold)"
                  : "var(--color-prax-ink-mute)",
              fontWeight: streak > 0 ? 600 : 400,
            }}
          >
            {streak > 0
              ? `${streak}-day study streak`
              : "Start a session to build your streak"}
          </div>
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
                Est. Score Range
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
            {totalQuestions > 0 ? (
              <div className="flex items-baseline gap-2">
                <div
                  className="leading-none font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 44,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {scoreLow}
                </div>
                <div
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 22,
                    color: "rgba(246,244,227,0.5)",
                  }}
                >
                  —
                </div>
                <div
                  className="leading-none font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 44,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {scoreHigh}
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
                No data yet
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
                <span>Based on accuracy</span>
                <span>Target 520</span>
              </div>
            </div>
          </div>
        </PraxCard>
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
              Accuracy over time
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              Weekly · weeks with &lt;5 questions excluded
            </SmallCaps>
          </div>

          {/* Section filter dropdown */}
          <div className="relative shrink-0">
            <button
              onClick={() => setSectionDropdownOpen((v) => !v)}
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
                    onClick={() => {
                      setChartSection(value);
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

        {chartPoints.length < 2 ? (
          <div
            className="h-48 flex items-center justify-center italic"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 14,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Complete more sessions to see your accuracy chart.
          </div>
        ) : (
          <div className="flex gap-3">
            <div
              className="flex flex-col justify-between shrink-0 w-8 text-right"
              style={{ height: 220 }}
            >
              {["100%", "75%", "50%", "25%", "0%"].map((label) => (
                <span
                  key={label}
                  style={{
                    fontSize: 9,
                    fontWeight: 600,
                    letterSpacing: "0.1em",
                    color: "var(--color-prax-ink-mute)",
                    fontVariantNumeric: "tabular-nums",
                    lineHeight: 1,
                  }}
                >
                  {label}
                </span>
              ))}
            </div>
            <div className="flex-1 min-w-0">
              <svg
                className="w-full overflow-visible"
                viewBox="0 0 1000 300"
                preserveAspectRatio="none"
                style={{ height: 220 }}
              >
                <defs>
                  <linearGradient id="prax-area-grad" x1="0" y1="0" x2="0" y2="1">
                    <stop
                      offset="0%"
                      stopColor="var(--color-prax-green)"
                      stopOpacity="0.22"
                    />
                    <stop
                      offset="100%"
                      stopColor="var(--color-prax-green)"
                      stopOpacity="0"
                    />
                  </linearGradient>
                </defs>
                {[20, 85, 150, 215, 280].map((y) => (
                  <line
                    key={y}
                    x1="0"
                    x2="1000"
                    y1={y}
                    y2={y}
                    stroke="var(--color-prax-cream-border)"
                    strokeWidth="0.8"
                  />
                ))}
                <path d={areaPath} fill="url(#prax-area-grad)" />
                <path
                  d={linePath}
                  fill="none"
                  stroke="var(--color-prax-green)"
                  strokeWidth="3.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  style={{
                    strokeDasharray: 2000,
                    strokeDashoffset: 2000,
                    animation: "praxChartDash 2s ease-in-out forwards",
                  }}
                />
                {chartPoints.map(([x, y], i) => (
                  <circle
                    key={i}
                    cx={x}
                    cy={y}
                    r="5"
                    fill="var(--color-prax-green)"
                  />
                ))}
              </svg>
              <style>{`@keyframes praxChartDash { to { stroke-dashoffset: 0; } }`}</style>
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
                <span>{chartWeekLabels[0]}</span>
                {chartWeekLabels.length > 2 && (
                  <span>
                    {chartWeekLabels[Math.floor(chartWeekLabels.length / 2)]}
                  </span>
                )}
                <span>{chartWeekLabels[chartWeekLabels.length - 1]}</span>
              </div>
            </div>
          </div>
        )}
      </PraxCard>

      {/* ── Focus Insight (weakest area + report cards) ── */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-5 mb-6">
        {/* Weakest Area */}
        <PraxCard variant="secondary">
          <div className="flex items-center gap-2 mb-3">
            <div
              className="rounded-full"
              style={{
                width: 6,
                height: 6,
                background: "var(--color-prax-gold)",
              }}
            />
            <SmallCaps>Weakest Area</SmallCaps>
          </div>
          {weakestTopic ? (
            <>
              <div
                className="font-medium mb-2"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-green)",
                  letterSpacing: "-0.005em",
                }}
              >
                {weakestTopic.subtopic.replace(/_/g, " ")}
              </div>
              <div
                style={{
                  fontSize: 12.5,
                  lineHeight: 1.55,
                  color: "var(--color-prax-ink-soft)",
                }}
              >
                Accuracy{" "}
                <span
                  style={{
                    fontWeight: 700,
                    color: "var(--color-prax-gold)",
                    fontVariantNumeric: "tabular-nums",
                  }}
                >
                  {weakestTopic.accuracy}%
                </span>{" "}
                — your lowest-scoring topic right now. Targeting it directly
                will have the most leverage on your overall score.
              </div>
              <div
                className="mt-4 p-3.5 rounded-xl"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                }}
              >
                <SmallCaps style={{ marginBottom: 6 }}>
                  Recommended Strategy
                </SmallCaps>
                <p
                  style={{
                    fontSize: 12,
                    lineHeight: 1.5,
                    color: "var(--color-prax-ink-soft)",
                  }}
                >
                  Filter practice to{" "}
                  {SECTION_LABELS[weakestTopic.section] || weakestTopic.section}{" "}
                  and start with Easy difficulty. Build the foundation before
                  attempting hard questions on this topic.
                </p>
              </div>
            </>
          ) : (
            <div
              className="italic"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 14,
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Answer at least 3 questions per topic to unlock personalised
              insights.
            </div>
          )}
        </PraxCard>

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

      {/* ── Subject Mastery + Intensity Analysis ── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-6">
        {/* Subject Mastery */}
        <PraxCard variant="secondary">
          <div className="flex items-center justify-between mb-5">
            <SmallCaps>Subject Mastery</SmallCaps>
            <SmallCaps style={{ color: "var(--color-prax-ink-soft)" }}>
              {periodLabel}
            </SmallCaps>
          </div>
          {sectionStats.length === 0 ? (
            <div
              className="italic text-center py-8"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 13,
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Answer practice questions to see your section breakdown.
            </div>
          ) : (
            <div className="space-y-5">
              {(() => {
                // mark weakest section in gold
                const minAcc =
                  sectionStats.length > 0
                    ? Math.min(...sectionStats.map((s) => s.accuracy))
                    : 0;
                return sectionStats.map((s) => {
                  const attention = s.accuracy === minAcc;
                  return (
                    <div key={s.section}>
                      <div className="flex justify-between items-baseline mb-1.5">
                        <div className="flex items-center gap-2">
                          {attention && (
                            <div
                              className="rounded-full"
                              style={{
                                width: 5,
                                height: 5,
                                background: "var(--color-prax-gold)",
                              }}
                            />
                          )}
                          <div
                            style={{
                              fontFamily: "var(--font-prax-sans)",
                              fontSize: 12.5,
                              fontWeight: attention ? 600 : 500,
                              color: "var(--color-prax-ink)",
                            }}
                          >
                            {s.label}
                          </div>
                        </div>
                        <div
                          style={{
                            fontFamily: "var(--font-prax-serif)",
                            fontSize: 16,
                            color: attention
                              ? "var(--color-prax-gold)"
                              : "var(--color-prax-green)",
                            fontVariantNumeric: "tabular-nums lining-nums",
                          }}
                        >
                          {s.accuracy}
                          <span
                            style={{
                              fontSize: 12,
                              color: "var(--color-prax-ink-mute)",
                            }}
                          >
                            %
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
                          style={{
                            width: `${s.accuracy}%`,
                            background: attention
                              ? "var(--color-prax-gold)"
                              : "var(--color-prax-green)",
                          }}
                        />
                      </div>
                      <div
                        className="mt-1"
                        style={{
                          fontSize: 10,
                          color: "var(--color-prax-ink-mute)",
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {s.correct}/{s.total} correct
                      </div>
                    </div>
                  );
                });
              })()}
            </div>
          )}
        </PraxCard>

        {/* Intensity Analysis (Difficulty) */}
        <PraxCard variant="secondary" className="flex flex-col">
          <div className="flex items-center justify-between mb-5">
            <SmallCaps>Intensity Analysis</SmallCaps>
            <SmallCaps style={{ color: "var(--color-prax-ink-soft)" }}>
              By difficulty
            </SmallCaps>
          </div>

          {diffStats.every((d) => d.total === 0) ? (
            <div
              className="italic text-center py-8"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 13,
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Complete practice sessions to see difficulty breakdown.
            </div>
          ) : (
            <div className="flex items-center justify-around py-2">
              {diffStats.map((d) => (
                <DonutRing key={d.label} pct={d.accuracy} label={d.label} />
              ))}
            </div>
          )}

          <div
            className="mt-auto pt-5 flex items-start gap-3"
            style={{
              borderTop: "1px solid var(--color-prax-cream-border)",
              marginTop: 16,
            }}
          >
            <div
              className="rounded-full shrink-0 mt-1"
              style={{
                width: 5,
                height: 5,
                background:
                  diffStats[2]?.accuracy < 60 && diffStats[2]?.total > 0
                    ? "var(--color-prax-gold)"
                    : "var(--color-prax-green-soft)",
              }}
            />
            <div>
              <SmallCaps style={{ marginBottom: 4 }}>Stamina Note</SmallCaps>
              <p
                style={{
                  fontSize: 11.5,
                  lineHeight: 1.55,
                  color: "var(--color-prax-ink-soft)",
                }}
              >
                {diffStats[2]?.accuracy < 60 && diffStats[2]?.total > 0
                  ? `Hard question accuracy is ${diffStats[2].accuracy}%. Schedule difficult drills during your highest-energy study block.`
                  : diffStats[2]?.total > 0
                  ? `Strong performance on hard questions at ${diffStats[2].accuracy}%. Keep up the high-difficulty practice.`
                  : "Attempt harder difficulty questions to see your intensity breakdown."}
              </p>
            </div>
          </div>
        </PraxCard>
      </div>

      {/* ── Topic Mastery list ── */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-end justify-between mb-5 gap-3">
          <div>
            <div
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Topic mastery
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              Weakest first — your highest-leverage targets
            </SmallCaps>
          </div>
          {subtopicStats.length > 0 && (
            <SmallCaps>{subtopicStats.length} topics</SmallCaps>
          )}
        </div>

        {subtopicStats.length === 0 ? (
          <div
            className="italic text-center py-8"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 13,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Answer at least 3 questions per topic to see mastery data.
          </div>
        ) : (
          <div>
            {subtopicStats.map((s) => {
              const accuracy = s.accuracy;
              const isStrong = accuracy >= 80;
              const isDeveloping = accuracy >= 60 && accuracy < 80;

              const badgeBg = isStrong
                ? "var(--color-prax-green-tint)"
                : isDeveloping
                ? "var(--color-prax-cream-card)"
                : "var(--color-prax-gold)";
              const badgeColor = isStrong
                ? "var(--color-prax-green)"
                : isDeveloping
                ? "var(--color-prax-ink-soft)"
                : "var(--color-prax-cream)";
              const badgeLabel = isStrong
                ? "Strong"
                : isDeveloping
                ? "Developing"
                : "Focus Here";

              return (
                <div
                  key={`${s.section}::${s.subtopic}`}
                  className="flex items-center gap-4 py-3"
                  style={{
                    borderBottom: "1px solid var(--color-prax-cream-border)",
                  }}
                >
                  <div
                    className="w-1 rounded-full overflow-hidden shrink-0"
                    style={{
                      height: 32,
                      background: "var(--color-prax-cream-card)",
                    }}
                  >
                    <div
                      className="w-full rounded-full transition-all duration-700"
                      style={{
                        height: `${accuracy}%`,
                        marginTop: `${100 - accuracy}%`,
                        background: isStrong
                          ? "var(--color-prax-green)"
                          : isDeveloping
                          ? "var(--color-prax-green-soft)"
                          : "var(--color-prax-gold)",
                      }}
                    />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div
                      className="font-medium truncate"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 14.5,
                        color: "var(--color-prax-green)",
                      }}
                    >
                      {s.subtopic.replace(/_/g, " ")}
                    </div>
                    <div
                      style={{
                        fontSize: 10.5,
                        color: "var(--color-prax-ink-mute)",
                        fontVariantNumeric: "tabular-nums",
                      }}
                    >
                      {SECTION_LABELS[s.section] || s.section} · {s.correct}/
                      {s.total} correct
                    </div>
                  </div>
                  <div className="flex items-center gap-2.5 shrink-0">
                    <div
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 17,
                        fontStyle: "italic",
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {accuracy}%
                    </div>
                    <span
                      className="px-2.5 py-1 rounded-full whitespace-nowrap"
                      style={{
                        background: badgeBg,
                        color: badgeColor,
                        fontSize: 9.5,
                        fontWeight: 700,
                        letterSpacing: "0.14em",
                        textTransform: "uppercase",
                      }}
                    >
                      {badgeLabel}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </PraxCard>
    </PraxPage>
  );
}
