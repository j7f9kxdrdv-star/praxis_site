import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261006_card_too_broad_repairs.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/cards/pre_state.json", "utf8"));
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const CY = s.cytoskeletonCard, ST = s.structuralProteinsCard, EL = s.elastinConsideredAndDeclined;
console.log("PRE-APPLY AUDIT, MIGRATION 8");
console.log("\nSCOPE");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     " + verbs.join(" | "));
chk("no question_concepts write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_concepts/im.test(exec));
chk("no reasoning write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.question_reasoning_objects/im.test(exec));
chk("no questions table write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.questions\b/im.test(exec));
chk("no learner table write", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.(flashcard_user_state|flashcard_reviews|question_attempts)/im.test(exec));
chk("no DELETE, DROP, TRUNCATE or ALTER", !/\b(DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
chk("nothing HUMAN_VALIDATED or NEEDS_REVIEW", !/'(HUMAN_VALIDATED|NEEDS_REVIEW)'/.test(exec.replace(/mapping_status = 'HUMAN_VALIDATED'/g, "").replace(/mapping_status = 'NEEDS_REVIEW'/g, "")));

console.log("\nTHE REWRITES PRESERVE IDENTITY");
// Bound each statement at its own terminator. An unbounded lazy match runs to
// the end of the file and finds ids that belong to later statements, which is
// how four of these checks first reported problems that did not exist.
const stmt = (start) => { const i = exec.indexOf(start); return i < 0 ? "" : exec.slice(i, exec.indexOf(";", i) + 1); };
const cardInsert = stmt("INSERT INTO public.flashcards (deck_id");
chk("both existing card ids appear, and the card INSERT names neither",
  exec.includes(CY.id) && exec.includes(ST.id) &&
  !cardInsert.includes(CY.id) && !cardInsert.includes(ST.id));
chk("each rewrite is guarded on cloze_count = 2", (exec.match(/AND cloze_count = 2/g) || []).length === 2);
chk("keratin-family proteins stays inside c2", /\{\{c2::keratin-family proteins\}\}/.test(exec));
chk("cytoskeleton c1 holds the three class names",
  /\{\{c1::microfilaments\}\}/.test(exec) && /\{\{c1::intermediate filaments\}\}/.test(exec) && /\{\{c1::microtubules\}\}/.test(exec));
chk("cytoskeleton c2 holds the three subunits",
  /\{\{c2::actin\}\}/.test(exec) && /\{\{c2::tubulin\}\}/.test(exec));
chk("structural-proteins c1 is the class and c2 is keratin",
  /\{\{c1::Structural proteins\}\}/.test(exec) && /\{\{c2::keratin\}\}/.test(exec));
chk("the post-conditions assert both cloze_counts stay 2", (sql.match(/cloze_count changed to/g) || []).length === 2);

console.log("\nTHE NEW CARD IS NEW");
chk("exactly one flashcards INSERT", (exec.match(/INSERT INTO public\.flashcards/g) || []).length === 1);
chk("the INSERT carries no uuid at all except the deck",
  (cardInsert.match(/'[0-9a-f-]{36}'/g) || []).length === 1);
chk("the migration asserts it has zero scheduler rows and zero reviews",
  /the new card already has % scheduler row/.test(sql) && /the new card already has % review/.test(sql));
chk("it is appended at position 75, so no existing position shifts",
  /,\s*1,\s*75\);/.test(cardInsert) && /position = 75/.test(exec));

console.log("\nMAPPINGS");
chk("5 new mapping rows: 3 PRIMARY + 2 SECONDARY",
  (exec.match(/'PRIMARY', 0\.90/g) || []).length === 3 && (exec.match(/'SECONDARY', 0\.90/g) || []).length === 1,
  `${(exec.match(/'PRIMARY', 0\.90/g) || []).length} primary inserts`);
chk("collagen and keratin get the SECONDARY", exec.includes("ca5f08a7") && exec.includes("328bd950"));
// Elastin's id DOES appear, in a post-condition asserting it still holds
// exactly one mapping. That is the point: the migration proves it was not
// given a secondary, rather than merely not mentioning it.
const elastinLines = sql.split("\n").filter((l) => l.includes(EL.id));
chk("elastin gets no mapping, and the migration asserts it stays untouched",
  !cardInsert.includes(EL.id) &&
  !stmt("INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)\nSELECT v.card_id").includes(EL.id) &&
  elastinLines.length === 1 && /flashcard_concepts WHERE flashcard_id/.test(elastinLines[0]),
  `named on ${elastinLines.length} line, as an assertion`);
chk("all new mappings are AI_PROPOSED / AI_PROPOSED",
  (exec.match(/'AI_PROPOSED', 'AI_PROPOSED'/g) || []).length === 4);
chk("the gate assertion demands zero unmapped cards", /remain unmapped, expected 0/.test(sql));

console.log("\nLIVE STATE STILL MATCHES");
const F = await all("flashcards", "id,deck_id,position");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role");
const C = await all("concepts", "id,slug,canonical_name,status");
const mapped = new Set(FC.map((r) => r.flashcard_id));
chk("still exactly 2 unmapped cards", F.filter((f) => !mapped.has(f.id)).length === 2);
chk("they are still the two expected ones", !mapped.has(CY.id) && !mapped.has(ST.id));
chk("neither new slug nor name exists yet",
  !C.some((c) => ["CYTOSKELETON_FILAMENT_CLASSES", "STRUCTURAL_PROTEINS"].includes(c.slug)) &&
  !C.some((c) => ["Cytoskeleton: Filament Classes", "Structural Proteins"].includes(c.canonical_name)));
chk("position 75 of The Cell is free", !F.some((f) => f.deck_id === CY.deck_id && f.position === 75));
chk("collagen and keratin each hold exactly one PRIMARY",
  ["ca5f08a7-3bc2-493b-8e82-dd2835e122f0", "328bd950-1833-4c3c-902c-a6a514ec322c"]
    .every((id) => FC.filter((r) => r.flashcard_id === id).length === 1));
chk("the taxonomy sources exist",
  C.some((c) => c.slug === "CYTOSKELETON_MICROFILAMENTS") && C.some((c) => c.slug === "TISSUES_CONNECTIVE_TISSUE"));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest, the scope and current live state.");
process.exit(P.length ? 1 : 0);
