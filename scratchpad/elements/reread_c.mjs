import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const F = await all("flashcards", "id,deck_id,position,cloze_text,front_text");
const D = await all("flashcard_decks", "id,title");
const deck = new Map(D.map((d) => [d.id, d.title]));
for (const slug of ["TYPES_ELEMENTS", "PERIODIC_TABLE_STRUCTURE_CLASSIFICATION"]) {
  const c = C.find((x) => x.slug === slug);
  const rows = FC.filter((r) => r.concept_id === c.id)
    .map((r) => ({ ...r, f: F.find((x) => x.id === r.flashcard_id) }))
    .sort((a, b) => a.f.position - b.f.position);
  console.log(`\n######## ${c.canonical_name}  (${rows.length} cards)`);
  rows.forEach((r) => console.log(`  #${String(r.f.position).padStart(2)} [${r.role}/${r.mapping_status}/${r.source}] ${r.flashcard_id.slice(0,8)}  ${(r.f.cloze_text || r.f.front_text).replace(/\n/g," ").slice(0,105)}`));
}
