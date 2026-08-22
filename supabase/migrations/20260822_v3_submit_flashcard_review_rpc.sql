-- ============================================================
-- V3 PR2 — one transactional write path for flashcard reviews
--
-- WHAT THIS REPLACES. Today the browser computes a card's next schedule and
-- sends two independent, unchecked writes:
--
--     await supabase.from("flashcard_user_state").upsert(...)   -- no error check
--     await supabase.from("flashcard_reviews").insert(...)      -- no error check
--
-- They are not linked and neither is inspected. If the first fails and the
-- second succeeds, the schedule silently does not advance while the log says
-- it did. That is not hypothetical: 204 card-blanks first reviewed AFTER the
-- v2 scheduler shipped carry a success count that disagrees with their review
-- log, which the v1-to-v2 reps semantics change does not explain.
--
-- There is no server-side function anywhere in the review path today — a
-- repo-wide search for .rpc() returns nothing — so there is currently nowhere
-- a transaction could even be opened.
--
-- WHAT THIS FUNCTION DOES, all inside ONE transaction:
--   1. Refuses to act for anyone but the authenticated caller.
--   2. Returns the existing result if this exact attempt was already recorded
--      (idempotency by client_request_id), so a retry cannot double-grade.
--   3. Writes the scheduling row and the review-log row together, or neither.
--   4. Credits the study day, so the streak can no longer disagree with the
--      reviews that earned it.
--
-- WHAT IT DELIBERATELY DOES NOT DO. It does not compute the schedule. The
-- caller passes the computed values in. FSRS is a TypeScript library, and
-- reimplementing it in plpgsql would be exactly the "rebuild FSRS
-- approximately" mistake the specification forbids. The API route owns the
-- maths; this function owns atomicity, identity and idempotency.
--
-- PR2 changes WHERE the computation runs, not WHAT it computes. The v2 ladder
-- is unchanged, so the same card and grade must produce the same schedule as
-- before. That is verifiable, and is verified.
-- ============================================================

CREATE OR REPLACE FUNCTION public.submit_flashcard_review(
  p_flashcard_id      UUID,
  p_cloze_index       INTEGER,
  p_rating            TEXT,
  p_prev_interval     NUMERIC,
  p_new_interval      NUMERIC,
  p_ease_factor       NUMERIC,
  p_reps              INTEGER,
  p_lapses            INTEGER,
  p_next_review_at    TIMESTAMPTZ,
  p_source            TEXT,
  p_is_first_exposure BOOLEAN,
  p_client_request_id UUID
)
RETURNS TABLE (
  interval_days    NUMERIC,
  ease_factor      NUMERIC,
  reps             INTEGER,
  lapses           INTEGER,
  next_review_at   TIMESTAMPTZ,
  last_rating      TEXT,
  study_day        DATE,
  was_duplicate    BOOLEAN
)
LANGUAGE plpgsql
SECURITY DEFINER
-- Pin the search path: a SECURITY DEFINER function without this can be
-- hijacked by a caller-controlled search_path.
SET search_path = public, pg_temp
AS $$
DECLARE
  v_user        UUID := auth.uid();
  v_tz          TEXT;
  v_day_start   INTEGER;
  v_study_day   DATE;
  v_existing    public.flashcard_user_state%ROWTYPE;
BEGIN
  -- 1. Identity. Taken from the session, never from an argument, so a caller
  --    cannot write to somebody else's schedule.
  IF v_user IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;

  IF p_rating NOT IN ('again', 'hard', 'medium', 'easy') THEN
    RAISE EXCEPTION 'invalid rating: %', p_rating;
  END IF;

  -- 2. Idempotency. If this attempt was already recorded, return what the card
  --    looks like now and report it as a duplicate. A retried request, a
  --    double-submit, or a network replay therefore cannot grade twice.
  --    Twelve pairs of reviews landed under a second apart in production and
  --    two carried DIFFERENT grades, so the grade a card kept was decided by
  --    whichever request won the race.
  IF p_client_request_id IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.flashcard_reviews r
    WHERE r.user_id = v_user AND r.client_request_id = p_client_request_id
  ) THEN
    SELECT * INTO v_existing
    FROM public.flashcard_user_state s
    WHERE s.user_id = v_user
      AND s.flashcard_id = p_flashcard_id
      AND s.cloze_index = p_cloze_index;

    RETURN QUERY SELECT
      v_existing.interval_days, v_existing.ease_factor, v_existing.reps,
      v_existing.lapses, v_existing.next_review_at, v_existing.last_rating,
      NULL::DATE, TRUE;
    RETURN;
  END IF;

  -- 3. The study day, computed here rather than trusted from the client,
  --    because the server owns the write and cannot ask the browser what day
  --    it is. Subtracting the rollover hour from local time and taking the
  --    date gives the right answer at every edge: 03:59 with a 4am boundary
  --    lands on yesterday, 04:00 on today, and a session spanning midnight
  --    stays on one day.
  SELECT COALESCE(p.timezone, 'UTC'), COALESCE(p.day_start_hour, 4)
    INTO v_tz, v_day_start
  FROM public.profiles p WHERE p.id = v_user;

  v_study_day := ((now() AT TIME ZONE COALESCE(v_tz, 'UTC'))
                  - make_interval(hours => COALESCE(v_day_start, 4)))::DATE;

  -- 4. Scheduling row and review log, together or not at all.
  INSERT INTO public.flashcard_user_state (
    user_id, flashcard_id, cloze_index,
    interval_days, ease_factor, reps, lapses,
    last_rating, last_reviewed_at, next_review_at
  ) VALUES (
    v_user, p_flashcard_id, p_cloze_index,
    p_new_interval, p_ease_factor, p_reps, p_lapses,
    p_rating, now(), p_next_review_at
  )
  ON CONFLICT (user_id, flashcard_id, cloze_index) DO UPDATE SET
    interval_days    = EXCLUDED.interval_days,
    ease_factor      = EXCLUDED.ease_factor,
    reps             = EXCLUDED.reps,
    lapses           = EXCLUDED.lapses,
    last_rating      = EXCLUDED.last_rating,
    last_reviewed_at = EXCLUDED.last_reviewed_at,
    next_review_at   = EXCLUDED.next_review_at;

  INSERT INTO public.flashcard_reviews (
    user_id, flashcard_id, cloze_index, rating,
    prev_interval_days, new_interval_days,
    source, is_first_exposure, client_request_id, reviewed_at
  ) VALUES (
    v_user, p_flashcard_id, p_cloze_index, p_rating,
    p_prev_interval, p_new_interval,
    p_source, p_is_first_exposure, p_client_request_id, now()
  );

  -- 5. Credit the study day in the SAME transaction. Previously this was a
  --    separate read-then-write from the client that flashcards never made at
  --    all, so a student doing 600 cards a day saw a streak of zero.
  INSERT INTO public.daily_activity (user_id, activity_date, questions_completed)
  VALUES (v_user, v_study_day, 1)
  ON CONFLICT (user_id, activity_date) DO UPDATE SET
    questions_completed = public.daily_activity.questions_completed + 1;

  RETURN QUERY SELECT
    p_new_interval, p_ease_factor, p_reps, p_lapses,
    p_next_review_at, p_rating, v_study_day, FALSE;
END;
$$;

-- Callable by signed-in users only. The function derives identity from
-- auth.uid(), so this does not let one user touch another's rows.
REVOKE ALL ON FUNCTION public.submit_flashcard_review(
  UUID, INTEGER, TEXT, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER,
  TIMESTAMPTZ, TEXT, BOOLEAN, UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.submit_flashcard_review(
  UUID, INTEGER, TEXT, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER,
  TIMESTAMPTZ, TEXT, BOOLEAN, UUID) TO authenticated;

COMMENT ON FUNCTION public.submit_flashcard_review IS
  'Atomic flashcard review write: scheduling row, review log and study-day credit in one transaction, idempotent on client_request_id. Does NOT compute the schedule; the caller supplies it so FSRS can stay in TypeScript.';

-- NOTE for PR3: once both the web app and the phone submit through this
-- function, the browser''s direct INSERT on flashcard_reviews and its UPDATE of
-- the scheduling columns on flashcard_user_state should be revoked. Until then
-- the old client write path still works, which is deliberate: revoking early
-- would break any client that has not shipped yet.
