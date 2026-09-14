import { describe, it, expect } from "vitest";
import {
  aggregateFlashcards,
  lookbackIso,
  SESSION_GAP_MS,
  type AggregateReview,
} from "./flashcardAggregate";

const at = (iso: string, rating: AggregateReview["rating"], card = "c1", topic: string | null = "enzymes"): AggregateReview => ({
  flashcardId: card,
  clozeIndex: 0,
  rating,
  reviewedAt: iso,
  topicKey: topic,
});

const WINDOW = { fromIso: "2026-09-10T00:00:00.000Z", toIso: "2026-09-11T00:00:00.000Z" };

describe("the session gap decides a first look", () => {
  it("counts a repeat inside the gap once", () => {
    // Rating a card Again re-queues it in the same sitting, so one struggle
    // logs several rows. Counting them all would score a topic by how
    // stubbornly it was retried.
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-10T10:00:00.000Z", "again"),
        at("2026-09-10T10:02:00.000Z", "hard"),
        at("2026-09-10T10:05:00.000Z", "medium"),
      ],
    });
    expect(a.firstLookTotal).toBe(1);
    expect(a.firstLookCorrect).toBe(0); // the first sighting failed
    expect(a.total).toBe(3);            // the distribution still sees all three
  });

  it("counts a return after the gap as a new look", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-10T10:00:00.000Z", "again"),
        at("2026-09-10T14:00:00.000Z", "easy"),
      ],
    });
    expect(a.firstLookTotal).toBe(2);
    expect(a.firstLookCorrect).toBe(1);
  });

  it("A REVIEW JUST BEFORE THE WINDOW STILL SUPPRESSES A FIRST LOOK", () => {
    // The bug a naive window query has: the first review after the boundary
    // looks like a first sighting even when the same card was seen minutes
    // earlier. The margin exists to prevent exactly this.
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-09T23:50:00.000Z", "again"), // before the window
        at("2026-09-10T00:05:00.000Z", "medium"), // 15 minutes later
      ],
    });
    expect(a.firstLookTotal).toBe(0);
    expect(a.total).toBe(1); // and the earlier one is not counted at all
  });

  it("never counts the lookback margin in any total", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-09T23:40:00.000Z", "easy"),
        at("2026-09-09T23:45:00.000Z", "easy"),
      ],
    });
    expect(a.total).toBe(0);
    expect(a.distinctCards).toBe(0);
    expect(a.byTopic).toEqual([]);
  });

  it("asks for exactly one session gap of history", () => {
    const from = "2026-09-10T00:00:00.000Z";
    expect(new Date(from).getTime() - new Date(lookbackIso(from)).getTime()).toBe(SESSION_GAP_MS);
  });
});

describe("AGAIN IS THE ONLY FAILURE GRADE", () => {
  it("treats hard, medium and easy alike as retrieved", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-10T09:00:00.000Z", "hard", "c1"),
        at("2026-09-10T09:00:00.000Z", "medium", "c2"),
        at("2026-09-10T09:00:00.000Z", "easy", "c3"),
        at("2026-09-10T09:00:00.000Z", "again", "c4"),
      ],
    });
    expect(a.firstLookTotal).toBe(4);
    expect(a.firstLookCorrect).toBe(3);
  });

  it("keeps the rating distribution descriptive and separate", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-10T09:00:00.000Z", "hard", "c1"),
        at("2026-09-10T09:10:00.000Z", "hard", "c1"),
      ],
    });
    // Two reviews in the distribution, one first look. The chart and the
    // recall figure are answering different questions.
    expect(a.counts.hard).toBe(2);
    expect(a.total).toBe(2);
    expect(a.firstLookTotal).toBe(1);
  });
});

describe("per-topic recall", () => {
  it("splits first looks by canonical topic", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [
        at("2026-09-10T09:00:00.000Z", "easy", "c1", "enzymes"),
        at("2026-09-10T09:00:00.000Z", "again", "c2", "enzymes"),
        at("2026-09-10T09:00:00.000Z", "medium", "c3", "the_cell"),
      ],
    });
    expect(a.byTopic).toEqual([
      { key: "enzymes", firstLooks: 2, recalled: 1 },
      { key: "the_cell", firstLooks: 1, recalled: 1 },
    ]);
  });

  it("drops cards whose deck resolves to no topic rather than inventing one", () => {
    const a = aggregateFlashcards({
      ...WINDOW,
      reviews: [at("2026-09-10T09:00:00.000Z", "easy", "c1", null)],
    });
    expect(a.firstLookTotal).toBe(1);
    expect(a.byTopic).toEqual([]);
  });
});

describe("the shape that replaces 42,000 rows", () => {
  it("is bounded by topics touched, not reviews logged", () => {
    // 5,000 reviews across three topics still reduces to three rows.
    const reviews: AggregateReview[] = [];
    for (let i = 0; i < 5000; i++) {
      const d = new Date(Date.UTC(2026, 8, 10, 1 + (i % 20), i % 60));
      reviews.push(at(d.toISOString(), i % 4 === 0 ? "again" : "medium", `c${i % 900}`, ["enzymes", "the_cell", "dna"][i % 3]));
    }
    const a = aggregateFlashcards({ ...WINDOW, reviews });
    expect(a.byTopic).toHaveLength(3);
    expect(JSON.stringify(a).length).toBeLessThan(1024);
  });
});
