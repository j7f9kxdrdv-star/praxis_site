// Migration 1 preflight: four QUANTITATIVE slugs get the QK_ prefix and a
// definition. No mapping moves. Everything below must pass BEFORE the SQL runs,
// and the last block is the runtime-reference audit Mikko asked for.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
import { execSync } from "node:child_process";

const RENAMES = [
  ["VECTORS_AND_SCALARS", "QK_VECTORS_AND_SCALARS",
   "Magnitude with direction versus magnitude alone, and which physical quantities are which."],
  ["VECTOR_ADDITION_AND_COMPONENTS", "QK_VECTOR_ADDITION_AND_COMPONENTS",
   "Tip-to-tail addition, resolution into signed perpendicular components, and the magnitude and angle of the resultant."],
  ["VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION", "QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION",
   "Subtraction as adding the reverse, and how a scalar multiple rescales and flips a vector."],
  ["DOT_AND_CROSS_PRODUCTS", "QK_DOT_AND_CROSS_PRODUCTS",
   "The scalar product and its cosine, the vector product and its sine, and the right-hand rule."],
];

const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };

const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,updated_at");
const bySlug = new Map(C.map((c) => [c.slug, c]));
const FC = await all("flashcard_concepts", "flashcard_id,concept_id");
const QC = await all("question_concepts", "question_id,concept_id");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");

console.log("MIGRATION 1 PREFLIGHT  " + new Date().toISOString());
console.log("\nTARGETS");
const targets = [];
for (const [oldSlug, newSlug, def] of RENAMES) {
  const c = bySlug.get(oldSlug);
  chk(`${oldSlug} exists`, !!c);
  if (!c) continue;
  targets.push(c);
  chk(`   is QUANTITATIVE`, c.object_type === "QUANTITATIVE", c.object_type);
  chk(`   is not deprecated`, c.status !== "DEPRECATED", c.status);
  chk(`   description is currently empty`, !String(c.description || "").trim());
  chk(`   ${newSlug} is free`, !bySlug.has(newSlug));
  chk(`   new slug keeps the QK_ convention`, /^QK_[A-Z0-9_]+$/.test(newSlug));
  chk(`   definition is non-empty and has no em or en dash`,
    def.length > 20 && !/[–—―]/.test(def));
  chk(`   has flashcard evidence to define from`, FC.filter((r) => r.concept_id === c.id).length > 0,
    FC.filter((r) => r.concept_id === c.id).length + " cards");
}

console.log("\nNOTHING MOVES");
const ids = new Set(targets.map((c) => c.id));
chk("no question_concepts row points at any of the four",
  !QC.some((r) => ids.has(r.concept_id)), String(QC.filter((r) => ids.has(r.concept_id)).length));
chk("no question_reasoning_objects row points at any of the four",
  !QRO.some((r) => ids.has(r.concept_id)));
const cardsBefore = targets.map((c) => FC.filter((r) => r.concept_id === c.id).length);
chk("flashcard mappings are 2, 4, 2, 3 and must be unchanged after",
  JSON.stringify(cardsBefore) === "[2,4,2,3]", JSON.stringify(cardsBefore));
chk("the four are the only QUANTITATIVE objects missing the QK_ prefix",
  C.filter((c) => c.object_type === "QUANTITATIVE" && !c.slug.startsWith("QK_")).length === 4);
chk("the four are the only QUANTITATIVE objects missing a description",
  C.filter((c) => c.object_type === "QUANTITATIVE" && !c.description).length === 4);

console.log("\nRUNTIME-REFERENCE AUDIT");
const g = (cmd) => { try { return execSync(cmd, { encoding: "utf8" }).trim(); } catch { return ""; } };
const appHits = g(`grep -rn "${RENAMES.map(r => r[0]).join('\\|')}" --include='*.ts' --include='*.tsx' lib app components 2>/dev/null`);
chk("no app code mentions any old slug", appHits === "", appHits.split("\n")[0] || "");
const prefixPartition = g(`grep -rn "startsWith(.QK_\\|startsWith(.RO_\\|LIKE 'QK\\|LIKE 'RO" --include='*.ts' --include='*.tsx' --include='*.sql' lib app components supabase 2>/dev/null`);
chk("nothing partitions objects by slug prefix", prefixPartition === "", prefixPartition.split("\n")[0] || "");
const resolveSrc = fs.readFileSync("lib/taxonomy/resolve.ts", "utf8");
chk("resolve.ts joins on concept_id, never on slug",
  /concept_id/.test(resolveSrc) && !/eq\(\s*["']slug/.test(resolveSrc) && !/\.eq\(["']concepts\.slug/.test(resolveSrc));
const objTypeSrc = fs.readFileSync("lib/taxonomy/objectType.ts", "utf8");
chk("objectType.ts partitions on the object_type column, not a slug prefix",
  /objectType === "QUANTITATIVE"/.test(objTypeSrc) && !/slug\.startsWith/.test(objTypeSrc));
const views = g(`grep -rn "CREATE OR REPLACE VIEW" -A1 supabase/migrations/20260924_object_type.sql`);
chk("the three type views filter on object_type", /object_type = /.test(views) && !/slug/.test(views));
const seedHits = g(`grep -rln "${RENAMES.map(r => r[0]).join('\\|')}" supabase scripts 2>/dev/null`);
console.log("     files referencing an old slug (documentation only, not re-run): " + (seedHits.split("\n").filter(Boolean).join(", ") || "none"));

console.log("\nALIAS MACHINERY");
const trig = fs.readFileSync("supabase/migrations/20260923_concept_ontology_seed.sql", "utf8");
chk("the rename trigger fires on canonical_name only, so a slug change files NO alias",
  /BEFORE UPDATE OF canonical_name ON public\.concepts/.test(trig));
const aliasCheck = fs.readFileSync("supabase/migrations/20260923_taxonomy_interop.sql", "utf8");
chk("alias_type has no slug member, so filing one would need a CHECK change",
  !/LEGACY_SLUG/.test(aliasCheck));

// A preflight snapshot is the ONLY record of the pre-migration UUIDs, and it is
// what the post-migration check compares against. Re-running this after the
// migration would overwrite it with an empty target list and turn the UUID
// check into a comparison against undefined, which reads as a failure while
// actually proving nothing. I did exactly that once. Refuse instead.
if (!targets.length) {
  console.log("\nREFUSING to overwrite /tmp/m1_renames.json: the old slugs are gone, so this migration has already run. The pre-migration snapshot is not reproducible after the fact.");
  process.exit(P.length ? 1 : 0);
}
fs.writeFileSync("/tmp/m1_renames.json", JSON.stringify({ RENAMES, cardsBefore, ids: targets.map(c => c.id) }, null, 1));
console.log(P.length ? `\n${P.length} PROBLEM(S): ` + P.join("; ") : "\nPreflight clean. Safe to generate the SQL.");
process.exit(P.length ? 1 : 0);
