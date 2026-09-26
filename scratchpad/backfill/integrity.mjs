import { all } from "./record.mjs";
import fs from "node:fs";
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const G=JSON.parse(fs.readFileSync("/tmp/backfill_gaps.json","utf8"));
const P=[];
const F=await all("flashcards","id,deck_id");
const FC=await all("flashcard_concepts","flashcard_id,concept_id,role");
const mappedLive=new Set(FC.map(r=>r.flashcard_id));
const unmapped=new Set(F.filter(f=>!mappedLive.has(f.id)).map(f=>f.id));
const C=await all("concepts","id,canonical_name,object_type,status");
const byId=new Map(C.map(c=>[c.id,c]));
const liveNames=new Set(C.map(c=>c.canonical_name));
// 1 no duplicate cards
const seen=new Set(); for(const r of A){ if(seen.has(r.card)) P.push(`card ${r.card} assigned twice`); seen.add(r.card); }
// 2 Every assigned card must be a real flashcard that is EITHER still unmapped
//   (pre-migration) or now mapped to exactly the concept this accumulator names
//   (post-migration). Checking only "unmapped" would flag the applied state as
//   broken; checking the target too makes the post-migration run meaningful.
const liveTarget=new Map(FC.filter(r=>r.role==="PRIMARY").map(r=>[r.flashcard_id,r.concept_id]));
const allIds=new Set(F.map(f=>f.id));
let notYet=0, done=0;
for(const r of A){
  if(!allIds.has(r.card)){P.push(`card ${r.card} does not exist`);continue;}
  if(unmapped.has(r.card)){notYet++;continue;}
  const t=liveTarget.get(r.card);
  if(!t){P.push(`card ${r.card} is mapped but carries no PRIMARY`);continue;}
  const nm=byId.get(t)?.canonical_name;
  if(nm!==r.name) P.push(`card ${r.card} is live on "${nm}", accumulator says "${r.name}"`);
  else done++;
}
// 3 held cards are disjoint from assigned and must STILL be unmapped, before and
//   after: the whole point is that they were never force-mapped.
const heldIds=new Set(G.flatMap(g=>g.cards||[]));
for(const id of heldIds){ if(seen.has(id)) P.push(`card ${id} both assigned and held`); if(!unmapped.has(id)) P.push(`held card ${id} got mapped anyway`); }
// 4 total accounted: assigned + held covers every card that was unmapped at design time
if(seen.size+heldIds.size!==2156) P.push(`accounted ${seen.size+heldIds.size} != 2156`);
// 5 existing targets resolve, are CONTENT-or-declared type, not deprecated
for(const r of A){
  if(r.isNew){ if(r.concept) P.push(`NEW "${r.name}" carries a concept id`); continue; }
  const c=byId.get(r.concept);
  if(!c){P.push(`unknown concept id on card ${r.card}`);continue;}
  if(c.canonical_name!==r.name) P.push(`name drift: ${r.name} vs ${c.canonical_name}`);
  if(c.status!=="ACTIVE_SEED") P.push(`target "${r.name}" status ${c.status}`);
  if(c.object_type!==r.type) P.push(`type drift on "${r.name}": ${r.type} vs ${c.object_type}`);
}
// 6 no new-concept name collides with another new-concept spelling difference
const newNames=[...new Set(A.filter(r=>r.isNew).map(r=>r.name))];
const norm=n=>n.toLowerCase().replace(/[^a-z0-9]/g,"");
const nm={}; newNames.forEach(n=>{const k=norm(n); if(nm[k]&&nm[k]!==n) P.push(`near-duplicate new names: "${nm[k]}" and "${n}"`); nm[k]=n;});
// 7 no new name near-duplicates an existing live name
const liveNorm=new Map(C.map(c=>[norm(c.canonical_name),c.canonical_name]));
// After the migration every new name is live by design, so a collision check
// against live names only means something before it runs.
if(notYet>0) newNames.forEach(n=>{ if(liveNorm.has(norm(n))) P.push(`new "${n}" collides with live "${liveNorm.get(norm(n))}"`); });
if(P.length){console.log("FAIL:");P.slice(0,20).forEach(p=>console.log("  "+p));console.log(`\n${P.length} problems`);process.exit(1);}
console.log(notYet===0 ? "INTEGRITY OK (migration APPLIED: every assignment verified against live rows)" : "INTEGRITY OK (pre-migration)");
console.log(`  assigned ${seen.size} | held ${heldIds.size} | live-unmapped ${unmapped.size} | verified live ${done} | awaiting ${notYet}`);
console.log(`  distinct new concepts ${newNames.length} | distinct existing targets ${new Set(A.filter(r=>!r.isNew).map(r=>r.concept)).size}`);
