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
const concepts = await all("concepts", "id,slug,canonical_name,description,status,deprecated_by,split_candidate,concept_level,parent_concept_id,object_type");
// A FLOOR. Vocabulary growth is the point of the programme, so an equality here
// would fail on success. The exact before-and-after belongs to each seeding
// migration, where it proves that migration did what it said.
ok("ontology objects never shrink below 1,129", concepts.length >= 1129, String(concepts.length));
// 83 immune labels are DEPRECATED by the question-side reconciliation. Every
// other object is still ACTIVE_SEED, and a deprecated one must name a successor
// so an attempt recorded against it can still be explained.
const deprecated = concepts.filter((c) => c.status === "DEPRECATED");
const byIdEarly = new Map(concepts.map((c) => [c.id, c]));
ok("every object is ACTIVE_SEED or DEPRECATED", concepts.every((c) => c.status === "ACTIVE_SEED" || c.status === "DEPRECATED"));
// The COUNT is the weakest of these three and is only a floor: deprecation is
// monotonic under the lifecycle model, nothing is ever un-deprecated. The
// invariants that actually protect learner history are the other two, which hold
// at any count.
ok("deprecations never reverse, floor 176", deprecated.length >= 176, String(deprecated.length));
// A MERGE leaves a successor; a SPLIT cannot, because there is no single heir
// and naming one would assert something false. So successorless deprecation is
// legal only where a split was deliberately performed, and the legal cases are
// named here rather than waved through by relaxing the rule. A new
// successorless deprecation that nobody recorded still fails.
const SPLIT_PARENTS = ["LIPID_MOBILIZATION_TRANSPORT"];
const orphaned = deprecated.filter((c) => !c.deprecated_by && !SPLIT_PARENTS.includes(c.slug));
ok("every deprecated concept names a successor, except recorded split parents",
  orphaned.length === 0, orphaned.map((c) => c.slug).join(", "));
ok("every recorded split parent is in fact deprecated and successorless",
  SPLIT_PARENTS.every((sl) => {
    const c = concepts.find((x) => x.slug === sl);
    return c && c.status === "DEPRECATED" && !c.deprecated_by;
  }),
  SPLIT_PARENTS.filter((sl) => {
    const c = concepts.find((x) => x.slug === sl);
    return !(c && c.status === "DEPRECATED" && !c.deprecated_by);
  }).join(", "));

// The children a split produced must exist and be live. Without this, deleting
// both children would leave the rule above passing on a parent deprecated into
// nothing at all.
const SPLIT_CHILDREN = ["ADIPOSE_FAT_MOBILIZATION", "LIPOPROTEIN_CLASSES_CHOLESTEROL_TRANSPORT"];
const kids = concepts.filter((c) => SPLIT_CHILDREN.includes(c.slug));
ok("the lipid split children exist, are live, and carry definitions",
  kids.length === 2 && kids.every(
    (c) => c.status === "ACTIVE_SEED" && c.object_type === "CONTENT" && String(c.description || "").trim()),
  `${kids.length} of 2`);
ok("no deprecated_by points at a concept that does not exist",
  deprecated.every((c) => !c.deprecated_by || byIdEarly.has(c.deprecated_by)),
  deprecated.filter((c) => c.deprecated_by && !byIdEarly.has(c.deprecated_by)).map((c) => c.slug).join(", "));
ok("200 split candidates flagged", concepts.filter((c) => c.split_candidate).length === 200);
ok("the rename kept one concept and filed an alias",
  concepts.some((c) => c.canonical_name === "Respiratory Thermoregulation") &&
  !concepts.some((c) => c.canonical_name === "Thermoregulation"));

// Every rename in this programme, as a rule over a named set: the concept
// answers to its new name, its old name is gone as a canonical name, the old
// name survives as a LEGACY_NAME alias, and the SLUG is untouched. That last
// clause is the project's convention, and the reason Respiratory
// Thermoregulation still carries the slug THERMOREGULATION.
const RENAMES = [
  { slug: "THERMOREGULATION", from: "Thermoregulation", to: "Respiratory Thermoregulation" },
  { slug: "OXIDATION_REDUCING_SUGARS", from: "Oxidation & Reducing Sugars", to: "Sugar Oxidation Products" },
  { slug: "REACTION_TYPES_CLASSIFICATION", from: "Reaction Types & Classification",
    to: "Redox Classification of Reaction Families" },
  { slug: "TYPES_ELEMENTS", from: "Types of Elements", to: "Metals, Nonmetals & Metalloids" },
];

// A pair that keeps collapsing is held apart by making each definition name the
// other. Checked as a rule, because a future author who empties one of these
// has removed the only thing in the database that marks the boundary.
const DISJOINT_PAIRS = [
  { a: "TYPES_REACTIONS", b: "REACTION_TYPES_CLASSIFICATION" },
  { a: "OXIDATION_REDUCING_SUGARS", b: "REDUCING_NON_REDUCING_SUGARS" },
];
const pairFaults = DISJOINT_PAIRS.filter(({ a, b }) => {
  const ca = concepts.find((c) => c.slug === a), cb = concepts.find((c) => c.slug === b);
  return !ca || !cb || !String(ca.description || "").trim() || !String(cb.description || "").trim();
});
ok("each easily-confused pair keeps a definition on both sides",
  pairFaults.length === 0, pairFaults.map((p) => p.a).join(", "));

// A narrow, single-sided version of the same idea. Personality Disorder
// Clusters was read as an evidence-free umbrella duplicating Cluster A, B and
// C, and that reading survived because its description was NULL. It owns five
// cards that none of those three hold. The definition is the only thing in the
// database that prevents the misreading, so losing it is worth failing over.
// Deliberately NOT generalised into "all CONTENT concepts need a description":
// 755 of them do not have one, and that backlog is a separate piece of work.
const pdc = concepts.find((c) => c.slug === "PERSONALITY_DISORDER_CLUSTERS");
ok("Personality Disorder Clusters keeps the definition that marks it off from the cluster concepts",
  !!pdc && pdc.status !== "DEPRECATED" && pdc.object_type === "CONTENT" &&
  String(pdc.description || "").includes("Cluster A, Cluster B and Cluster C"),
  pdc ? `${pdc.object_type}/${pdc.status}, description ${pdc.description ? "present" : "NULL"}` : "missing");
const renameFaults = RENAMES.filter((r) => {
  const c = concepts.find((x) => x.slug === r.slug);
  return !c || c.canonical_name !== r.to || concepts.some((x) => x.canonical_name === r.from);
});
ok("every renamed concept answers to its new name under its original slug",
  renameFaults.length === 0, renameFaults.map((r) => r.slug).join(", "));
ok("slugs unique", new Set(concepts.map((c) => c.slug)).size === concepts.length);
ok("canonical names unique", new Set(concepts.map((c) => c.canonical_name)).size === concepts.length);
ok("hierarchy left flat", concepts.every((c) => c.concept_level === "CONCEPT" && !c.parent_concept_id));

console.log("\nLEARNING-OBJECT TYPES");
// Three kinds of object share this table and must never be counted together.
// The failure guarded against is quiet: a content query forgets a filter and
// starts reporting "confounding" as a biology weakness. Nothing errors.
ok("content_concepts view agrees with the column",
  (await count("content_concepts")) === concepts.filter((c) => c.object_type === "CONTENT").length);
ok("reasoning and quantitative objects are counted separately",
  (await count("reasoning_objects")) === concepts.filter((c) => c.object_type === "REASONING").length &&
  (await count("quantitative_objects")) === concepts.filter((c) => c.object_type === "QUANTITATIVE").length);
ok("the three types partition the table exactly",
  concepts.filter((c) => ["CONTENT", "REASONING", "QUANTITATIVE"].includes(c.object_type)).length === concepts.length);

// Section, discipline and AAMC category describe DISCIPLINARY content. A
// cross-cutting object carrying them means someone invented a classification
// to make the schema look complete, and later analytics would read it as fact.
const nonContentIds = new Set(concepts.filter((c) => c.object_type !== "CONTENT").map((c) => c.id));
const taxonomyRows = [
  ...(await all("concept_sections", "concept_id")),
  ...(await all("concept_disciplines", "concept_id")),
  ...(await all("concept_content_categories", "concept_id")),
];
ok("no cross-cutting object carries content taxonomy",
  !taxonomyRows.some((r) => nonContentIds.has(r.concept_id)));

// SLUG CONVENTION. A cross-cutting object is prefixed by its axis: RO_ for a
// reasoning operation, QK_ for a quantitative tool. Nothing in the runtime
// resolves a concept by slug, so this buys no behaviour; it keeps the authoring
// vocabulary legible and it is how a human tells the three axes apart while
// reading a seed file. Written as a rule over all such objects rather than a
// count, so a new object added tomorrow has to conform too.
const crossCutting = concepts.filter(
  (c) => c.object_type !== "CONTENT" && c.status !== "DEPRECATED");
const badPrefix = crossCutting.filter(
  (c) => !c.slug.startsWith(c.object_type === "REASONING" ? "RO_" : "QK_"));
ok("every reasoning and quantitative slug carries its axis prefix",
  badPrefix.length === 0, badPrefix.map((c) => `${c.slug} (${c.object_type})`).join(", "));

// A cross-cutting object carries NO section, discipline or AAMC category by
// design, so its description is the only thing in the database that says what
// it means. An undescribed one is a name and nothing else, and a name is what
// the ontology exists to stop people reasoning from.
const undescribed = crossCutting.filter((c) => !String(c.description || "").trim());
ok("every reasoning and quantitative object has a definition",
  undescribed.length === 0, undescribed.map((c) => c.slug).join(", "));

// The four vector objects were seeded off-convention and fixed by
// 20260930_vector_slug_convention.sql. Named explicitly because the two rules
// above would also pass if these four had been deleted instead of renamed.
const vectorSlugs = [
  "QK_VECTORS_AND_SCALARS",
  "QK_VECTOR_ADDITION_AND_COMPONENTS",
  "QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION",
  "QK_DOT_AND_CROSS_PRODUCTS",
];
const vectors = concepts.filter((c) => vectorSlugs.includes(c.slug));
ok("the four vector objects are present, live and quantitative",
  vectors.length === 4 && vectors.every(
    (c) => c.object_type === "QUANTITATIVE" && c.status !== "DEPRECATED"),
  `${vectors.length} of 4`);

console.log("\nRELATIONSHIPS");
// THESE WERE TWO MAGIC NUMBERS. They asserted 609 and 583 without ever saying
// what would be wrong if the figure differed, so every phase that legitimately
// added concepts broke them, and the fix was always to bump the number. That
// buys one phase of silence and checks nothing. What they were really guarding
// is that taxonomy rows track the concepts they describe, so it is now derived
// and needs no maintenance as the ontology grows.
const contentConcepts = concepts.filter((c) => c.object_type === "CONTENT");
const discRows = await all("concept_disciplines", "concept_id,role");
const primaryDisc = discRows.filter((r) => r.role === "PRIMARY").map((r) => r.concept_id);
ok("no concept carries two PRIMARY disciplines",
  new Set(primaryDisc).size === primaryDisc.length);
// Three bioethics concepts are PSYCH_SOC with the discipline deliberately left
// UNRESOLVED. That is a decision on record, not an omission, and it is spelled
// out here so a fourth cannot join them unnoticed.
const hasDisc = new Set(primaryDisc);
const noDiscipline = contentConcepts.filter((c) => !hasDisc.has(c.id));
ok("every content concept has a PRIMARY discipline, bar the 3 deferred",
  noDiscipline.length === 3,
  noDiscipline.map((c) => c.canonical_name).join(", "));
// A PRE-EXISTING GAP, recorded so it cannot quietly widen. 34 content concepts
// carry no AAMC content category, nearly all of them the gas-laws cluster. They
// are still reachable by section and discipline, but a candidate search that
// narrows on category cannot see them. This is a CEILING: new work must not add
// to it, and closing it is its own task.
const catRows = await all("concept_content_categories", "concept_id");
const hasCat = new Set(catRows.map((r) => r.concept_id));
const noCategory = contentConcepts.filter((c) => !hasCat.has(c.id));
ok("content concepts lacking an AAMC category does not exceed 34",
  noCategory.length <= 34, `${noCategory.length} without a category`);
ok("concept_relationships empty (seeded by hand only)", (await count("concept_relationships")) === 0);

console.log("\nDETERMINISTIC QUESTION MAPPING");
const qc = await all("question_concepts", "question_id,concept_id,role,mapping_status,source,confidence");
const qById0 = new Map((await all("questions", "id,topic")).map((q) => [q.id, q]));
// A FLOOR, NOT AN EQUALITY. This was pinned at 2,673 and that was wrong for the
// same reason the learner-table counts were: question_concepts grows whenever a
// question is authored or mapped, so an exact count turns a correct change into
// a failure and trains you to ignore the verifier. The exact count belongs to
// the migration that creates the rows, where it is checked inside the
// transaction. Here the invariant is that mappings never silently disappear.
ok("question mappings never shrink below 2,673", qc.length >= 2673, String(qc.length));
// PROVENANCE NOW HAS THREE POPULATIONS. The original mappings were derived by
// exact subtopic match or approved lookup. The 96 immune mappings were chosen by
// analysis during the question-side reconciliation, so they are AI_PROPOSED, and
// labelling them DETERMINISTIC would claim a derivation that did not happen.
ok("provenance is deterministic or AI_PROPOSED, never human-validated",
  qc.every((m) => ["DETERMINISTIC_EXACT", "DETERMINISTIC", "AI_PROPOSED"].includes(m.source)));
// Also floors. The deterministic populations only shrink if something repoints
// them, which is worth catching; AI_PROPOSED is free to grow.
// The EXACT floor steps down with each recorded repoint: 2,054 -> 2,051 for the
// three carbohydrate questions in migration 3, then -> 2,050 for the Haber
// question in migration 4. Lowering a floor is how a deliberate, declared
// repoint is absorbed; the floor still catches an undeclared one, which is what
// it caught both times before the migration ran.
ok("deterministic mappings never shrink below 2,050 and 417",
  qc.filter((m) => m.source === "DETERMINISTIC_EXACT").length >= 2050 &&
  qc.filter((m) => m.source === "DETERMINISTIC").length >= 417,
  JSON.stringify(qc.reduce((a, m) => ((a[m.source] = (a[m.source] || 0) + 1), a), {})));
// Every AI_PROPOSED question mapping belongs to one of the two reconciled
// chapters. If this ever catches a third, an unreviewed pass has written
// somewhere it should not.
// A third recorded pass joins the two chapter reconciliations: migration 3
// repointed three questions out of Sugar Oxidation Products into Reducing &
// Non-Reducing Sugars. The set is widened by naming that pass, not by relaxing
// the rule, so a fourth chapter appearing still fails.
const RECONCILED = new Set([
  "The Immune System", "The Cardiovascular System", "Carbohydrate Structure and Function",
  "Compounds & Stoichiometry"]);
ok("every AI_PROPOSED question mapping belongs to a reconciled chapter",
  qc.filter((m) => m.source === "AI_PROPOSED")
    .every((m) => RECONCILED.has(qById0.get(m.question_id)?.topic)),
  [...new Set(qc.filter((m) => m.source === "AI_PROPOSED")
    .map((m) => qById0.get(m.question_id)?.topic).filter((t) => !RECONCILED.has(t)))].join(", "));
// ROLE-AWARE. This pair used to assume every mapping was PRIMARY and compared
// distinct question_ids against the row count. Six retained sub-objectives now
// hold SECONDARY rows, which made the old form fail on correct data. The
// invariant that matters is one PRIMARY per question, which is what the
// question_concepts_one_primary index enforces.
const qcPrimary = qc.filter((m) => m.role === "PRIMARY");
ok("secondary mappings never shrink below 12",
  qc.filter((m) => m.role === "SECONDARY").length >= 12,
  String(qc.filter((m) => m.role === "SECONDARY").length));
ok("no question carries two PRIMARY concepts",
  new Set(qcPrimary.map((m) => m.question_id)).size === qcPrimary.length);
ok("none marked human-validated", qc.every((m) => m.mapping_status !== "HUMAN_VALIDATED"));

const Q = await all("questions", "id,subtopic,section,content_category,topic");
const byId = new Map(concepts.map((c) => [c.id, c]));
const qById = new Map(Q.map((q) => [q.id, q]));
// Only the first 2,242 are name-equality; the 417 map through the approved
// descriptor lookup, where the descriptor is deliberately NOT the concept name.
//
// A RENAME LEGITIMATELY BREAKS NAME EQUALITY, which this check originally did
// not allow for: renaming Thermoregulation to Respiratory Thermoregulation left
// its 6 questions mapped by ID to a concept whose name no longer matched their
// subtopic. That is stable IDs working, not a fault. The old name is filed as
// an alias by the rename trigger, so the honest assertion is that the subtopic
// matches the concept's CURRENT NAME OR ONE OF ITS ALIASES.
const aliasRows = await all("concept_aliases", "concept_id,alias");
const aliasesOf = aliasRows.reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.alias), a), {});
// The other half of the rename rule, checked here because the alias rows are
// only read at this point: the old name must still be findable.
const aliasFaults = RENAMES.filter((r) => {
  const c = concepts.find((x) => x.slug === r.slug);
  return !c || !aliasRows.some(
    (a) => a.concept_id === c.id && a.alias === r.from);
});
ok("every renamed concept keeps its old name as an alias", aliasFaults.length === 0,
  aliasFaults.map((r) => r.from).join(", "));
// A SPLIT BREAKS NAME EQUALITY TOO, and unlike a rename it cannot be repaired
// by an alias: the parent keeps its own name, and UNIQUE (alias, alias_type)
// means the old name could be filed against at most one of the two children
// anyway. So the legitimate case is named. A question whose subtopic still
// reads "Lipid Mobilization & Transport" is expected to point at one of that
// split's children now, and the check below still fails if it points anywhere
// else, or if some other subtopic quietly stops matching.
const splitParentNames = new Set(SPLIT_PARENTS.map(
  (sl) => concepts.find((c) => c.slug === sl)?.canonical_name).filter(Boolean));
const splitChildIds = new Set(SPLIT_CHILDREN.map(
  (sl) => concepts.find((c) => c.slug === sl)?.id).filter(Boolean));
const exactCohort = qc.filter((m) => m.source === "DETERMINISTIC_EXACT");
const nameMismatch = exactCohort.filter((m) => {
  const sub = qById.get(m.question_id)?.subtopic;
  if (sub === byId.get(m.concept_id)?.canonical_name || aliasesOf[m.concept_id]?.has(sub)) return false;
  // Excused only if the subtopic names a split parent AND the mapping now
  // resolves to one of that split's children.
  return !(splitParentNames.has(sub) && splitChildIds.has(m.concept_id));
});
ok("the exact-equality cohort matches a current or historical name, or moved to a split child",
  nameMismatch.length === 0,
  nameMismatch.slice(0, 3).map((m) => qById.get(m.question_id)?.subtopic).join(", "));
ok("every question excused by the split rule landed on a split child",
  exactCohort.filter((m) => splitParentNames.has(qById.get(m.question_id)?.subtopic))
    .every((m) => splitChildIds.has(m.concept_id)),
  String(exactCohort.filter((m) => splitParentNames.has(qById.get(m.question_id)?.subtopic)).length) + " excused");

const SEC = { chem_phys: "CHEM_PHYS", bio_biochem: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", cars: "CARS" };
// MEMBERSHIP, not equality. This check originally compared a single
// concepts.section_code and failed on 4 mappings, which looked like a mapping
// bug and was really a schema one: "Isoelectric Focusing" is examined in two
// MCAT sections, so no single value could have been right.
const sects = (await all("concept_sections", "concept_id,section_code"))
  .reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.section_code), a), {});
ok("section compatible on every mapping",
  qc.every((m) => sects[m.concept_id]?.has(SEC[qById.get(m.question_id)?.section])));
// A floor plus the rule that matters: every CONTENT concept carrying a question
// or a card must be reachable by section. Freezing the population would fail the
// next time vocabulary is seeded.
ok("content concepts in a section never shrink below 1,097",
  new Set(Object.keys(sects)).size >= 1097, String(new Set(Object.keys(sects)).size));
// EVERY SECTION A CONCEPT CLAIMS MUST BE EARNED. This replaces a hardcoded
// count of cross-section concepts, which went stale the moment two concepts
// were legitimately widened. The count was never the point: the failure mode is
// taxonomy widened without evidence, a concept asserting it belongs to a
// section where nothing of its actually is. So the rule is now that each
// claimed section must be backed by at least one mapped question or card from
// that section, and it needs no maintenance as the ontology grows.
const deckSection = { chemistry: "CHEM_PHYS", organic_chemistry: "CHEM_PHYS", physics: "CHEM_PHYS",
  biology: "BIO_BIOCHEM", biochemistry: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", scientific_reasoning: null };
const decks = new Map((await all("flashcard_decks", "id,section")).map((d) => [d.id, d.section]));
const cardDeck = new Map((await all("flashcards", "id,deck_id")).map((f) => [f.id, f.deck_id]));
const evidence = {};
for (const m of qc) (evidence[m.concept_id] ??= new Set()).add(SEC[qById.get(m.question_id)?.section]);
for (const m of await all("flashcard_concepts", "flashcard_id,concept_id")) {
  const sec = deckSection[decks.get(cardDeck.get(m.flashcard_id))];
  if (sec) (evidence[m.concept_id] ??= new Set()).add(sec);
}
// CONTRADICTED, not merely uncorroborated. The first version of this check
// demanded positive evidence for every claimed section and immediately flagged
// the three bioethics concepts, which claim PSYCH_SOC while their cards sit in
// the Scientific Reasoning deck, and that deck resolves to no section at all.
// Those claims are right: a deck's section does not determine its cards', which
// is the whole card-level principle. So the rule is that a concept with
// section-bearing evidence must agree with at least some of it. A concept whose
// only evidence comes from a section-less deck is unconfirmable, not wrong.
const contradicted = Object.entries(sects).filter(([id, claimed]) => {
  const ev = evidence[id];
  if (!ev || ev.size === 0) return false;
  return ![...claimed].some((sec) => ev.has(sec));
});
ok("no concept claims a section its evidence contradicts",
  contradicted.length === 0,
  contradicted.length
    ? contradicted.map(([id, cl]) => `${byId.get(id)?.canonical_name}: claims ${[...cl]} but evidence is ${[...(evidence[id] ?? [])]}`).join(" | ")
    : "");
ok("cross-section concepts exist and are not flattened",
  Object.values(sects).filter((s) => s.size > 1).length >= 1);

const disciplinesOf = (await all("concept_disciplines", "concept_id,discipline_code"))
  .reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.discipline_code), a), {});
const catRows2 = await all("concept_content_categories", "concept_id,content_category");
const catNames = new Set(catRows2.map((r) => r.content_category));
const cc = catRows2;
const catsOf = cc.reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.content_category), a), {});
// BACK TO AN EQUALITY. This was briefly a ceiling of 1: repointing an immune
// question onto Immunoglobulins left a mapping reachable by section and
// discipline but not by category, because that concept carried only protein
// structure. The SECONDARY widening closed it, so the invariant is zero again
// and a future repoint that forgets to widen fails here.
const catIncompatible = qc.filter((m) => !catsOf[m.concept_id]?.has(qById.get(m.question_id)?.content_category));
ok("category compatible on every question mapping",
  catIncompatible.length === 0,
  catIncompatible.map((m) => byId.get(m.concept_id)?.canonical_name).join(", "));
// The widening is additive: protein structure is still what Immunoglobulins IS.
const igCats = catsOf[concepts.find((c) => c.slug === "IMMUNOGLOBULINS")?.id];
ok("Immunoglobulins carries both its categories",
  igCats?.has("Structure and Function of Proteins and Their Constituent Amino Acids") && igCats?.has("Organ Systems"));

console.log("\nFLASHCARD MAPPINGS");
const fc = await all("flashcard_concepts", "flashcard_id,concept_id,mapping_status,source");
const typeOf = Object.fromEntries(concepts.map((c) => [c.id, c.object_type]));
const byType = fc.reduce((a, m) => ((a[typeOf[m.concept_id]] = (a[typeOf[m.concept_id]] || 0) + 1), a), {});
// A floor. Authoring new cards and mapping them is normal growth; the structural
// checks below are what keep those mappings honest.
ok("card mappings never shrink below 4,115", fc.length >= 4115, String(fc.length));
ok("card mappings by type never shrink below 3987 / 36 / 92",
  byType.CONTENT >= 3987 && byType.REASONING >= 36 && byType.QUANTITATIVE >= 92, JSON.stringify(byType));
// Provenance must not overstate. The vocabulary was approved; 314 individual
// rows were not reviewed, and the status must not claim they were.
ok("no card mapping claims HUMAN_VALIDATED", fc.every((m) => m.mapping_status !== "HUMAN_VALIDATED"));
ok("no card mapping claims deterministic provenance",
  fc.every((m) => m.source !== "DETERMINISTIC" && m.source !== "DETERMINISTIC_EXACT"));

// ─── MIGRATION 7 IS OUTSTANDING WHILE THIS FAILS ───────────────────────────
// Migration 6 renamed TYPES_ELEMENTS to Metals, Nonmetals & Metalloids, which
// is what its 12 questions test. Its 19 chemical-family flashcards did not move
// and now hang off a concept that does not describe them. That is a deliberate
// intermediate state, and the instruction was not to treat it as final, so it
// is wired to a check rather than to anyone's memory.
//
// Identified by DECK POSITION, not by keyword. The Periodic Trends & Chemical
// Families deck runs structure and trends up to card 26 and chemical families
// from 27 on, so the boundary is exact. A keyword scan was tried first and
// missed two of the nineteen, which would have let this pass with family cards
// still sitting here.
const mnm = concepts.find((c) => c.slug === "TYPES_ELEMENTS");
let pendingFamily = 0;
if (mnm) {
  const decks = await all("flashcard_decks", "id,title");
  const familyDeck = decks.find((d) => d.title === "Periodic Trends & Chemical Families");
  const cards = await all("flashcards", "id,deck_id,position");
  const here = new Set(fc.filter((m) => m.concept_id === mnm.id).map((m) => m.flashcard_id));
  pendingFamily = cards.filter(
    (f) => here.has(f.id) && familyDeck && f.deck_id === familyDeck.id && f.position >= 27).length;
}
ok("no chemical-family card is left on Metals, Nonmetals & Metalloids (migration 7 outstanding until this passes)",
  pendingFamily === 0, `${pendingFamily} family card(s) still pending`);

ok("all card mappings are AI_PROPOSED", fc.every((m) => m.source === "AI_PROPOSED"));
// The boundary that matters: reasoning and quantitative objects MAY be mapped
// from a flashcard, and must still be invisible to content analytics.
const contentIds = new Set(concepts.filter((c) => c.object_type === "CONTENT").map((c) => c.id));
ok("reasoning and quantitative mappings exist but are outside content",
  fc.some((m) => !contentIds.has(m.concept_id)) &&
  fc.filter((m) => contentIds.has(m.concept_id)).length >= 3987);
ok("every question mapping still points at CONTENT",
  qc.every((m) => contentIds.has(m.concept_id)));

// ── The organic chemistry pass, checked rather than trusted ──────────────
// 425 cards, one PRIMARY each, and no deck-level shortcut: a deck that resolved
// to a single object would mean the cards were never read individually.
const ochemCards = [...cardDeck.entries()]
  .filter(([, d]) => decks.get(d) === "organic_chemistry").map(([id]) => id);
const ochemMaps = fc.filter((m) => ochemCards.includes(m.flashcard_id));
ok("425 organic chemistry cards", ochemCards.length === 425, String(ochemCards.length));
ok("every organic chemistry card carries exactly one mapping",
  ochemMaps.length === 425 && new Set(ochemMaps.map((m) => m.flashcard_id)).size === 425,
  String(ochemMaps.length));
// THE INVARIANT THE WIDENING EXISTS FOR. A card sits in a Chem/Phys deck, so
// the concept it resolves to must admit it is examined in Chem/Phys. Twelve
// biochemistry concepts are reused by these cards, and each was widened for
// exactly this reason. Without the check the widening is a claim; with it, a
// future reuse that forgets to widen fails here instead of silently making a
// concept unreachable from the section its cards actually live in.
const wrongSection = ochemMaps.filter((m) =>
  contentIds.has(m.concept_id) && !sects[m.concept_id]?.has("CHEM_PHYS"));
ok("every organic chemistry content mapping is reachable from Chem/Phys",
  wrongSection.length === 0,
  wrongSection.map((m) => byId.get(m.concept_id)?.canonical_name).join(", "));
// The reasoning object stays off the content tree, as its type requires.
ok("the organic chemistry reasoning object carries no taxonomy",
  !sects[[...concepts].find((c) => c.slug === "RO_REACTION_MECHANISM_ANALYSIS")?.id]);

// ── The physics pass ────────────────────────────────────────────────────
const physCards = [...cardDeck.entries()]
  .filter(([, d]) => decks.get(d) === "physics").map(([id]) => id);
const physSet = new Set(physCards);
const physMaps = fc.filter((m) => physSet.has(m.flashcard_id));
ok("444 physics cards", physCards.length === 444, String(physCards.length));
ok("every physics card carries exactly one mapping",
  physMaps.length === 444 && new Set(physMaps.map((m) => m.flashcard_id)).size === 444,
  String(physMaps.length));
const physWrongSection = physMaps.filter((m) =>
  contentIds.has(m.concept_id) && !sects[m.concept_id]?.has("CHEM_PHYS"));
ok("every physics content mapping is reachable from Chem/Phys",
  physWrongSection.length === 0,
  physWrongSection.map((m) => byId.get(m.concept_id)?.canonical_name).join(", "));
// THE SEPARATION THAT EARNS ITS KEEP. Vector mathematics is a tool, not
// physics. 14 cards open the Motion & Forces deck before any physics appears.
// If these ever acquire a physics discipline, the tool has been misfiled as
// content and one root cause will read as four separate weaknesses.
const quantIds = new Set(concepts.filter((c) => c.object_type === "QUANTITATIVE").map((c) => c.id));
const physQuant = physMaps.filter((m) => quantIds.has(m.concept_id));
ok("14 physics cards resolve to quantitative tools, not content",
  physQuant.length === 14, String(physQuant.length));
ok("no quantitative object carries a section or discipline",
  ![...quantIds].some((id) => sects[id] || disciplinesOf[id]));
// AAMC 4-series. 4E already existed and must NOT have been duplicated.
const FOUR_SERIES = [
  "Translational motion, forces, work, energy, and equilibrium in living systems",
  "Importance of fluids for the circulation of blood, gas movement, and gas exchange",
  "Electrochemistry and electrical circuits and their elements",
  "How light and sound interact with matter",
  "Atoms, nuclear decay, electronic structure, and atomic chemical behavior",
];

ok("all five AAMC physics categories are present", FOUR_SERIES.every((c) => catNames.has(c)),
  FOUR_SERIES.filter((c) => !catNames.has(c)).join(" | "));
// PRIMARY, not "has physics anywhere". The first version of this asked whether
// any concept carrying the physics discipline had a category, and flagged four
// General Chemistry thermodynamics concepts that had just gained physics as a
// SECONDARY discipline. Those four are part of the 34-concept uncategorized
// backlog and were deliberately not backfilled, because nothing in their
// metadata determines a category. Widening a concept's discipline does not make
// this phase responsible for a gap it did not create, so the rule is about the
// concepts physics actually seeded.
const physPrimary = new Set(
  (await all("concept_disciplines", "concept_id,discipline_code,role"))
    .filter((r) => r.discipline_code === "PHYSICS" && r.role === "PRIMARY")
    .map((r) => r.concept_id),
);
const physNoCat = concepts.filter((c) => physPrimary.has(c.id) && !catsOf[c.id]);
ok("all 137 seeded physics concepts carry an AAMC category",
  physPrimary.size === 137 && physNoCat.length === 0,
  `${physPrimary.size} seeded, ${physNoCat.length} without: ${physNoCat.map((c) => c.canonical_name).join(", ")}`);

// ── The psych/soc pass ──────────────────────────────────────────────────
const psCards = [...cardDeck.entries()]
  .filter(([, d]) => decks.get(d) === "psych_soc").map(([id]) => id);
const psSet = new Set(psCards);
const psMaps = fc.filter((m) => psSet.has(m.flashcard_id));
ok("778 psych/soc cards", psCards.length === 778, String(psCards.length));
ok("every psych/soc card carries exactly one mapping",
  psMaps.length === 778 && new Set(psMaps.map((m) => m.flashcard_id)).size === 778,
  String(psMaps.length));
// SECTION IS NOT DISCIPLINE. The first psych/soc design forced all 268 proposed
// concepts into psychology or sociology because their cards sit in the psych/soc
// curriculum. 62 of them are biological psychology or evolutionary behaviour, and
// three carry BIOLOGY alone. This check asserts the corrected model survives: the
// concepts these cards resolve to are all examined in PSYCH_SOC, and at least one
// of them carries no psychology or sociology discipline at all.
// SEEDED BY THIS PHASE, not "sits in PSYCH_SOC". This check has now been wrong
// twice for the same reason, so it states its discriminator explicitly. Asking
// which concepts carry the section catches three populations: the 239 seeded
// here, the three bioethics concepts (section but no discipline, and in the
// uncategorized backlog), and the eight reused Biology objects widened into the
// section. A concept seeded here is the only one with BOTH a primary PSYCH_SOC
// section row and a PRIMARY discipline; a widened one carries the section as
// SECONDARY, which is exactly what widening means.
const psPrimarySection = new Set(
  (await all("concept_sections", "concept_id,section_code,is_primary"))
    .filter((r) => r.section_code === "PSYCH_SOC" && r.is_primary).map((r) => r.concept_id),
);
const hasPrimaryDiscipline = new Set(
  (await all("concept_disciplines", "concept_id,role"))
    .filter((r) => r.role === "PRIMARY").map((r) => r.concept_id),
);
const psSeeded = concepts.filter((c) =>
  psPrimarySection.has(c.id) && c.object_type === "CONTENT" && hasPrimaryDiscipline.has(c.id));
const psWrongSection = psMaps.filter((m) =>
  contentIds.has(m.concept_id) && !sects[m.concept_id]?.has("PSYCH_SOC"));
ok("every psych/soc mapping is reachable from the Psych/Soc section",
  psWrongSection.length === 0,
  psWrongSection.map((m) => byId.get(m.concept_id)?.canonical_name).join(", "));
const isBioOnly = (id) => {
  const d = disciplinesOf[id];
  return !!d?.has("BIOLOGY") && !d.has("PSYCHOLOGY") && !d.has("SOCIOLOGY");
};
const bioOnly = psSeeded.filter((c) => isBioOnly(c.id));
ok("3 biology-only concepts were seeded into the psych/soc section",
  bioOnly.length === 3, `${bioOnly.length}: ${bioOnly.map((c) => c.canonical_name).join(", ")}`);
// The widened pair earns its own line. Natural Selection & Fitness and
// Neurulation & Neural Crest gained the PSYCH_SOC section but deliberately NOT
// a psychology discipline, so the section holds five biology-only concepts in
// total. If either ever acquires psychology, that decision has been undone.
const bioOnlyInSection = concepts.filter((c) => sects[c.id]?.has("PSYCH_SOC") && isBioOnly(c.id));
ok("5 biology-only concepts sit in the section once widening is counted",
  bioOnlyInSection.length === 5, String(bioOnlyInSection.length));
// The deferral that must NOT have been resolved to tidy the hierarchy.
const ethics = concepts.find((c) => c.canonical_name === "Principles of Biomedical Ethics");
ok("biomedical ethics discipline is still UNRESOLVED",
  ethics && !disciplinesOf[ethics.id], JSON.stringify([...(disciplinesOf[ethics?.id] ?? [])]));
const PS_CATS = ["Sensing the environment", "Making sense of the environment", "Responding to the world",
  "Individual influences on behavior", "Social processes that influence human behavior",
  "Attitude and behavior change", "Self-identity", "Social thinking", "Social interactions",
  "Understanding social structure", "Demographic characteristics and processes", "Social inequality"];
ok("all twelve AAMC psych/soc categories are present",
  PS_CATS.every((c) => catNames.has(c)), PS_CATS.filter((c) => !catNames.has(c)).join(" | "));
const psNoCat = psSeeded.filter((c) => !catsOf[c.id]);
ok("all 239 seeded psych/soc concepts carry an AAMC category",
  psSeeded.length === 239 && psNoCat.length === 0,
  `${psSeeded.length} seeded, ${psNoCat.length} without`);

// The 42 objects the final backfill seeds. Listed rather than derived so a
// concept quietly vanishing from the migration fails this check.
const BACKFILL_SLUGS = [
  "ABO_RH_BLOOD_TYPES", "ACTIVE_PASSIVE_IMMUNITY", "AMINO_ACID_RECOGNITION_ABBREVIATIONS",
  "ANTIGENS_EPITOPES", "AUTOIMMUNE_DISEASE", "B_CELL_ACTIVATION_ANTIBODY_DIVERSITY",
  "BAROREFLEX_AUTONOMIC_CARDIOVASCULAR_CONTROL", "BLOOD_COMPOSITION_PLASMA_FORMED_ELEMENTS", "BLOOD_PRESSURE_MEASUREMENT",
  "BLOOD_VESSEL_STRUCTURE_TYPES", "CAPILLARY_STRUCTURE_EXCHANGE", "CARDIAC_CONDUCTION_PACEMAKER_HIERARCHY",
  "CARDIAC_OUTPUT_STROKE_VOLUME", "CLONAL_SELECTION_IMMUNOLOGIC_MEMORY", "CYTOKINES_INTERFERONS",
  "ERYTHROCYTES_STRUCTURE_LIFECYCLE_TURNOVER", "HEART_CHAMBERS_VALVES", "HEMODYNAMICS_RESISTANCE_FLOW_VELOCITY",
  "HEMOSTASIS_COAGULATION_FIBRINOLYSIS", "HYPERSENSITIVITY_ALLERGY", "INNATE_ADAPTIVE_IMMUNITY",
  "LEUKOCYTE_LINEAGES_LYMPHOID_ORGANS", "LEUKOCYTES_PLATELETS_BLOOD", "MHC_ANTIGEN_PRESENTATION",
  "NATURAL_KILLER_CELLS", "PATTERN_RECOGNITION_ACUTE_INFLAMMATION", "PHAGOCYTES_GRANULOCYTES",
  "POLYPROTIC_ACIDS_STEPWISE_DISSOCIATION", "PORTAL_CIRCULATIONS", "PROTEIN_STRUCTURE_DETERMINATION",
  "PULMONARY_SYSTEMIC_CIRCUITS", "RENIN_ANGIOTENSIN_ALDOSTERONE_SYSTEM", "STARLING_FORCES_CAPILLARY_FLUID_BALANCE",
  "SURFACE_BARRIERS_INFECTION", "T_CELL_SUBSETS_EFFECTOR_FUNCTION", "CARDIAC_CYCLE_HEART_SOUNDS",
  "COMPLEMENT_SYSTEM", "LYMPHATIC_SYSTEM", "THYMIC_SELECTION_SELF_TOLERANCE",
  "URINARY_TRACT_MICTURITION", "VACCINATION", "VENOUS_RETURN_PRELOAD"
];

console.log("\nTHE FINAL FLASHCARD BACKFILL");
// 2,154 cards across all 33 remaining decks, and 42 new CONTENT objects. The
// checks below are the ones that would have caught the mistakes this pass
// actually made, not a restatement of its totals.
const backfillSlugs = BACKFILL_SLUGS;
const backfilled = concepts.filter((c) => backfillSlugs.includes(c.slug));
ok("42 backfill concepts seeded", backfilled.length === 42, String(backfilled.length));
ok("every backfill concept is CONTENT", backfilled.every((c) => c.object_type === "CONTENT"));
ok("every backfill concept carries a section, a discipline and a category",
  backfilled.every((c) => sects[c.id] && disciplinesOf[c.id] && catsOf[c.id]),
  backfilled.filter((c) => !(sects[c.id] && disciplinesOf[c.id] && catsOf[c.id])).map((c) => c.slug).join(", "));

// ONE PRIMARY PER CARD. The whole learner model assumes a card resolves to one
// concept. Two PRIMARY rows would double-count every review of that card.
const primaryPerCard = fc.filter((m) => m.role === "PRIMARY")
  .reduce((a, m) => ((a[m.flashcard_id] = (a[m.flashcard_id] || 0) + 1), a), {});
const doubled = Object.entries(primaryPerCard).filter(([, n]) => n > 1);
ok("no card carries two PRIMARY concepts", doubled.length === 0, String(doubled.length));

// THE TWO DELIBERATE GAPS. Both are authoring repairs, not ontology gaps: one
// card defines a class then names examples from four different concepts, the
// other compares all three cytoskeletal filament classes at once. If this count
// ever moves, either a card was force-mapped or a new card went unmapped.
const mappedCards = new Set(fc.map((m) => m.flashcard_id));
const unmappedCards = [...cardDeck.keys()].filter((id) => !mappedCards.has(id));
ok("exactly 2 flashcards remain unmapped (CARD_TOO_BROAD)",
  unmappedCards.length === 2, String(unmappedCards.length));

// THE INVARIANT THIS PASS EXISTS FOR.
//
// The Immune System and The Cardiovascular System each carried one concept per
// question: 89 and 99 objects, every one with an empty description and a name
// copied verbatim from its question's subtopic. They are a question index, not a
// vocabulary, and a card mapped onto one inherits an identity that dies with the
// question. 95 cards were provisionally mapped that way before this pass and all
// 95 were moved. A future mapping that reaches for one of these labels because
// the words match fails here.
const chapterOf = new Map(Q.map((q) => [q.id, q.topic]));
const LABEL_CHAPTERS = new Set(["The Immune System", "The Cardiovascular System"]);
// THE HEURISTIC HAS TO NARROW AS THE WORK PROCEEDS. Counting "exactly one
// question, in one of the two chapters" identified all 188 labels while both
// chapters were untouched. After the immune reconciliation it also catches
// durable concepts that legitimately hold one question, such as Natural Killer
// Cells, and the six retained sub-objectives. The defect signature is what
// actually distinguishes a label: no description, a name copied verbatim from a
// question subtopic, and a PRIMARY mapping from exactly one question.
const subtopics = new Set(Q.map((x) => String(x.subtopic)));
const primaryOf = qc.filter((m) => m.role === "PRIMARY")
  .reduce((a, m) => ((a[m.concept_id] ??= []).push(m.question_id), a), {});
const questionInstanceLabels = new Set(Object.entries(primaryOf)
  .filter(([cid, qs]) => qs.length === 1 && LABEL_CHAPTERS.has(chapterOf.get(qs[0]))
    && !String(byId.get(cid)?.description || "").trim()
    && subtopics.has(byId.get(cid)?.canonical_name))
  .map(([cid]) => cid));
const onLabels = fc.filter((m) => questionInstanceLabels.has(m.concept_id));
// BANK-WIDE NOW, AND STRONGER FOR IT. While the two chapters were being
// reconciled this counted only within them, which would freeze the moment both
// were done. Dropping the chapter filter asks the real question: does the defect
// signature exist ANYWHERE. Three concepts match, in three different chapters,
// and they are the same three the backfill's residual audit examined one by one
// and judged durable. A ceiling, so a new label appearing anywhere fails here.
const bankWideLabels = new Set(Object.entries(primaryOf)
  .filter(([cid, qs]) => qs.length === 1
    && byId.get(cid)?.status === "ACTIVE_SEED"
    && !String(byId.get(cid)?.description || "").trim()
    && subtopics.has(byId.get(cid)?.canonical_name))
  .map(([cid]) => cid));
ok("question-instance signature does not exceed 3 bank-wide",
  bankWideLabels.size <= 3, String(bankWideLabels.size));
ok("no label survives in either reconciled chapter",
  [...bankWideLabels].every((cid) => !LABEL_CHAPTERS.has(chapterOf.get(primaryOf[cid][0]))),
  [...bankWideLabels].map((cid) => byId.get(cid)?.canonical_name).join(", "));
ok("every deprecated object has lost all its evidence",
  deprecated.every((c) => !qc.some((m) => m.concept_id === c.id) && !fc.some((m) => m.concept_id === c.id)));
ok("no card maps onto a surviving question-instance label",
  onLabels.length === 0,
  onLabels.map((m) => byId.get(m.concept_id)?.canonical_name).slice(0, 8).join(", "));

// SECTION REACHABILITY ACROSS THE WHOLE CARD SIDE. The ochem and physics passes
// each check this for their own deck; the backfill reused 376 existing concepts
// across five sections, so it needs the check globally. A card in a biology deck
// whose concept does not admit BIO_BIOCHEM is unreachable from where it lives,
// which is exactly what the 38 widening rows prevent.
const DECK_SEC = { biology: "BIO_BIOCHEM", biochemistry: "BIO_BIOCHEM", chemistry: "CHEM_PHYS",
  organic_chemistry: "CHEM_PHYS", physics: "CHEM_PHYS", psych_soc: "PSYCH_SOC" };
const unreachable = fc.filter((m) => {
  if (!contentIds.has(m.concept_id)) return false;
  const want = DECK_SEC[decks.get(cardDeck.get(m.flashcard_id))];
  return want && !sects[m.concept_id]?.has(want);
});
ok("every content card mapping is reachable from its deck's section",
  unreachable.length === 0,
  unreachable.map((m) => byId.get(m.concept_id)?.canonical_name).slice(0, 8).join(", "));

// Widening is additive only. A widening row that overwrote a primary would move
// a concept's home section, which is a silent reclassification.
const multiPrimarySect = (await all("concept_sections", "concept_id,is_primary"))
  .filter((r) => r.is_primary)
  .reduce((a, r) => ((a[r.concept_id] = (a[r.concept_id] || 0) + 1), a), {});
ok("no concept has two primary sections",
  Object.values(multiPrimarySect).every((n) => n === 1));

console.log("\nTHE REASONING RELATION");
// Structural invariants only. The row count is deliberately NOT asserted here:
// this relation is meant to grow, and the exact count of any one pass belongs to
// that pass's own migration.
const reasoningObjects = concepts.filter((c) => c.object_type === "REASONING");
let qro = null;
try {
  qro = await all("question_reasoning_objects", "question_id,concept_id,mapping_status,source");
} catch {
  qro = null;
}
if (qro === null) {
  console.log("  --    question_reasoning_objects does not exist yet (migration 1 not applied)");
} else {
  ok("every reasoning mapping points at a REASONING object",
    qro.every((m) => byId.get(m.concept_id)?.object_type === "REASONING"),
    [...new Set(qro.filter((m) => byId.get(m.concept_id)?.object_type !== "REASONING")
      .map((m) => byId.get(m.concept_id)?.object_type))].join(", "));
  ok("no reasoning mapping points at a deprecated object",
    qro.every((m) => byId.get(m.concept_id)?.status !== "DEPRECATED"));
  ok("no duplicate question and object pair",
    new Set(qro.map((m) => `${m.question_id}|${m.concept_id}`)).size === qro.length);
  ok("every reasoning mapping is AI_PROPOSED or better, never overstated",
    qro.every((m) => ["AI_PROPOSED", "DETERMINISTIC", "HUMAN_VALIDATED", "NEEDS_REVIEW"].includes(m.mapping_status)));
  // A reasoning object carrying question evidence must say what it means. This
  // is the check that would have caught Reaction Mechanism Analysis, which had
  // no description at all, before anything was mapped to it.
  const carrying = new Set(qro.map((m) => m.concept_id));
  const undefinedCarriers = reasoningObjects.filter(
    (c) => carrying.has(c.id) && !String(c.description || "").trim());
  ok("every reasoning object with question evidence has a definition",
    undefinedCarriers.length === 0, undefinedCarriers.map((c) => c.slug).join(", "));
}
// True whether or not the relation exists yet: a cross-cutting object never
// carries content taxonomy, and question_concepts stays CONTENT-only.
ok("no REASONING object carries a section, a discipline or a category",
  !reasoningObjects.some((c) => sects[c.id] || disciplinesOf[c.id] || catsOf[c.id]),
  reasoningObjects.filter((c) => sects[c.id] || disciplinesOf[c.id] || catsOf[c.id]).map((c) => c.slug).join(", "));
ok("question_concepts still holds only CONTENT",
  qc.every((m) => byId.get(m.concept_id)?.object_type === "CONTENT"));

console.log("\nDELIBERATELY LEFT ALONE");
const mapped = new Set(qc.map((m) => m.question_id));
const unmapped = Q.filter((q) => !mapped.has(q.id));
// A CEILING AND A NAMED SET, NEVER A FLOOR.
//
// Every other count here became a floor because growth is legitimate. This one
// is the opposite: an unmapped question is a gap, and ">= 20" would let the
// backlog grow silently while the verifier stayed green. Worse, a bare ceiling
// would still allow one backlog question to be fixed while a newly authored one
// quietly takes its place.
//
// So the accepted backlog is named. All 20 are the same subtopic, Chemistry of
// the Groups, which is one coherent gap rather than scatter. Any unmapped
// question outside this set is new and fails.
const KNOWN_UNMAPPED = new Set([
  "281971ff-47d5-48f2-ade7-bb49b09ecf78",
  "73b5fcb7-a512-42ca-8ec3-b430c9264f47",
  "ab4d6752-bed6-4716-a5e4-99eec8fcc551",
  "5ef31e94-271a-4344-b482-e4d9bacc7bb5",
  "055c6d03-4f75-493d-81ab-94ddabff502f",
  "41f87b91-e2a7-4348-8495-48cd042eece3",
  "487d627f-035c-4192-b71a-b7d7f4fd845d",
  "0ecd7bac-0143-47c1-98a8-66483b9da663",
  "d20971ce-413f-44b2-ba81-d55af592d136",
  "6486571a-1237-471c-bb9b-8c373f61c395",
  "75a2da19-403a-461a-ba4c-d9721d233eec",
  "b7858478-c39f-4aeb-bb6b-32894e259ab7",
  "be5f387b-e6b2-4ec3-8197-821198b54cda",
  "c6f7963e-fa2b-4c69-b852-aef86e5f6c4e",
  "2500b00c-f29c-43f6-9c8a-8009805b7c5d",
  "883f79c9-3fad-4d44-a63e-d104d6a890aa",
  "eee33c57-0002-4666-81a6-f7a1fb97a1b9",
  "f4f7b834-bb1f-401a-b380-2f173274871c",
  "2f153e0e-453a-4ff7-b1ec-b304739cde77",
  "9e2a17c9-cac8-4c02-a0c8-379b30ac5965",
]);
const strayUnmapped = unmapped.filter((q) => !KNOWN_UNMAPPED.has(q.id));
ok("unmapped questions never exceed the accepted backlog of 20",
  unmapped.length <= 20, String(unmapped.length));
ok("every unmapped question is in the named backlog, none newly authored",
  strayUnmapped.length === 0,
  strayUnmapped.map((q) => `${q.topic}: ${q.subtopic}`).join(" | "));
ok("no unmapped question's label is a concept name",
  unmapped.every((q) => !concepts.some((c) => c.canonical_name === q.subtopic)));


console.log("\nCONTENT AND LEARNER DATA UNCHANGED");
ok("questions 2,681", (await count("questions")) === 2681);
ok("flashcards 4,117", (await count("flashcards")) === 4117);
ok("decks 73", (await count("flashcard_decks")) === 73);
ok("distractor metadata 8,043", (await count("question_distractor_metadata")) === 8043);
// LEARNER TABLES GROW. A FLOOR, NOT AN EQUALITY.
//
// These were pinned to exact counts, which was wrong and would have made this
// verifier useless: the owner studies his own app, so flashcard_reviews climbs
// whenever he does. It went 47,777 -> 47,853 during this phase, and the cause
// was a study session that day (77 reviews, ratings mixed medium/again/hard,
// real interval transitions including a lapse), not a migration. An assertion
// that fails on ordinary use trains you to ignore it.
//
// The mutation we actually guard against is LOSS: ontology work must never
// delete or reset review history. Growth is the app working. So each of these
// is a floor recorded at the point the taxonomy work began, and only a DROP
// below it means something went wrong.
const UID = "ee01e0e1-ac92-4ea7-92c9-2738b82b6dca";
for (const [t, floor] of Object.entries({ flashcard_reviews: 47777, flashcard_user_state: 7147, question_attempts: 201 })) {
  const n = await count(t, (q) => q.eq("user_id", UID));
  ok(`${t} >= ${floor.toLocaleString()} (never shrinks)`, n >= floor,
    n === floor ? "" : `${n.toLocaleString()}, +${(n - floor).toLocaleString()} from study`);
}

console.log("\nCONCENTRATION CHECK (a catch-all forming?)");
const per = qc.reduce((a, m) => ((a[m.concept_id] = (a[m.concept_id] || 0) + 1), a), {});
const top = Object.entries(per).sort((a, b) => b[1] - a[1]).slice(0, 5);
top.forEach(([id, n]) => console.log("        " + String(n).padStart(3) + "  " + byId.get(id)?.canonical_name));
ok("largest concept under 120 questions", top[0][1] < 120, top[0][1] + " max");
ok("no concept became a catch-all", top[0][1] <= 30, top[0][1] + " max");

console.log("\nDATABASE GUARDS  (fixture: created, driven, removed)");
let fixture = null;
let liveFixture = null;
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

  // ─── The deprecated-target guard, both halves ───────────────────────────
  // The INSERT half above was the whole check until 20261003. The lipid split
  // fixture showed the trigger was attached BEFORE INSERT only, so an UPDATE
  // could repoint an existing mapping onto a deprecated concept unchallenged.
  // The invariant is that no evidence mapping can be CREATED on OR REPOINTED
  // ONTO a deprecated concept, and both halves are driven here rather than
  // asserted from a count, because a count cannot tell a guard that works from
  // one that was dropped.
  const { data: live, error: eLive } = await db.from("concepts")
    .insert({ slug: "__FIXTURE_LIVE_TARGET__", canonical_name: "Fixture Live Target",
              status: "ACTIVE_SEED", object_type: "CONTENT" })
    .select("id").single();
  if (eLive) throw new Error("live fixture concept: " + eLive.message);
  liveFixture = live.id;

  const { error: eIns } = await db.from("question_concepts").insert({
    question_id: someQ, concept_id: liveFixture, role: "SECONDARY",
    mapping_status: "AI_PROPOSED", source: "AI_PROPOSED" });
  ok("a mapping onto a live concept is accepted", !eIns, eIns?.message ?? "");

  const { error: eMeta } = await db.from("question_concepts")
    .update({ confidence: 0.55 }).eq("question_id", someQ).eq("concept_id", liveFixture);
  ok("an UPDATE that does not touch concept_id is not blocked", !eMeta, eMeta?.message ?? "");

  const { error: eMove } = await db.from("question_concepts")
    .update({ concept_id: fixture }).eq("question_id", someQ).eq("concept_id", liveFixture);
  ok("a DEPRECATED concept refuses an existing mapping REPOINTED onto it", !!eMove);

  const { data: stillThere } = await db.from("question_concepts")
    .select("concept_id").eq("question_id", someQ).eq("concept_id", liveFixture);
  ok("the refused repoint left the mapping where it was", (stillThere?.length ?? 0) === 1);
} catch (err) {
  console.error("  FIXTURE ERROR:", err.message);
  fail++;
} finally {
  for (const id of [fixture, liveFixture].filter(Boolean)) {
    await db.from("question_concepts").delete().eq("concept_id", id);
    await db.from("concept_aliases").delete().eq("concept_id", id);
    await db.from("concepts").delete().eq("id", id);
  }
  // THE SAME DEFECT AS THE COUNTS ABOVE, and it hid here because it is phrased
  // as a cleanup check rather than a population check. Comparing the whole
  // concepts table against a magic number fails the next time anything is
  // seeded, which is exactly what happened when Data Interpretation landed. Ask
  // about the fixture itself instead: it is a stronger check and it never goes
  // stale.
  const ids = [fixture, liveFixture].filter(Boolean);
  const { data: leftC } = await db.from("concepts").select("id").in("id", ids.length ? ids : ["00000000-0000-0000-0000-000000000000"]);
  const { data: leftA } = await db.from("concept_aliases").select("concept_id").in("concept_id", ids.length ? ids : ["00000000-0000-0000-0000-000000000000"]);
  const { data: leftQ } = await db.from("question_concepts").select("concept_id").in("concept_id", ids.length ? ids : ["00000000-0000-0000-0000-000000000000"]);
  ok("fixture fully removed, no residue",
    (leftC?.length ?? 0) === 0 && (leftA?.length ?? 0) === 0 && (leftQ?.length ?? 0) === 0,
    `concept ${leftC?.length ?? 0}, alias ${leftA?.length ?? 0}, mapping ${leftQ?.length ?? 0}`);
}

console.log("\n" + (fail ? `${fail} FAILURE(S), ${pass} passed` : `all ${pass} checks pass`));
process.exit(fail ? 1 : 0);
