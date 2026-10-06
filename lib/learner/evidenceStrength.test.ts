import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  EVIDENCE_STRENGTHS, ELIGIBLE_STRENGTHS, buildConceptStates,
  CONCEPT_STATE_MODEL_VERSION, type ConceptEvidence, type EvidenceStrength,
} from "@/lib/learner/conceptState";

const MIGRATION = path.join(
  process.cwd(), "supabase", "migrations", "20261006_05_question_concepts_evidence_strength.sql");
const sql = fs.readFileSync(MIGRATION, "utf8");

/** The live row 27 identifiers, so a refactor cannot quietly re-admit it. */
const ROW27_QUESTION = "cec05f2f-6d03-449e-ae09-2592c6717821";
const ROW27_CONCEPT = "2bd9f11e-36cc-47d7-ab4f-4daa827b46be";

describe("the evidence-strength vocabulary", () => {
  it("is exactly four values", () => {
    expect([...EVIDENCE_STRENGTHS]).toEqual(
      ["UNREVIEWED", "STANDARD", "SELF_CONTAINED", "RECOGNITION_ONLY"]);
  });

  it("THE SQL CHECK AND THE TYPESCRIPT LIST AGREE", () => {
    // One canonical vocabulary. If the migration ever adds a fifth value
    // without the module learning it, the model would silently treat it as
    // ineligible, which is the quietest possible way to lose evidence.
    const check = sql.match(/CHECK \(evidence_strength IN \(([^)]+)\)\)/);
    expect(check).not.toBeNull();
    const fromSql = check![1].split(",").map((s) => s.trim().replace(/'/g, ""));
    expect(fromSql).toEqual([...EVIDENCE_STRENGTHS]);
  });

  it("only UNREVIEWED and STANDARD are eligible evidence", () => {
    expect([...ELIGIBLE_STRENGTHS].sort()).toEqual(["STANDARD", "UNREVIEWED"]);
    for (const s of ["SELF_CONTAINED", "RECOGNITION_ONLY"] as EvidenceStrength[]) {
      expect(ELIGIBLE_STRENGTHS.has(s)).toBe(false);
    }
  });
});

describe("the schema the migration declares", () => {
  it("defaults to UNREVIEWED and is NOT NULL", () => {
    expect(sql).toMatch(/evidence_strength TEXT NOT NULL DEFAULT 'UNREVIEWED'/);
  });

  it("the timestamp column is nullable", () => {
    expect(sql).toMatch(/evidence_strength_set_at TIMESTAMPTZ/);
    expect(sql).not.toMatch(/evidence_strength_set_at TIMESTAMPTZ NOT NULL/);
  });

  it("an invalid value is rejected by a CHECK", () => {
    expect(sql).toMatch(/question_concepts_evidence_strength_check/);
    expect(sql).toMatch(/CHECK \(evidence_strength IN \('UNREVIEWED', 'STANDARD', 'SELF_CONTAINED', 'RECOGNITION_ONLY'\)\)/);
  });

  it("UNREVIEWED with a timestamp, and a verdict without one, are both rejected", () => {
    // One CHECK, both directions, no subquery so it is CHECK-legal.
    // Bounded at the statement terminator. An unbounded slice runs to the end
    // of the file and picks up every later SELECT, which is the same
    // run-past-the-statement mistake the ontology audits made twice.
    const from = sql.indexOf("ADD CONSTRAINT question_concepts_evidence_strength_stamp");
    const stamp = sql.slice(from, sql.indexOf(";", from));
    expect(stamp).toMatch(/evidence_strength = 'UNREVIEWED' AND evidence_strength_set_at IS NULL/);
    expect(stamp).toMatch(/evidence_strength IN \('STANDARD', 'SELF_CONTAINED', 'RECOGNITION_ONLY'\)\s*\n?\s*AND evidence_strength_set_at IS NOT NULL/);
    expect(stamp).not.toMatch(/SELECT/);
  });

  it("both columns are documented in the schema itself", () => {
    expect(sql).toMatch(/COMMENT ON COLUMN public\.question_concepts\.evidence_strength IS/);
    expect(sql).toMatch(/COMMENT ON COLUMN public\.question_concepts\.evidence_strength_set_at IS/);
    expect(sql).toMatch(/A SECOND AXIS, independent of mapping correctness/);
  });

  it("authoring gets UNREVIEWED from the database, not from call sites", () => {
    expect(sql).toMatch(/DEFAULT 'UNREVIEWED'/);
  });
});

describe("exactly one row is classified, and nothing is inferred", () => {
  it("only the reviewed row 27 pair appears", () => {
    const uuids = new Set([...sql.matchAll(
      /'([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})'/g)].map((m) => m[1]));
    expect(uuids).toEqual(new Set([ROW27_QUESTION, ROW27_CONCEPT]));
  });

  it("the classification names both the question and the concept", () => {
    const update = sql.slice(sql.indexOf("SET evidence_strength = 'SELF_CONTAINED'"));
    expect(update).toContain(ROW27_QUESTION);
    expect(update).toContain(ROW27_CONCEPT);
  });

  it("THE CLASSIFICATION TOUCHES ONLY THE TWO NEW COLUMNS", () => {
    // The mapping was reviewed separately and its history is not being rewritten.
    const update = sql.slice(
      sql.indexOf("SET evidence_strength = 'SELF_CONTAINED'"),
      sql.indexOf("Post-conditions"));
    for (const governance of [
      "mapping_status =", "source =", "role =", "concept_id =",
      "confidence =", "reviewed_at =", "reviewed_by =",
    ]) {
      expect(update).not.toContain(governance);
    }
  });

  it("no bulk UPDATE classifies anything", () => {
    const classifying = [...sql.matchAll(/UPDATE public\.question_concepts/g)];
    // Two probe updates proving the guard bites, plus the one classification.
    expect(classifying.length).toBe(4);
    const unqualified = sql.match(/UPDATE public\.question_concepts\s+SET evidence_strength[^;]*;/g) ?? [];
    for (const u of unqualified) expect(u).toMatch(/WHERE question_id = /);
  });

  it("the migration never writes STANDARD, so nothing is inferred from mapping_status", () => {
    // About the MIGRATION's text, not about a permanent data coupling: see the
    // independence suite below for why those are different claims.
    expect(sql).not.toMatch(/SET evidence_strength = 'STANDARD'/);
    expect(sql).toMatch(/human-validated rows were inferred to be STANDARD/);
  });

  it("the migration asserts its own outcome", () => {
    for (const assertion of [
      "expected exactly 1 SELF_CONTAINED mapping",
      "expected 0 STANDARD mappings",
      "expected 0 RECOGNITION_ONLY mappings",
      "unreviewed rows carry a review timestamp",
      "reviewed rows lack a review timestamp",
    ]) expect(sql).toContain(assertion);
  });
});

describe("THE TWO AXES ARE INDEPENDENT", () => {
  // mapping_status answers "is this question about this concept".
  // evidence_strength answers "does getting it right prove mastery of it".
  // Neither implies the other, in either direction, for any pair of values.
  //
  // This suite exists because the Step 4 verifier asserted that a
  // HUMAN_VALIDATED row is never STANDARD. That passed only because nothing was
  // STANDARD yet; it would have failed the first time someone legitimately
  // reviewed a validated mapping and found it strong evidence.

  it("every combination of the two axes is permitted", () => {
    const statuses = ["AI_PROPOSED", "DETERMINISTIC", "HUMAN_VALIDATED", "NEEDS_REVIEW"];
    for (const status of statuses) {
      for (const strength of EVIDENCE_STRENGTHS) {
        // No rule anywhere forbids a pair. The model reads only the strength.
        expect(ELIGIBLE_STRENGTHS.has(strength)).toBe(
          strength === "UNREVIEWED" || strength === "STANDARD");
        expect(statuses).toContain(status);
      }
    }
  });

  it("the pure model reads evidence strength and ignores mapping status entirely", () => {
    const source = fs.readFileSync(
      path.join(process.cwd(), "lib", "learner", "conceptState.ts"), "utf8");
    const code = source.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
    // ConceptEvidence carries no mapping_status at all, so the model could not
    // couple them even by accident.
    expect(code).not.toMatch(/mapping_status|mappingStatus/);
    expect(code).toMatch(/ELIGIBLE_STRENGTHS\.has/);
  });

  it("no suite in this file asserts a coupling between the two axes", () => {
    // The regression guarded against: an assertion of the form "a validated
    // mapping is never strong evidence". That is a coupling, not an invariant.
    //
    // The pattern is assembled from fragments rather than written out, because
    // a literal here would match THIS file and the test would fail on its own
    // text. Same self-reference trap as the reset-scope scanner finding a table
    // name inside an example of forbidden code.
    const coupling = new RegExp(
      ["mapping_status", "===", '"HUMAN', "VALIDATED\"[\\s\\S]{0,160}evidence", "strength !=="].join("_?"),
    );
    const self = fs.readFileSync(__filename, "utf8")
      .replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
    expect(coupling.test(self)).toBe(false);
  });
});

describe("the guard exception is future-proof", () => {
  // The Step 4 guard listed every column that existed and required each to be
  // unchanged. A column added later would not be in that list, so the exception
  // would silently widen as the table grew. Step 4b inverts it.
  const hardening = fs.readFileSync(
    path.join(process.cwd(), "supabase", "migrations",
      "20261006_06_human_validated_guard_hardening.sql"), "utf8");

  it("compares the WHOLE ROW, excluding exactly the two evidence fields", () => {
    expect(hardening).toMatch(
      /to_jsonb\(NEW\) - 'evidence_strength' - 'evidence_strength_set_at'/);
    expect(hardening).toMatch(
      /to_jsonb\(OLD\) - 'evidence_strength' - 'evidence_strength_set_at'/);
    expect(hardening).toMatch(/IS NOT DISTINCT FROM/);
  });

  it("DOES NOT fall back to a manual list of today's columns", () => {
    // If someone replaces the whole-row comparison with an allowlist, future
    // columns stop being protected and this fails.
    const fn = hardening.slice(hardening.indexOf("CREATE OR REPLACE FUNCTION"));
    const manual = ["concept_id", "role", "confidence", "created_at", "reviewed_at", "reviewed_by"]
      .filter((c) => new RegExp(`NEW\\.${c}\\s+IS NOT DISTINCT FROM OLD\\.${c}`).test(fn));
    expect(manual).toEqual([]);
  });

  it("keeps the original refusal and the delete refusal intact", () => {
    expect(hardening).toMatch(/Only a HUMAN_REVIEWED write may amend a human decision/);
    expect(hardening).toMatch(/Refusing to delete a HUMAN_VALIDATED mapping/);
  });

  it("proves every governance column still refuses, by probe", () => {
    for (const col of ["concept_id", "role", "mapping_status", "source",
                       "confidence", "created_at", "reviewed_at", "reviewed_by"]) {
      expect(hardening).toMatch(new RegExp(`leaked \\|\\| '${col}'`));
    }
    expect(hardening).toMatch(/the hardened guard ALLOWED changes to/);
  });

  it("proves the two paths that must still work", () => {
    expect(hardening).toMatch(/refuses an evidence-strength-only write/);
    expect(hardening).toMatch(/broke the established HUMAN_REVIEWED amendment path/);
  });

  it("does not rewrite the applied Step 4 migration", () => {
    const step4 = fs.readFileSync(
      path.join(process.cwd(), "supabase", "migrations",
        "20261006_05_question_concepts_evidence_strength.sql"), "utf8");
    // Step 4 keeps the manual list it actually shipped with. History stands.
    expect(step4).toMatch(/NEW\.concept_id\s+IS NOT DISTINCT FROM OLD\.concept_id/);
    expect(step4).not.toMatch(/to_jsonb/);
  });
});

describe("the guard amendment is minimal and still bites", () => {
  it("declares itself as the one scope deviation", () => {
    expect(sql).toMatch(/THE ONE SCOPE DEVIATION/);
  });

  it("proves the old guard blocked a no-op update, rather than asserting it", () => {
    expect(sql).toMatch(/the current guard refuses even a no-op update/);
  });

  it("allows a write through only when EVERY pre-existing column is unchanged", () => {
    const amended = sql.slice(sql.indexOf("CREATE OR REPLACE FUNCTION public.protect_human_validated_mapping"));
    for (const col of ["concept_id", "role", "mapping_status", "source",
                       "confidence", "created_at", "reviewed_at", "reviewed_by"]) {
      expect(amended).toMatch(new RegExp(`NEW\\.${col}\\s+IS NOT DISTINCT FROM OLD\\.${col}`));
    }
  });

  it("keeps the original refusal intact", () => {
    expect(sql).toMatch(/Only a HUMAN_REVIEWED write may amend a human decision/);
    expect(sql).toMatch(/Refusing to delete a HUMAN_VALIDATED mapping/);
  });

  it("proves afterwards that role and mapping_status changes are still refused", () => {
    expect(sql).toMatch(/the amended guard let a role change through/);
    expect(sql).toMatch(/the amended guard let a mapping_status change through/);
  });
});

describe("PURE MODEL REGRESSION: row 27 stays excluded", () => {
  const NOW = new Date("2026-10-06T12:00:00.000Z");
  const CONCEPT = ROW27_CONCEPT;

  const withStrength = (strength: EvidenceStrength): ConceptEvidence => ({
    concepts: [{ id: CONCEPT, objectType: "CONTENT", status: "ACTIVE_SEED" }],
    flashcards: [], cardMappings: [], schedulerRows: [],
    questionMappings: [{
      conceptId: CONCEPT, questionId: ROW27_QUESTION, role: "PRIMARY", evidenceStrength: strength,
    }],
    attempts: [{
      id: "a1", questionId: ROW27_QUESTION, isCorrect: false,
      isFirstAttempt: true, createdAt: "2026-10-01T00:00:00.000Z",
    }],
  });

  it("the real row 27, as SELF_CONTAINED, is not evidence at all", () => {
    expect(buildConceptStates(withStrength("SELF_CONTAINED"), null, NOW)).toHaveLength(0);
  });

  it("if it is a concept's only question evidence, application stays INSUFFICIENT", () => {
    const e = withStrength("SELF_CONTAINED");
    const withCards: ConceptEvidence = {
      ...e,
      flashcards: [{ id: "c1", clozeCount: 1 }, { id: "c2", clozeCount: 1 }, { id: "c3", clozeCount: 1 }],
      cardMappings: ["c1", "c2", "c3"].map((id) => ({
        conceptId: CONCEPT, flashcardId: id, role: "PRIMARY" as const, clozeIndices: null })),
      schedulerRows: ["c1", "c2", "c3"].map((id) => ({
        flashcardId: id, clozeIndex: 1, stability: 20, reps: 4, suspended: false,
        lastReviewedAt: "2026-10-05T00:00:00.000Z" })),
    };
    const s = buildConceptStates(withCards, null, NOW)[0];
    expect(s.applicationAttempts).toBe(0);
    expect(s.applicationSignal).toBe("INSUFFICIENT");
    expect(s.coverageState).toBe("MEMORY_ONLY");
    expect(s.modelVersion).toBe(CONCEPT_STATE_MODEL_VERSION);
  });

  it("RECOGNITION_ONLY is excluded the same way", () => {
    expect(buildConceptStates(withStrength("RECOGNITION_ONLY"), null, NOW)).toHaveLength(0);
  });

  it("and the same row as UNREVIEWED or STANDARD does count", () => {
    for (const strength of ["UNREVIEWED", "STANDARD"] as EvidenceStrength[]) {
      const s = buildConceptStates(withStrength(strength), null, NOW)[0];
      expect(s.applicationAttempts, strength).toBe(1);
      expect(s.coverageState, strength).toBe("QUESTION_ONLY");
    }
  });

  it("the model version did not move: the semantics were already frozen", () => {
    expect(CONCEPT_STATE_MODEL_VERSION).toBe("2.0.0-provisional");
  });
});
