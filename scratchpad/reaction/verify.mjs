import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/reaction/pre_state.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const A = s.conceptA.id, B = s.conceptB.id, LR = s.limitingReagent.id;
const CARD = s.movedCard.id, HABER = s.haberQuestion.id;

const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating,prev_interval_days,new_interval_days,stability,difficulty");
const QA = await all("question_attempts", "id");
const a = C.find((c) => c.id === A), b = C.find((c) => c.id === B), lr = C.find((c) => c.id === LR);

console.log("MIGRATION 4 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}\n`);

console.log("1-5  CONCEPTS");
chk("the renamed concept keeps its original UUID", b && b.id === s.conceptB.id, b.id);
chk("it answers to Redox Classification of Reaction Families", b.canonical_name === "Redox Classification of Reaction Families", b.canonical_name);
chk("its slug is unchanged", b.slug === s.conceptB.slug, b.slug);
chk("version incremented", b.version === s.conceptB.version + 1, `${s.conceptB.version} -> ${b.version}`);
chk("it is CONTENT and ACTIVE", b.object_type === "CONTENT" && b.status === "ACTIVE_SEED");
const leg = AL.filter((r) => r.concept_id === B && r.alias === "Reaction Types & Classification");
chk("the old name exists as a LEGACY_NAME alias", leg.length === 1 && leg[0].alias_type === "LEGACY_NAME");
chk("no concept answers to the old name", !C.some((c) => c.canonical_name === "Reaction Types & Classification"));
chk("Types of Reactions remains distinct, ACTIVE and unrenamed",
  a.canonical_name === "Types of Reactions" && a.status === "ACTIVE_SEED" && a.version === s.conceptA.version);
chk("both definitions are written and each names the other",
  String(a.description || "").includes("Redox Classification of Reaction Families") &&
  String(b.description || "").includes("Types of Reactions"));

console.log("\n6-9  THE TWO MOVES");
const cardRows = FC.filter((r) => r.flashcard_id === CARD);
chk("the card holds exactly one mapping, now on the renamed concept",
  cardRows.length === 1 && cardRows[0].concept_id === B, `${cardRows.length} row(s)`);
chk("it is PRIMARY / AI_PROPOSED / AI_PROPOSED",
  cardRows[0].role === "PRIMARY" && cardRows[0].mapping_status === "AI_PROPOSED" && cardRows[0].source === "AI_PROPOSED");
const haberRows = QC.filter((r) => r.question_id === HABER);
chk("the Haber question holds exactly one mapping, now on Limiting Reagent",
  haberRows.length === 1 && haberRows[0].concept_id === LR, `${haberRows.length} row(s)`);
chk("it is PRIMARY / AI_PROPOSED / AI_PROPOSED",
  haberRows[0].role === "PRIMARY" && haberRows[0].mapping_status === "AI_PROPOSED" && haberRows[0].source === "AI_PROPOSED");
chk("Types of Reactions: 10 -> 9 cards, 11 -> 10 questions",
  FC.filter((r) => r.concept_id === A).length === 9 && QC.filter((r) => r.concept_id === A).length === 10,
  `${FC.filter((r) => r.concept_id === A).length}c ${QC.filter((r) => r.concept_id === A).length}q`);
chk("renamed concept: 0 -> 1 card, 5 questions unchanged",
  FC.filter((r) => r.concept_id === B).length === 1 && QC.filter((r) => r.concept_id === B).length === 5);
chk("Limiting Reagent: 16 -> 17 questions, 3 cards unchanged",
  QC.filter((r) => r.concept_id === LR).length === 17 && FC.filter((r) => r.concept_id === LR).length === 3);
chk("every OTHER mapping on Types of Reactions is untouched",
  s.conceptA.flashcardMappings.filter((m) => m.flashcard_id !== CARD)
    .every((m) => FC.some((r) => r.flashcard_id === m.flashcard_id && r.concept_id === A && r.role === m.role && r.source === m.source)) &&
  s.conceptA.questionMappings.filter((m) => m.question_id !== HABER)
    .every((m) => QC.some((r) => r.question_id === m.question_id && r.concept_id === A && r.role === m.role && r.source === m.source)));
chk("the renamed concept's 5 original questions are untouched",
  s.conceptB.questionMappings.every((m) => QC.some((r) => r.question_id === m.question_id && r.concept_id === B && r.source === m.source)));
chk("no question or card carries two PRIMARY content mappings",
  new Set(QC.filter((r) => r.role === "PRIMARY").map((r) => r.question_id)).size === QC.filter((r) => r.role === "PRIMARY").length);

console.log("\n10-11  DEPRECATED TARGETS AND THE MOVED CARD'S LEARNER STATE");
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping anywhere targets a deprecated concept", ![...QC, ...FC, ...QRO].some((r) => dep.has(r.concept_id)));
const fld = (r) => `${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`;
const nowRows = S.filter((r) => r.flashcard_id === CARD).sort((x, y) => x.cloze_index - y.cloze_index);
const wasRows = s.movedCard.schedulerRows.slice().sort((x, y) => x.cloze_index - y.cloze_index);
chk("the moved card still has the same number of scheduler rows", nowRows.length === wasRows.length, `${wasRows.length} -> ${nowRows.length}`);
chk("every scheduler field on the moved card is byte-identical to the snapshot",
  nowRows.length === wasRows.length && nowRows.every((r, i) => fld(r) === fld(wasRows[i])),
  nowRows.map((r) => `cloze${r.cloze_index} stab=${r.stability} reps=${r.reps} lapses=${r.lapses}`).join(" | "));
const nowRev = R.filter((r) => r.flashcard_id === CARD).sort((x, y) => x.reviewed_at.localeCompare(y.reviewed_at));
chk("its review history is unchanged, row for row",
  nowRev.length === s.movedCard.reviews.length &&
  nowRev.every((r, i) => r.id === s.movedCard.reviews[i].id && r.reviewed_at === s.movedCard.reviews[i].reviewed_at && r.rating === s.movedCard.reviews[i].rating),
  `${s.movedCard.reviews.length} -> ${nowRev.length} reviews`);

console.log("\n12-17  POPULATIONS");
chk(`ontology objects unchanged at ${s.totals.concepts}`, C.length === s.totals.concepts, String(C.length));
chk(`flashcard_concepts unchanged at ${s.totals.flashcardConcepts}`, FC.length === s.totals.flashcardConcepts, String(FC.length));
chk(`question_concepts unchanged at ${s.totals.questionConcepts}`, QC.length === s.totals.questionConcepts, String(QC.length));
chk(`question_reasoning_objects unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects, String(QRO.length));
chk(`aliases ${s.totals.aliases} -> ${s.totals.aliases + 1}`, AL.length === s.totals.aliases + 1, String(AL.length));
chk(`deprecated unchanged at ${s.totals.deprecated}`, C.filter((c) => c.status === "DEPRECATED").length === s.totals.deprecated);
chk(`NEEDS_REVIEW queue unchanged at ${s.totals.needsReview}`,
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === s.totals.needsReview,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
chk("taxonomy on all three concepts unchanged", [A, B, LR].every((id) => CS.filter((r) => r.concept_id === id).length === s[id === A ? "conceptA" : id === B ? "conceptB" : "limitingReagent"].sections.length));

console.log("\nBANK-WIDE LEARNER DATA");
const before = new Map(fs.readFileSync("scratchpad/reaction/pre_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const beforeLR2 = new Map([...before].map(([k, l]) => [k, l.split("|")[11]]));
const reviewKeys = new Set(R.map(key));
const explained = (r) => { const k = key(r); if (!reviewKeys.has(k)) return false;
  const bl = beforeLR2.get(k) ?? null;
  return r.last_reviewed_at !== null && (bl === null || bl === "null" || new Date(r.last_reviewed_at) > new Date(bl)); };
const moved = S.filter((r) => before.has(key(r)) && before.get(key(r)) !== line(r));
const appeared = S.filter((r) => !before.has(key(r)));
const vanished = [...before.keys()].filter((k) => !S.some((r) => key(r) === k));
const unexplained = [...moved, ...appeared].filter((r) => !explained(r));
chk("no scheduler row vanished", vanished.length === 0, String(vanished.length));
chk("every row that moved has a fresh review on it", unexplained.length === 0,
  `${moved.length} changed, ${appeared.length} new, ${unexplained.length} unexplained`);
chk("reviews only grew", R.length >= s.learnerBaseline.reviewRows, `${s.learnerBaseline.reviewRows} -> ${R.length}`);
chk("question attempts unchanged", QA.length === s.learnerBaseline.attemptRows, String(QA.length));

console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
