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
  return !!raw && parseSection(raw) === null;
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
  limitReached: boolean;
}

/**
 * How many cards a subject's Review button would serve right now.
 *
 * The daily allowance is shared across the whole library, so a subject can
 * only use what is left of it today. New cards and reviews are capped
 * separately, exactly as the session loader caps them.
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
    limitReached: args.unseen + args.dueReviews > 0 && served === 0,
  };
}
