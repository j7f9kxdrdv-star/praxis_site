"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

const sections = [
  {
    id: "bio_biochem",
    label: "Bio/Biochem",
    color: "bg-as-primary/10 text-as-primary",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "chem_phys",
    label: "Chem/Phys",
    color: "bg-as-surface-tint/10 text-as-surface-tint",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "psych_soc",
    label: "Psych/Soc",
    color: "bg-as-primary-container/10 text-as-primary-container",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "cars",
    label: "CARS",
    color: "bg-as-on-surface-variant/10 text-as-on-surface-variant",
    accent: "bg-as-surface-container-high",
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

  // Builder modal state
  const [showBuilder, setShowBuilder] = useState(false);
  const [builderDifficulty, setBuilderDifficulty] = useState("all");
  const [builderCount, setBuilderCount] = useState(10);
  const [builderSections, setBuilderSections] = useState<Set<string>>(
    new Set()
  );
  const [builderTopics, setBuilderTopics] = useState<Set<string>>(new Set());
  const [builderSubtopics, setBuilderSubtopics] = useState<Set<string>>(new Set());
  const [builderAllTopics, setBuilderAllTopics] = useState(false);
  const [builderStep, setBuilderStep] = useState<1 | 2 | 3>(1);
  const [expandedBuilderTopic, setExpandedBuilderTopic] = useState<string | null>(null);

  // Browse accordion state
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

  // Get available topics for selected sections
  function getAvailableTopics() {
    const topics = new Map<string, { section: string; count: number }>();
    allQuestions
      .filter(
        (q) => !q.passage_id && builderSections.has(q.section) && q.topic
      )
      .forEach((q) => {
        const key = q.topic!;
        const existing = topics.get(key) || {
          section: q.section,
          count: 0,
        };
        existing.count++;
        topics.set(key, existing);
      });
    return Array.from(topics.entries())
      .map(([name, info]) => ({ name, ...info }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  // Count matching questions for current builder settings
  function getBuilderMatchCount() {
    return allQuestions.filter((q) => {
      if (q.passage_id) return false;
      if (!builderSections.has(q.section)) return false;
      // If not "all topics" and some topics are selected, filter by topic
      if (!builderAllTopics && builderTopics.size > 0) {
        if (!builderTopics.has(q.topic || "")) return false;
        // If subtopics are selected for this topic, filter by subtopic too
        if (builderSubtopics.size > 0) {
          const topicSubs = getSubtopicsForTopic(q.topic || "");
          const hasSubsForThisTopic = topicSubs.some((s) => builderSubtopics.has(s.name));
          if (hasSubsForThisTopic && !builderSubtopics.has(q.subtopic)) return false;
        }
      } else if (!builderAllTopics && builderTopics.size === 0) {
        return false; // No topics selected and not "all"
      }
      if (builderDifficulty !== "all" && q.difficulty !== builderDifficulty)
        return false;
      if (answeredIds.has(q.id)) return false;
      return true;
    }).length;
  }

  // Get subtopics for a given topic within selected sections
  function getSubtopicsForTopic(topicName: string) {
    const subtopics = new Map<string, number>();
    allQuestions
      .filter(
        (q) => !q.passage_id && builderSections.has(q.section) && q.topic === topicName && q.subtopic
      )
      .forEach((q) => {
        subtopics.set(q.subtopic, (subtopics.get(q.subtopic) || 0) + 1);
      });
    return Array.from(subtopics.entries())
      .map(([name, count]) => ({ name, count }))
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  function toggleSection(id: string) {
    const next = new Set(builderSections);
    if (next.has(id)) {
      next.delete(id);
    } else {
      next.add(id);
    }
    setBuilderSections(next);
    // Reset topic selection when sections change
    setBuilderTopics(new Set());
    setBuilderSubtopics(new Set());
    setBuilderAllTopics(false);
  }

  function toggleTopic(name: string) {
    if (builderAllTopics) {
      setBuilderAllTopics(false);
      setBuilderTopics(new Set([name]));
      setBuilderSubtopics(new Set());
    } else {
      const next = new Set(builderTopics);
      if (next.has(name)) {
        next.delete(name);
        // Also remove any subtopics belonging to this topic
        const subs = getSubtopicsForTopic(name);
        const nextSubs = new Set(builderSubtopics);
        subs.forEach((s) => nextSubs.delete(s.name));
        setBuilderSubtopics(nextSubs);
      } else {
        next.add(name);
      }
      setBuilderTopics(next);
    }
  }

  function toggleSubtopic(subtopicName: string, topicName: string) {
    const nextSubs = new Set(builderSubtopics);
    if (nextSubs.has(subtopicName)) {
      nextSubs.delete(subtopicName);
    } else {
      nextSubs.add(subtopicName);
    }
    setBuilderSubtopics(nextSubs);
    // Ensure the parent topic is selected
    if (!builderTopics.has(topicName) && !builderAllTopics) {
      const nextTopics = new Set(builderTopics);
      nextTopics.add(topicName);
      setBuilderTopics(nextTopics);
    }
  }

  function openBuilder() {
    setBuilderStep(1);
    setShowBuilder(true);
  }

  async function launchBuilderSession() {
    setLoading(true);

    let query = supabase
      .from("questions")
      .select("id, passage_id, difficulty, topic, subtopic")
      .is("passage_id", null)
      .in("section", Array.from(builderSections));

    if (builderDifficulty !== "all") {
      query = query.eq("difficulty", builderDifficulty);
    }

    const { data: questions } = await query;

    if (!questions || questions.length === 0) {
      setLoading(false);
      alert("No questions match your selection.");
      return;
    }

    // Filter by topics if specific ones selected
    let filtered = questions;
    if (!builderAllTopics && builderTopics.size > 0) {
      filtered = questions.filter((q) => {
        const qi = q as unknown as QuestionInfo;
        if (!builderTopics.has(qi.topic || "")) return false;
        // If subtopics are selected, filter by those too
        if (builderSubtopics.size > 0) {
          const topicSubs = getSubtopicsForTopic(qi.topic || "");
          const hasSubsForThisTopic = topicSubs.some((s) => builderSubtopics.has(s.name));
          if (hasSubsForThisTopic && !builderSubtopics.has(qi.subtopic)) return false;
        }
        return true;
      });
    }

    // Exclude answered
    const { data: attempts } = await supabase
      .from("question_attempts")
      .select("question_id")
      .eq("user_id", user.id)
      .in(
        "question_id",
        filtered.map((q) => q.id)
      );

    const answered = new Set(attempts?.map((a) => a.question_id) || []);
    let available = filtered.filter((q) => !answered.has(q.id));

    if (available.length === 0) {
      const reset = confirm(
        "You've completed all questions for this selection! Reset and practice again?"
      );
      if (!reset) {
        setLoading(false);
        return;
      }
      available = filtered;
    }

    const shuffled = available.sort(() => Math.random() - 0.5);
    const count =
      builderCount === 0
        ? shuffled.length
        : Math.min(builderCount, shuffled.length);
    const selectedIds = shuffled.slice(0, count).map((q) => q.id);

    const { data: session, error } = await supabase
      .from("practice_sessions")
      .insert({
        user_id: user.id,
        session_type: "custom",
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
    setShowBuilder(false);
    router.push(`/dashboard/practice/session/${session.id}`);
  }

  async function startReview() {
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
  }

  async function startMcatSession(section?: string) {
    setLoading(true);

    let query = supabase
      .from("questions")
      .select("id, passage_id")
      .not("passage_id", "is", null);
    if (section) query = query.eq("section", section);

    const { data: questions } = await query;

    if (!questions || questions.length === 0) {
      setLoading(false);
      alert("No MCAT-style passage questions available yet. Check back soon!");
      return;
    }

    const { data: attempts } = await supabase
      .from("question_attempts")
      .select("question_id")
      .eq("user_id", user.id)
      .in(
        "question_id",
        questions.map((q) => q.id)
      );

    const answered = new Set(attempts?.map((a) => a.question_id) || []);
    let available = questions.filter((q) => !answered.has(q.id));

    if (available.length === 0) {
      const reset = confirm("You've completed all passage questions! Reset?");
      if (!reset) {
        setLoading(false);
        return;
      }
      available = questions;
    }

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
    const selectedIds: string[] = [];
    for (const pid of passageIds) {
      selectedIds.push(...passageGroups.get(pid)!);
      if (selectedIds.length >= 10) break;
    }

    const { data: session, error } = await supabase
      .from("practice_sessions")
      .insert({
        user_id: user.id,
        session_type: "mcat_style",
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

  const conceptTotal = allQuestions.filter(
    (q) => !q.passage_id && !answeredIds.has(q.id)
  ).length;
  const mcatTotal = allQuestions.filter(
    (q) => q.passage_id && !answeredIds.has(q.id)
  ).length;
  const availableTopics = getAvailableTopics();
  const builderMatch = getBuilderMatchCount();

  // Get unseen count for browse sections
  function getUnseen(filters: {
    section?: string;
    topic?: string;
    subtopic?: string;
  }) {
    return allQuestions.filter((q) => {
      if (q.passage_id) return false;
      if (answeredIds.has(q.id)) return false;
      if (filters.section && q.section !== filters.section) return false;
      if (filters.topic && (q.topic || "General") !== filters.topic) return false;
      if (filters.subtopic && q.subtopic !== filters.subtopic) return false;
      return true;
    }).length;
  }

  // Get topics for a section
  function getTopics(section: string) {
    const topics = new Map<string, { total: number; unseen: number }>();
    allQuestions
      .filter((q) => q.section === section && !q.passage_id)
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

  async function startTopicSession(section: string, topic?: string, subtopic?: string) {
    setLoading(true);

    let query = supabase
      .from("questions")
      .select("id")
      .is("passage_id", null)
      .eq("section", section);

    if (topic && topic !== "General") {
      query = query.eq("topic", topic);
    }
    if (subtopic && subtopic !== "General") {
      query = query.eq("subtopic", subtopic);
    }

    const { data: questions } = await query;

    if (!questions || questions.length === 0) {
      setLoading(false);
      alert("No questions available for this selection.");
      return;
    }

    const { data: attempts } = await supabase
      .from("question_attempts")
      .select("question_id")
      .eq("user_id", user.id)
      .in(
        "question_id",
        questions.map((q) => q.id)
      );

    const answered = new Set(attempts?.map((a) => a.question_id) || []);
    let available = questions.filter((q) => !answered.has(q.id));

    if (available.length === 0) {
      const reset = confirm(
        "You've completed all questions here! Reset and practice again?"
      );
      if (!reset) {
        setLoading(false);
        return;
      }
      available = questions;
    }

    const shuffled = available.sort(() => Math.random() - 0.5);
    const selectedIds = shuffled.map((q) => q.id);

    const { data: session, error } = await supabase
      .from("practice_sessions")
      .insert({
        user_id: user.id,
        session_type: "topic",
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

  return (
    <div className="max-w-2xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-headline text-2xl sm:text-3xl text-as-primary mb-2">
        Practice Questions
      </h1>
      <p className="text-sm text-as-on-surface-variant mb-8">
        Build a custom session or jump into a quick review.
      </p>

      {/* ===== BUILD YOUR SESSION — Primary CTA ===== */}
      <button
        onClick={openBuilder}
        disabled={loading}
        className="w-full bg-as-primary text-as-on-primary rounded-2xl p-6 text-left hover:bg-as-primary-container transition-colors disabled:opacity-50 mb-4"
      >
        <div className="flex items-center justify-between">
          <div>
            <h2 className="font-headline text-lg text-as-on-primary mb-1">
              Build Your Session
            </h2>
            <p className="text-sm text-as-on-primary/70">
              Pick your subjects, difficulty, and how many questions you want.
            </p>
            {dataLoaded && (
              <p className="text-xs text-as-on-primary/50 mt-1">
                {conceptTotal} unseen concept questions available
              </p>
            )}
          </div>
          <svg
            className="w-6 h-6 text-as-on-primary/70 shrink-0 ml-4"
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

      {/* ===== SMART REVIEW ===== */}
      {dataLoaded && reviewDueCount > 0 && (
        <button
          onClick={startReview}
          disabled={loading}
          className="w-full bg-as-surface-container-high rounded-2xl p-5 text-left hover:bg-as-surface-container-highest transition-colors disabled:opacity-50 mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <div className="flex items-center gap-2 mb-0.5">
                <span className="text-base">🔄</span>
                <h3 className="font-headline text-base text-as-primary">
                  Smart Review
                </h3>
              </div>
              <p className="text-sm text-as-on-surface-variant">
                {reviewDueCount} question{reviewDueCount === 1 ? "" : "s"} due
                for review.
              </p>
            </div>
            <svg
              className="w-5 h-5 text-as-surface-tint shrink-0 ml-4"
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

      {/* ===== MCAT-STYLE QUESTIONS ===== */}
      <div className="mt-8">
        <div className="flex items-baseline gap-3 mb-1">
          <h2 className="font-headline text-lg text-as-primary">
            MCAT-Style Questions
          </h2>
          {dataLoaded && (
            <span className="text-xs text-as-outline">
              {mcatTotal} unseen
            </span>
          )}
        </div>
        <p className="text-xs text-as-on-surface-variant mb-4">
          Passage-based questions that mimic the real MCAT format.
        </p>

        <button
          onClick={() => startMcatSession()}
          disabled={loading}
          className="w-full bg-as-surface-container-lowest rounded-2xl border-2 border-as-outline-variant/15 p-5 text-left hover:border-as-primary/20 hover:shadow-sm transition-all disabled:opacity-50 mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <h3 className="font-headline text-base text-as-primary mb-0.5">
                Start a Passage Set
              </h3>
              <p className="text-sm text-as-on-surface-variant">
                Read a passage and answer the questions that follow.
              </p>
              {dataLoaded && mcatTotal === 0 && (
                <p className="text-xs text-as-surface-tint mt-1">
                  Coming soon — no passages available yet.
                </p>
              )}
            </div>
            <svg
              className="w-5 h-5 text-as-outline shrink-0 ml-4"
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
      </div>

      {/* ===== BROWSE BY SECTION ===== */}
      <div className="mt-10 mb-10">
        <div className="flex items-baseline gap-3 mb-1">
          <h2 className="font-headline text-lg text-as-primary">Concept Questions</h2>
          {dataLoaded && (
            <span className="text-xs text-as-outline">
              {conceptTotal} unseen
            </span>
          )}
        </div>
        <p className="text-xs text-as-on-surface-variant mb-4">
          Standalone questions organized by section, topic, and subtopic.
        </p>

        <div className="space-y-2.5">
          {sections.map((section) => {
            const isExpanded = expandedSection === section.id;
            const topics = isExpanded ? getTopics(section.id) : [];
            const unseen = getUnseen({ section: section.id });

            return (
              <div key={section.id}>
                {/* Section header */}
                <button
                  onClick={() => {
                    setExpandedSection(isExpanded ? null : section.id);
                    setExpandedTopic(null);
                  }}
                  disabled={loading}
                  className={`w-full bg-as-surface-container-lowest rounded-xl border p-4 text-left hover:shadow-sm transition-all disabled:opacity-50 ${
                    isExpanded
                      ? section.accent + " border-2"
                      : "border-as-outline-variant/15"
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
                      <h3 className="font-semibold text-sm text-as-primary">
                        {section.label}
                      </h3>
                      {dataLoaded && (
                        <p className="text-[10px] text-as-outline">
                          {unseen} unseen
                        </p>
                      )}
                    </div>
                    <svg
                      className={`w-4 h-4 text-as-outline shrink-0 transition-transform ${
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

                {/* Expanded: Topics */}
                {isExpanded && (
                  <div className="mt-1.5 ml-4 space-y-1">
                    {/* All in section */}
                    <button
                      onClick={() => startTopicSession(section.id)}
                      disabled={loading}
                      className="w-full text-left rounded-lg bg-as-surface-container hover:bg-as-surface-container-high px-4 py-2.5 transition-colors disabled:opacity-50"
                    >
                      <span className="text-sm font-medium text-as-primary">
                        All {section.label}
                      </span>
                      <span className="text-xs text-as-outline ml-2">
                        {unseen} unseen
                      </span>
                    </button>

                    {topics.map((topic) => {
                      const isTopicExpanded = expandedTopic === topic.name;
                      const subtopics = isTopicExpanded
                        ? getSubtopics(section.id, topic.name)
                        : [];
                      const hasMultipleSubtopics =
                        isTopicExpanded && subtopics.length > 1;

                      return (
                        <div key={topic.name}>
                          <button
                            onClick={() => {
                              setExpandedTopic(
                                isTopicExpanded ? null : topic.name
                              );
                            }}
                            disabled={loading}
                            className={`w-full text-left rounded-lg px-4 py-2.5 transition-colors disabled:opacity-50 ${
                              isTopicExpanded
                                ? "bg-as-primary/5 border border-as-primary/10"
                                : "bg-as-surface-container hover:bg-as-surface-container-high"
                            }`}
                          >
                            <div className="flex items-center justify-between">
                              <div>
                                <span className="text-sm font-medium text-as-primary">
                                  {topic.name}
                                </span>
                                <span className="text-xs text-as-outline ml-2">
                                  {topic.unseen}/{topic.total}
                                </span>
                              </div>
                              <svg
                                className={`w-3.5 h-3.5 text-as-outline shrink-0 transition-transform ${
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

                          {/* Subtopics */}
                          {isTopicExpanded && (
                            <div className="ml-4 mt-1 space-y-0.5">
                              {hasMultipleSubtopics && (
                                <button
                                  onClick={() =>
                                    startTopicSession(
                                      section.id,
                                      topic.name
                                    )
                                  }
                                  disabled={loading}
                                  className="w-full text-left rounded-md bg-as-surface-container-lowest hover:bg-as-surface-container px-3 py-2 transition-colors disabled:opacity-50 border border-as-outline-variant/10"
                                >
                                  <span className="text-xs font-medium text-as-primary">
                                    All {topic.name}
                                  </span>
                                  <span className="text-[10px] text-as-outline ml-2">
                                    {topic.unseen} unseen
                                  </span>
                                </button>
                              )}

                              {subtopics.map((sub) => (
                                <button
                                  key={sub.name}
                                  onClick={() =>
                                    startTopicSession(
                                      section.id,
                                      topic.name,
                                      sub.name
                                    )
                                  }
                                  disabled={loading || sub.unseen === 0}
                                  className="w-full text-left rounded-md bg-as-surface-container-lowest hover:bg-as-surface-container px-3 py-2 transition-colors disabled:opacity-50 border border-as-outline-variant/10"
                                >
                                  <span className="text-xs text-as-primary">
                                    {sub.name.replace(/_/g, " ")}
                                  </span>
                                  <span className="text-[10px] text-as-outline ml-2">
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

      {loading && (
        <div className="mt-6 text-center">
          <div className="w-6 h-6 border-2 border-as-primary border-t-transparent rounded-full animate-spin mx-auto mb-2" />
          <p className="text-sm text-as-on-surface-variant">Setting up your session...</p>
        </div>
      )}

      {/* ===== BUILD YOUR SESSION MODAL ===== */}
      {showBuilder && (
        <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center">
          <div
            className="absolute inset-0 bg-as-on-surface/30"
            onClick={() => setShowBuilder(false)}
          />
          <div className="relative bg-as-surface-container-lowest rounded-t-2xl sm:rounded-2xl w-full sm:max-w-4xl sm:min-h-[540px] max-h-[92vh] overflow-y-auto p-10 pb-12 sm:pb-12">
            {/* Header */}
            <div className="flex items-center justify-between mb-6">
              <h3 className="font-headline text-xl text-as-primary">
                Build Your Session
              </h3>
              <button
                onClick={() => setShowBuilder(false)}
                className="text-as-outline hover:text-as-primary transition-colors"
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
            </div>

            {/* Step indicator */}
            <div className="flex items-center gap-2 mb-6">
              {[1, 2, 3].map((step) => (
                <div key={step} className="flex items-center gap-2 flex-1">
                  <div className={`h-1 flex-1 rounded-full transition-colors ${
                    builderStep >= step ? "bg-as-primary" : "bg-as-outline-variant/20"
                  }`} />
                </div>
              ))}
            </div>

            {/* ===== STEP 1: SECTIONS ===== */}
            {builderStep === 1 && (
              <>
                <p className="text-sm text-as-on-surface-variant mb-1">
                  Step 1 of 3
                </p>
                <p className="text-lg font-headline text-as-primary mb-4">
                  What do you want to study?
                </p>
                <p className="text-xs text-as-outline mb-4">
                  Select the sections you want to practice.
                </p>

                <div className="grid grid-cols-2 gap-4 mb-8">
                  {sections.map((s) => {
                    const selected = builderSections.has(s.id);
                    const sectionUnseen = allQuestions.filter(
                      (q) =>
                        q.section === s.id &&
                        !q.passage_id &&
                        !answeredIds.has(q.id)
                    ).length;

                    return (
                      <button
                        key={s.id}
                        onClick={() => toggleSection(s.id)}
                        className={`rounded-xl border-2 p-5 text-left transition-all ${
                          selected
                            ? "border-as-primary bg-as-primary/5"
                            : "border-as-outline-variant/15 opacity-50"
                        }`}
                      >
                        <div className="flex items-center gap-2">
                          <div
                            className={`w-6 h-6 rounded-md ${s.color} flex items-center justify-center`}
                          >
                            <span className="text-[10px] font-bold">
                              {s.label.charAt(0)}
                            </span>
                          </div>
                          <div>
                            <p className="text-sm font-medium text-as-primary">
                              {s.label}
                            </p>
                            <p className="text-[10px] text-as-outline">
                              {sectionUnseen} unseen
                            </p>
                          </div>
                        </div>
                      </button>
                    );
                  })}
                </div>

                <button
                  onClick={() => {
                    setBuilderStep(2);
                    setExpandedBuilderTopic(null);
                  }}
                  disabled={builderSections.size === 0}
                  className="w-full bg-as-primary text-as-on-primary text-sm font-semibold rounded-xl py-3 hover:bg-as-primary-container transition-colors disabled:opacity-30"
                >
                  Next
                </button>
              </>
            )}

            {/* ===== STEP 2: TOPICS ===== */}
            {builderStep === 2 && (
              <>
                <p className="text-sm text-as-on-surface-variant mb-1">
                  Step 2 of 3
                </p>
                <p className="text-lg font-headline text-as-primary mb-2">
                  Narrow your focus
                </p>
                <p className="text-xs text-as-outline mb-4">
                  Select the topics you want to practice. Expand any topic to pick specific subtopics.
                </p>

                <div className="flex items-center justify-between mb-3">
                  <p className="text-xs font-medium text-as-on-surface-variant">
                    {builderAllTopics
                      ? "All topics selected"
                      : builderTopics.size === 0
                        ? "No topics selected"
                        : `${builderTopics.size} topic${builderTopics.size > 1 ? "s" : ""} selected`}
                  </p>
                  <button
                    onClick={() => {
                      if (builderAllTopics) {
                        setBuilderAllTopics(false);
                        setBuilderTopics(new Set());
                        setBuilderSubtopics(new Set());
                      } else {
                        setBuilderAllTopics(true);
                        setBuilderTopics(new Set());
                        setBuilderSubtopics(new Set());
                      }
                    }}
                    className={`text-[10px] font-medium px-3 py-1 rounded-full transition-colors ${
                      builderAllTopics
                        ? "bg-as-primary text-as-on-primary"
                        : "text-as-outline hover:text-as-primary border border-as-outline-variant/15"
                    }`}
                  >
                    {builderAllTopics ? "All Topics ✓" : "Select All"}
                  </button>
                </div>

                <div className="max-h-[60vh] overflow-y-auto -mx-1 px-1 mb-6 space-y-1.5">
                  {availableTopics.map((t) => {
                    const selected = builderAllTopics || builderTopics.has(t.name);
                    const subtopics = getSubtopicsForTopic(t.name);
                    const isExpanded = expandedBuilderTopic === t.name;
                    const selectedSubCount = subtopics.filter((s) => builderSubtopics.has(s.name)).length;

                    return (
                      <div key={t.name}>
                        <div className="flex items-center gap-1.5">
                          <button
                            onClick={() => toggleTopic(t.name)}
                            className={`flex-1 text-left text-xs font-medium px-3 py-2.5 rounded-lg border transition-colors ${
                              selected
                                ? "bg-as-primary/10 border-as-primary/20 text-as-primary"
                                : "border-as-outline-variant/15 text-as-outline"
                            }`}
                          >
                            <span className="flex items-center justify-between">
                              <span>{t.name}</span>
                              <span className="flex items-center gap-2">
                                {selectedSubCount > 0 && !builderAllTopics && (
                                  <span className="text-[9px] bg-as-primary/20 text-as-primary px-1.5 py-0.5 rounded-full">
                                    {selectedSubCount} sub
                                  </span>
                                )}
                                <span className="text-[10px] opacity-60">{t.count}</span>
                              </span>
                            </span>
                          </button>
                          {subtopics.length > 0 && (
                            <button
                              onClick={() => setExpandedBuilderTopic(isExpanded ? null : t.name)}
                              className="p-2 text-as-outline hover:text-as-primary transition-colors"
                              title="Show subtopics"
                            >
                              <svg className={`w-3.5 h-3.5 transition-transform ${isExpanded ? "rotate-180" : ""}`} fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                              </svg>
                            </button>
                          )}
                        </div>
                        {isExpanded && subtopics.length > 0 && (
                          <div className="ml-4 mt-1.5 space-y-0.5 border-l-2 border-as-outline-variant/15 pl-3">
                            {subtopics.map((sub) => {
                              const subSelected = builderAllTopics || builderSubtopics.has(sub.name) || (builderTopics.has(t.name) && builderSubtopics.size === 0);
                              const isActiveSubFilter = builderSubtopics.has(sub.name);

                              return (
                                <button
                                  key={sub.name}
                                  onClick={() => toggleSubtopic(sub.name, t.name)}
                                  className={`w-full flex items-center justify-between text-[11px] py-1.5 px-2 rounded-md transition-colors ${
                                    isActiveSubFilter
                                      ? "bg-as-primary/10 text-as-primary font-medium"
                                      : subSelected
                                        ? "text-as-on-surface-variant hover:bg-as-surface-container-high"
                                        : "text-as-outline hover:bg-as-surface-container-high"
                                  }`}
                                >
                                  <span>{sub.name}</span>
                                  <span className="text-[10px] opacity-60">{sub.count}</span>
                                </button>
                              );
                            })}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>

                <div className="flex gap-3">
                  <button
                    onClick={() => setBuilderStep(1)}
                    className="flex-1 border border-as-outline-variant/15 text-sm font-semibold text-as-primary rounded-xl py-3 hover:bg-as-surface-container-low transition-colors"
                  >
                    Back
                  </button>
                  <button
                    onClick={() => setBuilderStep(3)}
                    disabled={!builderAllTopics && builderTopics.size === 0}
                    className="flex-1 bg-as-primary text-as-on-primary text-sm font-semibold rounded-xl py-3 hover:bg-as-primary-container transition-colors disabled:opacity-30"
                  >
                    Next
                  </button>
                </div>
              </>
            )}

            {/* ===== STEP 3: DIFFICULTY & COUNT ===== */}
            {builderStep === 3 && (
              <>
                <p className="text-sm text-as-on-surface-variant mb-1">
                  Step 3 of 3
                </p>
                <p className="text-lg font-headline text-as-primary mb-4">
                  Customize your session
                </p>

                {/* Difficulty */}
                <div className="mb-6">
                  <p className="text-xs font-medium text-as-on-surface-variant mb-2">
                    Difficulty
                  </p>
                  <div className="flex flex-wrap gap-2">
                    {difficultyOptions.map((d) => (
                      <button
                        key={d.id}
                        onClick={() => setBuilderDifficulty(d.id)}
                        className={`text-sm font-medium px-4 py-2 rounded-xl border transition-colors ${
                          builderDifficulty === d.id
                            ? "bg-as-primary text-as-on-primary border-as-primary"
                            : "bg-as-surface-container-lowest text-as-on-surface-variant border-as-outline-variant/15 hover:border-as-primary/20"
                        }`}
                      >
                        {d.label}
                      </button>
                    ))}
                  </div>
                </div>

                {/* Question count */}
                <div className="mb-6">
                  <p className="text-xs font-medium text-as-on-surface-variant mb-2">
                    How many questions?
                  </p>
                  <div className="flex flex-wrap gap-2 mb-3">
                    {[10, 25, 50].map((n) => (
                      <button
                        key={n}
                        onClick={() => setBuilderCount(n)}
                        className={`text-sm font-medium px-4 py-2 rounded-xl border transition-colors ${
                          builderCount === n
                            ? "bg-as-primary text-as-on-primary border-as-primary"
                            : "bg-as-surface-container-lowest text-as-on-surface-variant border-as-outline-variant/15 hover:border-as-primary/20"
                        }`}
                      >
                        {n}
                      </button>
                    ))}
                    <button
                      onClick={() => setBuilderCount(0)}
                      className={`text-sm font-medium px-4 py-2 rounded-xl border transition-colors ${
                        builderCount === 0
                          ? "bg-as-primary text-as-on-primary border-as-primary"
                          : "bg-as-surface-container-lowest text-as-on-surface-variant border-as-outline-variant/15 hover:border-as-primary/20"
                      }`}
                    >
                      All
                    </button>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-as-outline">or custom:</span>
                    <input
                      type="number"
                      min="1"
                      max="500"
                      value={builderCount === 0 ? "" : builderCount}
                      placeholder="e.g. 75"
                      onChange={(e) => {
                        const val = parseInt(e.target.value);
                        if (!isNaN(val) && val > 0) setBuilderCount(val);
                        else if (e.target.value === "") setBuilderCount(0);
                      }}
                      className="w-24 text-sm text-center border border-as-outline-variant/15 rounded-xl px-3 py-2 focus:outline-none focus:border-as-surface-tint text-as-primary"
                    />
                  </div>
                </div>

                {/* Summary */}
                <div className="bg-as-surface-container-low rounded-xl p-4 mb-6">
                  <p className="text-xs text-as-on-surface-variant mb-1">Your session</p>
                  <p className="text-sm text-as-primary font-medium">
                    {builderCount === 0 ? "All" : builderCount} questions ·{" "}
                    {difficultyOptions.find(
                      (d) => d.id === builderDifficulty
                    )?.label}{" "}
                    ·{" "}
                    {builderSections.size === 4
                      ? "All sections"
                      : Array.from(builderSections)
                          .map(
                            (id) => sections.find((s) => s.id === id)?.label
                          )
                          .join(", ")}
                  </p>
                  {!builderAllTopics && builderTopics.size > 0 && (
                    <p className="text-[10px] text-as-outline mt-0.5">
                      Topics: {Array.from(builderTopics).join(", ")}
                    </p>
                  )}
                  <p className="text-[10px] text-as-outline mt-1">
                    {builderMatch} unseen questions match
                  </p>
                </div>

                <div className="flex gap-3">
                  <button
                    onClick={() => setBuilderStep(2)}
                    className="flex-1 border border-as-outline-variant/15 text-sm font-semibold text-as-primary rounded-xl py-3 hover:bg-as-surface-container-low transition-colors"
                  >
                    Back
                  </button>
                  <button
                    onClick={launchBuilderSession}
                    disabled={loading || builderMatch === 0}
                    className="flex-1 bg-as-primary text-as-on-primary text-sm font-semibold rounded-xl py-3 hover:bg-as-primary-container transition-colors disabled:opacity-30"
                  >
                    {loading ? "Starting..." : "Start Session"}
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
