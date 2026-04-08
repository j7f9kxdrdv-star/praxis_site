"use client";

import { useEffect, useState } from "react";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface SectionStats {
  section: string;
  label: string;
  total: number;
  correct: number;
  accuracy: number;
  color: string;
}

interface DailyData {
  date: string;
  questions: number;
}

interface SubtopicStat {
  section: string;
  subtopic: string;
  total: number;
  correct: number;
  accuracy: number;
}

const sectionLabels: Record<string, string> = {
  bio_biochem: "Bio/Biochem",
  chem_phys: "Chem/Phys",
  psych_soc: "Psych/Soc",
  cars: "CARS",
};

const sectionColors: Record<string, { bar: string; bg: string; text: string }> =
  {
    bio_biochem: {
      bar: "bg-sage",
      bg: "bg-sage/10",
      text: "text-sage",
    },
    chem_phys: {
      bar: "bg-amber",
      bg: "bg-amber/10",
      text: "text-amber",
    },
    psych_soc: {
      bar: "bg-plum",
      bg: "bg-plum/10",
      text: "text-plum",
    },
    cars: {
      bar: "bg-coral",
      bg: "bg-coral/10",
      text: "text-coral",
    },
  };

function getMasteryLabel(accuracy: number): {
  label: string;
  color: string;
} {
  if (accuracy >= 80)
    return { label: "Strong", color: "bg-sage/20 text-sage" };
  if (accuracy >= 60)
    return { label: "Developing", color: "bg-amber/20 text-amber" };
  return { label: "Needs Work", color: "bg-coral/20 text-coral" };
}

export default function AnalyticsPage() {
  const { user } = useDashboard();
  const [sectionStats, setSectionStats] = useState<SectionStats[]>([]);
  const [subtopicStats, setSubtopicStats] = useState<SubtopicStat[]>([]);
  const [dailyData, setDailyData] = useState<DailyData[]>([]);
  const [totalQuestions, setTotalQuestions] = useState(0);
  const [totalCorrect, setTotalCorrect] = useState(0);
  const [streak, setStreak] = useState(0);
  const [lessonsCompleted, setLessonsCompleted] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadAnalytics() {
      // 1. Get all question attempts with question details
      const { data: attempts } = await supabase
        .from("question_attempts")
        .select(
          "is_correct, created_at, questions(section, subtopic)"
        )
        .eq("user_id", user.id);

      if (attempts) {
        setTotalQuestions(attempts.length);
        const correct = attempts.filter((a) => a.is_correct).length;
        setTotalCorrect(correct);

        // Section breakdown
        const sectionMap = new Map<
          string,
          { total: number; correct: number }
        >();
        const subtopicMap = new Map<
          string,
          { section: string; subtopic: string; total: number; correct: number }
        >();

        attempts.forEach((a) => {
          const q = a.questions as unknown as {
            section: string;
            subtopic: string;
          };
          if (!q) return;

          // Section stats
          const sec = sectionMap.get(q.section) || {
            total: 0,
            correct: 0,
          };
          sec.total++;
          if (a.is_correct) sec.correct++;
          sectionMap.set(q.section, sec);

          // Subtopic stats
          const key = `${q.section}::${q.subtopic}`;
          const sub = subtopicMap.get(key) || {
            section: q.section,
            subtopic: q.subtopic,
            total: 0,
            correct: 0,
          };
          sub.total++;
          if (a.is_correct) sub.correct++;
          subtopicMap.set(key, sub);
        });

        const sectionOrder = [
          "bio_biochem",
          "chem_phys",
          "psych_soc",
          "cars",
        ];
        const stats: SectionStats[] = sectionOrder
          .filter((s) => sectionMap.has(s))
          .map((s) => {
            const data = sectionMap.get(s)!;
            return {
              section: s,
              label: sectionLabels[s],
              total: data.total,
              correct: data.correct,
              accuracy:
                data.total > 0
                  ? Math.round((data.correct / data.total) * 100)
                  : 0,
              color: s,
            };
          });
        setSectionStats(stats);

        const subs: SubtopicStat[] = Array.from(subtopicMap.values())
          .map((s) => ({
            ...s,
            accuracy:
              s.total > 0 ? Math.round((s.correct / s.total) * 100) : 0,
          }))
          .sort((a, b) => a.accuracy - b.accuracy); // weakest first
        setSubtopicStats(subs);
      }

      // 2. All-time daily activity (grouped by week for the chart)
      const { data: activity } = await supabase
        .from("daily_activity")
        .select("activity_date, questions_completed")
        .eq("user_id", user.id)
        .order("activity_date");

      if (activity && activity.length > 0) {
        // Group by week (starting Monday)
        const weekMap = new Map<string, number>();
        activity.forEach((a) => {
          const d = new Date(a.activity_date + "T00:00:00");
          const day = d.getDay();
          const monday = new Date(d);
          monday.setDate(d.getDate() - ((day + 6) % 7));
          const weekKey = monday.toISOString().split("T")[0];
          weekMap.set(
            weekKey,
            (weekMap.get(weekKey) || 0) + a.questions_completed
          );
        });

        // Fill in missing weeks between first activity and now
        const firstDate = new Date(activity[0].activity_date + "T00:00:00");
        const firstDay = firstDate.getDay();
        const firstMonday = new Date(firstDate);
        firstMonday.setDate(firstDate.getDate() - ((firstDay + 6) % 7));

        const today = new Date();
        const todayDay = today.getDay();
        const thisMonday = new Date(today);
        thisMonday.setDate(today.getDate() - ((todayDay + 6) % 7));

        const filled: DailyData[] = [];
        const current = new Date(firstMonday);
        while (current <= thisMonday) {
          const weekKey = current.toISOString().split("T")[0];
          filled.push({
            date: weekKey,
            questions: weekMap.get(weekKey) || 0,
          });
          current.setDate(current.getDate() + 7);
        }
        setDailyData(filled);
      }

      // 3. Streak
      const { data: streakData } = await supabase
        .from("daily_activity")
        .select("activity_date")
        .eq("user_id", user.id)
        .order("activity_date", { ascending: false })
        .limit(60);

      if (streakData && streakData.length > 0) {
        let s = 0;
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        for (let i = 0; i < streakData.length; i++) {
          const actDate = new Date(
            streakData[i].activity_date + "T00:00:00"
          );
          const expected = new Date(today);
          expected.setDate(expected.getDate() - i);
          if (actDate.getTime() === expected.getTime()) {
            s++;
          } else {
            break;
          }
        }
        setStreak(s);
      }

      // 4. Lessons completed
      const { data: progress } = await supabase
        .from("lesson_progress")
        .select("id")
        .eq("user_id", user.id)
        .eq("completed", true);

      setLessonsCompleted(progress?.length || 0);

      setLoading(false);
    }

    loadAnalytics();
  }, [user.id]);

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-navy border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  const overallAccuracy =
    totalQuestions > 0
      ? Math.round((totalCorrect / totalQuestions) * 100)
      : 0;

  const maxDaily = Math.max(...dailyData.map((d) => d.questions), 1);

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-serif text-2xl sm:text-3xl text-navy mb-2">
        Analytics
      </h1>
      <p className="text-sm text-gray-600 mb-8">
        Track your progress and identify areas to improve.
      </p>

      {/* Overview stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 mb-8">
        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <p className="text-xs font-medium text-gray-400 uppercase tracking-wider mb-1">
            Total Questions
          </p>
          <p className="text-2xl font-semibold text-navy">{totalQuestions}</p>
        </div>
        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <p className="text-xs font-medium text-gray-400 uppercase tracking-wider mb-1">
            Overall Accuracy
          </p>
          <p className="text-2xl font-semibold text-navy">
            {totalQuestions > 0 ? `${overallAccuracy}%` : "—"}
          </p>
        </div>
        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <p className="text-xs font-medium text-gray-400 uppercase tracking-wider mb-1">
            Study Streak
          </p>
          <p className="text-2xl font-semibold text-navy">
            {streak} {streak === 1 ? "day" : "days"}
          </p>
        </div>
        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <p className="text-xs font-medium text-gray-400 uppercase tracking-wider mb-1">
            Lessons Done
          </p>
          <p className="text-2xl font-semibold text-navy">
            {lessonsCompleted}
          </p>
        </div>
      </div>

      {/* Activity chart (last 30 days) */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5 sm:p-6 mb-8">
        <h2 className="font-serif text-lg text-navy mb-1">Weekly Activity</h2>
        <p className="text-xs text-gray-400 mb-4">
          Questions answered per week since you started
        </p>

        {dailyData.length === 0 ? (
          <p className="text-sm text-gray-400 text-center py-8">
            Complete a practice session to see your activity here.
          </p>
        ) : (
          <>
            <div className="flex items-end gap-1 h-32">
              {dailyData.map((d, idx) => {
                const height =
                  d.questions > 0
                    ? Math.max((d.questions / maxDaily) * 100, 8)
                    : 0;
                const isCurrentWeek = idx === dailyData.length - 1;

                return (
                  <div
                    key={d.date}
                    className="flex flex-col items-center justify-end h-full group relative"
                    style={{
                      width:
                        dailyData.length < 8
                          ? `${Math.min(100 / dailyData.length, 40)}%`
                          : undefined,
                      flex: dailyData.length >= 8 ? "1" : undefined,
                    }}
                  >
                    <div className="absolute -top-6 left-1/2 -translate-x-1/2 bg-navy text-white text-[10px] px-1.5 py-0.5 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
                      {d.questions}
                    </div>
                    <div
                      className={`w-full rounded-t-md transition-all ${
                        d.questions > 0
                          ? isCurrentWeek
                            ? "bg-amber"
                            : "bg-navy/60 group-hover:bg-navy"
                          : "bg-gray-100"
                      }`}
                      style={{
                        height: d.questions > 0 ? `${height}%` : "2px",
                      }}
                    />
                    {dailyData.length <= 12 && (
                      <span className="text-[9px] text-gray-400 mt-1 whitespace-nowrap">
                        {new Date(d.date + "T00:00:00").toLocaleDateString(
                          "en-US",
                          { month: "short", day: "numeric" }
                        )}
                      </span>
                    )}
                  </div>
                );
              })}
            </div>
            {dailyData.length > 12 && (
              <div className="flex justify-between mt-2 text-[10px] text-gray-400">
                <span>
                  {new Date(
                    dailyData[0].date + "T00:00:00"
                  ).toLocaleDateString("en-US", {
                    month: "short",
                    day: "numeric",
                  })}
                </span>
                <span>This week</span>
              </div>
            )}
          </>
        )}
      </div>

      {/* Section breakdown */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5 sm:p-6 mb-8">
        <h2 className="font-serif text-lg text-navy mb-4">
          Accuracy by Section
        </h2>

        {sectionStats.length === 0 ? (
          <p className="text-sm text-gray-400 text-center py-8">
            Answer some practice questions to see your section breakdown.
          </p>
        ) : (
          <div className="space-y-4">
            {sectionStats.map((s) => {
              const colors = sectionColors[s.section];
              return (
                <div key={s.section}>
                  <div className="flex items-center justify-between mb-1.5">
                    <span className="text-sm font-medium text-navy">
                      {s.label}
                    </span>
                    <div className="flex items-center gap-3">
                      <span className="text-xs text-gray-400">
                        {s.correct}/{s.total} correct
                      </span>
                      <span
                        className={`text-sm font-semibold ${
                          s.accuracy >= 80
                            ? "text-sage"
                            : s.accuracy >= 60
                            ? "text-amber"
                            : "text-coral"
                        }`}
                      >
                        {s.accuracy}%
                      </span>
                    </div>
                  </div>
                  <div className="h-3 bg-gray-100 rounded-full overflow-hidden">
                    <div
                      className={`h-full ${colors?.bar || "bg-navy"} rounded-full transition-all duration-500`}
                      style={{ width: `${s.accuracy}%` }}
                    />
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* Subtopic mastery */}
      <div className="bg-white rounded-2xl border border-gray-200 p-5 sm:p-6">
        <h2 className="font-serif text-lg text-navy mb-1">
          Topic Mastery
        </h2>
        <p className="text-xs text-gray-400 mb-4">
          Sorted by accuracy — weakest topics first so you know where to
          focus.
        </p>

        {subtopicStats.length === 0 ? (
          <p className="text-sm text-gray-400 text-center py-8">
            Answer some practice questions to see your topic breakdown.
          </p>
        ) : (
          <div className="space-y-2">
            {subtopicStats.map((s) => {
              const mastery = getMasteryLabel(s.accuracy);
              const secColors = sectionColors[s.section];

              return (
                <div
                  key={`${s.section}::${s.subtopic}`}
                  className="flex items-center gap-3 py-2.5 border-b border-gray-100 last:border-0"
                >
                  {/* Section indicator */}
                  <div
                    className={`w-2 h-2 rounded-full ${secColors?.bar || "bg-gray-400"} shrink-0`}
                  />

                  {/* Topic name */}
                  <div className="flex-1 min-w-0">
                    <p className="text-sm text-navy truncate">
                      {s.subtopic.replace(/_/g, " ")}
                    </p>
                    <p className="text-[10px] text-gray-400">
                      {sectionLabels[s.section]} · {s.correct}/{s.total}{" "}
                      correct
                    </p>
                  </div>

                  {/* Accuracy + mastery badge */}
                  <div className="flex items-center gap-2 shrink-0">
                    <span className="text-sm font-semibold text-navy">
                      {s.accuracy}%
                    </span>
                    <span
                      className={`text-[10px] font-medium px-2 py-0.5 rounded-full ${mastery.color}`}
                    >
                      {mastery.label}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
