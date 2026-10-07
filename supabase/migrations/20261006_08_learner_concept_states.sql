-- ─── Phase 2 step 6: where the learner concept model is kept ───────────────
-- REQUIRES: 20261006_07_flashcard_concepts_cloze_indices.sql
--
-- This creates ONE table and writes no learner data into it. After it runs the
-- table holds zero rows, and it will keep holding zero rows until a separately
-- reviewed integration step computes the first states. Schema now, computation
-- later, on purpose: a schema review and a first production computation are two
-- different reviews, and mixing them means neither gets done properly.
--
-- WHAT THIS TABLE IS. The current output of buildConceptStates() in
-- lib/learner/conceptState.ts, one row per (learner, concept). For a single
-- canonical CONTENT concept it keeps MEMORY (what the learner can retrieve,
-- from flashcard scheduler state) and APPLICATION (what they can correctly use,
-- from question attempts) as separate columns that are allowed to disagree.
--
-- WHAT IT IS NOT. Not evidence. Not history. Not a scoring model. Not an input
-- to the predicted MCAT score, now or ever. Every number here is recomputable
-- from flashcard_user_state, question_attempts and the mapping tables, and
-- deleting the whole table loses nothing that cannot be rebuilt.
--
-- THAT REPLACEABILITY IS THE POINT, and it is what separates this table from
-- the history table that comes later. Current state may be recomputed under a
-- new model version whenever the model changes. Closed-day history may not: a
-- record of what the learner could retrieve last Tuesday is an OBSERVATION, and
-- a later model does not get to reinterpret it. Those two lifecycles must not
-- be blurred, which is why they are two tables rather than one with a flag.
--
-- SPARSE, AND ABSENCE IS THE SIGNAL. A row exists only where the learner has
-- qualifying evidence. NO_EVIDENCE is not stored; it is the state of every
-- (learner, concept) pair with no row, which today is all 929 learner-facing
-- CONTENT concepts for all 7 accounts. The model already refuses to emit a
-- NO_EVIDENCE state, and the coverage CHECK below refuses to store one.
--
-- WHY THE LEARNER CANNOT WRITE THIS. Every other derived learner table in this
-- schema (learner_state_snapshots, user_insight_briefs, performance_reports)
-- grants the student INSERT and UPDATE on their own rows, because the route
-- that computes them runs as the student under RLS. This one deliberately does
-- not. A learner concept state is an assertion the system makes ABOUT a
-- learner, which the next step will use to decide what they are shown and
-- eventually to brief an explanation model. A student who can POST their own
-- row can tell the product they have mastered anything. So writes belong to
-- service tooling only, which already exists and is already how the account
-- reset and the weekly report cron operate.
--
-- THE PREDICTED SCORE NEVER READS THIS TABLE. Memory-derived and
-- application-derived numbers share a row here, so any code holding the row
-- holds retention evidence whether it meant to or not. lib/scoring/
-- scoreEstimate.ts has banned both this table and the future history table by
-- name since before either existed; that ban is tested statically and the test
-- now runs against a table that is real.
--
-- WHAT THE PROBES AT THE BOTTOM PROVE, inside this transaction, against the
-- live database, before it commits: that an authenticated learner cannot
-- insert, update or delete a state row even if the privilege layer is opened
-- up; that one learner cannot read another's; that state cannot be stored
-- against a REASONING, QUANTITATIVE or deprecated concept; and that no probe
-- row survives. The probes read concepts and auth.users and modify neither.

BEGIN;

-- ─── The table ─────────────────────────────────────────────────────────────
--
-- COLUMNS, NOT JSONB. learner_state_snapshots stores jsonb because a snapshot
-- is read whole and its shape was still moving. This is the opposite case: the
-- shape is pinned by a pure function with 24 named fields, and the rows will be
-- filtered and ordered by individual values ("which concepts is this learner
-- struggling to apply"). jsonb would make every one of those a scan and would
-- let a writer store a misspelled signal forever.
--
-- DOUBLE PRECISION, NOT NUMERIC, for every fraction. The model computes in
-- IEEE-754 binary64 and float8 is the same representation, so a value survives
-- the round trip to the database and back unchanged. NUMERIC would require
-- choosing a scale, and a chosen scale is a silent rounding of a model output.
CREATE TABLE IF NOT EXISTS public.learner_concept_states (
  -- Identity. ONE CURRENT ROW PER PAIR: this table is not versioned by adding
  -- rows. model_version describes the model that produced the row that is
  -- here; coexisting versions are a property of the later history table.
  user_id    UUID NOT NULL REFERENCES auth.users(id)     ON DELETE CASCADE,
  concept_id UUID NOT NULL REFERENCES public.concepts(id) ON DELETE CASCADE,

  -- Which modalities the evidence came from, and why one is missing.
  coverage_state  TEXT NOT NULL,
  coverage_reason TEXT,

  -- Memory. Two components because they answer different questions and move at
  -- different speeds: durability is what was built, freshness is what is
  -- accessible today. Both NULL exactly when there is no memory evidence.
  memory_durability            DOUBLE PRECISION,
  memory_freshness             DOUBLE PRECISION,
  memory_signal                TEXT NOT NULL,
  freshness_signal             TEXT NOT NULL,
  memory_confidence            TEXT NOT NULL,
  memory_confidence_raw        DOUBLE PRECISION NOT NULL,
  memory_confidence_limited_by TEXT NOT NULL,
  memory_items                 INTEGER NOT NULL,
  memory_items_available       INTEGER NOT NULL,
  weak_card_count              INTEGER NOT NULL,

  -- Application. Deliberately timid in this model version: it can report that
  -- misses happened and can make a negative claim at depth, and makes no
  -- positive competence claim at all.
  application_signal           TEXT NOT NULL,
  application_confidence       TEXT NOT NULL,
  application_attempts         INTEGER NOT NULL,
  application_correct          INTEGER NOT NULL,
  application_misses_in_window INTEGER NOT NULL,
  application_lower_bound      DOUBLE PRECISION,
  application_upper_bound      DOUBLE PRECISION,

  -- The interpretation, and when each axis last saw anything.
  state_label                  TEXT NOT NULL,
  last_memory_evidence_at      TIMESTAMPTZ,
  last_application_evidence_at TIMESTAMPTZ,

  -- Provenance. NO DEFAULTS ON ANY OF THESE THREE, which is a deliberate
  -- refusal of convenience: see the comments below.
  model_version TEXT        NOT NULL,
  study_day     DATE        NOT NULL,
  computed_at   TIMESTAMPTZ NOT NULL,

  PRIMARY KEY (user_id, concept_id)
);

COMMENT ON TABLE public.learner_concept_states IS
  'CURRENT deterministic learner concept state, one row per (user, concept), produced by buildConceptStates() in lib/learner/conceptState.ts. Sparse: a missing row means NO_EVIDENCE. Derived and replaceable - every column is recomputable from flashcard_user_state, question_attempts and the mapping tables, so deleting any row or the whole table loses nothing permanent. NOT history: closed-day observations belong in a separate append-only table. NEVER an input to the predicted MCAT score.';

COMMENT ON COLUMN public.learner_concept_states.model_version IS
  'The model that produced THIS row. No database default, on purpose: a default would let a stale writer create rows that look current merely because the server supplied today version string. The writer has to say which model it is.';

COMMENT ON COLUMN public.learner_concept_states.computed_at IS
  'The now the pure model was given, not the moment of the INSERT. No default, on purpose: now() at insert time is a different fact, and a row whose timestamp came from the clock rather than from the computation cannot be reproduced. The model takes now as an explicit argument precisely so a past day can be recomputed identically.';

COMMENT ON COLUMN public.learner_concept_states.study_day IS
  'The study day the writer attributed this computation to, from studyDayKey() with the profile day_start_hour (4am local for all 7 accounts today). NOT a UTC calendar day and NOT derivable in SQL. It is not part of the row identity; it is here because the later history table will key closed days by it, and reconstructing a day boundary afterwards from computed_at - with a day_start_hour that may since have changed - is exactly the invented history that design forbids.';

COMMENT ON COLUMN public.learner_concept_states.memory_items IS
  'Distinct cards that contributed memory evidence. One card is one vote however many clozes it carries, and a cloze-scoped mapping votes only with the blanks in its scope.';

COMMENT ON COLUMN public.learner_concept_states.memory_items_available IS
  'Cards the bank maps to this concept, whether or not the learner has studied them. memory_items / memory_items_available is the breadth term in memory_confidence. Never less than memory_items, because flashcard_concepts holds exactly one row per (card, concept).';

COMMENT ON COLUMN public.learner_concept_states.application_misses_in_window IS
  'Misses among the most recent OBSERVATION_WINDOW eligible first attempts, not lifetime misses. A lifetime count can only rise, so a learner who missed twice in January could never shed the observation.';

COMMENT ON COLUMN public.learner_concept_states.application_upper_bound IS
  'Wilson UPPER bound. A negative claim needs the optimistic end: if even the most favourable reading of the evidence sits below MCAT-par, the learner is struggling whatever luck they had. The paired lower bound is reported but drives no decision in this model version.';

-- NO SECONDARY INDEXES, deliberately. The primary key is (user_id, concept_id)
-- and every access path starts with user_id: the reset deletes by user, the
-- writer upserts by pair, and a learner read is "all my rows". The whole
-- population is 929 learner-facing concepts, so one learner's rows are at most
-- 929 and a primary-key prefix scan is the right plan. learner_state_snapshots
-- needed a (user_id, study_day DESC) index because it is queried in day order;
-- there is no such ordering here. An index can be added when a query wants one.

-- ─── Integrity, derived from the pure function and nothing else ─────────────
--
-- Every CHECK below was read off the implementation and then MEASURED: 3,915
-- states generated from 4,000 random evidence sets, plus an exhaustive sweep of
-- all 125,751 (correct, attempts) pairs up to n = 500. Nothing here is a
-- constraint that merely sounds plausible, and two candidates were dropped
-- after the measurement contradicted them.
--
-- WHAT IS DELIBERATELY NOT CONSTRAINED: the threshold arithmetic. Whether
-- freshness >= 0.80 really means FRESH, or durability >= 0.55 really means
-- DURABLE, is checkable in SQL today and would be wrong tomorrow. Those
-- thresholds are provisional by the model own admission, and a CHECK that
-- encodes them turns a calibration into a schema migration and breaks every
-- stored row the moment the model is recalibrated. Band agreement is asserted
-- in TypeScript, where changing it is a code review. The CHECKs here carry only
-- STRUCTURAL invariants: vocabularies, nullability pairings, orderings and
-- counts, none of which a recalibration can change.

-- The vocabularies. Listed in the same order as the runtime lists exported by
-- lib/learner/conceptState.ts, and a test compares the sequences, so a value
-- added on one side and not the other fails the build rather than silently
-- being accepted by a database the model has no branch for.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_coverage_state_check,
  ADD CONSTRAINT learner_concept_states_coverage_state_check
    CHECK (coverage_state IN ('BOTH_MODALITIES', 'MEMORY_ONLY', 'QUESTION_ONLY', 'NO_EVIDENCE')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_coverage_reason_check,
  ADD CONSTRAINT learner_concept_states_coverage_reason_check
    CHECK (coverage_reason IS NULL OR coverage_reason IN ('BANK_HAS_NO_QUESTIONS', 'BANK_HAS_NO_CARDS', 'LEARNER_HAS_NOT_ATTEMPTED', 'LEARNER_HAS_NOT_REVIEWED')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_signal_check,
  ADD CONSTRAINT learner_concept_states_memory_signal_check
    CHECK (memory_signal IN ('DURABLE', 'BUILDING', 'THIN', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_freshness_signal_check,
  ADD CONSTRAINT learner_concept_states_freshness_signal_check
    CHECK (freshness_signal IN ('FRESH', 'COOLING', 'STALE', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_confidence_check,
  ADD CONSTRAINT learner_concept_states_memory_confidence_check
    CHECK (memory_confidence IN ('LOW', 'MODERATE', 'HIGH')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_application_confidence_check,
  ADD CONSTRAINT learner_concept_states_application_confidence_check
    CHECK (application_confidence IN ('LOW', 'MODERATE', 'HIGH')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_confidence_limited_by_check,
  ADD CONSTRAINT learner_concept_states_memory_confidence_limited_by_check
    CHECK (memory_confidence_limited_by IN ('LEARNER_COVERAGE', 'BANK_COVERAGE', 'ROLE', 'NONE')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_application_signal_check,
  ADD CONSTRAINT learner_concept_states_application_signal_check
    CHECK (application_signal IN ('STRUGGLING', 'MISSES_OBSERVED', 'NOT_ESTABLISHED', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_states_state_label_check,
  ADD CONSTRAINT learner_concept_states_state_label_check
    CHECK (state_label IN ('DURABLE_RECALL_APPLICATION_MISSES', 'STALE_RECALL_APPLICATION_MISSES', 'THIN_RECALL_APPLICATION_MISSES', 'APPLICATION_MISSES_MEMORY_UNKNOWN', 'MEMORY_DURABLE', 'MEMORY_DURABLE_STALE', 'MEMORY_BUILDING', 'MEMORY_THIN', 'INSUFFICIENT_EVIDENCE'));

-- THE COVERAGE CONTRACT, in one constraint.
--
-- coverage_state is not an independent label, it is a statement about which
-- counts are non-zero, and the reason is only meaningful for the state that
-- lacks a modality. Stating all of it together also makes two separate
-- constraints unnecessary: NO_EVIDENCE cannot be stored because no branch
-- admits it, and "a row has evidence on at least one axis" falls out of the
-- same three branches. Both were drafted and then dropped as redundant.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_coverage_contract,
  ADD CONSTRAINT learner_concept_states_coverage_contract CHECK (
       (coverage_state = 'BOTH_MODALITIES' AND memory_items > 0 AND application_attempts > 0
          AND coverage_reason IS NULL)
    OR (coverage_state = 'MEMORY_ONLY'     AND memory_items > 0 AND application_attempts = 0
          AND coverage_reason IN ('LEARNER_HAS_NOT_ATTEMPTED', 'BANK_HAS_NO_QUESTIONS'))
    OR (coverage_state = 'QUESTION_ONLY'   AND memory_items = 0 AND application_attempts > 0
          AND coverage_reason IN ('LEARNER_HAS_NOT_REVIEWED', 'BANK_HAS_NO_CARDS'))
  );

-- THE MEMORY AXIS, both branches.
--
-- INSUFFICIENT means exactly one thing: no eligible memory evidence. It is not
-- a synonym for low confidence, and the signal keeps reporting a real
-- measurement at LOW confidence - the conservative gate lives on state_label.
-- So the pairing is exact in both directions and the CHECK says so.
--
-- NOT ASSERTED: that a learner with memory evidence has a memory timestamp.
-- last_memory_evidence_at can legitimately be NULL with memory_items > 0, when
-- every in-scope scheduler row has reps > 0 but a null last_reviewed_at. Only
-- the reverse holds: a timestamp requires an item.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_contract,
  ADD CONSTRAINT learner_concept_states_memory_contract CHECK (
       (memory_items = 0
          AND memory_durability IS NULL AND memory_freshness IS NULL
          AND memory_signal = 'INSUFFICIENT' AND freshness_signal = 'INSUFFICIENT'
          AND memory_confidence = 'LOW' AND memory_confidence_raw = 0
          AND memory_confidence_limited_by = 'NONE'
          AND weak_card_count = 0
          AND last_memory_evidence_at IS NULL)
    OR (memory_items > 0
          AND memory_durability IS NOT NULL AND memory_freshness IS NOT NULL
          AND memory_signal <> 'INSUFFICIENT' AND freshness_signal <> 'INSUFFICIENT')
  );

-- Ranges and counts on the memory axis.
--
-- durability, freshness and memory_confidence_raw are each clipped to [0,1] by
-- the model and measured inside it, so the bound is exact for all three.
-- memory_items_available >= memory_items is safe to assert because
-- flashcard_concepts holds exactly one row per (card, concept): 4,123 rows,
-- 4,123 distinct pairs, verified live before this was written.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_ranges,
  ADD CONSTRAINT learner_concept_states_memory_ranges CHECK (
        (memory_durability     IS NULL OR memory_durability     BETWEEN 0 AND 1)
    AND (memory_freshness      IS NULL OR memory_freshness      BETWEEN 0 AND 1)
    AND memory_confidence_raw BETWEEN 0 AND 1
    AND memory_items           >= 0
    AND memory_items_available >= memory_items
    AND weak_card_count        >= 0
    AND weak_card_count        <= memory_items
  ),
  -- A limit is only recorded when confidence is actually limited. The model
  -- leaves this NONE when confidence is HIGH or there is no memory evidence.
  DROP CONSTRAINT IF EXISTS learner_concept_states_confidence_limit_pairing,
  ADD CONSTRAINT learner_concept_states_confidence_limit_pairing CHECK (
    memory_confidence_limited_by = 'NONE'
    OR (memory_confidence <> 'HIGH' AND memory_items > 0)
  );

-- THE APPLICATION AXIS, both branches.
--
-- The 5 in the window ceiling is OBSERVATION_WINDOW. It is the one model
-- constant this file hard-codes, because the constraint it buys is worth it: a
-- writer that stored LIFETIME misses here would pass "misses <= attempts"
-- unnoticed, and a learner with 40 attempts and 30 misses would look like a
-- window observation forever. A TypeScript test asserts this literal equals
-- OBSERVATION_WINDOW, so changing the constant fails the build and forces a
-- deliberate migration rather than silently invalidating stored rows.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_application_contract,
  ADD CONSTRAINT learner_concept_states_application_contract CHECK (
       (application_attempts = 0
          AND application_correct = 0 AND application_misses_in_window = 0
          AND application_lower_bound IS NULL AND application_upper_bound IS NULL
          AND application_signal = 'INSUFFICIENT' AND application_confidence = 'LOW'
          AND last_application_evidence_at IS NULL)
    OR (application_attempts > 0
          AND application_correct BETWEEN 0 AND application_attempts
          AND application_misses_in_window BETWEEN 0 AND LEAST(application_attempts, 5)
          AND application_lower_bound IS NOT NULL AND application_upper_bound IS NOT NULL
          AND last_application_evidence_at IS NOT NULL)
  );

-- THE WILSON BOUNDS ARE NOT CONSTRAINED TO [0,1], AND THAT IS NOT SLOPPINESS.
--
-- The interval is computed in floating point and genuinely leaves the unit
-- interval at the endpoints. Measured, exhaustively, over every (correct,
-- attempts) pair up to n = 500:
--
--   upper = 1.0000000000000002   first at 5 correct out of 5
--   lower = -2.2096511667503485e-17   first at 0 correct out of 15
--
-- Five right out of five is the FIRST depth at which this model will make any
-- application claim, so a CHECK of BETWEEN 0 AND 1 would have rejected a
-- correct row for a real learner on their first clean run. The tolerance is
-- 1e-9: about seven orders of magnitude above the observed error, and about
-- nine below any plausible unit mistake, so it still catches a writer that
-- stores 65 instead of 0.65. The underlying rounding belongs to the shared
-- formula in lib/learner/topicState.ts and is left alone here; clipping it
-- would change a calibrated model inside a schema migration.
ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_application_bounds,
  ADD CONSTRAINT learner_concept_states_application_bounds CHECK (
       (application_lower_bound IS NULL AND application_upper_bound IS NULL)
    OR (application_lower_bound BETWEEN -1e-9 AND 1 + 1e-9
          AND application_upper_bound BETWEEN -1e-9 AND 1 + 1e-9
          AND application_lower_bound <= application_upper_bound)
  );

ALTER TABLE public.learner_concept_states
  DROP CONSTRAINT IF EXISTS learner_concept_states_memory_timestamp,
  ADD CONSTRAINT learner_concept_states_memory_timestamp CHECK (
    last_memory_evidence_at IS NULL OR memory_items > 0
  ),
  DROP CONSTRAINT IF EXISTS learner_concept_states_model_version_present,
  ADD CONSTRAINT learner_concept_states_model_version_present CHECK (
    btrim(model_version) <> ''
  );

-- ─── Only learner-facing CONTENT may carry state ───────────────────────────
--
-- A plain foreign key says the concept exists; it cannot say the concept is the
-- kind of thing a learner has a state about. Section and discipline are
-- separate axes in this ontology and object_type is a column, not a slug
-- prefix, so there is nothing to infer from the id. A CHECK cannot do it either
-- because a CHECK may not contain a subquery. That leaves a trigger, which is
-- how the sibling rules on question_concepts and flashcard_concepts are already
-- enforced, so this follows them rather than inventing a mechanism.
--
-- A POSITIVE NAMED SET, matching LEARNER_FACING_STATUSES in the model, not
-- "status <> 'DEPRECATED'". The negation would silently admit a future DRAFT or
-- PROPOSED concept the moment someone added one. The live learner-facing status
-- is ACTIVE_SEED; there is no row with status 'ACTIVE' anywhere in this
-- database, which is the mistake that would have computed zero states for every
-- learner with no error at all.
--
-- NOT security definer, matching its siblings. public.concepts has no row-level
-- security, so the lookup succeeds for any role that can reach this table, and
-- the only role that can write it is service tooling.
CREATE OR REPLACE FUNCTION public.learner_concept_states_active_content()
RETURNS TRIGGER AS $fn$
DECLARE t TEXT; s TEXT;
BEGIN
  SELECT object_type, status INTO t, s FROM public.concepts WHERE id = NEW.concept_id;
  IF t IS DISTINCT FROM 'CONTENT' THEN
    RAISE EXCEPTION
      'learner_concept_states answers "what does this learner know about this CONTENT concept". Concept % is %. A learner state for a % object needs its own design, because reasoning and quantitative skill are not retrieved from flashcards.',
      NEW.concept_id, COALESCE(t, 'missing'), COALESCE(t, 'missing');
  END IF;
  IF s IS DISTINCT FROM 'ACTIVE_SEED' THEN
    RAISE EXCEPTION
      'Concept % has status %, which is not learner-facing. State cannot be stored against it; recompute against its successor instead.',
      NEW.concept_id, COALESCE(s, 'missing');
  END IF;
  RETURN NEW;
END; $fn$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS learner_concept_states_active_content ON public.learner_concept_states;
CREATE TRIGGER learner_concept_states_active_content
  BEFORE INSERT OR UPDATE OF concept_id ON public.learner_concept_states
  FOR EACH ROW EXECUTE FUNCTION public.learner_concept_states_active_content();

-- ─── Security ──────────────────────────────────────────────────────────────
--
-- Read your own row. Write nothing. Two layers, because they fail differently:
-- the GRANT stops the statement before RLS is consulted, and the absence of a
-- write policy stops it even if someone re-grants the privilege later. The
-- probes below prove each layer separately rather than assuming one covers the
-- other.
ALTER TABLE public.learner_concept_states ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own concept states" ON public.learner_concept_states;
CREATE POLICY "Users read own concept states"
  ON public.learner_concept_states FOR SELECT USING (auth.uid() = user_id);

-- No INSERT, UPDATE or DELETE policy exists, and that is the design, not an
-- omission. Service tooling bypasses RLS; nothing else writes here.
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.learner_concept_states FROM anon, authenticated;

-- ─── Post-conditions ───────────────────────────────────────────────────────
--
-- Read the installed shape back out of the catalog, then drive the real
-- behaviour against it. A policy that exists but names the wrong column, or a
-- trigger attached to the wrong events, both look installed and protect
-- nothing.
DO $post$
DECLARE
  n          INT;
  defn       TEXT;
  u_a        UUID;
  u_b        UUID;
  c_content  UUID;
  c_content2 UUID;
  c_content3 UUID;
  c_reason   UUID;
  c_quant    UUID;
  c_dep      UUID;
  leaked     TEXT[] := ARRAY[]::TEXT[];
  err        TEXT;
  state      TEXT;
  users      INT;
BEGIN
  -- ── Shape ───────────────────────────────────────────────────────────────
  SELECT count(*) INTO n FROM information_schema.tables
   WHERE table_schema = 'public' AND table_name = 'learner_concept_states';
  IF n <> 1 THEN RAISE EXCEPTION 'STEP 6: the table was not created'; END IF;

  SELECT count(*) INTO n FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'learner_concept_states';
  IF n <> 27 THEN RAISE EXCEPTION 'STEP 6: expected 27 columns, found %', n; END IF;

  -- The identity is the pair, and nothing else.
  SELECT string_agg(a.attname, ',' ORDER BY k.ord) INTO defn
    FROM pg_constraint c
    JOIN LATERAL unnest(c.conkey) WITH ORDINALITY AS k(attnum, ord) ON TRUE
    JOIN pg_attribute a ON a.attrelid = c.conrelid AND a.attnum = k.attnum
   WHERE c.conrelid = 'public.learner_concept_states'::regclass AND c.contype = 'p';
  IF defn <> 'user_id,concept_id' THEN
    RAISE EXCEPTION 'STEP 6: primary key is (%), expected (user_id,concept_id)', defn;
  END IF;

  -- Foreign keys, including what happens when the far end goes away. CASCADE on
  -- both: this is replaceable derived data and a dangling row is worse than a
  -- missing one. For the later history table that answer will be different.
  SELECT count(*) INTO n FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_states'::regclass AND contype = 'f'
     AND confrelid = 'auth.users'::regclass AND confdeltype = 'c';
  IF n <> 1 THEN RAISE EXCEPTION 'STEP 6: user_id does not cascade from auth.users'; END IF;

  SELECT count(*) INTO n FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_states'::regclass AND contype = 'f'
     AND confrelid = 'public.concepts'::regclass AND confdeltype = 'c';
  IF n <> 1 THEN RAISE EXCEPTION 'STEP 6: concept_id does not cascade from concepts'; END IF;

  SELECT count(*) INTO n FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_states'::regclass AND contype = 'c';
  -- A FLOOR, NOT AN EXACT COUNT: later work may add an invariant, and that is
  -- growth. Losing one is the failure this notices.
  IF n < 17 THEN RAISE EXCEPTION 'STEP 6: expected at least 17 CHECK constraints, found %', n; END IF;

  -- No column may carry a default. model_version, computed_at and study_day are
  -- the ones that matter and the reason is in their comments; the rest are
  -- checked too, so a later convenience default cannot slip in unnoticed.
  SELECT string_agg(column_name, ', ' ORDER BY ordinal_position) INTO defn
    FROM information_schema.columns
   WHERE table_schema = 'public' AND table_name = 'learner_concept_states'
     AND column_default IS NOT NULL;
  IF defn IS NOT NULL THEN
    RAISE EXCEPTION 'STEP 6: these columns have a database default, which the writer contract forbids: %', defn;
  END IF;

  IF NOT (SELECT relrowsecurity FROM pg_class WHERE oid = 'public.learner_concept_states'::regclass) THEN
    RAISE EXCEPTION 'STEP 6: row-level security is not enabled';
  END IF;

  SELECT count(*) INTO n FROM pg_policies
   WHERE schemaname = 'public' AND tablename = 'learner_concept_states';
  IF n <> 1 THEN RAISE EXCEPTION 'STEP 6: expected exactly one policy, found %', n; END IF;

  SELECT cmd || ' ' || COALESCE(qual, 'null') INTO defn FROM pg_policies
   WHERE schemaname = 'public' AND tablename = 'learner_concept_states';
  IF defn NOT LIKE 'SELECT %' OR position('auth.uid() = user_id' IN defn) = 0 THEN
    RAISE EXCEPTION 'STEP 6: the only policy is not own-row SELECT: %', defn;
  END IF;

  SELECT count(*) INTO n FROM information_schema.role_table_grants
   WHERE table_schema = 'public' AND table_name = 'learner_concept_states'
     AND grantee IN ('anon', 'authenticated')
     AND privilege_type IN ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE');
  IF n <> 0 THEN
    RAISE EXCEPTION 'STEP 6: anon or authenticated still hold % write privilege(s)', n;
  END IF;

  SELECT pg_get_triggerdef(t.oid) INTO defn
    FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
   WHERE NOT t.tgisinternal AND c.relname = 'learner_concept_states'
     AND t.tgname = 'learner_concept_states_active_content';
  IF defn IS NULL THEN RAISE EXCEPTION 'STEP 6: the ACTIVE CONTENT trigger is missing'; END IF;
  IF position('BEFORE INSERT OR UPDATE OF concept_id' IN defn) = 0 THEN
    RAISE EXCEPTION 'STEP 6: the ACTIVE CONTENT trigger fires on the wrong events: %', defn;
  END IF;

  -- ── Fixtures, read-only, from whatever the database actually holds ───────
  -- THREE distinct eligible concepts, not one reused. Two probes below expect
  -- to be refused by a CHECK and by RLS; if they targeted a pair that already
  -- held a row, a primary-key collision could refuse them first and both would
  -- pass while proving nothing. That is the same "passed for the wrong reason"
  -- fault a probe in step 5 had, and it is cheaper to remove the possibility
  -- than to reason about which check Postgres evaluates first.
  SELECT id INTO c_content  FROM public.concepts
   WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 0;
  SELECT id INTO c_content2 FROM public.concepts
   WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 1;
  SELECT id INTO c_content3 FROM public.concepts
   WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 2;
  SELECT id INTO c_reason FROM public.concepts
   WHERE object_type = 'REASONING' ORDER BY id LIMIT 1;
  SELECT id INTO c_quant FROM public.concepts
   WHERE object_type = 'QUANTITATIVE' ORDER BY id LIMIT 1;
  SELECT id INTO c_dep FROM public.concepts
   WHERE object_type = 'CONTENT' AND status = 'DEPRECATED' ORDER BY id LIMIT 1;
  IF c_content IS NULL OR c_content2 IS NULL OR c_content3 IS NULL
     OR c_reason IS NULL OR c_quant IS NULL OR c_dep IS NULL THEN
    RAISE EXCEPTION 'STEP 6: the ontology does not hold the probe concepts (content % % %, reasoning %, quantitative %, deprecated %)',
      c_content, c_content2, c_content3, c_reason, c_quant, c_dep;
  END IF;

  SELECT count(*) INTO users FROM auth.users;
  SELECT id INTO u_a FROM auth.users ORDER BY id LIMIT 1;
  SELECT id INTO u_b FROM auth.users WHERE id <> u_a ORDER BY id LIMIT 1;

  -- ── ACTIVE CONTENT enforcement, driven for real ─────────────────────────
  -- Three refusals and one acceptance. Each refusal is checked for the RIGHT
  -- reason: a probe that passes because a different rule happened to fire is
  -- not evidence about the rule being tested.
  BEGIN
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_durability, memory_freshness, memory_signal, freshness_signal,
      memory_confidence, memory_confidence_raw, memory_confidence_limited_by,
      memory_items, memory_items_available, weak_card_count,
      application_signal, application_confidence, application_attempts,
      application_correct, application_misses_in_window,
      application_lower_bound, application_upper_bound, state_label,
      last_memory_evidence_at, last_application_evidence_at,
      model_version, study_day, computed_at
    ) VALUES (
      u_a, c_reason, 'MEMORY_ONLY', 'BANK_HAS_NO_QUESTIONS',
      0.5, 0.5, 'BUILDING', 'COOLING', 'MODERATE', 0.5, 'LEARNER_COVERAGE',
      1, 1, 0, 'INSUFFICIENT', 'LOW', 0, 0, 0, NULL, NULL, 'MEMORY_BUILDING',
      NULL, NULL, 'PROBE', CURRENT_DATE, now()
    );
    leaked := array_append(leaked, 'a REASONING concept accepted learner state');
  EXCEPTION WHEN OTHERS THEN
    IF position('is REASONING' IN SQLERRM) = 0 THEN
      leaked := array_append(leaked, 'REASONING refused for the wrong reason: ' || SQLERRM);
    END IF;
  END;

  BEGIN
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_durability, memory_freshness, memory_signal, freshness_signal,
      memory_confidence, memory_confidence_raw, memory_confidence_limited_by,
      memory_items, memory_items_available, weak_card_count,
      application_signal, application_confidence, application_attempts,
      application_correct, application_misses_in_window,
      application_lower_bound, application_upper_bound, state_label,
      last_memory_evidence_at, last_application_evidence_at,
      model_version, study_day, computed_at
    ) VALUES (
      u_a, c_quant, 'MEMORY_ONLY', 'BANK_HAS_NO_QUESTIONS',
      0.5, 0.5, 'BUILDING', 'COOLING', 'MODERATE', 0.5, 'LEARNER_COVERAGE',
      1, 1, 0, 'INSUFFICIENT', 'LOW', 0, 0, 0, NULL, NULL, 'MEMORY_BUILDING',
      NULL, NULL, 'PROBE', CURRENT_DATE, now()
    );
    leaked := array_append(leaked, 'a QUANTITATIVE concept accepted learner state');
  EXCEPTION WHEN OTHERS THEN
    IF position('is QUANTITATIVE' IN SQLERRM) = 0 THEN
      leaked := array_append(leaked, 'QUANTITATIVE refused for the wrong reason: ' || SQLERRM);
    END IF;
  END;

  BEGIN
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_durability, memory_freshness, memory_signal, freshness_signal,
      memory_confidence, memory_confidence_raw, memory_confidence_limited_by,
      memory_items, memory_items_available, weak_card_count,
      application_signal, application_confidence, application_attempts,
      application_correct, application_misses_in_window,
      application_lower_bound, application_upper_bound, state_label,
      last_memory_evidence_at, last_application_evidence_at,
      model_version, study_day, computed_at
    ) VALUES (
      u_a, c_dep, 'MEMORY_ONLY', 'BANK_HAS_NO_QUESTIONS',
      0.5, 0.5, 'BUILDING', 'COOLING', 'MODERATE', 0.5, 'LEARNER_COVERAGE',
      1, 1, 0, 'INSUFFICIENT', 'LOW', 0, 0, 0, NULL, NULL, 'MEMORY_BUILDING',
      NULL, NULL, 'PROBE', CURRENT_DATE, now()
    );
    leaked := array_append(leaked, 'a DEPRECATED CONTENT concept accepted learner state');
  EXCEPTION WHEN OTHERS THEN
    IF position('not learner-facing' IN SQLERRM) = 0 THEN
      leaked := array_append(leaked, 'DEPRECATED refused for the wrong reason: ' || SQLERRM);
    END IF;
  END;

  -- And the one that must succeed, with the awkward values a real row carries:
  -- a Wilson upper bound outside the unit interval, a durability that is not
  -- representable in binary, and both evidence timestamps present.
  BEGIN
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_durability, memory_freshness, memory_signal, freshness_signal,
      memory_confidence, memory_confidence_raw, memory_confidence_limited_by,
      memory_items, memory_items_available, weak_card_count,
      application_signal, application_confidence, application_attempts,
      application_correct, application_misses_in_window,
      application_lower_bound, application_upper_bound, state_label,
      last_memory_evidence_at, last_application_evidence_at,
      model_version, study_day, computed_at
    ) VALUES (
      u_a, c_content, 'BOTH_MODALITIES', NULL,
      0.1234567890123456, 0.9989899400000001, 'THIN', 'FRESH',
      'MODERATE', 0.4672345612345678, 'LEARNER_COVERAGE',
      3, 7, 2, 'MISSES_OBSERVED', 'MODERATE', 5, 5, 0,
      0.5654915598090251, 1.0000000000000002, 'THIN_RECALL_APPLICATION_MISSES',
      now() - interval '2 days', now() - interval '1 day',
      'PROBE', CURRENT_DATE, now()
    );
  EXCEPTION WHEN OTHERS THEN
    leaked := array_append(leaked, 'an ACTIVE_SEED CONTENT row was REFUSED: ' || SQLERRM);
  END;

  -- Float8 keeps the exact bits, which is the whole reason the columns are not
  -- NUMERIC. If this fails, every stored model output is being rounded.
  SELECT count(*) INTO n FROM public.learner_concept_states
   WHERE user_id = u_a AND concept_id = c_content
     AND memory_durability = 0.1234567890123456
     AND application_upper_bound = 1.0000000000000002
     AND memory_confidence_raw = 0.4672345612345678;
  IF n <> 1 THEN
    leaked := array_append(leaked, 'a double did not survive storage unchanged');
  END IF;

  -- An UPDATE that moves concept_id onto an ineligible concept must be refused
  -- too. The gap that shape left open on the mapping tables cost a whole extra
  -- migration in this project, so it is closed here on the first attempt.
  BEGIN
    UPDATE public.learner_concept_states SET concept_id = c_reason
     WHERE user_id = u_a AND concept_id = c_content;
    leaked := array_append(leaked, 'an UPDATE repointed state onto a REASONING concept');
  EXCEPTION WHEN OTHERS THEN
    IF position('is REASONING' IN SQLERRM) = 0 THEN
      leaked := array_append(leaked, 'the UPDATE path refused for the wrong reason: ' || SQLERRM);
    END IF;
  END;

  -- ── A CHECK that must bite: NO_EVIDENCE cannot be stored ────────────────
  BEGIN
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_signal, freshness_signal, memory_confidence, memory_confidence_raw,
      memory_confidence_limited_by, memory_items, memory_items_available,
      weak_card_count, application_signal, application_confidence,
      application_attempts, application_correct, application_misses_in_window,
      state_label, model_version, study_day, computed_at
    ) VALUES (
      u_a, c_content2, 'NO_EVIDENCE', NULL,
      'INSUFFICIENT', 'INSUFFICIENT', 'LOW', 0, 'NONE', 0, 0, 0,
      'INSUFFICIENT', 'LOW', 0, 0, 0, 'INSUFFICIENT_EVIDENCE',
      'PROBE', CURRENT_DATE, now()
    );
    leaked := array_append(leaked, 'a NO_EVIDENCE row was stored, when absence is supposed to mean that');
  EXCEPTION WHEN check_violation THEN NULL;
  WHEN OTHERS THEN
    leaked := array_append(leaked, 'the NO_EVIDENCE probe failed on something else: ' || SQLERRM);
  END;

  -- ── RLS, driven as a real authenticated learner ─────────────────────────
  IF users < 2 THEN
    -- Only reachable on an empty database, where there is no learner data to
    -- protect. The live database has seven accounts, so this never fires there.
    RAISE NOTICE 'STEP 6: RLS BEHAVIOURAL PROBE SKIPPED, only % user(s) exist', users;
  ELSE
    IF NOT pg_has_role(current_user, 'authenticated', 'MEMBER') THEN
      RAISE EXCEPTION 'STEP 6: % cannot assume the authenticated role, so the RLS behaviour cannot be proved. Report this message; the catalog checks above all passed and nothing has been committed.', current_user;
    END IF;

    -- A second row, owned by the other learner, so isolation has something to
    -- hide. Written here as service tooling, which is the only writer there is.
    INSERT INTO public.learner_concept_states (
      user_id, concept_id, coverage_state, coverage_reason,
      memory_signal, freshness_signal, memory_confidence, memory_confidence_raw,
      memory_confidence_limited_by, memory_items, memory_items_available,
      weak_card_count, application_signal, application_confidence,
      application_attempts, application_correct, application_misses_in_window,
      application_lower_bound, application_upper_bound, state_label,
      last_application_evidence_at, model_version, study_day, computed_at
    ) VALUES (
      u_b, c_content, 'QUESTION_ONLY', 'LEARNER_HAS_NOT_REVIEWED',
      'INSUFFICIENT', 'INSUFFICIENT', 'LOW', 0, 'NONE', 0, 0, 0,
      'NOT_ESTABLISHED', 'MODERATE', 6, 5, 1, 0.45, 0.98, 'INSUFFICIENT_EVIDENCE',
      now(), 'PROBE', CURRENT_DATE, now()
    );

    EXECUTE 'SET LOCAL ROLE authenticated';
    PERFORM set_config('request.jwt.claims',
      json_build_object('sub', u_a::text, 'role', 'authenticated')::text, true);
    PERFORM set_config('request.jwt.claim.sub', u_a::text, true);

    -- Prove the identity took effect FIRST. Without this, every refusal below
    -- could be the trivial consequence of auth.uid() being null, and an
    -- isolation test that passes because nobody is logged in proves nothing.
    IF auth.uid() IS DISTINCT FROM u_a THEN
      EXECUTE 'RESET ROLE';
      RAISE EXCEPTION 'STEP 6: the probe could not become a learner, auth.uid() is % not %', auth.uid(), u_a;
    END IF;

    SELECT count(*) INTO n FROM public.learner_concept_states;
    IF n <> 1 THEN
      leaked := array_append(leaked, 'learner A sees ' || n || ' row(s) under RLS, expected only their own');
    END IF;
    SELECT count(*) INTO n FROM public.learner_concept_states WHERE user_id = u_b;
    IF n <> 0 THEN
      leaked := array_append(leaked, 'learner A can read learner B state');
    END IF;

    -- Writes, refused by the privilege layer as shipped.
    BEGIN
      INSERT INTO public.learner_concept_states (
        user_id, concept_id, coverage_state, coverage_reason,
        memory_signal, freshness_signal, memory_confidence, memory_confidence_raw,
        memory_confidence_limited_by, memory_items, memory_items_available,
        weak_card_count, application_signal, application_confidence,
        application_attempts, application_correct, application_misses_in_window,
        application_lower_bound, application_upper_bound, state_label,
        last_application_evidence_at, model_version, study_day, computed_at
      ) VALUES (
        u_a, c_dep, 'QUESTION_ONLY', 'LEARNER_HAS_NOT_REVIEWED',
        'INSUFFICIENT', 'INSUFFICIENT', 'LOW', 0, 'NONE', 0, 0, 0,
        'NOT_ESTABLISHED', 'HIGH', 20, 20, 0, 0.8, 1.0, 'INSUFFICIENT_EVIDENCE',
        now(), 'FORGED', CURRENT_DATE, now()
      );
      leaked := array_append(leaked, 'an authenticated learner INSERTED their own state');
    EXCEPTION WHEN insufficient_privilege THEN NULL;
    WHEN OTHERS THEN
      leaked := array_append(leaked, 'the learner INSERT probe failed on something else (' || SQLSTATE || '): ' || SQLERRM);
    END;

    BEGIN
      UPDATE public.learner_concept_states SET state_label = 'MEMORY_DURABLE' WHERE user_id = u_a;
      leaked := array_append(leaked, 'an authenticated learner UPDATED their own state');
    EXCEPTION WHEN insufficient_privilege THEN NULL;
    WHEN OTHERS THEN
      leaked := array_append(leaked, 'the learner UPDATE probe failed on something else (' || SQLSTATE || '): ' || SQLERRM);
    END;

    BEGIN
      DELETE FROM public.learner_concept_states WHERE user_id = u_a;
      leaked := array_append(leaked, 'an authenticated learner DELETED their own state');
    EXCEPTION WHEN insufficient_privilege THEN NULL;
    WHEN OTHERS THEN
      leaked := array_append(leaked, 'the learner DELETE probe failed on something else (' || SQLSTATE || '): ' || SQLERRM);
    END;

    EXECUTE 'RESET ROLE';

    -- Now open the privilege layer and prove RLS refuses on its own. If the
    -- GRANT were ever restored by a later migration or a dashboard click, the
    -- missing write policy still has to stop this.
    GRANT INSERT, UPDATE, DELETE ON public.learner_concept_states TO authenticated;
    EXECUTE 'SET LOCAL ROLE authenticated';
    PERFORM set_config('request.jwt.claims',
      json_build_object('sub', u_a::text, 'role', 'authenticated')::text, true);
    PERFORM set_config('request.jwt.claim.sub', u_a::text, true);

    BEGIN
      INSERT INTO public.learner_concept_states (
        user_id, concept_id, coverage_state, coverage_reason,
        memory_signal, freshness_signal, memory_confidence, memory_confidence_raw,
        memory_confidence_limited_by, memory_items, memory_items_available,
        weak_card_count, application_signal, application_confidence,
        application_attempts, application_correct, application_misses_in_window,
        application_lower_bound, application_upper_bound, state_label,
        last_application_evidence_at, model_version, study_day, computed_at
      ) VALUES (
        u_a, c_content3, 'QUESTION_ONLY', 'LEARNER_HAS_NOT_REVIEWED',
        'INSUFFICIENT', 'INSUFFICIENT', 'LOW', 0, 'NONE', 0, 0, 0,
        'NOT_ESTABLISHED', 'HIGH', 20, 20, 0, 0.8, 1.0, 'INSUFFICIENT_EVIDENCE',
        now(), 'FORGED', CURRENT_DATE, now()
      );
      leaked := array_append(leaked, 'with INSERT granted, RLS did not stop a learner writing their own state');
    EXCEPTION WHEN insufficient_privilege THEN
      -- 42501 with the privilege granted can only be the missing policy. The
      -- row targets a valid ACTIVE_SEED CONTENT concept precisely so the
      -- BEFORE trigger passes and the refusal has to come from RLS; a trigger
      -- refusal would arrive as P0001 and be recorded as the wrong reason.
      state := SQLSTATE;
    WHEN OTHERS THEN
      leaked := array_append(leaked, 'with INSERT granted, the refusal came from the wrong layer (' || SQLSTATE || '): ' || SQLERRM);
    END;
    IF state IS DISTINCT FROM '42501' THEN
      leaked := array_append(leaked, 'the RLS-only INSERT probe did not report 42501, it reported ' || COALESCE(state, 'nothing'));
    END IF;

    EXECUTE 'RESET ROLE';
    REVOKE INSERT, UPDATE, DELETE ON public.learner_concept_states FROM authenticated;
  END IF;

  -- ── No residue ──────────────────────────────────────────────────────────
  DELETE FROM public.learner_concept_states WHERE model_version IN ('PROBE', 'FORGED');
  SELECT count(*) INTO n FROM public.learner_concept_states;
  IF n <> 0 THEN
    RAISE EXCEPTION 'STEP 6: % probe row(s) survived. The table must commit empty.', n;
  END IF;

  -- The privilege state has to be exactly as shipped, after all that granting.
  SELECT count(*) INTO n FROM information_schema.role_table_grants
   WHERE table_schema = 'public' AND table_name = 'learner_concept_states'
     AND grantee IN ('anon', 'authenticated')
     AND privilege_type IN ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE');
  IF n <> 0 THEN
    RAISE EXCEPTION 'STEP 6: the probe left % write privilege(s) behind', n;
  END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'STEP 6 FAILED: %', array_to_string(leaked, ' | ');
  END IF;

  RAISE NOTICE 'STEP 6 OK: learner_concept_states created with 27 columns, 1 own-row SELECT policy, no write policy, no write privileges, ACTIVE CONTENT enforced on insert and repoint, doubles stored exactly, 0 rows committed. Probed as % of % users.', u_a, users;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'learner_concept_states'
ORDER BY ordinal_position;

SELECT conname, pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE conrelid = 'public.learner_concept_states'::regclass
ORDER BY contype DESC, conname;

SELECT policyname, cmd, qual, with_check FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'learner_concept_states';

SELECT grantee, privilege_type FROM information_schema.role_table_grants
WHERE table_schema = 'public' AND table_name = 'learner_concept_states'
ORDER BY grantee, privilege_type;

SELECT count(*) AS rows_in_learner_concept_states FROM public.learner_concept_states;
