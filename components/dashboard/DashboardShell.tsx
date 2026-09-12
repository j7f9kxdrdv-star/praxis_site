"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { detectTimezone } from "@/lib/flashcards/studyDay";
import type { User } from "@supabase/supabase-js";
import Sidebar from "./Sidebar";
import BottomTabs from "./BottomTabs";

interface Profile {
  id: string;
  first_name: string | null;
  last_name: string | null;
  email: string | null;
  subscription_tier: string;
  mcat_test_date: string | null;
  study_hours_per_week: number | null;
  weak_sections: string[] | null;
  onboarding_completed: boolean;
  is_admin: boolean;
  daily_new_card_limit: number;
  daily_review_limit: number;
  weekly_question_goal: number | null;
  /** Score the student is aiming for, 472-528. Null when unset. */
  target_mcat_score: number | null;
  /** IANA name. Null until the browser has reported one. */
  timezone: string | null;
  /** Local hour the study day rolls over. 4 by default, so a session running
   *  past midnight stays on one study day. */
  day_start_hour: number;
}

interface DashboardContext {
  user: User;
  profile: Profile | null;
  refreshProfile: () => Promise<void>;
}

import { createContext, useContext } from "react";

export const DashboardCtx = createContext<DashboardContext | null>(null);

export function useDashboard() {
  const ctx = useContext(DashboardCtx);
  if (!ctx) throw new Error("useDashboard must be used within DashboardShell");
  return ctx;
}

export default function DashboardShell({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);

  async function fetchProfile(userId: string) {
    const { data } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", userId)
      .single();
    setProfile(data);

    // Record the browser's timezone once. PR2 moves scheduling to the server,
    // which cannot ask the client what day it is — so the profile has to carry
    // it. Written only when it is missing or has actually changed (a student
    // who travels), so this is not a write on every page load.
    if (data) {
      const tz = detectTimezone();
      if (tz && data.timezone !== tz) {
        await supabase.from("profiles").update({ timezone: tz }).eq("id", userId);
      }
    }

    return data as Profile | null;
  }

  useEffect(() => {
    async function init() {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.push("/login");
        return;
      }

      setUser(user);
      const loaded = await fetchProfile(user.id);

      // ── The onboarding gate ──────────────────────────────────────────
      //
      // onboarding_completed is written at the end of /onboarding, including
      // when the student skips it: being asked once is the point, and asking
      // twice is nagging. Until this landed the column had never been read or
      // written by anything, so its values were arbitrary; the migration in
      // supabase/migrations/20260911_onboarding_gate.sql resets it for anyone
      // who has not actually answered.
      //
      // replace(), not push(), so Back from the flow does not land on a
      // dashboard that will only bounce them here again. /onboarding sits
      // outside this shell, so there is no loop to fall into.
      if (loaded && !loaded.onboarding_completed) {
        router.replace("/onboarding");
        return;
      }

      setLoading(false);
    }

    init();
  }, [router]);

  if (loading) {
    return (
      <div className="min-h-screen bg-as-surface flex items-center justify-center font-body">
        <div className="text-center">
          <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-sm text-as-secondary">Loading your dashboard...</p>
        </div>
      </div>
    );
  }

  if (!user) return null;

  return (
    <DashboardCtx.Provider
      value={{
        user,
        profile,
        refreshProfile: async () => {
          await fetchProfile(user.id);
        },
      }}
    >
      <div className="min-h-screen bg-as-surface-container-low font-body text-as-on-surface flex">
        <Sidebar />
        <main className="flex-1 pb-16 lg:pb-0 lg:px-16 lg:py-16 max-w-[1440px]">{children}</main>
        <BottomTabs />
      </div>
    </DashboardCtx.Provider>
  );
}
