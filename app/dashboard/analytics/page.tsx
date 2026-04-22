"use client";

import { useEffect, useState, useMemo } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

// ─── Types ────────────────────────────────────────────────────────────────────

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

// ─── Helpers ─────────────────────────────────────────────────────────────────

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
  customTo?: string,
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

// ─── Donut Ring ───────────────────────────────────────────────────────────────

function DonutRing({ pct, label }: { pct: number; label: string }) {
  const r = 36;
  const circ = 2 * Math.PI * r;
  const offset = circ * (1 - pct / 100);
  return (
    <div className="flex flex-col items-center gap-3">
      <div className="relative w-24 h-24">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 88 88">
          <circle cx="44" cy="44" r={r} fill="none" stroke="currentColor"
            strokeWidth="8" className="text-as-outline-variant/20" />
          <circle cx="44" cy="44" r={r} fill="none" stroke="currentColor"
            strokeWidth="8" strokeLinecap="round"
            strokeDasharray={circ} strokeDashoffset={offset}
            className="text-as-primary transition-all duration-1000" />
        </svg>
        <span className="absolute inset-0 flex items-center justify-center font-bold text-lg text-as-primary">
          {pct > 0 ? `${pct}%` : "—"}
        </span>
      </div>
      <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">
        {label}
      </span>
    </div>
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function AnalyticsPage() {
  const { user } = useDashboard();
  const [allAttempts, setAllAttempts] = useState<Attempt[]>([]);
  const [activity, setActivity] = useState<DailyActivity[]>([]);
  const [streak, setStreak] = useState(0);
  const [lessonsCompleted, setLessonsCompleted] = useState(0);
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
      const [{ data: attempts }, { data: act }, { data: streakData }, { data: progress }] =
        await Promise.all([
          supabase
            .from("question_attempts")
            .select("is_correct, created_at, questions(section, subtopic, difficulty)")
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

  // ── Derived stats ────────────────────────────────────────────────────────

  const filtered = useMemo(
    () => filterByPeriod(allAttempts, period, customFrom, customTo),
    [allAttempts, period, customFrom, customTo],
  );

  const totalQuestions = filtered.length;
  const totalCorrect = filtered.filter((a) => a.is_correct).length;
  const overallAccuracy = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0;
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
        return { section: s, label: SECTION_LABELS[s], ...d, accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0 };
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
      return { label: k.charAt(0).toUpperCase() + k.slice(1), ...d, accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0 };
    });
  }, [filtered]);

  // Subtopic stats (weakest first)
  const subtopicStats = useMemo(() => {
    const map = new Map<string, { section: string; subtopic: string; total: number; correct: number }>();
    filtered.forEach((a) => {
      if (!a.questions) return;
      const key = `${a.questions.section}::${a.questions.subtopic}`;
      const s = map.get(key) || { section: a.questions.section, subtopic: a.questions.subtopic, total: 0, correct: 0 };
      s.total++;
      if (a.is_correct) s.correct++;
      map.set(key, s);
    });
    return Array.from(map.values())
      .filter((s) => s.total >= 3)
      .map((s) => ({ ...s, accuracy: Math.round((s.correct / s.total) * 100) }))
      .sort((a, b) => a.accuracy - b.accuracy);
  }, [filtered]);

  // Weakest topic for insight card
  const weakestTopic = subtopicStats[0];

  // Weekly accuracy chart — groups attempts by week, calculates accuracy per week
  const { chartPoints, chartWeekLabels } = useMemo(() => {
    const empty = { chartPoints: [] as [number, number][], chartWeekLabels: [] as string[] };
    if (allAttempts.length === 0) return empty;

    // Filter by section if set
    const src = chartSection === "all"
      ? allAttempts
      : allAttempts.filter((a) => a.questions?.section === chartSection);

    if (src.length === 0) return empty;

    // Group by week (Monday-based)
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

    // Only include weeks with ≥5 attempts for meaningful accuracy
    const weeks = Array.from(weekMap.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .filter(([, w]) => w.total >= 5);

    if (weeks.length === 0) return empty;

    // SVG coordinate system: viewBox 0 0 1000 300
    // Plot area: x=0..1000, y=20..280 (100%=y20, 0%=y280)
    const X_START = 0, X_END = 1000, Y_TOP = 20, Y_BOT = 280;
    const points: [number, number][] = weeks.map(([, w], i) => {
      const acc = (w.correct / w.total) * 100;
      const x = weeks.length === 1
        ? (X_START + X_END) / 2
        : X_START + (i / (weeks.length - 1)) * (X_END - X_START);
      const y = Y_BOT - (acc / 100) * (Y_BOT - Y_TOP);
      return [x, y];
    });

    const labels = weeks.map(([key]) =>
      new Date(key + "T00:00:00").toLocaleDateString("en-US", { month: "short", day: "numeric" })
    );

    return { chartPoints: points, chartWeekLabels: labels };
  }, [allAttempts, chartSection]);

  const linePath = buildSvgPath(chartPoints);
  const areaPath = buildAreaPath(chartPoints, 280);

  // ─── Loading ───────────────────────────────────────────────────────────────

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  // ─── Render ────────────────────────────────────────────────────────────────

  return (
    <div className="max-w-5xl mx-auto px-4 sm:px-6 py-8 sm:py-12">
      <style>{`
        input[type="date"]::-webkit-datetime-edit,
        input[type="date"]::-webkit-datetime-edit-fields-wrapper,
        input[type="date"]::-webkit-datetime-edit-text,
        input[type="date"]::-webkit-datetime-edit-month-field,
        input[type="date"]::-webkit-datetime-edit-day-field,
        input[type="date"]::-webkit-datetime-edit-year-field,
        input[type="date"]::-webkit-input-placeholder { color: #ffffff !important; }
      `}</style>

      {/* ── Header ── */}
      <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-6 mb-10">
        <div>
          <span className="text-[10px] font-bold tracking-[0.2em] text-as-outline uppercase block mb-2">
            Diagnostic Intelligence
          </span>
          <h1 className="font-headline text-4xl sm:text-5xl font-bold text-as-primary leading-tight">
            Performance Intelligence
          </h1>
        </div>

        {/* Period selector */}
        <div className="flex flex-col sm:flex-row sm:items-center gap-3 self-start sm:self-auto">
          {/* Preset tabs */}
          <div className="flex items-center bg-as-surface-container p-1.5 rounded-2xl gap-1">
            {(["7d", "30d", "all"] as Period[]).map((p) => (
              <button
                key={p}
                onClick={() => { setPeriod(p); setCustomFrom(""); setCustomTo(""); }}
                className={`px-4 py-2 text-xs font-bold uppercase tracking-wider rounded-xl transition-all ${
                  period === p
                    ? "bg-as-primary text-as-on-primary shadow-md"
                    : "text-as-outline hover:text-as-primary"
                }`}
              >
                {p === "7d" ? "Last Week" : p === "30d" ? "Last 30 Days" : "All Time"}
              </button>
            ))}
          </div>

          {/* Divider */}
          <span className="hidden sm:block text-as-outline-variant text-xs font-bold select-none">or</span>

          {/* Custom date range */}
          <div className="flex items-center bg-as-surface-container p-1.5 rounded-2xl gap-1">
            <input
              type="date"
              value={customFrom}
              onChange={(e) => {
                setCustomFrom(e.target.value);
                if (e.target.value) setPeriod("custom");
              }}
              style={{ colorScheme: "dark", color: "#ffffff", backgroundColor: "#003630" }}
              className="px-4 py-2 text-xs font-bold rounded-xl border-0 outline-none cursor-pointer"
            />
            <span className="text-as-outline text-xs font-bold select-none px-1">–</span>
            <input
              type="date"
              value={customTo}
              min={customFrom || undefined}
              onChange={(e) => {
                setCustomTo(e.target.value);
                if (e.target.value) setPeriod("custom");
              }}
              style={{ colorScheme: "dark", color: "#ffffff", backgroundColor: "#003630" }}
              className="px-4 py-2 text-xs font-bold rounded-xl border-0 outline-none cursor-pointer"
            />
          </div>
        </div>
      </div>


      {/* ── Top Bento Grid ── */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-5 mb-8">
        {/* Overall Accuracy */}
        <div className="bg-as-surface-container-low rounded-[2rem] p-7 flex flex-col justify-between hover:bg-as-surface-container transition-all duration-500">
          <div className="flex justify-between items-start mb-5">
            <span className="text-[10px] font-bold text-as-outline uppercase tracking-widest">Overall Accuracy</span>
            <svg className="w-5 h-5 text-as-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
              <polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" />
            </svg>
          </div>
          <div className="flex items-baseline gap-1">
            <span className="text-5xl font-bold text-as-primary">
              {totalQuestions > 0 ? overallAccuracy : "—"}
            </span>
            {totalQuestions > 0 && <span className="text-2xl font-serif italic text-as-primary/60">%</span>}
          </div>
          <p className="mt-5 text-xs font-medium text-as-outline">
            {totalCorrect} of {totalQuestions} correct
          </p>
        </div>

        {/* Questions Done */}
        <div className="bg-as-surface-container-low rounded-[2rem] p-7 flex flex-col justify-between hover:bg-as-surface-container transition-all duration-500">
          <div className="flex justify-between items-start mb-5">
            <span className="text-[10px] font-bold text-as-outline uppercase tracking-widest">Questions Done</span>
            <svg className="w-5 h-5 text-as-primary" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
              <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z" /><polyline points="14 2 14 8 20 8" />
            </svg>
          </div>
          <span className="text-5xl font-bold text-as-primary">
            {totalQuestions.toLocaleString()}
          </span>
          <p className="mt-5 text-xs font-medium text-as-outline">
            {streak > 0 ? `${streak}-day study streak 🔥` : "Start a session to build your streak"}
          </p>
        </div>

        {/* Score Estimate */}
        <div className="bg-as-primary rounded-[2rem] p-7 flex flex-col justify-between relative overflow-hidden shadow-xl">
          <div className="absolute -top-8 -right-8 w-32 h-32 bg-white/5 rounded-full blur-2xl" />
          <div className="flex justify-between items-start mb-5 relative">
            <span className="text-[10px] font-bold text-as-primary-fixed uppercase tracking-widest">Est. Score Range</span>
            <svg className="w-5 h-5 text-as-primary-fixed" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
            </svg>
          </div>
          {totalQuestions > 0 ? (
            <div className="flex items-baseline gap-1.5 relative">
              <span className="text-5xl font-bold text-white">{scoreLow}</span>
              <span className="text-2xl text-white/50 font-serif">—</span>
              <span className="text-5xl font-bold text-white">{scoreHigh}</span>
            </div>
          ) : (
            <span className="text-3xl font-bold text-white/40 relative">No data yet</span>
          )}
          <div className="mt-5 relative">
            <div className="h-1.5 w-full bg-white/10 rounded-full overflow-hidden">
              <div className="h-full bg-as-primary-fixed rounded-full transition-all duration-1000"
                style={{ width: `${Math.min(overallAccuracy, 100)}%` }} />
            </div>
            <div className="flex justify-between mt-2 text-[10px] font-bold uppercase tracking-tighter text-white/50">
              <span>Based on accuracy</span>
              <span>Target: 520</span>
            </div>
          </div>
        </div>
      </div>

      {/* ── Accuracy Over Time (full width) ── */}
      <div className="mb-6">

        {/* Accuracy Over Time */}
        <div className="bg-as-surface-container-low rounded-[2.5rem] p-8 border border-transparent hover:border-as-outline-variant/20 transition-all duration-700">
          <div className="flex items-start justify-between mb-8 gap-4">
            <div>
              <h2 className="font-headline text-2xl font-bold text-as-primary mb-1">Accuracy Over Time</h2>
              <p className="text-xs text-as-outline">Weekly accuracy rate — weeks with fewer than 5 questions are excluded</p>
            </div>

            {/* Section filter dropdown */}
            <div className="relative shrink-0">
              <button
                onClick={() => setSectionDropdownOpen((v) => !v)}
                className="flex items-center gap-2 bg-as-surface-container px-4 py-2 rounded-xl text-[11px] font-bold uppercase tracking-wider text-as-primary hover:bg-as-surface-container-highest transition-colors"
              >
                <span>
                  {chartSection === "all" ? "All Subjects" : SECTION_LABELS[chartSection] ?? chartSection}
                </span>
                <svg className={`w-3 h-3 transition-transform ${sectionDropdownOpen ? "rotate-180" : ""}`} fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path d="M6 9l6 6 6-6" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </button>
              {sectionDropdownOpen && (
                <div className="absolute right-0 top-full mt-2 z-20 bg-white rounded-2xl shadow-xl border border-as-outline-variant/20 min-w-[180px] overflow-hidden">
                  {[
                    { value: "all", label: "All Subjects" },
                    { value: "bio_biochem", label: "Biology & Biochem" },
                    { value: "chem_phys", label: "Physical Sciences" },
                    { value: "psych_soc", label: "Behavioral Sciences" },
                    { value: "cars", label: "CARS (Reading)" },
                  ].map(({ value, label }) => (
                    <button
                      key={value}
                      onClick={() => { setChartSection(value); setSectionDropdownOpen(false); }}
                      className={`w-full text-left px-4 py-3 text-[11px] font-bold uppercase tracking-wider transition-colors ${
                        chartSection === value
                          ? "bg-as-primary text-white"
                          : "text-as-primary hover:bg-as-surface-container"
                      }`}
                    >
                      {label}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>

          {chartPoints.length < 2 ? (
            <div className="h-48 flex items-center justify-center text-sm text-as-outline">
              Complete more sessions to see your accuracy chart.
            </div>
          ) : (
            <div className="flex gap-3">
              {/* Y-axis labels */}
              <div className="flex flex-col justify-between shrink-0 w-8 text-right" style={{ height: "220px" }}>
                {["100%", "75%", "50%", "25%", "0%"].map((label) => (
                  <span key={label} className="text-[10px] font-bold text-as-outline leading-none">{label}</span>
                ))}
              </div>

              {/* Chart area */}
              <div className="flex-1 min-w-0">
                <svg className="w-full overflow-visible" viewBox="0 0 1000 300" preserveAspectRatio="none" style={{ height: "220px" }}>
                  <defs>
                    <linearGradient id="area-grad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="0%" stopColor="#003630" stopOpacity="0.18" />
                      <stop offset="100%" stopColor="#003630" stopOpacity="0" />
                    </linearGradient>
                  </defs>
                  {/* Grid lines at 0 / 25 / 50 / 75 / 100 % */}
                  {[20, 85, 150, 215, 280].map((y) => (
                    <line key={y} x1="0" x2="1000" y1={y} y2={y}
                      stroke="#bfc9c5" strokeWidth="0.8" opacity="0.5" />
                  ))}
                  {/* Area fill */}
                  <path d={areaPath} fill="url(#area-grad)" />
                  {/* Line */}
                  <path d={linePath} fill="none" stroke="#003630" strokeWidth="4"
                    strokeLinecap="round" strokeLinejoin="round"
                    style={{ strokeDasharray: 2000, strokeDashoffset: 2000, animation: "chartDash 2s ease-in-out forwards" }} />
                  {/* Data point dots */}
                  {chartPoints.map(([x, y], i) => (
                    <circle key={i} cx={x} cy={y} r="6" fill="#003630" />
                  ))}
                </svg>
                <style>{`@keyframes chartDash { to { stroke-dashoffset: 0; } }`}</style>
                {/* X-axis labels */}
                <div className="flex justify-between mt-3 text-[10px] font-bold text-as-outline uppercase tracking-widest">
                  <span>{chartWeekLabels[0]}</span>
                  {chartWeekLabels.length > 2 && (
                    <span>{chartWeekLabels[Math.floor(chartWeekLabels.length / 2)]}</span>
                  )}
                  <span>{chartWeekLabels[chartWeekLabels.length - 1]}</span>
                </div>
              </div>
            </div>
          )}
        </div>

      </div>

      {/* ── Focus Insight (full width, includes report cards) ── */}
      <div className="bg-as-surface-container-highest rounded-[2.5rem] p-8 mb-8 relative overflow-hidden">
        <div className="absolute top-6 right-8 opacity-[0.05] pointer-events-none">
          <svg className="w-32 h-32 text-as-primary" fill="currentColor" viewBox="0 0 24 24">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/>
          </svg>
        </div>

        <div className="relative">
          <h2 className="font-headline text-3xl font-bold text-as-primary italic mb-6">
            Focus Insight
          </h2>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

            {/* Weakest Area + Strategy */}
            <div className="flex flex-col gap-4">
              {weakestTopic ? (
                <>
                  <div>
                    <p className="text-[10px] font-bold uppercase tracking-widest text-as-primary mb-2">
                      Weakest Area
                    </p>
                    <p className="text-sm leading-relaxed text-as-on-surface-variant">
                      Your accuracy in{" "}
                      <span className="font-bold text-as-primary">{weakestTopic.subtopic}</span>{" "}
                      is {weakestTopic.accuracy}% — your lowest-scoring topic right now.
                      Targeting it directly will have the most impact on your overall score.
                    </p>
                  </div>
                  <div className="p-4 bg-white/40 rounded-2xl border border-white/60">
                    <div className="flex items-center gap-2 text-as-primary font-bold text-xs mb-1.5">
                      <svg className="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M9 21c0 .55.45 1 1 1h4c.55 0 1-.45 1-1v-1H9v1zm3-19C8.14 2 5 5.14 5 9c0 2.38 1.19 4.47 3 5.74V17c0 .55.45 1 1 1h6c.55 0 1-.45 1-1v-2.26c1.81-1.27 3-3.36 3-5.74 0-3.86-3.14-7-7-7z"/>
                      </svg>
                      <span>Recommended Strategy</span>
                    </div>
                    <p className="text-xs text-as-on-surface-variant leading-relaxed">
                      Filter practice sessions to {SECTION_LABELS[weakestTopic.section] || weakestTopic.section} and set difficulty to Easy first — build the foundation before attempting hard questions on this topic.
                    </p>
                  </div>
                </>
              ) : (
                <p className="text-sm text-as-outline">
                  Answer at least 3 questions per topic to unlock personalised insights.
                </p>
              )}
            </div>

            {/* Daily Report Card */}
            <Link
              href="/dashboard/analytics/daily"
              className="group bg-white/50 backdrop-blur rounded-[1.75rem] p-6 flex flex-col justify-between hover:bg-white/80 transition-all duration-300 cursor-pointer border border-white/60"
            >
              <div>
                <div className="flex items-start justify-between mb-3">
                  <h3 className="font-headline text-xl font-bold text-as-primary">Daily Report</h3>
                  {hasDailyReport && (
                    <span className="text-[10px] font-bold uppercase tracking-wide bg-as-primary/10 text-as-primary px-2.5 py-1 rounded-full">
                      Ready
                    </span>
                  )}
                </div>
                <p className="text-[11px] text-as-outline uppercase tracking-wider mb-3">Last 24 hours</p>
                <p className="text-sm text-as-on-surface-variant leading-relaxed mb-5">
                  Today&apos;s accuracy, section performance, and a personalised coach analysis.
                </p>
              </div>
              <div className="flex items-center gap-2 text-as-primary font-bold text-xs uppercase tracking-widest group-hover:gap-3 transition-all">
                <span>{hasDailyReport ? "View Report" : "Generate"}</span>
                <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path d="M5 12h14M12 5l7 7-7 7" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </div>
            </Link>

            {/* Weekly Report Card */}
            <Link
              href="/dashboard/analytics/weekly"
              className="group bg-white/50 backdrop-blur rounded-[1.75rem] p-6 flex flex-col justify-between hover:bg-white/80 transition-all duration-300 cursor-pointer border border-white/60"
            >
              <div>
                <div className="flex items-start justify-between mb-3">
                  <h3 className="font-headline text-xl font-bold text-as-primary">Weekly Report</h3>
                  {hasWeeklyReport && (
                    <span className="text-[10px] font-bold uppercase tracking-wide bg-as-primary/10 text-as-primary px-2.5 py-1 rounded-full">
                      Ready
                    </span>
                  )}
                </div>
                <p className="text-[11px] text-as-outline uppercase tracking-wider mb-3">Last 7 days</p>
                <p className="text-sm text-as-on-surface-variant leading-relaxed mb-5">
                  Daily accuracy trend, topics ranked by priority, and a 5-part study plan.
                </p>
              </div>
              <div className="flex items-center gap-2 text-as-primary font-bold text-xs uppercase tracking-widest group-hover:gap-3 transition-all">
                <span>{hasWeeklyReport ? "View Report" : "Generate"}</span>
                <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path d="M5 12h14M12 5l7 7-7 7" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </div>
            </Link>
          </div>
        </div>
      </div>

      {/* ── Subject Mastery + Difficulty ── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">

        {/* Subject Mastery */}
        <div className="bg-as-surface-container-lowest rounded-[2.5rem] p-8 shadow-sm border border-as-outline-variant/10">
          <div className="flex items-center justify-between mb-8">
            <h2 className="font-headline text-2xl font-bold text-as-primary">Subject Mastery</h2>
            <span className="text-[10px] font-bold text-as-outline bg-as-surface-container px-3 py-1 rounded-full uppercase tracking-widest">
              {period === "7d" ? "Last Week" : period === "30d" ? "30 Days" : period === "custom" && customFrom && customTo ? `${customFrom} – ${customTo}` : "All Time"}
            </span>
          </div>

          {sectionStats.length === 0 ? (
            <p className="text-sm text-as-outline text-center py-8">
              Answer practice questions to see your section breakdown.
            </p>
          ) : (
            <div className="space-y-7">
              {sectionStats.map((s) => (
                <div key={s.section} className="space-y-2">
                  <div className="flex justify-between items-end">
                    <span className="font-bold text-as-primary text-sm uppercase tracking-wide">
                      {s.label}
                    </span>
                    <span className="font-headline italic text-xl font-bold text-as-primary">
                      {s.accuracy}%
                    </span>
                  </div>
                  <div className="h-2 w-full bg-as-surface-container rounded-full overflow-hidden">
                    <div
                      className="h-full bg-as-primary rounded-full transition-all duration-1000"
                      style={{ width: `${s.accuracy}%` }}
                    />
                  </div>
                  <p className="text-[10px] text-as-outline">{s.correct}/{s.total} correct</p>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Difficulty Breakdown */}
        <div className="bg-as-surface-container-highest rounded-[2.5rem] p-8 flex flex-col justify-between">
          <div>
            <h2 className="font-headline text-2xl font-bold text-as-primary mb-8">Intensity Analysis</h2>

            {diffStats.every((d) => d.total === 0) ? (
              <p className="text-sm text-as-outline text-center py-8">
                Complete practice sessions to see difficulty breakdown.
              </p>
            ) : (
              <div className="flex items-center justify-around py-4">
                {diffStats.map((d) => (
                  <DonutRing key={d.label} pct={d.accuracy} label={d.label} />
                ))}
              </div>
            )}
          </div>

          <div className="mt-6 flex items-start gap-3 bg-white/30 p-5 rounded-[1.5rem]">
            <svg className="w-5 h-5 text-as-primary shrink-0 mt-0.5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M13 2.003A10 10 0 1 0 22 12c0-.173-.01-.344-.025-.512A10 10 0 0 0 13 2.003zM11 17v-6h2v6h-2zm0-8V7h2v2h-2z"/>
            </svg>
            <div>
              <h3 className="text-sm font-bold text-as-primary mb-1">Stamina Note</h3>
              <p className="text-xs text-as-on-surface-variant leading-relaxed">
                {diffStats[2]?.accuracy < 60 && diffStats[2]?.total > 0
                  ? `Hard question accuracy is ${diffStats[2].accuracy}%. Schedule difficult drills during your highest-energy study block.`
                  : diffStats[2]?.total > 0
                  ? `Strong performance on hard questions at ${diffStats[2].accuracy}%. Keep up the high-difficulty practice.`
                  : "Attempt harder difficulty questions to see your intensity breakdown."}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* ── Topic Mastery ── */}
      <div className="bg-as-surface-container-lowest rounded-[2.5rem] p-8 border border-as-outline-variant/10">
        <div className="flex items-end justify-between mb-6">
          <div>
            <h2 className="font-headline text-2xl font-bold text-as-primary mb-1">Topic Mastery</h2>
            <p className="text-xs text-as-outline">Weakest topics first — these are your highest-leverage study targets</p>
          </div>
          {subtopicStats.length > 0 && (
            <span className="text-[10px] font-bold text-as-outline bg-as-surface-container px-3 py-1 rounded-full uppercase tracking-widest">
              {subtopicStats.length} topics
            </span>
          )}
        </div>

        {subtopicStats.length === 0 ? (
          <p className="text-sm text-as-outline text-center py-8">
            Answer at least 3 questions per topic to see mastery data.
          </p>
        ) : (
          <div className="space-y-0">
            {subtopicStats.map((s) => {
              const accuracy = s.accuracy;
              const isStrong = accuracy >= 80;
              const isDeveloping = accuracy >= 60 && accuracy < 80;

              return (
                <div
                  key={`${s.section}::${s.subtopic}`}
                  className="flex items-center gap-4 py-3.5 border-b border-as-outline-variant/10 last:border-0 group"
                >
                  {/* Accuracy bar indicator */}
                  <div className="w-1 h-8 rounded-full bg-as-surface-container overflow-hidden shrink-0">
                    <div
                      className="w-full bg-as-primary rounded-full transition-all duration-700"
                      style={{ height: `${accuracy}%`, marginTop: `${100 - accuracy}%` }}
                    />
                  </div>

                  {/* Topic info */}
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium text-as-primary truncate">
                      {s.subtopic.replace(/_/g, " ")}
                    </p>
                    <p className="text-[10px] text-as-outline">
                      {SECTION_LABELS[s.section] || s.section} · {s.correct}/{s.total} correct
                    </p>
                  </div>

                  {/* Accuracy + badge */}
                  <div className="flex items-center gap-2.5 shrink-0">
                    <span className="font-headline italic text-lg font-bold text-as-primary">
                      {accuracy}%
                    </span>
                    <span className={`text-[10px] font-bold px-2.5 py-1 rounded-full uppercase tracking-wide ${
                      isStrong
                        ? "bg-as-primary/10 text-as-primary"
                        : isDeveloping
                        ? "bg-as-surface-tint/15 text-as-surface-tint"
                        : "bg-red-50 text-red-600"
                    }`}>
                      {isStrong ? "Strong" : isDeveloping ? "Developing" : "Focus Here"}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>

      <div className="h-16" />
    </div>
  );
}
