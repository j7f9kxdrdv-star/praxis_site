"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import MolecularBg from "@/components/dashboard/MolecularBg";
import {
  PageHeader,
  ActiveNowPill,
  SmallCaps,
  PraxCard,
  SectionHeader,
  praxBtnCreamOnGreen,
  praxBtnGreenOnCream,
} from "@/components/dashboard/PraxUI";

/* ─────────────── Types ─────────────── */

const SECTIONS: { id: string; label: string }[] = [
  { id: "bio_biochem", label: "Biology & Biochemistry" },
  { id: "chem_phys", label: "Chemistry & Physics" },
  { id: "psych_soc", label: "Psychology & Sociology" },
  { id: "cars", label: "Critical Analysis & Reasoning" },
];

const DIFFICULTY_OPTIONS = [
  { id: "all", label: "All Levels" },
  { id: "easy", label: "Easy" },
  { id: "medium", label: "Medium" },
  { id: "hard", label: "Hard" },
];

interface QuestionRow {
  id: string;
  section: string;
  topic: string | null;
  subtopic: string;
  difficulty: string;
  passage_id: string | null;
}

/* ─────────────── Page ─────────────── */

export default function PracticeHub() {
  const router = useRouter();
  const { user } = useDashboard();

  const [questions, setQuestions] = useState<QuestionRow[]>([]);
  // Latest is_correct per question_id (undefined = unattempted)
  const [latestCorrect, setLatestCorrect] = useState<Map<string, boolean>>(
    new Map()
  );
  const [flaggedCount, setFlaggedCount] = useState(0);
  const [dueCount, setDueCount] = useState(0);
  const [dataLoaded, setDataLoaded] = useState(false);
  const [loading, setLoading] = useState(false);

  // Most recent unfinished session, if any (for the Resume card)
  const [resumable, setResumable] = useState<{
    id: string;
    current_index: number;
    total_questions: number;
  } | null>(null);
  const [discarding, setDiscarding] = useState(false);

  const [expandedSection, setExpandedSection] = useState<string | null>(null);

  // Builder modal state
  const [showBuilder, setShowBuilder] = useState(false);
  const [builderStep, setBuilderStep] = useState<1 | 2 | 3>(1);
  const [builderSections, setBuilderSections] = useState<Set<string>>(new Set());
  const [builderTopics, setBuilderTopics] = useState<Set<string>>(new Set());
  const [builderAllTopics, setBuilderAllTopics] = useState(false);
  const [builderDifficulty, setBuilderDifficulty] = useState("all");
  const [builderCount, setBuilderCount] = useState(10);

  /* ─────────────── Load data ─────────────── */

  useEffect(() => {
    async function load() {
      const PAGE = 1000;

      // Page through questions
      const qRows: QuestionRow[] = [];
      for (let from = 0; ; from += PAGE) {
        const { data, error } = await supabase
          .from("questions")
          .select("id, section, topic, subtopic, difficulty, passage_id")
          .range(from, from + PAGE - 1);
        if (error || !data || data.length === 0) break;
        qRows.push(...(data as QuestionRow[]));
        if (data.length < PAGE) break;
      }

      // Page through this user's attempts. Ordered by created_at so the
      // last assignment to the map wins → "latest is_correct" wins.
      type AttemptRow = {
        question_id: string;
        is_correct: boolean;
        flagged: boolean;
        created_at: string;
      };
      const aRows: AttemptRow[] = [];
      for (let from = 0; ; from += PAGE) {
        const { data, error } = await supabase
          .from("question_attempts")
          .select("question_id, is_correct, flagged, created_at")
          .eq("user_id", user.id)
          .order("created_at", { ascending: true })
          .range(from, from + PAGE - 1);
        if (error || !data || data.length === 0) break;
        aRows.push(...(data as AttemptRow[]));
        if (data.length < PAGE) break;
      }

      const correctMap = new Map<string, boolean>();
      const flaggedSet = new Set<string>();
      aRows.forEach((a) => {
        correctMap.set(a.question_id, a.is_correct);
        if (a.flagged) flaggedSet.add(a.question_id);
        else flaggedSet.delete(a.question_id);
      });

      // Review-due count
      const today = new Date().toISOString().split("T")[0];
      const { count: reviewCount } = await supabase
        .from("review_schedule")
        .select("*", { count: "exact", head: true })
        .eq("user_id", user.id)
        .lte("next_review_date", today);

      // Most recent unfinished session → drives the Resume card. Sessions untouched for a
      // week are treated as abandoned and no longer surface: a stale one you were never
      // going to finish just nags forever (users had zombie sessions up to 46 days old).
      const staleCutoff = new Date();
      staleCutoff.setDate(staleCutoff.getDate() - 7);
      const { data: openSession } = await supabase
        .from("practice_sessions")
        .select("id, current_index, total_questions")
        .eq("user_id", user.id)
        .eq("status", "in_progress")
        .gte("last_active_at", staleCutoff.toISOString())
        .order("last_active_at", { ascending: false, nullsFirst: false })
        .order("started_at", { ascending: false })
        .limit(1)
        .maybeSingle();

      setQuestions(qRows);
      setLatestCorrect(correctMap);
      setFlaggedCount(flaggedSet.size);
      setDueCount(reviewCount || 0);
      setResumable(
        openSession && openSession.total_questions > 0 ? openSession : null
      );
      setDataLoaded(true);
    }
    load();
  }, [user.id]);

  /* ─────────────── Derived counts ─────────────── */

  // Standalone (non-passage) questions only — passage sets are a separate
  // surface we'll design later.
  const standalone = questions.filter((q) => !q.passage_id);
  const totalCount = standalone.length;

  let attemptedAll = 0;
  let correctAll = 0;
  standalone.forEach((q) => {
    const ic = latestCorrect.get(q.id);
    if (ic === undefined) return;
    attemptedAll++;
    if (ic) correctAll++;
  });
  const incorrectAll = attemptedAll - correctAll;
  const unseenAll = totalCount - attemptedAll;
  const accuracyAll =
    attemptedAll > 0 ? Math.round((correctAll / attemptedAll) * 100) : 0;

  /* ─────────────── Section roll-up ─────────────── */

  function sectionStats(sectionId: string) {
    const qs = standalone.filter((q) => q.section === sectionId);
    let attempted = 0;
    let correct = 0;
    qs.forEach((q) => {
      const ic = latestCorrect.get(q.id);
      if (ic === undefined) return;
      attempted++;
      if (ic) correct++;
    });
    return {
      total: qs.length,
      attempted,
      correct,
      incorrect: attempted - correct,
      unseen: qs.length - attempted,
    };
  }

  function topicsInSection(sectionId: string) {
    const map = new Map<
      string,
      { total: number; attempted: number; correct: number }
    >();
    standalone
      .filter((q) => q.section === sectionId)
      .forEach((q) => {
        const key = q.topic || "General";
        const entry = map.get(key) || { total: 0, attempted: 0, correct: 0 };
        entry.total++;
        const ic = latestCorrect.get(q.id);
        if (ic !== undefined) {
          entry.attempted++;
          if (ic) entry.correct++;
        }
        map.set(key, entry);
      });
    return Array.from(map.entries())
      .map(([name, info]) => ({ name, ...info }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  /* ─────────────── Session launchers ─────────────── */

  async function createSession(
    selectedIds: string[],
    sessionType: string,
    mode?: string
  ) {
    const { data: session, error } = await supabase
      .from("practice_sessions")
      .insert({
        user_id: user.id,
        session_type: sessionType,
        total_questions: selectedIds.length,
        status: "in_progress",
        // Persist the ordered question list + mode on the row so the
        // session survives a full browser close and can be resumed.
        question_ids: selectedIds,
        mode: mode ?? null,
        last_active_at: new Date().toISOString(),
      })
      .select("id")
      .single();

    if (error || !session) {
      setLoading(false);
      return;
    }

    sessionStorage.setItem(
      `session_${session.id}`,
      JSON.stringify(selectedIds)
    );
    if (mode) {
      sessionStorage.setItem(`session_${session.id}_mode`, mode);
    }
    router.push(`/dashboard/practice/session/${session.id}`);
  }

  // Let the user clear an unfinished session they don't intend to return to, instead of
  // leaving the Resume banner nagging them indefinitely.
  async function discardResumable() {
    if (!resumable || discarding) return;
    setDiscarding(true);
    const { error } = await supabase
      .from("practice_sessions")
      .update({ status: "abandoned" })
      .eq("id", resumable.id)
      .eq("user_id", user.id);
    setDiscarding(false);
    if (!error) setResumable(null);
  }

  // Sessions have to be finishable in one sitting. Completion rates across all users:
  // 1-10 q -> 93% finished, 11-25 q -> 100%, 26-50 q -> 20%, 51-100 q -> 8%, 100+ q -> 0%.
  // Uncapped section / review launches produced 40-421 question sessions that nobody
  // completed, which then sat "in progress" forever and nagged the hub's Resume banner.
  const MAX_SESSION_QUESTIONS = 20;

  async function startQuick10() {
    setLoading(true);
    const pool = standalone.filter((q) => latestCorrect.get(q.id) === undefined);
    if (pool.length === 0) {
      setLoading(false);
      alert("You've seen every question once. Build a custom session to re-practice.");
      return;
    }
    const shuffled = [...pool].sort(() => Math.random() - 0.5);
    const ids = shuffled.slice(0, Math.min(10, shuffled.length)).map((q) => q.id);
    await createSession(ids, "quick_10");
  }

  async function startSmartReview() {
    setLoading(true);
    const today = new Date().toISOString().split("T")[0];
    const { data: reviews } = await supabase
      .from("review_schedule")
      .select("question_id")
      .eq("user_id", user.id)
      .lte("next_review_date", today)
      .limit(1000);

    if (!reviews || reviews.length === 0) {
      setLoading(false);
      alert("No questions due for review right now. Keep practicing!");
      return;
    }
    await createSession(
      reviews.slice(0, MAX_SESSION_QUESTIONS).map((r) => r.question_id),
      "weak_areas",
      "review"
    );
  }

  async function startFlagged() {
    setLoading(true);
    const { data: flagged } = await supabase
      .from("question_attempts")
      .select("question_id")
      .eq("user_id", user.id)
      .eq("flagged", true)
      .limit(1000);
    if (!flagged || flagged.length === 0) {
      setLoading(false);
      alert("No flagged questions yet. Flag questions you want to revisit during a session.");
      return;
    }
    const unique = Array.from(new Set(flagged.map((f) => f.question_id))).slice(
      0,
      MAX_SESSION_QUESTIONS
    );
    await createSession(unique, "weak_areas", "flagged");
  }

  async function startSectionSession(sectionId: string) {
    setLoading(true);
    const pool = standalone
      .filter((q) => q.section === sectionId)
      .filter((q) => latestCorrect.get(q.id) === undefined);
    if (pool.length === 0) {
      setLoading(false);
      alert("You've seen every question in this section. Build a custom session to re-practice.");
      return;
    }
    const shuffled = [...pool].sort(() => Math.random() - 0.5);
    await createSession(
      shuffled.slice(0, MAX_SESSION_QUESTIONS).map((q) => q.id),
      "by_section"
    );
  }

  async function startTopicSession(sectionId: string, topicName: string) {
    setLoading(true);
    const pool = standalone
      .filter(
        (q) =>
          q.section === sectionId && (q.topic || "General") === topicName
      )
      .filter((q) => latestCorrect.get(q.id) === undefined);
    if (pool.length === 0) {
      setLoading(false);
      alert("You've seen every question in this topic. Build a custom session to re-practice.");
      return;
    }
    const shuffled = [...pool].sort(() => Math.random() - 0.5);
    await createSession(
      shuffled.slice(0, MAX_SESSION_QUESTIONS).map((q) => q.id),
      "by_section"
    );
  }

  /* ─────────────── Builder helpers ─────────────── */

  function openBuilder() {
    setBuilderStep(1);
    setBuilderSections(new Set());
    setBuilderTopics(new Set());
    setBuilderAllTopics(false);
    setBuilderDifficulty("all");
    setBuilderCount(10);
    setShowBuilder(true);
  }

  function getBuilderTopics() {
    const t = new Map<string, { section: string; count: number }>();
    standalone
      .filter((q) => builderSections.has(q.section) && q.topic)
      .forEach((q) => {
        const k = q.topic!;
        const e = t.get(k) || { section: q.section, count: 0 };
        e.count++;
        t.set(k, e);
      });
    return Array.from(t.entries())
      .map(([name, info]) => ({ name, ...info }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  function getBuilderMatch() {
    return standalone.filter((q) => {
      if (!builderSections.has(q.section)) return false;
      if (!builderAllTopics && builderTopics.size > 0) {
        if (!builderTopics.has(q.topic || "")) return false;
      } else if (!builderAllTopics) {
        return false;
      }
      if (builderDifficulty !== "all" && q.difficulty !== builderDifficulty)
        return false;
      if (latestCorrect.has(q.id)) return false;
      return true;
    }).length;
  }

  async function launchBuilder() {
    setLoading(true);
    const matching = standalone.filter((q) => {
      if (!builderSections.has(q.section)) return false;
      if (!builderAllTopics && builderTopics.size > 0) {
        if (!builderTopics.has(q.topic || "")) return false;
      } else if (!builderAllTopics) {
        return false;
      }
      if (builderDifficulty !== "all" && q.difficulty !== builderDifficulty)
        return false;
      if (latestCorrect.has(q.id)) return false;
      return true;
    });
    if (matching.length === 0) {
      setLoading(false);
      alert("No questions match your selection.");
      return;
    }
    const shuffled = [...matching].sort(() => Math.random() - 0.5);
    const count =
      builderCount === 0
        ? shuffled.length
        : Math.min(builderCount, shuffled.length);
    const ids = shuffled.slice(0, count).map((q) => q.id);
    setShowBuilder(false);
    await createSession(ids, "custom");
  }

  /* ─────────────── Render ─────────────── */

  const noQuestions = dataLoaded && totalCount === 0;

  return (
    <div
      className="relative min-h-full w-full lg:-mx-16 lg:-my-16 overflow-hidden"
      style={{
        background: "var(--color-prax-cream)",
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <MolecularBg variant="elements" />
      <div className="relative z-[1] px-6 py-8 lg:px-12 lg:py-10">
        <PageHeader
          eyebrow="Question Bank · Standalone Practice"
          title="Practice."
          subtitle="Sharpen recall under timed pressure. Build a custom session or pull a quick ten."
          right={<ActiveNowPill />}
        />

        {/* ─────────── RESUME BANNER ─────────── */}
        {resumable && (
          <div
            className="w-full mb-6 flex items-center gap-4"
            style={{
              background: "var(--color-prax-cream-card)",
              border: "1px solid var(--color-prax-green)",
              borderRadius: 14,
              padding: "16px 20px",
            }}
          >
            <button
              onClick={() =>
                router.push(`/dashboard/practice/session/${resumable.id}`)
              }
              className="flex-1 min-w-0 text-left flex items-center gap-4 transition-colors"
              style={{ background: "transparent", padding: 0 }}
            >
              <div
                className="grid place-items-center rounded-full shrink-0"
                style={{
                  width: 38,
                  height: 38,
                  background: "var(--color-prax-green)",
                  color: "var(--color-prax-cream)",
                }}
              >
                <svg width={18} height={18} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
                  <path d="M5 3l14 9-14 9V3z" />
                </svg>
              </div>
              <div className="flex-1 min-w-0">
                <SmallCaps style={{ color: "var(--color-prax-green)" }}>
                  Resume your session
                </SmallCaps>
                <div
                  className="mt-1"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 17,
                    color: "var(--color-prax-green)",
                  }}
                >
                  Pick up at question {Math.min(resumable.current_index + 1, resumable.total_questions)} of {resumable.total_questions}
                </div>
              </div>
              <span
                className="shrink-0 font-semibold hidden sm:inline"
                style={{ fontSize: 12, color: "var(--color-prax-green)" }}
              >
                Continue →
              </span>
            </button>
            <button
              onClick={discardResumable}
              disabled={discarding}
              aria-label="Discard this unfinished session"
              className="shrink-0 underline"
              style={{
                background: "transparent",
                padding: "6px 2px",
                fontSize: 12,
                color: "var(--color-prax-ink-mute)",
                cursor: discarding ? "default" : "pointer",
                opacity: discarding ? 0.5 : 1,
              }}
            >
              {discarding ? "Discarding…" : "Discard"}
            </button>
          </div>
        )}

        {/* ─────────── EMPTY STATE ─────────── */}
        {noQuestions && (
          <PraxCard variant="secondary" className="text-center py-12">
            <div
              className="font-medium mb-1"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              No questions yet
            </div>
            <div
              style={{ fontSize: 13, color: "var(--color-prax-ink-mute)" }}
              className="italic"
            >
              Questions will appear here once content is added.
            </div>
          </PraxCard>
        )}

        {/* ─────────── PRIMARY: green hero ─────────── */}
        {!noQuestions && (
          <PraxCard variant="primary" className="overflow-hidden mb-6">
            {/* Decorative orbital motif */}
            <svg
              className="absolute opacity-20"
              style={{ right: -80, top: -100 }}
              width="380"
              height="380"
              viewBox="0 0 440 440"
              aria-hidden
            >
              <g fill="none" stroke="var(--color-prax-cream)" strokeWidth="1">
                <circle cx="220" cy="220" r="200" />
                <circle cx="220" cy="220" r="150" />
                <circle cx="220" cy="220" r="100" />
                <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(30 220 220)" />
                <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(-30 220 220)" />
              </g>
              <circle cx="220" cy="220" r="5" fill="var(--color-prax-gold-soft)" />
            </svg>

            <div className="relative grid grid-cols-1 lg:[grid-template-columns:1.45fr_auto] gap-10 items-center">
              <div>
                <div className="flex items-center gap-2.5 mb-4">
                  <div
                    className="rounded-full"
                    style={{
                      width: 6,
                      height: 6,
                      background: "var(--color-prax-gold-soft)",
                    }}
                  />
                  <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                    Today&apos;s Practice · Custom Session
                  </SmallCaps>
                </div>
                <div className="flex items-baseline gap-3">
                  <div
                    className="leading-none font-medium"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 56,
                      color: "var(--color-prax-cream)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {dataLoaded ? unseenAll : "—"}
                  </div>
                  <div
                    className="italic"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 22,
                      color: "rgba(246,244,227,0.72)",
                    }}
                  >
                    questions left
                  </div>
                </div>
                <div
                  className="mt-3 max-w-[480px]"
                  style={{
                    color: "rgba(246,244,227,0.72)",
                    fontSize: 13.5,
                    lineHeight: 1.6,
                  }}
                >
                  {unseenAll > 0
                    ? "Build a session sized to whatever time you have, or pull a quick ten at random. The bar tracks accuracy as you go."
                    : "You've seen every standalone question once. Open the builder to re-practice missed ones."}
                </div>

                {/* Accuracy / progress bar */}
                {totalCount > 0 && (
                  <div className="mt-6 max-w-[480px]">
                    <div
                      className="flex rounded-full overflow-hidden"
                      style={{ height: 8, gap: 2 }}
                    >
                      {correctAll > 0 && (
                        <div
                          style={{
                            flex: correctAll,
                            background: "var(--color-prax-gold-soft)",
                          }}
                        />
                      )}
                      {incorrectAll > 0 && (
                        <div
                          style={{
                            flex: incorrectAll,
                            background: "rgba(212, 161, 78, 0.55)",
                          }}
                        />
                      )}
                      {unseenAll > 0 && (
                        <div
                          style={{
                            flex: unseenAll,
                            background: "rgba(246,244,227,0.22)",
                          }}
                        />
                      )}
                    </div>
                    <div
                      className="flex justify-between mt-2"
                      style={{ fontSize: 11, color: "rgba(246,244,227,0.7)" }}
                    >
                      <span>
                        <strong
                          style={{
                            color: "var(--color-prax-gold-soft)",
                            fontWeight: 700,
                            fontVariantNumeric: "tabular-nums",
                          }}
                        >
                          {correctAll}
                        </strong>{" "}
                        correct
                      </span>
                      <span>
                        <strong
                          style={{
                            color: "rgba(212, 161, 78, 0.95)",
                            fontWeight: 700,
                            fontVariantNumeric: "tabular-nums",
                          }}
                        >
                          {incorrectAll}
                        </strong>{" "}
                        missed
                      </span>
                      <span>
                        <strong
                          style={{
                            color: "rgba(246,244,227,0.85)",
                            fontWeight: 700,
                            fontVariantNumeric: "tabular-nums",
                          }}
                        >
                          {unseenAll}
                        </strong>{" "}
                        unseen
                      </span>
                    </div>
                  </div>
                )}

                <div className="mt-7 flex flex-wrap items-center gap-4">
                  <button
                    onClick={openBuilder}
                    disabled={loading}
                    style={praxBtnCreamOnGreen}
                  >
                    Build Session
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
                  </button>
                  <button
                    onClick={startQuick10}
                    disabled={loading || unseenAll === 0}
                    className="underline"
                    style={{
                      background: "transparent",
                      border: "none",
                      padding: 0,
                      color: "rgba(246,244,227,0.85)",
                      fontSize: 13,
                      cursor: "pointer",
                    }}
                  >
                    Or take a Quick 10 →
                  </button>
                </div>
              </div>

              {/* Right column: library stat */}
              <div className="hidden lg:block text-right pr-2">
                <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                  Library
                </SmallCaps>
                <div
                  className="leading-none mt-2 font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 38,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {totalCount}
                </div>
                <div
                  className="italic mt-1"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 13,
                    color: "rgba(246,244,227,0.65)",
                  }}
                >
                  standalone questions
                </div>
                {attemptedAll > 0 && (
                  <div
                    className="mt-4"
                    style={{
                      fontSize: 12,
                      color: "rgba(246,244,227,0.55)",
                    }}
                  >
                    {accuracyAll}% accuracy
                  </div>
                )}
              </div>
            </div>
          </PraxCard>
        )}

        {/* ─────────── SECONDARY ROW: Smart Review + Flagged ─────────── */}
        {!noQuestions && (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-8">
            {/* Smart Review */}
            <PraxCard variant="secondary">
              <div className="flex items-start justify-between gap-4">
                <div className="min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <div
                      className="rounded-full"
                      style={{
                        width: 5,
                        height: 5,
                        background: "var(--color-prax-green-soft)",
                      }}
                    />
                    <SmallCaps>Smart Review</SmallCaps>
                  </div>
                  <div className="flex items-baseline gap-2">
                    <div
                      className="leading-none font-medium"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 30,
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {dueCount}
                    </div>
                    <div
                      className="italic"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 14,
                        color: "var(--color-prax-ink-soft)",
                      }}
                    >
                      due for review
                    </div>
                  </div>
                  <p
                    className="mt-2 max-w-[280px]"
                    style={{
                      fontSize: 12.5,
                      color: "var(--color-prax-ink-soft)",
                      lineHeight: 1.5,
                    }}
                  >
                    Questions you&apos;ve missed that the system wants you to retry today.
                  </p>
                </div>
                {dueCount > 0 && (
                  <button
                    onClick={startSmartReview}
                    disabled={loading}
                    style={praxBtnGreenOnCream}
                    className="shrink-0"
                  >
                    Review
                  </button>
                )}
              </div>
            </PraxCard>

            {/* Flagged */}
            <PraxCard variant="secondary">
              <div className="flex items-start justify-between gap-4">
                <div className="min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <div
                      className="rounded-full"
                      style={{
                        width: 5,
                        height: 5,
                        background: "var(--color-prax-gold)",
                      }}
                    />
                    <SmallCaps>Flagged Questions</SmallCaps>
                  </div>
                  <div className="flex items-baseline gap-2">
                    <div
                      className="leading-none font-medium"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 30,
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {flaggedCount}
                    </div>
                    <div
                      className="italic"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 14,
                        color: "var(--color-prax-ink-soft)",
                      }}
                    >
                      saved
                    </div>
                  </div>
                  <p
                    className="mt-2 max-w-[300px]"
                    style={{
                      fontSize: 12.5,
                      color: "var(--color-prax-ink-soft)",
                      lineHeight: 1.5,
                    }}
                  >
                    Questions you marked for a second look during a session.
                  </p>
                </div>
                {flaggedCount > 0 && (
                  <button
                    onClick={startFlagged}
                    disabled={loading}
                    style={praxBtnGreenOnCream}
                    className="shrink-0"
                  >
                    Review
                  </button>
                )}
              </div>
            </PraxCard>
          </div>
        )}

        {/* ─────────── BROWSE BY SECTION ─────────── */}
        {!noQuestions && (
          <div className="mb-8">
            <SectionHeader
              label="Browse by Section"
              subtitle={
                dataLoaded
                  ? `${SECTIONS.length} MCAT sections · ${totalCount} questions`
                  : "Loading library…"
              }
            />

            <div className="space-y-3">
              {SECTIONS.map((section) => {
                const stats = sectionStats(section.id);
                if (dataLoaded && stats.total === 0) return null;

                const isExpanded = expandedSection === section.id;
                const status: "untouched" | "in-progress" | "mastered" =
                  stats.total === 0 || stats.attempted === 0
                    ? "untouched"
                    : stats.attempted >= stats.total &&
                      stats.incorrect === 0
                    ? "mastered"
                    : "in-progress";
                const accuracyPct =
                  stats.attempted > 0
                    ? Math.round((stats.correct / stats.attempted) * 100)
                    : 0;

                return (
                  <div key={section.id}>
                    <button
                      onClick={() =>
                        setExpandedSection(isExpanded ? null : section.id)
                      }
                      className="w-full text-left relative"
                      style={{
                        background: isExpanded
                          ? "var(--color-prax-cream-card)"
                          : "var(--color-prax-cream-deep)",
                        border: "1px solid var(--color-prax-cream-border)",
                        borderRadius: 14,
                        padding: "16px 22px",
                        cursor: "pointer",
                      }}
                    >
                      <div className="flex items-center gap-4">
                        <SectionStatusDot status={status} />
                        <div className="flex-1 min-w-0">
                          <div
                            className="font-medium"
                            style={{
                              fontFamily: "var(--font-prax-serif)",
                              fontSize: 18,
                              color: "var(--color-prax-green)",
                            }}
                          >
                            {section.label}
                          </div>
                          {dataLoaded && (
                            <SmallCaps
                              style={{
                                marginTop: 4,
                                color: "var(--color-prax-ink-mute)",
                              }}
                            >
                              {stats.total} question
                              {stats.total === 1 ? "" : "s"}
                              {stats.attempted > 0
                                ? ` · ${stats.attempted} attempted · ${accuracyPct}% correct`
                                : ""}
                            </SmallCaps>
                          )}
                          {dataLoaded && stats.total > 0 && (
                            <TwoColorBar
                              total={stats.total}
                              correct={stats.correct}
                              incorrect={stats.incorrect}
                            />
                          )}
                        </div>
                        <svg
                          width="16"
                          height="16"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="var(--color-prax-ink-mute)"
                          strokeWidth="2"
                          style={{
                            transform: isExpanded
                              ? "rotate(180deg)"
                              : "none",
                            transition: "transform 0.2s",
                            flexShrink: 0,
                          }}
                        >
                          <path d="M6 9l6 6 6-6" />
                        </svg>
                      </div>
                    </button>

                    {isExpanded && (
                      <div className="mt-2 ml-4 space-y-1">
                        {/* "All of section" row */}
                        <button
                          onClick={() => startSectionSession(section.id)}
                          disabled={loading || stats.unseen === 0}
                          className="w-full text-left block px-4 py-3 transition-colors disabled:opacity-60"
                          style={{
                            background: "var(--color-prax-cream-card)",
                            border: "1px solid var(--color-prax-cream-border)",
                            borderRadius: 10,
                          }}
                        >
                          <div
                            className="font-medium"
                            style={{
                              fontFamily: "var(--font-prax-serif)",
                              fontSize: 15,
                              color: "var(--color-prax-green)",
                            }}
                          >
                            All {section.label}
                          </div>
                          <div
                            className="mt-0.5"
                            style={{
                              fontSize: 11,
                              color: "var(--color-prax-ink-mute)",
                              fontVariantNumeric: "tabular-nums",
                            }}
                          >
                            {stats.unseen > 0
                              ? `${stats.unseen} unseen · random shuffle`
                              : "Every question attempted"}
                          </div>
                        </button>

                        {topicsInSection(section.id).map((t) => (
                          <TopicCard
                            key={t.name}
                            topic={t}
                            onStart={() => startTopicSession(section.id, t.name)}
                            disabled={loading}
                          />
                        ))}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          </div>
        )}

        {/* ─────────── BUILDER MODAL ─────────── */}
        {showBuilder && (
          <BuilderModal
            onClose={() => setShowBuilder(false)}
            sections={SECTIONS}
            sectionStatsFn={sectionStats}
            availableTopics={getBuilderTopics()}
            builderSections={builderSections}
            setBuilderSections={setBuilderSections}
            builderTopics={builderTopics}
            setBuilderTopics={setBuilderTopics}
            builderAllTopics={builderAllTopics}
            setBuilderAllTopics={setBuilderAllTopics}
            builderDifficulty={builderDifficulty}
            setBuilderDifficulty={setBuilderDifficulty}
            builderCount={builderCount}
            setBuilderCount={setBuilderCount}
            builderStep={builderStep}
            setBuilderStep={setBuilderStep}
            matchCount={getBuilderMatch()}
            onLaunch={launchBuilder}
            loading={loading}
          />
        )}

        {loading && !showBuilder && (
          <div className="mt-6 text-center">
            <div
              className="w-6 h-6 mx-auto mb-2 rounded-full"
              style={{
                border: "2px solid var(--color-prax-green)",
                borderTopColor: "transparent",
                animation: "spin 0.8s linear infinite",
              }}
            />
            <p
              style={{ fontSize: 13, color: "var(--color-prax-ink-soft)" }}
            >
              Setting up your session…
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

/* ─────────────── TopicCard ─────────────── */

function TopicCard({
  topic,
  onStart,
  disabled,
}: {
  topic: {
    name: string;
    total: number;
    attempted: number;
    correct: number;
  };
  onStart: () => void;
  disabled: boolean;
}) {
  const status: "untouched" | "in-progress" | "mastered" =
    topic.total === 0 || topic.attempted === 0
      ? "untouched"
      : topic.attempted >= topic.total && topic.correct === topic.attempted
      ? "mastered"
      : "in-progress";
  const incorrect = topic.attempted - topic.correct;
  const accuracyPct =
    topic.attempted > 0
      ? Math.round((topic.correct / topic.attempted) * 100)
      : 0;

  return (
    <button
      onClick={onStart}
      disabled={disabled}
      className="w-full text-left block px-4 py-3 transition-colors disabled:opacity-60"
      style={{
        background: "var(--color-prax-cream-card)",
        border: "1px solid var(--color-prax-cream-border)",
        borderRadius: 10,
      }}
    >
      <div className="flex items-start gap-3">
        <SectionStatusDot status={status} />
        <div className="flex-1 min-w-0">
          <div
            className="font-medium truncate"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 15,
              color: "var(--color-prax-green)",
            }}
          >
            {topic.name}
          </div>
          <div
            className="mt-0.5"
            style={{
              fontSize: 11,
              color: "var(--color-prax-ink-mute)",
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {topic.total} question{topic.total === 1 ? "" : "s"}
            {topic.attempted > 0
              ? ` · ${topic.attempted} attempted · ${accuracyPct}% correct`
              : ""}
          </div>
          <TwoColorBar
            total={topic.total}
            correct={topic.correct}
            incorrect={incorrect}
          />
        </div>
      </div>
    </button>
  );
}

/* ─────────────── Two-color progress bar ─────────────── */

function TwoColorBar({
  total,
  correct,
  incorrect,
}: {
  total: number;
  correct: number;
  incorrect: number;
}) {
  if (total === 0) return null;
  const unseen = Math.max(0, total - correct - incorrect);
  return (
    <div
      className="mt-2 flex"
      style={{
        height: 2,
        background: "var(--color-prax-cream-border)",
        borderRadius: 2,
        overflow: "hidden",
      }}
    >
      {correct > 0 && (
        <div
          style={{
            flex: correct,
            background: "var(--color-prax-green)",
            transition: "flex 400ms ease-out",
          }}
        />
      )}
      {incorrect > 0 && (
        <div
          style={{
            flex: incorrect,
            background: "var(--color-prax-gold)",
            transition: "flex 400ms ease-out",
          }}
        />
      )}
      {unseen > 0 && (
        <div
          style={{
            flex: unseen,
            background: "transparent",
          }}
        />
      )}
    </div>
  );
}

/* ─────────────── Status dot ─────────────── */

function SectionStatusDot({
  status,
}: {
  status: "untouched" | "in-progress" | "mastered";
}) {
  const size = 14;
  const wrap: React.CSSProperties = {
    width: size,
    height: size,
    marginTop: 4,
    flexShrink: 0,
  };
  if (status === "untouched") {
    return (
      <div
        style={{
          ...wrap,
          borderRadius: "50%",
          border: "1.5px solid var(--color-prax-ink-mute)",
          opacity: 0.55,
        }}
      />
    );
  }
  if (status === "in-progress") {
    return (
      <div
        style={{
          ...wrap,
          borderRadius: "50%",
          background: "var(--color-prax-green)",
        }}
      />
    );
  }
  return (
    <div
      style={{
        ...wrap,
        borderRadius: "50%",
        background: "var(--color-prax-green)",
        display: "grid",
        placeItems: "center",
      }}
    >
      <svg
        width={9}
        height={9}
        viewBox="0 0 24 24"
        fill="none"
        stroke="var(--color-prax-cream)"
        strokeWidth={3.5}
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <path d="M5 13l4 4L19 7" />
      </svg>
    </div>
  );
}

/* ─────────────── Builder modal ─────────────── */

function BuilderModal({
  onClose,
  sections,
  sectionStatsFn,
  availableTopics,
  builderSections,
  setBuilderSections,
  builderTopics,
  setBuilderTopics,
  builderAllTopics,
  setBuilderAllTopics,
  builderDifficulty,
  setBuilderDifficulty,
  builderCount,
  setBuilderCount,
  builderStep,
  setBuilderStep,
  matchCount,
  onLaunch,
  loading,
}: {
  onClose: () => void;
  sections: { id: string; label: string }[];
  sectionStatsFn: (id: string) => { unseen: number; total: number };
  availableTopics: { name: string; section: string; count: number }[];
  builderSections: Set<string>;
  setBuilderSections: (s: Set<string>) => void;
  builderTopics: Set<string>;
  setBuilderTopics: (s: Set<string>) => void;
  builderAllTopics: boolean;
  setBuilderAllTopics: (b: boolean) => void;
  builderDifficulty: string;
  setBuilderDifficulty: (d: string) => void;
  builderCount: number;
  setBuilderCount: (n: number) => void;
  builderStep: 1 | 2 | 3;
  setBuilderStep: (n: 1 | 2 | 3) => void;
  matchCount: number;
  onLaunch: () => void;
  loading: boolean;
}) {
  function toggleSection(id: string) {
    const next = new Set(builderSections);
    if (next.has(id)) next.delete(id);
    else next.add(id);
    setBuilderSections(next);
    setBuilderTopics(new Set());
    setBuilderAllTopics(false);
  }
  function toggleTopic(name: string) {
    if (builderAllTopics) {
      setBuilderAllTopics(false);
      setBuilderTopics(new Set([name]));
      return;
    }
    const next = new Set(builderTopics);
    if (next.has(name)) next.delete(name);
    else next.add(name);
    setBuilderTopics(next);
  }

  return (
    <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center">
      <div
        className="absolute inset-0"
        style={{ background: "rgba(28, 28, 19, 0.45)" }}
        onClick={onClose}
      />
      <div
        className="relative rounded-t-2xl sm:rounded-2xl w-full sm:max-w-xl max-h-[92vh] overflow-y-auto p-8 pb-10"
        style={{
          background: "var(--color-prax-cream)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        <div className="flex items-start justify-between mb-5">
          <div>
            <SmallCaps style={{ marginBottom: 8 }}>
              Practice · Custom Session
            </SmallCaps>
            <h3
              className="font-serif"
              style={{
                fontSize: 22,
                fontWeight: 500,
                color: "var(--color-prax-ink)",
                lineHeight: 1.1,
              }}
            >
              Build your session
            </h3>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Close"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            <svg
              width={18}
              height={18}
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth={1.8}
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <path d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div className="flex items-center gap-2 mb-6">
          {[1, 2, 3].map((step) => (
            <div key={step} className="flex-1">
              <div
                style={{
                  height: 3,
                  borderRadius: 999,
                  background:
                    builderStep >= step
                      ? "var(--color-prax-green)"
                      : "var(--color-prax-cream-border)",
                  transition: "background 200ms",
                }}
              />
            </div>
          ))}
        </div>

        {builderStep === 1 && (
          <>
            <SmallCaps style={{ marginBottom: 6 }}>Step 1 of 3</SmallCaps>
            <div
              className="font-serif mb-3"
              style={{ fontSize: 18, color: "var(--color-prax-green)" }}
            >
              Which sections do you want to practice?
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-6">
              {sections.map((s) => {
                const selected = builderSections.has(s.id);
                const stats = sectionStatsFn(s.id);
                return (
                  <button
                    key={s.id}
                    onClick={() => toggleSection(s.id)}
                    className="text-left transition-colors"
                    style={{
                      background: selected
                        ? "var(--color-prax-green)"
                        : "var(--color-prax-cream-card)",
                      color: selected
                        ? "var(--color-prax-cream)"
                        : "var(--color-prax-ink)",
                      border: selected
                        ? "1px solid var(--color-prax-green)"
                        : "1px solid var(--color-prax-cream-border)",
                      borderRadius: 12,
                      padding: "14px 16px",
                    }}
                  >
                    <div
                      className="font-medium"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 15,
                      }}
                    >
                      {s.label}
                    </div>
                    <div
                      className="mt-1"
                      style={{
                        fontSize: 11,
                        opacity: 0.75,
                        fontVariantNumeric: "tabular-nums",
                      }}
                    >
                      {stats.unseen} unseen of {stats.total}
                    </div>
                  </button>
                );
              })}
            </div>
            <button
              onClick={() => setBuilderStep(2)}
              disabled={builderSections.size === 0}
              style={{
                ...praxBtnGreenOnCream,
                width: "100%",
                justifyContent: "center",
                opacity: builderSections.size === 0 ? 0.4 : 1,
              }}
            >
              Next
            </button>
          </>
        )}

        {builderStep === 2 && (
          <>
            <SmallCaps style={{ marginBottom: 6 }}>Step 2 of 3</SmallCaps>
            <div
              className="font-serif mb-3"
              style={{ fontSize: 18, color: "var(--color-prax-green)" }}
            >
              Narrow your focus
            </div>
            <div className="flex items-center justify-between mb-3">
              <div
                style={{ fontSize: 12, color: "var(--color-prax-ink-soft)" }}
              >
                {builderAllTopics
                  ? "All topics selected"
                  : builderTopics.size === 0
                  ? "No topics selected"
                  : `${builderTopics.size} topic${
                      builderTopics.size === 1 ? "" : "s"
                    } selected`}
              </div>
              <button
                onClick={() => {
                  if (builderAllTopics) {
                    setBuilderAllTopics(false);
                    setBuilderTopics(new Set());
                  } else {
                    setBuilderAllTopics(true);
                    setBuilderTopics(new Set());
                  }
                }}
                style={{
                  fontSize: 11,
                  fontWeight: 600,
                  padding: "4px 10px",
                  borderRadius: 999,
                  background: builderAllTopics
                    ? "var(--color-prax-green)"
                    : "transparent",
                  color: builderAllTopics
                    ? "var(--color-prax-cream)"
                    : "var(--color-prax-green)",
                  border: builderAllTopics
                    ? "1px solid var(--color-prax-green)"
                    : "1px solid var(--color-prax-cream-border)",
                  cursor: "pointer",
                }}
              >
                {builderAllTopics ? "All Topics ✓" : "Select All"}
              </button>
            </div>
            <div className="max-h-[50vh] overflow-y-auto mb-6 space-y-1.5">
              {availableTopics.length === 0 ? (
                <div
                  style={{
                    fontSize: 13,
                    fontStyle: "italic",
                    color: "var(--color-prax-ink-mute)",
                    padding: "12px 0",
                  }}
                >
                  No topics yet for the selected sections.
                </div>
              ) : (
                availableTopics.map((t) => {
                  const selected =
                    builderAllTopics || builderTopics.has(t.name);
                  return (
                    <button
                      key={t.name}
                      onClick={() => toggleTopic(t.name)}
                      className="w-full text-left transition-colors"
                      style={{
                        background: selected
                          ? "var(--color-prax-green-soft)"
                          : "var(--color-prax-cream-card)",
                        color: "var(--color-prax-ink)",
                        border: selected
                          ? "1px solid var(--color-prax-green)"
                          : "1px solid var(--color-prax-cream-border)",
                        borderRadius: 10,
                        padding: "10px 14px",
                        fontSize: 13,
                      }}
                    >
                      <div className="flex items-center justify-between">
                        <span>{t.name}</span>
                        <span
                          style={{
                            fontSize: 11,
                            color: "var(--color-prax-ink-mute)",
                            fontVariantNumeric: "tabular-nums",
                          }}
                        >
                          {t.count}
                        </span>
                      </div>
                    </button>
                  );
                })
              )}
            </div>
            <div className="flex gap-3">
              <button
                onClick={() => setBuilderStep(1)}
                style={{
                  flex: 1,
                  padding: "11px 22px",
                  borderRadius: 999,
                  background: "transparent",
                  color: "var(--color-prax-ink-soft)",
                  border: "1px solid var(--color-prax-cream-border)",
                  fontSize: 11.5,
                  fontWeight: 600,
                  textTransform: "uppercase",
                  letterSpacing: "0.14em",
                  cursor: "pointer",
                }}
              >
                Back
              </button>
              <button
                onClick={() => setBuilderStep(3)}
                disabled={!builderAllTopics && builderTopics.size === 0}
                style={{
                  ...praxBtnGreenOnCream,
                  flex: 1,
                  justifyContent: "center",
                  opacity:
                    !builderAllTopics && builderTopics.size === 0 ? 0.4 : 1,
                }}
              >
                Next
              </button>
            </div>
          </>
        )}

        {builderStep === 3 && (
          <>
            <SmallCaps style={{ marginBottom: 6 }}>Step 3 of 3</SmallCaps>
            <div
              className="font-serif mb-4"
              style={{ fontSize: 18, color: "var(--color-prax-green)" }}
            >
              Tune the session
            </div>

            <div className="mb-5">
              <SmallCaps style={{ marginBottom: 8 }}>Difficulty</SmallCaps>
              <div className="flex flex-wrap gap-2">
                {DIFFICULTY_OPTIONS.map((d) => {
                  const selected = builderDifficulty === d.id;
                  return (
                    <button
                      key={d.id}
                      onClick={() => setBuilderDifficulty(d.id)}
                      style={{
                        padding: "8px 16px",
                        borderRadius: 999,
                        background: selected
                          ? "var(--color-prax-green)"
                          : "var(--color-prax-cream-card)",
                        color: selected
                          ? "var(--color-prax-cream)"
                          : "var(--color-prax-ink)",
                        border: "1px solid",
                        borderColor: selected
                          ? "var(--color-prax-green)"
                          : "var(--color-prax-cream-border)",
                        fontSize: 12.5,
                        fontWeight: 500,
                        cursor: "pointer",
                      }}
                    >
                      {d.label}
                    </button>
                  );
                })}
              </div>
            </div>

            <div className="mb-5">
              <SmallCaps style={{ marginBottom: 8 }}>How many?</SmallCaps>
              <div className="flex flex-wrap gap-2 mb-3">
                {[10, 25, 50].map((n) => {
                  const selected = builderCount === n;
                  return (
                    <button
                      key={n}
                      onClick={() => setBuilderCount(n)}
                      style={{
                        padding: "8px 16px",
                        borderRadius: 999,
                        background: selected
                          ? "var(--color-prax-green)"
                          : "var(--color-prax-cream-card)",
                        color: selected
                          ? "var(--color-prax-cream)"
                          : "var(--color-prax-ink)",
                        border: "1px solid",
                        borderColor: selected
                          ? "var(--color-prax-green)"
                          : "var(--color-prax-cream-border)",
                        fontSize: 12.5,
                        fontWeight: 500,
                        cursor: "pointer",
                      }}
                    >
                      {n}
                    </button>
                  );
                })}
                <button
                  onClick={() => setBuilderCount(0)}
                  style={{
                    padding: "8px 16px",
                    borderRadius: 999,
                    background:
                      builderCount === 0
                        ? "var(--color-prax-green)"
                        : "var(--color-prax-cream-card)",
                    color:
                      builderCount === 0
                        ? "var(--color-prax-cream)"
                        : "var(--color-prax-ink)",
                    border: "1px solid",
                    borderColor:
                      builderCount === 0
                        ? "var(--color-prax-green)"
                        : "var(--color-prax-cream-border)",
                    fontSize: 12.5,
                    fontWeight: 500,
                    cursor: "pointer",
                  }}
                >
                  All
                </button>
              </div>
            </div>

            <div
              className="rounded-xl mb-6 px-4 py-3"
              style={{
                background: "var(--color-prax-cream-card)",
                border: "1px solid var(--color-prax-cream-border)",
              }}
            >
              <SmallCaps style={{ marginBottom: 4 }}>Your session</SmallCaps>
              <div
                style={{
                  fontSize: 13,
                  color: "var(--color-prax-ink)",
                  fontVariantNumeric: "tabular-nums",
                }}
              >
                <strong>{matchCount}</strong> unseen question
                {matchCount === 1 ? "" : "s"} match — you&apos;ll see{" "}
                <strong>
                  {builderCount === 0
                    ? matchCount
                    : Math.min(builderCount, matchCount)}
                </strong>
                .
              </div>
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => setBuilderStep(2)}
                style={{
                  flex: 1,
                  padding: "11px 22px",
                  borderRadius: 999,
                  background: "transparent",
                  color: "var(--color-prax-ink-soft)",
                  border: "1px solid var(--color-prax-cream-border)",
                  fontSize: 11.5,
                  fontWeight: 600,
                  textTransform: "uppercase",
                  letterSpacing: "0.14em",
                  cursor: "pointer",
                }}
              >
                Back
              </button>
              <button
                onClick={onLaunch}
                disabled={loading || matchCount === 0}
                style={{
                  ...praxBtnGreenOnCream,
                  flex: 1,
                  justifyContent: "center",
                  opacity: loading || matchCount === 0 ? 0.4 : 1,
                }}
              >
                {loading ? "Starting…" : "Start Session"}
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
