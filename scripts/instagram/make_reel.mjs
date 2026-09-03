/*
 * Instagram REEL for a question of the day. Vertical 9:16 video.
 *
 *   node scripts/instagram/make_reel.mjs                      # every question
 *   node scripts/instagram/make_reel.mjs --slug parallel-power
 *
 * WHY A REEL AND NOT THE CAROUSEL. Reels reach people who do not already
 * follow the account, which a post does not. The trade is that a Reel cannot
 * hold an explanation: it is watched, not read. So this shows the question and
 * nothing else, and the interaction lives in a comment poll where people
 * commit to a letter in public.
 *
 * The countdown is the whole mechanic. It gives a viewer a reason to stay for
 * the full clip, which is what the platform measures, and a reason to answer
 * before they scroll.
 *
 * Novelty is enforced exactly as in make_qotd.mjs: these must not spend a
 * question that already sits behind the paywall.
 *
 * ffmpeg here is built without libfreetype, so there is no drawtext filter.
 * The countdown is therefore rendered as real frames in Chrome, which also
 * typesets far better than an overlay would.
 */
import { createClient } from "@supabase/supabase-js";
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const ROOT = process.cwd();
const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1920;
const COUNT_FROM = 5;
const BRAND = {
  cream: "#FBF8F2", creamCard: "#F1EADC", forest: "#1F4D3C", mint: "#86D2B6",
  ink: "#1C1B19", inkSoft: "#3A382F", muted: "#8A8578", onForest: "#DCE8E1",
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
  for (const [f, v] of Object.entries({ stem: q.stem, ...Object.fromEntries(q.options.map((o, i) => [`option ${i}`, o])) })) {
    if (/[—–]/.test(v)) { console.error(`BLOCKED ${q.slug}: em or en dash in ${f}`); process.exit(1); }
  }
}

const esc = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
const rich = (s) => esc(s).replace(/_\{([^}]+)\}/g, "<sub>$1</sub>").replace(/\^\{([^}]+)\}/g, "<sup>$1</sup>");
const fit = (t, big, mid, small) => (t.length < 170 ? big : t.length < 260 ? mid : small);

/** One frame. `count` null means no timer yet; `cta` swaps the footer. */
function frame(q, count, cta) {
  const ring = count === null ? "" : `
    <div style="position:relative;width:132px;height:132px;display:flex;align-items:center;justify-content:center">
      <svg width="132" height="132" style="position:absolute;transform:rotate(-90deg)">
        <circle cx="66" cy="66" r="58" fill="none" stroke="${BRAND.creamCard}" stroke-width="7"/>
        <circle cx="66" cy="66" r="58" fill="none" stroke="${BRAND.mint}" stroke-width="7"
          stroke-linecap="round" stroke-dasharray="${2 * Math.PI * 58}"
          stroke-dashoffset="${2 * Math.PI * 58 * (1 - count / COUNT_FROM)}"/>
      </svg>
      <div class="serif" style="font-size:60px;color:${BRAND.forest};font-weight:700">${count}</div>
    </div>`;
  return `<html><head><meta charset="utf-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${BRAND.cream};font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:150px 92px 130px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
.eyebrow{font-size:26px;letter-spacing:.2em;text-transform:uppercase;font-weight:600}
sub{font-size:.68em;vertical-align:-.18em}sup{font-size:.66em;vertical-align:.45em}
</style></head><body><div class="card">
  <div class="eyebrow" style="color:${BRAND.muted}">${esc(q.eyebrow)}</div>
  <div style="width:70px;height:3px;background:${BRAND.mint};margin:32px 0 0"></div>
  <div style="margin:auto 0">
    <div class="serif" style="font-size:${fit(q.stem, 62, 55, 48)}px;line-height:1.3;color:${BRAND.ink}">${rich(q.stem)}</div>
    <div style="margin-top:64px;display:flex;flex-direction:column;gap:30px">
      ${q.options.map((o) => `<div style="display:flex;gap:24px;align-items:baseline">
        <div class="serif" style="font-size:38px;color:${BRAND.forest};font-weight:700;min-width:38px">${o.slice(0, 1)}</div>
        <div style="font-size:${q.options.join("").length > 200 ? 35 : 38}px;line-height:1.34;color:${BRAND.inkSoft}">${rich(o.replace(/^[A-D]\.\s*/, ""))}</div>
      </div>`).join("")}
    </div>
  </div>
  <div style="display:flex;align-items:center;justify-content:space-between">
    <div>
      <div class="serif" style="font-size:${cta ? 44 : 38}px;font-style:italic;color:${BRAND.forest};line-height:1.28">
        ${cta ? "Vote in the poll below." : "Pick your letter."}</div>
      <div style="margin-top:16px;font-size:27px;color:${BRAND.muted};letter-spacing:.02em">Praxist Prep</div>
    </div>
    ${ring}
  </div>
</div></body></html>`;
}

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
  const work = path.join(outDir, `.${q.slug}_frames`);
  fs.mkdirSync(work, { recursive: true });

  // read the stem, then the countdown, then the call to vote
  const plan = [{ count: null, cta: false, hold: 3.0 }];
  for (let c = COUNT_FROM; c >= 1; c--) plan.push({ count: c, cta: false, hold: 1.0 });
  plan.push({ count: null, cta: true, hold: 2.5 });

  const list = [];
  plan.forEach((p, i) => {
    const png = path.join(work, `f${String(i).padStart(2, "0")}.png`);
    shoot(frame(q, p.count, p.cta), png);
    list.push(`file '${png}'`, `duration ${p.hold}`);
  });
  // concat demuxer ignores the final duration unless the last file repeats
  list.push(`file '${path.join(work, `f${String(plan.length - 1).padStart(2, "0")}.png`)}'`);
  const listFile = path.join(work, "frames.txt");
  fs.writeFileSync(listFile, list.join("\n"));

  const mp4 = path.join(outDir, `${q.slug}_reel.mp4`);
  execFileSync("ffmpeg", ["-y", "-f", "concat", "-safe", "0", "-i", listFile,
    "-vf", "fps=30,format=yuv420p,fade=t=in:st=0:d=0.4",
    "-c:v", "libx264", "-preset", "slow", "-crf", "18",
    "-movflags", "+faststart", mp4], { stdio: "ignore" });
  fs.rmSync(work, { recursive: true, force: true });

  const dur = execFileSync("ffprobe", ["-v", "error", "-show_entries", "format=duration",
    "-of", "default=nw=1:nk=1", mp4]).toString().trim();
  const size = (fs.statSync(mp4).size / 1024 / 1024).toFixed(1);
  console.log(`${q.slug}  ${Number(dur).toFixed(1)}s  ${size} MB  ${W}x${H}  (${(100 * q._overlap).toFixed(0)}% overlap with the bank)`);
  console.log(`   ${mp4}`);
}
