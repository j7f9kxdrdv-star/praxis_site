/**
 * Tier 1 insights — what the product can honestly tell a student today.
 *
 * THE RULE THIS FILE EXISTS TO ENFORCE: the data decides the claim, and a
 * language model may only phrase it. Every Claim below is computed
 * deterministically from measured evidence and carries the evidence with it,
 * so any sentence shown to a student can be traced back to the rows that
 * justify it. A model that is handed these and asked to write prose cannot
 * invent a diagnosis, because it is never shown anything to diagnose from.
 *
 * Tier 1 is deliberately flashcards-only. Concept-level claims ("you know the
 * facts but miss the questions") need the canonical ontology, which does not
 * exist yet, and per-concept question evidence, which is far too sparse to
 * support a confident statement — the heaviest user in the bank has a median
 * of 21 attempts per topic, where 67% accuracy carries a confidence interval
 * of roughly ±20 points.
 */

export type ClaimKind =
  | "backlog"          // the queue is beyond reach at the current pace
  | "pace"             // what a given daily budget actually buys
  | "leech"            // specific cards that keep failing
  | "stale_deck"       // a deck going cold while work piles up
  | "today"            // what to do in this session
  | "no_evidence";     // an honest "cannot tell yet"

/** How much weight a claim can bear. Never inferred — always counted. */
export type Confidence = "high" | "medium" | "low";

export interface Claim {
  kind: ClaimKind;
  /** Ordering hint for the brief. 0 is most urgent. */
  priority: number;
  confidence: Confidence;
  /** One line, already true and already specific. Safe to show unmodified. */
  headline: string;
  /** Supporting sentence. Also safe to show unmodified. */
  detail: string;
  /**
   * The numbers behind the claim. Passed to a model for phrasing; shown to a
   * student on request. If a figure is not in here, nothing may say it.
   */
  evidence: Record<string, string | number>;
}

export interface Brief {
  generatedAt: string;
  studyDay: string;
  claims: Claim[];
  /** True when there is too little history for any confident claim at all. */
  insufficientEvidence: boolean;
}
