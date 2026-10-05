import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/cards/pre_state.json";
const CYTO = "71959e9d-e9e0-4da5-aa03-6286378a591d";
const STRUCT = "4d56a412-90d2-47cb-b0d8-db3a3a06f232";
if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}`);
  process.exit(0);
}
const F = await all("flashcards", "id,deck_id,card_type,front_text,back_text,cloze_text,cloze_count,explanation,tags,position,created_at,back_image_url,back_image_alt");
const D = await all("flashcard_decks", "id,title");
const C = await all("concepts", "id,slug,canonical_name,status,object_type");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,mapping_status");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating,prev_interval_days,new_interval_days,stability,difficulty");
const QA = await all("question_attempts", "id");
const mappedCards = new Set(FC.map((r) => r.flashcard_id));
const card = (id) => { const f = F.find((x) => x.id === id); return { ...f, deckTitle: D.find((d) => d.id === f.deck_id)?.title,
  schedulerRows: S.filter((r) => r.flashcard_id === id).sort((a, b) => a.cloze_index - b.cloze_index || String(a.user_id).localeCompare(String(b.user_id))),
  reviews: R.filter((r) => r.flashcard_id === id).sort((a, b) => a.id.localeCompare(b.id)) }; };
if (mappedCards.has(CYTO) || mappedCards.has(STRUCT)) { console.error("STOP: a target card is already mapped"); process.exit(1); }
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const SEC = ["ca5f08a7-3bc2-493b-8e82-dd2835e122f0", "328bd950-1833-4c3c-902c-a6a514ec322c"];
const snap = {
  takenAt: TAKEN_AT, purpose: "Pre-state for the two CARD_TOO_BROAD repairs (migration 8). Immutable.",
  cytoskeletonCard: card(CYTO), structuralProteinsCard: card(STRUCT),
  secondaryCandidates: SEC.map((id) => ({ ...card(id), currentMappings: FC.filter((r) => r.flashcard_id === id) })),
  elastinConsideredAndDeclined: card("d660225e-9617-4ee1-b7b0-d3d74ff80ba4"),
  totals: { flashcards: F.length, uniqueMappedCards: mappedCards.size, unmappedCards: F.length - mappedCards.size,
            flashcardConceptRows: FC.length, concepts: C.length, questionConcepts: QC.length,
            reasoningObjects: QRO.length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/cards/pre_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}\n`);
for (const [tag, c] of [["CYTOSKELETON", snap.cytoskeletonCard], ["STRUCTURAL PROTEINS", snap.structuralProteinsCard]]) {
  console.log(`${tag}  ${c.id}  ${c.deckTitle} #${c.position}  cloze_count=${c.cloze_count}`);
  console.log(`   ${c.schedulerRows.length} scheduler row(s), ${c.reviews.length} review(s)`);
  c.schedulerRows.forEach((r) => console.log(`     cloze${r.cloze_index} user ${String(r.user_id).slice(0,8)} stab=${r.stability} reps=${r.reps} lapses=${r.lapses} due=${r.next_review_at}`));
}
console.log(`\ntotals ${JSON.stringify(snap.totals)}`);
console.log(`sha256 ${snap.sha256.slice(0, 16)}`);
