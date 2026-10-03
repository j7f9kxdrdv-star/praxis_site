// Immutable pre-state for the reducing-sugar boundary repair. Stamped BEFORE
// any read, so a review landing between the reads cannot later look like an
// unexplained change. Refuses to overwrite itself.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/sugar/pre_rename_snapshot.json";
const SLUG_A = "OXIDATION_REDUCING_SUGARS", SLUG_B = "REDUCING_NON_REDUCING_SUGARS";

if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. Pre-rename state is not reproducible once the migration runs.`);
  console.log(`  taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}, A="${s.conceptA.canonicalName}"`);
  process.exit(0);
}
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level,parent_concept_id");
const a = C.find((c) => c.slug === SLUG_A), b = C.find((c) => c.slug === SLUG_B);
if (!a || !b) { console.error("STOP: a concept is missing."); process.exit(1); }
if (a.canonical_name !== "Oxidation & Reducing Sugars") { console.error(`STOP: concept A is already named "${a.canonical_name}"; the rename may have run.`); process.exit(1); }

const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at");
const QA = await all("question_attempts", "id");

const pack = (c) => ({
  id: c.id, slug: c.slug, canonicalName: c.canonical_name, description: c.description,
  objectType: c.object_type, status: c.status, version: c.version, deprecatedBy: c.deprecated_by,
  conceptLevel: c.concept_level, parentConceptId: c.parent_concept_id,
  sections: CS.filter((r) => r.concept_id === c.id),
  disciplines: CD.filter((r) => r.concept_id === c.id),
  contentCategories: CCC.filter((r) => r.concept_id === c.id),
  aliases: AL.filter((r) => r.concept_id === c.id),
  questionMappings: QC.filter((r) => r.concept_id === c.id).sort((x, y) => x.question_id.localeCompare(y.question_id)),
  flashcardMappings: FC.filter((r) => r.concept_id === c.id).sort((x, y) => x.flashcard_id.localeCompare(y.flashcard_id)),
});
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const snap = {
  takenAt: TAKEN_AT,
  purpose: "Pre-state for the reducing-sugar boundary repair (migration 3). Immutable.",
  conceptA: pack(a), conceptB: pack(b),
  totals: { concepts: C.length, questionConcepts: QC.length, flashcardConcepts: FC.length,
            reasoningObjects: QRO.length, aliases: AL.length,
            deprecated: C.filter((c) => c.status === "DEPRECATED").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/sugar/pre_rename_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}`);
console.log(`  A: "${a.canonical_name}" ${a.id} slug=${a.slug} v${a.version}  ${snap.conceptA.questionMappings.length}q ${snap.conceptA.flashcardMappings.length}c`);
console.log(`  B: "${b.canonical_name}" ${b.id} slug=${b.slug} v${b.version}  ${snap.conceptB.questionMappings.length}q ${snap.conceptB.flashcardMappings.length}c`);
console.log(`  totals: ${JSON.stringify(snap.totals)}`);
console.log(`  learner: ${S.length} scheduler, ${R.length} reviews, ${QA.length} attempts`);
console.log(`  sha256 ${snap.sha256.slice(0, 16)}`);
