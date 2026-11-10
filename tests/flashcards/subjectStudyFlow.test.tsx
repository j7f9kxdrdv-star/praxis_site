// @vitest-environment jsdom
//
// Page-level tests: the REAL Flashcards page and the REAL study session page,
// rendered against an in-memory database. Only the edges are replaced: the
// database client, the router, the signed-in student, today's study counts, the
// review write, and the card face (StudySurface, unchanged by this feature,
// stubbed to a plain readout of the card's text with one "rate" button).

import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { act, cleanup, fireEvent, render, screen, waitFor } from "@testing-library/react";
import type { ReactNode } from "react";
import { SECTIONS } from "@/lib/flashcards/sections";
import { deferred, fakeSupabase, type FakeOptions } from "@/tests/helpers/fakeSupabase";
import { EXPECTED, makeLibrary } from "@/tests/helpers/flashcardFixture";

const h = vi.hoisted(() => ({
  client: null as unknown,
  params: new URLSearchParams(),
  profile: { daily_new_card_limit: 25, daily_review_limit: 150, day_start_hour: 4, study_hours_per_week: null as number | null },
  counts: { newToday: 0, reviewsToday: 0, attemptsToday: 0, extraStudyAttemptsToday: 0 },
  submit: null as unknown as ReturnType<typeof vi.fn>,
}));

vi.mock("@/lib/supabase", () => ({
  get supabase() {
    return h.client;
  },
}));
vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), replace: vi.fn(), back: vi.fn(), prefetch: vi.fn() }),
  useSearchParams: () => h.params,
  usePathname: () => "/dashboard/flashcards",
}));
vi.mock("next/link", () => ({
  default: ({ href, children, ...rest }: { href: string; children: ReactNode }) => (
    <a href={href} {...rest}>
      {children}
    </a>
  ),
}));
vi.mock("@/components/dashboard/DashboardShell", () => ({
  useDashboard: () => ({ user: { id: "u1" }, profile: h.profile, refreshProfile: vi.fn() }),
}));
vi.mock("@/lib/flashcards/quota", () => ({ countTodaysReviews: vi.fn(async () => ({ ...h.counts })) }));
vi.mock("@/lib/flashcards/submitReview", () => ({ submitReview: (...a: unknown[]) => h.submit(...a) }));
vi.mock("@/lib/flashcards/cardFlags", () => ({ setCardFlag: vi.fn(async () => true) }));
vi.mock("@/components/flashcards/RotateGate", () => ({ default: ({ children }: { children: ReactNode }) => <>{children}</> }));
vi.mock("@/components/flashcards/StudySurface", () => ({
  default: (p: {
    progress: { total: number };
    segments: { text?: string }[];
    onRate: (r: string) => void;
  }) => (
    <div data-testid="surface" data-total={p.progress.total}>
      <span data-testid="card-text">{p.segments.map((s) => s.text ?? "").join("")}</span>
      <button onClick={() => p.onRate("easy")}>rate</button>
    </div>
  ),
}));

import SessionPage from "@/app/dashboard/flashcards/session/page";
import FlashcardsHub from "@/app/dashboard/flashcards/page";

function useLibrary(opts: FakeOptions = {}, tables = makeLibrary()) {
  const fake = fakeSupabase(tables, opts);
  h.client = fake;
  return fake;
}

/** "[psych_soc/ch1/p3]" -> "psych_soc/ch1/p3" */
const tagOf = (text: string) => /\[([^\]]+)\]/.exec(text)?.[1] ?? "";

/** Rate every card in the session with Easy and return the tags in the order served. */
async function studyAll(): Promise<string[]> {
  const tags: string[] = [];
  for (let guard = 0; guard < 200; guard++) {
    const surface = screen.queryByTestId("surface");
    if (!surface) break;
    tags.push(tagOf(screen.getByTestId("card-text").textContent ?? ""));
    const before = h.submit.mock.calls.length;
    await act(async () => {
      fireEvent.click(screen.getByText("rate"));
    });
    await waitFor(() => expect(h.submit.mock.calls.length).toBe(before + 1));
  }
  return tags;
}

async function openSession(query: string) {
  h.params = new URLSearchParams(query);
  const view = render(<SessionPage />);
  await waitFor(() => expect(screen.queryByText((_, el) => el?.classList.contains("animate-spin") ?? false)).toBeNull());
  return view;
}

beforeEach(() => {
  h.profile = { daily_new_card_limit: 25, daily_review_limit: 150, day_start_hour: 4, study_hours_per_week: null };
  h.counts = { newToday: 0, reviewsToday: 0, attemptsToday: 0, extraStudyAttemptsToday: 0 };
  h.submit = vi.fn(async () => ({ intervalDays: 3, easeFactor: 2.5, reps: 1, lapses: 0, nextReviewAt: "2099-01-01T00:00:00.000Z" }));
});
afterEach(() => cleanup());

describe("subject Review session, every subject", () => {
  it.each(SECTIONS.map((s) => s.id))("%s: serves exactly its eligible items, only from that subject, recorded as Daily Review", async (section) => {
    useLibrary();
    await openSession(`mode=due&section=${section}`);
    const expected = EXPECTED[section].newItems + EXPECTED[section].dueReviews;
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(expected);
    const tags = await studyAll();
    expect(tags).toHaveLength(expected);
    expect(tags.every((t) => t.startsWith(`${section}/`))).toBe(true);
    // The write is unchanged: the same card, blank and grade, with the
    // Daily Review source, so it spends the shared allowance and the server
    // computes FSRS exactly as for any other review.
    for (const [args] of h.submit.mock.calls) {
      expect(args).toMatchObject({ rating: "easy", source: "daily_review", isRelearnStep: false });
      expect(typeof args.flashcardId).toBe("string");
      expect(typeof args.clientRequestId).toBe("string");
    }
    expect(screen.getByText(/Complete/)).toBeTruthy();
  });
});

describe("subject Extra Study", () => {
  it("serves every unsuspended item of the subject, due or not, recorded as Extra Study", async () => {
    useLibrary();
    await openSession("mode=extra_study&section=psych_soc");
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(11);
    const tags = await studyAll();
    expect(tags.every((t) => t.startsWith("psych_soc/"))).toBe(true);
    expect(h.submit.mock.calls.every(([a]) => a.source === "extra_study")).toBe(true);
    // The suspended basic card in chapter 1 never appears.
    expect(tags).not.toContain("psych_soc/ch1/p2");
  });
});

describe("new items follow course order in a subject Review", () => {
  it("with 3 new items left today, takes them from chapter 1 in authored order", async () => {
    useLibrary();
    h.profile.daily_new_card_limit = 3;
    h.counts.reviewsToday = 150; // review allowance spent: only new items are served
    await openSession("mode=due&section=physics");
    const tags = await studyAll();
    expect(tags.sort()).toEqual(["physics/ch1/p1", "physics/ch1/p1", "physics/ch1/p1"]);
  });

  it("skips studied and suspended items and continues in course order", async () => {
    useLibrary();
    h.profile.daily_new_card_limit = 3;
    h.counts.reviewsToday = 150;
    await openSession("mode=due&section=psych_soc");
    const tags = await studyAll();
    // ch1: card 1 blank 3, then card 3 blanks 1 and 2. Card 2 is suspended.
    expect(tags.sort()).toEqual(["psych_soc/ch1/p1", "psych_soc/ch1/p3", "psych_soc/ch1/p3"]);
  });

  it("leaves the all-subject Daily Review on its existing order (by card id)", async () => {
    useLibrary();
    h.profile.daily_new_card_limit = 3;
    h.counts.reviewsToday = 150;
    await openSession("mode=due");
    const tags = await studyAll();
    // Lowest card ids in the library: Biochemistry chapter 1's position-3 card
    // (2 blanks) and position-2 card, NOT its position-1 card.
    expect(tags.sort()).toEqual(["biochemistry/ch1/p2", "biochemistry/ch1/p3", "biochemistry/ch1/p3"]);
  });
});

describe("daily limits, shared by every subject", () => {
  it("only the new-item limit spent: a subject Review serves its due reviews only", async () => {
    useLibrary();
    h.counts.newToday = 25;
    await openSession("mode=due&section=psych_soc");
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(2);
    const tags = await studyAll();
    expect(tags.sort()).toEqual(["psych_soc/ch1/p1", "psych_soc/ch2/p1"]);
  });

  it("only the review limit spent: serves new items only", async () => {
    useLibrary();
    h.counts.reviewsToday = 150;
    await openSession("mode=due&section=psych_soc");
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(8);
  });

  it("both spent: explains the shared allowance and offers this subject's Extra Study", async () => {
    useLibrary();
    h.counts = { newToday: 25, reviewsToday: 150, attemptsToday: 175, extraStudyAttemptsToday: 0 };
    await openSession("mode=due&section=psych_soc");
    expect(screen.getByText("You're all caught up")).toBeTruthy();
    expect(screen.getByText(/shared by every subject, so studying Psych \/ Soc draws/)).toBeTruthy();
    expect(screen.getByText("Extra Study").closest("a")?.getAttribute("href")).toBe(
      "/dashboard/flashcards/session?mode=extra_study&section=psych_soc",
    );
  });

  it("two tabs opened together each serve today's whole remainder (known, not new: the server enforces no quota)", async () => {
    useLibrary();
    h.profile.daily_new_card_limit = 5;
    h.params = new URLSearchParams("mode=due&section=psych_soc");
    render(<SessionPage />);
    render(<SessionPage />);
    await waitFor(() => expect(screen.getAllByTestId("surface")).toHaveLength(2));
    const totals = screen.getAllByTestId("surface").map((s) => Number(s.dataset.total));
    expect(totals).toEqual([7, 7]); // each: 5 new + 2 due; 10 new between them against a limit of 5
  });
});

describe("a subject that cannot be served safely shows a message, never the whole library", () => {
  it.each(["section=astrology", "section="])("an unknown or empty subject (%s)", async (q) => {
    const fake = useLibrary();
    await openSession(`mode=due&${q}`);
    expect(screen.getByText("Subject not found")).toBeTruthy();
    expect(screen.queryByTestId("surface")).toBeNull();
    expect(fake.calls.some((c) => c.table === "flashcards")).toBe(false);
  });

  it.each([
    ["the deck list", "flashcard_decks"],
    ["a page of cards", "flashcards"],
    ["the student's progress", "flashcard_user_state"],
  ])("a failed read of %s", async (_, table) => {
    useLibrary({ fail: (q) => q.table === table });
    await openSession("mode=due&section=psych_soc");
    expect(screen.getByText("Couldn't load Psych / Soc")).toBeTruthy();
    expect(screen.queryByTestId("surface")).toBeNull();
  });

  it("a subject with no decks says there is nothing to study", async () => {
    const tables = makeLibrary();
    tables.flashcard_decks = tables.flashcard_decks.filter((d) => d.section !== "physics");
    useLibrary({}, tables);
    await openSession("mode=due&section=physics");
    expect(screen.getByText("Nothing in Physics is due right now.")).toBeTruthy();
  });
});

describe("stale requests", () => {
  it("switching subject while the first is still loading never shows the first subject's cards", async () => {
    const hold = deferred();
    useLibrary({
      delay: (q) => (q.eqs.some(([c, v]) => c === "section" && v === "psych_soc") ? hold.promise : undefined),
    });
    h.params = new URLSearchParams("mode=due&section=psych_soc");
    const view = render(<SessionPage />);
    h.params = new URLSearchParams("mode=due&section=physics");
    view.rerender(<SessionPage />);
    await waitFor(() => expect(screen.getByTestId("surface")).toBeTruthy());
    await act(async () => {
      hold.release();
      await hold.promise;
    });
    expect(screen.getAllByTestId("surface")).toHaveLength(1);
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(12);
    const tags = await studyAll();
    expect(tags.every((t) => t.startsWith("physics/"))).toBe(true);
  });

  it("a limit change while loading: the older load, finishing last, is ignored", async () => {
    const hold = deferred();
    let held = false;
    useLibrary({
      delay: (q) => {
        if (q.table === "flashcard_decks" && !held) {
          held = true;
          return hold.promise;
        }
      },
    });
    h.params = new URLSearchParams("mode=due&section=psych_soc");
    const view = render(<SessionPage />);
    h.profile = { ...h.profile, daily_new_card_limit: 1 };
    view.rerender(<SessionPage />);
    await waitFor(() => expect(screen.getByTestId("surface")).toBeTruthy());
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(3); // 1 new + 2 due
    await act(async () => {
      hold.release();
      await hold.promise;
    });
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(3); // not 10 from the stale load
  });
});

describe("from the Flashcards page to the session", () => {
  async function openHub() {
    render(<FlashcardsHub />);
    await waitFor(() => expect(screen.getByText("Psych / Soc")).toBeTruthy());
    await waitFor(() => expect(screen.queryByText("Loading library…")).toBeNull());
    await act(async () => {
      fireEvent.click(screen.getByText("Psych / Soc"));
    });
  }

  it("the box's count is exactly what the session then serves", async () => {
    useLibrary();
    await openHub();
    expect(screen.getByText("10 to study today")).toBeTruthy();
    expect(screen.getByText(/8 new, 2 reviews\./)).toBeTruthy();
    expect(screen.getByText("1 review is also due in other subjects.")).toBeTruthy();
    const href = screen.getByText("Review", { selector: "a" }).getAttribute("href")!;
    expect(href).toBe("/dashboard/flashcards/session?mode=due&section=psych_soc");
    cleanup();
    await openSession(href.split("?")[1]);
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(10);
  });

  it("with only the new-item limit spent, the box says so and the session agrees", async () => {
    useLibrary();
    h.counts.newToday = 25;
    await openHub();
    expect(screen.getByText("2 to study today")).toBeTruthy();
    expect(screen.getByText(/new-card limit is used up, so no new ones/)).toBeTruthy();
    expect(screen.queryByText(/Both daily limits/)).toBeNull();
    cleanup();
    await openSession("mode=due&section=psych_soc");
    expect(Number(screen.getByTestId("surface").dataset.total)).toBe(2);
  });

  it("with both limits spent, Review is unavailable and Extra Study still links to the subject", async () => {
    useLibrary();
    h.counts = { newToday: 25, reviewsToday: 150, attemptsToday: 175, extraStudyAttemptsToday: 0 };
    await openHub();
    expect(screen.getByText("Both daily limits are used up")).toBeTruthy();
    expect(screen.queryByText("Review", { selector: "a" })).toBeNull();
    expect(
      screen.getAllByText("Extra Study", { selector: "a" }).some(
        (a) => a.getAttribute("href") === "/dashboard/flashcards/session?mode=extra_study&section=psych_soc",
      ),
    ).toBe(true);
  });
});
