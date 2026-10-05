import { all } from "../backfill/record.mjs";
const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const Q = await all("questions", "id,subtopic,question_text,options,correct_answer,explanation");
const toe = C.find((c) => c.slug === "TYPES_ELEMENTS");
console.log(`${toe.canonical_name}  ${toe.id}  v${toe.version}  def=${toe.description || "(EMPTY)"}\n`);
QC.filter((r) => r.concept_id === toe.id).forEach((m, i) => {
  const q = Q.find((x) => x.id === m.question_id);
  const opts = Array.isArray(q.options) ? q.options : JSON.parse(q.options || "[]");
  console.log(`[Q${i + 1}] ${q.id}   ${m.role}/${m.mapping_status}/${m.source}`);
  console.log(`   Q: ${q.question_text.replace(/\n/g, " ").slice(0, 260)}`);
  console.log(`   correct ${q.correct_answer}: ${String(opts[["A","B","C","D"].indexOf(q.correct_answer)] ?? "").replace(/\n/g," ").slice(0,160)}`);
  console.log(`   why: ${String(q.explanation || "").replace(/\n/g, " ").slice(0, 160)}\n`);
});
