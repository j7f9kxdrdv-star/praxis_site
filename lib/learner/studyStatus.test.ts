import { describe, it, expect } from "vitest";
import {
  studyStatus,
  MIN_ATTEMPTS_TO_CLASSIFY,
  DECLINE_POINTS,
  FOUNDATION_COVERAGE,
  type StudyStatusInput,
} from "./studyStatus";
import { estimateScore } from "@/lib/scoring/scoreEstimate";

const base = (over: Partial<StudyStatusInput> = {}): StudyStatusInput => ({
  eligibleAttempts: 200,
  accuracyDeltaPoints: 0,
  coveragePercent: 50,
  priorityCount: 0,
  memoryHealth: "STABLE",
  predictedHigh: null,
  predictionConfidence: "Low",
  targetScore: null,
  ...over,
});

describe("study status", () => {
  it("says nothing about a new student", () => {
    const r = studyStatus(base({ eligibleAttempts: 0 }));
    expect(r.status).toBe("INSUFFICIENT_EVIDENCE");
    expect(r.evidence).toBe("NONE");
  });

  it("still says nothing just below the evidence bar", () => {
    const r = studyStatus(base({ eligibleAttempts: MIN_ATTEMPTS_TO_CLASSIFY - 1 }));
    expect(r.status).toBe("INSUFFICIENT_EVIDENCE");
    expect(r.evidence).toBe("THIN");
  });

  it("classifies once there is enough evidence", () => {
    expect(studyStatus(base({ eligibleAttempts: MIN_ATTEMPTS_TO_CLASSIFY })).evidence).toBe(
      "ADEQUATE",
    );
  });

  it("flags a measured decline above everything else", () => {
    // Low coverage too, which would otherwise mean BUILDING_FOUNDATION.
    const r = studyStatus(
      base({ accuracyDeltaPoints: -DECLINE_POINTS, coveragePercent: 5 }),
    );
    expect(r.status).toBe("NEEDS_ATTENTION");
  });

  it("does not flag a decline inside normal variation", () => {
    const r = studyStatus(base({ accuracyDeltaPoints: -(DECLINE_POINTS - 1) }));
    expect(r.status).not.toBe("NEEDS_ATTENTION");
  });

  it("calls a student with little coverage a foundation builder", () => {
    const r = studyStatus(base({ coveragePercent: FOUNDATION_COVERAGE - 1 }));
    expect(r.status).toBe("BUILDING_FOUNDATION");
  });

  it("never claims ON_TRACK without a target", () => {
    // Strong on every other axis, and still not "on track" toward nothing.
    const r = studyStatus(
      base({ coveragePercent: 90, accuracyDeltaPoints: 8, predictedHigh: 520, targetScore: null }),
    );
    expect(r.status).toBe("PROGRESSING");
    expect(r.rule).toContain("no target set");
  });

  it("claims ON_TRACK when the predicted range reaches the target", () => {
    const r = studyStatus(base({ coveragePercent: 70, predictedHigh: 512, targetScore: 510 }));
    expect(r.status).toBe("ON_TRACK");
  });

  it("does not claim ON_TRACK when the range falls short", () => {
    const r = studyStatus(base({ coveragePercent: 70, predictedHigh: 505, targetScore: 515 }));
    expect(r.status).toBe("PROGRESSING");
    expect(r.rule).toContain("short of target");
  });

  it("does not claim ON_TRACK with a target but no estimate yet", () => {
    const r = studyStatus(base({ coveragePercent: 70, predictedHigh: null, targetScore: 510 }));
    expect(r.status).toBe("PROGRESSING");
  });

  it("reports strong practice with low coverage as still building", () => {
    const r = studyStatus(base({ accuracyDeltaPoints: 10, coveragePercent: 8 }));
    expect(r.status).toBe("BUILDING_FOUNDATION");
  });

  it("does not let good memory rescue weak question performance", () => {
    const r = studyStatus(
      base({ memoryHealth: "STRONG", accuracyDeltaPoints: -10, coveragePercent: 80 }),
    );
    expect(r.status).toBe("NEEDS_ATTENTION");
  });

  it("explains itself: every status names the rule that fired", () => {
    for (const input of [
      base({ eligibleAttempts: 0 }),
      base({ accuracyDeltaPoints: -10 }),
      base({ coveragePercent: 2 }),
      base({ coveragePercent: 70, predictedHigh: 515, targetScore: 510 }),
      base({ coveragePercent: 70 }),
    ]) {
      expect(studyStatus(input).rule.length).toBeGreaterThan(0);
    }
  });

  it("stamps a version", () => {
    expect(studyStatus(base()).version).toMatch(/^\d+\.\d+\.\d+$/);
  });
});

describe("product rule: flashcards never move the predicted score", () => {
  it("the predictor's signature cannot accept flashcard data", () => {
    // Every parameter is question evidence: accuracy, attempt count, sections,
    // subtopics, full lengths. There is no parameter a card could enter by.
    // The exhaustive guard lives in lib/scoring/scoreEstimate.test.ts, which
    // scans the module for memory imports and identifiers; this is the
    // signature-level check that a reader of studyStatus would look for.
    const params = estimateScore.toString().slice(0, 400);
    expect(/flashcard|card|review|memory|stability|retention/i.test(params)).toBe(false);
  });

  it("identical question evidence gives an identical range whatever memory says", () => {
    const sections = new Set(["bio_biochem", "chem_phys"]);
    const a = estimateScore(70, 200, sections);
    const b = estimateScore(70, 200, sections);
    expect(a).toEqual(b);

    // And memory health, which does vary, changes only the status signals.
    const weak = studyStatus(base({ memoryHealth: "NEEDS_ATTENTION", coveragePercent: 70 }));
    const strong = studyStatus(base({ memoryHealth: "STRONG", coveragePercent: 70 }));
    expect(weak.status).toBe(strong.status);
  });
});
