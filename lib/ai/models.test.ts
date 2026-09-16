import { describe, it, expect } from "vitest";
import fs from "fs";
import path from "path";
import { REASONING_MODEL, BULK_JUDGE_MODEL, KNOWN_MODELS } from "./models";

const ROOT = path.resolve(__dirname, "../..");

/** Source files this codebase owns, excluding build output and dependencies. */
function sourceFiles(dir: string, out: string[] = []): string[] {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.name.startsWith(".") || entry.name === "node_modules") continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) sourceFiles(full, out);
    else if (/\.(ts|tsx|mjs|js)$/.test(entry.name)) out.push(full);
  }
  return out;
}

/**
 * Anything that looks like a model id.
 *
 * Deliberately broad: it should catch a model this codebase has never used, so
 * that adding one in the wrong place fails rather than passing unnoticed.
 */
const MODEL_ID = /["'`](claude-[a-z0-9.\-]*\d[a-z0-9.\-]*)["'`]/g;

/**
 * Files allowed to name a model, and why.
 *
 * flashcard-leak-judge is plain ESM and cannot import a TypeScript constant
 * without the loader, so it keeps a literal plus an env override. Every other
 * exception has to be argued for here, in the open.
 */
const ALLOWED = [
  path.join("lib", "ai", "models.ts"),
  path.join("lib", "ai", "models.test.ts"),
  path.join("scripts", "flashcard-leak-judge.mjs"),
];

describe("MODEL IDS LIVE IN ONE PLACE", () => {
  // Three modules each pinned a literal. Two were moved to Opus 5 and the
  // third was not, so reports ran a generation behind for months. Nothing was
  // careless; there was simply nowhere to look that showed the three together.
  // A constant does not stop someone editing a call site. This does.

  const offenders: string[] = [];
  for (const file of sourceFiles(ROOT)) {
    const rel = path.relative(ROOT, file);
    if (ALLOWED.some((a) => rel === a)) continue;
    const src = fs.readFileSync(file, "utf8");
    // Comments may discuss models freely; only code is policed.
    const code = src.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*(\/\/|\*).*$/gm, "");
    for (const m of code.matchAll(MODEL_ID)) {
      offenders.push(`${rel}: ${m[1]}`);
    }
  }

  it("no source file outside lib/ai names a model directly", () => {
    expect(offenders).toEqual([]);
  });

  it("the constants are the ids the app actually intends", () => {
    expect(REASONING_MODEL).toBe("claude-opus-5");
    expect(BULK_JUDGE_MODEL).toBe("claude-sonnet-5");
    expect(new Set(KNOWN_MODELS).size).toBe(KNOWN_MODELS.length);
  });

  it("every exception is a real file, so the list cannot rot", () => {
    for (const rel of ALLOWED) {
      expect(fs.existsSync(path.join(ROOT, rel)), `${rel} is listed but missing`).toBe(true);
    }
  });

  it("the three production callers all reference the constant", () => {
    for (const rel of [
      path.join("lib", "insights", "diagnoseCard.ts"),
      path.join("lib", "insights", "auditVisibleAnswer.ts"),
      path.join("lib", "reports", "generate.ts"),
    ]) {
      const src = fs.readFileSync(path.join(ROOT, rel), "utf8");
      expect(src, rel).toContain("REASONING_MODEL");
    }
  });
});
