import fs from "node:fs";
const sql = fs.readFileSync("supabase/migrations/20261003_deprecated_target_update_guard.sql", "utf8");
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
console.log("PRE-APPLY AUDIT, MIGRATION 2.5");
// A DML verb must START a statement. "UPDATE OF concept_id" inside a trigger
// definition is not a statement, and matching it is how this check first
// reported a data write in a migration that contains none.
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
chk("writes no table at all", verbs.length === 0, verbs.join(" | "));
chk("touches no learner table",
  !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events|learner_state_snapshots)\b/.test(exec));
chk("replaces exactly one function", (exec.match(/CREATE OR REPLACE FUNCTION/g) || []).length === 1);
chk("recreates exactly three triggers", (exec.match(/CREATE TRIGGER/g) || []).length === 3);
chk("all three fire BEFORE INSERT OR UPDATE OF concept_id",
  (exec.match(/BEFORE INSERT OR UPDATE OF concept_id ON/g) || []).length === 3);
chk("the three tables are the three mapping tables",
  ["public.question_concepts", "public.flashcard_concepts", "public.question_reasoning_objects"]
    .every((t) => new RegExp(`CREATE TRIGGER[\\s\\S]{0,120}ON ${t.replace(".", "\\.")}\\b`).test(exec)));
chk("the function short-circuits when concept_id is not moving",
  /TG_OP = 'UPDATE' AND NEW\.concept_id IS NOT DISTINCT FROM OLD\.concept_id/.test(exec));
chk("no DROP of a sibling trigger", !/DROP TRIGGER IF EXISTS \w*(protect|content_only|reasoning_only)/.test(exec));
chk("asserts the installed shape from the catalog", /pg_get_triggerdef/.test(exec));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGuard-only migration: no data statements of any kind.");
process.exit(P.length ? 1 : 0);
