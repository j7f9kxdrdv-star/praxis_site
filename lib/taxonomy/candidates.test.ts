import { describe, it, expect } from "vitest";
import { candidatesFor, eligibility, type ConceptFacts, type QuestionFacts } from "./candidates";

const concept = (over: Partial<ConceptFacts> & { id: string }): ConceptFacts => ({
  canonicalName: over.id, status: "ACTIVE_SEED",
  sections: new Set(["BIO_BIOCHEM"]), contentCategories: new Set(["Enzyme Activity"]),
  disciplines: new Set(["BIOCHEMISTRY"]), topics: new Set(["Enzymes"]),
  ...over,
});

const question = (over: Partial<QuestionFacts> = {}): QuestionFacts => ({
  section: "bio_biochem", contentCategory: "Enzyme Activity",
  discipline: "biochemistry", topic: "Enzymes", ...over,
});

const MATCH = concept({ id: "ENZYME_INHIBITION", canonicalName: "Enzyme Inhibition" });

describe("candidate restriction is exact on every axis", () => {
  it("keeps a concept matching all four", () => {
    expect(candidatesFor(question(), [MATCH]).map(c => c.id)).toEqual(["ENZYME_INHIBITION"]);
  });

  it("excludes on a section mismatch, which makes a cross-section mapping unreachable", () => {
    const wrong = concept({ id: "X", sections: new Set(["CHEM_PHYS"]) });
    expect(candidatesFor(question(), [wrong])).toEqual([]);
  });

  it("excludes on a content-category mismatch", () => {
    const wrong = concept({ id: "X", contentCategories: new Set(["Lipids"]) });
    expect(candidatesFor(question(), [wrong])).toEqual([]);
  });

  it("excludes on a discipline mismatch", () => {
    const wrong = concept({ id: "X", disciplines: new Set(["BIOLOGY"]) });
    expect(candidatesFor(question(), [wrong])).toEqual([]);
  });

  it("excludes on a chapter mismatch, the axis that refuses 417 questions", () => {
    const wrong = concept({ id: "X", topics: new Set(["The Cell"]) });
    expect(candidatesFor(question(), [wrong])).toEqual([]);
  });

  it("excludes a DEPRECATED concept even when everything else matches", () => {
    const dead = concept({ id: "X", status: "DEPRECATED" });
    expect(candidatesFor(question(), [dead])).toEqual([]);
  });

  it("accepts a concept spanning two sections when one of them matches", () => {
    // The Isoelectric Focusing case: one concept, two sections, both valid.
    const both = concept({ id: "ISO", sections: new Set(["CHEM_PHYS", "BIO_BIOCHEM"]) });
    expect(candidatesFor(question(), [both])).toHaveLength(1);
  });
});

describe("failing closed", () => {
  it("narrows to nothing on an unrecognised section, never to everything", () => {
    expect(candidatesFor(question({ section: "made_up" }), [MATCH])).toEqual([]);
  });

  it("narrows to nothing on an unrecognised discipline", () => {
    expect(candidatesFor(question({ discipline: "alchemy" }), [MATCH])).toEqual([]);
  });
});

describe("the two ways of having no candidates are not the same", () => {
  it("reports VOCABULARY_GAP when the chapter has no concepts", () => {
    // The seven descriptor-only chapters. A real hole, needing a human decision.
    const r = eligibility(question({ topic: "DNA and Biotechnology" }), [MATCH]);
    expect(r).toEqual({ eligible: false, reason: "VOCABULARY_GAP" });
  });

  it("reports UNKNOWN_CLASSIFICATION when the question's own metadata is unreadable", () => {
    const r = eligibility(question({ section: "nonsense" }), [MATCH]);
    expect(r).toEqual({ eligible: false, reason: "UNKNOWN_CLASSIFICATION" });
  });

  it("is eligible only with at least one lawful candidate", () => {
    const r = eligibility(question(), [MATCH]);
    expect(r.eligible).toBe(true);
    expect(r.eligible && r.candidates).toHaveLength(1);
  });

  it("never proposes for a question whose vocabulary does not exist", () => {
    // The guarantee that matters: an empty vocabulary produces no mapping,
    // rather than the nearest available concept.
    const r = eligibility(question(), []);
    expect(r.eligible).toBe(false);
  });
});
