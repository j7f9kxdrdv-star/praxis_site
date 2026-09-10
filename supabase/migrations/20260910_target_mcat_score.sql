-- The score a student is aiming for.
--
-- Added because "On track" needs a destination. Without a target it claims a
-- student is on course toward nothing, which is the reason the status was
-- nearly dropped instead. profiles already carried mcat_test_date and
-- weekly_question_goal, so the product knew WHEN they sit the exam and HOW MUCH
-- they intend to study, but never what they were aiming at.
--
-- NULLABLE ON PURPOSE. Most students will not set one, and a default would be
-- inventing an ambition on their behalf. Study Status only uses ON_TRACK when
-- this is present; without it a student gets PROGRESSING, which claims nothing
-- about a destination.
--
-- The bounds are the real MCAT scale, matching official_mcat_scores so the two
-- cannot disagree about what a valid score is.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS target_mcat_score INTEGER;

ALTER TABLE public.profiles
  DROP CONSTRAINT IF EXISTS profiles_target_mcat_score_range;
ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_target_mcat_score_range
  CHECK (target_mcat_score IS NULL OR (target_mcat_score BETWEEN 472 AND 528));

COMMENT ON COLUMN public.profiles.target_mcat_score IS
  'Score the student is aiming for, 472-528. Null when unset; Study Status only reports ON_TRACK when it is present.';
