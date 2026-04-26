"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { isLive } from "@/lib/launch-mode";
import ComingSoon from "@/components/ComingSoon";
import MarketingHome from "@/components/MarketingHome";

/**
 * Public homepage dispatcher.
 *
 * Picks one of two views based on the site's launch mode + the visitor's
 * auth state:
 *
 *   live   + (authed or not) -> MarketingHome   (auth-aware CTAs)
 *   preview + authed         -> MarketingHome   (founder bypass)
 *   preview + not authed     -> ComingSoon      (waitlist gate)
 *
 * To open the gate to the public, set NEXT_PUBLIC_LAUNCH_MODE=live in
 * Vercel and redeploy. See lib/launch-mode.ts.
 */
export default function HomeRouter() {
  const live = isLive();
  const [authChecked, setAuthChecked] = useState(false);
  const [authed, setAuthed] = useState(false);

  useEffect(() => {
    // In live mode the page is public; we still check session so the
    // marketing CTAs can route a logged-in visitor straight to /dashboard
    // instead of bouncing them through /login.
    let cancelled = false;
    supabase.auth.getSession().then(({ data }) => {
      if (cancelled) return;
      setAuthed(!!data.session);
      setAuthChecked(true);
    });
    return () => {
      cancelled = true;
    };
  }, []);

  // While we're checking auth, render nothing — keeps the page from briefly
  // flashing the wrong view (especially the coming-soon page for someone
  // who's actually logged in).
  if (!authChecked) return null;

  if (live) {
    return <MarketingHome />;
  }
  // preview mode
  return authed ? <MarketingHome /> : <ComingSoon />;
}
