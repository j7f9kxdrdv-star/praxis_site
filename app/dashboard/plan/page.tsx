"use client";

import { useEffect, useState } from "react";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface StudyTask {
  id: string;
  scheduled_date: string;
  task_type: string;
  title: string;
  description: string | null;
  completed: boolean;
}

const taskTypeIcons: Record<string, { icon: string; color: string }> = {
  lesson: { icon: "📖", color: "bg-sage/10" },
  practice: { icon: "📝", color: "bg-amber/10" },
  review: { icon: "🔄", color: "bg-plum/10" },
};

function getWeekDates(): { date: Date; label: string; isToday: boolean }[] {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const dayOfWeek = today.getDay(); // 0=Sun, 1=Mon, ...
  const monday = new Date(today);
  monday.setDate(today.getDate() - ((dayOfWeek + 6) % 7)); // go back to Monday

  const days = [];
  const dayLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  for (let i = 0; i < 7; i++) {
    const d = new Date(monday);
    d.setDate(monday.getDate() + i);
    days.push({
      date: d,
      label: dayLabels[i],
      isToday: d.getTime() === today.getTime(),
    });
  }

  return days;
}

function formatDate(d: Date): string {
  return d.toISOString().split("T")[0];
}

export default function StudyPlanPage() {
  const { user, profile, refreshProfile } = useDashboard();
  const [tasks, setTasks] = useState<StudyTask[]>([]);
  const [loading, setLoading] = useState(true);
  const [generating, setGenerating] = useState(false);
  const [selectedDay, setSelectedDay] = useState<string>(
    formatDate(new Date())
  );

  // Onboarding state
  const [testDate, setTestDate] = useState(profile?.mcat_test_date || "");
  const [hoursPerWeek, setHoursPerWeek] = useState(
    profile?.study_hours_per_week || 15
  );

  const weekDays = getWeekDates();

  useEffect(() => {
    loadTasks();
  }, [user.id]);

  async function loadTasks() {
    const startOfWeek = formatDate(weekDays[0].date);
    const endOfWeek = formatDate(weekDays[6].date);

    const { data } = await supabase
      .from("study_plan_tasks")
      .select("*")
      .eq("user_id", user.id)
      .gte("scheduled_date", startOfWeek)
      .lte("scheduled_date", endOfWeek)
      .order("sort_order");

    setTasks(data || []);
    setLoading(false);
  }

  async function toggleTask(taskId: string, currentlyCompleted: boolean) {
    await supabase
      .from("study_plan_tasks")
      .update({
        completed: !currentlyCompleted,
        completed_at: !currentlyCompleted ? new Date().toISOString() : null,
      })
      .eq("id", taskId);

    setTasks((prev) =>
      prev.map((t) =>
        t.id === taskId ? { ...t, completed: !currentlyCompleted } : t
      )
    );
  }

  async function generatePlan() {
    setGenerating(true);

    // Save preferences to profile
    await supabase
      .from("profiles")
      .update({
        mcat_test_date: testDate || null,
        study_hours_per_week: hoursPerWeek,
      })
      .eq("id", user.id);

    // Clear existing tasks for this week
    const startOfWeek = formatDate(weekDays[0].date);
    const endOfWeek = formatDate(weekDays[6].date);

    await supabase
      .from("study_plan_tasks")
      .delete()
      .eq("user_id", user.id)
      .gte("scheduled_date", startOfWeek)
      .lte("scheduled_date", endOfWeek);

    // Get available lessons
    const { data: lessons } = await supabase
      .from("lessons")
      .select("id, section, title, estimated_minutes")
      .order("sort_order");

    // Get completed lessons
    const { data: progress } = await supabase
      .from("lesson_progress")
      .select("lesson_id")
      .eq("user_id", user.id)
      .eq("completed", true);

    const completedIds = new Set(progress?.map((p) => p.lesson_id) || []);
    const incompleteLessons =
      lessons?.filter((l) => !completedIds.has(l.id)) || [];

    // Distribute tasks across the week
    const dailyMinutes = Math.round((hoursPerWeek * 60) / 7);
    const tasksToInsert: Omit<StudyTask, "id">[] = [];
    let lessonIndex = 0;

    const sectionNames: Record<string, string> = {
      bio_biochem: "Bio/Biochem",
      chem_phys: "Chem/Phys",
      psych_soc: "Psych/Soc",
      cars: "CARS",
    };

    for (let day = 0; day < 7; day++) {
      const date = formatDate(weekDays[day].date);
      let minutesRemaining = dailyMinutes;
      let sortOrder = 0;

      // Add a lesson if available
      if (lessonIndex < incompleteLessons.length && minutesRemaining >= 15) {
        const lesson = incompleteLessons[lessonIndex];
        tasksToInsert.push({
          scheduled_date: date,
          task_type: "lesson",
          title: `Read: ${lesson.title}`,
          description: `${sectionNames[lesson.section] || lesson.section} lesson (~${lesson.estimated_minutes} min)`,
          completed: false,
          reference_id: lesson.id,
          sort_order: sortOrder++,
        } as never);
        minutesRemaining -= lesson.estimated_minutes;
        lessonIndex++;
      }

      // Add practice questions
      if (minutesRemaining >= 15) {
        const sections = ["Bio/Biochem", "Chem/Phys", "Psych/Soc", "CARS"];
        const section = sections[day % 4];
        tasksToInsert.push({
          scheduled_date: date,
          task_type: "practice",
          title: `Practice: ${section} Questions`,
          description: `Complete a Quick 10 session (~15 min)`,
          completed: false,
          sort_order: sortOrder++,
        } as never);
        minutesRemaining -= 15;
      }

      // Add review on some days
      if (day === 2 || day === 5) {
        tasksToInsert.push({
          scheduled_date: date,
          task_type: "review",
          title: "Review: Missed Questions",
          description: "Go over questions you got wrong this week",
          completed: false,
          sort_order: sortOrder++,
        } as never);
      }
    }

    // Insert tasks
    if (tasksToInsert.length > 0) {
      await supabase.from("study_plan_tasks").insert(
        tasksToInsert.map((t) => ({
          ...t,
          user_id: user.id,
        }))
      );
    }

    await refreshProfile();
    await loadTasks();
    setGenerating(false);
  }

  const dayTasks = tasks.filter((t) => t.scheduled_date === selectedDay);
  const completedToday = dayTasks.filter((t) => t.completed).length;
  const hasPlan = tasks.length > 0;

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-navy border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="max-w-3xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-serif text-2xl sm:text-3xl text-navy mb-2">
        Study Plan
      </h1>
      <p className="text-sm text-gray-600 mb-8">
        {hasPlan
          ? "Your personalized weekly study schedule. Check off tasks as you complete them."
          : "Set up your study preferences and we'll create a weekly plan for you."}
      </p>

      {/* Setup / Preferences */}
      {!hasPlan && (
        <div className="bg-white rounded-2xl border border-gray-200 p-6 sm:p-8 mb-8">
          <h2 className="font-serif text-lg text-navy mb-4">
            Let&rsquo;s build your plan
          </h2>

          <div className="space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-900 mb-1.5">
                When is your MCAT?
              </label>
              <input
                type="date"
                value={testDate}
                onChange={(e) => setTestDate(e.target.value)}
                className="w-full sm:w-64 rounded-xl border border-gray-200 bg-white px-4 py-3 text-sm text-gray-900 focus:border-coral focus:ring-2 focus:ring-coral/20 focus:outline-none transition-colors"
              />
              <p className="text-xs text-gray-400 mt-1">
                Optional — helps us pace your studying
              </p>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-900 mb-1.5">
                Hours per week you can study
              </label>
              <div className="flex items-center gap-4">
                <input
                  type="range"
                  min={5}
                  max={40}
                  step={5}
                  value={hoursPerWeek}
                  onChange={(e) => setHoursPerWeek(Number(e.target.value))}
                  className="flex-1 accent-navy"
                />
                <span className="text-sm font-semibold text-navy w-16 text-right">
                  {hoursPerWeek} hrs
                </span>
              </div>
            </div>

            <button
              onClick={generatePlan}
              disabled={generating}
              className="w-full sm:w-auto rounded-xl bg-navy px-8 py-3.5 text-sm font-semibold text-white hover:bg-navy-light transition-colors disabled:opacity-50"
            >
              {generating ? "Building your plan..." : "Generate My Plan"}
            </button>
          </div>
        </div>
      )}

      {/* Weekly view */}
      {hasPlan && (
        <>
          {/* Day selector */}
          <div className="flex gap-2 mb-6 overflow-x-auto pb-2">
            {weekDays.map((day) => {
              const dateStr = formatDate(day.date);
              const isSelected = dateStr === selectedDay;
              const dayTaskCount = tasks.filter(
                (t) => t.scheduled_date === dateStr
              ).length;
              const dayCompletedCount = tasks.filter(
                (t) => t.scheduled_date === dateStr && t.completed
              ).length;
              const allDone =
                dayTaskCount > 0 && dayCompletedCount === dayTaskCount;

              return (
                <button
                  key={dateStr}
                  onClick={() => setSelectedDay(dateStr)}
                  className={`flex flex-col items-center min-w-[4rem] px-3 py-2.5 rounded-xl border transition-all ${
                    isSelected
                      ? "bg-navy text-white border-navy"
                      : day.isToday
                      ? "bg-amber/10 border-amber/30 text-navy"
                      : "bg-white border-gray-200 text-gray-600 hover:border-gray-300"
                  }`}
                >
                  <span className="text-[10px] font-medium uppercase">
                    {day.label}
                  </span>
                  <span className="text-lg font-semibold">
                    {day.date.getDate()}
                  </span>
                  {dayTaskCount > 0 && (
                    <div
                      className={`w-1.5 h-1.5 rounded-full mt-0.5 ${
                        allDone
                          ? "bg-sage"
                          : isSelected
                          ? "bg-white/50"
                          : "bg-amber"
                      }`}
                    />
                  )}
                </button>
              );
            })}
          </div>

          {/* Tasks for selected day */}
          <div className="space-y-3">
            {dayTasks.length === 0 ? (
              <div className="text-center py-12">
                <p className="text-sm text-gray-400">
                  No tasks scheduled for this day. Enjoy the break!
                </p>
              </div>
            ) : (
              <>
                <div className="flex items-center justify-between mb-2">
                  <p className="text-xs text-gray-400">
                    {completedToday}/{dayTasks.length} tasks complete
                  </p>
                </div>
                {dayTasks.map((task) => {
                  const typeInfo = taskTypeIcons[task.task_type] || {
                    icon: "📋",
                    color: "bg-gray-100",
                  };

                  return (
                    <div
                      key={task.id}
                      className={`flex items-start gap-3 bg-white rounded-xl border border-gray-200 p-4 transition-all ${
                        task.completed ? "opacity-60" : ""
                      }`}
                    >
                      <button
                        onClick={() => toggleTask(task.id, task.completed)}
                        className={`w-6 h-6 rounded-full border-2 flex items-center justify-center shrink-0 mt-0.5 transition-colors ${
                          task.completed
                            ? "bg-sage border-sage text-white"
                            : "border-gray-300 hover:border-navy"
                        }`}
                      >
                        {task.completed && (
                          <svg
                            className="w-3 h-3"
                            fill="none"
                            viewBox="0 0 24 24"
                            strokeWidth={3}
                            stroke="currentColor"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              d="M4.5 12.75l6 6 9-13.5"
                            />
                          </svg>
                        )}
                      </button>

                      <div className="flex-1 min-w-0">
                        <p
                          className={`text-sm font-medium ${
                            task.completed
                              ? "line-through text-gray-400"
                              : "text-navy"
                          }`}
                        >
                          {task.title}
                        </p>
                        {task.description && (
                          <p className="text-xs text-gray-400 mt-0.5">
                            {task.description}
                          </p>
                        )}
                      </div>

                      <div
                        className={`w-8 h-8 rounded-lg ${typeInfo.color} flex items-center justify-center shrink-0`}
                      >
                        <span className="text-sm">{typeInfo.icon}</span>
                      </div>
                    </div>
                  );
                })}
              </>
            )}
          </div>

          {/* Regenerate button */}
          <div className="mt-8 pt-6 border-t border-gray-200">
            <button
              onClick={generatePlan}
              disabled={generating}
              className="text-sm text-gray-400 hover:text-navy transition-colors disabled:opacity-50"
            >
              {generating
                ? "Regenerating..."
                : "Regenerate this week's plan"}
            </button>
          </div>
        </>
      )}
    </div>
  );
}
