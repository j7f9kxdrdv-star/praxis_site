// Immutable pre-state for the final governance migration, and every
// pre-application check from the approval. Time is stamped BEFORE the reads, so
// a "did this row move after the snapshot" test can use the row's own
// timestamps without racing the snapshot itself.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/govern/pre_state.json";
if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}`);
  process.exit(0);
}
const MAN = JSON.parse(fs.readFileSync("scratchpad/review/manifest.json", "utf8"));
const QUEUE = JSON.parse(fs.readFileSync("scratchpad/review/rows.json", "utf8"));
const ROW17 = "7d0c69e5-1e1d-4061-826a-dd4ad94dc426";
const SYNTH = "066ad4c3-e5b1-49b4-b8a2-951a8f721eed";

const C  = await all("concepts", "id,slug,canonical_name,status,description,version,object_type");
const F  = await all("flashcards", "id,deck_id,position,card_type,cloze_text,cloze_count,front_text,back_text,explanation,tags");
const Q  = await all("questions", "id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const S  = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R  = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating,prev_interval_days,new_interval_days,stability,difficulty");
const QA = await all("question_attempts", "id");

const fail = [];
let checks = 0;
const must = (label, cond, detail = "") => { checks++; console.log(`${cond ? "  ok  " : " FAIL "} ${label}${detail ? "  :: " + detail : ""}`); if (!cond) fail.push(label); };
const live = (d) => (d.table === "flashcard_concepts"
  ? FC.find((r) => r.flashcard_id === d.item_id && r.concept_id === d.old_concept_id)
  : QC.find((r) => r.question_id === d.item_id && r.concept_id === d.old_concept_id));

console.log("PRE-APPLICATION VALIDATION\n");
const reviewed = MAN.decisions;
must("manifest holds exactly 29 reviewed existing rows", reviewed.length === 29, `${reviewed.length}`);
must("row numbers are exactly 1..29, no repeats", JSON.stringify(reviewed.map((d) => d.row)) === JSON.stringify([...Array(29)].map((_, i) => i + 1)));
must("every decision carries a reviewer, timestamp and rationale",
  reviewed.every((d) => d.reviewer && d.timestamp && d.rationale && d.rationale.length > 10));
must("every decision resolves to HUMAN_VALIDATED", reviewed.every((d) => d.resulting_mapping_status === "HUMAN_VALIDATED"));

const found = reviewed.map(live);
must("all 29 rows still exist live", found.every(Boolean));
must("all 29 are still NEEDS_REVIEW", found.every((r) => r && r.mapping_status === "NEEDS_REVIEW"),
  [...new Set(found.filter(Boolean).map((r) => r.mapping_status))].join("/"));
must("every row still points at the approved concept and role",
  reviewed.every((d, i) => found[i] && found[i].concept_id === d.approved_concept_id && found[i].role === d.approved_role));
must("no reviewed row drifted from the queue captured at review start",
  reviewed.every((d) => { const q = QUEUE.find((x) => x.n === d.row), r = live(d);
    return q && r && q.concept_id === r.concept_id && q.role === r.role && q.source === r.source && q.mapping_status === r.mapping_status; }));
must("no reviewed row has a reviewed_at or reviewed_by already set",
  found.every((r) => r && r.reviewed_at === null && r.reviewed_by === null));

const adds = reviewed.flatMap((d) => (d.additions || []).map((a) => ({ ...a, row: d.row })));
must("exactly two approved new SECONDARY mappings", adds.length === 2, `${adds.length}`);
must("both additions are SECONDARY", adds.every((a) => a.role === "SECONDARY"));
must("neither addition already exists (no duplicate mapping)",
  adds.every((a) => !FC.some((r) => r.flashcard_id === a.item_id && r.concept_id === a.concept_id)));
must("neither addition targets a DEPRECATED concept",
  adds.every((a) => C.find((c) => c.id === a.concept_id)?.status !== "DEPRECATED"));
must("both additions target a CONTENT object", adds.every((a) => C.find((c) => c.id === a.concept_id)?.object_type === "CONTENT"));
must("both addition items already hold a PRIMARY elsewhere, so no PRIMARY is created",
  adds.every((a) => FC.some((r) => r.flashcard_id === a.item_id && r.role === "PRIMARY")));

const dupPrimary = (rows, key) => { const m = new Map();
  for (const r of rows.filter((r) => r.role === "PRIMARY")) m.set(r[key], (m.get(r[key]) || 0) + 1);
  return [...m.entries()].filter(([, n]) => n > 1); };
must("one PRIMARY per flashcard holds now", dupPrimary(FC, "flashcard_id").length === 0);
must("one PRIMARY per question holds now", dupPrimary(QC, "question_id").length === 0);
must("no HUMAN_VALIDATED mapping exists anywhere yet",
  ![...FC, ...QC].some((r) => r.mapping_status === "HUMAN_VALIDATED"));
must("no mapping carries source HUMAN_REVIEWED yet", ![...FC, ...QC].some((r) => r.source === "HUMAN_REVIEWED"));
must("the only NEEDS_REVIEW rows in the database are these 29",
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 29);

const synth = C.find((c) => c.id === SYNTH);
must("the definition target exists and is ACTIVE", synth && synth.status !== "DEPRECATED", synth?.canonical_name);
must("the definition target has no description to overwrite", !synth?.description, JSON.stringify(synth?.description));
const r17 = F.find((f) => f.id === ROW17);
must("row 17's card exists and is a cloze card", r17 && r17.card_type === "cloze");
must("row 17's card text still contains the loose wording", r17 && /dietary uptake/.test(r17.cloze_text || ""));
must("row 17's card has exactly the two clozes c1 and c2", r17 && /\{\{c1::/.test(r17.cloze_text) && /\{\{c2::/.test(r17.cloze_text) && !/\{\{c3::/.test(r17.cloze_text));

const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`).sort();
const reviewRows = R.map((r) => `${r.id}|${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.reviewed_at}|${r.rating}|${r.prev_interval_days}|${r.new_interval_days}|${r.stability}|${r.difficulty}`).sort();
const dist = (rows, k) => rows.reduce((a, r) => ((a[r[k]] = (a[r[k]] || 0) + 1), a), {});

const snap = {
  takenAt: TAKEN_AT,
  purpose: "Pre-state for the final lipid-split governance migration: 29 rows to HUMAN_VALIDATED, 2 new SECONDARY rows, one concept definition, one card rewording. Immutable.",
  reviewedRows: reviewed.map((d, i) => ({ row: d.row, table: d.table, item_id: d.item_id, concept_id: d.approved_concept_id,
    role: d.approved_role, liveBefore: found[i] })),
  additions: adds,
  row17Card: { ...r17,
    schedulerRows: S.filter((r) => r.flashcard_id === ROW17).sort((a, b) => a.cloze_index - b.cloze_index || String(a.user_id).localeCompare(String(b.user_id))),
    reviews: R.filter((r) => r.flashcard_id === ROW17).sort((a, b) => String(a.id).localeCompare(String(b.id))),
    mappings: FC.filter((r) => r.flashcard_id === ROW17) },
  definitionTarget: synth,
  totals: { concepts: C.length, flashcards: F.length, questions: Q.length,
    flashcardConceptRows: FC.length, questionConceptRows: QC.length, reasoningObjectRows: QRO.length,
    cardsWithAMapping: new Set(FC.map((r) => r.flashcard_id)).size,
    questionsWithAContentMapping: new Set(QC.map((r) => r.question_id)).size,
    fcStatus: dist(FC, "mapping_status"), fcSource: dist(FC, "source"),
    qcStatus: dist(QC, "mapping_status"), qcSource: dist(QC, "source") },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
    fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex"),
    reviewDigest: crypto.createHash("sha256").update(reviewRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
if (fail.length) { console.error(`\nSTOP. ${fail.length} pre-application check(s) failed. No snapshot written, no SQL generated.`); process.exit(1); }
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/govern/pre_fsrs_rows.txt", fsrsRows.join("\n"));
fs.writeFileSync("scratchpad/govern/pre_review_rows.txt", reviewRows.join("\n"));
console.log(`\nall ${checks} pre-application checks passed\nWROTE ${OUT}  sha256 ${snap.sha256.slice(0, 16)}`);
console.log(`\ntotals        ${JSON.stringify(snap.totals.fcStatus)} cards / ${JSON.stringify(snap.totals.qcStatus)} questions`);
console.log(`coverage      cards ${snap.totals.cardsWithAMapping}/${snap.totals.flashcards}, questions ${snap.totals.questionsWithAContentMapping}/${snap.totals.questions}`);
console.log(`learner       ${snap.learnerBaseline.schedulerRows} scheduler, ${snap.learnerBaseline.reviewRows} reviews, ${snap.learnerBaseline.attemptRows} attempts`);
console.log(`row 17 card   ${snap.row17Card.schedulerRows.length} scheduler row(s), ${snap.row17Card.reviews.length} review(s), cloze_count=${snap.row17Card.cloze_count}`);
