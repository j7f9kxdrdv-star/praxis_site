// Immutable pre-state for migration 6, and the hand-off manifest for migration 7.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/elements/pre_state.json";
if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}, name "${s.concept.canonicalName}"`);
  process.exit(0);
}
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level,parent_concept_id");
const toe = C.find((c) => c.slug === "TYPES_ELEMENTS");
const pts = C.find((c) => c.slug === "PERIODIC_TABLE_STRUCTURE_CLASSIFICATION");
if (!toe || !pts) { console.error("STOP: a concept is missing"); process.exit(1); }
if (toe.canonical_name !== "Types of Elements") { console.error(`STOP: already named "${toe.canonical_name}"`); process.exit(1); }

const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");
const deck = new Map(D.map((d) => [d.id, d.title]));
const posOf = (id) => { const f = F.find((x) => x.id === id); return { deck: deck.get(f.deck_id), position: f.position, text: (f.cloze_text || "").replace(/\n/g, " ") }; };

// The five that move IN: metal, nonmetal and metalloid character, deck positions 8-12.
const INCOMING = FC.filter((r) => r.concept_id === pts.id)
  .map((r) => ({ ...r, ...posOf(r.flashcard_id) }))
  .filter((r) => r.position >= 8 && r.position <= 12)
  .sort((a, b) => a.position - b.position);
// The nineteen that STAY PUT for now and belong to migration 7.
const FAMILY = FC.filter((r) => r.concept_id === toe.id)
  .map((r) => ({ ...r, ...posOf(r.flashcard_id) }))
  .sort((a, b) => a.position - b.position);

const pack = (c) => ({ id: c.id, slug: c.slug, canonicalName: c.canonical_name, description: c.description,
  objectType: c.object_type, status: c.status, version: c.version, deprecatedBy: c.deprecated_by,
  conceptLevel: c.concept_level, parentConceptId: c.parent_concept_id,
  sections: CS.filter((r) => r.concept_id === c.id), disciplines: CD.filter((r) => r.concept_id === c.id),
  contentCategories: CCC.filter((r) => r.concept_id === c.id), aliases: AL.filter((r) => r.concept_id === c.id),
  flashcardMappings: FC.filter((r) => r.concept_id === c.id).sort((a, b) => a.flashcard_id.localeCompare(b.flashcard_id)),
  questionMappings: QC.filter((r) => r.concept_id === c.id).sort((a, b) => a.question_id.localeCompare(b.question_id)) });

const movedIds = INCOMING.map((r) => r.flashcard_id);
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const snap = {
  takenAt: TAKEN_AT,
  purpose: "Pre-state for the Types of Elements identity repair (migration 6), and the hand-off manifest for migration 7.",
  concept: pack(toe), periodicTableStructure: pack(pts),
  incomingFiveCards: INCOMING,
  // THE HAND-OFF. These 19 keep teaching chemical families while sitting on a
  // concept renamed to Metals, Nonmetals & Metalloids. That mismatch is
  // deliberate and temporary, and migration 7 reads this list to resolve it.
  pendingFamilyCardsForMigration7: FAMILY,
  movedCardLearnerState: {
    schedulerRows: S.filter((r) => movedIds.includes(r.flashcard_id)),
    reviews: R.filter((r) => movedIds.includes(r.flashcard_id)).sort((a, b) => a.reviewed_at.localeCompare(b.reviewed_at)),
  },
  totals: { concepts: C.length, flashcardConcepts: FC.length, questionConcepts: QC.length,
            reasoningObjects: QRO.length, aliases: AL.length,
            deprecated: C.filter((c) => c.status === "DEPRECATED").length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/elements/pre_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}`);
console.log(`  "${toe.canonical_name}" ${toe.id} v${toe.version}  ${snap.concept.flashcardMappings.length}c ${snap.concept.questionMappings.length}q`);
console.log(`  Periodic Table Structure & Classification ${pts.id}  ${snap.periodicTableStructure.flashcardMappings.length}c`);
console.log(`\n  FIVE CARDS MOVING IN:`);
INCOMING.forEach((r) => console.log(`    #${r.position} ${r.flashcard_id.slice(0,8)} [${r.mapping_status}/${r.source}]  ${r.text.slice(0, 72)}`));
console.log(`\n  NINETEEN FAMILY CARDS HANDED TO MIGRATION 7: positions ${FAMILY.map((r) => r.position).join(", ")}`);
const ms = snap.movedCardLearnerState;
console.log(`\n  moved-card learner state: ${ms.schedulerRows.length} scheduler row(s), ${ms.reviews.length} review(s)`);
ms.schedulerRows.forEach((r) => console.log(`    ${r.flashcard_id.slice(0,8)} cloze${r.cloze_index} stability=${r.stability} reps=${r.reps} lapses=${r.lapses}`));
console.log(`\n  totals ${JSON.stringify(snap.totals)}`);
console.log(`  sha256 ${snap.sha256.slice(0, 16)}`);
