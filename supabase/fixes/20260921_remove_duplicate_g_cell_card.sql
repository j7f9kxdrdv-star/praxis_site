-- ============================================================
-- Remove the duplicate G cell card
--
-- 20260921_add_g_cell_card_appended.sql was executed twice, three seconds
-- apart, so the deck now holds two identical cards at position 69:
--
--   1eefbe52-3a94-474d-bb79-10469aa46480   created 18:34:02   KEEP
--   7fa552cf-264d-46f4-ab40-55a26beac76c   created 18:34:05   DELETE
--
-- The deck stands at 71 cards and the bank at 4,118, both one too many.
--
-- WHICH ONE GOES. The later of the two. Both are byte-identical in content and
-- neither has been studied: flashcard_reviews and flashcard_user_state each
-- return zero rows for BOTH ids, checked before writing this. So no review
-- history and no scheduling state is lost either way, and keeping the first
-- insert is simply the tidier convention.
--
-- WHAT THIS TAUGHT US, worth recording. There is NO unique constraint on
-- (deck_id, position): two rows sat at 69 quite happily. The earlier version of
-- this card's INSERT went to elaborate lengths to avoid a mid-statement
-- collision while shifting 45 rows, on the assumption such a constraint might
-- exist. It does not. That file was abandoned for other reasons and this
-- confirms the caution was unnecessary, though the shuffle is still not worth
-- reintroducing.
--
-- The delete is by id and names a single row. It cannot touch the survivor.
-- ============================================================

DELETE FROM public.flashcards
WHERE id = '7fa552cf-264d-46f4-ab40-55a26beac76c';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 70 rows, positions 0..69, 70 distinct positions, and exactly one
-- card whose text mentions G cells.
SELECT count(*) AS deck_cards,
       min(position) AS first_position,
       max(position) AS last_position,
       count(DISTINCT position) AS distinct_positions
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d';

SELECT id, position, cloze_count, cloze_text
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d'
  AND cloze_text LIKE '%Distension and peptides%';
