import { describe, it, expect } from "vitest";
import {
  resolveDeckSection,
  deckMatchesSection,
  DECK_SUBJECT_TO_SECTION,
  UNSECTIONED_DECK_SUBJECTS,
  type McatSection,
} from "./sectionMap";

const bank = new Map<string, McatSection>([
  ["enzymes", "bio_biochem"],
  ["atomic_structure", "chem_phys"],
]);

describe("the question bank is asked first", () => {
  it("takes the section from the bank when the topic is known there", () => {
    // Even though the deck is filed under biochemistry, the bank is the
    // authority on what a topic is.
    const r = resolveDeckSection("biochemistry", "enzymes", bank);
    expect(r).toEqual({ section: "bio_biochem", via: "QUESTION_BANK" });
  });

  it("falls back to the declared map when the bank has never seen the topic", () => {
    const r = resolveDeckSection("physics", "waves_and_sound", bank);
    expect(r).toEqual({ section: "chem_phys", via: "DECLARED_MAP" });
  });
});

describe("ORGANIC CHEMISTRY IS CHEM/PHYS, and that is read, not guessed", () => {
  // It was previously called ambiguous on the grounds that orgo is tested in
  // both sections. True of the subject, false of these decks: the library
  // already files the biologically-relevant organic chemistry under
  // biochemistry, leaving Spectroscopy, Stereochemistry, Nomenclature,
  // Separations, Alcohols, Aldehydes and Ketones and the rest, all of which
  // are Chem/Phys under AAMC 5D.

  it("resolves rather than excluding", () => {
    const r = resolveDeckSection("organic_chemistry", "aldehydes_and_ketones_i", bank);
    expect(r.section).toBe("chem_phys");
    expect(r.via).toBe("DECLARED_MAP");
  });

  it("does not steal the biochemistry decks on the way", () => {
    // Amino acids, carbohydrates and lipids are organic chemistry by content
    // and biochemistry by filing. The filing wins, because that is where the
    // student studies them.
    for (const topic of ["amino_acids", "carbohydrate_structure_and_function", "lipid_structure_and_function"]) {
      expect(resolveDeckSection("biochemistry", topic, bank).section).toBe("bio_biochem");
    }
  });
});

describe("scientific reasoning has no section ON PURPOSE", () => {
  it("is reported as unsectioned, not as unknown", () => {
    // "No section exists for this" and "nobody has classified this yet" are
    // different states and must not be collapsed.
    const r = resolveDeckSection("scientific_reasoning", "study_method", bank);
    expect(r).toEqual({ section: null, via: "UNSECTIONED" });
    expect(UNSECTIONED_DECK_SUBJECTS.scientific_reasoning).toMatch(/study method/i);
  });

  it("is the ONLY subject left without one", () => {
    expect(Object.keys(UNSECTIONED_DECK_SUBJECTS)).toEqual(["scientific_reasoning"]);
  });

  it("reports an unrecognised subject as unknown, separately", () => {
    expect(resolveDeckSection("astrology", "star_signs", bank).via).toBe("UNKNOWN");
  });
});

describe("filtering excludes rather than guesses", () => {
  it("keeps everything when no section is selected", () => {
    expect(deckMatchesSection({ section: null, via: "UNSECTIONED" }, "all")).toBe(true);
  });

  it("DROPS a deck it cannot place rather than bucketing it", () => {
    // A filtered series that quietly includes cards it cannot place is worse
    // than one that admits its coverage.
    expect(deckMatchesSection({ section: null, via: "UNSECTIONED" }, "chem_phys")).toBe(false);
    expect(deckMatchesSection({ section: null, via: "UNKNOWN" }, "chem_phys")).toBe(false);
  });

  it("keeps only the matching section", () => {
    expect(deckMatchesSection({ section: "chem_phys", via: "DECLARED_MAP" }, "chem_phys")).toBe(true);
    expect(deckMatchesSection({ section: "bio_biochem", via: "DECLARED_MAP" }, "chem_phys")).toBe(false);
  });
});

describe("every mapped subject points at a real MCAT section", () => {
  it("uses only the four section slugs the question bank spells", () => {
    const valid = new Set(["bio_biochem", "chem_phys", "psych_soc", "cars"]);
    for (const [subject, section] of Object.entries(DECK_SUBJECT_TO_SECTION)) {
      expect(valid.has(section), `${subject} -> ${section}`).toBe(true);
    }
  });

  it("never maps a subject that is also declared unsectioned", () => {
    for (const subject of Object.keys(UNSECTIONED_DECK_SUBJECTS)) {
      expect(subject in DECK_SUBJECT_TO_SECTION).toBe(false);
    }
  });
});
