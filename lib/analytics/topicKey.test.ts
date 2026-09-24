import { describe, it, expect } from "vitest";
import { canonicalTopicKey, buildTopicIndex } from "./topicKey";

describe("the four deck aliases added after the flashcard audit", () => {
  it.each([
    ["nonenzymatic_protein_function_and_protein_analysis", "Non-enzymatic Protein Function and Protein Analysis"],
    ["inside_the_atom", "Atomic Structure"],
    ["periodic_trends_and_chemical_families", "The Periodic Table"],
    ["amino_acids", "Amino Acids, Peptides, and Proteins"],
  ])("deck %s resolves to its chapter", (deckSlug, chapter) => {
    expect(canonicalTopicKey(deckSlug)).toBe(canonicalTopicKey(chapter));
  });

  it("still resolves the two aliases that existed before", () => {
    expect(canonicalTopicKey("Embryogenesis & Development")).toBe(canonicalTopicKey("embryonic_development_and_gestation"));
    expect(canonicalTopicKey("Reproduction")).toBe(canonicalTopicKey("cell_division_and_reproduction"));
  });

  it("does not make unrelated chapters collide", () => {
    // Atomic and Nuclear Phenomena is physics and was deliberately NOT aliased
    // to Atomic Structure, because its cards are photoelectric effect and work
    // function rather than subatomic particles.
    expect(canonicalTopicKey("atomic_and_nuclear_phenomena")).not.toBe(canonicalTopicKey("Atomic Structure"));
  });
});

describe("an alias resolves a DECK to a CHAPTER and assigns nothing to a CARD", () => {
  // The whole point of the regression: once a deck resolves, the tempting
  // shortcut is to hand every card in it that chapter's concepts. Nothing in
  // this module does that, and nothing built on it may either.
  it("exposes no card-level or concept-level assignment at all", async () => {
    const mod = await import("./topicKey");
    const exported = Object.keys(mod);
    expect(exported.sort()).toEqual(["buildTopicIndex", "canonicalTopicKey", "titleFromKey"]);
    for (const name of exported) {
      expect(name.toLowerCase()).not.toContain("concept");
      expect(name.toLowerCase()).not.toContain("card");
    }
  });

  it("buildTopicIndex reports coverage only, never a mapping", () => {
    const index = buildTopicIndex(["Atomic Structure"], ["inside_the_atom"]);
    const entry = index.get(canonicalTopicKey("Atomic Structure"))!;
    expect(entry.hasQuestions).toBe(true);
    expect(entry.hasCards).toBe(true);
    // It says both libraries touch this chapter. It does NOT say which concept
    // any individual card belongs to, and carries no field that could.
    expect(Object.keys(entry).sort()).toEqual(["hasCards", "hasQuestions", "key", "label"]);
  });

  it("an aliased deck with no questions still reports the gap honestly", () => {
    const index = buildTopicIndex([], ["inside_the_atom"]);
    const entry = index.get(canonicalTopicKey("Atomic Structure"))!;
    expect(entry.hasQuestions).toBe(false);
    expect(entry.hasCards).toBe(true);
  });
});
