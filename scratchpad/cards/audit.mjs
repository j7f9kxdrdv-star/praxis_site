import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const F = await all("flashcards", "id,deck_id,position,cloze_text,cloze_count,card_type,front_text,back_text,explanation,tags");
const D = await all("flashcard_decks", "id,title");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const deck = new Map(D.map((d) => [d.id, d.title]));
const npf = D.find((d) => d.title === "Nonenzymatic Protein Function and Protein Analysis");
const cell = D.find((d) => d.title === "The Cell");
console.log("=== CANDIDATE SECONDARY CARDS (Nonenzymatic Protein Function #1-#3) ===");
F.filter((f) => f.deck_id === npf.id && f.position >= 1 && f.position <= 3)
  .sort((a, b) => a.position - b.position)
  .forEach((f) => {
    const m = FC.filter((r) => r.flashcard_id === f.id);
    console.log(`\n#${f.position}  ${f.id}  PRIMARY -> ${m.map((r) => nm.get(r.concept_id)).join(", ")}`);
    console.log(`   ${f.cloze_text.replace(/\n/g, " ")}`);
  });
console.log("\n=== DECK PLACEMENT FOR THE NEW CARD ===");
for (const d of [cell, npf]) {
  const ps = F.filter((f) => f.deck_id === d.id).map((f) => f.position).sort((a, b) => a - b);
  console.log(`   "${d.title}": ${ps.length} cards, positions ${ps[0]} to ${ps[ps.length - 1]}, max+1 = ${ps[ps.length - 1] + 1}`);
}
console.log("\n=== THE TWO CARDS TO REWRITE, FULL ROW ===");
["71959e9d-e9e0-4da5-aa03-6286378a591d", "4d56a412-90d2-47cb-b0d8-db3a3a06f232"].forEach((id) => {
  const f = F.find((x) => x.id === id);
  console.log(`\n${deck.get(f.deck_id)} #${f.position}  ${f.id}`);
  console.log(`   card_type=${f.card_type} cloze_count=${f.cloze_count} front=${f.front_text} back=${f.back_text}`);
  console.log(`   tags=${JSON.stringify(f.tags)} explanation=${JSON.stringify(f.explanation)}`);
  console.log(`   text: ${f.cloze_text.replace(/\n/g, " ")}`);
});
