-- ============================================================
-- V3 PR6 correction — the replayed backfill was pathological
--
-- WHAT WENT WRONG. Parts 1-5 seeded stability and difficulty by replaying each
-- card's real review history through FSRS. That sounded strictly better than
-- approximating, and for difficulty it was. For stability it was not.
--
-- 52% of the rows in flashcard_reviews are same-day retries: the v2 ladder's
-- "Again -> 10 minutes -> try again" loop, logged as separate reviews. Replayed
-- through FSRS's learning steps, that reads as a card failing over and over
-- within an hour. The result:
--
--   5,564 card-blanks (59% of the studied deck) landed in LEARNING state, with
--   a median stability of 0.21 days, despite the old scheduler having them at
--   1+ day intervals and students having survived those intervals for months.
--
-- Learning-state cards are scheduled by fixed short steps, not by stability. So
-- every one of those 5,564 cards was coming back in 10 minutes, forever. A card
-- the student had comfortably at 2 days became a treadmill.
--
-- THE FIX. For any card the old scheduler had settled at a day or more, seed
-- stability from that interval and put the card in Review. This is what Anki
-- does when importing SM-2 cards, and it leans on FSRS's own definition:
-- stability IS the interval at which predicted recall decays to 90%. An
-- interval a student has actually been surviving is a far better estimate of
-- that than a replay of retry loops.
--
-- Difficulty is KEPT from the replay. Unlike stability it is derived from the
-- pattern of grades rather than their timing, so the same-day retries distort
-- it much less. Median 7.6 out of 10 is a fair reading of a deck where 35% of
-- all reviews are graded Again.
--
-- Cards still under a day are left exactly as they are: those genuinely are
-- mid-acquisition, and Learning is the right state for them.
--
-- next_review_at is untouched. Nobody's due date moves.
-- ============================================================

UPDATE public.flashcard_user_state SET
  stability      = LEAST(GREATEST(interval_days, 0.5), 365),
  fsrs_state     = 2,      -- Review
  learning_steps = 0,
  scheduled_days = interval_days,
  difficulty     = COALESCE(difficulty, 7.6)
WHERE interval_days >= 1
  AND stability IS NOT NULL;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect: no unsuspended card sitting in Learning with a 1+ day interval.
SELECT COUNT(*) AS stuck_in_learning
FROM public.flashcard_user_state
WHERE suspended = false AND fsrs_state = 1 AND interval_days >= 1;

-- Expect Review to now hold every previously-studied blank, and Learning to
-- hold only cards genuinely under a day.
SELECT
  CASE fsrs_state WHEN 0 THEN 'New' WHEN 1 THEN 'Learning'
                  WHEN 2 THEN 'Review' WHEN 3 THEN 'Relearning' END AS state,
  COUNT(*)                                          AS cards,
  ROUND(MIN(interval_days)::numeric, 3)             AS min_interval,
  ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY stability))::numeric, 2) AS median_stability
FROM public.flashcard_user_state
WHERE suspended = false
GROUP BY 1 ORDER BY 2 DESC;
