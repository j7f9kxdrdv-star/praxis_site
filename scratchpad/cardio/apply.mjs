// Retargets accumulated assignments off the cardio question-instance labels and
// onto the approved curriculum concepts. Surgical rather than per-deck, because
// the affected cards live in five different decks and record() replaces a deck
// wholesale. Validation already ran in validate.mjs; this repeats the guards
// that matter before writing.
import { all } from "../backfill/record.mjs";
import { PROPOSED, REUSE } from "./design.mjs";
import fs from "node:fs";
const ACC="/tmp/backfill_map.json";
const C=await all("concepts","id,canonical_name,object_type");
const live=new Map(C.map(c=>[c.canonical_name,c]));
const D=await all("flashcard_decks","id,title");
const F=await all("flashcards","id,deck_id,position");
const FC=await all("flashcard_concepts","flashcard_id"); const mapped=new Set(FC.map(m=>m.flashcard_id));
const key=new Map();
for(const d of D){ const cards=F.filter(f=>f.deck_id===d.id&&!mapped.has(f.id)).sort((a,b)=>a.position-b.position);
  cards.forEach((c,i)=>key.set(`${d.title}|${i+1}`,c.id)); }
let A=JSON.parse(fs.readFileSync(ACC,"utf8"));
const idx=new Map(A.map((r,i)=>[r.card,i]));
const problems=[], moved=[];
const retarget=(name,pairs)=>{
  const ex=live.get(name);
  for(const [deck,pos] of pairs){
    const id=key.get(`${deck}|${pos}`);
    if(!id){problems.push(`${deck}|${pos} unresolved`);continue;}
    const i=idx.get(id); if(i===undefined){problems.push(`${deck}|${pos} not in accumulator`);continue;}
    const from=A[i].name;
    A[i] = ex
      ? {card:id, concept:ex.id, name, type:ex.object_type, deck}
      : {card:id, concept:null, name, type:"CONTENT", isNew:true, deck};
    moved.push({from,to:name,deck});
  }
};
for(const p of PROPOSED){ if(live.has(p.name)) problems.push(`"${p.name}" already exists`); retarget(p.name,p.cards); }
for(const r of REUSE) retarget(r.concept,r.cards);
if(problems.length){console.log("PROBLEMS:");problems.forEach(p=>console.log("  "+p));console.log("\nNOT APPLIED");process.exit(1);}
fs.writeFileSync(ACC,JSON.stringify(A,null,1));
const per={}; moved.forEach(m=>per[m.to]=(per[m.to]||0)+1);
Object.entries(per).forEach(([k,v])=>console.log(`  ${String(v).padStart(2)} cards -> ${k}`));
const fromDecks={}; moved.forEach(m=>fromDecks[m.deck]=(fromDecks[m.deck]||0)+1);
console.log(`\nretargeted ${moved.length} cards across ${Object.keys(fromDecks).length} decks: ${JSON.stringify(fromDecks)}`);
const newNames=new Set(A.filter(r=>r.isNew).map(r=>r.name));
console.log(`accumulator: ${A.length} assigned | distinct new concepts pending: ${newNames.size}`);
