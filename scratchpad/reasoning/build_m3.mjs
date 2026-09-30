// Builds the 24-row manifest from the MANUALLY REVIEWED classification, resolving
// each question by subtopic within its chapter. The 36-question ledger was a
// discovery mechanism; only what survived reading is used here.
import { all } from "../backfill/record.mjs";
import { CLASSIFICATION } from "./design.mjs";
import fs from "node:fs";
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const Q=await all("questions","id,topic,subtopic");
const CH=new Set(["The Immune System","The Cardiovascular System"]);
const bySub=new Map(Q.filter(q=>CH.has(q.topic)).map(q=>[String(q.subtopic),q]));
// HIGH and MEDIUM are the recorded judgements. The column is NUMERIC(3,2), so
// they need an encoding: 0.90 matches the precedent already used for
// AI_PROPOSED content mappings, and 0.60 marks the six rows where a defensible
// alternative was recorded in the manifest. Stated here so the numbers are not
// arbitrary decoration.
const CONF={HIGH:0.90, MEDIUM:0.60};
const P=[], rows=[];
for(const [sub,d] of Object.entries(CLASSIFICATION)){
  if(d.v==="NONE") continue;
  const target=d.v.startsWith("NEW:")?d.v.slice(4):d.v;
  const q=bySub.get(sub);
  const t=byName.get(target);
  if(!q){P.push(`no question with subtopic "${sub}"`);continue;}
  if(!t){P.push(`target "${target}" not live`);continue;}
  rows.push({question_id:q.id, subtopic:sub, chapter:q.topic,
    concept_id:t.id, target, slug:t.slug, confidence:CONF[d.c], judgement:d.c, note:d.n||null});
}
const noMap=Object.entries(CLASSIFICATION).filter(([,d])=>d.v==="NONE")
  .map(([sub])=>({subtopic:sub, question_id:bySub.get(sub)?.id}));
if(P.length){console.log("PROBLEMS:");P.forEach(x=>console.log("  "+x));process.exit(1);}
fs.writeFileSync("/tmp/m3_manifest.json",JSON.stringify({rows,noMap},null,1));
const per={}; rows.forEach(r=>per[r.target]=(per[r.target]||0)+1);
console.log(`mappings: ${rows.length}`);
Object.entries(per).sort((a,b)=>b[1]-a[1]).forEach(([k,v])=>console.log(`  ${String(v).padStart(2)}  ${k}`));
const cf={}; rows.forEach(r=>cf[r.judgement]=(cf[r.judgement]||0)+1);
console.log(`judgement: ${JSON.stringify(cf)}  ->  confidence ${JSON.stringify(rows.reduce((a,r)=>((a[r.confidence]=(a[r.confidence]||0)+1),a),{}))}`);
console.log(`explicitly NOT mapped: ${noMap.length} (all resolved: ${noMap.every(n=>n.question_id)})`);
console.log(`distinct questions: ${new Set(rows.map(r=>r.question_id)).size} | distinct pairs: ${new Set(rows.map(r=>r.question_id+"|"+r.concept_id)).size}`);
