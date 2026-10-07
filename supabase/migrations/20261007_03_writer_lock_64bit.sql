-- ─── A wider lock key for the writer ──────────────────────────────────────
-- REQUIRES: 20261007_02_account_universe_repair.sql
--
-- The writer serialises recomputations for ONE learner so two runs cannot
-- interleave a stale delete with an upsert and leave a hybrid. That part was
-- right and does not change. What changes is the key.
--
-- WAS:  pg_advisory_xact_lock(hashtext('learner_concept_states'), hashtext(p_user_id::text))
-- NOW:  pg_advisory_xact_lock(hashtextextended('learner_concept_states:' || p_user_id::text, 20261007))
--
-- The two-argument form takes a pair of 32-bit integers. Hashing a UUID into
-- 32 bits means two different learners share a key about once in every few
-- tens of thousands of pairs. That was never a correctness problem — a
-- collision costs one of them a short wait and can never produce a wrong
-- answer — but at ten thousand accounts it stops being rare, and there is no
-- reason to accept it when a 64-bit key costs nothing.
--
-- WHAT WAS DELIBERATELY NOT DONE. The lock is not moved to
-- SELECT ... FOR UPDATE on the learner's profile row. The thing being
-- serialised is a learner-state replacement, not a profile mutation, and
-- taking a row lock on profiles would make an unrelated profile update wait
-- behind a 900-row state write, and vice versa. The lock belongs to the
-- transaction that does the work.
--
-- Everything else is byte-identical to the function installed by
-- 20261007_01: same arguments, same validation, same replacement semantics,
-- same SECURITY INVOKER, same search_path, same privileges.

BEGIN;

-- hashtextextended(text, bigint) has existed since PostgreSQL 11, but a
-- migration that assumes a function exists is a migration that fails halfway
-- through on the one database where it does not.
DO $cap$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
     WHERE n.nspname = 'pg_catalog' AND p.proname = 'hashtextextended'
       AND pg_get_function_identity_arguments(p.oid) = 'text, bigint'
  ) THEN
    RAISE EXCEPTION 'LOCK: hashtextextended(text, bigint) is not available on this server (%). Keep the 32-bit pair and record why.', version();
  END IF;
  RAISE NOTICE 'LOCK: hashtextextended(text, bigint) is available on %', split_part(version(), ' on ', 1);
END $cap$;

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

  -- A SINGLE 64-BIT KEY, seeded, instead of a pair of 32-bit hashes.
  --
  -- The two-argument form splits one lock space into (classid, objid) and
  -- hashes the user id into 32 bits, so two learners collide roughly once in
  -- every few tens of thousands of pairs — harmless, since a collision only
  -- makes one of them wait, but avoidable. hashtextextended gives 64 bits and
  -- takes a seed, so the key is both wider and namespaced to this table rather
  -- than sharing a space with any other advisory lock in the database.
  --
  -- The seed is the date this was fixed and never changes: a different seed
  -- would be a different lock, and two deploys disagreeing about it would stop
  -- serialising the same learner against each other.
  PERFORM pg_advisory_xact_lock(
    hashtextextended('learner_concept_states:' || p_user_id::text, 20261007));

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


REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) FROM anon, authenticated;
GRANT EXECUTE ON FUNCTION public.replace_learner_concept_states(UUID, DATE, TIMESTAMPTZ, TEXT, JSONB) TO service_role;

-- ─── Post-conditions, as service_role ─────────────────────────────────────
DO $post$
DECLARE
  n INT; u_a UUID; c1 UUID; c2 UUID; res JSONB; before INT;
  leaked TEXT[] := ARRAY[]::TEXT[]; payload JSONB; defn TEXT;
BEGIN
  SELECT prosrc INTO defn FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
   WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';
  IF position('hashtextextended' IN defn) = 0 THEN
    RAISE EXCEPTION 'LOCK: the installed function does not use the 64-bit key';
  END IF;
  IF position('hashtext(''learner_concept_states''' IN defn) > 0 THEN
    RAISE EXCEPTION 'LOCK: the installed function still uses the 32-bit pair';
  END IF;

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

  IF NOT pg_has_role(current_user, 'service_role', 'MEMBER') THEN
    RAISE EXCEPTION 'LOCK: % cannot assume service_role, so the writer cannot be proved against its real caller.', current_user;
  END IF;
  EXECUTE 'SET LOCAL ROLE service_role';
  BEGIN
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', payload);
    IF (res ->> 'final_row_count')::INT <> 1 THEN
      leaked := array_append(leaked, 'the write under the new lock reported ' || res::TEXT);
    END IF;
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE',
      jsonb_build_array(jsonb_set(payload -> 0, '{concept_id}', to_jsonb(c2))));
    IF (res ->> 'rows_deleted')::INT <> 1 THEN
      leaked := array_append(leaked, 'the stale delete under the new lock reported ' || res::TEXT);
    END IF;
    res := public.replace_learner_concept_states(u_a, DATE '2026-10-06', now(), 'PROBE', '[]'::JSONB);
    IF (res ->> 'final_row_count')::INT <> 0 THEN
      leaked := array_append(leaked, 'the empty payload under the new lock reported ' || res::TEXT);
    END IF;
  EXCEPTION WHEN OTHERS THEN
    leaked := array_append(leaked, 'as service_role the writer FAILED (' || SQLSTATE || '): ' || SQLERRM);
  END;
  EXECUTE 'RESET ROLE';

  -- The lock is transaction scoped: taking it here and committing releases it
  -- with nothing left held. A session-scoped lock would survive this block.
  SELECT count(*) INTO n FROM pg_locks WHERE locktype = 'advisory' AND NOT granted;
  IF n <> 0 THEN leaked := array_append(leaked, n || ' advisory lock(s) are waiting'); END IF;

  DELETE FROM public.learner_concept_states WHERE model_version = 'PROBE';
  SELECT count(*) INTO n FROM public.learner_concept_states;
  IF n <> before THEN
    RAISE EXCEPTION 'LOCK: the probes left the table at % rows, it held % before', n, before;
  END IF;
  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'LOCK FIX FAILED: %', array_to_string(leaked, ' | ');
  END IF;
  RAISE NOTICE 'LOCK OK: the writer now serialises on a seeded 64-bit key, proved end to end as service_role, table back at % row(s).', n;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT p.proname, p.prosecdef AS security_definer, p.proconfig AS settings,
       position('hashtextextended' IN p.prosrc) > 0 AS uses_64_bit_key
FROM pg_proc p JOIN pg_namespace ns ON ns.oid = p.pronamespace
WHERE ns.nspname = 'public' AND p.proname = 'replace_learner_concept_states';

SELECT count(*) AS rows_in_learner_concept_states FROM public.learner_concept_states;
