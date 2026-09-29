-- ============================================================
-- Migration 1 of 3: the question-to-reasoning relation, schema only
--
-- No data. Seeding RO_DATA_INTERPRETATION is migration 2, and the 24 approved
-- mappings are migration 3. Split so a schema problem cannot corrupt data and a
-- mapping problem cannot force a schema rollback.
--
-- WHY A SEPARATE TABLE. question_concepts answers exactly one question, "which
-- CONTENT concept does this question test", and a trigger already refuses
-- anything else. Reasoning demand is a different axis: a question can test
-- Starling forces AND require reading a table, and those are not competing
-- answers to one question. Reusing question_concepts would destroy the meaning
-- the existing trigger protects.
--
-- NO ROLE COLUMN. question_concepts carries PRIMARY and SECONDARY because
-- content identity is singular, enforced by a one-primary index. Reasoning is
-- not like that: two operations can be required without either being
-- subordinate. None of the 24 approved mappings needs two objects, so a role
-- column would be unused ceremony added against a future that may not arrive.
-- The composite primary key already prevents duplicates, and a second operation
-- is simply a second row.
--
-- GOVERNANCE IS REUSED, NOT REWRITTEN. protect_human_validated_mapping() reads
-- TG_TABLE_NAME and reject_deprecated_concept_mapping() reads NEW.concept_id,
-- so both existing functions attach to this table unchanged. Only the
-- object-type guard is new, and it mirrors question_concepts_content_only().
--
-- VOCABULARY IS REUSED. mapping_status and source take the same values and the
-- same constraints as the two existing mapping tables, including
-- DETERMINISTIC_EXACT, rather than inventing a second governance vocabulary.
-- confidence carries the same NUMERIC(3,2) zero-to-one domain, so a meaningless
-- number cannot be stored.
--
-- TOUCHES NOTHING ELSE. No existing table is read or written. question_concepts,
-- questions, flashcard_concepts, flashcards and every learner table are
-- untouched.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The table.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.question_reasoning_objects (
  question_id    UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  concept_id     UUID NOT NULL REFERENCES public.concepts(id)  ON DELETE CASCADE,
  confidence     NUMERIC(3,2) CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1)),
  mapping_status TEXT NOT NULL DEFAULT 'AI_PROPOSED' CHECK (mapping_status IN (
                   'AI_PROPOSED','DETERMINISTIC','HUMAN_VALIDATED','NEEDS_REVIEW')),
  source         TEXT NOT NULL CHECK (source IN (
                   'LEGACY_EXACT','DETERMINISTIC','DETERMINISTIC_EXACT','AI_PROPOSED','HUMAN_REVIEWED')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at    TIMESTAMPTZ,
  reviewed_by    UUID,
  PRIMARY KEY (question_id, concept_id)
);

COMMENT ON TABLE public.question_reasoning_objects IS
  'Which reusable REASONING operation does solving this question require? Separate from question_concepts, which answers which CONTENT concept the question tests. Flat many-to-many: a question may require more than one operation, and none is subordinate.';

-- The primary key indexes question_id first. The question this table exists to
-- answer in the other direction, "which questions require this operation", needs
-- concept_id leading.
CREATE INDEX IF NOT EXISTS question_reasoning_objects_concept_idx
  ON public.question_reasoning_objects (concept_id);

-- ────────────────────────────────────────────────────────────
-- 2. Object-type guard. The mirror of question_concepts_content_only().
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.question_reasoning_objects_reasoning_only()
RETURNS TRIGGER AS $$
DECLARE t TEXT;
BEGIN
  SELECT object_type INTO t FROM public.concepts WHERE id = NEW.concept_id;
  IF t IS DISTINCT FROM 'REASONING' THEN
    RAISE EXCEPTION
      'question_reasoning_objects answers "which REASONING operation does this question require". Concept % is %. A CONTENT concept belongs in question_concepts, and a QUANTITATIVE tool is a third axis with no relation of its own yet.',
      NEW.concept_id, t;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS question_reasoning_objects_reasoning_only ON public.question_reasoning_objects;
CREATE TRIGGER question_reasoning_objects_reasoning_only
  BEFORE INSERT OR UPDATE ON public.question_reasoning_objects
  FOR EACH ROW EXECUTE FUNCTION public.question_reasoning_objects_reasoning_only();

-- ────────────────────────────────────────────────────────────
-- 3. Existing governance, attached unchanged.
-- ────────────────────────────────────────────────────────────
DROP TRIGGER IF EXISTS question_reasoning_objects_no_deprecated ON public.question_reasoning_objects;
CREATE TRIGGER question_reasoning_objects_no_deprecated
  BEFORE INSERT ON public.question_reasoning_objects
  FOR EACH ROW EXECUTE FUNCTION public.reject_deprecated_concept_mapping();

DROP TRIGGER IF EXISTS question_reasoning_objects_protect ON public.question_reasoning_objects;
CREATE TRIGGER question_reasoning_objects_protect
  BEFORE UPDATE OR DELETE ON public.question_reasoning_objects
  FOR EACH ROW EXECUTE FUNCTION public.protect_human_validated_mapping();

-- ────────────────────────────────────────────────────────────
-- 4. RLS, the reference-data pattern used by every taxonomy table:
--    readable by any authenticated user, written only by service_role.
-- ────────────────────────────────────────────────────────────
ALTER TABLE public.question_reasoning_objects ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "read taxonomy" ON public.question_reasoning_objects;
CREATE POLICY "read taxonomy" ON public.question_reasoning_objects
  FOR SELECT USING (auth.role() = 'authenticated');

-- ────────────────────────────────────────────────────────────
-- 5. Prove the guards guard.
--
--    A trigger that has never rejected anything is not known to work. Each block
--    attempts a write that MUST fail and raises if it succeeds. Everything here
--    runs against real rows and is undone by the savepoint, so the table is
--    still empty at COMMIT.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE
  qid   UUID;
  cont  UUID;
  quant UUID;
  reas  UUID;
  ok    BOOLEAN;
BEGIN
  SELECT id INTO qid   FROM public.questions LIMIT 1;
  SELECT id INTO cont  FROM public.concepts WHERE object_type = 'CONTENT'      AND status = 'ACTIVE_SEED' LIMIT 1;
  SELECT id INTO quant FROM public.concepts WHERE object_type = 'QUANTITATIVE' LIMIT 1;
  SELECT id INTO reas  FROM public.concepts WHERE object_type = 'REASONING'    LIMIT 1;
  IF qid IS NULL OR cont IS NULL OR quant IS NULL OR reas IS NULL THEN
    RAISE EXCEPTION 'fixture rows missing: cannot prove the guards';
  END IF;

  -- (a) a CONTENT concept must be refused
  ok := false;
  BEGIN
    INSERT INTO public.question_reasoning_objects (question_id, concept_id, source)
    VALUES (qid, cont, 'AI_PROPOSED');
  EXCEPTION WHEN OTHERS THEN ok := true;
  END;
  IF NOT ok THEN RAISE EXCEPTION 'guard failed: a CONTENT concept was accepted'; END IF;

  -- (b) a QUANTITATIVE concept must be refused
  ok := false;
  BEGIN
    INSERT INTO public.question_reasoning_objects (question_id, concept_id, source)
    VALUES (qid, quant, 'AI_PROPOSED');
  EXCEPTION WHEN OTHERS THEN ok := true;
  END;
  IF NOT ok THEN RAISE EXCEPTION 'guard failed: a QUANTITATIVE concept was accepted'; END IF;

  -- (c) a REASONING concept must be ACCEPTED, or the guard is simply refusing
  --     everything and proves nothing.
  SAVEPOINT probe;
  INSERT INTO public.question_reasoning_objects (question_id, concept_id, source)
  VALUES (qid, reas, 'AI_PROPOSED');

  -- (d) a HUMAN_VALIDATED row must refuse an automated overwrite and a delete
  UPDATE public.question_reasoning_objects
    SET mapping_status = 'HUMAN_VALIDATED', source = 'HUMAN_REVIEWED'
    WHERE question_id = qid AND concept_id = reas;

  ok := false;
  BEGIN
    UPDATE public.question_reasoning_objects SET source = 'AI_PROPOSED'
      WHERE question_id = qid AND concept_id = reas;
  EXCEPTION WHEN OTHERS THEN ok := true;
  END;
  IF NOT ok THEN RAISE EXCEPTION 'guard failed: a HUMAN_VALIDATED row was overwritten by an automated source'; END IF;

  ok := false;
  BEGIN
    DELETE FROM public.question_reasoning_objects WHERE question_id = qid AND concept_id = reas;
  EXCEPTION WHEN OTHERS THEN ok := true;
  END;
  IF NOT ok THEN RAISE EXCEPTION 'guard failed: a HUMAN_VALIDATED row was deleted'; END IF;

  -- (e) confidence outside zero to one must be refused
  ok := false;
  BEGIN
    INSERT INTO public.question_reasoning_objects (question_id, concept_id, source, confidence)
    VALUES (qid, reas, 'AI_PROPOSED', 4.00);
  EXCEPTION WHEN OTHERS THEN ok := true;
  END;
  IF NOT ok THEN RAISE EXCEPTION 'guard failed: confidence 4.00 was accepted'; END IF;

  ROLLBACK TO SAVEPOINT probe;
  RAISE NOTICE 'all five guards proved';
END $$;

-- ────────────────────────────────────────────────────────────
-- 6. Verification. The table exists, is empty, and carries its three triggers.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> 0 THEN RAISE EXCEPTION 'schema migration must leave the table empty, found % rows', n; END IF;

  SELECT count(*) INTO n FROM pg_trigger
    WHERE tgrelid = 'public.question_reasoning_objects'::regclass AND NOT tgisinternal;
  IF n <> 3 THEN RAISE EXCEPTION 'expected 3 triggers, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2673 THEN RAISE EXCEPTION 'question_concepts was touched: %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4115 THEN RAISE EXCEPTION 'flashcard_concepts was touched: %', n; END IF;
END $$;

SELECT tgname AS trigger_name FROM pg_trigger
WHERE tgrelid = 'public.question_reasoning_objects'::regclass AND NOT tgisinternal
ORDER BY 1;

COMMIT;
