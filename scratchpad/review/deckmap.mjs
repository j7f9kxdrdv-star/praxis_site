// The deck's own mapping pattern around rows 11-20. If a neighbouring card that
// teaches the same thing already sits elsewhere, that is evidence about where
// these rows belong; if the neighbours sit here, that is evidence to keep them.
import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,canonical_name");
const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const dk = D.find((d) => d.title === "Lipid and Amino Acid Metabolism");
for (const f of F.filter((f) => f.deck_id === dk.id && f.position >= 14 && f.position <= 36).sort((a, b) => a.position - b.position)) {
  const ms = FC.filter((r) => r.flashcard_id === f.id);
  const tag = ms.map((m) => `${nm.get(m.concept_id)}${m.role === "SECONDARY" ? " (2nd)" : ""}${m.mapping_status === "NEEDS_REVIEW" ? " *REVIEW*" : ""}`).join(" + ") || "(unmapped)";
  console.log(`#${String(f.position).padStart(2)}  ${tag}`);
  console.log(`      ${(f.cloze_text || "").replace(/\n/g, " ").slice(0, 150)}`);
}
console.log("\n--- cards on Cholesterol & Triacylglycerol Synthesis (anywhere) ---");
for (const r of FC.filter((r) => r.concept_id === "066ad4c3-e5b1-49b4-b8a2-951a8f721eed")) {
  const f = F.find((x) => x.id === r.flashcard_id);
  console.log(`  [${D.find((d) => d.id === f.deck_id).title} #${f.position}] ${r.role} ${(f.cloze_text || "").replace(/\n/g, " ").slice(0, 130)}`);
}
console.log("\n--- cards on Lipid Absorption & Routing (anywhere) ---");
for (const r of FC.filter((r) => r.concept_id === "befc9366-83b7-4b65-93dc-09d8aba82a26")) {
  const f = F.find((x) => x.id === r.flashcard_id);
  console.log(`  [${D.find((d) => d.id === f.deck_id).title} #${f.position}] ${r.role} ${(f.cloze_text || "").replace(/\n/g, " ").slice(0, 130)}`);
}
