// Migration 2 verification, live and from OUTSIDE the migration, against the
// immutable pre-split snapshot.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const snap = JSON.parse(fs.readFileSync("scratchpad/lipid/pre_split_snapshot.json", "utf8"));
const man = JSON.parse(fs.readFileSync("scratchpad/lipid/manifest.json", "utf8"));
const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };

const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,concept_level,parent_concept_id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const QRO = await all("question_reasoning_objects", "concept_id");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const A = await all("concept_aliases", "concept_id,alias");
// Must select EXACTLY the columns the snapshot recorded, in the same order.
// Selecting fewer makes every row differ on undefined and reads as mass damage.
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at");
const QA = await all("question_attempts", "id");

const parent = C.find((c) => c.id === snap.parent.id);
const a = C.find((c) => c.slug === man.slugs[0]);
const b = C.find((c) => c.slug === man.slugs[1]);

console.log("MIGRATION 2 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  snapshot taken ${snap.takenAt}, sha256 ${snap.sha256.slice(0, 16)}\n`);

console.log("PARENT");
chk("parent still exists, not hard-deleted", !!parent);
chk("parent id unchanged", parent.id === snap.parent.id, parent.id);
chk("parent canonical name unchanged", parent.canonical_name === snap.parent.canonicalName, parent.canonical_name);
chk(`status ${snap.parent.status} -> DEPRECATED`, parent.status === "DEPRECATED", parent.status);
chk("deprecated_by IS NULL, a split names no successor", parent.deprecated_by === null, String(parent.deprecated_by));
chk("version incremented", parent.version === snap.parent.version + 1, `${snap.parent.version} -> ${parent.version}`);
chk("no concept anywhere names a child as its successor",
  !C.some((c) => c.deprecated_by === a?.id || c.deprecated_by === b?.id));

console.log("\nCHILDREN");
chk("both children exist", !!a && !!b);
chk("children have distinct new UUIDs, neither reusing the parent",
  a.id !== b.id && a.id !== parent.id && b.id !== parent.id, `${a.id.slice(0,8)} / ${b.id.slice(0,8)}`);
chk("child 1 name and slug", a.canonical_name === man.names[0] && a.slug === man.slugs[0], `${a.canonical_name}`);
chk("child 2 name and slug", b.canonical_name === man.names[1] && b.slug === man.slugs[1], `${b.canonical_name}`);
chk("both are CONTENT, ACTIVE_SEED, flat", [a, b].every((c) =>
  c.object_type === "CONTENT" && c.status === "ACTIVE_SEED" && c.concept_level === "CONCEPT" && !c.parent_concept_id));
chk("both carry a definition", [a, b].every((c) => String(c.description || "").trim().length > 80));

console.log("\nEVIDENCE ON THE PARENT");
chk("0 flashcard mappings remain on the parent", FC.filter((r) => r.concept_id === parent.id).length === 0,
  String(FC.filter((r) => r.concept_id === parent.id).length));
chk("0 question mappings remain on the parent", QC.filter((r) => r.concept_id === parent.id).length === 0,
  String(QC.filter((r) => r.concept_id === parent.id).length));
chk("0 reasoning mappings on the parent", QRO.filter((r) => r.concept_id === parent.id).length === 0);

console.log("\nREDISTRIBUTION");
const fcA = FC.filter((r) => r.concept_id === a.id), fcB = FC.filter((r) => r.concept_id === b.id);
const qcA = QC.filter((r) => r.concept_id === a.id), qcB = QC.filter((r) => r.concept_id === b.id);
chk("6 cards on Adipose Fat Mobilization, all PRIMARY",
  fcA.length === 6 && fcA.every((r) => r.role === "PRIMARY"), String(fcA.length));
chk("16 card rows on Lipoprotein Transport: 15 PRIMARY + 1 SECONDARY",
  fcB.length === 16 && fcB.filter((r) => r.role === "PRIMARY").length === 15 && fcB.filter((r) => r.role === "SECONDARY").length === 1,
  `${fcB.length} rows`);
chk("every card landed where the manifest said",
  man.cardsA.every((id) => fcA.some((r) => r.flashcard_id === id)) &&
  man.cardsB.every((id) => fcB.some((r) => r.flashcard_id === id && r.role === "PRIMARY")));
chk("4 questions on mobilization, 3 on transport", qcA.length === 4 && qcB.length === 3, `${qcA.length} / ${qcB.length}`);
chk("every question landed where the manifest said",
  man.qA.every((id) => qcA.some((r) => r.question_id === id)) &&
  man.qB.every((id) => qcB.some((r) => r.question_id === id)));
const str = FC.filter((r) => r.flashcard_id === man.straddle);
chk("straddle card: exactly PRIMARY on mobilization and SECONDARY on transport",
  str.length === 2 && str.some((r) => r.concept_id === a.id && r.role === "PRIMARY") &&
  str.some((r) => r.concept_id === b.id && r.role === "SECONDARY"),
  str.map((r) => `${r.role}->${r.concept_id === a.id ? "mobilization" : "transport"}`).join(", "));
chk("all 21 original cards still mapped somewhere, none lost",
  snap.flashcards.every((r) => FC.some((x) => x.flashcard_id === r.flashcard_id)));
chk("all 7 original questions still mapped, none lost",
  snap.questions.every((r) => QC.some((x) => x.question_id === r.question_id)));

console.log("\nGOVERNANCE");
const split = [...fcA, ...fcB, ...qcA, ...qcB];
chk("every split-affected mapping is NEEDS_REVIEW",
  split.every((r) => r.mapping_status === "NEEDS_REVIEW"),
  JSON.stringify(split.reduce((o, r) => ((o[r.mapping_status] = (o[r.mapping_status] || 0) + 1), o), {})));
chk("nothing was marked HUMAN_VALIDATED", !split.some((r) => r.mapping_status === "HUMAN_VALIDATED"));
console.log("     source distribution: " + JSON.stringify(split.reduce((o, r) => ((o[r.source] = (o[r.source] || 0) + 1), o), {})));
chk("provenance preserved: card sources still AI_PROPOSED, question sources still DETERMINISTIC_EXACT",
  [...fcA, ...fcB].filter((r) => r.role === "PRIMARY").every((r) => r.source === "AI_PROPOSED") &&
  [...qcA, ...qcB].every((r) => r.source === "DETERMINISTIC_EXACT"));

console.log("\nTAXONOMY");
chk("each child has exactly one section, discipline and category",
  [a, b].every((c) => CS.filter((r) => r.concept_id === c.id).length === 1 &&
    CD.filter((r) => r.concept_id === c.id).length === 1 &&
    CCC.filter((r) => r.concept_id === c.id).length === 1));
chk("inherited exactly the parent's three, nothing broader",
  [a, b].every((c) =>
    CS.find((r) => r.concept_id === c.id)?.section_code === "BIO_BIOCHEM" &&
    CD.find((r) => r.concept_id === c.id)?.discipline_code === "BIOCHEMISTRY" &&
    CCC.find((r) => r.concept_id === c.id)?.content_category === "Metabolism of Fatty Acids and Proteins"));
chk("the deprecated parent kept its taxonomy, so history stays readable",
  CS.filter((r) => r.concept_id === parent.id).length === 1);
chk("no alias was filed: canonical_name never changed", !A.some((r) => r.concept_id === parent.id),
  `${A.length} aliases bank-wide, was ${snap.totals.conceptAliases}`);

console.log("\nPOPULATION");
chk(`concepts ${snap.totals.concepts} -> ${snap.totals.concepts + 2}`, C.length === snap.totals.concepts + 2, String(C.length));
chk(`flashcard_concepts ${snap.totals.flashcardConcepts} -> ${snap.totals.flashcardConcepts + 1} (one new SECONDARY)`,
  FC.length === snap.totals.flashcardConcepts + 1, String(FC.length));
chk(`question_concepts unchanged at ${snap.totals.questionConcepts} (repointed, not added)`,
  QC.length === snap.totals.questionConcepts, String(QC.length));
chk("deprecated count rose by exactly 1",
  C.filter((c) => c.status === "DEPRECATED").length === (snap.totals.concepts - snap.totals.activeConcepts) + 1,
  String(C.filter((c) => c.status === "DEPRECATED").length));

console.log("\nLEARNER DATA");
const bl = snap.learnerBaseline;
const beforeRows = new Map(fs.readFileSync("scratchpad/lipid/pre_split_fsrs_rows.txt", "utf8").split("\n")
  .filter(Boolean).map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const vanished = [...beforeRows.keys()].filter((k) => !S.some((r) => key(r) === k));
// Correlate on the row's OWN last_reviewed_at advancing, not on a wall-clock
// window. The snapshot stamps takenAt AFTER its reads, so a review landing
// between the state read and that stamp looks unexplained purely from timing.
// A row whose last_reviewed_at moved forward, and which has a matching review,
// was reviewed. That test cannot be fooled by read skew.
const reviewKeys = new Set(R.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`));
const beforeLastReviewed = new Map([...beforeRows].map(([k, l]) => [k, l.split("|")[11]]));
const explained = (r) => {
  const k = `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
  if (!reviewKeys.has(k)) return false;
  const b = beforeLastReviewed.get(k) ?? null;
  return r.last_reviewed_at !== null && (b === null || b === "null" || new Date(r.last_reviewed_at) > new Date(b));
};
const reviewed = { size: R.filter((r) => r.reviewed_at >= snap.takenAt).length };
const moved = S.filter((r) => { const b = beforeRows.get(key(r)); return b !== undefined && b !== line(r); });
const appeared = S.filter((r) => !beforeRows.has(key(r)));
const unexplained = [...moved, ...appeared].filter((r) => !explained(r));
chk("no scheduler row vanished", vanished.length === 0, String(vanished.length));
chk("every scheduler row that moved is explained by a review since the snapshot",
  unexplained.length === 0,
  `${moved.length} changed, ${appeared.length} new, all with a fresh review on the row, ${unexplained.length} unexplained`);
chk("reviews only grew", R.length >= bl.flashcardReviewRows, `${bl.flashcardReviewRows} -> ${R.length}`);
chk("question_attempts unchanged", QA.length === bl.questionAttemptRows, `${QA.length}`);

console.log(P.length ? `\n${P.length} FAILURE(S): ` + P.join("; ") : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
