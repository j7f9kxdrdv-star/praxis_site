-- ============================================================
-- Immunoglobulins: one SECONDARY content category
--
-- FOUND DURING VERIFICATION of the immune question-side reconciliation, not
-- designed alongside it. One immune question, "Defence Against an Extracellular
-- Bacterial Product", was repointed onto Immunoglobulins, which is the right
-- destination: the item is about antibody neutralising a toxin in interstitial
-- fluid. But the question is categorised under Organ Systems and the concept
-- only carried Structure and Function of Proteins and Their Constituent Amino
-- Acids, so the mapping is reachable by section and discipline but not by
-- category.
--
-- This is the same gap the flashcard backfill already fixed on the other axis.
-- That pass gave Immunoglobulins BIOLOGY as a SECONDARY discipline when it took
-- nine biology cards. The category was missed because nothing mapped a question
-- onto it until now.
--
-- SECONDARY, never primary. concept_content_categories carries a partial unique
-- index on is_primary, so a widening row written as primary is silently
-- discarded by ON CONFLICT DO NOTHING and the concept quietly keeps one
-- category. Protein structure stays primary: that is what Immunoglobulins is.
--
-- Scope: one row. No mapping moves, no concept changes status, no learner table
-- is read or written.
-- ============================================================

BEGIN;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'Organ Systems', false
FROM public.concepts c
WHERE c.slug = 'IMMUNOGLOBULINS'
ON CONFLICT DO NOTHING;

DO $$
DECLARE n int;
BEGIN
  -- The widening landed, and protein structure is still the primary.
  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
    WHERE c.slug = 'IMMUNOGLOBULINS' AND k.content_category = 'Organ Systems' AND k.is_primary = false;
  IF n <> 1 THEN RAISE EXCEPTION 'expected 1 secondary category row, found %', n; END IF;

  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
    WHERE c.slug = 'IMMUNOGLOBULINS' AND k.is_primary;
  IF n <> 1 THEN RAISE EXCEPTION 'expected exactly 1 primary category, found %', n; END IF;

  -- Nothing else moved.
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2666 THEN RAISE EXCEPTION 'question mappings changed: %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4115 THEN RAISE EXCEPTION 'flashcard mappings changed: %', n; END IF;
END $$;

-- Every question mapping is now reachable by category. Expect 0 rows.
SELECT c.canonical_name, q.content_category
FROM public.question_concepts qc
JOIN public.concepts c ON c.id = qc.concept_id
JOIN public.questions q ON q.id = qc.question_id
WHERE NOT EXISTS (
  SELECT 1 FROM public.concept_content_categories k
  WHERE k.concept_id = c.id AND k.content_category = q.content_category);

COMMIT;
