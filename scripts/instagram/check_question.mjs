/*
 * Originality gate for an Instagram question of the day.
 *
 *   node scripts/instagram/check_question.mjs --slug competitive-inhibition
 *   node scripts/instagram/check_question.mjs --all
 *
 * THE RULE THIS ENFORCES. Instagram questions must be net-new. They may test
 * the same concept as the paid bank, but they must not reuse a scenario, a
 * data pattern, a reasoning path, or a distractor set. The bank is the
 * product; spending it on social media gives away the thing people pay for.
 *
 * WHAT A MACHINE CAN AND CANNOT CHECK. Four of the rejection criteria are
 * mechanical and are checked here:
 *
 *   vocabulary overlap     shared content words, Jaccard
 *   numeric fingerprint    the same distinctive values, e.g. "2 mM" and "8 mM"
 *   distractor overlap     answer choices that say the same things
 *   rare-term collision    unusual terms two questions both lean on
 *
 * The remaining criteria, same reasoning pathway and same central inference,
 * are NOT mechanically detectable. Two questions can share none of the above
 * and still be the same question wearing a different coat. So this script does
 * not return a verdict on its own: it prints the three nearest questions in the
 * bank IN FULL so they can be read and judged. A clean score here means "worth
 * reading the neighbours", not "verified unique".
 *
 * Exit code 1 blocks. Exit code 0 means the mechanical checks passed and the
 * neighbours still need a human read.
 */
import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";

const ROOT = process.cwd();
const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const only = arg("--slug");

const env = Object.fromEntries(
  fs.readFileSync(path.join(ROOT, ".env.local"), "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()])
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

const QFILE = path.join(ROOT, "marketing/qotd/questions.json");
const questions = JSON.parse(fs.readFileSync(QFILE, "utf8"))
  .filter((q) => !only || q.slug === only);
if (!questions.length) { console.error("no questions matched"); process.exit(1); }

// ─── Thresholds ────────────────────────────────────────────────────────────
// Deliberately tighter than the 0.45 the reel generator shipped with. That
// figure was chosen to catch outright copies; these criteria are meant to catch
// a question that merely FEELS like one already in the bank.
const T = {
  vocab: 0.32,      // shared content words
  numeric: 0.60,    // shared numeric values with units
  distractor: 0.45, // shared answer-choice vocabulary
  rare: 3,          // count of shared rare terms that triggers a look
};

const STOP = new Set(("a an the of to in is are was were which what most likely following for on at "
  + "by with from that this these those it its as be been and or if then than does do did can could "
  + "would should will not no more less into during each both when where how why there here such "
  + "one two three four also may might must have has had been being about after before between").split(" "));

const words = (s) => String(s).toLowerCase()
  .replace(/[_^]\{([^}]+)\}/g, "$1")
  .replace(/[^a-z0-9\s.]/g, " ")
  .split(/\s+/).filter(Boolean);
const bag = (s) => new Set(words(s).filter((w) => w.length > 2 && !STOP.has(w) && !/^\d/.test(w)));
const jaccard = (a, b) => {
  if (!a.size || !b.size) return 0;
  let hit = 0; for (const w of a) if (b.has(w)) hit++;
  return hit / (a.size + b.size - hit);
};

/** Numbers with their units: the fingerprint of a question's data. */
const numbers = (s) => {
  const out = new Set();
  const re = /(\d+(?:\.\d+)?)\s*(mM|M|mg|g|kg|mol|nm|mL|L|kJ|kcal|mmHg|atm|°C|K|Hz|V|A|W|s|min|h|%)?/gi;
  let m;
  while ((m = re.exec(String(s).replace(/[_^]\{([^}]+)\}/g, "$1"))) !== null) {
    out.add(m[2] ? `${m[1]}${m[2].toLowerCase()}` : m[1]);
  }
  return out;
};

fs.mkdirSync(path.join(ROOT, "marketing/qotd"), { recursive: true });

// ─── Pull the paid bank ────────────────────────────────────────────────────
const bank = [];
for (let from = 0; ; from += 1000) {
  const { data, error } = await db.from("questions")
    .select("id, question_text, options, subtopic")
    .order("id", { ascending: true }).range(from, from + 999);
  if (error) { console.error("bank read failed:", error.message); process.exit(1); }
  if (!data.length) break;
  bank.push(...data); if (data.length < 1000) break;
}

// Document frequency, so "rare" means rare in THIS bank rather than in English.
const df = new Map();
for (const q of bank) for (const w of bag(q.question_text)) df.set(w, (df.get(w) ?? 0) + 1);
const isRare = (w) => (df.get(w) ?? 0) > 0 && (df.get(w) ?? 0) <= 12;

/** `options` is one JSON column; it may be an array of strings or of objects. */
const optionText = (o) => {
  if (!o) return "";
  const arr = Array.isArray(o) ? o : Object.values(o);
  return arr.map((x) => (typeof x === "string" ? x : (x?.text ?? x?.label ?? JSON.stringify(x)))).join(" ");
};

const prepped = bank.map((q) => ({
  q, stem: bag(q.question_text), nums: numbers(q.question_text), opts: bag(optionText(q.options)),
}));

console.log(`Praxist question bank: ${bank.length} live questions\n`);

let blocked = 0;
for (const q of questions) {
  const mine = { stem: bag(q.stem), nums: numbers(q.stem), opts: bag(q.options.join(" ")) };
  const scored = prepped.map((b) => {
    const v = jaccard(mine.stem, b.stem);
    const n = jaccard(mine.nums, b.nums);
    const d = jaccard(mine.opts, b.opts);
    const shared = [...mine.stem].filter((w) => b.stem.has(w) && isRare(w));
    // One combined figure for ranking only. Each signal is judged on its own
    // threshold below, because a question can be a duplicate on ANY of them.
    return { b, v, n, d, shared, rank: v + 0.6 * n + 0.5 * d + 0.04 * shared.length };
  }).sort((x, y) => y.rank - x.rank);

  const worst = scored[0];
  const fails = [];
  if (worst.v >= T.vocab) fails.push(`vocabulary overlap ${(100 * worst.v).toFixed(0)}% (limit ${100 * T.vocab}%)`);
  if (worst.n >= T.numeric) fails.push(`numeric fingerprint ${(100 * worst.n).toFixed(0)}% (limit ${100 * T.numeric}%)`);
  if (worst.d >= T.distractor) fails.push(`distractor overlap ${(100 * worst.d).toFixed(0)}% (limit ${100 * T.distractor}%)`);
  if (worst.shared.length >= T.rare) fails.push(`${worst.shared.length} rare terms in common: ${worst.shared.join(", ")}`);

  console.log(`${"=".repeat(70)}\n${q.slug}  (${q.eyebrow})`);
  console.log(`${q.stem.replace(/[_^]\{([^}]+)\}/g, "$1").slice(0, 150)}\n`);
  console.log(`  nearest in bank: vocab ${(100 * worst.v).toFixed(0)}%, numeric ${(100 * worst.n).toFixed(0)}%, `
    + `distractors ${(100 * worst.d).toFixed(0)}%, rare terms ${worst.shared.length}`);

  if (fails.length) {
    blocked++;
    console.log(`\n  BLOCKED. Too close to a paid question:`);
    fails.forEach((f) => console.log(`    - ${f}`));
  } else {
    console.log(`  Mechanical checks PASS.`);
  }

  console.log(`\n  READ THESE THREE AND JUDGE THE REASONING PATH YOURSELF.`);
  console.log(`  No script can see that two questions share a central inference.\n`);
  scored.slice(0, 3).forEach((s, i) => {
    console.log(`  ${i + 1}. [${s.b.q.subtopic ?? "?"}]  vocab ${(100 * s.v).toFixed(0)}%`);
    console.log(`     ${s.b.q.question_text.replace(/\s+/g, " ").slice(0, 220)}`);
    console.log(`     options: ${optionText(s.b.q.options).replace(/\s+/g, " ").slice(0, 150)}`);
    console.log("");
  });
}

console.log("=".repeat(70));
if (blocked) {
  console.log(`${blocked} question(s) BLOCKED. Write different ones.`);
  process.exit(1);
}
console.log(`Mechanical checks passed. This is NOT a verification of uniqueness:`);
console.log(`the reasoning path still has to be read and judged.`);
