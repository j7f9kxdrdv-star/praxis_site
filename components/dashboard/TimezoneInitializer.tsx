"use client";

// ─── Telling the server where the learner is, once ──────────────────────────
//
// profiles.timezone decides when a learner's study day starts, and until now
// nothing ever wrote it: five of nine live profiles are NULL and every OAuth
// signup would stay that way, because an account created through a provider
// callback has no browser metadata to carry.
//
// So this fills the gap the signup form cannot reach. It runs once on an
// authenticated dashboard load, and only when the stored timezone is NULL.
//
// IT INITIALISES; IT DOES NOT TRACK. A learner who lives in New York and
// spends three days in California must not have their study-day boundary
// silently redefined because the browser reported America/Los_Angeles on
// Tuesday. Their days would shift under them, their streak could break, and
// once history exists their past would be relabelled by a trip.
//
// The rule is therefore: NULL may be initialised, a stored value is never
// overwritten. Changing it later is a deliberate act, not a side effect of
// opening a laptop somewhere else.
//
// RACE-SAFE BY CONSTRUCTION. Two tabs can both load and both detect. The write
// carries `.is("timezone", null)`, so the second one matches no rows and does
// nothing — the values cannot oscillate, and nothing needs to coordinate.

import { useEffect } from "react";
import { supabase } from "@/lib/supabase";
import { detectTimezone, isValidTimezone } from "@/lib/flashcards/studyDay";

export default function TimezoneInitializer() {
  useEffect(() => {
    let cancelled = false;

    (async () => {
      const zone = detectTimezone();
      // A browser that cannot name its zone, or names one the shared helper
      // does not recognise, contributes nothing rather than something wrong.
      if (!isValidTimezone(zone)) return;

      const { data: auth } = await supabase.auth.getUser();
      const userId = auth?.user?.id;
      if (!userId || cancelled) return;

      const { data: profile } = await supabase
        .from("profiles").select("timezone").eq("id", userId).maybeSingle();
      // Already known. Nothing to do, and nothing to overwrite.
      if (cancelled || profile?.timezone != null) return;

      // `.is("timezone", null)` is the whole concurrency story: the update
      // matches nothing once any tab has won, so this is idempotent without a
      // lock. The server validates the value again regardless of what a client
      // sends, and row-level security confines the write to this learner's own
      // row.
      const { error } = await supabase
        .from("profiles").update({ timezone: zone }).eq("id", userId).is("timezone", null);

      // A failure here is not worth interrupting anyone over: the runtime has
      // a documented UTC fallback and the next load tries again.
      if (error) console.warn("[timezone] could not initialise:", error.message);
    })();

    return () => { cancelled = true; };
  }, []);

  return null;
}
