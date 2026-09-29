import { all } from "../backfill/record.mjs";
const C=await all("concepts","id,slug,canonical_name,description,object_type,status,split_candidate");
const QC=await all("question_concepts","concept_id");
const FC=await all("flashcard_concepts","concept_id,flashcard_id");
const CS=await all("concept_sections","concept_id");
const CD=await all("concept_disciplines","concept_id");
const CCC=await all("concept_content_categories","concept_id");
const F=await all("flashcards","id,deck_id");
const D=await all("flashcard_decks","id,title,section");
const dt=new Map(D.map(d=>[d.id,d]));
const fd=new Map(F.map(f=>[f.id,f.deck_id]));
const q={},f={}; QC.forEach(r=>q[r.concept_id]=(q[r.concept_id]||0)+1); FC.forEach(r=>f[r.concept_id]=(f[r.concept_id]||0)+1);
const tax=new Set([...CS.map(r=>r.concept_id),...CD.map(r=>r.concept_id),...CCC.map(r=>r.concept_id)]);
for(const t of ["REASONING","QUANTITATIVE"]){
  const objs=C.filter(c=>c.object_type===t);
  console.log(`\n${"=".repeat(72)}\n${t}  (${objs.length} objects)\n`);
  objs.forEach(c=>{
    const decks=[...new Set(FC.filter(r=>r.concept_id===c.id).map(r=>dt.get(fd.get(r.flashcard_id))?.title))].filter(Boolean);
    console.log(`${c.slug}`);
    console.log(`   name      ${c.canonical_name}`);
    console.log(`   desc      ${String(c.description||"(none)").replace(/\s+/g," ").slice(0,120)}`);
    console.log(`   questions ${q[c.id]||0}   flashcards ${f[c.id]||0}   taxonomy ${tax.has(c.id)?"*** HAS TAXONOMY ***":"none (correct)"}`);
    if(decks.length) console.log(`   decks     ${decks.slice(0,3).join(" | ")}`);
  });
}
console.log(`\n${"=".repeat(72)}`);
console.log(`REASONING with zero questions: ${C.filter(c=>c.object_type==="REASONING"&&!q[c.id]).length} of ${C.filter(c=>c.object_type==="REASONING").length}`);
console.log(`QUANTITATIVE with zero questions: ${C.filter(c=>c.object_type==="QUANTITATIVE"&&!q[c.id]).length} of ${C.filter(c=>c.object_type==="QUANTITATIVE").length}`);
console.log(`non-CONTENT objects carrying taxonomy (must be 0): ${C.filter(c=>c.object_type!=="CONTENT"&&tax.has(c.id)).length}`);
