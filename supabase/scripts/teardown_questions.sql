-- ============================================================
-- TEARDOWN: clear all questions and dependent rows.
--
-- Phase 2 of the standalone-questions rebuild. After this runs,
-- the `questions` library is empty and we'll seed a fresh set
-- chapter-by-chapter in Phase 3.
--
-- Idempotent. Preserves schema, indexes, RLS policies, triggers,
-- and foreign keys. Only row data is removed.
--
-- The `daily_activity` table is intentionally left alone — those
-- rows record real study time, not question content, so the
-- historical streak / "questions completed" totals stay accurate.
--
-- Run in Supabase Studio → SQL Editor → New query.
-- ============================================================

BEGIN;

-- 1. Per-user per-question rows that FK to questions
DELETE FROM question_attempts;
DELETE FROM review_schedule;

-- 2. Practice session shells. They don't FK to questions, but
--    their selected-question id lists live in sessionStorage on
--    the client; wiping these prevents anyone from resuming a
--    stale in-progress session.
DELETE FROM practice_sessions;

-- 3. The questions themselves
DELETE FROM questions;

-- 4. Passage shells — questions referenced these via passage_id,
--    and there's nothing left to anchor them to.
DELETE FROM passages;

COMMIT;

-- Verification (every count should be 0)
SELECT
  (SELECT COUNT(*) FROM questions)         AS questions_remaining,
  (SELECT COUNT(*) FROM passages)          AS passages_remaining,
  (SELECT COUNT(*) FROM question_attempts) AS attempts_remaining,
  (SELECT COUNT(*) FROM review_schedule)   AS schedule_remaining,
  (SELECT COUNT(*) FROM practice_sessions) AS sessions_remaining;
