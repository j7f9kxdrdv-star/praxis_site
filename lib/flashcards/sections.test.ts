import { describe, expect, it } from "vitest";
import {
  SECTIONS,
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
  it("is false when no subject was asked for, so the whole library is right", () => {
    expect(sectionParamProblem(null)).toBe(false);
    expect(sectionParamProblem("")).toBe(false);
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
      limitReached: false,
    });
  });

  it("caps new cards and reviews separately, by what is left of the shared allowance", () => {
    expect(projectSubjectReview({ unseen: 300, dueReviews: 80, newLeftToday: 5, reviewsLeftToday: 20 })).toEqual({
      servedNew: 5,
      servedReview: 20,
      served: 25,
      limitReached: false,
    });
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
