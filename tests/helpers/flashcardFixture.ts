// A small flashcard library covering all seven subjects, for tests only.
//
// Every subject has two chapters (decks). Each deck has three cards, whose ids
// sort in the OPPOSITE order to their authored position, so a test can tell
// course order from id order:
//   position 1: cloze, 3 blanks   id ...-z
//   position 2: basic             id ...-m
//   position 3: cloze, 2 blanks   id ...-a
// Deck ids also sort opposite to chapter order (chapter 1 is "...-2nd-id").
//
// The student "u1" has studied a little of Psych / Soc and one Biology card;
// another student, "u2", has state on the same cards that must never leak in.

import { SECTIONS } from "@/lib/flashcards/sections";
import type { Row } from "./fakeSupabase";

export const PAST = "2026-01-01T00:00:00.000Z";
export const FUTURE = "2099-01-01T00:00:00.000Z";
export const USER = "u1";

export const deckId = (section: string, chapter: 1 | 2) => `deck-${section}-${chapter === 1 ? "b" : "a"}`;
export const cardId = (section: string, chapter: 1 | 2, position: 1 | 2 | 3) =>
  `card-${section}-${chapter}-${({ 1: "z", 2: "m", 3: "a" } as const)[position]}`;

function state(card: string, cloze: number, next: string, extra: Partial<Row> = {}, user = USER): Row {
  return {
    user_id: user,
    flashcard_id: card,
    cloze_index: cloze,
    starred: false,
    suspended: false,
    interval_days: 3,
    ease_factor: 2.5,
    reps: 1,
    lapses: 0,
    next_review_at: next,
    last_rating: "medium",
    last_reviewed_at: PAST,
    ...extra,
  };
}

export function makeLibrary(): Record<string, Row[]> {
  const decks: Row[] = [];
  const cards: Row[] = [];
  for (const s of SECTIONS) {
    for (const chapter of [1, 2] as const) {
      decks.push({ id: deckId(s.id, chapter), section: s.id, sort_order: chapter, topic: `${s.label} ${chapter}`, title: `${s.label} chapter ${chapter}`, subtopic: null, description: null });
      const base = { deck_id: deckId(s.id, chapter), front_text: null, back_text: null, explanation: null, back_image_url: null, back_image_alt: null };
      const tag = (p: number) => `${s.id}/ch${chapter}/p${p}`;
      cards.push({ ...base, id: cardId(s.id, chapter, 1), card_type: "cloze", cloze_count: 3, position: 1, cloze_text: `{{c1::a1}} {{c2::a2}} {{c3::a3}} [${tag(1)}]` });
      cards.push({ ...base, id: cardId(s.id, chapter, 2), card_type: "basic", cloze_count: 0, position: 2, cloze_text: null, front_text: `front [${tag(2)}]`, back_text: "back" });
      cards.push({ ...base, id: cardId(s.id, chapter, 3), card_type: "cloze", cloze_count: 2, position: 3, cloze_text: `{{c1::b1}} {{c2::b2}} [${tag(3)}]` });
    }
  }
  const ps = "psych_soc";
  const states: Row[] = [
    // Psych / Soc chapter 1, card 1 (3 blanks): c1 due, c2 later, c3 never seen,
    // plus an orphan row for a 4th blank the card no longer has.
    state(cardId(ps, 1, 1), 1, PAST),
    state(cardId(ps, 1, 1), 2, FUTURE),
    state(cardId(ps, 1, 1), 4, PAST),
    // chapter 1, card 2 (basic): suspended by the student
    state(cardId(ps, 1, 2), 0, PAST, { suspended: true }),
    // chapter 2, card 1: c1 due, and starred
    state(cardId(ps, 2, 1), 1, PAST, { starred: true }),
    // Biology chapter 1, card 2 (basic): due
    state(cardId("biology", 1, 2), 0, PAST),
    // Another student's rows on the same cards: must never count for u1.
    state(cardId(ps, 1, 3), 1, PAST, {}, "u2"),
    state(cardId("physics", 1, 1), 1, PAST, {}, "u2"),
  ];
  return { flashcard_decks: decks, flashcards: cards, flashcard_user_state: states, flashcard_reviews: [] };
}

/** What u1 can be served in a Review, per subject, before any daily limit. */
export const EXPECTED: Record<string, { newItems: number; dueReviews: number }> = Object.fromEntries(
  SECTIONS.map((s) => [s.id, { newItems: 12, dueReviews: 0 }]),
);
// Psych / Soc: ch1 new = card1 c3 + card3 c1,c2 = 3 (card2 suspended, c2 later,
// orphan c4 ignored), due = card1 c1; ch2 new = 5, due = card1 c1.
EXPECTED.psych_soc = { newItems: 8, dueReviews: 2 };
// Biology: the basic card in chapter 1 is a due review instead of new.
EXPECTED.biology = { newItems: 11, dueReviews: 1 };
