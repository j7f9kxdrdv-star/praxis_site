import { describe, it, expect } from "vitest";
import {
  buildSeries,
  segments,
  granularityFor,
  evidenceFor,
  localDayKey,
  LOW_SAMPLE,
  type SeriesAttempt,
} from "./dailySeries";

/** n attempts on one local day, `correct` of them right. */
const on = (day: string, correct: number, n: number, section = "bio_biochem"): SeriesAttempt[] =>
  Array.from({ length: n }, (_, i) => ({
    createdAt: `${day}T10:${String(i % 60).padStart(2, "0")}:00`,
    isCorrect: i < correct,
    section,
    isFirstAttempt: true,
  }));

const range = { from: "2026-09-01", to: "2026-09-10", section: "all" };

describe("A DAY WITH NO QUESTIONS IS NOT A DAY AT ZERO PERCENT", () => {
  // The single most misleading thing a study chart can do: plot an empty day
  // as 0%, drawing a line that falls to the floor and climbs back, which reads
  // as a catastrophic session that never happened.
  it("carries an empty day as null, never as zero", () => {
    const s = buildSeries({ ...range, attempts: on("2026-09-03", 6, 10) });
    const quiet = s.points.find((p) => p.key === "2026-09-04")!;
    expect(quiet.accuracy).toBeNull();
    expect(quiet.total).toBe(0);
    // And a real zero is still a real zero.
    const zero = buildSeries({ ...range, attempts: on("2026-09-04", 0, 8) });
    expect(zero.points.find((p) => p.key === "2026-09-04")!.accuracy).toBe(0);
  });

  it("emits every day in the range, not only the studied ones", () => {
    const s = buildSeries({ ...range, attempts: on("2026-09-03", 6, 10) });
    expect(s.points).toHaveLength(10);
    expect(s.measured).toBe(1);
  });

  it("BREAKS THE LINE AT A GAP instead of drawing through it", () => {
    // A stroke crossing a gap asserts accuracy moved smoothly across days the
    // student did not study.
    const s = buildSeries({
      ...range,
      attempts: [...on("2026-09-01", 8, 10), ...on("2026-09-02", 7, 10), ...on("2026-09-09", 2, 10)],
    });
    const runs = segments(s.points);
    expect(runs).toHaveLength(2);
    expect(runs[0].map((p) => p.key)).toEqual(["2026-09-01", "2026-09-02"]);
    expect(runs[1].map((p) => p.key)).toEqual(["2026-09-09"]);
  });
});

describe("thin days are shown, not deleted", () => {
  it("keeps a one-question day", () => {
    const s = buildSeries({ ...range, attempts: on("2026-09-02", 1, 1) });
    const p = s.points.find((x) => x.key === "2026-09-02")!;
    expect(p.accuracy).toBe(100);
    expect(p.total).toBe(1);
  });

  it("labels it as limited evidence so it cannot pass for a full day", () => {
    expect(evidenceFor(1)).toBe("LIMITED");
    expect(evidenceFor(LOW_SAMPLE - 1)).toBe("LIMITED");
    expect(evidenceFor(LOW_SAMPLE)).toBe("ADEQUATE");
    expect(evidenceFor(0)).toBe("NONE");
  });
});

describe("granularity follows the span", () => {
  it("uses days for the ranges a student actually explores", () => {
    expect(granularityFor(7)).toBe("day");
    expect(granularityFor(30)).toBe("day");
    expect(granularityFor(60)).toBe("day");
  });

  it("aggregates only when daily stops being readable", () => {
    expect(granularityFor(200)).toBe("week");
    expect(granularityFor(900)).toBe("month");
  });

  it("DAILY DETAIL IS NOT LOST, only the current view aggregates", () => {
    // Same attempts, two ranges. The short one still resolves to days.
    const attempts = [...on("2026-09-01", 5, 10), ...on("2026-09-02", 9, 10)];
    const wide = buildSeries({ attempts, from: "2024-01-01", to: "2026-09-10", section: "all" });
    const narrow = buildSeries({ attempts, from: "2026-09-01", to: "2026-09-10", section: "all" });
    expect(wide.granularity).not.toBe("day");
    expect(narrow.granularity).toBe("day");
    expect(narrow.points.find((p) => p.key === "2026-09-02")!.accuracy).toBe(90);
  });

  it("never returns an unbounded number of points", () => {
    const s = buildSeries({ attempts: [], from: "2015-01-01", to: "2026-09-10", section: "all" });
    expect(s.points.length).toBeLessThan(200);
  });
});

describe("section filtering recomputes each bucket", () => {
  const attempts = [
    ...on("2026-09-02", 8, 10, "bio_biochem"),
    ...on("2026-09-02", 2, 10, "chem_phys"),
  ];

  it("uses only the chosen section's questions", () => {
    const all = buildSeries({ ...range, attempts });
    const bio = buildSeries({ ...range, attempts, section: "bio_biochem" });
    const chem = buildSeries({ ...range, attempts, section: "chem_phys" });
    expect(all.points.find((p) => p.key === "2026-09-02")!.accuracy).toBe(50);
    expect(bio.points.find((p) => p.key === "2026-09-02")!.accuracy).toBe(80);
    expect(chem.points.find((p) => p.key === "2026-09-02")!.accuracy).toBe(20);
  });

  it("splits a bucket only where a section earns it", () => {
    const s = buildSeries({ ...range, attempts });
    expect(s.points.find((p) => p.key === "2026-09-02")!.sections).toHaveLength(2);
    const thin = buildSeries({
      ...range,
      attempts: [...on("2026-09-02", 8, 10, "bio_biochem"), ...on("2026-09-02", 1, 2, "chem_phys")],
    });
    expect(thin.points.find((p) => p.key === "2026-09-02")!.sections.map((x) => x.section)).toEqual([
      "bio_biochem",
    ]);
  });
});

describe("what counts as evidence", () => {
  it("excludes repeat attempts", () => {
    const repeats = on("2026-09-02", 10, 10).map((a) => ({ ...a, isFirstAttempt: false }));
    const s = buildSeries({ ...range, attempts: [...on("2026-09-02", 4, 10), ...repeats] });
    const p = s.points.find((x) => x.key === "2026-09-02")!;
    expect(p.total).toBe(10);
    expect(p.correct).toBe(4);
  });

  it("keeps a late-evening attempt on the day it happened", () => {
    // Local day keys, so 23:30 does not roll into tomorrow via UTC.
    const late: SeriesAttempt[] = [
      { createdAt: "2026-09-03T23:30:00", isCorrect: true, section: "bio_biochem", isFirstAttempt: true },
    ];
    const s = buildSeries({ ...range, attempts: late });
    expect(s.points.find((p) => p.key === "2026-09-03")!.total).toBe(1);
    expect(localDayKey(new Date("2026-09-03T23:30:00"))).toBe("2026-09-03");
  });

  it("ignores attempts outside the range", () => {
    const s = buildSeries({ ...range, attempts: on("2026-08-01", 5, 10) });
    expect(s.measured).toBe(0);
  });
});
