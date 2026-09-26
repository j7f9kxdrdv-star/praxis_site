// Promotes an APPROVED gap candidate out of gaps.json and into the assignment
// accumulator as a NEW: concept (concept:null until the migration seeds it).
// Same guards as record(): the name must NOT already exist in the ontology, the
// cards must not already be assigned, and they must still be unmapped live.
import { all } from "./record.mjs";
import fs from "node:fs";
const ACC="/tmp/backfill_map.json", GAPS="/tmp/backfill_gaps.json";
const names=process.argv.slice(2);
if(!names.length){console.log("usage: approve.mjs <canonical name> ...");process.exit(1);}
const C=await all("concepts","id,canonical_name");
const live=new Set(C.map(c=>c.canonical_name));
const FC=await all("flashcard_concepts","flashcard_id");
const mappedLive=new Set(FC.map(r=>r.flashcard_id));
let acc=JSON.parse(fs.readFileSync(ACC,"utf8"));
let gaps=JSON.parse(fs.readFileSync(GAPS,"utf8"));
const assigned=new Set(acc.map(r=>r.card));
const problems=[];
const added=[];
for(const n of names){
  if(live.has(n)) problems.push(`"${n}" already exists in the ontology, cannot be NEW`);
  const entries=gaps.filter(g=>g.name===n);
  if(!entries.length){problems.push(`no gap entry named "${n}"`);continue;}
  for(const e of entries){
    for(const card of e.cards){
      if(assigned.has(card)) problems.push(`${n}: card ${card} is already assigned`);
      if(mappedLive.has(card)) problems.push(`${n}: card ${card} is already mapped in the database`);
      added.push({card, concept:null, name:n, type:"CONTENT", isNew:true, deck:e.deck});
      assigned.add(card);
    }
  }
}
if(problems.length){console.log("PROBLEMS:");problems.forEach(p=>console.log("  "+p));console.log("\nNOT RECORDED");process.exit(1);}
acc=acc.concat(added);
gaps=gaps.filter(g=>!names.includes(g.name));
fs.writeFileSync(ACC,JSON.stringify(acc,null,1));
fs.writeFileSync(GAPS,JSON.stringify(gaps,null,1));
const per={}; added.forEach(r=>per[r.name]=(per[r.name]||0)+1);
Object.entries(per).forEach(([k,v])=>console.log(`  promoted ${String(v).padStart(2)} cards -> NEW: ${k}`));
let heldNow=0; gaps.forEach(g=>heldNow+=(g.cards||[]).length);
console.log(`\naccumulator now ${acc.length} assigned | ${heldNow} still held | ${acc.length+heldNow} total`);
