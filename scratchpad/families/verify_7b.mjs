import { all } from "../backfill/record.mjs";
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const C = await all("concepts", "id,slug,canonical_name,status");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const CS = await all("concept_sections", "concept_id");
const CD = await all("concept_disciplines", "concept_id");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status");
// Must select mapping_status, or every flashcard row reads undefined and the
// NEEDS_REVIEW tally silently counts only the question side. Same mistake as
// the migration 2 verification, which selected fewer columns than the snapshot.
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,mapping_status");
const Q = await all("questions", "id,content_category");
const pt = C.find((c) => c.slug === "PERIODIC_TRENDS");
const rows = CCC.filter((r) => r.concept_id === pt.id);
console.log("MIGRATION 7b VERIFICATION  " + new Date().toISOString() + "\n");
chk("Periodic Trends now carries 3 categories", rows.length === 3, String(rows.length));
rows.forEach((r) => console.log(`     ${r.is_primary ? "PRIMARY  " : "secondary"}  ${r.content_category}`));
chk("still exactly one primary", rows.filter((r) => r.is_primary).length === 1);
chk("the new row is the periodic-table classification category, secondary",
  rows.some((r) => !r.is_primary && r.content_category.startsWith("The Periodic Table: Classification")));
chk("its section and discipline rows are untouched",
  CS.filter((r) => r.concept_id === pt.id).length === 1 && CD.filter((r) => r.concept_id === pt.id).length === 1);

const cats = CCC.reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.content_category), a), {});
const qcat = new Map(Q.map((q) => [q.id, q.content_category]));
const bad = QC.filter((r) => !cats[r.concept_id]?.has(qcat.get(r.question_id)));
chk("ZERO question mappings unreachable by category, bank-wide", bad.length === 0, `${bad.length} of ${QC.length}`);

console.log("\nNOTHING ELSE MOVED");
chk("ontology objects still 1,137", C.length === 1137, String(C.length));
chk("question mappings still 2,694", QC.length === 2694, String(QC.length));
chk("flashcard mappings still 4,116", FC.length === 4116, String(FC.length));
chk("unmapped backlog still zero", Q.filter((q) => !new Set(QC.map((r) => r.question_id)).has(q.id)).length === 0);
chk("NEEDS_REVIEW still 29", [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 29,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
chk("total category rows rose by exactly one", CCC.length === 1091 + 5 + 1, String(CCC.length));
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
