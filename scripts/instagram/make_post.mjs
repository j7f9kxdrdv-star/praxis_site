/*
 * Instagram "question of the day" generator.
 *
 * Renders a two slide carousel at Instagram's 4:5 portrait size (1080x1350)
 * from a real question in the live bank. Slide 1 is the question on cream,
 * slide 2 is the answer on forest green.
 *
 *   node scripts/instagram/make_post.mjs --id <question-uuid>
 *   node scripts/instagram/make_post.mjs --id <uuid> --overrides post.json
 *
 * IMPORTANT: by default the script renders the question EXACTLY as it is
 * stored. It never rewrites the science to make text fit. If a stem is too
 * long for the card, tighten it by hand in an overrides file:
 *
 *   { "stem": "...", "options": ["A. ...","B. ...","C. ...","D. ..."],
 *     "explanation": "...", "eyebrow": "Biology: Musculoskeletal" }
 *
 * Anything absent from the overrides falls back to the database value.
 */
import { createClient } from "@supabase/supabase-js";
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const ROOT = process.cwd();
const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1350;

const BRAND = {
  cream: "#FBF8F2",
  creamCard: "#F1EADC",
  forest: "#1F4D3C",
  mint: "#86D2B6",
  ink: "#1C1B19",
  inkSoft: "#3A382F",
  muted: "#8A8578",
  onForest: "#DCE8E1",
  rule: "#E6DFD2",
};

const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const id = arg("--id");
const overridesPath = arg("--overrides");
const outDir = arg("--out") || path.join(ROOT, "marketing", "instagram");
if (!id) { console.error("usage: node scripts/instagram/make_post.mjs --id <question-uuid> [--overrides file.json] [--out dir]"); process.exit(1); }

const env = Object.fromEntries(
  fs.readFileSync(path.join(ROOT, ".env.local"), "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()])
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

const { data: q, error } = await db
  .from("questions")
  .select("id, discipline, topic, question_text, options, correct_answer, explanation, difficulty, figure_svg, passage_id")
  .eq("id", id).maybeSingle();
if (error) { console.error("query failed:", error.message); process.exit(1); }
if (!q) { console.error("no question with id", id); process.exit(1); }
if (q.figure_svg || q.passage_id) { console.error("this question needs a figure or passage, so it will not fit a card"); process.exit(1); }

const ov = overridesPath ? JSON.parse(fs.readFileSync(overridesPath, "utf8")) : {};
const dbOptions = (Array.isArray(q.options) ? q.options : JSON.parse(q.options || "[]"))
  .map((o) => `${o.label}. ${o.text}`);

const stem = ov.stem || q.question_text;
const options = ov.options || dbOptions;
const eyebrow = ov.eyebrow || `${q.discipline.replace(/-/g, " ")}: ${q.topic}`;
const answerLabel = q.correct_answer;
const answerText = ov.answer_text || (dbOptions.find((o) => o.startsWith(answerLabel + ".")) || "").replace(/^[A-D]\.\s*/, "");
const explanation = ov.explanation;
if (!explanation) {
  console.error("The database explanation is written for the app, not for a card.");
  console.error("Supply a tightened one in an overrides file as \"explanation\".");
  process.exit(1);
}

for (const [name, val] of Object.entries({ stem, explanation, ...Object.fromEntries(options.map((o, i) => [`option ${i}`, o])) })) {
  if (/[—–]/.test(val)) { console.error(`BLOCKED: an em or en dash is present in ${name}. Brand rule: no dashes in copy.`); process.exit(1); }
}

const esc = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
const fit = (text, big, mid, small) => (text.length < 170 ? big : text.length < 260 ? mid : small);

const shell = (bg, body) => `<html><head><meta charset="utf-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${bg};font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:86px 82px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
.eyebrow{font-size:23px;letter-spacing:.19em;text-transform:uppercase;font-weight:600}
.rule{width:64px;height:3px;background:${BRAND.mint}}
.spacer{margin-top:auto}
</style></head><body><div class="card">${body}</div></body></html>`;

const slide1 = shell(BRAND.cream, `
  <div class="eyebrow" style="color:${BRAND.muted}">${esc(eyebrow)}</div>
  <div class="rule" style="margin:30px 0 0"></div>
  <div style="margin:auto 0">
  <div class="serif" style="font-size:${fit(stem, 52, 46, 40)}px;line-height:1.34;color:${BRAND.ink}">${esc(stem)}</div>
  <div style="margin-top:48px;display:flex;flex-direction:column;gap:26px">
    ${options.map((o) => {
      const letter = o.slice(0, 1);
      const text = o.replace(/^[A-D]\.\s*/, "");
      return `<div style="display:flex;gap:20px;align-items:baseline">
        <div class="serif" style="font-size:32px;color:${BRAND.forest};font-weight:700;min-width:30px">${letter}</div>
        <div style="font-size:${options.join("").length > 260 ? 28 : 31}px;line-height:1.36;color:${BRAND.inkSoft}">${esc(text)}</div>
      </div>`;
    }).join("")}
  </div>
  </div>
  <div style="display:flex;align-items:flex-end;justify-content:space-between">
    <div class="serif" style="font-size:31px;font-style:italic;color:${BRAND.forest}">Lock in a letter. Then swipe.</div>
    <div class="serif" style="font-size:24px;color:${BRAND.muted}">Praxist Prep</div>
  </div>`);

const slide2 = shell(BRAND.forest, `
  <div class="eyebrow" style="color:${BRAND.mint}">The answer</div>
  <div style="margin:auto 0">
  <div style="display:flex;align-items:baseline;gap:28px;margin-top:26px">
    <div class="serif" style="font-size:170px;line-height:.9;color:${BRAND.cream}">${esc(answerLabel)}</div>
    <div class="serif" style="font-size:40px;line-height:1.26;color:${BRAND.cream}">${esc(answerText)}</div>
  </div>
  <div class="rule" style="margin:44px 0 40px"></div>
  <div style="font-size:${fit(explanation, 36, 33, 30)}px;line-height:1.52;color:${BRAND.onForest}">${esc(explanation)}</div>
  </div>
  <div>
    <div class="serif" style="font-size:31px;font-style:italic;color:${BRAND.mint};line-height:1.35">Questions built one step beyond the real MCAT.</div>
    <div style="margin-top:30px;padding-top:28px;border-top:1px solid rgba(251,248,242,.22);font-size:28px;color:${BRAND.cream};letter-spacing:.02em">Claim early access at praxistprep.com</div>
  </div>`);

fs.mkdirSync(outDir, { recursive: true });
const stamp = id.slice(0, 8);
const made = [];
for (const [n, html] of [[1, slide1], [2, slide2]]) {
  const htmlPath = path.join(outDir, `.slide${n}.html`);
  const rawPng = path.join(outDir, `.slide${n}.raw.png`);
  const outPng = path.join(outDir, `${stamp}_slide${n}.png`);
  fs.writeFileSync(htmlPath, html);
  execFileSync(CHROME, ["--headless=new", "--disable-gpu", "--hide-scrollbars",
    "--force-device-scale-factor=2", `--window-size=${W},${H}`,
    `--screenshot=${rawPng}`, `file://${htmlPath}`], { stdio: "ignore" });
  execFileSync("magick", [rawPng, "-resize", `${W}x${H}`, "-strip", "-quality", "95", outPng]);
  fs.unlinkSync(htmlPath); fs.unlinkSync(rawPng);
  made.push(outPng);
}

console.log("question :", q.id, `(${q.discipline} / ${q.topic} / ${q.difficulty})`);
console.log("answer   :", answerLabel);
made.forEach((f) => {
  const d = execFileSync("sips", ["-g", "pixelWidth", "-g", "pixelHeight", f]).toString();
  const w = d.match(/pixelWidth: (\d+)/)?.[1], h = d.match(/pixelHeight: (\d+)/)?.[1];
  console.log(`wrote    : ${f}  ${w}x${h}`);
});
