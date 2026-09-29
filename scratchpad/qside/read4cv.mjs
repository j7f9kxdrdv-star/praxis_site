import { all } from "../backfill/record.mjs";
const Q=await all("questions","id,topic,subtopic,question_text,options,correct_answer,cognitive_skill");
const want=["Murmur Timing And Valve Lesions","Peritubular Capillary Conditions","Leukocyte Exit From The Microcirculation","Confinement of Clotting to the Injury Site"];
Q.filter(q=>q.topic==="The Cardiovascular System"&&want.includes(String(q.subtopic))).forEach(q=>{
  console.log(`\n=== ${q.subtopic}  [skill ${q.cognitive_skill}] ===`);
  console.log(String(q.question_text).replace(/\s+/g," ").trim().slice(0,700));
  const o=typeof q.options==="string"?JSON.parse(q.options):q.options;
  if(Array.isArray(o)) o.forEach((x,i)=>console.log(`   ${"ABCD"[i]}. ${String(typeof x==="string"?x:x.text||"").replace(/\s+/g," ").slice(0,160)}`));
  console.log(`   correct: ${q.correct_answer}`);
});
