"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

interface DashboardStats {
  streak: number;
  questionsThisWeek: number;
  totalQuestions: number;
  accuracy: number | null;
}

interface SubjectProgress {
  label: string;
  percent: number;
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
  const [subjectProgress, setSubjectProgress] = useState<SubjectProgress[]>([]);

  const firstName =
    profile?.first_name ||
    user.user_metadata?.first_name ||
    user.email?.split("@")[0] ||
    "Student";

  useEffect(() => {
    async function loadStats() {
      const { data: attempts } = await supabase
        .from("question_attempts")
        .select("is_correct, created_at, question_id")
        .eq("user_id", user.id);

      if (attempts && attempts.length > 0) {
        const correct = attempts.filter((a) => a.is_correct).length;
        const total = attempts.length;

        const weekAgo = new Date();
        weekAgo.setDate(weekAgo.getDate() - 7);
        const thisWeek = attempts.filter(
          (a) => new Date(a.created_at) >= weekAgo
        ).length;

        setStats({
          streak: 0,
          questionsThisWeek: thisWeek,
          totalQuestions: total,
          accuracy: total >= 20 ? Math.round((correct / total) * 100) : null,
        });
      }

      // Streak from daily_activity
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

      // Recent session
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

      // Subject progress - questions answered per section vs total available
      const { data: allQuestions } = await supabase
        .from("questions")
        .select("id, section")
        .is("passage_id", null);

      const { data: answeredAttempts } = await supabase
        .from("question_attempts")
        .select("question_id")
        .eq("user_id", user.id);

      if (allQuestions && answeredAttempts) {
        const answeredSet = new Set(answeredAttempts.map((a) => a.question_id));
        const sectionMap: Record<string, { total: number; done: number }> = {};

        allQuestions.forEach((q) => {
          if (!sectionMap[q.section]) sectionMap[q.section] = { total: 0, done: 0 };
          sectionMap[q.section].total++;
          if (answeredSet.has(q.id)) sectionMap[q.section].done++;
        });

        const labels: Record<string, string> = {
          bio_biochem: "Biological Systems",
          chem_phys: "Chemical Foundations",
          psych_soc: "Psychological Behavior",
          cars: "Critical Reasoning",
        };

        const progress = Object.entries(sectionMap)
          .map(([key, val]) => ({
            label: labels[key] || key,
            percent: val.total > 0 ? Math.round((val.done / val.total) * 100) : 0,
          }))
          .sort((a, b) => b.percent - a.percent);

        setSubjectProgress(progress);
      }
    }

    loadStats();
  }, [user.id]);

  const isNewUser = stats.totalQuestions === 0;
  const lastAccuracy = recentSession
    ? Math.round((recentSession.correct_count / recentSession.total_questions) * 100)
    : null;

  return (
    <div className="px-4 sm:px-6 lg:px-0 py-6 sm:py-10 lg:py-0">
      {/* Top Header */}
      <header className="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-12 sm:mb-20 gap-4">
        <div>
          <h2 className="font-headline text-3xl sm:text-4xl lg:text-5xl font-medium tracking-tight text-as-on-surface">
            {getGreeting()}, {firstName}
          </h2>
          <div className="flex items-center gap-3 mt-4 text-as-secondary/80 font-medium">
            <span className="flex h-2 w-2 rounded-full bg-as-primary/40" />
            <span className="text-sm tracking-[0.015em]">
              {isNewUser
                ? "Welcome to Praxist Prep. Let's begin your journey."
                : lastAccuracy !== null
                ? `Your last session accuracy was ${lastAccuracy}%.${lastAccuracy >= 80 ? " Maintaining peak performance." : " Keep pushing forward."}`
                : "Let's keep the momentum going."}
            </span>
          </div>
        </div>
      </header>

      {/* Prominent Action Entry */}
      <section className="mb-16 sm:mb-24">
        <Link
          href="/dashboard/practice"
          className="block bg-as-primary-container group overflow-hidden rounded-[2rem] sm:rounded-[2.5rem] p-8 sm:p-12 lg:p-16 text-white relative"
        >
          <div className="z-10 max-w-2xl relative">
            <span className="text-[11px] uppercase tracking-[0.3em] font-bold text-white/50 mb-6 block">
              Current Curricula
            </span>
            <h3 className="font-headline text-3xl sm:text-4xl lg:text-5xl mb-6 leading-tight tracking-tight italic">
              Master the MCAT through deliberate, scholarly practice.
            </h3>
            <p className="font-body text-white/70 mb-10 sm:mb-12 text-base sm:text-lg font-light leading-relaxed max-w-lg">
              Your personalized path to mastery is optimized by our core algorithms
              and your unique study rhythm.
            </p>
            <span className="inline-flex items-center gap-4 bg-as-surface text-as-primary px-8 sm:px-10 py-4 sm:py-5 rounded-full font-semibold tracking-[0.015em] group-hover:bg-white group-hover:scale-[1.02] transition-all duration-500 shadow-xl shadow-as-primary/20">
              {isNewUser ? "Start Practicing" : "Continue Practicing"}
              <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
              </svg>
            </span>
          </div>
        </Link>
      </section>

      {/* Insight Pulse Grid */}
      <div className="mb-16 sm:mb-24">
        <div className="flex items-center justify-between mb-8 px-2">
          <h4 className="text-sm font-semibold uppercase tracking-[0.2em] text-as-secondary/60">
            Insight Pulse
          </h4>
          <Link
            href="/dashboard/analytics"
            className="text-xs font-bold text-as-primary hover:underline underline-offset-4 transition-all"
          >
            Detailed Analytics
          </Link>
        </div>
        <section className="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-8">
          {/* Streak */}
          <div className="harvey-card p-6 sm:p-8 rounded-2xl sm:rounded-3xl flex flex-col justify-between aspect-auto sm:aspect-[1.1/1]">
            <div className="flex justify-between items-start mb-4 sm:mb-0">
              <div className="w-10 h-10 rounded-full bg-as-primary/5 flex items-center justify-center">
                <svg className="w-5 h-5 text-as-primary" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15.362 5.214A8.252 8.252 0 0112 21 8.25 8.25 0 016.038 7.048 8.287 8.287 0 009 9.6a8.983 8.983 0 013.361-6.867 8.21 8.21 0 003 2.48z" />
                  <path strokeLinecap="round" strokeLinejoin="round" d="M12 18a3.75 3.75 0 00.495-7.467 5.99 5.99 0 00-1.925 3.546 5.974 5.974 0 01-2.133-1A3.75 3.75 0 0012 18z" />
                </svg>
              </div>
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-secondary/40">
                Streak
              </span>
            </div>
            <div>
              <div className="text-4xl sm:text-6xl font-headline text-as-primary mb-1">
                {stats.streak}
              </div>
              <div className="text-[11px] uppercase tracking-[0.015em] text-as-secondary font-medium">
                Days active
              </div>
            </div>
          </div>

          {/* Activity */}
          <div className="harvey-card p-6 sm:p-8 rounded-2xl sm:rounded-3xl flex flex-col justify-between aspect-auto sm:aspect-[1.1/1]">
            <div className="flex justify-between items-start mb-4 sm:mb-0">
              <div className="w-10 h-10 rounded-full bg-as-primary/5 flex items-center justify-center">
                <svg className="w-5 h-5 text-as-primary" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-secondary/40">
                Activity
              </span>
            </div>
            <div>
              <div className="text-4xl sm:text-6xl font-headline text-as-primary mb-1">
                {stats.questionsThisWeek}
              </div>
              <div className="text-[11px] uppercase tracking-[0.015em] text-as-secondary font-medium">
                Questions this week
              </div>
            </div>
          </div>

          {/* Precision */}
          <div className="harvey-card p-6 sm:p-8 rounded-2xl sm:rounded-3xl flex flex-col justify-between aspect-auto sm:aspect-[1.1/1]">
            <div className="flex justify-between items-start mb-4 sm:mb-0">
              <div className="w-10 h-10 rounded-full bg-as-primary/5 flex items-center justify-center">
                <svg className="w-5 h-5 text-as-primary" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
                </svg>
              </div>
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-secondary/40">
                Precision
              </span>
            </div>
            <div>
              <div className="text-4xl sm:text-6xl font-headline text-as-primary mb-1">
                {stats.accuracy !== null ? `${stats.accuracy}%` : "—"}
              </div>
              <div className="text-[11px] uppercase tracking-[0.015em] text-as-secondary font-medium">
                {stats.accuracy !== null ? "Overall accuracy" : "Answer 20+ to see"}
              </div>
            </div>
          </div>

          {/* Total */}
          <div className="harvey-card p-6 sm:p-8 rounded-2xl sm:rounded-3xl flex flex-col justify-between aspect-auto sm:aspect-[1.1/1]">
            <div className="flex justify-between items-start mb-4 sm:mb-0">
              <div className="w-10 h-10 rounded-full bg-as-primary/5 flex items-center justify-center">
                <svg className="w-5 h-5 text-as-primary" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z" />
                </svg>
              </div>
              <span className="text-[10px] font-bold uppercase tracking-widest text-as-secondary/40">
                Total
              </span>
            </div>
            <div>
              <div className="text-4xl sm:text-6xl font-headline text-as-primary mb-1">
                {stats.totalQuestions}
              </div>
              <div className="text-[11px] uppercase tracking-[0.015em] text-as-secondary font-medium">
                Total Solved
              </div>
            </div>
          </div>
        </section>
      </div>

      {/* Deep Dives & Progress */}
      <section className="grid grid-cols-1 lg:grid-cols-3 gap-6 sm:gap-12 mb-16 sm:mb-24">
        {/* Question Bank */}
        <Link href="/dashboard/practice" className="lg:col-span-1 group cursor-pointer block">
          <div className="harvey-card h-full p-8 sm:p-10 rounded-[2rem] sm:rounded-[2.5rem]">
            <div className="w-14 h-14 bg-as-surface-container-low border border-as-on-surface/[0.04] rounded-2xl flex items-center justify-center mb-10 group-hover:bg-as-primary-container group-hover:text-white transition-all duration-500">
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 18L9 11.25l4.306 4.307a11.95 11.95 0 015.814-5.519l2.74-1.22m0 0l-5.94-2.28m5.94 2.28l-2.28 5.941" />
              </svg>
            </div>
            <h4 className="font-headline text-2xl sm:text-3xl text-as-on-surface mb-4">
              The Question Bank
            </h4>
            <p className="text-as-secondary/70 text-base mb-10 leading-relaxed font-light">
              Dive into high-yield questions designed for conceptual mastery.
            </p>
            <div className="flex items-center gap-3 text-as-primary font-bold text-sm uppercase tracking-widest opacity-80 group-hover:opacity-100 transition-opacity">
              <span>Access Bank</span>
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
              </svg>
            </div>
          </div>
        </Link>

        {/* Course Lessons */}
        <Link href="/dashboard/lessons" className="lg:col-span-1 group cursor-pointer block">
          <div className="harvey-card h-full p-8 sm:p-10 rounded-[2rem] sm:rounded-[2.5rem]">
            <div className="w-14 h-14 bg-as-surface-container-low border border-as-on-surface/[0.04] rounded-2xl flex items-center justify-center mb-10 group-hover:bg-as-primary-container group-hover:text-white transition-all duration-500">
              <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
              </svg>
            </div>
            <h4 className="font-headline text-2xl sm:text-3xl text-as-on-surface mb-4">
              Curated Modules
            </h4>
            <p className="text-as-secondary/70 text-base mb-10 leading-relaxed font-light">
              Structured video lectures and clinical breakdowns of complex topics.
            </p>
            <div className="flex items-center gap-3 text-as-primary font-bold text-sm uppercase tracking-widest opacity-80 group-hover:opacity-100 transition-opacity">
              <span>Explore modules</span>
              <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
              </svg>
            </div>
          </div>
        </Link>

        {/* Subject Mastery */}
        <div className="lg:col-span-1 harvey-card p-8 sm:p-10 rounded-[2rem] sm:rounded-[2.5rem]">
          <h4 className="font-headline text-2xl text-as-on-surface mb-8">Subject Mastery</h4>
          <div className="space-y-10">
            {subjectProgress.length > 0 ? (
              subjectProgress.map((subject) => (
                <div key={subject.label} className="space-y-3">
                  <div className="flex justify-between items-end">
                    <span className="text-sm font-medium tracking-[0.015em] opacity-60 italic">
                      {subject.label}
                    </span>
                    <span className="text-sm font-bold tracking-[0.015em]">
                      {subject.percent}%
                    </span>
                  </div>
                  <div className="h-[1px] w-full bg-as-on-surface/5">
                    <div
                      className="h-full bg-as-primary-container transition-all duration-700"
                      style={{ width: `${subject.percent}%` }}
                    />
                  </div>
                </div>
              ))
            ) : (
              <p className="text-sm text-as-secondary/50 italic">
                Complete practice questions to see your progress here.
              </p>
            )}
          </div>
        </div>
      </section>

      {/* Elite Access Banner */}
      {profile?.subscription_tier === "free" && (
        <section className="harvey-card p-8 sm:p-12 rounded-[2rem] sm:rounded-[2.5rem] border border-as-primary/10 flex flex-col md:flex-row items-center justify-between gap-8 sm:gap-12">
          <div className="flex flex-col sm:flex-row items-center gap-6 sm:gap-10">
            <div className="w-16 h-16 rounded-full bg-as-primary/5 flex items-center justify-center text-as-primary shrink-0">
              <svg className="w-8 h-8" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z" />
              </svg>
            </div>
            <div className="text-center sm:text-left">
              <h4 className="font-headline text-2xl sm:text-3xl text-as-on-surface mb-2">
                Elevate your scholarship
              </h4>
              <p className="text-as-secondary/70 text-base sm:text-lg font-light">
                Access simulated exams and advanced predictive analytics.
              </p>
            </div>
          </div>
          <Link
            href="/pricing"
            className="whitespace-nowrap px-10 py-4 border border-as-primary text-as-primary hover:bg-as-primary-container hover:text-white rounded-full font-semibold transition-all duration-500 tracking-[0.015em]"
          >
            Explore Elite Plans
          </Link>
        </section>
      )}
    </div>
  );
}
