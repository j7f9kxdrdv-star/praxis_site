import { all } from "../backfill/record.mjs";
import { DECISIONS } from "./lifecycle_cardio.mjs";
import { OVERRIDES } from "./overrides_cardio.mjs";
import { CARD_GAPS } from "../cardio/design.mjs";
import fs from "node:fs";
const rows=JSON.parse(fs.readFileSync("/tmp/cardio_qmap.json","utf8"));
const C=await all("concepts","id,slug,canonical_name,status");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const Q=await all("questions","id,topic,subtopic");
const CV=Q.filter(q=>q.topic==="The Cardiovascular System");
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const cvIds=new Set(CV.map(q=>q.id));
const cur=new Map(QC.filter(r=>cvIds.has(r.question_id)&&r.role==="PRIMARY").map(r=>[r.question_id,r]));
const P=[];
// the two new question-only concepts
const NEWC={"Oxygen delivery and extraction":"Oxygen Delivery and Extraction","Endothelial control of vascular tone":"Endothelial Control of Vascular Tone"};
for(const n of Object.values(NEWC)) if(byName.has(n)) P.push(`"${n}" already exists`);
const M={repoint:[],insert:[],newConcepts:[],lifecycle:[],secondary:[]};
for(const g of CARD_GAPS) M.newConcepts.push({name:NEWC[g.objective], questions:g.questions.length, why:g.why});
for(const r of rows){
  const c=cur.get(r.question);
  const isNew=r.newName.startsWith("QUESTION_ONLY:");
  const tName=isNew?NEWC[r.newName.slice(14)]:r.newName;
  const t=byName.get(tName);
  if(!isNew&&!t){P.push(`target "${tName}" not live`);continue;}
  if(c&&c.mapping_status==="HUMAN_VALIDATED") P.push(`${r.question} is HUMAN_VALIDATED`);
  const rec={question_id:r.question, old_concept_id:c?c.concept_id:null, old_label:r.oldName,
    new_label:tName, new_concept_id:t?t.id:null, new_is_new:isNew,
    classification:r.cls, basis:r.basis, confidence:r.conf||"HIGH",
    reason:r.why||`The question applies ${tName}; ${r.oldName} names the scenario it applies it in.`,
    old_provenance:c?`${c.mapping_status}/${c.source}`:null};
  (c?M.repoint:M.insert).push(rec);
}
// the unmapped question
const un=CV.find(q=>!cur.has(q.id));
if(un && !M.insert.some(r=>r.question_id===un.id)){
  const o=OVERRIDES[un.subtopic];
  M.insert.push({question_id:un.id, old_concept_id:null, old_label:null, new_label:o.target,
    new_concept_id:byName.get(o.target).id, new_is_new:false, classification:"UNMAPPED",
    basis:"read-the-question", confidence:o.conf, reason:o.why, old_provenance:null});
}
// lifecycle for all 99
for(const name of [...new Set(rows.map(r=>r.oldName))]){
  const r=rows.find(x=>x.oldName===name);
  const d=DECISIONS[name];
  const action=d?d.action:"MERGE_TO";
  const isNew=r.newName.startsWith("QUESTION_ONLY:");
  const succ=isNew?NEWC[r.newName.slice(14)]:r.newName;
  M.lifecycle.push({concept_id:byName.get(name).id, label:name, classification:r.cls, action,
    successor:action==="MERGE_TO"?succ:null,
    successor_id:action==="MERGE_TO"&&!isNew?byName.get(succ).id:null,
    successor_is_new:action==="MERGE_TO"&&isNew,
    why:d?d.why:`Class ${r.cls}: ${r.cls==="C"?"names an experimental operation rather than biology":r.cls==="D"?"a near-duplicate of another label testing the same idea":"a scenario-specific expression of the durable concept"}.`});
  if(action!=="MERGE_TO") M.secondary.push({question_id:r.question, concept_id:byName.get(name).id, label:name});
}
if(P.length){console.log("PROBLEMS:");P.forEach(x=>console.log("  "+x));process.exit(1);}
fs.writeFileSync("/tmp/cardio_manifest.json",JSON.stringify(M,null,1));
const act={}; M.lifecycle.forEach(l=>act[l.action]=(act[l.action]||0)+1);
console.log("CARDIO MANIFEST");
console.log(`  repoint ${M.repoint.length} | insert ${M.insert.length} | new concepts ${M.newConcepts.length} | secondary ${M.secondary.length}`);
console.log(`  lifecycle ${M.lifecycle.length} ${JSON.stringify(act)}`);
console.log(`  confidence ${JSON.stringify(M.repoint.concat(M.insert).reduce((a,r)=>((a[r.confidence]=(a[r.confidence]||0)+1),a),{}))}`);
console.log(`  question mappings 2666 -> ${2666+M.insert.length+M.secondary.length}`);
console.log(`  merging into a NEW concept: ${M.lifecycle.filter(l=>l.successor_is_new).length}`);
