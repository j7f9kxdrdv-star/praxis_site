import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/cards/pre_state_8b.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const ID = s.card.id, ELASTIN = "d660225e-9617-4ee1-b7b0-d3d74ff80ba4";
const COLLAGEN = "ca5f08a7-3bc2-493b-8e82-dd2835e122f0", KERATIN = "328bd950-1833-4c3c-902c-a6a514ec322c";
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
const card = F.find((f) => f.id === ID), sp = C.find((c) => c.slug === "STRUCTURAL_PROTEINS");
const nm = new Map(C.map((c) => [c.id, c.canonical_name]));
console.log("MIGRATION 8b LIVE VERIFICATION  " + new Date().toISOString() + "\n");
console.log("THE CARD");
chk("same flashcard_id, deck and position", card.id === ID && card.deck_id === s.card.deck_id && card.position === s.card.position, card.id);
chk("cloze_count still 2", card.cloze_count === 2);
console.log(`     old: ${s.card.cloze_text}`);
console.log(`     new: ${card.cloze_text}`);
const c1 = [...card.cloze_text.matchAll(/\{\{c1::(.*?)\}\}/g)].map((m) => m[1]);
const c2 = [...card.cloze_text.matchAll(/\{\{c2::(.*?)\}\}/g)].map((m) => m[1]);
chk("c1 semantic identity unchanged: Structural proteins", JSON.stringify(c1) === JSON.stringify(["Structural proteins"]), c1.join("/"));
chk("c2 semantic identity unchanged: keratin", JSON.stringify(c2) === JSON.stringify(["keratin"]), c2.join("/"));
chk("the overgeneralisation is gone from the card", !/repetitive secondary structure/.test(card.cloze_text));
chk("it now states architecture and cross-linking", /fibrous architecture and cross-linking/.test(card.cloze_text));

console.log("\nTHE DEFINITION");
console.log(`     ${sp.description}`);
chk("same concept UUID and version", sp.id === s.concept.id && sp.version === s.concept.version, `${sp.id} v${sp.version}`);
chk("still CONTENT and ACTIVE", sp.object_type === "CONTENT" && sp.status === "ACTIVE_SEED");
chk("the overgeneralisation is gone from the definition", !/whose strength comes from highly repetitive secondary structure/.test(sp.description));
chk("it says the mechanism differs by protein", /mechanism differs by protein/.test(sp.description));
chk("it names all three and what each actually uses",
  /collagen a repetitive Gly-X-Y triple helix/.test(sp.description) && /keratin a coiled coil/.test(sp.description) &&
  /elastin a cross-linked network that recoils/.test(sp.description));
chk("taxonomy and aliases untouched",
  CS.filter((r) => r.concept_id === sp.id).length === s.concept.sections &&
  CD.filter((r) => r.concept_id === sp.id).length === s.concept.disciplines &&
  CCC.filter((r) => r.concept_id === sp.id).length === s.concept.categories &&
  AL.filter((r) => r.concept_id === sp.id).length === s.concept.aliases);

console.log("\nTHE MAPPINGS, INCLUDING THE DECISION THIS PROTECTS");
const el = FC.filter((r) => r.flashcard_id === ELASTIN);
chk("elastin still has NO Structural Proteins mapping", !el.some((r) => r.concept_id === sp.id));
chk("elastin still holds exactly its one original mapping",
  el.length === 1 && el[0].role === "PRIMARY", el.map((r) => `${r.role}->${nm.get(r.concept_id)}`).join(", "));
chk("collagen SECONDARY remains",
  FC.some((r) => r.flashcard_id === COLLAGEN && r.concept_id === sp.id && r.role === "SECONDARY"));
chk("keratin SECONDARY remains",
  FC.some((r) => r.flashcard_id === KERATIN && r.concept_id === sp.id && r.role === "SECONDARY"));
chk("the concept still holds exactly 1 PRIMARY and 2 SECONDARY",
  FC.filter((r) => r.concept_id === sp.id).length === 3 &&
  FC.filter((r) => r.concept_id === sp.id && r.role === "SECONDARY").length === 2);
chk("the definition is now compatible with every example it maps",
  /elastin a cross-linked network/.test(sp.description) && !/repetitive secondary structure/.test(card.cloze_text));

console.log("\nLEARNER HISTORY");
const fld = (r) => `${r.cloze_index}|${r.user_id}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}|${r.last_rating}|${r.scheduled_days}|${r.learning_steps}|${r.starred}`;
const now = S.filter((r) => r.flashcard_id === ID).map(fld).sort();
const was = s.card.schedulerRows.map(fld).sort();
chk("scheduler rows byte-identical", now.length === was.length && now.every((r, i) => r === was[i]), `${was.length} row(s)`);
const nr = R.filter((r) => r.flashcard_id === ID).map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
const orr = s.card.reviews.map((r) => `${r.id}|${r.reviewed_at}|${r.rating}`).sort();
chk("review history byte-identical", nr.length === orr.length && nr.every((r, i) => r === orr[i]), `${orr.length} review(s)`);

console.log("\nPOPULATIONS");
const mapped = new Set(FC.map((r) => r.flashcard_id));
chk("unique flashcard coverage remains 4,118 of 4,118", mapped.size === F.length && F.length === 4118, `${mapped.size} / ${F.length}`);
chk("mapping rows unchanged at 4,121", FC.length === s.totals.mappingRows, String(FC.length));
chk("concepts unchanged at 1,139", C.length === s.totals.concepts, String(C.length));
chk("NEEDS_REVIEW remains 29",
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 29,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
