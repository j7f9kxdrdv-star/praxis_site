"use client";

import { useEffect, useState, useMemo } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import type { SubtopicMetrics, ReportMetrics } from "@/lib/reports/metrics";

// ─── Constants ────────────────────────────────────────────────────────────────

const SECTION_LABELS: Record<string, string> = {
  bio_biochem: "Biology & Biochem",
  chem_phys: "Physical Sciences",
  psych_soc: "Behavioral Sciences",
  cars: "CARS",
};

const STATUS_COLORS: Record<string, string> = {
  Mastered: "bg-emerald-100 text-emerald-700",
  Stable: "bg-as-primary/10 text-as-primary",
  Developing: "bg-amber-50 text-amber-700",
  Struggling: "bg-red-50 text-red-600",
  Critical: "bg-red-100 text-red-700",
  "Insufficient Data": "bg-as-surface-container text-as-outline",
};

// ─── Types ────────────────────────────────────────────────────────────────────

interface DailyAttempt {
  is_correct: boolean;
  created_at: string;
}

interface SavedReport {
  report_text: string;
  raw_metrics_json: ReportMetrics | null;
  created_at: string;
}

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

function parseReportSections(text: string): { title: string; body: string }[] {
  const sections: { title: string; lines: string[] }[] = [];
  let current: { title: string; lines: string[] } | null = null;
  for (const line of text.split("\n")) {
    const match = line.trim().match(/^\*{0,2}(\d+)\.\s+(.+?)\*{0,2}$/);
    if (match) {
      if (current) sections.push(current);
      current = { title: match[2].trim(), lines: [] };
    } else if (current) {
      current.lines.push(line);
    }
  }
  if (current) sections.push(current);
  return sections.map((s) => ({ title: s.title, body: s.lines.join("\n").trim() }));
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

// ─── Sub-components ───────────────────────────────────────────────────────────

function ReportSection({ number, title, body }: { number: number; title: string; body: string }) {
  return (
    <div className="bg-as-surface-container-low rounded-[1.75rem] p-6 sm:p-7">
      <div className="flex items-center gap-3 mb-4">
        <span className="w-8 h-8 rounded-full bg-as-primary text-white text-xs font-bold flex items-center justify-center shrink-0">
          {number}
        </span>
        <h3 className="font-headline text-lg font-bold text-as-primary">{title}</h3>
      </div>
      <div className="space-y-2 text-sm text-as-on-surface-variant leading-relaxed pl-11">
        {body.split("\n").map((line, i) => {
          const t = line.trim();
          if (!t) return null;
          if (t.startsWith("- ") || t.startsWith("• ")) {
            return (
              <div key={i} className="flex items-start gap-2.5">
                <span className="text-as-primary font-bold shrink-0 mt-0.5">—</span>
                <span>{t.replace(/^[-•]\s+/, "")}</span>
              </div>
            );
          }
          return <p key={i}>{t}</p>;
        })}
      </div>
    </div>
  );
}

function SectionBar({ label, accuracy, attempts }: { label: string; accuracy: number; attempts: number }) {
  const color =
    accuracy >= 80 ? "bg-as-primary" : accuracy >= 65 ? "bg-amber-500" : "bg-red-500";
  return (
    <div className="space-y-1.5">
      <div className="flex items-center justify-between">
        <span className="text-xs font-bold text-as-primary uppercase tracking-wide">{label}</span>
        <div className="flex items-center gap-2">
          <span className="text-[10px] text-as-outline">{attempts} Qs</span>
          <span className="font-headline italic font-bold text-lg text-as-primary">{accuracy}%</span>
        </div>
      </div>
      <div className="h-2 w-full bg-as-surface-container rounded-full overflow-hidden">
        <div
          className={`h-full ${color} rounded-full transition-all duration-1000`}
          style={{ width: `${accuracy}%` }}
        />
      </div>
    </div>
  );
}

function TopicRow({ topic }: { topic: SubtopicMetrics }) {
  const pct = topic.accuracy;
  return (
    <div className="flex items-center gap-3 py-3.5 border-b border-as-outline-variant/10 last:border-0">
      <div className="flex-1 min-w-0">
        <p className="text-sm font-medium text-as-primary truncate">{topic.subtopic.replace(/_/g, " ")}</p>
        <p className="text-[10px] text-as-outline">
          {SECTION_LABELS[topic.section] || topic.section} · {topic.attempts} attempts ·{" "}
          {topic.days_since_last_practiced === 0
            ? "practiced today"
            : `${topic.days_since_last_practiced}d ago`}
        </p>
      </div>
      <div className="w-20 shrink-0">
        <div className="h-1.5 w-full bg-as-surface-container rounded-full overflow-hidden mb-1">
          <div
            className="h-full bg-as-primary rounded-full transition-all duration-700"
            style={{ width: `${pct}%` }}
          />
        </div>
        <p className="text-[10px] text-right text-as-outline">{pct}%</p>
      </div>
      <div className="shrink-0 flex flex-col items-end gap-1">
        <span
          className={`text-[10px] font-bold px-2.5 py-1 rounded-full uppercase tracking-wide ${
            STATUS_COLORS[topic.status] || STATUS_COLORS["Insufficient Data"]
          }`}
        >
          {topic.status}
        </span>
        {topic.priority_score > 0 && (
          <span className="text-[10px] text-as-outline">P: {topic.priority_score}</span>
        )}
      </div>
    </div>
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function WeeklyReportPage() {
  const { user } = useDashboard();
  const [report, setReport] = useState<SavedReport | null>(null);
  const [weekAttempts, setWeekAttempts] = useState<DailyAttempt[]>([]);
  const [loading, setLoading] = useState(true);
  const [generating, setGenerating] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadData() {
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

      const [{ data: reportData }, { data: attemptsData }] = await Promise.all([
        supabase
          .from("performance_reports")
          .select("report_text, raw_metrics_json, created_at")
          .eq("user_id", user.id)
          .eq("report_type", "weekly")
          .order("created_at", { ascending: false })
          .limit(1)
          .maybeSingle(),
        supabase
          .from("question_attempts")
          .select("is_correct, created_at")
          .eq("user_id", user.id)
          .gte("created_at", sevenDaysAgo.toISOString()),
      ]);

      setReport(reportData as SavedReport | null);
      setWeekAttempts((attemptsData as DailyAttempt[]) ?? []);
      setLoading(false);
    }
    loadData();
  }, [user.id]);

  async function generate() {
    setGenerating(true);
    setError(null);
    try {
      const {
        data: { session },
      } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");
      const res = await fetch("/api/reports/weekly", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId: user.id, accessToken: session.access_token }),
      });
      if (!res.ok) throw new Error(await res.text());
      const [{ data: fresh }, { data: attemptsData }] = await Promise.all([
        supabase
          .from("performance_reports")
          .select("report_text, raw_metrics_json, created_at")
          .eq("user_id", user.id)
          .eq("report_type", "weekly")
          .order("created_at", { ascending: false })
          .limit(1)
          .maybeSingle(),
        supabase
          .from("question_attempts")
          .select("is_correct, created_at")
          .eq("user_id", user.id)
          .gte(
            "created_at",
            new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString()
          ),
      ]);
      setReport(fresh as SavedReport | null);
      setWeekAttempts((attemptsData as DailyAttempt[]) ?? []);
    } catch (e: unknown) {
      setError(e instanceof Error ? e.message : "Failed to generate report");
    } finally {
      setGenerating(false);
    }
  }

  // ── Derived data ─────────────────────────────────────────────────────────

  const metrics = report?.raw_metrics_json ?? null;

  // Build 7-day trend from raw attempts
  const { trendPoints, trendLabels } = useMemo(() => {
    if (weekAttempts.length === 0)
      return { trendPoints: [] as [number, number][], trendLabels: [] as string[] };

    const dayMap = new Map<string, { total: number; correct: number }>();
    for (let i = 6; i >= 0; i--) {
      const d = new Date();
      d.setDate(d.getDate() - i);
      const key = d.toISOString().split("T")[0];
      dayMap.set(key, { total: 0, correct: 0 });
    }

    weekAttempts.forEach((a) => {
      const key = a.created_at.split("T")[0];
      const entry = dayMap.get(key);
      if (!entry) return;
      entry.total++;
      if (a.is_correct) entry.correct++;
    });

    const activeDays = Array.from(dayMap.entries()).filter(([, v]) => v.total > 0);
    if (activeDays.length < 2) return { trendPoints: [], trendLabels: [] };

    const X_START = 0, X_END = 1000, Y_TOP = 20, Y_BOT = 260;
    const points: [number, number][] = activeDays.map(([, v], i) => {
      const acc = (v.correct / v.total) * 100;
      const x = activeDays.length === 1
        ? 500
        : X_START + (i / (activeDays.length - 1)) * (X_END - X_START);
      const y = Y_BOT - (acc / 100) * (Y_BOT - Y_TOP);
      return [x, y];
    });

    const labels = activeDays.map(([key]) =>
      new Date(key + "T00:00:00").toLocaleDateString("en-US", { weekday: "short", month: "short", day: "numeric" })
    );

    return { trendPoints: points, trendLabels: labels };
  }, [weekAttempts]);

  const linePath = buildSvgPath(trendPoints);
  const areaPath = buildAreaPath(trendPoints, 260);

  const parsedSections = report?.report_text ? parseReportSections(report.report_text) : [];

  const sections = metrics
    ? Object.entries(metrics.section_breakdown).filter(([, v]) => v.attempts > 0)
    : [];

  const [scoreLow, scoreHigh] = estimateScoreRange(metrics?.overall_accuracy ?? 0);

  const reportDateRange = metrics
    ? `${new Date(metrics.start_date + "T00:00:00").toLocaleDateString("en-US", { month: "short", day: "numeric" })} – ${new Date(metrics.end_date + "T00:00:00").toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" })}`
    : "Last 7 days";

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 py-8 sm:py-12">

      {/* ── Back + Header ── */}
      <div className="mb-10">
        <Link
          href="/dashboard/analytics"
          className="inline-flex items-center gap-2 text-[11px] font-bold uppercase tracking-wider text-as-outline hover:text-as-primary transition-colors mb-6"
        >
          <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
            <path d="M19 12H5M12 5l-7 7 7 7" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
          Back to Analytics
        </Link>

        <div className="flex flex-col sm:flex-row sm:items-end justify-between gap-6">
          <div>
            <span className="text-[10px] font-bold tracking-[0.2em] text-as-outline uppercase block mb-2">
              Performance Report
            </span>
            <h1 className="font-headline text-4xl sm:text-5xl font-bold text-as-primary leading-tight">
              Weekly Report
            </h1>
            <p className="text-sm text-as-outline mt-2">{reportDateRange}</p>
          </div>
          <button
            onClick={generate}
            disabled={generating}
            className="self-start sm:self-auto flex items-center gap-2 px-6 py-3 bg-as-primary text-white text-xs font-bold uppercase tracking-wider rounded-2xl disabled:opacity-50 hover:opacity-90 transition-opacity shadow-lg"
          >
            {generating ? (
              <>
                <div className="w-3.5 h-3.5 border-2 border-white/40 border-t-white rounded-full animate-spin" />
                Generating…
              </>
            ) : (
              <>
                <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2} viewBox="0 0 24 24">
                  <path d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
                Generate New Report
              </>
            )}
          </button>
        </div>
      </div>

      {error && (
        <div className="bg-red-50 text-red-600 text-sm px-5 py-3 rounded-2xl mb-6">{error}</div>
      )}

      {!report ? (
        <div className="bg-as-surface-container-low rounded-[2.5rem] p-12 text-center">
          <svg className="w-12 h-12 text-as-outline/30 mx-auto mb-4" fill="none" stroke="currentColor" strokeWidth={1.5} viewBox="0 0 24 24">
            <path d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
          <p className="text-as-outline text-sm mb-2">No weekly report yet</p>
          <p className="text-as-outline/60 text-xs">Study this week, then generate your weekly breakdown.</p>
        </div>
      ) : (
        <>
          {/* ── Priority Banner ── */}
          {metrics?.top_priority && (
            <div className="bg-as-primary rounded-[2rem] p-7 mb-8 flex flex-col sm:flex-row sm:items-center justify-between gap-6 shadow-xl relative overflow-hidden">
              <div className="absolute -top-6 -right-6 w-40 h-40 bg-white/5 rounded-full blur-3xl" />
              <div className="relative">
                <span className="text-[10px] font-bold tracking-[0.2em] text-white/60 uppercase block mb-2">
                  This Week&apos;s Top Priority
                </span>
                <p className="font-headline text-2xl sm:text-3xl font-bold text-white">
                  {metrics.top_priority.subtopic}
                </p>
                <p className="text-sm text-white/70 mt-1">
                  {SECTION_LABELS[metrics.top_priority.section] || metrics.top_priority.section}
                  {metrics.top_priority.top_priority_reason
                    ? ` · ${metrics.top_priority.top_priority_reason}`
                    : ""}
                </p>
              </div>
              <div className="relative shrink-0 flex flex-col items-center gap-1">
                <span className="text-5xl font-bold text-white">{metrics.top_priority.priority_score}</span>
                <span className="text-[10px] font-bold text-white/50 uppercase tracking-widest">
                  Priority Score
                </span>
              </div>
            </div>
          )}

          {/* ── Metrics Row ── */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-8">
            <div className="bg-as-surface-container-low rounded-[1.5rem] p-5 flex flex-col gap-1">
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">Accuracy</span>
              <span className="text-3xl font-bold text-as-primary">
                {metrics ? `${metrics.overall_accuracy}%` : "—"}
              </span>
            </div>
            <div className="bg-as-surface-container-low rounded-[1.5rem] p-5 flex flex-col gap-1">
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">Questions</span>
              <span className="text-3xl font-bold text-as-primary">
                {metrics ? metrics.total_questions.toLocaleString() : "—"}
              </span>
            </div>
            <div className="bg-as-surface-container-low rounded-[1.5rem] p-5 flex flex-col gap-1">
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">Days Studied</span>
              <span className="text-3xl font-bold text-as-primary">
                {metrics ? `${metrics.days_studied}/7` : "—"}
              </span>
            </div>
            <div className="bg-as-primary rounded-[1.5rem] p-5 flex flex-col gap-1 relative overflow-hidden">
              <div className="absolute -top-4 -right-4 w-20 h-20 bg-white/5 rounded-full blur-xl" />
              <span className="text-[10px] font-bold uppercase tracking-widest text-white/60 relative">Est. Score</span>
              {metrics && metrics.overall_accuracy > 0 ? (
                <div className="flex items-baseline gap-1 relative">
                  <span className="text-2xl font-bold text-white">{scoreLow}</span>
                  <span className="text-sm text-white/50 font-serif">–</span>
                  <span className="text-2xl font-bold text-white">{scoreHigh}</span>
                </div>
              ) : (
                <span className="text-2xl font-bold text-white/40 relative">—</span>
              )}
            </div>
          </div>

          {/* ── Daily Trend Chart ── */}
          {trendPoints.length >= 2 && (
            <div className="bg-as-surface-container-low rounded-[2.5rem] p-7 sm:p-8 mb-8 border border-transparent hover:border-as-outline-variant/20 transition-all duration-700">
              <h2 className="font-headline text-xl font-bold text-as-primary mb-1">Daily Accuracy Trend</h2>
              <p className="text-xs text-as-outline mb-6">Accuracy per day over the past 7 days</p>
              <div className="flex gap-3">
                <div className="flex flex-col justify-between shrink-0 w-8 text-right" style={{ height: "180px" }}>
                  {["100%", "75%", "50%", "25%", "0%"].map((label) => (
                    <span key={label} className="text-[10px] font-bold text-as-outline leading-none">{label}</span>
                  ))}
                </div>
                <div className="flex-1 min-w-0">
                  <svg className="w-full overflow-visible" viewBox="0 0 1000 280" preserveAspectRatio="none" style={{ height: "180px" }}>
                    <defs>
                      <linearGradient id="week-area-grad" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stopColor="#003630" stopOpacity="0.18" />
                        <stop offset="100%" stopColor="#003630" stopOpacity="0" />
                      </linearGradient>
                    </defs>
                    {[20, 85, 150, 215, 260].map((y) => (
                      <line key={y} x1="0" x2="1000" y1={y} y2={y} stroke="#bfc9c5" strokeWidth="0.8" opacity="0.5" />
                    ))}
                    <path d={areaPath} fill="url(#week-area-grad)" />
                    <path
                      d={linePath}
                      fill="none"
                      stroke="#003630"
                      strokeWidth="4"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      style={{
                        strokeDasharray: 2000,
                        strokeDashoffset: 2000,
                        animation: "weekChartDash 2s ease-in-out forwards",
                      }}
                    />
                    {trendPoints.map(([x, y], i) => (
                      <g key={i}>
                        <circle cx={x} cy={y} r="8" fill="white" stroke="#003630" strokeWidth="3" />
                        <circle cx={x} cy={y} r="4" fill="#003630" />
                      </g>
                    ))}
                  </svg>
                  <style>{`@keyframes weekChartDash { to { stroke-dashoffset: 0; } }`}</style>
                  <div className="flex justify-between mt-3 text-[10px] font-bold text-as-outline uppercase tracking-widest">
                    <span>{trendLabels[0]}</span>
                    {trendLabels.length > 2 && (
                      <span className="hidden sm:block">{trendLabels[Math.floor(trendLabels.length / 2)]}</span>
                    )}
                    <span>{trendLabels[trendLabels.length - 1]}</span>
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* ── Section + Exam countdown ── */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">

            {/* Section Accuracy */}
            <div className="bg-as-surface-container-lowest rounded-[2.5rem] p-7 sm:p-8 border border-as-outline-variant/10">
              <h2 className="font-headline text-xl font-bold text-as-primary mb-6">Section Breakdown</h2>
              {sections.length === 0 ? (
                <p className="text-sm text-as-outline text-center py-8">No section data for this week.</p>
              ) : (
                <div className="space-y-5">
                  {sections.map(([key, val]) => (
                    <SectionBar
                      key={key}
                      label={SECTION_LABELS[key] || key}
                      accuracy={val.accuracy}
                      attempts={val.attempts}
                    />
                  ))}
                </div>
              )}
            </div>

            {/* Exam countdown + timing */}
            <div className="bg-as-surface-container-highest rounded-[2.5rem] p-7 sm:p-8 flex flex-col justify-between">
              <div>
                <h2 className="font-headline text-xl font-bold text-as-primary mb-6">Study Insights</h2>
                <div className="space-y-4">
                  {metrics?.exam_days_remaining != null && (
                    <div className="bg-white/30 rounded-2xl p-4">
                      <p className="text-[10px] font-bold uppercase tracking-widest text-as-primary mb-1">MCAT Countdown</p>
                      <p className="text-3xl font-bold text-as-primary">{metrics.exam_days_remaining}</p>
                      <p className="text-xs text-as-outline">days until your exam</p>
                    </div>
                  )}
                  <div className="bg-white/30 rounded-2xl p-4">
                    <p className="text-[10px] font-bold uppercase tracking-widest text-as-primary mb-1">Avg Time / Question</p>
                    <p className="text-3xl font-bold text-as-primary">
                      {metrics
                        ? metrics.avg_time_seconds >= 60
                          ? `${Math.floor(metrics.avg_time_seconds / 60)}m ${Math.round(metrics.avg_time_seconds % 60)}s`
                          : `${Math.round(metrics.avg_time_seconds)}s`
                        : "—"}
                    </p>
                    <p className="text-xs text-as-outline mt-1">
                      {metrics && metrics.avg_time_seconds > 110
                        ? "Above 110s target — pacing needs work"
                        : metrics && metrics.avg_time_seconds < 45
                        ? "Very fast — verify you&apos;re reading fully"
                        : "Within normal range"}
                    </p>
                  </div>
                  <div className="bg-white/30 rounded-2xl p-4">
                    <p className="text-[10px] font-bold uppercase tracking-widest text-as-primary mb-1">Study Consistency</p>
                    <div className="flex gap-1 mt-2">
                      {Array.from({ length: 7 }).map((_, i) => {
                        const d = new Date();
                        d.setDate(d.getDate() - (6 - i));
                        const key = d.toISOString().split("T")[0];
                        const hasActivity = weekAttempts.some((a) => a.created_at.startsWith(key));
                        return (
                          <div
                            key={i}
                            title={d.toLocaleDateString("en-US", { weekday: "short", month: "short", day: "numeric" })}
                            className={`flex-1 h-8 rounded-lg transition-colors ${
                              hasActivity ? "bg-as-primary" : "bg-as-surface-container"
                            }`}
                          />
                        );
                      })}
                    </div>
                    <p className="text-xs text-as-outline mt-2">
                      {metrics?.days_studied ?? 0} of 7 days active
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* ── Topic Breakdown ── */}
          {(metrics?.struggling.length || metrics?.strong.length) ? (
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
              {/* Struggling */}
              <div className="bg-as-surface-container-low rounded-[2.5rem] p-7 sm:p-8 border border-red-100">
                <h2 className="font-headline text-xl font-bold text-as-primary mb-1">Needs Work</h2>
                <p className="text-[11px] text-as-outline mb-5">
                  Sorted by priority score — drill these first
                </p>
                {metrics?.struggling.length === 0 ? (
                  <p className="text-sm text-as-outline text-center py-6">No struggling topics this week.</p>
                ) : (
                  <div>
                    {(metrics?.struggling ?? [])
                      .sort((a, b) => b.priority_score - a.priority_score)
                      .map((t) => (
                        <TopicRow key={`${t.section}::${t.subtopic}`} topic={t} />
                      ))}
                  </div>
                )}
              </div>

              {/* Strong */}
              <div className="bg-as-surface-container-low rounded-[2.5rem] p-7 sm:p-8 border border-emerald-100">
                <h2 className="font-headline text-xl font-bold text-as-primary mb-1">Strong Areas</h2>
                <p className="text-[11px] text-as-outline mb-5">
                  Keep these maintained — don&apos;t let them slip
                </p>
                {metrics?.strong.length === 0 ? (
                  <p className="text-sm text-as-outline text-center py-6">Keep building — strong topics will appear here.</p>
                ) : (
                  <div>
                    {(metrics?.strong ?? [])
                      .sort((a, b) => b.mastery_score - a.mastery_score)
                      .map((t) => (
                        <TopicRow key={`${t.section}::${t.subtopic}`} topic={t} />
                      ))}
                  </div>
                )}
              </div>
            </div>
          ) : null}

          {/* ── All Topics Table ── */}
          {metrics?.subtopics && metrics.subtopics.length > 0 && (
            <div className="bg-as-surface-container-lowest rounded-[2.5rem] p-7 sm:p-8 border border-as-outline-variant/10 mb-8">
              <div className="flex items-end justify-between mb-5">
                <div>
                  <h2 className="font-headline text-xl font-bold text-as-primary">All Topics This Week</h2>
                  <p className="text-xs text-as-outline mt-1">Weakest first</p>
                </div>
                <span className="text-[10px] font-bold text-as-outline bg-as-surface-container px-3 py-1 rounded-full uppercase tracking-widest">
                  {metrics.subtopics.length} topics
                </span>
              </div>
              <div>
                {[...metrics.subtopics]
                  .sort((a, b) => a.accuracy - b.accuracy)
                  .map((t) => (
                    <TopicRow key={`${t.section}::${t.subtopic}`} topic={t} />
                  ))}
              </div>
            </div>
          )}

          {/* ── AI Report Sections ── */}
          {parsedSections.length > 0 && (
            <div className="mb-8">
              <h2 className="font-headline text-2xl font-bold text-as-primary mb-5">Coach Analysis</h2>
              <div className="space-y-4">
                {parsedSections.map((s, i) => (
                  <ReportSection key={i} number={i + 1} title={s.title} body={s.body} />
                ))}
              </div>
            </div>
          )}

          {parsedSections.length === 0 && report?.report_text && (
            <div className="bg-as-surface-container-low rounded-[2.5rem] p-8 mb-8">
              <h2 className="font-headline text-2xl font-bold text-as-primary mb-5">Coach Analysis</h2>
              <p className="text-sm text-as-on-surface-variant leading-relaxed whitespace-pre-wrap">
                {report.report_text}
              </p>
            </div>
          )}
        </>
      )}

      <div className="h-16" />
    </div>
  );
}
