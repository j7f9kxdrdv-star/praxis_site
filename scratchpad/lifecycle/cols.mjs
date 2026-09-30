import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env=fs.readFileSync(".env.local","utf8");
const g=k=>(env.match(new RegExp("^"+k+"=(.*)$","m"))||[])[1]?.trim();
const db=createClient(g("NEXT_PUBLIC_SUPABASE_URL"),g("SUPABASE_SERVICE_ROLE_KEY"));
for(const t of ["flashcards","questions","concepts","concept_aliases","flashcard_decks","content_categories","concept_content_categories"]){
  const {data,error}=await db.from(t).select("*").limit(1);
  console.log(t+":\n   "+(error?error.message:Object.keys(data[0]||{}).join(", ")));
}
for(const t of ["concept_sections","concept_disciplines","question_concepts","flashcard_concepts"]){
  const {data,error}=await db.from(t).select("*").limit(1);
  console.log(t+":\n   "+(error?error.message:Object.keys(data[0]||{}).join(", ")));
}
