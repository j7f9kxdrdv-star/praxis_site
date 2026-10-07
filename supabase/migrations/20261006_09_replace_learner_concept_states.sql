-- ─── Phase 2 step 7: the atomic writer ─────────────────────────────────────
-- REQUIRES: 20261006_08_learner_concept_states.sql
--
-- ONE function, which replaces a learner's whole current concept state in one
-- transaction. No table is created, no learner row is written by this file: it
-- installs the writer and proves it on disposable fixtures that are rolled
-- back before it commits.
--
-- WHY A DATABASE FUNCTION AND NOT TWO REQUESTS. Replacing current state is two
-- operations, an upsert of everything the model now says and a delete of the
-- rows for concepts it no longer mentions, and they are only correct together.
-- Through PostgREST they would be two HTTP requests with no transaction around
-- them, and either order has a failure that lands a learner somewhere false:
--
--   upsert, then the delete fails   state the model no longer believes, kept
--                                   beside state it does, with nothing on the
--                                   row to say which is which
--   delete, then the upsert fails   a learner with real study history reads as
--                                   a beginner until someone notices
--
-- Both are silent. Neither is recoverable by retrying, because the retry has
-- no idea what the first attempt managed. So the two statements live inside
-- one function and share its transaction, and a failure anywhere leaves the
-- learner exactly as they were.
--
-- WHY SECURITY INVOKER. A SECURITY DEFINER function would run as its owner and
-- bypass the row-level security the step 6 migration just installed, which is
-- a write path around the policy rather than through it. It is not needed:
-- service_role already holds the table privileges and already bypasses RLS, so
-- the plain function does the job, and an authenticated caller who somehow
-- obtained EXECUTE would still be stopped by the table's own privileges and
-- policies. The weaker function is the safer one here, so this takes it, and
-- the probes below drive both halves of that claim.
--
-- WHAT IT VALIDATES, AND WHAT IT DELIBERATELY DOES NOT. It checks the SHAPE of
-- the batch: the learner exists, the batch facts are present, the payload is
-- an array of objects carrying exactly the 23 per-concept keys, no concept
-- appears twice, and every concept is a learner-facing CONTENT object. It does
-- NOT re-check the model's own rules. The table already holds 17 CHECK
-- constraints and the ACTIVE CONTENT trigger, and a second copy of those rules
-- in PL/pgSQL would be a second model that could disagree with the first.
--
-- One model, one persistence contract, no SQL reimplementation of
-- buildConceptStates().

BEGIN;

CREATE OR REPLACE FUNCTION public.replace_learner_concept_states(
  p_user_id       UUID,
  p_study_day     DATE,
  p_computed_at   TIMESTAMPTZ,
  p_model_version TEXT,
  p_states        JSONB
) RETURNS JSONB
LANGUAGE plpgsql
SECURITY INVOKER
-- A fixed search_path even without SECURITY DEFINER: the body names public
-- tables and pg_catalog functions, and leaving the path to the caller is how a
-- function ends up resolving a name to something it did not mean.
SET search_path = public, pg_catalog
AS $fn$
DECLARE
  n_received INT;
  n_upserted INT;
  n_deleted  INT;
  n_final    INT;
  bad        TEXT;
  -- The 23 keys a payload row may carry. user_id, study_day, computed_at and
  -- model_version are NOT among them: they are the arguments above, so a batch
  -- cannot disagree with itself about which learner, which day or which model
  -- it belongs to.
  allowed    TEXT[] := ARRAY[
    'concept_id', 'coverage_state', 'coverage_reason',
    'memory_durability', 'memory_freshness', 'memory_signal', 'freshness_signal',
    'memory_confidence', 'memory_confidence_raw', 'memory_confidence_limited_by',
    'memory_items', 'memory_items_available', 'weak_card_count',
    'application_signal', 'application_confidence', 'application_attempts',
    'application_correct', 'application_misses_in_window',
    'application_lower_bound', 'application_upper_bound',
    'state_label', 'last_memory_evidence_at', 'last_application_evidence_at'
  ];
BEGIN
  -- ── The batch facts ─────────────────────────────────────────────────────
  IF p_user_id IS NULL THEN RAISE EXCEPTION 'replace_learner_concept_states: p_user_id is required'; END IF;
  IF p_study_day IS NULL THEN RAISE EXCEPTION 'replace_learner_concept_states: p_study_day is required'; END IF;
  IF p_computed_at IS NULL THEN RAISE EXCEPTION 'replace_learner_concept_states: p_computed_at is required'; END IF;
  IF p_model_version IS NULL OR btrim(p_model_version) = '' THEN
    RAISE EXCEPTION 'replace_learner_concept_states: p_model_version must say which model produced these states';
  END IF;
  IF p_states IS NULL OR jsonb_typeof(p_states) <> 'array' THEN
    RAISE EXCEPTION 'replace_learner_concept_states: p_states must be a JSON array, got %',
      COALESCE(jsonb_typeof(p_states), 'null');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE id = p_user_id) THEN
    RAISE EXCEPTION 'replace_learner_concept_states: no such user %', p_user_id;
  END IF;

  n_received := jsonb_array_length(p_states);

  -- ── SERIALISE PER LEARNER, NOT GLOBALLY ────────────────────────────────
  -- Two recomputations racing for one learner could interleave the stale
  -- delete of one with the upsert of the other and leave a hybrid that is
  -- neither run's answer. The lock is transaction-scoped, so it releases on
  -- commit or rollback with nothing to clean up, and it is keyed on the user,
  -- so two different learners never wait for each other. A hash collision
  -- between two user ids costs one of them a short wait and can never produce
  -- a wrong answer.
  PERFORM pg_advisory_xact_lock(hashtext('learner_concept_states'), hashtext(p_user_id::text));

  -- ── Validate the whole batch BEFORE touching anything ───────────────────
  -- Every check below runs over the payload, not over the table. Nothing has
  -- been written yet, so a refusal here leaves the learner exactly as they
  -- were without relying on the rollback to undo a partial write.
  IF EXISTS (SELECT 1 FROM jsonb_array_elements(p_states) e WHERE jsonb_typeof(e) <> 'object') THEN
    RAISE EXCEPTION 'replace_learner_concept_states: every element of p_states must be an object';
  END IF;

  -- Exactly the allowed keys, in both directions. A missing key would arrive
  -- as NULL and a misspelled one would be ignored in silence, and for a
  -- nullable column that means a state quietly losing a value it had.
  SELECT string_agg(DISTINCT k, ', ') INTO bad
    FROM jsonb_array_elements(p_states) e, jsonb_object_keys(e) k
   WHERE NOT (k = ANY(allowed));
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'replace_learner_concept_states: payload carries unknown key(s): %. The batch facts (user, study day, computed_at, model version) are function arguments, not row fields.', bad;
  END IF;
  SELECT string_agg(DISTINCT k, ', ') INTO bad
    FROM jsonb_array_elements(p_states) e, unnest(allowed) k
   WHERE NOT (e ? k);
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'replace_learner_concept_states: payload is missing key(s): %', bad;
  END IF;

  SELECT string_agg(concept_id::TEXT, ', ') INTO bad FROM (
    SELECT (e ->> 'concept_id')::UUID AS concept_id
      FROM jsonb_array_elements(p_states) e
     GROUP BY 1 HAVING count(*) > 1) d;
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'replace_learner_concept_states: concept(s) appear twice in one batch: %', bad;
  END IF;

  -- The ACTIVE CONTENT trigger would catch this one row at a time. Checking it
  -- here instead names every offending concept in one message, which is the
  -- difference between one fix and twenty round trips.
  SELECT string_agg(e ->> 'concept_id', ', ') INTO bad
    FROM jsonb_array_elements(p_states) e
    LEFT JOIN public.concepts c ON c.id = (e ->> 'concept_id')::UUID
   WHERE c.id IS NULL OR c.object_type <> 'CONTENT' OR c.status <> 'ACTIVE_SEED';
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'replace_learner_concept_states: these are not learner-facing CONTENT concepts: %', bad;
  END IF;

  -- ── Replace ─────────────────────────────────────────────────────────────
  -- Stale first: rows for THIS learner whose concept the model no longer
  -- mentions. An empty payload therefore clears the learner completely, which
  -- is the correct reading of "the model now says nothing about you".
  --
  -- Keyed on concept_id alone. A row carrying an older model_version whose
  -- concept IS in the batch is not stale, it is about to be replaced by the
  -- upsert below.
  DELETE FROM public.learner_concept_states s
   WHERE s.user_id = p_user_id
     AND NOT EXISTS (
       SELECT 1 FROM jsonb_array_elements(p_states) e
        WHERE (e ->> 'concept_id')::UUID = s.concept_id);
  GET DIAGNOSTICS n_deleted = ROW_COUNT;

  INSERT INTO public.learner_concept_states AS t (
    user_id, concept_id, coverage_state, coverage_reason,
    memory_durability, memory_freshness, memory_signal, freshness_signal,
    memory_confidence, memory_confidence_raw, memory_confidence_limited_by,
    memory_items, memory_items_available, weak_card_count,
    application_signal, application_confidence, application_attempts,
    application_correct, application_misses_in_window,
    application_lower_bound, application_upper_bound,
    state_label, last_memory_evidence_at, last_application_evidence_at,
    model_version, study_day, computed_at)
  SELECT
    p_user_id, r.concept_id, r.coverage_state, r.coverage_reason,
    r.memory_durability, r.memory_freshness, r.memory_signal, r.freshness_signal,
    r.memory_confidence, r.memory_confidence_raw, r.memory_confidence_limited_by,
    r.memory_items, r.memory_items_available, r.weak_card_count,
    r.application_signal, r.application_confidence, r.application_attempts,
    r.application_correct, r.application_misses_in_window,
    r.application_lower_bound, r.application_upper_bound,
    r.state_label, r.last_memory_evidence_at, r.last_application_evidence_at,
    p_model_version, p_study_day, p_computed_at
  FROM jsonb_to_recordset(p_states) AS r(
    concept_id UUID, coverage_state TEXT, coverage_reason TEXT,
    memory_durability DOUBLE PRECISION, memory_freshness DOUBLE PRECISION,
    memory_signal TEXT, freshness_signal TEXT,
    memory_confidence TEXT, memory_confidence_raw DOUBLE PRECISION,
    memory_confidence_limited_by TEXT,
    memory_items INT, memory_items_available INT, weak_card_count INT,
    application_signal TEXT, application_confidence TEXT,
    application_attempts INT, application_correct INT, application_misses_in_window INT,
    application_lower_bound DOUBLE PRECISION, application_upper_bound DOUBLE PRECISION,
    state_label TEXT, last_memory_evidence_at TIMESTAMPTZ, last_application_evidence_at TIMESTAMPTZ)
  ON CONFLICT (user_id, concept_id) DO UPDATE SET
    coverage_state = EXCLUDED.coverage_state,
    coverage_reason = EXCLUDED.coverage_reason,
    memory_durability = EXCLUDED.memory_durability,
    memory_freshness = EXCLUDED.memory_freshness,
    memory_signal = EXCLUDED.memory_signal,
    freshness_signal = EXCLUDED.freshness_signal,
    memory_confidence = EXCLUDED.memory_confidence,
    memory_confidence_raw = EXCLUDED.memory_confidence_raw,
    memory_confidence_limited_by = EXCLUDED.memory_confidence_limited_by,
    memory_items = EXCLUDED.memory_items,
    memory_items_available = EXCLUDED.memory_items_available,
    weak_card_count = EXCLUDED.weak_card_count,
    application_signal = EXCLUDED.application_signal,
    application_confidence = EXCLUDED.application_confidence,
    application_attempts = EXCLUDED.application_attempts,
    application_correct = EXCLUDED.application_correct,
    application_misses_in_window = EXCLUDED.application_misses_in_window,
    application_lower_bound = EXCLUDED.application_lower_bound,
    application_upper_bound = EXCLUDED.application_upper_bound,
    state_label = EXCLUDED.state_label,
    last_memory_evidence_at = EXCLUDED.last_memory_evidence_at,
    last_application_evidence_at = EXCLUDED.last_application_evidence_at,
    model_version = EXCLUDED.model_version,
    study_day = EXCLUDED.study_day,
    computed_at = EXCLUDED.computed_at;
  GET DIAGNOSTICS n_upserted = ROW_COUNT;

  SELECT count(*) INTO n_final FROM public.learner_concept_states WHERE user_id = p_user_id;

  -- The caller must not have to infer success from HTTP 200. These are the
  -- numbers the database actually did, read back from the statements.
  RETURN jsonb_build_object(
    'user_id', p_user_id,
    'rows_received', n_received,
    'rows_upserted', n_upserted,
    'rows_deleted', n_deleted,
    'final_row_count', n_final,
    'model_version', p_model_version,
    'study_day', p_study_day,
    'computed_at', p_computed_at);
END; $fn$;

COMMENT ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) IS
  'Replaces one learner''s whole current concept state in a single transaction: upserts every state in the payload on (user_id, concept_id) and deletes that learner''s rows for concepts the payload does not mention. An empty payload clears the learner. Service tooling only. Validates batch shape; row-level integrity is left to the table''s own constraints, so there is no second copy of the model in SQL.';

-- ─── Who may run it ────────────────────────────────────────────────────────
-- A function is EXECUTE-able by PUBLIC by default, which would put a writer in
-- reach of every signed-in learner. It is taken back first and granted only to
-- service tooling. SECURITY INVOKER means even a mistaken grant would not be
-- enough on its own, because the body still runs under the caller's own
-- privileges and policies — but defence in depth is the point, not an excuse
-- to leave the grant open.
REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) TO service_role;

-- ─── Post-conditions ───────────────────────────────────────────────────────
DO $post$
DECLARE
  n       INT;
  u_a     UUID;
  u_b     UUID;
  c1      UUID;
  c2      UUID;
  c3      UUID;
  c_dep   UUID;
  leaked  TEXT[] := ARRAY[]::TEXT[];
  res     JSONB;
  before  INT;
  digest  TEXT;
  digest2 TEXT;
  users   INT;
  state   TEXT;
  payload JSONB;
BEGIN
  -- ── Shape ───────────────────────────────────────────────────────────────
  SELECT count(*) INTO n FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
   WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';
  IF n <> 1 THEN RAISE EXCEPTION 'STEP 7: expected exactly one writer function, found %', n; END IF;

  SELECT p.prosecdef::TEXT INTO state FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
   WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';
  IF state <> 'false' THEN
    RAISE EXCEPTION 'STEP 7: the writer is SECURITY DEFINER, which would bypass the row-level security installed in step 6';
  END IF;

  SELECT array_to_string(p.proconfig, ' ') INTO state FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
   WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';
  IF state IS NULL OR position('search_path=' IN state) = 0 THEN
    RAISE EXCEPTION 'STEP 7: the writer has no fixed search_path: %', COALESCE(state, 'none');
  END IF;

  IF has_function_privilege('anon', 'public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB)', 'EXECUTE')
     OR has_function_privilege('authenticated', 'public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB)', 'EXECUTE') THEN
    RAISE EXCEPTION 'STEP 7: anon or authenticated can execute the writer';
  END IF;
  IF NOT has_function_privilege('service_role', 'public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB)', 'EXECUTE') THEN
    RAISE EXCEPTION 'STEP 7: service_role cannot execute the writer';
  END IF;

  -- ── Fixtures, read-only, from whatever the database holds ───────────────
  SELECT count(*) INTO users FROM auth.users;
  SELECT id INTO u_a FROM auth.users ORDER BY id LIMIT 1;
  SELECT id INTO u_b FROM auth.users WHERE id <> u_a ORDER BY id LIMIT 1;
  SELECT id INTO c1 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 0;
  SELECT id INTO c2 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 1;
  SELECT id INTO c3 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 2;
  SELECT id INTO c_dep FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'DEPRECATED' ORDER BY id LIMIT 1;
  IF u_a IS NULL OR c1 IS NULL OR c2 IS NULL OR c3 IS NULL OR c_dep IS NULL THEN
    RAISE EXCEPTION 'STEP 7: the database does not hold the probe fixtures';
  END IF;

  SELECT count(*) INTO before FROM public.learner_concept_states;

  -- One valid state, built as a function of the concept so the probes below
  -- can vary only the thing each is testing.
  payload := jsonb_build_array(jsonb_build_object(
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
    'last_memory_evidence_at', '2026-10-05T08:00:00Z', 'last_application_evidence_at', NULL));

  -- ── It writes ───────────────────────────────────────────────────────────
  res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', payload);
  IF (res ->> 'rows_received')::INT <> 1 OR (res ->> 'rows_upserted')::INT <> 1
     OR (res ->> 'rows_deleted')::INT <> 0 OR (res ->> 'final_row_count')::INT <> 1 THEN
    leaked := array_append(leaked, 'the first write reported ' || res::TEXT);
  END IF;

  -- ── It replaces rather than accumulating ────────────────────────────────
  res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', payload);
  IF (res ->> 'final_row_count')::INT <> 1 THEN
    leaked := array_append(leaked, 'a second identical write did not replace: ' || res::TEXT);
  END IF;

  -- ── Stale rows go, named rows stay ──────────────────────────────────────
  res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE',
    payload || jsonb_build_array(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c2))));
  IF (res ->> 'final_row_count')::INT <> 2 THEN
    leaked := array_append(leaked, 'the two-concept write did not land: ' || res::TEXT);
  END IF;
  res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE',
    jsonb_build_array(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c2))));
  IF (res ->> 'rows_deleted')::INT <> 1 OR (res ->> 'final_row_count')::INT <> 1 THEN
    leaked := array_append(leaked, 'the stale row was not removed: ' || res::TEXT);
  END IF;
  IF EXISTS (SELECT 1 FROM public.learner_concept_states WHERE user_id = u_a AND concept_id = c1) THEN
    leaked := array_append(leaked, 'the stale concept survived the replacement');
  END IF;

  -- ── One learner's replacement never touches another's ───────────────────
  IF u_b IS NOT NULL THEN
    PERFORM public.replace_learner_concept_states(u_b, DATE '2026-10-06', now(), 'PROBE', payload);
    PERFORM public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', '[]'::JSONB);
    SELECT count(*) INTO n FROM public.learner_concept_states WHERE user_id = u_b;
    IF n <> 1 THEN
      leaked := array_append(leaked, 'clearing one learner removed another learner''s rows');
    END IF;
    SELECT count(*) INTO n FROM public.learner_concept_states WHERE user_id = u_a;
    IF n <> 0 THEN
      leaked := array_append(leaked, 'an empty payload did not clear the learner, ' || n || ' row(s) left');
    END IF;
    PERFORM public.replace_learner_concept_states(u_b, DATE '2026-10-06', now(), 'PROBE', '[]'::JSONB);
  END IF;

  -- ── A bad batch changes NOTHING ─────────────────────────────────────────
  -- The whole reason this is a database function. Each probe writes one good
  -- state, then sends a batch containing that same good state AND one invalid
  -- one, and the good state must be untouched afterwards: no upsert, no stale
  -- delete, no partial anything.
  PERFORM public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', payload);
  SELECT md5(string_agg(t::TEXT, '|' ORDER BY t.concept_id)) INTO digest
    FROM public.learner_concept_states t WHERE t.user_id = u_a;

  FOR n IN 1 .. 7 LOOP
    BEGIN
      res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE',
        payload || jsonb_build_array(
          CASE n
            -- a deprecated concept
            WHEN 1 THEN jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c_dep))
            -- a value outside the vocabulary
            WHEN 2 THEN jsonb_set(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c3)), '{state_label}', '"MEMORY_EXCELLENT"')
            -- counts that contradict each other
            WHEN 3 THEN jsonb_set(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c3)), '{weak_card_count}', '9')
            -- a per-row batch fact, which must not be expressible
            WHEN 4 THEN jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c3)) || '{"model_version":"FORGED"}'::JSONB
            -- a misspelled key
            WHEN 5 THEN jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c3)) || '{"memory_durabilty":0.9}'::JSONB
            -- a missing key
            WHEN 6 THEN (jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c3))) - 'state_label'
            -- the same concept twice
            ELSE payload -> 0
          END));
      leaked := array_append(leaked, 'invalid batch ' || n || ' was ACCEPTED: ' || res::TEXT);
    EXCEPTION WHEN OTHERS THEN
      NULL;  -- refused, which is the point
    END;

    SELECT md5(string_agg(t::TEXT, '|' ORDER BY t.concept_id)) INTO digest2
      FROM public.learner_concept_states t WHERE t.user_id = u_a;
    IF digest2 IS DISTINCT FROM digest THEN
      leaked := array_append(leaked, 'invalid batch ' || n || ' left the learner changed');
    END IF;
  END LOOP;

  -- ── The batch facts cannot be absent either ─────────────────────────────
  FOR n IN 1 .. 4 LOOP
    BEGIN
      CASE n
        WHEN 1 THEN res := public.replace_learner_concept_states(NULL, DATE '2026-10-06', now(), 'PROBE', payload);
        WHEN 2 THEN res := public.replace_learner_concept_states(u_a, NULL, now(), 'PROBE', payload);
        WHEN 3 THEN res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', NULL, 'PROBE', payload);
        ELSE res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), '   ', payload);
      END CASE;
      leaked := array_append(leaked, 'a missing batch fact (' || n || ') was accepted');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  BEGIN
    res := public.replace_learner_concept_states(
      '00000000-0000-0000-0000-000000000000'::UUID, DATE '2026-10-06', now(), 'PROBE', payload);
    leaked := array_append(leaked, 'a state was written for a user that does not exist');
  EXCEPTION WHEN OTHERS THEN NULL;
  END;

  -- ── An authenticated learner cannot call it ─────────────────────────────
  IF users >= 1 THEN
    IF NOT pg_has_role(current_user, 'authenticated', 'MEMBER') THEN
      RAISE EXCEPTION 'STEP 7: % cannot assume the authenticated role, so the writer''s reachability cannot be proved. Report this; nothing has been committed.', current_user;
    END IF;
    EXECUTE 'SET LOCAL ROLE authenticated';
    PERFORM set_config('request.jwt.claims',
      json_build_object('sub', u_a::text, 'role', 'authenticated')::text, true);
    PERFORM set_config('request.jwt.claim.sub', u_a::text, true);
    IF auth.uid() IS DISTINCT FROM u_a THEN
      EXECUTE 'RESET ROLE';
      RAISE EXCEPTION 'STEP 7: the probe could not become a learner, auth.uid() is % not %', auth.uid(), u_a;
    END IF;
    BEGIN
      PERFORM public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'FORGED', payload);
      leaked := array_append(leaked, 'an authenticated learner executed the writer');
    EXCEPTION WHEN insufficient_privilege THEN NULL;
    WHEN OTHERS THEN
      leaked := array_append(leaked, 'the learner EXECUTE probe failed on something else (' || SQLSTATE || '): ' || SQLERRM);
    END;
    EXECUTE 'RESET ROLE';
  END IF;

  -- ── No residue ──────────────────────────────────────────────────────────
  DELETE FROM public.learner_concept_states WHERE model_version IN ('PROBE', 'FORGED');
  SELECT count(*) INTO n FROM public.learner_concept_states;
  IF n <> before THEN
    RAISE EXCEPTION 'STEP 7: the probes left the table at % rows, it held % before', n, before;
  END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'STEP 7 FAILED: %', array_to_string(leaked, ' | ');
  END IF;

  RAISE NOTICE 'STEP 7 OK: replace_learner_concept_states installed SECURITY INVOKER with a fixed search_path, executable by service_role only, atomic across 7 invalid batches, stale-delete and empty-payload correct, learner-isolated, and the table is back at % row(s).', n;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT p.proname, p.prosecdef AS security_definer, p.proconfig AS settings,
       pg_get_function_arguments(p.oid) AS arguments
FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';

SELECT grantee, privilege_type FROM information_schema.routine_privileges
WHERE routine_schema = 'public' AND routine_name = 'replace_learner_concept_states'
ORDER BY grantee;

SELECT count(*) AS rows_in_learner_concept_states FROM public.learner_concept_states;
