import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const OUT = "scratchpad/cards/pre_state_8b.json";
const ID = "4d56a412-90d2-47cb-b0d8-db3a3a06f232";
if (fs.existsSync(OUT)) { const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}`); process.exit(0); }
const takenAt = new Date().toISOString();
const F = await all("flashcards", "id,deck_id,position,cloze_text,cloze_count");
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,mapping_status");
const CS = await all("concept_sections", "concept_id");
const CD = await all("concept_disciplines", "concept_id");
const CCC = await all("concept_content_categories", "concept_id");
const AL = await all("concept_aliases", "concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const sp = C.find((c) => c.slug === "STRUCTURAL_PROTEINS");
const card = F.find((f) => f.id === ID);
const snap = { takenAt, purpose: "Pre-state for the structural-proteins wording correction (migration 8b).",
  card: { ...card, schedulerRows: S.filter((r) => r.flashcard_id === ID).sort((a, b) => a.cloze_index - b.cloze_index),
          reviews: R.filter((r) => r.flashcard_id === ID).sort((a, b) => a.id.localeCompare(b.id)),
          mappings: FC.filter((r) => r.flashcard_id === ID) },
  concept: { id: sp.id, slug: sp.slug, canonicalName: sp.canonical_name, description: sp.description,
             objectType: sp.object_type, status: sp.status, version: sp.version,
             sections: CS.filter((r) => r.concept_id === sp.id).length,
             disciplines: CD.filter((r) => r.concept_id === sp.id).length,
             categories: CCC.filter((r) => r.concept_id === sp.id).length,
             aliases: AL.filter((r) => r.concept_id === sp.id).length,
             mappings: FC.filter((r) => r.concept_id === sp.id) },
  totals: { flashcards: F.length, uniqueMapped: new Set(FC.map((r) => r.flashcard_id)).size,
            mappingRows: FC.length, concepts: C.length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length } };
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
console.log(`WROTE ${OUT}`);
console.log(`  card ${ID}: ${snap.card.schedulerRows.length} scheduler row(s), ${snap.card.reviews.length} review(s)`);
console.log(`  concept mappings: ${snap.concept.mappings.map((r) => r.role).join(", ")}`);
console.log(`  totals ${JSON.stringify(snap.totals)}`);
