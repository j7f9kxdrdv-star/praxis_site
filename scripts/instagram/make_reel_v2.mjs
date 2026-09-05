/*
 * Instagram REEL, second generation. Vertical 9:16.
 *
 *   node scripts/instagram/make_reel_v2.mjs --template a
 *   node scripts/instagram/make_reel_v2.mjs --template b --slug competitive-inhibition
 *   node scripts/instagram/make_reel_v2.mjs --all-templates --slug competitive-inhibition
 *
 * WHY THIS EXISTS. Reel #1 ran 10 seconds and was skipped by 68.6% of viewers,
 * with a 4.0s average watch. The instinct is to blame the hook or the
 * difficulty. The arithmetic says otherwise:
 *
 *   competitive-inhibition   59 words   17.7s to read at 200wpm
 *   parallel-power           57 words   17.1s
 *   weak-acid-ka             38 words   11.4s
 *
 * All three were physically unreadable inside 10 seconds, and a countdown was
 * running the whole time. A viewer landed on a wall of text with a timer
 * draining and understood immediately that they could not finish. Leaving at
 * four seconds is the rational response, not a failure of interest.
 *
 * So the question does not get simpler. The PRESENTATION stops fusing two
 * different jobs into one panicked block:
 *
 *   READING TIME   calm, untimed, no pressure, generous type
 *   DECIDING TIME  timed, and the countdown belongs only here
 *
 * Every template below separates those two. They differ in how the stem
 * arrives and how hard they work to stop a scroll.
 *
 * ffmpeg here is built without libfreetype, so there is no drawtext filter.
 * Frames are rendered in Chrome, which typesets far better anyway.
 */
import { createClient } from "@supabase/supabase-js";
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const ROOT = process.cwd();
const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1920;

const BRAND = {
  cream: "#FBF8F2", creamCard: "#F1EADC", forest: "#1F4D3C", mint: "#86D2B6",
  ink: "#1C1B19", inkSoft: "#3A382F", muted: "#8A8578",
};

const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const only = arg("--slug");
const allTemplates = args.includes("--all-templates");
const wanted = allTemplates ? ["a", "b", "c"] : [(arg("--template") || "a").toLowerCase()];
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

// ─── Gates, unchanged from v1 ──────────────────────────────────────────────
// These questions must never be ones already sitting behind the paywall, and
// must never carry an em dash, which reads as machine-written.
const STOP = new Set(("a an the of to in is are was were which what most likely following "
  + "for on at by with from that this these those it its as be been and or if then than "
  + "does do did can could would should will not no more less than into during").split(" "));
const bag = (s) => new Set(String(s).toLowerCase().replace(/[_^{}]/g, " ")
  .replace(/[^a-z0-9\s]/g, " ").split(/\s+/).filter((w) => w.length > 2 && !STOP.has(w)));
const jaccard = (a, b) => { let h = 0; for (const w of a) if (b.has(w)) h++; return h / (a.size + b.size - h); };

const bank = [];
for (let from = 0; ; from += 1000) {
  const { data, error } = await db.from("questions").select("id, question_text")
    .order("id", { ascending: true }).range(from, from + 999);
  if (error) { console.error("bank read failed:", error.message); process.exit(1); }
  if (!data.length) break;
  bank.push(...data); if (data.length < 1000) break;
}
const bankBags = bank.map((q) => ({ q, bag: bag(q.question_text) }));
for (const q of questions) {
  const mine = bag(q.stem);
  let worst = 0, hit = null;
  for (const b of bankBags) { const s = jaccard(mine, b.bag); if (s > worst) { worst = s; hit = b.q; } }
  q._overlap = worst;
  if (worst >= 0.45) {
    console.error(`BLOCKED ${q.slug}: ${(100 * worst).toFixed(0)}% overlap with a live question`);
    console.error(`  ${hit.question_text.slice(0, 120)}`); process.exit(1);
  }
  const fields = { stem: q.stem, ...Object.fromEntries(q.options.map((o, i) => [`option ${i}`, o])) };
  for (const [f, v] of Object.entries(fields)) {
    if (/[—–]/.test(v)) { console.error(`BLOCKED ${q.slug}: em or en dash in ${f}`); process.exit(1); }
  }
}

// ─── Typesetting ───────────────────────────────────────────────────────────
const esc = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

/**
 * Notation, plus quiet emphasis on the SYMBOLS a reader must hold in mind.
 *
 * A symbol carrying a subscript (K_m, V_max, k_cat) is a variable the question
 * turns on. Setting those in the brand green with a heavier weight gives the
 * eye anchors to jump between, so a dense stem can be skimmed for structure
 * before it is read for meaning. It is emphasis in service of reading speed,
 * not decoration, so it is deliberately subtle: no highlight, no colour block.
 */
const rich = (s, emphasise = true) => {
  let out = esc(s)
    .replace(/([A-Za-z])_\{([^}]+)\}/g, (m, base, sub) => emphasise
      ? `<span class="var">${base}<sub>${sub}</sub></span>`
      : `${base}<sub>${sub}</sub>`)
    .replace(/_\{([^}]+)\}/g, "<sub>$1</sub>")
    .replace(/\^\{([^}]+)\}/g, "<sup>$1</sup>");
  return out;
};

/** Split a stem into reading beats at sentence boundaries. */
function clauses(stem) {
  const parts = stem.match(/[^.?!]+[.?!]+/g) || [stem];
  return parts.map((p) => p.trim()).filter(Boolean);
}

const wordCount = (q) =>
  (q.stem + " " + q.options.join(" ")).replace(/[_^]\{([^}]+)\}/g, "$1").split(/\s+/).filter(Boolean).length;

/** Stem size: bigger than v1 across the board, since readability is the point. */
const stemSize = (t) => (t.length < 150 ? 66 : t.length < 210 ? 60 : t.length < 270 ? 54 : 50);
const optSize = (q) => (q.options.join("").length > 200 ? 38 : 41);

const SHELL = `
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${BRAND.cream};
  font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:132px 88px 120px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
.hook{font-size:30px;letter-spacing:.19em;text-transform:uppercase;font-weight:700;color:${BRAND.forest}}
.eyebrow{font-size:25px;letter-spacing:.17em;text-transform:uppercase;font-weight:600;color:${BRAND.muted}}
.var{color:${BRAND.forest};font-weight:700}
sub{font-size:.66em;vertical-align:-.19em}sup{font-size:.64em;vertical-align:.46em}
.opt{display:flex;gap:26px;align-items:baseline}
.optl{font-size:40px;color:${BRAND.forest};font-weight:700;min-width:40px}
`;

/** The countdown ring. Only ever drawn during the DECIDING phase. */
function ring(count, from) {
  if (count === null) return `<div style="width:124px;height:124px"></div>`;
  const r = 55, c = 2 * Math.PI * r;
  return `<div style="position:relative;width:124px;height:124px;display:flex;align-items:center;justify-content:center">
    <svg width="124" height="124" style="position:absolute;transform:rotate(-90deg)">
      <circle cx="62" cy="62" r="${r}" fill="none" stroke="${BRAND.creamCard}" stroke-width="6"/>
      <circle cx="62" cy="62" r="${r}" fill="none" stroke="${BRAND.mint}" stroke-width="6"
        stroke-linecap="round" stroke-dasharray="${c}" stroke-dashoffset="${c * (1 - count / from)}"/>
    </svg>
    <div class="serif" style="font-size:56px;color:${BRAND.forest};font-weight:700">${count}</div>
  </div>`;
}

function options(q, shown) {
  return `<div style="display:flex;flex-direction:column;gap:${q.options.length > 4 ? 24 : 29}px">
    ${q.options.map((o, i) => `<div class="opt" style="opacity:${i < shown ? 1 : 0}">
      <div class="serif optl">${o.slice(0, 1)}</div>
      <div style="font-size:${optSize(q)}px;line-height:1.32;color:${BRAND.inkSoft}">${rich(o.replace(/^[A-D]\.\s*/, ""))}</div>
    </div>`).join("")}
  </div>`;
}

/**
 * One frame.
 *   hook      the line across the top
 *   stemHtml  the stem as it stands at this beat
 *   shown     how many options are visible
 *   count     countdown value, or null for the untimed reading phase
 *   footer    the line bottom-left
 */
function frame({ q, hook, stemHtml, shown, count, from, footer, footerStrong }) {
  return `<html><head><meta charset="utf-8"><style>${SHELL}</style></head>
<body><div class="card">
  <div style="display:flex;justify-content:space-between;align-items:baseline">
    <div class="hook">${esc(hook)}</div>
  </div>
  <div style="width:64px;height:3px;background:${BRAND.mint};margin:26px 0 0"></div>
  <div class="eyebrow" style="margin-top:26px">${esc(q.eyebrow)}</div>

  <div style="margin:auto 0">
    <div class="serif" style="font-size:${stemSize(q.stem)}px;line-height:1.42;color:${BRAND.ink}">${stemHtml}</div>
    <div style="margin-top:${shown ? 70 : 70}px">${options(q, shown)}</div>
  </div>

  <div style="display:flex;align-items:center;justify-content:space-between">
    <div>
      <div class="serif" style="font-size:${footerStrong ? 46 : 40}px;font-style:italic;color:${BRAND.forest};line-height:1.26">${esc(footer)}</div>
      <div style="margin-top:14px;font-size:26px;color:${BRAND.muted};letter-spacing:.02em">Praxist Prep</div>
    </div>
    ${ring(count, from)}
  </div>
</div></body></html>`;
}

// ─── The three templates ───────────────────────────────────────────────────
//
// Each returns a plan: an array of { html, hold } beats.

/**
 * A. STAGED REVEAL. 14s.
 *
 * The stem is on screen whole from the first frame with NO timer, so the
 * opening second reads as an invitation rather than a stopwatch. Options fade
 * in at 6s, and only then does the countdown start. The viewer physically
 * cannot answer before 6s, which is the structural reason average watch time
 * should rise: playing the game requires staying.
 */
/**
 * Timing is DERIVED FROM THE QUESTION, never fixed.
 *
 * Reading rate is taken as 200 words per minute, a generous figure for dense
 * prose on a phone. The reading phase covers 60% of the stem's read time
 * rather than all of it, because the stem does not vanish when the options
 * arrive: it stays on screen for the whole clip, so the remainder is finished
 * during the decision phase. Covering 100% here would push a 40-word stem past
 * 20 seconds for no gain.
 *
 * The decision phase covers reading the four options in full, plus three
 * seconds to actually reason.
 *
 * The ten second cap on that phase is deliberate and is NOT to be raised when
 * a question does not fit. It is a forcing function: if the options cannot be
 * read and weighed inside ten seconds, the OPTIONS are too long, and the fix
 * is to tighten them rather than to lengthen the Reel. Reel #1 failed because
 * a question was allowed to outgrow its format, and raising the cap each time
 * that happens reproduces the same failure more slowly.
 *
 * Under four seconds of reading is the failure that sank Reel #1; over eight
 * is dead air. Under six seconds to decide is not a decision.
 */
export function timeA(q) {
  const wc = (s) => String(s).replace(/[_^]\{([^}]+)\}/g, "$1").split(/\s+/).filter(Boolean).length;
  const stemWords = wc(q.stem);
  const optWords = q.options.reduce((a, o) => a + wc(o), 0);
  const WPM = 200;
  const stemRead = (stemWords / WPM) * 60;
  const optRead = (optWords / WPM) * 60;
  // REASONING TIME DOES NOT SCALE WITH OPTION LENGTH. A calculation question
  // has four numeric answers, perhaps eight words in total, and still needs ten
  // seconds of actual arithmetic. Sizing the decision phase from how long the
  // options take to READ would give it three, which is the Reel #1 failure in
  // miniature: enough time to see the question, not enough to answer it.
  //
  // A question counts as a calculation when its options are numeric, which is
  // what "short answers, long thinking" looks like from the outside.
  const numericOptions = q.options.filter((o) =>
    /^[A-D][.)]\s*[-+]?[\d.,]+/.test(String(o).trim())
  ).length;
  const isCalculation = numericOptions >= 3;
  const reasoningBuffer = isCalculation ? 8 : 3;

  const read = Math.min(8, Math.max(4, Math.round(stemRead * 0.6)));
  let decide = Math.min(10, Math.max(6, Math.round(optRead + reasoningBuffer)));

  // THE LOOP IS THE EXTRA THINKING TIME, so the clip does not have to be.
  //
  // Reel #2 measured a 7.0s average watch on a 12s clip, with the options
  // appearing at 6s. Viewers were leaving about one second after the answers
  // arrived, which means the countdown beyond that was barely watched and was
  // costing completion percentage for nothing. Completion is one of the
  // strongest ranking signals Instagram has.
  //
  // The same reel logged 1.61 plays per viewer, 20 replays across 33 people.
  // So a 10s clip watched 1.6 times gives a student 16 seconds with the
  // question AND a strong completion signal, where a 15s clip abandoned at 7s
  // gives the same thinking and a weak one. Ending nearer where viewers
  // actually leave restarts the loop instead of trailing off.
  //
  // The DECISION phase absorbs the squeeze, never the reading phase: reading
  // too little is what sank Reel #1, and it is the fix that is working.
  const MAX_TOTAL = 11;
  const DECIDE_FLOOR = 5;
  if (read + decide > MAX_TOTAL) {
    decide = Math.max(DECIDE_FLOOR, MAX_TOTAL - read);
  }
  const total = read + decide;
  return { read, decide, total, stemWords, optWords, stemRead, optRead, isCalculation,
           overLength: total > MAX_TOTAL };
}

function planA(q) {
  const hook = "MCAT Question of the Day";
  const stem = rich(q.stem);
  const t = timeA(q);
  const p = [];
  // The reading phase is cut into beats only so the encoder has frames to work
  // with; nothing changes on screen during it.
  const beats = Math.max(2, Math.round(t.read / 2.5));
  for (let i = 0; i < beats; i++) {
    p.push({ hold: t.read / beats, q, hook, stemHtml: stem, shown: 0, count: null, from: t.decide, footer: "Read carefully." });
  }
  for (let c = t.decide; c >= 1; c--) {
    p.push({
      hold: 1.0, q, hook, stemHtml: stem, shown: 4, count: c, from: t.decide,
      footer: c <= 2 ? "Lock in your answer below." : "Pick your letter.",
      footerStrong: c <= 2,
    });
  }
  return { seconds: t.total, beats: p, timing: t };
}

/**
 * B. CLAUSE CASCADE. 13s.
 *
 * The stem assembles one sentence at a time. The first frame therefore shows a
 * single line rather than a wall, which is the version of this that a scroller
 * can absorb in the half second they give it, and the build itself is motion,
 * which is what actually stops a thumb. Options land together, then the clock.
 */
function planB(q) {
  const hook = "Can you reason through this?";
  const cl = clauses(q.stem);
  // Every clause is always PRESENT; the unrevealed ones are merely transparent.
  // Rendering only the revealed clauses would let the block grow beat by beat,
  // and since it is vertically centred the whole stem would creep upward as it
  // built. Text that moves while it is being read costs more than the reveal
  // gains, so the full height is reserved from the first frame and only opacity
  // changes.
  const upTo = (n) => cl
    .map((c, i) => `<span style="opacity:${i < n ? 1 : 0}">${rich(c)}</span>`)
    .join(" ");
  const p = [];
  const perClause = cl.length > 2 ? 1.6 : 2.2;
  for (let i = 1; i <= cl.length; i++) {
    p.push({ hold: perClause, q, hook, stemHtml: upTo(i), shown: 0, count: null, from: 7, footer: "Read carefully." });
  }
  const full = upTo(cl.length);
  p.push({ hold: 1.0, q, hook, stemHtml: full, shown: 4, count: null, from: 7, footer: "Four choices." });
  for (let c = 7; c >= 1; c--) {
    p.push({
      hold: 1.0, q, hook, stemHtml: full, shown: 4, count: c, from: 7,
      footer: c <= 2 ? "Vote in the poll below." : "Pick your letter.",
      footerStrong: c <= 2,
    });
  }
  const seconds = p.reduce((a, b) => a + b.hold, 0);
  return { seconds: Math.round(seconds), beats: p };
}

/**
 * C. STATIC PREMIUM. 12s.
 *
 * The closest to Reel #1, corrected rather than rethought: everything visible
 * from the first frame, but with larger type, more leading, variables
 * emphasised, and a countdown that starts at 12 instead of racing. The control
 * case. Lowest risk to the brand, smallest expected gain, and the honest
 * baseline the other two should have to beat.
 */
function planC(q) {
  const hook = "MCAT Question of the Day";
  const stem = rich(q.stem);
  const p = [];
  for (let c = 12; c >= 1; c--) {
    p.push({
      hold: 1.0, q, hook, stemHtml: stem, shown: 4, count: c, from: 12,
      footer: c <= 2 ? "Vote in the poll below." : "Pick your letter.",
      footerStrong: c <= 2,
    });
  }
  return { seconds: 12, beats: p };
}

const PLANS = { a: planA, b: planB, c: planC };

function shoot(html, out) {
  const tmp = out.replace(/\.png$/, ".html");
  const raw = out.replace(/\.png$/, ".raw.png");
  fs.writeFileSync(tmp, html);
  execFileSync(CHROME, ["--headless=new", "--disable-gpu", "--hide-scrollbars",
    "--force-device-scale-factor=1", `--window-size=${W},${H}`,
    `--screenshot=${raw}`, `file://${tmp}`], { stdio: "ignore" });
  execFileSync("magick", [raw, "-resize", `${W}x${H}!`, "-strip", out]);
  fs.unlinkSync(tmp); fs.unlinkSync(raw);
}

fs.mkdirSync(outDir, { recursive: true });
for (const q of questions) {
  for (const t of wanted) {
    const make = PLANS[t];
    if (!make) { console.error(`unknown template "${t}"`); process.exit(1); }
    const { seconds, beats, timing } = make(q);
    if (timing) {
      console.log(`  timing derived: stem ${timing.stemWords}w needs ${timing.stemRead.toFixed(1)}s to read, `
        + `options ${timing.optWords}w needs ${timing.optRead.toFixed(1)}s`);
      console.log(`  -> ${timing.read}s reading (no timer) + ${timing.decide}s deciding = ${timing.total}s`
        + (timing.isCalculation ? "   [calculation]" : "")
        + (timing.overLength ? "   [OVER LENGTH: the stem is too long to trim further]" : ""));
    }
    const work = path.join(outDir, `.${q.slug}_${t}_frames`);
    fs.mkdirSync(work, { recursive: true });

    const list = [];
    beats.forEach((b, i) => {
      const png = path.join(work, `f${String(i).padStart(2, "0")}.png`);
      shoot(frame(b), png);
      list.push(`file '${png}'`, `duration ${b.hold}`);
    });
    // The concat demuxer drops the last frame's duration unless the file is
    // repeated; the repeat then inherits a duration of its own, so -t clamps.
    list.push(`file '${path.join(work, `f${String(beats.length - 1).padStart(2, "0")}.png`)}'`);
    const listFile = path.join(work, "frames.txt");
    fs.writeFileSync(listFile, list.join("\n"));

    const mp4 = path.join(outDir, `${q.slug}_reel_${t}.mp4`);
    execFileSync("ffmpeg", ["-y", "-f", "concat", "-safe", "0", "-i", listFile,
      "-t", String(seconds),
      "-vf", `fps=30,format=yuv420p,fade=t=in:st=0:d=0.3,fade=t=out:st=${(seconds - 0.3).toFixed(2)}:d=0.3`,
      "-c:v", "libx264", "-preset", "slow", "-crf", "18",
      "-movflags", "+faststart", mp4], { stdio: "ignore" });
    fs.rmSync(work, { recursive: true, force: true });

    const dur = execFileSync("ffprobe", ["-v", "error", "-show_entries", "format=duration",
      "-of", "default=nw=1:nk=1", mp4]).toString().trim();
    const size = (fs.statSync(mp4).size / 1024 / 1024).toFixed(1);
    console.log(`${q.slug}  template ${t.toUpperCase()}  ${Number(dur).toFixed(1)}s  ${size} MB  ${wordCount(q)} words`);
    console.log(`   ${mp4}`);
  }
}
