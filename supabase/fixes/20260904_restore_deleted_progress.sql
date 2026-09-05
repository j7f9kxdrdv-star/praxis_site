-- ============================================================
-- Restore progress my merge repairs deleted
--
-- Mikko: "I have reviewed all the cards, so I don't get how there are 12
-- unseen." He is right. Every one of those blanks had been studied.
--
-- merge-split-contrasts deletes the progress on any card it repairs. The
-- reasoning was defensible, a leaking card could be answered without knowing
-- it, so its review history is not evidence of knowledge. What I did not think
-- through is how that looks from the student's side: cards studied for weeks
-- reappear labelled UNSEEN and are charged against the daily NEW-card budget
-- instead of the review budget, eight days before an exam.
--
-- These 28 blanks are restored as REVIEWS, not as new cards. Reps and lapses
-- are rebuilt from the actual review log rather than invented. The SCHEDULE is
-- still reset to due-now with low stability, because that part of the original
-- reasoning holds: the card asks a harder question after the merge than the one
-- that was graded, so the old interval should not carry over.
--
-- The generator no longer deletes. It now resets the schedule in place and
-- removes only rows pointing past the card's new blank count.
-- ============================================================

BEGIN;

-- The Endocrine System  c1  (7 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '16f66da1-e4c4-4fd8-a756-ef804f0a5420', 1, false, false, 0,
   2.5, 7, 1, '2026-08-22T16:51:03.055098+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c2  (8 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '16f66da1-e4c4-4fd8-a756-ef804f0a5420', 2, false, false, 0,
   2.5, 8, 0, '2026-09-01T19:35:22.528605+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Motion & Forces  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '3757167c-57e0-4777-9cbe-6c52a4efefd9', 1, false, false, 0,
   2.5, 1, 0, '2026-06-10T18:38:34.175987+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Embryonic Development & Gestation  c1  (5 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '3fe30088-a559-4ec3-9bbd-973d3e39c8de', 1, false, false, 0,
   2.5, 5, 0, '2026-07-05T15:02:51.042639+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c1  (5 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '417a364c-f519-4eb7-87e3-e2432dd42127', 1, false, false, 0,
   2.5, 5, 1, '2026-08-25T22:17:03.663295+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c2  (6 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '417a364c-f519-4eb7-87e3-e2432dd42127', 2, false, false, 0,
   2.5, 6, 1, '2026-09-01T16:43:15.817757+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c3  (4 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '417a364c-f519-4eb7-87e3-e2432dd42127', 3, false, false, 0,
   2.5, 4, 0, '2026-08-25T18:44:39.384805+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Periodic Trends & Chemical Families  c3  (1 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '4f400965-ec4e-4643-9554-a21d47b91411', 3, false, false, 0,
   2.5, 1, 1, '2026-06-23T17:35:06.324309+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Nonenzymatic Protein Function and Protein Analysis  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '5419bd9a-5491-4916-a792-9137b0f70dbd', 1, false, false, 0,
   2.5, 1, 0, '2026-07-28T14:55:00.186291+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Periodic Trends & Chemical Families  c1  (5 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '63e518b1-93cf-41ac-be8c-16491d26db46', 1, false, false, 0,
   2.5, 5, 0, '2026-09-02T20:58:53.937862+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Periodic Trends & Chemical Families  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '63e518b1-93cf-41ac-be8c-16491d26db46', 1, false, false, 0,
   2.5, 1, 0, '2026-06-23T17:31:10.152158+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '685f35d6-b8f5-4595-9a36-85a152bdf56e', 1, false, false, 0,
   2.5, 1, 0, '2026-07-18T00:30:01.285301+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Separations and Purifications  c1  (2 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '6cff16af-42de-4b68-8a75-357775f255c5', 1, false, false, 0,
   2.5, 2, 1, '2026-07-28T13:15:34.143644+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Nervous System  c1  (4 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '766fdc79-085c-4b18-befc-e47905f62aa5', 1, false, false, 0,
   2.5, 4, 0, '2026-07-08T21:47:02.821891+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Inside the Atom  c1  (5 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '917700e5-2cd1-4d02-8d06-f8b6838a0b03', 1, false, false, 0,
   2.5, 5, 0, '2026-09-04T00:20:16.510418+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Inside the Atom  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '917700e5-2cd1-4d02-8d06-f8b6838a0b03', 1, false, false, 0,
   2.5, 1, 0, '2026-06-15T23:11:33.174017+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Inside the Atom  c2  (5 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '917700e5-2cd1-4d02-8d06-f8b6838a0b03', 2, false, false, 0,
   2.5, 5, 1, '2026-09-04T02:14:52.786416+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Inside the Atom  c2  (2 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '917700e5-2cd1-4d02-8d06-f8b6838a0b03', 2, false, false, 0,
   2.5, 2, 1, '2026-06-27T12:46:44.411513+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '937373a4-8f2e-46c3-b847-588c13433f7b', 1, false, false, 0,
   2.5, 1, 0, '2026-08-05T19:50:47.85263+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Endocrine System  c2  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', '937373a4-8f2e-46c3-b847-588c13433f7b', 2, false, false, 0,
   2.5, 1, 0, '2026-08-04T18:42:04.2274+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Amino Acids  c1  (1 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '9470bc20-6bcb-4016-81a8-d18af8f56df5', 1, false, false, 0,
   2.5, 1, 0, '2026-07-18T17:16:28.319791+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Amino Acids  c3  (1 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '9470bc20-6bcb-4016-81a8-d18af8f56df5', 3, false, false, 0,
   2.5, 1, 1, '2026-07-18T23:44:42.788388+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Amino Acids  c4  (2 prior reviews, 1 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', '9470bc20-6bcb-4016-81a8-d18af8f56df5', 4, false, false, 0,
   2.5, 2, 1, '2026-06-23T17:37:05.562266+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Embryonic Development & Gestation  c1  (5 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', 'bbd49e94-5f9a-4164-b8da-f62169336f5b', 1, false, false, 0,
   2.5, 5, 0, '2026-07-08T15:24:27.009224+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Cell Division & Human Reproduction  c1  (6 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca', 'c63b3c70-378c-4335-a137-6df11ab64bb8', 1, false, false, 0,
   2.5, 6, 0, '2026-09-04T02:27:57.996745+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- Cell Division & Human Reproduction  c1  (14 prior reviews, 5 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', 'c63b3c70-378c-4335-a137-6df11ab64bb8', 1, false, false, 0,
   2.5, 14, 5, '2026-07-21T13:19:37.472669+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Nervous System  c1  (4 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', 'ccc9bda9-7e6b-4e45-9e84-375a49c84116', 1, false, false, 0,
   2.5, 4, 0, '2026-07-08T15:30:07.912763+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

-- The Nervous System  c1  (4 prior reviews, 0 lapses)
INSERT INTO public.flashcard_user_state
  (user_id, flashcard_id, cloze_index, starred, suspended, interval_days,
   ease_factor, reps, lapses, last_reviewed_at, next_review_at,
   stability, difficulty, fsrs_state, learning_steps, scheduled_days)
VALUES ('e448edd7-ed5a-4417-ac1d-91ea78851927', 'e68fb1b2-fc0e-4cf9-b727-3cfbe8c7be5b', 1, false, false, 0,
   2.5, 4, 0, '2026-07-08T15:30:14.817988+00:00', now(),
   2.0, 5.0, 2, 0, 0)
ON CONFLICT (user_id, flashcard_id, cloze_index) DO NOTHING;

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: no card-blank that has review history is missing its state row.
SELECT COUNT(*) AS studied_but_stateless FROM (
  SELECT DISTINCT r.user_id, r.flashcard_id, r.cloze_index
  FROM public.flashcard_reviews r
  JOIN public.flashcards f ON f.id = r.flashcard_id
  WHERE r.cloze_index <= f.cloze_count
) h
LEFT JOIN public.flashcard_user_state s
  ON s.user_id = h.user_id AND s.flashcard_id = h.flashcard_id
 AND s.cloze_index = h.cloze_index
WHERE s.flashcard_id IS NULL;
