// ─── Deck subject to MCAT section ──────────────────────────────────────────
//
// The subject filter on the analytics chart names MCAT sections. Questions
// carry one already. Flashcard decks do not: they are filed by SUBJECT, which
// is a different axis, so "Chemical & Physical" has to be resolved before the
// flashcard series can honour the filter.
//
// TWO ROUTES, IN THIS ORDER, AND NEITHER IS FUZZY MATCHING.
//
//   1. THE QUESTION BANK, which is authoritative. A deck whose canonical
//      subtopic matches a question topic inherits that topic's section from
//      the bank itself. Nothing is assumed; the answer is looked up.
//
//   2. A DECLARED MAP, below, for the decks route 1 cannot reach. Written by
//      hand so each line is a claim someone can argue with, in the same spirit
//      as the ALIASES table in topicKey.ts.
//
// MEASURED COVERAGE. Route 1 alone resolves 1,943 of 4,116 cards, only 47%,
// because the question bank holds just two sections and 33 topics while the
// deck library spans seven subjects. Psych/Soc has 778 cards and no questions
// at all to join against. The declared map lifts it to 3,997 of 4,116, 97%,
// and the remainder is the one subject that should not have a section.
//
// ORGANIC CHEMISTRY WAS CALLED AMBIGUOUS HERE, AND THAT WAS WRONG. The claim
// was that orgo is tested under both Chem/Phys and Bio/Biochem, which is true
// of the SUBJECT in the abstract and false of these particular decks. The
// library has already made the split: everything biologically-relevant, amino
// acids and peptides and proteins and carbohydrates and lipids and nucleic
// acids, sits under `biochemistry` and resolves to bio_biochem. What remains
// filed as `organic_chemistry` is Spectroscopy, Stereochemistry, Nomenclature,
// Separations, Alcohols, Aldehydes and Ketones, Carboxylic Acids and their
// derivatives, Nitrogen and Phosphorus compounds, Bonding, and Analyzing
// Organic Reactions. Every one of those is Chem/Phys content under AAMC
// category 5D. Mapping them there is reading the library, not guessing.
//
// The question bank cannot help: it holds no organic chemistry questions at
// all, so none of the twelve orgo decks resolves by route 1.
//
// SCIENTIFIC REASONING STAYS OUT, and that is a product decision rather than a
// gap. Those 119 cards are study method, not examinable content, so there is
// no section whose accuracy they would belong to. Excluding them from a
// section-filtered series is the correct answer, not a missing one.

/** MCAT section slugs, as the question bank spells them. */
export type McatSection = "bio_biochem" | "chem_phys" | "psych_soc" | "cars";

/**
 * Deck subject to MCAT section, for the decks the question bank cannot reach.
 *
 * Absent on purpose:
 *   organic_chemistry     tested under both Chem/Phys and Bio/Biochem
 *   scientific_reasoning  spans every section
 */
export const DECK_SUBJECT_TO_SECTION: Record<string, McatSection> = {
  biology: "bio_biochem",
  biochemistry: "bio_biochem",
  chemistry: "chem_phys",
  physics: "chem_phys",
  psych_soc: "psych_soc",
  // See the note above: the biologically-relevant organic chemistry is already
  // filed under `biochemistry`, so what is left here is Chem/Phys content.
  organic_chemistry: "chem_phys",
};

/**
 * Deck subjects with no MCAT section, and why.
 *
 * Not a backlog. A subject lands here when there is genuinely no section its
 * accuracy belongs to, which is different from one nobody has classified yet.
 */
export const UNSECTIONED_DECK_SUBJECTS: Record<string, string> = {
  scientific_reasoning: "study method rather than examinable content",
};

export interface SectionResolution {
  section: McatSection | null;
  /** How it was decided, so a caller can explain or exclude. */
  via: "QUESTION_BANK" | "DECLARED_MAP" | "UNSECTIONED" | "UNKNOWN";
}

/**
 * Which MCAT section a deck belongs to.
 *
 * `topicSections` maps a canonical topic key to the section the QUESTION BANK
 * files it under. Passing it lets route 1 run; without it only the declared
 * map applies.
 */
export function resolveDeckSection(
  deckSubject: string | null | undefined,
  canonicalKey: string | null | undefined,
  topicSections?: Map<string, McatSection>,
): SectionResolution {
  // 1. Ask the question bank first. It is the authority on what a topic is.
  if (canonicalKey && topicSections?.has(canonicalKey)) {
    return { section: topicSections.get(canonicalKey)!, via: "QUESTION_BANK" };
  }

  const subject = String(deckSubject ?? "").trim().toLowerCase();

  // 2. Having no section is an answer, and a different one from "not found".
  if (subject in UNSECTIONED_DECK_SUBJECTS) {
    return { section: null, via: "UNSECTIONED" };
  }

  // 3. The declared map.
  if (subject in DECK_SUBJECT_TO_SECTION) {
    return { section: DECK_SUBJECT_TO_SECTION[subject], via: "DECLARED_MAP" };
  }

  return { section: null, via: "UNKNOWN" };
}

/** Whether a deck's cards belong in a series filtered to `section`. */
export function deckMatchesSection(
  resolution: SectionResolution,
  section: string,
): boolean {
  if (section === "all") return true;
  // An unresolved deck is EXCLUDED rather than guessed into the bucket. A
  // filtered series that quietly includes cards it cannot place is worse than
  // one that admits its coverage.
  return resolution.section === section;
}
