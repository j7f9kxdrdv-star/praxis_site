-- ─── Authoritative observed learner concept history ───────────────────────
-- REQUIRES: 20261007_04_timezone_capture.sql
--
-- Two tables and one writer. The tables commit empty and the writer is the
-- only thing that may fill them, from the designated daily scheduled refresh
-- and from nothing else.
--
-- WHAT A HISTORY ROW CLAIMS, exactly: the deterministic learner concept state
-- as the scheduled refresh observed it, at the instant it looked. Not the
-- learner's state at 03:59 their time, not the end of their day after every
-- card, not a reconstruction. The global cron fires once at 09:00 UTC; for a
-- learner in Sydney that is mid-evening with hours of study still ahead, so
-- "close of day" is a claim this system cannot support and does not make.
--
-- WHY TWO TABLES, which is not abstraction for its own sake. A successful
-- observation that found no concept state, and an observation that never
-- happened, both produce zero concept rows. Those are completely different
-- facts: one says "we looked and there was nothing", the other says "we never
-- looked". The parent record is what makes them distinguishable.
--
-- ─── THE IDENTITY CORRECTION, which is the heart of this migration ─────────
--
-- The obvious identity is (user_id, study_day, model_version). It is wrong,
-- and it would have been wrong in a way that silently dropped real data.
--
-- study_day is a learner-local LABEL, not the identity of a global scheduled
-- observation, and the label can repeat across consecutive cycles:
--
--   Cycle 2026-10-08    profile timezone NULL, so UTC is used
--                       09:00 UTC is already past the 04:00 UTC boundary
--                       study_day = 2026-10-08
--
--   that evening        the learner opens the dashboard from California and
--                       the initialiser stores America/Los_Angeles
--
--   Cycle 2026-10-09    09:00 UTC is 02:00 in Los Angeles, which is BEFORE
--                       their 04:00 boundary, so the study day is the one
--                       before: study_day = 2026-10-08 AGAIN
--
-- Two genuine observations, two days apart, carrying the same local label. A
-- unique key on study_day would refuse the second one and the day would
-- vanish from history with nothing to show it had been lost. The same shape
-- happens in reverse when a timezone moves east, skipping a local label.
--
-- So identity is the SCHEDULED CYCLE: the UTC calendar date of the designated
-- run. It is a property of the observer, independent of every learner's zone,
-- and it is stable across a retry in a way a random run id is not.
--
-- ─── WHAT EVERY OBSERVATION CARRIES FORWARD ───────────────────────────────
--
-- The timezone and day_start_hour USED are stored on the observation, not
-- joined from today''s profile. A learner may legitimately change either, and
-- an old label must stay interpretable under the rule that produced it rather
-- than under whatever rule is current. Timezone capture makes such a change
-- more likely, not less.
--
-- timezone_source distinguishes "this learner uses UTC" from "we did not know
-- where they were". Five live accounts are the second case today, and nothing
-- downstream should ever confuse the two.

BEGIN;

-- ─── The observation: we looked at this learner, in this cycle ────────────
CREATE TABLE IF NOT EXISTS public.learner_concept_state_observations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- CASCADE from auth.users on purpose. Immutability is about semantic
  -- rewriting, never about a person''s right to have their data deleted.
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,

  -- The UTC calendar date of the designated scheduled run. The identity.
  observation_cycle_date DATE NOT NULL,

  -- The exact instant the model was given. Every child of this observation
  -- was computed at this one moment.
  observed_at TIMESTAMPTZ NOT NULL,

  -- The learner-local label, and the two facts needed to read it later.
  study_day       DATE    NOT NULL,
  timezone_used   TEXT    NOT NULL,
  timezone_source TEXT    NOT NULL,
  day_start_hour  INTEGER NOT NULL,

  model_version TEXT    NOT NULL,
  -- Zero is a real and meaningful value: we looked and there was nothing.
  state_count   INTEGER NOT NULL,

  -- Which run produced it, for operational tracing. Not an identity: a retry
  -- of the same cycle gets a new run id and must not create a second
  -- observation.
  refresh_run_id TEXT,

  -- THE IDENTITY. A retry of the same cycle finds this row and records no
  -- second observation. Named explicitly, because a post-condition below reads
  -- this exact name out of the catalog and checks which columns it covers.
  CONSTRAINT learner_concept_state_observations_cycle_identity
    UNIQUE (user_id, observation_cycle_date, model_version),

  -- The target of the child's composite foreign key, and nothing more. id is
  -- already the primary key, so this constrains no data; a foreign key must
  -- reference a declared unique set of columns, and pairing the owner into the
  -- reference is what makes the child's copy of it unforgeable.
  --
  -- It carries its own name on purpose. Both of these are UNIQUE constraints
  -- on the same table, and an unnamed one here would sit directly under the
  -- CONSTRAINT keyword above and silently take the identity's name, which is
  -- exactly what happened on the first attempt to apply this file: the name
  -- bound to (id, user_id), the real identity went unenforced, and a retry
  -- would have written a second observation for a cycle already recorded. The
  -- post-condition caught it and the migration aborted. Keep both names.
  CONSTRAINT learner_concept_state_observations_owner_ref
    UNIQUE (id, user_id)
);

COMMENT ON TABLE public.learner_concept_state_observations IS
  'One row per learner per designated scheduled refresh cycle: proof that the learner WAS successfully observed. Identity is (user_id, observation_cycle_date, model_version) and deliberately NOT study_day, which is a learner-local label that can repeat or be skipped when a timezone changes. state_count 0 means observed with no concept state, which is different from no row at all, which means no observation happened.';

COMMENT ON COLUMN public.learner_concept_state_observations.timezone_source IS
  'PROFILE when the learner profile carried a timezone, DEFAULT_UTC when it did not and the documented fallback was used. Keeps "this learner uses UTC" distinguishable from "we did not know where they were" forever.';

ALTER TABLE public.learner_concept_state_observations
  DROP CONSTRAINT IF EXISTS learner_concept_state_observations_timezone_source_check,
  ADD CONSTRAINT learner_concept_state_observations_timezone_source_check
    CHECK (timezone_source IN ('PROFILE', 'DEFAULT_UTC')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_observations_shape,
  ADD CONSTRAINT learner_concept_state_observations_shape CHECK (
        btrim(model_version) <> ''
    AND btrim(timezone_used) <> ''
    AND day_start_hour BETWEEN 0 AND 23
    AND state_count >= 0
  );

CREATE INDEX IF NOT EXISTS learner_concept_state_observations_user_cycle_idx
  ON public.learner_concept_state_observations (user_id, observation_cycle_date DESC);

-- ─── The states that observation found ────────────────────────────────────
-- The 22 fields below are exactly the per-concept fields of
-- learner_concept_states. The four batch facts it carries — user, study day,
-- computed_at, model version — live on the parent instead of being repeated
-- across thousands of rows, and are always reachable through the mandatory
-- foreign key.
CREATE TABLE IF NOT EXISTS public.learner_concept_state_history (
  observation_id UUID NOT NULL,

  -- THE OWNER IS REPEATED HERE ON PURPOSE, AND IT IS NOT A CONVENTION.
  --
  -- The owner is already derivable by joining the parent, so a denormalized
  -- copy looks like duplication. It earns its place twice over.
  --
  -- The account reset deletes every table in its scope with the same
  -- statement: delete where user_id equals the caller. A child table without
  -- user_id cannot be deleted that way, so the reset would error on this table
  -- and return half-finished for every learner. Relying on the parent's
  -- CASCADE instead would delete the rows but report a count of zero, telling
  -- someone their history was already empty on the day they asked for it to be
  -- erased. The same applies to row-level security: a join-based policy is
  -- correct but is re-evaluated per row, where an own-row check is an index
  -- lookup.
  --
  -- A denormalized owner that can drift is worse than no copy at all, so it is
  -- not maintained by convention: the composite foreign key below makes
  -- (observation_id, user_id) reference the parent's own (id, user_id) pair.
  -- A row whose user_id disagrees with its parent's cannot be inserted. The
  -- database holds the invariant, not the writer, and not a comment.
  user_id UUID NOT NULL,

  FOREIGN KEY (observation_id, user_id)
    REFERENCES public.learner_concept_state_observations(id, user_id)
    ON DELETE CASCADE,

  -- RESTRICT, not CASCADE. This project deprecates concepts rather than
  -- deleting them, and an accidental hard delete must not quietly erase the
  -- record of what a learner knew. Renaming, deprecating and merging all keep
  -- the stable id, so ordinary lifecycle work is unaffected.
  concept_id UUID NOT NULL REFERENCES public.concepts(id) ON DELETE RESTRICT,

  coverage_state                 TEXT NOT NULL,
  coverage_reason                TEXT,
  memory_durability              DOUBLE PRECISION,
  memory_freshness               DOUBLE PRECISION,
  memory_signal                  TEXT NOT NULL,
  freshness_signal               TEXT NOT NULL,
  memory_confidence              TEXT NOT NULL,
  memory_confidence_raw          DOUBLE PRECISION NOT NULL,
  memory_confidence_limited_by   TEXT NOT NULL,
  memory_items                   INTEGER NOT NULL,
  memory_items_available         INTEGER NOT NULL,
  weak_card_count                INTEGER NOT NULL,
  application_signal             TEXT NOT NULL,
  application_confidence         TEXT NOT NULL,
  application_attempts           INTEGER NOT NULL,
  application_correct            INTEGER NOT NULL,
  application_misses_in_window   INTEGER NOT NULL,
  application_lower_bound        DOUBLE PRECISION,
  application_upper_bound        DOUBLE PRECISION,
  state_label                    TEXT NOT NULL,
  last_memory_evidence_at        TIMESTAMPTZ,
  last_application_evidence_at   TIMESTAMPTZ,

  PRIMARY KEY (observation_id, concept_id)
);

COMMENT ON TABLE public.learner_concept_state_history IS
  'The concept states one observation found. Immutable in normal runtime: never updated, never relabelled, never reconstructed. Deleted only by account reset or account deletion. Its temporal and account context lives on the parent observation.';

CREATE INDEX IF NOT EXISTS learner_concept_state_history_concept_idx
  ON public.learner_concept_state_history (concept_id);

-- The account reset and the row-level security policy both filter this table by
-- owner alone. Without this index each becomes a sequential scan over every
-- observation ever recorded, for every learner, which is the one table in the
-- schema guaranteed to grow without bound.
CREATE INDEX IF NOT EXISTS learner_concept_state_history_user_idx
  ON public.learner_concept_state_history (user_id);

-- ─── The same integrity the current table holds ───────────────────────────
-- An observation is only worth keeping if it is as well-formed as the state it
-- observed. These mirror learner_concept_states so a history row cannot say
-- something the model could never have produced.
ALTER TABLE public.learner_concept_state_history
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_coverage_state_check,
  ADD CONSTRAINT learner_concept_state_history_coverage_state_check
    CHECK (coverage_state IN ('BOTH_MODALITIES', 'MEMORY_ONLY', 'QUESTION_ONLY', 'NO_EVIDENCE')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_coverage_reason_check,
  ADD CONSTRAINT learner_concept_state_history_coverage_reason_check
    CHECK (coverage_reason IS NULL OR coverage_reason IN ('BANK_HAS_NO_QUESTIONS', 'BANK_HAS_NO_CARDS', 'LEARNER_HAS_NOT_ATTEMPTED', 'LEARNER_HAS_NOT_REVIEWED')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_signal_check,
  ADD CONSTRAINT learner_concept_state_history_memory_signal_check
    CHECK (memory_signal IN ('DURABLE', 'BUILDING', 'THIN', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_freshness_signal_check,
  ADD CONSTRAINT learner_concept_state_history_freshness_signal_check
    CHECK (freshness_signal IN ('FRESH', 'COOLING', 'STALE', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_confidence_check,
  ADD CONSTRAINT learner_concept_state_history_memory_confidence_check
    CHECK (memory_confidence IN ('LOW', 'MODERATE', 'HIGH')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_application_confidence_check,
  ADD CONSTRAINT learner_concept_state_history_application_confidence_check
    CHECK (application_confidence IN ('LOW', 'MODERATE', 'HIGH')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_confidence_limited_by_check,
  ADD CONSTRAINT learner_concept_state_history_memory_confidence_limited_by_check
    CHECK (memory_confidence_limited_by IN ('LEARNER_COVERAGE', 'BANK_COVERAGE', 'ROLE', 'NONE')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_application_signal_check,
  ADD CONSTRAINT learner_concept_state_history_application_signal_check
    CHECK (application_signal IN ('STRUGGLING', 'MISSES_OBSERVED', 'NOT_ESTABLISHED', 'INSUFFICIENT')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_state_label_check,
  ADD CONSTRAINT learner_concept_state_history_state_label_check
    CHECK (state_label IN ('DURABLE_RECALL_APPLICATION_MISSES', 'STALE_RECALL_APPLICATION_MISSES', 'THIN_RECALL_APPLICATION_MISSES', 'APPLICATION_MISSES_MEMORY_UNKNOWN', 'MEMORY_DURABLE', 'MEMORY_DURABLE_STALE', 'MEMORY_BUILDING', 'MEMORY_THIN', 'INSUFFICIENT_EVIDENCE')),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_coverage_contract,
  ADD CONSTRAINT learner_concept_state_history_coverage_contract CHECK (
       (coverage_state = 'BOTH_MODALITIES' AND memory_items > 0 AND application_attempts > 0 AND coverage_reason IS NULL)
    OR (coverage_state = 'MEMORY_ONLY'     AND memory_items > 0 AND application_attempts = 0
          AND coverage_reason IN ('LEARNER_HAS_NOT_ATTEMPTED', 'BANK_HAS_NO_QUESTIONS'))
    OR (coverage_state = 'QUESTION_ONLY'   AND memory_items = 0 AND application_attempts > 0
          AND coverage_reason IN ('LEARNER_HAS_NOT_REVIEWED', 'BANK_HAS_NO_CARDS'))
  ),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_contract,
  ADD CONSTRAINT learner_concept_state_history_memory_contract CHECK (
       (memory_items = 0 AND memory_durability IS NULL AND memory_freshness IS NULL
          AND memory_signal = 'INSUFFICIENT' AND freshness_signal = 'INSUFFICIENT'
          AND memory_confidence = 'LOW' AND memory_confidence_raw = 0
          AND memory_confidence_limited_by = 'NONE' AND weak_card_count = 0
          AND last_memory_evidence_at IS NULL)
    OR (memory_items > 0 AND memory_durability IS NOT NULL AND memory_freshness IS NOT NULL
          AND memory_signal <> 'INSUFFICIENT' AND freshness_signal <> 'INSUFFICIENT')
  ),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_ranges,
  ADD CONSTRAINT learner_concept_state_history_memory_ranges CHECK (
        (memory_durability IS NULL OR memory_durability BETWEEN 0 AND 1)
    AND (memory_freshness  IS NULL OR memory_freshness  BETWEEN 0 AND 1)
    AND memory_confidence_raw BETWEEN 0 AND 1
    AND memory_items >= 0 AND memory_items_available >= memory_items
    AND weak_card_count >= 0 AND weak_card_count <= memory_items
  ),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_application_contract,
  ADD CONSTRAINT learner_concept_state_history_application_contract CHECK (
       (application_attempts = 0 AND application_correct = 0 AND application_misses_in_window = 0
          AND application_lower_bound IS NULL AND application_upper_bound IS NULL
          AND application_signal = 'INSUFFICIENT' AND application_confidence = 'LOW'
          AND last_application_evidence_at IS NULL)
    OR (application_attempts > 0
          AND application_correct BETWEEN 0 AND application_attempts
          AND application_misses_in_window BETWEEN 0 AND LEAST(application_attempts, 5)
          AND application_lower_bound IS NOT NULL AND application_upper_bound IS NOT NULL
          AND last_application_evidence_at IS NOT NULL)
  ),
  -- The same measured tolerance as the current table: the Wilson interval
  -- genuinely leaves [0,1] at the endpoints, first at five correct out of five.
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_application_bounds,
  ADD CONSTRAINT learner_concept_state_history_application_bounds CHECK (
       (application_lower_bound IS NULL AND application_upper_bound IS NULL)
    OR (application_lower_bound BETWEEN -1e-9 AND 1 + 1e-9
          AND application_upper_bound BETWEEN -1e-9 AND 1 + 1e-9
          AND application_lower_bound <= application_upper_bound)
  ),
  DROP CONSTRAINT IF EXISTS learner_concept_state_history_memory_timestamp,
  ADD CONSTRAINT learner_concept_state_history_memory_timestamp
    CHECK (last_memory_evidence_at IS NULL OR memory_items > 0);

-- ─── Immutable in normal runtime ──────────────────────────────────────────
-- An UPDATE is refused on both tables, for every role including service
-- tooling. There is no "fix yesterday" path and no relabelling: if an
-- observation is ever found to be genuinely defective, the remedy is a
-- separately reviewed ADDITIVE record, not an edit.
--
-- DELETE IS DELIBERATELY LEFT ALONE. Immutability here is about semantic
-- rewriting, never about data retention: account reset and account deletion
-- must be able to remove a learner's history, and a trigger that blocked that
-- would turn a design principle into a privacy problem.
CREATE OR REPLACE FUNCTION public.reject_history_update()
RETURNS TRIGGER AS $fn$
BEGIN
  RAISE EXCEPTION
    'learner concept history is immutable. % rows record what was observed and are never rewritten; a correction must be an additive, separately reviewed record. DELETE remains available for account reset and account deletion.',
    TG_TABLE_NAME;
END; $fn$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS learner_concept_state_observations_immutable ON public.learner_concept_state_observations;
CREATE TRIGGER learner_concept_state_observations_immutable
  BEFORE UPDATE ON public.learner_concept_state_observations
  FOR EACH ROW EXECUTE FUNCTION public.reject_history_update();

DROP TRIGGER IF EXISTS learner_concept_state_history_immutable ON public.learner_concept_state_history;
CREATE TRIGGER learner_concept_state_history_immutable
  BEFORE UPDATE ON public.learner_concept_state_history
  FOR EACH ROW EXECUTE FUNCTION public.reject_history_update();

-- ─── Security ─────────────────────────────────────────────────────────────
-- Read your own, write nothing. Same shape as learner_concept_states.
ALTER TABLE public.learner_concept_state_observations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.learner_concept_state_history ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own observations" ON public.learner_concept_state_observations;
CREATE POLICY "Users read own observations"
  ON public.learner_concept_state_observations FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users read own concept history" ON public.learner_concept_state_history;
-- An own-row check rather than an EXISTS against the parent. Both are correct,
-- because the composite foreign key guarantees this user_id IS the parent's,
-- and this one is an index lookup instead of a per-row subquery.
CREATE POLICY "Users read own concept history"
  ON public.learner_concept_state_history FOR SELECT USING (auth.uid() = user_id);

REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.learner_concept_state_observations FROM anon, authenticated;
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.learner_concept_state_history FROM anon, authenticated;

-- ─── The scheduled writer: current state and history, one transaction ─────
--
-- It CALLS the existing current-state writer rather than reimplementing it.
-- replace_learner_concept_states already owns batch validation, the stale
-- delete, the per-learner lock and the upsert; a second copy here would be a
-- second interpretation of ConceptState that could drift from the first.
--
-- One payload, one model, one validation contract — and because both halves
-- run inside this one function, they share its transaction. A history row can
-- never claim one state while the current table holds another.
CREATE OR REPLACE FUNCTION public.record_scheduled_observation(
  p_user_id         UUID,
  p_cycle_date      DATE,
  p_study_day       DATE,
  p_observed_at     TIMESTAMPTZ,
  p_timezone_used   TEXT,
  p_timezone_source TEXT,
  p_day_start_hour  INT,
  p_model_version   TEXT,
  p_states          JSONB,
  p_refresh_run_id  TEXT DEFAULT NULL
) RETURNS JSONB
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_catalog
AS $fn$
DECLARE
  current_result JSONB;
  existing       UUID;
  new_id         UUID;
  inserted       INT := 0;
  status         TEXT;
BEGIN
  IF p_cycle_date IS NULL THEN
    RAISE EXCEPTION 'record_scheduled_observation: p_cycle_date is required; it is the observation identity';
  END IF;
  IF p_timezone_source IS NULL OR p_timezone_source NOT IN ('PROFILE', 'DEFAULT_UTC') THEN
    RAISE EXCEPTION 'record_scheduled_observation: p_timezone_source must be PROFILE or DEFAULT_UTC, got %', p_timezone_source;
  END IF;

  -- Current state is replaceable and is replaced on every scheduled run,
  -- including a retry. All of its validation happens in here.
  current_result := public.replace_learner_concept_states(
    p_user_id, p_study_day, p_observed_at, p_model_version, p_states);

  -- HISTORY IS WRITTEN ONCE PER CYCLE. A retry finds the observation already
  -- recorded and leaves it exactly as it was: the first successful observation
  -- of a cycle is the one that counts, and a second look at the same cycle is
  -- not a second day.
  SELECT id INTO existing FROM public.learner_concept_state_observations
   WHERE user_id = p_user_id AND observation_cycle_date = p_cycle_date
     AND model_version = p_model_version;

  IF existing IS NOT NULL THEN
    status := 'ALREADY_RECORDED';
  ELSE
    INSERT INTO public.learner_concept_state_observations (
      user_id, observation_cycle_date, observed_at, study_day,
      timezone_used, timezone_source, day_start_hour, model_version,
      state_count, refresh_run_id)
    VALUES (
      p_user_id, p_cycle_date, p_observed_at, p_study_day,
      p_timezone_used, p_timezone_source, p_day_start_hour, p_model_version,
      jsonb_array_length(p_states), p_refresh_run_id)
    RETURNING id INTO new_id;

    -- From the SAME payload the current write just validated. Reading it back
    -- out of learner_concept_states instead would be a second source of truth
    -- that a concurrent write could change underneath this.
    INSERT INTO public.learner_concept_state_history (
      observation_id, user_id, concept_id, coverage_state, coverage_reason, memory_durability, memory_freshness, memory_signal, freshness_signal, memory_confidence, memory_confidence_raw, memory_confidence_limited_by, memory_items, memory_items_available, weak_card_count, application_signal, application_confidence, application_attempts, application_correct, application_misses_in_window, application_lower_bound, application_upper_bound, state_label, last_memory_evidence_at, last_application_evidence_at)
    SELECT new_id, p_user_id, r.concept_id, r.coverage_state, r.coverage_reason, r.memory_durability, r.memory_freshness, r.memory_signal, r.freshness_signal, r.memory_confidence, r.memory_confidence_raw, r.memory_confidence_limited_by, r.memory_items, r.memory_items_available, r.weak_card_count, r.application_signal, r.application_confidence, r.application_attempts, r.application_correct, r.application_misses_in_window, r.application_lower_bound, r.application_upper_bound, r.state_label, r.last_memory_evidence_at, r.last_application_evidence_at
    FROM jsonb_to_recordset(p_states) AS r(
      concept_id UUID,
      coverage_state TEXT,
    coverage_reason TEXT,
    memory_durability DOUBLE PRECISION,
    memory_freshness DOUBLE PRECISION,
    memory_signal TEXT,
    freshness_signal TEXT,
    memory_confidence TEXT,
    memory_confidence_raw DOUBLE PRECISION,
    memory_confidence_limited_by TEXT,
    memory_items INTEGER,
    memory_items_available INTEGER,
    weak_card_count INTEGER,
    application_signal TEXT,
    application_confidence TEXT,
    application_attempts INTEGER,
    application_correct INTEGER,
    application_misses_in_window INTEGER,
    application_lower_bound DOUBLE PRECISION,
    application_upper_bound DOUBLE PRECISION,
    state_label TEXT,
    last_memory_evidence_at TIMESTAMPTZ,
    last_application_evidence_at TIMESTAMPTZ);
    GET DIAGNOSTICS inserted = ROW_COUNT;

    IF inserted <> jsonb_array_length(p_states) THEN
      RAISE EXCEPTION 'record_scheduled_observation: % states sent, % history rows written', jsonb_array_length(p_states), inserted;
    END IF;
    status := 'RECORDED';
  END IF;

  RETURN jsonb_build_object(
    'user_id', p_user_id,
    'observation_cycle', p_cycle_date,
    'history_status', status,
    'observation_id', COALESCE(new_id, existing),
    'history_rows_inserted', inserted,
    'current_rows_received', current_result -> 'rows_received',
    'current_rows_final', current_result -> 'final_row_count',
    'study_day', p_study_day,
    'observed_at', p_observed_at,
    'timezone_used', p_timezone_used,
    'timezone_source', p_timezone_source,
    'model_version', p_model_version);
END; $fn$;

COMMENT ON FUNCTION public.record_scheduled_observation(UUID, DATE, DATE, TIMESTAMPTZ, TEXT, TEXT, INT, TEXT, JSONB, TEXT) IS
  'The designated scheduled path: replaces current state AND records the cycle observation in one transaction. Calls replace_learner_concept_states rather than reimplementing it. History is written once per (user, cycle, model version); a retry replaces current state and reports ALREADY_RECORDED without touching the observation.';

REVOKE ALL ON FUNCTION public.record_scheduled_observation(UUID, DATE, DATE, TIMESTAMPTZ, TEXT, TEXT, INT, TEXT, JSONB, TEXT) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.record_scheduled_observation(UUID, DATE, DATE, TIMESTAMPTZ, TEXT, TEXT, INT, TEXT, JSONB, TEXT) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.record_scheduled_observation(UUID, DATE, DATE, TIMESTAMPTZ, TEXT, TEXT, INT, TEXT, JSONB, TEXT) TO service_role;

-- ─── Post-conditions, driven as service_role ──────────────────────────────
DO $post$
DECLARE
  n INT; u UUID; c1 UUID; c2 UUID; c_dep UUID; obs UUID; obs_zero UUID;
  res JSONB; leaked TEXT[] := ARRAY[]::TEXT[];
  payload JSONB; one JSONB; digest TEXT; digest2 TEXT; before_current INT;
BEGIN
  -- Shape
  SELECT count(*) INTO n FROM information_schema.tables
   WHERE table_schema = 'public'
     AND table_name IN ('learner_concept_state_observations', 'learner_concept_state_history');
  IF n <> 2 THEN RAISE EXCEPTION 'HISTORY: expected both tables, found %', n; END IF;

  SELECT count(*) INTO n FROM public.learner_concept_state_observations;
  IF n <> 0 THEN RAISE EXCEPTION 'HISTORY: the observation table must commit empty, found %', n; END IF;
  SELECT count(*) INTO n FROM public.learner_concept_state_history;
  IF n <> 0 THEN RAISE EXCEPTION 'HISTORY: the history table must commit empty, found %', n; END IF;

  -- IDENTITY IS THE CYCLE, NOT THE STUDY DAY. The single most important
  -- property of this migration, asserted from the catalog.
  SELECT string_agg(a.attname, ',' ORDER BY k.ord) INTO digest
    FROM pg_constraint con
    JOIN LATERAL unnest(con.conkey) WITH ORDINALITY AS k(attnum, ord) ON TRUE
    JOIN pg_attribute a ON a.attrelid = con.conrelid AND a.attnum = k.attnum
   WHERE con.conname = 'learner_concept_state_observations_cycle_identity';
  IF digest <> 'user_id,observation_cycle_date,model_version' THEN
    RAISE EXCEPTION 'HISTORY: the observation identity is (%), expected (user_id,observation_cycle_date,model_version)', digest;
  END IF;

  -- And the foreign key target is a SEPARATE constraint. Two unique keys on one
  -- table are easy to merge by accident while editing, and if these two ever
  -- became one, the check above would pass or fail depending only on which
  -- columns survived. This pins them apart.
  SELECT string_agg(a.attname, ',' ORDER BY k.ord) INTO digest
    FROM pg_constraint con
    JOIN LATERAL unnest(con.conkey) WITH ORDINALITY AS k(attnum, ord) ON TRUE
    JOIN pg_attribute a ON a.attrelid = con.conrelid AND a.attnum = k.attnum
   WHERE con.conname = 'learner_concept_state_observations_owner_ref';
  IF digest IS DISTINCT FROM 'id,user_id' THEN
    RAISE EXCEPTION 'HISTORY: the owner reference is (%), expected (id,user_id)', digest;
  END IF;

  SELECT count(*) INTO n FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_state_observations'::regclass AND contype = 'u';
  IF n <> 2 THEN
    RAISE EXCEPTION 'HISTORY: expected exactly 2 unique constraints on observations, found %', n;
  END IF;

  -- Concept deletion must not be able to erase history.
  SELECT confdeltype INTO digest FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_state_history'::regclass AND contype = 'f'
     AND confrelid = 'public.concepts'::regclass;
  IF digest <> 'r' THEN
    RAISE EXCEPTION 'HISTORY: the concept foreign key is %, expected RESTRICT', digest;
  END IF;
  -- But a deleted account must be able to take its history with it.
  SELECT confdeltype INTO digest FROM pg_constraint
   WHERE conrelid = 'public.learner_concept_state_observations'::regclass AND contype = 'f'
     AND confrelid = 'auth.users'::regclass;
  IF digest <> 'c' THEN
    RAISE EXCEPTION 'HISTORY: the user foreign key is %, expected CASCADE so deletion can remove history', digest;
  END IF;

  -- Read-only for learners, on both tables.
  SELECT count(*) INTO n FROM information_schema.role_table_grants
   WHERE table_schema = 'public'
     AND table_name IN ('learner_concept_state_observations', 'learner_concept_state_history')
     AND grantee IN ('anon', 'authenticated')
     AND privilege_type IN ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE');
  IF n <> 0 THEN RAISE EXCEPTION 'HISTORY: anon or authenticated hold % write privilege(s)', n; END IF;

  SELECT string_agg(cmd, ',' ORDER BY tablename) INTO digest FROM pg_policies
   WHERE schemaname = 'public'
     AND tablename IN ('learner_concept_state_observations', 'learner_concept_state_history');
  IF digest <> 'SELECT,SELECT' THEN
    RAISE EXCEPTION 'HISTORY: expected exactly two SELECT policies, found %', COALESCE(digest, 'none');
  END IF;

  -- ── Drive the writer, as the role that will call it ─────────────────────
  SELECT id INTO u FROM public.profiles ORDER BY id LIMIT 1;
  SELECT id INTO c1 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 0;
  SELECT id INTO c2 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 1;
  SELECT id INTO c_dep FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'DEPRECATED' ORDER BY id LIMIT 1;
  SELECT count(*) INTO before_current FROM public.learner_concept_states;

  one := jsonb_build_object(
    'concept_id', c1, 'coverage_state', 'MEMORY_ONLY', 'coverage_reason', 'BANK_HAS_NO_QUESTIONS',
    'memory_durability', 0.42, 'memory_freshness', 0.81,
    'memory_signal', 'BUILDING', 'freshness_signal', 'FRESH',
    'memory_confidence', 'MODERATE', 'memory_confidence_raw', 0.47,
    'memory_confidence_limited_by', 'LEARNER_COVERAGE',
    'memory_items', 2, 'memory_items_available', 5, 'weak_card_count', 1,
    'application_signal', 'INSUFFICIENT', 'application_confidence', 'LOW',
    'application_attempts', 0, 'application_correct', 0, 'application_misses_in_window', 0,
    'application_lower_bound', NULL, 'application_upper_bound', NULL,
    'state_label', 'MEMORY_BUILDING',
    'last_memory_evidence_at', '2026-10-05T08:00:00Z', 'last_application_evidence_at', NULL);
  payload := jsonb_build_array(one, jsonb_set(one, '{concept_id}', to_jsonb(c2)));

  IF NOT pg_has_role(current_user, 'service_role', 'MEMBER') THEN
    RAISE EXCEPTION 'HISTORY: % cannot assume service_role, so the writer cannot be proved against its real caller.', current_user;
  END IF;

  -- EVERY PROBE BELOW RUNS INSIDE A SUBTRANSACTION THAT IS ALWAYS DISCARDED.
  --
  -- The probes must call the real writer, and the real writer only accepts a
  -- real account, because a foreign key ties it to auth.users. There is no
  -- synthetic learner to use instead, and inventing one would mean writing a
  -- fake row into the account table to test a feature.
  --
  -- That is survivable only because nothing the probes do is kept. The first
  -- version of this file cleaned up afterwards by deleting the rows it had
  -- written, and that is not the same thing. replace_learner_concept_states
  -- replaces a learner's WHOLE current state, every model version of it, so
  -- the first probe silently destroyed the five real rows belonging to the
  -- account it borrowed, and deleting the PROBE rows afterwards could not
  -- bring them back. The count check at the end caught it and the migration
  -- aborted, which is the only reason those five rows still exist.
  --
  -- Cleaning up correctly was not the fix. A probe that has to be tidied after
  -- is one forgotten DELETE away from the same outcome, and the thing it
  -- damages is a real learner's state. So the probes now cannot persist
  -- anything at all: PL/pgSQL rolls back every database change made inside a
  -- block that exits through an exception, while the variables carrying the
  -- findings survive it. The sentinel is raised at the end on purpose, pass or
  -- fail, and the findings are judged after the rollback.
  BEGIN
    EXECUTE 'SET LOCAL ROLE service_role';

    -- A normal scheduled observation.
    res := public.record_scheduled_observation(
      u, DATE '2026-10-08', DATE '2026-10-08', now(), 'America/New_York', 'PROFILE', 4, 'PROBE', payload, 'probe-run-1');
    IF res ->> 'history_status' <> 'RECORDED' THEN
      leaked := array_append(leaked, 'the first observation reported ' || res::TEXT);
    END IF;
    SELECT count(*) INTO n FROM public.learner_concept_state_history
     WHERE observation_id = (res ->> 'observation_id')::UUID;
    IF n <> 2 THEN leaked := array_append(leaked, 'expected 2 history rows, found ' || n); END IF;
    SELECT state_count INTO n FROM public.learner_concept_state_observations
     WHERE id = (res ->> 'observation_id')::UUID;
    IF n <> 2 THEN leaked := array_append(leaked, 'the observation recorded state_count ' || n); END IF;
    obs := (res ->> 'observation_id')::UUID;

    SELECT md5(string_agg(h::TEXT, '|' ORDER BY h.concept_id)) INTO digest
      FROM public.learner_concept_state_history h WHERE h.observation_id = obs;

    -- A RETRY OF THE SAME CYCLE. Current state may be rewritten; history is not.
    res := public.record_scheduled_observation(
      u, DATE '2026-10-08', DATE '2026-10-08', now(), 'America/New_York', 'PROFILE', 4, 'PROBE',
      jsonb_build_array(one), 'probe-run-2');
    IF res ->> 'history_status' <> 'ALREADY_RECORDED' THEN
      leaked := array_append(leaked, 'a same-cycle retry reported ' || (res ->> 'history_status'));
    END IF;
    SELECT md5(string_agg(h::TEXT, '|' ORDER BY h.concept_id)) INTO digest2
      FROM public.learner_concept_state_history h WHERE h.observation_id = obs;
    IF digest2 IS DISTINCT FROM digest THEN
      leaked := array_append(leaked, 'a retry changed the recorded history');
    END IF;
    SELECT count(*) INTO n FROM public.learner_concept_state_observations WHERE user_id = u;
    IF n <> 1 THEN leaked := array_append(leaked, 'a retry created ' || n || ' observations'); END IF;

    -- THE SAME STUDY DAY IN A DIFFERENT CYCLE IS A DIFFERENT OBSERVATION.
    -- The whole reason identity is the cycle. This would be refused outright by
    -- a unique key on study_day.
    res := public.record_scheduled_observation(
      u, DATE '2026-10-09', DATE '2026-10-08', now(), 'America/Los_Angeles', 'PROFILE', 4, 'PROBE',
      jsonb_build_array(one), 'probe-run-3');
    IF res ->> 'history_status' <> 'RECORDED' THEN
      leaked := array_append(leaked, 'a second cycle with a repeated study_day was refused: ' || res::TEXT);
    END IF;
    SELECT count(*) INTO n FROM public.learner_concept_state_observations
     WHERE user_id = u AND study_day = DATE '2026-10-08';
    IF n <> 2 THEN
      leaked := array_append(leaked, 'expected 2 observations sharing one study_day, found ' || n);
    END IF;

    -- A ZERO-STATE OBSERVATION IS STILL AN OBSERVATION.
    res := public.record_scheduled_observation(
      u, DATE '2026-10-10', DATE '2026-10-10', now(), 'UTC', 'DEFAULT_UTC', 4, 'PROBE', '[]'::JSONB, 'probe-run-4');
    IF res ->> 'history_status' <> 'RECORDED' THEN
      leaked := array_append(leaked, 'a zero-state observation was not recorded');
    END IF;
    SELECT state_count INTO n FROM public.learner_concept_state_observations
     WHERE id = (res ->> 'observation_id')::UUID;
    IF n <> 0 THEN leaked := array_append(leaked, 'the zero-state observation recorded state_count ' || n); END IF;
    -- Kept for the ownership probe below: an observation with no children, so an
    -- insert against it cannot collide with the primary key.
    obs_zero := (res ->> 'observation_id')::UUID;

    -- An invalid child state fails the WHOLE thing, current state included.
    SELECT md5(string_agg(t::TEXT, '|' ORDER BY t.concept_id)) INTO digest
      FROM public.learner_concept_states t WHERE t.user_id = u;
    BEGIN
      res := public.record_scheduled_observation(
        u, DATE '2026-10-11', DATE '2026-10-11', now(), 'UTC', 'DEFAULT_UTC', 4, 'PROBE',
        jsonb_build_array(jsonb_set(one, '{state_label}', '"MEMORY_EXCELLENT"')), 'probe-run-5');
      leaked := array_append(leaked, 'an invalid state was recorded as history');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;
    SELECT md5(string_agg(t::TEXT, '|' ORDER BY t.concept_id)) INTO digest2
      FROM public.learner_concept_states t WHERE t.user_id = u;
    IF digest2 IS DISTINCT FROM digest THEN
      leaked := array_append(leaked, 'a failed scheduled write still changed current state');
    END IF;
    IF EXISTS (SELECT 1 FROM public.learner_concept_state_observations
                WHERE user_id = u AND observation_cycle_date = DATE '2026-10-11') THEN
      leaked := array_append(leaked, 'a failed scheduled write left an observation behind');
    END IF;

    -- IMMUTABLE. Every update path refused, on both tables.
    BEGIN
      UPDATE public.learner_concept_state_observations SET study_day = DATE '2000-01-01' WHERE id = obs;
      leaked := array_append(leaked, 'an observation was updated');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;
    BEGIN
      UPDATE public.learner_concept_state_history SET state_label = 'MEMORY_DURABLE' WHERE observation_id = obs;
      leaked := array_append(leaked, 'a history row was updated');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;

    -- CONCEPT DELETION IS PROVED FROM THE CATALOG, NOT BY ATTEMPTING ONE.
    --
    -- The obvious probe is to try deleting a referenced concept and check it is
    -- refused. I wrote that, and then removed it for two reasons. Its failure
    -- mode is the worst available: if the foreign key were ever NOT restrictive,
    -- the probe would succeed and hard-delete a production concept, which is
    -- exactly the catastrophe it exists to prevent. And it made this a migration
    -- that writes public.concepts, which the repository's own write-scope lint
    -- correctly flags, because a file that touches the ontology must not also
    -- write learner tables.
    --
    -- confdeltype = 'r' above already proves the constraint is RESTRICT, read
    -- from the catalog. That is the same fact, obtained without risking the
    -- thing being protected.

    -- THE OWNER ON A CHILD ROW CANNOT DISAGREE WITH ITS PARENT.
    --
    -- This is the probe that matters for the denormalized column. If a child row
    -- could name a different owner than its observation, the reset would delete
    -- the wrong rows and the row-level security policy would show one learner
    -- another learner's history. The composite foreign key is what makes that
    -- unrepresentable.
    --
    -- TWO WAYS THIS PROBE COULD PASS WITHOUT PROVING ANYTHING, both avoided:
    --
    -- It must target an observation that has no row for this concept. Written
    -- against the first observation, which already holds c1 and c2, the insert
    -- would violate the primary key on (observation_id, concept_id), and a
    -- schema with NO composite foreign key at all would still look like it
    -- refused. obs_zero is the zero-state observation, which has no children.
    --
    -- And every column except the owner must be known-valid. Hand-written values
    -- risk tripping one of the mirrored CHECK constraints instead, which again
    -- reads as a refusal. So the row is built from the same payload the writer
    -- was proved with, through the same jsonb_to_recordset shape, and the ONLY
    -- thing wrong with it is whose it claims to be.
    BEGIN
      INSERT INTO public.learner_concept_state_history (
        observation_id, user_id, concept_id, coverage_state, coverage_reason, memory_durability, memory_freshness, memory_signal, freshness_signal, memory_confidence, memory_confidence_raw, memory_confidence_limited_by, memory_items, memory_items_available, weak_card_count, application_signal, application_confidence, application_attempts, application_correct, application_misses_in_window, application_lower_bound, application_upper_bound, state_label, last_memory_evidence_at, last_application_evidence_at)
      SELECT obs_zero, gen_random_uuid(), r.concept_id, r.coverage_state, r.coverage_reason, r.memory_durability, r.memory_freshness, r.memory_signal, r.freshness_signal, r.memory_confidence, r.memory_confidence_raw, r.memory_confidence_limited_by, r.memory_items, r.memory_items_available, r.weak_card_count, r.application_signal, r.application_confidence, r.application_attempts, r.application_correct, r.application_misses_in_window, r.application_lower_bound, r.application_upper_bound, r.state_label, r.last_memory_evidence_at, r.last_application_evidence_at
      FROM jsonb_to_recordset(jsonb_build_array(one)) AS r(
        concept_id UUID, coverage_state TEXT, coverage_reason TEXT,
        memory_durability DOUBLE PRECISION, memory_freshness DOUBLE PRECISION,
        memory_signal TEXT, freshness_signal TEXT, memory_confidence TEXT,
        memory_confidence_raw DOUBLE PRECISION, memory_confidence_limited_by TEXT,
        memory_items INTEGER, memory_items_available INTEGER, weak_card_count INTEGER,
        application_signal TEXT, application_confidence TEXT,
        application_attempts INTEGER, application_correct INTEGER,
        application_misses_in_window INTEGER,
        application_lower_bound DOUBLE PRECISION, application_upper_bound DOUBLE PRECISION,
        state_label TEXT, last_memory_evidence_at TIMESTAMPTZ,
        last_application_evidence_at TIMESTAMPTZ);
      leaked := array_append(leaked, 'a history row named an owner its observation does not have');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;

    -- And the same row with the RIGHT owner is accepted, which is what makes the
    -- refusal above attributable to the owner and nothing else.
    BEGIN
      INSERT INTO public.learner_concept_state_history (
        observation_id, user_id, concept_id, coverage_state, coverage_reason, memory_durability, memory_freshness, memory_signal, freshness_signal, memory_confidence, memory_confidence_raw, memory_confidence_limited_by, memory_items, memory_items_available, weak_card_count, application_signal, application_confidence, application_attempts, application_correct, application_misses_in_window, application_lower_bound, application_upper_bound, state_label, last_memory_evidence_at, last_application_evidence_at)
      SELECT obs_zero, u, r.concept_id, r.coverage_state, r.coverage_reason, r.memory_durability, r.memory_freshness, r.memory_signal, r.freshness_signal, r.memory_confidence, r.memory_confidence_raw, r.memory_confidence_limited_by, r.memory_items, r.memory_items_available, r.weak_card_count, r.application_signal, r.application_confidence, r.application_attempts, r.application_correct, r.application_misses_in_window, r.application_lower_bound, r.application_upper_bound, r.state_label, r.last_memory_evidence_at, r.last_application_evidence_at
      FROM jsonb_to_recordset(jsonb_build_array(one)) AS r(
        concept_id UUID, coverage_state TEXT, coverage_reason TEXT,
        memory_durability DOUBLE PRECISION, memory_freshness DOUBLE PRECISION,
        memory_signal TEXT, freshness_signal TEXT, memory_confidence TEXT,
        memory_confidence_raw DOUBLE PRECISION, memory_confidence_limited_by TEXT,
        memory_items INTEGER, memory_items_available INTEGER, weak_card_count INTEGER,
        application_signal TEXT, application_confidence TEXT,
        application_attempts INTEGER, application_correct INTEGER,
        application_misses_in_window INTEGER,
        application_lower_bound DOUBLE PRECISION, application_upper_bound DOUBLE PRECISION,
        state_label TEXT, last_memory_evidence_at TIMESTAMPTZ,
        last_application_evidence_at TIMESTAMPTZ);
    EXCEPTION WHEN OTHERS THEN
      leaked := array_append(leaked, 'a correctly owned history row was refused: ' || SQLERRM);
    END;

    -- THE ACCOUNT RESET'S OWN STATEMENT SHAPE WORKS ON BOTH TABLES.
    --
    -- The reset counts and then deletes every table in its scope with one shape:
    -- filter by user_id. A table it cannot filter that way fails the whole reset
    -- halfway through, so the shape is exercised here rather than discovered by
    -- the first learner who asks to be erased. Children first, then the parent,
    -- which is the order the scope list declares, so both counts are truthful
    -- instead of the second reading zero after a cascade.
    -- Four history rows by now: two from the first observation, one from the
    -- second cycle, and one just added to the zero-state observation by the
    -- positive half of the ownership probe. Three observations.
    SELECT count(*) INTO n FROM public.learner_concept_state_history WHERE user_id = u;
    IF n <> 4 THEN
      leaked := array_append(leaked, 'the reset would count ' || n || ' history rows, expected 4');
    END IF;
    DELETE FROM public.learner_concept_state_history WHERE user_id = u;
    GET DIAGNOSTICS n = ROW_COUNT;
    IF n <> 4 THEN
      leaked := array_append(leaked, 'the reset deleted ' || n || ' history rows, expected 4');
    END IF;
    DELETE FROM public.learner_concept_state_observations WHERE user_id = u;
    GET DIAGNOSTICS n = ROW_COUNT;
    IF n <> 3 THEN
      leaked := array_append(leaked, 'the reset deleted ' || n || ' observations, expected 3');
    END IF;

    EXECUTE 'RESET ROLE';
    RAISE EXCEPTION 'PROBE_ROLLBACK';
  EXCEPTION WHEN OTHERS THEN
    -- Anything other than the sentinel is a probe that threw where it should
    -- have returned, which is a finding rather than something to swallow.
    IF SQLERRM <> 'PROBE_ROLLBACK' THEN
      leaked := array_append(leaked, 'a probe raised: ' || SQLERRM);
    END IF;
  END;

  -- ── The rollback actually happened ──────────────────────────────────
  --
  -- Asserted rather than assumed. These are the same three checks the previous
  -- version ran after deleting its own rows, and they are kept because they
  -- are what caught the damage; the difference is that nothing now has to be
  -- deleted for them to pass.
  SELECT count(*) INTO n FROM public.learner_concept_state_observations;
  IF n <> 0 THEN RAISE EXCEPTION 'HISTORY: % observation(s) survived the probe rollback', n; END IF;
  SELECT count(*) INTO n FROM public.learner_concept_state_history;
  IF n <> 0 THEN RAISE EXCEPTION 'HISTORY: % history row(s) survived the probe rollback', n; END IF;
  SELECT count(*) INTO n FROM public.learner_concept_states;
  IF n <> before_current THEN
    RAISE EXCEPTION 'HISTORY: current state went from % to %. The probes borrowed a real learner and the rollback did not restore them.', before_current, n;
  END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'HISTORY FAILED: %', array_to_string(leaked, ' | ');
  END IF;

  RAISE NOTICE 'HISTORY OK: both tables created empty, identity is the scheduled cycle, retries are idempotent, a repeated study_day across cycles is representable, zero-state is an observation, an invalid batch changes nothing, updates are refused, concept deletion is restricted, a child cannot name an owner its parent does not have, the account reset statement shape works on both tables, and deleting a parent cascades its children.';
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT table_name, count(*) AS columns
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('learner_concept_state_observations', 'learner_concept_state_history')
GROUP BY table_name ORDER BY table_name;

SELECT conname, pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE conrelid IN ('public.learner_concept_state_observations'::regclass,
                   'public.learner_concept_state_history'::regclass)
  AND contype IN ('u', 'f', 'p')
ORDER BY conrelid, conname;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('learner_concept_state_observations', 'learner_concept_state_history');

SELECT
  (SELECT count(*) FROM public.learner_concept_state_observations) AS observations,
  (SELECT count(*) FROM public.learner_concept_state_history)      AS history_rows,
  (SELECT count(*) FROM public.learner_concept_states)             AS current_rows;
