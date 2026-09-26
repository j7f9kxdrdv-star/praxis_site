// Derives a per-QUESTION durable target from the approved immune design, against
// live state. Each label carries exactly one question, so label -> question is
// 1:1 and the label's exact owner is that question's durable PRIMARY.
import { all } from "../backfill/record.mjs";
import { PROPOSED, KEEP_EXISTING, LABELS } from "../immune/design.mjs";
import { OVERRIDES } from "./overrides.mjs";
import fs from "node:fs";
const C=await all("concepts","id,slug,canonical_name,object_type,status");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const Q=await all("questions","id,topic,subtopic,question_text");
const IM=Q.filter(q=>q.topic==="The Immune System");
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const byId=new Map(C.map(c=>[c.id,c]));
const imIds=new Set(IM.map(q=>q.id));
const cur=new Map(QC.filter(r=>imIds.has(r.question_id)).map(r=>[r.question_id,r]));
const labelOfQ=new Map(); // question -> label concept
for(const [qid,r] of cur) labelOfQ.set(qid,byId.get(r.concept_id));
const qOfLabel=new Map(); // label name -> question
for(const [qid,c] of labelOfQ) qOfLabel.set(c.canonical_name,qid);

// exact / related claims from the design
const exact=new Map(), related=new Map();
const claim=(m,label,concept)=>{ if(!m.has(label)) m.set(label,[]); m.get(label).push(concept); };
for(const p of PROPOSED) for(const [n,e] of p.q) claim(e?exact:related,n,p.name);
// the one label that belongs to an existing concept
claim(exact,"Defence Against an Extracellular Bacterial Product","Immunoglobulins");

const P=[];
const rows=[];
for(const [name,qid] of qOfLabel){
  const ex=exact.get(name)||[], rel=related.get(name)||[];
  let target=null, basis=null, conf="HIGH", why=null;
  if(OVERRIDES[name]){ target=OVERRIDES[name].target; basis="read-the-question"; conf=OVERRIDES[name].conf; why=OVERRIDES[name].why; }
  else if(ex.length===1){ target=ex[0]; basis="exact"; }
  else if(ex.length>1){ P.push(`"${name}" claimed EXACT by ${ex.length}: ${ex.join(" | ")}`); }
  else if(rel.length===1){ target=rel[0]; basis="related-only"; }
  else if(rel.length>1){ P.push(`"${name}" has no exact owner and ${rel.length} related: ${rel.join(" | ")}`); }
  else P.push(`"${name}" has no alignment at all`);
  if(target){
    const t=byName.get(target);
    if(!t) P.push(`target "${target}" not live`);
    rows.push({question:qid, oldConcept:labelOfQ.get(qid).id, oldName:name, oldSlug:labelOfQ.get(qid).slug,
      newName:target, newConcept:t?.id, newSlug:t?.slug, basis, conf, why,
      cls:Object.entries(LABELS).find(([,arr])=>arr.includes(name))?.[0]||"B"});
  }
}
console.log(`immune questions: ${IM.length} | currently mapped: ${cur.size} | labels: ${qOfLabel.size}`);
console.log(`rows resolved: ${rows.length}`);
const unmapped=IM.filter(q=>!cur.has(q.id));
console.log(`unmapped questions: ${unmapped.length}`);
unmapped.forEach(q=>console.log(`  ${q.id}\n    subtopic: ${q.subtopic}\n    ${String(q.question_text).replace(/\s+/g," ").slice(0,200)}`));
if(P.length){console.log("\nAMBIGUITIES TO RESOLVE:");P.forEach(x=>console.log("  "+x));}
const byCls={}; rows.forEach(r=>byCls[r.cls]=(byCls[r.cls]||0)+1);
console.log(`\nby class: ${JSON.stringify(byCls)}`);
const byBasis={}; rows.forEach(r=>byBasis[r.basis]=(byBasis[r.basis]||0)+1);
console.log(`by basis: ${JSON.stringify(byBasis)}`);
const perTarget={}; rows.forEach(r=>perTarget[r.newName]=(perTarget[r.newName]||0)+1);
console.log(`\nquestions per durable concept:`);
Object.entries(perTarget).sort((a,b)=>b[1]-a[1]).forEach(([k,v])=>console.log(`  ${String(v).padStart(2)}  ${k}`));
fs.writeFileSync("/tmp/immune_qmap.json",JSON.stringify(rows,null,1));
