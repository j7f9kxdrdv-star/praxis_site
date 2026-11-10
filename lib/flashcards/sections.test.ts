import { describe, expect, it } from "vitest";
import {
  SECTIONS,
  describeSubjectReview,
  parseSection,
  projectSubjectReview,
  sectionLabel,
  sectionParamProblem,
  sessionHref,
} from "./sections";

describe("parseSection", () => {
  it("accepts every subject the Flashcards page groups by", () => {
    for (const s of SECTIONS) expect(parseSection(s.id)).toBe(s.id);
  });

  it("returns null when absent", () => {
    expect(parseSection(null)).toBeNull();
    expect(parseSection(undefined)).toBeNull();
    expect(parseSection("")).toBeNull();
  });

  it("returns null for anything that is not a subject", () => {
    expect(parseSection("psych")).toBeNull();
    expect(parseSection("Psych / Soc")).toBeNull();
    expect(parseSection("psych_soc ")).toBeNull();
  });
});

describe("sectionParamProblem", () => {
  it("is false only when no subject was asked for at all, so the whole library is right", () => {
    expect(sectionParamProblem(null)).toBe(false);
    expect(sectionParamProblem(undefined)).toBe(false);
  });

  it("is true for an explicitly empty subject (?section=), which must not widen to the library", () => {
    expect(sectionParamProblem("")).toBe(true);
    expect(new URLSearchParams("mode=due&section=").get("section")).toBe("");
  });

  it("is true when an unknown subject was asked for, so the session must not widen", () => {
    expect(sectionParamProblem("astrology")).toBe(true);
  });

  it("is false for a real subject", () => {
    expect(sectionParamProblem("psych_soc")).toBe(false);
  });
});

describe("sectionLabel", () => {
  it("reads the label shown on the Flashcards page", () => {
    expect(sectionLabel("psych_soc")).toBe("Psych / Soc");
    expect(sectionLabel("organic_chemistry")).toBe("Organic Chemistry");
  });
});

describe("sessionHref", () => {
  it("keeps the existing whole-library URLs unchanged", () => {
    expect(sessionHref("due")).toBe("/dashboard/flashcards/session?mode=due");
    expect(sessionHref("extra_study", null)).toBe("/dashboard/flashcards/session?mode=extra_study");
  });

  it("adds the subject when one is given", () => {
    expect(sessionHref("due", "psych_soc")).toBe("/dashboard/flashcards/session?mode=due&section=psych_soc");
    expect(sessionHref("extra_study", "physics")).toBe(
      "/dashboard/flashcards/session?mode=extra_study&section=physics",
    );
  });

  it("round-trips through parseSection", () => {
    for (const s of SECTIONS) {
      const url = new URL(sessionHref("due", s.id), "https://example.test");
      expect(parseSection(url.searchParams.get("section"))).toBe(s.id);
      expect(url.searchParams.get("mode")).toBe("due");
    }
  });
});

describe("projectSubjectReview", () => {
  it("serves everything waiting when the allowance covers it", () => {
    expect(projectSubjectReview({ unseen: 10, dueReviews: 30, newLeftToday: 25, reviewsLeftToday: 150 })).toEqual({
      servedNew: 10,
      servedReview: 30,
      served: 40,
      newLimitUsed: false,
      reviewLimitUsed: false,
      limitReached: false,
    });
  });

  it("caps new cards and reviews separately, by what is left of the shared allowance", () => {
    expect(projectSubjectReview({ unseen: 300, dueReviews: 80, newLeftToday: 5, reviewsLeftToday: 20 })).toEqual({
      servedNew: 5,
      servedReview: 20,
      served: 25,
      newLimitUsed: false,
      reviewLimitUsed: false,
      limitReached: false,
    });
  });

  it("flags only the limit that is spent", () => {
    const onlyNew = projectSubjectReview({ unseen: 5, dueReviews: 5, newLeftToday: 0, reviewsLeftToday: 10 });
    expect([onlyNew.newLimitUsed, onlyNew.reviewLimitUsed, onlyNew.limitReached]).toEqual([true, false, false]);
    const onlyReview = projectSubjectReview({ unseen: 5, dueReviews: 5, newLeftToday: 10, reviewsLeftToday: 0 });
    expect([onlyReview.newLimitUsed, onlyReview.reviewLimitUsed, onlyReview.limitReached]).toEqual([false, true, false]);
  });

  it("does not call a limit spent when nothing of that kind is waiting", () => {
    const p = projectSubjectReview({ unseen: 0, dueReviews: 5, newLeftToday: 0, reviewsLeftToday: 10 });
    expect(p.newLimitUsed).toBe(false);
  });

  it("reports the limit reached when cards wait but nothing is left today", () => {
    expect(projectSubjectReview({ unseen: 4, dueReviews: 9, newLeftToday: 0, reviewsLeftToday: 0 }).limitReached).toBe(true);
  });

  it("does not report the limit reached when nothing is waiting", () => {
    const p = projectSubjectReview({ unseen: 0, dueReviews: 0, newLeftToday: 0, reviewsLeftToday: 0 });
    expect(p.served).toBe(0);
    expect(p.limitReached).toBe(false);
  });

  it("never goes negative when today's work already passed a lowered limit", () => {
    const p = projectSubjectReview({ unseen: 10, dueReviews: 10, newLeftToday: -5, reviewsLeftToday: -40 });
    expect(p.servedNew).toBe(0);
    expect(p.servedReview).toBe(0);
  });
});

describe("describeSubjectReview (the words on the box)", () => {
  const d = (unseen: number, dueReviews: number, newLeftToday: number, reviewsLeftToday: number, elsewhere = 0) =>
    describeSubjectReview(projectSubjectReview({ unseen, dueReviews, newLeftToday, reviewsLeftToday }), "Psych / Soc", elsewhere);

  it("with items to serve, counts them without calling blanks cards", () => {
    const r = d(10, 30, 25, 150);
    expect(r.headline).toBe("40 to study today");
    expect(r.detail).toContain("10 new, 30 reviews.");
    expect(r.detail).toContain("Review counts toward your daily limits");
    expect(r.headline).not.toMatch(/card/);
  });

  it("only the new-item limit spent, with reviews to serve: says so, and only that", () => {
    const r = d(10, 30, 0, 150);
    expect(r.headline).toBe("30 to study today");
    expect(r.detail).toContain("new-card limit is used up");
    expect(r.detail).not.toContain("review limit is used up");
    expect(r.detail).not.toMatch(/both/i);
  });

  it("only the review limit spent, with new items to serve: says so, and only that", () => {
    const r = d(10, 30, 25, 0);
    expect(r.headline).toBe("10 to study today");
    expect(r.detail).toContain("review limit is used up");
    expect(r.detail).not.toContain("new-card limit is used up");
  });

  it("nothing servable because only the new-item limit is spent: names that limit", () => {
    const r = d(10, 0, 0, 150);
    expect(r.headline).toBe("Today\u2019s new-card limit is used up");
    expect(r.detail).toContain("No Psych / Soc reviews are due.");
  });

  it("nothing servable because only the review limit is spent: names that limit", () => {
    const r = d(0, 30, 25, 0);
    expect(r.headline).toBe("Today\u2019s review limit is used up");
  });

  it("both spent with both kinds waiting: says both", () => {
    expect(d(10, 30, 0, 0).headline).toBe("Both daily limits are used up");
  });

  it("nothing waiting at all: says nothing is due", () => {
    expect(d(0, 0, 25, 150).headline).toBe("Nothing in Psych / Soc is due right now");
  });

  it("mentions reviews due in other subjects only when there are some", () => {
    expect(d(1, 1, 5, 5, 0).elsewhere).toBeNull();
    expect(d(1, 1, 5, 5, 1).elsewhere).toBe("1 review is also due in other subjects.");
    expect(d(1, 1, 5, 5, 140).elsewhere).toBe("140 reviews are also due in other subjects.");
  });
});
