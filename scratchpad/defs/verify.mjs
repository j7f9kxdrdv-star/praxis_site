import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/defs/pre_state.json", "utf8"));
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const RS = s.researchSettings, PDC = s.personalityDisorderClusters;
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,deprecated_by,parent_concept_id,concept_level");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,confidence,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id,mapping_status");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const AL = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id,section_code,is_primary");
const CD = await all("concept_disciplines", "concept_id,discipline_code,role");
const CCC = await all("concept_content_categories", "concept_id,content_category,is_primary");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await all("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at");
const QA = await all("question_attempts", "id");
const rs = C.find((c) => c.id === RS.id), pdc = C.find((c) => c.id === PDC.id);
const ser = (rows, k) => rows.map((r) => `${r[k]}|${r.role ?? ""}|${r.confidence ?? ""}|${r.mapping_status ?? ""}|${r.source ?? ""}`).sort().join("\n");
const tax = (id) => JSON.stringify({
  s: CS.filter((r) => r.concept_id === id).map((r) => r.section_code + (r.is_primary ? "*" : "")).sort(),
  d: CD.filter((r) => r.concept_id === id).map((r) => r.discipline_code + "[" + r.role + "]").sort(),
  c: CCC.filter((r) => r.concept_id === id).map((r) => r.content_category + (r.is_primary ? "*" : "")).sort() });
const taxWas = (o) => JSON.stringify({
  s: o.sections.map((r) => r.section_code + (r.is_primary ? "*" : "")).sort(),
  d: o.disciplines.map((r) => r.discipline_code + "[" + r.role + "]").sort(),
  c: o.contentCategories.map((r) => r.content_category + (r.is_primary ? "*" : "")).sort() });

console.log("MIGRATION 5 LIVE VERIFICATION  " + new Date().toISOString());
console.log(`  against snapshot ${s.takenAt}, sha256 ${s.sha256.slice(0, 16)}`);

for (const [tag, was, now] of [["RESEARCH SETTINGS", RS, rs], ["PERSONALITY DISORDER CLUSTERS", PDC, pdc]]) {
  console.log(`\n${tag}`);
  chk("  same UUID", now && now.id === was.id, now.id);
  chk("  same slug", now.slug === was.slug, now.slug);
  chk("  same canonical name", now.canonical_name === was.canonicalName, now.canonical_name);
  chk(`  still ${was.objectType} and ACTIVE_SEED`, now.object_type === was.objectType && now.status === "ACTIVE_SEED",
    `${now.object_type}/${now.status}`);
  chk("  version untouched", now.version === was.version, `${was.version} -> ${now.version}`);
  chk("  no parent added, level unchanged", !now.parent_concept_id && now.concept_level === was.conceptLevel);
  chk("  deprecated_by still null", now.deprecated_by === null);
  chk("  definition changed and is substantial",
    now.description !== was.description && String(now.description || "").trim().length > 150,
    `${String(was.description ?? "NULL").slice(0, 28)}... -> ${String(now.description).length} chars`);
  chk("  taxonomy byte-identical", tax(was.id) === taxWas(was), tax(was.id));
  chk("  no alias filed", AL.filter((r) => r.concept_id === was.id).length === was.aliases.length);
  chk("  flashcard mapping SET byte-identical",
    ser(FC.filter((r) => r.concept_id === was.id), "flashcard_id") === ser(was.flashcardMappings, "flashcard_id"),
    `${FC.filter((r) => r.concept_id === was.id).length} row(s)`);
  chk("  still no question or reasoning mapping",
    !QC.some((r) => r.concept_id === was.id) && !QRO.some((r) => r.concept_id === was.id));
}

console.log("\nTHE DEFINITIONS SAY WHAT THEY MUST");
chk("Research Settings names the inferential operation", String(rs.description).includes("inferential"));
chk("Research Settings rules out the recall reading", /not the objective/.test(String(rs.description)));
chk("the clusters definition names where the individual disorders live",
  String(pdc.description).includes("Cluster A, Cluster B and Cluster C"));

console.log("\nPOPULATIONS");
chk(`ontology objects unchanged at ${s.totals.concepts}`, C.length === s.totals.concepts, String(C.length));
chk(`flashcard_concepts unchanged at ${s.totals.flashcardConcepts}`, FC.length === s.totals.flashcardConcepts, String(FC.length));
chk(`question_concepts unchanged at ${s.totals.questionConcepts}`, QC.length === s.totals.questionConcepts, String(QC.length));
chk(`question_reasoning_objects unchanged at ${s.totals.reasoningObjects}`, QRO.length === s.totals.reasoningObjects, String(QRO.length));
chk(`aliases unchanged at ${s.totals.aliases}`, AL.length === s.totals.aliases, String(AL.length));
chk(`deprecated unchanged at ${s.totals.deprecated}`, C.filter((c) => c.status === "DEPRECATED").length === s.totals.deprecated);
chk(`NEEDS_REVIEW unchanged at ${s.totals.needsReview}`,
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === s.totals.needsReview,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));

console.log("\nLEARNER DATA");
const before = new Map(fs.readFileSync("scratchpad/defs/pre_fsrs_rows.txt", "utf8").split("\n").filter(Boolean)
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
chk("every row that moved has a fresh review on it", unexplained.length === 0,
  `${moved.length} changed, ${appeared.length} new, ${unexplained.length} unexplained`);
chk("reviews only grew", R.length >= s.learnerBaseline.reviewRows, `${s.learnerBaseline.reviewRows} -> ${R.length}`);
chk("question attempts unchanged", QA.length === s.learnerBaseline.attemptRows, String(QA.length));
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
