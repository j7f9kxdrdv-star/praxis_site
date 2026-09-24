import { describe, it, expect } from "vitest";
import {
  resolveLegacyValue,
  sectionForDiscipline,
  DISCIPLINES,
} from "./levels";
import { comparability, type ConceptRef } from "./resolve";
import { canonicalTopicKey } from "../analytics/topicKey";

// The 13 checks in Part 18 of the brief, in order, plus the invariants that
// keep the mismatch from quietly coming back.

describe("disciplines resolve to the right MCAT section", () => {
  // 1-5, and 6.
  it.each([
    ["general-chemistry", "CHEM_PHYS"],
    ["organic-chemistry", "CHEM_PHYS"],
    ["physics", "CHEM_PHYS"],
    ["biology", "BIO_BIOCHEM"],
    ["biochemistry", "BIO_BIOCHEM"],
    ["psychology", "PSYCH_SOC"],
    ["sociology", "PSYCH_SOC"],
  ])("questions.discipline %s -> %s", (value, section) => {
    expect(resolveLegacyValue("questions", "discipline", value).section).toBe(section);
  });

  it.each([
    ["chemistry", "CHEM_PHYS", "GENERAL_CHEMISTRY"],
    ["organic_chemistry", "CHEM_PHYS", "ORGANIC_CHEMISTRY"],
    ["physics", "CHEM_PHYS", "PHYSICS"],
    ["biology", "BIO_BIOCHEM", "BIOLOGY"],
    ["biochemistry", "BIO_BIOCHEM", "BIOCHEMISTRY"],
  ])("deck section %s -> section %s, discipline %s", (value, section, discipline) => {
    const m = resolveLegacyValue("flashcard_decks", "section", value);
    expect(m.section).toBe(section);
    expect(m.discipline).toBe(discipline);
  });
});

describe("MCAT section is not the same thing as discipline", () => {
  it("does not invent a section per discipline", () => {
    const sections = new Set(
      Object.values(DISCIPLINES)
        .map((d) => d.primarySection)
        .filter(Boolean),
    );
    expect(sections.size).toBeLessThanOrEqual(4);
  });

  it("reads a deck's discipline-shaped section as a DISCIPLINE, not a section", () => {
    const m = resolveLegacyValue("flashcard_decks", "section", "organic_chemistry");
    expect(m.discipline).toBe("ORGANIC_CHEMISTRY");
    expect(m.section).toBe("CHEM_PHYS");
    // The failure this guards against: ORGANIC_CHEMISTRY becoming a 5th section.
    expect(m.section).not.toBe("ORGANIC_CHEMISTRY");
  });

  it("treats the deck value psych_soc as a section and refuses to guess a discipline", () => {
    const m = resolveLegacyValue("flashcard_decks", "section", "psych_soc");
    expect(m.section).toBe("PSYCH_SOC");
    expect(m.discipline).toBeNull();
  });
});

describe("scientific reasoning stays off the content tree", () => {
  // 13 of the brief, and the recommendation in Part 13.
  it("is cross-cutting and belongs to no MCAT section", () => {
    const m = resolveLegacyValue("flashcard_decks", "section", "scientific_reasoning");
    expect(m.isCrossCutting).toBe(true);
    expect(m.section).toBeNull();
  });

  it("carries no section even when asked via the discipline table", () => {
    expect(sectionForDiscipline("SCIENTIFIC_REASONING")).toBeNull();
    expect(DISCIPLINES.SCIENTIFIC_REASONING.isCrossCutting).toBe(true);
  });
});

describe("CARS is not forced into the science taxonomy", () => {
  it("resolves as its own section with no discipline", () => {
    const m = resolveLegacyValue("questions", "section", "cars");
    expect(m.section).toBe("CARS");
    expect(m.discipline).toBeNull();
  });
});

describe("no fuzzy matching, ever", () => {
  // 9 of the brief.
  it("returns nulls for an unknown value rather than the nearest one", () => {
    for (const v of ["organic chem", "orgo", "ORGANIC-CHEMISTRY!", "bio", "chem"]) {
      const m = resolveLegacyValue("flashcard_decks", "section", v);
      expect(m.section).toBeNull();
      expect(m.discipline).toBeNull();
    }
  });

  it("accepts only exact values, case and whitespace aside", () => {
    expect(resolveLegacyValue("flashcard_decks", "section", "  BIOLOGY  ").discipline).toBe("BIOLOGY");
    expect(resolveLegacyValue("flashcard_decks", "section", "biologyy").discipline).toBeNull();
  });

  it("does not let one system's vocabulary resolve in another", () => {
    // 'chemistry' is a deck word; questions say 'general-chemistry'.
    expect(resolveLegacyValue("questions", "discipline", "chemistry").discipline).toBeNull();
    // and the reverse
    expect(resolveLegacyValue("flashcard_decks", "section", "general-chemistry").discipline).toBeNull();
  });
});

describe("unmapped is reported, not guessed", () => {
  // 8 and 10 of the brief.
  const q: ConceptRef[] = [
    { conceptId: "c1", slug: "a", canonicalName: "A", role: "PRIMARY", mappingStatus: "HUMAN_VALIDATED", source: "HUMAN_REVIEWED", confidence: 1 },
  ];
  const f: ConceptRef[] = [
    { conceptId: "c1", slug: "a", canonicalName: "A", role: "PRIMARY", mappingStatus: "AI_PROPOSED", source: "AI_PROPOSED", confidence: 0.8 },
  ];

  it("says which side is unmapped instead of returning a bare false", () => {
    expect(comparability([], f).reason).toBe("QUESTIONS_UNMAPPED");
    expect(comparability(q, []).reason).toBe("FLASHCARDS_UNMAPPED");
  });

  it("separates 'not mapped yet' from 'no content on one side'", () => {
    const other: ConceptRef[] = [{ ...f[0], conceptId: "c2" }];
    expect(comparability(q, other)).toEqual({ comparable: false, reason: "NO_SHARED_CONCEPT" });
  });

  it("is comparable only on a genuinely shared concept id", () => {
    expect(comparability(q, f)).toEqual({ comparable: true, reason: "OK" });
  });
});

describe("legacy behaviour is untouched", () => {
  // 7 and 12 of the brief: the existing chapter join must still work.
  it("still resolves the offset chapter join it always did", () => {
    expect(canonicalTopicKey("Carbohydrate Metabolism I")).toBe("carbohydrate_metabolism_i");
    expect(canonicalTopicKey("carbohydrate_metabolism_i")).toBe("carbohydrate_metabolism_i");
    expect(canonicalTopicKey("Embryogenesis & Development")).toBe("embryonic_development_and_gestation");
  });

  it("does not make the legacy resolver agree with things it never agreed with", () => {
    expect(canonicalTopicKey("Atomic Structure")).not.toBe(canonicalTopicKey("inside_the_atom"));
  });
});

describe("psych_soc stays at section level, deliberately", () => {
  it("resolves the section with certainty", () => {
    expect(resolveLegacyValue("flashcard_decks", "section", "psych_soc").section).toBe("PSYCH_SOC");
  });

  it("marks the discipline UNRESOLVED, not UNKNOWN", () => {
    // The distinction is the point: UNRESOLVED is a decision deferred, and the
    // section around it is still trustworthy. UNKNOWN is a value nobody mapped
    // and nothing about it can be relied on. Collapsing them to null loses that.
    const m = resolveLegacyValue("flashcard_decks", "section", "psych_soc");
    expect(m.discipline).toBeNull();
    expect(m.disciplineStatus).toBe("UNRESOLVED");
  });

  it("is not confused with a value that was never recognised", () => {
    const nonsense = resolveLegacyValue("flashcard_decks", "section", "psychsoc");
    expect(nonsense.disciplineStatus).toBe("UNKNOWN");
    expect(nonsense.section).toBeNull();
  });

  it("never guesses psychology or sociology from a deck", () => {
    for (const slug of ["psych_soc"]) {
      const m = resolveLegacyValue("flashcard_decks", "section", slug);
      expect(m.discipline).not.toBe("PSYCHOLOGY");
      expect(m.discipline).not.toBe("SOCIOLOGY");
    }
  });

  it("still resolves psychology and sociology when a QUESTION states them outright", () => {
    // The deferral is about decks, which do not say. A question that does say
    // must still resolve, or the deferral would spread where it is not needed.
    expect(resolveLegacyValue("questions", "discipline", "psychology").disciplineStatus).toBe("RESOLVED");
    expect(resolveLegacyValue("questions", "discipline", "sociology").discipline).toBe("SOCIOLOGY");
  });
});

describe("an unresolved discipline does not block concept mapping", () => {
  it("comparability depends on concepts alone, never on discipline", () => {
    // A psych_soc card carries no discipline. It must still be comparable to a
    // question once both are mapped, otherwise the deferral would quietly
    // exclude 778 cards from the learner model.
    const shared: ConceptRef[] = [
      { conceptId: "c9", slug: "s", canonicalName: "S", role: "PRIMARY", mappingStatus: "HUMAN_VALIDATED", source: "HUMAN_REVIEWED", confidence: 1 },
    ];
    expect(comparability(shared, shared)).toEqual({ comparable: true, reason: "OK" });
  });
});
