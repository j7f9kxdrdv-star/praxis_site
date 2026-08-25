import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { EASE_DEFAULT, type Rating } from "@/lib/flashcards/scheduler";
import { nextFsrsSchedule, type StoredState } from "@/lib/flashcards/fsrsScheduler";
import { DEFAULT_DAY_START_HOUR, startOfStudyDay } from "@/lib/flashcards/studyDay";

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
 * PR6 SWAPPED THE MATHS. The v2 ladder is gone from this path; scheduling is
 * now FSRS, in lib/flashcards/fsrsScheduler.ts. That it was a one-line change
 * here is the point of having done PR2 first: there is exactly one place in
 * either app where a schedule is decided, so replacing the algorithm touched
 * no client code at all.
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

  // The student's own day boundary. The server owns the study day now, so it
  // cannot assume the default here.
  const { data: prof } = await supabase
    .from("profiles")
    .select("day_start_hour")
    .eq("id", userId)
    .maybeSingle();
  const dayStartHour = prof?.day_start_hour ?? DEFAULT_DAY_START_HOUR;

  // Load the card's CURRENT state here rather than accepting it from the
  // client. A client-supplied interval could be stale (a second tab, a phone
  // mid-session) or simply invented.
  const { data: state, error: stateErr } = await supabase
    .from("flashcard_user_state")
    // One string literal, not a concatenation: the Supabase client infers the
    // row type from the literal, and splitting it across lines erases that.
    .select("interval_days, ease_factor, reps, lapses, last_rating, last_reviewed_at, next_review_at, stability, difficulty, fsrs_state, learning_steps, scheduled_days")
    .eq("user_id", userId)
    .eq("flashcard_id", flashcardId)
    .eq("cloze_index", clozeIndex)
    .maybeSingle();

  if (stateErr) {
    return NextResponse.json({ error: "Could not load card state." }, { status: 500 });
  }

  const prevInterval = Number(state?.interval_days ?? 0);
  const now = new Date();

  const stored: StoredState | null = state
    ? {
        stability: state.stability === null ? null : Number(state.stability),
        difficulty: state.difficulty === null ? null : Number(state.difficulty),
        fsrsState: state.fsrs_state === null ? null : Number(state.fsrs_state),
        learningSteps: state.learning_steps === null ? null : Number(state.learning_steps),
        scheduledDays: state.scheduled_days === null ? null : Number(state.scheduled_days),
        reps: state.reps ?? 0,
        lapses: state.lapses ?? 0,
        intervalDays: prevInterval,
        lastReviewedAt: state.last_reviewed_at ? new Date(state.last_reviewed_at) : null,
        nextReviewAt: state.next_review_at ? new Date(state.next_review_at) : null,
      }
    : null;

  const computed = nextFsrsSchedule(stored, rating, now);

  // ── The same-day evidence rule ────────────────────────────────────────
  //
  // Retrieving a card you saw minutes ago proves almost nothing about whether
  // you will still know it next week. Measured against ts-fsrs 5.4.1 with its
  // default settings: twenty Easy ratings one minute apart on a single card
  // produce 1,222 days of stability — 48% of what YEARS of properly spaced
  // review would earn, from nineteen minutes of tapping.
  //
  // So a repeat retrieval of an already-passed, matured card within the same
  // study day is RECORDED but does not advance the schedule.
  //
  // This is an evidence rule, not an Extra Study penalty. It keys on elapsed
  // time, never on which page the student was on, exactly as the spec
  // requires: a genuine retrieval is a genuine retrieval regardless of mode.
  //
  // Three things it must NOT block, and does not:
  //   . a brand-new card being learned (no state row yet);
  //   . the 10-minute re-show after "Again" (that card's stored last_rating IS
  //     "again", and its post-lapse confirmation is the whole point);
  //   . a card genuinely due again today after a real interval.
  const lastReviewedAt = stored?.lastReviewedAt ?? null;
  const sameStudyDay =
    lastReviewedAt !== null && lastReviewedAt >= startOfStudyDay(now, dayStartHour);
  const isMature = prevInterval >= 1;
  const isPostLapseRecheck = state?.last_rating === "again";
  const advance = !(sameStudyDay && isMature && !isPostLapseRecheck);

  // When the schedule is held, write back exactly what the card already had,
  // so the row is unchanged while the attempt is still logged.
  const sched = advance
    ? computed
    : {
        ...computed,
        // Every scheduling field reverts to what the card already had. Only
        // reps and lapses are allowed through, because the attempt did happen.
        stability: stored?.stability ?? computed.stability,
        difficulty: stored?.difficulty ?? computed.difficulty,
        fsrsState: stored?.fsrsState ?? computed.fsrsState,
        learningSteps: stored?.learningSteps ?? computed.learningSteps,
        scheduledDays: stored?.scheduledDays ?? computed.scheduledDays,
        intervalDays: prevInterval,
        nextReviewAt: new Date(state!.next_review_at as string),
      };

  const { data, error } = await supabase.rpc("submit_flashcard_review", {
    p_flashcard_id: flashcardId,
    p_cloze_index: clozeIndex,
    p_rating: rating,
    p_prev_interval: prevInterval,
    p_new_interval: sched.intervalDays,
    p_ease_factor: Number(state?.ease_factor ?? EASE_DEFAULT),
    p_reps: sched.reps,
    p_lapses: sched.lapses,
    p_next_review_at: sched.nextReviewAt.toISOString(),
    p_source: source,
    p_is_first_exposure: !state,
    p_client_request_id: clientRequestId,
    p_stability: sched.stability,
    p_difficulty: sched.difficulty,
    p_fsrs_state: sched.fsrsState,
    p_learning_steps: sched.learningSteps,
    p_scheduled_days: sched.scheduledDays,
  });

  if (error) {
    // Surfaced deliberately. The old client path ignored write errors entirely,
    // which is how 204 card-blanks ended up with a schedule that disagrees with
    // their review log.
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  const row = Array.isArray(data) ? data[0] : data;
  return NextResponse.json({
    // True when this retrieval was recorded but deliberately did not move the
    // schedule, because the card was already answered earlier the same day.
    scheduleHeld: !advance,
    intervalDays: row?.interval_days ?? sched.intervalDays,
    // Vestigial: FSRS does not use it, but it is still returned so any
    // client reading it keeps working until they are all updated.
    easeFactor: row?.ease_factor ?? EASE_DEFAULT,
    reps: row?.reps ?? sched.reps,
    lapses: row?.lapses ?? sched.lapses,
    nextReviewAt: row?.next_review_at ?? sched.nextReviewAt.toISOString(),
    stability: row?.stability ?? sched.stability,
    difficulty: row?.difficulty ?? sched.difficulty,
    // True when this exact attempt had already been recorded, so the client
    // knows the write was collapsed rather than applied twice.
    duplicate: row?.was_duplicate ?? false,
  });
}
