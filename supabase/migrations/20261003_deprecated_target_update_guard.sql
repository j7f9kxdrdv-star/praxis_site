-- ─── Migration 2.5: close the deprecated-target UPDATE gap ────────────────
--
-- WHAT THE LIPID FIXTURE FOUND. reject_deprecated_concept_mapping() was
-- attached BEFORE INSERT only, on all three mapping tables. An INSERT onto a
-- deprecated concept was refused; an UPDATE that moved an existing mapping's
-- concept_id onto a deprecated concept was not checked at all.
--
-- Probed live before this was written, on disposable rows, all three tables:
--
--   flashcard_concepts          INSERT onto DEPRECATED       REFUSED
--   flashcard_concepts          UPDATE active -> DEPRECATED  ALLOWED  <- gap
--   question_concepts           INSERT onto DEPRECATED       REFUSED
--   question_concepts           UPDATE active -> DEPRECATED  ALLOWED  <- gap
--   question_reasoning_objects  INSERT onto DEPRECATED       REFUSED
--   question_reasoning_objects  UPDATE active -> DEPRECATED  ALLOWED  <- gap
--
-- The lipid split happened to be written in an order that never exercised the
-- gap: every repoint ran while both ends were live, and the parent was
-- deprecated last. That was deliberate, but safety that depends on each author
-- remembering a particular statement order is not safety.
--
-- WORTH NOTING, because it shows the gap was an oversight rather than a policy:
-- the sibling type-check triggers on the same tables are already BEFORE INSERT
-- OR UPDATE. question_concepts_content_only and
-- question_reasoning_objects_reasoning_only both cover the update path. Only
-- the deprecated-target guard was left on INSERT alone, and this brings it into
-- line with its neighbours.
--
-- THE SMALLEST CORRECT FIX is two changes:
--
--   1. UPDATE OF concept_id in the trigger definition, so the guard runs when
--      that column is assigned and stays out of the way otherwise. An edit to
--      confidence, mapping_status or reviewed_at does not fire it at all.
--   2. An early return inside the function when concept_id is not actually
--      moving. UPDATE OF fires whenever the column appears in the SET list,
--      even if the value is unchanged, so without this a self-assignment on a
--      row that already points somewhere deprecated would be refused. The rule
--      is about the destination changing, not about the column being named.
--
-- The function is shared by all three tables and is written generically, so it
-- is replaced once and every attached trigger gets the fix.
--
-- THIS MIGRATION MOVES NO DATA. No concept, no mapping, no taxonomy row, no
-- learner row. It replaces one function and three triggers.

BEGIN;

CREATE OR REPLACE FUNCTION public.reject_deprecated_concept_mapping()
RETURNS TRIGGER AS $$
DECLARE s TEXT;
BEGIN
  -- Only a move matters. A row whose concept_id is not changing is left alone,
  -- so ordinary metadata edits are never blocked, including on a row that
  -- already points at something deprecated and is being annotated rather than
  -- moved.
  IF TG_OP = 'UPDATE' AND NEW.concept_id IS NOT DISTINCT FROM OLD.concept_id THEN
    RETURN NEW;
  END IF;

  SELECT status INTO s FROM public.concepts WHERE id = NEW.concept_id;
  IF s = 'DEPRECATED' THEN
    RAISE EXCEPTION
      'Concept % is DEPRECATED. A mapping cannot be created on it or repointed onto it. Map to its successor instead.',
      NEW.concept_id;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS question_concepts_no_deprecated ON public.question_concepts;
CREATE TRIGGER question_concepts_no_deprecated
  BEFORE INSERT OR UPDATE OF concept_id ON public.question_concepts
  FOR EACH ROW EXECUTE FUNCTION public.reject_deprecated_concept_mapping();

DROP TRIGGER IF EXISTS flashcard_concepts_no_deprecated ON public.flashcard_concepts;
CREATE TRIGGER flashcard_concepts_no_deprecated
  BEFORE INSERT OR UPDATE OF concept_id ON public.flashcard_concepts
  FOR EACH ROW EXECUTE FUNCTION public.reject_deprecated_concept_mapping();

DROP TRIGGER IF EXISTS question_reasoning_objects_no_deprecated ON public.question_reasoning_objects;
CREATE TRIGGER question_reasoning_objects_no_deprecated
  BEFORE INSERT OR UPDATE OF concept_id ON public.question_reasoning_objects
  FOR EACH ROW EXECUTE FUNCTION public.reject_deprecated_concept_mapping();

-- ─── Post-conditions ─────────────────────────────────────────────────────
-- Assert the SHAPE of what was installed, read back from the catalog, rather
-- than trusting that the statements above ran. A trigger that exists but fires
-- on the wrong events would leave the gap open while looking repaired.
DO $$
DECLARE
  r      RECORD;
  defn   TEXT;
  n      INT;
  tables TEXT[] := ARRAY['question_concepts', 'flashcard_concepts', 'question_reasoning_objects'];
  trigs  TEXT[] := ARRAY['question_concepts_no_deprecated', 'flashcard_concepts_no_deprecated',
                         'question_reasoning_objects_no_deprecated'];
  i      INT;
BEGIN
  FOR i IN 1 .. array_length(tables, 1) LOOP
    SELECT pg_get_triggerdef(t.oid) INTO defn
      FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
     WHERE NOT t.tgisinternal AND c.relname = tables[i] AND t.tgname = trigs[i];

    IF defn IS NULL THEN
      RAISE EXCEPTION 'GUARD 2.5: trigger % is missing on %', trigs[i], tables[i];
    END IF;
    IF position('BEFORE INSERT OR UPDATE OF concept_id' IN defn) = 0 THEN
      RAISE EXCEPTION 'GUARD 2.5: % fires on the wrong events: %', trigs[i], defn;
    END IF;
    IF position('reject_deprecated_concept_mapping' IN defn) = 0 THEN
      RAISE EXCEPTION 'GUARD 2.5: % calls the wrong function: %', trigs[i], defn;
    END IF;
  END LOOP;

  -- The sibling guards must be untouched by this migration.
  SELECT count(*) INTO n
    FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
   WHERE NOT t.tgisinternal
     AND t.tgname IN ('question_concepts_protect', 'flashcard_concepts_protect',
                      'question_reasoning_objects_protect', 'question_concepts_content_only',
                      'question_reasoning_objects_reasoning_only');
  IF n <> 5 THEN
    RAISE EXCEPTION 'GUARD 2.5: expected the 5 sibling triggers to survive, found %', n;
  END IF;

  -- And no mapping may already be sitting on a deprecated concept, which would
  -- mean the invariant was violated before the guard existed to enforce it.
  SELECT count(*) INTO n FROM public.question_concepts m
    JOIN public.concepts c ON c.id = m.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'GUARD 2.5: % question mapping(s) already point at a deprecated concept', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts m
    JOIN public.concepts c ON c.id = m.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'GUARD 2.5: % flashcard mapping(s) already point at a deprecated concept', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects m
    JOIN public.concepts c ON c.id = m.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'GUARD 2.5: % reasoning mapping(s) already point at a deprecated concept', n; END IF;

  RAISE NOTICE 'GUARD 2.5 OK: 3 triggers now fire BEFORE INSERT OR UPDATE OF concept_id, 5 sibling triggers intact, 0 mappings on deprecated concepts.';
END $$;

COMMIT;
