"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import MolecularBg from "@/components/dashboard/MolecularBg";

/* ---------------------------------------------------------------------- */
/* Types                                                                  */
/* ---------------------------------------------------------------------- */

interface Stats {
  streak: number;
  questionsThisWeek: number;
  totalQuestions: number;
  accuracy: number | null;
  weeklySpark: number[]; // 7 buckets, oldest → newest
  precisionSpark: number[]; // 7-day rolling accuracy
  weekDelta: number; // questions this week vs prev week
  precisionDelta: number; // percentage points vs last week
}

interface SubjectProgress {
  section: string;
  label: string;
  percent: number;
  attention: boolean;
}

interface FlashcardSummary {
  totalDue: number;
  urgent: number;
  soon: number;
  later: number;
  deckCount: number;
}

interface TodaysFocus {
  section: string;
  sectionLabel: string;
  topic: string;
  questionCount: number;
  estimatedMinutes: number;
  expectedGainPct: number;
  altLabel: string | null;
  altMinutes: number | null;
}

const SECTION_LABELS: Record<string, string> = {
  bio_biochem: "Biological Systems",
  chem_phys: "Physical Sciences",
  psych_soc: "Psychological Behavior",
  cars: "Critical Reasoning",
};

/* ---------------------------------------------------------------------- */
/* Helpers                                                                */
/* ---------------------------------------------------------------------- */

function getGreeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return "Good morning";
  if (hour < 17) return "Good afternoon";
  return "Good evening";
}

function todayLabel(): string {
  return new Date().toLocaleDateString("en-US", {
    weekday: "long",
    month: "long",
    day: "numeric",
  });
}

function startOfDayMs(d: Date): number {
  const c = new Date(d);
  c.setHours(0, 0, 0, 0);
  return c.getTime();
}

/* ---------------------------------------------------------------------- */
/* Sparkline (inline SVG)                                                 */
/* ---------------------------------------------------------------------- */

function Spark({
  points,
  color,
  width = 72,
  height = 22,
}: {
  points: number[];
  color: string;
  width?: number;
  height?: number;
}) {
  if (points.length === 0) {
    return <div style={{ width, height }} />;
  }
  const max = Math.max(...points, 1);
  const min = Math.min(...points, 0);
  const range = max - min || 1;
  const step = points.length > 1 ? width / (points.length - 1) : 0;
  const coords = points.map(
    (p, i) => [i * step, height - ((p - min) / range) * height] as [number, number]
  );
  const d = coords
    .map((c, i) => (i === 0 ? "M" : "L") + c[0].toFixed(1) + " " + c[1].toFixed(1))
    .join(" ");
  const area = d + ` L ${width} ${height} L 0 ${height} Z`;
  const last = coords[coords.length - 1];
  return (
    <svg width={width} height={height} style={{ display: "block" }}>
      <path d={area} fill={color} opacity="0.12" />
      <path
        d={d}
        fill="none"
        stroke={color}
        strokeWidth="1.4"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <circle cx={last[0]} cy={last[1]} r="2.2" fill={color} />
    </svg>
  );
}

/* ---------------------------------------------------------------------- */
/* Stat card                                                              */
/* ---------------------------------------------------------------------- */

function StatCard({
  label,
  value,
  unit,
  delta,
  deltaIsGood = true,
  spark,
  hint,
  empty,
  emptyCta,
  emptyHref,
}: {
  label: string;
  value: string;
  unit?: string;
  delta?: string;
  deltaIsGood?: boolean;
  spark?: number[];
  hint?: string;
  empty?: boolean;
  emptyCta?: string;
  emptyHref?: string;
}) {
  const card = (
    <div
      className="relative flex flex-1 min-w-0 flex-col rounded-xl px-[18px] pt-4 pb-3.5"
      style={{
        background: "var(--color-prax-cream-card)",
        border: "1px solid var(--color-prax-cream-border)",
      }}
    >
      <div className="flex items-baseline justify-between mb-2.5">
        <div
          className="font-semibold uppercase"
          style={{
            fontFamily: "var(--font-prax-sans)",
            fontSize: 10,
            letterSpacing: "0.2em",
            color: "var(--color-prax-ink-mute)",
          }}
        >
          {label}
        </div>
        {delta && (
          <div
            className="font-semibold"
            style={{
              fontFamily: "var(--font-prax-sans)",
              fontSize: 10.5,
              color: deltaIsGood
                ? "var(--color-prax-green-soft)"
                : "var(--color-prax-ink-mute)",
            }}
          >
            {delta}
          </div>
        )}
      </div>
      <div className="flex items-end justify-between gap-2.5">
        <div className="flex items-baseline gap-1">
          <div
            className="leading-none font-medium"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 30,
              color: empty
                ? "var(--color-prax-ink-mute)"
                : "var(--color-prax-green)",
              fontVariantNumeric: "tabular-nums lining-nums",
            }}
          >
            {value}
          </div>
          {unit && (
            <div
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 15,
                color: "var(--color-prax-ink-soft)",
              }}
            >
              {unit}
            </div>
          )}
        </div>
        {spark && <Spark points={spark} color="var(--color-prax-green-soft)" />}
      </div>
      <div
        className="mt-2"
        style={{
          fontFamily: "var(--font-prax-sans)",
          fontSize: 11,
          color: empty ? "var(--color-prax-gold)" : "var(--color-prax-ink-mute)",
          fontWeight: empty ? 600 : 400,
        }}
      >
        {empty ? emptyCta : hint}
      </div>
    </div>
  );
  return empty && emptyHref ? (
    <Link href={emptyHref} className="flex flex-1 min-w-0">
      {card}
    </Link>
  ) : (
    card
  );
}

/* ---------------------------------------------------------------------- */
/* Subject row                                                            */
/* ---------------------------------------------------------------------- */

function SubjectRow({
  name,
  value,
  attention,
}: {
  name: string;
  value: number;
  attention: boolean;
}) {
  return (
    <div className="mb-3.5">
      <div className="flex items-baseline justify-between mb-1.5">
        <div className="flex items-center gap-2">
          {attention && (
            <div
              className="rounded-full"
              style={{ width: 5, height: 5, background: "var(--color-prax-gold)" }}
            />
          )}
          <div
            style={{
              fontFamily: "var(--font-prax-sans)",
              fontSize: 12.5,
              color: "var(--color-prax-ink)",
              fontWeight: attention ? 600 : 500,
            }}
          >
            {name}
          </div>
        </div>
        <div
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 14,
            color: attention
              ? "var(--color-prax-gold)"
              : "var(--color-prax-green)",
            fontVariantNumeric: "tabular-nums lining-nums",
          }}
        >
          {value}
          <span style={{ fontSize: 11, color: "var(--color-prax-ink-mute)" }}>%</span>
        </div>
      </div>
      <div
        className="rounded-full overflow-hidden"
        style={{ height: 4, background: "var(--color-prax-cream-deep)" }}
      >
        <div
          className="h-full rounded-full"
          style={{
            width: `${value}%`,
            background: attention
              ? "var(--color-prax-gold)"
              : "var(--color-prax-green)",
          }}
        />
      </div>
    </div>
  );
}

/* ---------------------------------------------------------------------- */
/* Main page                                                              */
/* ---------------------------------------------------------------------- */

export default function DashboardHome() {
  const { user, profile } = useDashboard();

  const [stats, setStats] = useState<Stats>({
    streak: 0,
    questionsThisWeek: 0,
    totalQuestions: 0,
    accuracy: null,
    weeklySpark: [],
    precisionSpark: [],
    weekDelta: 0,
    precisionDelta: 0,
  });
  const [subjects, setSubjects] = useState<SubjectProgress[]>([]);
  const [flashcards, setFlashcards] = useState<FlashcardSummary>({
    totalDue: 0,
    urgent: 0,
    soon: 0,
    later: 0,
    deckCount: 0,
  });
  const [focus, setFocus] = useState<TodaysFocus | null>(null);
  const [loading, setLoading] = useState(true);

  const firstName =
    profile?.first_name ||
    user.user_metadata?.first_name ||
    user.email?.split("@")[0] ||
    "Student";

  /* -------------------------------------------------------- *
   * Load all dashboard data.                                  *
   * -------------------------------------------------------- */

  useEffect(() => {
    let cancelled = false;

    async function load() {
      // -- Question attempts (basis for stats, accuracy, week, sparks) --
      const { data: attempts } = await supabase
        .from("question_attempts")
        .select("is_correct, created_at, question_id")
        .eq("user_id", user.id)
        .order("created_at", { ascending: true });

      // -- Daily activity (basis for streak) --
      const { data: activity } = await supabase
        .from("daily_activity")
        .select("activity_date")
        .eq("user_id", user.id)
        .order("activity_date", { ascending: false })
        .limit(60);

      // -- All questions (for section/topic mapping + Today's Focus) --
      const { data: allQuestions } = await supabase
        .from("questions")
        .select("id, section, topic")
        .is("passage_id", null);

      // -- Flashcards: decks, cards, user state --
      const { data: deckRows } = await supabase
        .from("flashcard_decks")
        .select("id");
      const deckIds = (deckRows || []).map((d) => d.id);

      let cardRows: { id: string; deck_id: string; cloze_count: number; card_type: string }[] = [];
      if (deckIds.length > 0) {
        const { data } = await supabase
          .from("flashcards")
          .select("id, deck_id, cloze_count, card_type")
          .in("deck_id", deckIds);
        cardRows = data || [];
      }

      let stateRows: {
        flashcard_id: string;
        cloze_index: number;
        next_review_at: string;
        suspended: boolean;
      }[] = [];
      if (cardRows.length > 0) {
        const { data } = await supabase
          .from("flashcard_user_state")
          .select("flashcard_id, cloze_index, next_review_at, suspended")
          .eq("user_id", user.id)
          .in(
            "flashcard_id",
            cardRows.map((c) => c.id)
          );
        stateRows = data || [];
      }

      if (cancelled) return;

      // ── Compute stats ────────────────────────────────────
      const now = new Date();
      const todayStart = startOfDayMs(now);
      const weekAgo = todayStart - 7 * 86400000;
      const twoWeeksAgo = todayStart - 14 * 86400000;

      const allAttempts = attempts || [];
      const total = allAttempts.length;
      const correct = allAttempts.filter((a) => a.is_correct).length;
      const accuracy = total >= 20 ? Math.round((correct / total) * 100) : null;

      const thisWeekAttempts = allAttempts.filter(
        (a) => new Date(a.created_at).getTime() >= weekAgo
      );
      const lastWeekAttempts = allAttempts.filter((a) => {
        const t = new Date(a.created_at).getTime();
        return t >= twoWeeksAgo && t < weekAgo;
      });

      const questionsThisWeek = thisWeekAttempts.length;
      const weekDelta = questionsThisWeek - lastWeekAttempts.length;

      // Daily buckets for last 7 days
      const weeklySpark: number[] = Array(7).fill(0);
      const precisionSpark: number[] = [];
      const dailyCorrect = Array(7).fill(0);
      const dailyTotal = Array(7).fill(0);
      thisWeekAttempts.forEach((a) => {
        const dayOffset = Math.floor(
          (startOfDayMs(new Date(a.created_at)) - weekAgo) / 86400000
        );
        if (dayOffset >= 0 && dayOffset < 7) {
          weeklySpark[dayOffset]++;
          dailyTotal[dayOffset]++;
          if (a.is_correct) dailyCorrect[dayOffset]++;
        }
      });
      // Precision sparkline = rolling daily accuracy
      for (let i = 0; i < 7; i++) {
        precisionSpark.push(
          dailyTotal[i] > 0 ? Math.round((dailyCorrect[i] / dailyTotal[i]) * 100) : 0
        );
      }

      // Precision delta: this-week accuracy vs prev-week accuracy
      const thisWeekCorrect = thisWeekAttempts.filter((a) => a.is_correct).length;
      const lastWeekCorrect = lastWeekAttempts.filter((a) => a.is_correct).length;
      const thisWeekAcc =
        thisWeekAttempts.length >= 10
          ? Math.round((thisWeekCorrect / thisWeekAttempts.length) * 100)
          : null;
      const lastWeekAcc =
        lastWeekAttempts.length >= 10
          ? Math.round((lastWeekCorrect / lastWeekAttempts.length) * 100)
          : null;
      const precisionDelta =
        thisWeekAcc !== null && lastWeekAcc !== null ? thisWeekAcc - lastWeekAcc : 0;

      // Streak
      let streak = 0;
      if (activity && activity.length > 0) {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        for (let i = 0; i < activity.length; i++) {
          const actDate = new Date(activity[i].activity_date + "T00:00:00");
          const expected = new Date(today);
          expected.setDate(expected.getDate() - i);
          if (actDate.getTime() === expected.getTime()) streak++;
          else break;
        }
      }

      setStats({
        streak,
        questionsThisWeek,
        totalQuestions: total,
        accuracy,
        weeklySpark,
        precisionSpark,
        weekDelta,
        precisionDelta,
      });

      // ── Subject mastery ──────────────────────────────────
      if (allQuestions && allAttempts) {
        const answered = new Set(allAttempts.map((a) => a.question_id));
        const sectionMap: Record<string, { total: number; done: number }> = {};
        allQuestions.forEach((q) => {
          if (!sectionMap[q.section]) sectionMap[q.section] = { total: 0, done: 0 };
          sectionMap[q.section].total++;
          if (answered.has(q.id)) sectionMap[q.section].done++;
        });

        const subjectList = Object.entries(sectionMap).map(([key, val]) => ({
          section: key,
          label: SECTION_LABELS[key] || key,
          percent: val.total > 0 ? Math.round((val.done / val.total) * 100) : 0,
          attention: false,
        }));
        subjectList.sort((a, b) => b.percent - a.percent);
        // Mark the lowest as attention (the weakest)
        if (subjectList.length > 0) {
          const min = subjectList.reduce((a, b) => (b.percent < a.percent ? b : a));
          min.attention = true;
        }
        setSubjects(subjectList);
      }

      // ── Today's Focus: weakest topic by accuracy ─────────
      if (allQuestions && allAttempts && allAttempts.length >= 5) {
        const qById = new Map(allQuestions.map((q) => [q.id, q]));
        type Bucket = { total: number; correct: number; section: string; topic: string };
        const topicMap = new Map<string, Bucket>();
        allAttempts.forEach((a) => {
          const q = qById.get(a.question_id);
          if (!q || !q.topic) return;
          const key = `${q.section}::${q.topic}`;
          const b =
            topicMap.get(key) ||
            ({ total: 0, correct: 0, section: q.section, topic: q.topic } as Bucket);
          b.total++;
          if (a.is_correct) b.correct++;
          topicMap.set(key, b);
        });
        // Filter to topics with at least 3 attempts (signal vs noise)
        const ranked = Array.from(topicMap.values())
          .filter((b) => b.total >= 3)
          .map((b) => ({ ...b, acc: b.correct / b.total }))
          .sort((a, b) => a.acc - b.acc);

        if (ranked.length > 0) {
          const weakest = ranked[0];
          const accPct = Math.round(weakest.acc * 100);
          // Simple heuristic for expected gain
          const expectedGainPct = Math.max(3, Math.min(12, Math.round((85 - accPct) * 0.15)));
          const second = ranked[1];
          setFocus({
            section: weakest.section,
            sectionLabel: SECTION_LABELS[weakest.section] || weakest.section,
            topic: weakest.topic,
            questionCount: 12,
            estimatedMinutes: 25,
            expectedGainPct,
            altLabel: second
              ? `${SECTION_LABELS[second.section] || second.section} · ${second.topic}`
              : null,
            altMinutes: second ? 18 : null,
          });
        }
      }

      // ── Flashcards ───────────────────────────────────────
      let totalItems = 0;
      cardRows.forEach((c) => {
        totalItems += c.card_type === "cloze" ? c.cloze_count || 1 : 1;
      });

      const nowIso = new Date().toISOString();
      const threeDaysIso = new Date(Date.now() + 3 * 86400000).toISOString();
      const seen = new Set<string>();
      let urgent = 0;
      let soon = 0;
      let later = 0;
      stateRows.forEach((s) => {
        seen.add(`${s.flashcard_id}::${s.cloze_index}`);
        if (s.suspended) return;
        if (s.next_review_at <= nowIso) urgent++;
        else if (s.next_review_at <= threeDaysIso) soon++;
        else later++;
      });
      // Unseen items are treated as urgent
      const unseen = Math.max(0, totalItems - seen.size);
      urgent += unseen;
      const totalDue = urgent + soon + later;

      setFlashcards({
        totalDue,
        urgent,
        soon,
        later,
        deckCount: deckIds.length,
      });

      setLoading(false);
    }

    load();
    return () => {
      cancelled = true;
    };
  }, [user.id]);

  /* -------------------------------------------------------- */

  // Weekly goal: rolling target of 50 q/week (placeholder until settings)
  const weeklyGoal = 50;
  const weeklyGoalPct = Math.min(
    100,
    Math.round((stats.questionsThisWeek / weeklyGoal) * 100)
  );
  const weeklyGoalRemaining = Math.max(0, weeklyGoal - stats.questionsThisWeek);

  // Practice link with focus params
  const practiceHref = focus
    ? `/dashboard/practice?section=${encodeURIComponent(focus.section)}&topic=${encodeURIComponent(focus.topic)}`
    : "/dashboard/practice";

  const isNewUser = stats.totalQuestions === 0;

  /* -------------------------------------------------------- *
   * Render                                                    *
   * -------------------------------------------------------- */

  return (
    <div
      className="relative min-h-full w-full lg:-mx-16 lg:-my-16 overflow-hidden"
      style={{
        background: "var(--color-prax-cream)",
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <MolecularBg opacity={0.07} />

      <div className="relative z-[1] px-6 py-8 lg:px-12 lg:py-10">
        {/* ── Greeting row ─────────────────────────────────────── */}
        <div className="mb-8 flex items-start justify-between gap-4">
          <div>
            <h1
              className="font-medium m-0"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 44,
                lineHeight: 1.05,
                color: "var(--color-prax-green)",
                letterSpacing: "-0.015em",
              }}
            >
              {getGreeting()}, {firstName}.
            </h1>
            <div
              className="italic mt-1.5 max-w-[520px]"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 16,
                color: "var(--color-prax-ink-soft)",
              }}
            >
              Master the MCAT through deliberate, scholarly practice.
            </div>
          </div>

          {/* Date / active-now pill — top right */}
          <div className="hidden sm:flex items-center gap-2.5 pt-2 shrink-0">
            <div className="relative w-2 h-2">
              <div
                className="absolute inset-0 rounded-full"
                style={{ background: "var(--color-prax-green-soft)" }}
              />
              <div
                className="absolute inset-0 rounded-full animate-prax-pulse"
                style={{ background: "var(--color-prax-green-soft)" }}
              />
            </div>
            <div
              className="font-semibold uppercase whitespace-nowrap"
              style={{
                fontSize: 10,
                letterSpacing: "0.22em",
                color: "var(--color-prax-ink-mute)",
              }}
            >
              {todayLabel()} · Active now
            </div>
          </div>
        </div>

        {/* ── TERTIARY: Insight Pulse ────────────────────────────── */}
        <div className="mb-8">
          <div
            className="flex justify-between items-baseline pb-3.5 mb-4"
            style={{ borderBottom: "1px solid var(--color-prax-cream-border)" }}
          >
            <div className="flex items-baseline gap-2.5">
              <div
                className="font-semibold uppercase"
                style={{
                  fontSize: 10,
                  letterSpacing: "0.22em",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                Insight Pulse
              </div>
              <div
                className="italic"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 13,
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                last 7 days
              </div>
            </div>
            <Link
              href="/dashboard/analytics"
              className="font-semibold cursor-pointer"
              style={{
                fontSize: 11.5,
                color: "var(--color-prax-green)",
              }}
            >
              Detailed Analytics →
            </Link>
          </div>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
            <StatCard
              label="Streak"
              value={String(stats.streak)}
              empty={stats.streak === 0}
              emptyCta="Start a streak today →"
              emptyHref={practiceHref}
              hint={stats.streak === 1 ? "day" : "days"}
            />
            <StatCard
              label="Activity"
              value={String(stats.questionsThisWeek)}
              unit="q"
              delta={
                stats.weekDelta > 0
                  ? `+${stats.weekDelta} vs last`
                  : stats.weekDelta < 0
                  ? `${stats.weekDelta} vs last`
                  : "—"
              }
              deltaIsGood={stats.weekDelta >= 0}
              spark={stats.weeklySpark.some((v) => v > 0) ? stats.weeklySpark : undefined}
              hint="Questions this week"
            />
            <StatCard
              label="Precision"
              value={stats.accuracy !== null ? String(stats.accuracy) : "—"}
              unit={stats.accuracy !== null ? "%" : undefined}
              delta={
                stats.precisionDelta > 0
                  ? `+${stats.precisionDelta} pts`
                  : stats.precisionDelta < 0
                  ? `${stats.precisionDelta} pts`
                  : undefined
              }
              deltaIsGood={stats.precisionDelta >= 0}
              spark={
                stats.precisionSpark.some((v) => v > 0) ? stats.precisionSpark : undefined
              }
              hint={stats.accuracy !== null ? "Overall accuracy" : "Answer 20+ to see"}
            />
            <StatCard
              label="Solved"
              value={String(stats.totalQuestions)}
              hint="All questions answered"
              delta="lifetime"
              deltaIsGood={false}
            />
          </div>
        </div>

        {/* ── PRIMARY: Today's Focus ────────────────────────────── */}
        <div
          className="relative overflow-hidden mb-8"
          style={{
            background: "var(--color-prax-green)",
            borderRadius: 20,
            padding: "32px 36px",
            boxShadow:
              "0 1px 2px rgba(3,56,48,0.05), 0 12px 40px -20px rgba(3,56,48,0.35)",
          }}
        >
          {/* Decorative orbital motif */}
          <svg
            className="absolute opacity-20"
            style={{ right: -80, top: -100 }}
            width="440"
            height="440"
            viewBox="0 0 440 440"
            aria-hidden
          >
            <g fill="none" stroke="var(--color-prax-cream)" strokeWidth="1">
              <circle cx="220" cy="220" r="200" />
              <circle cx="220" cy="220" r="150" />
              <circle cx="220" cy="220" r="100" />
              <circle cx="220" cy="220" r="50" />
              <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(30 220 220)" />
              <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(-30 220 220)" />
              <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(90 220 220)" />
            </g>
            <circle cx="220" cy="220" r="5" fill="var(--color-prax-gold-soft)" />
          </svg>

          <div className="relative grid grid-cols-1 lg:[grid-template-columns:1.55fr_auto] gap-12 items-center">
            <div>
              <div className="flex items-center gap-2.5 mb-4">
                <div
                  className="rounded-full"
                  style={{ width: 6, height: 6, background: "var(--color-prax-gold-soft)" }}
                />
                <div
                  className="font-semibold uppercase"
                  style={{
                    fontSize: 10,
                    letterSpacing: "0.22em",
                    color: "var(--color-prax-gold-soft)",
                  }}
                >
                  Today&apos;s Focus
                  {focus && ` · ${focus.estimatedMinutes} min · Adaptive`}
                </div>
              </div>
              <h2
                className="font-normal italic m-0 max-w-[520px]"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 38,
                  lineHeight: 1.08,
                  color: "var(--color-prax-cream)",
                  letterSpacing: "-0.005em",
                }}
              >
                {focus
                  ? `${focus.sectionLabel} — ${focus.topic.toLowerCase()}.`
                  : isNewUser
                  ? "Begin with your first practice session."
                  : "Keep building your practice rhythm."}
              </h2>
              <div
                className="mt-3.5 max-w-[500px]"
                style={{
                  color: "rgba(246,244,227,0.72)",
                  fontSize: 13.5,
                  lineHeight: 1.6,
                }}
              >
                {focus ? (
                  <>
                    {focus.questionCount} adaptive questions on your weakest cluster this
                    week. Expected precision gain{" "}
                    <strong
                      style={{
                        color: "var(--color-prax-cream)",
                        fontWeight: 600,
                      }}
                    >
                      +{focus.expectedGainPct}%
                    </strong>
                    .
                  </>
                ) : isNewUser ? (
                  "We'll start surfacing personalized drills once you've answered a few questions."
                ) : (
                  "Answer a few more questions in any section to unlock personalized drill recommendations."
                )}
              </div>
              <div className="flex items-center gap-4 mt-7 flex-wrap">
                <Link
                  href={practiceHref}
                  className="inline-flex items-center gap-2.5 cursor-pointer"
                  style={{
                    background: "var(--color-prax-cream)",
                    color: "var(--color-prax-green)",
                    border: "none",
                    borderRadius: 999,
                    padding: "14px 26px",
                    fontSize: 13.5,
                    fontWeight: 600,
                    letterSpacing: "0.02em",
                  }}
                >
                  Start Daily Drill
                  <svg
                    width="14"
                    height="14"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                  >
                    <path d="M5 12h14M13 6l6 6-6 6" />
                  </svg>
                </Link>
                {focus?.altLabel && (
                  <div
                    style={{
                      fontSize: 11.5,
                      color: "rgba(246,244,227,0.6)",
                    }}
                  >
                    or{" "}
                    <Link
                      href="/dashboard/practice"
                      className="underline cursor-pointer"
                    >
                      swap focus
                    </Link>{" "}
                    · {focus.altLabel} · {focus.altMinutes} min
                  </div>
                )}
              </div>
            </div>

            {/* Weekly goal ring */}
            <div className="text-center pr-3 hidden lg:block">
              <svg width="140" height="140" viewBox="0 0 140 140">
                <circle
                  cx="70"
                  cy="70"
                  r="60"
                  fill="none"
                  stroke="rgba(246,244,227,0.18)"
                  strokeWidth="9"
                />
                <circle
                  cx="70"
                  cy="70"
                  r="60"
                  fill="none"
                  stroke="var(--color-prax-gold-soft)"
                  strokeWidth="9"
                  strokeDasharray={`${(2 * Math.PI * 60 * weeklyGoalPct) / 100} ${
                    2 * Math.PI * 60
                  }`}
                  strokeLinecap="round"
                  transform="rotate(-90 70 70)"
                />
                <text
                  x="70"
                  y="70"
                  textAnchor="middle"
                  dominantBaseline="central"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 32,
                    fill: "var(--color-prax-cream)",
                    fontWeight: 500,
                  }}
                >
                  {weeklyGoalPct}
                  <tspan fontSize="16">%</tspan>
                </text>
                <text
                  x="70"
                  y="96"
                  textAnchor="middle"
                  style={{
                    fontFamily: "var(--font-prax-sans)",
                    fontSize: 8,
                    fill: "var(--color-prax-gold-soft)",
                    letterSpacing: "0.2em",
                    fontWeight: 600,
                  }}
                >
                  WEEKLY GOAL
                </text>
              </svg>
              <div
                className="italic mt-1"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 11,
                  color: "rgba(246,244,227,0.65)",
                }}
              >
                {stats.questionsThisWeek} of {weeklyGoal} · {weeklyGoalRemaining} to go
              </div>
            </div>
          </div>
        </div>

        {/* ── SECONDARY row: Spaced Repetition + Subject Mastery ── */}
        <div className="grid grid-cols-1 lg:[grid-template-columns:1.25fr_1fr] gap-5 mb-8">
          {/* Spaced Repetition */}
          <div
            className="relative overflow-hidden flex flex-col"
            style={{
              background: "var(--color-prax-cream-deep)",
              border: "1px solid var(--color-prax-cream-border)",
              borderRadius: 16,
              padding: "24px 26px",
            }}
          >
            <div className="flex justify-between items-baseline mb-[18px]">
              <div
                className="font-semibold uppercase"
                style={{
                  fontSize: 10,
                  letterSpacing: "0.22em",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                Spaced Repetition
              </div>
              <Link
                href="/dashboard/flashcards"
                className="font-semibold cursor-pointer"
                style={{ fontSize: 11.5, color: "var(--color-prax-green)" }}
              >
                All Decks →
              </Link>
            </div>
            <div className="flex items-baseline gap-2.5">
              <div
                className="leading-none font-medium"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 52,
                  color: "var(--color-prax-green)",
                  fontVariantNumeric: "tabular-nums lining-nums",
                }}
              >
                {flashcards.totalDue}
              </div>
              <div
                className="italic"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 18,
                  color: "var(--color-prax-ink-soft)",
                }}
              >
                cards due
              </div>
            </div>
            <div
              className="mt-2 max-w-[340px]"
              style={{ fontSize: 13, color: "var(--color-prax-ink-soft)" }}
            >
              {flashcards.deckCount === 0
                ? "Create or import a deck to begin spaced repetition."
                : flashcards.totalDue === 0
                ? "All caught up. New cards will surface as you progress."
                : "Review now to keep retention strong."}
            </div>

            {/* Segmented urgency bar */}
            {flashcards.totalDue > 0 && (
              <div className="mt-5">
                <div
                  className="flex rounded-full overflow-hidden"
                  style={{ height: 8, gap: 2 }}
                >
                  {flashcards.urgent > 0 && (
                    <div
                      style={{ flex: flashcards.urgent, background: "var(--color-prax-gold)" }}
                    />
                  )}
                  {flashcards.soon > 0 && (
                    <div
                      style={{
                        flex: flashcards.soon,
                        background: "var(--color-prax-green-soft)",
                      }}
                    />
                  )}
                  {flashcards.later > 0 && (
                    <div
                      style={{
                        flex: flashcards.later,
                        background: "var(--color-prax-green-tint)",
                      }}
                    />
                  )}
                </div>
                <div
                  className="flex justify-between mt-2.5"
                  style={{ fontSize: 11 }}
                >
                  <div className="flex items-center gap-1.5">
                    <div
                      className="rounded-full"
                      style={{ width: 6, height: 6, background: "var(--color-prax-gold)" }}
                    />
                    <span style={{ color: "var(--color-prax-ink-soft)" }}>
                      <strong
                        style={{
                          color: "var(--color-prax-gold)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {flashcards.urgent}
                      </strong>{" "}
                      urgent
                    </span>
                  </div>
                  <div className="flex items-center gap-1.5">
                    <div
                      className="rounded-full"
                      style={{
                        width: 6,
                        height: 6,
                        background: "var(--color-prax-green-soft)",
                      }}
                    />
                    <span style={{ color: "var(--color-prax-ink-soft)" }}>
                      <strong
                        style={{
                          color: "var(--color-prax-green)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {flashcards.soon}
                      </strong>{" "}
                      soon
                    </span>
                  </div>
                  <div className="flex items-center gap-1.5">
                    <div
                      className="rounded-full"
                      style={{
                        width: 6,
                        height: 6,
                        background: "var(--color-prax-green-tint)",
                      }}
                    />
                    <span style={{ color: "var(--color-prax-ink-soft)" }}>
                      <strong
                        style={{
                          color: "var(--color-prax-ink-soft)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {flashcards.later}
                      </strong>{" "}
                      later
                    </span>
                  </div>
                </div>
              </div>
            )}

            <div className="flex-1" />
            {flashcards.totalDue > 0 && (
              <Link
                href="/dashboard/flashcards"
                className="self-start font-semibold uppercase cursor-pointer mt-6"
                style={{
                  background: "var(--color-prax-green)",
                  color: "var(--color-prax-cream)",
                  border: "none",
                  borderRadius: 999,
                  padding: "11px 22px",
                  fontSize: 11.5,
                  letterSpacing: "0.14em",
                }}
              >
                Review Now
              </Link>
            )}
          </div>

          {/* Subject Mastery */}
          <div
            style={{
              background: "var(--color-prax-cream-deep)",
              border: "1px solid var(--color-prax-cream-border)",
              borderRadius: 16,
              padding: "24px 26px",
            }}
          >
            <div className="flex justify-between items-baseline mb-5">
              <div
                className="font-semibold uppercase"
                style={{
                  fontSize: 10,
                  letterSpacing: "0.22em",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                Subject Mastery
              </div>
              <div
                className="italic"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 12,
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                {subjects.length} subjects tracked
              </div>
            </div>
            {subjects.length > 0 ? (
              subjects.map((s) => (
                <SubjectRow
                  key={s.section}
                  name={s.label}
                  value={s.percent}
                  attention={s.attention}
                />
              ))
            ) : (
              <div
                className="italic"
                style={{
                  fontSize: 12,
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                Complete practice questions to start tracking mastery.
              </div>
            )}
            {subjects.find((s) => s.attention) && (
              <div
                className="flex items-center gap-2 mt-[18px] pt-3.5"
                style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
              >
                <div
                  className="rounded-full"
                  style={{ width: 5, height: 5, background: "var(--color-prax-gold)" }}
                />
                <div
                  className="italic"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 11.5,
                    color: "var(--color-prax-ink-soft)",
                  }}
                >
                  Weakest cluster — drill queued in today&apos;s focus.
                </div>
              </div>
            )}
          </div>
        </div>

        {/* ── SECONDARY: Question Bank + Modules ─────────────── */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-8">
          {[
            {
              title: "The Question Bank",
              desc: "High-yield questions designed for conceptual mastery.",
              cta: "Access Bank",
              meta: "Filter by section, topic, difficulty",
              href: "/dashboard/practice",
              icon: (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6">
                  <path d="M8 9h8M8 13h5" />
                  <path d="M4 5h16v12l-4 4H4z" />
                </svg>
              ),
            },
            {
              title: "Curated Modules",
              desc: "Structured video lectures and clinical breakdowns of complex topics.",
              cta: "Explore Modules",
              meta: "Lessons across all MCAT sections",
              href: "/dashboard/lessons",
              icon: (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6">
                  <rect x="3" y="5" width="18" height="14" rx="2" />
                  <path d="M10 9l5 3-5 3z" fill="currentColor" />
                </svg>
              ),
            },
          ].map((c) => (
            <Link
              key={c.title}
              href={c.href}
              className="flex items-center gap-5"
              style={{
                background: "var(--color-prax-cream-deep)",
                border: "1px solid var(--color-prax-cream-border)",
                borderRadius: 16,
                padding: "22px 26px",
              }}
            >
              <div
                className="grid place-items-center shrink-0"
                style={{
                  width: 44,
                  height: 44,
                  borderRadius: 10,
                  background: "var(--color-prax-green-tint)",
                  color: "var(--color-prax-green)",
                }}
              >
                {c.icon}
              </div>
              <div className="flex-1 min-w-0">
                <div
                  className="font-medium mb-1"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 20,
                    color: "var(--color-prax-green)",
                  }}
                >
                  {c.title}
                </div>
                <div
                  className="leading-snug mb-1.5"
                  style={{
                    fontSize: 12.5,
                    color: "var(--color-prax-ink-soft)",
                  }}
                >
                  {c.desc}
                </div>
                <div
                  className="font-semibold uppercase"
                  style={{
                    fontSize: 10,
                    letterSpacing: "0.18em",
                    color: "var(--color-prax-ink-mute)",
                  }}
                >
                  {c.meta}
                </div>
              </div>
              <div
                className="font-bold uppercase flex items-center gap-2 cursor-pointer hidden lg:flex"
                style={{
                  fontSize: 10,
                  letterSpacing: "0.18em",
                  color: "var(--color-prax-green)",
                }}
              >
                {c.cta}
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                  <path d="M5 12h14M13 6l6 6-6 6" />
                </svg>
              </div>
            </Link>
          ))}
        </div>

        {/* ── FOOTER banner: Elite ──────────────────────────────── */}
        {profile?.subscription_tier === "free" && (
          <div
            className="relative overflow-hidden flex items-center gap-5 flex-wrap"
            style={{
              background: "var(--color-prax-green-deep)",
              borderRadius: 14,
              padding: "18px 28px",
              color: "var(--color-prax-cream)",
            }}
          >
            <svg
              className="absolute opacity-15 hidden lg:block"
              style={{ right: 20, top: -10 }}
              width="180"
              height="120"
              viewBox="0 0 180 120"
              aria-hidden
            >
              <g fill="none" stroke="var(--color-prax-gold-soft)" strokeWidth="0.8">
                <ellipse cx="90" cy="60" rx="80" ry="30" />
                <ellipse cx="90" cy="60" rx="80" ry="30" transform="rotate(30 90 60)" />
                <ellipse cx="90" cy="60" rx="80" ry="30" transform="rotate(-30 90 60)" />
              </g>
            </svg>
            <div
              className="font-semibold uppercase pr-5"
              style={{
                fontSize: 10,
                letterSpacing: "0.22em",
                color: "var(--color-prax-gold-soft)",
                borderRight: "1px solid rgba(246,244,227,0.2)",
              }}
            >
              Elite
            </div>
            <div className="flex-1 relative">
              <div
                className="font-medium italic leading-tight"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 17,
                  color: "var(--color-prax-cream)",
                }}
              >
                Elevate your scholarship — simulated exams and predictive analytics.
              </div>
            </div>
            <Link
              href="/pricing"
              className="font-semibold uppercase cursor-pointer shrink-0"
              style={{
                background: "transparent",
                color: "var(--color-prax-gold-soft)",
                border: "1px solid var(--color-prax-gold-soft)",
                borderRadius: 999,
                padding: "9px 18px",
                fontSize: 11,
                letterSpacing: "0.14em",
              }}
            >
              Explore Plans
            </Link>
          </div>
        )}

        {/* Tiny signature */}
        <div
          className="text-center mt-10 italic"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 11,
            color: "var(--color-prax-ink-mute)",
            letterSpacing: "0.04em",
          }}
        >
          <span
            className="inline-block pb-1.5"
            style={{
              borderBottom: "1px solid var(--color-prax-cream-border)",
              minWidth: 200,
            }}
          >
            — tempered by practice —
          </span>
        </div>
      </div>
    </div>
  );
}
