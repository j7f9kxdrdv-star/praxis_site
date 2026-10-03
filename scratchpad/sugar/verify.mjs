// Migration 3 verification, live and from outside the migration, against the
// immutable pre-rename snapshot.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/sugar/pre_rename_snapshot.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const MOVE = ["29efd5f2-32cc-4e7a-a799-947d92ebee71","56644b98-ee7f-4189-b08c-7126fcc508f0","d0f19c7b-2255-4544-8576-0558117cacba"];
const STAY = ["18ee658b-e1c8-463d-b495-20e0283148b3","e45c97f6-a36b-45c4-83df-2693fb8e3a88"];
const A = s.conceptA.id, B = s.conceptB.id;

const C = await all("concepts", "id,slug,canonical_name,description,status,object_type,version");
const QC = await all("question_concepts", "question_id,concept_id,role,mapping_status,source");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type,source,status");
const CS = await all("concept_sections", "concept_id");
const CD = await all("concept_disciplines", "concept_id");
const CCC = await all("concept_content_categories", "concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at");
const QA = await all("question_attempts", "id");
const a = C.find((c) => c.id === A), b = C.find((c) => c.id === B);

console.log("MIGRATION 3 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}\n`);

console.log("1-2  THE RENAME");
chk("Sugar Oxidation Products exists under the ORIGINAL UUID", a && a.canonical_name === "Sugar Oxidation Products", a?.id);
chk("the UUID is byte-identical to the snapshot", a.id === s.conceptA.id);
chk("the slug is unchanged, per the rename convention", a.slug === s.conceptA.slug, a.slug);
chk("version incremented 1 -> 2", a.version === s.conceptA.version + 1, `${s.conceptA.version} -> ${a.version}`);
chk("still CONTENT and ACTIVE_SEED", a.object_type === "CONTENT" && a.status === "ACTIVE_SEED");
chk("it now carries a definition", String(a.description || "").trim().length > 80);
const legacy = AL.filter((r) => r.concept_id === A && r.alias === "Oxidation & Reducing Sugars");
chk("the old name exists as a LEGACY_NAME alias on the same concept",
  legacy.length === 1 && legacy[0].alias_type === "LEGACY_NAME",
  legacy.map((r) => `${r.alias_type}/${r.source}/${r.status}`).join(", "));
chk("no concept answers to the old name any more", !C.some((c) => c.canonical_name === "Oxidation & Reducing Sugars"));

console.log("\n3  CONCEPT B UNCHANGED");
chk("name, slug, status and version all as snapshotted",
  b.canonical_name === s.conceptB.canonicalName && b.slug === s.conceptB.slug &&
  b.status === s.conceptB.status && b.version === s.conceptB.version);
chk("it now carries a definition", String(b.description || "").trim().length > 80);

console.log("\n4-6  THE REPOINTS");
const onA = QC.filter((r) => r.concept_id === A), onB = QC.filter((r) => r.concept_id === B);
chk("exactly 2 reviewed questions remain on Sugar Oxidation Products", onA.length === 2, String(onA.length));
chk("they are the two oxidation-product questions", STAY.every((id) => onA.some((r) => r.question_id === id)));
chk("Reducing & Non-Reducing Sugars now holds 7 (4 original + 3 moved)", onB.length === 7, String(onB.length));
chk("exactly the 3 reviewed questions moved", MOVE.every((id) => onB.some((r) => r.question_id === id)));
chk("the 4 original B questions are untouched",
  s.conceptB.questionMappings.every((m) => onB.some((r) => r.question_id === m.question_id && r.source === m.source)));
chk("the 3 moved rows carry AI_PROPOSED / AI_PROPOSED and stayed PRIMARY",
  MOVE.every((id) => { const r = onB.find((x) => x.question_id === id); return r && r.mapping_status === "AI_PROPOSED" && r.source === "AI_PROPOSED" && r.role === "PRIMARY"; }));
chk("the 2 held rows kept their original provenance",
  STAY.every((id) => { const r = onA.find((x) => x.question_id === id); const o = s.conceptA.questionMappings.find((m) => m.question_id === id); return r && r.source === o.source && r.mapping_status === o.mapping_status; }));
chk("no new NEEDS_REVIEW row was created anywhere",
  QC.filter((r) => r.mapping_status === "NEEDS_REVIEW").length + FC.filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 29,
  String(QC.filter((r) => r.mapping_status === "NEEDS_REVIEW").length + FC.filter((r) => r.mapping_status === "NEEDS_REVIEW").length));

console.log("\n7-9  NOTHING ELSE MOVED");
chk("concept A flashcards unchanged at 2", FC.filter((r) => r.concept_id === A).length === 2);
chk("concept B flashcards unchanged at 4", FC.filter((r) => r.concept_id === B).length === 4);
chk("every flashcard mapping on both concepts is byte-identical to the snapshot",
  [...s.conceptA.flashcardMappings, ...s.conceptB.flashcardMappings].every((m) =>
    FC.some((r) => r.flashcard_id === m.flashcard_id && r.concept_id === m.concept_id && r.role === m.role && r.mapping_status === m.mapping_status)));
const prim = QC.filter((r) => r.role === "PRIMARY");
const live = new Set(C.filter((c) => c.status !== "DEPRECATED" && c.object_type === "CONTENT").map((c) => c.id));
chk("all 5 questions still hold exactly one live PRIMARY CONTENT mapping",
  [...MOVE, ...STAY].every((id) => prim.filter((r) => r.question_id === id && live.has(r.concept_id)).length === 1));
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping anywhere targets a deprecated concept",
  ![...QC, ...FC, ...QRO].some((r) => dep.has(r.concept_id)));

console.log("\n10-14  POPULATIONS");
chk(`ontology objects unchanged at ${s.totals.concepts}`, C.length === s.totals.concepts, String(C.length));
chk(`aliases ${s.totals.aliases} -> ${s.totals.aliases + 1}`, AL.length === s.totals.aliases + 1, String(AL.length));
chk(`question_concepts unchanged at ${s.totals.questionConcepts}`, QC.length === s.totals.questionConcepts, String(QC.length));
chk(`flashcard_concepts unchanged at ${s.totals.flashcardConcepts}`, FC.length === s.totals.flashcardConcepts, String(FC.length));
chk(`question_reasoning_objects unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects, String(QRO.length));
chk(`deprecated unchanged at ${s.totals.deprecated}`, C.filter((c) => c.status === "DEPRECATED").length === s.totals.deprecated);
chk("taxonomy rows on both concepts unchanged",
  [A, B].every((id) => CS.filter((r) => r.concept_id === id).length === 1 &&
    CD.filter((r) => r.concept_id === id).length === 1 && CCC.filter((r) => r.concept_id === id).length === 1));

console.log("\n15  LEARNER DATA");
const before = new Map(fs.readFileSync("scratchpad/sugar/pre_rename_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
  .map((l) => { const p = l.split("|"); return [`${p[0]}|${p[1]}|${p[2]}`, l]; }));
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.ease_factor}|${r.next_review_at}|${r.last_reviewed_at}|${r.suspended}`;
const beforeLR = new Map([...before].map(([k, l]) => [k, l.split("|")[11]]));
const reviewKeys = new Set(R.map(key));
const explained = (r) => { const k = key(r); if (!reviewKeys.has(k)) return false;
  const bl = beforeLR.get(k) ?? null;
  return r.last_reviewed_at !== null && (bl === null || bl === "null" || new Date(r.last_reviewed_at) > new Date(bl)); };
const moved = S.filter((r) => before.has(key(r)) && before.get(key(r)) !== line(r));
const appeared = S.filter((r) => !before.has(key(r)));
const vanished = [...before.keys()].filter((k) => !S.some((r) => key(r) === k));
const unexplained = [...moved, ...appeared].filter((r) => !explained(r));
chk("no scheduler row vanished", vanished.length === 0, String(vanished.length));
chk("every scheduler row that moved has a fresh review on it", unexplained.length === 0,
  `${moved.length} changed, ${appeared.length} new, ${unexplained.length} unexplained`);
chk("reviews only grew", R.length >= s.learnerBaseline.reviewRows, `${s.learnerBaseline.reviewRows} -> ${R.length}`);
chk("question attempts unchanged", QA.length === s.learnerBaseline.attemptRows, String(QA.length));

console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
