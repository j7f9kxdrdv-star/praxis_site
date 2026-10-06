-- ─── Hardening the HUMAN_VALIDATED guard against future columns ───────────
-- REQUIRES: 20261006_05_question_concepts_evidence_strength.sql
-- because it hardens the exception that migration introduced.
--
-- WHAT WAS WRONG. Step 4 taught the guard that a write touching only
-- evidence_strength is not an amendment of a human decision. It expressed that
-- by listing every column that existed at the time and requiring each to be
-- unchanged. Correct on the day, and quietly wrong afterwards: a column added
-- to question_concepts tomorrow is not in the list, so a HUMAN_VALIDATED row
-- could be changed in that new column while every listed field stayed put. The
-- exception would silently widen each time the table grows.
--
-- THE FIX IS TO INVERT THE QUESTION. Instead of naming what must not change,
-- name what MAY change, and compare everything else as a whole row:
--
--   to_jsonb(NEW) - 'evidence_strength' - 'evidence_strength_set_at'
--     IS NOT DISTINCT FROM
--   to_jsonb(OLD) - 'evidence_strength' - 'evidence_strength_set_at'
--
-- Every current and future column outside those two is protected by default,
-- which is the right default for a governance guard. Adding a column now
-- requires a deliberate decision to exempt it, rather than exempting it by
-- forgetting.
--
-- WHY jsonb AND NOT A COLUMN LIST FROM information_schema. A catalogue lookup
-- per row would be slow and would still need the list maintained somewhere.
-- to_jsonb(NEW) is the whole row as it stands, computed by the server, with no
-- list to drift.
--
-- SAFE FOR BOTH TABLES. This function is shared by question_concepts and
-- flashcard_concepts, and flashcard_concepts has no evidence-strength columns.
-- Subtracting an absent key from jsonb is a no-op, so the comparison there is a
-- plain whole-row equality, exactly the behaviour it had before Step 4.
--
-- NOT A HISTORY REWRITE. 20261006_05 stays exactly as it ran. This is a
-- follow-up that replaces one function.
--
-- WRITES: none. It replaces a function and proves its behaviour with probes
-- that all roll back.

BEGIN;

-- ─── 0. Pre-conditions ───────────────────────────────────────────────────
DO $pre$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'question_concepts'
     AND column_name IN ('evidence_strength', 'evidence_strength_set_at');
  IF n <> 2 THEN RAISE EXCEPTION 'step 4 has not been applied: % evidence columns found', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid
     AND evidence_strength = 'SELF_CONTAINED'
     AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 1 THEN RAISE EXCEPTION 'row 27 is not in its expected post-step-4 state'; END IF;

  RAISE NOTICE 'pre-conditions hold: step 4 applied, row 27 classified';
END $pre$;

-- ─── 1. The hardened guard ───────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.protect_human_validated_mapping()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    IF OLD.mapping_status = 'HUMAN_VALIDATED' THEN
      RAISE EXCEPTION
        'Refusing to delete a HUMAN_VALIDATED mapping (%). Human review is authoritative; record disagreement as a new NEEDS_REVIEW row instead.',
        TG_TABLE_NAME;
    END IF;
    RETURN OLD;
  END IF;

  -- THE ONLY EXCEPTION, STATED AS WHAT MAY MOVE RATHER THAN WHAT MAY NOT.
  -- Evidence strength is a second axis: it says how strongly an item tests a
  -- concept, not whether the mapping is right. A write that moves only those
  -- two fields amends no human decision. Anything else, in any column that
  -- exists now or is added later, falls through to the refusal below.
  IF OLD.mapping_status = 'HUMAN_VALIDATED'
     AND (to_jsonb(NEW) - 'evidence_strength' - 'evidence_strength_set_at')
         IS NOT DISTINCT FROM
         (to_jsonb(OLD) - 'evidence_strength' - 'evidence_strength_set_at')
  THEN
    RETURN NEW;
  END IF;

  IF OLD.mapping_status = 'HUMAN_VALIDATED' AND NEW.source <> 'HUMAN_REVIEWED' THEN
    RAISE EXCEPTION
      'Refusing to overwrite a HUMAN_VALIDATED mapping (%) from source %. Only a HUMAN_REVIEWED write may amend a human decision.',
      TG_TABLE_NAME, NEW.source;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ─── 2. Negative fixtures: every governance column still refuses ─────────
-- Each probe attempts a real change and then raises PROBE_LEAKED, so a change
-- the guard WRONGLY allows is rolled back by its own subtransaction rather than
-- left in the table. A guard that works swallows the probe before that point.
DO $neg$
DECLARE leaked TEXT[] := ARRAY[]::TEXT[];
  qid UUID := 'cec05f2f-6d03-449e-ae09-2592c6717821';
BEGIN
  BEGIN
    UPDATE public.question_concepts SET concept_id = 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'concept_id'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET role = 'SECONDARY' WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'role'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET mapping_status = 'AI_PROPOSED' WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'mapping_status'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET source = 'AI_PROPOSED' WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'source'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET confidence = 0.25 WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'confidence'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET created_at = now() WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'created_at'; END IF;
  END;

  BEGIN
    UPDATE public.question_concepts SET reviewed_at = now() WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'reviewed_at'; END IF;
  END;

  -- reviewed_by is NULL on every row, so this is the null-safe case: a naive
  -- equality comparison would have treated NULL vs a uuid as "not different".
  BEGIN
    UPDATE public.question_concepts SET reviewed_by = gen_random_uuid() WHERE question_id = qid;
    RAISE EXCEPTION 'PROBE_LEAKED';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'PROBE_LEAKED' THEN leaked := leaked || 'reviewed_by'; END IF;
  END;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'the hardened guard ALLOWED changes to: %. It is weaker than the one it replaces and must not ship.',
      array_to_string(leaked, ', ');
  END IF;
  RAISE NOTICE 'all 8 governance columns still refuse a non-HUMAN_REVIEWED write';
END $neg$;

-- ─── 3. Positive fixtures: the two paths that must still work ────────────
DO $pos$
DECLARE allowed BOOLEAN; qid UUID := 'cec05f2f-6d03-449e-ae09-2592c6717821';
BEGIN
  -- (a) An evidence-strength-only write passes.
  allowed := false;
  BEGIN
    UPDATE public.question_concepts
       SET evidence_strength = 'RECOGNITION_ONLY', evidence_strength_set_at = now()
     WHERE question_id = qid;
    allowed := true;
    RAISE EXCEPTION 'PROBE_ROLLBACK';
  EXCEPTION WHEN OTHERS THEN
    IF SQLERRM <> 'PROBE_ROLLBACK' THEN allowed := false; END IF;
  END;
  IF NOT allowed THEN
    RAISE EXCEPTION 'the hardened guard refuses an evidence-strength-only write, which is the one thing it must permit';
  END IF;

  -- (b) The original governance path, a deliberate HUMAN_REVIEWED amendment,
  --     still works exactly as before.
  allowed := false;
  BEGIN
    UPDATE public.question_concepts
       SET source = 'HUMAN_REVIEWED', confidence = 0.9
     WHERE question_id = qid;
    allowed := true;
    RAISE EXCEPTION 'PROBE_ROLLBACK';
  EXCEPTION WHEN OTHERS THEN
    IF SQLERRM <> 'PROBE_ROLLBACK' THEN allowed := false; END IF;
  END;
  IF NOT allowed THEN
    RAISE EXCEPTION 'the hardened guard broke the established HUMAN_REVIEWED amendment path';
  END IF;

  RAISE NOTICE 'evidence-only writes and HUMAN_REVIEWED amendments both still work';
END $pos$;

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $post$
DECLARE n INT; r RECORD;
BEGIN
  -- Every probe rolled back: the row is exactly as Step 4 left it.
  SELECT * INTO r FROM public.question_concepts
   WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  IF r.concept_id <> '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid
     OR r.role <> 'PRIMARY' OR r.mapping_status <> 'HUMAN_VALIDATED'
     OR r.source <> 'DETERMINISTIC_EXACT' OR r.confidence <> 1
     OR r.reviewed_by IS NOT NULL
     OR r.evidence_strength <> 'SELF_CONTAINED' OR r.evidence_strength_set_at IS NULL
  THEN
    RAISE EXCEPTION 'a probe leaked into row 27: % / % / % / %',
      r.role, r.mapping_status, r.source, r.evidence_strength;
  END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength = 'SELF_CONTAINED';
  IF n <> 1 THEN RAISE EXCEPTION 'expected 1 SELF_CONTAINED row, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength = 'RECOGNITION_ONLY';
  IF n <> 0 THEN RAISE EXCEPTION 'a probe left % RECOGNITION_ONLY rows behind', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE source = 'HUMAN_REVIEWED';
  IF n <> 0 THEN RAISE EXCEPTION 'a probe left % HUMAN_REVIEWED rows behind', n; END IF;

  -- The two axes stay independent: nothing here couples them in either direction.
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED';
  IF n <> 7 THEN RAISE NOTICE 'human-validated row count is % (was 7)', n; END IF;

  RAISE NOTICE 'guard hardened, every probe rolled back, row 27 untouched';
END $post$;

COMMIT;
