import { describe, it, expect } from "vitest";
import { buildSnapshot, deriveEvents, type SnapshotInput, type LearnerSnapshot } from "./snapshot";
import { recentProgress, progressSignals, MIN_PER_WINDOW } from "./recentProgress";

/** n attempts on one topic, `correct` of them right. */
const attempts = (topic: string, correct: number, n: number, section = "bio_biochem") =>
  Array.from({ length: n }, (_, i) => ({ topic, section, isCorrect: i < correct }));

const snap = (over: Partial<SnapshotInput> = {}): LearnerSnapshot =>
  buildSnapshot({
    studyDay: "2026-09-11",
    attempts: [],
    recentAccuracy: null,
    recentSampleSize: 0,
    coverageAttempted: 0,
    coverageTotal: 1000,
    memoryHealth: null,
    previous: null,
    ...over,
  });

describe("snapshots", () => {
  it("gives a barely-seen topic no state", () => {
    const s = snap({ attempts: attempts("Enzymes", 2, 3) });
    expect(s.topics[0].state).toBe("INSUFFICIENT_EVIDENCE");
    expect(s.topics[0].isPriority).toBe(false);
  });

  it("carries the previous state so hysteresis can apply", () => {
    const day1 = snap({ attempts: attempts("Enzymes", 14, 20) });
    const day2 = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 15, 22),
      previous: day1,
    });
    expect(day2.topics[0].state).toBe(day1.topics[0].state);
  });

  it("records which topics are priorities", () => {
    const s = snap({ attempts: attempts("Electrochemistry", 6, 30, "chem_phys") });
    expect(s.priorityTopics).toContain("Electrochemistry");
    expect(s.topics[0].reasons.length).toBeGreaterThan(0);
  });

  it("stamps both model versions", () => {
    const s = snap();
    expect(s.version).toMatch(/^\d+\.\d+\.\d+$/);
    expect(s.topicModelVersion).toMatch(/^\d+\.\d+\.\d+$/);
  });
});

describe("derived events", () => {
  it("produces nothing on the very first snapshot", () => {
    expect(deriveEvents(null, snap({ attempts: attempts("Enzymes", 18, 20) }))).toEqual([]);
  });

  it("A TOPIC APPEARING IS NOT AN IMPROVEMENT", () => {
    // The failure mode this guards: every new student would otherwise collect a
    // run of "improvements" for doing nothing but showing up.
    const day1 = snap({ attempts: [] });
    const day2 = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 19, 20),
      previous: day1,
    });
    const events = deriveEvents(day1, day2);
    expect(events.filter((e) => e.type === "TOPIC_PERFORMANCE_IMPROVED")).toHaveLength(0);
  });

  it("ONE LUCKY ANSWER PRODUCES NO EVENT", () => {
    const day1 = snap({ attempts: attempts("Enzymes", 11, 20) });
    const day2 = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 12, 21),
      previous: day1,
    });
    expect(deriveEvents(day1, day2)).toHaveLength(0);
  });

  it("records a real, sustained improvement", () => {
    const day1 = snap({ attempts: attempts("Enzymes", 8, 20) });
    const day2 = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 48, 60),
      previous: day1,
    });
    const e = deriveEvents(day1, day2).find((x) => x.type === "TOPIC_PERFORMANCE_IMPROVED");
    expect(e).toBeDefined();
    expect(e!.previousValue).toBe("NEEDS_ATTENTION");
    expect(e!.newValue).toBe("STABLE");
  });

  it("resolves a priority only on sufficient evidence, not on review", () => {
    const day1 = snap({ attempts: attempts("Electro", 6, 30, "chem_phys") });
    expect(day1.priorityTopics).toContain("Electro");

    // Two correct answers after opening it. Nothing resolves.
    const nudged = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Electro", 8, 32, "chem_phys"),
      previous: day1,
    });
    expect(
      deriveEvents(day1, nudged).filter((e) => e.type === "PRIORITY_TOPIC_RESOLVED"),
    ).toHaveLength(0);

    // Genuine sustained improvement does resolve it.
    const fixed = snap({
      studyDay: "2026-09-13",
      attempts: attempts("Electro", 50, 60, "chem_phys"),
      previous: day1,
    });
    expect(
      deriveEvents(day1, fixed).filter((e) => e.type === "PRIORITY_TOPIC_RESOLVED"),
    ).toHaveLength(1);
  });

  it("gives every event a dedupe key that repeats on a rebuild", () => {
    const day1 = snap({ attempts: attempts("Enzymes", 8, 20) });
    const day2in = {
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 48, 60),
      previous: day1,
    };
    const first = deriveEvents(day1, snap(day2in));
    const rebuild = deriveEvents(day1, snap(day2in));
    expect(first.map((e) => e.dedupeKey)).toEqual(rebuild.map((e) => e.dedupeKey));
    // Unique within a run, so one day cannot emit the same event twice.
    expect(new Set(first.map((e) => e.dedupeKey)).size).toBe(first.length);
  });

  it("priority events describe the flag, not the band", () => {
    // A topic can gain priority without changing state, so previous/new must
    // name the thing that actually changed.
    const day1 = snap({ attempts: attempts("Enzymes", 13, 22) });
    const day2 = snap({
      studyDay: "2026-09-12",
      attempts: attempts("Enzymes", 14, 28),
      previous: day1,
    });
    const added = deriveEvents(day1, day2).find((e) => e.type === "PRIORITY_TOPIC_ADDED");
    if (added) {
      expect(added.previousValue).toBe("NOT_PRIORITY");
      expect(added.newValue).toBe("PRIORITY");
      expect(added.metadata.state).toBeDefined();
    }
  });

  it("records coverage growing", () => {
    const day1 = snap({ coverageAttempted: 100 });
    const day2 = snap({ studyDay: "2026-09-12", coverageAttempted: 140, previous: day1 });
    const e = deriveEvents(day1, day2).find((x) => x.type === "CONTENT_COVERAGE_INCREASED");
    expect(e!.metadata.questionsAdded).toBe(40);
  });
});

describe("recent progress", () => {
  const base = {
    periodStart: "2026-09-04",
    periodEnd: "2026-09-11",
    currentCorrect: 0,
    currentN: 0,
    previousCorrect: 0,
    previousN: 0,
    questionsCompleted: 0,
    cardsReviewed: 0,
    lessonsCompleted: 0,
    coverageAtStart: 0,
    coverageAtEnd: 0,
    topicsImproved: 0,
    priorityAreasResolved: 0,
  };

  it("reports an empty period as empty rather than as zeros", () => {
    const p = recentProgress(base);
    expect(p.isEmpty).toBe(true);
    expect(p.evidenceLevel).toBe("NONE");
    expect(progressSignals(p)).toHaveLength(0);
  });

  it("REFUSES A DELTA WHEN ONE WINDOW IS THIN", () => {
    // Two questions this week against eighty last week would otherwise produce
    // a dramatic swing that says nothing about the student.
    const p = recentProgress({
      ...base,
      currentCorrect: 2,
      currentN: 2,
      previousCorrect: 48,
      previousN: 80,
      questionsCompleted: 2,
    });
    expect(p.accuracyDelta).toBeNull();
    expect(p.insufficientEvidence).toBe(true);
    expect(p.evidenceLevel).toBe("INSUFFICIENT");
  });

  it("refuses a delta when there is no previous window at all", () => {
    const p = recentProgress({ ...base, currentCorrect: 40, currentN: 60 });
    expect(p.accuracyDelta).toBeNull();
  });

  it("reports improvement when both windows carry evidence", () => {
    const p = recentProgress({
      ...base,
      currentCorrect: 55,
      currentN: 80,
      previousCorrect: 48,
      previousN: 80,
      questionsCompleted: 80,
    });
    expect(p.currentAccuracy).toBe(69);
    expect(p.previousAccuracy).toBe(60);
    expect(p.accuracyDelta).toBe(9);
    expect(p.evidenceLevel).toBe("ADEQUATE");
  });

  it("reports a decline just as readily", () => {
    const p = recentProgress({
      ...base,
      currentCorrect: 30,
      currentN: MIN_PER_WINDOW * 4,
      previousCorrect: 45,
      previousN: MIN_PER_WINDOW * 4,
    });
    expect(p.accuracyDelta).toBeLessThan(0);
  });

  it("carries topics improved and priorities resolved through from events", () => {
    const p = recentProgress({
      ...base,
      topicsImproved: 3,
      priorityAreasResolved: 1,
      questionsCompleted: 40,
    });
    const labels = progressSignals(p).map((s) => s.label);
    expect(labels).toContain("Topics improved");
    expect(labels).toContain("Priority areas resolved");
  });

  it("computes the coverage delta", () => {
    expect(recentProgress({ ...base, coverageAtStart: 8, coverageAtEnd: 12 }).coverageDelta).toBe(4);
  });

  it("shows at most four signals", () => {
    const p = recentProgress({
      ...base,
      currentCorrect: 55,
      currentN: 80,
      previousCorrect: 40,
      previousN: 80,
      questionsCompleted: 80,
      cardsReviewed: 900,
      lessonsCompleted: 2,
      topicsImproved: 3,
      priorityAreasResolved: 1,
    });
    expect(progressSignals(p).length).toBeLessThanOrEqual(4);
  });
});
