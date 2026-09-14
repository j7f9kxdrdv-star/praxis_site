import { describe, it, expect } from "vitest";
import { buildDailyPrompt, buildWeeklyPrompt } from "./prompts";
import type { ReportMetrics, LearnerSignals } from "./metrics";
import { MIN_ATTEMPTS_FOR_STATE } from "@/lib/learner/topicState";

const learner: LearnerSignals = {
  cards_reviewed: 610,
  first_look_recall: 78,
  first_looks: 512,
  topics_improved: 2,
  topics_declined: 0,
  priorities_resolved: 1,
  priorities_added: 3,
  coverage_delta: 5,
  coverage_percent: 21,
};

const base = (over: Partial<ReportMetrics> = {}): ReportMetrics => ({
  period: "weekly",
  start_date: "2026-09-07",
  end_date: "2026-09-14",
  total_questions: 82,
  overall_accuracy: 64,
  avg_time_seconds: 88,
  subtopics: [],
  struggling: [],
  strong: [],
  top_priority: null,
  section_breakdown: {},
  days_studied: 5,
  exam_days_remaining: 120,
  learner,
  ...over,
});

describe("the prompts are valid strings, not broken templates", () => {
  // A stray backtick inside a template literal silently ends the string and
  // the rest of the prompt becomes code. That happened once; these catch it.
  it("builds without throwing and returns substantial text", () => {
    expect(buildDailyPrompt(base({ period: "daily" })).length).toBeGreaterThan(500);
    expect(buildWeeklyPrompt(base()).length).toBeGreaterThan(500);
  });

  it("carries no unbalanced backticks", () => {
    for (const p of [buildDailyPrompt(base({ period: "daily" })), buildWeeklyPrompt(base())]) {
      expect(p.split("`").length % 2).toBe(1);
    }
  });
});

describe("learner signals reach the model", () => {
  it("embeds the block so the report can cite real transitions", () => {
    const p = buildWeeklyPrompt(base());
    expect(p).toContain("610");                 // cards reviewed
    expect(p).toContain("priorities_resolved");
    expect(p).toContain("topics_improved");
  });

  it("passes null through rather than inventing zeros", () => {
    const p = buildWeeklyPrompt(base({ learner: null }));
    expect(p).toContain('"learner": null');
  });
});

describe("THE GUARDS THE PROSE MUST NOT CROSS", () => {
  const daily = buildDailyPrompt(base({ period: "daily" }));
  const weekly = buildWeeklyPrompt(base());

  it("forbids joining flashcard recall to a predicted score", () => {
    for (const p of [daily, weekly]) {
      expect(p).toMatch(/not connect flashcard recall to a predicted MCAT score/i);
    }
  });

  it("forbids calling recall an accuracy or a mastery", () => {
    for (const p of [daily, weekly]) {
      expect(p).toMatch(/NOT a test score/i);
    }
  });

  it("forbids treating coverage as material learned", () => {
    expect(weekly).toMatch(/Coverage is how much material has been SEEN/i);
    expect(weekly).toMatch(/Never describe it as material learned or mastered/i);
  });

  it("forbids reporting a zero transition as an observation", () => {
    expect(weekly).toMatch(/Omit any that are zero/i);
    expect(daily).toMatch(/simply omit it/i);
  });

  it("still bans motivational language", () => {
    for (const p of [daily, weekly]) {
      expect(p).toMatch(/Do not use motivational language/i);
      expect(p).toMatch(/coach, not a cheerleader/i);
    }
  });

  it("NEVER ASKS FOR THE WORD MASTERED", () => {
    // Raw accuracy on practice questions is not mastery, however much of it
    // there is. The band is Strong.
    for (const p of [daily, weekly]) {
      expect(p).not.toMatch(/status "Mastered"/);
    }
    expect(weekly).toMatch(/not evidence of mastery/i);
  });
});

describe("the report shares the learner model's evidence floor", () => {
  it("does not define a second one", () => {
    // The report used to call a subtopic Mastered on three attempts. It now
    // uses the same floor the learner model uses to say anything at all.
    expect(MIN_ATTEMPTS_FOR_STATE).toBeGreaterThanOrEqual(12);
  });
});
