import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env=fs.readFileSync(".env.local","utf8");
const g=k=>(env.match(new RegExp("^"+k+"=(.*)$","m"))||[])[1]?.trim();
const db=createClient(g("NEXT_PUBLIC_SUPABASE_URL"),g("SUPABASE_SERVICE_ROLE_KEY"));
const { all } = await import("../backfill/record.mjs");
const QC=await all("question_concepts","question_id,concept_id,role");
const per={}; QC.forEach(r=>per[r.question_id]=(per[r.question_id]||0)+1);
console.log("questions with >1 concept mapping:",Object.values(per).filter(n=>n>1).length);
console.log("max mappings on one question:",Math.max(...Object.values(per)));
// try inserting a SECOND concept on an existing question, then roll it back by deleting
const Q=await all("questions","id,topic");
const q=Q.find(x=>x.topic==="The Immune System");
const C=await all("concepts","id,slug");
const a=C.find(c=>c.slug==="INNATE_ADAPTIVE_IMMUNITY"), b=C.find(c=>c.slug==="VACCINATION");
const existing=QC.find(r=>r.question_id===q.id);
console.log(`\nprobe question ${q.id} currently -> ${existing?.concept_id}`);
const ins=await db.from("question_concepts").insert({question_id:q.id,concept_id:a.id,role:"SECONDARY",mapping_status:"AI_PROPOSED",source:"AI_PROPOSED"});
console.log("insert SECONDARY role:", ins.error? "REFUSED: "+ins.error.message.slice(0,120) : "ACCEPTED");
if(!ins.error){ await db.from("question_concepts").delete().eq("question_id",q.id).eq("concept_id",a.id); console.log("  (probe row removed)"); }
const ins2=await db.from("question_concepts").insert({question_id:q.id,concept_id:b.id,role:"PRIMARY",mapping_status:"AI_PROPOSED",source:"AI_PROPOSED"});
console.log("insert 2nd PRIMARY:", ins2.error? "REFUSED: "+ins2.error.message.slice(0,120) : "ACCEPTED");
if(!ins2.error){ await db.from("question_concepts").delete().eq("question_id",q.id).eq("concept_id",b.id); console.log("  (probe row removed)"); }
const after=await all("question_concepts","question_id");
console.log(`\nquestion_concepts count after probe: ${after.length} (must be 2659)`);
