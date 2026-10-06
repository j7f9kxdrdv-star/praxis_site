// Batch 3 evidence. The seven question rows carry source DETERMINISTIC_EXACT,
// which records how the ORIGINAL mapping onto the now-deprecated parent was
// made, not how the split repoint was decided. An exact NAME match proves the
// label matched; it proves nothing about the stem. So this prints the legacy
// label alongside the stem, to show exactly what the match was made on.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const rows = JSON.parse(fs.readFileSync("scratchpad/review/rows.json", "utf8"));
const C = await all("concepts", "id,canonical_name");
const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const Q = await all("questions", "id,topic,subtopic,content_category,difficulty,question_text,options,correct_answer,explanation");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QR = await all("question_reasoning_objects", "question_id,concept_id");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const deck = new Map(D.map((d) => [d.id, d.title]));
for (const r of rows.filter((r) => r.n >= 21)) {
  console.log(`\n${"=".repeat(72)}\nROW ${r.n}  [${r.kind}]  ${r.role} / ${r.source}`);
  console.log(`   currently on: ${r.concept}`);
  if (r.kind === "card") {
    const f = F.find((x) => x.id === r.item_id);
    console.log(`   ${deck.get(f.deck_id)} #${f.position}   ${r.item_id}`);
    console.log(`   TEXT: ${(f.cloze_text || "").replace(/\n/g, " ")}`);
    const other = FC.filter((x) => x.flashcard_id === r.item_id && x.concept_id !== r.concept_id);
    console.log(`   other mappings: ${other.map((o) => `${nm.get(o.concept_id)} (${o.role})`).join(", ") || "none"}`);
  } else {
    const q = Q.find((x) => x.id === r.item_id);
    const o = Array.isArray(q.options) ? q.options : JSON.parse(q.options || "[]");
    console.log(`   ${r.item_id}`);
    console.log(`   LEGACY LABEL: topic="${q.topic}"  subtopic="${q.subtopic}"`);
    console.log(`   content_category: ${q.content_category}   difficulty: ${q.difficulty}`);
    console.log(`   STEM: ${q.question_text.replace(/\n/g, " ")}`);
    o.forEach((x, j) => console.log(`      ${"ABCD"[j]}. ${String(typeof x === "string" ? x : x.text ?? JSON.stringify(x)).replace(/\n/g, " ")}`));
    console.log(`   CORRECT: ${q.correct_answer}`);
    console.log(`   EXPLANATION: ${String(q.explanation || "").replace(/\n/g, " ")}`);
    const other = QC.filter((x) => x.question_id === r.item_id && x.concept_id !== r.concept_id);
    console.log(`   other content mappings: ${other.map((x) => `${nm.get(x.concept_id)} (${x.role})`).join(", ") || "none"}`);
    const ro = QR.filter((x) => x.question_id === r.item_id);
    console.log(`   reasoning objects: ${ro.map((x) => nm.get(x.concept_id)).join(", ") || "none"}`);
  }
}
