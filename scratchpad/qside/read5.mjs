import { all } from "../backfill/record.mjs";
const Q=await all("questions","id,topic,subtopic,question_text,options,correct_answer");
const want=["Adoptive Transfer and Causal Necessity","Culture Arm Testing Matched Versus Generic Help",
 "Control Arms for a Specificity Claim","Localising a Block Upstream of Lymphocytes","Random Repertoire and the Need for Tolerance"];
Q.filter(q=>q.topic==="The Immune System"&&want.includes(String(q.subtopic))).forEach(q=>{
  console.log(`\n=== ${q.subtopic} ===`);
  console.log(String(q.question_text).replace(/\s+/g," ").trim());
  const o=typeof q.options==="string"?JSON.parse(q.options):q.options;
  if(Array.isArray(o)) o.forEach((x,i)=>console.log(`   ${"ABCD"[i]}. ${String(typeof x==="string"?x:x.text||JSON.stringify(x)).replace(/\s+/g," ").slice(0,150)}`));
  console.log(`   correct: ${q.correct_answer}`);
});
