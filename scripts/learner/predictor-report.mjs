/*
 * Score-range calibration report.
 *
 *   node scripts/learner/predictor-report.mjs
 *
 * Imports the predictor rather than restating it, so the tables cannot drift
 * from the model. Pure arithmetic; touches no database.
 */
import path from "path";
import { pathToFileURL } from "url";
import { register } from "node:module";
const HERE = path.dirname(new URL(import.meta.url).pathname);
const ROOT = path.resolve(HERE, "../..");
register(pathToFileURL(path.join(HERE, "ts-loader.mjs")).href, pathToFileURL(HERE + "/"));

const { estimateScore, PREDICTOR_VERSION } = await import(`${ROOT}/lib/scoring/scoreEstimate.ts`);

const BANK_TODAY = new Set(["bio_biochem", "chem_phys"]);
const ALL_FOUR = new Set(["bio_biochem", "chem_phys", "cars", "psych_soc"]);
const topics = (k) => new Set(Array.from({ length: k }, (_, i) => `t${i}`));
const rule = (n = 100) => console.log("-".repeat(n));

console.log(`\nSCORE PREDICTOR ${PREDICTOR_VERSION}  calibration report`);
console.log(`generated ${new Date().toISOString().slice(0, 10)}\n`);

function table(title, rows) {
  console.log(`\n${title}`);
  rule();
  console.log("    n   acc%   sections  subtopics  FL    range      width  conf       E      ceiling");
  rule();
  for (const [n, acc, sections, nTopics, fl] of rows) {
    const e = estimateScore(acc, n, sections, topics(nTopics), fl);
    if (e.low === null) {
      console.log(`  ${String(n).padStart(3)}  ${String(acc).padStart(5)}   ${String(4 - e.blindSections.length).padStart(8)}  ${String(nTopics).padStart(9)}  ${fl ? "y" : "n"}     (no estimate: below minimum attempts)`);
      continue;
    }
    const ev = e.evidence;
    console.log(
      `  ${String(n).padStart(3)}  ${String(acc).padStart(5)}   ${String(4 - e.blindSections.length).padStart(8)}` +
      `  ${String(nTopics).padStart(9)}  ${fl ? "y" : "n"}   ${e.low}-${e.high}     ${String(e.high - e.low).padStart(3)}` +
      `   ${e.confidence.padEnd(9)} ${ev.overall.toFixed(3)}   ${Math.round(ev.ceiling)}`
    );
  }
}

// The requested grid, at today's evidence shape: two sections, modest breadth.
table("TODAY'S BANK (2 of 4 sections, 12 subtopics, no full length)",
  [20, 50, 100, 250, 500].flatMap((n) =>
    [60, 75, 90, 95, 100].map((acc) => [n, acc, BANK_TODAY, 12, 0])));

table("BREADTH AT A FIXED 100 QUESTIONS, 95% accuracy", [
  [100, 95, BANK_TODAY, 3, 0],
  [100, 95, BANK_TODAY, 12, 0],
  [100, 95, BANK_TODAY, 30, 0],
  [100, 95, ALL_FOUR, 3, 0],
  [100, 95, ALL_FOUR, 12, 0],
  [100, 95, ALL_FOUR, 30, 0],
]);

table("A FULL EVIDENCE BASE (all four sections, broad, full lengths sat)", [
  [100, 95, ALL_FOUR, 30, 2],
  [250, 95, ALL_FOUR, 30, 2],
  [500, 95, ALL_FOUR, 30, 2],
  [500, 100, ALL_FOUR, 30, 2],
  [800, 100, ALL_FOUR, 30, 2],
  [500, 100, ALL_FOUR, 30, 0],
]);

console.log("\n\nMONOTONICITY CHECKS");
rule();
const ceilingAt = (n, sections = BANK_TODAY, k = 12, fl = 0) =>
  estimateScore(100, n, sections, topics(k), fl).high;
/* The evidence-supported ceiling, which is what the full-length and breadth
 * terms move. Once evidence is deep it stops binding and `high` is set by
 * uncertainty instead, so these checks must read the ceiling directly. */
const evCeilingAt = (n, sections = BANK_TODAY, k = 12, fl = 0) =>
  Math.round(estimateScore(100, n, sections, topics(k), fl).evidence.ceiling);

let ok = true;
const report = (label, pass, detail) => {
  console.log(`  ${pass ? "PASS" : "FAIL"}  ${label}${detail ? "   " + detail : ""}`);
  if (!pass) ok = false;
};

let prev = -Infinity, mono = true;
for (const n of [20, 50, 100, 250, 500, 800]) { const h = ceilingAt(n); if (h < prev) mono = false; prev = h; }
report("ceiling never falls as questions increase", mono,
  `20q=${ceilingAt(20)}  500q=${ceilingAt(500)}`);

report("20/20 no longer reaches the perfect-score ceiling", ceilingAt(20) < 528,
  `20q high = ${ceilingAt(20)}`);

report("500/500 now outranks 20/20", ceilingAt(500) > ceilingAt(20),
  `${ceilingAt(20)} -> ${ceilingAt(500)}`);

report("broader sections raise the ceiling", ceilingAt(250, ALL_FOUR) > ceilingAt(250, BANK_TODAY),
  `2 sections=${ceilingAt(250, BANK_TODAY)}  4 sections=${ceilingAt(250, ALL_FOUR)}`);

report("broader subtopics raise the ceiling", ceilingAt(250, ALL_FOUR, 30) > ceilingAt(250, ALL_FOUR, 3),
  `3 subtopics=${ceilingAt(250, ALL_FOUR, 3)}  30=${ceilingAt(250, ALL_FOUR, 30)}`);

report("a full length raises the evidence ceiling",
  evCeilingAt(500, ALL_FOUR, 30, 2) > evCeilingAt(500, ALL_FOUR, 30, 0),
  `none=${evCeilingAt(500, ALL_FOUR, 30, 0)}  two=${evCeilingAt(500, ALL_FOUR, 30, 2)}`);

report("an elite evidence ceiling is reachable on a full evidence base",
  evCeilingAt(800, ALL_FOUR, 30, 3) >= 525, `best case = ${evCeilingAt(800, ALL_FOUR, 30, 3)}`);

report("the DISPLAYED top reaches 528 on a complete evidence base",
  ceilingAt(800, ALL_FOUR, 30, 3) === 528, `best displayed high = ${ceilingAt(800, ALL_FOUR, 30, 3)}`);

report("and 472 is reachable at the bottom of the scale",
  estimateScore(25, 5000, ALL_FOUR, topics(60), 10).low === 472,
  `worst displayed low = ${estimateScore(25, 5000, ALL_FOUR, topics(60), 10).low}`);

let widthMono = true, pw = Infinity;
for (const n of [20, 50, 100, 250, 500]) {
  const e = estimateScore(90, n, ALL_FOUR, topics(30), 1);
  const w = e.high - e.low; if (w > pw) widthMono = false; pw = w;
}
report("range never widens as evidence grows", widthMono);

let confOk = true;
for (const n of [20, 50, 100]) {
  if (estimateScore(100, n, BANK_TODAY, topics(12), 0).confidence !== "Low") confOk = false;
}
report("thin or half-blind evidence stays Low confidence", confOk);

console.log(`\n  ${ok ? "all monotonicity checks passed" : "SOME CHECKS FAILED"}\n`);
