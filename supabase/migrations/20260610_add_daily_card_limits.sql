-- ============================================================
-- Praxis Prep — Per-user daily flashcard limits
--
-- Lets each student cap how many new cards (cards they have never
-- reviewed before) and how many reviews (cards they've seen and that
-- are now due) they're shown in a single day. Hard caps protect
-- students from review-pile-up burnout and keep daily study time
-- predictable.
--
-- The session loader will read these limits and subtract the number
-- of cards already reviewed today (from the flashcard_reviews log)
-- to compute the remaining quota when building a "due" study queue.
--
-- Default values:
--   daily_new_card_limit = 25  → at 25/day, the full ~2,200-card
--                                library is introduced over ~90 days,
--                                fitting a typical 3-month MCAT runway
--   daily_review_limit   = 150 → ~6x new-card volume, a standard
--                                spaced-repetition ratio for healthy
--                                retention without overload
--
-- Students can change these from their Settings page.
--
-- Idempotent: re-running has no additional effect.
-- ============================================================

ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS daily_new_card_limit INTEGER NOT NULL DEFAULT 25,
  ADD COLUMN IF NOT EXISTS daily_review_limit   INTEGER NOT NULL DEFAULT 150;

-- Guardrails: a limit must be non-negative. Set to 0 to disable that
-- category entirely (e.g., daily_new_card_limit = 0 means "no new
-- cards today, only reviews").
ALTER TABLE profiles
  DROP CONSTRAINT IF EXISTS profiles_daily_new_card_limit_check;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_daily_new_card_limit_check
  CHECK (daily_new_card_limit >= 0);

ALTER TABLE profiles
  DROP CONSTRAINT IF EXISTS profiles_daily_review_limit_check;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_daily_review_limit_check
  CHECK (daily_review_limit >= 0);
