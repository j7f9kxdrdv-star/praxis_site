// Order-independent multiset comparison over full row tuples including user_id.
// Counts are FLOORS: concurrent study legitimately adds reviews, only a DROP
// indicates mutation.
import fs from "node:fs";
const B=JSON.parse(fs.readFileSync("/tmp/snap_before.json","utf8"));
const A=JSON.parse(fs.readFileSync("/tmp/snap_after.json","utf8"));
const P=[];
console.log("FSRS INTEGRITY");
console.log(`  digest before ${B.digest}  after ${A.digest}  ${B.digest===A.digest?"IDENTICAL":"DIFFER"}`);
const mb=new Map(), ma=new Map();
B.tuples.forEach(t=>mb.set(t,(mb.get(t)||0)+1));
A.tuples.forEach(t=>ma.set(t,(ma.get(t)||0)+1));
let lost=0, gained=0;
for(const [t,n] of mb){ const m=ma.get(t)||0; if(m<n) lost+=n-m; }
for(const [t,n] of ma){ const m=mb.get(t)||0; if(m>n) gained+=n-m; }
console.log(`  state rows ${B.stateRows} -> ${A.stateRows}`);
console.log(`  tuples present before but MISSING after: ${lost}`);
console.log(`  tuples new after (study activity): ${gained}`);
if(lost>0) P.push(`${lost} FSRS tuples were mutated or lost`);
console.log("\nLEARNER HISTORY (floors)");
for(const [t,b] of Object.entries(B.counts)){
  const a=A.counts[t];
  const dir = a===b ? "unchanged" : a>b ? `+${a-b} (study)` : `DROPPED ${b-a}`;
  console.log(`  ${t.padEnd(24)} ${String(b).padStart(6)} -> ${String(a).padStart(6)}  ${dir}`);
  if(typeof a==="number" && typeof b==="number" && a<b) P.push(`${t} DROPPED from ${b} to ${a}`);
}
console.log("\nONTOLOGY");
console.log(`  concepts          ${B.concepts} -> ${A.concepts}  (+${A.concepts-B.concepts})`);
console.log(`  card mappings     ${B.flashcardConcepts} -> ${A.flashcardConcepts}  (+${A.flashcardConcepts-B.flashcardConcepts})`);
console.log(`  question mappings ${B.questionConcepts} -> ${A.questionConcepts}  ${B.questionConcepts===A.questionConcepts?"UNCHANGED":"CHANGED"}`);
if(B.questionConcepts!==A.questionConcepts) P.push("question mappings changed");
console.log(P.length?`\nFAIL:\n  ${P.join("\n  ")}`:"\nLEARNER AND FSRS INTEGRITY: CLEAN");
