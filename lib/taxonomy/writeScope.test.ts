import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";

// ─── An ontology migration may add meaning. It may not rewrite history. ────
//
// Count floors catch a learner table SHRINKING, but only after the damage, and
// only if someone runs the verifier. They also cannot see an UPDATE that
// rewrites 7,000 FSRS rows in place while leaving the count identical, which is
// the quietest and worst version of this failure.
//
// This is the cheap structural half: a migration that touches the ontology is
// read at build time and must contain no write against a learner-history table.
// It needs no database, runs with the unit tests, and fails before a file is
// ever pasted into the SQL editor rather than after.
//
// It is a lint, not a runtime sandbox. The runtime half stays the verifier's
// job. Together they cover both directions: this one stops a bad migration
// being written, the floors notice if one ever runs.

const MIGRATIONS = path.join(process.cwd(), "supabase", "migrations");

/** Tables that record what a learner actually did. Ontology work never writes here. */
const LEARNER_TABLES = [
  "flashcard_reviews",
  "flashcard_user_state",
  "question_attempts",
  "practice_sessions",
  "learner_events",
  "learner_state_snapshots",
  "performance_reports",
  "daily_activity",
  // Phase 2 derived learner state. An ontology migration has no business
  // writing it: a concept rename or a mapping repoint may legitimately make a
  // stored state stale, and the answer to that is a recomputation by the
  // writer, not an UPDATE buried in a taxonomy migration where nobody would
  // look for it.
  "learner_concept_states",
];

/** Tables an ontology migration is allowed to write. */
const ONTOLOGY_TABLES = [
  "concepts",
  "concept_aliases",
  "concept_sections",
  "concept_disciplines",
  "concept_content_categories",
  "concept_relationships",
  "topics",
  "question_concepts",
  "question_reasoning_objects",
  "flashcard_concepts",
  "mcat_sections",
  "disciplines",
  "legacy_taxonomy_map",
];

/** Strip comments so a table named only in prose never trips the check. */
function executable(sql: string): string {
  return sql
    .replace(/\/\*[\s\S]*?\*\//g, " ")
    .split("\n")
    .map((line) => {
      const i = line.indexOf("--");
      return i === -1 ? line : line.slice(0, i);
    })
    .join("\n");
}

const files = fs.existsSync(MIGRATIONS)
  ? fs.readdirSync(MIGRATIONS).filter((f) => f.endsWith(".sql"))
  : [];

/** A migration counts as ontology work if it writes any ontology table. */
function isOntologyMigration(sql: string): boolean {
  const body = executable(sql);
  return ONTOLOGY_TABLES.some((t) =>
    new RegExp(`\\b(INSERT\\s+INTO|UPDATE|DELETE\\s+FROM)\\s+(public\\.)?${t}\\b`, "i").test(body),
  );
}

function writesTo(sql: string, table: string): string[] {
  const body = executable(sql);
  const hits: string[] = [];
  for (const verb of ["INSERT\\s+INTO", "UPDATE", "DELETE\\s+FROM", "TRUNCATE"]) {
    const re = new RegExp(`\\b${verb}\\s+(?:ONLY\\s+)?(?:public\\.)?${table}\\b`, "gi");
    const found = body.match(re);
    if (found) hits.push(...found.map((m) => m.replace(/\s+/g, " ")));
  }
  return hits;
}

describe("ontology migrations never write learner history", () => {
  it("finds the migrations directory", () => {
    expect(files.length).toBeGreaterThan(0);
  });

  const ontologyFiles = files.filter((f) =>
    isOntologyMigration(fs.readFileSync(path.join(MIGRATIONS, f), "utf8")),
  );

  it("identifies the ontology migrations", () => {
    // If this ever drops to zero the check has stopped checking anything.
    expect(ontologyFiles.length).toBeGreaterThan(0);
  });

  it.each(LEARNER_TABLES)("no ontology migration writes %s", (table) => {
    const offenders: string[] = [];
    for (const f of ontologyFiles) {
      const sql = fs.readFileSync(path.join(MIGRATIONS, f), "utf8");
      for (const hit of writesTo(sql, table)) offenders.push(`${f}: ${hit}`);
    }
    expect(offenders).toEqual([]);
  });

  it("the guard can actually catch an offender", () => {
    // A check that has never failed on anything is not known to work. This is
    // the counter-example, proving the matcher sees a real write rather than
    // passing because the regex is wrong.
    const bad = `INSERT INTO public.concepts (slug) VALUES ('X');
                 UPDATE public.flashcard_user_state SET stability = 1;`;
    expect(isOntologyMigration(bad)).toBe(true);
    expect(writesTo(bad, "flashcard_user_state")).toHaveLength(1);
  });

  it("does not trip on a learner table named only in a comment", () => {
    // Every migration written in this project explains itself, and several
    // discuss FSRS at length. Prose must not fail the build.
    const fine = `-- This migration must never touch flashcard_user_state or
                  -- delete from flashcard_reviews. It only adds concepts.
                  /* UPDATE flashcard_user_state would be wrong here. */
                  INSERT INTO public.concepts (slug) VALUES ('X');`;
    expect(isOntologyMigration(fine)).toBe(true);
    for (const t of LEARNER_TABLES) expect(writesTo(fine, t)).toEqual([]);
  });
});
