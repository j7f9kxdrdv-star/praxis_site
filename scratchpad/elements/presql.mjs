import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261005_types_of_elements_identity.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/elements/pre_state.json", "utf8"));
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const TOE = s.concept.id, PTS = s.periodicTableStructure.id;
const FIVE = s.incomingFiveCards.map((r) => r.flashcard_id);
const NINETEEN = s.pendingFamilyCardsForMigration7.map((r) => r.flashcard_id);
console.log("PRE-APPLY AUDIT, MIGRATION 6");
console.log("\nSCOPE");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     write statements: " + verbs.join(" | "));
chk("writes only concepts and flashcard_concepts", verbs.every((v) => /public\.(concepts|flashcard_concepts)$/.test(v)));
chk("no question_concepts write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_concepts/im.test(exec));
chk("no reasoning write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_reasoning_objects/im.test(exec));
chk("no taxonomy write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.(concept_sections|concept_disciplines|concept_content_categories)/im.test(exec));
chk("no learner table named", !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events)\b/.test(exec));
chk("no INSERT, DELETE, DROP, TRUNCATE or ALTER", !/\b(INSERT\s+INTO|DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
const setClauses = [...exec.matchAll(/\bUPDATE\s+public\.\w+[\s\S]*?\bSET\b([\s\S]*?)\bWHERE\b/gi)].map((m) => m[1]);
chk("exactly 3 UPDATE statements: definition, rename, five cards", setClauses.length === 3, String(setClauses.length));
chk("no SET assigns a slug, HUMAN_VALIDATED or NEEDS_REVIEW",
  !setClauses.some((c) => /\bslug\s*=|'HUMAN_VALIDATED'|'NEEDS_REVIEW'/.test(c)));

console.log("\nMANIFEST");
chk("exactly one flashcard UPDATE", (exec.match(/UPDATE public\.flashcard_concepts/g) || []).length === 1);
const upd = exec.slice(exec.indexOf("UPDATE public.flashcard_concepts"));
const updBlock = upd.slice(0, upd.indexOf(");") + 2);
const inBlock = (updBlock.match(/'([0-9a-f-]{36})'/g) || []).map((x) => x.slice(1, -1));
chk("the repoint names exactly the 5 incoming cards plus both concepts",
  FIVE.every((id) => inBlock.includes(id)) && inBlock.filter((u) => ![TOE, PTS].includes(u)).length === 5,
  `${inBlock.filter((u) => ![TOE, PTS].includes(u)).length} card id(s)`);
chk("NONE of the 19 family cards appears in the repoint", !NINETEEN.some((id) => updBlock.includes(id)));
chk("the repoint moves FROM Periodic Table Structure TO the renamed concept",
  updBlock.includes(`SET concept_id = '${TOE}'`) && updBlock.includes(`WHERE concept_id = '${PTS}'`));
chk("governance is AI_PROPOSED / AI_PROPOSED", /mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'/.test(updBlock));
chk("the definition rules the family axis out", /DIFFERENT axis/.test(exec));
chk("the post-conditions expect 24 cards, the pending state", /expected 24 cards \(19 pending \+ 5 moved\)/.test(sql));

console.log("\nLIVE STATE STILL MATCHES THE SNAPSHOT");
const C = await all("concepts", "id,slug,canonical_name,status,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const QC = await all("question_concepts", "question_id,concept_id");
const toe = C.find((c) => c.id === TOE), pts = C.find((c) => c.id === PTS);
chk("both concepts ACTIVE and unrenamed",
  toe.canonical_name === "Types of Elements" && toe.status === "ACTIVE_SEED" && pts.status === "ACTIVE_SEED");
chk("19 cards and 12 questions still on the concept",
  FC.filter((r) => r.concept_id === TOE).length === 19 && QC.filter((r) => r.concept_id === TOE).length === 12);
chk("13 cards still on Periodic Table Structure", FC.filter((r) => r.concept_id === PTS).length === 13);
chk("all 5 incoming cards are still on Periodic Table Structure, PRIMARY",
  FIVE.every((id) => FC.some((r) => r.flashcard_id === id && r.concept_id === PTS && r.role === "PRIMARY")));
chk("none of the 5 is HUMAN_VALIDATED",
  FIVE.every((id) => FC.find((r) => r.flashcard_id === id).mapping_status !== "HUMAN_VALIDATED"));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest, the scope and current live state.");
process.exit(P.length ? 1 : 0);
