// Re-read the five questions from live state, in full, with their answer and
// explanation, so the destination is decided from what each one tests rather
// than from the earlier audit or from a concept name.
import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const Q = await all("questions", "id,subtopic,question_text,options,correct_answer,explanation");
const A = await all("concept_aliases", "concept_id,alias,alias_type,status");
const a = C.find((c) => c.slug === "OXIDATION_REDUCING_SUGARS");
const b = C.find((c) => c.slug === "REDUCING_NON_REDUCING_SUGARS");
for (const [tag, c] of [["CONCEPT A", a], ["CONCEPT B", b]]) {
  console.log(`\n######## ${tag}: ${c.canonical_name}`);
  console.log(`id ${c.id}  slug ${c.slug}  status ${c.status}  version ${c.version}`);
  console.log(`definition: ${c.description || "(EMPTY)"}`);
  console.log(`aliases: ${A.filter((r) => r.concept_id === c.id).map((r) => r.alias + " [" + r.alias_type + "]").join(" | ") || "none"}`);
  const qs = QC.filter((r) => r.concept_id === c.id);
  console.log(`question mappings: ${qs.length}`);
  qs.forEach((m, i) => {
    const q = Q.find((x) => x.id === m.question_id);
    const opts = Array.isArray(q.options) ? q.options : JSON.parse(q.options || "[]");
    console.log(`\n  --- [${tag.slice(-1)}${i + 1}] ${q.id}`);
    console.log(`      role=${m.role} status=${m.mapping_status} source=${m.source} conf=${m.confidence}`);
    console.log(`      subtopic: ${q.subtopic}`);
    console.log(`      Q: ${q.question_text.replace(/\n/g, " ")}`);
    opts.forEach((o, j) => console.log(`         ${"ABCD"[j]}. ${String(typeof o === "string" ? o : o.text ?? JSON.stringify(o)).replace(/\n/g, " ").slice(0, 150)}`));
    console.log(`      correct: ${q.correct_answer}`);
    console.log(`      why: ${String(q.explanation || "").replace(/\n/g, " ").slice(0, 400)}`);
  });
}
