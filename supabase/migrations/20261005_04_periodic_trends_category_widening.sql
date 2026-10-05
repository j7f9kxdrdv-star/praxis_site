-- REQUIRES: 20261005_03_chemical_family_vocabulary.sql
-- because it closes a category gap that only exists once migration 7 has reused Periodic Trends.
-- Checked by lib/taxonomy/migrationOrder.test.ts: a required file must
-- sort earlier, so a fresh database replays these in a working order.
-- ─── Migration 7b: one category row, to close what migration 7 opened ─────
--
-- Migration 7 reused Periodic Trends for the successive-ionization-energy
-- question out of the Chemistry of the Groups backlog. That mapping is right:
-- the question gives IE1, IE2 and IE3 for two period-3 metals and asks you to
-- read group membership off the jump, and the evidence is the Periodic Trends
-- card saying a large jump between successive ionization energies marks the
-- noble-gas core.
--
-- But the question carries the AAMC category "The Periodic Table: Classification
-- of Elements Into Groups by Electronic Structure", and Periodic Trends carried
-- only "Atoms, nuclear decay, electronic structure, and atomic chemical
-- behavior" and "The Periodic Table: Variations of Chemical Properties with
-- Group and Row". So the mapping was reachable by section and by discipline but
-- NOT by category, and the permanent verifier caught it on the first run after
-- migration 7 applied.
--
-- This is the same defect, and the same fix, as the Immunoglobulins widening
-- during the immune reconciliation. The check's own comment predicted it: "a
-- future repoint that forgets to widen fails here." It did, and it was mine.
--
-- The widening is correct rather than a workaround: identifying a group from
-- the pattern of successive ionization energies IS classification of elements
-- into groups by electronic structure, so Periodic Trends genuinely spans both
-- categories. One concept, two legitimate AAMC categories.
--
-- is_primary = false, because concept_content_categories_one_primary allows
-- exactly one primary per concept and Periodic Trends already has one. A row
-- written as primary would be silently dropped by the partial unique index.
--
-- Exactly one row. No concept, mapping, learner or taxonomy change beyond it.

BEGIN;

DO $$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug = 'PERIODIC_TRENDS' AND status = 'ACTIVE_SEED';
  IF n <> 1 THEN RAISE EXCEPTION 'WIDEN: Periodic Trends is not a live concept'; END IF;

  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
   WHERE c.slug = 'PERIODIC_TRENDS';
  IF n <> 2 THEN RAISE EXCEPTION 'WIDEN: expected 2 category rows on Periodic Trends, found %', n; END IF;

  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
   WHERE c.slug = 'PERIODIC_TRENDS' AND k.is_primary;
  IF n <> 1 THEN RAISE EXCEPTION 'WIDEN: Periodic Trends should already have exactly one primary category'; END IF;
END $$;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure', false
  FROM public.concepts c WHERE c.slug = 'PERIODIC_TRENDS'
ON CONFLICT (concept_id, content_category) DO NOTHING;

DO $$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
   WHERE c.slug = 'PERIODIC_TRENDS';
  IF n <> 3 THEN RAISE EXCEPTION 'WIDEN: expected 3 category rows after, found % (ON CONFLICT may have dropped it)', n; END IF;

  SELECT count(*) INTO n FROM public.concept_content_categories k
    JOIN public.concepts c ON c.id = k.concept_id
   WHERE c.slug = 'PERIODIC_TRENDS' AND k.is_primary;
  IF n <> 1 THEN RAISE EXCEPTION 'WIDEN: the primary category changed'; END IF;

  -- The point of the migration: every question mapping is now reachable by
  -- category, bank-wide, not just this one.
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.questions q ON q.id = qc.question_id
   WHERE NOT EXISTS (
     SELECT 1 FROM public.concept_content_categories k
      WHERE k.concept_id = qc.concept_id AND k.content_category = q.content_category);
  IF n <> 0 THEN RAISE EXCEPTION 'WIDEN: % question mapping(s) still unreachable by category', n; END IF;

  RAISE NOTICE 'WIDEN OK: Periodic Trends now carries 3 categories, 0 question mappings unreachable by category.';
END $$;

COMMIT;
