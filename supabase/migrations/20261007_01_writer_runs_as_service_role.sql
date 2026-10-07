-- ─── The writer could not be called by the only role allowed to call it ────
-- REQUIRES: 20261006_09_replace_learner_concept_states.sql
--
-- WHAT HAPPENED. replace_learner_concept_states validated its learner with
--
--   SELECT 1 FROM auth.users WHERE id = p_user_id
--
-- and it is SECURITY INVOKER, so that SELECT runs as whoever called the
-- function. The only role allowed to call it is service_role, and service_role
-- has no privileges in the auth schema. Every real invocation failed with
--
--   42501  permission denied for table users
--
-- before it reached a single write.
--
-- WHY THE MIGRATION'S OWN PROBES MISSED IT, which is the more useful half of
-- this. The probes in 20261006_09 called the function directly from a DO block
-- in the SQL editor, where the session role is postgres. postgres CAN read
-- auth.users, so the function worked perfectly for the one caller that will
-- never use it in production. The probes were real, they drove real behaviour,
-- and they proved it about the wrong role. A test can be honest and still
-- answer a question nobody asked.
--
-- THE OBVIOUS FIX WAS ALSO WRONG, and the first version of this migration
-- shipped it as far as the SQL editor before being refused by its own guard.
-- The idea was to check public.profiles instead, which service_role can read.
-- The guard asked first whether the two tables agree about who exists, and
-- they do not:
--
--   WRITER FIX: 2 auth user(s) have no profile row
--
-- So a profiles check would have refused to write state for two real accounts.
-- That is a quieter failure than the one it replaced: not an error on every
-- call, but two learners who silently never get a state.
--
-- SO THERE IS NO PRE-CHECK AT ALL NOW, and the foreign key does the work it
-- was always doing:
--
--   a batch with states, unknown learner   the FK on user_id refuses every row
--                                          (23503), the whole call rolls back,
--                                          nothing is written
--   an empty batch, unknown learner        deletes the rows of a user who has
--                                          none, which is a correct no-op
--
-- The pre-check only ever bought a friendlier message for the first case and
-- nothing at all for the second, and it could not be made both correct and
-- callable. The constraint that actually guarantees the invariant stays where
-- it is, on the table, pointing at auth.users.
--
-- THE TWO PROFILE-LESS AUTH USERS ARE REPORTED, NOT REPAIRED. This migration
-- raises a NOTICE naming how many there are. Who they are and what should
-- happen to them is a separate question, and it is probably the same question
-- as the founder's is_admin row: a migration in June matched zero rows because
-- it looked for an email that is not in profiles.
--
-- NOTHING ELSE CHANGES. Same arguments, same validation of the batch itself,
-- same semantics, same privileges, same advisory lock. One SELECT is removed,
-- and a probe is added that runs AS service_role so the next writer change is
-- exercised by the role that will actually run it.

BEGIN;

-- Report the mismatch rather than acting on it. The writer no longer depends
-- on profiles, so this blocks nothing; it is here because the number is worth
-- seeing in the apply output and because the next person to reach for
-- "just check profiles" should find out here rather than in production.
DO $pre$
DECLARE orphans INT; profiles_without_user INT;
BEGIN
  SELECT count(*) INTO orphans FROM auth.users u
   WHERE NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id);
  SELECT count(*) INTO profiles_without_user FROM public.profiles p
   WHERE NOT EXISTS (SELECT 1 FROM auth.users u WHERE u.id = p.id);
  RAISE NOTICE 'ACCOUNTS: % auth user(s), % profile(s). % auth user(s) have no profile row, % profile(s) have no auth user. The writer relies on the foreign key, not on either count.',
    (SELECT count(*) FROM auth.users), (SELECT count(*) FROM public.profiles),
    orphans, profiles_without_user;
END $pre$;

CREATE OR REPLACE FUNCTION public.replace_learner_concept_states(
  p_user_id       UUID,
  p_study_day     DATE,
  p_computed_at   TIMESTAMPTZ,
  p_model_version TEXT,
  p_states        JSONB
) RETURNS JSONB
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_catalog
AS $fn$
DECLARE
  n_received INT;
  n_upserted INT;
  n_deleted  INT;
  n_final    INT;
  bad        TEXT;
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
  -- NO LEARNER-EXISTENCE CHECK HERE, deliberately. This function runs as its
  -- caller and the only caller is service_role, which cannot read auth.users;
  -- and public.profiles is not the same set, so checking it would refuse two
  -- real accounts. The foreign key on user_id enforces existence on every row
  -- this writes, inside this same transaction, which is the guarantee that
  -- actually matters. See the header.

  n_received := jsonb_array_length(p_states);

  PERFORM pg_advisory_xact_lock(hashtext('learner_concept_states'), hashtext(p_user_id::text));

  IF EXISTS (SELECT 1 FROM jsonb_array_elements(p_states) e WHERE jsonb_typeof(e) <> 'object') THEN
    RAISE EXCEPTION 'replace_learner_concept_states: every element of p_states must be an object';
  END IF;

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

  SELECT string_agg(e ->> 'concept_id', ', ') INTO bad
    FROM jsonb_array_elements(p_states) e
    LEFT JOIN public.concepts c ON c.id = (e ->> 'concept_id')::UUID
   WHERE c.id IS NULL OR c.object_type <> 'CONTENT' OR c.status <> 'ACTIVE_SEED';
  IF bad IS NOT NULL THEN
    RAISE EXCEPTION 'replace_learner_concept_states: these are not learner-facing CONTENT concepts: %', bad;
  END IF;

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

-- CREATE OR REPLACE keeps the existing privileges, but stating them again
-- costs nothing and means this file is a complete description of the function
-- rather than a diff against one.
REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) TO service_role;

-- ─── Post-conditions, driven AS THE ROLE THAT WILL ACTUALLY CALL IT ────────
DO $post$
DECLARE
  n      INT;
  u_a    UUID;
  c1     UUID;
  c2     UUID;
  res    JSONB;
  before INT;
  leaked TEXT[] := ARRAY[]::TEXT[];
  payload JSONB;
BEGIN
  -- A learner that certainly exists in auth.users: the table's own rows are
  -- the safest source, and failing that, any profile (all 7 have an auth user).
  SELECT id INTO u_a FROM public.profiles ORDER BY id LIMIT 1;
  SELECT id INTO c1 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 0;
  SELECT id INTO c2 FROM public.concepts WHERE object_type = 'CONTENT' AND status = 'ACTIVE_SEED' ORDER BY id LIMIT 1 OFFSET 1;
  SELECT count(*) INTO before FROM public.learner_concept_states;

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

  -- THE PROBE THAT WAS MISSING. Becoming service_role is what the production
  -- caller does, and it is the only way to find out whether the body can reach
  -- the tables it names. Run as postgres, every one of these passes whether or
  -- not the function is callable in production.
  IF NOT pg_has_role(current_user, 'service_role', 'MEMBER') THEN
    RAISE EXCEPTION 'WRITER FIX: % cannot assume service_role, so the fix cannot be proved against the role that will run it. Report this; nothing has been committed.', current_user;
  END IF;

  EXECUTE 'SET LOCAL ROLE service_role';
  BEGIN
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', payload);
    IF (res ->> 'final_row_count')::INT <> 1 THEN
      leaked := array_append(leaked, 'as service_role the write reported ' || res::TEXT);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    leaked := array_append(leaked, 'as service_role the writer FAILED (' || SQLSTATE || '): ' || SQLERRM);
  END;

  -- And the rest of the contract, still as service_role.
  BEGIN
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE',
      jsonb_build_array(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c2))));
    IF (res ->> 'rows_deleted')::INT <> 1 OR (res ->> 'final_row_count')::INT <> 1 THEN
      leaked := array_append(leaked, 'as service_role the stale delete reported ' || res::TEXT);
    END IF;
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', '[]'::JSONB);
    IF (res ->> 'final_row_count')::INT <> 0 THEN
      leaked := array_append(leaked, 'as service_role the empty payload reported ' || res::TEXT);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    leaked := array_append(leaked, 'as service_role a later call FAILED (' || SQLSTATE || '): ' || SQLERRM);
  END;

  -- An unknown learner with real states must be refused by the FOREIGN KEY,
  -- atomically. Checked by SQLSTATE rather than by message, so a refusal from
  -- some other rule cannot be mistaken for this one.
  BEGIN
    res := public.replace_learner_concept_states(
      '00000000-0000-0000-0000-000000000000'::UUID, DATE '2026-10-06', now(), 'PROBE', payload);
    leaked := array_append(leaked, 'as service_role a state was written for a learner that does not exist');
  EXCEPTION WHEN foreign_key_violation THEN NULL;
  WHEN OTHERS THEN
    leaked := array_append(leaked, 'the unknown-learner refusal came from the wrong layer (' || SQLSTATE || '): ' || SQLERRM);
  END;

  -- And an EMPTY batch for an unknown learner is a no-op, not an error: there
  -- is nothing to insert, so there is no foreign key to violate, and deleting
  -- the rows of a user who has none changes nothing.
  BEGIN
    res := public.replace_learner_concept_states(
      '00000000-0000-0000-0000-000000000000'::UUID, DATE '2026-10-06', now(), 'PROBE', '[]'::JSONB);
    IF (res ->> 'final_row_count')::INT <> 0 OR (res ->> 'rows_deleted')::INT <> 0 THEN
      leaked := array_append(leaked, 'the empty unknown-learner call did something: ' || res::TEXT);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    leaked := array_append(leaked, 'an empty batch for an unknown learner raised (' || SQLSTATE || '): ' || SQLERRM);
  END;

  EXECUTE 'RESET ROLE';

  DELETE FROM public.learner_concept_states WHERE model_version IN ('PROBE', 'FORGED');
  SELECT count(*) INTO n FROM public.learner_concept_states;
  IF n <> before THEN
    RAISE EXCEPTION 'WRITER FIX: the probes left the table at % rows, it held % before', n, before;
  END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'WRITER FIX FAILED: %', array_to_string(leaked, ' | ');
  END IF;

  RAISE NOTICE 'WRITER FIX OK: the writer now runs end to end AS service_role, which is the role that calls it in production. Table back at % row(s).', n;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT p.proname, p.prosecdef AS security_definer, p.proconfig AS settings
FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';

SELECT grantee, privilege_type FROM information_schema.routine_privileges
WHERE routine_schema = 'public' AND routine_name = 'replace_learner_concept_states'
ORDER BY grantee;

SELECT count(*) AS rows_in_learner_concept_states FROM public.learner_concept_states;
