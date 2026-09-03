/*
 * Instagram "question of the day" from questions written FOR Instagram.
 *
 *   node scripts/instagram/make_qotd.mjs                  # every question
 *   node scripts/instagram/make_qotd.mjs --slug weak-acid-ka
 *
 * The sibling script make_post.mjs renders a question out of the live bank.
 * This one deliberately cannot: these posts must not spend the question bank,
 * because a question a student has already seen on the site is not a hook, and
 * giving the answer away in public burns an item people are paying for.
 *
 * So the novelty rule is ENFORCED here rather than trusted. Every stem is
 * compared against all live questions and the script refuses to render one
 * that overlaps too closely. Reads the bank; writes nothing to it.
 *
 * Three slides, because a question of the day that only reveals the letter is
 * worth nothing to a student:
 *   1  the question, on cream
 *   2  the answer and why it is right, on forest
 *   3  why each distractor fails, and the transferable point
 */
import { createClient } from "@supabase/supabase-js";
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const ROOT = process.cwd();
const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1350;
const BRAND = {
  cream: "#FBF8F2", creamCard: "#F1EADC", forest: "#1F4D3C", mint: "#86D2B6",
  ink: "#1C1B19", inkSoft: "#3A382F", muted: "#8A8578", onForest: "#DCE8E1", rule: "#E6DFD2",
};

const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const only = arg("--slug");
const outDir = arg("--out") || path.join(ROOT, "marketing", "qotd");
const questions = JSON.parse(fs.readFileSync(path.join(ROOT, "marketing/qotd/questions.json"), "utf8"))
  .filter((q) => !only || q.slug === only);
if (!questions.length) { console.error("no questions matched"); process.exit(1); }

const env = Object.fromEntries(
  fs.readFileSync(path.join(ROOT, ".env.local"), "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()])
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

// ── The novelty gate ──────────────────────────────────────────────────────
// Jaccard overlap on content words. Crude, but the failure it guards against
// is posting something already sitting behind the paywall, and near-identical
// stems share most of their vocabulary. Stopwords are dropped so that shared
// scaffolding ("which of the following is most likely") does not read as a
// match on its own.
const STOP = new Set(("a an the of to in is are was were which what most likely following "
  + "for on at by with from that this these those it its as be been and or if then than "
  + "does do did can could would should will not no more less than into during").split(" "));
const bag = (s) => new Set(String(s).toLowerCase().replace(/[_^{}]/g, " ").replace(/[^a-z0-9\s]/g, " ")
  .split(/\s+/).filter((w) => w.length > 2 && !STOP.has(w)));
const jaccard = (a, b) => {
  let hit = 0;
  for (const w of a) if (b.has(w)) hit++;
  return hit / (a.size + b.size - hit);
};

const bank = [];
for (let from = 0; ; from += 1000) {
  const { data, error } = await db.from("questions").select("id, question_text, topic")
    .order("id", { ascending: true }).range(from, from + 999);
  if (error) { console.error("bank read failed:", error.message); process.exit(1); }
  if (!data.length) break;
  bank.push(...data);
  if (data.length < 1000) break;
}
const bankBags = bank.map((q) => ({ q, bag: bag(q.question_text) }));

const OVERLAP_LIMIT = 0.45;
let blocked = 0;
for (const q of questions) {
  const mine = bag(q.stem);
  let worst = { score: 0, q: null };
  for (const b of bankBags) {
    const s = jaccard(mine, b.bag);
    if (s > worst.score) worst = { score: s, q: b.q };
  }
  q._overlap = worst;
  if (worst.score >= OVERLAP_LIMIT) {
    console.error(`BLOCKED ${q.slug}: ${(100 * worst.score).toFixed(0)}% overlap with a live question`);
    console.error(`  ${worst.q.question_text.slice(0, 120)}`);
    blocked++;
  }
}
if (blocked) { console.error(`\n${blocked} question(s) too close to the bank. Rewrite or drop them.`); process.exit(1); }

// Brand rule: no em or en dashes anywhere a student can read.
for (const q of questions) {
  for (const [field, val] of Object.entries({ stem: q.stem, explanation: q.explanation,
    teaching_point: q.teaching_point, ...Object.fromEntries(q.options.map((o, i) => [`option ${i}`, o])),
    ...Object.fromEntries(q.distractors.map((d, i) => [`distractor ${i}`, d])) })) {
    if (/[—–]/.test(val)) { console.error(`BLOCKED ${q.slug}: em or en dash in ${field}`); process.exit(1); }
  }
}

const esc = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

// These cards are HTML, so they can carry real subscripts and superscripts —
// including the multi-character ones (V_max, k_cat) that Unicode has no
// characters for and the flashcards therefore have to write flat. Escape
// first, then promote the markup, so a stray angle bracket in the copy can
// never inject a tag.
const rich = (s) => esc(s)
  .replace(/_\{([^}]+)\}/g, "<sub>$1</sub>")
  .replace(/\^\{([^}]+)\}/g, "<sup>$1</sup>");
const fit = (t, big, mid, small) => (t.length < 170 ? big : t.length < 260 ? mid : small);
const shell = (bg, body) => `<html><head><meta charset="utf-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${bg};font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:86px 82px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
.eyebrow{font-size:23px;letter-spacing:.19em;text-transform:uppercase;font-weight:600}
.rule{width:64px;height:3px;background:${BRAND.mint}}
sub{font-size:.68em;vertical-align:-.18em}sup{font-size:.66em;vertical-align:.45em}
</style></head><body><div class="card">${body}</div></body></html>`;

function slides(q) {
  const one = shell(BRAND.cream, `
  <div class="eyebrow" style="color:${BRAND.muted}">${esc(q.eyebrow)}</div>
  <div class="rule" style="margin:30px 0 0"></div>
  <div style="margin:auto 0">
    <div class="serif" style="font-size:${fit(q.stem, 50, 44, 39)}px;line-height:1.34;color:${BRAND.ink}">${rich(q.stem)}</div>
    <div style="margin-top:46px;display:flex;flex-direction:column;gap:24px">
      ${q.options.map((o) => `<div style="display:flex;gap:20px;align-items:baseline">
        <div class="serif" style="font-size:32px;color:${BRAND.forest};font-weight:700;min-width:30px">${o.slice(0, 1)}</div>
        <div style="font-size:${q.options.join("").length > 200 ? 29 : 32}px;line-height:1.36;color:${BRAND.inkSoft}">${rich(o.replace(/^[A-D]\.\s*/, ""))}</div>
      </div>`).join("")}
    </div>
  </div>
  <div style="display:flex;align-items:flex-end;justify-content:space-between">
    <div class="serif" style="font-size:31px;font-style:italic;color:${BRAND.forest}">Lock in a letter. Then swipe.</div>
    <div class="serif" style="font-size:24px;color:${BRAND.muted}">Praxist Prep</div>
  </div>`);

  const two = shell(BRAND.forest, `
  <div class="eyebrow" style="color:${BRAND.mint}">The answer</div>
  <div style="margin:auto 0">
    <div style="display:flex;align-items:baseline;gap:28px;margin-top:26px">
      <div class="serif" style="font-size:170px;line-height:.9;color:${BRAND.cream}">${esc(q.answer)}</div>
      <div class="serif" style="font-size:40px;line-height:1.26;color:${BRAND.cream}">${rich(q.answer_text)}</div>
    </div>
    <div class="rule" style="margin:44px 0 40px"></div>
    <div style="font-size:${fit(q.explanation, 36, 33, 30)}px;line-height:1.52;color:${BRAND.onForest}">${rich(q.explanation)}</div>
  </div>
  <div class="serif" style="font-size:29px;font-style:italic;color:${BRAND.mint}">Swipe for why the other three fail.</div>`);

  const three = shell(BRAND.cream, `
  <div class="eyebrow" style="color:${BRAND.muted}">Why the others fail</div>
  <div class="rule" style="margin:30px 0 0"></div>
  <div style="margin:auto 0;display:flex;flex-direction:column;gap:32px">
    ${q.distractors.map((d) => `<div style="display:flex;gap:20px;align-items:baseline">
      <div class="serif" style="font-size:30px;color:${BRAND.forest};font-weight:700;min-width:30px">${d.slice(0, 1)}</div>
      <div style="font-size:${q.distractors.join("").length > 420 ? 27 : 30}px;line-height:1.46;color:${BRAND.inkSoft}">${rich(d.replace(/^[A-D]\.\s*/, ""))}</div>
    </div>`).join("")}
    <div style="margin-top:16px;padding:34px 36px;background:${BRAND.creamCard};border-radius:18px">
      <div class="eyebrow" style="font-size:20px;color:${BRAND.forest};margin-bottom:16px">Take this with you</div>
      <div class="serif" style="font-size:31px;line-height:1.44;color:${BRAND.ink}">${rich(q.teaching_point)}</div>
    </div>
  </div>
  <div style="display:flex;align-items:flex-end;justify-content:space-between">
    <div class="serif" style="font-size:28px;font-style:italic;color:${BRAND.forest}">Built one step beyond the real MCAT.</div>
    <div style="font-size:24px;color:${BRAND.muted}">praxistprep.com</div>
  </div>`);
  return [one, two, three];
}

fs.mkdirSync(outDir, { recursive: true });
for (const q of questions) {
  const made = [];
  slides(q).forEach((html, i) => {
    const n = i + 1;
    const htmlPath = path.join(outDir, `.${q.slug}${n}.html`);
    const raw = path.join(outDir, `.${q.slug}${n}.raw.png`);
    const out = path.join(outDir, `${q.slug}_${n}.png`);
    fs.writeFileSync(htmlPath, html);
    execFileSync(CHROME, ["--headless=new", "--disable-gpu", "--hide-scrollbars",
      "--force-device-scale-factor=2", `--window-size=${W},${H}`,
      `--screenshot=${raw}`, `file://${htmlPath}`], { stdio: "ignore" });
    execFileSync("magick", [raw, "-resize", `${W}x${H}`, "-strip", "-quality", "95", out]);
    fs.unlinkSync(htmlPath); fs.unlinkSync(raw);
    made.push(out);
  });
  console.log(`${q.slug}  answer ${q.answer}  closest live question: ${(100 * q._overlap.score).toFixed(0)}% overlap`);
  made.forEach((f) => console.log(`   ${f}`));
}
