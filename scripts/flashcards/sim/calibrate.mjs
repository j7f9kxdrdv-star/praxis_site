import { fsrs, generatorParameters, createEmptyCard, Rating } from "ts-fsrs";
import fs from "fs";

const rows = JSON.parse(fs.readFileSync("reviews.json", "utf8"));
// Only the two users with a real history; the other three have <40 reviews.
const REAL = new Set(["ee01e0e1-ac92-4ea7-92c9-2738b82b6dca", "e448edd7-b8b8-4d6b-b5b6-6b1b8b8b8b8b"]);
const counts = new Map();
rows.forEach(r => counts.set(r.user_id, (counts.get(r.user_id) || 0) + 1));
const keep = new Set([...counts.entries()].filter(([, n]) => n >= 1000).map(([u]) => u));

const RMAP = { again: Rating.Again, hard: Rating.Hard, medium: Rating.Good, easy: Rating.Easy };

// Group into per-card-blank sequences, in time order.
const seqs = new Map();
for (const r of rows) {
  if (!keep.has(r.user_id)) continue;
  const k = `${r.user_id}|${r.flashcard_id}|${r.cloze_index}`;
  if (!seqs.has(k)) seqs.set(k, []);
  seqs.get(k).push(r);
}
for (const v of seqs.values()) v.sort((a, b) => a.reviewed_at.localeCompare(b.reviewed_at));
console.log(`card-blanks with history: ${seqs.size}`);

const f = fsrs(generatorParameters({ enable_short_term: true, enable_fuzz: false }));

// Replay each sequence. At every review that follows a REAL gap (>= 1 day),
// record what FSRS predicted the recall probability to be, next to what
// actually happened. That is the only honest test of whether the default
// parameters describe this content.
const preds = [];
for (const seq of seqs.values()) {
  let card = createEmptyCard(new Date(seq[0].reviewed_at));
  let last = null;
  for (const rev of seq) {
    const now = new Date(rev.reviewed_at);
    if (last) {
      const gapDays = (now - last) / 86400000;
      if (gapDays >= 1) {
        const R = f.get_retrievability(card, now, false);
        if (typeof R === "number" && R > 0 && R < 1) {
          preds.push({ R, pass: rev.rating !== "again" ? 1 : 0, gapDays });
        }
      }
    }
    card = f.next(card, now, RMAP[rev.rating] ?? Rating.Good).card;
    last = now;
  }
}
console.log(`spaced reviews scored: ${preds.length}`);

const meanP = preds.reduce((s, p) => s + p.R, 0) / preds.length;
const meanO = preds.reduce((s, p) => s + p.pass, 0) / preds.length;
console.log(`\nFSRS predicted recall: ${(100*meanP).toFixed(1)}%`);
console.log(`actually observed:     ${(100*meanO).toFixed(1)}%`);
console.log(`overprediction:        ${(100*(meanP-meanO)).toFixed(1)} points`);

// Calibration by predicted-probability bucket.
console.log(`\n  predicted    n      predicted  observed   gap`);
const B = [[0,.5],[.5,.7],[.7,.8],[.8,.85],[.85,.9],[.9,.95],[.95,1]];
for (const [lo, hi] of B) {
  const b = preds.filter(p => p.R >= lo && p.R < hi);
  if (b.length < 30) continue;
  const pp = b.reduce((s,p)=>s+p.R,0)/b.length, oo = b.reduce((s,p)=>s+p.pass,0)/b.length;
  console.log(`  ${(lo*100).toFixed(0).padStart(3)}-${(hi*100).toFixed(0).padEnd(3)} ${String(b.length).padStart(6)}      ${(100*pp).toFixed(1).padStart(5)}%   ${(100*oo).toFixed(1).padStart(5)}%  ${(100*(pp-oo)).toFixed(1).padStart(6)}`);
}
// Log loss vs a constant baseline, to see if FSRS is adding signal at all.
const ll = -preds.reduce((s,p)=>s+(p.pass?Math.log(p.R):Math.log(1-p.R)),0)/preds.length;
const base = -preds.reduce((s,p)=>s+(p.pass?Math.log(meanO):Math.log(1-meanO)),0)/preds.length;
console.log(`\nlog loss  FSRS ${ll.toFixed(4)}   constant-rate baseline ${base.toFixed(4)}   ${ll<base?"FSRS adds signal":"FSRS WORSE than a constant"}`);
