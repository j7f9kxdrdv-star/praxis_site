/*
 * V3 PR6 — seed FSRS state for every card a student has already studied.
 *
 * FSRS carries two numbers per card, stability and difficulty, that the v2
 * ladder never stored. Without them every existing card looks brand new, and
 * months of a beta tester's work would reset to a one-minute interval.
 *
 * They cannot be derived from the current row, but they CAN be recovered
 * exactly: replay each card-blank's real review history through FSRS in order
 * and read off the state it arrives at. That is what this does.
 *
 * next_review_at is deliberately NOT recomputed. Students keep the schedule
 * they already have, and FSRS takes over from their next review onward. The
 * alternative would silently move thousands of due dates the moment the
 * migration ran.
 *
 * Emits SQL rather than writing directly, so the change goes through the same
 * review-then-paste path as every other live data change.
 *
 *   node scripts/flashcards/backfill-fsrs-state.mjs
 */
import { createClient } from "@supabase/supabase-js";
import { fsrs, generatorParameters, createEmptyCard, Rating } from "ts-fsrs";
import fs from "fs";

const env = Object.fromEntries(
  fs.readFileSync(".env.local", "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()])
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const RMAP = { again: Rating.Again, hard: Rating.Hard, medium: Rating.Good, easy: Rating.Easy };
const engine = fsrs(generatorParameters({
  request_retention: 0.75, maximum_interval: 60, enable_short_term: true, enable_fuzz: false,
}));

// Every review, oldest first. The .order() is not optional: without a stable
// sort key, .range() pagination silently returns overlapping pages.
const reviews = [];
for (let from = 0; ; from += 1000) {
  const { data, error } = await db.from("flashcard_reviews")
    .select("user_id, flashcard_id, cloze_index, rating, reviewed_at")
    .order("reviewed_at", { ascending: true }).order("id", { ascending: true })
    .range(from, from + 999);
  if (error) throw new Error(error.message);
  if (!data.length) break;
  reviews.push(...data);
  if (data.length < 1000) break;
}
console.error(`reviews read: ${reviews.length}`);

const seqs = new Map();
for (const r of reviews) {
  const k = `${r.user_id}|${r.flashcard_id}|${r.cloze_index}`;
  if (!seqs.has(k)) seqs.set(k, []);
  seqs.get(k).push(r);
}
for (const v of seqs.values()) v.sort((a, b) => a.reviewed_at.localeCompare(b.reviewed_at));
console.error(`card-blanks with history: ${seqs.size}`);

const rows = [];
for (const [key, seq] of seqs) {
  const [userId, flashcardId, clozeIndex] = key.split("|");
  let card = createEmptyCard(new Date(seq[0].reviewed_at));
  for (const rev of seq) {
    card = engine.next(card, new Date(rev.reviewed_at), RMAP[rev.rating] ?? Rating.Good).card;
  }
  rows.push([userId, Number(clozeIndex), flashcardId,
    card.stability.toFixed(4), card.difficulty.toFixed(4),
    card.state, card.learning_steps ?? 0, card.scheduled_days ?? 0]);
}

const CHUNK = 2000;
const files = [];
for (let i = 0; i < rows.length; i += CHUNK) {
  const part = rows.slice(i, i + CHUNK);
  const n = Math.floor(i / CHUNK) + 1;
  const total = Math.ceil(rows.length / CHUNK);
  const sql = `-- V3 PR6 backfill, part ${n} of ${total} (${part.length} card-blanks)
--
-- Stability and difficulty recovered by replaying each card's real review
-- history through FSRS. next_review_at is untouched on purpose: students keep
-- the schedule they already have and FSRS takes over from the next review.
--
-- Safe to re-run. Safe to run in any order. Parts are disjoint.

UPDATE public.flashcard_user_state AS s SET
  stability      = v.stability,
  difficulty     = v.difficulty,
  fsrs_state     = v.fsrs_state,
  learning_steps = v.learning_steps,
  scheduled_days = v.scheduled_days
FROM (VALUES
${part.map(r => `  ('${r[0]}'::uuid,${r[1]},'${r[2]}'::uuid,${r[3]}::numeric,${r[4]}::numeric,${r[5]}::smallint,${r[6]}::smallint,${r[7]}::numeric)`).join(",\n")}
) AS v(user_id, cloze_index, flashcard_id, stability, difficulty, fsrs_state, learning_steps, scheduled_days)
WHERE s.user_id = v.user_id
  AND s.flashcard_id = v.flashcard_id
  AND s.cloze_index = v.cloze_index;

-- Rows still missing FSRS state after ALL parts have run. Expect this to fall
-- to zero once every part is applied; anything left is a scheduling row whose
-- review history was lost before PR5 made that impossible.
SELECT COUNT(*) AS still_missing
FROM public.flashcard_user_state WHERE stability IS NULL;
`;
  const path = `supabase/fixes/20260825_backfill_fsrs_part${n}.sql`;
  fs.writeFileSync(path, sql);
  files.push(path);
}
console.error(`\nwrote ${files.length} files:`);
files.forEach(f => console.error(`  ${f}  (${(fs.statSync(f).size/1024).toFixed(0)} KB)`));
const st = rows.map(r => Number(r[3])).sort((a,b)=>a-b);
const df = rows.map(r => Number(r[4])).sort((a,b)=>a-b);
const q = (a,p) => a[Math.floor(p*(a.length-1))];
console.error(`\nrecovered stability   median ${q(st,.5).toFixed(1)}d  p90 ${q(st,.9).toFixed(1)}d  max ${q(st,1).toFixed(0)}d`);
console.error(`recovered difficulty  median ${q(df,.5).toFixed(1)}   p90 ${q(df,.9).toFixed(1)}   (1 easiest, 10 hardest)`);
