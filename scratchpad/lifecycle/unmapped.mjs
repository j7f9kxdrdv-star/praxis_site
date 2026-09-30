import { all } from "../backfill/record.mjs";
const Q=await all("questions","id,section,topic,subtopic,discipline,content_category,question_text,explanation");
const QC=await all("question_concepts","question_id");
const m=new Set(QC.map(r=>r.question_id));
const u=Q.filter(q=>!m.has(q.id));
console.log(`${u.length} unmapped\n`);
const by={}; u.forEach(q=>by[q.topic]=(by[q.topic]||0)+1);
console.log(JSON.stringify(by)+"\n");
u.sort((a,b)=>String(a.subtopic).localeCompare(String(b.subtopic))).forEach((q,i)=>{
  console.log(`[${i+1}] ${q.subtopic}   (${q.section}/${q.content_category})`);
  console.log("    Q: "+q.question_text.replace(/\n/g," ").slice(0,300));
  console.log("    E: "+String(q.explanation||"").replace(/\n/g," ").slice(0,200)+"\n");
});
