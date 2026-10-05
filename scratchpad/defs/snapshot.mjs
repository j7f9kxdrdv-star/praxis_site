// Immutable pre-state for migration 5. Definitions only, so the interesting
// part of the snapshot is everything that must NOT move: exact mapping SETS
// rather than counts, and every taxonomy row.
import { all } from "../backfill/record.mjs";
import fs from "node:fs"; import crypto from "node:crypto";
const TAKEN_AT = new Date().toISOString();
const OUT = "scratchpad/defs/pre_state.json";
if (fs.existsSync(OUT)) {
  const s = JSON.parse(fs.readFileSync(OUT, "utf8"));
  console.log(`REFUSING to overwrite ${OUT}. taken ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}`);
  process.exit(0);
}
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level,parent_concept_id,content_category,split_candidate");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,confidence,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id,confidence,mapping_status,source");
const AL = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "id");
const QA = await all("question_attempts", "id");

const pack = (slug) => {
  const c = C.find((x) => x.slug === slug);
  if (!c) { console.error("STOP: missing " + slug); process.exit(1); }
  return {
    id: c.id, slug: c.slug, canonicalName: c.canonical_name, description: c.description,
    objectType: c.object_type, status: c.status, version: c.version, deprecatedBy: c.deprecated_by,
    conceptLevel: c.concept_level, parentConceptId: c.parent_concept_id,
    contentCategoryColumn: c.content_category, splitCandidate: c.split_candidate,
    sections: CS.filter((r) => r.concept_id === c.id).sort((a, b) => a.section_code.localeCompare(b.section_code)),
    disciplines: CD.filter((r) => r.concept_id === c.id).sort((a, b) => a.discipline_code.localeCompare(b.discipline_code)),
    contentCategories: CCC.filter((r) => r.concept_id === c.id).sort((a, b) => a.content_category.localeCompare(b.content_category)),
    aliases: AL.filter((r) => r.concept_id === c.id),
    // SETS, not counts, so a swap is visible.
    flashcardMappings: FC.filter((r) => r.concept_id === c.id).sort((a, b) => a.flashcard_id.localeCompare(b.flashcard_id)),
    questionMappings: QC.filter((r) => r.concept_id === c.id).sort((a, b) => a.question_id.localeCompare(b.question_id)),
    reasoningMappings: QRO.filter((r) => r.concept_id === c.id).sort((a, b) => a.question_id.localeCompare(b.question_id)),
  };
};
const rs = pack("RO_RESEARCH_SETTINGS"), pdc = pack("PERSONALITY_DISORDER_CLUSTERS");
const fsrsRows = S.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`).sort();
const snap = {
  takenAt: TAKEN_AT, purpose: "Pre-state for migration 5 (definitions only). Immutable.",
  researchSettings: rs, personalityDisorderClusters: pdc,
  totals: { concepts: C.length, flashcardConcepts: FC.length, questionConcepts: QC.length,
            reasoningObjects: QRO.length, aliases: AL.length,
            deprecated: C.filter((c) => c.status === "DEPRECATED").length,
            needsReview: [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length },
  learnerBaseline: { schedulerRows: S.length, reviewRows: R.length, attemptRows: QA.length,
                     fsrsDigest: crypto.createHash("sha256").update(fsrsRows.join("\n")).digest("hex") },
};
snap.sha256 = crypto.createHash("sha256").update(JSON.stringify({ ...snap, sha256: undefined })).digest("hex");
fs.writeFileSync(OUT, JSON.stringify(snap, null, 1));
fs.writeFileSync("scratchpad/defs/pre_fsrs_rows.txt", fsrsRows.join("\n"));

for (const [tag, o] of [["RESEARCH SETTINGS", rs], ["PERSONALITY DISORDER CLUSTERS", pdc]]) {
  console.log(`\n######## ${tag}`);
  console.log(`  uuid       ${o.id}`);
  console.log(`  slug       ${o.slug}`);
  console.log(`  name       ${o.canonicalName}`);
  console.log(`  type       ${o.objectType}   status ${o.status}   version ${o.version}   level ${o.conceptLevel}`);
  console.log(`  parent     ${o.parentConceptId ?? "none"}   deprecated_by ${o.deprecatedBy ?? "none"}`);
  console.log(`  definition ${o.description ?? "(NULL)"}`);
  console.log(`  sections   ${o.sections.map((r) => r.section_code + (r.is_primary ? "*" : "")).join(", ") || "none"}`);
  console.log(`  discipline ${o.disciplines.map((r) => r.discipline_code + "[" + r.role + "]").join(", ") || "none"}`);
  console.log(`  categories ${o.contentCategories.map((r) => r.content_category + (r.is_primary ? "*" : "")).join(", ") || "none"}`);
  console.log(`  aliases    ${o.aliases.map((r) => r.alias).join(", ") || "none"}`);
  console.log(`  mappings   ${o.flashcardMappings.length} flashcard, ${o.questionMappings.length} question, ${o.reasoningMappings.length} reasoning`);
}
console.log(`\ntotals ${JSON.stringify(snap.totals)}`);
console.log(`sha256 ${snap.sha256.slice(0, 16)}`);
