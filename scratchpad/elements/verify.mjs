import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/elements/pre_state.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const TOE = s.concept.id, PTS = s.periodicTableStructure.id;
const FIVE = s.incomingFiveCards.map((r) => r.flashcard_id);
const NINETEEN = s.pendingFamilyCardsForMigration7.map((r) => r.flashcard_id);
const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version,parent_concept_id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");
const toe = C.find((c) => c.id === TOE), pts = C.find((c) => c.id === PTS);

console.log("MIGRATION 6 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}\n`);
console.log("1-4  IDENTITY");
chk("stable UUID unchanged", toe && toe.id === s.concept.id, toe.id);
chk("canonical name is Metals, Nonmetals & Metalloids", toe.canonical_name === "Metals, Nonmetals & Metalloids", toe.canonical_name);
chk("slug unchanged", toe.slug === s.concept.slug, toe.slug);
chk("version incremented", toe.version === s.concept.version + 1, `${s.concept.version} -> ${toe.version}`);
chk("still CONTENT, ACTIVE, no parent", toe.object_type === "CONTENT" && toe.status === "ACTIVE_SEED" && !toe.parent_concept_id);
const leg = AL.filter((r) => r.concept_id === TOE && r.alias === "Types of Elements");
chk("old name archived as LEGACY_NAME", leg.length === 1 && leg[0].alias_type === "LEGACY_NAME");
chk("no concept answers to the old name", !C.some((c) => c.canonical_name === "Types of Elements"));
chk("the definition excludes chemical-family identity", String(toe.description || "").includes("DIFFERENT axis"));
chk("the definition names the families as living elsewhere",
  /alkali metals, alkaline earths, chalcogens, halogens, noble gases/.test(String(toe.description)));

console.log("\n5-6  EVIDENCE");
const qOn = QC.filter((r) => r.concept_id === TOE);
chk("all 12 questions remain, none moved", qOn.length === 12, String(qOn.length));
chk("the 12 are the same 12, with the same provenance",
  s.concept.questionMappings.every((m) => qOn.some((r) => r.question_id === m.question_id && r.role === m.role && r.source === m.source)));
const cOn = FC.filter((r) => r.concept_id === TOE);
chk("exactly 5 PRIMARY card mappings moved in",
  FIVE.every((id) => cOn.some((r) => r.flashcard_id === id && r.role === "PRIMARY")), `${FIVE.length} expected`);
chk("the 5 landed AI_PROPOSED / AI_PROPOSED",
  FIVE.every((id) => { const r = cOn.find((x) => x.flashcard_id === id); return r && r.mapping_status === "AI_PROPOSED" && r.source === "AI_PROPOSED"; }));
chk("Periodic Table Structure went 13 -> 8 cards", FC.filter((r) => r.concept_id === PTS).length === 8,
  String(FC.filter((r) => r.concept_id === PTS).length));
chk("the 8 it kept are byte-identical to the snapshot",
  s.periodicTableStructure.flashcardMappings.filter((m) => !FIVE.includes(m.flashcard_id))
    .every((m) => FC.some((r) => r.flashcard_id === m.flashcard_id && r.concept_id === PTS && r.role === m.role && r.source === m.source)));

console.log("\n7  MOVED-CARD LEARNER STATE");
const fld = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`;
const nowRows = S.filter((r) => FIVE.includes(r.flashcard_id)).map(fld).sort();
const wasRows = s.movedCardLearnerState.schedulerRows.map(fld).sort();
chk("same number of scheduler rows", nowRows.length === wasRows.length, `${wasRows.length} -> ${nowRows.length}`);
chk("every scheduler field on all five cards is byte-identical",
  nowRows.length === wasRows.length && nowRows.every((r, i) => r === wasRows[i]));
const nowRev = R.filter((r) => FIVE.includes(r.flashcard_id)).map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
const wasRev = s.movedCardLearnerState.reviews.map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
chk("review history unchanged, row for row",
  nowRev.length === wasRev.length && nowRev.every((r, i) => r === wasRev[i]), `${wasRev.length} -> ${nowRev.length} reviews`);

console.log("\n8  THE PENDING HAND-OFF TO MIGRATION 7");
const stillHere = NINETEEN.filter((id) => cOn.some((r) => r.flashcard_id === id));
chk("all 19 chemical-family cards are accounted for and still on this concept",
  stillHere.length === 19, `${stillHere.length} of 19`);
chk("the concept therefore holds 24 cards, the documented intermediate state", cOn.length === 24, String(cOn.length));
chk("the manifest records all 19 by id and deck position",
  s.pendingFamilyCardsForMigration7.length === 19 &&
  s.pendingFamilyCardsForMigration7.every((r) => r.flashcard_id && typeof r.position === "number"));

console.log("\n9-15  POPULATIONS");
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping targets a deprecated concept", ![...FC, ...QC, ...QRO].some((r) => dep.has(r.concept_id)));
chk(`ontology objects unchanged at ${s.totals.concepts}`, C.length === s.totals.concepts, String(C.length));
chk(`flashcard_concepts unchanged at ${s.totals.flashcardConcepts}`, FC.length === s.totals.flashcardConcepts, String(FC.length));
chk(`question_concepts unchanged at ${s.totals.questionConcepts}`, QC.length === s.totals.questionConcepts, String(QC.length));
chk(`reasoning mappings unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects, String(QRO.length));
chk(`aliases ${s.totals.aliases} -> ${s.totals.aliases + 1}`, AL.length === s.totals.aliases + 1, String(AL.length));
chk(`NEEDS_REVIEW unchanged at ${s.totals.needsReview}`,
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === s.totals.needsReview,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
chk("taxonomy on both concepts unchanged",
  CS.filter((r) => r.concept_id === TOE).length === s.concept.sections.length &&
  CS.filter((r) => r.concept_id === PTS).length === s.periodicTableStructure.sections.length);

console.log("\n16  BANK-WIDE LEARNER DATA");
const before = new Map(fs.readFileSync("scratchpad/elements/pre_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const bLR = new Map([...before].map(([k, l]) => [k, l.split("|")[11]]));
const rk = new Set(R.map(key));
const explained = (r) => { const k = key(r); if (!rk.has(k)) return false;
  const bl = bLR.get(k) ?? null;
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
