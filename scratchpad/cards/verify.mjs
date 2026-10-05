import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/cards/pre_state.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const CY = s.cytoskeletonCard, ST = s.structuralProteinsCard, EL = s.elastinConsideredAndDeclined;
const COLLAGEN = "ca5f08a7-3bc2-493b-8e82-dd2835e122f0", KERATIN = "328bd950-1833-4c3c-902c-a6a514ec322c";
const F = await all("flashcards", "id,deck_id,position,cloze_text,cloze_count,card_type");
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QC = await all("question_concepts", "question_id,mapping_status");
const QRO = await all("question_reasoning_objects", "question_id");
const CS = await all("concept_sections", "concept_id,section_code");
const CD = await all("concept_disciplines", "concept_id,discipline_code");
const CCC = await all("concept_content_categories", "concept_id,content_category");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended,last_rating,scheduled_days,learning_steps,starred");
const R = await all("flashcard_reviews", "id,flashcard_id,cloze_index,user_id,reviewed_at,rating");
const QA = await all("question_attempts", "id");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
const fcls = C.find((c) => c.slug === "CYTOSKELETON_FILAMENT_CLASSES");
const sp = C.find((c) => c.slug === "STRUCTURAL_PROTEINS");
const newCard = F.find((f) => f.deck_id === CY.deck_id && f.position === 75);

console.log("MIGRATION 8 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}\n`);
console.log("1-5  CYTOSKELETON CARD");
const cy = F.find((f) => f.id === CY.id);
chk("same card_id", !!cy && cy.id === CY.id, cy.id);
chk("same deck and position", cy.deck_id === CY.deck_id && cy.position === CY.position);
chk("cloze_count still 2", cy.cloze_count === 2, String(cy.cloze_count));
console.log(`     old: ${CY.cloze_text.replace(/\n/g, " ").slice(0, 110)}...`);
console.log(`     new: ${cy.cloze_text}`);
const c1 = [...cy.cloze_text.matchAll(/\{\{c1::(.*?)\}\}/g)].map((m) => m[1]);
const c2 = [...cy.cloze_text.matchAll(/\{\{c2::(.*?)\}\}/g)].map((m) => m[1]);
chk("c1 still the filament class names", JSON.stringify(c1) === JSON.stringify(["microfilaments", "intermediate filaments", "microtubules"]), c1.join(" / "));
chk("c2 still the component proteins", JSON.stringify(c2) === JSON.stringify(["actin", "keratin-family proteins", "tubulin"]), c2.join(" / "));
chk("keratin-family proteins is inside c2, not exposed", !/\}\}\s*of\s*keratin-family/.test(cy.cloze_text));
const cyMap = FC.filter((r) => r.flashcard_id === CY.id);
chk("mapped PRIMARY to Cytoskeleton: Filament Classes",
  cyMap.length === 1 && cyMap[0].concept_id === fcls.id && cyMap[0].role === "PRIMARY",
  cyMap.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));
chk("Cytoskeleton: Filament Classes is new, live CONTENT with a definition and full taxonomy",
  fcls && fcls.status === "ACTIVE_SEED" && fcls.object_type === "CONTENT" && String(fcls.description || "").trim().length > 100 &&
  CS.some((r) => r.concept_id === fcls.id) && CD.some((r) => r.concept_id === fcls.id) && CCC.some((r) => r.concept_id === fcls.id),
  fcls.id);

console.log("\n6-8  THE NEW CARD");
chk("it exists at The Cell position 75", !!newCard, newCard?.id);
chk("it has a NEW id, not either existing card", newCard.id !== CY.id && newCard.id !== ST.id);
console.log(`     ${newCard.cloze_text}`);
chk("cloze_count 1 and one cloze group of four proteins",
  newCard.cloze_count === 1 && [...newCard.cloze_text.matchAll(/\{\{c1::(.*?)\}\}/g)].length === 4);
const ncMap = FC.filter((r) => r.flashcard_id === newCard.id);
chk("mapped PRIMARY to Cytoskeleton: Intermediate Filaments",
  ncMap.length === 1 && ncMap[0].role === "PRIMARY" && nm.get(ncMap[0].concept_id) === "Cytoskeleton: Intermediate Filaments",
  ncMap.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));
chk("ZERO scheduler rows, nothing inherited", S.filter((r) => r.flashcard_id === newCard.id).length === 0);
chk("ZERO reviews, nothing inherited", R.filter((r) => r.flashcard_id === newCard.id).length === 0);

console.log("\n9-14  STRUCTURAL PROTEINS");
const st = F.find((f) => f.id === ST.id);
chk("same card_id, deck and position", st.id === ST.id && st.deck_id === ST.deck_id && st.position === ST.position);
chk("cloze_count still 2", st.cloze_count === 2);
console.log(`     old: ${ST.cloze_text.replace(/\n/g, " ")}`);
console.log(`     new: ${st.cloze_text}`);
const s1 = [...st.cloze_text.matchAll(/\{\{c1::(.*?)\}\}/g)].map((m) => m[1]);
const s2 = [...st.cloze_text.matchAll(/\{\{c2::(.*?)\}\}/g)].map((m) => m[1]);
chk("c1 still the class, c2 still keratin",
  JSON.stringify(s1) === JSON.stringify(["Structural proteins"]) && JSON.stringify(s2) === JSON.stringify(["keratin"]),
  `c1=${s1.join("/")} c2=${s2.join("/")}`);
const stMap = FC.filter((r) => r.flashcard_id === ST.id);
chk("mapped PRIMARY to Structural Proteins",
  stMap.length === 1 && stMap[0].concept_id === sp.id && stMap[0].role === "PRIMARY");
chk("Structural Proteins is new, live CONTENT with a definition and full taxonomy",
  sp && sp.status === "ACTIVE_SEED" && sp.object_type === "CONTENT" && String(sp.description || "").trim().length > 100 &&
  CS.some((r) => r.concept_id === sp.id) && CD.some((r) => r.concept_id === sp.id) && CCC.some((r) => r.concept_id === sp.id),
  sp.id);
const col = FC.filter((r) => r.flashcard_id === COLLAGEN), ker = FC.filter((r) => r.flashcard_id === KERATIN);
chk("collagen: PRIMARY kept, SECONDARY added to Structural Proteins",
  col.length === 2 && col.some((r) => r.role === "PRIMARY" && nm.get(r.concept_id) === "Tissues: Connective Tissue") &&
  col.some((r) => r.role === "SECONDARY" && r.concept_id === sp.id),
  col.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));
chk("keratin: PRIMARY kept, SECONDARY added to Structural Proteins",
  ker.length === 2 && ker.some((r) => r.role === "PRIMARY" && nm.get(r.concept_id) === "Cytoskeleton: Intermediate Filaments") &&
  ker.some((r) => r.role === "SECONDARY" && r.concept_id === sp.id),
  ker.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));
const el = FC.filter((r) => r.flashcard_id === EL.id);
chk("elastin UNTOUCHED, no secondary added, as decided",
  el.length === 1 && el[0].role === "PRIMARY" && !el.some((r) => r.concept_id === sp.id),
  el.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));

console.log("\n15-16  OLD-CARD LEARNER HISTORY");
const fld = (r) => `${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`;
for (const [tag, was] of [["cytoskeleton", CY], ["structural proteins", ST]]) {
  const now = S.filter((r) => r.flashcard_id === was.id).map(fld).sort();
  const old = was.schedulerRows.map(fld).sort();
  chk(`  ${tag}: every scheduler field byte-identical`,
    now.length === old.length && now.every((r, i) => r === old[i]), `${old.length} row(s)`);
  const nr = R.filter((r) => r.flashcard_id === was.id).map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
  const orr = was.reviews.map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
  chk(`  ${tag}: review history unchanged row for row`,
    nr.length === orr.length && nr.every((r, i) => r === orr[i]), `${orr.length} review(s)`);
}

console.log("\n17-22  COVERAGE AND POPULATIONS");
const mapped = new Set(FC.map((r) => r.flashcard_id));
chk(`total cards ${s.totals.flashcards} -> ${s.totals.flashcards + 1}`, F.length === s.totals.flashcards + 1, String(F.length));
chk(`unique mapped cards ${s.totals.uniqueMappedCards} -> ${F.length}`, mapped.size === F.length, String(mapped.size));
chk(`unmapped cards ${s.totals.unmappedCards} -> 0`, F.filter((f) => !mapped.has(f.id)).length === 0,
  String(F.filter((f) => !mapped.has(f.id)).length));
console.log(`     COVERAGE: ${mapped.size} / ${F.length} unique cards mapped`);
chk(`mapping ROWS ${s.totals.flashcardConceptRows} -> ${s.totals.flashcardConceptRows + 5} (rows exceed cards: 2 secondaries)`,
  FC.length === s.totals.flashcardConceptRows + 5, String(FC.length));
chk(`ontology objects ${s.totals.concepts} -> ${s.totals.concepts + 2}`, C.length === s.totals.concepts + 2, String(C.length));
chk(`question_concepts unchanged at ${s.totals.questionConcepts}`, QC.length === s.totals.questionConcepts, String(QC.length));
chk(`reasoning mappings unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects);
chk(`NEEDS_REVIEW unchanged at ${s.totals.needsReview}`,
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === s.totals.needsReview,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
chk("every new mapping is AI_PROPOSED / AI_PROPOSED",
  [...cyMap, ...stMap, ...ncMap, ...col.filter((r) => r.role === "SECONDARY"), ...ker.filter((r) => r.role === "SECONDARY")]
    .every((r) => r.mapping_status === "AI_PROPOSED" && r.source === "AI_PROPOSED"));
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping targets a deprecated concept", !FC.some((r) => dep.has(r.concept_id)));

console.log("\nBANK-WIDE LEARNER DATA");
const before = new Map(fs.readFileSync("scratchpad/cards/pre_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const bLR = new Map([...before].map(([k, l]) => [k, l.split("|")[11]]));
const rk = new Set(R.map(key));
// A row is explained either by a review on it, or by being a row that cannot
// have had FSRS state tampered with because it has none. The second case is
// real: a learner suspending or starring a card creates a scheduler row with
// reps 0, no stability and no review, and the review-correlation rule alone
// called that unexplained. First seen on 2026-10-05, a second user suspending
// an unrelated card mid-verification.
const studied = (r) => { const k = key(r); if (!rk.has(k)) return false; const bl = bLR.get(k) ?? null;
  return r.last_reviewed_at !== null && (bl === null || bl === "null" || new Date(r.last_reviewed_at) > new Date(bl)); };
const untouchedState = (r) =>
  r.reps === 0 && r.lapses === 0 && r.stability === null && r.last_reviewed_at === null;
const expl = (r) => studied(r) || untouchedState(r);
const moved = S.filter((r) => before.has(key(r)) && before.get(key(r)) !== line(r));
const appeared = S.filter((r) => !before.has(key(r)));
const vanished = [...before.keys()].filter((k) => !S.some((r) => key(r) === k));
chk("no scheduler row vanished", vanished.length === 0, String(vanished.length));
const unex = [...moved, ...appeared].filter((r) => !expl(r));
chk("every row that moved is explained by a review or carries no FSRS state at all",
  unex.length === 0,
  `${moved.length} changed, ${appeared.length} new, ${[...moved, ...appeared].filter((r) => !studied(r) && untouchedState(r)).length} non-study (suspend/star), ${unex.length} unexplained`);
chk("reviews only grew", R.length >= s.learnerBaseline.reviewRows, `${s.learnerBaseline.reviewRows} -> ${R.length}`);
chk("question attempts unchanged", QA.length === s.learnerBaseline.attemptRows, String(QA.length));
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
