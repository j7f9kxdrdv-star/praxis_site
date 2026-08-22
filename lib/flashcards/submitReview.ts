// ─── Client-side wrapper for the one review write path ───────────────────────
//
// Every surface that grades a card calls this. It exists so no page ever
// writes flashcard_user_state or flashcard_reviews directly again — those two
// unchecked writes are what let a schedule and its review log drift apart on
// 204 card-blanks.
//
// The scheduling decision now happens on the server. This sends what happened
// (which card, which grade, from where) and receives the resulting state.

import { supabase } from "@/lib/supabase";
import type { Rating } from "@/lib/flashcards/scheduler";

export type ReviewSource = "daily_review" | "extra_study" | "starred" | "deck_all";

export interface SubmittedReview {
  intervalDays: number;
  easeFactor: number;
  reps: number;
  lapses: number;
  nextReviewAt: string;
  /** The server had already recorded this attempt; the write was collapsed. */
  duplicate: boolean;
}

export interface SubmitReviewArgs {
  flashcardId: string;
  clozeIndex: number;
  rating: Rating;
  source: ReviewSource;
  /** Stable per grading action. Reusing it on a retry makes the write idempotent. */
  clientRequestId: string;
}

/**
 * Submit one review. Throws on failure so callers can surface it — the old
 * path swallowed write errors silently, which is exactly how a student's
 * schedule could stop advancing without anyone noticing.
 */
export async function submitReview(args: SubmitReviewArgs): Promise<SubmittedReview> {
  const { data: sessionData } = await supabase.auth.getSession();
  const token = sessionData.session?.access_token;
  if (!token) throw new Error("Your session expired. Please sign in again.");

  const res = await fetch("/api/flashcards/review", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify({
      flashcardId: args.flashcardId,
      clozeIndex: args.clozeIndex,
      rating: args.rating,
      source: args.source,
      clientRequestId: args.clientRequestId,
    }),
  });

  if (!res.ok) {
    const detail = await res.json().catch(() => null);
    throw new Error(detail?.error || `Could not save that review (${res.status}).`);
  }
  return (await res.json()) as SubmittedReview;
}
