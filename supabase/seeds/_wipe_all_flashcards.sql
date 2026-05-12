-- ============================================================
-- Praxist Prep — Flashcard Tear-Down
--
-- ⚠️ DESTRUCTIVE — clears every flashcard deck and all
-- attached cards, user review state, and review history.
--
-- Use this when rebuilding the flashcard system from scratch
-- under a new content prompt or schema. Safe to re-run.
--
-- Cascade chain (assuming ON DELETE CASCADE on these FKs):
--   flashcard_decks   ──► flashcards
--                     ──► flashcard_user_state   (via deck or card)
--                     ──► flashcard_reviews      (via deck or card)
-- ============================================================

DO $$
DECLARE
  deck_count   INT;
  card_count   INT;
  state_count  INT;
  review_count INT;
BEGIN
  -- Snapshot the "before" counts so the operator can sanity-check.
  SELECT COUNT(*) INTO deck_count   FROM flashcard_decks;
  SELECT COUNT(*) INTO card_count   FROM flashcards;

  BEGIN
    SELECT COUNT(*) INTO state_count FROM flashcard_user_state;
  EXCEPTION WHEN undefined_table THEN
    state_count := -1; -- table doesn't exist; ignore
  END;

  BEGIN
    SELECT COUNT(*) INTO review_count FROM flashcard_reviews;
  EXCEPTION WHEN undefined_table THEN
    review_count := -1;
  END;

  RAISE NOTICE 'Before wipe — decks: %, cards: %, user_state rows: %, review rows: %',
    deck_count, card_count, state_count, review_count;

  -- Deleting all decks cascades to flashcards, and (via card FK) to
  -- flashcard_user_state and flashcard_reviews. If any of those tables
  -- ever reference user_id directly without a card FK, they'll need
  -- their own DELETE here.
  DELETE FROM flashcard_decks;

  -- Belt-and-suspenders cleanup in case cascade is partial.
  BEGIN
    DELETE FROM flashcards;
  EXCEPTION WHEN undefined_table THEN NULL;
  END;

  BEGIN
    DELETE FROM flashcard_user_state;
  EXCEPTION WHEN undefined_table THEN NULL;
  END;

  BEGIN
    DELETE FROM flashcard_reviews;
  EXCEPTION WHEN undefined_table THEN NULL;
  END;

  RAISE NOTICE 'Wipe complete. All flashcard tables emptied.';
END $$;
