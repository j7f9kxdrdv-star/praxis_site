// ─── Daily study quotas ────────────────────────────────────────────────────
//
// Shared helper so the cross-deck session, the per-deck study page, and the
// library hub all count today's progress the SAME way when they apply the
// user's daily new-card / review limits.

import { supabase } from "@/lib/supabase";
import { DEFAULT_DAY_START_HOUR, startOfStudyDay } from "@/lib/flashcards/studyDay";

export interface TodaysCounts {
  /** Unique card-blanks introduced for the first time during this study day. */
  newToday: number;
  /** Unique already-seen card-blanks studied during this study day. */
  reviewsToday: number;
}

/**
 * Count how many unique card-blanks the user has studied during the current
 * STUDY DAY, split into "new" vs "review".
 *
 * We count UNIQUE card-blanks, not review rows — an "Again" re-queue logs a
 * new row each time, which would otherwise massively over-count a struggled
 * card. This is deliberate and is the reason a heavy session can log more
 * attempts than it consumes budget: 410 attempts against 329 unique cards on
 * one real day. The user-facing counter must therefore be labelled in cards,
 * never in attempts.
 *
 * Two changes from the previous version:
 *
 * 1. The window is the study day (default 4am boundary), not local midnight,
 *    so a session running past midnight is one day's work rather than two.
 * 2. "New" now reads the RECORDED is_first_exposure flag instead of inferring
 *    it from prev_interval_days === 0. That inference was wrong on 518 rows,
 *    each of which was billed against the daily NEW-card budget on a day it
 *    was really a review. The fallback below only fires for rows written
 *    between the migration and this code shipping.
 */
export async function countTodaysReviews(
  userId: string,
  dayStartHour: number = DEFAULT_DAY_START_HOUR
): Promise<TodaysCounts> {
  const dayStart = startOfStudyDay(new Date(), dayStartHour);

  // Page through ALL of this study day's review rows. Supabase caps a single
  // query at 1000 rows, and a heavy day easily exceeds that (every "Again"
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
      .select("flashcard_id, cloze_index, prev_interval_days, is_first_exposure")
      .eq("user_id", userId)
      .gte("reviewed_at", dayStart.toISOString())
      .order("id", { ascending: true })
      .range(from, from + PAGE - 1);
    if (error || !data) break;
    for (const r of data) {
      const key = `${r.flashcard_id}::${r.cloze_index}`;
      seenCards.add(key);
      const isFirst =
        r.is_first_exposure ?? (r.prev_interval_days ?? 0) === 0;
      if (isFirst) newCards.add(key);
    }
    if (data.length < PAGE) break;
  }
  let reviewsToday = 0;
  seenCards.forEach((k) => {
    if (!newCards.has(k)) reviewsToday++;
  });
  return { newToday: newCards.size, reviewsToday };
}
