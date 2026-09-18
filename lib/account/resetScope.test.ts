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

  const used = new Set<string>();
  for (const file of sourceFiles(path.join(ROOT, "app"))
    .concat(sourceFiles(path.join(ROOT, "lib")))
    .concat(sourceFiles(path.join(ROOT, "scripts")))) {
    const src = fs.readFileSync(file, "utf8");
    for (const m of src.matchAll(/\.from\("([a-z_]+)"\)/g)) used.add(m[1]);
  }

  it("every table the app touches is classified", () => {
    const unclassified = [...used].filter((t) => !classified.has(t)).sort();
    expect(unclassified).toEqual([]);
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
    ]) {
      expect(USER_DATA_TABLES, t).toContain(t);
    }
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
