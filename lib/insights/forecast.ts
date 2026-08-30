import { fsrs, Rating, State, type Card as FsrsCard, type Grade } from "ts-fsrs";
import { FSRS_PARAMS } from "@/lib/flashcards/fsrsScheduler";

/**
 * Where does this student's queue actually go?
 *
 * Arithmetic cannot answer this. "5,610 due at 265 cards an hour is 21 hours"
 * is wrong, because every card reviewed comes back, and cards graded Again
 * come back within the hour. The queue is a feedback loop, so the only honest
 * forecast is to run it forward.
 *
 * The outcome of each simulated review is drawn at the rate students of this
 * deck ACTUALLY achieved at that gap length, not at the rate FSRS predicts.
 * Measured over 18,372 spaced reviews, FSRS is accurate between 2 and 14 days
 * and 7.5 to 7.8 points too hopeful beyond a fortnight; forecasting through
 * its own optimism would promise a student a backlog clearing that will not.
 */

const SECONDS_PER_CARD = 13.6; // mean in-session gap, 38,516 real samples

/** Observed recall ÷ FSRS's prediction, by days since the card was last seen. */
const CALIBRATION: [number, number, number][] = [
  [0, 2, 0.911],
  [2, 4, 0.996],
  [4, 7, 0.994],
  [7, 14, 0.984],
  [14, 30, 0.883],
  [30, Infinity, 0.871],
];
const calibrate = (gapDays: number): number =>
  CALIBRATION.find(([lo, hi]) => gapDays >= lo && gapDays < hi)?.[2] ?? 0.871;

/** Grade mix when a card IS recalled, measured from the log. */
const PASS_MIX: [Grade, number][] = [
  [Rating.Hard, 0.52],
  [Rating.Good, 0.32],
  [Rating.Easy, 0.15],
];

export interface ForecastCard {
  stability: number;
  difficulty: number;
  state: number;
  reps: number;
  lapses: number;
  intervalDays: number;
  dueAt: Date;
  lastReviewedAt: Date | null;
}

export interface ForecastPoint {
  minutesPerDay: number;
  dueAfter: number;
  knownAfter: number;
  clears: boolean;
}

function mulberry(seed: number): () => number {
  let a = seed >>> 0;
  return () => {
    a = (a * 1664525 + 1013904223) >>> 0;
    return a / 4294967296;
  };
}

function toCard(c: ForecastCard, fallbackNow: Date): FsrsCard {
  return {
    due: c.dueAt,
    stability: c.stability,
    difficulty: c.difficulty,
    elapsed_days: 0,
    scheduled_days: c.intervalDays,
    reps: c.reps,
    lapses: c.lapses,
    learning_steps: 0,
    state: c.state as State,
    last_review: c.lastReviewedAt ?? new Date(fallbackNow.getTime() - 86_400_000),
  } as FsrsCard;
}

/**
 * Run the queue forward at a given daily budget.
 *
 * Cards are taken in DUE-DATE order, which is what the app already does and
 * what measurement supports: simulated against this student's real backlog,
 * due-date order left 5,114 cards known after 30 days, against 5,055 for
 * most-overdue-first and 4,424 for least-overdue-first. Working the
 * nearly-remembered cards first — which sounds like sensible triage — spends
 * the budget re-confirming what is already known while the buried cards decay.
 */
export function simulate(
  cards: ForecastCard[],
  days: number,
  minutesPerDay: number,
  seed = 1,
): { dueAfter: number; knownAfter: number } {
  const engine = fsrs(FSRS_PARAMS);
  const rand = mulberry(seed);
  const perDay = Math.floor((minutesPerDay * 60) / SECONDS_PER_CARD);
  const t0 = new Date();
  const live = cards.map((c) => ({ card: toCard(c, t0) }));

  const recall = (card: FsrsCard, now: Date): number => {
    const r = engine.get_retrievability(card, now, false);
    const base = typeof r === "number" ? r : 0.9;
    const last = card.last_review ? new Date(card.last_review) : now;
    const gap = (now.getTime() - last.getTime()) / 86_400_000;
    return Math.min(1, Math.max(0, base * calibrate(gap)));
  };
  const passGrade = (u: number): Grade => {
    let acc = 0;
    for (const [g, p] of PASS_MIX) {
      acc += p;
      if (u < acc) return g;
    }
    return Rating.Good;
  };

  for (let d = 0; d < days; d++) {
    const now = new Date(t0.getTime() + d * 86_400_000);
    let budget = perDay;
    const due = live
      .filter((x) => new Date(x.card.due) <= now)
      .sort((a, b) => new Date(a.card.due).getTime() - new Date(b.card.due).getTime());

    for (const item of due) {
      if (budget <= 0) break;
      const passed = rand() < recall(item.card, now);
      item.card = engine.next(item.card, now, passed ? passGrade(rand()) : Rating.Again).card;
      budget--;
      // An "Again" card is re-shown the same day, as the app does.
      if (!passed && budget > 0) {
        const retry = new Date(now.getTime() + 600_000);
        item.card = engine.next(item.card, retry, passGrade(rand())).card;
        budget--;
      }
    }
  }

  const end = new Date(t0.getTime() + days * 86_400_000);
  let dueAfter = 0;
  let knownAfter = 0;
  for (const x of live) {
    if (new Date(x.card.due) <= end) dueAfter++;
    knownAfter += recall(x.card, end);
  }
  return { dueAfter, knownAfter: Math.round(knownAfter) };
}

/** What a range of daily budgets buys over one horizon. */
export function forecastPaces(
  cards: ForecastCard[],
  days: number,
  paces: number[] = [30, 60, 90, 120, 180],
): ForecastPoint[] {
  const startingDue = cards.filter((c) => c.dueAt <= new Date()).length;
  return paces.map((minutesPerDay) => {
    const runs = [1, 2, 3].map((s) => simulate(cards, days, minutesPerDay, s));
    const dueAfter = Math.round(runs.reduce((a, r) => a + r.dueAfter, 0) / runs.length);
    const knownAfter = Math.round(runs.reduce((a, r) => a + r.knownAfter, 0) / runs.length);
    return {
      minutesPerDay,
      dueAfter,
      knownAfter,
      // "Clears" means the queue is genuinely worked down, not merely smaller
      // than it started: a backlog that shrinks 3% in three months has not.
      clears: dueAfter < startingDue * 0.25,
    };
  });
}
