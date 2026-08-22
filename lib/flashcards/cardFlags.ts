// ─── Starring and suspending, without clobbering the schedule ────────────────
//
// THE BUG THIS REPLACES. Star and suspend were implemented as a full upsert of
// the scheduling row, rebuilt from whatever the page held in memory:
//
//     upsert({ starred, suspended, interval_days, ease_factor, reps,
//              lapses, next_review_at, ... })
//
// Every one of those scheduling columns was written from a snapshot taken when
// the page loaded. So a student who grades a card on their phone and then
// stars it from a laptop tab that has been open since before that grade writes
// the OLD schedule back over the new one. The card silently loses the review.
//
// Flags are metadata about a card, not a scheduling event. Toggling one must
// touch exactly one column.
//
// Note the update-then-insert shape: a plain upsert cannot express "change
// only this column" through PostgREST, because it writes every column it is
// given. Updating first and only inserting when no row exists keeps the
// scheduling columns untouched on the path that matters.

import { supabase } from "@/lib/supabase";

type Flag = { starred?: boolean; suspended?: boolean };

/**
 * Set `starred` and/or `suspended` on one card-blank, leaving every scheduling
 * column exactly as it is.
 *
 * Returns true when the change was persisted.
 */
export async function setCardFlag(
  userId: string,
  flashcardId: string,
  clozeIndex: number,
  flag: Flag
): Promise<boolean> {
  const { data, error } = await supabase
    .from("flashcard_user_state")
    .update(flag)
    .eq("user_id", userId)
    .eq("flashcard_id", flashcardId)
    .eq("cloze_index", clozeIndex)
    .select("flashcard_id");

  if (error) return false;
  if (data && data.length > 0) return true;

  // No state row yet: the card has never been reviewed. Create one carrying the
  // flag and a neutral, unstudied schedule. next_review_at is left at the
  // column default (now), so an unseen card stays available rather than being
  // pushed into the future by the act of starring it.
  const { error: insertErr } = await supabase.from("flashcard_user_state").insert({
    user_id: userId,
    flashcard_id: flashcardId,
    cloze_index: clozeIndex,
    starred: flag.starred ?? false,
    suspended: flag.suspended ?? false,
  });
  return !insertErr;
}
