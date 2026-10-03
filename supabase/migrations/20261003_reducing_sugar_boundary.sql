-- ─── Migration 3: the reducing-sugar boundary repair ──────────────────────
--
-- Two concepts, both legitimate, with the line drawn in the wrong place and a
-- name that invited the mistake. "Oxidation & Reducing Sugars" names two things
-- at once, and three of its five questions actually test the second one.
--
-- NOT A MERGE. The objectives are genuinely distinct: what oxidising a sugar
-- PRODUCES (aldonic acids, lactones) is a different thing to know from WHICH
-- sugars reduce a reagent and why. A student can know one and not the other.
-- So the repair is a rename plus three repoints, not a deprecation.
--
-- THE DESTINATIONS WERE RE-DERIVED FROM LIVE STATE, not from the earlier audit
-- and not from the old label. Each of the five questions was re-read in full
-- with its options and explanation, and each one's flashcard evidence settles
-- it without a judgement call:
--
--   STAYS, oxidation products:
--     18ee658b  C1 aldehyde to carboxylic acid, the aldonic acid
--     e45c97f6  oxidised in the ring, so a lactone
--   MOVES, reducing-sugar behaviour:
--     29efd5f2  Benedict's redox bookkeeping, sugar oxidised and Cu(II) reduced
--     56644b98  anomeric-to-anomeric linkage versus anomeric-to-C4
--     d0f19c7b  a free anomeric hemiacetal opens to an aldehyde
--
-- The three that move have their evidence in Reducing & Non-Reducing Sugars:
-- the Benedict's card, the hemiacetal card and the sucrose card. The two that
-- stay have theirs in the aldonic acid and lactone cards.
--
-- SLUG: UNCHANGED, and deliberately so. The project's established convention is
-- that a rename changes canonical_name and leaves the slug alone. The one prior
-- rename proves it: "Respiratory Thermoregulation" still carries the slug
-- THERMOREGULATION. renameConcept() in lib/taxonomy/lifecycle.ts touches
-- canonical_name and version only, and archive_renamed_concept() fires on
-- canonical_name only. Migration 1 did rename four slugs, but that repaired a
-- seeding defect in a convention, which is a different operation from
-- correcting a display name. A slug reading OXIDATION_REDUCING_SUGARS under the
-- name "Sugar Oxidation Products" is the known cost of that convention, and
-- inventing a new rule here is not this migration's job.
--
-- GOVERNANCE on the three repoints: AI_PROPOSED / AI_PROPOSED, which is the
-- pattern the immune and cardiovascular reconciliations established for a
-- manually designed repoint, and which 202 live rows already carry. It is also
-- the truthful label: once a mapping has been moved by hand because the old one
-- was semantically wrong, it is no longer derived by exact name equality, so
-- leaving source as DETERMINISTIC_EXACT would be a false provenance claim.
--
-- A SPLIT flags NEEDS_REVIEW because it cannot know which child a mapping
-- belongs to. A designed repoint knows exactly where each one goes and why, so
-- it does not. This migration adds ZERO rows to the NEEDS_REVIEW queue, which
-- stays at the 29 from the lipid split.
--
-- Pre-state recorded immutably at scratchpad/sugar/pre_rename_snapshot.json
-- (sha256 ef022e771f4234392fa0bba9e2a24a0e).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT; st TEXT; nm TEXT;
BEGIN
  SELECT status, canonical_name INTO st, nm FROM public.concepts WHERE id = '5b0439d8-9114-4191-ae44-1d09c924b053';
  IF st IS NULL THEN RAISE EXCEPTION 'SUGAR: concept A not found'; END IF;
  IF st <> 'ACTIVE_SEED' THEN RAISE EXCEPTION 'SUGAR: concept A is %, expected ACTIVE_SEED', st; END IF;
  IF nm <> 'Oxidation & Reducing Sugars' THEN RAISE EXCEPTION 'SUGAR: concept A is already named %', nm; END IF;

  SELECT status INTO st FROM public.concepts WHERE id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce';
  IF st IS NULL THEN RAISE EXCEPTION 'SUGAR: concept B not found'; END IF;
  IF st <> 'ACTIVE_SEED' THEN RAISE EXCEPTION 'SUGAR: concept B is %, expected ACTIVE_SEED', st; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053';
  IF n <> 5 THEN RAISE EXCEPTION 'SUGAR: expected 5 questions on concept A, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce';
  IF n <> 4 THEN RAISE EXCEPTION 'SUGAR: expected 4 questions on concept B, found %', n; END IF;

  -- The five reviewed ids must be exactly the five currently on A.
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053' AND question_id IN (
     '29efd5f2-32cc-4e7a-a799-947d92ebee71',
     '56644b98-ee7f-4189-b08c-7126fcc508f0',
     'd0f19c7b-2255-4544-8576-0558117cacba',
     '18ee658b-e1c8-463d-b495-20e0283148b3',
     'e45c97f6-a36b-45c4-83df-2693fb8e3a88'
   );
  IF n <> 5 THEN RAISE EXCEPTION 'SUGAR: the reviewed set matches only % of the 5 live mappings', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id IN ('5b0439d8-9114-4191-ae44-1d09c924b053', '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce') AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'SUGAR: % human-validated mapping(s) would be overwritten', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id IN ('5b0439d8-9114-4191-ae44-1d09c924b053', '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce') AND role <> 'PRIMARY';
  IF n <> 0 THEN RAISE EXCEPTION 'SUGAR: % non-PRIMARY mapping(s) present; the repoint assumes all are PRIMARY', n; END IF;

  -- The new name must not collide, before or after normalisation.
  SELECT count(*) INTO n FROM public.concepts
   WHERE id <> '5b0439d8-9114-4191-ae44-1d09c924b053'
     AND lower(regexp_replace(canonical_name, '[^a-zA-Z0-9]+', ' ', 'g')) =
         lower(regexp_replace('Sugar Oxidation Products', '[^a-zA-Z0-9]+', ' ', 'g'));
  IF n <> 0 THEN RAISE EXCEPTION 'SUGAR: the new canonical name collides with % existing concept(s)', n; END IF;

  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE alias = 'Oxidation & Reducing Sugars' AND alias_type = 'LEGACY_NAME';
  IF n <> 0 THEN RAISE EXCEPTION 'SUGAR: that LEGACY_NAME alias already exists'; END IF;
END $$;

-- ─── 1. Definitions. Both were empty; each now states its own boundary. ──
UPDATE public.concepts SET description = $d$The products of oxidising a monosaccharide: aldonic acids from the open-chain aldehyde, and lactones when the anomeric carbon is oxidised in the ring. This concept is about what the oxidation yields, not about which sugars give a positive reducing test.$d$ WHERE id = '5b0439d8-9114-4191-ae44-1d09c924b053';
UPDATE public.concepts SET description = $d$Which sugars reduce an oxidising reagent and why: a free anomeric carbon in the hemiacetal form opens to an aldehyde, so the sugar is a reducing sugar. Covers Benedict's and Tollens' testing, and why a sugar whose anomeric carbons are both committed to a glycosidic bond, such as sucrose, is non-reducing.$d$ WHERE id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce';

-- ─── 2. The rename. The trigger files the old name as a LEGACY_NAME alias. ──
UPDATE public.concepts
   SET canonical_name = 'Sugar Oxidation Products', version = version + 1
 WHERE id = '5b0439d8-9114-4191-ae44-1d09c924b053';

-- ─── 3. The three repoints ───────────────────────────────────────────────
UPDATE public.question_concepts
   SET concept_id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce', mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
 WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053'
   AND question_id IN (
  -- Benedict's redox bookkeeping: the sugar is oxidised and Cu(II) reduced, which is what makes it a REDUCING sugar
  '29efd5f2-32cc-4e7a-a799-947d92ebee71',
  -- anomeric-to-anomeric versus anomeric-to-C4 linkage decides which disaccharide reduces Cu
  '56644b98-ee7f-4189-b08c-7126fcc508f0',
  -- a free anomeric hemiacetal can open to an aldehyde, so the structure gives a positive test
  'd0f19c7b-2255-4544-8576-0558117cacba'
   );

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; nm TEXT; sl TEXT; v INT;
BEGIN
  SELECT canonical_name, slug, version INTO nm, sl, v FROM public.concepts WHERE id = '5b0439d8-9114-4191-ae44-1d09c924b053';
  IF nm <> 'Sugar Oxidation Products' THEN RAISE EXCEPTION 'SUGAR: rename did not land, name is %', nm; END IF;
  IF sl <> 'OXIDATION_REDUCING_SUGARS' THEN RAISE EXCEPTION 'SUGAR: the slug changed to %, it must not', sl; END IF;
  IF v <> 2 THEN RAISE EXCEPTION 'SUGAR: version is %, expected 2', v; END IF;

  -- Assert the alias from live state rather than assuming the trigger ran.
  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053' AND alias = 'Oxidation & Reducing Sugars' AND alias_type = 'LEGACY_NAME';
  IF n <> 1 THEN RAISE EXCEPTION 'SUGAR: the rename trigger did not file the old name as a LEGACY_NAME alias (found %)', n; END IF;

  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> 6 THEN RAISE EXCEPTION 'SUGAR: alias total is %, expected 6', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053';
  IF n <> 2 THEN RAISE EXCEPTION 'SUGAR: expected 2 questions left on Sugar Oxidation Products, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce';
  IF n <> 7 THEN RAISE EXCEPTION 'SUGAR: expected 7 questions on Reducing & Non-Reducing Sugars, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce' AND question_id IN (
     '29efd5f2-32cc-4e7a-a799-947d92ebee71',
     '56644b98-ee7f-4189-b08c-7126fcc508f0',
     'd0f19c7b-2255-4544-8576-0558117cacba'
   ) AND mapping_status = 'AI_PROPOSED' AND source = 'AI_PROPOSED' AND role = 'PRIMARY';
  IF n <> 3 THEN RAISE EXCEPTION 'SUGAR: only % of the 3 repoints landed with the right governance', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053' AND question_id IN (
     '18ee658b-e1c8-463d-b495-20e0283148b3',
     'e45c97f6-a36b-45c4-83df-2693fb8e3a88'
   );
  IF n <> 2 THEN RAISE EXCEPTION 'SUGAR: the 2 oxidation-product questions did not stay put (%)', n; END IF;

  -- Every one of the five still holds exactly one PRIMARY CONTENT mapping.
  SELECT count(*) INTO n FROM (
    SELECT qc.question_id FROM public.question_concepts qc
      JOIN public.concepts c ON c.id = qc.concept_id
     WHERE qc.question_id IN (
       '29efd5f2-32cc-4e7a-a799-947d92ebee71',
       '56644b98-ee7f-4189-b08c-7126fcc508f0',
       'd0f19c7b-2255-4544-8576-0558117cacba',
       '18ee658b-e1c8-463d-b495-20e0283148b3',
       'e45c97f6-a36b-45c4-83df-2693fb8e3a88'
     ) AND qc.role = 'PRIMARY' AND c.object_type = 'CONTENT' AND c.status <> 'DEPRECATED'
     GROUP BY qc.question_id HAVING count(*) = 1) x;
  IF n <> 5 THEN RAISE EXCEPTION 'SUGAR: only % of 5 questions hold exactly one live PRIMARY CONTENT mapping', n; END IF;

  -- Nothing else moved.
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2673 THEN RAISE EXCEPTION 'SUGAR: question_concepts total is %, expected 2673', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4116 THEN RAISE EXCEPTION 'SUGAR: flashcard_concepts total is %, expected 4116', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> 24 THEN RAISE EXCEPTION 'SUGAR: reasoning mappings is %, expected 24', n; END IF;
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> 1132 THEN RAISE EXCEPTION 'SUGAR: ontology objects is %, expected 1132', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> 177 THEN RAISE EXCEPTION 'SUGAR: deprecated count is %, expected 177', n; END IF;

  -- The flashcards on both concepts are untouched: 2 on A, 4 on B.
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '5b0439d8-9114-4191-ae44-1d09c924b053';
  IF n <> 2 THEN RAISE EXCEPTION 'SUGAR: concept A flashcards changed (%)', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '475ee5d2-1e2f-4976-b1b3-7f8b614d10ce';
  IF n <> 4 THEN RAISE EXCEPTION 'SUGAR: concept B flashcards changed (%)', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'SUGAR: % mapping(s) now target a deprecated concept', n; END IF;

  RAISE NOTICE 'SUGAR OK: renamed, old name filed as LEGACY_NAME, 3 questions repointed, 2 held, 0 new NEEDS_REVIEW.';
END $$;

COMMIT;
