import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { nextSchedule, EASE_DEFAULT, type Rating } from "@/lib/flashcards/scheduler";

/**
 * The single write path for a flashcard review.
 *
 * POST /api/flashcards/review
 *   { flashcardId, clozeIndex, rating, source, clientRequestId }
 *
 * WHY THIS EXISTS. Until now the browser computed a card's next schedule and
 * wrote it directly, in two unchecked statements that could half-succeed. The
 * phone did the same thing with its own copy of the code, and the two copies
 * had already drifted: quota.ts differed by 88 lines between the repos, so the
 * two apps computed different daily limits against one database.
 *
 * WHAT MOVES HERE. The scheduling decision. The route loads the card's current
 * state SERVER-SIDE, so the client cannot claim a card is at an interval it is
 * not, then hands the computed values to a Postgres function that writes the
 * scheduling row, the review log and the study-day credit in one transaction.
 *
 * WHAT DELIBERATELY DOES NOT MOVE. The scheduling MATHS is unchanged: this
 * calls the same v2 ladder the client called. PR2 changes where the
 * computation happens, not what it computes, which is what makes the move
 * verifiable — identical inputs must produce identical schedules.
 *
 * WHEN FSRS ARRIVES (PR6) it replaces the nextSchedule call below and nothing
 * else. One file, one function, both apps.
 */

interface ReviewBody {
  flashcardId?: string;
  clozeIndex?: number;
  rating?: string;
  source?: string;
  clientRequestId?: string;
}

const RATINGS = ["again", "hard", "medium", "easy"] as const;
const SOURCES = ["daily_review", "extra_study", "starred", "deck_all"] as const;
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export async function POST(req: NextRequest) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    return NextResponse.json({ error: "Server is not configured." }, { status: 500 });
  }

  // Identity comes from the caller's own session token, never from the body.
  // The Supabase client is created WITH that token, so every statement runs as
  // that user and row-level security still applies — this endpoint cannot be
  // used to touch somebody else's cards.
  const authHeader = req.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }

  const supabase = createClient(url, anonKey, {
    global: { headers: { Authorization: `Bearer ${token}` } },
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const { data: userData, error: userErr } = await supabase.auth.getUser();
  if (userErr || !userData?.user) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }
  const userId = userData.user.id;

  let body: ReviewBody;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request body." }, { status: 400 });
  }

  const flashcardId = String(body.flashcardId ?? "");
  const clozeIndex = Number(body.clozeIndex);
  const rating = String(body.rating ?? "") as Rating;
  const source = String(body.source ?? "daily_review");
  const clientRequestId = String(body.clientRequestId ?? "");

  if (!UUID_RE.test(flashcardId)) {
    return NextResponse.json({ error: "Invalid flashcardId." }, { status: 400 });
  }
  if (!Number.isInteger(clozeIndex) || clozeIndex < 0 || clozeIndex > 64) {
    return NextResponse.json({ error: "Invalid clozeIndex." }, { status: 400 });
  }
  if (!RATINGS.includes(rating as (typeof RATINGS)[number])) {
    return NextResponse.json({ error: "Invalid rating." }, { status: 400 });
  }
  if (!SOURCES.includes(source as (typeof SOURCES)[number])) {
    return NextResponse.json({ error: "Invalid source." }, { status: 400 });
  }
  if (!UUID_RE.test(clientRequestId)) {
    return NextResponse.json({ error: "Invalid clientRequestId." }, { status: 400 });
  }

  // Load the card's CURRENT state here rather than accepting it from the
  // client. A client-supplied interval could be stale (a second tab, a phone
  // mid-session) or simply invented.
  const { data: state, error: stateErr } = await supabase
    .from("flashcard_user_state")
    .select("interval_days, ease_factor, reps, lapses, last_rating")
    .eq("user_id", userId)
    .eq("flashcard_id", flashcardId)
    .eq("cloze_index", clozeIndex)
    .maybeSingle();

  if (stateErr) {
    return NextResponse.json({ error: "Could not load card state." }, { status: 500 });
  }

  const prevInterval = Number(state?.interval_days ?? 0);
  const sched = nextSchedule({
    rating,
    intervalDays: prevInterval,
    easeFactor: Number(state?.ease_factor ?? EASE_DEFAULT),
    reps: state?.reps ?? 0,
    lapses: state?.lapses ?? 0,
    lastRating: (state?.last_rating ?? null) as Rating | null,
  });

  const { data, error } = await supabase.rpc("submit_flashcard_review", {
    p_flashcard_id: flashcardId,
    p_cloze_index: clozeIndex,
    p_rating: rating,
    p_prev_interval: prevInterval,
    p_new_interval: sched.intervalDays,
    p_ease_factor: sched.easeFactor,
    p_reps: sched.reps,
    p_lapses: sched.lapses,
    p_next_review_at: sched.nextReviewAt.toISOString(),
    p_source: source,
    p_is_first_exposure: !state,
    p_client_request_id: clientRequestId,
  });

  if (error) {
    // Surfaced deliberately. The old client path ignored write errors entirely,
    // which is how 204 card-blanks ended up with a schedule that disagrees with
    // their review log.
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  const row = Array.isArray(data) ? data[0] : data;
  return NextResponse.json({
    intervalDays: row?.interval_days ?? sched.intervalDays,
    easeFactor: row?.ease_factor ?? sched.easeFactor,
    reps: row?.reps ?? sched.reps,
    lapses: row?.lapses ?? sched.lapses,
    nextReviewAt: row?.next_review_at ?? sched.nextReviewAt.toISOString(),
    // True when this exact attempt had already been recorded, so the client
    // knows the write was collapsed rather than applied twice.
    duplicate: row?.was_duplicate ?? false,
  });
}
