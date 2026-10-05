import { all } from "../backfill/record.mjs";
const Q = await all("questions", "id,topic,subtopic,question_text,options,correct_answer,explanation");
const QC = await all("question_concepts", "question_id");
const mapped = new Set(QC.map((r) => r.question_id));
const u = Q.filter((q) => !mapped.has(q.id)).sort((a, b) => a.id.localeCompare(b.id));
console.log(`${u.length} unmapped questions\n`);
u.forEach((q, i) => {
  console.log(`[${i + 1}] ${q.id}   topic=${q.topic} / subtopic=${q.subtopic}`);
  console.log(`    Q: ${q.question_text.replace(/\n/g, " ").slice(0, 300)}`);
  console.log(`    correct ${q.correct_answer}  |  why: ${String(q.explanation || "").replace(/\n/g, " ").replace(/^This is a General Chemistry question (that falls under|in) the content category[^.]*\.\s*/, "").slice(0, 230)}\n`);
});
