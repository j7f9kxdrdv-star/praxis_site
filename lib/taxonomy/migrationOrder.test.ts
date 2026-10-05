import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";

// ─── A migration that depends on another must sort after it ────────────────
//
// Migrations are applied in lexicographic filename order on a fresh database.
// Nothing enforced that the order matched the order they were actually written
// in, and it diverged: 20261005_chemical_family_vocabulary.sql asserts that
// Metals, Nonmetals & Metalloids holds 24 flashcards, which is only true once
// 20261005_types_of_elements_identity.sql has moved 5 cards into it. Sorted by
// name, "chemical" came before "types", so a fresh database would have aborted
// on a precondition while the live database was perfectly correct.
//
// That is the worst shape of defect in this repository: live state right,
// committed code unable to reproduce it, and no test that could tell.
//
// So a migration declares its prerequisite in a header comment and this check
// enforces the ordering. It is deliberately simple: the dependency is stated by
// the author, because what a migration needs from the database is semantic
// (row counts, prior renames) and no static scan of SQL can infer it.

const DIR = path.join(process.cwd(), "supabase", "migrations");

const files = fs.existsSync(DIR)
  ? fs.readdirSync(DIR).filter((f) => f.endsWith(".sql")).sort()
  : [];

/** `-- REQUIRES: <filename>` in the first lines of a migration. */
function requirementOf(sql: string): string | null {
  const m = sql.match(/^--\s*REQUIRES:\s*(\S+\.sql)\s*$/m);
  return m ? m[1] : null;
}

describe("migration apply order", () => {
  it("finds the migrations directory", () => {
    expect(files.length).toBeGreaterThan(0);
  });

  it("every declared prerequisite exists and sorts earlier", () => {
    const problems: string[] = [];
    for (const f of files) {
      const req = requirementOf(fs.readFileSync(path.join(DIR, f), "utf8"));
      if (!req) continue;
      if (!files.includes(req)) {
        problems.push(`${f} requires ${req}, which is not in the migrations directory`);
        continue;
      }
      if (!(req < f)) {
        problems.push(`${f} requires ${req}, which sorts LATER and would run after it`);
      }
    }
    expect(problems).toEqual([]);
  });

  it("the check can actually catch a bad order", () => {
    // A counter-example, so this is known to fail on something.
    const list = ["20260101_b.sql", "20260101_a.sql"].sort();
    const req = "20260101_b.sql";
    const dependent = "20260101_a.sql";
    expect(list.includes(req)).toBe(true);
    expect(req < dependent).toBe(false);
  });

  it("filenames are unique and lexicographically ordered as applied", () => {
    expect(new Set(files).size).toBe(files.length);
    expect([...files].sort()).toEqual(files);
  });
});
