-- ============================================================
-- Practice-session pause & resume
--
-- Lets a student stop a practice session mid-way, exit the page
-- (even close the browser), and resume exactly where they left off.
--
-- The question order, current position, elapsed timer, mode, and
-- flagged questions currently live only in sessionStorage, which is
-- wiped when the tab closes. This migration moves that state onto the
-- practice_sessions row so a session survives a full exit. Per-question
-- answers are already persisted in question_attempts (keyed by
-- session_id), so combined with these columns a session is fully
-- restorable.
--
-- Resumable = status 'in_progress' with current_index < total_questions.
-- No new status value is added (crash-safe: any unfinished in_progress
-- session is resumable, whether paused deliberately or abandoned).
--
-- RLS: practice_sessions already has per-user SELECT/INSERT/UPDATE
-- policies (auth.uid() = user_id). RLS policies are row-level, so the
-- new columns are covered automatically — no policy change needed.
--
-- Fully idempotent. Run in Supabase Studio -> SQL Editor.
-- Run AFTER 001_phase1_schema.sql.
-- ============================================================

-- Ordered list of question UUIDs for the session (the resume source of
-- truth; previously only in sessionStorage).
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS question_ids JSONB;

-- Index of the question the student is currently on (0-based).
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS current_index INTEGER NOT NULL DEFAULT 0;

-- Accumulated time on the session in seconds, so the timer resumes.
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS elapsed_seconds INTEGER NOT NULL DEFAULT 0;

-- Session mode: 'review' (spaced-repetition due), 'flagged', 'cram', or
-- NULL for a normal/custom session.
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS mode TEXT;

-- Question indices the student flagged for review (array of ints).
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS flagged_indices JSONB;

-- Last time the session was touched (started, answered, or paused).
-- Used to surface and sort the "Resume your session" card.
ALTER TABLE practice_sessions
  ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMPTZ;

COMMENT ON COLUMN practice_sessions.question_ids IS
  'Ordered array of question UUIDs for resume; authoritative over sessionStorage.';
COMMENT ON COLUMN practice_sessions.current_index IS
  'Zero-based index of the question the student is currently on.';
COMMENT ON COLUMN practice_sessions.elapsed_seconds IS
  'Accumulated session time in seconds so the timer resumes on pause/return.';
COMMENT ON COLUMN practice_sessions.mode IS
  'review / flagged / cram, or NULL for a normal session.';
COMMENT ON COLUMN practice_sessions.flagged_indices IS
  'Array of question indices the student flagged for review.';
COMMENT ON COLUMN practice_sessions.last_active_at IS
  'Timestamp of the last start/answer/pause; sorts the resume card.';

-- Guard rails (NULL allowed; a non-NULL value must be valid).
ALTER TABLE practice_sessions DROP CONSTRAINT IF EXISTS practice_sessions_current_index_check;
ALTER TABLE practice_sessions ADD CONSTRAINT practice_sessions_current_index_check
  CHECK (current_index >= 0);

ALTER TABLE practice_sessions DROP CONSTRAINT IF EXISTS practice_sessions_elapsed_check;
ALTER TABLE practice_sessions ADD CONSTRAINT practice_sessions_elapsed_check
  CHECK (elapsed_seconds >= 0);

ALTER TABLE practice_sessions DROP CONSTRAINT IF EXISTS practice_sessions_mode_check;
ALTER TABLE practice_sessions ADD CONSTRAINT practice_sessions_mode_check
  CHECK (mode IS NULL OR mode IN ('review', 'flagged', 'cram'));

-- Speeds up "find this user's most recent resumable session".
CREATE INDEX IF NOT EXISTS idx_practice_sessions_resume
  ON practice_sessions(user_id, status, last_active_at DESC);

-- ────────────────────────────────────────────────────────────
-- Verification (expect new_resume_columns = 6)
-- ────────────────────────────────────────────────────────────
SELECT COUNT(*) AS new_resume_columns
FROM information_schema.columns
WHERE table_name = 'practice_sessions'
  AND column_name IN ('question_ids', 'current_index', 'elapsed_seconds',
                      'mode', 'flagged_indices', 'last_active_at');
