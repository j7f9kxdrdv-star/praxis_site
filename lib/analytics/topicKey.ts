// ─── The canonical topic key ───────────────────────────────────────────────
//
// Questions and flashcards describe the same syllabus in two different shapes,
// and until this file there was no way to say "the recall evidence and the
// application evidence are about the same thing".
//
// WHAT THE TWO TAXONOMIES ACTUALLY LOOK LIKE. They are offset by one level,
// which is why every same-named comparison returns nothing:
//
//   questions.section    bio_biochem, chem_phys          MCAT section codes
//   questions.topic      "Carbohydrate Metabolism I"     CHAPTER, human text
//   questions.subtopic   904 distinct                    learning objective
//
//   decks.section        biochemistry, physics, ...      subject names
//   decks.topic          "Biochemistry"                  SUBJECT
//   decks.subtopic       carbohydrate_metabolism_i       CHAPTER, slug
//
// So the join that means something is questions.topic against decks.subtopic,
// and the only thing standing between them is formatting.
//
// THIS IS NORMALISATION, NOT FUZZY MATCHING. Everything below is a
// deterministic string transform followed by an EXACT comparison. Nothing is
// scored, nothing is approximate, and two concepts that are genuinely named
// differently do not match by accident: they go in ALIASES, by hand, where they
// can be read and argued with. The spec's warning about joining "Amino Acid" to
// "Amino Acids" by similarity is exactly what this avoids.
//
// MEASURED against the live bank: 27 of 33 question topics resolve to a deck,
// covering 2,202 of 2,633 questions. The remainder are genuine content gaps
// where a topic has questions and no cards, and those must read as "no recall
// evidence", never as weak recall.

/**
 * Fold a topic or deck name to its canonical key.
 *
 * Lowercase, ampersand spelled out, punctuation dropped, runs of whitespace or
 * underscore collapsed to one underscore. "Embryogenesis & Development" and
 * "embryogenesis_and_development" both become embryogenesis_and_development.
 */
export function canonicalTopicKey(raw: string | null | undefined): string {
  const folded = String(raw ?? "")
    .toLowerCase()
    .trim()
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9\s_]/g, " ")
    .replace(/[\s_]+/g, "_")
    .replace(/^_|_$/g, "");
  return ALIASES[folded] ?? folded;
}

/**
 * Concepts the two libraries genuinely named differently.
 *
 * BY HAND ON PURPOSE. Each line is a claim that two differently-named things
 * are the same piece of syllabus, and that claim should be reviewable. Adding
 * a similarity threshold here instead would silently join things nobody
 * checked.
 *
 * Left side is the canonicalised QUESTION topic; right side is the
 * canonicalised DECK subtopic it corresponds to.
 */
const ALIASES: Record<string, string> = {
  // Questions call this Embryogenesis; the deck library calls it Embryonic
  // Development. Same chapter.
  embryogenesis_and_development: "embryonic_development_and_gestation",
  // The question bank's Reproduction chapter is the deck library's Cell
  // Division and Reproduction.
  reproduction: "cell_division_and_reproduction",
};

/** A topic that exists on one side of the join and not the other. */
export interface TopicCoverage {
  key: string;
  /** The human-readable name, preferred from the question bank. */
  label: string;
  hasQuestions: boolean;
  hasCards: boolean;
}

/**
 * Resolve both libraries onto one key space.
 *
 * Returns every topic either side knows about, so a caller can tell the three
 * cases apart: both (joinable), questions only (no recall evidence exists), and
 * cards only (no application evidence exists). Collapsing those three into two
 * is how a content gap starts reading as a student weakness.
 */
export function buildTopicIndex(
  questionTopics: (string | null | undefined)[],
  deckSubtopics: (string | null | undefined)[],
): Map<string, TopicCoverage> {
  const index = new Map<string, TopicCoverage>();

  for (const raw of questionTopics) {
    const key = canonicalTopicKey(raw);
    if (!key) continue;
    const existing = index.get(key);
    if (existing) existing.hasQuestions = true;
    else index.set(key, { key, label: String(raw), hasQuestions: true, hasCards: false });
  }

  for (const raw of deckSubtopics) {
    const key = canonicalTopicKey(raw);
    if (!key) continue;
    const existing = index.get(key);
    if (existing) {
      existing.hasCards = true;
    } else {
      // No question-bank name for this one, so fall back to un-slugging the
      // deck's own name rather than showing a raw slug to a student.
      index.set(key, { key, label: titleFromKey(key), hasQuestions: false, hasCards: true });
    }
  }

  return index;
}

/** carbohydrate_metabolism_i -> "Carbohydrate Metabolism I" */
export function titleFromKey(key: string): string {
  return key
    .split("_")
    .filter(Boolean)
    .map((w) =>
      // Roman numerals and short connectives read wrong in title case.
      /^(i|ii|iii|iv|v|vi|dna|rna|atp)$/.test(w)
        ? w.toUpperCase()
        : /^(and|of|the|in|to|a)$/.test(w)
          ? w
          : w.charAt(0).toUpperCase() + w.slice(1),
    )
    .join(" ")
    .replace(/^./, (c) => c.toUpperCase());
}
