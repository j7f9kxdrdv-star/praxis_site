#!/usr/bin/env node
/**
 * Flashcard QC — deterministic quality gate / auditor for cloze decks.
 *
 *   node scripts/flashcard-qc.mjs               # audit ALL live decks
 *   node scripts/flashcard-qc.mjs "Endocrine"   # audit decks whose title contains the string
 *
 * Env (from .env.local): NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
 *
 * Exit code 1 if any HARD FAIL is found (structural breakage that mis-renders or
 * mis-schedules a card). WARNINGS are heuristic "look here" flags — a regex cannot
 * reliably tell a real answer-leak from a coincidental word repeat, so warnings never
 * block. For trustworthy leak detection, run scripts/flashcard-leak-judge.mjs (LLM).
 *
 * HARD FAILS:  nested cloze · cloze_count ≠ distinct-group-count · malformed/empty token
 * WARNINGS:    likely answer-leak · parallel contrast pair in separate groups ·
 *              ASCII chemical formula (should be Unicode) · card longer than ~32 words
 */
import fs from "node:fs";
import path from "node:path";
import { createClient } from "@supabase/supabase-js";

// ── env ──
const envPath = path.join(process.cwd(), ".env.local");
const env = Object.fromEntries(
  fs.readFileSync(envPath, "utf8").split("\n").filter((l) => l.includes("=")).map((l) => {
    const i = l.indexOf("=");
    return [l.slice(0, i).trim(), l.slice(i + 1).trim().replace(/^["']|["']$/g, "")];
  }),
);
const sb = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const FILTER = process.argv[2] || null;
async function withRetry(fn) {
  for (let a = 1; a <= 6; a++) { const r = await fn(); if (!r.error) return r; await new Promise((x) => setTimeout(x, 800 * a)); }
  return fn();
}

// ── cloze helpers ──
const CLOZE = /\{\{c(\d+)::([\s\S]+?)(?:::([\s\S]+?))?\}\}/g;
const clozes = (t) => { const o = []; let m; CLOZE.lastIndex = 0; while ((m = CLOZE.exec(t)) !== null) o.push({ g: +m[1], ans: m[2] }); return o; };
const groupsOf = (t) => [...new Set(clozes(t).map((c) => c.g))].sort((a, b) => a - b);
function nested(t) { let d = 0; for (let i = 0; i < t.length - 1; i++) { if (t[i] === "{" && t[i + 1] === "{") { d++; i++; if (d >= 2) return true; } else if (t[i] === "}" && t[i + 1] === "}") { d--; i++; } } return false; }
function malformed(t) {
  if ((t.match(/\{\{/g) || []).length !== (t.match(/\}\}/g) || []).length) return "brace-imbalance";
  for (const r of t.match(/\{\{c\d+::[\s\S]*?\}\}/g) || []) { const m = r.match(/^\{\{c(\d+)::([\s\S]*?)(?:::([\s\S]*?))?\}\}$/); if (!m || !m[2].trim()) return "empty-or-unparsable-cloze"; }
  if (/\{\{c\d+::(?![\s\S]*?\}\})/.test(t)) return "unclosed-cloze";
  return null;
}
const stripCloze = (t) => t.replace(CLOZE, (_, g, a) => a).replace(/<img[^>]*>/gi, " ");
const wordCount = (t) => (stripCloze(t).match(/[A-Za-z0-9'’.-]+/g) || []).length;
const tokset = (s) => new Set((s.toLowerCase().match(/[a-z][a-z-]{2,}/g) || []));
const GENERIC = new Set("energy water blood oxygen carbon hydrogen nitrogen protein proteins molecule molecules reaction reactions structure surface pressure electron electrons proton protons charge bonded atoms cells tissue muscle muscles force forces motion number system process function membrane concentration solution particle element elements compound chemical positive negative increase decrease higher lower greater smaller between through across within acid acids amino sugar chain chains region level state phase field value point object light sound wave power current voltage the and that with from this these those which into onto".split(/\s+/));
const sig = (s) => [...new Set((s.match(/[A-Za-z][A-Za-z-]{3,}/g) || []).map((w) => w.toLowerCase()))];
const hit = (w, toks) => toks.has(w) || (w.endsWith("s") && toks.has(w.slice(0, -1))) || toks.has(w + "s");

// heuristic answer-leak: a specific answer term (len≥6, non-generic), a full single-word answer,
// or a Greek symbol from the answer recurs in the visible text when its group is masked.
function leak(text) {
  const cl = clozes(text); const found = [];
  for (const g of [...new Set(cl.map((c) => c.g))]) {
    const vis = text.replace(CLOZE, (full, gi, a) => (+gi === g ? " ____ " : a));
    const toks = tokset(vis);
    const ans = cl.filter((c) => c.g === g).map((c) => c.ans).join(" ");
    const sw = sig(ans); if (!sw.length) continue;
    const hits = sw.filter((w) => hit(w, toks));
    const single = sw.length === 1 && hits.length === 1;
    const specific = hits.some((w) => w.length >= 6 && !GENERIC.has(w));
    const greek = [...new Set((ans.match(/[αβγδεζηθλμνξπρστφχψωΔΣΩΘΦΨΠΛ]/g) || []))].filter((s) => (vis.match(new RegExp(s, "g")) || []).length > 0);
    if (single || specific || greek.length) found.push({ g, terms: [...new Set([...hits.filter((w) => w.length >= 6 || single), ...greek])].slice(0, 4) });
  }
  return found;
}
// parallel contrast pair split across separate groups (studying one reveals the other)
function parallelPair(text) {
  const cl = clozes(text); const byG = {}; cl.forEach((c) => { (byG[c.g] = byG[c.g] || []).push(c.ans); });
  const singles = Object.keys(byG).map(Number).filter((g) => byG[g].length === 1 && /^[A-Za-z+\-−]{1,14}$/.test(byG[g][0].trim()));
  return singles.length >= 2 && singles.length <= 3 && text.length < 220 && /\b(and|but|whereas|while)\b|;|,/.test(stripCloze(text)) ? singles : null;
}
const asciiFormula = (t) => { const p = stripCloze(t); return /\b[A-Z][a-z]?[0-9]/.test(p) || /(?:^|[\s(])(?:H\+|OH-|Na\+|K\+|Cl-|HCO3-|NH4\+|e-|H3O\+|Ca2\+|Mg2\+)(?=[\s).,;]|$)/.test(p); };

// ── load ──
const { data: decks } = await withRetry(() => sb.from("flashcard_decks").select("id,title").order("title"));
let targets = decks || [];
if (FILTER) targets = targets.filter((d) => d.title.toLowerCase().includes(FILTER.toLowerCase()));
if (!targets.length) { console.error(FILTER ? `No deck title matches "${FILTER}".` : "No decks found."); process.exit(2); }
const cards = [];
for (let f = 0; ; f += 1000) {
  const { data } = await withRetry(() => sb.from("flashcards").select("id,deck_id,card_type,cloze_text,cloze_count").order("id").range(f, f + 999));
  if (!data || !data.length) break; cards.push(...data); if (data.length < 1000) break;
}
const byDeck = {}; cards.forEach((c) => { (byDeck[c.deck_id] = byDeck[c.deck_id] || []).push(c); });

// ── check ──
let hardTotal = 0, warnTotal = 0; const rows = [];
for (const d of targets) {
  const cs = (byDeck[d.id] || []).filter((c) => c.card_type === "cloze" && c.cloze_text);
  let hard = 0, warn = 0; const detail = [];
  for (const c of cs) {
    const t = c.cloze_text; const H = [], W = [];
    const mf = malformed(t); if (mf) H.push("malformed:" + mf);
    if (nested(t)) H.push("nested-cloze");
    const g = groupsOf(t); const maxg = g.length ? Math.max(...g) : 0;
    if (g.length && (c.cloze_count !== g.length || maxg !== g.length)) H.push(`cloze_count=${c.cloze_count}!=groups[${g.join(",")}]`);
    const lk = leak(t); if (lk.length) W.push("leak " + lk.map((x) => `c${x.g}:${x.terms.join("/")}`).join(" "));
    if (parallelPair(t)) W.push("parallel-pair");
    if (asciiFormula(t)) W.push("ascii-formula");
    const wc = wordCount(t); if (wc > 32) W.push(`long:${wc}w`);
    if (H.length) { hard++; detail.push({ id: c.id, H, t }); } else if (W.length) { warn++; detail.push({ id: c.id, W, t }); }
  }
  hardTotal += hard; warnTotal += warn;
  rows.push({ title: d.title, n: cs.length, hard, warn, detail });
}
rows.sort((a, b) => (b.hard - a.hard) || (b.warn - a.warn));

console.log(`Flashcard QC — ${targets.length} deck(s), ${cards.filter((c) => c.card_type === "cloze").length} cloze cards`);
console.log(`HARD FAILS: ${hardTotal}   WARNINGS: ${warnTotal}\n`);
console.log("deck".padEnd(46), "cards", "hard", "warn");
for (const r of rows) console.log(r.title.slice(0, 45).padEnd(46), String(r.n).padStart(5), String(r.hard).padStart(4), String(r.warn).padStart(4));
const hd = rows.flatMap((r) => r.detail.filter((x) => x.H).map((x) => ({ deck: r.title, ...x })));
if (hd.length) { console.log("\nHARD FAILS (must fix):"); hd.forEach((x) => console.log(` [${x.deck.slice(0, 26)}] ${x.id.slice(0, 8)} ${JSON.stringify(x.H)}\n   ${x.t.slice(0, 150)}`)); }
console.log(`\n${hardTotal ? "FAILED" : "PASSED"} (warnings are advisory; run flashcard-leak-judge.mjs for real leak detection)`);
process.exit(hardTotal ? 1 : 0);
