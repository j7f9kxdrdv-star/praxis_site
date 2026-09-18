import { describe, it, expect } from "vitest";
import {
  structuralFindings,
  adjacentParentheticals,
  auditCardStructure,
  classifyRewrite,
  checkRewriteSafety,
  decideAction,
  sanitizeRewrite,
  visibleComposition,
} from "./leakSafety";
import { expandStudyVariants } from "./studyVariants";

const codes = (original: string, proposed: string) =>
  checkRewriteSafety(original, proposed).violations.map((v) => v.code);

describe("TEST 3 — a shared group is not a defect", () => {
  const kinetic =
    "The {{c1::kinetic enolate}} forms at low temperature with a bulky base; the {{c1::thermodynamic enolate}} forms at high temperature under equilibrium.";

  it("finds nothing structurally wrong", () => {
    expect(structuralFindings(kinetic)).toEqual([]);
  });

  it("hides both terms on the single study card", () => {
    const [v] = expandStudyVariants(kinetic);
    expect(v.prompt).not.toMatch(/kinetic enolate|thermodynamic enolate/);
  });

  it("refuses the split the old judge recommended for this card", () => {
    const split = kinetic.replace("{{c1::thermodynamic enolate}}", "{{c2::thermodynamic enolate}}");
    const report = checkRewriteSafety(kinetic, split);
    expect(report.kind).toBe("SPLIT_GROUPS");
    expect(report.safe).toBe(false);
    expect(report.violations.map((v) => v.code)).toContain("BREAKS_CO_MASKED_PAIR");
  });

  it("withholds that rewrite rather than showing it to a human as a fix", () => {
    const split = kinetic.replace("{{c1::thermodynamic enolate}}", "{{c2::thermodynamic enolate}}");
    const d = decideAction(true, split, checkRewriteSafety(kinetic, split));
    expect(d.surfaceRewrite).toBe(false);
    expect(d.recommendedAction).toBe("HUMAN_REVIEW");
    expect(d.notes.join(" ")).toMatch(/BREAKS_CO_MASKED_PAIR/);
  });
});

describe("TEST 4 — simulating a split proves it creates the leak", () => {
  const safe = "{{c1::Dispositional}} attributions cite traits; {{c1::situational}} attributions cite context.";
  const split = "{{c1::Dispositional}} attributions cite traits; {{c2::situational}} attributions cite context.";

  it("rejects the rewrite on the rendered variants, not on the markup", () => {
    const report = checkRewriteSafety(safe, split);
    expect(report.safe).toBe(false);
    const detail = report.violations.map((v) => v.detail).join(" ");
    expect(detail).toMatch(/hidden together today/);
  });

  it("names the study item where the exposure appears", () => {
    const report = checkRewriteSafety(safe, split);
    // Both variants of the split expose the partner, so both are reported.
    expect(report.violations.filter((v) => v.code === "BREAKS_CO_MASKED_PAIR")).toHaveLength(2);
  });

  it("accepts the reverse direction: merging the split card back", () => {
    const report = checkRewriteSafety(split, safe);
    expect(report.kind).toBe("MERGE_GROUPS");
    expect(report.safe).toBe(true);
  });
});

describe("TEST 5 — a visible synonym is fixed by wording, not by numbering", () => {
  const card = "The {{c1::O-H}} stretch of an alcohol produces a {{c2::broad}} (wide) peak near 3300 per cm.";

  it("leaves the synonym on screen when the term is blanked", () => {
    const [, second] = expandStudyVariants(card);
    expect(second.hiddenAnswers).toEqual(["broad"]);
    expect(second.prompt).toContain("(wide)");
  });

  it("flags the parenthetical as a candidate for the model to judge", () => {
    const [, second] = expandStudyVariants(card);
    expect(adjacentParentheticals(second)).toEqual(["wide"]);
  });

  it("accepts dropping the synonym and surfaces it as a reword", () => {
    const fixed = "The {{c1::O-H}} stretch of an alcohol produces a {{c2::broad}} peak near 3300 per cm.";
    const safety = checkRewriteSafety(card, fixed);
    expect(safety.kind).toBe("REWORD");
    expect(safety.safe).toBe(true);
    expect(decideAction(true, fixed, safety).recommendedAction).toBe("REWORD");
  });

  it("accepts pulling the synonym into the same group as the answer", () => {
    const merged = "The {{c1::O-H}} stretch of an alcohol produces a {{c2::broad}} ({{c2::wide}}) peak near 3300 per cm.";
    const safety = checkRewriteSafety(card, merged);
    expect(safety.safe).toBe(true);
  });

  it("refuses a rewrite that answers the synonym by deleting the tested term", () => {
    const gutted = "The {{c1::O-H}} stretch of an alcohol produces a wide peak near 3300 per cm.";
    expect(codes(card, gutted)).toContain("DROPS_TESTED_ANSWER");
  });
});

describe("TEST 6 — a parenthetical that restates the answer", () => {
  const card = "A {{c1::downfield}} (higher chemical shift) signal means the proton is deshielded.";

  it("is found next to the blank on the rendered card", () => {
    const [v] = expandStudyVariants(card);
    expect(adjacentParentheticals(v)).toEqual(["higher chemical shift"]);
  });

  it("is reported by the structure pass as a candidate, not as a verdict", () => {
    const s = auditCardStructure(card);
    expect(s.findings).toEqual([]);
    expect(s.candidates).toEqual([{ activeGroup: 1, parentheticals: ["higher chemical shift"] }]);
  });

  it("is cleared by removing the gloss", () => {
    const fixed = "A {{c1::downfield}} signal means the proton is deshielded.";
    const safety = checkRewriteSafety(card, fixed);
    expect(safety.safe).toBe(true);
    expect(safety.kind).toBe("REWORD");
  });
});

describe("TEST 8 — the same card audits the same way every time", () => {
  const cards = [
    "The {{c1::pulmonary}} circuit and the {{c1::systemic}} circuit.",
    "Glycolysis makes {{c1::two}} ATP and {{c3::two}} NADH.",
    "A {{c1::downfield}} (higher chemical shift) signal.",
    "The {{c1::O-H}} stretch gives a {{c2::broad}} peak, and O-H is easy to spot.",
  ];

  it("returns deep-equal structure across repeated runs", () => {
    for (const c of cards) {
      expect(auditCardStructure(c)).toEqual(auditCardStructure(c));
    }
  });

  it("returns deep-equal safety reports across repeated runs", () => {
    const a = "{{c1::alpha}} and {{c1::beta}} anomers.";
    const b = "{{c1::alpha}} and {{c2::beta}} anomers.";
    expect(checkRewriteSafety(a, b)).toEqual(checkRewriteSafety(a, b));
  });

  it("does not depend on call order between cards", () => {
    const forward = cards.map((c) => auditCardStructure(c));
    const backward = cards.slice().reverse().map((c) => auditCardStructure(c)).reverse();
    expect(forward).toEqual(backward);
  });
});

describe("leaks code can prove on its own", () => {
  it("catches an answer printed elsewhere on the same card", () => {
    const card = "The {{c1::O-H}} stretch is broad because O-H bonds hydrogen bond to each other.";
    const found = structuralFindings(card);
    expect(found).toHaveLength(1);
    expect(found[0].leakType).toBe("VERBATIM_ANSWER_VISIBLE");
  });

  it("does not count an answer repeated inside its own group, since it masks too", () => {
    const card = "The {{c1::O-H}} stretch is broad because {{c1::O-H}} bonds associate.";
    expect(structuralFindings(card)).toEqual([]);
  });

  it("catches a scheduled item with nothing to hide", () => {
    const found = structuralFindings("Glycolysis occurs in the {{c1::cytosol}} and yields {{c3::two}} ATP.", 2);
    expect(found.map((f) => f.leakType)).toEqual(["NOTHING_MASKED"]);
  });

  it("catches both at once when a gappy card also repeats an answer", () => {
    // Written c1/c3 with the same word behind both blanks: item 1 prints "two"
    // while hiding "two", and item 2 hides nothing at all.
    const found = structuralFindings("Glycolysis makes {{c1::two}} ATP and {{c3::two}} NADH.", 2);
    expect(found.map((f) => f.leakType)).toEqual([
      "VERBATIM_ANSWER_VISIBLE",
      "NOTHING_MASKED",
    ]);
  });

  it("does not fire on a well-formed card", () => {
    expect(structuralFindings("The {{c1::mitochondrion}} makes ATP by oxidative phosphorylation.")).toEqual([]);
  });
});

describe("classifying what a rewrite actually does", () => {
  const base = "The {{c1::alpha}} anomer and the {{c2::beta}} anomer differ at the anomeric carbon.";

  it("reads a merge off the two texts", () => {
    const merged = base.replace("{{c2::beta}}", "{{c1::beta}}");
    expect(classifyRewrite(base, merged)).toBe("MERGE_GROUPS");
  });

  it("reads a split off the two texts", () => {
    const merged = base.replace("{{c2::beta}}", "{{c1::beta}}");
    expect(classifyRewrite(merged, base)).toBe("SPLIT_GROUPS");
  });

  it("reads a reword when only the visible prose moves", () => {
    const reworded = base.replace("differ at the anomeric carbon", "differ in configuration at C1");
    expect(classifyRewrite(base, reworded)).toBe("REWORD");
  });

  it("calls a whitespace-only edit no change", () => {
    expect(classifyRewrite(base, base.replace(/ /g, "  "))).toBe("NO_CHANGE");
  });

  it("calls a simultaneous regroup and rewrite mixed", () => {
    const both = "The {{c1::alpha}} anomer and the {{c1::beta}} anomer differ in configuration at C1.";
    expect(classifyRewrite(base, both)).toBe("MIXED");
  });

  it("does not trust the label a model attaches to its own rewrite", () => {
    // A split dressed up as a merge is still classified from the text.
    const merged = base.replace("{{c2::beta}}", "{{c1::beta}}");
    expect(classifyRewrite(merged, base)).not.toBe("MERGE_GROUPS");
  });
});

describe("rewrites are rejected on their rendered consequences", () => {
  it("refuses one that leaves a gap in the numbering", () => {
    const card = "The {{c1::alpha}} and {{c2::beta}} anomers.";
    const gapped = "The {{c1::alpha}} and {{c3::beta}} anomers.";
    expect(codes(card, gapped)).toContain("NOTHING_MASKED");
  });

  it("refuses one that makes a hidden answer readable elsewhere", () => {
    const card = "An {{c1::aldose}} has a terminal carbonyl; a {{c2::ketose}} has an internal one.";
    const bad = "An {{c1::aldose}} has a terminal carbonyl; a ketose has an internal one, unlike an aldose.";
    expect(codes(card, bad)).toContain("NEW_VERBATIM_EXPOSURE");
  });

  it("refuses malformed cloze text outright", () => {
    expect(codes("The {{c1::alpha}} anomer.", "The alpha anomer.")).toEqual(["INVALID_CLOZE"]);
  });

  it("lets a clean merge through", () => {
    const card = "An {{c1::aldose}} has a terminal carbonyl; a {{c2::ketose}} has an internal one.";
    const merged = "An {{c1::aldose}} has a terminal carbonyl; a {{c1::ketose}} has an internal one.";
    const report = checkRewriteSafety(card, merged);
    expect(report.safe).toBe(true);
    expect(decideAction(true, merged, report).recommendedAction).toBe("MERGE_GROUPS");
  });
});

describe("what reaches a human", () => {
  it("says nothing about a clean card", () => {
    const d = decideAction(false, null, null);
    expect(d.overallStatus).toBe("SAFE");
    expect(d.recommendedAction).toBe("NONE");
  });

  it("asks for a human when a leak is claimed with no fix", () => {
    expect(decideAction(true, null, null).overallStatus).toBe("NEEDS_HUMAN_REVIEW");
  });

  it("asks for a human when the fix is identical to the card", () => {
    const card = "The {{c1::alpha}} anomer.";
    const d = decideAction(true, card, checkRewriteSafety(card, card));
    expect(d.overallStatus).toBe("NEEDS_HUMAN_REVIEW");
    expect(d.surfaceRewrite).toBe(false);
  });

  it("never auto-recommends a split, even a mechanically clean one", () => {
    // Two unrelated facts sharing a group: splitting exposes nothing, and it
    // still goes to a human, because whether each half stands alone is a
    // teaching question this tool has no standing to answer.
    const card = "Glycolysis occurs in the {{c1::cytosol}} and yields {{c1::two}} ATP.";
    const split = "Glycolysis occurs in the {{c1::cytosol}} and yields {{c2::two}} ATP.";
    const report = checkRewriteSafety(card, split);
    expect(report.kind).toBe("SPLIT_GROUPS");
    const d = decideAction(true, split, report);
    expect(d.recommendedAction).toBe("HUMAN_REVIEW");
  });
});

describe("reading a rewrite the model sent back", () => {
  const original = "The {{c1::alpha}} anomer.";

  it("ignores the empty answer, however it was spelled", () => {
    // All three of these arrived from a live judge meaning "no change".
    expect(sanitizeRewrite("", original)).toBeNull();
    expect(sanitizeRewrite('""', original)).toBeNull();
    expect(sanitizeRewrite("   ", original)).toBeNull();
  });

  it("ignores prose with no cloze tokens in it", () => {
    expect(sanitizeRewrite("No change needed, the card is fine.", original)).toBeNull();
  });

  it("ignores a rewrite identical to the card", () => {
    expect(sanitizeRewrite(`  ${original}  `, original)).toBeNull();
  });

  it("unwraps a quoted rewrite rather than throwing it away", () => {
    expect(sanitizeRewrite('"The {{c1::alpha}} and {{c1::beta}} anomers."', original)).toBe(
      "The {{c1::alpha}} and {{c1::beta}} anomers.",
    );
  });

  it("passes a real rewrite through untouched", () => {
    const fix = "The {{c1::alpha}} and {{c1::beta}} anomers.";
    expect(sanitizeRewrite(fix, original)).toBe(fix);
  });
});

describe("pulling the giveaway inside the blank", () => {
  // The fix the house style asks for: the gloss moves into the group it was
  // giving away, so it hides with the answer.
  const card =
    "Each orbital holds at most {{c1::two electrons}}, which must have {{c2::opposite spins}} (one +1/2 and one -1/2).";
  const absorbed =
    "Each orbital holds at most {{c1::two electrons}}, which must have {{c2::opposite spins (one +1/2 and one -1/2)}}.";

  it("is not treated as dropping the tested answer", () => {
    const report = checkRewriteSafety(card, absorbed);
    expect(report.violations.map((v) => v.code)).not.toContain("DROPS_TESTED_ANSWER");
    expect(report.safe).toBe(true);
  });

  it("hides the gloss along with the answer", () => {
    const [, second] = expandStudyVariants(absorbed);
    expect(second.prompt).not.toContain("+1/2");
  });

  it("still catches an answer that genuinely shrank away", () => {
    const shrunk =
      "Each orbital holds at most {{c1::two electrons}}, which must have {{c2::opposite}} spins.";
    expect(checkRewriteSafety(card, shrunk).violations.map((v) => v.code)).toContain(
      "DROPS_TESTED_ANSWER",
    );
  });
});

describe("an answer the card spells out one piece at a time", () => {
  // From a live card: "E/Z" was hidden on one group while another group printed
  // "-> Z (zusammen)" and "-> E (entgegen)" two lines below. The verbatim check
  // compared the string "E/Z" against the page and found nothing.
  const ez =
    "Configuration is given by {{c1::E/Z}} notation: same side gives {{c2::Z}} (zusammen), opposite sides gives {{c2::E}} (entgegen).";

  it("catches the answer assembled from other visible answers", () => {
    const found = structuralFindings(ez);
    expect(found.map((f) => f.leakType)).toContain("COMPOSED_ANSWER_VISIBLE");
    expect(found.find((f) => f.leakType === "COMPOSED_ANSWER_VISIBLE")!.explanation).toMatch(/"e" and "z"|"z" and "e"/i);
  });

  it("goes quiet once the pieces hide with the whole", () => {
    const fixed =
      "Configuration is given by {{c1::E/Z}} notation: same side gives {{c1::Z}} (zusammen), opposite sides gives {{c1::E}} (entgegen).";
    expect(structuralFindings(fixed)).toEqual([]);
  });

  it("needs every piece visible, not just one", () => {
    const half = "Configuration is {{c1::E/Z}} notation: same side gives {{c2::Z}} (zusammen).";
    expect(structuralFindings(half).map((f) => f.leakType)).not.toContain("COMPOSED_ANSWER_VISIBLE");
  });

  it("ignores answers with no separator, so multi-word terms do not flood it", () => {
    const card = "The small bowel has three parts; the first is the {{c1::small intestine}} proper.";
    expect(structuralFindings(card).map((f) => f.leakType)).not.toContain("COMPOSED_ANSWER_VISIBLE");
  });

  it("stays quiet when the pieces are stem scaffolding rather than other answers", () => {
    // The card names Q and V so the student can assemble the relationship. The
    // ORDER is the content; seeing the symbols gives nothing away.
    const formula = "For charge Q held at voltage V, capacitance is C = {{c1::Q/V}}.";
    expect(structuralFindings(formula).map((f) => f.leakType)).not.toContain("COMPOSED_ANSWER_VISIBLE");
  });

  it("works on single letters, which containsWord deliberately skips", () => {
    expect(visibleComposition({
      activeGroup: 1,
      prompt: "gives R at one centre and S at the other",
      revealed: "",
      hiddenAnswers: ["R/S"],
      visibleAnswers: ["R", "S"],
      hints: [],
      blankWidths: [3],
      masksNothing: false,
    })).toHaveLength(1);
  });
});
