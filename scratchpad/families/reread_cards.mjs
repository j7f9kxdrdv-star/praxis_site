import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const mnm = C.find((c) => c.slug === "TYPES_ELEMENTS");
const fam = D.find((d) => d.title === "Periodic Trends & Chemical Families");
const rows = FC.filter((r) => r.concept_id === mnm.id)
  .map((r) => ({ ...r, f: F.find((x) => x.id === r.flashcard_id) }))
  .filter((r) => r.f.deck_id === fam.id && r.f.position >= 27)
  .sort((a, b) => a.f.position - b.f.position);
console.log(`${rows.length} chemical-family cards on "${mnm.canonical_name}"\n`);
rows.forEach((r) => {
  console.log(`#${r.f.position}  ${r.flashcard_id}  [${r.role}/${r.mapping_status}/${r.source}]`);
  console.log(`   ${r.f.cloze_text.replace(/\n/g, " ")}\n`);
});
