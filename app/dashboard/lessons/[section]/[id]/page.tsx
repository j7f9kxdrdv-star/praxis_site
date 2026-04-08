"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useParams, useRouter } from "next/navigation";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface Lesson {
  id: string;
  section: string;
  topic: string;
  title: string;
  content: string;
  estimated_minutes: number;
}

const sectionLabels: Record<string, string> = {
  bio_biochem: "Bio/Biochem",
  chem_phys: "Chem/Phys",
  psych_soc: "Psych/Soc",
  cars: "CARS",
};

// Simple markdown-like renderer for lesson content
function renderContent(content: string) {
  const lines = content.split("\n");
  const elements: React.ReactNode[] = [];
  let inTable = false;
  let tableRows: string[][] = [];
  let tableHeaders: string[] = [];

  function processInline(text: string): React.ReactNode {
    // Bold
    const parts = text.split(/\*\*(.*?)\*\*/g);
    return parts.map((part, i) =>
      i % 2 === 1 ? (
        <strong key={i} className="font-semibold text-navy">
          {part}
        </strong>
      ) : (
        part
      )
    );
  }

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // Table handling
    if (line.startsWith("|") && line.endsWith("|")) {
      if (line.includes("---")) continue; // separator row
      const cells = line
        .split("|")
        .filter((c) => c.trim())
        .map((c) => c.trim());
      if (!inTable) {
        inTable = true;
        tableHeaders = cells;
        tableRows = [];
      } else {
        tableRows.push(cells);
      }
      // Check if next line is not a table row
      if (i + 1 >= lines.length || !lines[i + 1]?.startsWith("|")) {
        elements.push(
          <div key={i} className="overflow-x-auto my-4">
            <table className="w-full text-sm border-collapse">
              <thead>
                <tr>
                  {tableHeaders.map((h, j) => (
                    <th
                      key={j}
                      className="border border-gray-200 bg-sand px-3 py-2 text-left font-semibold text-navy text-xs"
                    >
                      {h}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {tableRows.map((row, j) => (
                  <tr key={j}>
                    {row.map((cell, k) => (
                      <td
                        key={k}
                        className="border border-gray-200 px-3 py-2 text-xs text-gray-700"
                      >
                        {processInline(cell)}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        );
        inTable = false;
      }
      continue;
    }

    // Headings
    if (line.startsWith("## ")) {
      elements.push(
        <h2
          key={i}
          className="font-serif text-xl text-navy mt-8 mb-3 first:mt-0"
        >
          {line.slice(3)}
        </h2>
      );
    } else if (line.startsWith("### ")) {
      elements.push(
        <h3 key={i} className="font-semibold text-base text-navy mt-6 mb-2">
          {line.slice(4)}
        </h3>
      );
    }
    // Bullet points
    else if (line.startsWith("- ")) {
      elements.push(
        <li
          key={i}
          className="ml-4 text-sm text-gray-700 leading-relaxed list-disc"
        >
          {processInline(line.slice(2))}
        </li>
      );
    }
    // Numbered items like "1. " or "2. "
    else if (/^\d+\.\s/.test(line)) {
      elements.push(
        <li
          key={i}
          className="ml-4 text-sm text-gray-700 leading-relaxed list-decimal"
        >
          {processInline(line.replace(/^\d+\.\s/, ""))}
        </li>
      );
    }
    // Empty lines
    else if (line.trim() === "") {
      elements.push(<div key={i} className="h-2" />);
    }
    // Regular paragraphs
    else {
      elements.push(
        <p key={i} className="text-sm text-gray-700 leading-relaxed">
          {processInline(line)}
        </p>
      );
    }
  }

  return elements;
}

export default function LessonPage() {
  const params = useParams();
  const router = useRouter();
  const { user } = useDashboard();
  const section = params.section as string;
  const lessonId = params.id as string;

  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [completed, setCompleted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [marking, setMarking] = useState(false);

  useEffect(() => {
    async function load() {
      const { data: lessonData } = await supabase
        .from("lessons")
        .select("*")
        .eq("id", lessonId)
        .single();

      if (!lessonData) {
        router.push(`/dashboard/lessons/${section}`);
        return;
      }

      setLesson(lessonData);

      // Check completion status
      const { data: progress } = await supabase
        .from("lesson_progress")
        .select("completed")
        .eq("user_id", user.id)
        .eq("lesson_id", lessonId)
        .single();

      if (progress?.completed) {
        setCompleted(true);
      }

      setLoading(false);
    }

    load();
  }, [lessonId, section, router, user.id]);

  async function toggleComplete() {
    setMarking(true);

    if (completed) {
      // Unmark
      await supabase
        .from("lesson_progress")
        .update({ completed: false, completed_at: null })
        .eq("user_id", user.id)
        .eq("lesson_id", lessonId);
      setCompleted(false);
    } else {
      // Mark complete — upsert
      const { data: existing } = await supabase
        .from("lesson_progress")
        .select("id")
        .eq("user_id", user.id)
        .eq("lesson_id", lessonId)
        .single();

      if (existing) {
        await supabase
          .from("lesson_progress")
          .update({ completed: true, completed_at: new Date().toISOString() })
          .eq("id", existing.id);
      } else {
        await supabase.from("lesson_progress").insert({
          user_id: user.id,
          lesson_id: lessonId,
          completed: true,
          completed_at: new Date().toISOString(),
        });
      }

      // Also log daily activity
      const today = new Date().toISOString().split("T")[0];
      const { data: activity } = await supabase
        .from("daily_activity")
        .select("*")
        .eq("user_id", user.id)
        .eq("activity_date", today)
        .single();

      if (activity) {
        await supabase
          .from("daily_activity")
          .update({
            time_studied_seconds:
              activity.time_studied_seconds +
              (lesson?.estimated_minutes || 15) * 60,
          })
          .eq("id", activity.id);
      } else {
        await supabase.from("daily_activity").insert({
          user_id: user.id,
          activity_date: today,
          time_studied_seconds: (lesson?.estimated_minutes || 15) * 60,
        });
      }

      setCompleted(true);
    }

    setMarking(false);
  }

  if (loading || !lesson) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-navy border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

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
        <Link
          href={`/dashboard/lessons/${section}`}
          className="hover:text-navy transition-colors"
        >
          {sectionLabels[section] || section}
        </Link>
        <span>/</span>
        <span className="text-navy font-medium truncate">{lesson.title}</span>
      </div>

      {/* Lesson header */}
      <div className="mb-8">
        <span className="inline-block text-xs font-medium text-gray-400 bg-white border border-gray-200 rounded-full px-3 py-1 mb-3">
          {lesson.topic} · ~{lesson.estimated_minutes} min
        </span>
        <h1 className="font-serif text-2xl sm:text-3xl text-navy">
          {lesson.title}
        </h1>
      </div>

      {/* Lesson content */}
      <div className="bg-white rounded-2xl border border-gray-200 p-6 sm:p-8 mb-6">
        {renderContent(lesson.content)}
      </div>

      {/* Mark complete */}
      <div className="flex flex-col sm:flex-row items-center gap-3">
        <button
          onClick={toggleComplete}
          disabled={marking}
          className={`w-full sm:w-auto inline-flex items-center justify-center gap-2 rounded-xl px-8 py-3.5 text-sm font-semibold transition-colors disabled:opacity-50 ${
            completed
              ? "bg-sage text-white hover:bg-sage/90"
              : "bg-navy text-white hover:bg-navy-light"
          }`}
        >
          {completed ? (
            <>
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
              Completed
            </>
          ) : (
            "Mark as Complete"
          )}
        </button>
        <Link
          href={`/dashboard/lessons/${section}`}
          className="w-full sm:w-auto inline-flex items-center justify-center rounded-xl border border-gray-200 px-8 py-3.5 text-sm font-semibold text-navy hover:bg-sand transition-colors"
        >
          Back to {sectionLabels[section]}
        </Link>
      </div>
    </div>
  );
}
