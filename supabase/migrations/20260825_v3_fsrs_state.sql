-- ============================================================
-- V3 PR6 — FSRS state, and the write path that persists it
--
-- The v2 ladder kept one number per card: an ease factor it multiplied the
-- interval by. It had no model of forgetting, so it could never answer the
-- question that actually matters — how likely are you to remember THIS card
-- today. FSRS keeps two numbers instead:
--
--   STABILITY   how many days until predicted recall decays to 90%
--   DIFFICULTY  how much each success actually buys on this card
--
-- and schedules the card for the day predicted recall crosses the target.
--
-- interval_days and ease_factor are deliberately KEPT. interval_days is read
-- by the UI and by PR4's same-day evidence rule; ease_factor becomes vestigial
-- but is left populated so this change can be rolled back by pointing the
-- route at scheduler.ts again, with no data migration in either direction.
-- ============================================================

ALTER TABLE public.flashcard_user_state
  ADD COLUMN IF NOT EXISTS stability      NUMERIC,
  ADD COLUMN IF NOT EXISTS difficulty     NUMERIC,
  ADD COLUMN IF NOT EXISTS fsrs_state     SMALLINT,
  ADD COLUMN IF NOT EXISTS learning_steps SMALLINT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS scheduled_days NUMERIC;

COMMENT ON COLUMN public.flashcard_user_state.stability IS
  'FSRS stability: days for predicted recall to fall to 90%. NULL means never graded by FSRS; the scheduler falls back to approximating from interval_days.';
COMMENT ON COLUMN public.flashcard_user_state.difficulty IS
  'FSRS difficulty, 1 (easiest) to 10 (hardest).';
COMMENT ON COLUMN public.flashcard_user_state.fsrs_state IS
  '0 New, 1 Learning, 2 Review, 3 Relearning.';

-- Sanity constraints. A negative stability or an out-of-range difficulty means
-- something upstream is broken, and it is far cheaper to find out here than to
-- discover it months later as inexplicable scheduling.
ALTER TABLE public.flashcard_user_state
  DROP CONSTRAINT IF EXISTS flashcard_user_state_stability_sane;
ALTER TABLE public.flashcard_user_state
  ADD CONSTRAINT flashcard_user_state_stability_sane
  CHECK (stability IS NULL OR (stability >= 0 AND stability <= 36500));

ALTER TABLE public.flashcard_user_state
  DROP CONSTRAINT IF EXISTS flashcard_user_state_difficulty_sane;
ALTER TABLE public.flashcard_user_state
  ADD CONSTRAINT flashcard_user_state_difficulty_sane
  CHECK (difficulty IS NULL OR (difficulty >= 1 AND difficulty <= 10));

ALTER TABLE public.flashcard_user_state
  DROP CONSTRAINT IF EXISTS flashcard_user_state_fsrs_state_sane;
ALTER TABLE public.flashcard_user_state
  ADD CONSTRAINT flashcard_user_state_fsrs_state_sane
  CHECK (fsrs_state IS NULL OR fsrs_state BETWEEN 0 AND 3);

-- The review log records the two numbers as they stood AFTER each grading.
-- Without this there is no way to reconstruct why a card was scheduled the way
-- it was, which is exactly the gap that made the v2 bugs so slow to find.
ALTER TABLE public.flashcard_reviews
  ADD COLUMN IF NOT EXISTS stability  NUMERIC,
  ADD COLUMN IF NOT EXISTS difficulty NUMERIC;

-- ── The write path ──────────────────────────────────────────────────────
--
-- The old 12-argument signature is dropped and recreated with five more.
-- They carry DEFAULTs on purpose: between this migration running and the new
-- web build going live, an old caller still resolves to this function and
-- still writes a correct v2-shaped row. It simply leaves the FSRS columns
-- NULL, which the scheduler's fallback handles.
DROP FUNCTION IF EXISTS public.submit_flashcard_review(
  UUID, INTEGER, TEXT, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER,
  TIMESTAMPTZ, TEXT, BOOLEAN, UUID);

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
  p_client_request_id UUID,
  p_stability         NUMERIC  DEFAULT NULL,
  p_difficulty        NUMERIC  DEFAULT NULL,
  p_fsrs_state        SMALLINT DEFAULT NULL,
  p_learning_steps    SMALLINT DEFAULT NULL,
  p_scheduled_days    NUMERIC  DEFAULT NULL
)
RETURNS TABLE (
  interval_days    NUMERIC,
  ease_factor      NUMERIC,
  reps             INTEGER,
  lapses           INTEGER,
  next_review_at   TIMESTAMPTZ,
  last_rating      TEXT,
  study_day        DATE,
  was_duplicate    BOOLEAN,
  stability        NUMERIC,
  difficulty       NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_user      UUID := auth.uid();
  v_tz        TEXT;
  v_day_start INTEGER;
  v_study_day DATE;
  v_existing  public.flashcard_user_state%ROWTYPE;
BEGIN
  IF v_user IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;

  IF p_rating NOT IN ('again', 'hard', 'medium', 'easy') THEN
    RAISE EXCEPTION 'invalid rating: %', p_rating;
  END IF;

  -- Idempotency, unchanged from PR2.
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
      NULL::DATE, TRUE, v_existing.stability, v_existing.difficulty;
    RETURN;
  END IF;

  SELECT COALESCE(p.timezone, 'UTC'), COALESCE(p.day_start_hour, 4)
    INTO v_tz, v_day_start
  FROM public.profiles p WHERE p.id = v_user;

  v_study_day := ((now() AT TIME ZONE COALESCE(v_tz, 'UTC'))
                  - make_interval(hours => COALESCE(v_day_start, 4)))::DATE;

  INSERT INTO public.flashcard_user_state (
    user_id, flashcard_id, cloze_index,
    interval_days, ease_factor, reps, lapses,
    last_rating, last_reviewed_at, next_review_at,
    stability, difficulty, fsrs_state, learning_steps, scheduled_days
  ) VALUES (
    v_user, p_flashcard_id, p_cloze_index,
    p_new_interval, p_ease_factor, p_reps, p_lapses,
    p_rating, now(), p_next_review_at,
    p_stability, p_difficulty, p_fsrs_state, p_learning_steps, p_scheduled_days
  )
  ON CONFLICT (user_id, flashcard_id, cloze_index) DO UPDATE SET
    interval_days    = EXCLUDED.interval_days,
    ease_factor      = EXCLUDED.ease_factor,
    reps             = EXCLUDED.reps,
    lapses           = EXCLUDED.lapses,
    last_rating      = EXCLUDED.last_rating,
    last_reviewed_at = EXCLUDED.last_reviewed_at,
    next_review_at   = EXCLUDED.next_review_at,
    -- COALESCE so an old caller that omits these cannot blank out state the
    -- card already had.
    stability        = COALESCE(EXCLUDED.stability,      public.flashcard_user_state.stability),
    difficulty       = COALESCE(EXCLUDED.difficulty,     public.flashcard_user_state.difficulty),
    fsrs_state       = COALESCE(EXCLUDED.fsrs_state,     public.flashcard_user_state.fsrs_state),
    learning_steps   = COALESCE(EXCLUDED.learning_steps, public.flashcard_user_state.learning_steps),
    scheduled_days   = COALESCE(EXCLUDED.scheduled_days, public.flashcard_user_state.scheduled_days);

  INSERT INTO public.flashcard_reviews (
    user_id, flashcard_id, cloze_index, rating,
    prev_interval_days, new_interval_days,
    source, is_first_exposure, client_request_id, reviewed_at,
    stability, difficulty
  ) VALUES (
    v_user, p_flashcard_id, p_cloze_index, p_rating,
    p_prev_interval, p_new_interval,
    p_source, p_is_first_exposure, p_client_request_id, now(),
    p_stability, p_difficulty
  );

  INSERT INTO public.daily_activity (user_id, activity_date, questions_completed)
  VALUES (v_user, v_study_day, 1)
  ON CONFLICT (user_id, activity_date) DO UPDATE SET
    questions_completed = public.daily_activity.questions_completed + 1;

  RETURN QUERY SELECT
    p_new_interval, p_ease_factor, p_reps, p_lapses,
    p_next_review_at, p_rating, v_study_day, FALSE,
    p_stability, p_difficulty;
END;
$$;

REVOKE ALL ON FUNCTION public.submit_flashcard_review(
  UUID, INTEGER, TEXT, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER,
  TIMESTAMPTZ, TEXT, BOOLEAN, UUID, NUMERIC, NUMERIC, SMALLINT, SMALLINT, NUMERIC) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.submit_flashcard_review(
  UUID, INTEGER, TEXT, NUMERIC, NUMERIC, NUMERIC, INTEGER, INTEGER,
  TIMESTAMPTZ, TEXT, BOOLEAN, UUID, NUMERIC, NUMERIC, SMALLINT, SMALLINT, NUMERIC) TO authenticated;

COMMENT ON FUNCTION public.submit_flashcard_review IS
  'Atomic flashcard review write: scheduling row, review log and study-day credit in one transaction, idempotent on client_request_id. Does NOT compute the schedule; FSRS runs in TypeScript and hands the result here.';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect all five columns present, and exactly ONE function named
-- submit_flashcard_review (17 arguments). Two rows would mean the old
-- signature survived as an overload and calls would be ambiguous.
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'flashcard_user_state'
  AND column_name IN ('stability','difficulty','fsrs_state','learning_steps','scheduled_days')
ORDER BY column_name;

SELECT p.oid::regprocedure AS signature, p.pronargs AS arg_count
FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
WHERE n.nspname = 'public' AND p.proname = 'submit_flashcard_review';
