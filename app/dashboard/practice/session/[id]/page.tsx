"use client";

import { useEffect, useState, useCallback, useRef } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface Passage {
  id: string;
  title: string | null;
  content: string;
}

interface Question {
  id: string;
  section: string;
  subtopic: string;
  passage_id: string | null;
  question_text: string;
  options: { label: string; text: string }[];
  correct_answer: string;
  explanation: string;
  difficulty: string;
}

type SessionState = "answering" | "feedback" | "complete";

export default function PracticeSession() {
  const params = useParams();
  const router = useRouter();
  const { user } = useDashboard();
  const sessionId = params.id as string;

  const [questions, setQuestions] = useState<Question[]>([]);
  const [passages, setPassages] = useState<Record<string, Passage>>({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [sessionState, setSessionState] = useState<SessionState>("answering");
  const [results, setResults] = useState<
    { questionId: string; selected: string; correct: string; isCorrect: boolean }[]
  >([]);
  const [loading, setLoading] = useState(true);
  const [questionStartTime, setQuestionStartTime] = useState<number>(Date.now());

  // Timer
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const [timerRunning, setTimerRunning] = useState(true);
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);

  // Flagged questions
  const [flagged, setFlagged] = useState<Set<number>>(new Set());

  // Navigation overlay
  const [showNav, setShowNav] = useState(false);

  // Strikethrough state per question
  const [strikethroughs, setStrikethroughs] = useState<Record<number, Set<string>>>({});
  const [strikethroughMode, setStrikethroughMode] = useState(false);

  // Timer effect
  useEffect(() => {
    if (timerRunning) {
      timerRef.current = setInterval(() => {
        setElapsedSeconds((prev) => prev + 1);
      }, 1000);
    }
    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, [timerRunning]);

  function formatTime(s: number) {
    const h = Math.floor(s / 3600);
    const m = Math.floor((s % 3600) / 60);
    const sec = s % 60;
    return `${String(h).padStart(2, "0")}:${String(m).padStart(2, "0")}:${String(sec).padStart(2, "0")}`;
  }

  // Load questions
  useEffect(() => {
    async function load() {
      const stored = sessionStorage.getItem(`session_${sessionId}`);
      if (!stored) {
        router.push("/dashboard/practice");
        return;
      }

      const questionIds: string[] = JSON.parse(stored);

      const { data } = await supabase
        .from("questions")
        .select("*")
        .in("id", questionIds);

      if (!data || data.length === 0) {
        router.push("/dashboard/practice");
        return;
      }

      const ordered = questionIds
        .map((id) => data.find((q) => q.id === id))
        .filter(Boolean) as Question[];

      const passageIds = [
        ...new Set(ordered.filter((q) => q.passage_id).map((q) => q.passage_id!)),
      ];
      if (passageIds.length > 0) {
        const { data: passageData } = await supabase
          .from("passages")
          .select("id, title, content")
          .in("id", passageIds);
        if (passageData) {
          const pMap: Record<string, Passage> = {};
          passageData.forEach((p) => (pMap[p.id] = p));
          setPassages(pMap);
        }
      }

      setQuestions(ordered);
      setLoading(false);
      setQuestionStartTime(Date.now());
    }

    load();
  }, [sessionId, router]);

  const currentQuestion = questions[currentIndex];

  const submitAnswer = useCallback(async () => {
    if (!selectedAnswer || !currentQuestion) return;

    const isCorrect = selectedAnswer === currentQuestion.correct_answer;
    const timeSpent = Math.round((Date.now() - questionStartTime) / 1000);
    const isReviewMode =
      sessionStorage.getItem(`session_${sessionId}_mode`) === "review";

    await supabase.from("question_attempts").insert({
      user_id: user.id,
      question_id: currentQuestion.id,
      session_id: sessionId,
      selected_answer: selectedAnswer,
      is_correct: isCorrect,
      time_spent_seconds: timeSpent,
    });

    if (!isCorrect) {
      await supabase.from("review_schedule").upsert(
        {
          user_id: user.id,
          question_id: currentQuestion.id,
          next_review_date: new Date(Date.now() + 86400000)
            .toISOString()
            .split("T")[0],
          interval_days: 1,
          ease_factor: 2.5,
          review_count: 0,
        },
        { onConflict: "user_id,question_id" }
      );
    } else if (isReviewMode) {
      const { data: schedule } = await supabase
        .from("review_schedule")
        .select("*")
        .eq("user_id", user.id)
        .eq("question_id", currentQuestion.id)
        .single();

      if (schedule) {
        const newCount = schedule.review_count + 1;
        let newInterval: number;
        if (newCount === 1) newInterval = 3;
        else if (newCount === 2) newInterval = 7;
        else
          newInterval = Math.round(
            schedule.interval_days * Number(schedule.ease_factor)
          );

        const nextDate = new Date(Date.now() + newInterval * 86400000)
          .toISOString()
          .split("T")[0];

        await supabase
          .from("review_schedule")
          .update({
            next_review_date: nextDate,
            interval_days: newInterval,
            review_count: newCount,
          })
          .eq("id", schedule.id);
      }
    }

    setResults((prev) => [
      ...prev,
      {
        questionId: currentQuestion.id,
        selected: selectedAnswer,
        correct: currentQuestion.correct_answer,
        isCorrect,
      },
    ]);

    setSessionState("feedback");
    setTimerRunning(false);
  }, [selectedAnswer, currentQuestion, questionStartTime, user.id, sessionId]);

  function goToQuestion(idx: number) {
    setCurrentIndex(idx);
    setSelectedAnswer(null);
    setSessionState("answering");
    setQuestionStartTime(Date.now());
    setShowNav(false);
    setStrikethroughMode(false);
    setTimerRunning(true);
  }

  async function nextQuestion() {
    if (currentIndex + 1 >= questions.length) {
      setTimerRunning(false);
      const allResults = results;
      const correctCount = allResults.filter((r) => r.isCorrect).length +
        (selectedAnswer === currentQuestion?.correct_answer ? 1 : 0);

      await supabase
        .from("practice_sessions")
        .update({
          status: "completed",
          correct_count: correctCount,
          completed_at: new Date().toISOString(),
        })
        .eq("id", sessionId);

      const today = new Date().toISOString().split("T")[0];
      const { data: existing } = await supabase
        .from("daily_activity")
        .select("*")
        .eq("user_id", user.id)
        .eq("activity_date", today)
        .single();

      if (existing) {
        await supabase
          .from("daily_activity")
          .update({
            questions_completed:
              existing.questions_completed + questions.length,
          })
          .eq("id", existing.id);
      } else {
        await supabase.from("daily_activity").insert({
          user_id: user.id,
          activity_date: today,
          questions_completed: questions.length,
        });
      }

      setSessionState("complete");
      return;
    }

    setCurrentIndex((prev) => prev + 1);
    setSelectedAnswer(null);
    setSessionState("answering");
    setQuestionStartTime(Date.now());
    setStrikethroughMode(false);
    setTimerRunning(true);
  }

  function toggleFlag() {
    setFlagged((prev) => {
      const next = new Set(prev);
      if (next.has(currentIndex)) next.delete(currentIndex);
      else next.add(currentIndex);
      return next;
    });
  }

  function toggleStrikethrough(label: string) {
    setStrikethroughs((prev) => {
      const current = prev[currentIndex] || new Set();
      const next = new Set(current);
      if (next.has(label)) next.delete(label);
      else next.add(label);
      return { ...prev, [currentIndex]: next };
    });
  }

  // Loading state
  if (loading) {
    return (
      <div className="fixed inset-0 z-[200] bg-[#4a5d8a] flex items-center justify-center">
        <div className="text-center">
          <div className="w-8 h-8 border-2 border-white border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-sm text-white/80">Loading your exam...</p>
        </div>
      </div>
    );
  }

  // ====== COMPLETE STATE ======
  if (sessionState === "complete") {
    const allResults = results;
    const correctCount = allResults.filter((r) => r.isCorrect).length;
    const total = allResults.length;
    const pct = Math.round((correctCount / total) * 100);

    return (
      <div className="fixed inset-0 z-[200] bg-as-surface flex items-center justify-center p-4">
        <div className="w-full max-w-lg bg-white rounded-2xl border border-as-outline-variant/15 p-8 sm:p-10 text-center shadow-lg">
          <div className="w-24 h-24 rounded-full border-4 border-as-primary flex items-center justify-center mx-auto mb-6">
            <span className="text-3xl font-bold text-as-primary">{pct}%</span>
          </div>

          <h1 className="font-headline text-2xl text-as-primary mb-2">
            Session Complete
          </h1>
          <p className="text-as-secondary mb-2">
            You got{" "}
            <span className="font-semibold text-as-primary">
              {correctCount} out of {total}
            </span>{" "}
            questions correct.
          </p>
          <p className="text-sm text-as-outline mb-6">
            Time: {formatTime(elapsedSeconds)}
          </p>

          <div className="flex justify-center gap-8 mb-8 text-sm">
            <div>
              <p className="text-2xl font-semibold text-as-primary">{correctCount}</p>
              <p className="text-as-outline">Correct</p>
            </div>
            <div>
              <p className="text-2xl font-semibold text-as-on-surface-variant">
                {total - correctCount}
              </p>
              <p className="text-as-outline">Incorrect</p>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-3">
            <Link
              href="/dashboard/practice"
              className="flex-1 inline-flex items-center justify-center rounded-xl bg-as-primary px-6 py-3 text-sm font-semibold text-as-on-primary hover:bg-as-primary-container transition-colors"
            >
              Practice Again
            </Link>
            <Link
              href="/dashboard"
              className="flex-1 inline-flex items-center justify-center rounded-xl border border-as-outline-variant/15 px-6 py-3 text-sm font-semibold text-as-primary hover:bg-as-surface-container-low transition-colors"
            >
              Back to Dashboard
            </Link>
          </div>
        </div>
      </div>
    );
  }

  // ====== EXAM INTERFACE ======
  if (!currentQuestion) return null;

  const currentStrikethroughs = strikethroughs[currentIndex] || new Set();
  const hasPassage = currentQuestion.passage_id && passages[currentQuestion.passage_id];
  const answeredQuestions = new Set(results.map((r) => r.questionId));

  // Parse per-answer explanations from the explanation string
  // Looks for patterns like "A)" or "A." or "A:" followed by explanation text
  function getPerAnswerExplanation(label: string): string | null {
    const explanation = currentQuestion.explanation;
    if (!explanation) return null;

    // Try matching "A)" or "A." or "A:" patterns
    const regex = new RegExp(
      `${label}[).:]\\s*(.+?)(?=\\s*[B-D][).:]|$)`,
      "is"
    );
    const match = explanation.match(regex);
    if (match) return match[1].trim();

    return null;
  }

  return (
    <div className="fixed inset-0 z-[200] flex flex-col bg-[#e8e8e8] font-sans text-[14px]">
      {/* ===== TOP BAR ===== */}
      <div className="bg-[#4a5d8a] text-white px-4 py-1.5 flex items-center justify-between text-xs shrink-0">
        <div className="flex items-center gap-2">
          <span className="font-semibold">Praxist Prep — Practice Exam</span>
        </div>
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2">
            <span className="text-white/70">Timer:</span>
            <button
              onClick={() => setTimerRunning(!timerRunning)}
              className="hover:text-white/80 transition-colors"
              title={timerRunning ? "Pause timer" : "Resume timer"}
            >
              {timerRunning ? "▐▐" : "▶"}
            </button>
            <span className="font-mono font-semibold tabular-nums">
              {formatTime(elapsedSeconds)}
            </span>
          </div>
          <span className="text-white/70">
            {currentIndex + 1} of {questions.length}
          </span>
        </div>
      </div>

      {/* ===== TOOLBAR ===== */}
      <div className="bg-[#6b7db5] text-white px-4 py-1 flex items-center justify-between text-xs shrink-0">
        <div className="flex items-center gap-4">
          <button
            onClick={() => setStrikethroughMode(!strikethroughMode)}
            className={`flex items-center gap-1 px-2 py-0.5 rounded transition-colors ${
              strikethroughMode ? "bg-white/20" : "hover:bg-white/10"
            }`}
          >
            <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
              <path d="M16 4H9a3 3 0 00-3 3v0a3 3 0 003 3h6a3 3 0 013 3v0a3 3 0 01-3 3H6" strokeLinecap="round" />
              <path d="M4 12h16" strokeLinecap="round" />
            </svg>
            Strikethrough
          </button>
        </div>
        <button
          onClick={toggleFlag}
          className={`flex items-center gap-1 px-2 py-0.5 rounded transition-colors ${
            flagged.has(currentIndex) ? "bg-yellow-500/30 text-yellow-200" : "hover:bg-white/10"
          }`}
        >
          <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill={flagged.has(currentIndex) ? "currentColor" : "none"} stroke="currentColor" strokeWidth={2}>
            <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z" />
            <line x1="4" y1="22" x2="4" y2="15" />
          </svg>
          Flag for Review
        </button>
      </div>

      {/* ===== MAIN CONTENT (split pane) ===== */}
      <div className="flex-1 flex overflow-hidden">
        {/* LEFT PANEL — Passage or instructions */}
        <div className="w-1/2 bg-white border-r border-[#ccc] overflow-y-auto">
          <div className="p-6">
            {hasPassage ? (
              <>
                {passages[currentQuestion.passage_id!].title && (
                  <p className="text-xs font-bold uppercase tracking-wider text-[#4a5d8a] mb-3">
                    {passages[currentQuestion.passage_id!].title}
                  </p>
                )}
                <div className="text-[14px] text-[#333] leading-relaxed whitespace-pre-line">
                  {passages[currentQuestion.passage_id!].content}
                </div>
              </>
            ) : (
              <p className="text-[14px] font-bold text-[#333]">
                Questions {currentIndex + 1} - {questions.length} do not refer to a passage and are independent of each other.
              </p>
            )}
          </div>
        </div>

        {/* RIGHT PANEL — Question + Answers */}
        <div className="w-1/2 bg-white overflow-y-auto">
          <div className="p-6">
            <h2 className="font-bold text-[14px] text-[#333] mb-4">
              Question {currentIndex + 1}
            </h2>

            <p className="text-[14px] text-[#333] leading-relaxed mb-6">
              {currentQuestion.question_text}
            </p>

            {/* Answer choices */}
            <div className="space-y-2">
              {currentQuestion.options.map((option) => {
                const isSelected = selectedAnswer === option.label;
                const isCorrect = option.label === currentQuestion.correct_answer;
                const showFeedback = sessionState === "feedback";
                const isStruckThrough = currentStrikethroughs.has(option.label);

                let indicatorIcon = null;
                let textColor = "text-[#333]";

                if (showFeedback) {
                  if (isCorrect) {
                    indicatorIcon = (
                      <span className="shrink-0 mt-0.5 text-green-600 text-sm">✓</span>
                    );
                  } else if (isSelected && !isCorrect) {
                    indicatorIcon = (
                      <span className="shrink-0 mt-0.5 text-red-500 text-sm">✗</span>
                    );
                  }
                }

                return (
                  <button
                    key={option.label}
                    onClick={() => {
                      if (sessionState === "feedback") return;
                      if (strikethroughMode) {
                        toggleStrikethrough(option.label);
                      } else {
                        setSelectedAnswer(option.label);
                      }
                    }}
                    disabled={sessionState === "feedback"}
                    className={`w-full text-left flex items-start gap-2.5 py-2 px-1 transition-colors ${
                      sessionState === "answering" && !strikethroughMode
                        ? "hover:bg-[#f0f0f0] cursor-pointer"
                        : sessionState === "answering" && strikethroughMode
                        ? "hover:bg-yellow-50 cursor-pointer"
                        : "cursor-default"
                    }`}
                  >
                    {/* Correct/incorrect indicator or empty space */}
                    <span className="w-4 shrink-0 flex justify-center">
                      {indicatorIcon}
                    </span>

                    {/* Radio circle */}
                    <span
                      className={`shrink-0 mt-0.5 w-4 h-4 rounded-full border-2 flex items-center justify-center ${
                        showFeedback && isCorrect
                          ? "border-green-600"
                          : showFeedback && isSelected && !isCorrect
                          ? "border-red-500"
                          : isSelected
                          ? "border-[#4a5d8a] bg-[#4a5d8a]"
                          : "border-[#999]"
                      }`}
                    >
                      {isSelected && !showFeedback && (
                        <span className="w-1.5 h-1.5 rounded-full bg-white" />
                      )}
                      {showFeedback && isCorrect && (
                        <span className="w-2 h-2 rounded-full bg-green-600" />
                      )}
                    </span>

                    {/* Label + text */}
                    <span
                      className={`text-[14px] ${textColor} ${
                        isStruckThrough && !showFeedback
                          ? "line-through text-[#999]"
                          : ""
                      }`}
                    >
                      <strong>{option.label}.</strong> {option.text.split(" — ")[0]}
                    </span>
                  </button>
                );
              })}
            </div>

            {/* Submit button (answering mode) */}
            {sessionState === "answering" && (
              <button
                onClick={submitAnswer}
                disabled={!selectedAnswer}
                className="mt-6 px-6 py-2 bg-[#4a5d8a] text-white text-sm font-semibold rounded hover:bg-[#3d4f75] transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
              >
                Submit Answer
              </button>
            )}

            {/* ===== EXPLANATION SECTION (feedback mode) ===== */}
            {sessionState === "feedback" && (
              <div className="mt-6 border-t border-[#ddd]">
                {/* Header: Topic + what you selected */}
                <div className="flex items-center justify-between py-3 border-b border-[#eee]">
                  <p className="text-[13px] text-[#666]">
                    <strong className="text-[#333]">Topic:</strong>{" "}
                    {currentQuestion.subtopic.replace(/_/g, " ")}
                  </p>
                  <p className="text-[13px]">
                    <span className="text-[#666]">You Selected </span>
                    <strong>{selectedAnswer}</strong>
                    <span className="text-[#666]"> | </span>
                    <strong className={
                      selectedAnswer === currentQuestion.correct_answer
                        ? "text-green-600"
                        : "text-red-500"
                    }>
                      {currentQuestion.correct_answer} is correct
                    </strong>
                  </p>
                </div>

                {/* Praxist Prep Solution heading */}
                <div className="pt-4 pb-2">
                  <h3 className="font-bold text-[14px] text-[#333]">
                    Praxist Prep — Question Solution
                  </h3>
                  <p className="text-green-700 font-bold text-[13px] mt-1">
                    Correct Answer: Choice {currentQuestion.correct_answer}
                  </p>
                </div>

                {/* Main explanation */}
                <div className="text-[13px] text-[#333] leading-relaxed pb-4">
                  <p>{currentQuestion.explanation}</p>
                </div>

                {/* Per-choice breakdown */}
                <div className="space-y-2 pb-4">
                  {currentQuestion.options.map((option) => {
                    const isCorrect = option.label === currentQuestion.correct_answer;
                    const perAnswer = getPerAnswerExplanation(option.label);

                    // Only show per-choice if we found a parsed explanation
                    if (!perAnswer) return null;

                    return (
                      <p key={option.label} className="text-[13px] text-[#333] leading-relaxed">
                        <strong className={isCorrect ? "text-green-700" : "text-[#333]"}>
                          (Choice {option.label})
                        </strong>{" "}
                        {perAnswer}
                      </p>
                    );
                  })}
                </div>

                {/* Metadata: time spent + difficulty */}
                <div className="flex items-center gap-8 py-3 border-t border-[#eee] text-[12px] text-[#666]">
                  <div className="flex items-center gap-1.5">
                    <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                      <circle cx="12" cy="12" r="10" />
                      <path d="M12 6v6l4 2" strokeLinecap="round" />
                    </svg>
                    <div>
                      <p className="font-semibold text-[#333]">Time Spent</p>
                      <p>{Math.floor((Date.now() - questionStartTime) / 60000)} mins, {Math.floor(((Date.now() - questionStartTime) / 1000) % 60)} secs</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-1.5">
                    <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                      <path d="M12 2L2 7l10 5 10-5-10-5z" />
                      <path d="M2 17l10 5 10-5M2 12l10 5 10-5" />
                    </svg>
                    <div>
                      <p className="font-semibold text-[#333]">Difficulty</p>
                      <p className="capitalize">{currentQuestion.difficulty}</p>
                    </div>
                  </div>
                </div>

                {/* Next question button */}
                <button
                  onClick={nextQuestion}
                  className="mt-4 px-6 py-2 bg-[#4a5d8a] text-white text-sm font-semibold rounded hover:bg-[#3d4f75] transition-colors"
                >
                  {currentIndex + 1 >= questions.length
                    ? "See Results"
                    : "Next Question"}
                </button>
              </div>
            )}

          </div>
        </div>
      </div>

      {/* ===== BOTTOM BAR ===== */}
      <div className="bg-[#4a5d8a] text-white px-4 py-1.5 flex items-center justify-between text-xs shrink-0">
        <div className="flex items-center gap-2">
          <button
            onClick={() =>
              window.open(
                "https://www.acs.org/content/dam/acsorg/education/students/highschool/chemistryclubs/content/periodic-table.pdf",
                "_blank",
                "width=900,height=600"
              )
            }
            className="flex items-center gap-1.5 hover:bg-white/10 px-2 py-0.5 rounded transition-colors"
          >
            <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
              <rect x="3" y="3" width="7" height="7" rx="1" />
              <rect x="14" y="3" width="7" height="7" rx="1" />
              <rect x="3" y="14" width="7" height="7" rx="1" />
              <rect x="14" y="14" width="7" height="7" rx="1" />
            </svg>
            Periodic Table
          </button>
        </div>

        <div className="flex items-center gap-2">
          <button
            onClick={() => setShowNav(true)}
            className="flex items-center gap-1.5 hover:bg-white/10 px-2 py-0.5 rounded transition-colors"
          >
            <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
              <rect x="3" y="3" width="18" height="18" rx="2" />
              <path d="M3 9h18M9 3v18" />
            </svg>
            Navigation
          </button>

          {currentIndex + 1 < questions.length && sessionState === "answering" && (
            <button
              onClick={() => goToQuestion(currentIndex + 1)}
              className="flex items-center gap-1 hover:bg-white/10 px-2 py-0.5 rounded transition-colors font-semibold"
            >
              Next
              <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                <path d="M9 5l7 7-7 7" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
            </button>
          )}

          {currentIndex > 0 && sessionState === "answering" && (
            <button
              onClick={() => goToQuestion(currentIndex - 1)}
              className="flex items-center gap-1 hover:bg-white/10 px-2 py-0.5 rounded transition-colors font-semibold"
            >
              <svg className="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                <path d="M15 5l-7 7 7 7" strokeLinecap="round" strokeLinejoin="round" />
              </svg>
              Previous
            </button>
          )}
        </div>
      </div>

      {/* ===== NAVIGATION OVERLAY ===== */}
      {showNav && (
        <div className="fixed inset-0 z-[300] flex items-center justify-center bg-black/40">
          <div className="bg-white rounded-lg shadow-xl w-full max-w-md mx-4 overflow-hidden">
            <div className="bg-[#4a5d8a] text-white px-4 py-2 flex items-center justify-between">
              <span className="font-semibold text-sm">Question Navigation</span>
              <button
                onClick={() => setShowNav(false)}
                className="hover:bg-white/10 p-1 rounded"
              >
                <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2}>
                  <path d="M18 6L6 18M6 6l12 12" strokeLinecap="round" />
                </svg>
              </button>
            </div>
            <div className="p-4">
              <div className="grid grid-cols-5 gap-2 mb-4">
                {questions.map((q, idx) => {
                  const isAnswered = answeredQuestions.has(q.id);
                  const isCurrent = idx === currentIndex;
                  const isFlagged = flagged.has(idx);

                  return (
                    <button
                      key={q.id}
                      onClick={() => {
                        if (!isAnswered) goToQuestion(idx);
                      }}
                      disabled={isAnswered}
                      className={`relative w-full aspect-square rounded flex items-center justify-center text-sm font-semibold transition-colors ${
                        isCurrent
                          ? "bg-[#4a5d8a] text-white"
                          : isAnswered
                          ? "bg-[#ccc] text-white cursor-not-allowed"
                          : "bg-[#f0f0f0] text-[#333] hover:bg-[#ddd]"
                      }`}
                    >
                      {idx + 1}
                      {isFlagged && (
                        <span className="absolute -top-1 -right-1 w-3 h-3 bg-yellow-400 rounded-full border border-white" />
                      )}
                    </button>
                  );
                })}
              </div>
              <div className="flex items-center gap-4 text-xs text-[#666] border-t pt-3">
                <div className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded bg-[#4a5d8a]" />
                  Current
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded bg-[#ccc]" />
                  Answered
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded bg-[#f0f0f0] border border-[#ddd]" />
                  Unanswered
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="relative w-3 h-3 rounded bg-[#f0f0f0] border border-[#ddd]">
                    <span className="absolute -top-0.5 -right-0.5 w-2 h-2 bg-yellow-400 rounded-full" />
                  </span>
                  Flagged
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
