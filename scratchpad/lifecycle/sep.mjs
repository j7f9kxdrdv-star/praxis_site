import { all } from "../backfill/record.mjs";
const Q=await all("questions","id,section,topic,subtopic,discipline,content_category,question_text");
for(const cat of ["Separation and Purification Methods (BC)","Separations and Purifications"]){
  const qs=Q.filter(q=>q.content_category===cat);
  console.log(`\n### ${cat}  (${qs.length} questions)`);
  const by={}; qs.forEach(q=>{const k=`${q.section} / ${q.discipline} / ${q.topic}`; by[k]=(by[k]||0)+1;});
  Object.entries(by).sort((a,b)=>b[1]-a[1]).forEach(([k,v])=>console.log(`   ${String(v).padStart(3)}  ${k}`));
  if(qs.length<=6) qs.forEach(q=>console.log(`      - ${q.subtopic}: ${q.question_text.replace(/\n/g," ").slice(0,110)}`));
}
console.log("\n### Organ-systems pair, same detector");
for(const cat of ["Structure and integrative functions of the main organ systems","Organ Systems"]){
  const qs=Q.filter(q=>q.content_category===cat);
  const by={}; qs.forEach(q=>{const k=`${q.section} / ${q.discipline}`; by[k]=(by[k]||0)+1;});
  console.log(`   ${cat}: ${qs.length} qs  ${JSON.stringify(by)}`);
}
