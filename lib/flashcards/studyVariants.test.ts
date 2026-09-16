import { describe, it, expect } from "vitest";
import { renderClozeSegments } from "./cloze";
import {
  expandStudyVariants,
  coMaskedPairs,
  normalizeAnswer,
  containsWord,
  scheduledIndices,
  renumberContiguous,
  BLANK_TOKEN,
} from "./studyVariants";

// The whole audit rests on one claim about the renderer. If that claim is ever
// wrong, every verdict downstream is wrong too, so it is asserted against the
// production function rather than described in a comment.
describe("GROUND TRUTH: the renderer masks by group, not by token", () => {
  it("hides every blank carrying the active number, together", () => {
    const text = "The {{c1::pulmonary}} circuit and the {{c1::systemic}} circuit.";
    const segs = renderClozeSegments(text, 1, false);
    const blanks = segs.filter((s) => s.kind === "blank");
    expect(blanks).toHaveLength(2);
    expect(segs.some((s) => s.kind === "text" && /pulmonary|systemic/.test(s.text))).toBe(false);
  });

  it("prints non-active groups as their answer text", () => {
    const text = "The {{c1::pulmonary}} circuit and the {{c2::systemic}} circuit.";
    const segs = renderClozeSegments(text, 1, false);
    expect(segs.some((s) => s.kind === "text" && s.text.includes("systemic"))).toBe(true);
  });
});

describe("TEST 1 — same group hides both", () => {
  const text = "The {{c1::pulmonary}} circuit carries blood to the lungs; the {{c1::systemic}} circuit carries it to the tissues.";

  it("produces exactly one study card", () => {
    expect(expandStudyVariants(text)).toHaveLength(1);
  });

  it("hides both terms on that one card", () => {
    const [v] = expandStudyVariants(text);
    expect(v.hiddenAnswers).toEqual(["pulmonary", "systemic"]);
    expect(v.visibleAnswers).toEqual([]);
    expect(v.prompt).not.toMatch(/pulmonary|systemic/);
    expect(v.prompt.match(/\[____\]/g)).toHaveLength(2);
  });

  it("records the pair as recalled together", () => {
    expect(coMaskedPairs(text).has("pulmonary || systemic")).toBe(true);
  });
});

describe("TEST 2 — different groups leave the partner on screen", () => {
  const text = "The {{c1::pulmonary}} circuit carries blood to the lungs; the {{c2::systemic}} circuit carries it to the tissues.";

  it("produces two study cards", () => {
    expect(expandStudyVariants(text)).toHaveLength(2);
  });

  it("shows systemic while pulmonary is blank, and the reverse", () => {
    const [one, two] = expandStudyVariants(text);
    expect(one.hiddenAnswers).toEqual(["pulmonary"]);
    expect(one.prompt).toContain("systemic");
    expect(two.hiddenAnswers).toEqual(["systemic"]);
    expect(two.prompt).toContain("pulmonary");
  });

  it("records no co-masked pair, so nothing protects the pairing", () => {
    expect(coMaskedPairs(text).size).toBe(0);
  });
});

describe("TEST 7 — three or more blanks on the active group", () => {
  const text =
    "A voltage-gated sodium channel cycles through {{c1::closed}}, {{c1::open}} and {{c1::inactivated}} states.";

  it("is still one study card", () => {
    expect(expandStudyVariants(text)).toHaveLength(1);
  });

  it("hides all three at once, with no partial state anywhere", () => {
    const [v] = expandStudyVariants(text);
    expect(v.hiddenAnswers).toEqual(["closed", "open", "inactivated"]);
    expect(v.prompt).not.toMatch(/closed|open|inactivated/);
  });

  it("pairs every combination as co-masked", () => {
    const pairs = coMaskedPairs(text);
    expect(pairs.size).toBe(3);
    expect(pairs.has("closed || open")).toBe(true);
    expect(pairs.has("inactivated || open")).toBe(true);
  });
});

describe("the item the session queue schedules, not the groups in the text", () => {
  // session/page.tsx walks clozeIndex 1..cloze_count. A card written c1, c3 has
  // cloze_count 2, so item 2 renders with activeGroup 2, matches nothing, and
  // shows the student the entire card with its answers in place.
  const gappy = "Glycolysis makes {{c1::two}} ATP and {{c3::two}} NADH per glucose.";

  it("walks 1..cloze_count when the stored count is supplied", () => {
    expect(scheduledIndices(gappy, 2)).toEqual([1, 2]);
    expect(scheduledIndices(gappy)).toEqual([1, 3]);
  });

  it("flags the scheduled item that masks nothing", () => {
    const variants = expandStudyVariants(gappy, 2);
    expect(variants[1].masksNothing).toBe(true);
    expect(variants[1].prompt).not.toContain(BLANK_TOKEN);
  });
});

describe("rendered text is what a reader sees", () => {
  it("fills blanks on the revealed side", () => {
    const [v] = expandStudyVariants("Water boils at {{c1::100}} degrees Celsius.");
    expect(v.prompt).toBe("Water boils at [____] degrees Celsius.");
    expect(v.revealed).toBe("Water boils at 100 degrees Celsius.");
  });

  it("carries hints through without putting them in the prompt text", () => {
    const [v] = expandStudyVariants("The {{c1::mitochondrion::organelle}} makes ATP.");
    expect(v.hints).toEqual(["organelle"]);
    expect(v.prompt).not.toContain("organelle");
  });

  it("describes an image by its alt text rather than dropping it", () => {
    const [v] = expandStudyVariants('The sugar shown <img src="/f.png" alt="alpha-D-glucose"> is {{c1::a pyranose}}.');
    expect(v.prompt).toContain("[image: alpha-D-glucose]");
  });

  it("reports the blank width, since the box is sized to the answer", () => {
    const [v] = expandStudyVariants("Blood pH is about {{c1::7.4}}.");
    expect(v.blankWidths).toEqual([3]);
  });
});

describe("comparison helpers", () => {
  it("treats notation markup and the plain term as the same word", () => {
    expect(normalizeAnswer("k_(cat)")).toBe("kcat");
    expect(normalizeAnswer("  Broad  ")).toBe("broad");
  });

  it("matches whole words only", () => {
    // The false positive that cost real remediation time on an earlier sweep.
    expect(containsWord("norepinephrine is released", "epinephrine")).toBe(false);
    expect(containsWord("epinephrine is released", "epinephrine")).toBe(true);
    expect(containsWord("beta-oxidation of fatty acids", "oxidation")).toBe(true);
  });

  it("ignores one-character answers, which match everything", () => {
    expect(containsWord("a b c", "a")).toBe(false);
  });
});

describe("superscripts continue a word", () => {
  // From the first structural pass over organic chemistry: "sp" was reported
  // visible on a card whose other mention was "sp³". Different hybridisation,
  // not a leak.
  it("does not match sp inside sp-superscript-three", () => {
    expect(containsWord("the same range as sp³", "sp")).toBe(false);
  });

  it("still matches sp standing on its own", () => {
    expect(containsWord("carbons that are sp hybridized", "sp")).toBe(true);
  });

  it("matches the superscripted term itself", () => {
    expect(containsWord("the same range as sp³", "sp³")).toBe(true);
  });

  it("leaves ordinary terms alone", () => {
    expect(containsWord("a broad O-H stretch", "o-h")).toBe(true);
    expect(containsWord("the n+1 rule applies", "n+1")).toBe(true);
  });
});

describe("closing a gap left by a merge", () => {
  it("leaves a contiguous card alone", () => {
    const text = "The {{c1::alpha}} and {{c2::beta}} anomers.";
    expect(renumberContiguous(text)).toBe(text);
  });

  it("closes the gap a merge leaves behind", () => {
    // c2 was merged into c1; c3 and c4 are now misnumbered.
    const merged = "{{c1::a}} {{c1::b}} {{c3::c}} {{c4::d}}";
    expect(renumberContiguous(merged)).toBe("{{c1::a}} {{c1::b}} {{c2::c}} {{c3::d}}");
  });

  it("makes the unmaskable study item go away", () => {
    const merged = "{{c1::a}} {{c1::b}} {{c3::c}}";
    expect(expandStudyVariants(merged, 2)[1].masksNothing).toBe(true);
    const fixed = renumberContiguous(merged);
    expect(expandStudyVariants(fixed, 2).some((v) => v.masksNothing)).toBe(false);
  });

  it("keeps hints and multi-word answers intact", () => {
    expect(renumberContiguous("{{c2::mitochondrion::organelle}} makes {{c5::ATP}}")).toBe(
      "{{c1::mitochondrion::organelle}} makes {{c2::ATP}}",
    );
  });

  it("does not change what is hidden together", () => {
    const before = coMaskedPairs("{{c1::a}} {{c1::b}} {{c4::c}}");
    const after = coMaskedPairs(renumberContiguous("{{c1::a}} {{c1::b}} {{c4::c}}"));
    expect(after).toEqual(before);
  });
});
