import { all } from "./record.mjs";
import fs from "node:fs";
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const G=JSON.parse(fs.readFileSync("/tmp/backfill_gaps.json","utf8"));
const P=[];
const F=await all("flashcards","id,deck_id");
const FC=await all("flashcard_concepts","flashcard_id");
const mappedLive=new Set(FC.map(r=>r.flashcard_id));
const unmapped=new Set(F.filter(f=>!mappedLive.has(f.id)).map(f=>f.id));
const C=await all("concepts","id,canonical_name,object_type,status");
const byId=new Map(C.map(c=>[c.id,c]));
const liveNames=new Set(C.map(c=>c.canonical_name));
// 1 no duplicate cards
const seen=new Set(); for(const r of A){ if(seen.has(r.card)) P.push(`card ${r.card} assigned twice`); seen.add(r.card); }
// 2 every assigned card is a live-unmapped card
for(const r of A) if(!unmapped.has(r.card)) P.push(`card ${r.card} is not an unmapped flashcard`);
// 3 held cards disjoint from assigned, and also unmapped
const heldIds=new Set(G.flatMap(g=>g.cards||[]));
for(const id of heldIds){ if(seen.has(id)) P.push(`card ${id} both assigned and held`); if(!unmapped.has(id)) P.push(`held card ${id} is not unmapped`); }
// 4 total accounted
if(seen.size+heldIds.size!==unmapped.size) P.push(`accounted ${seen.size+heldIds.size} != unmapped ${unmapped.size}`);
// 5 existing targets resolve, are CONTENT-or-declared type, not deprecated
for(const r of A){
  if(r.isNew){ if(liveNames.has(r.name)) P.push(`NEW "${r.name}" already exists live`); if(r.concept) P.push(`NEW "${r.name}" carries a concept id`); continue; }
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
newNames.forEach(n=>{ if(liveNorm.has(norm(n))) P.push(`new "${n}" collides with live "${liveNorm.get(norm(n))}"`); });
if(P.length){console.log("FAIL:");P.slice(0,20).forEach(p=>console.log("  "+p));console.log(`\n${P.length} problems`);process.exit(1);}
console.log("INTEGRITY OK");
console.log(`  assigned ${seen.size} | held ${heldIds.size} | live-unmapped ${unmapped.size}`);
console.log(`  distinct new concepts ${newNames.length} | distinct existing targets ${new Set(A.filter(r=>!r.isNew).map(r=>r.concept)).size}`);
