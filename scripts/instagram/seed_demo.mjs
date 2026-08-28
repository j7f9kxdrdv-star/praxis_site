/*
 * Seeds the ig-demo account so product screenshots show a plausible, committed
 * student instead of the founder's own (or an empty) account.
 *
 * Everything written is tied to one user id and is deleted by the matching
 * --wipe run, so this is fully reversible.
 *
 *   node seed_demo.mjs         seed
 *   node seed_demo.mjs --wipe  remove everything this created
 */
import { createClient } from "@supabase/supabase-js";
import fs from "fs";
const env = Object.fromEntries(fs.readFileSync(".env.local","utf8").split("\n").filter(l=>l.includes("=")&&!l.trim().startsWith("#")).map(l=>[l.slice(0,l.indexOf("=")).trim(),l.slice(l.indexOf("=")+1).trim()]));
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const DEMO = "35286b14-b18e-450b-b907-aba61c4d75eb";
const wipe = process.argv.includes("--wipe");

const page = async (t, cols, tweak = q => q) => { const o=[]; for(let f=0;;f+=1000){ const {data,error}=await tweak(db.from(t).select(cols)).order("id",{ascending:true}).range(f,f+999); if(error) throw error; if(!data||!data.length)break; o.push(...data); if(data.length<1000)break;} return o; };

if (wipe) {
  for (const t of ["question_attempts","daily_activity","flashcard_user_state","review_schedule"]) {
    const { error } = await db.from(t).delete().eq("user_id", DEMO);
    console.log(`wiped ${t}:`, error?.message || "ok");
  }
  await db.from("practice_sessions").delete().eq("user_id", DEMO);
  console.log("wiped practice_sessions");
  process.exit(0);
}

// Deterministic pseudo-random so a reseed reproduces the same dashboard.
let s = 987654321;
const rnd = () => (s = (s * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff;

const DAYS = 24;              // studying for about three and a half weeks
const STREAK_DAYS = 12;       // unbroken run ending today
const ACCURACY = 0.71;        // credible for a student mid-prep, not superhuman

const questions = await page("questions", "id, section, discipline, topic, passage_id");
const pool = questions.filter(q => !q.passage_id);

// ---- question attempts ----
await db.from("question_attempts").delete().eq("user_id", DEMO);
const now = Date.now();
// The dashboard builds the streak from LOCAL calendar dates. Deriving the day
// key from an ISO string uses UTC, which on a US evening lands every row on
// tomorrow and silently produces a streak of zero.
const pad = (n) => String(n).padStart(2, "0");
const localKey = (dt) => `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())}`;
const startOfToday = new Date(); startOfToday.setHours(0, 0, 0, 0);
const nowHour = new Date().getHours();

const attempts = [];
const dayKeys = [];
for (let d = DAYS - 1; d >= 0; d--) {
  const studied = d < STREAK_DAYS ? true : rnd() > 0.35;   // patchier earlier on
  if (!studied) continue;
  const day = new Date(startOfToday);
  day.setDate(day.getDate() - d);
  const key = localKey(day);
  dayKeys.push(key);
  // Keep today's rows in the past, not a few hours into this evening.
  const latest = d === 0 ? Math.max(9, nowHour - 1) : 20;
  const n = 12 + Math.floor(rnd() * 22);
  for (let i = 0; i < n; i++) {
    const q = pool[Math.floor(rnd() * pool.length)];
    const when = new Date(day);
    when.setHours(8 + Math.floor(rnd() * Math.max(1, latest - 8)), Math.floor(rnd() * 60), 0, 0);
    attempts.push({
      user_id: DEMO, question_id: q.id, selected_answer: "A",
      is_correct: rnd() < ACCURACY, time_spent_seconds: 45 + Math.floor(rnd() * 90),
      flagged: rnd() < 0.04, created_at: when.toISOString(), _day: key,
    });
  }
}
const attemptRows = attempts.map(({ _day, ...rest }) => rest);
for (let i = 0; i < attemptRows.length; i += 500) {
  const { error } = await db.from("question_attempts").insert(attemptRows.slice(i, i + 500));
  if (error) { console.error("attempts:", error.message); process.exit(1); }
}

// ---- daily activity (this is what drives the streak) ----
await db.from("daily_activity").delete().eq("user_id", DEMO);
const byDay = new Map();
attempts.forEach(a => byDay.set(a._day, (byDay.get(a._day) || 0) + 1));
const rows = [...byDay.entries()].map(([activity_date, questions_completed]) => ({
  user_id: DEMO, activity_date, questions_completed,
  time_studied_seconds: questions_completed * 70,
}));
const { error: daErr } = await db.from("daily_activity").insert(rows);
if (daErr) { console.error("daily_activity:", daErr.message); process.exit(1); }

// ---- flashcard progress ----
// cloze_index MUST stay within the card's real blank count, or these become
// the orphan rows that made the two headline counts disagree.
await db.from("flashcard_user_state").delete().eq("user_id", DEMO);
const decks = (await db.from("flashcard_decks").select("id")).data.map(d => d.id);
const cards = (await page("flashcards", "id, deck_id, cloze_count, card_type"))
  .filter(c => decks.includes(c.deck_id));
const states = [];
for (const c of cards) {
  if (rnd() > 0.17) continue;                      // a slice of the library in rotation
  const blanks = c.card_type === "cloze" ? Math.max(c.cloze_count || 1, 1) : 1;
  const idx = c.card_type === "cloze" ? 1 + Math.floor(rnd() * blanks) : 0;
  const reps = 1 + Math.floor(rnd() * 5);
  const due = rnd();
  const offsetDays = due < 0.34 ? -(rnd() * 3) : due < 0.7 ? rnd() * 3 : 3 + rnd() * 21;
  states.push({
    user_id: DEMO, flashcard_id: c.id, cloze_index: idx,
    starred: rnd() < 0.03, suspended: false,
    interval_days: Math.max(1, Math.round(offsetDays > 0 ? offsetDays : 1)),
    ease_factor: 2.3 + rnd() * 0.4, reps, lapses: rnd() < 0.2 ? 1 : 0,
    last_rating: rnd() < 0.18 ? "hard" : rnd() < 0.75 ? "medium" : "easy",
    last_reviewed_at: new Date(now - (2 + rnd() * 10) * 86400000).toISOString(),
    next_review_at: new Date(now + offsetDays * 86400000).toISOString(),
  });
}
for (let i = 0; i < states.length; i += 500) {
  const { error } = await db.from("flashcard_user_state").insert(states.slice(i, i + 500));
  if (error) { console.error("flashcard_user_state:", error.message); process.exit(1); }
}

const correct = attempts.filter(a => a.is_correct).length;
const dueNow = states.filter(x => new Date(x.next_review_at) <= new Date()).length;
const weekAgo = now - 7 * 86400000;
console.log(`attempts        : ${attempts.length}  (${Math.round(100*correct/attempts.length)}% correct)`);
console.log(`questions week  : ${attempts.filter(a => new Date(a.created_at).getTime() > weekAgo).length}`);
console.log(`most recent day : ${dayKeys[dayKeys.length - 1]}  (today is ${localKey(new Date())})`);
console.log(`active days     : ${rows.length}`);
console.log(`card state rows : ${states.length}  (${dueNow} due now)`);
