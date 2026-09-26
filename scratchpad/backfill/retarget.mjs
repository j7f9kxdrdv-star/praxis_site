// Retargets named cards to a named concept. Guards: the target must exist live
// (or already be a pending new concept in the accumulator), the card must be in
// the accumulator, and the caller must state the target it expects to replace so
// a stale instruction cannot silently move the wrong card.
import { all } from "./record.mjs";
import fs from "node:fs";
const ACC="/tmp/backfill_map.json";
// [deck, position, expected current target, new target]
const MOVES = [
 ["The Cardiovascular System",42,"Local Control of Blood Flow and Thermoregulation","Thermoregulatory Mechanisms"],
 ["The Respiratory System",57,"Layered Surface Defences and Response Timing","Respiratory Immune Defense"],
 ["The Respiratory System",58,"Layered Surface Defences and Response Timing","Respiratory Immune Defense"],
 ["The Respiratory System",59,"Layered Surface Defences and Response Timing","Hypersensitivity and Allergy"],
 ["The Respiratory System",60,"Layered Surface Defences and Response Timing","Respiratory Immune Defense"],
 ["Homeostasis",61,"Skin as a Physical Barrier","Skin Structure and Barrier Function"],
];
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
const pendingNew=new Set(A.filter(r=>r.isNew).map(r=>r.name));
const problems=[], done=[];
for(const [deck,pos,expect,to] of MOVES){
  const id=key.get(`${deck}|${pos}`);
  if(!id){problems.push(`${deck}|${pos} unresolved`);continue;}
  const i=idx.get(id);
  if(i===undefined){problems.push(`${deck}|${pos} not in accumulator`);continue;}
  if(A[i].name!==expect){problems.push(`${deck}|${pos} is on "${A[i].name}", expected "${expect}"`);continue;}
  const ex=live.get(to);
  if(!ex&&!pendingNew.has(to)){problems.push(`target "${to}" is neither live nor a pending new concept`);continue;}
  if(ex&&ex.object_type!=="CONTENT"){problems.push(`target "${to}" is ${ex.object_type}, not CONTENT`);continue;}
  A[i]= ex ? {card:id,concept:ex.id,name:to,type:"CONTENT",deck}
           : {card:id,concept:null,name:to,type:"CONTENT",isNew:true,deck};
  done.push(`${deck} p${pos}: ${expect} -> ${to}`);
}
if(problems.length){console.log("PROBLEMS:");problems.forEach(p=>console.log("  "+p));console.log("\nNOT APPLIED");process.exit(1);}
fs.writeFileSync(ACC,JSON.stringify(A,null,1));
done.forEach(d=>console.log("  "+d));
console.log(`\n${done.length} cards retargeted | accumulator ${A.length} assigned | ${new Set(A.filter(r=>r.isNew).map(r=>r.name)).size} new concepts pending`);
