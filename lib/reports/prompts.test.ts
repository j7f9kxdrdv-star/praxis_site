import { describe, it, expect } from "vitest";
import { buildDailyPrompt, buildWeeklyPrompt } from "./prompts";
import { extractText } from "./generate";
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

describe("zero transitions are stripped from the payload", () => {
  // An instruction the model can decline is not a guarantee. The prompt asked
  // for zeros to be omitted and the first real generated report still wrote
  // "No topics improved or declined. No priorities were resolved or added."
  // A field that is absent cannot be reported.

  const quiet = {
    ...learner,
    topics_improved: 0,
    topics_declined: 0,
    priorities_resolved: 0,
    priorities_added: 0,
  };

  // The field names appear in the instruction prose too, so assert on the
  // QUOTED form, which only occurs as a JSON key in the serialised payload.
  const key = (name: string) => `"${name}"`;

  it("removes transition counts that are zero", () => {
    const p = buildWeeklyPrompt(base({ learner: quiet }));
    expect(p).not.toContain(key("topics_improved"));
    expect(p).not.toContain(key("priorities_resolved"));
  });

  it("keeps transition counts that actually happened", () => {
    const p = buildWeeklyPrompt(base({ learner: { ...quiet, priorities_resolved: 1 } }));
    expect(p).toContain(key("priorities_resolved"));
    expect(p).not.toContain(key("topics_improved"));
  });

  it("KEEPS MEASURES AT ZERO, because those are real facts", () => {
    // "cards reviewed: 0" is a true statement about the week. "0 topics
    // improved" is the absence of an observation. Only the second is dropped.
    const p = buildWeeklyPrompt(base({ learner: { ...quiet, cards_reviewed: 0 } }));
    expect(p).toContain(key("cards_reviewed"));
  });

  it("describes first-look as session-first, not first-ever", () => {
    // The first generated report read it as "cards seen for the first time",
    // which is wrong: most session-first views are cards reviewed many times.
    const p = buildWeeklyPrompt(base());
    expect(p).toMatch(/SESSION-FIRST/);
    expect(p).toMatch(/NOT the first time it has ever been seen/i);
  });
});

describe("pulling the prose out of a model response", () => {
  // Opus 5 returns a thinking block before its answer. The old code read
  // content[0], found a non-text block, and returned an empty string; the API
  // route then saved a blank report and reported success. A real generation
  // was the only thing that surfaced it.
  it("FINDS TEXT THAT IS NOT THE FIRST BLOCK", () => {
    const content = [
      { type: "thinking", thinking: "weighing the numbers" },
      { type: "text", text: "1. Weekly Performance Summary" },
    ] as { type: string; text?: string }[];
    expect(extractText(content)).toBe("1. Weekly Performance Summary");
  });

  it("joins a response split across several text blocks", () => {
    expect(
      extractText([
        { type: "text", text: "one " },
        { type: "thinking" },
        { type: "text", text: "two" },
      ]),
    ).toBe("one two");
  });

  it("returns empty when there is genuinely no prose, so the caller can throw", () => {
    expect(extractText([{ type: "thinking" }])).toBe("");
    expect(extractText([])).toBe("");
  });
});

describe("an absent field is not a finding", () => {
  it("tells the model not to remark on fields that were stripped", () => {
    for (const p of [buildDailyPrompt(base({ period: "daily" })), buildWeeklyPrompt(base())]) {
      expect(p).toMatch(/ABSENT FIELDS ARE NOT FINDINGS/);
      expect(p).toMatch(/do not remark on its absence/i);
    }
  });
});
