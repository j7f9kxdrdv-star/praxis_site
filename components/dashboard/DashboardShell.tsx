"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
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
      await fetchProfile(user.id);
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
        refreshProfile: () => fetchProfile(user.id),
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
