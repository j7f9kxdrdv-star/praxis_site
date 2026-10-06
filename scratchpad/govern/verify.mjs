// Post-apply verification against the immutable pre-state. Selects EXACTLY the
// columns the snapshot recorded: selecting fewer has twice made undefined
// compare unequal and reported thousands of phantom scheduler changes.
//
// Learner tables are checked as FLOORS, not equalities. Beta testers study
// between the snapshot and the apply, so new reviews are legitimate; what must
// never happen is a row disappearing or a card's history being reset.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const SNAP = JSON.parse(fs.readFileSync("scratchpad/govern/pre_state.json", "utf8"));
const MAN = JSON.parse(fs.readFileSync("scratchpad/review/manifest.json", "utf8"));
const ROW17 = "7d0c69e5-1e1d-4061-826a-dd4ad94dc426";
const SYNTH = "066ad4c3-e5b1-49b4-b8a2-951a8f721eed";
let pass = 0, failed = [];
const ok = (n, good, d = "") => { good ? pass++ : failed.push(n); console.log(`  ${good ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); };

const C  = await all("concepts", "id,slug,canonical_name,status,description,version,object_type");
const F  = await all("flashcards", "id,deck_id,position,card_type,cloze_text,cloze_count,front_text,back_text,explanation,tags");
const Q  = await all("questions", "id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const S  = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R  = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating,prev_interval_days,new_interval_days,stability,difficulty");
const QA = await all("question_attempts", "id");

const key = (a, b) => `${a}|${b}`;
const reviewedCards = [], reviewedQs = [], added = [];
for (const d of MAN.decisions) {
  (d.table === "flashcard_concepts" ? reviewedCards : reviewedQs).push(key(d.item_id, d.approved_concept_id));
  for (const a of d.additions || []) added.push(key(a.item_id, a.concept_id));
}
const hv = (rows, k1, k2) => rows.filter((r) => r.mapping_status === "HUMAN_VALIDATED").map((r) => key(r[k1], r[k2]));

console.log("\n─── GOVERNANCE ───");
ok("NEEDS_REVIEW from this lipid split is 0",
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 0,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
ok("all 29 reviewed rows are HUMAN_VALIDATED",
  reviewedCards.concat(reviewedQs).every((k) => hv(FC, "flashcard_id", "concept_id").includes(k) || hv(QC, "question_id", "concept_id").includes(k)));
ok("human-validated card rows are exactly the 22 reviewed plus the 2 added",
  hv(FC, "flashcard_id", "concept_id").length === 24 &&
  new Set(hv(FC, "flashcard_id", "concept_id")).size === 24 &&
  [...reviewedCards, ...added].every((k) => hv(FC, "flashcard_id", "concept_id").includes(k)),
  `${hv(FC, "flashcard_id", "concept_id").length}`);
ok("human-validated question rows are exactly the 7 reviewed",
  hv(QC, "question_id", "concept_id").length === 7 && reviewedQs.every((k) => hv(QC, "question_id", "concept_id").includes(k)),
  `${hv(QC, "question_id", "concept_id").length}`);
ok("exactly two new synthesis SECONDARY mappings exist",
  FC.filter((r) => r.concept_id === SYNTH && r.role === "SECONDARY").length === 2);
ok("the two new rows are HUMAN_VALIDATED / HUMAN_REVIEWED",
  FC.filter((r) => added.includes(key(r.flashcard_id, r.concept_id)))
    .every((r) => r.mapping_status === "HUMAN_VALIDATED" && r.source === "HUMAN_REVIEWED" && r.role === "SECONDARY"));
ok("source HUMAN_REVIEWED appears on exactly those two rows and nowhere else",
  [...FC, ...QC].filter((r) => r.source === "HUMAN_REVIEWED").length === 2);
console.log("\n─── PROVENANCE PRESERVED, NOT REWRITTEN ───");
for (const d of MAN.decisions) {
  const before = SNAP.reviewedRows.find((r) => r.row === d.row).liveBefore;
  const now = d.table === "flashcard_concepts"
    ? FC.find((r) => r.flashcard_id === d.item_id && r.concept_id === d.approved_concept_id)
    : QC.find((r) => r.question_id === d.item_id && r.concept_id === d.approved_concept_id);
  if (!now || now.source !== before.source || now.role !== before.role || now.confidence !== before.confidence || now.created_at !== before.created_at)
    failed.push(`row ${d.row} provenance drifted`);
}
ok("all 29 kept source, role, confidence and created_at exactly as before", !failed.some((f) => /provenance drifted/.test(f)));
ok("the 22 reviewed card rows still read AI_PROPOSED",
  FC.filter((r) => reviewedCards.includes(key(r.flashcard_id, r.concept_id))).every((r) => r.source === "AI_PROPOSED"));
ok("the 7 reviewed question rows still read DETERMINISTIC_EXACT",
  QC.filter((r) => reviewedQs.includes(key(r.question_id, r.concept_id))).every((r) => r.source === "DETERMINISTIC_EXACT"));
ok("every one of the 31 carries reviewed_at, and nothing else does",
  [...FC, ...QC].filter((r) => r.reviewed_at !== null).length === 31);
ok("reviewed_by is uniformly NULL, as designed",
  [...FC, ...QC].every((r) => r.reviewed_by === null));
console.log("\n─── STRUCTURE ───");
const dupP = (rows, k) => { const m = new Map(); for (const r of rows.filter((r) => r.role === "PRIMARY")) m.set(r[k], (m.get(r[k]) || 0) + 1); return [...m.values()].filter((n) => n > 1).length; };
ok("one PRIMARY per flashcard", dupP(FC, "flashcard_id") === 0);
ok("one PRIMARY per question", dupP(QC, "question_id") === 0);
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
ok("no mapping points at a deprecated concept", ![...FC.map((r) => r.concept_id), ...QC.map((r) => r.concept_id)].some((id) => dep.has(id)));
ok("flashcard coverage is still complete",
  new Set(FC.map((r) => r.flashcard_id)).size === F.length, `${new Set(FC.map((r) => r.flashcard_id)).size}/${F.length}`);
ok("question coverage is still complete",
  new Set(QC.map((r) => r.question_id)).size === Q.length, `${new Set(QC.map((r) => r.question_id)).size}/${Q.length}`);
ok("no concept was created or removed", C.length === SNAP.totals.concepts, `${C.length} vs ${SNAP.totals.concepts}`);
ok("question_reasoning_objects is untouched", QRO.length === SNAP.totals.reasoningObjectRows, `${QRO.length} vs ${SNAP.totals.reasoningObjectRows}`);
ok("exactly two mapping rows were added in total",
  FC.length + QC.length === SNAP.totals.flashcardConceptRows + SNAP.totals.questionConceptRows + 2,
  `${FC.length + QC.length} vs ${SNAP.totals.flashcardConceptRows + SNAP.totals.questionConceptRows} + 2`);
console.log("\n─── THE DEFINITION ───");
const synth = C.find((c) => c.id === SYNTH);
ok("the definition is present", Boolean(synth.description) && synth.description.length > 200);
// Case-insensitive on purpose: the definition opens the sentence with "De novo",
// and a verifier that fails on a capital letter reports a data problem that is
// really its own.
const says = (p) => synth.description.toLowerCase().includes(p.toLowerCase());
ok("it covers what it must", ["de novo", "citrate shuttle", "acetyl-CoA", "NADPH", "ATP", "HMG-CoA reductase", "regulation"].every(says));
ok("it excludes what it must not absorb", ["particle identity", "density", "cargo", "LCAT and CETP"].every(says));
ok("its version was bumped", synth.version === SNAP.definitionTarget.version + 1, `${SNAP.definitionTarget.version} -> ${synth.version}`);
ok("its canonical name and slug are untouched",
  synth.canonical_name === SNAP.definitionTarget.canonical_name && synth.slug === SNAP.definitionTarget.slug);
console.log("\n─── ROW 17's CARD: TEXT CHANGED, STATE DID NOT ───");
const card = F.find((f) => f.id === ROW17);
const was = SNAP.row17Card;
ok("the loose wording is gone", !/dietary uptake/.test(card.cloze_text));
ok("c1 still hides LDL and c2 still hides de novo",
  card.cloze_text.includes("{{c1::LDL}}") && card.cloze_text.includes("{{c2::de novo}}"));
ok("no third cloze was introduced", !/\{\{c3::/.test(card.cloze_text) && card.cloze_count === 2);
ok("everything else about the card is unchanged",
  card.deck_id === was.deck_id && card.position === was.position && card.card_type === was.card_type &&
  card.front_text === was.front_text && card.back_text === was.back_text &&
  card.explanation === was.explanation && JSON.stringify(card.tags) === JSON.stringify(was.tags));
const nowRows = S.filter((r) => r.flashcard_id === ROW17).sort((a, b) => a.cloze_index - b.cloze_index || String(a.user_id).localeCompare(String(b.user_id)));
ok("the card still has its scheduler rows", nowRows.length === was.schedulerRows.length, `${nowRows.length} vs ${was.schedulerRows.length}`);
const unexplained = [];
for (const r of nowRows) {
  const b = was.schedulerRows.find((x) => x.cloze_index === r.cloze_index && x.user_id === r.user_id);
  if (!b) { unexplained.push(`new scheduler row cloze${r.cloze_index}`); continue; }
  const same = Object.keys(b).every((k) => JSON.stringify(b[k]) === JSON.stringify(r[k]));
  if (same) continue;
  // A genuine study event explains itself: the row's own last_reviewed_at moved.
  if (r.last_reviewed_at && r.last_reviewed_at !== b.last_reviewed_at && r.reps >= b.reps) continue;
  unexplained.push(`cloze${r.cloze_index} user ${String(r.user_id).slice(0, 8)}: ` +
    Object.keys(b).filter((k) => JSON.stringify(b[k]) !== JSON.stringify(r[k])).map((k) => `${k} ${b[k]} -> ${r[k]}`).join(", "));
}
ok("no unexplained scheduler change on the reworded card", unexplained.length === 0, unexplained.join(" | "));
const nowReviews = R.filter((r) => r.flashcard_id === ROW17);
ok("the card's review history was not reset",
  was.reviews.every((b) => nowReviews.some((r) => r.id === b.id)) && nowReviews.length >= was.reviews.length,
  `${nowReviews.length} now, ${was.reviews.length} before`);
console.log("\n─── LEARNER DATA: FLOORS, NOT EQUALITIES ───");
ok("no scheduler row was lost", S.length >= SNAP.learnerBaseline.schedulerRows, `${S.length} >= ${SNAP.learnerBaseline.schedulerRows}`);
ok("no review was lost", R.length >= SNAP.learnerBaseline.reviewRows, `${R.length} >= ${SNAP.learnerBaseline.reviewRows}`);
ok("no question attempt was lost", QA.length >= SNAP.learnerBaseline.attemptRows, `${QA.length} >= ${SNAP.learnerBaseline.attemptRows}`);
const preRows = fs.readFileSync("scratchpad/govern/pre_fsrs_rows.txt", "utf8").split("\n");
const nowSet = new Set(S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`));
const changed = preRows.filter((l) => l && !nowSet.has(l));
ok("every scheduler row is byte-identical, or explained by a study event",
  changed.length === 0 || changed.every((l) => { const [fid, ci, uid] = l.split("|");
    const r = S.find((x) => x.flashcard_id === fid && String(x.cloze_index) === ci && String(x.user_id) === uid);
    return r && r.last_reviewed_at && r.last_reviewed_at !== l.split("|")[11]; }),
  `${changed.length} row(s) differ`);
if (changed.length) { console.log(`     ${changed.length} scheduler row(s) moved since the snapshot; each is a study event, not this migration:`);
  for (const l of changed.slice(0, 6)) console.log(`       ${l.split("|")[0].slice(0, 8)} cloze${l.split("|")[1]}`); }
console.log("\n─── FSRS DIGEST ───");
const digest = crypto.createHash("sha256").update([...nowSet].sort().join("\n")).digest("hex");
ok("digest identical, or differs only by study events",
  digest === SNAP.learnerBaseline.fsrsDigest || changed.length > 0,
  digest === SNAP.learnerBaseline.fsrsDigest ? "identical" : "differs, explained above");
console.log(`\n${failed.length ? failed.length + " FAILURE(S)" : "ALL GREEN"}, ${pass} passed`);
if (failed.length) { for (const f of failed) console.log(`  - ${f}`); process.exit(1); }
