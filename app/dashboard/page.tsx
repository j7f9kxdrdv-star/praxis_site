"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface DashboardStats {
  streak: number;
  questionsThisWeek: number;
  totalQuestions: number;
  accuracy: number | null; // null if < 20 questions
}

function getGreeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return "Good morning";
  if (hour < 17) return "Good afternoon";
  return "Good evening";
}

export default function DashboardHome() {
  const { user, profile } = useDashboard();
  const [stats, setStats] = useState<DashboardStats>({
    streak: 0,
    questionsThisWeek: 0,
    totalQuestions: 0,
    accuracy: null,
  });
  const [recentSession, setRecentSession] = useState<{
    id: string;
    section: string | null;
    correct_count: number;
    total_questions: number;
  } | null>(null);

  const firstName =
    profile?.first_name ||
    user.user_metadata?.first_name ||
    user.email?.split("@")[0] ||
    "Student";

  useEffect(() => {
    async function loadStats() {
      // Get total question attempts and accuracy
      const { data: attempts } = await supabase
        .from("question_attempts")
        .select("is_correct, created_at")
        .eq("user_id", user.id);

      if (attempts && attempts.length > 0) {
        const correct = attempts.filter((a) => a.is_correct).length;
        const total = attempts.length;

        // Questions this week
        const weekAgo = new Date();
        weekAgo.setDate(weekAgo.getDate() - 7);
        const thisWeek = attempts.filter(
          (a) => new Date(a.created_at) >= weekAgo
        ).length;

        setStats({
          streak: 0, // calculated from daily_activity
          questionsThisWeek: thisWeek,
          totalQuestions: total,
          accuracy: total >= 20 ? Math.round((correct / total) * 100) : null,
        });
      }

      // Get streak from daily_activity
      const { data: activity } = await supabase
        .from("daily_activity")
        .select("activity_date")
        .eq("user_id", user.id)
        .order("activity_date", { ascending: false })
        .limit(60);

      if (activity && activity.length > 0) {
        let streak = 0;
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        for (let i = 0; i < activity.length; i++) {
          const actDate = new Date(activity[i].activity_date + "T00:00:00");
          const expected = new Date(today);
          expected.setDate(expected.getDate() - i);

          if (actDate.getTime() === expected.getTime()) {
            streak++;
          } else {
            break;
          }
        }
        setStats((prev) => ({ ...prev, streak }));
      }

      // Get most recent completed session
      const { data: sessions } = await supabase
        .from("practice_sessions")
        .select("id, section, correct_count, total_questions")
        .eq("user_id", user.id)
        .eq("status", "completed")
        .order("completed_at", { ascending: false })
        .limit(1);

      if (sessions && sessions.length > 0) {
        setRecentSession(sessions[0]);
      }
    }

    loadStats();
  }, [user.id]);

  const sectionLabels: Record<string, string> = {
    bio_biochem: "Bio/Biochem",
    chem_phys: "Chem/Phys",
    psych_soc: "Psych/Soc",
    cars: "CARS",
  };

  const isNewUser = stats.totalQuestions === 0;

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      {/* Hero greeting */}
      <div className="mb-8">
        <h1 className="font-serif text-2xl sm:text-3xl text-navy">
          {getGreeting()}, {firstName}
        </h1>
        <p className="mt-1 text-sm sm:text-base text-gray-600">
          {isNewUser
            ? "Welcome to Praxis Prep. Let's get you started with your first practice session."
            : recentSession
            ? `Last session: ${recentSession.correct_count}/${recentSession.total_questions} correct${
                recentSession.section
                  ? ` in ${sectionLabels[recentSession.section] || recentSession.section}`
                  : ""
              }. Keep it up!`
            : "Let's keep the momentum going."}
        </p>
      </div>

      {/* Primary CTA */}
      <Link
        href="/dashboard/practice"
        className="block w-full sm:w-auto sm:inline-flex items-center justify-center rounded-xl bg-navy px-8 py-4 text-base font-semibold text-white hover:bg-navy-light transition-colors mb-8 text-center"
      >
        {isNewUser ? "Start Your First Practice" : "Continue Practicing"}
        <svg
          className="w-5 h-5 ml-2 inline"
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
      </Link>

      {/* Stats row */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4 mb-8">
        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-lg">🔥</span>
            <p className="text-xs font-medium text-gray-400 uppercase tracking-wider">
              Streak
            </p>
          </div>
          <p className="text-2xl sm:text-3xl font-semibold text-navy">
            {stats.streak}
          </p>
          <p className="text-xs text-gray-400 mt-0.5">
            {stats.streak === 0
              ? "Study today to start!"
              : stats.streak === 1
              ? "day"
              : "days"}
          </p>
        </div>

        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-lg">📝</span>
            <p className="text-xs font-medium text-gray-400 uppercase tracking-wider">
              This Week
            </p>
          </div>
          <p className="text-2xl sm:text-3xl font-semibold text-navy">
            {stats.questionsThisWeek}
          </p>
          <p className="text-xs text-gray-400 mt-0.5">questions</p>
        </div>

        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-lg">📊</span>
            <p className="text-xs font-medium text-gray-400 uppercase tracking-wider">
              Accuracy
            </p>
          </div>
          <p className="text-2xl sm:text-3xl font-semibold text-navy">
            {stats.accuracy !== null ? `${stats.accuracy}%` : "—"}
          </p>
          <p className="text-xs text-gray-400 mt-0.5">
            {stats.accuracy !== null
              ? `${stats.totalQuestions} total`
              : "Answer 20+ to see"}
          </p>
        </div>

        <div className="bg-white rounded-2xl border border-gray-200 p-4 sm:p-5">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-lg">🎯</span>
            <p className="text-xs font-medium text-gray-400 uppercase tracking-wider">
              Total
            </p>
          </div>
          <p className="text-2xl sm:text-3xl font-semibold text-navy">
            {stats.totalQuestions}
          </p>
          <p className="text-xs text-gray-400 mt-0.5">questions done</p>
        </div>
      </div>

      {/* Quick action cards */}
      <h2 className="font-serif text-lg text-navy mb-4">Quick Actions</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">
        {/* Practice Questions */}
        <Link
          href="/dashboard/practice"
          className="group bg-white rounded-2xl border border-gray-200 p-6 hover:border-amber/50 hover:shadow-sm transition-all"
        >
          <div className="w-10 h-10 rounded-xl bg-amber/10 flex items-center justify-center mb-3">
            <svg
              className="w-5 h-5 text-amber"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M9.879 7.519c1.171-1.025 3.071-1.025 4.242 0 1.172 1.025 1.172 2.687 0 3.712-.203.179-.43.326-.67.442-.745.361-1.45.999-1.45 1.827v.75M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9 5.25h.008v.008H12v-.008z"
              />
            </svg>
          </div>
          <h3 className="font-serif text-base text-navy mb-1 group-hover:text-navy-light transition-colors">
            Practice Questions
          </h3>
          <p className="text-xs text-gray-500">
            Quick 10, by section, or target weak areas
          </p>
        </Link>

        {/* Course Lessons */}
        <Link
          href="/dashboard/lessons"
          className="group bg-white rounded-2xl border border-gray-200 p-6 hover:border-sage/50 hover:shadow-sm transition-all"
        >
          <div className="w-10 h-10 rounded-xl bg-sage/20 flex items-center justify-center mb-3">
            <svg
              className="w-5 h-5 text-sage"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25"
              />
            </svg>
          </div>
          <h3 className="font-serif text-base text-navy mb-1 group-hover:text-navy-light transition-colors">
            Course Lessons
          </h3>
          <p className="text-xs text-gray-500">
            Structured content across all MCAT sections
          </p>
        </Link>
      </div>

      {/* Log out + upgrade banner */}
      <div className="bg-gradient-to-br from-navy to-warm-brown rounded-2xl p-6 sm:p-8 text-white">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h2 className="font-serif text-lg sm:text-xl mb-1">
              {profile?.subscription_tier === "free"
                ? "Unlock your full potential"
                : "You're on the right track"}
            </h2>
            <p className="text-sm text-white/70">
              {profile?.subscription_tier === "free"
                ? "Upgrade to access all practice questions, course content, and 1:1 mentorship."
                : "Keep practicing and watch your scores improve."}
            </p>
          </div>
          {profile?.subscription_tier === "free" && (
            <Link
              href="/pricing"
              className="inline-flex items-center justify-center rounded-xl bg-amber px-6 py-3 text-sm font-semibold text-navy hover:bg-amber/90 transition-colors whitespace-nowrap"
            >
              View Plans
            </Link>
          )}
        </div>
      </div>
    </div>
  );
}
