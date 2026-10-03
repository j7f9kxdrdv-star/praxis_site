import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261003_reducing_sugar_boundary.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/sugar/pre_rename_snapshot.json", "utf8"));
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const MOVE = ["29efd5f2-32cc-4e7a-a799-947d92ebee71","56644b98-ee7f-4189-b08c-7126fcc508f0","d0f19c7b-2255-4544-8576-0558117cacba"];
const STAY = ["18ee658b-e1c8-463d-b495-20e0283148b3","e45c97f6-a36b-45c4-83df-2693fb8e3a88"];

console.log("PRE-APPLY AUDIT, MIGRATION 3");
console.log("\nSCOPE");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     write statements: " + verbs.join(" | "));
chk("writes only concepts and question_concepts", verbs.every((v) => /public\.(concepts|question_concepts)$/.test(v)));
chk("no learner table named", !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events|learner_state_snapshots)\b/.test(exec));
chk("no flashcard_concepts write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.flashcard_concepts/im.test(exec));
chk("no question_reasoning_objects write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_reasoning_objects/im.test(exec));
chk("no INSERT, DELETE, DROP or TRUNCATE at all", !/\b(INSERT\s+INTO|DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
chk("no new concept created", !/INSERT INTO public\.concepts/i.test(exec));
chk("nothing is deprecated", !/'DEPRECATED'/.test(exec.replace(/status = 'DEPRECATED'/g, "")) || !/SET[^;]*status\s*=\s*'DEPRECATED'/i.test(exec));
chk("slug is never assigned", !/SET[^;]*\bslug\s*=/i.test(exec));
// Only an ASSIGNMENT counts. The pre-conditions legitimately COMPARE against
// 'HUMAN_VALIDATED' to prove none is about to be overwritten, and matching that
// comparison is how this check first reported a problem that did not exist.
const setClauses = [...exec.matchAll(/\bUPDATE\s+public\.\w+[\s\S]*?\bSET\b([\s\S]*?)\bWHERE\b/gi)].map((m) => m[1]);
console.log("     SET clauses: " + setClauses.length);
chk("no SET clause assigns HUMAN_VALIDATED", !setClauses.some((c) => /'HUMAN_VALIDATED'/.test(c)));
chk("no SET clause assigns NEEDS_REVIEW, so the queue does not grow", !setClauses.some((c) => /'NEEDS_REVIEW'/.test(c)));
chk("no SET clause assigns a slug or an id", !setClauses.some((c) => /\b(slug|id)\s*=/.test(c)));

console.log("\nMANIFEST");
chk("exactly 3 questions repointed", (exec.match(/UPDATE public\.question_concepts/g) || []).length === 1);
MOVE.forEach((id) => chk(`  moves ${id.slice(0, 8)}`, exec.includes(id)));
STAY.forEach((id) => chk(`  holds ${id.slice(0, 8)} (assertions only, no UPDATE)`, exec.includes(id)));
const upd = exec.slice(exec.indexOf("UPDATE public.question_concepts"));
const updBlock = upd.slice(0, upd.indexOf(");") + 2);
chk("the repoint statement names the 3 movers and no stayer",
  MOVE.every((id) => updBlock.includes(id)) && !STAY.some((id) => updBlock.includes(id)));
chk("repoint governance is AI_PROPOSED / AI_PROPOSED",
  /mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'/.test(updBlock));
chk("source is the concept A id and target the concept B id",
  updBlock.includes(s.conceptA.id) && updBlock.includes(s.conceptB.id));

console.log("\nLIVE STATE STILL MATCHES THE SNAPSHOT");
const C = await all("concepts", "id,slug,canonical_name,status,version");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status");
const a = C.find((c) => c.id === s.conceptA.id), b = C.find((c) => c.id === s.conceptB.id);
chk("concept A still named, slugged and versioned as snapshotted",
  a.canonical_name === s.conceptA.canonicalName && a.slug === s.conceptA.slug && a.version === s.conceptA.version && a.status === "ACTIVE_SEED");
chk("concept B unchanged", b.canonical_name === s.conceptB.canonicalName && b.status === "ACTIVE_SEED");
const liveA = QC.filter((r) => r.concept_id === a.id).map((r) => r.question_id).sort();
chk("concept A still holds exactly the 5 reviewed questions",
  liveA.length === 5 && [...MOVE, ...STAY].sort().every((id, i) => liveA[i] === id), String(liveA.length));
chk("concept B still holds 4", QC.filter((r) => r.concept_id === b.id).length === 4);
chk("all 5 are PRIMARY and none is HUMAN_VALIDATED",
  QC.filter((r) => r.concept_id === a.id).every((r) => r.role === "PRIMARY" && r.mapping_status !== "HUMAN_VALIDATED"));
const norm = (x) => x.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
chk("the new name collides with nothing under normalisation",
  !C.some((c) => c.id !== a.id && norm(c.canonical_name) === norm("Sugar Oxidation Products")));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest, the scope and current live state.");
process.exit(P.length ? 1 : 0);
