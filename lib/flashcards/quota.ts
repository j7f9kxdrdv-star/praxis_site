// ─── Daily study quotas ────────────────────────────────────────────────────
//
// Shared helper so the cross-deck session, the per-deck study page, and the
// library hub all count today's progress the SAME way when they apply the
// user's daily new-card / review limits.

import { supabase } from "@/lib/supabase";
import { DEFAULT_DAY_START_HOUR, startOfStudyDay } from "@/lib/flashcards/studyDay";

export interface TodaysCounts {
  /** Unique card-blanks introduced for the first time through Daily Review. */
  newToday: number;
  /** Unique already-seen card-blanks served through Daily Review today. */
  reviewsToday: number;
  /** Every rating event today, both modes. Effort, not capacity. Never
   *  subtract this from a limit: it is the number that made a 600-tap session
   *  look like 330 to the student. */
  attemptsToday: number;
  /** Rating events that came from Extra Study. Reported, never charged. */
  extraStudyAttemptsToday: number;
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
 * 2. Extra Study no longer spends Daily Review capacity. A student who
 *    finishes their recommended work and keeps going is not penalised for it.
 * 3. "New" now reads the RECORDED is_first_exposure flag instead of inferring
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
  const reviewedCards = new Set<string>();
  const seenCards = new Set<string>();
  let attemptsToday = 0;
  let extraStudyAttemptsToday = 0;
  const PAGE = 1000;
  for (let from = 0; ; from += PAGE) {
    const { data, error } = await supabase
      .from("flashcard_reviews")
      .select("flashcard_id, cloze_index, prev_interval_days, is_first_exposure, source")
      .eq("user_id", userId)
      .gte("reviewed_at", dayStart.toISOString())
      .order("id", { ascending: true })
      .range(from, from + PAGE - 1);
    if (error || !data) break;
    for (const r of data) {
      attemptsToday++;

      // Only Daily Review spends Daily Review capacity. Extra Study updates
      // the same memory state, but the student chose to do it beyond the
      // recommended workload, so charging it against the recommendation would
      // punish them for studying more. Rows written before provenance existed
      // have a NULL source and are treated as Daily Review, which is what they
      // were.
      const isExtra = r.source === "extra_study" || r.source === "starred" || r.source === "deck_all";
      if (isExtra) {
        extraStudyAttemptsToday++;
        continue;
      }

      const key = `${r.flashcard_id}::${r.cloze_index}`;
      seenCards.add(key);
      const isFirst =
        r.is_first_exposure ?? (r.prev_interval_days ?? 0) === 0;
      // A card's bucket is decided by the FIRST time it is seen today and
      // never revisited. Rows arrive ordered by id, so the first row for a key
      // is the earliest event of the day.
      //
      // The previous rule put a card in "new" if ANY of today's rows was a
      // first exposure, which let the classification move BACKWARDS. Deleting
      // a card's memory state mid-day makes its next appearance log as a first
      // exposure, so a card reviewed in the morning was retroactively
      // reclassified as new in the afternoon and silently subtracted from the
      // review count. On 2026-09-03 that hit 24 cards and held the counter at
      // 597 of 600 while 661 unique card-blanks had actually been studied, so
      // the limit could never be reached and the number appeared to drift.
      if (!newCards.has(key) && !reviewedCards.has(key)) {
        (isFirst ? newCards : reviewedCards).add(key);
      }
    }
    if (data.length < PAGE) break;
  }
  const reviewsToday = reviewedCards.size;
  return {
    newToday: newCards.size,
    reviewsToday,
    attemptsToday,
    extraStudyAttemptsToday,
  };
}
