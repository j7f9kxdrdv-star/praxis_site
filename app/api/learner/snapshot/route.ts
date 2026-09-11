import { NextRequest, NextResponse } from "next/server";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { buildSnapshot, deriveEvents, type LearnerSnapshot } from "@/lib/learner/snapshot";
import { recentProgress, progressSignals } from "@/lib/learner/recentProgress";
import { studyDayKey, DEFAULT_DAY_START_HOUR } from "@/lib/flashcards/studyDay";

/**
 * GET /api/learner/snapshot            today's learner state and recent progress
 * GET /api/learner/snapshot?rebuild=1  recompute today even if it is stored
 *
 * Computes the student's state for the current study day, stores it, derives
 * the events since the previous snapshot, and stores those too. Then answers
 * with the state plus a Recent Progress reading over the last seven days.
 *
 * SAFE TO CALL REPEATEDLY. The snapshot is keyed on (user_id, study_day) and
 * every event carries a dedupe_key built from its own facts, so calling this
 * five times in a morning writes one snapshot and one copy of each event.
 *
 * Identity comes from the caller's token and the Supabase client is built WITH
 * it, so every statement runs as that user under row-level security.
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
  // THE CURRENT DAY IS MUTABLE. PAST DAYS ARE NOT.
  //
  // The first version of this returned today's stored snapshot whenever one
  // existed, which meant a student who studied at 8am and again at 6pm still
  // had the 8am state all evening: the snapshot recorded when it was first
  // built rather than what was true. Today is therefore always recomputed and
  // upserted, and only closed days are read as written.
  //
  // The cost is one page of attempts and one of questions, roughly five
  // queries. The expensive part of learner state is the flashcard simulation,
  // and this route does not do it.
  //
  // ?cached=1 opts into the stored row for callers that want speed over
  // freshness and can tolerate a snapshot from earlier in the same day.
  const preferCached = req.nextUrl.searchParams.get("cached") === "1";

  // ── The most recent snapshot BEFORE today, which is what today is compared
  // against. Today's own row is skipped so a rebuild does not diff against
  // itself and find nothing.
  const { data: prevRows } = await supabase
    .from("learner_state_snapshots")
    .select("study_day, state")
    .eq("user_id", userId)
    .lt("study_day", today)
    .order("study_day", { ascending: false })
    .limit(1);
  const previous = (prevRows?.[0]?.state as LearnerSnapshot | undefined) ?? null;

  if (preferCached) {
    const { data: existing } = await supabase
      .from("learner_state_snapshots")
      .select("state")
      .eq("user_id", userId)
      .eq("study_day", today)
      .maybeSingle();
    if (existing?.state) {
      return NextResponse.json({
        snapshot: existing.state,
        progress: await buildProgress(supabase, userId, existing.state as LearnerSnapshot, previous),
        cached: true,
      });
    }
  }

  // ── Evidence ──────────────────────────────────────────────────────────
  const attempts: {
    question_id: string;
    is_correct: boolean;
    created_at: string;
    is_first_attempt: boolean | null;
  }[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await supabase
      .from("question_attempts")
      .select("question_id, is_correct, created_at, is_first_attempt")
      .eq("user_id", userId)
      .order("created_at", { ascending: true })
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error) return NextResponse.json({ error: error.message }, { status: 500 });
    if (!data.length) break;
    attempts.push(...data);
    if (data.length < 1000) break;
  }

  const questions: { id: string; section: string; topic: string | null }[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await supabase
      .from("questions")
      .select("id, section, topic")
      .is("passage_id", null)
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error) return NextResponse.json({ error: error.message }, { status: 500 });
    if (!data.length) break;
    questions.push(...data);
    if (data.length < 1000) break;
  }
  const byId = new Map(questions.map((q) => [q.id, q]));

  // First attempts only. A repeat measures memory of that question, not the
  // skill, and the same rule gates the score predictor and the analytics page.
  const eligible = attempts
    .filter((a) => a.is_first_attempt !== false)
    .map((a) => ({ ...a, q: byId.get(a.question_id) }))
    .filter((a) => a.q);

  const snapshot = buildSnapshot({
    studyDay: today,
    attempts: eligible.map((a) => ({
      topic: a.q!.topic,
      section: a.q!.section,
      isCorrect: a.is_correct,
    })),
    recentAccuracy: recentPct(eligible.slice(-100)),
    recentSampleSize: Math.min(100, eligible.length),
    coverageAttempted: new Set(attempts.map((a) => a.question_id)).size,
    coverageTotal: questions.length,
    memoryHealth: null,
    previous,
  });

  const { error: snapErr } = await supabase.from("learner_state_snapshots").upsert(
    {
      user_id: userId,
      study_day: today,
      state: snapshot,
      calculation_version: snapshot.version,
      generated_at: new Date().toISOString(),
    },
    { onConflict: "user_id,study_day" },
  );
  if (snapErr) return NextResponse.json({ error: snapErr.message }, { status: 500 });

  // ── Events, deduped on the way in ─────────────────────────────────────
  const events = deriveEvents(previous, snapshot);
  if (events.length > 0) {
    const { error: evErr } = await supabase.from("learner_events").upsert(
      events.map((e) => ({
        user_id: userId,
        type: e.type,
        occurred_on: e.occurredOn,
        subject_kind: e.subjectKind,
        subject_id: e.subjectId,
        previous_value: e.previousValue,
        new_value: e.newValue,
        metadata: e.metadata,
        calculation_version: e.calculationVersion,
        dedupe_key: e.dedupeKey,
      })),
      { onConflict: "user_id,dedupe_key" },
    );
    // A failed event write must not fail the request: the snapshot is the
    // record of truth and the events can be rebuilt from it at any time.
    if (evErr) console.error("learner_events upsert failed:", evErr.message);
  }

  return NextResponse.json({
    snapshot,
    events,
    progress: await buildProgress(supabase, userId, snapshot, previous),
    cached: false,
  });
}

function recentPct(rows: { is_correct: boolean }[]): number | null {
  if (rows.length === 0) return null;
  return Math.round((rows.filter((r) => r.is_correct).length / rows.length) * 100);
}

/**
 * Recent Progress over the last seven days.
 *
 * Topics improved and priorities resolved are COUNTED FROM STORED EVENTS rather
 * than recomputed here, so a transition is counted once however many times this
 * route runs.
 */
async function buildProgress(
  supabase: SupabaseClient,
  userId: string,
  current: LearnerSnapshot,
  previous: LearnerSnapshot | null,
) {
  const now = Date.now();
  const startIso = new Date(now - 7 * 86_400_000).toISOString();
  const prevStartIso = new Date(now - 14 * 86_400_000).toISOString();
  const startDay = startIso.slice(0, 10);

  const { data: recent } = await supabase
    .from("question_attempts")
    .select("is_correct, created_at, is_first_attempt")
    .eq("user_id", userId)
    .gte("created_at", prevStartIso);

  const rows = (recent ?? []) as {
    is_correct: boolean;
    created_at: string;
    is_first_attempt: boolean | null;
  }[];
  const eligible = rows.filter((r) => r.is_first_attempt !== false);
  const cur = eligible.filter((r) => r.created_at >= startIso);
  const prev = eligible.filter((r) => r.created_at < startIso);

  const { count: improved } = await supabase
    .from("learner_events")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("type", "TOPIC_PERFORMANCE_IMPROVED")
    .gte("occurred_on", startDay);

  const { count: resolved } = await supabase
    .from("learner_events")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("type", "PRIORITY_TOPIC_RESOLVED")
    .gte("occurred_on", startDay);

  const { data: cardRows } = await supabase
    .from("flashcard_reviews")
    .select("flashcard_id, cloze_index")
    .eq("user_id", userId)
    .gte("reviewed_at", startIso);

  const { count: lessons } = await supabase
    .from("lesson_progress")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .eq("completed", true)
    .gte("completed_at", startIso);

  const p = recentProgress({
    periodStart: startDay,
    periodEnd: current.studyDay,
    currentCorrect: cur.filter((r) => r.is_correct).length,
    currentN: cur.length,
    previousCorrect: prev.filter((r) => r.is_correct).length,
    previousN: prev.length,
    questionsCompleted: rows.filter((r) => r.created_at >= startIso).length,
    cardsReviewed: new Set(
      (cardRows ?? []).map(
        (r) => `${(r as { flashcard_id: string }).flashcard_id}:${(r as { cloze_index: number }).cloze_index}`,
      ),
    ).size,
    lessonsCompleted: lessons ?? 0,
    coverageAtStart: previous?.coveragePercent ?? current.coveragePercent,
    coverageAtEnd: current.coveragePercent,
    topicsImproved: improved ?? 0,
    priorityAreasResolved: resolved ?? 0,
  });

  return { ...p, signals: progressSignals(p) };
}
