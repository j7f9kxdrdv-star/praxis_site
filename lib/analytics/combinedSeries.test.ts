import { describe, it, expect } from "vitest";
import {
  buildCombinedSeries,
  runsFor,
  bridgesFor,
  quietCount,
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

// ─── Bridging the days nobody studied ────────────────────────────────────────
//
// The line used to stop dead at every rest day, so a student who took a weekend
// off saw a chart in pieces. A bridge joins the two real observations either
// side of the gap. It carries no value of its own, and these tests exist to
// keep it that way: the moment a bridge starts producing numbers it has stopped
// being a drawing and started being a measurement nobody took.

describe("A GAP IS BRIDGED, NOT FILLED", () => {
  it("leaves consecutive measured days alone", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-03", 5, 10), ...q("2026-09-04", 7, 10)],
      daily: [],
    });
    expect(runsFor(s.points, "questions")).toHaveLength(1);
    expect(bridgesFor(s.points, "questions")).toEqual([]);
  });

  it("bridges a single missing day", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-03", 5, 10), ...q("2026-09-05", 8, 10)],
      daily: [],
    });
    const [b] = bridgesFor(s.points, "questions");
    expect(b.missing).toBe(1);
    expect(b.fromValue).toBe(50);
    expect(b.toValue).toBe(80);
    expect(s.points[b.toIndex].key).toBe("2026-09-05");
  });

  it("bridges several missing days with one segment", () => {
    // Sep 8 at 55, nothing on the 9th or 10th, Sep 11 at 72: one join, two
    // unmeasured days inside it, and no third point anywhere.
    const s = buildCombinedSeries({
      from: "2026-09-06",
      to: "2026-09-12",
      section: "all",
      attempts: [...q("2026-09-08", 11, 20), ...q("2026-09-11", 18, 25)],
      daily: [],
    });
    const bridges = bridgesFor(s.points, "questions");
    expect(bridges).toHaveLength(1);
    expect(bridges[0].missing).toBe(2);
    expect(bridges[0].fromValue).toBe(55);
    expect(bridges[0].toValue).toBe(72);
  });

  it("puts no data point on a bridged day", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-03", 5, 10), ...q("2026-09-06", 8, 10)],
      daily: [],
    });
    const drawn = runsFor(s.points, "questions").flat().map((r) => r.index);
    const bridge = bridgesFor(s.points, "questions")[0];
    for (let i = bridge.fromIndex + 1; i < bridge.toIndex; i++) {
      expect(drawn).not.toContain(i);
      expect(s.points[i].questions.value).toBeNull();
    }
  });

  it("never carries a value forward into the gap", () => {
    const s = buildCombinedSeries({
      from: "2026-09-06",
      to: "2026-09-12",
      section: "all",
      attempts: [...q("2026-09-08", 11, 20), ...q("2026-09-11", 18, 25)],
      daily: [],
    });
    for (const key of ["2026-09-09", "2026-09-10"]) {
      const p = s.points.find((x) => x.key === key)!;
      expect(p.questions.value).toBeNull();
      expect(p.questions.value).not.toBe(55);
      expect(p.questions.numerator).toBe(0);
      expect(p.questions.denominator).toBe(0);
    }
  });

  it("interpolates nothing: every non-null value has attempts behind it", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-02", 3, 10), ...q("2026-09-07", 9, 10)],
      daily: [r("2026-09-04", 8, 10)],
    });
    for (const p of s.points) {
      if (p.questions.value !== null) expect(p.questions.denominator).toBeGreaterThan(0);
      if (p.flashcards.value !== null) expect(p.flashcards.denominator).toBeGreaterThan(0);
    }
  });

  it("lets one series bridge while the other stays whole", () => {
    // Questions rest on the 4th, cards do not. The two histories are separate.
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-03", 5, 10), ...q("2026-09-05", 6, 10)],
      daily: [r("2026-09-03", 8, 10), r("2026-09-04", 7, 10), r("2026-09-05", 9, 10)],
    });
    expect(bridgesFor(s.points, "questions")).toHaveLength(1);
    expect(bridgesFor(s.points, "flashcards")).toEqual([]);
  });

  it("treats a low-sample day as a real observation, not a gap", () => {
    // 1 of 1 is thin evidence and a genuine measurement. Confusing the two is
    // how a real study day gets erased for looking inconvenient.
    const s = buildCombinedSeries({
      ...base,
      attempts: [...q("2026-09-03", 5, 10), ...q("2026-09-04", 1, 1), ...q("2026-09-05", 6, 10)],
      daily: [],
    });
    const thin = s.points.find((x) => x.key === "2026-09-04")!;
    expect(thin.questions.value).toBe(100);
    expect(thin.questions.evidence).toBe("LIMITED");
    expect(bridgesFor(s.points, "questions")).toEqual([]);
    expect(runsFor(s.points, "questions")).toHaveLength(1);
  });

  it("bridges weekly buckets the same way when the range is long", () => {
    const long = { from: "2026-01-01", to: "2026-06-30", section: "all" };
    const s = buildCombinedSeries({
      ...long,
      attempts: [...q("2026-01-05", 5, 10), ...q("2026-03-16", 8, 10)],
      daily: [],
    });
    expect(s.granularity).not.toBe("day");
    const bridges = bridgesFor(s.points, "questions");
    expect(bridges).toHaveLength(1);
    expect(bridges[0].missing).toBeGreaterThan(0);
    // The skipped buckets stay empty. Aggregation does not invent a period.
    for (let i = bridges[0].fromIndex + 1; i < bridges[0].toIndex; i++) {
      expect(s.points[i].questions.value).toBeNull();
    }
  });

  it("counts quiet buckets per modality", () => {
    const s = buildCombinedSeries({
      ...base,
      attempts: q("2026-09-03", 5, 10),
      daily: [r("2026-09-03", 8, 10), r("2026-09-04", 7, 10)],
    });
    expect(quietCount(s.points, "questions")).toBe(s.points.length - 1);
    expect(quietCount(s.points, "flashcards")).toBe(s.points.length - 2);
  });

  it("has no bridge to draw when a series was never measured", () => {
    const s = buildCombinedSeries({ ...base, attempts: [], daily: [] });
    expect(bridgesFor(s.points, "questions")).toEqual([]);
    expect(runsFor(s.points, "questions")).toEqual([]);
  });
});
