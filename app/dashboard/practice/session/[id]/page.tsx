"use client";

import { useEffect, useState, useCallback } from "react";
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

  // Load questions
  useEffect(() => {
    async function load() {
      // Get question IDs from sessionStorage
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

      // Maintain the shuffled order from sessionStorage
      const ordered = questionIds
        .map((id) => data.find((q) => q.id === id))
        .filter(Boolean) as Question[];

      // Load passages if any questions reference them
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

    // Record attempt
    await supabase.from("question_attempts").insert({
      user_id: user.id,
      question_id: currentQuestion.id,
      session_id: sessionId,
      selected_answer: selectedAnswer,
      is_correct: isCorrect,
      time_spent_seconds: timeSpent,
    });

    // Spaced repetition scheduling
    if (!isCorrect) {
      // Wrong answer → schedule for review (1 day from now)
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
      // Correct during review → increase interval using SM-2 algorithm
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
  }, [selectedAnswer, currentQuestion, questionStartTime, user.id, sessionId]);

  async function nextQuestion() {
    if (currentIndex + 1 >= questions.length) {
      // Session complete
      const correctCount = results.filter((r) => r.isCorrect).length +
        (selectedAnswer === currentQuestion?.correct_answer ? 1 : 0);

      // Update session in DB
      await supabase
        .from("practice_sessions")
        .update({
          status: "completed",
          correct_count: correctCount,
          completed_at: new Date().toISOString(),
        })
        .eq("id", sessionId);

      // Update daily activity
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
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="text-center">
          <div className="w-8 h-8 border-2 border-navy border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-sm text-gray-600">Loading questions...</p>
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
      <div className="max-w-lg mx-auto px-4 sm:px-6 py-10 text-center">
        <div className="bg-white rounded-2xl border border-gray-200 p-8 sm:p-10">
          {/* Score circle */}
          <div className="w-24 h-24 rounded-full border-4 border-navy flex items-center justify-center mx-auto mb-6">
            <span className="text-3xl font-bold text-navy">{pct}%</span>
          </div>

          <h1 className="font-serif text-2xl text-navy mb-2">
            Session Complete!
          </h1>
          <p className="text-gray-600 mb-6">
            You got{" "}
            <span className="font-semibold text-navy">
              {correctCount} out of {total}
            </span>{" "}
            questions correct.
          </p>

          {/* Breakdown */}
          <div className="flex justify-center gap-8 mb-8 text-sm">
            <div>
              <p className="text-2xl font-semibold text-sage">{correctCount}</p>
              <p className="text-gray-400">Correct</p>
            </div>
            <div>
              <p className="text-2xl font-semibold text-coral">
                {total - correctCount}
              </p>
              <p className="text-gray-400">Incorrect</p>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-3">
            <Link
              href="/dashboard/practice"
              className="flex-1 inline-flex items-center justify-center rounded-xl bg-navy px-6 py-3 text-sm font-semibold text-white hover:bg-navy-light transition-colors"
            >
              Practice Again
            </Link>
            <Link
              href="/dashboard"
              className="flex-1 inline-flex items-center justify-center rounded-xl border border-gray-200 px-6 py-3 text-sm font-semibold text-navy hover:bg-sand transition-colors"
            >
              Back to Dashboard
            </Link>
          </div>
        </div>
      </div>
    );
  }

  // ====== QUESTION STATE ======
  if (!currentQuestion) return null;

  const sectionLabels: Record<string, string> = {
    bio_biochem: "Bio/Biochem",
    chem_phys: "Chem/Phys",
    psych_soc: "Psych/Soc",
    cars: "CARS",
  };

  return (
    <div className="max-w-2xl mx-auto px-4 sm:px-6 py-6">
      {/* Progress bar */}
      <div className="flex items-center gap-3 mb-6">
        <button
          onClick={() => {
            if (confirm("Are you sure you want to exit this session?")) {
              router.push("/dashboard/practice");
            }
          }}
          className="text-gray-400 hover:text-navy transition-colors"
        >
          <svg
            className="w-5 h-5"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={1.5}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>
        <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
          <div
            className="h-full bg-navy rounded-full transition-all duration-300"
            style={{
              width: `${((currentIndex + 1) / questions.length) * 100}%`,
            }}
          />
        </div>
        <span className="text-xs font-medium text-gray-400">
          {currentIndex + 1}/{questions.length}
        </span>
      </div>

      {/* Section badge */}
      <div className="mb-4">
        <span className="inline-block text-xs font-medium text-gray-400 bg-white border border-gray-200 rounded-full px-3 py-1">
          {sectionLabels[currentQuestion.section] || currentQuestion.section} ·{" "}
          {currentQuestion.subtopic.replace(/_/g, " ")}
        </span>
      </div>

      {/* Passage (if MCAT-style) */}
      {currentQuestion.passage_id && passages[currentQuestion.passage_id] && (
        <div className="bg-sand rounded-2xl border border-gray-200 p-5 sm:p-6 mb-4 max-h-64 overflow-y-auto">
          {passages[currentQuestion.passage_id].title && (
            <p className="text-xs font-semibold text-navy uppercase tracking-wider mb-2">
              {passages[currentQuestion.passage_id].title}
            </p>
          )}
          <p className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
            {passages[currentQuestion.passage_id].content}
          </p>
        </div>
      )}

      {/* Question */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5 sm:p-6 mb-4">
        <p className="text-sm sm:text-base text-navy leading-relaxed">
          {currentQuestion.question_text}
        </p>
      </div>

      {/* Options */}
      <div className="space-y-3 mb-6">
        {currentQuestion.options.map((option) => {
          const isSelected = selectedAnswer === option.label;
          const isCorrect = option.label === currentQuestion.correct_answer;
          const showFeedback = sessionState === "feedback";

          let borderClass = "border-gray-200";
          let bgClass = "bg-white";

          if (showFeedback) {
            if (isCorrect) {
              borderClass = "border-sage";
              bgClass = "bg-sage/5";
            } else if (isSelected && !isCorrect) {
              borderClass = "border-coral";
              bgClass = "bg-coral/5";
            }
          } else if (isSelected) {
            borderClass = "border-navy";
            bgClass = "bg-navy/5";
          }

          return (
            <button
              key={option.label}
              onClick={() => {
                if (sessionState === "answering") {
                  setSelectedAnswer(option.label);
                }
              }}
              disabled={sessionState === "feedback"}
              className={`w-full text-left rounded-xl border ${borderClass} ${bgClass} p-4 transition-all ${
                sessionState === "answering"
                  ? "hover:border-navy/50 cursor-pointer"
                  : "cursor-default"
              }`}
            >
              <div className="flex items-start gap-3">
                <span
                  className={`shrink-0 w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-bold ${
                    showFeedback && isCorrect
                      ? "border-sage bg-sage text-white"
                      : showFeedback && isSelected && !isCorrect
                      ? "border-coral bg-coral text-white"
                      : isSelected
                      ? "border-navy bg-navy text-white"
                      : "border-gray-300 text-gray-400"
                  }`}
                >
                  {showFeedback && isCorrect
                    ? "✓"
                    : showFeedback && isSelected && !isCorrect
                    ? "✗"
                    : option.label}
                </span>
                <span className="text-sm text-navy leading-relaxed">
                  {option.text}
                </span>
              </div>
            </button>
          );
        })}
      </div>

      {/* Explanation (shown after answering) */}
      {sessionState === "feedback" && (
        <div className="bg-sand rounded-2xl border border-gray-200 p-5 mb-6">
          <p className="text-xs font-semibold text-navy uppercase tracking-wider mb-2">
            Explanation
          </p>
          <p className="text-sm text-gray-700 leading-relaxed">
            {currentQuestion.explanation}
          </p>
        </div>
      )}

      {/* Action button */}
      {sessionState === "answering" ? (
        <button
          onClick={submitAnswer}
          disabled={!selectedAnswer}
          className="w-full rounded-xl bg-navy py-3.5 text-sm font-semibold text-white hover:bg-navy-light transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
        >
          Check Answer
        </button>
      ) : sessionState === "feedback" ? (
        <button
          onClick={nextQuestion}
          className="w-full rounded-xl bg-navy py-3.5 text-sm font-semibold text-white hover:bg-navy-light transition-colors"
        >
          {currentIndex + 1 >= questions.length
            ? "See Results"
            : "Next Question"}
        </button>
      ) : null}
    </div>
  );
}
