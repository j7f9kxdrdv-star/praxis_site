"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

const sections = [
  {
    id: "bio_biochem",
    label: "Bio/Biochem",
    description: "Biological and Biochemical Foundations",
    color: "bg-sage/20 text-sage",
    accent: "border-sage/30",
  },
  {
    id: "chem_phys",
    label: "Chem/Phys",
    description: "Chemical and Physical Foundations",
    color: "bg-amber/10 text-amber",
    accent: "border-amber/30",
  },
  {
    id: "psych_soc",
    label: "Psych/Soc",
    description: "Psychological, Social, and Biological Foundations",
    color: "bg-plum/10 text-plum",
    accent: "border-plum/30",
  },
  {
    id: "cars",
    label: "CARS",
    description: "Critical Analysis and Reasoning Skills",
    color: "bg-coral/10 text-coral",
    accent: "border-coral/30",
  },
];

const difficultyOptions = [
  { id: "all", label: "All Levels" },
  { id: "easy", label: "Easy" },
  { id: "medium", label: "Medium" },
  { id: "hard", label: "Hard" },
];

interface QuestionInfo {
  id: string;
  section: string;
  topic: string | null;
  subtopic: string;
  difficulty: string;
  passage_id: string | null;
}

export default function PracticeHub() {
  const router = useRouter();
  const { user } = useDashboard();
  const [loading, setLoading] = useState(false);
  const [allQuestions, setAllQuestions] = useState<QuestionInfo[]>([]);
  const [answeredIds, setAnsweredIds] = useState<Set<string>>(new Set());
  const [reviewDueCount, setReviewDueCount] = useState(0);
  const [dataLoaded, setDataLoaded] = useState(false);

  // Filters & expansion state
  const [difficulty, setDifficulty] = useState("all");
  const [expandedSection, setExpandedSection] = useState<string | null>(null);
  const [expandedTopic, setExpandedTopic] = useState<string | null>(null);

  useEffect(() => {
    async function loadData() {
      const [{ data: allQ }, { data: attempts }, { data: reviews }] =
        await Promise.all([
          supabase
            .from("questions")
            .select("id, section, topic, subtopic, difficulty, passage_id"),
          supabase
            .from("question_attempts")
            .select("question_id")
            .eq("user_id", user.id),
          supabase
            .from("review_schedule")
            .select("id")
            .eq("user_id", user.id)
            .lte("next_review_date", new Date().toISOString().split("T")[0]),
        ]);

      if (allQ) setAllQuestions(allQ as QuestionInfo[]);
      setAnsweredIds(new Set(attempts?.map((a) => a.question_id) || []));
      setReviewDueCount(reviews?.length || 0);
      setDataLoaded(true);
    }
    loadData();
  }, [user.id]);

  // Count unseen questions with optional filters
  function getUnseen(filters: {
    mode?: "concept" | "mcat";
    section?: string;
    topic?: string;
    subtopic?: string;
  }) {
    return allQuestions.filter((q) => {
      if (answeredIds.has(q.id)) return false;
      if (filters.mode === "concept" && q.passage_id) return false;
      if (filters.mode === "mcat" && !q.passage_id) return false;
      if (filters.section && q.section !== filters.section) return false;
      if (filters.topic && q.topic !== filters.topic) return false;
      if (filters.subtopic && q.subtopic !== filters.subtopic) return false;
      if (difficulty !== "all" && q.difficulty !== difficulty) return false;
      return true;
    }).length;
  }

  // Get topics for a section (main categories like "Sensation & Perception")
  function getTopics(section: string) {
    const topics = new Map<string, { total: number; unseen: number }>();
    allQuestions
      .filter((q) => q.section === section && !q.passage_id)
      .filter((q) => difficulty === "all" || q.difficulty === difficulty)
      .forEach((q) => {
        const topicName = q.topic || "General";
        const existing = topics.get(topicName) || { total: 0, unseen: 0 };
        existing.total++;
        if (!answeredIds.has(q.id)) existing.unseen++;
        topics.set(topicName, existing);
      });
    return Array.from(topics.entries())
      .map(([name, counts]) => ({ name, ...counts }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  // Get subtopics within a topic
  function getSubtopics(section: string, topic: string) {
    const subs = new Map<string, { total: number; unseen: number }>();
    allQuestions
      .filter(
        (q) =>
          q.section === section &&
          (q.topic || "General") === topic &&
          !q.passage_id
      )
      .filter((q) => difficulty === "all" || q.difficulty === difficulty)
      .forEach((q) => {
        const existing = subs.get(q.subtopic) || { total: 0, unseen: 0 };
        existing.total++;
        if (!answeredIds.has(q.id)) existing.unseen++;
        subs.set(q.subtopic, existing);
      });
    return Array.from(subs.entries())
      .map(([name, counts]) => ({ name, ...counts }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  async function startSession(
    mode: "concept" | "mcat" | "review",
    section?: string,
    topic?: string,
    subtopic?: string
  ) {
    setLoading(true);

    if (mode === "review") {
      const today = new Date().toISOString().split("T")[0];
      const { data: reviews } = await supabase
        .from("review_schedule")
        .select("question_id")
        .eq("user_id", user.id)
        .lte("next_review_date", today)
        .limit(10);

      if (!reviews || reviews.length === 0) {
        setLoading(false);
        alert("No questions due for review right now. Keep practicing!");
        return;
      }

      const selectedIds = reviews.map((r) => r.question_id);

      const { data: session, error } = await supabase
        .from("practice_sessions")
        .insert({
          user_id: user.id,
          session_type: "review",
          total_questions: selectedIds.length,
          status: "in_progress",
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
      sessionStorage.setItem(`session_${session.id}_mode`, "review");
      router.push(`/dashboard/practice/session/${session.id}`);
      return;
    }

    // Concept or MCAT mode
    let query = supabase.from("questions").select("id, passage_id, difficulty");

    if (mode === "concept") {
      query = query.is("passage_id", null);
    } else {
      query = query.not("passage_id", "is", null);
    }

    if (section) query = query.eq("section", section);
    if (topic) query = query.eq("topic", topic);
    if (subtopic) query = query.eq("subtopic", subtopic);
    if (difficulty !== "all") query = query.eq("difficulty", difficulty);

    const { data: questions } = await query;

    if (!questions || questions.length === 0) {
      setLoading(false);
      alert("No questions available for this selection yet.");
      return;
    }

    // Exclude already-answered
    let attemptQuery = supabase
      .from("question_attempts")
      .select("question_id")
      .eq("user_id", user.id);

    const qIds = questions.map((q) => q.id);
    attemptQuery = attemptQuery.in("question_id", qIds);

    const { data: attempts } = await attemptQuery;
    const answered = new Set(attempts?.map((a) => a.question_id) || []);
    let available = questions.filter((q) => !answered.has(q.id));

    if (available.length === 0) {
      const reset = confirm(
        "You've completed all available questions for this selection! Reset and practice again?"
      );
      if (!reset) {
        setLoading(false);
        return;
      }
      available = questions;
    }

    let selectedIds: string[];

    if (mode === "mcat") {
      const passageGroups = new Map<string, string[]>();
      available.forEach((q) => {
        const pid = q.passage_id as string;
        const group = passageGroups.get(pid) || [];
        group.push(q.id);
        passageGroups.set(pid, group);
      });

      const passageIds = Array.from(passageGroups.keys()).sort(
        () => Math.random() - 0.5
      );
      selectedIds = [];
      for (const pid of passageIds) {
        selectedIds.push(...passageGroups.get(pid)!);
        if (selectedIds.length >= 10) break;
      }
    } else {
      const shuffled = available.sort(() => Math.random() - 0.5);
      const count = Math.min(10, shuffled.length);
      selectedIds = shuffled.slice(0, count).map((q) => q.id);
    }

    const { data: session, error } = await supabase
      .from("practice_sessions")
      .insert({
        user_id: user.id,
        session_type:
          mode === "mcat"
            ? "mcat_style"
            : subtopic
            ? "by_topic"
            : section
            ? "by_section"
            : "quick_10",
        section: section || null,
        total_questions: selectedIds.length,
        status: "in_progress",
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
    router.push(`/dashboard/practice/session/${session.id}`);
  }

  const conceptTotal = getUnseen({ mode: "concept" });
  const mcatTotal = getUnseen({ mode: "mcat" });

  return (
    <div className="max-w-2xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-serif text-2xl sm:text-3xl text-navy mb-2">
        Practice Questions
      </h1>
      <p className="text-sm text-gray-600 mb-6">
        Choose a practice mode to get started.
      </p>

      {/* Difficulty filter */}
      <div className="flex gap-2 mb-8 overflow-x-auto pb-1">
        {difficultyOptions.map((d) => (
          <button
            key={d.id}
            onClick={() => setDifficulty(d.id)}
            className={`shrink-0 text-xs font-medium px-3.5 py-1.5 rounded-full border transition-colors ${
              difficulty === d.id
                ? "bg-navy text-white border-navy"
                : "bg-white text-gray-500 border-gray-200 hover:border-navy/30"
            }`}
          >
            {d.label}
          </button>
        ))}
      </div>

      {/* ===== SMART REVIEW ===== */}
      {dataLoaded && reviewDueCount > 0 && (
        <button
          onClick={() => startSession("review")}
          disabled={loading}
          className="w-full bg-amber/10 border-2 border-amber/30 rounded-2xl p-5 text-left hover:bg-amber/20 transition-colors disabled:opacity-50 mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <div className="flex items-center gap-2 mb-0.5">
                <span className="text-base">🔄</span>
                <h3 className="font-serif text-base text-navy">
                  Smart Review
                </h3>
              </div>
              <p className="text-sm text-gray-600">
                {reviewDueCount} question{reviewDueCount === 1 ? "" : "s"} due
                for review.
              </p>
            </div>
            <svg
              className="w-5 h-5 text-amber shrink-0 ml-4"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </div>
        </button>
      )}

      {/* ===== CONCEPT QUESTIONS ===== */}
      <div className="mb-10">
        <div className="flex items-baseline gap-3 mb-1">
          <h2 className="font-serif text-lg text-navy">Concept Questions</h2>
          {dataLoaded && (
            <span className="text-xs text-gray-400">
              {conceptTotal} unseen
            </span>
          )}
        </div>
        <p className="text-xs text-gray-500 mb-4">
          Standalone questions that test individual concepts.
        </p>

        {/* Quick 10 */}
        <button
          onClick={() => startSession("concept")}
          disabled={loading}
          className="w-full bg-navy text-white rounded-2xl p-5 text-left hover:bg-navy-light transition-colors disabled:opacity-50 mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-serif text-base text-white mb-0.5">
                Quick 10
              </h3>
              <p className="text-sm text-white/70">
                10 random concept questions from all sections.
              </p>
            </div>
            <svg
              className="w-5 h-5 text-white/70 shrink-0 ml-4"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </div>
        </button>

        {/* By section → topic → subtopic */}
        <div className="space-y-2.5">
          {sections.map((section) => {
            const isExpanded = expandedSection === section.id;
            const topics = isExpanded ? getTopics(section.id) : [];
            const unseen = getUnseen({
              mode: "concept",
              section: section.id,
            });

            return (
              <div key={section.id}>
                {/* Section header */}
                <button
                  onClick={() => {
                    setExpandedSection(isExpanded ? null : section.id);
                    setExpandedTopic(null);
                  }}
                  disabled={loading}
                  className={`w-full bg-white rounded-xl border p-4 text-left hover:shadow-sm transition-all disabled:opacity-50 ${
                    isExpanded
                      ? section.accent + " border-2"
                      : "border-gray-200"
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <div
                      className={`w-8 h-8 rounded-lg ${section.color} flex items-center justify-center shrink-0`}
                    >
                      <span className="text-xs font-bold">
                        {section.label.charAt(0)}
                      </span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-sm text-navy">
                        {section.label}
                      </h3>
                      {dataLoaded && (
                        <p className="text-[10px] text-gray-400">
                          {unseen} unseen
                        </p>
                      )}
                    </div>
                    <svg
                      className={`w-4 h-4 text-gray-400 shrink-0 transition-transform ${
                        isExpanded ? "rotate-180" : ""
                      }`}
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={2}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M19.5 8.25l-7.5 7.5-7.5-7.5"
                      />
                    </svg>
                  </div>
                </button>

                {/* Expanded: Topics (main categories) */}
                {isExpanded && (
                  <div className="mt-1.5 ml-4 space-y-1">
                    {/* All in section */}
                    <button
                      onClick={() => startSession("concept", section.id)}
                      disabled={loading}
                      className="w-full text-left rounded-lg bg-gray-50 hover:bg-gray-100 px-4 py-2.5 transition-colors disabled:opacity-50"
                    >
                      <span className="text-sm font-medium text-navy">
                        All {section.label}
                      </span>
                      <span className="text-xs text-gray-400 ml-2">
                        {unseen} unseen
                      </span>
                    </button>

                    {topics.map((topic) => {
                      const isTopicExpanded =
                        expandedTopic === topic.name;
                      const subtopics = isTopicExpanded
                        ? getSubtopics(section.id, topic.name)
                        : [];
                      const hasMultipleSubtopics =
                        isTopicExpanded && subtopics.length > 1;

                      return (
                        <div key={topic.name}>
                          <button
                            onClick={() => {
                              if (isTopicExpanded) {
                                setExpandedTopic(null);
                              } else {
                                setExpandedTopic(topic.name);
                              }
                            }}
                            disabled={loading}
                            className={`w-full text-left rounded-lg px-4 py-2.5 transition-colors disabled:opacity-50 ${
                              isTopicExpanded
                                ? "bg-navy/5 border border-navy/10"
                                : "bg-gray-50 hover:bg-gray-100"
                            }`}
                          >
                            <div className="flex items-center justify-between">
                              <div>
                                <span className="text-sm font-medium text-navy">
                                  {topic.name}
                                </span>
                                <span className="text-xs text-gray-400 ml-2">
                                  {topic.unseen}/{topic.total}
                                </span>
                              </div>
                              <svg
                                className={`w-3.5 h-3.5 text-gray-400 shrink-0 transition-transform ${
                                  isTopicExpanded ? "rotate-180" : ""
                                }`}
                                fill="none"
                                viewBox="0 0 24 24"
                                strokeWidth={2}
                                stroke="currentColor"
                              >
                                <path
                                  strokeLinecap="round"
                                  strokeLinejoin="round"
                                  d="M19.5 8.25l-7.5 7.5-7.5-7.5"
                                />
                              </svg>
                            </div>
                          </button>

                          {/* Subtopics within this topic */}
                          {isTopicExpanded && (
                            <div className="ml-4 mt-1 space-y-0.5">
                              {/* All in topic */}
                              {hasMultipleSubtopics && (
                                <button
                                  onClick={() =>
                                    startSession(
                                      "concept",
                                      section.id,
                                      topic.name
                                    )
                                  }
                                  disabled={loading}
                                  className="w-full text-left rounded-md bg-white hover:bg-gray-50 px-3 py-2 transition-colors disabled:opacity-50 border border-gray-100"
                                >
                                  <span className="text-xs font-medium text-navy">
                                    All {topic.name}
                                  </span>
                                  <span className="text-[10px] text-gray-400 ml-2">
                                    {topic.unseen} unseen
                                  </span>
                                </button>
                              )}

                              {subtopics.map((sub) => (
                                <button
                                  key={sub.name}
                                  onClick={() =>
                                    startSession(
                                      "concept",
                                      section.id,
                                      topic.name,
                                      sub.name
                                    )
                                  }
                                  disabled={loading || sub.unseen === 0}
                                  className="w-full text-left rounded-md bg-white hover:bg-gray-50 px-3 py-2 transition-colors disabled:opacity-50 border border-gray-100"
                                >
                                  <span className="text-xs text-navy">
                                    {sub.name.replace(/_/g, " ")}
                                  </span>
                                  <span className="text-[10px] text-gray-400 ml-2">
                                    {sub.unseen}/{sub.total}
                                  </span>
                                </button>
                              ))}
                            </div>
                          )}
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>

      {/* ===== MCAT-STYLE QUESTIONS ===== */}
      <div>
        <div className="flex items-baseline gap-3 mb-1">
          <h2 className="font-serif text-lg text-navy">
            MCAT-Style Questions
          </h2>
          {dataLoaded && (
            <span className="text-xs text-gray-400">
              {mcatTotal} unseen
            </span>
          )}
        </div>
        <p className="text-xs text-gray-500 mb-4">
          Passage-based questions that mimic the real MCAT format.
        </p>

        <button
          onClick={() => startSession("mcat")}
          disabled={loading}
          className="w-full bg-white rounded-2xl border-2 border-navy/20 p-5 text-left hover:border-navy/40 hover:shadow-sm transition-all disabled:opacity-50 mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-serif text-base text-navy mb-0.5">
                Start a Passage Set
              </h3>
              <p className="text-sm text-gray-500">
                Read a passage and answer the questions that follow.
              </p>
              {dataLoaded && mcatTotal === 0 && (
                <p className="text-xs text-amber mt-1">
                  Coming soon — no passages available yet.
                </p>
              )}
            </div>
            <svg
              className="w-5 h-5 text-navy/40 shrink-0 ml-4"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </div>
        </button>

        <div className="grid grid-cols-2 gap-2.5">
          {sections.map((section) => (
            <button
              key={section.id}
              onClick={() => startSession("mcat", section.id)}
              disabled={loading}
              className="bg-white rounded-xl border border-gray-200 p-4 text-left hover:border-amber/50 hover:shadow-sm transition-all disabled:opacity-50"
            >
              <div
                className={`w-7 h-7 rounded-lg ${section.color} flex items-center justify-center mb-2`}
              >
                <span className="text-xs font-bold">
                  {section.label.charAt(0)}
                </span>
              </div>
              <h3 className="font-semibold text-sm text-navy mb-0.5">
                {section.label}
              </h3>
              {dataLoaded && (
                <p className="text-[10px] text-gray-400">
                  {getUnseen({ mode: "mcat", section: section.id })} unseen
                </p>
              )}
            </button>
          ))}
        </div>
      </div>

      {loading && (
        <div className="mt-6 text-center">
          <div className="w-6 h-6 border-2 border-navy border-t-transparent rounded-full animate-spin mx-auto mb-2" />
          <p className="text-sm text-gray-500">Setting up your session...</p>
        </div>
      )}
    </div>
  );
}
