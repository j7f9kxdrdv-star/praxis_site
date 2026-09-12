-- ============================================================
-- Make onboarding_completed mean something
--
-- The column has existed since the first schema and NOTHING HAS EVER READ OR
-- WRITTEN IT. Its current values are therefore arbitrary: three accounts say
-- true and three say false, and none of them went through a flow, because no
-- flow existed. Signup went straight to the dashboard.
--
-- The cost of that shows up in the data. Across every real account: not one
-- target score, two with no weekly study hours at all (which silently disables
-- their limit recommendations), every single one on the default weekly question
-- goal of 100, and one account sitting on a 5,000 new-card daily limit that
-- nobody chose deliberately and that would have buried them in reviews.
--
-- So the flag is reset for anyone who has not actually answered the questions,
-- and from here it is written only at the end of the flow. Skipping still sets
-- it: a student who declines to answer has been asked, and asking twice is
-- nagging.
--
-- NOTHING IS GUESSED ON A STUDENT'S BEHALF. Skipped fields stay NULL, and the
-- dashboard already has honest "not yet" states for every one of them.
-- ============================================================

-- Reset for anyone missing the inputs the learner model actually needs. In
-- practice that is everyone, because target_mcat_score was added yesterday and
-- no one has set one yet.
UPDATE public.profiles
SET onboarding_completed = FALSE
WHERE study_hours_per_week IS NULL
   OR target_mcat_score IS NULL;

COMMENT ON COLUMN public.profiles.onboarding_completed IS
  'True once the student has been through the onboarding flow, including if they skipped it. Gates the redirect in DashboardShell.';

-- ── Verification ────────────────────────────────────────────────────────
SELECT
  onboarding_completed,
  count(*)                                   AS accounts,
  count(study_hours_per_week)                AS with_hours,
  count(target_mcat_score)                   AS with_target
FROM public.profiles
GROUP BY onboarding_completed
ORDER BY onboarding_completed;
