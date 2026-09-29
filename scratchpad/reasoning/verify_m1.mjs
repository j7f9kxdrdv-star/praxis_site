// Independent live verification of migration 1. Drives the guards from outside
// the migration, because a probe that lives inside the thing it tests only
// proves the migration was internally consistent.
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env=fs.readFileSync(".env.local","utf8");
const g=k=>(env.match(new RegExp("^"+k+"=(.*)$","m"))||[])[1]?.trim();
const db=createClient(g("NEXT_PUBLIC_SUPABASE_URL"),g("SUPABASE_SERVICE_ROLE_KEY"));
const { all } = await import("../backfill/record.mjs");
const P=[];
const chk=(n,pass,d="")=>{console.log(`  ${pass?"ok  ":"FAIL"}  ${n}${d?"   "+d:""}`);if(!pass)P.push(n);};

const C=await all("concepts","id,slug,object_type,status");
const Q=await all("questions","id");
const qid=Q[0].id;
const cont=C.find(c=>c.object_type==="CONTENT"&&c.status==="ACTIVE_SEED");
const quant=C.find(c=>c.object_type==="QUANTITATIVE");
const reas=C.find(c=>c.object_type==="REASONING");
const dep=C.find(c=>c.status==="DEPRECATED");

const rows=await all("question_reasoning_objects","question_id,concept_id");
chk("table exists and is empty", rows.length===0, `${rows.length} rows`);

const tryIns=async(concept_id,extra={})=>{
  const {error}=await db.from("question_reasoning_objects")
    .insert({question_id:qid,concept_id,source:"AI_PROPOSED",...extra});
  return error;
};
chk("a CONTENT concept is refused", !!(await tryIns(cont.id)));
chk("a QUANTITATIVE concept is refused", !!(await tryIns(quant.id)));
chk("a DEPRECATED reasoning-or-other object is refused", !!(await tryIns(dep.id)));
chk("confidence 4.00 is refused", !!(await tryIns(reas.id,{confidence:4.0})));

// the accept case, then cleaned up
const e1=await tryIns(reas.id);
chk("a REASONING concept is ACCEPTED", !e1, e1?e1.message.slice(0,60):"");
if(!e1){
  const {error:e2}=await db.from("question_reasoning_objects")
    .update({mapping_status:"HUMAN_VALIDATED",source:"HUMAN_REVIEWED"})
    .eq("question_id",qid).eq("concept_id",reas.id);
  chk("a row can be marked HUMAN_VALIDATED", !e2);
  const {error:e3}=await db.from("question_reasoning_objects")
    .update({source:"AI_PROPOSED"}).eq("question_id",qid).eq("concept_id",reas.id);
  chk("an automated overwrite of HUMAN_VALIDATED is refused", !!e3);
  const {error:e4}=await db.from("question_reasoning_objects")
    .delete().eq("question_id",qid).eq("concept_id",reas.id);
  chk("deleting a HUMAN_VALIDATED row is refused", !!e4);
  // clean up: only a HUMAN_REVIEWED write may amend, so revert then delete
  await db.from("question_reasoning_objects")
    .update({mapping_status:"AI_PROPOSED",source:"HUMAN_REVIEWED"})
    .eq("question_id",qid).eq("concept_id",reas.id);
  const {error:e5}=await db.from("question_reasoning_objects")
    .delete().eq("question_id",qid).eq("concept_id",reas.id);
  chk("the probe row is removable once it is no longer HUMAN_VALIDATED", !e5, e5?e5.message.slice(0,60):"");
}
const after=await all("question_reasoning_objects","question_id");
chk("table empty again, no residue", after.length===0, `${after.length} rows`);
const qc=await all("question_concepts","question_id");
const fc=await all("flashcard_concepts","flashcard_id");
chk("question_concepts untouched", qc.length===2673, String(qc.length));
chk("flashcard_concepts untouched", fc.length===4115, String(fc.length));
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nMIGRATION 1 VERIFIED LIVE");
