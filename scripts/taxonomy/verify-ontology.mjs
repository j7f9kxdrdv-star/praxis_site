/*
 * Verify the concept ontology after the migration has been applied.
 *
 *   node scripts/taxonomy/verify-ontology.mjs
 *
 * WHY THIS IS A SCRIPT AND NOT A UNIT TEST. Most of what matters here lives in
 * the database: triggers that refuse writes, partial unique indexes, CHECK
 * constraints. None of that can be exercised without a real connection, and
 * none of it had ever executed until something tried. The human-validation
 * trigger shipped working only because a fixture was pushed through it.
 *
 * Everything below is READ-ONLY except one clearly-marked fixture block, which
 * creates a throwaway concept, drives the guards against it, and removes it.
 * The script fails loudly if any residue survives.
 */
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";

const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));

let pass = 0, fail = 0;
const ok = (name, good, detail = "") => {
  good ? pass++ : fail++;
  console.log("  " + (good ? "ok  " : "FAIL") + "  " + name + (detail ? "   " + detail : ""));
};
/**
 * Count rows, or die saying so.
 *
 * This used to read `.count` and ignore `error`. A transient connection failure
 * then returned null, null never equals the expected number, and the script
 * reported it as "your data is wrong" - sending someone to hunt a data bug that
 * did not exist. A verifier that turns its own failures into your failures is
 * worse than no verifier. It happened once, on content-category rows.
 */
const count = async (t, q = (x) => x) => {
  const res = await q(db.from(t).select("*", { count: "exact", head: true }));
  if (res.error) throw new Error(`count(${t}) failed: ${res.error.message}`);
  if (typeof res.count !== "number") throw new Error(`count(${t}) returned no count`);
  return res.count;
};

async function all(t, c) {
  let out = [], from = 0;
  for (;;) {
    const { data, error } = await db.from(t).select(c).range(from, from + 999);
    if (error) throw new Error(t + ": " + error.message);
    out = out.concat(data);
    if (data.length < 1000) break;
    from += 1000;
  }
  return out;
}

console.log("\nSEEDED VOCABULARY");
const concepts = await all("concepts", "id,slug,canonical_name,status,split_candidate,concept_level,parent_concept_id");
ok("488 concepts seeded", concepts.length === 488, String(concepts.length));
ok("all ACTIVE_SEED", concepts.every((c) => c.status === "ACTIVE_SEED"));
ok("200 split candidates flagged", concepts.filter((c) => c.split_candidate).length === 200);
ok("slugs unique", new Set(concepts.map((c) => c.slug)).size === concepts.length);
ok("canonical names unique", new Set(concepts.map((c) => c.canonical_name)).size === concepts.length);
ok("hierarchy left flat", concepts.every((c) => c.concept_level === "CONCEPT" && !c.parent_concept_id));

console.log("\nRELATIONSHIPS");
ok("discipline rows = 488", (await count("concept_disciplines")) === 488);
ok("content-category rows = 491", (await count("concept_content_categories")) === 491);
ok("concept_relationships empty (seeded by hand only)", (await count("concept_relationships")) === 0);

console.log("\nDETERMINISTIC QUESTION MAPPING");
const qc = await all("question_concepts", "question_id,concept_id,role,mapping_status,source,confidence");
ok("2,242 mappings created", qc.length === 2242, String(qc.length));
ok("all DETERMINISTIC_EXACT", qc.every((m) => m.source === "DETERMINISTIC_EXACT"));
ok("all PRIMARY", qc.every((m) => m.role === "PRIMARY"));
ok("no duplicate PRIMARY per question", new Set(qc.map((m) => m.question_id)).size === qc.length);
ok("none marked human-validated", qc.every((m) => m.mapping_status !== "HUMAN_VALIDATED"));

const Q = await all("questions", "id,subtopic,section,content_category");
const byId = new Map(concepts.map((c) => [c.id, c]));
const qById = new Map(Q.map((q) => [q.id, q]));
ok("every mapping is exact string equality",
  qc.every((m) => qById.get(m.question_id)?.subtopic === byId.get(m.concept_id)?.canonical_name));

const SEC = { chem_phys: "CHEM_PHYS", bio_biochem: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", cars: "CARS" };
// MEMBERSHIP, not equality. This check originally compared a single
// concepts.section_code and failed on 4 mappings, which looked like a mapping
// bug and was really a schema one: "Isoelectric Focusing" is examined in two
// MCAT sections, so no single value could have been right.
const sects = (await all("concept_sections", "concept_id,section_code"))
  .reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.section_code), a), {});
ok("section compatible on every mapping",
  qc.every((m) => sects[m.concept_id]?.has(SEC[qById.get(m.question_id)?.section])));
ok("488 concepts placed in a section", new Set(Object.keys(sects)).size === 488);
ok("cross-section concepts are represented, not flattened",
  Object.values(sects).filter((s) => s.size > 1).length === 1);

const cc = await all("concept_content_categories", "concept_id,content_category");
const catsOf = cc.reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.content_category), a), {});
ok("content category compatible on every mapping",
  qc.every((m) => catsOf[m.concept_id]?.has(qById.get(m.question_id)?.content_category)));

console.log("\nDELIBERATELY LEFT ALONE");
const mapped = new Set(qc.map((m) => m.question_id));
const unmapped = Q.filter((q) => !mapped.has(q.id));
ok("439 descriptor questions unmapped", unmapped.length === 439, String(unmapped.length));
ok("no unmapped question's label is a concept name",
  unmapped.every((q) => !concepts.some((c) => c.canonical_name === q.subtopic)));
ok("zero flashcards mapped", (await count("flashcard_concepts")) === 0);

console.log("\nCONTENT AND LEARNER DATA UNCHANGED");
ok("questions 2,681", (await count("questions")) === 2681);
ok("flashcards 4,117", (await count("flashcards")) === 4117);
ok("decks 73", (await count("flashcard_decks")) === 73);
ok("distractor metadata 8,043", (await count("question_distractor_metadata")) === 8043);
const UID = "ee01e0e1-ac92-4ea7-92c9-2738b82b6dca";
for (const [t, want] of Object.entries({ flashcard_reviews: 47777, flashcard_user_state: 7147, question_attempts: 201 })) {
  ok(t + " " + want.toLocaleString(), (await count(t, (q) => q.eq("user_id", UID))) === want);
}

console.log("\nCONCENTRATION CHECK (a catch-all forming?)");
const per = qc.reduce((a, m) => ((a[m.concept_id] = (a[m.concept_id] || 0) + 1), a), {});
const top = Object.entries(per).sort((a, b) => b[1] - a[1]).slice(0, 5);
top.forEach(([id, n]) => console.log("        " + String(n).padStart(3) + "  " + byId.get(id)?.canonical_name));
ok("largest concept under 120 questions", top[0][1] < 120, top[0][1] + " max");
ok("191 concepts carry a single question",
  Object.values(per).filter((n) => n === 1).length + (488 - Object.keys(per).length) === 191);

console.log("\nDATABASE GUARDS  (fixture: created, driven, removed)");
let fixture = null;
try {
  const { data: f, error } = await db.from("concepts")
    .insert({ slug: "__FIXTURE_DELETE_ME__", canonical_name: "Fixture Delete Me", status: "DRAFT" })
    .select("id").single();
  if (error) throw new Error("fixture insert: " + error.message);
  fixture = f.id;

  const { error: e1 } = await db.from("concepts").update({ parent_concept_id: fixture }).eq("id", fixture);
  ok("a concept cannot be its own parent", !!e1);

  const { error: e2 } = await db.from("concepts")
    .update({ parent_concept_id: concepts[0].id, concept_level: "CONCEPT" }).eq("id", fixture);
  ok("a child must be SUBCONCEPT", !!e2);

  const { error: e3 } = await db.from("concepts")
    .update({ parent_concept_id: concepts[0].id, concept_level: "SUBCONCEPT" }).eq("id", fixture);
  ok("a valid two-level parent is accepted", !e3, e3?.message ?? "");

  await db.from("concepts").update({ parent_concept_id: null, concept_level: "CONCEPT" }).eq("id", fixture);

  const { error: e4 } = await db.from("concepts")
    .update({ canonical_name: "Fixture Renamed" }).eq("id", fixture);
  const { data: alias } = await db.from("concept_aliases").select("alias").eq("concept_id", fixture);
  ok("rename files the old name as an alias", !e4 && alias?.some((a) => a.alias === "Fixture Delete Me"));

  await db.from("concepts").update({ status: "DEPRECATED" }).eq("id", fixture);
  const someQ = Q[0].id;
  const { error: e5 } = await db.from("question_concepts")
    .insert({ question_id: someQ, concept_id: fixture, role: "SECONDARY", mapping_status: "AI_PROPOSED", source: "AI_PROPOSED" });
  ok("a DEPRECATED concept refuses new mappings", !!e5);
} catch (err) {
  console.error("  FIXTURE ERROR:", err.message);
  fail++;
} finally {
  if (fixture) {
    await db.from("question_concepts").delete().eq("concept_id", fixture);
    await db.from("concept_aliases").delete().eq("concept_id", fixture);
    await db.from("concepts").delete().eq("id", fixture);
  }
  const left = (await count("concepts")) === 488 && (await count("concept_aliases")) === 0;
  ok("fixture fully removed, no residue", left);
}

console.log("\n" + (fail ? `${fail} FAILURE(S), ${pass} passed` : `all ${pass} checks pass`));
process.exit(fail ? 1 : 0);
