import { describe, expect, it } from "vitest";
import type { SupabaseClient } from "@supabase/supabase-js";
import { computeBrief } from "./computeBrief";
import { fakeSupabase, type Row } from "@/tests/helpers/fakeSupabase";
import { PAST, USER, cardId, makeLibrary } from "@/tests/helpers/flashcardFixture";
import { SECTIONS } from "@/lib/flashcards/sections";

// The insights brief must count only blanks a card still has, like the
// Flashcards page and the dashboard: a row for a blank the card lost is not
// due, not in circulation and not a leech.

const state = (card: string, cloze: number, extra: Partial<Row> = {}): Row => ({
  user_id: USER, flashcard_id: card, cloze_index: cloze, stability: 3, difficulty: 6, fsrs_state: 2, reps: 2, lapses: 0,
  interval_days: 3, next_review_at: PAST, last_reviewed_at: PAST, suspended: false, ...extra,
});

/** Every blank of every card studied and due (84 items), so the brief has enough history. */
function studiedLibrary() {
  const tables = makeLibrary();
  tables.flashcard_user_state = [];
  for (const s of SECTIONS) for (const ch of [1, 2] as const) {
    tables.flashcard_user_state.push(state(cardId(s.id, ch, 1), 1), state(cardId(s.id, ch, 1), 2), state(cardId(s.id, ch, 1), 3));
    tables.flashcard_user_state.push(state(cardId(s.id, ch, 2), 0));
    tables.flashcard_user_state.push(state(cardId(s.id, ch, 3), 1), state(cardId(s.id, ch, 3), 2));
  }
  return tables;
}
const today = async (tables: Record<string, Row[]>) => {
  const brief = await computeBrief(fakeSupabase(tables) as unknown as SupabaseClient, USER, "America/New_York", 4);
  return brief.claims.find((c) => c.kind === "today")!;
};

describe("computeBrief counts only blanks a card still has", () => {
  it("baseline: 84 real blanks, all due", async () => {
    const t = await today(studiedLibrary());
    expect(t.evidence).toMatchObject({ dueNow: 84, cardsInCirculation: 84 });
  });

  it("leaves out rows for blanks a card lost and for cards no longer in the library", async () => {
    const tables = studiedLibrary();
    tables.flashcard_user_state.push(
      state(cardId("psych_soc", 1, 1), 4), // the card has 3 blanks
      state(cardId("physics", 2, 3), 5, { lapses: 9 }), // would otherwise look like a leech
      state("card-that-no-longer-exists", 1),
    );
    const t = await today(tables);
    expect(t.evidence).toMatchObject({ dueNow: 84, cardsInCirculation: 84 });
  });

  it("an orphan row with many lapses is not reported as a leech", async () => {
    const tables = studiedLibrary();
    tables.flashcard_user_state.push(state(cardId("physics", 2, 3), 5, { lapses: 9 }));
    const brief = await computeBrief(fakeSupabase(tables) as unknown as SupabaseClient, USER, "America/New_York", 4);
    expect(brief.claims.some((c) => c.kind === "leech")).toBe(false);
  });

  it("a real leech is still reported", async () => {
    const tables = studiedLibrary();
    const row = tables.flashcard_user_state.find((r) => r.flashcard_id === cardId("physics", 2, 3) && r.cloze_index === 1)!;
    row.lapses = 9;
    const brief = await computeBrief(fakeSupabase(tables) as unknown as SupabaseClient, USER, "America/New_York", 4);
    expect(brief.claims.some((c) => c.kind === "leech")).toBe(true);
  });
});
