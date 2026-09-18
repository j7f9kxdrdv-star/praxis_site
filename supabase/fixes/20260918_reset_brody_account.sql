-- ============================================================
-- Reset Brody Gowen's account: all progress, plus onboarding
--
-- Requested by Mikko 2026-09-18. Scope confirmed before writing: wipe every
-- trace of study progress AND send him back through onboarding, while keeping
-- the login and the profile row itself. He is not being deleted.
--
-- WHO. Brody Gowen, gowenbrr22@yahoo.com, e448edd7-ed5a-4417-ac1d-91ea78851927.
-- Signed up 2026-06-05, last signed in 2026-06-26. His stored exam date was
-- 2026-09-11, which has already passed, so a fresh cycle is the likely reason.
--
-- THIS IS IRREVERSIBLE. There is no undo and no soft delete. What goes:
--
--     flashcard_reviews          7,261     the whole review history
--     flashcard_user_state       1,400     every card's schedule and memory state
--     question_attempts            658
--     study_plan_tasks              64
--     practice_sessions             58
--     learner_state_snapshots       30
--     daily_activity                27
--     performance_reports           10
--     learner_events                 6
--     review_schedule                5
--     user_insight_briefs            4
--     lesson_progress                2
--
-- EVERY STATEMENT IS SCOPED TO ONE user_id. No statement below can touch another
-- account: there is no DELETE here without an equality test on his id.
--
-- WHAT SURVIVES. The auth login, so he can still sign in with the same email and
-- password. The profile row, so his name and email stay. His timezone and
-- day_start_hour, which describe his device rather than his progress.
--
-- WHAT RESETS ON THE PROFILE. onboarding_completed goes false so the four-screen
-- setup runs again, and the answers it collects are cleared so it starts empty.
-- The daily limits go back to the schema defaults of 25 and 150; his new-card
-- limit was sitting at 5000, which was set by hand at some point and is not a
-- value onboarding would ever produce.
--
-- Run the first SELECT on its own first if you want to see the before picture.
-- ============================================================

-- ── Before ──────────────────────────────────────────────────────────────
SELECT 'flashcard_reviews' AS table_name, count(*) FROM public.flashcard_reviews WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'flashcard_user_state', count(*) FROM public.flashcard_user_state WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'question_attempts', count(*) FROM public.question_attempts WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'practice_sessions', count(*) FROM public.practice_sessions WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'study_plan_tasks', count(*) FROM public.study_plan_tasks WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'daily_activity', count(*) FROM public.daily_activity WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'learner_state_snapshots', count(*) FROM public.learner_state_snapshots WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'performance_reports', count(*) FROM public.performance_reports WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'user_insight_briefs', count(*) FROM public.user_insight_briefs WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'learner_events', count(*) FROM public.learner_events WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'review_schedule', count(*) FROM public.review_schedule WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'lesson_progress', count(*) FROM public.lesson_progress WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

BEGIN;

-- ── History first, then the state derived from it ───────────────────────
DELETE FROM public.flashcard_reviews       WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.question_attempts       WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.practice_sessions       WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.daily_activity          WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.lesson_progress         WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

DELETE FROM public.flashcard_user_state    WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.review_schedule         WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.study_plan_tasks        WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

-- ── Everything the analytics and reports layer inferred from the above ──
DELETE FROM public.learner_state_snapshots WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.learner_events          WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.performance_reports     WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
DELETE FROM public.user_insight_briefs     WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

-- ── Send him back through onboarding, with the answers cleared ──────────
UPDATE public.profiles
SET
  onboarding_completed = false,
  mcat_test_date       = NULL,
  target_mcat_score    = NULL,
  study_hours_per_week = NULL,
  weak_sections        = NULL,
  daily_new_card_limit = 25,
  daily_review_limit   = 150,
  weekly_question_goal = 100,
  updated_at           = now()
WHERE id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

COMMIT;

-- ── After: every count must be 0 ────────────────────────────────────────
SELECT 'flashcard_reviews' AS table_name, count(*) FROM public.flashcard_reviews WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'flashcard_user_state', count(*) FROM public.flashcard_user_state WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'question_attempts', count(*) FROM public.question_attempts WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'practice_sessions', count(*) FROM public.practice_sessions WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'study_plan_tasks', count(*) FROM public.study_plan_tasks WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'daily_activity', count(*) FROM public.daily_activity WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'learner_state_snapshots', count(*) FROM public.learner_state_snapshots WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'performance_reports', count(*) FROM public.performance_reports WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'user_insight_briefs', count(*) FROM public.user_insight_briefs WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'learner_events', count(*) FROM public.learner_events WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'review_schedule', count(*) FROM public.review_schedule WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927'
UNION ALL SELECT 'lesson_progress', count(*) FROM public.lesson_progress WHERE user_id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';

-- And the profile, which should show onboarding_completed false with empty answers.
SELECT id, first_name, last_name, email, onboarding_completed, mcat_test_date,
       study_hours_per_week, daily_new_card_limit, daily_review_limit
FROM public.profiles
WHERE id = 'e448edd7-ed5a-4417-ac1d-91ea78851927';
