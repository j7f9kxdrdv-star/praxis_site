import { describe, expect, it } from "vitest";
import { formatCount } from "./count";

describe("formatCount", () => {
  it("adds thousands separators the way the dashboard always has", () => {
    expect(formatCount(6544)).toBe("6,544");
    expect(formatCount(1284)).toBe("1,284");
    expect(formatCount(62573)).toBe("62,573");
  });
  it("leaves small numbers alone", () => {
    expect(formatCount(0)).toBe("0");
    expect(formatCount(388)).toBe("388");
  });
  it("never shows a fraction for a count", () => {
    expect(formatCount(1283.6)).toBe("1,284");
  });
  it("matches the existing en-US formatting used on the dashboard", () => {
    expect(formatCount(5354)).toBe((5354).toLocaleString("en-US"));
  });
});
