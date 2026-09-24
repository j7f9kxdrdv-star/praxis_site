import { describe, it, expect } from "vitest";
import {
  contentOnly, reasoningOnly, quantitativeOnly,
  mayCarryContentTaxonomy, assertAllContent, type ObjectType,
} from "./objectType";

const obj = (slug: string, objectType: ObjectType) => ({
  id: slug, slug, canonicalName: slug, objectType, status: "ACTIVE_SEED",
});

const MIXED = [
  obj("ENZYME_INHIBITION", "CONTENT"),
  obj("RO_CONFOUNDING", "REASONING"),
  obj("QK_LOGARITHM_RULES", "QUANTITATIVE"),
  obj("PERIODIC_TRENDS", "CONTENT"),
];

describe("content analytics cannot silently include the other two", () => {
  it("contentOnly keeps content and nothing else", () => {
    expect(contentOnly(MIXED).map((o) => o.slug)).toEqual(["ENZYME_INHIBITION", "PERIODIC_TRENDS"]);
  });

  it("excludes a reasoning object even though it sits in the same table", () => {
    expect(contentOnly(MIXED).some((o) => o.slug === "RO_CONFOUNDING")).toBe(false);
  });

  it("excludes a quantitative object", () => {
    expect(contentOnly(MIXED).some((o) => o.slug === "QK_LOGARITHM_RULES")).toBe(false);
  });

  it("throws rather than filtering when non-content reaches a content metric", () => {
    // Filtering here would hide the caller's bug behind a plausible number.
    expect(() => assertAllContent(MIXED)).toThrow(/non-content object/);
    expect(() => assertAllContent(MIXED)).toThrow(/content_concepts view/);
  });

  it("passes a genuinely content-only set", () => {
    expect(() => assertAllContent(contentOnly(MIXED))).not.toThrow();
  });
});

describe("the other two are reachable on their own terms", () => {
  it("reasoning and quantitative select independently", () => {
    expect(reasoningOnly(MIXED).map((o) => o.slug)).toEqual(["RO_CONFOUNDING"]);
    expect(quantitativeOnly(MIXED).map((o) => o.slug)).toEqual(["QK_LOGARITHM_RULES"]);
  });

  it("the three partitions are disjoint and complete", () => {
    const n = contentOnly(MIXED).length + reasoningOnly(MIXED).length + quantitativeOnly(MIXED).length;
    expect(n).toBe(MIXED.length);
  });
});

describe("only content carries section, discipline and category", () => {
  it("permits content", () => {
    expect(mayCarryContentTaxonomy("CONTENT").allowed).toBe(true);
  });

  it("refuses a reasoning object, and says zero rows is correct rather than missing", () => {
    const r = mayCarryContentTaxonomy("REASONING");
    expect(r.allowed).toBe(false);
    expect(r.reason).toMatch(/correct state, not an incomplete one/);
  });

  it("refuses a quantitative object", () => {
    expect(mayCarryContentTaxonomy("QUANTITATIVE").allowed).toBe(false);
  });
});
