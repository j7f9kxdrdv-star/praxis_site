import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/families/pre_state.json", "utf8"));
const { CARDS, QUESTIONS, REUSE, SECONDARY } = s.manifest;
const MNM = s.metalsNonmetalsMetalloids.id;
const NAMES = {
  ALKALI_AND_ALKALINE_EARTH_METALS: "Alkali and Alkaline Earth Metals",
  HALOGENS: "Halogens",
  NOBLE_GASES: "Noble Gases",
  TRANSITION_METALS_INNER_TRANSITION_SERIES: "Transition Metals & Inner Transition Series",
  CHALCOGENS: "Chalcogens",
};
const DEFS = {
  ALKALI_AND_ALKALINE_EARTH_METALS: "Groups 1 and 2: a single ns1 valence electron giving a +1 cation, or two ns2 electrons giving a +2 cation, each reaching the configuration of the preceding noble gas. Group 1 has the larger radius and lower ionization energy of the pair and is the more reactive, and both are reactive enough that neither is found free in nature. Covers the reaction with cold water and the hydroxide it produces, reactivity trends within and down the groups, and why hydrogen sits above lithium without being an alkali metal.",
  HALOGENS: "Group 17: seven valence electrons, one short of an octet, giving the highest electron affinities of any group and a halide ion of charge minus one. Covers the diatomic elemental form, the progression from gas to liquid to solid down the group as dispersion forces grow, oxidizing strength falling down the group, and the acid strength of the hydrogen halides rising down the group as the H to X bond weakens.",
  NOBLE_GASES: "Group 18: a filled valence shell, hence very high ionization energies, negligible electron affinity and chemical inertness under ordinary conditions. Covers the monatomic elemental form and the weak dispersion forces that follow from it, helium completing its shell at two electrons rather than eight, and the compounds the heavier members form with strongly electronegative partners.",
  TRANSITION_METALS_INNER_TRANSITION_SERIES: "The d-block, with valence electrons in the highest s and d subshells: variable oxidation states because those two levels lie close in energy, stronger metallic bonding than the active metals because more electrons are delocalized, and coloured complexes arising from d-orbital splitting. Includes the f-block lanthanide and actinide series shown beneath the main table.",
  CHALCOGENS: "Group 16: six valence electrons, typically gaining two to reach an oxidation state of minus two against an electropositive partner, with sulfur and the heavier members also reaching plus four and plus six when bonded to more electronegative atoms.",
};
const SLUGS = Object.keys(NAMES);
const q = (x) => `'${x}'`;
const cardRows = SLUGS.flatMap((sl) => CARDS[sl].map((id) => `  (${q(id)}, ${q(sl)})`)).join(",\n");
const qRows = [
  ...SLUGS.flatMap((sl) => (QUESTIONS[sl] || []).map((id) => `  (${q(id)}, ${q(sl)}, 'PRIMARY')`)),
  ...Object.entries(REUSE).flatMap(([sl, ids]) => ids.map((id) => `  (${q(id)}, ${q(sl)}, 'PRIMARY')`)),
  ...SECONDARY.map((x) => `  (${q(x.question)}, ${q(x.slug)}, 'SECONDARY')`),
].join(",\n");
const nQ = SLUGS.reduce((a, sl) => a + (QUESTIONS[sl] || []).length, 0);
const nReuse = Object.values(REUSE).flat().length;

const sql = `-- ─── Migration 7: the chemical-family vocabulary ──────────────────────────
--
-- The largest migration in the cleanup, and the one that pays off migration 6.
-- Five CONTENT concepts are created, the 19 chemical-family flashcards move to
-- them off a concept that no longer describes them, and the 20-question
-- Chemistry of the Groups backlog is resolved.
--
-- ALL 19 CARDS AND ALL 20 QUESTIONS RE-READ FROM LIVE STATE, in full, with
-- options and explanations. Every destination matches the approved audit.
--
-- CARD DISTRIBUTION BY ID, not by keyword. Migration 6 showed why: a keyword
-- scan of these same 19 found only 17, missing the card about hydrogen sitting
-- above lithium and the card about fluorine having the highest electronegativity,
-- neither of which names its family in its text. Both are assigned here by id.
--
-- THE HYDROFLUORIC ACID QUESTION was proposed for Strong vs Weak Acids/Bases;
-- Ka and Kb, and the forensic check REJECTED that. The question asks why HF is
-- the weakest hydrogen halide DESPITE fluorine being the most electronegative,
-- and its explanation says outright that the trend is governed by bond strength
-- and not by electronegativity. The acids concept carries card "Acids are
-- stronger when electronegative elements sit near the acidic proton", which is
-- the reasoning of the wrong answer. Sending a student who missed this question
-- to that card would reinforce the error the question exists to catch.
-- It is mapped to Halogens instead, as a group 17 trend, and a flashcard is
-- queued for the gap: no card anywhere in the bank teaches that binary hydride
-- acidity rises down the group because the H to X bond weakens.
--
-- THE CALCIUM AND CHLORINE QUESTION takes a SECONDARY, and only because both
-- family identities are independently required. The stem gives [Ar]4s2 and
-- 3s2 3p5 and asks for the product formula. Its explanation: "the formula must
-- satisfy two independent requirements at once". Group 2 alone gives +2 and
-- group 17 alone gives -1; neither yields CaCl2 without the other. No other
-- question gets a SECONDARY for merely naming two elements.
--
-- MAPPING ARITHMETIC, stated separately because these are different operations:
--   5    concepts created
--   15   taxonomy rows created (one section, discipline and category each)
--   1    alias created (Active Metals, the source deck phrase, as a COMMON_NAME)
--   19   EXISTING flashcard mappings REPOINTED  (flashcard_concepts total unchanged)
--   ${String(nQ).padEnd(4)} question PRIMARY mappings INSERTED to the new concepts
--   ${String(nReuse).padEnd(4)} question PRIMARY mapping INSERTED by REUSE (Periodic Trends)
--   1    question SECONDARY mapping INSERTED
--   = 21 new question_concepts rows, 2,673 -> 2,694
--
-- TAXONOMY comes from the evidence, not the deck. All 20 questions carry the
-- content category "The Periodic Table: Classification of Elements Into Groups
-- by Electronic Structure", which is also what Metals, Nonmetals & Metalloids
-- carries. All five are CHEM_PHYS / GENERAL_CHEMISTRY / that category.
--
-- GOVERNANCE: AI_PROPOSED / AI_PROPOSED throughout. Every assignment here was
-- determined by semantic review, so no row claims DETERMINISTIC_EXACT, nothing
-- is marked HUMAN_VALIDATED, and nothing is NEEDS_REVIEW because a designed
-- assignment knows its destination.
--
-- LEARNER HISTORY: the 19 cards carry 55 scheduler rows and 418 reviews between
-- them, the most any migration in this sequence has moved. Mapping identity
-- changes; none of that may.
--
-- Pre-state recorded immutably at scratchpad/families/pre_state.json
-- (sha256 ${s.sha256.slice(0, 32)}).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN (${SLUGS.map(q).join(", ")});
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the five slugs already exist', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE canonical_name IN (${SLUGS.map((sl) => `$n$${NAMES[sl]}$n$`).join(", ")});
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the five names already exist', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${MNM}';
  IF n <> 24 THEN RAISE EXCEPTION 'FAMILIES: expected 24 cards on Metals, Nonmetals & Metalloids, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '${MNM}' AND flashcard_id IN (${SLUGS.flatMap((sl) => CARDS[sl]).map(q).join(", ")});
  IF n <> 19 THEN RAISE EXCEPTION 'FAMILIES: only % of the 19 family cards are where expected', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE question_id IN (${[...SLUGS.flatMap((sl) => QUESTIONS[sl] || []), ...Object.values(REUSE).flat()].map(q).join(", ")});
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the 20 backlog questions are already mapped', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE slug = 'PERIODIC_TRENDS' AND status = 'ACTIVE_SEED';
  IF n <> 1 THEN RAISE EXCEPTION 'FAMILIES: the Periodic Trends reuse target is not active'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '${MNM}' AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % human-validated card mapping(s) in scope', n; END IF;
END $$;

-- ─── 1. The five concepts ────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES
${SLUGS.map((sl) => `  ('${sl}', $n$${NAMES[sl]}$n$, $d$${DEFS[sl]}$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT')`).join(",\n")};

-- ─── 2. Taxonomy, from the questions' own content category ──────────────
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, 'CHEM_PHYS', true FROM public.concepts c WHERE c.slug IN (${SLUGS.map(q).join(", ")});

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, 'GENERAL_CHEMISTRY', 'PRIMARY' FROM public.concepts c WHERE c.slug IN (${SLUGS.map(q).join(", ")});

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure', true
  FROM public.concepts c WHERE c.slug IN (${SLUGS.map(q).join(", ")});

-- ─── 3. The source-deck phrase kept searchable, not as identity ─────────
INSERT INTO public.concept_aliases (concept_id, alias, alias_type, source, status)
SELECT c.id, 'Active Metals', 'COMMON_NAME', 'HUMAN_REVIEWED', 'HUMAN_VALIDATED'
  FROM public.concepts c WHERE c.slug = 'ALKALI_AND_ALKALINE_EARTH_METALS';

-- ─── 4. The 19 cards, repointed by id ───────────────────────────────────
UPDATE public.flashcard_concepts fc
   SET concept_id = t.id, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
  FROM (VALUES
${cardRows}
  ) AS v(card_id, slug)
  JOIN public.concepts t ON t.slug = v.slug
 WHERE fc.flashcard_id = v.card_id::uuid AND fc.concept_id = '${MNM}';

-- ─── 5. The 20 backlog questions, plus one SECONDARY ────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, confidence, mapping_status, source)
SELECT v.question_id::uuid, t.id, v.role, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM (VALUES
${qRows}
  ) AS v(question_id, slug, role)
  JOIN public.concepts t ON t.slug = v.slug;

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; bad TEXT;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN (${SLUGS.map(q).join(", ")}) AND status = 'ACTIVE_SEED' AND object_type = 'CONTENT';
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % of 5 concepts are live CONTENT', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN (${SLUGS.map(q).join(", ")}) AND coalesce(btrim(description), '') = '';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % concept(s) have no definition', n; END IF;

  SELECT count(*) INTO n FROM public.concept_sections s JOIN public.concepts c ON c.id = s.concept_id WHERE c.slug IN (${SLUGS.map(q).join(", ")});
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % section rows, expected 5', n; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines d JOIN public.concepts c ON c.id = d.concept_id WHERE c.slug IN (${SLUGS.map(q).join(", ")});
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % discipline rows, expected 5', n; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories k JOIN public.concepts c ON c.id = k.concept_id WHERE c.slug IN (${SLUGS.map(q).join(", ")});
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % category rows, expected 5', n; END IF;

  -- The debt from migration 6 is paid: no family card left behind.
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${MNM}';
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: Metals, Nonmetals & Metalloids should hold exactly its 5 metal-character cards, found %', n; END IF;

  SELECT string_agg(x.slug || '=' || x.c, ', ' ORDER BY x.slug) INTO bad FROM (
    SELECT c.slug, count(fc.flashcard_id) AS c FROM public.concepts c
      LEFT JOIN public.flashcard_concepts fc ON fc.concept_id = c.id
     WHERE c.slug IN (${SLUGS.map(q).join(", ")}) GROUP BY c.slug) x
   WHERE NOT (${SLUGS.map((sl) => `(x.slug = '${sl}' AND x.c = ${CARDS[sl].length})`).join(" OR ")});
  IF bad IS NOT NULL THEN RAISE EXCEPTION 'FAMILIES: card distribution wrong: %', bad; END IF;

  SELECT string_agg(x.slug || '=' || x.c, ', ' ORDER BY x.slug) INTO bad FROM (
    SELECT c.slug, count(qc.question_id) AS c FROM public.concepts c
      LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
     WHERE c.slug IN (${SLUGS.map(q).join(", ")}) GROUP BY c.slug) x
   WHERE NOT (${SLUGS.map((sl) => {
     const extra = SECONDARY.filter((x) => x.slug === sl).length;
     return `(x.slug = '${sl}' AND x.c = ${(QUESTIONS[sl] || []).length + extra})`;
   }).join(" OR ")});
  IF bad IS NOT NULL THEN RAISE EXCEPTION 'FAMILIES: question distribution wrong: %', bad; END IF;

  -- Every one of the 20 now holds exactly one PRIMARY mapping.
  SELECT count(*) INTO n FROM (
    SELECT qc.question_id FROM public.question_concepts qc
     WHERE qc.question_id IN (${[...SLUGS.flatMap((sl) => QUESTIONS[sl] || []), ...Object.values(REUSE).flat()].map(q).join(", ")})
       AND qc.role = 'PRIMARY' GROUP BY qc.question_id HAVING count(*) = 1) y;
  IF n <> 20 THEN RAISE EXCEPTION 'FAMILIES: only % of 20 questions hold exactly one PRIMARY', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc JOIN public.concepts c ON c.id = qc.concept_id
   WHERE qc.question_id = '${SECONDARY[0].question}' AND qc.role = 'SECONDARY' AND c.slug = '${SECONDARY[0].slug}';
  IF n <> 1 THEN RAISE EXCEPTION 'FAMILIES: the calcium-chlorine SECONDARY did not land'; END IF;

  -- Governance and populations.
  SELECT count(*) INTO n FROM public.question_concepts qc JOIN public.concepts c ON c.id = qc.concept_id
   WHERE c.slug IN (${SLUGS.map(q).join(", ")}) AND NOT (qc.mapping_status = 'AI_PROPOSED' AND qc.source = 'AI_PROPOSED');
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % new question mapping(s) carry the wrong governance', n; END IF;

  SELECT count(*) INTO n FROM public.concepts;
  IF n <> ${s.totals.concepts + 5} THEN RAISE EXCEPTION 'FAMILIES: ontology objects is %, expected ${s.totals.concepts + 5}', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> ${s.totals.flashcardConcepts} THEN RAISE EXCEPTION 'FAMILIES: flashcard_concepts is %, expected ${s.totals.flashcardConcepts} (repointed, not added)', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> ${s.totals.questionConcepts + 21} THEN RAISE EXCEPTION 'FAMILIES: question_concepts is %, expected ${s.totals.questionConcepts + 21}', n; END IF;
  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> ${s.totals.aliases + 1} THEN RAISE EXCEPTION 'FAMILIES: aliases is %, expected ${s.totals.aliases + 1}', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> ${s.totals.reasoningObjects} THEN RAISE EXCEPTION 'FAMILIES: reasoning mappings moved'; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> ${s.totals.deprecated} THEN RAISE EXCEPTION 'FAMILIES: deprecated moved'; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') z;
  IF n <> ${s.totals.needsReview} THEN RAISE EXCEPTION 'FAMILIES: NEEDS_REVIEW is %, expected ${s.totals.needsReview}', n; END IF;

  -- No question anywhere is left without a CONTENT mapping.
  SELECT count(*) INTO n FROM public.questions q
   WHERE NOT EXISTS (SELECT 1 FROM public.question_concepts qc WHERE qc.question_id = q.id);
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % question(s) remain unmapped, expected 0', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts fc JOIN public.concepts c ON c.id = fc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % card mapping(s) target a deprecated concept', n; END IF;

  RAISE NOTICE 'FAMILIES OK: 5 concepts, 19 cards repointed, 21 question mappings inserted, backlog 20 -> 0, family cards on Metals/Nonmetals/Metalloids 19 -> 0.';
END $$;

COMMIT;
`;
fs.writeFileSync("supabase/migrations/20261005_chemical_family_vocabulary.sql", sql);
console.log("wrote supabase/migrations/20261005_chemical_family_vocabulary.sql");
