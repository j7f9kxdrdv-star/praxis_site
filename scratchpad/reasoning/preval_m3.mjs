import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const {rows,noMap}=JSON.parse(fs.readFileSync("/tmp/m3_manifest.json","utf8"));
const P=[]; const chk=(n,pass,d="")=>{console.log(`  ${pass?"ok  ":"FAIL"}  ${n}${d?"   "+d:""}`);if(!pass)P.push(n);};
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const byId=new Map(C.map(c=>[c.id,c]));
const Q=await all("questions","id");
const qIds=new Set(Q.map(q=>q.id));
const CS=await all("concept_sections","concept_id");
const CD=await all("concept_disciplines","concept_id");
const CCC=await all("concept_content_categories","concept_id");
const QRO=await all("question_reasoning_objects","question_id,concept_id,mapping_status");
const targets=[...new Set(rows.map(r=>r.concept_id))];

chk("exactly 24 question ids", new Set(rows.map(r=>r.question_id)).size===24, String(new Set(rows.map(r=>r.question_id)).size));
chk("exactly 24 question/object pairs", rows.length===24 && new Set(rows.map(r=>r.question_id+"|"+r.concept_id)).size===24);
chk("all question ids exist", rows.every(r=>qIds.has(r.question_id)));
chk("all target objects exist", targets.every(id=>byId.has(id)));
chk("all targets ACTIVE_SEED", targets.every(id=>byId.get(id).status==="ACTIVE_SEED"));
chk("all targets object_type REASONING", targets.every(id=>byId.get(id).object_type==="REASONING"),
  targets.map(id=>byId.get(id).object_type).join(","));
chk("all targets have a non-empty definition", targets.every(id=>String(byId.get(id).description||"").trim()));
chk("no target carries section taxonomy", !targets.some(id=>CS.some(r=>r.concept_id===id)));
chk("no target carries discipline taxonomy", !targets.some(id=>CD.some(r=>r.concept_id===id)));
chk("no target carries AAMC category taxonomy", !targets.some(id=>CCC.some(r=>r.concept_id===id)));
chk("no duplicate pair in the manifest", new Set(rows.map(r=>r.question_id+"|"+r.concept_id)).size===rows.length);
const existing=new Set(QRO.map(r=>r.question_id+"|"+r.concept_id));
chk("none of the 24 already exists", !rows.some(r=>existing.has(r.question_id+"|"+r.concept_id)), `table has ${QRO.length} rows`);
chk("no HUMAN_VALIDATED conflict", !QRO.some(r=>r.mapping_status==="HUMAN_VALIDATED"));
const per={}; rows.forEach(r=>per[r.target]=(per[r.target]||0)+1);
chk("Variables and Controls = 14", per["Variables and Controls"]===14, String(per["Variables and Controls"]));
chk("Data Interpretation = 9", per["Data Interpretation"]===9, String(per["Data Interpretation"]));
chk("Causal Inference = 1", per["Causal Inference"]===1, String(per["Causal Inference"]));
chk("the 12 NO_REASONING questions are not in the manifest",
  !noMap.some(n=>rows.some(r=>r.question_id===n.question_id)));
chk("confidence within the column domain", rows.every(r=>r.confidence>=0&&r.confidence<=1));
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nMIGRATION 3 PRE-VALIDATION CLEAN");
if(P.length) process.exit(1);
