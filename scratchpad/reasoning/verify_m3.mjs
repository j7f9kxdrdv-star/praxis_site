import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const {rows,noMap}=JSON.parse(fs.readFileSync("/tmp/m3_manifest.json","utf8"));
const P=[]; const chk=(n,pass,d="")=>{console.log(`  ${pass?"ok  ":"FAIL"}  ${n}${d?"   "+d:""}`);if(!pass)P.push(n);};
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const byId=new Map(C.map(c=>[c.id,c]));
const QRO=await all("question_reasoning_objects","question_id,concept_id,confidence,mapping_status,source");
const QC=await all("question_concepts","question_id,concept_id");
const FC=await all("flashcard_concepts","flashcard_id");
const CS=await all("concept_sections","concept_id");
const CD=await all("concept_disciplines","concept_id");
const CCC=await all("concept_content_categories","concept_id");
const n=s=>QRO.filter(r=>byId.get(r.concept_id)?.slug===s).length;
console.log("MIGRATION 3 LIVE VERIFICATION");
chk("1  rows", QRO.length===24, String(QRO.length));
chk("2  Variables and Controls", n("RO_VARIABLES_AND_CONTROLS")===14, String(n("RO_VARIABLES_AND_CONTROLS")));
chk("3  Data Interpretation", n("RO_DATA_INTERPRETATION")===9, String(n("RO_DATA_INTERPRETATION")));
chk("4  Causal Inference", n("RO_CAUSAL_INFERENCE")===1, String(n("RO_CAUSAL_INFERENCE")));
chk("5  all AI_PROPOSED in both fields",
  QRO.every(r=>r.mapping_status==="AI_PROPOSED"&&r.source==="AI_PROPOSED"),
  JSON.stringify(QRO.reduce((a,r)=>((a[`${r.mapping_status}/${r.source}`]=(a[`${r.mapping_status}/${r.source}`]||0)+1),a),{})));
const cf={}; QRO.forEach(r=>cf[Number(r.confidence).toFixed(2)]=(cf[Number(r.confidence).toFixed(2)]||0)+1);
chk("6  confidence distribution", cf["0.90"]===21&&cf["0.60"]===3, JSON.stringify(cf));
const mapped=[...new Set(QRO.map(r=>r.concept_id))];
chk("7  every mapped REASONING object has a definition",
  mapped.every(id=>String(byId.get(id).description||"").trim()));
chk("8  no CONTENT or QUANTITATIVE target",
  mapped.every(id=>byId.get(id).object_type==="REASONING"),
  mapped.map(id=>byId.get(id).object_type).join(","));
chk("   no target deprecated", mapped.every(id=>byId.get(id).status==="ACTIVE_SEED"));
chk("   no mapped object carries taxonomy",
  !mapped.some(id=>CS.some(r=>r.concept_id===id)||CD.some(r=>r.concept_id===id)||CCC.some(r=>r.concept_id===id)));
chk("9  question_concepts unchanged", QC.length===2673, String(QC.length));
chk("10 flashcard_concepts unchanged", FC.length===4115, String(FC.length));
chk("11 ontology objects unchanged at 1,130", C.length===1130, String(C.length));
// every approved pair present, and only those
const want=new Set(rows.map(r=>r.question_id+"|"+r.concept_id));
const got=new Set(QRO.map(r=>r.question_id+"|"+r.concept_id));
chk("   all 24 approved pairs present", [...want].every(k=>got.has(k)));
chk("   no unapproved pair present", [...got].every(k=>want.has(k)));
chk("   the 12 no-mapping questions received nothing",
  !noMap.some(x=>QRO.some(r=>r.question_id===x.question_id)));
chk("   no duplicate pair", got.size===QRO.length);
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nALL LIVE CHECKS PASS");
