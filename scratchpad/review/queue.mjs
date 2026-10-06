import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description,status");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const fcNR = FC.filter((r) => r.mapping_status === "NEEDS_REVIEW");
const qcNR = QC.filter((r) => r.mapping_status === "NEEDS_REVIEW");
console.log(`TOTAL NEEDS_REVIEW: ${fcNR.length + qcNR.length}`);
console.log(`  flashcard_concepts: ${fcNR.length}`);
console.log(`  question_concepts:  ${qcNR.length}\n`);
const dest = {};
[...fcNR, ...qcNR].forEach((r) => { const k = nm.get(r.concept_id); dest[k] = (dest[k] || 0) + 1; });
console.log("destinations:");
Object.entries(dest).forEach(([k, v]) => console.log(`  ${String(v).padStart(3)}  ${k}`));
const expected = new Set(["Adipose Fat Mobilization", "Lipoprotein Classes & Cholesterol Transport"]);
const stray = [...fcNR, ...qcNR].filter((r) => !expected.has(nm.get(r.concept_id)));
console.log(`\nrows NOT on a lipid-split concept: ${stray.length}`);
console.log("\nroles: " + JSON.stringify([...fcNR, ...qcNR].reduce((a, r) => ((a[r.role] = (a[r.role] || 0) + 1), a), {})));
console.log("sources: " + JSON.stringify([...fcNR, ...qcNR].reduce((a, r) => ((a[r.source] = (a[r.source] || 0) + 1), a), {})));
console.log("\nLIVE DEFINITIONS");
for (const sl of ["ADIPOSE_FAT_MOBILIZATION", "LIPOPROTEIN_CLASSES_CHOLESTEROL_TRANSPORT"]) {
  const c = C.find((x) => x.slug === sl);
  console.log(`\n${c.canonical_name}  [${c.status}]`);
  console.log(`  ${c.description}`);
}
