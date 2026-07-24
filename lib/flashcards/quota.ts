// ─── Daily study quotas ────────────────────────────────────────────────────
//
// Shared helper so the cross-deck session, the per-deck study page, and the
// library hub all count today's progress the SAME way when they apply the
// user's daily new-card / review limits.

import { supabase } from "@/lib/supabase";

export interface TodaysCounts {
  /** Unique cards studied today whose first review today started from a 0
   *  interval — i.e. brand-new introductions. */
  newToday: number;
  /** Unique already-seen cards studied today (came back due). */
  reviewsToday: number;
}

/**
 * Count how many unique cards the user has studied today (since local
 * midnight), split into "new" vs "review". We count UNIQUE cards, not review
 * rows — an "Again" re-queue logs a new row each time, which would otherwise
 * massively over-count a struggled card. A card is "new today" if any of its
 * reviews today started from a zero interval (its first-ever exposure);
 * every other studied card is a "review".
 */
export async function countTodaysReviews(userId: string): Promise<TodaysCounts> {
  const startOfToday = new Date();
  startOfToday.setHours(0, 0, 0, 0);

  // Page through ALL of today's review rows. Supabase caps a single query at
  // 1000 rows, and a heavy study day easily exceeds that (every "Again"
  // re-queue logs another row). Without paging, the count truncates at 1000
  // and UNDERcounts today's unique cards — which showed up as a phantom
  // "cards still left today" after the user had already finished their limit.
  // We order by the row's unique `id` so pages don't skip or overlap.
  const newCards = new Set<string>();
  const seenCards = new Set<string>();
  const PAGE = 1000;
  for (let from = 0; ; from += PAGE) {
    const { data, error } = await supabase
      .from("flashcard_reviews")
      .select("flashcard_id, cloze_index, prev_interval_days")
      .eq("user_id", userId)
      .gte("reviewed_at", startOfToday.toISOString())
      .order("id", { ascending: true })
      .range(from, from + PAGE - 1);
    if (error || !data) break;
    for (const r of data) {
      const key = `${r.flashcard_id}::${r.cloze_index}`;
      seenCards.add(key);
      if ((r.prev_interval_days ?? 0) === 0) newCards.add(key);
    }
    if (data.length < PAGE) break;
  }
  let reviewsToday = 0;
  seenCards.forEach((k) => {
    if (!newCards.has(k)) reviewsToday++;
  });
  return { newToday: newCards.size, reviewsToday };
}
