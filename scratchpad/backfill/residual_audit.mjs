// Point 12: after Immune and Cardiovascular, which accumulated mappings still
// target a concept with exactly one mapped question, and is that concept
// actually weak? One question alone is NOT the test. A concept passes if its
// name is curriculum-level and it could be reused by another card or question.
import { all } from "./record.mjs";
import fs from "node:fs";
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const C=await all("concepts","id,canonical_name,description");
const byId=new Map(C.map(c=>[c.id,c]));
const QC=await all("question_concepts","question_id,concept_id");
const Q=await all("questions","id,topic,subtopic");
const qById=new Map(Q.map(q=>[q.id,q]));
const subtopics=new Set(Q.map(q=>String(q.subtopic)));
const qOf={}; QC.forEach(r=>(qOf[r.concept_id]=qOf[r.concept_id]||[]).push(r.question_id));
const targets={}; A.forEach(r=>{if(r.concept)(targets[r.concept]=targets[r.concept]||[]).push(r);});
const rows=[];
for(const [cid,rs] of Object.entries(targets)){
  const qs=qOf[cid]||[]; if(qs.length!==1) continue;
  const c=byId.get(cid);
  const q=qById.get(qs[0]);
  rows.push({name:c.canonical_name, cards:rs.length, decks:[...new Set(rs.map(r=>r.deck))],
    chapter:q.topic, nameIsSubtopic:subtopics.has(c.canonical_name), hasDesc:!!String(c.description||"").trim()});
}
rows.sort((a,b)=>b.cards-a.cards);
console.log(`accumulated mappings still on a 1-question concept: ${rows.reduce((s,r)=>s+r.cards,0)} cards on ${rows.length} concepts\n`);
console.log("cards | name==subtopic | chapter of its one question | concept");
rows.forEach(r=>console.log(`${String(r.cards).padStart(4)}  | ${r.nameIsSubtopic?"YES":"no "} | ${r.chapter} | ${r.name}`));
const susp=rows.filter(r=>r.nameIsSubtopic);
console.log(`\nSUSPICIOUS (name copied verbatim from its one question's subtopic): ${susp.length} concepts, ${susp.reduce((s,r)=>s+r.cards,0)} cards`);
const ok=rows.filter(r=>!r.nameIsSubtopic);
console.log(`PASSES (curriculum-level name, thin evidence only): ${ok.length} concepts, ${ok.reduce((s,r)=>s+r.cards,0)} cards`);
