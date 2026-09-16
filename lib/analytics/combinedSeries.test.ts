import { describe, it, expect } from "vitest";
import {
  buildCombinedSeries,
  runsFor,
  seriesCaption,
  LOW_RECALL_SAMPLE,
  type DailyRecallInput,
} from "./combinedSeries";
import type { SeriesAttempt } from "./dailySeries";

const q = (day: string, correct: number, n: number, section = "bio_biochem"): SeriesAttempt[] =>
  Array.from({ length: n }, (_, i) => ({
    createdAt: `${day}T10:${String(i % 60).padStart(2, "0")}:00`,
    isCorrect: i < correct,
    section,
    isFirstAttempt: true,
  }));

const r = (date: string, recalled: number, firstLooks: number, reviews = firstLooks): DailyRecallInput =>
  ({ date, recalled, firstLooks, reviews });

const base = { from: "2026-09-01", to: "2026-09-10", section: "all" };

describe("BOTH MEASURES SHARE A CALENDAR, NEITHER INVENTS A ZERO", () => {
  it("keeps a day that has questions but no reviews", () => {
    // "I did questions and no cards" is a real shape of day. Dropping it would
    // delete the comparison the chart exists to show.
    const s = buildCombinedSeries({ ...base, attempts: q("2026-09-03", 6, 10), daily: [] });
    const p = s.points.find((x) => x.key === "2026-09-03")!;
    expect(p.questions.value).toBe(60);
    expect(p.flashcards.value).toBeNull();
    expect(p.flashcards.denominator).toBe(0);
  });

  it("keeps a day that has reviews but no questions", () => {
    const s = buildCombinedSeries({ ...base, attempts: [], daily: [r("2026-09-03", 18, 24)] });
    const p = s.points.find((x) => x.key === "2026-09-03")!;
    expect(p.questions.value).toBeNull();
    expect(p.flashcards.value).toBe(75);
  });

  it("a silent day is null on BOTH sides, never zero", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: q("2026-09-02", 5, 10),
      daily: [r("2026-09-02", 8, 10)],
    });
    const quiet = s.points.find((x) => x.key === "2026-09-05")!;
    expect(quiet.questions.value).toBeNull();
    expect(quiet.flashcards.value).toBeNull();
  });

  it("a real zero is still a real zero on both sides", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: q("2026-09-02", 0, 8),
      daily: [r("2026-09-02", 0, 12)],
    });
    const p = s.points.find((x) => x.key === "2026-09-02")!;
    expect(p.questions.value).toBe(0);
    expect(p.flashcards.value).toBe(0);
  });

  it("breaks each line at its OWN gaps, independently", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-01", 5, 10), ...q("2026-09-09", 7, 10)],
      daily: [r("2026-09-01", 8, 10), r("2026-09-02", 9, 10)],
    });
    expect(runsFor(s.points, "questions")).toHaveLength(2);
    expect(runsFor(s.points, "flashcards")).toHaveLength(1);
  });
});

describe("the two series share buckets", () => {
  it("rolls recall up to the question granularity so the crosshair cannot lie", () => {
    // A long range aggregates. If the flashcard side stayed daily, one line
    // would be indexed by week and the other by day.
    const wide = { from: "2024-01-01", to: "2026-09-10", section: "all" };
    const s = buildCombinedSeries({
      ...wide,
      attempts: q("2026-09-02", 5, 10),
      daily: [r("2026-09-01", 5, 10), r("2026-09-02", 5, 10), r("2026-09-03", 10, 10)],
    });
    expect(s.granularity).not.toBe("day");
    // All three days fall in one aggregated bucket: 20 of 30 recalled.
    const withRecall = s.points.filter((p) => p.flashcards.value !== null);
    expect(withRecall).toHaveLength(1);
    expect(withRecall[0].flashcards.denominator).toBe(30);
    expect(withRecall[0].flashcards.value).toBe(67);
  });

  it("gives both modalities the same x for the same bucket", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: q("2026-09-04", 5, 10),
      daily: [r("2026-09-04", 5, 10)],
    });
    const p = s.points.find((x) => x.key === "2026-09-04")!;
    expect(p.questions.value).not.toBeNull();
    expect(p.flashcards.value).not.toBeNull();
    expect(p.xPct).toBeGreaterThan(0);
  });
});

describe("thin days are marked, not hidden", () => {
  it("shows a single question and calls the evidence limited", () => {
    const s = buildCombinedSeries({ ...base, attempts: q("2026-09-02", 1, 1), daily: [] });
    const p = s.points.find((x) => x.key === "2026-09-02")!;
    expect(p.questions.value).toBe(100);
    expect(p.questions.evidence).toBe("LIMITED");
  });

  it("marks a thin recall day without dropping it", () => {
    const thin = buildCombinedSeries({
      ...base, attempts: [], daily: [r("2026-09-02", 3, LOW_RECALL_SAMPLE - 1)],
    });
    const fat = buildCombinedSeries({
      ...base, attempts: [], daily: [r("2026-09-02", 30, LOW_RECALL_SAMPLE * 4)],
    });
    expect(thin.points.find((p) => p.key === "2026-09-02")!.flashcards.evidence).toBe("LIMITED");
    expect(fat.points.find((p) => p.key === "2026-09-02")!.flashcards.evidence).toBe("ADEQUATE");
  });

  it("REVIEWS ARE NOT FIRST LOOKS, and the rate uses first looks", () => {
    // 40 reviews of 10 distinct cards is 10 first looks. Dividing by reviews
    // would score a topic by how stubbornly it was retried.
    const s = buildCombinedSeries({ ...base, attempts: [], daily: [r("2026-09-02", 7, 10, 40)] });
    const p = s.points.find((x) => x.key === "2026-09-02")!;
    expect(p.flashcards.denominator).toBe(10);
    expect(p.flashcards.value).toBe(70);
  });
});

describe("the subject filter reaches the question series", () => {
  it("recomputes question accuracy from the chosen section only", () => {
    const attempts = [...q("2026-09-02", 8, 10, "bio_biochem"), ...q("2026-09-02", 2, 10, "chem_phys")];
    const all = buildCombinedSeries({ ...base, attempts, daily: [] });
    const cp = buildCombinedSeries({ ...base, attempts, daily: [], section: "chem_phys" });
    expect(all.points.find((p) => p.key === "2026-09-02")!.questions.value).toBe(50);
    expect(cp.points.find((p) => p.key === "2026-09-02")!.questions.value).toBe(20);
  });
});

describe("the caption describes what is drawn", () => {
  it("names the grain and the range", () => {
    expect(seriesCaption("day", "Last 30 days")).toBe("Daily performance · Last 30 days");
    expect(seriesCaption("week", "All time")).toBe("Weekly performance · All time");
    expect(seriesCaption("month", "All time")).toBe("Monthly performance · All time");
  });
});
