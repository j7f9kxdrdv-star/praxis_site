-- ============================================================
-- V3 PR5 part A — stop the content pipeline from destroying review history
--
-- THE PROBLEM. Both flashcard_reviews and flashcard_user_state declare
--
--     flashcard_id UUID NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE
--
-- and 17 seed files in supabase/seeds/ begin with a variant of
--
--     DELETE FROM flashcards WHERE deck_id IN (SELECT id FROM flashcard_decks
--                                              WHERE title IN (...))
--
-- before re-inserting the deck. So re-seeding a deck to fix a typo silently
-- deletes every student's review history and scheduling state for that deck.
-- The cards come back with NEW ids; the history does not come back at all.
--
-- That history is irreplaceable. It is also, for V3, the measurement the whole
-- system rests on: FSRS reads it, the workload forecast projects from it, and
-- the future learner model treats it as evidence.
--
-- THE FIX. Make the review log refuse to be deleted out from under a card.
-- With RESTRICT, an accidental re-seed FAILS LOUDLY instead of succeeding
-- quietly. Nothing is lost, and whoever ran it finds out immediately.
--
-- CONSEQUENCE YOU SHOULD EXPECT. After this runs, re-running any of those 17
-- seed files against a deck that has been studied will ERROR. That is the
-- point. To edit a live deck, UPDATE the cards by id: card ids stay stable,
-- cloze groups stay attached to their scheduling rows, and history survives.
-- The fixes for the 82 leaked cards in part B are written that way.
--
-- flashcard_user_state keeps CASCADE deliberately. If a card genuinely has no
-- review history, its scheduling row is meaningless once the card is gone. And
-- when the card DOES have history, the RESTRICT above aborts the whole
-- statement first, so the state rows are protected too.
-- ============================================================

ALTER TABLE public.flashcard_reviews
  DROP CONSTRAINT IF EXISTS flashcard_reviews_flashcard_id_fkey;

ALTER TABLE public.flashcard_reviews
  ADD CONSTRAINT flashcard_reviews_flashcard_id_fkey
  FOREIGN KEY (flashcard_id) REFERENCES public.flashcards(id)
  ON DELETE RESTRICT;

COMMENT ON CONSTRAINT flashcard_reviews_flashcard_id_fkey ON public.flashcard_reviews IS
  'RESTRICT, not CASCADE. A card with review history cannot be deleted; re-seeding a studied deck fails loudly rather than destroying the history it depends on. Edit live cards with UPDATE by id.';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect exactly: flashcard_reviews -> RESTRICT, flashcard_user_state -> CASCADE.
--
-- This reads the constraint metadata rather than attempting a real delete on
-- purpose. A test delete that succeeded would be the very data loss this
-- migration exists to prevent.
SELECT
  tc.table_name,
  tc.constraint_name,
  rc.delete_rule
FROM information_schema.table_constraints tc
JOIN information_schema.referential_constraints rc
  ON rc.constraint_name = tc.constraint_name
 AND rc.constraint_schema = tc.constraint_schema
JOIN information_schema.key_column_usage kcu
  ON kcu.constraint_name = tc.constraint_name
 AND kcu.constraint_schema = tc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'
  AND kcu.column_name = 'flashcard_id'
  AND tc.table_name IN ('flashcard_reviews', 'flashcard_user_state')
ORDER BY tc.table_name;

-- How much history this now protects, per deck. Any deck with a non-zero count
-- here would have lost exactly that many rows to a careless re-seed.
SELECT
  d.title,
  COUNT(r.id) AS review_rows_protected
FROM flashcard_decks d
JOIN flashcards f     ON f.deck_id = d.id
JOIN flashcard_reviews r ON r.flashcard_id = f.id
GROUP BY d.title
HAVING COUNT(r.id) > 0
ORDER BY COUNT(r.id) DESC
LIMIT 10;
