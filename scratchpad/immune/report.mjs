import { all } from "../backfill/record.mjs";
import { PROPOSED, KEEP_EXISTING, LABELS } from "./design.mjs";
const C=await all("concepts","id,canonical_name");
const byId=new Map(C.map(c=>[c.id,c]));
const Q=await all("questions","id,topic");
const imQ=new Set(Q.filter(q=>q.topic==="The Immune System").map(q=>q.id));
const QC=await all("question_concepts","question_id,concept_id");
const labelNames=[...new Set(QC.filter(r=>imQ.has(r.question_id)).map(r=>byId.get(r.concept_id).canonical_name))];
const cls={}; for(const [k,arr] of Object.entries(LABELS)) arr.forEach(n=>cls[n]=k);
labelNames.forEach(n=>cls[n]=cls[n]||"B");
const ACTION={A:"KEEP_CURRENT + ADD_SHARED_CONCEPT_MAPPING",B:"ADD_SHARED_CONCEPT_MAPPING, then DEPRECATE_SCENARIO_CONCEPT_LATER",
 C:"ADD_SHARED_CONCEPT_MAPPING (content) + reasoning object later, then DEPRECATE_SCENARIO_CONCEPT_LATER",D:"MIGRATE_TO_SHARED_CONCEPT (merge the near-duplicates)"};
// which proposed concept each label aligns to (exact preferred)
const target={};
for(const p of PROPOSED) for(const [n,e] of p.q){ if(!target[n]||(e&&!target[n].e)) target[n]={name:p.name,e}; }
console.log("== TABLE 1: proposed concepts ==");
console.log("| Proposed concept | Cards | Exact q | Related q | Confidence |");
console.log("| --- | --- | --- | --- | --- |");
PROPOSED.forEach(p=>console.log(`| \`${p.name}\` | ${p.cards.length} | ${p.q.filter(([,e])=>e).length} | ${p.q.filter(([,e])=>!e).length} | ${p.conf} |`));
console.log(`\ntotals: ${PROPOSED.length} concepts, ${PROPOSED.reduce((s,p)=>s+p.cards.length,0)} cards, ${PROPOSED.reduce((s,p)=>s+p.q.filter(([,e])=>e).length,0)} exact alignments`);
const c2={}; labelNames.forEach(n=>c2[cls[n]]=(c2[cls[n]]||0)+1);
console.log("\n== TABLE 2: classification of the 89 labels ==");
console.log("| Class | Meaning | Count | Eventual action |");
console.log("| --- | --- | --- | --- |");
const MEAN={A:"Legitimate reusable curriculum concept",B:"Scenario expression of a broader concept",C:"Reasoning or experimental construct",D:"Duplicate or near-duplicate"};
["A","B","C","D"].forEach(k=>console.log(`| ${k} | ${MEAN[k]} | ${c2[k]||0} | ${ACTION[k]} |`));
console.log("\n== TABLE 3: full label ledger ==");
console.log("| Existing label | Class | Shared concept it should join | Alignment |");
console.log("| --- | --- | --- | --- |");
labelNames.sort().forEach(n=>{const t=target[n];
  console.log(`| ${n} | ${cls[n]} | ${t?"`"+t.name+"`":"`Immunoglobulins` (existing)"} | ${t?(t.e?"exact":"related"):"exact"} |`);});
console.log("\n== dual-modality projection ==");
console.log(`proposed concepts that gain BOTH modalities on reconciliation: ${PROPOSED.filter(p=>p.q.some(([,e])=>e)).length} of ${PROPOSED.length}`);
console.log(`proposed concepts that would stay MEMORY_ONLY: ${PROPOSED.filter(p=>!p.q.some(([,e])=>e)).length}`);
