-- V3 PR6 backfill, part 6 of 6 — the rows replay alone cannot reach
--
-- Part 6 exists because parts 1-5 left 735 scheduling rows untouched. They are not a
-- mistake in the backfill; they are two older bugs surfacing.
--
-- (a) 729 rows carry real progress — reps 1 to 5, intervals out to 20 days, a
--     last rating and a timestamp — but have ZERO rows in flashcard_reviews.
--     These are pre-PR2 casualties, from when the browser wrote the schedule
--     and the review-log insert failed silently with nobody checking. There is
--     no history to replay, so stability is approximated from the interval the
--     v2 ladder had settled on, which is what FSRS's own definition of
--     stability licenses: it IS the interval at which recall decays to 90%.
--
--     Difficulty is seeded at 7.6 rather than a neutral 5. That is the median
--     difficulty actually recovered from the 8723 card-blanks that DO have
--     history in this deck. Seeding 5 would tell the scheduler these cards are
--     easier than this deck's cards measurably are, and space them too far
--     apart. One review each and FSRS corrects it from evidence either way.
--
-- (b) 17 card-blanks have the opposite problem: review history but no
--     scheduling row, so they are currently invisible to study and would never
--     come up again. Their state IS recoverable by replay, so these are
--     inserted outright, which puts the cards back in circulation.
--
-- After this runs, every row that can be seeded is seeded. still_missing
-- should read 6: cards that genuinely have never been studied, where
-- NULL stability is the correct answer and the scheduler treats them as new.

-- (a) approximate from the settled interval
UPDATE public.flashcard_user_state AS s SET
  stability      = LEAST(GREATEST(s.interval_days, 0.5), 365),
  difficulty     = 7.6,
  fsrs_state     = 2,
  learning_steps = 0,
  scheduled_days = s.interval_days
WHERE s.stability IS NULL
  AND (s.reps > 0 OR s.interval_days >= 1)
  AND NOT EXISTS (
    SELECT 1 FROM public.flashcard_reviews r
    WHERE r.user_id = s.user_id
      AND r.flashcard_id = s.flashcard_id
      AND r.cloze_index = s.cloze_index
  );

-- (b) rebuild the scheduling rows that went missing entirely
INSERT INTO public.flashcard_user_state (
  user_id, flashcard_id, cloze_index,
  interval_days, ease_factor, reps, lapses, last_rating, last_reviewed_at, next_review_at,
  stability, difficulty, fsrs_state, learning_steps, scheduled_days
) VALUES
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'67eb7343-55b4-4f4f-bd4a-d6d713d2c6a8'::uuid,3,0.0007,2.5,1,0,'again','2026-06-19T17:19:48.269919+00:00'::timestamptz,'2026-06-19T17:20:48.269Z'::timestamptz,0.2120,6.4133,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'96aadd80-438b-47aa-9326-324694289b47'::uuid,3,0.0007,2.5,1,0,'again','2026-06-19T17:37:11.872137+00:00'::timestamptz,'2026-06-19T17:38:11.872Z'::timestamptz,0.2120,6.4133,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'0d203e8b-7fd7-4457-9443-6918a30bf02c'::uuid,3,0.0042,2.5,11,0,'hard','2026-07-17T01:23:04.986527+00:00'::timestamptz,'2026-07-17T01:29:04.986Z'::timestamptz,0.0040,9.9696,1,0,0),
  ('4cee91a2-8ff0-4451-bc28-5c1d9bb18599'::uuid,'65dbb712-2ba1-4ffc-a9b0-05a2c9af1b47'::uuid,1,0.0069,2.5,1,0,'medium','2026-06-27T14:38:52.875147+00:00'::timestamptz,'2026-06-27T14:48:52.875Z'::timestamptz,2.3065,2.1181,1,1,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'282e7404-76cf-4e6e-8051-10eab00d24b8'::uuid,4,0.0042,2.5,3,0,'hard','2026-07-13T16:30:51.778208+00:00'::timestamptz,'2026-07-13T16:36:51.778Z'::timestamptz,19.8584,6.7339,1,1,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'14e2fa26-4c54-4409-bda9-cf7f1ee1814e'::uuid,3,0.0069,2.5,5,0,'medium','2026-08-05T20:14:51.283108+00:00'::timestamptz,'2026-08-05T20:24:51.283Z'::timestamptz,11.1927,8.9059,1,1,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'1349f19e-e173-4b98-bbf2-e3242a92d844'::uuid,3,0.0042,2.5,4,0,'hard','2026-07-17T00:30:31.814169+00:00'::timestamptz,'2026-07-17T00:36:31.814Z'::timestamptz,2.6047,8.9196,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'0fd383e2-8570-4811-9f0b-7774e24414cd'::uuid,2,0.0069,2.5,2,0,'medium','2026-07-16T21:51:45.028238+00:00'::timestamptz,'2026-07-16T22:01:45.028Z'::timestamptz,8.0432,5.1023,1,1,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'1cb06b5d-84bf-45a8-b3b6-ce85e28a2e4d'::uuid,3,0.0042,2.5,4,0,'hard','2026-07-16T22:02:23.694035+00:00'::timestamptz,'2026-07-16T22:08:23.694Z'::timestamptz,0.0998,9.4527,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'3c79921f-63d0-456c-998f-69c703a7340f'::uuid,2,0.0042,2.5,3,0,'hard','2026-07-16T01:05:49.200421+00:00'::timestamptz,'2026-07-16T01:11:49.200Z'::timestamptz,0.0834,9.1928,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'4278ae9e-713d-45fa-b9b1-8ae78158c3f9'::uuid,2,0.0042,2.5,1,0,'hard','2026-07-16T01:20:23.21791+00:00'::timestamptz,'2026-07-16T01:26:23.217Z'::timestamptz,1.2931,5.1122,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'49cd4cc7-1e67-403f-9dff-3dd1dc169a54'::uuid,3,0.0042,2.5,1,0,'hard','2026-07-16T19:55:12.55077+00:00'::timestamptz,'2026-07-16T20:01:12.550Z'::timestamptz,1.2931,5.1122,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'4eb7e4ec-f2ed-4ea8-8d46-4f43e3dc4208'::uuid,2,0.0042,2.5,1,0,'hard','2026-07-16T20:08:00.206939+00:00'::timestamptz,'2026-07-16T20:14:00.206Z'::timestamptz,1.2931,5.1122,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'51cbfa33-1072-4b94-b5cb-f68dca1b30a9'::uuid,3,0.0042,2.5,2,0,'hard','2026-07-17T00:59:49.328305+00:00'::timestamptz,'2026-07-17T01:05:49.328Z'::timestamptz,0.2120,7.6042,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'6a4cf538-947d-457d-9b2e-ed8495e0cc8d'::uuid,3,0.0042,2.5,4,0,'hard','2026-07-18T03:03:18.186414+00:00'::timestamptz,'2026-07-18T03:09:18.186Z'::timestamptz,0.0349,9.7150,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'6d90402f-1053-4b92-806f-214ea05d8144'::uuid,3,0.0042,2.5,1,0,'hard','2026-07-28T17:42:45.672863+00:00'::timestamptz,'2026-07-28T17:48:45.672Z'::timestamptz,1.2931,5.1122,1,0,0),
  ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,'7258535d-0375-4ff5-a7f4-260021478f52'::uuid,2,0.0042,2.5,1,0,'hard','2026-07-29T16:59:58.997077+00:00'::timestamptz,'2026-07-29T17:05:58.997Z'::timestamptz,1.2931,5.1122,1,0,0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 6, all of them never-studied cards.
SELECT COUNT(*) AS still_missing
FROM public.flashcard_user_state WHERE stability IS NULL;

-- Expect zero: nothing seeded should be outside FSRS's own valid ranges.
SELECT COUNT(*) AS out_of_range
FROM public.flashcard_user_state
WHERE (stability IS NOT NULL AND (stability < 0 OR stability > 36500))
   OR (difficulty IS NOT NULL AND (difficulty < 1 OR difficulty > 10));
