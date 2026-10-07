-- ─── flashcard_concepts.cloze_indices: which blanks test which concept ────
-- REQUIRES: 20261006_06_human_validated_guard_hardening.sql
-- because it extends the exemption that migration established.
--
-- THE PROBLEM. Mappings are card-level; FSRS state is cloze-level. On a card
-- that maps to two concepts and whose two blanks test different things, the
-- weakest-cloze rule hands one concept's failure to the other. Live example,
-- card b393432e:
--
--   "The fatty acids packaged into VLDL come from excess dietary {{c1::glucose}}
--    ... plus fatty acids retrieved from {{c2::chylomicron remnants}}."
--
-- c1 is de novo lipogenesis; c2 is the lipoprotein cycle. Without scope, a
-- learner who keeps failing the glucose blank drags down their state on
-- Lipoprotein Classes, a concept that blank does not test.
--
-- NULL MEANS ALL CLOZES, and stays the normal case: 4,119 of 4,123 mappings
-- need no scope and get no row written. An explicit array restricts the
-- evidence to those blanks and nothing else.
--
-- THIS CHANGES EVIDENCE ATTRIBUTION, NOT SCHEDULING. The scheduler keeps its
-- own state on (flashcard_id, cloze_index) exactly as before. No review is
-- reset, no card is duplicated, no memory is weighted fractionally.
--
-- ONLY TWO CARDS NEED IT, confirmed by re-auditing all five multi-concept
-- cards rather than trusting the earlier report. The other three keep NULL
-- because every blank genuinely bears on every mapped concept: collagen and
-- keratin are both structural proteins and tissue components, and on the
-- HSL/LPL card c1 hides BOTH enzymes and c2 hides BOTH locations, so no split
-- is even expressible.
--
-- WRITES: flashcard_concepts, one new column and 4 rows scoped. No flashcard
-- content, no scheduler state, no review, no question_concepts, no concept.

BEGIN;

-- ─── 0. Pre-conditions ───────────────────────────────────────────────────
DO $pre$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'flashcard_concepts'
     AND column_name = 'cloze_indices';
  IF n <> 0 THEN RAISE EXCEPTION 'cloze_indices already exists'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id IN ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid,
                          '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid)
     AND concept_id IN ('2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid,
                        '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid)
     AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 4 THEN RAISE EXCEPTION 'expected 4 human-validated target mappings, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcards
   WHERE id IN ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid,
                '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid)
     AND cloze_count = 2;
  IF n <> 2 THEN RAISE EXCEPTION 'both target cards must still have exactly 2 clozes'; END IF;

  RAISE NOTICE 'pre-conditions hold: 4 human-validated target mappings on 2 two-cloze cards';
END $pre$;

-- ─── 1. The column ───────────────────────────────────────────────────────
ALTER TABLE public.flashcard_concepts
  ADD COLUMN IF NOT EXISTS cloze_indices INT[];

COMMENT ON COLUMN public.flashcard_concepts.cloze_indices IS
  'Which clozes on this card provide memory evidence for THIS concept. NULL means all valid clozes, and is the normal case. An explicit ascending array restricts evidence to those blanks only, for a card whose blanks test different concepts. This changes EVIDENCE ATTRIBUTION only: scheduler and review state stay attached to (flashcard_id, cloze_index) and are untouched by it. Validated by validate_cloze_indices() on write and by protect_scoped_cloze_mappings() when the parent card is edited.';

-- ─── 2. Mapping-side validation ──────────────────────────────────────────
-- A CHECK cannot do this: validity depends on the referenced flashcard, which
-- a CHECK may not read. Hence a trigger.
--
-- CANONICAL ORDER IS REQUIRED, NOT IMPOSED. [2,1] is rejected rather than
-- silently sorted. Ordering carries no meaning, so two spellings of the same
-- scope must not both be storable; and an author who wrote them out of order
-- may have meant something else, so the write should stop rather than be
-- quietly rewritten. Duplicates are rejected for the same reason.
CREATE OR REPLACE FUNCTION public.validate_cloze_indices()
RETURNS TRIGGER AS $$
DECLARE n INT; cc INT; worst INT;
BEGIN
  IF NEW.cloze_indices IS NULL THEN
    RETURN NEW;                              -- all clozes: nothing to validate
  END IF;

  n := array_length(NEW.cloze_indices, 1);
  IF n IS NULL OR n = 0 THEN
    RAISE EXCEPTION 'cloze_indices may not be an empty array. Use NULL to mean all clozes.';
  END IF;

  IF array_position(NEW.cloze_indices, NULL) IS NOT NULL THEN
    RAISE EXCEPTION 'cloze_indices may not contain NULL elements.';
  END IF;

  IF EXISTS (SELECT 1 FROM unnest(NEW.cloze_indices) AS x WHERE x < 1) THEN
    RAISE EXCEPTION 'cloze_indices must be >= 1; clozes are 1-based.';
  END IF;

  IF (SELECT count(DISTINCT x) FROM unnest(NEW.cloze_indices) AS x) <> n THEN
    RAISE EXCEPTION 'cloze_indices contains a duplicate index. That is an authoring error, not a scope.';
  END IF;

  IF NEW.cloze_indices IS DISTINCT FROM
     (SELECT array_agg(x ORDER BY x) FROM unnest(NEW.cloze_indices) AS x) THEN
    RAISE EXCEPTION 'cloze_indices must be stored in ascending order so one scope has one representation.';
  END IF;

  SELECT cloze_count INTO cc FROM public.flashcards WHERE id = NEW.flashcard_id;
  IF cc IS NULL THEN
    RAISE EXCEPTION 'cloze_indices set on a mapping whose flashcard % does not exist.', NEW.flashcard_id;
  END IF;

  SELECT max(x) INTO worst FROM unnest(NEW.cloze_indices) AS x WHERE x > cc;
  IF worst IS NOT NULL THEN
    RAISE EXCEPTION 'cloze_indices references cloze % but flashcard % has only % cloze(s).',
      worst, NEW.flashcard_id, cc;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Fires on INSERT and on every UPDATE. Validating whenever a scope is present
-- also covers the case your brief singles out: a mapping MOVED to a different
-- flashcard on which its indices no longer exist.
DROP TRIGGER IF EXISTS flashcard_concepts_validate_cloze_scope ON public.flashcard_concepts;
CREATE TRIGGER flashcard_concepts_validate_cloze_scope
BEFORE INSERT OR UPDATE ON public.flashcard_concepts
FOR EACH ROW EXECUTE FUNCTION public.validate_cloze_indices();

-- ─── 3. Parent-side protection ───────────────────────────────────────────
-- A mapping-side trigger alone is not enough. A scope of [2] is valid today and
-- becomes a dangling reference the moment an author rewrites the card down to
-- one cloze, because no row in flashcard_concepts was touched and nothing fired.
--
-- The card edit is REFUSED. The scope is not nulled, the mapping is not
-- deleted, and no scheduler state is reset: all three would silently discard a
-- human decision to make an unrelated edit succeed. An author who genuinely
-- means to change what the blanks test must update the concept scope first.
CREATE OR REPLACE FUNCTION public.protect_scoped_cloze_mappings()
RETURNS TRIGGER AS $$
DECLARE offending TEXT;
BEGIN
  IF NEW.cloze_count IS NOT DISTINCT FROM OLD.cloze_count
     AND NEW.cloze_text IS NOT DISTINCT FROM OLD.cloze_text THEN
    RETURN NEW;                              -- nothing cloze-bearing changed
  END IF;

  SELECT string_agg(format('concept %s scoped [%s]', fc.concept_id,
                           array_to_string(fc.cloze_indices, ',')), '; ')
    INTO offending
    FROM public.flashcard_concepts fc
   WHERE fc.flashcard_id = NEW.id
     AND fc.cloze_indices IS NOT NULL
     AND EXISTS (SELECT 1 FROM unnest(fc.cloze_indices) AS x WHERE x > NEW.cloze_count);

  IF offending IS NOT NULL THEN
    RAISE EXCEPTION
      'Refusing to edit flashcard %: it would leave concept mappings scoped to clozes that no longer exist (%). Update the concept scope deliberately, then edit the card.',
      NEW.id, offending;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS flashcards_protect_scoped_cloze_mappings ON public.flashcards;
CREATE TRIGGER flashcards_protect_scoped_cloze_mappings
BEFORE UPDATE ON public.flashcards
FOR EACH ROW EXECUTE FUNCTION public.protect_scoped_cloze_mappings();

-- ─── 4. The shared guard learns a SECOND, TABLE-SPECIFIC exemption ───────
-- Step 4b exempted the evidence-strength columns from the HUMAN_VALIDATED
-- refusal. All four rows being scoped here are HUMAN_VALIDATED, so cloze_indices
-- needs the same treatment, and the probe in section 5 proves it.
--
-- THE EXEMPTION IS PER TABLE, DELIBERATELY. Subtracting all three keys for both
-- tables would mean a future question_concepts.cloze_indices, or a future
-- flashcard_concepts.evidence_strength, became unprotected the day it was added,
-- without anyone deciding that. TG_TABLE_NAME keeps each table's exemption to
-- the columns actually reviewed for it.
CREATE OR REPLACE FUNCTION public.protect_human_validated_mapping()
RETURNS TRIGGER AS $$
DECLARE exempt TEXT[];
BEGIN
  IF TG_OP = 'DELETE' THEN
    IF OLD.mapping_status = 'HUMAN_VALIDATED' THEN
      RAISE EXCEPTION
        'Refusing to delete a HUMAN_VALIDATED mapping (%). Human review is authoritative; record disagreement as a new NEEDS_REVIEW row instead.',
        TG_TABLE_NAME;
    END IF;
    RETURN OLD;
  END IF;

  exempt := CASE TG_TABLE_NAME
    WHEN 'question_concepts'  THEN ARRAY['evidence_strength', 'evidence_strength_set_at']
    WHEN 'flashcard_concepts' THEN ARRAY['cloze_indices']
    ELSE ARRAY[]::TEXT[]
  END;

  IF OLD.mapping_status = 'HUMAN_VALIDATED'
     AND (to_jsonb(NEW) - exempt) IS NOT DISTINCT FROM (to_jsonb(OLD) - exempt)
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

-- ─── 5. The four reviewed scopes ─────────────────────────────────────────
-- b393432e: c1 = glucose, de novo lipogenesis.    c2 = chylomicron remnants.
-- 7d0c69e5: c1 = LDL, receptor-mediated uptake.   c2 = de novo synthesis.
-- Governance fields are untouched: only cloze_indices moves.
UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[1]
 WHERE flashcard_id = 'b393432e-665c-47fc-9b13-c66af880a80d'::uuid
   AND concept_id   = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid;   -- Synthesis

UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[2]
 WHERE flashcard_id = 'b393432e-665c-47fc-9b13-c66af880a80d'::uuid
   AND concept_id   = '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid;   -- Transport

UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[1]
 WHERE flashcard_id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid
   AND concept_id   = '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid;   -- Transport

UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[2]
 WHERE flashcard_id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid
   AND concept_id   = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid;   -- Synthesis

-- ─── 6. Invalid scopes are refused ───────────────────────────────────────
DO $invalid$
DECLARE leaked TEXT[] := ARRAY[]::TEXT[];
  fid UUID := 'b393432e-665c-47fc-9b13-c66af880a80d';
  cid UUID := '066ad4c3-e5b1-49b4-b8a2-951a8f721eed';
BEGIN
  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[]::INT[]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'empty array'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[0]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'zero index'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[-1]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'negative index'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[1, 1]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'duplicate index'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[3]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'index beyond cloze_count'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[2, 1]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'descending order'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[NULL]::INT[]
         WHERE flashcard_id = fid AND concept_id = cid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'null element'); END IF; END;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'the scope validator ACCEPTED invalid input: %', array_to_string(leaked, ', ');
  END IF;
  RAISE NOTICE 'all 7 invalid scopes refused';
END $invalid$;

-- ─── 7. Valid scopes are accepted ────────────────────────────────────────
DO $valid$
DECLARE okd BOOLEAN;
  fid UUID := 'b393432e-665c-47fc-9b13-c66af880a80d';
  cid UUID := '066ad4c3-e5b1-49b4-b8a2-951a8f721eed';
BEGIN
  okd := false;
  BEGIN
    UPDATE public.flashcard_concepts SET cloze_indices = ARRAY[1, 2]
     WHERE flashcard_id = fid AND concept_id = cid;
    okd := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN okd := false; END IF; END;
  IF NOT okd THEN RAISE EXCEPTION 'a valid multi-index scope [1,2] was refused'; END IF;

  okd := false;
  BEGIN
    UPDATE public.flashcard_concepts SET cloze_indices = NULL
     WHERE flashcard_id = fid AND concept_id = cid;
    okd := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN okd := false; END IF; END;
  IF NOT okd THEN RAISE EXCEPTION 'NULL, meaning all clozes, was refused'; END IF;

  RAISE NOTICE 'a valid [1,2] scope and NULL are both accepted';
END $valid$;

-- ─── 8. Parent-card edits ────────────────────────────────────────────────
DO $parent$
DECLARE blocked BOOLEAN; allowed BOOLEAN;
  fid UUID := 'b393432e-665c-47fc-9b13-c66af880a80d';
BEGIN
  -- Reducing cloze_count below a scoped index is refused.
  blocked := false;
  BEGIN UPDATE public.flashcards SET cloze_count = 1 WHERE id = fid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'LEAK' THEN blocked := true; END IF; END;
  IF NOT blocked THEN RAISE EXCEPTION 'reducing cloze_count below a scoped index was allowed'; END IF;

  -- Increasing it does not invalidate anything.
  allowed := false;
  BEGIN UPDATE public.flashcards SET cloze_count = 3 WHERE id = fid;
        allowed := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN allowed := false; END IF; END;
  IF NOT allowed THEN RAISE EXCEPTION 'increasing cloze_count was wrongly refused'; END IF;

  -- An edit that touches nothing cloze-bearing is untouched by the guard.
  allowed := false;
  BEGIN UPDATE public.flashcards SET explanation = coalesce(explanation, '') WHERE id = fid;
        allowed := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN allowed := false; END IF; END;
  IF NOT allowed THEN RAISE EXCEPTION 'an unrelated card edit was wrongly refused'; END IF;

  -- A NULL-scoped card is unaffected by the same shrink.
  allowed := false;
  BEGIN UPDATE public.flashcards SET cloze_count = 1
         WHERE id = 'ca5f08a7-3bc2-493b-8e82-dd2835e122f0'::uuid;
        allowed := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN allowed := false; END IF; END;
  IF NOT allowed THEN RAISE EXCEPTION 'a NULL-scoped card was wrongly protected'; END IF;

  RAISE NOTICE 'parent-edit guard: shrink refused, growth allowed, unrelated edits and NULL scopes unaffected';
END $parent$;

-- ─── 9. The HUMAN_VALIDATED guard, both tables ───────────────────────────
DO $guard$
DECLARE leaked TEXT[] := ARRAY[]::TEXT[]; okd BOOLEAN;
  qid UUID := 'cec05f2f-6d03-449e-ae09-2592c6717821';
  fid UUID := 'b393432e-665c-47fc-9b13-c66af880a80d';
  cid UUID := '066ad4c3-e5b1-49b4-b8a2-951a8f721eed';   -- Synthesis, source HUMAN_REVIEWED
  tid UUID := '2bd9f11e-36cc-47d7-ab4f-4daa827b46be';   -- Transport, source AI_PROPOSED
BEGIN
  -- question_concepts: evidence-strength-only still passes.
  okd := false;
  BEGIN UPDATE public.question_concepts
           SET evidence_strength = 'RECOGNITION_ONLY', evidence_strength_set_at = now()
         WHERE question_id = qid;
        okd := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN okd := false; END IF; END;
  IF NOT okd THEN RAISE EXCEPTION 'step 4b evidence-strength exemption was broken'; END IF;

  -- question_concepts: governance still refused.
  BEGIN UPDATE public.question_concepts SET role = 'SECONDARY' WHERE question_id = qid;
        RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'question_concepts.role'); END IF; END;

  -- flashcard_concepts: governance still refused.
  --
  -- THESE PROBE THE TRANSPORT MAPPING, NOT THE SYNTHESIS ONE, and the reason is
  -- worth recording. The Synthesis mapping carries source HUMAN_REVIEWED,
  -- because a human created it during the lipid governance review. On a row
  -- whose source is already HUMAN_REVIEWED the guard PERMITS amendments by
  -- design: that is the established governance path, not a hole. Probing it for
  -- refusal asserts the opposite of the intended behaviour. The Transport
  -- mapping carries source AI_PROPOSED, so it is the row the refusal applies to.
  BEGIN UPDATE public.flashcard_concepts SET role = 'SECONDARY'
         WHERE flashcard_id = fid AND concept_id = tid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'flashcard_concepts.role'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET source = 'DETERMINISTIC'
         WHERE flashcard_id = fid AND concept_id = tid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'flashcard_concepts.source'); END IF; END;

  BEGIN UPDATE public.flashcard_concepts SET confidence = 0.1
         WHERE flashcard_id = fid AND concept_id = tid; RAISE EXCEPTION 'LEAK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM = 'LEAK' THEN leaked := array_append(leaked, 'flashcard_concepts.confidence'); END IF; END;

  -- And the documented HUMAN_REVIEWED path still works on the row that carries
  -- that provenance, which is the behaviour the probes above must not forbid.
  okd := false;
  BEGIN UPDATE public.flashcard_concepts SET confidence = 0.9
         WHERE flashcard_id = fid AND concept_id = cid;
        okd := true; RAISE EXCEPTION 'ROLLBACK_OK';
  EXCEPTION WHEN OTHERS THEN IF SQLERRM <> 'ROLLBACK_OK' THEN okd := false; END IF; END;
  IF NOT okd THEN RAISE EXCEPTION 'the established HUMAN_REVIEWED amendment path was broken on flashcard_concepts'; END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'the guard allowed governance changes: %', array_to_string(leaked, ', ');
  END IF;
  RAISE NOTICE 'guard holds per table: evidence-strength and cloze-scope exempt, governance refused on both';
END $guard$;

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $post$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE cloze_indices IS NOT NULL;
  IF n <> 4 THEN RAISE EXCEPTION 'expected exactly 4 scoped mappings, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE cloze_indices IS NOT NULL
     AND flashcard_id NOT IN ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid,
                              '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid);
  IF n <> 0 THEN RAISE EXCEPTION '% scopes landed on unreviewed cards', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.flashcards f ON f.id = fc.flashcard_id
   WHERE fc.cloze_indices IS NOT NULL
     AND EXISTS (SELECT 1 FROM unnest(fc.cloze_indices) AS x WHERE x < 1 OR x > f.cloze_count);
  IF n <> 0 THEN RAISE EXCEPTION '% scopes reference a cloze that does not exist', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id = 'b393432e-665c-47fc-9b13-c66af880a80d'::uuid
     AND concept_id = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid
     AND cloze_indices = ARRAY[1];
  IF n <> 1 THEN RAISE EXCEPTION 'b393432e Synthesis is not scoped to [1]'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid
     AND concept_id = '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid
     AND cloze_indices = ARRAY[1];
  IF n <> 1 THEN RAISE EXCEPTION '7d0c69e5 Transport is not scoped to [1]'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE mapping_status = 'HUMAN_VALIDATED';
  IF n <> 24 THEN RAISE NOTICE 'human-validated card mappings now % (was 24)', n; END IF;

  RAISE NOTICE 'cloze scope live: 4 scoped mappings on 2 cards, every index real, governance untouched';
END $post$;

COMMIT;
