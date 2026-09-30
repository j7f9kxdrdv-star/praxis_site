import { all } from "../backfill/record.mjs";
const F=await all("flashcards","id,deck_id,position,cloze_text,front_text,back_text,card_type");
const FC=await all("flashcard_concepts","flashcard_id");
const D=await all("flashcard_decks","id,title");
const m=new Set(FC.map(r=>r.flashcard_id));
const u=F.filter(f=>!m.has(f.id));
console.log(`${u.length} unmapped flashcards of ${F.length}\n`);
u.forEach(f=>{
  console.log(`### ${D.find(d=>d.id===f.deck_id)?.title} #${f.position}  [${f.card_type}]  id=${f.id}`);
  console.log((f.cloze_text||`FRONT: ${f.front_text}\nBACK: ${f.back_text}`)+"\n");
});
