/*
 * Text-only statement slide at 1080x1350. For announcements and closing CTA
 * cards, where a screenshot would only get in the way.
 *
 *   node scripts/instagram/make_slide.mjs --eyebrow "Opening" --big "October 13" \
 *     --small "2026" --body "..." --cta "Claim early access at praxistprep.com" \
 *     --out marketing/instagram/site_4_date.png
 *
 * Refuses em dashes and outcome promises, same as the other generators.
 */
import { execFileSync } from "child_process";
import fs from "fs";
import path from "path";

const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const W = 1080, H = 1350;
const B = { cream:"#FBF8F2", forest:"#1F4D3C", mint:"#86D2B6", ink:"#1C1B19", muted:"#8A8578", onForest:"#DCE8E1" };

const args = process.argv.slice(2);
const arg = (n, d="") => { const i = args.indexOf(n); return i>=0 ? args[i+1] : d; };
const out = arg("--out"), theme = arg("--theme","forest");
const eyebrow = arg("--eyebrow"), big = arg("--big"), small = arg("--small");
const body = arg("--body"), cta = arg("--cta"), sig = arg("--sig","Questions built one step beyond the real MCAT.");
if (!out || !big) { console.error('usage: --big "October 13" [--small "2026"] [--eyebrow ..] [--body ..] [--cta ..] [--theme forest|cream] --out file.png'); process.exit(1); }

const all = [eyebrow, big, small, body, cta, sig].join(" ");
if (/[—–]/.test(all)) { console.error("BLOCKED: em or en dash in copy. Brand rule: no dashes."); process.exit(1); }
if (/\b(guarantee|guaranteed|score increase|raise your score|\+\d+\s*points?)\b/i.test(all)) {
  console.error("BLOCKED: reads as an outcome promise."); process.exit(1);
}

const bg   = theme === "cream" ? B.cream : B.forest;
const fg   = theme === "cream" ? B.ink : B.cream;
const soft = theme === "cream" ? B.muted : B.onForest;
const acc  = theme === "cream" ? B.forest : B.mint;
const esc = (s) => String(s).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");
const bigSize = big.length > 14 ? 108 : big.length > 10 ? 128 : 150;

const html = `<html><head><meta charset="utf-8"><style>
*{margin:0;padding:0;box-sizing:border-box}
body{width:${W}px;height:${H}px;background:${bg};font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}
.card{width:100%;height:100%;padding:86px 82px;display:flex;flex-direction:column}
.serif{font-family:Georgia,"Times New Roman",serif}
</style></head><body><div class="card">
  ${eyebrow ? `<div style="font-size:23px;letter-spacing:.2em;text-transform:uppercase;color:${acc};font-weight:600">${esc(eyebrow)}</div>` : ""}
  <div style="margin:auto 0">
    <div class="serif" style="font-size:${bigSize}px;line-height:1.02;color:${fg};letter-spacing:-.01em">${esc(big)}</div>
    ${small ? `<div class="serif" style="margin-top:10px;font-size:64px;line-height:1;color:${acc}">${esc(small)}</div>` : ""}
    <div style="width:64px;height:3px;background:${acc};margin:44px 0 38px"></div>
    ${body ? `<div style="font-size:34px;line-height:1.5;color:${soft};max-width:820px">${esc(body)}</div>` : ""}
  </div>
  <div>
    ${sig ? `<div class="serif" style="font-size:31px;font-style:italic;color:${acc};line-height:1.35">${esc(sig)}</div>` : ""}
    ${cta ? `<div style="margin-top:30px;padding-top:28px;border-top:1px solid ${theme==="cream"?"rgba(28,27,25,.16)":"rgba(251,248,242,.22)"};font-size:29px;color:${fg}">${esc(cta)}</div>` : ""}
  </div>
</div></body></html>`;

const dir = path.dirname(path.resolve(out));
fs.mkdirSync(dir, { recursive: true });
const th = path.join(dir, ".slide.html"), tp = path.join(dir, ".slide.raw.png");
fs.writeFileSync(th, html);
execFileSync(CHROME, ["--headless=new","--disable-gpu","--hide-scrollbars","--force-device-scale-factor=2",`--window-size=${W},${H}`,`--screenshot=${tp}`,`file://${th}`], { stdio:"ignore" });
execFileSync("magick", [tp,"-resize",`${W}x${H}`,"-strip","-quality","95", out]);
fs.unlinkSync(th); fs.unlinkSync(tp);
console.log("wrote", out);
