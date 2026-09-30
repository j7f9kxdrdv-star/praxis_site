// IMMUTABLE pre-split snapshot. Written once, never overwritten.
//
// After a split the parent is DEPRECATED and its 28 mappings have moved, so
// there is no way to reconstruct which side each card or question came from.
// The snapshot is the only record. A file that would silently replace good
// evidence with post-hoc evidence is worse than no file, so this refuses.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
import crypto from "node:crypto";

// Stamped BEFORE any read. Stamping it after means a review landing between
// the state read and the stamp looks like an unexplained change later.
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/lipid/pre_split_snapshot.json";
const PARENT = "LIPID_MOBILIZATION_TRANSPORT";

if (fs.existsSync(OUT)) {
  console.log(`REFUSING to overwrite ${OUT}. The pre-split state is not reproducible once the migration runs.`);
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`existing snapshot: taken ${s.takenAt}, sha256 ${s.sha256}, ${s.flashcards.length} cards, ${s.questions.length} questions`);
  process.exit(0);
}

const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level,parent_concept_id,content_category");
const parent = C.find((c) => c.slug === PARENT);
if (!parent) { console.error("STOP: parent concept not found."); process.exit(1); }
if (parent.status === "DEPRECATED") { console.error("STOP: parent is already DEPRECATED. The split may have run."); process.exit(1); }

const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source,created_at,reviewed_at,reviewed_by");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const A = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");

const cards = FC.filter((r) => r.concept_id === parent.id)
  .sort((a, b) => a.flashcard_id.localeCompare(b.flashcard_id));
const questions = QC.filter((r) => r.concept_id === parent.id)
  .sort((a, b) => a.question_id.localeCompare(b.question_id));

// FSRS baseline: a per-row digest, so a later comparison can name WHICH row
// moved rather than only that a total changed. A count cannot see an in-place
// rewrite of 7,000 rows.
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const snap = {
  takenAt: TAKEN_AT,
  purpose: "Pre-state for the Lipid Mobilization & Transport split (migration 2). Immutable.",
  parent: {
    id: parent.id, slug: parent.slug, canonicalName: parent.canonical_name,
    description: parent.description, objectType: parent.object_type, status: parent.status,
    version: parent.version, deprecatedBy: parent.deprecated_by,
    conceptLevel: parent.concept_level, parentConceptId: parent.parent_concept_id,
    contentCategoryColumn: parent.content_category,
    sections: CS.filter((r) => r.concept_id === parent.id),
    disciplines: CD.filter((r) => r.concept_id === parent.id),
    contentCategories: CCC.filter((r) => r.concept_id === parent.id),
    aliases: A.filter((r) => r.concept_id === parent.id),
  },
  flashcards: cards,
  questions,
  totals: {
    concepts: C.length,
    activeConcepts: C.filter((c) => c.status !== "DEPRECATED").length,
    flashcardConcepts: FC.length,
    questionConcepts: QC.length,
    conceptAliases: A.length,
  },
  learnerBaseline: {
    flashcardUserStateRows: S.length,
    flashcardReviewRows: R.length,
    questionAttemptRows: QA.length,
    fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex"),
    latestReviewAt: R.map((r) => r.reviewed_at).sort().pop() ?? null,
  },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/lipid/pre_split_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}`);
console.log(`  parent ${parent.canonical_name}  ${parent.id}  status=${parent.status} version=${parent.version}`);
console.log(`  ${cards.length} flashcard mappings, ${questions.length} question mappings`);
console.log(`  totals: concepts ${C.length}, flashcard_concepts ${FC.length}, question_concepts ${QC.length}`);
console.log(`  learner: ${S.length} scheduler rows, ${R.length} reviews, ${QA.length} attempts`);
console.log(`  fsrs digest ${snap.learnerBaseline.fsrsDigest.slice(0, 16)}...  snapshot sha256 ${snap.sha256.slice(0, 16)}...`);
