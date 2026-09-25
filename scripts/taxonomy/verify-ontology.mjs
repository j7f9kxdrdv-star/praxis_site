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
const concepts = await all("concepts", "id,slug,canonical_name,status,split_candidate,concept_level,parent_concept_id,object_type");
ok("1,085 objects (846 + 239 psych/soc)", concepts.length === 1085, String(concepts.length));
ok("all ACTIVE_SEED", concepts.every((c) => c.status === "ACTIVE_SEED"));
ok("200 split candidates flagged", concepts.filter((c) => c.split_candidate).length === 200);
ok("the rename kept one concept and filed an alias",
  concepts.some((c) => c.canonical_name === "Respiratory Thermoregulation") &&
  !concepts.some((c) => c.canonical_name === "Thermoregulation"));
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
ok("2,659 mappings (2,242 + 417)", qc.length === 2659, String(qc.length));
ok("all deterministic provenance",
  qc.every((m) => m.source === "DETERMINISTIC_EXACT" || m.source === "DETERMINISTIC"));
ok("2,242 by exact equality, 417 by approved lookup",
  qc.filter((m) => m.source === "DETERMINISTIC_EXACT").length === 2242 &&
  qc.filter((m) => m.source === "DETERMINISTIC").length === 417);
ok("all PRIMARY", qc.every((m) => m.role === "PRIMARY"));
ok("no duplicate PRIMARY per question", new Set(qc.map((m) => m.question_id)).size === qc.length);
ok("none marked human-validated", qc.every((m) => m.mapping_status !== "HUMAN_VALIDATED"));

const Q = await all("questions", "id,subtopic,section,content_category");
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
ok("the exact-equality cohort matches a current or historical name",
  qc.filter((m) => m.source === "DETERMINISTIC_EXACT").every((m) => {
    const sub = qById.get(m.question_id)?.subtopic;
    return sub === byId.get(m.concept_id)?.canonical_name || aliasesOf[m.concept_id]?.has(sub);
  }));

const SEC = { chem_phys: "CHEM_PHYS", bio_biochem: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", cars: "CARS" };
// MEMBERSHIP, not equality. This check originally compared a single
// concepts.section_code and failed on 4 mappings, which looked like a mapping
// bug and was really a schema one: "Isoelectric Focusing" is examined in two
// MCAT sections, so no single value could have been right.
const sects = (await all("concept_sections", "concept_id,section_code"))
  .reduce((a, r) => ((a[r.concept_id] ??= new Set()).add(r.section_code), a), {});
ok("section compatible on every mapping",
  qc.every((m) => sects[m.concept_id]?.has(SEC[qById.get(m.question_id)?.section])));
ok("1,053 content concepts placed in a section", new Set(Object.keys(sects)).size === 1053);
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
ok("content category compatible on every mapping",
  qc.every((m) => catsOf[m.concept_id]?.has(qById.get(m.question_id)?.content_category)));

console.log("\nFLASHCARD MAPPINGS");
const fc = await all("flashcard_concepts", "flashcard_id,concept_id,mapping_status,source");
const typeOf = Object.fromEntries(concepts.map((c) => [c.id, c.object_type]));
const byType = fc.reduce((a, m) => ((a[typeOf[m.concept_id]] = (a[typeOf[m.concept_id]] || 0) + 1), a), {});
ok("1,961 card mappings (1,183 + 778 psych/soc)", fc.length === 1961, String(fc.length));
ok("CONTENT 1834 / REASONING 36 / QUANTITATIVE 91",
  byType.CONTENT === 1834 && byType.REASONING === 36 && byType.QUANTITATIVE === 91, JSON.stringify(byType));
// Provenance must not overstate. The vocabulary was approved; 314 individual
// rows were not reviewed, and the status must not claim they were.
ok("no card mapping claims HUMAN_VALIDATED", fc.every((m) => m.mapping_status !== "HUMAN_VALIDATED"));
ok("no card mapping claims deterministic provenance",
  fc.every((m) => m.source !== "DETERMINISTIC" && m.source !== "DETERMINISTIC_EXACT"));
ok("all card mappings are AI_PROPOSED", fc.every((m) => m.source === "AI_PROPOSED"));
// The boundary that matters: reasoning and quantitative objects MAY be mapped
// from a flashcard, and must still be invisible to content analytics.
const contentIds = new Set(concepts.filter((c) => c.object_type === "CONTENT").map((c) => c.id));
ok("reasoning and quantitative mappings exist but are outside content",
  fc.some((m) => !contentIds.has(m.concept_id)) &&
  fc.filter((m) => contentIds.has(m.concept_id)).length === 1834);
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
// SEEDED BY THIS PHASE, not "sits in PSYCH_SOC". The physics pass made the
// broader mistake once already: a check that asks which concepts carry a section
// also catches the three bioethics concepts, which claim PSYCH_SOC, carry no
// category, and belong to the uncategorized backlog that must not be backfilled.
// The 239 seeded here all have a PRIMARY discipline; the bioethics three
// deliberately have none, so that is the discriminator.
const hasPrimaryDiscipline = new Set(
  (await all("concept_disciplines", "concept_id,role"))
    .filter((r) => r.role === "PRIMARY").map((r) => r.concept_id),
);
const psSeeded = concepts.filter((c) =>
  sects[c.id]?.has("PSYCH_SOC") && c.object_type === "CONTENT" && hasPrimaryDiscipline.has(c.id));
const psWrongSection = psMaps.filter((m) =>
  contentIds.has(m.concept_id) && !sects[m.concept_id]?.has("PSYCH_SOC"));
ok("every psych/soc mapping is reachable from the Psych/Soc section",
  psWrongSection.length === 0,
  psWrongSection.map((m) => byId.get(m.concept_id)?.canonical_name).join(", "));
const bioOnly = psSeeded.filter((c) => {
  const d = disciplinesOf[c.id];
  return d?.has("BIOLOGY") && !d.has("PSYCHOLOGY") && !d.has("SOCIOLOGY");
});
ok("biology-only concepts exist inside the psych/soc section",
  bioOnly.length === 3, `${bioOnly.length}: ${bioOnly.map((c) => c.canonical_name).join(", ")}`);
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

console.log("\nDELIBERATELY LEFT ALONE");
const mapped = new Set(qc.map((m) => m.question_id));
const unmapped = Q.filter((q) => !mapped.has(q.id));
ok("22 questions remain unmapped", unmapped.length === 22, String(unmapped.length));
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
  const left = (await count("concepts")) === 1085 && (await count("concept_aliases")) === 1;
  ok("fixture fully removed, no residue", left);
}

console.log("\n" + (fail ? `${fail} FAILURE(S), ${pass} passed` : `all ${pass} checks pass`));
process.exit(fail ? 1 : 0);
