/*
 * Threshold behaviour report for the topic-state model.
 *
 *   node scripts/learner/calibration-report.mjs
 *
 * Reads every constant from lib/learner/topicState.ts rather than restating
 * them, so this file cannot drift from the model it documents. If a threshold
 * moves, the report moves with it and the numbers below are regenerated, not
 * edited.
 *
 * Nothing here touches the database. It is pure arithmetic over the model.
 */
import path from "path";
import { pathToFileURL } from "url";
import { register } from "node:module";

const HERE = path.dirname(new URL(import.meta.url).pathname);
const ROOT = path.resolve(HERE, "../..");
register(pathToFileURL(path.join(HERE, "ts-loader.mjs")).href, pathToFileURL(HERE + "/"));

const T = await import(`${ROOT}/lib/learner/topicState.ts`);
const {
  wilsonLowerBound, topicState, topicPriority, isPriorityResolved,
  isImprovement, TOPIC_MODEL_VERSION, MIN_ATTEMPTS_FOR_STATE, BANDS,
  HYSTERESIS, PRIORITY_ENTER, PRIORITY_EXIT, MIN_ATTEMPTS_TO_RESOLVE,
} = T;

const pct = (n) => `${(100 * n).toFixed(1)}%`;
const f3 = (n) => n.toFixed(3);
const rule = (n = 92) => console.log("-".repeat(n));

console.log(`\nTOPIC MODEL ${TOPIC_MODEL_VERSION}  threshold behaviour report`);
console.log(`generated ${new Date().toISOString().slice(0, 10)}\n`);

console.log("CONSTANTS AS IMPLEMENTED");
rule();
console.log(`  min attempts for any state        ${MIN_ATTEMPTS_FOR_STATE}`);
console.log(`  band floors (Wilson lower bound)   DEVELOPING >= ${BANDS.developing}   STABLE >= ${BANDS.stable}   STRONG >= ${BANDS.strong}`);
console.log(`  hysteresis margin                 ${HYSTERESIS}`);
console.log(`  priority ENTERS below             ${PRIORITY_ENTER}`);
console.log(`  priority EXITS at or above        ${PRIORITY_EXIT}`);
console.log(`  min attempts to resolve priority  ${MIN_ATTEMPTS_TO_RESOLVE}`);
console.log(`  Wilson z                          1.96  (95% two-sided)\n`);

/* ── Table 1: the requested score grids ─────────────────────────────────── */
function grid(n, corrects) {
  console.log(`\nOUT OF ${n}`);
  rule();
  console.log("  score    raw      Wilson lb   band                    priority   can resolve?");
  rule();
  for (const c of corrects) {
    const lb = wilsonLowerBound(c, n);
    // previous = null, so this is the band on first measurement, with no
    // hysteresis applied. That is the honest "what does this evidence alone
    // say" reading.
    const band = topicState(c, n, null);
    const p = topicPriority(c, n, band, false);
    const resolvable = isPriorityResolved(true, c, n);
    console.log(
      `  ${String(c).padStart(2)}/${n}` +
      `  ${pct(c / n).padStart(7)}` +
      `   ${f3(lb).padStart(9)}` +
      `   ${band.padEnd(22)}` +
      `  ${(p.isPriority ? "PRIORITY" : "-").padEnd(9)}` +
      `  ${resolvable ? "yes" : "no"}`
    );
  }
}

grid(8, [4, 5, 6, 7, 8]);
grid(12, [6, 7, 8, 9, 10, 11, 12]);
grid(20, [10, 12, 14, 15, 16, 17, 18, 19]);

/* ── Table 2: trajectories ──────────────────────────────────────────────── */
//
// A trajectory is where the model earns or loses trust, because each step
// carries the PREVIOUS state in. Hysteresis only exists on this axis.
function trajectory(name, steps) {
  console.log(`\n\nTRAJECTORY: ${name}`);
  rule();
  console.log("  step        raw      Wilson lb   state                   moved?         priority");
  rule();
  let prev = null;
  let wasPriority = false;
  for (const [c, n] of steps) {
    const lb = wilsonLowerBound(c, n);
    const state = topicState(c, n, prev);
    const p = topicPriority(c, n, state, false);
    const improved = isImprovement(prev, state);
    const resolved = isPriorityResolved(wasPriority, c, n);

    let moved = "-";
    if (improved) moved = "IMPROVED";
    else if (prev && prev !== state && prev !== "INSUFFICIENT_EVIDENCE" && state !== "INSUFFICIENT_EVIDENCE") moved = "DECLINED";
    else if (prev === "INSUFFICIENT_EVIDENCE" && state !== "INSUFFICIENT_EVIDENCE") moved = "first measured";

    let pri = p.isPriority ? "PRIORITY" : "-";
    if (resolved) pri = "RESOLVED";

    console.log(
      `  ${String(c).padStart(2)}/${String(n).padEnd(3)}` +
      `    ${pct(c / n).padStart(7)}` +
      `   ${f3(lb).padStart(9)}` +
      `   ${state.padEnd(22)}` +
      `  ${moved.padEnd(14)}` +
      ` ${pri}`
    );
    prev = state;
    wasPriority = resolved ? false : p.isPriority;
  }
}

trajectory("steady improvement (the spec's example)", [[3, 8], [7, 12], [13, 18], [18, 24]]);
trajectory("one lucky correct answer on a weak topic", [[6, 14], [7, 15], [7, 16]]);
trajectory("one unlucky miss on a good topic", [[13, 15], [13, 16], [14, 17]]);
trajectory("hovering on the DEVELOPING/STABLE boundary", [
  [30, 45], [31, 46], [31, 47], [32, 48], [32, 49], [33, 50],
]);
trajectory("a real sustained decline", [[34, 40], [36, 50], [38, 60], [40, 70], [42, 80]]);
trajectory("priority earned back slowly", [[4, 14], [8, 20], [14, 28], [22, 38], [30, 48]]);

console.log("\n");
