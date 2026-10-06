-- ─── question_concepts.evidence_strength ──────────────────────────────────
-- REQUIRES: 20261006_03_lipid_split_governance.sql
-- because it classifies a row that governance migration marked HUMAN_VALIDATED.
--
-- A SECOND AXIS, NOT A SECOND OPINION. mapping_status answers "is this question
-- about this concept". evidence_strength answers "does getting it right
-- demonstrate independent mastery of that concept". A mapping can be correct,
-- human-validated, and still weak evidence, and until now there was nowhere to
-- say so.
--
-- THE CASE THAT FORCED IT, question cec05f2f, reviewed as row 27 of the lipid
-- split. It is correctly mapped to Lipoprotein Classes & Cholesterol Transport.
-- It is also unanswerable-proof: the stem states "because protein is denser
-- than lipid, a particle's density rises as its protein fraction rises", then
-- supplies 22% and 6%. Its own explanation says it requires "applying a stated
-- density-composition relationship to the supplied percentages rather than
-- recalling memorized particle densities". A learner can answer it correctly
-- knowing nothing whatever about lipoproteins.
--
-- UNREVIEWED IS ELIGIBLE, deliberately. All 2,694 existing mappings start there
-- because none has had this second review. Treating "not looked at" as "not
-- evidence" would delete the entire application axis to express a doubt.
--
-- HUMAN_VALIDATED DOES NOT IMPLY STANDARD. The two axes are independent and
-- nothing here infers one from the other: 7 rows are HUMAN_VALIDATED and all 7
-- remain UNREVIEWED on evidence strength, including the one being classified,
-- whose mapping review and evidence-strength review are separate events.
--
-- ─── THE ONE SCOPE DEVIATION, STATED PLAINLY ─────────────────────────────
--
-- Section 4 below amends protect_human_validated_mapping(). That is beyond the
-- "add columns and classify one row" scope, and it is unavoidable: the guard
-- currently refuses EVERY update to a HUMAN_VALIDATED row whose source is not
-- HUMAN_REVIEWED, not merely updates that change the mapping. Row 27 is
-- HUMAN_VALIDATED with source DETERMINISTIC_EXACT, so writing its
-- evidence_strength is refused outright. The probe in section 1 proves this
-- against live state rather than asserting it.
--
-- The amendment is the narrowest possible: an update is allowed through only
-- when EVERY pre-existing column is unchanged. Changing concept_id, role,
-- mapping_status, source, confidence, reviewed_at, reviewed_by, question_id or
-- created_at on a human-validated row still raises exactly as before, and
-- section 5 proves that too.
--
-- WRITES: question_concepts only, two new columns and one row classified.
-- No question, concept, flashcard, reasoning-object, learner or predictor data.

BEGIN;

-- ─── 0. Pre-conditions ───────────────────────────────────────────────────
DO $pre$
DECLARE n INT; st TEXT; src TEXT;
BEGIN
  SELECT count(*) INTO n FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'question_concepts'
     AND column_name IN ('evidence_strength', 'evidence_strength_set_at');
  IF n <> 0 THEN RAISE EXCEPTION 'evidence_strength columns already exist (% found)', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  IF n <> 1 THEN RAISE EXCEPTION 'row 27 must resolve to exactly one mapping, found %', n; END IF;

  SELECT mapping_status, source INTO st, src FROM public.question_concepts
   WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  IF st <> 'HUMAN_VALIDATED' THEN RAISE EXCEPTION 'row 27 is % not HUMAN_VALIDATED', st; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id
   WHERE qc.question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid
     AND qc.concept_id = '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid
     AND qc.role = 'PRIMARY'
     AND c.object_type = 'CONTENT' AND c.status = 'ACTIVE_SEED';
  IF n <> 1 THEN RAISE EXCEPTION 'row 27 does not match the reviewed manifest'; END IF;

  RAISE NOTICE 'pre-conditions hold: row 27 is % / %, mapped PRIMARY to an active CONTENT concept', st, src;
END $pre$;

-- ─── 1. Prove the guard currently blocks a metadata-only update ──────────
-- Not asserted from reading the trigger: demonstrated. The probe attempts a
-- no-op write and expects to be refused. If it ever succeeds, the amendment
-- below is unnecessary and this migration should be reconsidered.
DO $probe$
DECLARE blocked BOOLEAN := false;
BEGIN
  BEGIN
    UPDATE public.question_concepts SET created_at = created_at
     WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  EXCEPTION WHEN OTHERS THEN blocked := true;
  END;
  IF NOT blocked THEN
    RAISE EXCEPTION 'the guard did NOT block a no-op update; the amendment in section 4 is not needed and this migration must be re-reviewed';
  END IF;
  RAISE NOTICE 'confirmed: the current guard refuses even a no-op update to this row';
END $probe$;

-- ─── 2. The columns ──────────────────────────────────────────────────────
ALTER TABLE public.question_concepts
  ADD COLUMN IF NOT EXISTS evidence_strength TEXT NOT NULL DEFAULT 'UNREVIEWED',
  ADD COLUMN IF NOT EXISTS evidence_strength_set_at TIMESTAMPTZ;

ALTER TABLE public.question_concepts
  DROP CONSTRAINT IF EXISTS question_concepts_evidence_strength_check;
ALTER TABLE public.question_concepts
  ADD CONSTRAINT question_concepts_evidence_strength_check
  CHECK (evidence_strength IN ('UNREVIEWED', 'STANDARD', 'SELF_CONTAINED', 'RECOGNITION_ONLY'));

-- UNREVIEWED means nobody looked, so it cannot carry a review timestamp, and a
-- reviewed verdict cannot lack one. No subquery, so this is CHECK-legal.
ALTER TABLE public.question_concepts
  DROP CONSTRAINT IF EXISTS question_concepts_evidence_strength_stamp;
ALTER TABLE public.question_concepts
  ADD CONSTRAINT question_concepts_evidence_strength_stamp
  CHECK (
    (evidence_strength = 'UNREVIEWED' AND evidence_strength_set_at IS NULL)
    OR
    (evidence_strength IN ('STANDARD', 'SELF_CONTAINED', 'RECOGNITION_ONLY')
     AND evidence_strength_set_at IS NOT NULL)
  );

COMMENT ON COLUMN public.question_concepts.evidence_strength IS
  'How strongly this question demonstrates independent mastery of this concept. A SECOND AXIS, independent of mapping correctness: a mapping may be HUMAN_VALIDATED and still SELF_CONTAINED. UNREVIEWED means this pair has never had an evidence-strength review and is still counted as application evidence. SELF_CONTAINED and RECOGNITION_ONLY are excluded from concept-state scoring entirely, never fractionally weighted.';

COMMENT ON COLUMN public.question_concepts.evidence_strength_set_at IS
  'When the evidence-strength verdict was explicitly set by a human. NULL if and only if evidence_strength is UNREVIEWED, enforced by question_concepts_evidence_strength_stamp.';

-- ─── 3. Nothing is inferred from mapping_status ──────────────────────────
-- No bulk UPDATE appears in this file. Every one of the 2,694 rows, including
-- all 7 HUMAN_VALIDATED ones, takes UNREVIEWED from the column default.

-- ─── 4. The guard learns the difference between the two axes ─────────────
-- Unchanged for every governance column. The only new allowance is an update
-- that changes NO pre-existing column, which is what writing a second,
-- independent axis looks like.
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

  -- A write that leaves every pre-existing column alone is not an amendment of
  -- the human decision: it is a different axis being recorded beside it.
  IF OLD.mapping_status = 'HUMAN_VALIDATED'
     AND NEW.concept_id     IS NOT DISTINCT FROM OLD.concept_id
     AND NEW.role           IS NOT DISTINCT FROM OLD.role
     AND NEW.mapping_status IS NOT DISTINCT FROM OLD.mapping_status
     AND NEW.source         IS NOT DISTINCT FROM OLD.source
     AND NEW.confidence     IS NOT DISTINCT FROM OLD.confidence
     AND NEW.created_at     IS NOT DISTINCT FROM OLD.created_at
     AND NEW.reviewed_at    IS NOT DISTINCT FROM OLD.reviewed_at
     AND NEW.reviewed_by    IS NOT DISTINCT FROM OLD.reviewed_by
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

-- ─── 5. Prove the amended guard still refuses a real amendment ───────────
DO $bite$
DECLARE blocked BOOLEAN := false;
BEGIN
  BEGIN
    UPDATE public.question_concepts SET role = 'SECONDARY'
     WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  EXCEPTION WHEN OTHERS THEN blocked := true;
  END;
  IF NOT blocked THEN
    RAISE EXCEPTION 'the amended guard let a role change through; it has been weakened and must not ship';
  END IF;

  blocked := false;
  BEGIN
    UPDATE public.question_concepts SET mapping_status = 'AI_PROPOSED'
     WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  EXCEPTION WHEN OTHERS THEN blocked := true;
  END;
  IF NOT blocked THEN
    RAISE EXCEPTION 'the amended guard let a mapping_status change through';
  END IF;

  RAISE NOTICE 'the amended guard still refuses role and mapping_status changes';
END $bite$;

-- ─── 6. The one human evidence-strength decision ─────────────────────────
-- Row 27 of the lipid split review. Touches only the two new columns, so the
-- mapping's own history, its reviewer and its provenance are untouched.
UPDATE public.question_concepts
   SET evidence_strength = 'SELF_CONTAINED',
       evidence_strength_set_at = now()
 WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid
   AND concept_id  = '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid
   AND evidence_strength = 'UNREVIEWED';

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $post$
DECLARE n INT; r RECORD;
BEGIN
  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength IS NULL;
  IF n <> 0 THEN RAISE EXCEPTION '% rows have a null evidence_strength', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength = 'SELF_CONTAINED';
  IF n <> 1 THEN RAISE EXCEPTION 'expected exactly 1 SELF_CONTAINED mapping, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength = 'STANDARD';
  IF n <> 0 THEN RAISE EXCEPTION 'expected 0 STANDARD mappings, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE evidence_strength = 'RECOGNITION_ONLY';
  IF n <> 0 THEN RAISE EXCEPTION 'expected 0 RECOGNITION_ONLY mappings, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE evidence_strength = 'UNREVIEWED' AND evidence_strength_set_at IS NOT NULL;
  IF n <> 0 THEN RAISE EXCEPTION '% unreviewed rows carry a review timestamp', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE evidence_strength <> 'UNREVIEWED' AND evidence_strength_set_at IS NULL;
  IF n <> 0 THEN RAISE EXCEPTION '% reviewed rows lack a review timestamp', n; END IF;

  -- The classified row kept every governance field it had.
  SELECT * INTO r FROM public.question_concepts
   WHERE question_id = 'cec05f2f-6d03-449e-ae09-2592c6717821'::uuid;
  IF r.concept_id <> '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid
     OR r.role <> 'PRIMARY'
     OR r.mapping_status <> 'HUMAN_VALIDATED'
     OR r.source <> 'DETERMINISTIC_EXACT'
     OR r.evidence_strength <> 'SELF_CONTAINED'
     OR r.evidence_strength_set_at IS NULL
  THEN
    RAISE EXCEPTION 'row 27 did not classify cleanly: % / % / % / %',
      r.role, r.mapping_status, r.source, r.evidence_strength;
  END IF;

  -- Human validation still implies nothing about evidence strength.
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED' AND evidence_strength = 'STANDARD';
  IF n <> 0 THEN RAISE EXCEPTION '% human-validated rows were inferred to be STANDARD', n; END IF;

  RAISE NOTICE 'evidence_strength live: 1 SELF_CONTAINED, the rest UNREVIEWED, governance fields intact';
END $post$;

COMMIT;
