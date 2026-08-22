-- ============================================================
-- V3 PR1 — Study-day foundation + review provenance
--
-- Additive only. No existing row's schedule is changed, no card is moved,
-- and nothing is deleted. Every statement is idempotent, so re-running is
-- safe.
--
-- WHY THESE FOUR THINGS, in the order they matter:
--
-- 1. THE STUDY DAY HAS NO DEFINITION ANYWHERE.
--    Today "what counts as today" is computed in the browser at local
--    midnight and never recomputed, and no timezone is stored on the
--    profile (verified across all 25 existing migrations). Two problems
--    follow. A session that runs past midnight splits across two study
--    days and burns two days of quota, which is exactly what happens here:
--    the review log shows sessions at 21:00, 22:00 and 00:00. And once the
--    server owns scheduling (PR2) it cannot ask the browser what day it is.
--    day_start_hour defaults to 4, the Anki convention, so late-night study
--    counts toward the day it felt like.
--
-- 2. REVIEWS DO NOT RECORD WHERE THEY CAME FROM.
--    Daily Review and Extra Study attempts are indistinguishable in the
--    log, so the counters cannot tell them apart and neither can analytics.
--    V3 requires them separated: Extra Study advances the same memory state
--    but must never decrement Daily Review capacity.
--
-- 3. A DOUBLE-TAP CAN BE GRADED TWICE.
--    The review log's only key is a random row id, so a double-click, a
--    network retry, or the same card open twice all insert a second row.
--    This is not hypothetical: 12 pairs of reviews on the same card-blank
--    landed under a second apart, and 2 of them carried DIFFERENT grades
--    (one pair 95ms apart, "hard" then "medium"). Which grade the card kept
--    was decided by network timing. client_request_id makes a retry
--    idempotent: the same attempt submitted twice records once.
--
-- 4. FIRST EXPOSURE IS INFERRED FROM A FIELD THAT IS ABOUT TO CHANGE MEANING.
--    Everything that splits "new" from "review" keys off
--    prev_interval_days = 0. Under FSRS, interval_days stops being the
--    primary state, and 455 legacy rows already violate the invariant. This
--    replaces the inference with a recorded fact, backfilled from the
--    earliest review per card-blank rather than from the broken field.
-- ============================================================

-- ── 1. Study day ────────────────────────────────────────────────────────
ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS timezone       TEXT,
  ADD COLUMN IF NOT EXISTS day_start_hour INTEGER NOT NULL DEFAULT 4;

-- 0 = midnight rollover, 4 = the default (a 2am session counts as the
-- previous study day). Anything past 12 would push the boundary into the
-- afternoon, which no student would expect.
ALTER TABLE profiles DROP CONSTRAINT IF EXISTS profiles_day_start_hour_check;
ALTER TABLE profiles
  ADD CONSTRAINT profiles_day_start_hour_check
  CHECK (day_start_hour >= 0 AND day_start_hour <= 12);

COMMENT ON COLUMN profiles.timezone IS
  'IANA name, e.g. America/New_York. NULL means the client has not reported one yet; callers fall back to the browser timezone until it is set.';
COMMENT ON COLUMN profiles.day_start_hour IS
  'Local hour at which the study day rolls over. 4 by default so a session running past midnight stays on one study day.';

-- ── 2. Review provenance ────────────────────────────────────────────────
ALTER TABLE flashcard_reviews
  ADD COLUMN IF NOT EXISTS source TEXT;

-- Deliberately permissive for now: existing rows predate the column and
-- stay NULL, which reads as "unknown, before provenance was recorded".
-- PR4 tightens this to NOT NULL once every write path sets it.
ALTER TABLE flashcard_reviews DROP CONSTRAINT IF EXISTS flashcard_reviews_source_check;
ALTER TABLE flashcard_reviews
  ADD CONSTRAINT flashcard_reviews_source_check
  CHECK (source IS NULL OR source IN ('daily_review', 'extra_study', 'starred', 'deck_all'));

COMMENT ON COLUMN flashcard_reviews.source IS
  'Which surface produced this attempt. Analytics and capacity accounting only: every source updates the SAME memory state. NULL means recorded before PR1.';

-- ── 3. Idempotency ──────────────────────────────────────────────────────
ALTER TABLE flashcard_reviews
  ADD COLUMN IF NOT EXISTS client_request_id UUID;

-- Partial unique index: only constrains rows that carry an id, so the
-- ~29,900 historical rows with NULL are unaffected.
CREATE UNIQUE INDEX IF NOT EXISTS flashcard_reviews_client_request_uniq
  ON flashcard_reviews (user_id, client_request_id)
  WHERE client_request_id IS NOT NULL;

COMMENT ON COLUMN flashcard_reviews.client_request_id IS
  'Client-generated id for one grading action. A retry of the same attempt reuses it, so the unique index turns a duplicate submission into a no-op.';

-- ── 4. Explicit first exposure ──────────────────────────────────────────
ALTER TABLE flashcard_reviews
  ADD COLUMN IF NOT EXISTS is_first_exposure BOOLEAN;

COMMENT ON COLUMN flashcard_reviews.is_first_exposure IS
  'TRUE when this attempt was the card-blank''s first-ever exposure for this user. Replaces inferring it from prev_interval_days = 0, which 455 legacy rows violate.';

-- Backfill from the review log itself: the earliest attempt per
-- (user_id, flashcard_id, cloze_index) is by definition the first exposure.
-- Ties on identical timestamps are broken by row id so exactly one wins.
WITH first_rows AS (
  SELECT DISTINCT ON (user_id, flashcard_id, cloze_index) id
  FROM flashcard_reviews
  ORDER BY user_id, flashcard_id, cloze_index, reviewed_at ASC, id ASC
)
UPDATE flashcard_reviews r
SET is_first_exposure = (r.id IN (SELECT id FROM first_rows))
WHERE r.is_first_exposure IS NULL;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect: every review row now carries a first-exposure flag, and the count
-- of TRUE rows equals the number of distinct card-blanks ever reviewed.
SELECT
  COUNT(*)                                              AS review_rows,
  COUNT(*) FILTER (WHERE is_first_exposure IS NULL)     AS still_unflagged,
  COUNT(*) FILTER (WHERE is_first_exposure)             AS marked_first_exposure,
  (SELECT COUNT(*) FROM (
     SELECT DISTINCT user_id, flashcard_id, cloze_index FROM flashcard_reviews
   ) d)                                                 AS distinct_card_blanks
FROM flashcard_reviews;

-- Expect 0: rows that would have been misclassified by the OLD inference.
-- These are the legacy rows that carried prev_interval_days = 0 on a card
-- that had already been seen, and would have been counted against the daily
-- NEW-card budget on a day they were really reviews.
SELECT COUNT(*) AS legacy_rows_the_old_rule_got_wrong
FROM flashcard_reviews
WHERE prev_interval_days = 0
  AND is_first_exposure IS FALSE;

-- Expect one row per profile, all with day_start_hour = 4.
SELECT day_start_hour, COUNT(*) AS profiles
FROM profiles GROUP BY day_start_hour ORDER BY day_start_hour;
