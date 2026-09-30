import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const snap = JSON.parse(fs.readFileSync("scratchpad/lipid/pre_split_snapshot.json", "utf8"));
const COLS = "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended";
const S = await all("flashcard_user_state", COLS);
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at,rating");
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const before = new Map(fs.readFileSync("scratchpad/lipid/pre_split_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const reviewedSince = new Set(R.filter((r) => r.reviewed_at >= snap.takenAt).map(key));
const moved = S.filter((r) => before.has(key(r)) && before.get(key(r)) !== line(r));
const appeared = S.filter((r) => !before.has(key(r)));
const unexplained = [...moved, ...appeared].filter((r) => !reviewedSince.has(key(r)));
console.log(`snapshot takenAt: ${snap.takenAt}`);
console.log(`${moved.length} moved, ${appeared.length} new, ${unexplained.length} unexplained by the time-window test\n`);
for (const r of unexplained) {
  const k = key(r);
  const b = before.get(k);
  console.log("UNEXPLAINED ROW " + k);
  console.log("  before: " + (b ?? "(did not exist)"));
  console.log("  after : " + line(r));
  const revs = R.filter((x) => key(x) === k).sort((x, y) => x.reviewed_at.localeCompare(y.reviewed_at));
  const last = revs[revs.length - 1];
  console.log(`  reviews for this row: ${revs.length}, most recent ${last?.reviewed_at} (rating ${last?.rating})`);
  const bLast = b ? b.split("|")[11] : null;
  console.log(`  last_reviewed_at  before=${bLast}  after=${r.last_reviewed_at}`);
  console.log(`  did last_reviewed_at advance? ${bLast && r.last_reviewed_at ? String(new Date(r.last_reviewed_at) > new Date(bLast)) : "n/a"}`);
  console.log(`  is the most recent review AFTER the snapshot's state read but BEFORE takenAt? ${last && last.reviewed_at < snap.takenAt ? "yes, that is the read-skew case" : "no"}`);
  const isLipid = snap.flashcards.some((f) => f.flashcard_id === r.flashcard_id);
  console.log(`  is this one of the 21 lipid cards? ${isLipid}`);
}
