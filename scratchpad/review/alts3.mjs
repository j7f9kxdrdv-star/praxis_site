import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,canonical_name,description,status,object_type");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id");
const QC = await all("question_concepts", "question_id,concept_id");
const Q = await all("questions", "id,subtopic");
const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const cards = new Map(), qs = new Map();
for (const r of FC) cards.set(r.concept_id, (cards.get(r.concept_id) || 0) + 1);
for (const r of QC) qs.set(r.concept_id, (qs.get(r.concept_id) || 0) + 1);
console.log("=== candidate destinations for row 24 (glycerol glucogenic, acetyl-CoA not) ===");
for (const c of C.filter((c) => /gluconeogen|glycolysis|glycogen|acetyl|citric acid|krebs|carbohydrate metabolism|fuel|fasting|starvation/i.test(c.canonical_name)).sort((a,b)=>a.canonical_name.localeCompare(b.canonical_name))) {
  console.log(`${c.status === "DEPRECATED" ? "[DEP] " : ""}${c.canonical_name}  (${cards.get(c.id)||0}c / ${qs.get(c.id)||0}q)  ${c.id}`);
  console.log(`   DEF: ${(c.description || "(none)").replace(/\n/g," ")}`);
}
const G = C.find((c) => c.canonical_name === "Gluconeogenesis");
if (G) {
  console.log(`\n=== what already sits on Gluconeogenesis (${G.id}) ===`);
  for (const r of FC.filter((r) => r.concept_id === G.id)) {
    const f = F.find((x) => x.id === r.flashcard_id);
    console.log(`  CARD [${D.find((d)=>d.id===f.deck_id).title} #${f.position}] ${(f.cloze_text||"").replace(/\n/g," ").slice(0,140)}`);
  }
  for (const r of QC.filter((r) => r.concept_id === G.id)) console.log(`  Q ${r.question_id.slice(0,8)}  subtopic="${Q.find((q)=>q.id===r.question_id).subtopic}"`);
}
console.log("\n=== how many questions in the whole bank carry subtopic 'Lipid Mobilization & Transport' ===");
const lab = Q.filter((q) => q.subtopic === "Lipid Mobilization & Transport");
console.log(`  ${lab.length} questions; of those, mapped: ${lab.filter((q)=>QC.some((r)=>r.question_id===q.id)).length}`);
