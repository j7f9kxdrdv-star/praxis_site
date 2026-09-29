import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/cardio_manifest.json","utf8"));
const P=[], note=[];
const C=await all("concepts","id,slug,canonical_name,status,object_type,deprecated_by");
const byId=new Map(C.map(c=>[c.id,c])), byName=new Map(C.map(c=>[c.canonical_name,c]));
const liveSlug=new Set(C.map(c=>c.slug));
const Q=await all("questions","id,topic,subtopic,question_text,content_category");
const CV=Q.filter(q=>q.topic==="The Cardiovascular System");
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const cvIds=new Set(CV.map(q=>q.id));
const cvPrim=QC.filter(r=>cvIds.has(r.question_id)&&r.role==="PRIMARY");
const CCC=await all("concept_content_categories","concept_id,content_category");
const cats={}; CCC.forEach(r=>(cats[r.concept_id]=cats[r.concept_id]||new Set()).add(r.content_category));
const NEW=[["OXYGEN_DELIVERY_EXTRACTION","Oxygen Delivery and Extraction"],["ENDOTHELIAL_CONTROL_VASCULAR_TONE","Endothelial Control of Vascular Tone"]];
const chk=(n,a,e)=>{const ok=a===e;console.log(`  ${ok?"ok  ":"FAIL"}  ${n}: ${a}${ok?"":` (expected ${e})`}`);if(!ok)P.push(n);};

console.log("PRE-APPLICATION ASSERTIONS");
chk("1  cardiovascular questions",CV.length,100);
chk("2  legacy labels",new Set(cvPrim.map(r=>r.concept_id)).size,99);
chk("3  PRIMARY repoints",M.repoint.length,99);
chk("4  previously unmapped insertions",M.insert.length,1);
chk("5  SECONDARY mappings",M.secondary.length,6);
chk("6  labels to deprecate",M.lifecycle.filter(l=>l.action==="MERGE_TO").length,93);
chk("7  retained sub-objectives",M.lifecycle.filter(l=>l.action!=="MERGE_TO").length,6);
chk("8  new CONTENT concepts",M.newConcepts.length,2);
// 9 successors
const noSucc=M.lifecycle.filter(l=>l.action==="MERGE_TO"&&!l.successor);
chk("9  deprecations lacking a successor",noSucc.length,0);
const danglingSucc=M.lifecycle.filter(l=>l.action==="MERGE_TO"&&!l.successor_is_new&&!byName.has(l.successor));
chk("10 dangling successor references",danglingSucc.length,0);
// 11 one PRIMARY per question after
const after={}; 
QC.filter(r=>r.role==="PRIMARY").forEach(r=>after[r.question_id]=(after[r.question_id]||0)+1);
M.insert.forEach(r=>after[r.question_id]=(after[r.question_id]||0)+1);
chk("11 questions with >1 PRIMARY after",Object.values(after).filter(n=>n>1).length,0);
// 12 CONTENT-only targets
const badType=M.repoint.concat(M.insert).filter(r=>r.new_concept_id&&byId.get(r.new_concept_id)?.object_type!=="CONTENT");
chk("12 non-CONTENT targets",badType.length,0);
// 13 no deprecated target
const depTarget=M.repoint.concat(M.insert).filter(r=>r.new_concept_id&&byId.get(r.new_concept_id)?.status==="DEPRECATED");
chk("13 deprecated targets",depTarget.length,0);
// 14 name / slug collisions for the new concepts
chk("14 new-concept name collisions",NEW.filter(([,n])=>byName.has(n)).length,0);
chk("15 new-concept slug collisions",NEW.filter(([s])=>liveSlug.has(s)).length,0);
// 16 taxonomy compatibility for every repoint target
const qById=new Map(Q.map(q=>[q.id,q]));
const incompat=M.repoint.concat(M.insert).filter(r=>{
  if(!r.new_concept_id) return false;  // new concepts get Organ Systems by construction
  return !cats[r.new_concept_id]?.has(qById.get(r.question_id)?.content_category);});
chk("16 taxonomy-incompatible targets",incompat.length,0);
if(incompat.length) incompat.slice(0,5).forEach(r=>console.log(`       ${r.old_label} -> ${r.new_label}`));
// 17 every repoint's old mapping still matches what the manifest recorded
const curr=new Map(cvPrim.map(r=>[r.question_id,r.concept_id]));
const drift=M.repoint.filter(r=>curr.get(r.question_id)!==r.old_concept_id);
chk("17 questions that drifted since the design",drift.length,0);
// 18 no HUMAN_VALIDATED
chk("18 HUMAN_VALIDATED mappings in scope",cvPrim.filter(r=>r.mapping_status==="HUMAN_VALIDATED").length,0);
// 19 the previously unmapped question, verified from its text
const un=CV.find(q=>!curr.has(q.id));
const ins=M.insert[0];
console.log(`\n  previously unmapped: "${un.subtopic}"`);
console.log(`     -> ${ins.new_label}`);
console.log(`     stem: ${String(un.question_text).replace(/\s+/g," ").slice(0,150)}`);
chk("19 insertion targets the unmapped question",ins.question_id,un.id);
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nALL ASSERTIONS PASS");
if(P.length) process.exit(1);
