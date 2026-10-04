import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261004_reaction_type_disambiguation.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/reaction/pre_state.json", "utf8"));
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const { conceptA: A, conceptB: B, limitingReagent: LR, movedCard, haberQuestion } = s;

console.log("PRE-APPLY AUDIT, MIGRATION 4");
console.log("\nSCOPE");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     write statements: " + verbs.join(" | "));
chk("writes only concepts, flashcard_concepts and question_concepts",
  verbs.every((v) => /public\.(concepts|flashcard_concepts|question_concepts)$/.test(v)));
chk("no learner table named", !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events|learner_state_snapshots)\b/.test(exec));
chk("no INSERT, DELETE, DROP, TRUNCATE or ALTER", !/\b(INSERT\s+INTO|DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
chk("no reasoning mapping write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_reasoning_objects/im.test(exec));
chk("no taxonomy write", !/(concept_sections|concept_disciplines|concept_content_categories)/i.test(exec.replace(/SELECT[^;]*?(concept_sections|concept_disciplines|concept_content_categories)[^;]*;/gi, "")));
const setClauses = [...exec.matchAll(/\bUPDATE\s+public\.\w+[\s\S]*?\bSET\b([\s\S]*?)\bWHERE\b/gi)].map((m) => m[1]);
chk("exactly 5 UPDATE statements: 2 definitions, 1 rename, 1 card, 1 question", setClauses.length === 5, String(setClauses.length));
chk("no SET assigns HUMAN_VALIDATED or NEEDS_REVIEW",
  !setClauses.some((c) => /'(HUMAN_VALIDATED|NEEDS_REVIEW)'/.test(c)));
chk("no SET assigns a slug or an id column", !setClauses.some((c) => /\b(slug|id)\s*=/.test(c)));

console.log("\nMANIFEST");
chk("exactly one flashcard mapping moves", (exec.match(/UPDATE public\.flashcard_concepts/g) || []).length === 1);
chk("exactly one question mapping moves", (exec.match(/UPDATE public\.question_concepts/g) || []).length === 1);
chk("the card moved is the metathesis card", exec.includes(movedCard.id));
chk("the question moved is the Haber question", exec.includes(haberQuestion.id));
chk("the card goes from Types of Reactions to the renamed concept",
  new RegExp(`UPDATE public\\.flashcard_concepts[\\s\\S]*?'${B.id}'[\\s\\S]*?'${movedCard.id}'[\\s\\S]*?'${A.id}'`).test(exec));
chk("the question goes from Types of Reactions to Limiting Reagent",
  new RegExp(`UPDATE public\\.question_concepts[\\s\\S]*?'${LR.id}'[\\s\\S]*?'${haberQuestion.id}'[\\s\\S]*?'${A.id}'`).test(exec));
chk("both moves land AI_PROPOSED / AI_PROPOSED",
  (exec.match(/mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'/g) || []).length === 2);
chk("each definition names the other concept",
  /Redox Classification of Reaction Families\$d\$ WHERE id = '|Redox Classification of Reaction Families[\s\S]*?\$d\$,?\s*\n?\s*WHERE id = '/.test(exec) || exec.includes("belongs to Redox Classification of Reaction Families"));
chk("the renamed concept's definition points back at Types of Reactions", exec.includes("belongs to Types of Reactions"));

console.log("\nLIVE STATE STILL MATCHES THE SNAPSHOT");
const C = await all("concepts", "id,slug,canonical_name,status,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status");
const a = C.find((c) => c.id === A.id), b = C.find((c) => c.id === B.id), lr = C.find((c) => c.id === LR.id);
chk("all three concepts still ACTIVE_SEED", [a, b, lr].every((c) => c && c.status === "ACTIVE_SEED"));
chk("concept B still carries its pre-rename name and version",
  b.canonical_name === B.canonicalName && b.version === B.version);
chk("Types of Reactions still holds 10 cards and 11 questions",
  FC.filter((r) => r.concept_id === A.id).length === 10 && QC.filter((r) => r.concept_id === A.id).length === 11);
chk("the renamed concept still holds 0 cards and 5 questions",
  FC.filter((r) => r.concept_id === B.id).length === 0 && QC.filter((r) => r.concept_id === B.id).length === 5);
chk("Limiting Reagent still holds 16 questions", QC.filter((r) => r.concept_id === LR.id).length === 16);
chk("the metathesis card is still on Types of Reactions, PRIMARY",
  FC.some((r) => r.flashcard_id === movedCard.id && r.concept_id === A.id && r.role === "PRIMARY"));
chk("the Haber question is still on Types of Reactions, PRIMARY",
  QC.some((r) => r.question_id === haberQuestion.id && r.concept_id === A.id && r.role === "PRIMARY"));
chk("neither moved row is HUMAN_VALIDATED",
  FC.find((r) => r.flashcard_id === movedCard.id).mapping_status !== "HUMAN_VALIDATED" &&
  QC.find((r) => r.question_id === haberQuestion.id).mapping_status !== "HUMAN_VALIDATED");
const norm = (x) => x.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
chk("the new name collides with nothing under normalisation",
  !C.some((c) => c.id !== b.id && norm(c.canonical_name) === norm("Redox Classification of Reaction Families")));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest, the scope and current live state.");
process.exit(P.length ? 1 : 0);
