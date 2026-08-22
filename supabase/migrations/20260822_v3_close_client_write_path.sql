-- ============================================================
-- V3 PR3 — close the direct client write path
--
-- ┌──────────────────────────────────────────────────────────────────────┐
-- │  DO NOT RUN THIS UNTIL BOTH APPS ARE DEPLOYED.                        │
-- │                                                                      │
-- │  This makes the server-side function the ONLY way to record a review.│
-- │  Any client still using the old path stops being able to save the    │
-- │  moment this runs. Required order:                                    │
-- │    1. deploy the web app (PR2)                                        │
-- │    2. ship the phone build (PR2)                                      │
-- │    3. confirm reviews are arriving with a client_request_id           │
-- │       (the check at the bottom of this file)                          │
-- │    4. only then run this                                              │
-- │                                                                      │
-- │  A rollback block is at the end. It restores the old permissions in   │
-- │  one statement if anything goes wrong.                                │
-- └──────────────────────────────────────────────────────────────────────┘
--
-- WHY THIS EXISTS. Until now the browser could write scheduling rows directly,
-- and did. That has two consequences beyond the lost-write bug PR2 fixed:
--
--   . Anyone with developer tools open can set any card to any interval, or
--     write a review that never happened. Today that only cheats the student
--     doing it, but it also means the data cannot be trusted as evidence — and
--     the whole V3 plan rests on treating retrieval history as measurement.
--
--   . Every future scheduling change would have to be shipped to every client
--     simultaneously, forever. With the write path on the server, FSRS lands in
--     one place and old clients keep working because they never did the maths.
--
-- WHAT STAYS. Reading is untouched: both apps still read their own rows freely.
-- Starring and suspending stay client-writable, because those are flags on a
-- card rather than scheduling events, and PR2 already narrowed them to update
-- only their own column.
-- ============================================================

-- ── 1. Reviews become append-only THROUGH THE FUNCTION ONLY ─────────────
-- The function is SECURITY DEFINER, so it keeps working after this: it runs as
-- its owner, not as the caller.
DROP POLICY IF EXISTS "Users can insert own reviews" ON flashcard_reviews;

-- Reading own history is unchanged.
-- (policy "Users can read own reviews" intentionally left in place)

-- ── 2. Scheduling columns become server-only ────────────────────────────
-- The old blanket UPDATE policy allowed a client to rewrite interval_days,
-- ease_factor, reps, lapses and next_review_at. Replace it with one that
-- permits changing ONLY the two flags.
DROP POLICY IF EXISTS "Users can update own card state" ON flashcard_user_state;

CREATE POLICY "Users can update own card flags"
  ON flashcard_user_state FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- A policy cannot restrict WHICH columns are updated, so the column privilege
-- does that instead: grant UPDATE on the flag columns only. Combined with the
-- policy above, a client may flip starred/suspended on its own rows and
-- nothing else.
REVOKE UPDATE ON public.flashcard_user_state FROM authenticated;
GRANT UPDATE (starred, suspended) ON public.flashcard_user_state TO authenticated;

-- INSERT stays available so a first star on a never-reviewed card can create
-- its row (see lib/flashcards/cardFlags.ts). A client-inserted row carries the
-- column defaults: interval 0, due now. It cannot invent a schedule.
REVOKE INSERT ON public.flashcard_user_state FROM authenticated;
GRANT INSERT (user_id, flashcard_id, cloze_index, starred, suspended)
  ON public.flashcard_user_state TO authenticated;

-- ── 3. Verification ─────────────────────────────────────────────────────

-- BEFORE RUNNING THE REVOCATIONS ABOVE, run this alone. It answers "are both
-- apps actually on the new path yet?". Every review in the last hour should
-- carry a client_request_id; any without one came from a client still using
-- the old write path, and revoking now would break it.
SELECT
  COUNT(*)                                              AS reviews_last_hour,
  COUNT(*) FILTER (WHERE client_request_id IS NOT NULL) AS via_new_path,
  COUNT(*) FILTER (WHERE client_request_id IS NULL)     AS via_OLD_path
FROM flashcard_reviews
WHERE reviewed_at > now() - interval '1 hour';

-- After running: confirm the grants landed as intended.
SELECT privilege_type, column_name
FROM information_schema.column_privileges
WHERE table_name = 'flashcard_user_state'
  AND grantee = 'authenticated'
ORDER BY privilege_type, column_name;

-- ── 4. ROLLBACK ─────────────────────────────────────────────────────────
-- If anything breaks, run this block to restore the previous behaviour
-- immediately. It is safe to run at any time.
--
--   CREATE POLICY "Users can insert own reviews"
--     ON flashcard_reviews FOR INSERT WITH CHECK (auth.uid() = user_id);
--
--   DROP POLICY IF EXISTS "Users can update own card flags" ON flashcard_user_state;
--   CREATE POLICY "Users can update own card state"
--     ON flashcard_user_state FOR UPDATE USING (auth.uid() = user_id);
--
--   GRANT INSERT, UPDATE ON public.flashcard_user_state TO authenticated;
--   GRANT INSERT ON public.flashcard_reviews TO authenticated;
