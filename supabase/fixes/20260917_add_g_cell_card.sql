-- ============================================================
-- Restore the G cell to the Digestive System deck
--
-- WHY IT WENT MISSING. 20260917_gastrin_g_cell_unanswerable.sql fixed a card
-- that hid "G" and "gastrin" together and left nothing to answer from. Only one
-- of the two could stay, because the cell is NAMED for the hormone: whichever
-- term is visible hands over the other. Gastrin stayed. The letter G then
-- appeared nowhere in the deck, while parietal, chief and surface mucous cells
-- each keep a card of their own. This adds it back.
--
-- WHAT THE FIRST DRAFT GOT WRONG. It read "alongside parietal and chief cells,
-- the third secretory cell type of the gastric glands". That is false: this deck
-- already teaches surface mucous cells at position 22, so G is at least the
-- fourth. Checked against the deck before writing rather than after.
--
-- THE CUE IS THE TRIGGER, NOT THE COMPANY IT KEEPS. Listing "parietal, chief and
-- mucous" would have printed the answers to positions 17 and 20 as plain text on
-- this card, weakening both. The stimulus that provokes G cells is specific to
-- them and belongs to no other card's blank. Verified: this card prints none of
-- Parietal, Chief, pepsinogen, gastrin, bicarbonate or intrinsic factor.
--
-- Verified before writing: valid cloze text, cloze_count 1, one study card,
-- 15 words (under the 28-word bar), zero code-proven leaks.
--
-- POSITION 24, directly after the gastrin card at 23, so the gastric gland
-- cards stay together. `position` drives both the deck browse list and the
-- per-deck study order, so appending at the end would have filed a stomach card
-- after the intestines.
--
-- The shift runs in two hops through a +1000 offset. No duplicate
-- (deck_id, position) pair exists anywhere in the bank, so a unique constraint
-- may well be in force; incrementing rows in place could collide mid-statement.
-- Moving them out of range first cannot.
--
-- Deck cards 69 -> 70. Bank 4,116 -> 4,117. This is an INSERT, so the new card
-- enters the new-card queue and will appear as unseen material.
-- ============================================================

BEGIN;

-- 1. Move everything from the insertion point back, out of collision range.
UPDATE public.flashcards
SET position = position + 1000
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d'
  AND position >= 24;

-- 2. Drop the new card into the gap.
INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
VALUES (
  '1c583198-511a-4343-9aa9-afd8bcdd789d',
  'cloze',
  'Distension and peptides in the stomach trigger hormone release from the gastric glands'' {{c1::G}} cells.',
  1,
  24
);

-- 3. Bring them back, each one place later than before.
UPDATE public.flashcards
SET position = position - 999
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d'
  AND position >= 1000;

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 70 rows, positions 0..69 with no gap and no repeat, and the four
-- gastric gland cell cards sitting together at 17, 20, 22, 23, 24.
SELECT count(*) AS deck_cards,
       min(position) AS first_position,
       max(position) AS last_position,
       count(DISTINCT position) AS distinct_positions
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d';

SELECT position, cloze_count, cloze_text
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d'
  AND position BETWEEN 17 AND 26
ORDER BY position;
