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


interface FlashcardSummary {
  totalDue: number;
  urgent: number;
  soon: number;
  later: number;
  deckCount: number;
}

import TodayChecklist from "@/components/dashboard/TodayChecklist";
import SummaryRow from "@/components/dashboard/SummaryRow";
import {
  PriorityTopics,
  StudyStatusCard,
  MemoryReview,
  RecentProgress,
  ActivityStrip,
  type ProgressSignal,
} from "@/components/dashboard/DashboardCards";
import {
  scoreRange,
  recentAccuracy,
  weeklyProgress,
  coverage,
  priorityTopics,
  accuracyTrend,
  coverageBand,
  type Attempt,
  type QuestionMeta,
  type PriorityTopic,
  type Coverage as CoverageShape,
  type RecentAccuracy as RecentAccuracyShape,
  type WeeklyProgress as WeeklyProgressShape,
} from "@/lib/dashboard/summary";
import {
  studyStatus as computeStudyStatus,
  STATUS_LABEL,
  statusNote,
} from "@/lib/learner/studyStatus";
import type { ScoreEstimate } from "@/lib/scoring/scoreEstimate";
import { buildChecklist, type ChecklistInput, type FocusDeck } from "@/lib/dashboard/checklist";
import { detectPhase, summariseCards, type PhaseResult } from "@/lib/dashboard/phase";
import { countTodaysReviews } from "@/lib/flashcards/quota";
import { startOfStudyDay } from "@/lib/flashcards/studyDay";


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
  const [flashcards, setFlashcards] = useState<FlashcardSummary>({
    totalDue: 0,
    urgent: 0,
    soon: 0,
    later: 0,
    deckCount: 0,
  });
  const [checklist, setChecklist] = useState<ChecklistInput | null>(null);
  const [phase, setPhase] = useState<PhaseResult | null>(null);

  // ── The redesigned dashboard's own state ──────────────────────────────
  // Derived in lib/dashboard/summary.ts from rows this page already loads.
  const [score, setScore] = useState<ScoreEstimate | null>(null);
  const [weekly, setWeekly] = useState<WeeklyProgressShape | null>(null);
  const [recent, setRecent] = useState<RecentAccuracyShape | null>(null);
  const [cover, setCover] = useState<CoverageShape | null>(null);
  const [priorities, setPriorities] = useState<PriorityTopic[]>([]);
  const [progressSignals, setProgressSignals] = useState<ProgressSignal[]>([]);
  const [cardsThisWeek, setCardsThisWeek] = useState(0);
  /** Decks reviewed since the study day began, so a focus deck can tick off. */
  const decksStudiedToday = useRef<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);

  const firstName =
    profile?.first_name ||
    user.user_metadata?.first_name ||
    user.email?.split("@")[0] ||
    "Student";

  // ── Derived for the cards below ───────────────────────────────────────
  //
  // At render rather than in the loader, so a late-arriving brief or profile
  // flows through without a second pass over thousands of rows.
  const trend = accuracyTrend(stats.precisionDelta, recent?.sampleSize ?? 0);
  // The versioned rule-based model in lib/learner/studyStatus.ts. Every rule is
  // a stated condition and the result carries the one that fired, so a status
  // can be explained rather than re-derived.
  //
  // memoryHealth is passed to be DISPLAYED beside the status. It never reaches
  // the score predictor, which takes only first-attempt question evidence.
  const statusResult = computeStudyStatus({
    eligibleAttempts: recent?.sampleSize ?? 0,
    accuracyDeltaPoints: recent?.deltaPoints ?? null,
    coveragePercent: cover?.percent ?? 0,
    priorityCount: priorities.length,
    memoryHealth: phase
      ? phase.phase === "applying"
        ? "STRONG"
        : phase.phase === "consolidating"
          ? "STABLE"
          : "BUILDING"
      : null,
    predictedHigh: score?.high ?? null,
    predictionConfidence: score?.confidence ?? null,
    targetScore: profile?.target_mcat_score ?? null,
  });
  const status = {
    status: STATUS_LABEL[statusResult.status],
    note: statusNote(statusResult, profile?.target_mcat_score ?? null),
  };
  /** The one genuinely modelled signal on the status card. */
  const MEMORY_PHASE_LABEL: Record<string, string> = {
    building: "Building",
    consolidating: "Consolidating",
    applying: "Holding",
  };
  const memoryPhaseLabel = phase ? (MEMORY_PHASE_LABEL[phase.phase] ?? null) : null;
  /** Today's review target, taken from the plan so the two cannot disagree. */
  const reviewLine = checklist
    ? buildChecklist(checklist).find((l) => l.key === "cards_review") ?? null
    : null;

  /* -------------------------------------------------------- *
   * Load all dashboard data.                                  *
   * -------------------------------------------------------- */

  useEffect(() => {
    let cancelled = false;

    async function load() {
      // -- Question attempts (basis for stats, accuracy, week, sparks) --
      const { data: attempts } = await supabase
        .from("question_attempts")
        .select("is_correct, created_at, question_id, is_first_attempt")
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

      // ── The redesigned dashboard's figures ───────────────
      //
      // All of it from rows already loaded above. Nothing new is fetched and
      // nothing is invented: a metric without evidence returns null and the
      // card says so rather than showing a zero.
      const attemptRows = (allAttempts ?? []) as Attempt[];
      const questionList = (allQuestions ?? []) as QuestionMeta[];
      const questionById = new Map(questionList.map((q) => [q.id, q]));

      // The EXISTING predictor, not a second one. Flashcards are not an input,
      // because the approved model does not use them.
      setScore(scoreRange(attemptRows, questionById));
      setWeekly(weeklyProgress(attemptRows, profile?.weekly_question_goal ?? null));
      const recentAcc = recentAccuracy(attemptRows);
      setRecent(recentAcc);
      const cov = coverage(attemptRows, questionList);
      setCover(cov);
      const topics = priorityTopics(attemptRows, questionById);
      setPriorities(topics);

      // Cards studied this week, for the activity strip and recent progress.
      const weekAgoIso = new Date(Date.now() - 7 * 86_400_000).toISOString();
      const cardsWeek = new Set(
        (await (async () => {
          const rows: { flashcard_id: string; cloze_index: number }[] = [];
          for (let from = 0; ; from += PAGE) {
            const { data } = await supabase
              .from("flashcard_reviews")
              .select("flashcard_id, cloze_index")
              .eq("user_id", user.id)
              .gte("reviewed_at", weekAgoIso)
              .order("reviewed_at", { ascending: true })
              .order("id", { ascending: true })
              .range(from, from + PAGE - 1);
            if (!data || data.length === 0) break;
            rows.push(...data);
            if (data.length < PAGE) break;
          }
          return rows;
        })()).map((r) => `${r.flashcard_id}:${r.cloze_index}`),
      ).size;
      setCardsThisWeek(cardsWeek);

      // ── Recent progress ──────────────────────────────────
      // Movement, not totals. Only signals with something to say appear.
      const signals: ProgressSignal[] = [];
      if (recentAcc.percent !== null && precisionDelta !== 0) {
        signals.push({
          label: "Practice accuracy",
          value: `${precisionDelta > 0 ? "+" : ""}${precisionDelta} pts`,
          detail: "against the week before",
        });
      }
      if (weekDelta !== 0) {
        signals.push({
          label: "Questions completed",
          value: `${weekDelta > 0 ? "+" : ""}${weekDelta}`,
          detail: "against the week before",
        });
      }
      if (cardsWeek > 0) {
        signals.push({
          label: "Cards reviewed",
          value: cardsWeek.toLocaleString("en-US"),
          detail: "distinct cards this week",
        });
      }
      if (cov.attempted > 0) {
        signals.push({
          label: "Coverage",
          value: `${cov.percent}%`,
          detail: `${cov.attempted.toLocaleString("en-US")} questions seen`,
        });
      }
      setProgressSignals(signals);

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

  // ── Recent Progress, from the snapshot system ─────────────────────────
  //
  // Fetched separately and never awaited, the same shape as the brief above.
  // ROLLOUT IS THE FAILURE MODE: there is no per-feature flag system in this
  // codebase (launch-mode.ts gates the marketing site, which is a different
  // question), so this leans on the safest pattern already here. If the call
  // fails for any reason, including the learner tables not existing yet, the
  // catch swallows it and the card keeps the inline signals it has today.
  //
  // Topics improved and priority areas resolved can ONLY come from here. They
  // are counted from deduped learner_events, so a transition is counted once
  // however many times this runs, and there is no way to approximate them on
  // the client without double-counting.
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
        // Only replace the inline signals when the snapshot system actually has
        // something to say. An empty period keeps the existing card rather than
        // blanking it.
        if (body.progress.signals.length > 0) setProgressSignals(body.progress.signals);
      } catch {
        // Snapshot-backed progress is additive. Its absence is not an error.
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [user.id]);

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
        if (cancelled) return;
        if (!Array.isArray(brief?.focusDecks)) return;
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

        {/* ── ROW 1: where am I ─────────────────────────────────── */}
        {/*
          Replaced Streak, Activity, Precision and Solved. Those measure
          effort spent rather than ground gained, and they held the four
          highest-value positions on the page. They survive, quieter, in the
          activity strip at the foot.
        */}
        {/*
          SUMMARY FIRST, THEN THE PLAN, at every width. An earlier version put
          the plan above the summary on phones so it cleared the fold; the
          ordering here reads "where am I" before "what do I do" everywhere
          rather than inverting on small screens. The summary is two compact
          rows of two on mobile, never four cramped columns, so the plan is
          still reached quickly.
        */}
        <SummaryRow
          score={score}
          weekly={weekly}
          recent={recent}
          cover={cover}
          loading={loading}
        />

        {/* ── PRIMARY: Today's Plan ──────────────────────────────── */}
        {/*
          Replaced a panel that announced the backlog: "5,028 of your 7,143
          cards are waiting." True, and useless. It told a student the size of
          their problem and nothing about what to do this morning, and the
          number only grew. The rule for what appears here lives in
          lib/dashboard/checklist.ts.
        */}
        <TodayChecklist input={checklist} phase={phase} loading={loading} />

        {/* ── ROW 2: what needs attention ───────────────────────── */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-5">
          <PriorityTopics topics={priorities} loading={loading} />
          <StudyStatusCard
            status={status.status}
            note={status.note}
            trend={trend}
            coverageBand={cover ? coverageBand(cover.percent) : null}
            priorityCount={priorities.length}
            memoryPhase={memoryPhaseLabel}
            loading={loading}
          />
        </div>

        {/* ── ROW 3: am I moving ────────────────────────────────── */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-5">
          <MemoryReview
            recommendedToday={reviewLine?.target ?? 0}
            doneToday={reviewLine?.done ?? 0}
            comingSoon={flashcards.soon}
            backlog={Math.max(0, flashcards.urgent - (reviewLine?.target ?? 0))}
            loading={loading}
          />
          {/* Recent Progress sits here, not a second coverage card: the top
              row already carries Content Coverage, and repeating it lower down
              spends a prime slot on a number the student has just read. */}
          <RecentProgress signals={progressSignals} loading={loading} />
        </div>

        {/* ── Activity, kept and demoted ────────────────────────── */}
        <ActivityStrip
          streak={stats.streak}
          totalQuestions={stats.totalQuestions}
          questionsThisWeek={stats.questionsThisWeek}
          cardsThisWeek={cardsThisWeek}
        />


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
