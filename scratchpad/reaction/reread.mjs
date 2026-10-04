import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const F = await all("flashcards", "id,deck_id,position,cloze_text,front_text,back_text");
const D = await all("flashcard_decks", "id,title");
const Q = await all("questions", "id,topic,subtopic,question_text");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const deck = new Map(D.map((d) => [d.id, d.title]));
for (const slug of ["TYPES_REACTIONS", "REACTION_TYPES_CLASSIFICATION", "LIMITING_REAGENT_THEORETICAL_PERCENT_YIELD"]) {
  const c = C.find((x) => x.slug === slug);
  console.log(`\n######## ${c.canonical_name}`);
  console.log(`id ${c.id}  slug ${c.slug}  ${c.object_type}/${c.status}  v${c.version}`);
  console.log(`definition: ${c.description || "(EMPTY)"}`);
  console.log(`aliases: ${AL.filter((r) => r.concept_id === c.id).map((r) => r.alias).join(" | ") || "none"}`);
  const cards = FC.filter((r) => r.concept_id === c.id);
  console.log(`\n-- FLASHCARDS (${cards.length})`);
  cards.forEach((m) => {
    const f = F.find((x) => x.id === m.flashcard_id);
    console.log(`   ${deck.get(f.deck_id)} #${f.position}  [${m.role}/${m.mapping_status}/${m.source}]  ${f.id}`);
    console.log(`      ${(f.cloze_text || `${f.front_text} => ${f.back_text}`).replace(/\n/g, " ")}`);
  });
  const qs = QC.filter((r) => r.concept_id === c.id);
  console.log(`\n-- QUESTIONS (${qs.length})`);
  qs.forEach((m) => {
    const q = Q.find((x) => x.id === m.question_id);
    console.log(`   [${m.role}/${m.mapping_status}/${m.source}] ${q.id}  (${q.subtopic})`);
    console.log(`      ${q.question_text.replace(/\n/g, " ").slice(0, 190)}`);
  });
}
