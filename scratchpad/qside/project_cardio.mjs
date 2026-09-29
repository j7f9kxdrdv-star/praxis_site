import { all } from "../backfill/record.mjs";
import { PROPOSED } from "../cardio/design.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/cardio_manifest.json","utf8"));
const C=await all("concepts","id,canonical_name");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const QC=await all("question_concepts","question_id,concept_id,role");
const FC=await all("flashcard_concepts","concept_id");
const cards={}; FC.forEach(m=>cards[m.concept_id]=(cards[m.concept_id]||0)+1);
const qNow={}; QC.filter(m=>m.role==="PRIMARY").forEach(m=>qNow[m.concept_id]=(qNow[m.concept_id]||0)+1);
const qAfter={...qNow}, newQ={};
for(const r of M.repoint){ qAfter[r.old_concept_id]=(qAfter[r.old_concept_id]||0)-1;
  if(r.new_is_new) newQ[r.new_label]=(newQ[r.new_label]||0)+1; else qAfter[r.new_concept_id]=(qAfter[r.new_concept_id]||0)+1; }
for(const r of M.insert){ if(r.new_is_new) newQ[r.new_label]=(newQ[r.new_label]||0)+1; else qAfter[r.new_concept_id]=(qAfter[r.new_concept_id]||0)+1; }
const durable=[...PROPOSED.map(p=>p.name),"Heart Chambers and Valves","Blood Vessel Structure and Types","ABO and Rh Blood Types","The Lymphatic System","Thermoregulatory Mechanisms"];
const st=(q,f)=>q>0&&f>0?"BOTH_MODALITIES":q>0?"QUESTION_ONLY":f>0?"MEMORY_ONLY":"NO_ITEM_EVIDENCE";
console.log("| Durable concept | Qs before | Qs after | Cards | Modality |");
console.log("| --- | --- | --- | --- | --- |");
const t={};
durable.forEach(n=>{const c=byName.get(n); if(!c){console.log(`| ${n} | MISSING |`);return;}
  const s=st(qAfter[c.id]||0,cards[c.id]||0); t[s]=(t[s]||0)+1;
  console.log(`| \`${n}\` | ${qNow[c.id]||0} | ${qAfter[c.id]||0} | ${cards[c.id]||0} | ${s} |`);});
M.newConcepts.forEach(n=>{const s=st(newQ[n.name]||0,0); t[s]=(t[s]||0)+1;
  console.log(`| \`${n.name}\` (new) | 0 | ${newQ[n.name]||0} | 0 | ${s} |`);});
console.log(`\ntally: ${JSON.stringify(t)}`);
const merged=M.lifecycle.filter(l=>l.action==="MERGE_TO");
console.log(`merged labels retaining PRIMARY evidence (must be 0): ${merged.filter(l=>(qAfter[l.concept_id]||0)>0).length}`);
console.log(`merged labels holding flashcards (must be 0): ${merged.filter(l=>(cards[l.concept_id]||0)>0).length}`);
