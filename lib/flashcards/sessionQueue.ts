// ─── What a cross-deck study session serves ───────────────────────────────────
//
// ONE definition of "eligible", used by both the Flashcards page (to count what
// a subject's Review button will serve) and the session page (to serve it).
// They used to compute it separately: the page counted `card_count -
// reviewed_count`, which also counted state rows for blanks a card no longer
// has, so its number could disagree with what the session actually served.
//
// A study ITEM is one card × one blank: a basic card is item 0, a cloze card
// with N blanks is items 1..N. Each item has its own schedule.

import type { SupabaseClient } from "@supabase/supabase-js";
import type { SectionId } from "./sections";
import type { ReviewSource } from "./submitReview";

export type Mode = "due" | "starred" | "extra_study";

export interface Card {
  id: string;
  card_type: "basic" | "cloze";
  front_text: string | null;
  back_text: string | null;
  cloze_text: string | null;
  cloze_count: number;
  explanation: string | null;
  /** Answer-side image, shown under the card on reveal. Null on most cards. */
  back_image_url: string | null;
  back_image_alt: string | null;
  deck_id: string;
  /** Authored order within the deck. Loaded for subject sessions. */
  position?: number | null;
}

export interface UserState {
  flashcard_id: string;
  cloze_index: number;
  starred: boolean;
  suspended: boolean;
  interval_days: number;
  ease_factor: number;
  reps: number;
  lapses: number;
  next_review_at: string;
  last_rating?: string | null;
  last_reviewed_at?: string | null;
}

export interface ReviewItem {
  card: Card;
  clozeIndex: number;
  state: UserState | null;
  /** Successful recalls still owed before this card leaves the session. */
  owed?: number;
  /** How many times it has appeared today, so a card cannot cycle forever. */
  shows?: number;
  /** Has this card already lapsed in this session? One lapse per card is enough. */
  lapsed?: boolean;
}

/** The fields eligibility needs; the Flashcards page loads only these. */
export type CardShape = Pick<Card, "id" | "deck_id" | "card_type"> & { cloze_count: number | null };
export type StateShape = Pick<UserState, "flashcard_id" | "cloze_index" | "suspended" | "next_review_at"> & {
  starred?: boolean;
};

/** The items a card has: [0] for a basic card, [1..N] for a cloze card. */
export function itemIndices(card: Pick<CardShape, "card_type" | "cloze_count">): number[] {
  if (card.card_type !== "cloze") return [0];
  const n = Math.max(card.cloze_count ?? 1, 1);
  return Array.from({ length: n }, (_, i) => i + 1);
}

export const itemKey = (cardId: string, clozeIndex: number) => `${cardId}::${clozeIndex}`;

/** Does this card still have this item? (A basic card has item 0; a cloze card 1..N.) */
export function isRealItem(card: Pick<CardShape, "card_type" | "cloze_count">, clozeIndex: number): boolean {
  if (card.card_type !== "cloze") return clozeIndex === 0;
  return Number.isInteger(clozeIndex) && clozeIndex >= 1 && clozeIndex <= Math.max(card.cloze_count ?? 1, 1);
}

/**
 * Keep only progress rows for items their card still has.
 *
 * When a card is rewritten with fewer blanks, a student's rows for the blanks
 * it lost stay behind. No session can serve them (sessions walk the card's own
 * blanks), so no count should include them either: they made the all-subject
 * headline say 6,544 due where 6,532 could be studied, and a chapter say "236
 * reviewed" of 233. The rows themselves are left untouched; this only decides
 * what is counted.
 */
export function keepRealItems<S extends { flashcard_id: string; cloze_index: number }>(
  states: S[],
  cards: Pick<CardShape, "id" | "card_type" | "cloze_count">[],
): S[] {
  const byId = new Map(cards.map((c) => [c.id, c]));
  return states.filter((st) => {
    const card = byId.get(st.flashcard_id);
    return card !== undefined && isRealItem(card, st.cloze_index);
  });
}

/**
 * new:       never studied (no state row)
 * due:       studied, and due now
 * later:     studied, not due yet
 * suspended: taken out of rotation by the student
 *
 * Due-ness is the same string comparison the session has always used; both
 * sides are UTC ISO strings.
 */
export function classify(state: StateShape | null | undefined, nowIso: string): "new" | "due" | "later" | "suspended" {
  if (!state) return "new";
  if (state.suspended) return "suspended";
  return state.next_review_at <= nowIso ? "due" : "later";
}

/** Exact per-deck counts of what a Review session could serve (before the daily limits). */
export function countEligibleByDeck(
  cards: CardShape[],
  states: Map<string, StateShape>,
  nowIso: string,
): Map<string, { newItems: number; dueReviews: number }> {
  const out = new Map<string, { newItems: number; dueReviews: number }>();
  for (const c of cards) {
    for (const idx of itemIndices(c)) {
      const kind = classify(states.get(itemKey(c.id, idx)), nowIso);
      if (kind !== "new" && kind !== "due") continue;
      const row = out.get(c.deck_id) ?? { newItems: 0, dueReviews: 0 };
      if (kind === "new") row.newItems++;
      else row.dueReviews++;
      out.set(c.deck_id, row);
    }
  }
  return out;
}

/**
 * Split cards into the session's two pools. `new` items have no state; review
 * items have one. Suspended items are never served.
 *   due:         new items, and review items due now
 *   starred:     starred review items only
 *   extra_study: everything not suspended
 */
export function buildPools(
  cards: Card[],
  states: Map<string, UserState>,
  nowIso: string,
  mode: Mode,
): { newPool: ReviewItem[]; reviewPool: ReviewItem[] } {
  const newPool: ReviewItem[] = [];
  const reviewPool: ReviewItem[] = [];
  for (const card of cards) {
    for (const clozeIndex of itemIndices(card)) {
      const state = states.get(itemKey(card.id, clozeIndex)) ?? null;
      const kind = classify(state, nowIso);
      if (kind === "suspended") continue;
      const item: ReviewItem = { card, clozeIndex, state };
      if (mode === "starred") {
        if (state?.starred === true) reviewPool.push(item);
        continue;
      }
      if (mode === "due" && kind === "later") continue;
      (state ? reviewPool : newPool).push(item);
    }
  }
  return { newPool, reviewPool };
}

/**
 * Serve the most overdue reviews first. See the session page for the history:
 * id order starved long-waiting cards, due-date order tested best.
 */
export function sortReviewsByDue(pool: ReviewItem[]): ReviewItem[] {
  return [...pool].sort((a, b) => {
    const at = a.state?.next_review_at ?? "";
    const bt = b.state?.next_review_at ?? "";
    return at < bt ? -1 : at > bt ? 1 : 0;
  });
}

/**
 * Course order for introducing NEW items in a subject Review: the subject's
 * chapters in their order, cards in their authored order within a chapter,
 * blanks in order within a card. Card id breaks any remaining tie so the
 * order is stable.
 *
 * Only which new items are chosen follows this order. The session still
 * shuffles what it serves, so reviews stay mixed across chapters and a card's
 * blanks are not shown back to back.
 */
export function orderNewByCourse(pool: ReviewItem[], deckOrder: Map<string, number>): ReviewItem[] {
  const rank = (deckId: string) => deckOrder.get(deckId) ?? Number.MAX_SAFE_INTEGER;
  return [...pool].sort(
    (a, b) =>
      rank(a.card.deck_id) - rank(b.card.deck_id) ||
      (a.card.position ?? Number.MAX_SAFE_INTEGER) - (b.card.position ?? Number.MAX_SAFE_INTEGER) ||
      a.clozeIndex - b.clozeIndex ||
      (a.card.id < b.card.id ? -1 : a.card.id > b.card.id ? 1 : 0),
  );
}

export type EmptyReason = "limit_reached" | "nothing_due" | null;

/** Apply what is left of today's allowance to the two pools of a Review session. */
export function applyDailyLimits(args: {
  newPool: ReviewItem[];
  reviewPool: ReviewItem[];
  newLeft: number;
  reviewsLeft: number;
}): { items: ReviewItem[]; emptyReason: EmptyReason } {
  const newQuota = Math.max(0, args.newLeft);
  const reviewQuota = Math.max(0, args.reviewsLeft);
  const items = [...args.newPool.slice(0, newQuota), ...args.reviewPool.slice(0, reviewQuota)];
  const waiting = args.newPool.length + args.reviewPool.length;
  return {
    items,
    emptyReason: waiting === 0 ? "nothing_due" : items.length === 0 ? "limit_reached" : null,
  };
}

/** The review source a session records. Unchanged by limiting it to a subject. */
export function reviewSourceFor(mode: Mode): ReviewSource {
  return mode === "due" ? "daily_review" : mode === "starred" ? "starred" : "extra_study";
}

// ─── Loading ──────────────────────────────────────────────────────────────────

export type LoadResult =
  | {
      ok: true;
      cards: Card[];
      states: UserState[];
      /** Chapter order for the subject's decks; null for a whole-library session. */
      deckOrder: Map<string, number> | null;
      /** A whole-library page failed and the load stopped early (kept as before). */
      incomplete: boolean;
    }
  | { ok: false };

const PAGE = 1000;
const CARD_COLUMNS =
  "id, card_type, front_text, back_text, cloze_text, cloze_count, explanation, back_image_url, back_image_alt, deck_id, position";
const STATE_COLUMNS =
  "flashcard_id, cloze_index, starred, suspended, interval_days, ease_factor, reps, lapses, next_review_at, last_rating, last_reviewed_at";

/**
 * Load what a session needs. With a subject, ANY failed read fails the whole
 * load: a session missing some cards, or missing some of the student's state
 * (which would make studied items look new), must not be presented as valid.
 *
 * Without a subject the long-standing whole-library behaviour is kept: a
 * failed page ends that loop. That is reported as `incomplete` so it is not
 * hidden, but changing what the student sees there needs its own review.
 *
 * Everything is paged: an unranged select is silently capped at 1,000 rows,
 * which once hid whole decks from sessions. Every paged read carries a stable
 * order; without one, pages can skip rows (studied cards then looked new).
 */
export async function loadSessionData(
  client: SupabaseClient,
  opts: { userId: string; section: SectionId | null },
): Promise<LoadResult> {
  const failClosed = opts.section !== null;
  let incomplete = false;

  let deckIds: string[] | null = null;
  let deckOrder: Map<string, number> | null = null;
  if (opts.section) {
    const { data, error } = await client
      .from("flashcard_decks")
      .select("id, sort_order")
      .eq("section", opts.section)
      .order("sort_order", { ascending: true })
      .order("id", { ascending: true });
    if (error || !data) return { ok: false };
    deckIds = data.map((d) => d.id as string);
    deckOrder = new Map(data.map((d, i) => [d.id as string, i]));
    if (deckIds.length === 0) return { ok: true, cards: [], states: [], deckOrder, incomplete: false };
  }

  const cards: Card[] = [];
  for (let from = 0; ; from += PAGE) {
    let q = client.from("flashcards").select(CARD_COLUMNS);
    // A subject has at most a few dozen decks, so this list stays short
    // (unlike a list of card ids, which once outgrew the URL).
    if (deckIds) q = q.in("deck_id", deckIds);
    const { data, error } = await q.order("id", { ascending: true }).range(from, from + PAGE - 1);
    if (error || !data) {
      if (failClosed) return { ok: false };
      incomplete = incomplete || !!error;
      break;
    }
    cards.push(...(data as unknown as Card[]));
    if (data.length < PAGE) break;
  }
  if (cards.length === 0) return { ok: true, cards, states: [], deckOrder, incomplete };

  // Every state row this student has, filtered by user only: an IN list of
  // card ids once grew past the URL limit and was silently truncated.
  const states: UserState[] = [];
  for (let from = 0; ; from += PAGE) {
    const { data, error } = await client
      .from("flashcard_user_state")
      .select(STATE_COLUMNS)
      .eq("user_id", opts.userId)
      .order("flashcard_id", { ascending: true })
      .order("cloze_index", { ascending: true })
      .range(from, from + PAGE - 1);
    if (error || !data) {
      if (failClosed) return { ok: false };
      incomplete = incomplete || !!error;
      break;
    }
    states.push(...(data as unknown as UserState[]));
    if (data.length < PAGE) break;
  }
  return { ok: true, cards, states, deckOrder, incomplete };
}
