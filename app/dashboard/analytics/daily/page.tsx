"use client";

import { useEffect, useState } from "react";
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

interface SavedReport {
  report_text: string;
  raw_metrics_json: ReportMetrics | null;
  created_at: string;
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

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
    <div className="flex items-center gap-3 py-3 border-b border-as-outline-variant/10 last:border-0">
      <div className="flex-1 min-w-0">
        <p className="text-sm font-medium text-as-primary truncate">{topic.subtopic.replace(/_/g, " ")}</p>
        <p className="text-[10px] text-as-outline">
          {SECTION_LABELS[topic.section] || topic.section} · {topic.attempts} attempts
        </p>
      </div>
      <div className="w-24 shrink-0">
        <div className="h-1.5 w-full bg-as-surface-container rounded-full overflow-hidden mb-1">
          <div
            className="h-full bg-as-primary rounded-full transition-all duration-700"
            style={{ width: `${pct}%` }}
          />
        </div>
        <p className="text-[10px] text-right text-as-outline">{pct}%</p>
      </div>
      <span
        className={`text-[10px] font-bold px-2.5 py-1 rounded-full uppercase tracking-wide shrink-0 ${
          STATUS_COLORS[topic.status] || STATUS_COLORS["Insufficient Data"]
        }`}
      >
        {topic.status}
      </span>
    </div>
  );
}

function DonutRing({ pct, label }: { pct: number; label: string }) {
  const r = 32;
  const circ = 2 * Math.PI * r;
  const offset = circ * (1 - pct / 100);
  return (
    <div className="flex flex-col items-center gap-2">
      <div className="relative w-20 h-20">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 80 80">
          <circle cx="40" cy="40" r={r} fill="none" stroke="currentColor" strokeWidth="8" className="text-as-outline-variant/20" />
          <circle cx="40" cy="40" r={r} fill="none" stroke="currentColor" strokeWidth="8" strokeLinecap="round"
            strokeDasharray={circ} strokeDashoffset={offset} className="text-as-primary transition-all duration-1000" />
        </svg>
        <span className="absolute inset-0 flex items-center justify-center font-bold text-base text-as-primary">
          {pct > 0 ? `${pct}%` : "—"}
        </span>
      </div>
      <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">{label}</span>
    </div>
  );
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function DailyReportPage() {
  const { user } = useDashboard();
  const [report, setReport] = useState<SavedReport | null>(null);
  const [loading, setLoading] = useState(true);
  const [generating, setGenerating] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadReport() {
      const { data } = await supabase
        .from("performance_reports")
        .select("report_text, raw_metrics_json, created_at")
        .eq("user_id", user.id)
        .eq("report_type", "daily")
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      setReport(data as SavedReport | null);
      setLoading(false);
    }
    loadReport();
  }, [user.id]);

  async function generate() {
    setGenerating(true);
    setError(null);
    try {
      const {
        data: { session },
      } = await supabase.auth.getSession();
      if (!session) throw new Error("Not authenticated");
      const res = await fetch("/api/reports/daily", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId: user.id, accessToken: session.access_token }),
      });
      if (!res.ok) throw new Error(await res.text());
      const { data: fresh } = await supabase
        .from("performance_reports")
        .select("report_text, raw_metrics_json, created_at")
        .eq("user_id", user.id)
        .eq("report_type", "daily")
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      setReport(fresh as SavedReport | null);
    } catch (e: unknown) {
      setError(e instanceof Error ? e.message : "Failed to generate report");
    } finally {
      setGenerating(false);
    }
  }

  const metrics = report?.raw_metrics_json ?? null;
  const sections = metrics
    ? Object.entries(metrics.section_breakdown).filter(([, v]) => v.attempts > 0)
    : [];

  const parsedSections = report?.report_text ? parseReportSections(report.report_text) : [];

  const reportDate = report?.created_at
    ? new Date(report.created_at).toLocaleDateString("en-US", {
        weekday: "long",
        month: "long",
        day: "numeric",
      })
    : "Today";

  // Difficulty breakdown from subtopics
  const allTopics = metrics?.subtopics ?? [];

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
              Daily Report
            </h1>
            {report && (
              <p className="text-sm text-as-outline mt-2">{reportDate}</p>
            )}
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
          <p className="text-as-outline text-sm mb-2">No daily report yet</p>
          <p className="text-as-outline/60 text-xs">Complete practice questions today, then generate your report.</p>
        </div>
      ) : (
        <>
          {/* ── Priority Banner ── */}
          {metrics?.top_priority && (
            <div className="bg-as-primary rounded-[2rem] p-7 mb-8 flex flex-col sm:flex-row sm:items-center justify-between gap-6 shadow-xl relative overflow-hidden">
              <div className="absolute -top-6 -right-6 w-40 h-40 bg-white/5 rounded-full blur-3xl" />
              <div className="relative">
                <span className="text-[10px] font-bold tracking-[0.2em] text-white/60 uppercase block mb-2">
                  Today&apos;s Top Priority
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
            {[
              { label: "Accuracy", value: metrics ? `${metrics.overall_accuracy}%` : "—" },
              { label: "Questions", value: metrics ? metrics.total_questions.toString() : "—" },
              {
                label: "Avg Time",
                value: metrics
                  ? metrics.avg_time_seconds >= 60
                    ? `${Math.floor(metrics.avg_time_seconds / 60)}m ${Math.round(metrics.avg_time_seconds % 60)}s`
                    : `${Math.round(metrics.avg_time_seconds)}s`
                  : "—",
              },
              { label: "Days Studied", value: metrics ? metrics.days_studied.toString() : "—" },
            ].map(({ label, value }) => (
              <div
                key={label}
                className="bg-as-surface-container-low rounded-[1.5rem] p-5 flex flex-col gap-1"
              >
                <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">{label}</span>
                <span className="text-3xl font-bold text-as-primary">{value}</span>
              </div>
            ))}
          </div>

          {/* ── Charts Row ── */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">

            {/* Section Accuracy */}
            <div className="bg-as-surface-container-lowest rounded-[2.5rem] p-7 sm:p-8 border border-as-outline-variant/10">
              <h2 className="font-headline text-xl font-bold text-as-primary mb-6">Section Accuracy</h2>
              {sections.length === 0 ? (
                <p className="text-sm text-as-outline text-center py-8">No section data for this period.</p>
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

            {/* Difficulty Breakdown */}
            <div className="bg-as-surface-container-highest rounded-[2.5rem] p-7 sm:p-8 flex flex-col justify-between">
              <h2 className="font-headline text-xl font-bold text-as-primary mb-6">Difficulty Breakdown</h2>
              {allTopics.length === 0 ? (
                <p className="text-sm text-as-outline text-center py-8">No topic data yet.</p>
              ) : (() => {
                // Compute difficulty accuracy from subtopics data
                const easy = allTopics.filter((t) => t.difficulty_adjusted_accuracy > 0);
                const byDiff = [
                  { label: "Easy", pct: metrics?.overall_accuracy ?? 0 },
                  { label: "Medium", pct: easy.length > 0 ? Math.round(easy.reduce((s, t) => s + t.difficulty_adjusted_accuracy, 0) / easy.length) : 0 },
                  { label: "Hard", pct: easy.length > 0 ? Math.round(easy.filter((t) => t.struggle_score > 50).reduce((s, t, _, a) => s + t.accuracy / a.length, 0)) : 0 },
                ];
                return (
                  <div className="flex items-center justify-around py-4 flex-1">
                    {byDiff.map((d) => (
                      <DonutRing key={d.label} pct={d.pct} label={d.label} />
                    ))}
                  </div>
                );
              })()}
              {metrics && (
                <div className="mt-4 bg-white/30 rounded-[1.25rem] p-4 text-xs text-as-on-surface-variant leading-relaxed">
                  {metrics.avg_time_seconds > 110
                    ? `Avg ${Math.round(metrics.avg_time_seconds)}s per question — above the 110s benchmark. Focus on pacing.`
                    : metrics.avg_time_seconds < 45
                    ? `Avg ${Math.round(metrics.avg_time_seconds)}s per question — very fast. Check you&apos;re reading questions fully.`
                    : `Avg ${Math.round(metrics.avg_time_seconds)}s per question — within normal range.`}
                </div>
              )}
            </div>
          </div>

          {/* ── Topic Breakdown ── */}
          {(metrics?.struggling.length || metrics?.strong.length) ? (
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
              {/* Struggling */}
              <div className="bg-as-surface-container-low rounded-[2.5rem] p-7 sm:p-8 border border-red-100">
                <h2 className="font-headline text-xl font-bold text-as-primary mb-1">Needs Work</h2>
                <p className="text-[11px] text-as-outline mb-5">
                  {metrics?.struggling.length || 0} topic{metrics?.struggling.length !== 1 ? "s" : ""} flagged
                </p>
                {metrics?.struggling.length === 0 ? (
                  <p className="text-sm text-as-outline text-center py-6">No struggling topics today.</p>
                ) : (
                  <div>
                    {(metrics?.struggling ?? []).map((t) => (
                      <TopicRow key={`${t.section}::${t.subtopic}`} topic={t} />
                    ))}
                  </div>
                )}
              </div>

              {/* Strong */}
              <div className="bg-as-surface-container-low rounded-[2.5rem] p-7 sm:p-8 border border-emerald-100">
                <h2 className="font-headline text-xl font-bold text-as-primary mb-1">Strong Areas</h2>
                <p className="text-[11px] text-as-outline mb-5">
                  {metrics?.strong.length || 0} topic{metrics?.strong.length !== 1 ? "s" : ""} solid
                </p>
                {metrics?.strong.length === 0 ? (
                  <p className="text-sm text-as-outline text-center py-6">Keep building — strong topics will appear here.</p>
                ) : (
                  <div>
                    {(metrics?.strong ?? []).map((t) => (
                      <TopicRow key={`${t.section}::${t.subtopic}`} topic={t} />
                    ))}
                  </div>
                )}
              </div>
            </div>
          ) : null}

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

          {/* Fallback: plain text if sections couldn't be parsed */}
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
