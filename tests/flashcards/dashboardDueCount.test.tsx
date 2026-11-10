// @vitest-environment jsdom
//
// The REAL dashboard, against an in-memory database: its "Flashcard reviews:
// N are due" line must leave out rows for blanks a card no longer has, the
// same rule as the Flashcards page and the study sessions.

import { afterEach, describe, expect, it, vi } from "vitest";
import { cleanup, render, screen, waitFor } from "@testing-library/react";
import type { ReactNode } from "react";
import { fakeSupabase } from "@/tests/helpers/fakeSupabase";
import { PAST, USER, cardId, makeLibrary } from "@/tests/helpers/flashcardFixture";

const h = vi.hoisted(() => ({ client: null as unknown, reviewLimit: 150 }));
vi.mock("@/lib/supabase", () => ({ get supabase() { return h.client; } }));
vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), replace: vi.fn(), back: vi.fn(), prefetch: vi.fn() }),
  useSearchParams: () => new URLSearchParams(),
  usePathname: () => "/dashboard",
}));
vi.mock("next/link", () => ({
  default: ({ href, children, ...rest }: { href: string; children: ReactNode }) => <a href={href} {...rest}>{children}</a>,
}));
vi.mock("@/components/dashboard/DashboardShell", () => ({
  useDashboard: () => ({
    user: { id: USER, email: "u1@example.test" },
    profile: { id: USER, first_name: "Test", daily_new_card_limit: 25, daily_review_limit: h.reviewLimit, day_start_hour: 4, weekly_question_goal: 100, mcat_test_date: null, study_hours_per_week: null },
    refreshProfile: vi.fn(),
  }),
}));
vi.mock("@/lib/flashcards/quota", () => ({
  countTodaysReviews: vi.fn(async () => ({ newToday: 0, reviewsToday: 0, attemptsToday: 0, extraStudyAttemptsToday: 0 })),
}));
vi.mock("@/components/dashboard/MolecularBg", () => ({ default: () => null }));

import DashboardPage from "@/app/dashboard/page";

afterEach(() => {
  h.reviewLimit = 150;
  cleanup();
  vi.unstubAllGlobals();
});

async function dueLine(tables: ReturnType<typeof makeLibrary>) {
  h.client = fakeSupabase({ ...tables, question_attempts: [], daily_activity: [], questions: [], review_schedule: [] });
  vi.stubGlobal("fetch", vi.fn(async () => new Response(JSON.stringify({}), { status: 503 })));
  render(<DashboardPage />);
  await waitFor(() => expect(screen.getByText(/are due\. Your limit is/)).toBeTruthy(), { timeout: 4000 });
  return screen.getByText(/are due\. Your limit is/).textContent;
}

describe("the dashboard's flashcard due count", () => {
  it("leaves out the orphan row (3 due reviews in the test library, not 4)", async () => {
    // The line names the number only when it is over the daily limit, so set a limit of 2.
    h.reviewLimit = 2;
    expect(await dueLine(makeLibrary())).toBe("3 are due. Your limit is 2 a day.");
  });

  it("writes large counts with a thousands separator", async () => {
    const tables = makeLibrary();
    for (let i = 0; i < 1200; i++) {
      tables.flashcards.push({ ...tables.flashcards[1], id: `zz-${String(i).padStart(4, "0")}` });
      tables.flashcard_user_state.push({ ...tables.flashcard_user_state[0], flashcard_id: `zz-${String(i).padStart(4, "0")}`, cloze_index: 0, next_review_at: PAST });
    }
    expect(await dueLine(tables)).toMatch(/^1,203 are due\./);
  });
});

void cardId;
