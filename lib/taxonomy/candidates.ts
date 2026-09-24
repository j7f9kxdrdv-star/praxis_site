// ─── Which concepts a question is even allowed to be mapped to ─────────────
//
// The model never chooses from all 488 concepts. It chooses from a set narrowed
// deterministically first, which is what turns "an incompatible mapping is
// discouraged" into "an incompatible mapping is unreachable". A prompt can be
// ignored; a candidate list cannot.
//
// Four axes, all exact equality, all drawn from metadata the question already
// carries: MCAT section, AAMC content category, discipline, and chapter.
//
// THE CHAPTER AXIS IS THE ONE THAT MATTERS MOST, and it is why 417 of the 439
// unmapped questions are refused outright. Seven chapters were authored with
// per-question descriptions and contain no concept-style labels, so no concept
// was seeded from them. A question in those chapters has an empty candidate set
// and is INELIGIBLE. That is the correct outcome: the vocabulary genuinely does
// not cover its subject, and the honest answer is a vocabulary gap rather than
// the nearest neighbouring concept.

export interface QuestionFacts {
  section: string;
  contentCategory: string;
  discipline: string;
  topic: string;
}

export interface ConceptFacts {
  id: string;
  canonicalName: string;
  status: string;
  sections: Set<string>;
  contentCategories: Set<string>;
  disciplines: Set<string>;
  /** Chapters this concept is evidenced in, from questions already carrying it. */
  topics: Set<string>;
}

export const SECTION_OF_LEGACY: Record<string, string> = {
  chem_phys: "CHEM_PHYS", bio_biochem: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", cars: "CARS",
};

export const DISCIPLINE_OF_LEGACY: Record<string, string> = {
  "general-chemistry": "GENERAL_CHEMISTRY", "organic-chemistry": "ORGANIC_CHEMISTRY",
  physics: "PHYSICS", biology: "BIOLOGY", biochemistry: "BIOCHEMISTRY",
  psychology: "PSYCHOLOGY", sociology: "SOCIOLOGY",
};

/**
 * The concepts a question may legally be mapped to.
 *
 * Exact membership on every axis. Nothing is scored, nothing is approximate,
 * and an unrecognised legacy value narrows to nothing rather than to everything
 * — failing closed, because the cost of a wrong concept is a learner being told
 * they are weak at something they never attempted.
 */
export function candidatesFor(q: QuestionFacts, concepts: ConceptFacts[]): ConceptFacts[] {
  const section = SECTION_OF_LEGACY[q.section];
  const discipline = DISCIPLINE_OF_LEGACY[q.discipline];
  if (!section || !discipline) return [];

  return concepts.filter(
    (c) =>
      c.status !== "DEPRECATED" &&
      c.sections.has(section) &&
      c.contentCategories.has(q.contentCategory) &&
      c.disciplines.has(discipline) &&
      c.topics.has(q.topic),
  );
}

export type Eligibility =
  | { eligible: true; candidates: ConceptFacts[] }
  | { eligible: false; reason: "VOCABULARY_GAP" | "UNKNOWN_CLASSIFICATION" };

/**
 * Should this question be sent for a semantic proposal at all?
 *
 * Distinguishes the two ways of having no candidates, because they need
 * different responses. UNKNOWN_CLASSIFICATION is a data problem to fix.
 * VOCABULARY_GAP is a decision for a human: the ontology needs extending, and
 * no amount of matching will substitute for that.
 */
export function eligibility(q: QuestionFacts, concepts: ConceptFacts[]): Eligibility {
  if (!SECTION_OF_LEGACY[q.section] || !DISCIPLINE_OF_LEGACY[q.discipline]) {
    return { eligible: false, reason: "UNKNOWN_CLASSIFICATION" };
  }
  const candidates = candidatesFor(q, concepts);
  return candidates.length
    ? { eligible: true, candidates }
    : { eligible: false, reason: "VOCABULARY_GAP" };
}
