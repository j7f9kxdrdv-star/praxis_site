"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface Lesson {
  id: string;
  topic: string;
  title: string;
  sort_order: number;
  estimated_minutes: number;
  completed: boolean;
}

const sectionLabels: Record<string, string> = {
  bio_biochem: "Bio/Biochem",
  chem_phys: "Chem/Phys",
  psych_soc: "Psych/Soc",
  cars: "CARS",
};

const sectionFullNames: Record<string, string> = {
  bio_biochem: "Biological and Biochemical Foundations",
  chem_phys: "Chemical and Physical Foundations",
  psych_soc: "Psychological, Social, and Biological Foundations",
  cars: "Critical Analysis and Reasoning Skills",
};

export default function SectionLessonsPage() {
  const params = useParams();
  const { user } = useDashboard();
  const section = params.section as string;
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadLessons() {
      const { data: lessonData } = await supabase
        .from("lessons")
        .select("id, topic, title, sort_order, estimated_minutes")
        .eq("section", section)
        .order("sort_order");

      const { data: progress } = await supabase
        .from("lesson_progress")
        .select("lesson_id")
        .eq("user_id", user.id)
        .eq("completed", true);

      const completedIds = new Set(progress?.map((p) => p.lesson_id) || []);

      const lessonsWithProgress =
        lessonData?.map((l) => ({
          ...l,
          completed: completedIds.has(l.id),
        })) || [];

      setLessons(lessonsWithProgress);
      setLoading(false);
    }

    loadLessons();
  }, [section, user.id]);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-navy border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  // Group lessons by topic
  const topics = new Map<string, Lesson[]>();
  lessons.forEach((lesson) => {
    const existing = topics.get(lesson.topic) || [];
    existing.push(lesson);
    topics.set(lesson.topic, existing);
  });

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      {/* Breadcrumb */}
      <div className="flex items-center gap-2 text-xs text-gray-400 mb-6">
        <Link
          href="/dashboard/lessons"
          className="hover:text-navy transition-colors"
        >
          Lessons
        </Link>
        <span>/</span>
        <span className="text-navy font-medium">
          {sectionLabels[section] || section}
        </span>
      </div>

      <h1 className="font-serif text-2xl sm:text-3xl text-navy mb-1">
        {sectionLabels[section] || section}
      </h1>
      <p className="text-sm text-gray-600 mb-8">
        {sectionFullNames[section] || ""}
      </p>

      {/* Lessons grouped by topic */}
      <div className="space-y-8">
        {Array.from(topics.entries()).map(([topic, topicLessons]) => {
          const completedCount = topicLessons.filter(
            (l) => l.completed
          ).length;

          return (
            <div key={topic}>
              <div className="flex items-center justify-between mb-3">
                <h2 className="font-semibold text-sm text-navy">{topic}</h2>
                <span className="text-xs text-gray-400">
                  {completedCount}/{topicLessons.length} complete
                </span>
              </div>
              <div className="space-y-2">
                {topicLessons.map((lesson, i) => (
                  <Link
                    key={lesson.id}
                    href={`/dashboard/lessons/${section}/${lesson.id}`}
                    className="flex items-center gap-4 bg-white rounded-xl border border-gray-200 p-4 hover:border-amber/50 hover:shadow-sm transition-all"
                  >
                    {/* Status indicator */}
                    <div
                      className={`w-8 h-8 rounded-full flex items-center justify-center shrink-0 ${
                        lesson.completed
                          ? "bg-sage text-white"
                          : "bg-gray-100 text-gray-400"
                      }`}
                    >
                      {lesson.completed ? (
                        <svg
                          className="w-4 h-4"
                          fill="none"
                          viewBox="0 0 24 24"
                          strokeWidth={2.5}
                          stroke="currentColor"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M4.5 12.75l6 6 9-13.5"
                          />
                        </svg>
                      ) : (
                        <span className="text-xs font-bold">{i + 1}</span>
                      )}
                    </div>

                    <div className="flex-1 min-w-0">
                      <h3 className="text-sm font-medium text-navy">
                        {lesson.title}
                      </h3>
                      <p className="text-xs text-gray-400">
                        ~{lesson.estimated_minutes} min read
                      </p>
                    </div>

                    <svg
                      className="w-4 h-4 text-gray-300 shrink-0"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={2}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M8.25 4.5l7.5 7.5-7.5 7.5"
                      />
                    </svg>
                  </Link>
                ))}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
