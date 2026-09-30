import { all } from "../backfill/record.mjs";
const pat=new RegExp(process.argv.slice(2).join(" "),"i");
const C=await all("concepts","id,slug,canonical_name,object_type,status,description");
const FC=await all("flashcard_concepts","concept_id");
const QC=await all("question_concepts","concept_id");
const nf=id=>FC.filter(r=>r.concept_id===id).length, nq=id=>QC.filter(r=>r.concept_id===id).length;
C.filter(c=>pat.test(c.canonical_name)||pat.test(c.slug)).forEach(c=>
  console.log(`${c.status==="DEPRECATED"?"[DEP] ":""}${c.canonical_name}\n      slug=${c.slug} type=${c.object_type} cards=${nf(c.id)} qs=${nq(c.id)} def=${c.description?"yes":"EMPTY"}`));
