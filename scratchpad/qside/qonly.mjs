import { all } from "../backfill/record.mjs";
import { CARD_GAPS } from "../cardio/design.mjs";
const Q=await all("questions","id,topic,subtopic,question_text,cognitive_skill,content_category");
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const QC=await all("question_concepts","concept_id,role");
const FC=await all("flashcard_concepts","concept_id");
const q={},f={}; QC.filter(r=>r.role==="PRIMARY").forEach(r=>q[r.concept_id]=(q[r.concept_id]||0)+1); FC.forEach(r=>f[r.concept_id]=(f[r.concept_id]||0)+1);
for(const g of CARD_GAPS){
  console.log(`\n${"=".repeat(70)}\n${g.objective.toUpperCase()}  (${g.questions.length} questions)\n`);
  g.questions.forEach(n=>{const x=Q.find(y=>y.subtopic===n&&y.topic==="The Cardiovascular System");
    console.log(`  [skill ${x.cognitive_skill}] ${n}`);
    console.log(`     ${String(x.question_text).replace(/\s+/g," ").slice(0,175)}`);});
  // could anything existing absorb it?
  const kw=g.objective.toLowerCase().split(/\s+/).filter(w=>w.length>4);
  const cand=C.filter(c=>c.status==="ACTIVE_SEED"&&kw.some(k=>c.canonical_name.toLowerCase().includes(k.slice(0,6))));
  console.log(`\n  existing ACTIVE concepts matching "${kw.join(" / ")}":`);
  cand.slice(0,10).forEach(c=>console.log(`     q=${String(q[c.id]||0).padStart(2)} cards=${String(f[c.id]||0).padStart(2)}  ${c.canonical_name}`));
  if(!cand.length) console.log("     (none)");
}
