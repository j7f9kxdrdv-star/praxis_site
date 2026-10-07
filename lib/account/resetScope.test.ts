import { describe, it, expect } from "vitest";
import fs from "fs";
import path from "path";
import {
  USER_DATA_TABLES,
  KEPT_USER_TABLES,
  NON_USER_TABLES,
  ONBOARDING_DEFAULTS,
  profilePatchFor,
  describeScope,
  isResetScope,
} from "./resetScope";

const ROOT = path.resolve(__dirname, "../..");

function sourceFiles(dir: string, out: string[] = []): string[] {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.name.startsWith(".") || entry.name === "node_modules") continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) sourceFiles(full, out);
    else if (/\.(ts|tsx|mjs|mts)$/.test(entry.name)) out.push(full);
  }
  return out;
}

describe("A RESET THAT MISSES A TABLE IS WORSE THAN NO RESET", () => {
  // The failure this guards is silent: a table added later keeps its rows, the
  // button still says "done", and the student studies a deck that claims to be
  // new. Nothing in the UI can notice. So adding a table to the app has to be
  // the moment someone classifies it.

  const classified = new Set<string>([
    ...USER_DATA_TABLES,
    ...Object.keys(KEPT_USER_TABLES),
    ...Object.keys(NON_USER_TABLES),
  ]);

  // EXECUTABLE TEXT ONLY. A table named in a comment is not a table the app
  // touches, and treating it as one asks for a classification of something
  // that may not even be reachable: this first fired on a comment explaining
  // that reading auth.users through PostgREST CANNOT work, because it is not
  // exposed there at all. Classifying it would have been inventing a fact.
  const strip = (src: string) =>
    src.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");

  const used = new Set<string>();
  for (const file of sourceFiles(path.join(ROOT, "app"))
    .concat(sourceFiles(path.join(ROOT, "lib")))
    .concat(sourceFiles(path.join(ROOT, "scripts")))) {
    const src = strip(fs.readFileSync(file, "utf8"));
    for (const m of src.matchAll(/\.from\("([a-z_]+)"\)/g)) used.add(m[1]);
  }

  it("every table the app touches is classified", () => {
    const unclassified = [...used].filter((t) => !classified.has(t)).sort();
    expect(unclassified).toEqual([]);
  });

  it("the scan still sees a real table access, and ignores one in prose", () => {
    // Stripping comments must not have stripped the check's teeth.
    // ASSEMBLED FROM FRAGMENTS, never written out. A literal example here is
    // a real table access as far as the scanner above is concerned, and this
    // file is one of the files it scans — so spelling it out would make the
    // counter-example fail the very check it exists to prove.
    const call = (t: string) => `.${"from"}(${JSON.stringify(t)})`;
    const real = strip(`const x = db${call("flashcard_reviews")}.select("*");`);
    expect([...real.matchAll(/\.from\("([a-z_]+)"\)/g)].map((m) => m[1])).toEqual(["flashcard_reviews"]);
    const prose = strip(`${"//"} never call ${call("zz_commented_out")} here`);
    expect([...prose.matchAll(/\.from\("([a-z_]+)"\)/g)]).toEqual([]);
  });

  it("still finds the tables it is supposed to find", () => {
    // If stripping ever removed too much this would empty out silently.
    for (const t of ["flashcard_reviews", "question_attempts", "profiles", "learner_concept_states"]) {
      expect(used, t).toContain(t);
    }
  });

  it("no table is in two buckets at once", () => {
    const counts = new Map<string, number>();
    for (const t of [
      ...USER_DATA_TABLES,
      ...Object.keys(KEPT_USER_TABLES),
      ...Object.keys(NON_USER_TABLES),
    ]) {
      counts.set(t, (counts.get(t) ?? 0) + 1);
    }
    expect([...counts.entries()].filter(([, n]) => n > 1)).toEqual([]);
  });

  it("every kept or excluded table carries a stated reason", () => {
    for (const [table, why] of Object.entries({ ...KEPT_USER_TABLES, ...NON_USER_TABLES })) {
      expect(why.length, table).toBeGreaterThan(10);
    }
  });

  it("deletes the tables that actually hold progress", () => {
    // Named explicitly rather than derived, so dropping one is a visible edit.
    for (const t of [
      "flashcard_reviews",
      "flashcard_user_state",
      "question_attempts",
      "practice_sessions",
      "study_plan_tasks",
      "daily_activity",
      "learner_state_snapshots",
      "learner_events",
      "performance_reports",
      "user_insight_briefs",
      "review_schedule",
      "lesson_progress",
      "learner_concept_states",
    ]) {
      expect(USER_DATA_TABLES, t).toContain(t);
    }
  });

  // ── Phase 2: the derived concept layer ────────────────────────────────
  //
  // THE RULE THIS PINS: a learner-data table created by Phase 2 is in the
  // reset list from the moment it exists. The failure it prevents is the one
  // the file header describes — a student presses "start over", is told it
  // worked, and the model still holds a page of concept states asserting what
  // they knew before. Nothing in the UI could notice.
  it("clears the Phase 2 learner concept layer", () => {
    expect(USER_DATA_TABLES).toContain("learner_concept_states");
  });

  it("does not yet name the history table, which does not exist", () => {
    // Naming a relation before creating it is its own failure: the DELETE
    // errors and the preview count silently reads zero. The history table
    // joins this list in the step that creates it, not before.
    expect(USER_DATA_TABLES).not.toContain("learner_concept_state_history");
  });

  // ── The structural half, so the NEXT table cannot be forgotten ────────
  //
  // The named tests above protect the tables that exist today. This one
  // protects the ones that do not: every learner_* table a migration creates
  // has to be classified, so the step that creates a table is the step that
  // decides whether a reset clears it. When the Phase 2 history table is
  // created, this fails until it is placed, with no edit to this file.
  //
  // Scoped to the learner_ prefix on purpose rather than to every CREATE
  // TABLE. The wider rule would also demand a verdict on question-bank
  // metadata tables that hold no user data and that nothing has ever needed to
  // classify, which is a different and much weaker argument.
  const createdLearnerTables = (() => {
    const dir = path.join(ROOT, "supabase", "migrations");
    if (!fs.existsSync(dir)) return [];
    const found = new Set<string>();
    for (const f of fs.readdirSync(dir).filter((x) => x.endsWith(".sql"))) {
      const sql = fs.readFileSync(path.join(dir, f), "utf8");
      for (const m of sql.matchAll(/CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(?:public\.)?(learner_[a-z_]+)/gi)) {
        found.add(m[1].toLowerCase());
      }
    }
    return [...found].sort();
  })();

  it("finds the learner tables the migrations create", () => {
    // If the scan ever returns nothing it has stopped checking anything.
    expect(createdLearnerTables).toContain("learner_state_snapshots");
    expect(createdLearnerTables).toContain("learner_concept_states");
  });

  it("every learner_ table a migration creates is classified", () => {
    expect(createdLearnerTables.filter((t) => !classified.has(t))).toEqual([]);
  });

  it("the scan can actually catch an unclassified one", () => {
    // A counter-example, so the regex is known to match a real statement
    // rather than passing because it matches nothing.
    const sql = "CREATE TABLE IF NOT EXISTS public.learner_concept_state_history (\n  user_id UUID";
    const m = [...sql.matchAll(/CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(?:public\.)?(learner_[a-z_]+)/gi)];
    expect(m.map((x) => x[1])).toEqual(["learner_concept_state_history"]);
    expect(classified.has("learner_concept_state_history")).toBe(false);
  });

  it("clears derived concept state after the evidence it was derived from", () => {
    const i = (t: string) => (USER_DATA_TABLES as readonly string[]).indexOf(t);
    expect(i("question_attempts")).toBeLessThan(i("learner_concept_states"));
    expect(i("flashcard_reviews")).toBeLessThan(i("learner_concept_states"));
    expect(i("flashcard_user_state")).toBeLessThan(i("learner_concept_states"));
  });

  it("never deletes the account, its exam scores, or its support history", () => {
    for (const t of ["profiles", "official_mcat_scores", "support_messages"]) {
      expect(USER_DATA_TABLES).not.toContain(t);
      expect(Object.keys(KEPT_USER_TABLES)).toContain(t);
    }
  });

  it("never deletes shared content", () => {
    for (const t of ["flashcards", "flashcard_decks", "questions", "lessons", "passages"]) {
      expect(USER_DATA_TABLES).not.toContain(t);
    }
  });

  it("clears history before the state derived from it", () => {
    const i = (t: string) => (USER_DATA_TABLES as readonly string[]).indexOf(t);
    expect(i("flashcard_reviews")).toBeLessThan(i("flashcard_user_state"));
    expect(i("question_attempts")).toBeLessThan(i("learner_state_snapshots"));
  });
});

describe("THE TWO SCOPES DIFFER ONLY IN THE PROFILE", () => {
  it("wipes the same tables either way", () => {
    // Both scopes clear progress. "everything" additionally reopens onboarding,
    // which is a profile change, not a bigger deletion.
    expect(USER_DATA_TABLES.length).toBeGreaterThan(0);
    expect(profilePatchFor("progress")).toBeNull();
    expect(profilePatchFor("everything")).toBe(ONBOARDING_DEFAULTS);
  });

  it("reopens onboarding only on the full reset", () => {
    expect(profilePatchFor("everything")!.onboarding_completed).toBe(false);
    expect(profilePatchFor("progress")).toBeNull();
  });

  it("returns the daily limits to the schema defaults", () => {
    // A hand-edited limit is exactly what "start over" should undo; one live
    // account was sitting at a new-card limit of 5000.
    expect(ONBOARDING_DEFAULTS.daily_new_card_limit).toBe(25);
    expect(ONBOARDING_DEFAULTS.daily_review_limit).toBe(150);
    expect(ONBOARDING_DEFAULTS.weekly_question_goal).toBe(100);
  });

  it("clears every answer onboarding collects, and nothing else", () => {
    const cleared = Object.keys(ONBOARDING_DEFAULTS);
    for (const k of ["mcat_test_date", "study_hours_per_week", "target_mcat_score", "weak_sections"]) {
      expect(cleared).toContain(k);
    }
    for (const identity of ["first_name", "last_name", "email", "timezone", "day_start_hour", "is_admin"]) {
      expect(cleared).not.toContain(identity);
    }
  });
});

describe("scope parsing and wording", () => {
  it("accepts only the two known scopes", () => {
    expect(isResetScope("progress")).toBe(true);
    expect(isResetScope("everything")).toBe(true);
    for (const bad of ["all", "", null, undefined, 1, {}, "PROGRESS"]) {
      expect(isResetScope(bad)).toBe(false);
    }
  });

  it("describes each scope without promising more than it does", () => {
    const p = describeScope("progress");
    const e = describeScope("everything");
    expect(p.effect).toMatch(/stay as they are/);
    expect(e.effect).toMatch(/login and name stay/);
    expect(p.title).not.toBe(e.title);
  });
});
