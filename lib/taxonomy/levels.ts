// ─── The semantic levels, and why they are not interchangeable ─────────────
//
// Praxist stores taxonomy in columns whose names promise more agreement than
// they deliver. Both questions and flashcard_decks have `section`, `topic` and
// `subtopic`; none of the three means the same thing on both sides.
//
//   LEVEL        questions                    flashcard_decks
//   section      MCAT section code            a DISCIPLINE (mostly)
//   topic        chapter                      subject
//   subtopic     concept OR question label    chapter, slugged
//
// The practical consequences, each of which has bitten already:
//
//   MCAT SECTION != DISCIPLINE. chem_phys holds general chemistry, organic
//   chemistry AND physics. Treating decks.section = 'organic_chemistry' as a
//   section produces a fifth MCAT section that does not exist.
//
//   TOPIC != CONCEPT. A chapter is not a thing a student can get wrong.
//
//   DECK != CONCEPT. A deck is a chapter's worth of cards. There are 73 of
//   them against 908 question labels, so a deck-level match is roughly 12x too
//   coarse to say "you remember this but cannot apply it".
//
// This module holds the deterministic part: the levels that can be resolved
// today without deciding the concept vocabulary. Everything here is an exact
// lookup. Nothing is scored and nothing is approximate.

/** The four MCAT sections. Fixed by the exam, not by us. */
export type McatSection = "CHEM_PHYS" | "CARS" | "BIO_BIOCHEM" | "PSYCH_SOC";

export type DisciplineCode =
  | "GENERAL_CHEMISTRY"
  | "ORGANIC_CHEMISTRY"
  | "PHYSICS"
  | "BIOLOGY"
  | "BIOCHEMISTRY"
  | "PSYCHOLOGY"
  | "SOCIOLOGY"
  | "SCIENTIFIC_REASONING";

export interface Discipline {
  code: DisciplineCode;
  name: string;
  /** NULL for a cross-cutting skill, which belongs to no content section. */
  primarySection: McatSection | null;
  isCrossCutting: boolean;
}

/**
 * SCIENTIFIC REASONING IS NOT A DISCIPLINE, and this is the one entry worth
 * arguing about. Its three decks are Mathematics, Data-Based and Statistical
 * Reasoning, and Reasoning About Research Design. Those are ways of thinking
 * applied ACROSS content, and they are the same axis the question bank already
 * records in questions.cognitive_skill (AAMC skills 1 to 4).
 *
 * Filing it as a discipline would put a skill inside the content tree, and the
 * learner model would then be unable to say the most useful thing it could say:
 * that someone knows the content and fails the reasoning.
 */
export const DISCIPLINES: Record<DisciplineCode, Discipline> = {
  GENERAL_CHEMISTRY:   { code: "GENERAL_CHEMISTRY",   name: "General Chemistry", primarySection: "CHEM_PHYS",   isCrossCutting: false },
  ORGANIC_CHEMISTRY:   { code: "ORGANIC_CHEMISTRY",   name: "Organic Chemistry", primarySection: "CHEM_PHYS",   isCrossCutting: false },
  PHYSICS:             { code: "PHYSICS",             name: "Physics",           primarySection: "CHEM_PHYS",   isCrossCutting: false },
  BIOLOGY:             { code: "BIOLOGY",             name: "Biology",           primarySection: "BIO_BIOCHEM", isCrossCutting: false },
  BIOCHEMISTRY:        { code: "BIOCHEMISTRY",        name: "Biochemistry",      primarySection: "BIO_BIOCHEM", isCrossCutting: false },
  PSYCHOLOGY:          { code: "PSYCHOLOGY",          name: "Psychology",        primarySection: "PSYCH_SOC",   isCrossCutting: false },
  SOCIOLOGY:           { code: "SOCIOLOGY",           name: "Sociology",         primarySection: "PSYCH_SOC",   isCrossCutting: false },
  SCIENTIFIC_REASONING:{ code: "SCIENTIFIC_REASONING",name: "Scientific Reasoning", primarySection: null,       isCrossCutting: true  },
};

/** What a legacy string actually denotes, once read at the right level. */
export interface LegacyMeaning {
  section: McatSection | null;
  discipline: DisciplineCode | null;
  /** True when the legacy value names a reasoning skill rather than content. */
  isCrossCutting: boolean;
  note?: string;
}

const UNKNOWN: LegacyMeaning = { section: null, discipline: null, isCrossCutting: false };

/**
 * questions.section already holds real MCAT section codes.
 */
const QUESTION_SECTION: Record<string, LegacyMeaning> = {
  chem_phys:   { section: "CHEM_PHYS",   discipline: null, isCrossCutting: false },
  bio_biochem: { section: "BIO_BIOCHEM", discipline: null, isCrossCutting: false },
  psych_soc:   { section: "PSYCH_SOC",   discipline: null, isCrossCutting: false },
  cars:        { section: "CARS",        discipline: null, isCrossCutting: false },
};

/**
 * questions.discipline is a real discipline; only the spelling is legacy.
 */
const QUESTION_DISCIPLINE: Record<string, LegacyMeaning> = {
  "general-chemistry": { section: "CHEM_PHYS",   discipline: "GENERAL_CHEMISTRY", isCrossCutting: false },
  "organic-chemistry": { section: "CHEM_PHYS",   discipline: "ORGANIC_CHEMISTRY", isCrossCutting: false },
  physics:             { section: "CHEM_PHYS",   discipline: "PHYSICS",           isCrossCutting: false },
  biology:             { section: "BIO_BIOCHEM", discipline: "BIOLOGY",           isCrossCutting: false },
  biochemistry:        { section: "BIO_BIOCHEM", discipline: "BIOCHEMISTRY",      isCrossCutting: false },
  psychology:          { section: "PSYCH_SOC",   discipline: "PSYCHOLOGY",        isCrossCutting: false },
  sociology:           { section: "PSYCH_SOC",   discipline: "SOCIOLOGY",         isCrossCutting: false },
};

/**
 * flashcard_decks.section is the mixed-level column: six of its eight values
 * are disciplines, one is an MCAT section, and one is a reasoning skill.
 */
const DECK_SECTION: Record<string, LegacyMeaning> = {
  chemistry:         { section: "CHEM_PHYS",   discipline: "GENERAL_CHEMISTRY", isCrossCutting: false, note: 'Named "chemistry"; means general chemistry.' },
  organic_chemistry: { section: "CHEM_PHYS",   discipline: "ORGANIC_CHEMISTRY", isCrossCutting: false },
  physics:           { section: "CHEM_PHYS",   discipline: "PHYSICS",           isCrossCutting: false },
  biology:           { section: "BIO_BIOCHEM", discipline: "BIOLOGY",           isCrossCutting: false },
  biochemistry:      { section: "BIO_BIOCHEM", discipline: "BIOCHEMISTRY",      isCrossCutting: false },
  // An MCAT section, not a discipline. Its 12 decks span psychology and
  // sociology; splitting them is a judgement call left for review, so the
  // discipline stays null rather than being guessed.
  psych_soc:         { section: "PSYCH_SOC",   discipline: null,                isCrossCutting: false, note: "Section-level only; discipline deliberately unresolved." },
  // Neither a section nor content.
  scientific_reasoning: { section: null, discipline: "SCIENTIFIC_REASONING", isCrossCutting: true, note: "Reasoning skill, not content. Belongs on the AAMC skill axis." },
};

/**
 * Read a legacy taxonomy string at its true level.
 *
 * EXACT LOOKUP ONLY. An unrecognised value returns nulls rather than a guess,
 * because a wrong section silently mis-files a student's evidence, and that is
 * worse than an absent one.
 */
export function resolveLegacyValue(
  system: "questions" | "flashcard_decks",
  field: "section" | "discipline",
  value: string | null | undefined,
): LegacyMeaning {
  if (!value) return UNKNOWN;
  const key = value.trim().toLowerCase();
  const table =
    system === "questions"
      ? field === "section" ? QUESTION_SECTION : QUESTION_DISCIPLINE
      : DECK_SECTION;
  return table[key] ?? UNKNOWN;
}

/** The section a discipline principally serves. Null for cross-cutting. */
export function sectionForDiscipline(code: DisciplineCode | null): McatSection | null {
  return code ? DISCIPLINES[code].primarySection : null;
}
