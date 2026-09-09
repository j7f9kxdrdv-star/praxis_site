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

// ─── The repeat view ───────────────────────────────────────────────────────
//
// A card in debt comes back inside the same session. Until now it came back
// with the same four buttons, so a card failed thirty seconds ago could be
// graded Easy, and that Easy overwrote the Again: the schedule ended up set by
// the answer still sitting in working memory rather than by the memory that has
// to survive until tomorrow.
//
// A repeat view asks ONE question, so it gets one pair of buttons. There are
// two answers and not one, because a single button cannot say "I still don't
// know it": the debt would pay itself down whatever happened, a card the
// student never recalled would graduate looking learned, and the appearance cap
// below could never be reached.

export type RelearnAnswer = "correct" | "missed";

/** A card that still owes recalls is being re-shown, not graded afresh. */
export function isRepeat(owed: number): boolean {
  return owed > 0;
}

/** Debt after answering a repeat view. A miss puts the card back to the start. */
export function nextOwedOnRepeat(owed: number, answer: RelearnAnswer): number {
  return answer === "missed" ? 3 : Math.max(owed - 1, 0);
}

/**
 * The grade a repeat view records.
 *
 * The four-point scale still exists in the database, because FSRS speaks it and
 * the review log has to stay one shape. The student is simply no longer asked
 * to choose a point on it for an answer they read moments ago.
 */
export function ratingForRepeat(answer: RelearnAnswer): Rating {
  return answer === "missed" ? "again" : "medium";
}

/**
 * Whether this submission is allowed to move the card's schedule.
 *
 * ONE LAPSE AND ONE GRADUATION PER CARD PER SESSION. Exactly two submissions in
 * a relearning run are allowed through:
 *
 *   the FIRST miss          the card lapses, which is the honest record
 *   the RELEASING recall    FSRS's own relearning graduation
 *
 * Everything between them is recorded and held, so three recalls thirty seconds
 * apart cannot buy three intervals.
 *
 * `alreadyLapsed` is what stops the second half of that. Letting every miss
 * through looked right until the run was simulated: a card the student cannot
 * get today is missed up to eight times before the appearance cap releases it,
 * and each one was a separate FSRS lapse. Eight lapses is not eight times more
 * evidence than one, it is the same fact counted eight times, and lapse count
 * feeds difficulty and stability directly.
 *
 * The card still comes back and still owes its recalls. Only the accounting is
 * capped, and a card that was never lapsed (a first grade of Hard, then a miss)
 * still lapses properly the first time it is missed.
 */
export function repeatMovesSchedule(
  answer: RelearnAnswer,
  owedAfter: number,
  alreadyLapsed: boolean,
): boolean {
  if (answer === "missed") return !alreadyLapsed;
  return owedAfter === 0;
}
