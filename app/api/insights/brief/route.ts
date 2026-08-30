import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { computeBrief } from "@/lib/insights/computeBrief";
import { studyDayKey, DEFAULT_DAY_START_HOUR } from "@/lib/flashcards/studyDay";

/**
 * GET /api/insights/brief   — the student's Tier 1 brief for today.
 * GET /api/insights/brief?refresh=1 — recompute even if today's is cached.
 *
 * Identity comes from the caller's own token and the Supabase client is built
 * WITH it, so every statement runs as that user under row-level security. A
 * student cannot read anyone else's brief, and cannot ask for one.
 */
export async function GET(req: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    return NextResponse.json({ error: "Server is not configured." }, { status: 500 });
  }

  const authHeader = req.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) return NextResponse.json({ error: "Not signed in." }, { status: 401 });

  const supabase = createClient(url, anonKey, {
    global: { headers: { Authorization: `Bearer ${token}` } },
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: userData, error: userErr } = await supabase.auth.getUser();
  if (userErr || !userData?.user) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }
  const userId = userData.user.id;

  const { data: prof } = await supabase
    .from("profiles")
    .select("day_start_hour")
    .eq("id", userId)
    .maybeSingle();
  const dayStartHour = prof?.day_start_hour ?? DEFAULT_DAY_START_HOUR;
  const today = studyDayKey(new Date(), dayStartHour);
  const refresh = req.nextUrl.searchParams.get("refresh") === "1";

  if (!refresh) {
    const { data: cached } = await supabase
      .from("user_insight_briefs")
      .select("brief")
      .eq("user_id", userId)
      .eq("study_day", today)
      .maybeSingle();
    if (cached?.brief) {
      return NextResponse.json({ ...cached.brief, cached: true });
    }
  }

  let brief;
  try {
    brief = await computeBrief(supabase, userId, dayStartHour);
  } catch (e) {
    return NextResponse.json(
      { error: e instanceof Error ? e.message : "Could not build your brief." },
      { status: 500 },
    );
  }

  // A failed cache write must not fail the request: the student still gets the
  // brief, it is just recomputed next time.
  await supabase
    .from("user_insight_briefs")
    .upsert(
      { user_id: userId, study_day: today, brief, generated_at: new Date().toISOString() },
      { onConflict: "user_id,study_day" },
    );

  return NextResponse.json({ ...brief, cached: false });
}
