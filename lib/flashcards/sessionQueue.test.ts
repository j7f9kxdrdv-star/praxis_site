import { describe, expect, it } from "vitest";
import type { SupabaseClient } from "@supabase/supabase-js";
import {
  applyDailyLimits,
  buildPools,
  classify,
  countEligibleByDeck,
  itemIndices,
  itemKey,
  loadSessionData,
  orderNewByCourse,
  reviewSourceFor,
  sortReviewsByDue,
  type Card,
  type ReviewItem,
  type UserState,
} from "./sessionQueue";
import { SECTIONS, projectSubjectReview, type SectionId } from "./sections";
import { fakeSupabase, type Row } from "@/tests/helpers/fakeSupabase";
import { EXPECTED, FUTURE, PAST, USER, cardId, deckId, makeLibrary } from "@/tests/helpers/flashcardFixture";

const NOW = "2026-06-01T00:00:00.000Z";
const asClient = (f: ReturnType<typeof fakeSupabase>) => f as unknown as SupabaseClient;

async function loadOk(section: SectionId | null, tables = makeLibrary(), opts = {}) {
  const fake = fakeSupabase(tables, opts);
  const r = await loadSessionData(asClient(fake), { userId: USER, section });
  if (!r.ok) throw new Error("expected the load to succeed");
  return { ...r, fake };
}

function stateMapOf(states: UserState[]) {
  return new Map(states.map((s) => [itemKey(s.flashcard_id, s.cloze_index), s]));
}

describe("itemIndices", () => {
  it("gives a basic card one item, numbered 0", () => {
    expect(itemIndices({ card_type: "basic", cloze_count: 0 })).toEqual([0]);
  });
  it("gives a cloze card one item per blank, numbered from 1", () => {
    expect(itemIndices({ card_type: "cloze", cloze_count: 3 })).toEqual([1, 2, 3]);
  });
  it("treats a cloze card with a missing or zero count as one blank, as the session always has", () => {
    expect(itemIndices({ card_type: "cloze", cloze_count: 0 })).toEqual([1]);
    expect(itemIndices({ card_type: "cloze", cloze_count: null })).toEqual([1]);
  });
});

describe("classify", () => {
  const base = { flashcard_id: "x", cloze_index: 1, suspended: false };
  it("never studied is new", () => expect(classify(undefined, NOW)).toBe("new"));
  it("due now, or overdue, is due", () => {
    expect(classify({ ...base, next_review_at: PAST }, NOW)).toBe("due");
    expect(classify({ ...base, next_review_at: NOW }, NOW)).toBe("due");
  });
  it("due later is later", () => expect(classify({ ...base, next_review_at: FUTURE }, NOW)).toBe("later"));
  it("suspended wins over due", () =>
    expect(classify({ ...base, suspended: true, next_review_at: PAST }, NOW)).toBe("suspended"));
});

describe("countEligibleByDeck (what the subject box counts)", () => {
  it("counts partially studied multi-blank cards blank by blank, ignoring orphans and suspended items", async () => {
    const { cards, states } = await loadOk("psych_soc");
    const counts = countEligibleByDeck(cards, stateMapOf(states), NOW);
    expect(counts.get(deckId("psych_soc", 1))).toEqual({ newItems: 3, dueReviews: 1 });
    expect(counts.get(deckId("psych_soc", 2))).toEqual({ newItems: 5, dueReviews: 1 });
  });

  it.each(SECTIONS.map((s) => s.id))("matches the expected eligible items for %s", async (section) => {
    const { cards, states } = await loadOk(section);
    const counts = countEligibleByDeck(cards, stateMapOf(states), NOW);
    const sum = [...counts.values()].reduce(
      (a, c) => ({ newItems: a.newItems + c.newItems, dueReviews: a.dueReviews + c.dueReviews }),
      { newItems: 0, dueReviews: 0 },
    );
    expect(sum).toEqual(EXPECTED[section]);
  });

  it("agrees exactly with what a Review session's pools hold, for every subject", async () => {
    for (const s of SECTIONS) {
      const { cards, states } = await loadOk(s.id);
      const map = stateMapOf(states);
      const counts = [...countEligibleByDeck(cards, map, NOW).values()];
      const { newPool, reviewPool } = buildPools(cards, map, NOW, "due");
      expect(newPool.length).toBe(counts.reduce((a, c) => a + c.newItems, 0));
      expect(reviewPool.length).toBe(counts.reduce((a, c) => a + c.dueReviews, 0));
    }
  });

  it("would have disagreed with the old card_count - reviewed_count estimate on the orphan row", () => {
    // The old box: unseen = items - state rows. Psych / Soc chapter 1 has 6
    // items and 4 state rows for u1 (one of them the orphan), so it guessed 2
    // new items where the session serves 3.
    const items = 3 + 1 + 2;
    const stateRows = 4;
    expect(items - stateRows).toBe(2);
    expect(EXPECTED.psych_soc.newItems).toBe(8);
  });
});

describe("buildPools", () => {
  it("never serves another student's state as this student's", async () => {
    const { states, fake } = await loadOk("physics");
    expect(states.every((s) => (s as unknown as Row).user_id === undefined || (s as unknown as Row).user_id === USER)).toBe(true);
    const stateCall = fake.calls.find((c) => c.table === "flashcard_user_state");
    expect(stateCall?.eqs).toContainEqual(["user_id", USER]);
  });

  it("starred mode serves only starred, unsuspended reviews", async () => {
    const { cards, states } = await loadOk("psych_soc");
    const { newPool, reviewPool } = buildPools(cards, stateMapOf(states), NOW, "starred");
    expect(newPool).toHaveLength(0);
    expect(reviewPool.map((i) => itemKey(i.card.id, i.clozeIndex))).toEqual([itemKey(cardId("psych_soc", 2, 1), 1)]);
  });

  it("extra study serves everything not suspended, due or not", async () => {
    const { cards, states } = await loadOk("psych_soc");
    const { newPool, reviewPool } = buildPools(cards, stateMapOf(states), NOW, "extra_study");
    expect(newPool).toHaveLength(8);
    expect(reviewPool).toHaveLength(3); // two due + the one due later; suspended excluded
  });
});

describe("orderNewByCourse (new items in a subject Review)", () => {
  it("orders by chapter, then authored position, then blank, not by id", async () => {
    const { cards, states, deckOrder } = await loadOk("psych_soc");
    const { newPool } = buildPools(cards, stateMapOf(states), NOW, "due");
    const ordered = orderNewByCourse(newPool, deckOrder!);
    expect(ordered.map((i) => `${i.card.id}#${i.clozeIndex}`)).toEqual([
      `${cardId("psych_soc", 1, 1)}#3`,
      `${cardId("psych_soc", 1, 3)}#1`,
      `${cardId("psych_soc", 1, 3)}#2`,
      `${cardId("psych_soc", 2, 1)}#2`,
      `${cardId("psych_soc", 2, 1)}#3`,
      `${cardId("psych_soc", 2, 2)}#0`,
      `${cardId("psych_soc", 2, 3)}#1`,
      `${cardId("psych_soc", 2, 3)}#2`,
    ]);
  });

  it("is stable: the same input always gives the same order", async () => {
    const { cards, states, deckOrder } = await loadOk("chemistry");
    const { newPool } = buildPools(cards, stateMapOf(states), NOW, "due");
    const a = orderNewByCourse(newPool, deckOrder!).map((i) => itemKey(i.card.id, i.clozeIndex));
    const b = orderNewByCourse([...newPool].reverse(), deckOrder!).map((i) => itemKey(i.card.id, i.clozeIndex));
    expect(a).toEqual(b);
  });

  it("with an allowance of 3, introduces chapter 1 before anything in chapter 2", async () => {
    const { cards, states, deckOrder } = await loadOk("physics");
    const { newPool, reviewPool } = buildPools(cards, stateMapOf(states), NOW, "due");
    const { items } = applyDailyLimits({ newPool: orderNewByCourse(newPool, deckOrder!), reviewPool, newLeft: 3, reviewsLeft: 0 });
    expect(items.map((i) => i.card.deck_id)).toEqual([deckId("physics", 1), deckId("physics", 1), deckId("physics", 1)]);
    expect(items.map((i) => `${i.card.id}#${i.clozeIndex}`)).toEqual([
      `${cardId("physics", 1, 1)}#1`,
      `${cardId("physics", 1, 1)}#2`,
      `${cardId("physics", 1, 1)}#3`,
    ]);
  });
});

describe("applyDailyLimits", () => {
  const item = (id: string): ReviewItem => ({ card: { id } as Card, clozeIndex: 1, state: null });
  const pools = { newPool: [item("n1"), item("n2"), item("n3")], reviewPool: [item("r1"), item("r2")] };

  it("serves within both allowances", () => {
    const r = applyDailyLimits({ ...pools, newLeft: 2, reviewsLeft: 1 });
    expect(r.items.map((i) => i.card.id)).toEqual(["n1", "n2", "r1"]);
    expect(r.emptyReason).toBeNull();
  });
  it("only the new-item allowance spent: serves reviews only", () => {
    const r = applyDailyLimits({ ...pools, newLeft: 0, reviewsLeft: 5 });
    expect(r.items.map((i) => i.card.id)).toEqual(["r1", "r2"]);
  });
  it("only the review allowance spent: serves new items only", () => {
    const r = applyDailyLimits({ ...pools, newLeft: 5, reviewsLeft: 0 });
    expect(r.items.map((i) => i.card.id)).toEqual(["n1", "n2", "n3"]);
  });
  it("both spent with items waiting: limit reached", () => {
    expect(applyDailyLimits({ ...pools, newLeft: 0, reviewsLeft: -4 }).emptyReason).toBe("limit_reached");
  });
  it("nothing waiting: nothing due", () => {
    expect(applyDailyLimits({ newPool: [], reviewPool: [], newLeft: 5, reviewsLeft: 5 }).emptyReason).toBe("nothing_due");
  });
  it("matches the subject box's projection for the same numbers", () => {
    for (const [newLeft, reviewsLeft] of [[2, 1], [0, 5], [5, 0], [0, 0], [-3, 9]]) {
      const r = applyDailyLimits({ ...pools, newLeft, reviewsLeft });
      const p = projectSubjectReview({ unseen: 3, dueReviews: 2, newLeftToday: newLeft, reviewsLeftToday: reviewsLeft });
      expect(r.items.length).toBe(p.served);
      expect(r.emptyReason === "limit_reached").toBe(p.limitReached);
    }
  });

  it("is computed at load time only, so two sessions opened together each get today's whole remaining allowance", () => {
    // Known limitation, not new: the server does not enforce the daily limits
    // (POST /api/flashcards/review and submit_flashcard_review check no quota).
    // Two tabs that load before either grades both serve the full remainder.
    const tabA = applyDailyLimits({ ...pools, newLeft: 2, reviewsLeft: 2 });
    const tabB = applyDailyLimits({ ...pools, newLeft: 2, reviewsLeft: 2 });
    expect(tabA.items.length + tabB.items.length).toBe(8); // allowance was 4
  });
});

describe("sortReviewsByDue", () => {
  it("serves the most overdue first", () => {
    const at = (id: string, next: string): ReviewItem => ({ card: { id } as Card, clozeIndex: 1, state: { next_review_at: next } as UserState });
    const sorted = sortReviewsByDue([at("b", "2026-03-01"), at("a", "2026-01-01"), at("c", "2026-02-01")]);
    expect(sorted.map((i) => i.card.id)).toEqual(["a", "c", "b"]);
  });
});

describe("reviewSourceFor (what each session records)", () => {
  it("keeps the existing sources, so subject Review spends the shared allowance and Extra Study does not", () => {
    expect(reviewSourceFor("due")).toBe("daily_review");
    expect(reviewSourceFor("extra_study")).toBe("extra_study");
    expect(reviewSourceFor("starred")).toBe("starred");
  });
});

describe("loadSessionData", () => {
  it.each(SECTIONS.map((s) => s.id))("loads only %s's decks, in chapter order", async (section) => {
    const { cards, deckOrder, fake } = await loadOk(section);
    expect(new Set(cards.map((c) => c.deck_id))).toEqual(new Set([deckId(section, 1), deckId(section, 2)]));
    expect([...deckOrder!.entries()]).toEqual([[deckId(section, 1), 0], [deckId(section, 2), 1]]);
    const cardCall = fake.calls.find((c) => c.table === "flashcards");
    expect(cardCall?.ins).toEqual([["deck_id", [deckId(section, 1), deckId(section, 2)]]]);
  });

  it("without a subject, loads the whole library and no deck list", async () => {
    const { cards, deckOrder, fake } = await loadOk(null);
    expect(cards).toHaveLength(7 * 2 * 3);
    expect(deckOrder).toBeNull();
    expect(fake.calls.some((c) => c.table === "flashcard_decks")).toBe(false);
    expect(fake.calls.find((c) => c.table === "flashcards")?.ins).toEqual([]);
  });

  it("a subject with no decks loads nothing and reads no cards", async () => {
    const tables = makeLibrary();
    tables.flashcard_decks = tables.flashcard_decks.filter((d) => d.section !== "physics");
    const { cards, fake } = await loadOk("physics", tables);
    expect(cards).toEqual([]);
    expect(fake.calls.some((c) => c.table === "flashcards")).toBe(false);
  });

  it("pages through more than 1,000 cards and state rows with a stable order", async () => {
    const tables = makeLibrary();
    for (let i = 0; i < 1500; i++) {
      tables.flashcards.push({ ...tables.flashcards[0], id: `extra-${String(i).padStart(4, "0")}`, deck_id: deckId("biology", 2) });
      tables.flashcard_user_state.push({ ...tables.flashcard_user_state[0], flashcard_id: `extra-${String(i).padStart(4, "0")}`, cloze_index: 1 });
    }
    const { cards, states, fake } = await loadOk("biology", tables);
    expect(cards).toHaveLength(6 + 1500);
    expect(states.length).toBeGreaterThan(1000);
    const cardCalls = fake.calls.filter((c) => c.table === "flashcards");
    expect(cardCalls.map((c) => c.range)).toEqual([[0, 999], [1000, 1999]]);
    expect(cardCalls.every((c) => c.orders.some(([col]) => col === "id"))).toBe(true);
    const stateCalls = fake.calls.filter((c) => c.table === "flashcard_user_state");
    expect(stateCalls.every((c) => c.orders.map(([col]) => col).join() === "flashcard_id,cloze_index")).toBe(true);
  });

  describe("fails closed for a subject", () => {
    const failOn = (table: string, from = 0) => ({ fail: (q: { table: string; range: [number, number] | null }) => q.table === table && (q.range?.[0] ?? 0) === from });

    it("when the deck list fails", async () => {
      const r = await loadSessionData(asClient(fakeSupabase(makeLibrary(), failOn("flashcard_decks"))), { userId: USER, section: "biology" });
      expect(r.ok).toBe(false);
    });
    it("when a card page fails, even after a good first page", async () => {
      const tables = makeLibrary();
      for (let i = 0; i < 1200; i++) tables.flashcards.push({ ...tables.flashcards[0], id: `x${i}`, deck_id: deckId("biology", 1) });
      const r = await loadSessionData(asClient(fakeSupabase(tables, failOn("flashcards", 1000))), { userId: USER, section: "biology" });
      expect(r.ok).toBe(false);
    });
    it("when the student's state fails (studied items would otherwise look new)", async () => {
      const r = await loadSessionData(asClient(fakeSupabase(makeLibrary(), failOn("flashcard_user_state"))), { userId: USER, section: "psych_soc" });
      expect(r.ok).toBe(false);
    });
  });

  it("without a subject, keeps the old behaviour on a failed page but reports it", async () => {
    const fake = fakeSupabase(makeLibrary(), { fail: (q) => q.table === "flashcard_user_state" });
    const r = await loadSessionData(asClient(fake), { userId: USER, section: null });
    expect(r.ok).toBe(true);
    if (r.ok) {
      expect(r.cards.length).toBe(42);
      expect(r.states).toEqual([]);
      expect(r.incomplete).toBe(true);
    }
  });
});
