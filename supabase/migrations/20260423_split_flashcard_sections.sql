-- ============================================================
-- Praxis Prep — Split flashcard sections
-- Splits bio_biochem → biology + biochemistry
-- Splits chem_phys → chemistry + physics
-- Drops cars (CARS does not benefit from spaced-repetition flashcards)
-- Keeps psych_soc as-is
-- ============================================================

-- 1. Drop the old check constraint
ALTER TABLE flashcard_decks
  DROP CONSTRAINT IF EXISTS flashcard_decks_section_check;

-- 2. (If any decks already exist in legacy values, migrate them.
--     Safe no-op when table is empty.)
UPDATE flashcard_decks SET section = 'biology'      WHERE section = 'bio_biochem';
UPDATE flashcard_decks SET section = 'chemistry'    WHERE section = 'chem_phys';
DELETE FROM flashcard_decks                          WHERE section = 'cars';

-- 3. Add the new constraint
ALTER TABLE flashcard_decks
  ADD CONSTRAINT flashcard_decks_section_check
  CHECK (section IN ('biology', 'biochemistry', 'chemistry', 'physics', 'psych_soc'));
