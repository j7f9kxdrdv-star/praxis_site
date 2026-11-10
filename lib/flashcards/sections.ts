// ─── MCAT subjects ────────────────────────────────────────────────────────────
//
// Every deck belongs to exactly one subject (`flashcard_decks.section`). The
// Flashcards page groups decks by these, and a cross-deck study session can be
// limited to one of them, mixing cards from every chapter of that subject.
//
// Limiting a session to a subject changes WHICH cards it draws from, nothing
// else. Daily Review still spends the student's one shared daily allowance
// (the same limits whichever subject they study), and Extra Study still spends
// none of it. Both keep recording the review sources they always have, so the
// daily quota in ./quota.ts needs no change.

export const SECTIONS = [
  { id: "biology", label: "Biology" },
  { id: "biochemistry", label: "Biochemistry" },
  { id: "chemistry", label: "Chemistry" },
  { id: "organic_chemistry", label: "Organic Chemistry" },
  { id: "physics", label: "Physics" },
  { id: "scientific_reasoning", label: "Scientific Reasoning" },
  { id: "psych_soc", label: "Psych / Soc" },
] as const;

export type SectionId = (typeof SECTIONS)[number]["id"];

/** The cross-deck session modes, as the session page names them. */
export type SessionMode = "due" | "starred" | "extra_study";

/**
 * A `?section=` value from the URL, or null when it is absent or not one of
 * the subjects above. An unknown value must never widen to the whole library
 * silently, so the session page treats null as "no subject" only when the
 * parameter was absent; see `sectionParamProblem`.
 */
export function parseSection(raw: string | null | undefined): SectionId | null {
  if (!raw) return null;
  return SECTIONS.some((s) => s.id === raw) ? (raw as SectionId) : null;
}

/** True when the URL names a subject that does not exist. */
export function sectionParamProblem(raw: string | null | undefined): boolean {
  // Absent (null) means "no subject". Present but empty ("?section=") is a
  // request for a subject that names none, and must fail closed too.
  return raw !== null && raw !== undefined && parseSection(raw) === null;
}

export function sectionLabel(id: SectionId): string {
  return SECTIONS.find((s) => s.id === id)?.label ?? id;
}

/** The URL that starts a cross-deck session, optionally limited to one subject. */
export function sessionHref(mode: SessionMode, section?: SectionId | null): string {
  const params = new URLSearchParams({ mode });
  if (section) params.set("section", section);
  return `/dashboard/flashcards/session?${params.toString()}`;
}

export interface SubjectProjection {
  servedNew: number;
  servedReview: number;
  served: number;
  /** New items are waiting but today's new-item allowance is spent. */
  newLimitUsed: boolean;
  /** Due reviews are waiting but today's review allowance is spent. */
  reviewLimitUsed: boolean;
  /** Items are waiting, yet none can be served today. */
  limitReached: boolean;
}

/**
 * How many items a subject's Review button would serve right now.
 *
 * `unseen` and `dueReviews` must be the exact eligible counts from
 * countEligibleByDeck (./sessionQueue), the same definition the session uses.
 * The daily allowance is shared across the whole library, so a subject can
 * only use what is left of it today. New items and reviews are capped
 * separately, exactly as the session caps them.
 */
export function projectSubjectReview(args: {
  unseen: number;
  dueReviews: number;
  newLeftToday: number;
  reviewsLeftToday: number;
}): SubjectProjection {
  const servedNew = Math.max(0, Math.min(args.unseen, args.newLeftToday));
  const servedReview = Math.max(0, Math.min(args.dueReviews, args.reviewsLeftToday));
  const served = servedNew + servedReview;
  return {
    servedNew,
    servedReview,
    served,
    newLimitUsed: args.unseen > 0 && args.newLeftToday <= 0,
    reviewLimitUsed: args.dueReviews > 0 && args.reviewsLeftToday <= 0,
    limitReached: args.unseen + args.dueReviews > 0 && served === 0,
  };
}

/**
 * The words on a subject's box. Says which limit is spent, never implying both
 * are when only one is. Counts are study items (one per blank), so the copy
 * names them as "new" and "reviews" rather than as cards.
 */
export function describeSubjectReview(
  p: SubjectProjection,
  label: string,
  dueElsewhere: number,
): { headline: string; detail: string; elsewhere: string | null } {
  const plural = (n: number, one: string, many: string) => `${n} ${n === 1 ? one : many}`;
  let headline: string;
  const notes: string[] = [];
  if (p.served > 0) {
    headline = `${p.served} to study today`;
    notes.push(`${p.servedNew} new, ${plural(p.servedReview, "review", "reviews")}.`);
    if (p.newLimitUsed) notes.push("Today\u2019s new-card limit is used up, so no new ones.");
    if (p.reviewLimitUsed) notes.push("Today\u2019s review limit is used up, so no reviews.");
    notes.push("Review counts toward your daily limits; Extra Study doesn\u2019t.");
  } else if (p.newLimitUsed && p.reviewLimitUsed) {
    headline = "Both daily limits are used up";
    notes.push("Extra Study works any time and doesn\u2019t touch your daily limits.");
  } else if (p.newLimitUsed) {
    headline = "Today\u2019s new-card limit is used up";
    notes.push(`No ${label} reviews are due. Extra Study works any time and doesn\u2019t touch your daily limits.`);
  } else if (p.reviewLimitUsed) {
    headline = "Today\u2019s review limit is used up";
    notes.push(`No new ${label} cards are waiting. Extra Study works any time and doesn\u2019t touch your daily limits.`);
  } else {
    headline = `Nothing in ${label} is due right now`;
    notes.push("Extra Study works any time and doesn\u2019t touch your daily limits.");
  }
  return {
    headline,
    detail: notes.join(" "),
    elsewhere: dueElsewhere > 0 ? `${plural(dueElsewhere, "review is", "reviews are")} also due in other subjects.` : null,
  };
}
