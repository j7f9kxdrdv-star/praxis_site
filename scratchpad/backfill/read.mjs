import { all } from "./record.mjs";
const D=await all("flashcard_decks","id,title"), F=await all("flashcards","id,deck_id,position,cloze_text,front_text,back_text");
const FC=await all("flashcard_concepts","flashcard_id"); const mapped=new Set(FC.map(m=>m.flashcard_id));
for(const t of process.argv.slice(2)){
  const d=D.find(x=>x.title===t);
  const cards=F.filter(f=>f.deck_id===d.id&&!mapped.has(f.id)).sort((a,b)=>a.position-b.position);
  console.log(`\n===== ${d.title} (${cards.length}) =====`);
  cards.forEach((c,i)=>console.log(`${i+1}. ${String(c.cloze_text||[c.front_text,c.back_text].filter(Boolean).join(" >> ")).replace(/\s+/g," ").trim()}`));
}
