-- ============================================================
-- Score predictor: capture the evidence, do not yet predict
--
-- An audit against the Predictor V2 spec found that the architecture it
-- describes rests on evidence Praxist does not have:
--
--   four section estimates      the bank holds TWO sections. There are zero
--                               CARS and zero Psych/Soc questions, so half the
--                               exam has no content at all
--   passage vs discrete         zero passages exist
--   timed vs untimed            nothing records whether an attempt was timed
--   full lengths as anchors     no full-length exam type exists
--   empirical item difficulty   1,314 attempts over 2,633 questions, which is
--                               0.5 attempts per question
--   official MCAT outcomes      none, and nowhere to put them
--
-- So the engine waits. What cannot wait is the DATA, because it is not
-- recoverable retroactively: an attempt that was not recorded as timed can
-- never be known to have been timed, and a student who sat the MCAT last month
-- cannot be asked for a score that was never collectable.
--
-- This migration adds the three things that must exist before any defensible
-- predictor can be built, and nothing else.
-- ============================================================

-- ─── 1. First attempts ──────────────────────────────────────────────────────
--
-- 25.4% of all attempts in the bank are repeats of a question the student had
-- already answered, and every one of them currently feeds the accuracy figures
-- and the score estimate. A second look at a question whose answer you have
-- already seen is not an independent measurement of ability.
--
-- Derivable from history today, which is why it is backfilled here rather than
-- only recorded going forward.

ALTER TABLE public.question_attempts
  ADD COLUMN IF NOT EXISTS is_first_attempt BOOLEAN;

COMMENT ON COLUMN public.question_attempts.is_first_attempt IS
  'True when this is the earliest attempt this user has made at this question. Only first attempts are eligible as ability evidence; repeats are learning data.';

-- Backfill: the earliest row per (user, question) is the first attempt.
-- created_at ties are broken by id so the result is deterministic.
WITH ranked AS (
  SELECT id,
         ROW_NUMBER() OVER (
           PARTITION BY user_id, question_id
           ORDER BY created_at ASC, id ASC
         ) AS rn
  FROM public.question_attempts
)
UPDATE public.question_attempts a
SET is_first_attempt = (r.rn = 1)
FROM ranked r
WHERE a.id = r.id
  AND a.is_first_attempt IS DISTINCT FROM (r.rn = 1);

-- Reading "eligible evidence" is the predictor's hottest query.
CREATE INDEX IF NOT EXISTS question_attempts_first_attempt_idx
  ON public.question_attempts (user_id, is_first_attempt)
  WHERE is_first_attempt;

-- ─── 2. Timed conditions ────────────────────────────────────────────────────
--
-- NULLABLE ON PURPOSE, and it will be null for every existing row. Praxist has
-- no timed mode yet, so "was this timed" is genuinely unknown for everything
-- recorded so far, and that is different from known-untimed. Once a timed mode
-- exists it writes true or false and the nulls stay honestly unknown rather
-- than being silently reinterpreted.

ALTER TABLE public.question_attempts
  ADD COLUMN IF NOT EXISTS is_timed BOOLEAN;

COMMENT ON COLUMN public.question_attempts.is_timed IS
  'Whether the attempt was made under timed conditions. NULL means unknown, which is the correct value for every attempt recorded before a timed mode existed. Do not coalesce NULL to false.';

-- ─── 3. Official MCAT outcomes ──────────────────────────────────────────────
--
-- The only thing that can ever make a predictor defensible: what the student
-- actually scored, next to what was predicted for them beforehand.
--
-- The prediction is stored ALONGSIDE the outcome, frozen at the moment it was
-- made, because a prediction cannot be evaluated against an algorithm that has
-- since changed. predictor_version is what makes error rates comparable.

CREATE TABLE IF NOT EXISTS public.official_mcat_scores (
  id                 UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  exam_date          DATE        NOT NULL,

  -- Section scores are 118 to 132 and the total is 472 to 528. Enforced here
  -- rather than in application code so no path can write an impossible score.
  total_score        SMALLINT    NOT NULL CHECK (total_score BETWEEN 472 AND 528),
  score_cp           SMALLINT    CHECK (score_cp   BETWEEN 118 AND 132),
  score_cars         SMALLINT    CHECK (score_cars BETWEEN 118 AND 132),
  score_bb           SMALLINT    CHECK (score_bb   BETWEEN 118 AND 132),
  score_ps           SMALLINT    CHECK (score_ps   BETWEEN 118 AND 132),

  -- Self-reported until there is a way to verify. Recorded so that later
  -- calibration can weight or exclude unverified scores rather than assuming
  -- every number is true.
  verification_status TEXT       NOT NULL DEFAULT 'self_reported'
    CHECK (verification_status IN ('self_reported', 'verified', 'disputed')),

  -- What the predictor said before the exam, frozen. NULL while no predictor
  -- exists, which is the state today.
  predictor_version   TEXT,
  predicted_total     SMALLINT,
  predicted_low       SMALLINT,
  predicted_high      SMALLINT,
  predicted_at        TIMESTAMPTZ,

  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- A student can sit the MCAT more than once, but not twice on one day.
  UNIQUE (user_id, exam_date)
);

COMMENT ON TABLE public.official_mcat_scores IS
  'Official MCAT results students choose to report, stored beside the prediction made for them beforehand. This is the only data that can ever calibrate or validate a score predictor. Never expose one student''s row to another.';

ALTER TABLE public.official_mcat_scores ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can read own official scores" ON public.official_mcat_scores;
CREATE POLICY "Users can read own official scores"
  ON public.official_mcat_scores FOR SELECT
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can add own official scores" ON public.official_mcat_scores;
CREATE POLICY "Users can add own official scores"
  ON public.official_mcat_scores FOR INSERT
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can correct own official scores" ON public.official_mcat_scores;
CREATE POLICY "Users can correct own official scores"
  ON public.official_mcat_scores FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: every attempt classified.
SELECT COUNT(*) AS attempts_without_first_flag
FROM public.question_attempts WHERE is_first_attempt IS NULL;

-- Expect roughly a 75/25 split of first attempts to repeats.
SELECT is_first_attempt, COUNT(*) AS attempts
FROM public.question_attempts GROUP BY is_first_attempt ORDER BY is_first_attempt;

-- Expect 0: exactly one first attempt per user per question.
SELECT COUNT(*) AS users_questions_with_multiple_firsts FROM (
  SELECT user_id, question_id
  FROM public.question_attempts
  WHERE is_first_attempt
  GROUP BY user_id, question_id
  HAVING COUNT(*) > 1
) t;

-- Expect the new table to exist and be empty.
SELECT COUNT(*) AS official_scores_recorded FROM public.official_mcat_scores;
