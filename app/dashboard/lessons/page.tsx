"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface SectionData {
  id: string;
  label: string;
  description: string;
  icon: string;
  color: string;
  totalLessons: number;
  completedLessons: number;
}

const sectionMeta: Record<
  string,
  { label: string; description: string; icon: string; color: string }
> = {
  bio_biochem: {
    label: "Bio/Biochem",
    description: "Biological and Biochemical Foundations of Living Systems",
    icon: "🧬",
    color: "from-as-primary/20 to-as-primary/5",
  },
  chem_phys: {
    label: "Chem/Phys",
    description: "Chemical and Physical Foundations of Biological Systems",
    icon: "⚗️",
    color: "from-as-surface-tint/20 to-as-surface-tint/5",
  },
  psych_soc: {
    label: "Psych/Soc",
    description:
      "Psychological, Social, and Biological Foundations of Behavior",
    icon: "🧠",
    color: "from-as-primary-container/20 to-as-primary-container/5",
  },
  cars: {
    label: "CARS",
    description: "Critical Analysis and Reasoning Skills",
    icon: "📖",
    color: "from-as-on-surface-variant/20 to-as-on-surface-variant/5",
  },
};

export default function LessonsHub() {
  const { user } = useDashboard();
  const [sections, setSections] = useState<SectionData[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadSections() {
      // Get all lessons grouped by section
      const { data: lessons } = await supabase
        .from("lessons")
        .select("id, section");

      // Get user's completed lessons
      const { data: progress } = await supabase
        .from("lesson_progress")
        .select("lesson_id")
        .eq("user_id", user.id)
        .eq("completed", true);

      const completedIds = new Set(progress?.map((p) => p.lesson_id) || []);

      // Build section data
      const sectionMap = new Map<
        string,
        { total: number; completed: number }
      >();

      lessons?.forEach((lesson) => {
        const existing = sectionMap.get(lesson.section) || {
          total: 0,
          completed: 0,
        };
        existing.total++;
        if (completedIds.has(lesson.id)) existing.completed++;
        sectionMap.set(lesson.section, existing);
      });

      const sectionOrder = ["bio_biochem", "chem_phys", "psych_soc", "cars"];
      const result: SectionData[] = sectionOrder
        .filter((key) => sectionMap.has(key))
        .map((key) => ({
          id: key,
          ...sectionMeta[key],
          totalLessons: sectionMap.get(key)!.total,
          completedLessons: sectionMap.get(key)!.completed,
        }));

      setSections(result);
      setLoading(false);
    }

    loadSections();
  }, [user.id]);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-headline text-2xl sm:text-3xl text-as-primary mb-2">
        Course Lessons
      </h1>
      <p className="text-sm text-as-secondary mb-8">
        Structured content covering all four MCAT sections. Work through the
        lessons at your own pace.
      </p>

      <div className="space-y-4">
        {sections.map((section) => {
          const pct =
            section.totalLessons > 0
              ? Math.round(
                  (section.completedLessons / section.totalLessons) * 100
                )
              : 0;

          return (
            <Link
              key={section.id}
              href={`/dashboard/lessons/${section.id}`}
              className="block bg-as-surface-container-lowest rounded-2xl border border-as-outline-variant/15 p-6 hover:border-as-surface-tint/50 hover:shadow-sm transition-all"
            >
              <div className="flex items-start gap-4">
                <div
                  className={`w-12 h-12 rounded-xl bg-gradient-to-br ${section.color} flex items-center justify-center text-2xl shrink-0`}
                >
                  {section.icon}
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center justify-between gap-2">
                    <h2 className="font-headline text-lg text-as-primary">
                      {section.label}
                    </h2>
                    <span className="text-xs font-medium text-as-outline shrink-0">
                      {section.completedLessons}/{section.totalLessons} lessons
                    </span>
                  </div>
                  <p className="text-xs text-as-secondary mt-0.5 mb-3">
                    {section.description}
                  </p>
                  {/* Progress bar */}
                  <div className="h-1.5 bg-as-surface-container rounded-full overflow-hidden">
                    <div
                      className="h-full bg-as-primary rounded-full transition-all duration-300"
                      style={{ width: `${pct}%` }}
                    />
                  </div>
                </div>
              </div>
            </Link>
          );
        })}
      </div>

      {sections.length === 0 && (
        <div className="text-center py-16">
          <p className="text-as-outline text-sm">
            No lessons available yet. Check back soon!
          </p>
        </div>
      )}
    </div>
  );
}
