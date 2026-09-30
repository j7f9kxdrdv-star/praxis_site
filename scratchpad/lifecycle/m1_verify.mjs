// Migration 1 verification, read live and from OUTSIDE the migration. The
// in-file DO block already asserted its own work; this asks the database the
// same questions independently, plus the ones the migration could not ask about
// itself (did the UUID survive, did the name survive, did anything else move).
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const before = JSON.parse(fs.readFileSync("/tmp/m1_renames.json", "utf8"));
const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };

const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,updated_at,deprecated_by");
const bySlug = new Map(C.map((c) => [c.slug, c]));
const byId = new Map(C.map((c) => [c.id, c]));
const FC = await all("flashcard_concepts", "flashcard_id,concept_id");
const QC = await all("question_concepts", "question_id,concept_id");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const A = await all("concept_aliases", "concept_id,alias,alias_type");
const CS = await all("concept_sections", "concept_id");
const CD = await all("concept_disciplines", "concept_id");
const CCC = await all("concept_content_categories", "concept_id");
const S = await all("flashcard_user_state", "flashcard_id,cloze_index");
const R = await all("flashcard_reviews", "flashcard_id");

const NAMES = ["Vectors and Scalars", "Vector Addition and Components",
  "Vector Subtraction and Scalar Multiplication", "Dot and Cross Products"];
const CARDS = { QK_VECTORS_AND_SCALARS: 2, QK_VECTOR_ADDITION_AND_COMPONENTS: 4,
  QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION: 2, QK_DOT_AND_CROSS_PRODUCTS: 3 };

console.log("MIGRATION 1 LIVE VERIFICATION  " + new Date().toISOString());

console.log("\nTHE RENAME LANDED");
before.RENAMES.forEach(([oldSlug, newSlug, def], i) => {
  const c = bySlug.get(newSlug);
  chk(`${newSlug} exists`, !!c);
  if (!c) return;
  chk(`   ${oldSlug} is gone`, !bySlug.has(oldSlug));
  chk(`   SAME UUID as before the migration`, c.id === before.ids[i], c.id === before.ids[i] ? "" : `${before.ids[i]} -> ${c.id}`);
  chk(`   canonical_name untouched: ${NAMES[i]}`, c.canonical_name === NAMES[i], c.canonical_name);
  chk(`   description is byte-identical to the approved text`, c.description === def,
    c.description === def ? "" : JSON.stringify(c.description));
  chk(`   still QUANTITATIVE and live`, c.object_type === "QUANTITATIVE" && c.status !== "DEPRECATED" && !c.deprecated_by);
  chk(`   flashcard mappings still ${CARDS[newSlug]}`, FC.filter((r) => r.concept_id === c.id).length === CARDS[newSlug],
    String(FC.filter((r) => r.concept_id === c.id).length));
  chk(`   updated_at was bumped`, new Date(c.updated_at) > new Date("2026-09-30T18:00:00Z"), c.updated_at);
});

console.log("\nNOTHING ELSE MOVED");
const ids = new Set(before.ids);
chk("no question mapping appeared on any of the four", !QC.some((r) => ids.has(r.concept_id)));
chk("no reasoning mapping appeared on any of the four", !QRO.some((r) => ids.has(r.concept_id)));
chk("no content taxonomy appeared on any of the four",
  ![...CS, ...CD, ...CCC].some((r) => ids.has(r.concept_id)));
chk("no alias was filed, so canonical_name never changed", !A.some((r) => ids.has(r.concept_id)),
  `${A.length} aliases bank-wide, was 5`);
chk("ontology objects unchanged at 1,130", C.length === 1130, String(C.length));
chk("flashcard_concepts unchanged at 4,115", FC.length === 4115, String(FC.length));
chk("question_concepts unchanged at 2,673", QC.length === 2673, String(QC.length));
chk("question_reasoning_objects unchanged at 24", QRO.length === 24, String(QRO.length));
chk("slugs still globally unique", new Set(C.map((c) => c.slug)).size === C.length);

console.log("\nTHE CONVENTION NOW HOLDS BANK-WIDE");
const cross = C.filter((c) => c.object_type !== "CONTENT" && c.status !== "DEPRECATED");
const badPrefix = cross.filter((c) => !c.slug.startsWith(c.object_type === "REASONING" ? "RO_" : "QK_"));
chk("every reasoning and quantitative slug carries its axis prefix", badPrefix.length === 0,
  badPrefix.map((c) => c.slug).join(", "));
chk("every reasoning and quantitative object has a definition",
  cross.every((c) => String(c.description || "").trim()),
  cross.filter((c) => !String(c.description || "").trim()).map((c) => c.slug).join(", "));
chk("13 REASONING and 20 QUANTITATIVE, unchanged",
  cross.filter((c) => c.object_type === "REASONING").length === 13 &&
  cross.filter((c) => c.object_type === "QUANTITATIVE").length === 20);

console.log("\nLEARNER TABLES");
// The file's only write verb is UPDATE public.concepts, proven mechanically
// before it ran, so these are floors rather than equalities: Mikko studying
// between the two reads is legitimate growth, a DROP is not.
chk("scheduler rows never shrink below the 8,328 read before the migration", S.length >= 8328, String(S.length));
chk("reviews never shrink below the 50,017 read before the migration", R.length >= 50017, String(R.length));

console.log(P.length ? `\n${P.length} FAILURE(S): ` + P.join("; ") : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
