-- ─── Migration 7: the chemical-family vocabulary ──────────────────────────
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
--   19   question PRIMARY mappings INSERTED to the new concepts
--   1    question PRIMARY mapping INSERTED by REUSE (Periodic Trends)
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
-- (sha256 538ed970bcef12de34037e198927e8f8).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the five slugs already exist', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE canonical_name IN ($n$Alkali and Alkaline Earth Metals$n$, $n$Halogens$n$, $n$Noble Gases$n$, $n$Transition Metals & Inner Transition Series$n$, $n$Chalcogens$n$);
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the five names already exist', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 24 THEN RAISE EXCEPTION 'FAMILIES: expected 24 cards on Metals, Nonmetals & Metalloids, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1' AND flashcard_id IN ('6a7030ef-e87b-4789-b0c5-86c428e9521a', 'c94607ef-b01a-4c59-9d36-b0ca69a1cdc6', '14dedf27-ff4b-47b8-b03e-3216081bd745', '7d4080fd-c3f9-4479-aba5-8fdd104fc9dc', '47980145-006d-4ead-88f1-bfac0c6f8885', 'd934d272-5fa3-4e8e-b009-183fdadcadbe', 'be1a9ae7-9b98-46a7-ae11-0878027f83b0', 'f4c15b97-c19e-41f3-999c-d10acef2ce14', '0d84d208-3afe-4030-aa2d-c014c9545d08', '8efeb7bb-0bda-44b8-b4c4-624652e72534', 'e5af10b6-c440-4583-a906-df7a0dca39a9', '41e199ef-5bd1-4082-8deb-a90b68650d4b', '82701d00-f247-42c5-b344-44b5cce60f2a', '7271ffde-6204-416e-856b-bdc422f3ba40', '78cd585c-8233-4776-90e3-747585ad4251', 'dbedae99-4310-4e0e-bf65-4120c4e40d14', '681df28e-fdf8-4beb-ae4b-2ba3d304d4ca', '51c5de5b-d7e0-4d3b-b69e-c6d8f8ea5fb5', '0a7247dc-3575-4681-b553-d3cc156ac9c2');
  IF n <> 19 THEN RAISE EXCEPTION 'FAMILIES: only % of the 19 family cards are where expected', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE question_id IN ('0ecd7bac-0143-47c1-98a8-66483b9da663', '281971ff-47d5-48f2-ade7-bb49b09ecf78', '41f87b91-e2a7-4348-8495-48cd042eece3', '5ef31e94-271a-4344-b482-e4d9bacc7bb5', '6486571a-1237-471c-bb9b-8c373f61c395', '73b5fcb7-a512-42ca-8ec3-b430c9264f47', '75a2da19-403a-461a-ba4c-d9721d233eec', 'eee33c57-0002-4666-81a6-f7a1fb97a1b9', '2f153e0e-453a-4ff7-b1ec-b304739cde77', '487d627f-035c-4192-b71a-b7d7f4fd845d', '883f79c9-3fad-4d44-a63e-d104d6a890aa', 'be5f387b-e6b2-4ec3-8197-821198b54cda', 'f4f7b834-bb1f-401a-b380-2f173274871c', '055c6d03-4f75-493d-81ab-94ddabff502f', '9e2a17c9-cac8-4c02-a0c8-379b30ac5965', 'c6f7963e-fa2b-4c69-b852-aef86e5f6c4e', 'ab4d6752-bed6-4716-a5e4-99eec8fcc551', 'd20971ce-413f-44b2-ba81-d55af592d136', '2500b00c-f29c-43f6-9c8a-8009805b7c5d', 'b7858478-c39f-4aeb-bb6b-32894e259ab7');
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % of the 20 backlog questions are already mapped', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE slug = 'PERIODIC_TRENDS' AND status = 'ACTIVE_SEED';
  IF n <> 1 THEN RAISE EXCEPTION 'FAMILIES: the Periodic Trends reuse target is not active'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1' AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % human-validated card mapping(s) in scope', n; END IF;
END $$;

-- ─── 1. The five concepts ────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES
  ('ALKALI_AND_ALKALINE_EARTH_METALS', $n$Alkali and Alkaline Earth Metals$n$, $d$Groups 1 and 2: a single ns1 valence electron giving a +1 cation, or two ns2 electrons giving a +2 cation, each reaching the configuration of the preceding noble gas. Group 1 has the larger radius and lower ionization energy of the pair and is the more reactive, and both are reactive enough that neither is found free in nature. Covers the reaction with cold water and the hydroxide it produces, reactivity trends within and down the groups, and why hydrogen sits above lithium without being an alkali metal.$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('HALOGENS', $n$Halogens$n$, $d$Group 17: seven valence electrons, one short of an octet, giving the highest electron affinities of any group and a halide ion of charge minus one. Covers the diatomic elemental form, the progression from gas to liquid to solid down the group as dispersion forces grow, oxidizing strength falling down the group, and the acid strength of the hydrogen halides rising down the group as the H to X bond weakens.$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('NOBLE_GASES', $n$Noble Gases$n$, $d$Group 18: a filled valence shell, hence very high ionization energies, negligible electron affinity and chemical inertness under ordinary conditions. Covers the monatomic elemental form and the weak dispersion forces that follow from it, helium completing its shell at two electrons rather than eight, and the compounds the heavier members form with strongly electronegative partners.$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('TRANSITION_METALS_INNER_TRANSITION_SERIES', $n$Transition Metals & Inner Transition Series$n$, $d$The d-block, with valence electrons in the highest s and d subshells: variable oxidation states because those two levels lie close in energy, stronger metallic bonding than the active metals because more electrons are delocalized, and coloured complexes arising from d-orbital splitting. Includes the f-block lanthanide and actinide series shown beneath the main table.$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('CHALCOGENS', $n$Chalcogens$n$, $d$Group 16: six valence electrons, typically gaining two to reach an oxidation state of minus two against an electropositive partner, with sulfur and the heavier members also reaching plus four and plus six when bonded to more electronegative atoms.$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT');

-- ─── 2. Taxonomy, from the questions' own content category ──────────────
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, 'CHEM_PHYS', true FROM public.concepts c WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, 'GENERAL_CHEMISTRY', 'PRIMARY' FROM public.concepts c WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure', true
  FROM public.concepts c WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');

-- ─── 3. The source-deck phrase kept searchable, not as identity ─────────
INSERT INTO public.concept_aliases (concept_id, alias, alias_type, source, status)
SELECT c.id, 'Active Metals', 'COMMON_NAME', 'HUMAN_REVIEWED', 'HUMAN_VALIDATED'
  FROM public.concepts c WHERE c.slug = 'ALKALI_AND_ALKALINE_EARTH_METALS';

-- ─── 4. The 19 cards, repointed by id ───────────────────────────────────
UPDATE public.flashcard_concepts fc
   SET concept_id = t.id, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
  FROM (VALUES
  ('6a7030ef-e87b-4789-b0c5-86c428e9521a', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('c94607ef-b01a-4c59-9d36-b0ca69a1cdc6', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('14dedf27-ff4b-47b8-b03e-3216081bd745', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('7d4080fd-c3f9-4479-aba5-8fdd104fc9dc', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('47980145-006d-4ead-88f1-bfac0c6f8885', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('d934d272-5fa3-4e8e-b009-183fdadcadbe', 'ALKALI_AND_ALKALINE_EARTH_METALS'),
  ('be1a9ae7-9b98-46a7-ae11-0878027f83b0', 'HALOGENS'),
  ('f4c15b97-c19e-41f3-999c-d10acef2ce14', 'HALOGENS'),
  ('0d84d208-3afe-4030-aa2d-c014c9545d08', 'HALOGENS'),
  ('8efeb7bb-0bda-44b8-b4c4-624652e72534', 'HALOGENS'),
  ('e5af10b6-c440-4583-a906-df7a0dca39a9', 'NOBLE_GASES'),
  ('41e199ef-5bd1-4082-8deb-a90b68650d4b', 'NOBLE_GASES'),
  ('82701d00-f247-42c5-b344-44b5cce60f2a', 'NOBLE_GASES'),
  ('7271ffde-6204-416e-856b-bdc422f3ba40', 'TRANSITION_METALS_INNER_TRANSITION_SERIES'),
  ('78cd585c-8233-4776-90e3-747585ad4251', 'TRANSITION_METALS_INNER_TRANSITION_SERIES'),
  ('dbedae99-4310-4e0e-bf65-4120c4e40d14', 'TRANSITION_METALS_INNER_TRANSITION_SERIES'),
  ('681df28e-fdf8-4beb-ae4b-2ba3d304d4ca', 'TRANSITION_METALS_INNER_TRANSITION_SERIES'),
  ('51c5de5b-d7e0-4d3b-b69e-c6d8f8ea5fb5', 'TRANSITION_METALS_INNER_TRANSITION_SERIES'),
  ('0a7247dc-3575-4681-b553-d3cc156ac9c2', 'CHALCOGENS')
  ) AS v(card_id, slug)
  JOIN public.concepts t ON t.slug = v.slug
 WHERE fc.flashcard_id = v.card_id::uuid AND fc.concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';

-- ─── 5. The 20 backlog questions, plus one SECONDARY ────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, confidence, mapping_status, source)
SELECT v.question_id::uuid, t.id, v.role, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM (VALUES
  ('0ecd7bac-0143-47c1-98a8-66483b9da663', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('281971ff-47d5-48f2-ade7-bb49b09ecf78', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('41f87b91-e2a7-4348-8495-48cd042eece3', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('5ef31e94-271a-4344-b482-e4d9bacc7bb5', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('6486571a-1237-471c-bb9b-8c373f61c395', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('73b5fcb7-a512-42ca-8ec3-b430c9264f47', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('75a2da19-403a-461a-ba4c-d9721d233eec', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('eee33c57-0002-4666-81a6-f7a1fb97a1b9', 'ALKALI_AND_ALKALINE_EARTH_METALS', 'PRIMARY'),
  ('2f153e0e-453a-4ff7-b1ec-b304739cde77', 'HALOGENS', 'PRIMARY'),
  ('487d627f-035c-4192-b71a-b7d7f4fd845d', 'HALOGENS', 'PRIMARY'),
  ('883f79c9-3fad-4d44-a63e-d104d6a890aa', 'HALOGENS', 'PRIMARY'),
  ('be5f387b-e6b2-4ec3-8197-821198b54cda', 'HALOGENS', 'PRIMARY'),
  ('f4f7b834-bb1f-401a-b380-2f173274871c', 'HALOGENS', 'PRIMARY'),
  ('055c6d03-4f75-493d-81ab-94ddabff502f', 'NOBLE_GASES', 'PRIMARY'),
  ('9e2a17c9-cac8-4c02-a0c8-379b30ac5965', 'NOBLE_GASES', 'PRIMARY'),
  ('c6f7963e-fa2b-4c69-b852-aef86e5f6c4e', 'NOBLE_GASES', 'PRIMARY'),
  ('ab4d6752-bed6-4716-a5e4-99eec8fcc551', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'PRIMARY'),
  ('d20971ce-413f-44b2-ba81-d55af592d136', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'PRIMARY'),
  ('2500b00c-f29c-43f6-9c8a-8009805b7c5d', 'CHALCOGENS', 'PRIMARY'),
  ('b7858478-c39f-4aeb-bb6b-32894e259ab7', 'PERIODIC_TRENDS', 'PRIMARY'),
  ('73b5fcb7-a512-42ca-8ec3-b430c9264f47', 'HALOGENS', 'SECONDARY')
  ) AS v(question_id, slug, role)
  JOIN public.concepts t ON t.slug = v.slug;

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; bad TEXT;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS') AND status = 'ACTIVE_SEED' AND object_type = 'CONTENT';
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % of 5 concepts are live CONTENT', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS') AND coalesce(btrim(description), '') = '';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % concept(s) have no definition', n; END IF;

  SELECT count(*) INTO n FROM public.concept_sections s JOIN public.concepts c ON c.id = s.concept_id WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % section rows, expected 5', n; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines d JOIN public.concepts c ON c.id = d.concept_id WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % discipline rows, expected 5', n; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories k JOIN public.concepts c ON c.id = k.concept_id WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS');
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: % category rows, expected 5', n; END IF;

  -- The debt from migration 6 is paid: no family card left behind.
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 5 THEN RAISE EXCEPTION 'FAMILIES: Metals, Nonmetals & Metalloids should hold exactly its 5 metal-character cards, found %', n; END IF;

  SELECT string_agg(x.slug || '=' || x.c, ', ' ORDER BY x.slug) INTO bad FROM (
    SELECT c.slug, count(fc.flashcard_id) AS c FROM public.concepts c
      LEFT JOIN public.flashcard_concepts fc ON fc.concept_id = c.id
     WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS') GROUP BY c.slug) x
   WHERE NOT ((x.slug = 'ALKALI_AND_ALKALINE_EARTH_METALS' AND x.c = 6) OR (x.slug = 'HALOGENS' AND x.c = 4) OR (x.slug = 'NOBLE_GASES' AND x.c = 3) OR (x.slug = 'TRANSITION_METALS_INNER_TRANSITION_SERIES' AND x.c = 5) OR (x.slug = 'CHALCOGENS' AND x.c = 1));
  IF bad IS NOT NULL THEN RAISE EXCEPTION 'FAMILIES: card distribution wrong: %', bad; END IF;

  SELECT string_agg(x.slug || '=' || x.c, ', ' ORDER BY x.slug) INTO bad FROM (
    SELECT c.slug, count(qc.question_id) AS c FROM public.concepts c
      LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
     WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS') GROUP BY c.slug) x
   WHERE NOT ((x.slug = 'ALKALI_AND_ALKALINE_EARTH_METALS' AND x.c = 8) OR (x.slug = 'HALOGENS' AND x.c = 6) OR (x.slug = 'NOBLE_GASES' AND x.c = 3) OR (x.slug = 'TRANSITION_METALS_INNER_TRANSITION_SERIES' AND x.c = 2) OR (x.slug = 'CHALCOGENS' AND x.c = 1));
  IF bad IS NOT NULL THEN RAISE EXCEPTION 'FAMILIES: question distribution wrong: %', bad; END IF;

  -- Every one of the 20 now holds exactly one PRIMARY mapping.
  SELECT count(*) INTO n FROM (
    SELECT qc.question_id FROM public.question_concepts qc
     WHERE qc.question_id IN ('0ecd7bac-0143-47c1-98a8-66483b9da663', '281971ff-47d5-48f2-ade7-bb49b09ecf78', '41f87b91-e2a7-4348-8495-48cd042eece3', '5ef31e94-271a-4344-b482-e4d9bacc7bb5', '6486571a-1237-471c-bb9b-8c373f61c395', '73b5fcb7-a512-42ca-8ec3-b430c9264f47', '75a2da19-403a-461a-ba4c-d9721d233eec', 'eee33c57-0002-4666-81a6-f7a1fb97a1b9', '2f153e0e-453a-4ff7-b1ec-b304739cde77', '487d627f-035c-4192-b71a-b7d7f4fd845d', '883f79c9-3fad-4d44-a63e-d104d6a890aa', 'be5f387b-e6b2-4ec3-8197-821198b54cda', 'f4f7b834-bb1f-401a-b380-2f173274871c', '055c6d03-4f75-493d-81ab-94ddabff502f', '9e2a17c9-cac8-4c02-a0c8-379b30ac5965', 'c6f7963e-fa2b-4c69-b852-aef86e5f6c4e', 'ab4d6752-bed6-4716-a5e4-99eec8fcc551', 'd20971ce-413f-44b2-ba81-d55af592d136', '2500b00c-f29c-43f6-9c8a-8009805b7c5d', 'b7858478-c39f-4aeb-bb6b-32894e259ab7')
       AND qc.role = 'PRIMARY' GROUP BY qc.question_id HAVING count(*) = 1) y;
  IF n <> 20 THEN RAISE EXCEPTION 'FAMILIES: only % of 20 questions hold exactly one PRIMARY', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc JOIN public.concepts c ON c.id = qc.concept_id
   WHERE qc.question_id = '73b5fcb7-a512-42ca-8ec3-b430c9264f47' AND qc.role = 'SECONDARY' AND c.slug = 'HALOGENS';
  IF n <> 1 THEN RAISE EXCEPTION 'FAMILIES: the calcium-chlorine SECONDARY did not land'; END IF;

  -- Governance and populations.
  SELECT count(*) INTO n FROM public.question_concepts qc JOIN public.concepts c ON c.id = qc.concept_id
   WHERE c.slug IN ('ALKALI_AND_ALKALINE_EARTH_METALS', 'HALOGENS', 'NOBLE_GASES', 'TRANSITION_METALS_INNER_TRANSITION_SERIES', 'CHALCOGENS') AND NOT (qc.mapping_status = 'AI_PROPOSED' AND qc.source = 'AI_PROPOSED');
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % new question mapping(s) carry the wrong governance', n; END IF;

  SELECT count(*) INTO n FROM public.concepts;
  IF n <> 1137 THEN RAISE EXCEPTION 'FAMILIES: ontology objects is %, expected 1137', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4116 THEN RAISE EXCEPTION 'FAMILIES: flashcard_concepts is %, expected 4116 (repointed, not added)', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2694 THEN RAISE EXCEPTION 'FAMILIES: question_concepts is %, expected 2694', n; END IF;
  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> 9 THEN RAISE EXCEPTION 'FAMILIES: aliases is %, expected 9', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> 24 THEN RAISE EXCEPTION 'FAMILIES: reasoning mappings moved'; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> 177 THEN RAISE EXCEPTION 'FAMILIES: deprecated moved'; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') z;
  IF n <> 29 THEN RAISE EXCEPTION 'FAMILIES: NEEDS_REVIEW is %, expected 29', n; END IF;

  -- No question anywhere is left without a CONTENT mapping.
  SELECT count(*) INTO n FROM public.questions q
   WHERE NOT EXISTS (SELECT 1 FROM public.question_concepts qc WHERE qc.question_id = q.id);
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % question(s) remain unmapped, expected 0', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts fc JOIN public.concepts c ON c.id = fc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'FAMILIES: % card mapping(s) target a deprecated concept', n; END IF;

  RAISE NOTICE 'FAMILIES OK: 5 concepts, 19 cards repointed, 21 question mappings inserted, backlog 20 -> 0, family cards on Metals/Nonmetals/Metalloids 19 -> 0.';
END $$;

COMMIT;
