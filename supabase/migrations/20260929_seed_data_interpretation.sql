-- ============================================================
-- Migration 2 of 3: seed RO_DATA_INTERPRETATION
--
-- One object and one description fix. No mappings: the approved 24 are
-- migration 3, so if a mapping is wrong the object does not have to be unpicked
-- with it.
--
-- WHY A NEW OBJECT RATHER THAN A RECLASSIFICATION. Nine questions across the
-- immune and cardiovascular chapters put a dataset in front of the reader and
-- ask what it establishes. The obvious candidate, Data Display Formats, is the
-- wrong one and stays QUANTITATIVE: it means pie, bar, histogram, line, box plot
-- and log axes, which is knowing what a chart IS. Its seven flashcards teach
-- exactly that. None of the nine questions involves knowing what a histogram is;
-- most are plain tables of counts. Knowledge of a representation and the
-- operation of reading evidence are different axes, and collapsing them would
-- make one root cause read as the other.
--
-- The name is deliberate. Graph and Table Interpretation was considered and
-- rejected because it names the surface form rather than the operation, which is
-- the confusion this object exists to prevent.
--
-- NO TAXONOMY. A reasoning operation is not examined in one MCAT section or one
-- discipline, which is the whole point of the cross-cutting types. The existing
-- trigger already refuses taxonomy on a non-CONTENT object; this migration adds
-- none and the verifier asserts none appeared.
--
-- THE SECOND STATEMENT is an UPDATE, not a seed. Reaction Mechanism Analysis has
-- carried no description since it was created during the organic chemistry pass.
-- The permanent verifier now requires that any REASONING object holding question
-- evidence has a definition, and while that object has no questions today,
-- filling it in now means the rule can never be met by a silent exception later.
-- Its source flashcard is a six-step workflow for analysing an unfamiliar
-- reaction, which is why it is REASONING and not organic chemistry content.
--
-- TOUCHES NOTHING ELSE: no question_concepts, no flashcard_concepts, no
-- question_reasoning_objects row, no learner table.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The object.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES (
  'RO_DATA_INTERPRETATION',
  'Data Interpretation',
  'Extracting what a presented dataset does and does not establish: comparing observations or groups that differ in relevant respects, identifying which comparisons are controlled, recognising patterns the data supports, and rejecting conclusions it cannot support.',
  'REASONING', 'ACTIVE_SEED', 'CONCEPT')
ON CONFLICT (slug) DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 2. The description that was never written.
-- ────────────────────────────────────────────────────────────
UPDATE public.concepts
SET description = 'A reusable procedure for working out an unfamiliar organic reaction: read the nomenclature, identify the functional groups and the other reagents, decide which group is most reactive, find the first step, then account for stereospecificity and selectivity.',
    updated_at = now()
WHERE slug = 'RO_REACTION_MECHANISM_ANALYSIS'
  AND (description IS NULL OR btrim(description) = '');

-- ────────────────────────────────────────────────────────────
-- 3. Verification inside the transaction.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int; d TEXT;
BEGIN
  SELECT count(*) INTO v FROM public.concepts WHERE slug = 'RO_DATA_INTERPRETATION';
  IF v <> 1 THEN RAISE EXCEPTION 'expected 1 RO_DATA_INTERPRETATION, found %', v; END IF;

  SELECT object_type INTO d FROM public.concepts WHERE slug = 'RO_DATA_INTERPRETATION';
  IF d <> 'REASONING' THEN RAISE EXCEPTION 'object_type is %, expected REASONING', d; END IF;

  SELECT status INTO d FROM public.concepts WHERE slug = 'RO_DATA_INTERPRETATION';
  IF d <> 'ACTIVE_SEED' THEN RAISE EXCEPTION 'status is %, expected ACTIVE_SEED', d; END IF;

  -- Both reasoning objects now carry a definition.
  SELECT count(*) INTO v FROM public.concepts
    WHERE object_type = 'REASONING' AND (description IS NULL OR btrim(description) = '');
  IF v <> 0 THEN RAISE EXCEPTION '% REASONING objects still have no description', v; END IF;

  -- No taxonomy reached the new object, on any of the three axes.
  SELECT count(*) INTO v FROM public.concepts c
    WHERE c.slug = 'RO_DATA_INTERPRETATION' AND (
      EXISTS (SELECT 1 FROM public.concept_sections s            WHERE s.concept_id = c.id) OR
      EXISTS (SELECT 1 FROM public.concept_disciplines di        WHERE di.concept_id = c.id) OR
      EXISTS (SELECT 1 FROM public.concept_content_categories k  WHERE k.concept_id = c.id));
  IF v <> 0 THEN RAISE EXCEPTION 'the new reasoning object acquired content taxonomy'; END IF;

  -- No mappings of any kind yet.
  SELECT count(*) INTO v FROM public.question_reasoning_objects;
  IF v <> 0 THEN RAISE EXCEPTION 'question_reasoning_objects should still be empty, found %', v; END IF;
  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.slug = 'RO_DATA_INTERPRETATION';
  IF v <> 0 THEN RAISE EXCEPTION 'a reasoning object reached question_concepts'; END IF;

  -- Exactly one object was added, and nothing else moved.
  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1130 THEN RAISE EXCEPTION 'expected 1130 concepts, found %', v; END IF;
  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2673 THEN RAISE EXCEPTION 'question_concepts was touched: %', v; END IF;
  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard_concepts was touched: %', v; END IF;
END $$;

SELECT slug, canonical_name, object_type, status, left(description, 70) AS definition_starts
FROM public.concepts
WHERE slug IN ('RO_DATA_INTERPRETATION', 'RO_REACTION_MECHANISM_ANALYSIS')
ORDER BY slug;

COMMIT;
