-- ─── Migration 1 of the ontology lifecycle cleanup ─────────────────────────
--
-- Four QUANTITATIVE objects were seeded without the QK_ slug prefix that the
-- other sixteen carry, and without descriptions. This migration fixes both and
-- does nothing else.
--
-- WHY THIS ONE GOES FIRST: it moves no mapping. Every other migration in the
-- sequence changes which concept a piece of evidence resolves to, so this one
-- re-proves the write-and-verify loop against a change that cannot affect a
-- learner.
--
-- WHAT THE PREFIX IS AND IS NOT: nothing in the runtime resolves a concept by
-- slug. lib/taxonomy/resolve.ts joins on concept_id, lib/taxonomy/objectType.ts
-- partitions on the object_type column, and the content_concepts /
-- reasoning_objects / quantitative_objects views filter on object_type. The
-- prefix is an authoring convention, audited before this was written, so this
-- migration is cosmetic to the application and load-bearing only for humans
-- and for future seed SQL.
--
-- STABLE IDS DO NOT CHANGE. slug is a display and authoring handle; the UUID is
-- the key every mapping holds. That is why no flashcard_concepts row moves.
--
-- OLD SLUG TRACEABILITY: the rename trigger archive_renamed_concept() fires
-- BEFORE UPDATE OF canonical_name only, so a slug change files no alias, and
-- concept_aliases.alias_type has no slug member to file one under. Extending
-- that CHECK is a schema change and does not belong in a migration whose whole
-- point is that it is cheap. The old-to-new mapping is recorded here and in git.
--   VECTORS_AND_SCALARS                          -> QK_VECTORS_AND_SCALARS
--   VECTOR_ADDITION_AND_COMPONENTS               -> QK_VECTOR_ADDITION_AND_COMPONENTS
--   VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION -> QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION
--   DOT_AND_CROSS_PRODUCTS                       -> QK_DOT_AND_CROSS_PRODUCTS
-- supabase/migrations/20260924_physics_vocabulary_seed.sql still names the old
-- slugs. It is already applied and is not edited: a historical migration
-- records what ran, not what is current.
--
-- CANONICAL NAMES ARE NOT TOUCHED. Updating canonical_name would fire the
-- rename trigger and file a LEGACY_NAME alias, which would be a second,
-- unrequested change. The assertions below prove no alias was filed.
--
-- The descriptions are written from the source flashcards, not from the names.

BEGIN;

UPDATE public.concepts SET
  slug        = 'QK_VECTORS_AND_SCALARS',
  description = $d$Magnitude with direction versus magnitude alone, and which physical quantities are which.$d$,
  updated_at  = now()
WHERE slug = 'VECTORS_AND_SCALARS' AND object_type = 'QUANTITATIVE';

UPDATE public.concepts SET
  slug        = 'QK_VECTOR_ADDITION_AND_COMPONENTS',
  description = $d$Tip-to-tail addition, resolution into signed perpendicular components, and the magnitude and angle of the resultant.$d$,
  updated_at  = now()
WHERE slug = 'VECTOR_ADDITION_AND_COMPONENTS' AND object_type = 'QUANTITATIVE';

UPDATE public.concepts SET
  slug        = 'QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION',
  description = $d$Subtraction as adding the reverse, and how a scalar multiple rescales and flips a vector.$d$,
  updated_at  = now()
WHERE slug = 'VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION' AND object_type = 'QUANTITATIVE';

UPDATE public.concepts SET
  slug        = 'QK_DOT_AND_CROSS_PRODUCTS',
  description = $d$The scalar product and its cosine, the vector product and its sine, and the right-hand rule.$d$,
  updated_at  = now()
WHERE slug = 'DOT_AND_CROSS_PRODUCTS' AND object_type = 'QUANTITATIVE';

-- ─── Migration-specific assertions ────────────────────────────────────────
--
-- These are exact counts on purpose. An exact count in the permanent verifier
-- is correct exactly once; an exact count HERE is the proof that this migration
-- did what it said. They are also written as assertions about the resulting
-- STATE rather than about rows affected, so pasting this twice is a no-op that
-- still passes rather than a false alarm.

DO $$
DECLARE
  n           INT;
  bad         TEXT;
  expected    TEXT[] := ARRAY[
                'QK_VECTORS_AND_SCALARS',
                'QK_VECTOR_ADDITION_AND_COMPONENTS',
                'QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION',
                'QK_DOT_AND_CROSS_PRODUCTS'];
  retired     TEXT[] := ARRAY[
                'VECTORS_AND_SCALARS',
                'VECTOR_ADDITION_AND_COMPONENTS',
                'VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION',
                'DOT_AND_CROSS_PRODUCTS'];
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug = ANY(retired);
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % old vector slug(s) survive', n;
  END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE slug = ANY(expected);
  IF n <> 4 THEN
    RAISE EXCEPTION 'MIGRATION 1: expected 4 renamed objects, found %', n;
  END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE slug = ANY(expected) AND object_type = 'QUANTITATIVE' AND status <> 'DEPRECATED';
  IF n <> 4 THEN
    RAISE EXCEPTION 'MIGRATION 1: a renamed object changed type or status (% of 4 still QUANTITATIVE and live)', n;
  END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE slug = ANY(expected) AND coalesce(btrim(description), '') = '';
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % renamed object(s) still have no description', n;
  END IF;

  -- Every QUANTITATIVE object now conforms. This is the point of the migration.
  SELECT count(*) INTO n FROM public.concepts
   WHERE object_type = 'QUANTITATIVE' AND (left(slug, 3) <> 'QK_' OR coalesce(btrim(description), '') = '');
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % QUANTITATIVE object(s) still off-convention', n;
  END IF;

  -- NOTHING MOVED. The card counts per object are the pre-migration numbers,
  -- read live before this file was written: 2, 4, 2, 3.
  SELECT string_agg(x.slug || '=' || x.cards, ', ' ORDER BY x.slug) INTO bad
    FROM (SELECT c.slug, count(fc.flashcard_id) AS cards
            FROM public.concepts c
            LEFT JOIN public.flashcard_concepts fc ON fc.concept_id = c.id
           WHERE c.slug = ANY(expected)
           GROUP BY c.slug) x
   WHERE NOT (
     (x.slug = 'QK_VECTORS_AND_SCALARS' AND x.cards = 2) OR
     (x.slug = 'QK_VECTOR_ADDITION_AND_COMPONENTS' AND x.cards = 4) OR
     (x.slug = 'QK_VECTOR_SUBTRACTION_AND_SCALAR_MULTIPLICATION' AND x.cards = 2) OR
     (x.slug = 'QK_DOT_AND_CROSS_PRODUCTS' AND x.cards = 3));
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'MIGRATION 1: flashcard mappings moved: %', bad;
  END IF;

  -- A QUANTITATIVE object must carry no question mapping and no content
  -- taxonomy. Both are trigger-enforced, so this is belt and braces.
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.slug = ANY(expected);
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % question mapping(s) appeared on a QUANTITATIVE object', n;
  END IF;

  SELECT count(*) INTO n FROM public.concepts c WHERE c.slug = ANY(expected) AND (
       EXISTS (SELECT 1 FROM public.concept_sections s WHERE s.concept_id = c.id)
    OR EXISTS (SELECT 1 FROM public.concept_disciplines d WHERE d.concept_id = c.id)
    OR EXISTS (SELECT 1 FROM public.concept_content_categories k WHERE k.concept_id = c.id));
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % renamed object(s) acquired content taxonomy', n;
  END IF;

  -- The canonical names were not touched, so the rename trigger must not have
  -- fired. If it had, each of these four would now own a LEGACY_NAME alias.
  SELECT count(*) INTO n FROM public.concept_aliases a
    JOIN public.concepts c ON c.id = a.concept_id WHERE c.slug = ANY(expected);
  IF n <> 0 THEN
    RAISE EXCEPTION 'MIGRATION 1: % alias row(s) filed, so canonical_name changed when it should not have', n;
  END IF;

  RAISE NOTICE 'MIGRATION 1 OK: 4 slugs on convention, 4 descriptions written, 11 flashcard mappings unmoved, 0 aliases filed.';
END $$;

COMMIT;
