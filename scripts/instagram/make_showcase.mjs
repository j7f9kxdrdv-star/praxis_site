/*
 * Turns a product screenshot into a post-ready 1080x1350 Instagram slide.
 *
 *   node scripts/instagram/make_showcase.mjs \
 *     --shot shots/home.png --headline "Six months of building." \
 *     --caption "The site students will actually use." --out marketing/instagram/site1.png
 *
 * Options: --theme forest|cream   --chrome praxistprep.com   --eyebrow "..."
 *
 * The screenshot is embedded as a data URI so the page renders offline, and
 * the browser frame is drawn here rather than screenshotted, so no real URL
 * bar, bookmark, or profile picture from a live browser can leak into a post.
 */
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1350;
const B = { cream:"#FBF8F2", forest:"#1F4D3C", mint:"#86D2B6", ink:"#1C1B19", muted:"#8A8578", onForest:"#DCE8E1" };

const args = process.argv.slice(2);
const arg = (n, d=null) => { const i = args.indexOf(n); return i>=0 ? args[i+1] : d; };
const shot = arg("--shot"), out = arg("--out");
const headline = arg("--headline", "");
const caption = arg("--caption", "");
const eyebrow = arg("--eyebrow", "Praxist Prep");
const theme = arg("--theme", "forest");
const chromeLabel = arg("--chrome", "praxistprep.com");
if (!shot || !out) { console.error('usage: --shot <png> --out <png> [--headline "..."] [--caption "..."] [--theme forest|cream] [--eyebrow "..."] [--chrome "..."]'); process.exit(1); }

for (const [k,v] of Object.entries({headline, caption, eyebrow})) {
  if (/[—–]/.test(v)) { console.error(`BLOCKED: em or en dash in ${k}. Brand rule: no dashes in copy.`); process.exit(1); }
}
if (/\b(guarantee|guaranteed|score increase|raise your score|\+\d+\s*points?)\b/i.test(headline + " " + caption)) {
  console.error("BLOCKED: this reads as an outcome promise. The brand never guarantees a score.");
  process.exit(1);
}

const bg   = theme === "cream" ? B.cream : B.forest;
const fg   = theme === "cream" ? B.ink : B.cream;
const soft = theme === "cream" ? B.muted : B.onForest;
const frameEdge = theme === "cream" ? "rgba(28,27,25,.14)" : "rgba(251,248,242,.20)";
const barBg = theme === "cream" ? "#EDE6D8" : "#173D30";

const b64 = fs.readFileSync(shot).toString("base64");
const esc = (s) => String(s).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
const headSize = headline.length > 42 ? 58 : headline.length > 26 ? 66 : 74;

const html = `<html><head><meta charset="utf-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${bg};font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:76px 72px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
.dot{width:12px;height:12px;border-radius:50%;background:${frameEdge}}
</style></head><body><div class="card">
  <div style="font-size:22px;letter-spacing:.2em;text-transform:uppercase;color:${theme==="cream"?B.muted:B.mint};font-weight:600">${esc(eyebrow)}</div>
  ${headline ? `<div class="serif" style="margin-top:22px;font-size:${headSize}px;line-height:1.16;color:${fg}">${esc(headline)}</div>` : ""}
  <div style="margin:auto 0;width:100%">
    <div style="border:1px solid ${frameEdge};border-radius:14px;overflow:hidden;background:${barBg}">
      <div style="height:46px;display:flex;align-items:center;padding:0 18px;gap:9px;background:${barBg}">
        <div class="dot"></div><div class="dot"></div><div class="dot"></div>
        <div style="margin-left:16px;flex:1;height:26px;border-radius:13px;background:${theme==="cream"?"rgba(28,27,25,.06)":"rgba(251,248,242,.10)"};display:flex;align-items:center;padding:0 14px;font-size:16px;color:${soft};letter-spacing:.02em">${esc(chromeLabel)}</div>
      </div>
      <img src="data:image/png;base64,${b64}" style="display:block;width:100%;height:auto">
    </div>
  </div>
  ${caption ? `<div style="font-size:29px;line-height:1.45;color:${soft}">${esc(caption)}</div>` : ""}
</div></body></html>`;

const dir = path.dirname(path.resolve(out));
fs.mkdirSync(dir, { recursive: true });
const tmpHtml = path.join(dir, ".showcase.html");
const tmpPng  = path.join(dir, ".showcase.raw.png");
fs.writeFileSync(tmpHtml, html);
execFileSync(CHROME, ["--headless=new","--disable-gpu","--hide-scrollbars",
  "--force-device-scale-factor=2",`--window-size=${W},${H}`,
  `--screenshot=${tmpPng}`,`file://${tmpHtml}`], { stdio:"ignore" });
execFileSync("magick", [tmpPng,"-resize",`${W}x${H}`,"-strip","-quality","95", out]);
fs.unlinkSync(tmpHtml); fs.unlinkSync(tmpPng);
const d = execFileSync("sips",["-g","pixelWidth","-g","pixelHeight",out]).toString();
console.log(`wrote ${out}  ${d.match(/pixelWidth: (\d+)/)?.[1]}x${d.match(/pixelHeight: (\d+)/)?.[1]}`);
