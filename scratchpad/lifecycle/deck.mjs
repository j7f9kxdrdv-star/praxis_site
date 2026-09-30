import { all } from "../backfill/record.mjs";
const D=await all("flashcard_decks","id,title,topic,subtopic");
const F=await all("flashcards","id,deck_id,position,cloze_text,front_text");
const FC=await all("flashcard_concepts","flashcard_id,concept_id");
const C=await all("concepts","id,canonical_name");
const nm=new Map(C.map(c=>[c.id,c.canonical_name]));
const map=new Map(); FC.forEach(r=>{ if(!map.has(r.flashcard_id)) map.set(r.flashcard_id,[]); map.get(r.flashcard_id).push(nm.get(r.concept_id)); });
const pat=new RegExp(process.argv.slice(2).join(" "),"i");
D.filter(d=>pat.test(d.title)).forEach(d=>{
  const cards=F.filter(f=>f.deck_id===d.id).sort((a,b)=>a.position-b.position);
  console.log(`\n### ${d.title}  (${cards.length} cards)  topic=${d.topic} subtopic=${d.subtopic}`);
  cards.forEach(f=>console.log(`  #${String(f.position).padStart(2)}  [${(map.get(f.id)||["UNMAPPED"]).join(" + ")}]  ${(f.cloze_text||f.front_text).replace(/\n/g," ").slice(0,78)}`));
});
