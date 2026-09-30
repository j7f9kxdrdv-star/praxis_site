import { all } from "../backfill/record.mjs";
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const FC=await all("flashcard_concepts","flashcard_id,concept_id");
const QC=await all("question_concepts","question_id,concept_id");
const QRO=await all("question_reasoning_objects","question_id,concept_id");
for(const t of ["REASONING","QUANTITATIVE"]){
  const set=C.filter(c=>c.object_type===t&&c.status!=="DEPRECATED");
  console.log(`\n===== ${t} (${set.length}) =====`);
  set.sort((a,b)=>a.slug.localeCompare(b.slug)).forEach(c=>{
    const f=FC.filter(r=>r.concept_id===c.id).length;
    const q=QC.filter(r=>r.concept_id===c.id).length;
    const r=QRO.filter(x=>x.concept_id===c.id).length;
    console.log(`${c.slug}\n   name: ${c.canonical_name}   cards=${f} qc=${q} reasoning=${r}\n   def: ${c.description||"(EMPTY)"}`);
  });
}
