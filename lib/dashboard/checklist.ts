// ─── Today's checklist ─────────────────────────────────────────────────────
//
// What replaced "Today's Focus", which announced a backlog: "5,028 of your
// 7,143 cards are waiting." True, and useless. A student who opens that has
// been told the size of their problem and nothing about what to do this
// morning, and the number only ever grows.
//
// So the panel now answers one question: what is today's work? Four lines, a
// count on each, and every count comes from something the student themselves
// set or from work they actually did.
//
// NOTHING IS TICKED BY HAND. Each line fills from real activity and closes
// itself. A checkbox a student can tap is a checkbox that can claim work that
// never happened, and then the dashboard is no longer a record of anything.
//
// A LINE WITH NO WORK IN IT DOES NOT APPEAR. Mikko has seen all 7,146 blanks,
// so his new-card line would read 0 of 0 forever; it is dropped instead. The
// same goes for a student with nothing due and no questions owed. An empty row
// is worse than a missing one, because it reads as a failure rather than an
// absence.

/** How many missed questions to ask for in one day.
 *
 * Smart Review holds everything the student has ever missed, and that number
 * only goes up: 87 were waiting the day this was written. Putting all 87 on a
 * daily checklist makes a list that cannot be finished, which is the same
 * mistake the old backlog headline made. The rest stay one tap away in
 * Practice. */
export const MISSED_QUESTIONS_PER_DAY = 20;

/** How many weak decks to name. Three is enough to steer a session without
 *  turning the panel into a second analytics page. */
export const FOCUS_DECK_COUNT = 3;

/** A deck needs this many of the student's cards before its failure rate means
 *  anything. Two lapses out of three cards is not a weak deck, it is noise. */
export const MIN_BLANKS_FOR_FOCUS = 25;

import type { Phase } from "@/lib/dashboard/phase";

// ─── Priority ──────────────────────────────────────────────────────────────
//
// The order was arbitrary before: whatever sequence the lines happened to be
// pushed in. It is now the point of the panel. Mikko: "that's what we should
// be dictating, what is a priority."
//
// ORDER MEANS "START HERE", NOT A GATE. Every line keeps its own target and
// stays visible and tappable whatever position it lands in. Ordering changes
// emphasis; it does not create time, and a list where the top item has to be
// finished before the rest count is a list where 600 due cards mean questions
// never happen.
//
// Building     retrieve, shore up the weak spots, then apply. You cannot
//              apply what you cannot recall.
// Consolidating recall is holding, so application earns its place ahead of
//              chasing weak decks.
// Exam ready   the cards are steady and the exam is close; the remaining
//              value is in questions, and cards drop to maintenance.
// MISSED QUESTIONS ALWAYS COME BEFORE NEW ONES, in every phase. Mikko's call,
// and it is a rule rather than a per-phase preference: a question you have
// already proven you get wrong is a known gap, and a new one is a lottery
// ticket that may test something you already know.
//
// The evidence that it matters is not hypothetical. Smart Review had been last
// on the list its whole life, and the queue read: 87 waiting, 73 of them over a
// week old, and not one ever retried. Last means never.
const ORDER: Record<Phase, LineKey[]> = {
  building: ["cards_review", "cards_new", "decks", "topics", "missed", "questions"],
  consolidating: ["cards_review", "cards_new", "missed", "questions", "decks", "topics"],
  applying: ["missed", "questions", "cards_review", "cards_new", "decks", "topics"],
};

export type LineKey =
  | "cards_review"
  | "cards_new"
  | "questions"
  | "missed"
  | "decks"
  | "topics";

export type LineState = "todo" | "partial" | "done" | "soon";

export interface ChecklistLine {
  key: LineKey;
  title: string;
  /** The one line of context under the title. Never a scolding. */
  note: string;
  done: number;
  target: number;
  state: LineState;
  href: string;
}

/**
 * A deck the student is genuinely weak on.
 *
 * Measured in lib/insights/computeBrief.ts from the whole review log and cached
 * per study day, NOT approximated here. Two cheap proxies were tried on the
 * dashboard first and both failed on the only part that is shown: lapse rate
 * put every deck between 1.16 and 1.28 lapses a card, and FSRS difficulty
 * saturated at 9.0 across the worst six. Difficulty correlated 0.83 with the
 * truth across 73 decks and matched 2 of 5 on the top five, which is a coin
 * toss wearing a recommendation's clothes.
 */
export interface FocusDeck {
  deckId: string;
  title: string;
  /** First-look recall, 0 to 1. */
  accuracy: number;
  attempts: number;
  due: number;
  studiedToday: boolean;
}

export interface ChecklistInput {
  /** From the profile. The student's own limits, never invented here. */
  reviewLimit: number;
  newLimit: number;
  weeklyQuestionGoal: number;

  /** Supply of work. */
  cardsDue: number;
  unseenBlanks: number;
  missedQuestionsDue: number;
  focusDecks: FocusDeck[];

  /** Work already done in the current study day. */
  reviewsToday: number;
  newToday: number;
  newQuestionsToday: number;
  missedQuestionsToday: number;

  /** Study modules are not built yet; the row is shown greyed so it has a
   *  place now rather than shoving everything down the day it lands. */
  topicsReady: boolean;

  /** Decides the order. See ORDER above. */
  phase: Phase;
}

const plural = (n: number, one: string, many: string) => (n === 1 ? one : many);
const comma = (n: number) => n.toLocaleString("en-US");

function stateOf(done: number, target: number): LineState {
  if (target <= 0) return "done";
  if (done >= target) return "done";
  return done > 0 ? "partial" : "todo";
}

/**
 * Questions to answer today, from the weekly goal the student set.
 *
 * Divided across seven days rather than five, because a goal a student misses
 * on the two days they do not study is a goal that reads as failure twice a
 * week. Rounded up so a goal of 100 asks for 15 and not 14, which would quietly
 * leave five questions unaccounted for.
 */
export function dailyQuestionTarget(weeklyGoal: number): number {
  if (!weeklyGoal || weeklyGoal <= 0) return 0;
  return Math.ceil(weeklyGoal / 7);
}

export function buildChecklist(input: ChecklistInput): ChecklistLine[] {
  const lines: ChecklistLine[] = [];

  // ── Flashcard reviews ────────────────────────────────────────────────
  // The limit is a ceiling, not a demand: a student with 40 cards due is asked
  // for 40, not for their 600-card limit.
  const reviewTarget = Math.min(input.reviewLimit, input.cardsDue + input.reviewsToday);
  if (reviewTarget > 0) {
    lines.push({
      key: "cards_review",
      title: "Flashcard reviews",
      note:
        input.cardsDue > reviewTarget
          ? `${comma(input.cardsDue)} are due. Your limit is ${comma(input.reviewLimit)} a day.`
          : `Everything due today.`,
      done: Math.min(input.reviewsToday, reviewTarget),
      target: reviewTarget,
      state: stateOf(input.reviewsToday, reviewTarget),
      href: "/dashboard/flashcards/session?mode=due",
    });
  }

  // ── New cards ────────────────────────────────────────────────────────
  const newTarget = Math.min(input.newLimit, input.unseenBlanks + input.newToday);
  if (newTarget > 0) {
    lines.push({
      key: "cards_new",
      title: "New flashcards",
      note: `${comma(input.unseenBlanks)} you have not seen yet.`,
      done: Math.min(input.newToday, newTarget),
      target: newTarget,
      state: stateOf(input.newToday, newTarget),
      href: "/dashboard/flashcards/session?mode=due",
    });
  }

  // ── New questions ────────────────────────────────────────────────────
  const questionTarget = dailyQuestionTarget(input.weeklyQuestionGoal);
  if (questionTarget > 0) {
    lines.push({
      key: "questions",
      title: "New questions",
      note: `${comma(input.weeklyQuestionGoal)} a week, spread across seven days.`,
      done: input.newQuestionsToday,
      target: questionTarget,
      state: stateOf(input.newQuestionsToday, questionTarget),
      href: "/dashboard/practice",
    });
  }

  // ── Missed questions ─────────────────────────────────────────────────
  const missedTarget = Math.min(MISSED_QUESTIONS_PER_DAY, input.missedQuestionsDue);
  if (missedTarget > 0) {
    lines.push({
      key: "missed",
      title: "Missed questions",
      note:
        input.missedQuestionsDue > missedTarget
          ? `${comma(input.missedQuestionsDue)} waiting in Smart Review. ${missedTarget} today.`
          : `${missedTarget} waiting in Smart Review.`,
      done: input.missedQuestionsToday,
      target: missedTarget,
      state: stateOf(input.missedQuestionsToday, missedTarget),
      href: "/dashboard/practice",
    });
  }

  // ── Focus decks ──────────────────────────────────────────────────────
  const decks = input.focusDecks.slice(0, FOCUS_DECK_COUNT);
  if (decks.length > 0) {
    const touched = decks.filter((d) => d.studiedToday).length;
    const remaining = decks.filter((d) => !d.studiedToday);
    lines.push({
      key: "decks",
      title: `Focus ${plural(decks.length, "deck", "decks")}`,
      note:
        remaining.length === 0
          ? "All three touched today."
          : remaining
              .map((d) => `${d.title} ${Math.round(d.accuracy * 100)}%`)
              .join(", "),
      done: touched,
      target: decks.length,
      state: stateOf(touched, decks.length),
      href: "/dashboard/flashcards",
    });
  }

  // ── Topics ───────────────────────────────────────────────────────────
  lines.push({
    key: "topics",
    title: "Topics to study",
    note: input.topicsReady ? "" : "Arrives with the study modules.",
    done: 0,
    target: 0,
    state: input.topicsReady ? "todo" : "soon",
    href: "/dashboard/lessons",
  });

  // ── Priority ─────────────────────────────────────────────────────────
  // Sorted last, so each block above stays readable as its own rule rather
  // than being written in whatever sequence the phases happen to want.
  const rank = ORDER[input.phase];
  return lines.sort((a, b) => rank.indexOf(a.key) - rank.indexOf(b.key));
}

/** Lines that count toward the ring. "Soon" rows are not work yet. */
export const countable = (lines: ChecklistLine[]) => lines.filter((l) => l.state !== "soon");

/**
 * Overall progress: each LINE counts once, however big it is.
 *
 * The first version pooled the raw items instead, on the reasoning that 600
 * cards is more work than 15 questions and should weigh more. It is, but the
 * ring then read 99% while the headline beside it read "2 things left", because
 * the cards are 94% of the day's items and swamp everything else. Two numbers
 * in one panel contradicting each other is worse than either being imprecise,
 * and the honest reading of a checklist is how much of the LIST is done.
 *
 * Partly-finished lines still count for their fraction, so the ring moves while
 * a long line is in progress rather than sitting still for 600 cards.
 */
export function overallProgress(lines: ChecklistLine[]): number {
  const live = countable(lines);
  if (live.length === 0) return 0;
  const sum = live.reduce(
    (a, l) => a + (l.target > 0 ? Math.min(1, l.done / l.target) : 1),
    0,
  );
  return Math.max(0, Math.min(1, sum / live.length));
}

/** The headline: how many lines are still open. */
export function headline(lines: ChecklistLine[]): string {
  const live = countable(lines);
  const open = live.filter((l) => l.state !== "done").length;
  if (live.length === 0) return "Nothing due today.";
  if (open === 0) return "Today is done.";
  if (open === live.length) {
    return `${open} ${plural(open, "thing", "things")} today.`;
  }
  return `${open} ${plural(open, "thing", "things")} left.`;
}
