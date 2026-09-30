// Does the build-time write-scope guard actually see this new migration?
import fs from "node:fs";
const f="supabase/migrations/20260930_vector_slug_convention.sql";
const sql=fs.readFileSync(f,"utf8");
const ONT=["concepts","concept_aliases","concept_sections","concept_disciplines","concept_content_categories","question_concepts","question_reasoning_objects","flashcard_concepts"];
const LEARNER=["flashcard_reviews","flashcard_user_state","question_attempts","practice_sessions","learner_events","learner_state_snapshots","performance_reports","daily_activity"];
const executable=s=>s.replace(/\/\*[\s\S]*?\*\//g," ").split("\n").map(l=>{const i=l.indexOf("--");return i===-1?l:l.slice(0,i);}).join("\n");
const body=executable(sql);
const isOnt=ONT.some(t=>new RegExp(`\\b(INSERT\\s+INTO|UPDATE|DELETE\\s+FROM)\\s+(public\\.)?${t}\\b`,"i").test(body));
console.log("classified as an ontology migration: "+isOnt);
const hits=[];
for(const t of LEARNER) for(const v of ["INSERT\\s+INTO","UPDATE","DELETE\\s+FROM","TRUNCATE"]){
  const m=body.match(new RegExp(`\\b${v}\\s+(?:ONLY\\s+)?(?:public\\.)?${t}\\b`,"gi"));
  if(m) hits.push(t+": "+m.join(","));
}
console.log("learner-table writes found: "+(hits.join(" | ")||"none"));
const verbs=body.match(/\b(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE|ALTER\s+TABLE|DROP)\s+\S+/gi)||[];
console.log("\nevery write verb in the file:");
[...new Set(verbs.map(v=>v.replace(/\s+/g," ")))].forEach(v=>console.log("   "+v));
