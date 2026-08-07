-- OPTIONAL one-time backfill: restore card strength erased by the v1 scheduler.
--
-- Context: until 2026-08-07 the scheduler used interval_days as both a card's earned strength and
-- its time-to-next-show, so every "Again" wiped the card's history back to zero. The v2 scheduler
-- (deployed with this fix) halves strength on a lapse instead. That fix is forward-looking; this
-- backfill gives previously-damaged cards a head start so they do not all rebuild from one day.
--
-- The signal: under v1, reps was RESET by every Again, so a row's surviving reps equals its streak
-- of consecutive successes since its last lapse. That is a fair, conservative strength estimate.
--
-- The formula: strength = 1.45^min(reps, 9), capped at 21 days, and only ever RAISED, never lowered.
--   reps 2 -> 2.1d   reps 4 -> 4.4d   reps 6 -> 9.3d   reps 8 -> 19.7d   reps 9+ -> 21d cap
-- Rows with reps < 2 are untouched (no streak to restore). Rows a v1 lapse left at ~0.007d have
-- reps 0 and are untouched; they relearn through the normal 1/3/5-day seeds.
--
-- Deliberately NOT touched: next_review_at (nothing is rescheduled; cards due today stay due today
-- and simply grow from restored strength when graded), ease_factor (the new ladder adapts it from
-- here), and the flashcard_reviews history table.
--
-- SRS SAFE and idempotent: re-running changes nothing further, since GREATEST keeps the higher value.

BEGIN;

UPDATE public.flashcard_user_state
   SET interval_days = GREATEST(interval_days, LEAST(POWER(1.45, LEAST(reps, 9)), 21))
 WHERE reps >= 2;

COMMIT;

-- Verification: strength distribution after the backfill, by account.
SELECT u.email,
       COUNT(*)                                      AS cards,
       ROUND(AVG(s.interval_days)::numeric, 1)       AS avg_strength_days,
       COUNT(*) FILTER (WHERE s.interval_days >= 7)  AS at_least_1wk,
       COUNT(*) FILTER (WHERE s.interval_days >= 21) AS at_3wk_cap
  FROM public.flashcard_user_state s
  JOIN auth.users u ON u.id = s.user_id
 GROUP BY 1 ORDER BY 2 DESC;
