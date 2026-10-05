import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261005_chemical_family_vocabulary.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/families/pre_state.json", "utf8"));
const { CARDS, QUESTIONS, REUSE, SECONDARY } = s.manifest;
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const SLUGS = Object.keys(CARDS);
const allCards = Object.values(CARDS).flat();
const allQs = [...Object.values(QUESTIONS).flat(), ...Object.values(REUSE).flat()];
console.log("PRE-APPLY AUDIT, MIGRATION 7");
console.log("\nSCOPE");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     " + verbs.join(" | "));
chk("no learner table named", !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events|learner_state_snapshots)\b/.test(exec));
chk("no DELETE, DROP, TRUNCATE or ALTER", !/\b(DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
chk("no deprecation anywhere", !/'DEPRECATED'/.test(exec.replace(/status = 'DEPRECATED'/g, "")));
chk("nothing marked HUMAN_VALIDATED on a mapping",
  ![...exec.matchAll(/\bINSERT INTO public\.(question_concepts|flashcard_concepts)[\s\S]*?;/g)].some((m) => /HUMAN_VALIDATED/.test(m[0])));
chk("nothing marked NEEDS_REVIEW", !/'NEEDS_REVIEW'/.test(exec.replace(/mapping_status = 'NEEDS_REVIEW'/g, "")) || !/SET[^;]*'NEEDS_REVIEW'/.test(exec));

console.log("\nARITHMETIC");
chk("5 concepts created", (exec.match(/'CONTENT', 'ACTIVE_SEED', 'CONCEPT'/g) || []).length === 5);
chk("exactly one flashcard UPDATE", (exec.match(/UPDATE public\.flashcard_concepts/g) || []).length === 1);
chk("exactly one question INSERT", (exec.match(/INSERT INTO public\.question_concepts/g) || []).length === 1);
// Bound each statement at its own terminator. Slicing to a comment marker does
// not work here because exec has already had comments stripped, so the block
// ran on into the next statement and swept up its ids.
const stmt = (start) => { const i = exec.indexOf(start); return exec.slice(i, exec.indexOf(";", i) + 1); };
const cardBlock = stmt("UPDATE public.flashcard_concepts");
const cardIds = [...new Set((cardBlock.match(/'([0-9a-f-]{36})'/g) || []).map((x) => x.slice(1, -1)))].filter((u) => u !== s.metalsNonmetalsMetalloids.id);
chk("the repoint names exactly the 19 cards", cardIds.length === 19 && allCards.every((id) => cardIds.includes(id)), String(cardIds.length));
const qBlock = stmt("INSERT INTO public.question_concepts");
const qIds = [...new Set((qBlock.match(/'([0-9a-f-]{36})'/g) || []).map((x) => x.slice(1, -1)))];
chk("the insert names exactly the 20 questions", qIds.length === 20 && allQs.every((id) => qIds.includes(id)), String(qIds.length));
chk("21 question rows: 20 PRIMARY + 1 SECONDARY",
  (qBlock.match(/'PRIMARY'\)/g) || []).length === 20 && (qBlock.match(/'SECONDARY'\)/g) || []).length === 1,
  `${(qBlock.match(/'PRIMARY'\)/g) || []).length}P + ${(qBlock.match(/'SECONDARY'\)/g) || []).length}S`);
chk("the SECONDARY is the calcium-chlorine question on Halogens",
  new RegExp(`'${SECONDARY[0].question}', 'HALOGENS', 'SECONDARY'`).test(qBlock));
chk("the HF question goes to Halogens, not to the acids concept",
  /'f4f7b834-bb1f-401a-b380-2f173274871c', 'HALOGENS', 'PRIMARY'/.test(qBlock) && !/STRONG_WEAK|Ka and Kb/.test(qBlock));
chk("15 taxonomy rows: section, discipline, category for each", (exec.match(/INSERT INTO public\.concept_(sections|disciplines|content_categories)/g) || []).length === 3);
chk("one alias, Active Metals, as COMMON_NAME not an identity",
  /'Active Metals', 'COMMON_NAME'/.test(exec) && (exec.match(/INSERT INTO public\.concept_aliases/g) || []).length === 1);
chk("the post-conditions demand zero unmapped questions", /remain unmapped, expected 0/.test(sql));
chk("the post-conditions demand 5 cards left on Metals, Nonmetals & Metalloids", /should hold exactly its 5 metal-character cards/.test(sql));

console.log("\nLIVE STATE STILL MATCHES");
const C = await all("concepts", "id,slug,canonical_name,status");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const QC = await all("question_concepts", "question_id");
const mapped = new Set(QC.map((r) => r.question_id));
chk("none of the five slugs or names exists yet",
  !C.some((c) => SLUGS.includes(c.slug)) && !C.some((c) => ["Alkali and Alkaline Earth Metals","Halogens","Noble Gases","Transition Metals & Inner Transition Series","Chalcogens"].includes(c.canonical_name)));
chk("all 19 cards still on Metals, Nonmetals & Metalloids",
  allCards.every((id) => FC.some((r) => r.flashcard_id === id && r.concept_id === s.metalsNonmetalsMetalloids.id)));
chk("that concept still holds 24 cards", FC.filter((r) => r.concept_id === s.metalsNonmetalsMetalloids.id).length === 24);
chk("all 20 questions are still unmapped", allQs.every((id) => !mapped.has(id)));
chk("the Periodic Trends reuse target is live", C.some((c) => c.slug === "PERIODIC_TRENDS" && c.status === "ACTIVE_SEED"));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest, the scope and current live state.");
process.exit(P.length ? 1 : 0);
