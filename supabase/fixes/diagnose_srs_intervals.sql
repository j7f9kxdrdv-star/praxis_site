-- Diagnostic only, changes nothing.
--
-- Mikko: the interval row under the grade buttons always reads 10m / 1d / 3d / 5d no matter how many
-- times a card is reviewed. Those are exactly the scheduler's FIRST-REVIEW seed values, which it uses
-- whenever a card's stored interval is below 1 day. These queries show whether cards are actually
-- accumulating interval or resetting.
--
-- NOTE: the earlier version filtered on auth.uid(), which is NULL in the SQL Editor because you are
-- connected as the postgres role rather than as a signed-in user. That is why it returned no rows.
-- This version groups by account email instead, so every account shows and you can find yours.

-- 1. WHO has study history at all
SELECT u.email, COUNT(*) AS card_states, MAX(s.last_reviewed_at) AS last_studied
  FROM public.flashcard_user_state s
  JOIN auth.users u ON u.id = s.user_id
 GROUP BY 1 ORDER BY 2 DESC;

-- 2. THE DECISIVE ONE: are repeatedly-reviewed cards maturing, or stuck near zero?
--    If cards with 5+ reviews still average a 1 to 3 day interval, the lapse reset is erasing progress.
SELECT u.email,
       LEAST(s.reps, 10) AS reviews_done,
       COUNT(*)          AS cards,
       ROUND(AVG(s.interval_days)::numeric, 2) AS avg_interval_days,
       ROUND(MAX(s.interval_days)::numeric, 2) AS max_interval_days
  FROM public.flashcard_user_state s
  JOIN auth.users u ON u.id = s.user_id
 GROUP BY 1, 2 ORDER BY 1, 2;

-- 3. How far have cards progressed overall
SELECT u.email,
       CASE WHEN s.interval_days < 1  THEN 'a. under 1 day (shows seed values 1/3/5)'
            WHEN s.interval_days < 3  THEN 'b. 1 to 3 days'
            WHEN s.interval_days < 8  THEN 'c. 3 to 8 days'
            WHEN s.interval_days < 21 THEN 'd. 8 to 21 days'
            ELSE                           'e. over 21 days' END AS interval_band,
       COUNT(*) AS cards,
       ROUND(AVG(s.reps), 1)   AS avg_reviews,
       ROUND(AVG(s.lapses), 1) AS avg_lapses
  FROM public.flashcard_user_state s
  JOIN auth.users u ON u.id = s.user_id
 GROUP BY 1, 2 ORDER BY 1, 2;

-- 4. Is ease_factor doing anything? The scheduler never reads it, so expect a single value.
SELECT ease_factor, COUNT(*) AS cards
  FROM public.flashcard_user_state
 GROUP BY 1 ORDER BY 2 DESC;

-- 5. Rating mix. Every "Again" is what triggers the reset.
SELECT u.email, r.rating, COUNT(*) AS reviews,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY u.email), 1) AS pct
  FROM public.flashcard_reviews r
  JOIN auth.users u ON u.id = r.user_id
 GROUP BY 1, 2 ORDER BY 1, 3 DESC;
