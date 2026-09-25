// Records one batch of backfill assignments, validates it against the live
// ontology, and appends to the accumulator. Positions are 1-based within the
// deck's UNMAPPED cards, in position order.
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env=fs.readFileSync(".env.local","utf8");
const g=k=>(env.match(new RegExp("^"+k+"=(.*)$","m"))||[])[1]?.trim();
const db=createClient(g("NEXT_PUBLIC_SUPABASE_URL"),g("SUPABASE_SERVICE_ROLE_KEY"));
const sleep=ms=>new Promise(r=>setTimeout(r,ms));
async function page(t,c,f){for(let a=0;a<5;a++){try{const{data,error}=await db.from(t).select(c).range(f,f+999);
 if(error)throw new Error(error.message);return data;}catch(e){if(a===4)throw e;await sleep(400*(a+1));}}}
export async function all(t,c){let o=[],f=0;for(;;){const d=await page(t,c,f);o=o.concat(d);if(d.length<1000)break;f+=1000;}return o;}
export const R=(a,b)=>({a,b});
const ACC="/tmp/backfill_map.json", GAPS="/tmp/backfill_gaps.json";
export async function record(deckTitle, groups, gaps=[]){
  const C=await all("concepts","id,canonical_name,object_type,status");
  const D=await all("flashcard_decks","id,title"), F=await all("flashcards","id,deck_id,position");
  const FC=await all("flashcard_concepts","flashcard_id"); const mapped=new Set(FC.map(m=>m.flashcard_id));
  const d=D.find(x=>x.title===deckTitle); if(!d) throw new Error("no deck "+deckTitle);
  const cards=F.filter(f=>f.deck_id===d.id&&!mapped.has(f.id)).sort((a,b)=>a.position-b.position);
  const byName=new Map(C.map(c=>[c.canonical_name,c]));
  const out=[], problems=[], seen=new Set();
  for(const [name,ranges] of groups){
    // "NEW:" names an APPROVED concept that does not exist yet. It is checked
    // the opposite way round from the others: it must NOT already be in the
    // ontology, because a new concept whose name is already taken is a
    // duplicate waiting to happen. These carry concept:null until the
    // migration seeds them.
    const isNew = name.startsWith("NEW:");
    const bare = isNew ? name.slice(4) : name;
    const c = byName.get(bare);
    if(isNew){ if(c) problems.push(`"${bare}" is declared NEW but already exists in the ontology`); }
    else if(!c) problems.push(`unknown concept: ${name}`);
    else if(c.status==="DEPRECATED") problems.push(`deprecated target: ${name}`);
    for(const {a,b} of ranges) for(let i=a;i<=b;i++){
      if(!cards[i-1]){problems.push(`${deckTitle} pos ${i} does not exist`);continue;}
      if(seen.has(i)) problems.push(`${deckTitle} pos ${i} assigned twice`);
      seen.add(i);
      if(isNew) out.push({card:cards[i-1].id, concept:null, name:bare, type:"CONTENT", isNew:true, deck:deckTitle});
      else if(c) out.push({card:cards[i-1].id, concept:c.id, name:bare, type:c.object_type, deck:deckTitle});
    }
  }
  const gapPos=new Set(gaps.flatMap(x=>x.positions));
  for(let i=1;i<=cards.length;i++) if(!seen.has(i)&&!gapPos.has(i)) problems.push(`${deckTitle} pos ${i} UNASSIGNED`);
  for(const i of gapPos) if(seen.has(i)) problems.push(`${deckTitle} pos ${i} both assigned and flagged as a gap`);
  const acc=fs.existsSync(ACC)?JSON.parse(fs.readFileSync(ACC,"utf8")):[];
  const gl=fs.existsSync(GAPS)?JSON.parse(fs.readFileSync(GAPS,"utf8")):[];
  if(problems.length){console.log("PROBLEMS:");problems.slice(0,15).forEach(p=>console.log("  "+p));
    console.log(`\n${deckTitle}: NOT RECORDED`); process.exit(1);}
  const kept=acc.filter(r=>r.deck!==deckTitle).concat(out);
  fs.writeFileSync(ACC, JSON.stringify(kept,null,1));
  fs.writeFileSync(GAPS, JSON.stringify(gl.filter(x=>x.deck!==deckTitle).concat(
    gaps.map(x=>({...x, deck:deckTitle, cards:x.positions.map(i=>cards[i-1].id)}))),null,1));
  const byType=out.reduce((a,r)=>((a[r.type]=(a[r.type]||0)+1),a),{});
  const newCount=new Set(out.filter(r=>r.isNew).map(r=>r.name)).size;
  console.log(`${deckTitle}: ${out.length} assigned of ${cards.length} unmapped  ${JSON.stringify(byType)}`
    + (gapPos.size?`  | ${gapPos.size} held for review`:"")
    + (newCount?`  | ${newCount} approved new concept(s)`:"") + `  | accumulator now ${kept.length}`);
}
