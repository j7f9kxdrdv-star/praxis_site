import { describe, it, expect } from "vitest";
import {
  renameConcept, mergeConcepts, splitConcept, deprecateConcept,
  mayAutomationWrite, bankCoverage,
  type ConceptRecord, type ExistingMapping,
} from "./lifecycle";

const concept = (over: Partial<ConceptRecord> = {}): ConceptRecord => ({
  id: "c-1", slug: "ENZYME_INHIBITION", canonicalName: "Enzyme Inhibition",
  status: "ACTIVE_SEED", version: 1, deprecatedBy: null, ...over,
});

describe("rename preserves identity", () => {
  it("never changes the id and files the old name as an alias", () => {
    const c = concept();
    const acts = renameConcept(c, "Enzyme Inhibition Mechanisms");
    expect(acts.some(a => a.kind === "ADD_ALIAS" && a.alias === "Enzyme Inhibition")).toBe(true);
    const upd = acts.find(a => a.kind === "UPDATE_CONCEPT");
    expect(upd && "fields" in upd && upd.fields.canonicalName).toBe("Enzyme Inhibition Mechanisms");
    expect(acts.every(a => !("fields" in a) || !("id" in a.fields))).toBe(true);
  });

  it("bumps the version but touches no mapping", () => {
    const acts = renameConcept(concept(), "New Name");
    expect(acts.some(a => a.kind === "REPOINT_MAPPING" || a.kind === "FLAG_MAPPING")).toBe(false);
  });

  it("is a no-op when the name is unchanged", () => {
    expect(renameConcept(concept(), "Enzyme Inhibition")).toEqual([]);
  });
});

describe("merge moves evidence forward", () => {
  const loser = concept({ id: "c-lose", canonicalName: "Types of Reactions" });
  const winner = concept({ id: "c-win", canonicalName: "Reaction Types & Classification" });
  const maps: ExistingMapping[] = [
    { itemId: "q1", conceptId: "c-lose", mappingStatus: "DETERMINISTIC" },
    { itemId: "q2", conceptId: "c-lose", mappingStatus: "HUMAN_VALIDATED" },
    { itemId: "q3", conceptId: "other",  mappingStatus: "DETERMINISTIC" },
  ];

  it("repoints the loser's mappings and leaves other concepts alone", () => {
    const acts = mergeConcepts(loser, winner, maps);
    const moved = acts.filter(a => a.kind === "REPOINT_MAPPING");
    expect(moved).toHaveLength(2);
    expect(moved.every(a => "to" in a && a.to === "c-win")).toBe(true);
    expect(moved.some(a => "itemId" in a && a.itemId === "q3")).toBe(false);
  });

  it("moves a human-validated mapping too, because merging does not undo the judgement", () => {
    const acts = mergeConcepts(loser, winner, maps);
    expect(acts.some(a => a.kind === "REPOINT_MAPPING" && a.itemId === "q2")).toBe(true);
  });

  it("deprecates the loser pointing at the winner, so history resolves forward", () => {
    const upd = mergeConcepts(loser, winner, maps).find(
      a => a.kind === "UPDATE_CONCEPT" && a.id === "c-lose");
    expect(upd && "fields" in upd && upd.fields.status).toBe("DEPRECATED");
    expect(upd && "fields" in upd && upd.fields.deprecatedBy).toBe("c-win");
  });

  it("refuses to merge into a deprecated concept or into itself", () => {
    expect(() => mergeConcepts(loser, concept({ id: "c-x", status: "DEPRECATED" }), [])).toThrow();
    expect(() => mergeConcepts(loser, loser, [])).toThrow();
  });
});

describe("split refuses to guess", () => {
  const orig = concept({ id: "c-split", canonicalName: "Ketone Bodies & Ethanol" });
  const kids = [
    { slug: "KETONE_BODIES", canonicalName: "Ketone Bodies" },
    { slug: "ETHANOL_METABOLISM", canonicalName: "Ethanol Metabolism" },
  ];
  const maps: ExistingMapping[] = [
    { itemId: "q1", conceptId: "c-split", mappingStatus: "DETERMINISTIC" },
    { itemId: "q2", conceptId: "c-split", mappingStatus: "HUMAN_VALIDATED" },
  ];

  it("flags every existing mapping for review rather than assigning a child", () => {
    const acts = splitConcept(orig, kids, maps);
    const flagged = acts.filter(a => a.kind === "FLAG_MAPPING");
    expect(flagged).toHaveLength(2);
    expect(flagged.every(a => "status" in a && a.status === "NEEDS_REVIEW")).toBe(true);
    // The critical negative: nothing is silently repointed to a child.
    expect(acts.some(a => a.kind === "REPOINT_MAPPING")).toBe(false);
  });

  it("creates every child", () => {
    const made = splitConcept(orig, kids, maps).filter(a => a.kind === "CREATE_CONCEPT");
    expect(made).toHaveLength(2);
  });

  it("deprecates the original with NO successor, unlike a merge", () => {
    const upd = splitConcept(orig, kids, maps).find(
      a => a.kind === "UPDATE_CONCEPT" && a.id === "c-split");
    expect(upd && "fields" in upd && upd.fields.status).toBe("DEPRECATED");
    expect(upd && "fields" in upd && upd.fields.deprecatedBy).toBeNull();
  });

  it("rejects a split with fewer than two children", () => {
    expect(() => splitConcept(orig, [kids[0]], maps)).toThrow();
  });
});

describe("deprecation preserves history", () => {
  it("marks the concept without removing anything", () => {
    const acts = deprecateConcept(concept(), "c-successor");
    expect(acts).toHaveLength(1);
    const upd = acts[0];
    expect("fields" in upd && upd.fields.status).toBe("DEPRECATED");
    expect(acts.some(a => a.kind === "REPOINT_MAPPING" || a.kind === "FLAG_MAPPING")).toBe(false);
  });

  it("allows retirement with no successor", () => {
    const upd = deprecateConcept(concept())[0];
    expect("fields" in upd && upd.fields.deprecatedBy).toBeNull();
  });
});

describe("human validation outranks automation", () => {
  it("blocks an automated write over a human-validated mapping", () => {
    const r = mayAutomationWrite({ itemId: "q1", conceptId: "c1", mappingStatus: "HUMAN_VALIDATED" });
    expect(r.allowed).toBe(false);
    expect(r.reason).toMatch(/NEEDS_REVIEW candidate/);
  });

  it("permits a write over deterministic or AI mappings, and where none exists", () => {
    expect(mayAutomationWrite({ itemId: "q", conceptId: "c", mappingStatus: "DETERMINISTIC" }).allowed).toBe(true);
    expect(mayAutomationWrite({ itemId: "q", conceptId: "c", mappingStatus: "AI_PROPOSED" }).allowed).toBe(true);
    expect(mayAutomationWrite(null).allowed).toBe(true);
  });
});

describe("bank coverage is derived, never stored on the concept", () => {
  // Replaces the withdrawn concepts.evidence_floor column.
  it("refuses inference from a single question, which 191 seeded concepts have", () => {
    expect(bankCoverage(1)).toEqual({ level: "SPARSE", safeForInference: false });
  });

  it("refuses inference where the bank has nothing", () => {
    expect(bankCoverage(0)).toEqual({ level: "NONE", safeForInference: false });
  });

  it("allows inference once evidence exists", () => {
    expect(bankCoverage(3).safeForInference).toBe(true);
    expect(bankCoverage(23).level).toBe("ADEQUATE");
  });

  it("changes answer as the bank grows, which a stored threshold could not", () => {
    const before = bankCoverage(1), after = bankCoverage(20);
    expect(before.safeForInference).toBe(false);
    expect(after.safeForInference).toBe(true);
  });
});
