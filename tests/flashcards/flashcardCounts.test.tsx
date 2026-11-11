// @vitest-environment jsdom
//
// The REAL Flashcards page, against an in-memory database: it must count only
// blanks a card still has (rows left behind by a rewritten card are not due,
// reviewed or unseen-reducing), and write every count with thousands separators.

import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { cleanup, render, screen, waitFor } from "@testing-library/react";
import type { ReactNode } from "react";
import { fakeSupabase, type Row } from "@/tests/helpers/fakeSupabase";
import { FUTURE, PAST, USER, cardId, deckId, makeLibrary } from "@/tests/helpers/flashcardFixture";

const h = vi.hoisted(() => ({
  client: null as unknown,
  profile: { daily_new_card_limit: 25, daily_review_limit: 150, day_start_hour: 4, study_hours_per_week: null as number | null },
  counts: { newToday: 0, reviewsToday: 0, attemptsToday: 0, extraStudyAttemptsToday: 0 },
}));
vi.mock("@/lib/supabase", () => ({ get supabase() { return h.client; } }));
vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), replace: vi.fn(), back: vi.fn(), prefetch: vi.fn() }),
  useSearchParams: () => new URLSearchParams(),
  usePathname: () => "/dashboard/flashcards",
}));
vi.mock("next/link", () => ({
  default: ({ href, children, ...rest }: { href: string; children: ReactNode }) => <a href={href} {...rest}>{children}</a>,
}));
vi.mock("@/components/dashboard/DashboardShell", () => ({
  useDashboard: () => ({ user: { id: "u1" }, profile: h.profile, refreshProfile: vi.fn() }),
}));
vi.mock("@/lib/flashcards/quota", () => ({ countTodaysReviews: vi.fn(async () => ({ ...h.counts })) }));

import FlashcardsHub from "@/app/dashboard/flashcards/page";

const state = (card: string, cloze: number, next = PAST, extra: Partial<Row> = {}): Row => ({
  user_id: USER, flashcard_id: card, cloze_index: cloze, starred: false, suspended: false, interval_days: 3, ease_factor: 2.5,
  reps: 1, lapses: 0, next_review_at: next, last_rating: "medium", last_reviewed_at: PAST, fsrs_state: 2, stability: 3, ...extra,
});

async function openHub(tables: Record<string, Row[]>) {
  h.client = fakeSupabase(tables);
  render(<FlashcardsHub />);
  await waitFor(() => expect(screen.getByText("Psych / Soc")).toBeTruthy());
  await waitFor(() => expect(screen.queryByText("Loading library…")).toBeNull());
}
/** The big number, and the "unseen" and "due" figures under it. */
function headline() {
  // Each figure is "<strong>N</strong> word" inside one span.
  const label = (word: string) => {
    const span = [...document.querySelectorAll("span")].find(
      (sp) => sp.querySelector(":scope > strong") && sp.textContent?.trim().endsWith(` ${word}`),
    );
    return span?.querySelector("strong")?.textContent ?? null;
  };
  const big = [...document.querySelectorAll("div")].find((d) => d.style.fontSize === "56px")?.textContent ?? null;
  return { big, unseen: label("unseen"), due: label("due") };
}
const deckLine = (chapterTitle: string) =>
  [...document.querySelectorAll("a")].find((a) => a.textContent?.includes(chapterTitle))?.textContent ?? "";

beforeEach(() => {
  h.counts = { newToday: 0, reviewsToday: 0, attemptsToday: 0, extraStudyAttemptsToday: 0 };
});
afterEach(() => cleanup());

describe("the Flashcards page counts only blanks a card still has", () => {
  it("a chapter's 'reviewed' count leaves out the orphan row (3 of 6, not 4)", async () => {
    await openHub(makeLibrary());
    screen.getByText("Psych / Soc").click();
    await waitFor(() => expect(deckLine("Psych / Soc chapter 1")).toContain("6 cards"));
    expect(deckLine("Psych / Soc chapter 1")).toContain("· 3 reviewed");
    expect(deckLine("Psych / Soc chapter 1")).not.toContain("4 reviewed");
  });

  it("the headline splits unseen and due without the orphan row", async () => {
    await openHub(makeLibrary());
    expect(headline()).toEqual({ big: "82", unseen: "79", due: "3" });
  });

  it("on a fully studied subject (as on the live account), the orphan row no longer inflates the headline", async () => {
    const tables = makeLibrary();
    tables.flashcard_user_state = tables.flashcard_user_state.filter(
      (r) => r.user_id !== USER || !String(r.flashcard_id).startsWith("card-psych_soc"),
    );
    for (const ch of [1, 2] as const) {
      tables.flashcard_user_state.push(state(cardId("psych_soc", ch, 1), 1), state(cardId("psych_soc", ch, 1), 2), state(cardId("psych_soc", ch, 1), 3));
      tables.flashcard_user_state.push(state(cardId("psych_soc", ch, 2), 0));
      tables.flashcard_user_state.push(state(cardId("psych_soc", ch, 3), 1), state(cardId("psych_soc", ch, 3), 2));
    }
    tables.flashcard_user_state.push(state(cardId("psych_soc", 1, 1), 4)); // the orphan, due
    await openHub(tables);
    // 71 unseen elsewhere + 13 due (12 Psych / Soc + 1 Biology) = 84. Counting the orphan made it 85.
    expect(headline()).toEqual({ big: "84", unseen: "71", due: "13" });
    screen.getByText("Psych / Soc").click();
    await waitFor(() => expect(deckLine("Psych / Soc chapter 1")).toContain("· 6 reviewed"));
    expect(screen.getByText("12 to study today")).toBeTruthy();
  });

  it("a due orphan row is not starred-counted either", async () => {
    const tables = makeLibrary();
    tables.flashcard_user_state.push(state(cardId("physics", 1, 3), 5, PAST, { starred: true }));
    await openHub(tables);
    const starred = [...document.querySelectorAll("div")].find((d) => d.textContent === "flagged")?.previousElementSibling?.textContent;
    expect(starred).toBe("1"); // only Psych / Soc chapter 2's starred blank
  });
});

describe("the word \"cards\"", () => {
  const NOTE = "Each blank on a flashcard counts as one study card.";

  it("explains it while cards are due", async () => {
    await openHub(makeLibrary());
    expect(headline().big).toBe("82");
    expect(screen.getByText(/Clear your queue today/).textContent).toContain(NOTE);
  });

  it("explains it when the student is caught up", async () => {
    const tables = makeLibrary();
    // Every blank studied and due well in the future: nothing due, nothing unseen.
    tables.flashcard_user_state = [];
    for (const card of tables.flashcards) {
      const n = card.card_type === "cloze" ? Number(card.cloze_count) : 1;
      for (let i = 0; i < n; i++) tables.flashcard_user_state.push(state(String(card.id), card.card_type === "cloze" ? i + 1 : 0, FUTURE));
    }
    await openHub(tables);
    expect(headline().big).toBe("0");
    expect(screen.getByText(/Caught up\./).textContent).toContain(NOTE);
  });

  it("uses the agreed wording only, once", async () => {
    await openHub(makeLibrary());
    expect(screen.getAllByText(new RegExp(NOTE.replace(".", "\\."))).length).toBe(1);
    expect(screen.queryByText(/counts once for each blank/)).toBeNull();
  });
});

describe("counts are written with thousands separators", () => {
  it("the headline, the unseen figure, the library total and a chapter line", async () => {
    const tables = makeLibrary();
    for (let i = 0; i < 1200; i++) {
      tables.flashcards.push({ ...tables.flashcards[1], id: `zz-${String(i).padStart(4, "0")}`, deck_id: deckId("biology", 2), position: 100 + i });
    }
    await openHub(tables);
    expect(headline()).toEqual({ big: "1,282", unseen: "1,279", due: "3" });
    screen.getByText("Biology").click();
    await waitFor(() => expect(deckLine("Biology chapter 2")).toContain("1,206 cards"));
  });

  it("the subject box writes large numbers the same way", async () => {
    const tables = makeLibrary();
    for (let i = 0; i < 1100; i++) {
      tables.flashcards.push({ ...tables.flashcards[1], id: `yy-${String(i).padStart(4, "0")}`, deck_id: deckId("physics", 1), position: 100 + i });
      tables.flashcard_user_state.push(state(`yy-${String(i).padStart(4, "0")}`, 0, PAST));
    }
    h.profile = { ...h.profile, daily_review_limit: 5000 };
    await openHub(tables);
    screen.getByText("Physics").click();
    await waitFor(() => expect(screen.getByText("1,112 to study today")).toBeTruthy());
    expect(screen.getByText(/12 new, 1,100 reviews\./)).toBeTruthy();
    h.profile = { ...h.profile, daily_review_limit: 150 };
  });
});

