import { describe, it, expect } from "vitest";
import { backfill, studyDayEndIso, studyDaysFrom, type HistoricalAttempt } from "./backfill";

const DAY_START = 4;

/** n attempts on one topic at a given local time, `correct` of them right. */
function made(
  topic: string,
  correct: number,
  n: number,
  isoDay: string,
  hour = 10,
): HistoricalAttempt[] {
  return Array.from({ length: n }, (_, i) => ({
    questionId: `${topic}-${isoDay}-${i}`,
    topic,
    section: "bio_biochem",
    isCorrect: i < correct,
    createdAt: new Date(`${isoDay}T${String(hour).padStart(2, "0")}:00:00Z`).toISOString(),
    isFirstAttempt: true,
  }));
}

describe("the historical cutoff", () => {
  it("ends a study day at the day-start hour of the NEXT day", () => {
    const end = studyDayEndIso("2026-09-01", DAY_START);
    // Not midnight: an evening session must belong to the day it happened on.
    expect(new Date(end).getTime()).toBeGreaterThan(new Date("2026-09-02T00:00:00").getTime());
  });

  it("FUTURE ATTEMPTS ARE INVISIBLE TO A PAST SNAPSHOT", () => {
    // The failure this guards: if 5 September's evidence leaks into the
    // 1 September state, the diff between them shows nothing happening and the
    // transition is erased.
    const attempts = [
      ...made("Enzymes", 4, 20, "2026-09-01"),
      ...made("Enzymes", 20, 20, "2026-09-05"),
    ];
    const r = backfill({
      attempts,
      studyDays: ["2026-09-01", "2026-09-05"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    });
    const sep1 = r.snapshots[0].topics.find((t) => t.topic === "Enzymes")!;
    // Only the twenty from the first, of which four were right.
    expect(sep1.attempts).toBe(20);
    expect(sep1.correct).toBe(4);

    const sep5 = r.snapshots[1].topics.find((t) => t.topic === "Enzymes")!;
    expect(sep5.attempts).toBe(40);
  });

  it("keeps a late-evening attempt on the day it happened", () => {
    // 11pm on the 1st is still the 1st, because the day rolls at 4am.
    const attempts = made("Enzymes", 8, 10, "2026-09-01", 23);
    const days = studyDaysFrom(attempts, DAY_START);
    expect(days).toEqual(["2026-09-01"]);
  });

  it("puts a 2am attempt on the previous study day", () => {
    const attempts = made("Enzymes", 8, 10, "2026-09-02", 2);
    expect(studyDaysFrom(attempts, DAY_START)).toEqual(["2026-09-01"]);
  });

  it("produces no snapshot for a day with no activity", () => {
    const attempts = [...made("Enzymes", 5, 10, "2026-09-01"), ...made("Enzymes", 5, 10, "2026-09-08")];
    expect(studyDaysFrom(attempts, DAY_START)).toEqual(["2026-09-01", "2026-09-08"]);
  });
});

describe("backfill correctness", () => {
  const attempts = [
    ...made("Enzymes", 4, 20, "2026-09-01"),
    ...made("Enzymes", 58, 60, "2026-09-05"),
    ...made("Kinetics", 3, 12, "2026-09-05"),
  ];
  const days = ["2026-09-01", "2026-09-05"];
  const run = () =>
    backfill({ attempts, studyDays: days, totalQuestions: 1000, dayStartHour: DAY_START });

  it("is deterministic: two runs give identical output", () => {
    expect(JSON.stringify(run())).toBe(JSON.stringify(run()));
  });

  it("is idempotent: dedupe keys repeat exactly across runs", () => {
    const a = run().events.map((e) => e.dedupeKey);
    const b = run().events.map((e) => e.dedupeKey);
    expect(a).toEqual(b);
    expect(new Set(a).size).toBe(a.length);
  });

  it("produces no events for the first day", () => {
    // Nothing to diff against, so nothing changed.
    const r = run();
    expect(r.events.every((e) => e.occurredOn !== "2026-09-01")).toBe(true);
  });

  it("A TOPIC BECOMING MEASURABLE IS NOT AN IMPROVEMENT", () => {
    // Kinetics appears for the first time on the 5th. It must produce no
    // improvement event, however good its numbers are.
    const r = run();
    const kinetics = r.events.filter((e) => e.subjectId === "Kinetics");
    expect(kinetics.filter((e) => e.type === "TOPIC_PERFORMANCE_IMPROVED")).toHaveLength(0);
  });

  it("records a genuine improvement across days", () => {
    const r = run();
    const improved = r.events.filter(
      (e) => e.type === "TOPIC_PERFORMANCE_IMPROVED" && e.subjectId === "Enzymes",
    );
    expect(improved).toHaveLength(1);
    expect(improved[0].occurredOn).toBe("2026-09-05");
  });

  it("resuming mid-run rebuilds the same days to the same values", () => {
    const full = run();
    // Restart from the second day, seeded by the first day's reconstruction.
    const partial = backfill({
      attempts,
      studyDays: ["2026-09-05"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    });
    const fullSep5 = full.snapshots.find((s) => s.studyDay === "2026-09-05")!;
    const partSep5 = partial.snapshots[0];
    // The state itself is identical; only the transitions differ, because a
    // resumed run has no previous day in memory to diff against.
    expect(partSep5.topics.map((t) => [t.topic, t.attempts, t.correct])).toEqual(
      fullSep5.topics.map((t) => [t.topic, t.attempts, t.correct]),
    );
  });

  it("never counts a repeat attempt as evidence", () => {
    const withRepeats: HistoricalAttempt[] = [
      ...made("Enzymes", 4, 20, "2026-09-01"),
      ...made("Enzymes", 10, 10, "2026-09-01").map((a) => ({ ...a, isFirstAttempt: false })),
    ];
    const r = backfill({
      attempts: withRepeats,
      studyDays: ["2026-09-01"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    });
    expect(r.snapshots[0].topics[0].attempts).toBe(20);
  });

  it("counts coverage from all attempts, including repeats", () => {
    // Coverage is what was ENCOUNTERED. A repeat is still an encounter, even
    // though it is not evidence of ability.
    const r = run();
    expect(r.snapshots[1].coverageAttempted).toBeGreaterThan(
      r.snapshots[0].coverageAttempted,
    );
  });

  it("stamps a version on the result", () => {
    expect(run().version).toMatch(/^\d+\.\d+\.\d+$/);
  });
});

describe("current-day recompute", () => {
  it("a morning and an evening session give one snapshot holding both", () => {
    // 10 attempts at 8am, 20 more at 6pm, same study day. The day's snapshot
    // must reflect all 30, not the 10 that existed when it was first built.
    const morning = made("Enzymes", 4, 10, "2026-09-10", 8);
    const evening = made("Enzymes", 16, 20, "2026-09-10", 18);

    const atNoon = backfill({
      attempts: morning,
      studyDays: ["2026-09-10"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    });
    expect(atNoon.snapshots[0].topics[0].attempts).toBe(10);

    const atNight = backfill({
      attempts: [...morning, ...evening],
      studyDays: ["2026-09-10"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    });
    expect(atNight.snapshots[0].topics[0].attempts).toBe(30);
    expect(atNight.snapshots[0].topics[0].correct).toBe(20);
  });

  it("recomputing the same day twice produces the same dedupe keys", () => {
    const attempts = [
      ...made("Enzymes", 4, 20, "2026-09-01"),
      ...made("Enzymes", 30, 40, "2026-09-10"),
    ];
    const args = {
      attempts,
      studyDays: ["2026-09-01", "2026-09-10"],
      totalQuestions: 1000,
      dayStartHour: DAY_START,
    };
    const first = backfill(args).events.map((e) => e.dedupeKey);
    const second = backfill(args).events.map((e) => e.dedupeKey);
    expect(first).toEqual(second);
    // Which is what makes the upsert a no-op rather than a duplicate.
    expect(new Set([...first, ...second]).size).toBe(first.length);
  });
});
