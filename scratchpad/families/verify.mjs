import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/families/pre_state.json", "utf8"));
const { CARDS, QUESTIONS, REUSE, SECONDARY } = s.manifest;
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const SLUGS = Object.keys(CARDS);
const MNM = s.metalsNonmetalsMetalloids.id;
const allCards = Object.values(CARDS).flat();
const allQs = [...Object.values(QUESTIONS).flat(), ...Object.values(REUSE).flat()];
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,parent_concept_id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const Q = await all("questions", "id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");
const bySlug = Object.fromEntries(C.filter((c) => SLUGS.includes(c.slug)).map((c) => [c.slug, c]));

console.log("MIGRATION 7 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}\n`);
console.log("1-3  THE FIVE NEW CONCEPTS");
chk("all five exist", SLUGS.every((sl) => bySlug[sl]), `${Object.keys(bySlug).length} of 5`);
SLUGS.forEach((sl) => { const c = bySlug[sl];
  if (c) console.log(`     ${c.id.slice(0, 8)}  ${c.canonical_name}`); });
chk("all five are CONTENT, ACTIVE, flat, with definitions",
  SLUGS.every((sl) => { const c = bySlug[sl];
    return c && c.object_type === "CONTENT" && c.status === "ACTIVE_SEED" && !c.parent_concept_id && String(c.description || "").trim().length > 150; }));
chk("all five UUIDs are distinct and new",
  new Set(SLUGS.map((sl) => bySlug[sl].id)).size === 5 && !SLUGS.some((sl) => bySlug[sl].id === MNM));
chk("each has exactly one section, discipline and category",
  SLUGS.every((sl) => CS.filter((r) => r.concept_id === bySlug[sl].id).length === 1 &&
    CD.filter((r) => r.concept_id === bySlug[sl].id).length === 1 &&
    CCC.filter((r) => r.concept_id === bySlug[sl].id).length === 1));
chk("taxonomy is CHEM_PHYS / GENERAL_CHEMISTRY / the periodic-table category",
  SLUGS.every((sl) => CS.find((r) => r.concept_id === bySlug[sl].id)?.section_code === "CHEM_PHYS" &&
    CD.find((r) => r.concept_id === bySlug[sl].id)?.discipline_code === "GENERAL_CHEMISTRY" &&
    CCC.find((r) => r.concept_id === bySlug[sl].id)?.content_category.startsWith("The Periodic Table: Classification")));
const am = AL.filter((r) => r.concept_id === bySlug.ALKALI_AND_ALKALINE_EARTH_METALS?.id && r.alias === "Active Metals");
chk("Active Metals kept as a COMMON_NAME alias, not as identity",
  am.length === 1 && am[0].alias_type === "COMMON_NAME" &&
  bySlug.ALKALI_AND_ALKALINE_EARTH_METALS.canonical_name === "Alkali and Alkaline Earth Metals");

console.log("\n4  THE 19 CARDS");
SLUGS.forEach((sl) => {
  const got = FC.filter((r) => r.concept_id === bySlug[sl].id);
  chk(`  ${sl.padEnd(42)} ${CARDS[sl].length} cards`,
    got.length === CARDS[sl].length && CARDS[sl].every((id) => got.some((r) => r.flashcard_id === id && r.role === "PRIMARY")),
    `${got.length}`);
});
chk("all 19 left Metals, Nonmetals & Metalloids", !allCards.some((id) => FC.some((r) => r.flashcard_id === id && r.concept_id === MNM)));
chk("it now holds exactly its 5 metal-character cards", FC.filter((r) => r.concept_id === MNM).length === 5,
  String(FC.filter((r) => r.concept_id === MNM).length));
chk("its 12 questions are untouched", QC.filter((r) => r.concept_id === MNM).length === 12);
chk("every one of the 19 holds exactly one mapping", allCards.every((id) => FC.filter((r) => r.flashcard_id === id).length === 1));

console.log("\n5  THE 20 QUESTIONS");
SLUGS.forEach((sl) => {
  const want = (QUESTIONS[sl] || []).length + SECONDARY.filter((x) => x.slug === sl).length;
  const got = QC.filter((r) => r.concept_id === bySlug[sl].id);
  chk(`  ${sl.padEnd(42)} ${want} question rows`, got.length === want, String(got.length));
});
const pt = C.find((c) => c.slug === "PERIODIC_TRENDS");
chk("Periodic Trends gained exactly the one reused question",
  QC.filter((r) => r.concept_id === pt.id).length === s.reuseTargets[0].questionCount + 1 &&
  QC.some((r) => r.question_id === REUSE.PERIODIC_TRENDS[0] && r.concept_id === pt.id),
  `${s.reuseTargets[0].questionCount} -> ${QC.filter((r) => r.concept_id === pt.id).length}`);
chk("every one of the 20 holds exactly one PRIMARY",
  allQs.every((id) => QC.filter((r) => r.question_id === id && r.role === "PRIMARY").length === 1));
const hf = QC.filter((r) => r.question_id === "f4f7b834-bb1f-401a-b380-2f173274871c");
chk("the HF question is PRIMARY on Halogens, and not on the acids concept",
  hf.length === 1 && hf[0].concept_id === bySlug.HALOGENS.id && hf[0].role === "PRIMARY");
const sec = QC.filter((r) => r.question_id === SECONDARY[0].question);
chk("the calcium-chlorine question is PRIMARY on alkali/alkaline earth and SECONDARY on halogens",
  sec.length === 2 &&
  sec.some((r) => r.role === "PRIMARY" && r.concept_id === bySlug.ALKALI_AND_ALKALINE_EARTH_METALS.id) &&
  sec.some((r) => r.role === "SECONDARY" && r.concept_id === bySlug.HALOGENS.id));
const mappedNow = new Set(QC.map((r) => r.question_id));
chk("the unmapped backlog is now ZERO", Q.filter((q) => !mappedNow.has(q.id)).length === 0,
  `${s.unmappedBacklog.length} -> ${Q.filter((q) => !mappedNow.has(q.id)).length}`);

console.log("\n8-9  ARITHMETIC AND GOVERNANCE");
chk(`concepts ${s.totals.concepts} -> ${s.totals.concepts + 5}`, C.length === s.totals.concepts + 5, String(C.length));
chk(`flashcard_concepts unchanged at ${s.totals.flashcardConcepts} (repointed, not added)`, FC.length === s.totals.flashcardConcepts, String(FC.length));
chk(`question_concepts ${s.totals.questionConcepts} -> ${s.totals.questionConcepts + 21}`, QC.length === s.totals.questionConcepts + 21, String(QC.length));
chk(`aliases ${s.totals.aliases} -> ${s.totals.aliases + 1}`, AL.length === s.totals.aliases + 1, String(AL.length));
chk(`reasoning mappings unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects);
chk(`deprecated unchanged at ${s.totals.deprecated}`, C.filter((c) => c.status === "DEPRECATED").length === s.totals.deprecated);
chk(`NEEDS_REVIEW unchanged at ${s.totals.needsReview}`,
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === s.totals.needsReview,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
const newRows = [...FC.filter((r) => SLUGS.some((sl) => r.concept_id === bySlug[sl].id)),
                 ...QC.filter((r) => SLUGS.some((sl) => r.concept_id === bySlug[sl].id))];
chk("every new mapping is AI_PROPOSED / AI_PROPOSED",
  newRows.every((r) => r.mapping_status === "AI_PROPOSED" && r.source === "AI_PROPOSED"),
  JSON.stringify(newRows.reduce((a, r) => ((a[`${r.mapping_status}/${r.source}`] = (a[`${r.mapping_status}/${r.source}`] || 0) + 1), a), {})));
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping targets a deprecated concept", ![...FC, ...QC, ...QRO].some((r) => dep.has(r.concept_id)));

console.log("\n17-18  LEARNER DATA");
const fld = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`;
const nowRows = S.filter((r) => allCards.includes(r.flashcard_id)).map(fld).sort();
const wasRows = s.movedCardLearnerState.schedulerRows.map(fld).sort();
chk("all 55 scheduler rows on the 19 moved cards are byte-identical",
  nowRows.length === wasRows.length && nowRows.every((r, i) => r === wasRows[i]),
  `${wasRows.length} -> ${nowRows.length}`);
const nowRev = R.filter((r) => allCards.includes(r.flashcard_id)).map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
const wasRev = s.movedCardLearnerState.reviews.map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
chk("all 418 reviews on those cards are unchanged, row for row",
  nowRev.length === wasRev.length && nowRev.every((r, i) => r === wasRev[i]), `${wasRev.length} -> ${nowRev.length}`);
const before = new Map(fs.readFileSync("scratchpad/families/pre_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const bLR = new Map([...before].map(([k, l]) => [k, l.split("|")[11]]));
const rk = new Set(R.map(key));
const expl = (r) => { const k = key(r); if (!rk.has(k)) return false; const bl = bLR.get(k) ?? null;
  return r.last_reviewed_at !== null && (bl === null || bl === "null" || new Date(r.last_reviewed_at) > new Date(bl)); };
const moved = S.filter((r) => before.has(key(r)) && before.get(key(r)) !== line(r));
const appeared = S.filter((r) => !before.has(key(r)));
const vanished = [...before.keys()].filter((k) => !S.some((r) => key(r) === k));
chk("bank-wide: no scheduler row vanished", vanished.length === 0, String(vanished.length));
chk("bank-wide: every row that moved has a fresh review on it",
  [...moved, ...appeared].filter((r) => !expl(r)).length === 0,
  `${moved.length} changed, ${appeared.length} new`);
chk("question attempts unchanged", QA.length === s.learnerBaseline.attemptRows, String(QA.length));
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
