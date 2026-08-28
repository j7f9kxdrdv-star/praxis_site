/*
 * Product screenshot tool.
 *
 * Drives headless Chrome over the DevTools protocol so JavaScript can run
 * BEFORE the shutter fires. A plain `chrome --screenshot` is not enough here
 * for two reasons: the marketing page hides its copy until a scroll-reveal
 * observer fires, and the dev server may still be compiling on first hit.
 *
 *   node scripts/instagram/shoot.mjs --url http://localhost:3000/ --out home.png \
 *        --width 1280 --height 860 [--wait-for "text to wait for"] [--reveal] [--full]
 *
 * Nothing leaves this machine. No credentials are read or written.
 */
import { spawn } from "child_process";
import fs from "fs";
import path from "path";

const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const PORT = 9333;
const args = process.argv.slice(2);
const arg = (n, d = null) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : d; };
const flag = (n) => args.includes(n);

const url = arg("--url");
const out = arg("--out");
const width = parseInt(arg("--width", "1280"), 10);
const height = parseInt(arg("--height", "860"), 10);
const waitFor = arg("--wait-for");
const scale = parseFloat(arg("--scale", "2"));
if (!url || !out) { console.error('usage: --url <url> --out <file.png> [--width n] [--height n] [--wait-for "text"] [--reveal] [--full]'); process.exit(1); }

// A persistent profile lets a human log in ONCE in a visible window; every
// later shot reuses that session headlessly. No password is ever handled here.
const persistent = arg("--profile");
const profile = persistent || fs.mkdtempSync(path.join("/tmp", "shoot-"));
if (persistent) fs.mkdirSync(persistent, { recursive: true });
const chrome = spawn(CHROME, [
  "--headless=new", "--disable-gpu", "--hide-scrollbars", "--mute-audio",
  "--no-first-run", "--no-default-browser-check",
  `--remote-debugging-port=${PORT}`, `--user-data-dir=${profile}`,
  "about:blank",
], { stdio: "ignore" });

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function wsUrl() {
  for (let i = 0; i < 60; i++) {
    try {
      const r = await fetch(`http://127.0.0.1:${PORT}/json/version`);
      const j = await r.json();
      if (j.webSocketDebuggerUrl) return j.webSocketDebuggerUrl;
    } catch {}
    await sleep(250);
  }
  throw new Error("Chrome did not expose a debugging endpoint");
}

const ws = new WebSocket(await wsUrl());
await new Promise((res, rej) => { ws.onopen = res; ws.onerror = rej; });

let msgId = 0;
const pending = new Map();
ws.onmessage = (e) => {
  const m = JSON.parse(e.data);
  if (m.id && pending.has(m.id)) { pending.get(m.id)(m); pending.delete(m.id); }
};
const send = (method, params = {}, sessionId) => new Promise((resolve) => {
  const id = ++msgId;
  pending.set(id, resolve);
  ws.send(JSON.stringify({ id, method, params, sessionId }));
});

const { result: target } = await send("Target.createTarget", { url: "about:blank" });
const { result: attached } = await send("Target.attachToTarget", { targetId: target.targetId, flatten: true });
const S = attached.sessionId;

await send("Page.enable", {}, S);
await send("Runtime.enable", {}, S);
await send("Emulation.setDeviceMetricsOverride", {
  width, height, deviceScaleFactor: scale, mobile: width < 768,
}, S);

const evaluate = async (expr) => {
  const r = await send("Runtime.evaluate", { expression: expr, returnByValue: true, awaitPromise: true }, S);
  return r.result?.result?.value;
};

await send("Page.navigate", { url }, S);

// Wait for the document AND for the dev server to finish compiling.
for (let i = 0; i < 120; i++) {
  await sleep(500);
  const state = await evaluate("document.readyState");
  const compiling = await evaluate("/Compiling/.test(document.body ? document.body.innerText : '')");
  const long = await evaluate("document.body ? document.body.innerText.length : 0");
  if (state === "complete" && !compiling && long > 200) break;
}

// --js runs an expression right after load, before any waiting. Use it to
// drive the UI into the state worth photographing (start a session, open a
// panel) without a human at the keyboard.
const beforeJs = arg("--js");
if (beforeJs) { await evaluate(beforeJs); await sleep(1200); }

// --wait-js polls an arbitrary expression. Dashboard numbers arrive well after
// load, so waiting on readyState alone captures zeroed placeholders that look
// like an empty account.
const waitJs = arg("--wait-js");
if (waitJs) {
  let ok = false;
  for (let i = 0; i < 160; i++) {
    if (await evaluate(`!!(${waitJs})`)) { ok = true; break; }
    await sleep(500);
  }
  if (!ok) { console.error(`TIMEOUT: --wait-js never became true, refusing to shoot a half-loaded page:\n  ${waitJs}`); ws.close(); chrome.kill(); process.exit(2); }
  await sleep(900);
}

if (waitFor) {
  for (let i = 0; i < 120; i++) {
    const found = await evaluate(`document.body.innerText.includes(${JSON.stringify(waitFor)})`);
    if (found) break;
    await sleep(500);
  }
}

if (flag("--reveal")) {
  await evaluate(`
    document.querySelectorAll('.reveal-element').forEach(e => {
      e.classList.add('revealed','is-visible','in-view');
      e.style.opacity = '1'; e.style.transform = 'none'; e.style.transition = 'none';
    });
    document.querySelectorAll('*').forEach(e => {
      const cs = getComputedStyle(e);
      if (cs.animationName && cs.animationName !== 'none') e.style.animation = 'none';
    });
    // The Next.js dev badge is not part of the product; never ship it in a shot.
    document.querySelectorAll('nextjs-portal,[data-nextjs-toast],#__next-build-watcher').forEach(e => e.remove());
    true;
  `);
  await sleep(700);
}

const scrollY = parseInt(arg("--scroll", "0"), 10);
if (scrollY) { await evaluate(`window.scrollTo({top:${scrollY},behavior:'instant'}); true`); await sleep(500); }

const params = { format: "png", captureBeyondViewport: false };
if (flag("--full")) {
  const h = await evaluate("document.documentElement.scrollHeight");
  await send("Emulation.setDeviceMetricsOverride", { width, height: h, deviceScaleFactor: scale, mobile: width < 768 }, S);
  await sleep(500);
  params.captureBeyondViewport = true;
}

const shot = await send("Page.captureScreenshot", params, S);
const b64 = shot.result?.data;
if (!b64) { console.error("capture failed:", JSON.stringify(shot).slice(0, 300)); process.exit(1); }
fs.mkdirSync(path.dirname(path.resolve(out)), { recursive: true });
fs.writeFileSync(out, Buffer.from(b64, "base64"));

const title = await evaluate("document.title");
const textLen = await evaluate("document.body.innerText.length");
console.log(`shot: ${out}  title="${title}"  textChars=${textLen}`);

ws.close();
chrome.kill();
if (!persistent) fs.rmSync(profile, { recursive: true, force: true });
