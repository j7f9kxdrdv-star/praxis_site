// Migration 2 pre-application validation, item 11.
import { all } from "../backfill/record.mjs";
const P=[]; const chk=(n,pass,d="")=>{console.log(`  ${pass?"ok  ":"FAIL"}  ${n}${d?"   "+d:""}`);if(!pass)P.push(n);};
const C=await all("concepts","id,slug,canonical_name,description,object_type,status");
const SLUG="RO_DATA_INTERPRETATION", NAME="Data Interpretation";
const norm=s=>s.toLowerCase().replace(/[^a-z0-9]/g,"");
chk("slug is not already taken", !C.some(c=>c.slug===SLUG));
chk("canonical name does not collide", !C.some(c=>c.canonical_name===NAME));
chk("name does not collide under normalisation",
  !C.some(c=>norm(c.canonical_name)===norm(NAME)),
  C.filter(c=>norm(c.canonical_name)===norm(NAME)).map(c=>c.canonical_name).join(", "));
chk("no near-name among QUANTITATIVE that would confuse it",
  !C.some(c=>c.object_type==="QUANTITATIVE"&&norm(c.canonical_name)===norm(NAME)));
const rma=C.find(c=>c.slug==="RO_REACTION_MECHANISM_ANALYSIS");
chk("Reaction Mechanism Analysis exists and is REASONING", !!rma && rma.object_type==="REASONING");
chk("Reaction Mechanism Analysis has no description yet", !String(rma?.description||"").trim());
chk("it is the only REASONING object lacking one",
  C.filter(c=>c.object_type==="REASONING"&&!String(c.description||"").trim()).length===1);
const qro=await all("question_reasoning_objects","question_id");
chk("question_reasoning_objects is empty", qro.length===0, String(qro.length));
const qc=await all("question_concepts","question_id"); const fc=await all("flashcard_concepts","flashcard_id");
chk("question_concepts baseline 2,673", qc.length===2673, String(qc.length));
chk("flashcard_concepts baseline 4,115", fc.length===4115, String(fc.length));
chk("concepts baseline 1,129", C.length===1129, String(C.length));
console.log(P.length?`\nFAILED: ${P.join(", ")}`:"\nMIGRATION 2 PRE-VALIDATION CLEAN");
if(P.length) process.exit(1);
