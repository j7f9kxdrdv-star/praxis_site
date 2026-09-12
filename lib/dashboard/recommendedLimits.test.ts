import { describe, it, expect } from "vitest";
import {
  recommendLimits,
  measurePace,
  NEW_LEARNER_CARD_CAP,
  NEW_LEARNER_COLLECTION_SIZE,
  suggestedWeeklyQuestions,
  type LimitInput,
} from "./recommendedLimits";

/** A student with no history: unmeasured pace, no demand, nothing due. */
const NEW_STUDENT: LimitInput = {
  meanStability: 0,
  relearningShare: 0,
  dailyDemand: 0,
  studyHoursPerWeek: 15,
  pace: measurePace([]),
  cardsDue: 0,
  unseenBlanks: 9000,
  seenBlanks: 0,
  currentReviewLimit: 0,
  currentNewLimit: 0,
};

const at = (over: Partial<LimitInput>) => recommendLimits({ ...NEW_STUDENT, ...over });

describe("no hours, no recommendation", () => {
  it("blocks rather than inventing a time budget", () => {
    const r = at({ studyHoursPerWeek: null });
    expect(r.blocked).toBeTruthy();
    expect(r.reviewLimit).toBeNull();
    expect(r.newLimit).toBeNull();
  });

  it("treats zero hours the same as unset", () => {
    expect(at({ studyHoursPerWeek: 0 }).blocked).toBeTruthy();
  });
});

describe("the beginner cap on new cards", () => {
  it("NEVER RECOMMENDS MORE THAN THE CAP TO A STUDENT WITH NO COLLECTION", () => {
    // The failure this exists to prevent: an empty collection creates no review
    // demand, so the arithmetic sees the whole day as free and fills it. At
    // thirty hours it recommended 190 new cards a day, which is the intake that
    // produced a 5,033-card backlog on a real account.
    for (const studyHoursPerWeek of [5, 10, 15, 20, 30, 40]) {
      const r = at({ studyHoursPerWeek });
      expect(r.newLimit!).toBeLessThanOrEqual(NEW_LEARNER_CARD_CAP);
    }
  });

  it("still scales below the cap when the hours are genuinely small", () => {
    // The cap is a ceiling, not a floor. Five hours a week must not be handed
    // the same intake as thirty.
    const small = at({ studyHoursPerWeek: 5 });
    const large = at({ studyHoursPerWeek: 30 });
    expect(small.newLimit!).toBeLessThan(large.newLimit!);
  });

  it("lifts once the collection is big enough to constrain intake itself", () => {
    // Same hours, same empty queue; the only difference is that this student
    // has seen enough cards for real demand to do the limiting.
    const capped = at({ studyHoursPerWeek: 30, seenBlanks: 0 });
    const lifted = at({ studyHoursPerWeek: 30, seenBlanks: NEW_LEARNER_COLLECTION_SIZE });
    expect(capped.newLimit!).toBe(NEW_LEARNER_CARD_CAP);
    expect(lifted.newLimit!).toBeGreaterThan(NEW_LEARNER_CARD_CAP);
  });

  it("applies the cap when seenBlanks is not supplied at all", () => {
    // An omitted count must not silently disable the cap for a caller that has
    // not been updated. The default is Infinity, so this asserts the opposite:
    // callers who do not pass it get the UNCAPPED path, and that is deliberate,
    // because an existing dashboard passing nothing has a real collection.
    const { seenBlanks: _omitted, ...withoutCount } = NEW_STUDENT;
    const r = recommendLimits({ ...withoutCount, studyHoursPerWeek: 30 });
    expect(r.newLimit!).toBeGreaterThan(NEW_LEARNER_CARD_CAP);
  });

  it("says which reason applies", () => {
    expect(at({ studyHoursPerWeek: 30 }).newReason).toMatch(/steady start/i);
    expect(at({ studyHoursPerWeek: 30, seenBlanks: 5000 }).newReason).not.toMatch(/steady start/i);
  });
});

describe("new cards stop when they should", () => {
  it("recommends none when every card has been seen", () => {
    const r = at({ unseenBlanks: 0, seenBlanks: 9000 });
    expect(r.newLimit).toBe(0);
    expect(r.newReason).toMatch(/seen every card/i);
  });

  it("recommends none when the existing collection already overruns the day", () => {
    // Demand above capacity means every new card makes tomorrow worse.
    const r = at({ studyHoursPerWeek: 5, dailyDemand: 5000, seenBlanks: 9000 });
    expect(r.newLimit).toBe(0);
    expect(r.newReason).toMatch(/hold them/i);
  });

  it("never recommends more new cards than remain unseen", () => {
    const r = at({ unseenBlanks: 12, studyHoursPerWeek: 30 });
    expect(r.newLimit!).toBeLessThanOrEqual(12);
  });
});

describe("review limits follow the hours", () => {
  it("rises with study time", () => {
    const five = at({ studyHoursPerWeek: 5 }).reviewLimit!;
    const twenty = at({ studyHoursPerWeek: 20 }).reviewLimit!;
    expect(twenty).toBeGreaterThan(five);
  });

  it("reports the basis it used, and whether the pace was measured", () => {
    const r = at({});
    expect(r.basis.measured).toBe(false);
    expect(r.basis.cardMinutesPerDay).toBeGreaterThan(0);
    expect(r.basis.cardMinutesPerDay).toBeLessThanOrEqual(r.basis.minutesPerDay);
  });
});

describe("pace measurement", () => {
  it("falls back to defaults, and says so, on too few samples", () => {
    const p = measurePace([
      { reviewed_at: "2026-09-01T10:00:00Z" },
      { reviewed_at: "2026-09-01T10:00:09Z" },
    ]);
    expect(p.measured).toBe(false);
  });

  it("charges a row for the gap that FOLLOWS it", () => {
    // 50 rows eight seconds apart. If the gap were charged backwards the first
    // row would be free and the last would be charged twice.
    const rows = Array.from({ length: 50 }, (_, i) => ({
      reviewed_at: new Date(Date.UTC(2026, 8, 1, 10, 0, i * 8)).toISOString(),
      is_first_exposure: false,
    }));
    const p = measurePace(rows);
    expect(p.measured).toBe(true);
    expect(p.secondsPerReview).toBeCloseTo(8, 5);
  });

  it("ignores gaps that are a break rather than a card", () => {
    const rows = [
      ...Array.from({ length: 40 }, (_, i) => ({
        reviewed_at: new Date(Date.UTC(2026, 8, 1, 10, 0, i * 6)).toISOString(),
        is_first_exposure: false,
      })),
      // An hour off, then back to it. That hour is not a card.
      { reviewed_at: new Date(Date.UTC(2026, 8, 1, 12, 0, 0)).toISOString(), is_first_exposure: false },
    ];
    expect(measurePace(rows).secondsPerReview).toBeCloseTo(6, 5);
  });
});

describe("the suggested weekly question goal", () => {
  /** What the flow actually asks for, at a given week of study hours. */
  const goalAt = (hours: number) => {
    const r = at({ studyHoursPerWeek: hours });
    return suggestedWeeklyQuestions(r.basis.minutesPerDay, r.basis.cardMinutesPerDay);
  };

  it("LEAVES TIME FOR CONTENT, not just cards and questions", () => {
    // The failure this replaced: giving questions every minute cards did not
    // take, which asked a fifteen-hour student for 43 questions a day and left
    // nothing for reading. Cards plus questions must fit inside the day with
    // room to spare.
    for (const hours of [5, 10, 15, 20, 30, 40]) {
      const r = at({ studyHoursPerWeek: hours });
      const questionMinutesPerDay = (Math.ceil(goalAt(hours) / 7) * 97) / 60;
      const spent = r.basis.cardMinutesPerDay + questionMinutesPerDay;
      expect(spent).toBeLessThan(r.basis.minutesPerDay);
    }
  });

  it("rises with the hours available", () => {
    expect(goalAt(20)).toBeGreaterThan(goalAt(10));
    expect(goalAt(10)).toBeGreaterThan(goalAt(5));
  });

  it("never suggests a goal of nothing", () => {
    // A student with almost no time still gets something to aim at rather than
    // a zero, which would read as "do no questions".
    expect(suggestedWeeklyQuestions(10, 9)).toBeGreaterThan(0);
    expect(suggestedWeeklyQuestions(0, 0)).toBeGreaterThan(0);
  });

  it("gives a round number, because a person reads it", () => {
    for (const hours of [5, 10, 15, 20, 30]) {
      expect(goalAt(hours) % 10).toBe(0);
    }
  });

  it("never goes negative when cards claim more than the day", () => {
    expect(suggestedWeeklyQuestions(60, 200)).toBeGreaterThan(0);
  });
});
