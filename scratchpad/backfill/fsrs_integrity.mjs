// Distinguishes "changed because the user studied" from "changed because a
// migration touched learner state".
//
// The digest and the row-level check between them answer "did anything change"
// and "did anything break". Neither answers the question that matters most: was
// each change EXPLAINED. A migration that nudged one scheduler row would be
// invisible to a digest amid genuine study.
//
// flashcard_reviews carries (user_id, flashcard_id, cloze_index, reviewed_at),
// which is exactly the scheduler key plus a timestamp, so correlating is a
// lookup rather than a heuristic.
//
//   usage: node fsrs_integrity.mjs <beforeSnapshot> <afterSnapshot>
import { all } from "./record.mjs";
import fs from "node:fs";
const [bf,af]=process.argv.slice(2);
const b=JSON.parse(fs.readFileSync(bf,"utf8"));
const a=JSON.parse(fs.readFileSync(af,"utf8"));
const key=t=>t.split("|").slice(0,3).join("|");
const fld=(t,n)=>{const m=t.match(new RegExp(`(?:^|\\\\|)${n}=([^|]*)`)); return m?m[1]:null;};
const B=new Map(b.tuples.map(t=>[key(t),t])), A=new Map(a.tuples.map(t=>[key(t),t]));

// every review inside the comparison window, keyed the same way
const R=await all("flashcard_reviews","user_id,flashcard_id,cloze_index,reviewed_at");
const reviewed=new Set(R.filter(r=>r.reviewed_at>b.when&&r.reviewed_at<=a.when)
  .map(r=>`user_id=${JSON.stringify(r.user_id)}|flashcard_id=${JSON.stringify(r.flashcard_id)}|cloze_index=${JSON.stringify(r.cloze_index)}`));

const P=[]; let unchanged=0, explained=0, unexplained=0, vanished=0, regressed=0;
const bad=[];
for(const [k,tb] of B){
  const ta=A.get(k);
  if(!ta){vanished++; bad.push(`VANISHED ${k}`); continue;}
  if(ta===tb){unchanged++; continue;}
  const rb=Number(fld(tb,"reps")), ra=Number(fld(ta,"reps"));
  if(Number.isFinite(rb)&&Number.isFinite(ra)&&ra<rb){regressed++; bad.push(`REPS BACKWARD ${k}: ${rb} -> ${ra}`);}
  if(reviewed.has(k)) explained++;
  else { unexplained++; bad.push(`UNEXPLAINED ${k}\n      before ${tb}\n      after  ${ta}`); }
}
console.log("FSRS INTEGRITY");
console.log(`  window                    ${b.when}  ->  ${a.when}`);
console.log(`  reviews in window         ${[...reviewed].length} distinct cards, ${R.filter(r=>r.reviewed_at>b.when&&r.reviewed_at<=a.when).length} reviews`);
console.log(`  digest                    ${b.digest===a.digest?"identical":"differs"}`);
console.log(`  rows ${b.stateRows} -> ${a.stateRows}  (+${a.stateRows-b.stateRows} new)`);
console.log(`  unchanged                 ${unchanged}`);
console.log(`  changed WITH a review     ${explained}   (legitimate study)`);
console.log(`  changed WITHOUT a review  ${unexplained}   <- must be 0`);
console.log(`  vanished                  ${vanished}   <- must be 0`);
console.log(`  reps went backward        ${regressed}   <- must be 0`);
if(unexplained||vanished||regressed){
  console.log("\nPROBLEMS:"); bad.slice(0,6).forEach(x=>console.log("  "+x));
  console.log("\nFSRS INTEGRITY: FAILED"); process.exit(1);
}
console.log("\nFSRS INTEGRITY: every change is explained by a review in the window");
