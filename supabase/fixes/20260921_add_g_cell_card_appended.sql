-- ============================================================
-- The G cell card, appended this time
--
-- SUPERSEDES 20260917_add_g_cell_card.sql, which never reached the database
-- across three attempts. That file wrapped a transaction around two position
-- UPDATEs shifting 45 rows and an INSERT, so it could insert at position 24 and
-- keep the gastric gland cards together. It was also the only pending file that
-- touched row positions, and the only one that repeatedly failed, so the
-- shuffle is the suspect and it is being abandoned rather than debugged.
--
-- This is one INSERT at the end of the deck. No transaction, no UPDATE, nothing
-- that can half-apply. Position 69, after the current last card at 68.
--
-- WHAT IT COSTS. The deck browse list and the per-deck study order both read
-- `position`, so a stomach card now sits after the intestines instead of beside
-- parietal, chief and the other gastric gland cards at 17 to 23. That is a
-- cosmetic loss in one list. Cross-deck Daily Review, which is how this account
-- actually studies, orders by the scheduler rather than by position and is
-- unaffected.
--
-- WHY THE CARD EXISTS. 20260917_gastrin_g_cell_unanswerable.sql fixed a card
-- that hid "G" and "gastrin" together and left nothing to answer from. Only one
-- could stay, because the cell is NAMED for the hormone, so whichever term is
-- visible hands over the other. Gastrin stayed, and the letter G then appeared
-- nowhere in the deck while parietal, chief and surface mucous cells each keep
-- a card.
--
-- THE CUE IS THE TRIGGER, NOT THE COMPANY IT KEEPS. Naming parietal and chief
-- would have printed the answers to positions 17 and 20 on this card. The
-- stimulus that provokes G cells belongs to no other card's blank. Verified:
-- this card prints none of Parietal, Chief, pepsinogen, gastrin, bicarbonate or
-- intrinsic factor.
--
-- Verified before writing: valid cloze text, cloze_count 1, one study card,
-- 15 words (under the 28 word bar), zero structural leaks, not a duplicate of
-- anything already in the deck.
--
-- Deck 69 -> 70 cards. Bank 4,116 -> 4,117. This is an INSERT, so the card
-- enters the new-card queue and appears as unseen material.
-- ============================================================

INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
VALUES (
  '1c583198-511a-4343-9aa9-afd8bcdd789d',
  'cloze',
  'Distension and peptides in the stomach trigger hormone release from the gastric glands'' {{c1::G}} cells.',
  1,
  69
);

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 70 rows, positions 0..69, no gap and no repeat.
SELECT count(*) AS deck_cards,
       min(position) AS first_position,
       max(position) AS last_position,
       count(DISTINCT position) AS distinct_positions
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d';

-- And the card itself.
SELECT id, position, cloze_count, cloze_text
FROM public.flashcards
WHERE deck_id = '1c583198-511a-4343-9aa9-afd8bcdd789d'
  AND position = 69;
