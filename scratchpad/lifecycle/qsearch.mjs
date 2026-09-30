import { all } from "../backfill/record.mjs";
const Q=await all("questions","id,subtopic,question_text");
const QC=await all("question_concepts","question_id,concept_id");
const C=await all("concepts","id,canonical_name");
const nm=new Map(C.map(c=>[c.id,c.canonical_name]));
const pat=new RegExp(process.argv.slice(2).join(" "),"i");
Q.filter(q=>pat.test(q.question_text)).slice(0,8).forEach(q=>{
  const cs=QC.filter(r=>r.question_id===q.id).map(r=>nm.get(r.concept_id));
  console.log(`[${cs.join("+")||"UNMAPPED"}] ${q.subtopic}\n   ${q.question_text.replace(/\n/g," ").slice(0,150)}`);
});
