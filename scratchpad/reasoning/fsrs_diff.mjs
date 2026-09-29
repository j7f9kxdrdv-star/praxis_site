// A blunt multiset digest cannot tell study from mutation: reviewing a card
// legitimately rewrites its FSRS row, so the old tuple disappears. The question
// that matters is whether each changed row moved FORWARD or was damaged.
import fs from "node:fs";
const b=JSON.parse(fs.readFileSync("/tmp/snap_cvafter.json","utf8"));
const a=JSON.parse(fs.readFileSync("/tmp/snap_m1after.json","utf8"));
const key=t=>t.split("|").slice(0,3).join("|");          // user_id|flashcard_id|cloze_index
const field=(t,n)=>{const m=t.match(new RegExp(`${n}=([^|]*)`)); return m?m[1]:null;};
const B=new Map(b.tuples.map(t=>[key(t),t])), A=new Map(a.tuples.map(t=>[key(t),t]));
let vanished=0, changed=0, repsDown=0, identical=0;
const examples=[];
for(const [k,tb] of B){
  const ta=A.get(k);
  if(!ta){vanished++;continue;}
  if(ta===tb){identical++;continue;}
  changed++;
  const rb=Number(field(tb,"reps")), ra=Number(field(ta,"reps"));
  if(Number.isFinite(rb)&&Number.isFinite(ra)&&ra<rb){repsDown++; if(examples.length<3) examples.push(`${k} reps ${rb} -> ${ra}`);}
}
console.log("ROW-LEVEL COMPARISON");
console.log(`  rows present before:            ${B.size}`);
console.log(`  rows present after:             ${A.size}   (+${A.size-B.size} new cards started)`);
console.log(`  unchanged:                      ${identical}`);
console.log(`  changed but still present:      ${changed}`);
console.log(`  VANISHED (row deleted):         ${vanished}`);
console.log(`  reps went DOWN (regression):    ${repsDown}`);
examples.forEach(e=>console.log(`      ${e}`));
console.log(`\n  flashcard_reviews ${b.counts.flashcard_reviews} -> ${a.counts.flashcard_reviews}  (+${a.counts.flashcard_reviews-b.counts.flashcard_reviews})`);
const ok = vanished===0 && repsDown===0 && a.counts.flashcard_reviews>=b.counts.flashcard_reviews;
console.log(ok
 ? "\nVERDICT: study, not mutation. No row was deleted, no schedule regressed, and the review log grew."
 : "\nVERDICT: *** something was mutated, investigate ***");
