// ─── Flashcard aggregation ─────────────────────────────────────────────────
//
// WHY THIS MOVED TO THE SERVER. The analytics page loaded every review the
// student had ever logged so that three cards could count them. On the largest
// real account that is 42,553 rows, roughly 3.7 MB of JSON, to render a
// four-bar chart and two percentages. Everything below reduces to about two
// kilobytes before it leaves the server.
//
// THE SESSION GAP IS WHY THIS LOOKED IMPOSSIBLE TO AGGREGATE. First-look recall
// asks whether a review was the first sighting of that card in a sitting, which
// seems to need the whole history to answer. It does not: it needs only the
// thirty minutes BEFORE the window. Any earlier review is, by definition, more
// than a session gap away from anything inside it and cannot change a
// classification. So the read is bounded by the window, not by the account.
//
// AGAIN IS THE ONLY FAILURE GRADE, here as everywhere. Hard, Medium and Easy
// all mean the card was retrieved, at differing cost. This file does not
// interpret them beyond that, and the rating distribution it returns is
// descriptive: the scheduler owns memory state.

export const SESSION_GAP_MS = 30 * 60 * 1000;

export type Rating = "again" | "hard" | "medium" | "easy";

export interface AggregateReview {
  flashcardId: string;
  clozeIndex: number;
  rating: Rating;
  reviewedAt: string;
  /** Canonical topic key of the deck this card belongs to, when known. */
  topicKey: string | null;
}

export interface TopicRecall {
  key: string;
  firstLooks: number;
  recalled: number;
}

export interface FlashcardAggregate {
  /** Rating distribution over reviews INSIDE the window. */
  counts: Record<Rating, number>;
  /** All reviews in the window, the denominator for the distribution. */
  total: number;
  /** Distinct card-blanks touched in the window. */
  distinctCards: number;
  firstLookTotal: number;
  firstLookCorrect: number;
  byTopic: TopicRecall[];
  from: string;
  to: string;
}

export interface AggregateInput {
  /**
   * Reviews from one session gap BEFORE `fromIso` through `toIso`, oldest
   * first. The earlier margin exists only to classify first looks correctly and
   * is never counted.
   */
  reviews: AggregateReview[];
  fromIso: string;
  toIso: string;
}

/**
 * Reduce a window of reviews to the handful of numbers the page shows.
 *
 * Reviews before `fromIso` are read for context and excluded from every count,
 * which is the one thing a naive window query gets wrong: it would treat the
 * first review after midnight as a first look even when the same card was seen
 * ten minutes earlier.
 */
export function aggregateFlashcards(input: AggregateInput): FlashcardAggregate {
  const { reviews, fromIso, toIso } = input;

  const counts: Record<Rating, number> = { again: 0, hard: 0, medium: 0, easy: 0 };
  const lastSeen = new Map<string, number>();
  const distinct = new Set<string>();
  const topics = new Map<string, TopicRecall>();
  let total = 0;
  let firstLookTotal = 0;
  let firstLookCorrect = 0;

  for (const r of reviews) {
    const id = `${r.flashcardId}:${r.clozeIndex}`;
    const t = new Date(r.reviewedAt).getTime();
    const prev = lastSeen.get(id);
    const isFirstLook = prev === undefined || t - prev > SESSION_GAP_MS;
    lastSeen.set(id, t);

    // The lookback margin classifies, then stops existing.
    if (r.reviewedAt < fromIso || r.reviewedAt > toIso) continue;

    total++;
    counts[r.rating]++;
    distinct.add(id);

    if (!isFirstLook) continue;
    firstLookTotal++;
    const recalled = r.rating !== "again";
    if (recalled) firstLookCorrect++;

    if (r.topicKey) {
      const t0 = topics.get(r.topicKey) ?? { key: r.topicKey, firstLooks: 0, recalled: 0 };
      t0.firstLooks++;
      if (recalled) t0.recalled++;
      topics.set(r.topicKey, t0);
    }
  }

  return {
    counts,
    total,
    distinctCards: distinct.size,
    firstLookTotal,
    firstLookCorrect,
    byTopic: [...topics.values()].sort((a, b) => b.firstLooks - a.firstLooks),
    from: fromIso,
    to: toIso,
  };
}

/** How far back a query must reach to classify the window correctly. */
export function lookbackIso(fromIso: string): string {
  return new Date(new Date(fromIso).getTime() - SESSION_GAP_MS).toISOString();
}
