"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import { DEFAULT_DAY_START_HOUR, studyDayKeyOffset } from "@/lib/flashcards/studyDay";
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

import TodayChecklist from "@/components/dashboard/TodayChecklist";
import type { ChecklistInput, FocusDeck } from "@/lib/dashboard/checklist";
import { detectPhase, summariseCards, type PhaseResult } from "@/lib/dashboard/phase";
import { countTodaysReviews } from "@/lib/flashcards/quota";
import { startOfStudyDay } from "@/lib/flashcards/studyDay";

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
  const [checklist, setChecklist] = useState<ChecklistInput | null>(null);
  const [phase, setPhase] = useState<PhaseResult | null>(null);
  /** Decks reviewed since the study day began, so a focus deck can tick off. */
  const decksStudiedToday = useRef<Set<string>>(new Set());
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
        .select("id, title");
      const deckIds = (deckRows || []).map((d) => d.id);

      // Page through rows to bypass Supabase's default 1000-row cap on .select()
      const PAGE = 1000;
      let cardRows: { id: string; deck_id: string; cloze_count: number; card_type: string }[] = [];
      if (deckIds.length > 0) {
        for (let from = 0; ; from += PAGE) {
          const { data, error } = await supabase
            .from("flashcards")
            .select("id, deck_id, cloze_count, card_type")
            .in("deck_id", deckIds)
            // Stable sort is REQUIRED for correct pagination: without an
            // explicit order, PostgREST may return overlapping or missing rows
            // across pages, which inflates the card total and therefore the
            // "cards due" headline.
            .order("id", { ascending: true })
            .range(from, from + PAGE - 1);
          if (error || !data || data.length === 0) break;
          cardRows.push(...data);
          if (data.length < PAGE) break;
        }
      }

      // Fetch every state row this user has. The previous .in("flashcard_id",
      // cardIds) filter produced an URL larger than PostgREST allowed when
      // the library grew past ~1k cards, which silently truncated the
      // result set and caused the dashboard counters to under-report
      // reviewed cards. .eq("user_id") is selective enough on its own.
      let stateRows: {
        flashcard_id: string;
        cloze_index: number;
        next_review_at: string;
        suspended: boolean;
      }[] = [];
      if (cardRows.length > 0) {
        for (let from = 0; ; from += PAGE) {
          const { data, error } = await supabase
            .from("flashcard_user_state")
            .select("flashcard_id, cloze_index, next_review_at, suspended, lapses, last_reviewed_at, fsrs_state, stability")
            .eq("user_id", user.id)
            // Stable sort is REQUIRED here too. This table has no `id` column,
            // so the primary key pair is the sort key. Unordered pages let the
            // same row repeat while another is skipped, which shrinks the
            // distinct "seen" set and over-reports unseen cards as due.
            .order("flashcard_id", { ascending: true })
            .order("cloze_index", { ascending: true })
            .range(from, from + PAGE - 1);
          if (error || !data || data.length === 0) break;
          stateRows.push(...data);
          if (data.length < PAGE) break;
        }
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

      // Streak. Walk back through study days (4am boundary), not calendar
      // midnights, so it agrees with the day each activity row was written
      // under. Comparing date STRINGS avoids the timezone conversion that
      // made an evening session look like tomorrow's activity.
      let streak = 0;
      if (activity && activity.length > 0) {
        const dayStart = profile?.day_start_hour ?? DEFAULT_DAY_START_HOUR;
        for (let i = 0; i < activity.length; i++) {
          if (activity[i].activity_date === studyDayKeyOffset(i, new Date(), dayStart)) streak++;
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
        // Flag the least-covered subject. NOTE this is coverage, not accuracy:
        // percent is answered/total, so a low number means untouched material,
        // not material the student is bad at. The copy must not say otherwise.
        if (subjectList.length > 0) {
          const min = subjectList.reduce((a, b) => (b.percent < a.percent ? b : a));
          min.attention = true;
        }
        setSubjects(subjectList);
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
      // "Cards due" = the now-actionable queue (unseen + due now), matching the
      // Flashcards page headline. "soon"/"later" are scheduled ahead, not due
      // yet — shown in the bar below but excluded from the headline count.
      const totalDue = urgent;

      setFlashcards({
        totalDue,
        urgent,
        soon,
        later,
        deckCount: deckIds.length,
      });

      // ── Today's checklist ────────────────────────────────
      //
      // Everything here is either something the student set or work they
      // actually did. Nothing is estimated, and nothing is invented: that was
      // the failure of the panel this replaced, which showed an "expected
      // precision gain" derived from no outcome data at all.
      const dayStartHour = profile?.day_start_hour ?? DEFAULT_DAY_START_HOUR;
      const dayStart = startOfStudyDay(new Date(), dayStartHour);
      const dayStartIso = dayStart.toISOString();
      const todayKey = new Date().toISOString().slice(0, 10);

      // Cards done today, counted the same way the study pages count them, so
      // the checklist and the session agree about what a card is.
      const todays = await countTodaysReviews(user.id, dayStartHour);

      // Missed questions waiting in Smart Review, which already exists.
      const { count: missedDue } = await supabase
        .from("review_schedule")
        .select("question_id", { count: "exact", head: true })
        .eq("user_id", user.id)
        .lte("next_review_date", todayKey);

      // Questions answered this study day, split the way the checklist asks
      // for them: a first attempt is new work, a repeat is Smart Review.
      const todaysAttempts = (allAttempts || []).filter(
        (a) => a.created_at >= dayStartIso
      );
      const newQuestionsToday = todaysAttempts.filter(
        (a) => (a as { is_first_attempt?: boolean }).is_first_attempt !== false
      ).length;
      const missedQuestionsToday = todaysAttempts.length - newQuestionsToday;

      // ── Where the student is ─────────────────────────────
      // Measured, not asserted. See lib/dashboard/phase.ts for what the
      // numbers are and what they deliberately do not include.
      const examDate = profile?.mcat_test_date ? new Date(profile.mcat_test_date) : null;
      const daysToExam = examDate
        ? Math.ceil((examDate.getTime() - Date.now()) / 86_400_000)
        : null;
      const detected = detectPhase({
        ...summariseCards(
          stateRows as {
            fsrs_state?: number | null;
            stability?: number | null;
            suspended?: boolean | null;
          }[],
        ),
        daysToExam,
      });
      setPhase(detected);

      // Which decks were touched today, so a focus deck can tick itself off
      // once the brief names them.
      // A Map, not a .find() per row: the first version of this scanned 4,116
      // cards for each of 7,146 state rows, which is 29 million comparisons on
      // every dashboard load.
      const cardToDeck = new Map(cardRows.map((c) => [c.id, c.deck_id]));
      const touched = new Set<string>();
      stateRows.forEach((r) => {
        const seenAt = (r as { last_reviewed_at?: string | null }).last_reviewed_at;
        if (!seenAt || seenAt < dayStartIso) return;
        const deckId = cardToDeck.get(r.flashcard_id);
        if (deckId) touched.add(deckId);
      });
      decksStudiedToday.current = touched;

      // Focus decks are NOT computed here. Getting them right means reading the
      // whole review log, which takes eighteen seconds on a 41,787-row account,
      // so they arrive from the cached brief in the effect below and the line
      // fills in when they land. Two shortcuts were tried here first and both
      // named the wrong decks.

      setChecklist({
        reviewLimit: profile?.daily_review_limit ?? 0,
        newLimit: profile?.daily_new_card_limit ?? 0,
        weeklyQuestionGoal: profile?.weekly_question_goal ?? 0,
        cardsDue: Math.max(0, urgent - unseen),
        unseenBlanks: unseen,
        missedQuestionsDue: missedDue ?? 0,
        focusDecks: [],
        reviewsToday: todays.reviewsToday,
        newToday: todays.newToday,
        newQuestionsToday,
        missedQuestionsToday,
        // The study modules are not built yet.
        topicsReady: false,
        phase: detected.phase,
      });

      setLoading(false);
    }

    load();
    return () => {
      cancelled = true;
    };
    // Deliberately keyed on the user alone, though the body reads four profile
    // fields. DashboardShell awaits the profile before it renders children, so
    // it is already present on the first run; adding the fields would key this
    // on values that change from undefined to their real value and run the
    // whole paged load a second time for nothing.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user.id]);

  /* -------------------------------------------------------- */

  // NOTE: the insight brief used to be fetched here. It existed only to fill
  // Today's Focus, so replacing that panel left it with no consumer and the
  // fetch ran on every load for nothing. lib/insights and /api/insights/brief
  // are untouched and still work; nothing renders them today.

  // ── Focus decks, from the cached brief ────────────────────────────────
  //
  // Fetched separately and never awaited by the main load. The computation
  // behind it reads every review the student has ever logged and takes about
  // eighteen seconds on the largest real account; it is cached per study day,
  // so that cost lands once a morning. Blocking the dashboard on it would trade
  // a correct line for an unusable page.
  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const { data: sessionData } = await supabase.auth.getSession();
        const token = sessionData.session?.access_token;
        if (!token) return;
        const res = await fetch("/api/insights/brief", {
          headers: { Authorization: `Bearer ${token}` },
        });
        if (!res.ok) return;
        const brief = await res.json();
        if (cancelled || !Array.isArray(brief?.focusDecks)) return;
        setChecklist((prev) =>
          prev
            ? {
                ...prev,
                focusDecks: (brief.focusDecks as FocusDeck[]).map((d) => ({
                  ...d,
                  // Touched today is local knowledge; the brief is a day-level
                  // snapshot and does not know what happened since it was cached.
                  studiedToday: decksStudiedToday.current.has(d.deckId),
                })),
              }
            : prev,
        );
      } catch {
        // The line simply does not appear. A checklist missing one row beats a
        // dashboard that fails because an optional extra could not be built.
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [user.id]);

  const practiceHref = "/dashboard/practice";


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

        {/* ── PRIMARY: Today's checklist ─────────────────────────── */}
        {/*
          Replaced a panel that announced the backlog: "5,028 of your 7,143
          cards are waiting." True, and useless. It told a student the size of
          their problem and nothing about what to do this morning, and the
          number only grew. The rule for what appears here lives in
          lib/dashboard/checklist.ts.
        */}
        <TodayChecklist input={checklist} phase={phase} loading={loading} />

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
                  Least covered so far. This tracks how much you have
                  attempted, not how well you did.
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
                Early access, full access. Simulated exams and predictive
                analytics, included at no cost.
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
              See What&rsquo;s Coming
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
            tempered by practice
          </span>
        </div>
      </div>
    </div>
  );
}
