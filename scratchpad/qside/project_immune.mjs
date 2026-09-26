import { all } from "../backfill/record.mjs";
import { PROPOSED, KEEP_EXISTING } from "../immune/design.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/immune_manifest.json","utf8"));
const C=await all("concepts","id,slug,canonical_name");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const FC=await all("flashcard_concepts","flashcard_id,concept_id");
const QC=await all("question_concepts","question_id,concept_id,role");
const cards={}; FC.forEach(r=>cards[r.concept_id]=(cards[r.concept_id]||0)+1);
const qNow={}; QC.filter(r=>r.role==="PRIMARY").forEach(r=>qNow[r.concept_id]=(qNow[r.concept_id]||0)+1);
const qAfter={...qNow};
for(const r of M.repoint){ qAfter[r.old_concept_id]=(qAfter[r.old_concept_id]||0)-1; qAfter[r.new_concept_id]=(qAfter[r.new_concept_id]||0)+1; }
for(const r of M.insert) qAfter[r.new_concept_id]=(qAfter[r.new_concept_id]||0)+1;
const durable=[...PROPOSED.map(p=>p.name), ...KEEP_EXISTING.map(k=>k.concept)];
const state=(q,f)=> q>0&&f>0 ? "BOTH_MODALITIES" : q>0 ? "QUESTION_ONLY" : f>0 ? "MEMORY_ONLY" : "NO_ITEM_EVIDENCE";
console.log("| Durable concept | Questions before | Questions after | Flashcards | Modality after |");
console.log("| --- | --- | --- | --- | --- |");
const tally={};
for(const n of durable){ const c=byName.get(n); const qb=qNow[c.id]||0, qa=qAfter[c.id]||0, f=cards[c.id]||0;
  const s=state(qa,f); tally[s]=(tally[s]||0)+1;
  console.log(`| \`${n}\` | ${qb} | ${qa} | ${f} | ${s} |`);}
console.log(`\nprojected: ${JSON.stringify(tally)}`);
// old labels after
const lab=M.lifecycle.map(l=>({...l, qAfter:qAfter[l.concept_id]||0, cards:cards[l.concept_id]||0}));
const merged=lab.filter(l=>l.action==="MERGE_TO");
const retained=lab.filter(l=>l.action!=="MERGE_TO");
console.log(`\nmerged labels with residual PRIMARY evidence (must be 0): ${merged.filter(l=>l.qAfter>0).length}`);
console.log(`merged labels with flashcards (must be 0): ${merged.filter(l=>l.cards>0).length}`);
console.log(`retained sub-objectives, PRIMARY after (0 each) / SECONDARY held: ${retained.map(l=>l.qAfter).join(",")} / ${M.secondary.length}`);
retained.forEach(l=>console.log(`   RETAIN  ${l.label}`));
