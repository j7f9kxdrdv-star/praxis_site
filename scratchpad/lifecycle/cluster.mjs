import { all } from "../backfill/record.mjs";
const C=await all("concepts","id,slug,canonical_name,parent_concept_id,concept_level");
const FC=await all("flashcard_concepts","flashcard_id,concept_id,role");
const F=await all("flashcards","id,deck_id,position,cloze_text,front_text");
const names=["Personality Disorder Clusters","Cluster A Personality Disorders","Cluster B Personality Disorders","Cluster C Personality Disorders"];
const cs=names.map(n=>C.find(c=>c.canonical_name===n));
for(const c of cs){
  console.log(`\n${c.canonical_name}  [level=${c.concept_level}] parent=${c.parent_concept_id?C.find(x=>x.id===c.parent_concept_id).canonical_name:"NONE"}`);
  FC.filter(r=>r.concept_id===c.id).forEach(r=>{
    const f=F.find(x=>x.id===r.flashcard_id);
    console.log(`   #${f.position} [${r.role}]  ${(f.cloze_text||f.front_text).replace(/\n/g," ").slice(0,95)}`);
  });
}
// overlap
const own=new Map(cs.map(c=>[c.canonical_name,new Set(FC.filter(r=>r.concept_id===c.id).map(r=>r.flashcard_id))]));
const um=own.get("Personality Disorder Clusters");
const kids=new Set([...own].filter(([k])=>k!=="Personality Disorder Clusters").flatMap(([,v])=>[...v]));
console.log(`\nUmbrella cards also on a child: ${[...um].filter(x=>kids.has(x)).length} of ${um.size}`);
