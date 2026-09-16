/**
 * Flashcard analytics for one window.
 *
 * WHAT THIS REPLACES. The analytics page fetched every review the student had
 * ever logged so the browser could count them. On the largest real account that
 * is 42,553 rows and roughly 3.7 MB of JSON, sent to render a four-bar chart
 * and two percentages. This returns about two kilobytes, and it stays about two
 * kilobytes however long the account lives, because the response is bounded by
 * topics touched rather than reviews logged.
 *
 * IT ALSO READS LESS. The window plus one session gap, not the whole history:
 * a review more than thirty minutes before the window cannot change whether
 * anything inside it was a first look. See lib/analytics/flashcardAggregate.ts
 * for why that margin is sufficient and why it is necessary.
 *
 * Identity comes from the caller's token and the client is built WITH it, so
 * every statement runs as that user under row-level security. A student cannot
 * ask this endpoint about anyone else.
 */
import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import {
  aggregateFlashcards,
  lookbackIso,
  type AggregateReview,
  type Rating,
} from "@/lib/analytics/flashcardAggregate";
import { canonicalTopicKey } from "@/lib/analytics/topicKey";
import {
  resolveDeckSection,
  type McatSection,
  type SectionResolution,
} from "@/lib/analytics/sectionMap";

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

  // An open-ended window is the "All time" preset, not an error.
  const params = req.nextUrl.searchParams;
  const fromIso = params.get("from") || new Date(0).toISOString();
  const toIso = params.get("to") || new Date().toISOString();
  const section = params.get("section") || "all";
  if (Number.isNaN(Date.parse(fromIso)) || Number.isNaN(Date.parse(toIso))) {
    return NextResponse.json({ error: "Invalid range." }, { status: 400 });
  }

  // Which MCAT section does each canonical topic belong to? Read from the
  // QUESTION bank, so the flashcard series is filtered by the same authority
  // the question series uses rather than by a guess. See sectionMap.ts.
  const topicSections = new Map<string, McatSection>();
  if (section !== "all") {
    for (let from = 0; ; from += 1000) {
      const { data, error } = await supabase
        .from("questions")
        .select("section, topic")
        .order("id", { ascending: true })
        .range(from, from + 999);
      if (error || !data || data.length === 0) break;
      for (const q of data as { section: string; topic: string | null }[]) {
        const k = canonicalTopicKey(q.topic);
        if (k && !topicSections.has(k)) topicSections.set(k, q.section as McatSection);
      }
      if (data.length < 1000) break;
    }
  }

  // Card to deck to canonical topic. Both tables are small and shared, so this
  // is the cheap half of the request.
  const deckKey = new Map<string, string>();
  const deckSection = new Map<string, SectionResolution>();
  for (let from = 0; ; from += 1000) {
    const { data, error } = await supabase
      .from("flashcard_decks")
      .select("id, subtopic, section")
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error || !data || data.length === 0) break;
    for (const d of data as { id: string; subtopic: string | null; section: string | null }[]) {
      const key = canonicalTopicKey(d.subtopic);
      deckKey.set(d.id, key);
      deckSection.set(d.id, resolveDeckSection(d.section, key, topicSections));
    }
    if (data.length < 1000) break;
  }

  const cardKey = new Map<string, string | null>();
  const cardSection = new Map<string, string | null>();
  for (let from = 0; ; from += 1000) {
    const { data, error } = await supabase
      .from("flashcards")
      .select("id, deck_id")
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error || !data || data.length === 0) break;
    for (const c of data as { id: string; deck_id: string }[]) {
      cardKey.set(c.id, deckKey.get(c.deck_id) || null);
      cardSection.set(c.id, deckSection.get(c.deck_id)?.section ?? null);
    }
    if (data.length < 1000) break;
  }

  // The window plus one session gap. Paged, because a heavy week can still
  // exceed a thousand rows even though a lifetime no longer has to be read.
  const reviews: AggregateReview[] = [];
  const start = lookbackIso(fromIso);
  for (let from = 0; ; from += 1000) {
    const { data, error } = await supabase
      .from("flashcard_reviews")
      .select("flashcard_id, cloze_index, rating, reviewed_at")
      .eq("user_id", userId)
      .gte("reviewed_at", start)
      .lte("reviewed_at", toIso)
      // A stable order or pages overlap and skip.
      .order("reviewed_at", { ascending: true })
      .order("flashcard_id", { ascending: true })
      .range(from, from + 999);
    if (error) {
      return NextResponse.json({ error: "Could not read reviews." }, { status: 500 });
    }
    if (!data || data.length === 0) break;
    for (const r of data as {
      flashcard_id: string;
      cloze_index: number;
      rating: Rating;
      reviewed_at: string;
    }[]) {
      reviews.push({
        flashcardId: r.flashcard_id,
        clozeIndex: r.cloze_index,
        rating: r.rating,
        reviewedAt: r.reviewed_at,
        topicKey: cardKey.get(r.flashcard_id) ?? null,
        section: cardSection.get(r.flashcard_id) ?? null,
      });
    }
    if (data.length < 1000) break;
  }

  return NextResponse.json(aggregateFlashcards({ reviews, fromIso, toIso, section }), {
    // Re-read on a range change, but not on every re-render of the page.
    headers: { "Cache-Control": "private, max-age=30" },
  });
}
