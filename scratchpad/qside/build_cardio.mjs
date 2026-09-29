import { all } from "../backfill/record.mjs";
import { PROPOSED, ALIGN_APPROVED, CARD_GAPS, LABELS } from "../cardio/design.mjs";
import { OVERRIDES } from "./overrides_cardio.mjs";
import fs from "node:fs";
const C=await all("concepts","id,slug,canonical_name,status");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const byId=new Map(C.map(c=>[c.id,c]));
const Q=await all("questions","id,topic,subtopic,question_text");
const CV=Q.filter(q=>q.topic==="The Cardiovascular System");
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const cvIds=new Set(CV.map(q=>q.id));
const cur=new Map(QC.filter(r=>cvIds.has(r.question_id)&&r.role==="PRIMARY").map(r=>[r.question_id,r]));
const qOfLabel=new Map();
for(const [qid,r] of cur) qOfLabel.set(byId.get(r.concept_id).canonical_name,qid);

const exact=new Map(), related=new Map();
const claim=(m,l,c)=>{ if(!m.has(l)) m.set(l,[]); m.get(l).push(c); };
for(const p of PROPOSED) for(const [n,e] of p.q) claim(e?exact:related,n,p.name);
for(const a of ALIGN_APPROVED) for(const [n,e] of a.q) claim(e?exact:related,n,a.concept);
for(const g of CARD_GAPS) for(const n of g.questions) claim(exact,n,`QUESTION_ONLY:${g.objective}`);

const P=[], rows=[];
for(const [name,qid] of qOfLabel){
  const ex=[...new Set(exact.get(name)||[])], rel=[...new Set(related.get(name)||[])];
  let target=null, basis=null, conf="HIGH", why=null;
  if(OVERRIDES[name]){target=OVERRIDES[name].target;basis="read-the-question";conf=OVERRIDES[name].conf;why=OVERRIDES[name].why;}
  else if(ex.length===1){target=ex[0];basis="exact";}
  else if(ex.length>1) P.push(`"${name}" EXACT by ${ex.length}: ${ex.join(" | ")}`);
  else if(rel.length===1){target=rel[0];basis="related-only";}
  else if(rel.length>1) P.push(`"${name}" no exact, ${rel.length} related: ${rel.join(" | ")}`);
  else P.push(`"${name}" NO alignment`);
  if(target) rows.push({question:qid, oldConcept:cur.get(qid).concept_id, oldName:name,
    oldSlug:byId.get(cur.get(qid).concept_id).slug, newName:target, basis, conf, why,
    cls:Object.entries(LABELS).find(([,a])=>a.includes(name))?.[0]||"B"});
}
console.log(`cardio questions ${CV.length} | mapped ${cur.size} | labels ${qOfLabel.size}`);
console.log(`resolved ${rows.length} | ambiguous ${P.length}`);
const un=CV.filter(q=>!cur.has(q.id));
console.log(`unmapped questions: ${un.length}`);
un.forEach(q=>console.log(`  ${q.id}  "${q.subtopic}"\n    ${String(q.question_text).replace(/\s+/g," ").slice(0,190)}`));
if(P.length){console.log("\nAMBIGUOUS, need the question read:");P.forEach(x=>console.log("  "+x));}
const qo=rows.filter(r=>r.newName.startsWith("QUESTION_ONLY:"));
console.log(`\nrows heading to a question-only objective: ${qo.length}`);
const byCls={}; rows.forEach(r=>byCls[r.cls]=(byCls[r.cls]||0)+1);
console.log(`by class: ${JSON.stringify(byCls)} | by basis: ${JSON.stringify(rows.reduce((a,r)=>((a[r.basis]=(a[r.basis]||0)+1),a),{}))}`);
fs.writeFileSync("/tmp/cardio_qmap.json",JSON.stringify(rows,null,1));
