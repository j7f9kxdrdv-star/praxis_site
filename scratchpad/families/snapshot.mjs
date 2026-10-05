// Immutable pre-state and full manifest for migration 7.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/families/pre_state.json";
if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}`);
  process.exit(0);
}
const CARDS = {
  ALKALI_AND_ALKALINE_EARTH_METALS: ["6a7030ef-e87b-4789-b0c5-86c428e9521a","c94607ef-b01a-4c59-9d36-b0ca69a1cdc6","14dedf27-ff4b-47b8-b03e-3216081bd745","7d4080fd-c3f9-4479-aba5-8fdd104fc9dc","47980145-006d-4ead-88f1-bfac0c6f8885","d934d272-5fa3-4e8e-b009-183fdadcadbe"],
  HALOGENS: ["be1a9ae7-9b98-46a7-ae11-0878027f83b0","f4c15b97-c19e-41f3-999c-d10acef2ce14","0d84d208-3afe-4030-aa2d-c014c9545d08","8efeb7bb-0bda-44b8-b4c4-624652e72534"],
  NOBLE_GASES: ["e5af10b6-c440-4583-a906-df7a0dca39a9","41e199ef-5bd1-4082-8deb-a90b68650d4b","82701d00-f247-42c5-b344-44b5cce60f2a"],
  TRANSITION_METALS_INNER_TRANSITION_SERIES: ["7271ffde-6204-416e-856b-bdc422f3ba40","78cd585c-8233-4776-90e3-747585ad4251","dbedae99-4310-4e0e-bf65-4120c4e40d14","681df28e-fdf8-4beb-ae4b-2ba3d304d4ca","51c5de5b-d7e0-4d3b-b69e-c6d8f8ea5fb5"],
  CHALCOGENS: ["0a7247dc-3575-4681-b553-d3cc156ac9c2"],
};
const QUESTIONS = {
  ALKALI_AND_ALKALINE_EARTH_METALS: ["0ecd7bac-0143-47c1-98a8-66483b9da663","281971ff-47d5-48f2-ade7-bb49b09ecf78","41f87b91-e2a7-4348-8495-48cd042eece3","5ef31e94-271a-4344-b482-e4d9bacc7bb5","6486571a-1237-471c-bb9b-8c373f61c395","73b5fcb7-a512-42ca-8ec3-b430c9264f47","75a2da19-403a-461a-ba4c-d9721d233eec","eee33c57-0002-4666-81a6-f7a1fb97a1b9"],
  HALOGENS: ["2f153e0e-453a-4ff7-b1ec-b304739cde77","487d627f-035c-4192-b71a-b7d7f4fd845d","883f79c9-3fad-4d44-a63e-d104d6a890aa","be5f387b-e6b2-4ec3-8197-821198b54cda","f4f7b834-bb1f-401a-b380-2f173274871c"],
  NOBLE_GASES: ["055c6d03-4f75-493d-81ab-94ddabff502f","9e2a17c9-cac8-4c02-a0c8-379b30ac5965","c6f7963e-fa2b-4c69-b852-aef86e5f6c4e"],
  TRANSITION_METALS_INNER_TRANSITION_SERIES: ["ab4d6752-bed6-4716-a5e4-99eec8fcc551","d20971ce-413f-44b2-ba81-d55af592d136"],
  CHALCOGENS: ["2500b00c-f29c-43f6-9c8a-8009805b7c5d"],
};
const REUSE = { PERIODIC_TRENDS: ["b7858478-c39f-4aeb-bb6b-32894e259ab7"] };
const SECONDARY = [{ question: "73b5fcb7-a512-42ca-8ec3-b430c9264f47", slug: "HALOGENS" }];

const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");
const Q = await all("questions", "id");
const mnm = C.find((c) => c.slug === "TYPES_ELEMENTS");
const allCards = Object.values(CARDS).flat();
const allQs = [...Object.values(QUESTIONS).flat(), ...Object.values(REUSE).flat()];
const mapped = new Set(QC.map((r) => r.question_id));

const problems = [];
if (allCards.length !== 19) problems.push(`${allCards.length} cards, expected 19`);
if (new Set(allCards).size !== 19) problems.push("a card is assigned twice");
if (allQs.length !== 20) problems.push(`${allQs.length} questions, expected 20`);
if (new Set(allQs).size !== 20) problems.push("a question is assigned twice");
for (const id of allCards) if (!FC.some((r) => r.flashcard_id === id && r.concept_id === mnm.id)) problems.push(`card ${id} not on the concept`);
for (const id of allQs) { if (mapped.has(id)) problems.push(`question ${id} is already mapped`); if (!Q.some((q) => q.id === id)) problems.push(`question ${id} missing`); }
if (problems.length) { console.error("STOP:\n  " + problems.join("\n  ")); process.exit(1); }

const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const snap = {
  takenAt: TAKEN_AT, purpose: "Pre-state and manifest for the chemical-family vocabulary (migration 7). Immutable.",
  manifest: { CARDS, QUESTIONS, REUSE, SECONDARY },
  metalsNonmetalsMetalloids: { id: mnm.id, slug: mnm.slug, canonicalName: mnm.canonical_name, version: mnm.version,
    flashcardMappings: FC.filter((r) => r.concept_id === mnm.id).sort((a, b) => a.flashcard_id.localeCompare(b.flashcard_id)),
    questionMappings: QC.filter((r) => r.concept_id === mnm.id).sort((a, b) => a.question_id.localeCompare(b.question_id)),
    sections: CS.filter((r) => r.concept_id === mnm.id), disciplines: CD.filter((r) => r.concept_id === mnm.id),
    contentCategories: CCC.filter((r) => r.concept_id === mnm.id) },
  reuseTargets: Object.keys(REUSE).map((slug) => { const c = C.find((x) => x.slug === slug);
    return { slug, id: c.id, canonicalName: c.canonical_name, status: c.status,
             questionCount: QC.filter((r) => r.concept_id === c.id).length }; }),
  // Every cloze and every review for all 19 cards. Mapping identity may change; none of this may.
  movedCardLearnerState: {
    schedulerRows: S.filter((r) => allCards.includes(r.flashcard_id)),
    reviews: R.filter((r) => allCards.includes(r.flashcard_id)).sort((a, b) => a.id.localeCompare(b.id)),
  },
  unmappedBacklog: Q.filter((q) => !mapped.has(q.id)).map((q) => q.id).sort(),
  totals: { concepts: C.length, flashcardConcepts: FC.length, questionConcepts: QC.length,
            reasoningObjects: QRO.length, aliases: AL.length,
            deprecated: C.filter((c) => c.status === "DEPRECATED").length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/families/pre_fsrs_rows.txt", fsrsRows.join("\n"));
console.log(`WROTE ${OUT}`);
Object.entries(CARDS).forEach(([k, v]) => console.log(`  ${k.padEnd(42)} ${v.length} cards, ${(QUESTIONS[k] || []).length} questions`));
console.log(`  reuse: ${snap.reuseTargets.map((t) => `${t.canonicalName} (${t.questionCount}q)`).join(", ")}`);
console.log(`  SECONDARY: ${SECONDARY.length}`);
console.log(`  unmapped backlog now: ${snap.unmappedBacklog.length}`);
console.log(`  19 moved cards carry ${snap.movedCardLearnerState.schedulerRows.length} scheduler rows and ${snap.movedCardLearnerState.reviews.length} reviews`);
console.log(`  totals ${JSON.stringify(snap.totals)}`);
console.log(`  sha256 ${snap.sha256.slice(0, 16)}`);
