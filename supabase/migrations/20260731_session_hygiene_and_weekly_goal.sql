-- Session hygiene + personal weekly goal
--
-- Why: practice sessions launched from "all of section" / Smart Review had no size cap,
-- so users were handed 40-421 question sessions. Completion data across all users:
--   1-10 q: 93% finished | 11-25 q: 100% | 26-50 q: 20% | 51-100 q: 8% | 100+ q: 0%
-- Unfinished sessions stay 'in_progress' forever, and the hub's Resume banner surfaces the
-- most recent one with no way to dismiss it. Result: 20 zombie sessions across 4 users, all
-- 7+ days stale, oldest 46 days, permanently nagging the dashboard.
--
-- Also: the dashboard weekly-goal ring was hardcoded to 50 questions/week and clamped to 100%,
-- so any regular studier sat pinned at 100% forever. It becomes a per-user setting.

-- 1) Allow sessions to be explicitly abandoned (discarded by the user, or aged out).
DO $$
DECLARE c text;
BEGIN
  FOR c IN
    SELECT con.conname
    FROM pg_constraint con
    JOIN pg_class rel ON rel.oid = con.conrelid
    JOIN pg_namespace ns ON ns.oid = rel.relnamespace
    WHERE ns.nspname = 'public'
      AND rel.relname = 'practice_sessions'
      AND con.contype = 'c'
      AND pg_get_constraintdef(con.oid) ILIKE '%in_progress%'
  LOOP
    EXECUTE format('ALTER TABLE public.practice_sessions DROP CONSTRAINT %I', c);
  END LOOP;
END $$;

ALTER TABLE public.practice_sessions
  ADD CONSTRAINT practice_sessions_status_check
  CHECK (status IN ('in_progress', 'completed', 'abandoned'));

-- 2) Retire the existing zombie sessions (anything in_progress and untouched for 7+ days).
UPDATE public.practice_sessions
SET status = 'abandoned'
WHERE status = 'in_progress'
  AND COALESCE(last_active_at, started_at) < NOW() - INTERVAL '7 days';

-- 3) Per-user weekly question goal (replaces the hardcoded 50).
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS weekly_question_goal INTEGER DEFAULT 100;

UPDATE public.profiles
SET weekly_question_goal = 100
WHERE weekly_question_goal IS NULL;

ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_weekly_question_goal_check
  CHECK (weekly_question_goal IS NULL OR (weekly_question_goal > 0 AND weekly_question_goal <= 2000));

-- Verification
SELECT status, COUNT(*) AS sessions
FROM public.practice_sessions
GROUP BY status
ORDER BY status;
