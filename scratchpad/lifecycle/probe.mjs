// Dumps everything attached to one concept: definition, taxonomy, aliases,
// every flashcard, every question. Named on the command line.
import { all } from "../backfill/record.mjs";
const NAMES = process.argv.slice(2);
const C=await all("concepts","id,slug,canonical_name,description,object_type,status,content_category,concept_level,parent_concept_id,deprecated_by,topic_id");
const FC=await all("flashcard_concepts","flashcard_id,concept_id");
const QC=await all("question_concepts","question_id,concept_id,role");
const F=await all("flashcards","id,deck_id,front_text,back_text,cloze_text,explanation,position");
const Q=await all("questions","id,section,subtopic,topic,content_category,discipline,question_text,explanation");
const D=await all("flashcard_decks","id,title");
const A=await all("concept_aliases","concept_id,alias,alias_type,status");
const CS=await all("concept_sections","concept_id,section_code,is_primary");
const CD=await all("concept_disciplines","concept_id,discipline_code,role");
const CCC=await all("concept_content_categories","concept_id,content_category,is_primary");
const deck=new Map(D.map(d=>[d.id,d.title]));
for(const nm of NAMES){
  const c=C.find(x=>x.canonical_name===nm || x.slug===nm);
  if(!c){ console.log("### NOT FOUND: "+nm+"\n"); continue; }
  console.log("################ "+c.canonical_name);
  console.log("slug: "+c.slug+"   type: "+c.object_type+"   status: "+c.status+"   level: "+c.concept_level);
  console.log("parent: "+(c.parent_concept_id?C.find(x=>x.id===c.parent_concept_id)?.canonical_name:"none")+"   deprecated_by: "+(c.deprecated_by||"none"));
  console.log("content_category(col): "+c.content_category);
  console.log("definition: "+(c.description||"(EMPTY)"));
  console.log("sections: "+CS.filter(r=>r.concept_id===c.id).map(r=>r.section_code+(r.is_primary?"*":"")).join(", "));
  console.log("disciplines: "+CD.filter(r=>r.concept_id===c.id).map(r=>r.discipline_code+"["+r.role+"]").join(", "));
  console.log("categories: "+CCC.filter(r=>r.concept_id===c.id).map(r=>r.content_category+(r.is_primary?"*":"")).join(", "));
  console.log("aliases: "+(A.filter(r=>r.concept_id===c.id).map(r=>`${r.alias} [${r.alias_type}/${r.status}]`).join(" | ")||"none"));
  const cards=FC.filter(r=>r.concept_id===c.id).map(r=>F.find(f=>f.id===r.flashcard_id)).filter(Boolean)
    .sort((a,b)=>(deck.get(a.deck_id)||"").localeCompare(deck.get(b.deck_id)||"")||a.position-b.position);
  console.log("\n--- FLASHCARDS ("+cards.length+") ---");
  cards.forEach((f,i)=>{
    console.log(`[${i+1}] ${deck.get(f.deck_id)} #${f.position}`);
    console.log("    "+(f.cloze_text||`${f.front_text}  ==>  ${f.back_text}`).replace(/\n/g," "));
  });
  const qs=QC.filter(r=>r.concept_id===c.id).map(r=>({...Q.find(q=>q.id===r.question_id),role:r.role})).filter(x=>x.id);
  console.log("\n--- QUESTIONS ("+qs.length+") ---");
  qs.forEach((q,i)=>{
    console.log(`[${i+1}] ${q.role}  ${q.section} / ${q.topic} / ${q.subtopic}   cat=${q.content_category} disc=${q.discipline}`);
    console.log("    "+String(q.question_text).replace(/\n/g," ").slice(0,340));
  });
  console.log("\n");
}
