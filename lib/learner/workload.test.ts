import { describe, it, expect } from "vitest";
import {
  weeklyPlan,
  questionSeconds,
  flashcardSeconds,
  DEFAULTS,
  MIN_SAMPLES_TO_PERSONALISE,
  type WeeklyPlanInput,
} from "./workload";

/** A plan with nothing in it; each test overrides only what it is about. */
const base = (over: Partial<WeeklyPlanInput> = {}): WeeklyPlanInput => ({
  plannedQuestions: 0,
  plannedFlashcards: 0,
  plannedMissedQuestions: 0,
  plannedLessonMinutes: [],
  completedQuestions: 0,
  completedFlashcards: 0,
  completedMissedQuestions: 0,
  completedLessonMinutes: [],
  questionDurations: [],
  flashcardReviewTimes: [],
  ...over,
});

/** n durations of exactly `s` seconds, enough to beat the personalising floor. */
const durations = (s: number, n = MIN_SAMPLES_TO_PERSONALISE) => Array<number>(n).fill(s);

/** Review timestamps `gap` seconds apart, oldest first. */
const reviewTimes = (gap: number, n = MIN_SAMPLES_TO_PERSONALISE + 1) =>
  Array.from({ length: n }, (_, i) => new Date(Date.UTC(2026, 0, 1, 0, 0, i * gap)).toISOString());

describe("duration estimators", () => {
  it("falls back to the default until there is enough evidence", () => {
    const r = questionSeconds(durations(30, MIN_SAMPLES_TO_PERSONALISE - 1));
    expect(r.measured).toBe(false);
    expect(r.seconds).toBe(DEFAULTS.secondsPerQuestion);
  });

  it("uses the student's own median once there is", () => {
    const r = questionSeconds(durations(30));
    expect(r.measured).toBe(true);
    expect(r.seconds).toBe(30);
  });

  it("ignores a tab left open for twenty minutes", () => {
    // Nineteen honest 30s attempts and one 1,333s outlier, the real maximum in
    // the bank. A mean would read 95s; the median must stay at 30.
    const r = questionSeconds([...durations(30, 19), 1333, ...durations(30, 5)]);
    expect(r.seconds).toBe(30);
  });

  it("ignores zero-second and negative durations", () => {
    const r = questionSeconds([...durations(40), 0, -5, 0]);
    expect(r.seconds).toBe(40);
    expect(r.samples).toBe(MIN_SAMPLES_TO_PERSONALISE);
  });

  it("survives nulls and missing timestamps", () => {
    const r = questionSeconds([null, undefined, ...durations(45)]);
    expect(r.seconds).toBe(45);
  });

  it("measures flashcard pace from the gaps between reviews", () => {
    const r = flashcardSeconds(reviewTimes(8));
    expect(r.measured).toBe(true);
    expect(r.seconds).toBe(8);
  });

  it("treats a long gap as a break rather than a very slow card", () => {
    const times = [
      ...reviewTimes(8),
      // Twenty minutes later: the student went for lunch.
      new Date(Date.UTC(2026, 0, 1, 0, 25, 0)).toISOString(),
      new Date(Date.UTC(2026, 0, 1, 0, 25, 8)).toISOString(),
    ];
    expect(flashcardSeconds(times).seconds).toBe(8);
  });
});

describe("weekly plan", () => {
  it("returns null progress when nothing is planned", () => {
    const p = weeklyPlan(base());
    expect(p.progressPercent).toBeNull();
    expect(p.plannedMinutes).toBe(0);
  });

  it("does NOT add item counts across modalities", () => {
    // 60 questions at 60s = 60 min. 350 cards at 6s = 35 min. If the model
    // added counts, the cards would be 85% of the work; in minutes they are 37%.
    const p = weeklyPlan(
      base({
        plannedQuestions: 60,
        plannedFlashcards: 350,
        questionDurations: durations(60),
        flashcardReviewTimes: reviewTimes(6),
      }),
    );
    const q = p.modalities.find((m) => m.modality === "QUESTION")!;
    const f = p.modalities.find((m) => m.modality === "FLASHCARD")!;
    expect(Math.round(q.plannedMinutes)).toBe(60);
    expect(Math.round(f.plannedMinutes)).toBe(35);
    expect(f.plannedMinutes / p.plannedMinutes).toBeLessThan(0.4);
  });

  it("computes partial completion in minutes, not items", () => {
    const p = weeklyPlan(
      base({
        plannedQuestions: 100,
        completedQuestions: 50,
        plannedFlashcards: 600,
        completedFlashcards: 600,
        questionDurations: durations(60),
        flashcardReviewTimes: reviewTimes(6),
      }),
    );
    // 100 questions = 100 min, 600 cards = 60 min, so 160 planned.
    // Done: 50 min of questions + 60 of cards = 110. 110/160 = 69%.
    expect(p.plannedMinutes).toBe(160);
    expect(p.completedMinutes).toBe(110);
    expect(p.progressPercent).toBe(69);
  });

  it("reaches exactly 100 when the plan is finished", () => {
    const p = weeklyPlan(
      base({
        plannedQuestions: 20,
        completedQuestions: 20,
        questionDurations: durations(60),
      }),
    );
    expect(p.progressPercent).toBe(100);
    expect(p.remainingMinutes).toBe(0);
  });

  it("clamps overcompletion to 100 and never reports negative remaining", () => {
    const p = weeklyPlan(
      base({
        plannedQuestions: 10,
        completedQuestions: 40,
        questionDurations: durations(60),
      }),
    );
    expect(p.progressPercent).toBe(100);
    expect(p.remainingMinutes).toBe(0);
    // The surplus is not hidden: the count still shows it.
    expect(p.modalities.find((m) => m.modality === "QUESTION")!.completed).toBe(40);
    expect(p.completedMinutes).toBeGreaterThan(p.creditedMinutes);
  });

  it("uses each lesson's authored minutes, and the default only when absent", () => {
    const p = weeklyPlan(base({ plannedLessonMinutes: [20, 30, 0] }));
    expect(p.plannedMinutes).toBe(20 + 30 + DEFAULTS.minutesPerLesson);
  });

  it("prices a missed question at a question's time", () => {
    const p = weeklyPlan(
      base({ plannedMissedQuestions: 20, questionDurations: durations(60) }),
    );
    expect(p.plannedMinutes).toBe(20);
  });

  it("combines four modalities into one honest percentage", () => {
    const p = weeklyPlan(
      base({
        plannedQuestions: 120,
        completedQuestions: 40,
        plannedFlashcards: 350,
        completedFlashcards: 350,
        plannedMissedQuestions: 20,
        completedMissedQuestions: 0,
        plannedLessonMinutes: [25, 25, 25],
        completedLessonMinutes: [25],
        questionDurations: durations(60),
        flashcardReviewTimes: reviewTimes(6),
      }),
    );
    // 120 + 35 + 20 + 75 = 250 planned; 40 + 35 + 0 + 25 = 100 done.
    expect(p.plannedMinutes).toBe(250);
    expect(p.completedMinutes).toBe(100);
    expect(p.progressPercent).toBe(40);
  });

  it("reports whether the rates were measured or defaulted", () => {
    const thin = weeklyPlan(base({ plannedQuestions: 10, questionDurations: [30, 30] }));
    expect(thin.diagnostics.personalisedQuestions).toBe(false);
    expect(thin.diagnostics.secondsPerQuestion).toBe(DEFAULTS.secondsPerQuestion);

    const rich = weeklyPlan(base({ plannedQuestions: 10, questionDurations: durations(42) }));
    expect(rich.diagnostics.personalisedQuestions).toBe(true);
    expect(rich.diagnostics.secondsPerQuestion).toBe(42);
  });

  it("does not let surplus in one modality pay for a deficit in another", () => {
    // The real case this was written for: cards massively overdone, questions
    // barely started. The week is not finished, and must not read as finished.
    const p = weeklyPlan(
      base({
        plannedQuestions: 100,
        completedQuestions: 40,
        plannedFlashcards: 4200,
        completedFlashcards: 5894,
        questionDurations: durations(60),
        flashcardReviewTimes: reviewTimes(6),
      }),
    );
    expect(p.progressPercent).toBeLessThan(100);
    // Credited is capped; completed still reports everything actually done.
    expect(p.creditedMinutes).toBeLessThan(p.completedMinutes);
    expect(p.modalities.find((m) => m.modality === "FLASHCARD")!.completed).toBe(5894);
  });

  it("stamps the estimator version so a later formula stays interpretable", () => {
    expect(weeklyPlan(base()).version).toMatch(/^\d+\.\d+\.\d+$/);
  });

  it("is unaffected by how large the backlog is", () => {
    // Backlog is not an input at all. The plan is what was asked for, so two
    // students with the same plan and the same work done read the same.
    const a = weeklyPlan(
      base({ plannedFlashcards: 600, completedFlashcards: 300, flashcardReviewTimes: reviewTimes(6) }),
    );
    expect(a.progressPercent).toBe(50);
  });
});
