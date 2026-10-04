// Immutable pre-state for the reaction-type disambiguation (migration 4).
// First cleanup migration to move a FLASHCARD mapping, so the moved card's
// scheduler and review state is captured per row, not just as a total.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/reaction/pre_state.json";
const CARD = "d01a72af-36d7-41d7-bbd5-f683f6047d94";   // Ox-Red #25, metathesis is not redox
const HABER = "641ac692-1819-4b4c-833a-a86bd49bba38";  // theoretical yield of NH3

if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. Pre-state is not reproducible once the migration runs.`);
  console.log(`  taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}, B="${s.conceptB.canonicalName}"`);
  process.exit(0);
}
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level");
const get = (slug) => { const c = C.find((x) => x.slug === slug); if (!c) { console.error("STOP: missing " + slug); process.exit(1); } return c; };
const a = get("TYPES_REACTIONS"), b = get("REACTION_TYPES_CLASSIFICATION"), lr = get("LIMITING_REAGENT_THEORETICAL_PERCENT_YIELD");
if (b.canonical_name !== "Reaction Types & Classification") { console.error(`STOP: B already named "${b.canonical_name}"`); process.exit(1); }

const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating,prev_interval_days,new_interval_days,stability,difficulty");
const QA = await all("question_attempts", "id");

const pack = (c) => ({
  id: c.id, slug: c.slug, canonicalName: c.canonical_name, description: c.description,
  objectType: c.object_type, status: c.status, version: c.version, deprecatedBy: c.deprecated_by,
  sections: CS.filter((r) => r.concept_id === c.id), disciplines: CD.filter((r) => r.concept_id === c.id),
  contentCategories: CCC.filter((r) => r.concept_id === c.id), aliases: AL.filter((r) => r.concept_id === c.id),
  flashcardMappings: FC.filter((r) => r.concept_id === c.id).sort((x, y) => x.flashcard_id.localeCompare(y.flashcard_id)),
  questionMappings: QC.filter((r) => r.concept_id === c.id).sort((x, y) => x.question_id.localeCompare(y.question_id)),
});
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();

const snap = {
  takenAt: TAKEN_AT,
  purpose: "Pre-state for the reaction-type disambiguation and Haber repoint (migration 4). Immutable.",
  conceptA: pack(a), conceptB: pack(b), limitingReagent: pack(lr),
  movedCard: {
    id: CARD,
    mapping: FC.find((r) => r.flashcard_id === CARD),
    // The whole point of capturing this: mapping identity and scheduler state
    // are independent, so moving the mapping must leave every one of these
    // untouched. Captured per row and per review, not as a count.
    schedulerRows: S.filter((r) => r.flashcard_id === CARD),
    reviews: R.filter((r) => r.flashcard_id === CARD).sort((x, y) => x.reviewed_at.localeCompare(y.reviewed_at)),
  },
  haberQuestion: { id: HABER, mapping: QC.find((r) => r.question_id === HABER) },
  totals: { concepts: C.length, flashcardConcepts: FC.length, questionConcepts: QC.length,
            reasoningObjects: QRO.length, aliases: AL.length,
            deprecated: C.filter((c) => c.status === "DEPRECATED").length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/reaction/pre_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}`);
console.log(`  A  "${a.canonical_name}" ${a.id}  ${snap.conceptA.flashcardMappings.length}c ${snap.conceptA.questionMappings.length}q`);
console.log(`  B  "${b.canonical_name}" ${b.id}  ${snap.conceptB.flashcardMappings.length}c ${snap.conceptB.questionMappings.length}q`);
console.log(`  LR "${lr.canonical_name}" ${lr.id}  ${snap.limitingReagent.flashcardMappings.length}c ${snap.limitingReagent.questionMappings.length}q`);
console.log(`  moved card ${CARD}: ${snap.movedCard.schedulerRows.length} scheduler row(s), ${snap.movedCard.reviews.length} review(s)`);
snap.movedCard.schedulerRows.forEach((r) => console.log(`     cloze ${r.cloze_index} user ${String(r.user_id).slice(0,8)} stability=${r.stability} reps=${r.reps} lapses=${r.lapses} due=${r.next_review_at}`));
console.log(`  totals: ${JSON.stringify(snap.totals)}`);
console.log(`  sha256 ${snap.sha256.slice(0, 16)}`);
