// Pre/post migration learner snapshot. Order-independent multiset over FULL row
// tuples including user_id: flashcard_user_state is keyed by user, so
// (flashcard_id, cloze_index) is NOT unique and keying on it produces false
// positives. Counts are floors, not equalities: concurrent study legitimately
// adds reviews, only a DROP indicates mutation.
import { all } from "./record.mjs";
import crypto from "node:crypto";
import fs from "node:fs";
const mode=process.argv[2]||"before";
const S=await all("flashcard_user_state","*");
const cols=Object.keys(S[0]||{}).sort();
const FSRS=["stability","difficulty","interval_days","ease_factor","reps","lapses","last_rating","next_review_at","fsrs_state","state","due","elapsed_days","scheduled_days"]
  .filter(c=>cols.includes(c));
const keyCols=["user_id","flashcard_id","cloze_index"].filter(c=>cols.includes(c));
const tup=r=>[...keyCols,...FSRS].map(c=>`${c}=${JSON.stringify(r[c]??null)}`).join("|");
const tuples=S.map(tup).sort();
const digest=crypto.createHash("sha256").update(tuples.join("\n")).digest("hex").slice(0,16);
const byUser={}; S.forEach(r=>byUser[r.user_id]=(byUser[r.user_id]||0)+1);
const counts={};
for(const t of ["flashcard_reviews","question_attempts","flashcard_user_state","learner_events","practice_sessions","learner_state_snapshots"]){
  try{ counts[t]=(await all(t,"user_id")).length; }catch(e){ counts[t]=`n/a (${e.message.slice(0,30)})`; }
}
const snap={mode, when:new Date().toISOString(), fsrsFields:FSRS, keyCols,
  stateRows:S.length, byUser, digest, counts,
  questionConcepts:(await all("question_concepts","concept_id")).length,
  flashcardConcepts:(await all("flashcard_concepts","concept_id")).length,
  concepts:(await all("concepts","id")).length};
fs.writeFileSync(`/tmp/snap_${mode}.json`,JSON.stringify({...snap,tuples},null,1));
console.log(`${mode.toUpperCase()} snapshot`);
console.log(`  FSRS fields compared: ${FSRS.join(", ")}`);
console.log(`  key columns: ${keyCols.join(", ")}`);
console.log(`  flashcard_user_state rows: ${S.length} across ${Object.keys(byUser).length} users ${JSON.stringify(Object.values(byUser))}`);
console.log(`  tuple multiset digest: ${digest}`);
console.log(`  learner counts: ${JSON.stringify(counts)}`);
console.log(`  ontology: concepts ${snap.concepts} | card mappings ${snap.flashcardConcepts} | question mappings ${snap.questionConcepts}`);
