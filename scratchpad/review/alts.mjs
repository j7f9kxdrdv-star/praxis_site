// Candidate alternative destinations for rows 11-20. Looking BEFORE recommending
// "keep", so a keep is a comparison and not an absence of effort.
import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description,status,object_type");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role");
const QC = await all("question_concepts", "question_id,concept_id,role");
const cards = new Map(), qs = new Map();
for (const r of FC) cards.set(r.concept_id, (cards.get(r.concept_id) || 0) + 1);
for (const r of QC) qs.set(r.concept_id, (qs.get(r.concept_id) || 0) + 1);
const RE = /cholesterol|lipoprotein|lipid|fatty acid|steroid|triacylglycerol|chylomicron|lipolysis|mobiliz|absorption|ketone|beta.?oxidation|bile/i;
const hits = C.filter((c) => RE.test(c.canonical_name)).sort((a, b) => a.canonical_name.localeCompare(b.canonical_name));
for (const c of hits) {
  console.log(`${c.status === "DEPRECATED" ? "[DEPRECATED] " : ""}${c.canonical_name}  (${c.object_type}, ${cards.get(c.id) || 0}c / ${qs.get(c.id) || 0}q)`);
  console.log(`   ${c.id}  ${c.slug}`);
  console.log(`   DEF: ${(c.description || "(none)").replace(/\n/g, " ")}`);
}
