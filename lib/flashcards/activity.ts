// ─── Crediting a study day ───────────────────────────────────────────────────
//
// `daily_activity` holds one row per user per study day and is the ONLY source
// of the streak on the dashboard. Two bugs made that streak wrong:
//
// 1. FLASHCARDS NEVER CREDITED IT. Only lessons and practice questions wrote
//    this table, so a student doing 600 cards a day saw a streak of 0 and a
//    "Start a streak today" prompt. Measured on the founder's account: 5,420
//    flashcard reviews in eight days, zero daily_activity rows, last row five
//    weeks old.
//
// 2. THE EXISTING WRITERS USED THE UTC DATE. `new Date().toISOString()
//    .split("T")[0]` converts to UTC first, so for anyone west of Greenwich an
//    evening session is credited to TOMORROW. In US Eastern that is everything
//    after 8pm. A student studying at 9pm each night could log activity every
//    day and still show a broken streak, because each row landed a day ahead.
//
// This helper fixes both: one entry point, crediting the local STUDY DAY
// (4am boundary by default), used by every surface that counts as studying.
//
// Not atomic. Read-then-write can lose a concurrent increment, which matters
// for the questions_completed total but not for the streak, since the streak
// only asks whether a row exists for that day. PR2 moves this into the same
// server-side transaction as the review write and the race disappears.

import { supabase } from "@/lib/supabase";
import { DEFAULT_DAY_START_HOUR, studyDayKey } from "@/lib/flashcards/studyDay";

/**
 * Record that the user studied today, incrementing the day's item count.
 *
 * @param items How many items to add to questions_completed. A flashcard
 *              review passes 1; the column name predates flashcards existing.
 */
export async function creditStudyDay(
  userId: string,
  dayStartHour: number = DEFAULT_DAY_START_HOUR,
  items = 1
): Promise<void> {
  const day = studyDayKey(new Date(), dayStartHour);

  const { data: existing } = await supabase
    .from("daily_activity")
    .select("id, questions_completed")
    .eq("user_id", userId)
    .eq("activity_date", day)
    .maybeSingle();

  if (existing) {
    await supabase
      .from("daily_activity")
      .update({ questions_completed: (existing.questions_completed || 0) + items })
      .eq("id", existing.id);
    return;
  }

  // (user_id, activity_date) is UNIQUE, so a race here surfaces as a duplicate
  // -key error rather than a second row. Swallow it: the day is credited
  // either way, which is all the streak needs.
  await supabase
    .from("daily_activity")
    .insert({ user_id: userId, activity_date: day, questions_completed: items });
}
