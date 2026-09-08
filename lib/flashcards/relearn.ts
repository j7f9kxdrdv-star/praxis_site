// ─── Relearning inside a single session ────────────────────────────────────
//
// A card used to leave the session on its first passing grade: fail it, see it
// again three cards later, get it right, gone for two days. That recall lands
// about thirty seconds after reading the answer, so it measures working memory
// rather than the memory that has to survive until tomorrow. FSRS agrees in
// principle but applies only one relearning step of its own.
//
// So a card now carries a DEBT of successful recalls before it may leave.
//
// THE RULE LIVES HERE, IN ONE FILE. The cross-deck session and the per-deck
// study page had identical copies of the old requeue logic, and identical
// copies drift: the same duplication across the flashcard detectors meant
// teaching one rule about a contrast taught only one of three. Both pages now
// import this.

import type { Rating } from "@/lib/flashcards/scheduler";

/**
 * Recalls owed after a grade.
 *
 *   again   owe 3. The card was not known, and one echo is not evidence.
 *   hard    owe one more. Dragging it back is a pass, but a weak one, so it
 *           costs a further look. On a card already in debt it simply pays a
 *           step, which is also what guarantees repeated Hards terminate
 *           rather than cycling forever.
 *   medium
 *   easy    pay one step.
 */
export function nextOwed(owed: number, rating: Rating): number {
  if (rating === "again") return 3;
  if (rating === "hard") return owed > 0 ? owed - 1 : 1;
  return Math.max(owed - 1, 0);
}

/**
 * How far ahead to re-insert a card, by the debt it still owes.
 *
 * THE GAP GROWS AS THE DEBT SHRINKS. Three recalls at the same short spacing is
 * drilling, not spaced repetition: the further away a recall is, the more it is
 * genuine retrieval rather than an echo of the answer just read. So the last
 * look before a card graduates is the furthest away, and the first look after
 * failing is the nearest, because there the point is to re-read and encode.
 */
export function requeueGap(owed: number): number {
  if (owed >= 3) return 3;
  if (owed === 2) return 8;
  return 15;
}

/**
 * A card the student simply cannot get today would otherwise cycle forever and
 * take the session with it. After this many appearances it is released to
 * tomorrow's queue, which is where it belongs.
 */
export const MAX_SHOWS_PER_SESSION = 8;

/** Has this card finished for the session? */
export function isFinished(owed: number, shows: number): boolean {
  return owed === 0 || shows >= MAX_SHOWS_PER_SESSION;
}
