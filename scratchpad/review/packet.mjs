import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const C = await all("concepts", "id,slug,canonical_name");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const F = await all("flashcards", "id,deck_id,position,cloze_text,front_text,back_text");
const D = await all("flashcard_decks", "id,title");
const Q = await all("questions", "id,subtopic,question_text,options,correct_answer,explanation");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const deck = new Map(D.map((d) => [d.id, d.title]));
const rows = [];
FC.filter((r) => r.mapping_status === "NEEDS_REVIEW")
  .map((r) => ({ ...r, f: F.find((x) => x.id === r.flashcard_id) }))
  .sort((a, b) => (deck.get(a.f.deck_id)).localeCompare(deck.get(b.f.deck_id)) || a.f.position - b.f.position || a.role.localeCompare(b.role))
  .forEach((r) => rows.push({ kind: "card", ...r }));
QC.filter((r) => r.mapping_status === "NEEDS_REVIEW")
  .map((r) => ({ ...r, q: Q.find((x) => x.id === r.question_id) }))
  .sort((a, b) => a.question_id.localeCompare(b.question_id))
  .forEach((r) => rows.push({ kind: "question", ...r }));
fs.writeFileSync("scratchpad/review/rows.json", JSON.stringify(rows.map((r, i) => ({
  n: i + 1, kind: r.kind, table: r.kind === "card" ? "flashcard_concepts" : "question_concepts",
  item_id: r.kind === "card" ? r.flashcard_id : r.question_id,
  concept_id: r.concept_id, concept: nm.get(r.concept_id), role: r.role,
  mapping_status: r.mapping_status, source: r.source, confidence: r.confidence,
})), null, 1));
const from = Number(process.argv[2] || 1), to = Number(process.argv[3] || 10);
rows.slice(from - 1, to).forEach((r, i) => {
  const n = from + i;
  console.log(`\n${"=".repeat(70)}\nROW ${n}  [${r.kind}]  ${r.role} / ${r.mapping_status} / ${r.source} / conf ${r.confidence}`);
  console.log(`   currently on: ${nm.get(r.concept_id)}`);
  if (r.kind === "card") {
    console.log(`   ${deck.get(r.f.deck_id)} #${r.f.position}   ${r.flashcard_id}`);
    console.log(`   TEXT: ${(r.f.cloze_text || `${r.f.front_text} => ${r.f.back_text}`).replace(/\n/g, " ")}`);
  } else {
    const o = Array.isArray(r.q.options) ? r.q.options : JSON.parse(r.q.options || "[]");
    console.log(`   ${r.question_id}   subtopic: ${r.q.subtopic}`);
    console.log(`   STEM: ${r.q.question_text.replace(/\n/g, " ")}`);
    o.forEach((x, j) => console.log(`      ${"ABCD"[j]}. ${String(typeof x === "string" ? x : x.text ?? JSON.stringify(x)).replace(/\n/g, " ").slice(0, 200)}`));
    console.log(`   CORRECT: ${r.q.correct_answer}`);
    console.log(`   WHY: ${String(r.q.explanation || "").replace(/\n/g, " ").slice(0, 420)}`);
  }
});
console.log(`\n(${rows.length} rows total; manifest written to scratchpad/review/rows.json)`);
