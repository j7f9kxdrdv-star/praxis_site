-- ─── Migration 6: the Types of Elements identity repair ───────────────────
--
-- The clearest instance of the defect that has run through this whole cleanup.
-- "Types of Elements" means two things in English, and its evidence split along
-- the ambiguity:
--
--   19 flashcards teaching the CHEMICAL FAMILIES   (alkali metals, halogens,
--      noble gases, chalcogens, transition metals, lanthanides)
--   12 questions testing METAL CHARACTER           (metal vs nonmetal vs
--      metalloid: lustre, ductility, conductivity, brittleness, the staircase)
--
-- Neither set is wrong about the concept it landed on. The NAME was wrong about
-- which of the two it meant.
--
-- ALL 12 QUESTIONS RE-READ FROM LIVE STATE, with options and explanations.
-- Every one tests metal character, so none moves. The only one worth a second
-- look was the group-16 oxide question, which chains an electron configuration
-- to an oxide formula to a pH. Its explanation settles it: "classification of
-- an element as a nonmetal predicts that its oxide is an acidic oxide", and its
-- distractors are keyed to amphoteric (metalloid), basic (metal) and acidic
-- (nonmetal). The group identity is how you work out it is sulfur; the tested
-- inference is metal character. It stays.
--
-- THE FIVE CARDS MOVING IN are deck positions 8 to 12 of Periodic Trends &
-- Chemical Families: metals, what characterises a metal, nonmetals, the
-- metalloid staircase, and why metals conduct. They sit on Periodic Table
-- Structure & Classification, which keeps the eight that are genuinely about
-- the table's structure: Mendeleev, Moseley, the periodic law, periods and
-- groups, A and B elements, and where valence electrons sit per block.
--
-- A DELIBERATE, TEMPORARY MISMATCH, recorded here because it must not be
-- mistaken for a finished state. After this migration the 19 chemical-family
-- cards still hang off this concept, now called Metals, Nonmetals & Metalloids,
-- which does not describe them. Migration 7 creates the five family concepts
-- that receive them. Until it runs:
--
--   * the manifest of all 19 is recorded in scratchpad/elements/pre_state.json
--     under pendingFamilyCardsForMigration7, by id and deck position;
--   * a permanent verifier check FAILS while any family card remains here, so
--     the outstanding work is visible rather than remembered;
--   * learner concept states must not be built on this intermediate state.
--
-- SLUG UNCHANGED (TYPES_ELEMENTS), per the convention migrations 3 and 4
-- followed and Respiratory Thermoregulation established. A rename changes
-- canonical_name and version; renameConcept() touches nothing else.
--
-- GOVERNANCE: the five repoints land AI_PROPOSED / AI_PROPOSED, the pattern for
-- a designed semantic correction. They already carry those values, and the SQL
-- sets them explicitly so the governance is stated rather than inherited. No
-- DETERMINISTIC_EXACT is being preserved falsely here, because none was there.
-- Nothing becomes HUMAN_VALIDATED and nothing becomes NEEDS_REVIEW: a designed
-- repoint knows its destination, which a split does not.
--
-- THE FIVE CARDS CARRY REAL HISTORY: 12 scheduler rows and 86 reviews between
-- them, stabilities from 0.55 to 133. Mapping identity and scheduler state are
-- independent and the verification compares every field row by row.
--
-- Pre-state recorded immutably at scratchpad/elements/pre_state.json
-- (sha256 acd123e23400bd28763269d8338db229).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT; st TEXT; nm TEXT;
BEGIN
  SELECT status, canonical_name INTO st, nm FROM public.concepts WHERE id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF st IS DISTINCT FROM 'ACTIVE_SEED' THEN RAISE EXCEPTION 'ELEMENTS: concept is %', coalesce(st, 'missing'); END IF;
  IF nm <> 'Types of Elements' THEN RAISE EXCEPTION 'ELEMENTS: already renamed to %', nm; END IF;

  SELECT status INTO st FROM public.concepts WHERE id = '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329';
  IF st IS DISTINCT FROM 'ACTIVE_SEED' THEN RAISE EXCEPTION 'ELEMENTS: Periodic Table Structure is %', coalesce(st, 'missing'); END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 19 THEN RAISE EXCEPTION 'ELEMENTS: expected 19 cards on the concept, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 12 THEN RAISE EXCEPTION 'ELEMENTS: expected 12 questions on the concept, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329';
  IF n <> 13 THEN RAISE EXCEPTION 'ELEMENTS: expected 13 cards on Periodic Table Structure, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329' AND flashcard_id IN (
     '242ad5f8-8c88-4b39-9880-a91c2113aad2',
     '901b1035-869d-4f94-bdbf-2c14b197eeff',
     'd1345b3a-df4b-41c1-9c67-46a3b82a39ab',
     'a3be5b48-30de-49fe-bb22-5c8203296a3a',
     '535e2355-5d26-4e83-a122-be2c2a44be1f'
   );
  IF n <> 5 THEN RAISE EXCEPTION 'ELEMENTS: only % of the 5 incoming cards are where expected', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id IN ('70219a4e-8ea1-4629-9501-f0a6fcb5b7b1', '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329') AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'ELEMENTS: % human-validated card mapping(s) in scope', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1' AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'ELEMENTS: % human-validated question mapping(s) in scope', n; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE id <> '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1'
     AND lower(regexp_replace(canonical_name, '[^a-zA-Z0-9]+', ' ', 'g')) =
         lower(regexp_replace('Metals, Nonmetals & Metalloids', '[^a-zA-Z0-9]+', ' ', 'g'));
  IF n <> 0 THEN RAISE EXCEPTION 'ELEMENTS: the new name collides with % concept(s)', n; END IF;

  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE alias = 'Types of Elements' AND alias_type = 'LEGACY_NAME';
  IF n <> 0 THEN RAISE EXCEPTION 'ELEMENTS: that LEGACY_NAME alias already exists'; END IF;
END $$;

-- ─── 1. The definition, which rules the family axis out explicitly ──────
UPDATE public.concepts SET description = $d$Classifying an element by its broad character as a metal, nonmetal or metalloid, and the properties that separate those classes: lustre, malleability and ductility, electrical and thermal conductivity, brittleness, and the stair-step boundary that divides them. Group and family identity is a DIFFERENT axis and does not belong here: alkali metals, alkaline earths, chalcogens, halogens, noble gases and the transition series each have their own concept.$d$, updated_at = now()
 WHERE id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';

-- ─── 2. The rename. The trigger files the old name as a LEGACY_NAME alias. ──
UPDATE public.concepts
   SET canonical_name = 'Metals, Nonmetals & Metalloids', version = version + 1
 WHERE id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';

-- ─── 3. The five metal-character cards ──────────────────────────────────
UPDATE public.flashcard_concepts
   SET concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1', mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
 WHERE concept_id = '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329'
   AND flashcard_id IN (
  -- deck position 8: Metals occupy the left and middle of the periodic table and share a di
  '242ad5f8-8c88-4b39-9880-a91c2113aad2',
  -- deck position 9: A metal is characterized by low effective nuclear charge, low electron
  '901b1035-869d-4f94-bdbf-2c14b197eeff',
  -- deck position 10: Nonmetals sit in the upper right of the periodic table and are essenti
  'd1345b3a-df4b-41c1-9c67-46a3b82a39ab',
  -- deck position 11: The metalloids occupy a stair-step pattern separating metals from nonm
  'a3be5b48-30de-49fe-bb22-5c8203296a3a',
  -- deck position 12: Metals conduct heat and electricity well because their valence electro
  '535e2355-5d26-4e83-a122-be2c2a44be1f'
   );

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; nm TEXT; sl TEXT; v INT; d TEXT;
BEGIN
  SELECT canonical_name, slug, version, description INTO nm, sl, v, d
    FROM public.concepts WHERE id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF nm <> 'Metals, Nonmetals & Metalloids' THEN RAISE EXCEPTION 'ELEMENTS: rename did not land, name is %', nm; END IF;
  IF sl <> 'TYPES_ELEMENTS' THEN RAISE EXCEPTION 'ELEMENTS: the slug changed to %, it must not', sl; END IF;
  IF v <> 2 THEN RAISE EXCEPTION 'ELEMENTS: version is %, expected 2', v; END IF;
  IF position('DIFFERENT axis' IN d) = 0 THEN
    RAISE EXCEPTION 'ELEMENTS: the definition must rule the family axis out explicitly';
  END IF;

  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1' AND alias = 'Types of Elements' AND alias_type = 'LEGACY_NAME';
  IF n <> 1 THEN RAISE EXCEPTION 'ELEMENTS: the rename trigger did not file the LEGACY_NAME alias (found %)', n; END IF;
  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> 8 THEN RAISE EXCEPTION 'ELEMENTS: alias total is %, expected 8', n; END IF;

  -- 19 family cards still pending plus the 5 that arrived.
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 24 THEN RAISE EXCEPTION 'ELEMENTS: expected 24 cards (19 pending + 5 moved), found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '7e8df6c8-d4b5-4585-89c1-00aa7c4ba329';
  IF n <> 8 THEN RAISE EXCEPTION 'ELEMENTS: expected 8 cards left on Periodic Table Structure, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1' AND role = 'PRIMARY'
     AND mapping_status = 'AI_PROPOSED' AND source = 'AI_PROPOSED'
     AND flashcard_id IN (
       '242ad5f8-8c88-4b39-9880-a91c2113aad2',
       '901b1035-869d-4f94-bdbf-2c14b197eeff',
       'd1345b3a-df4b-41c1-9c67-46a3b82a39ab',
       'a3be5b48-30de-49fe-bb22-5c8203296a3a',
       '535e2355-5d26-4e83-a122-be2c2a44be1f'
     );
  IF n <> 5 THEN RAISE EXCEPTION 'ELEMENTS: only % of the 5 landed with the right governance', n; END IF;

  -- No question moved.
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '70219a4e-8ea1-4629-9501-f0a6fcb5b7b1';
  IF n <> 12 THEN RAISE EXCEPTION 'ELEMENTS: question count moved to %', n; END IF;

  -- Nothing else moved.
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> 1132 THEN RAISE EXCEPTION 'ELEMENTS: ontology objects is %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4116 THEN RAISE EXCEPTION 'ELEMENTS: flashcard_concepts is %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2673 THEN RAISE EXCEPTION 'ELEMENTS: question_concepts is %', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> 24 THEN RAISE EXCEPTION 'ELEMENTS: reasoning mappings is %', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> 177 THEN RAISE EXCEPTION 'ELEMENTS: deprecated is %', n; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') x;
  IF n <> 29 THEN RAISE EXCEPTION 'ELEMENTS: NEEDS_REVIEW is %, expected 29', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'ELEMENTS: % card mapping(s) target a deprecated concept', n; END IF;

  RAISE NOTICE 'ELEMENTS OK: renamed, old name filed, 5 cards moved in, 12 questions held. 19 family cards remain PENDING for migration 7.';
END $$;

COMMIT;
