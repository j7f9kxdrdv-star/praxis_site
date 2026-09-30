import { all } from "../backfill/record.mjs";
const P=[]; const chk=(n,pass,d="")=>{console.log(`  ${pass?"ok  ":"FAIL"}  ${n}${d?"   "+d:""}`);if(!pass)P.push(n);};
const C=await all("concepts","id,slug,canonical_name,description,object_type,status,deprecated_by");
const di=C.find(c=>c.slug==="RO_DATA_INTERPRETATION");
const rma=C.find(c=>c.slug==="RO_REACTION_MECHANISM_ANALYSIS");
const CS=await all("concept_sections","concept_id");
const CD=await all("concept_disciplines","concept_id");
const CCC=await all("concept_content_categories","concept_id");
const QC=await all("question_concepts","question_id,concept_id");
const FC=await all("flashcard_concepts","flashcard_id");
const QRO=await all("question_reasoning_objects","question_id,concept_id");
console.log("MIGRATION 2 LIVE VERIFICATION");
chk("1  RO_DATA_INTERPRETATION exists", !!di);
chk("2  object_type is REASONING", di?.object_type==="REASONING", di?.object_type);
chk("3  definition is non-empty and on-message",
  !!String(di?.description||"").trim() && /does not establish/i.test(di?.description||""),
  `${String(di?.description||"").length} chars`);
chk("   status ACTIVE_SEED, not deprecated", di?.status==="ACTIVE_SEED" && !di?.deprecated_by);
chk("4  no section taxonomy", !CS.some(r=>r.concept_id===di?.id));
chk("5  no discipline taxonomy", !CD.some(r=>r.concept_id===di?.id));
chk("6  no AAMC category taxonomy", !CCC.some(r=>r.concept_id===di?.id));
chk("7  question_reasoning_objects still empty", QRO.length===0, String(QRO.length));
chk("8  question_concepts unchanged", QC.length===2673, String(QC.length));
chk("9  flashcard_concepts unchanged", FC.length===4115, String(FC.length));
chk("   concepts 1,129 -> 1,130", C.length===1130, String(C.length));
chk("   Reaction Mechanism Analysis now has a description",
  !!String(rma?.description||"").trim(), `${String(rma?.description||"").length} chars`);
chk("   it is still REASONING with no taxonomy",
  rma?.object_type==="REASONING" && !CS.some(r=>r.concept_id===rma?.id)
  && !CD.some(r=>r.concept_id===rma?.id) && !CCC.some(r=>r.concept_id===rma?.id));
const noDesc=C.filter(c=>c.object_type==="REASONING"&&!String(c.description||"").trim());
chk("   every REASONING object now has a definition", noDesc.length===0, noDesc.map(c=>c.slug).join(", "));
chk("   no reasoning object leaked into question_concepts",
  !QC.some(r=>C.find(c=>c.id===r.concept_id)?.object_type!=="CONTENT"));
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nALL LIVE CHECKS PASS");
