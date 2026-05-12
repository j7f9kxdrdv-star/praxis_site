-- ============================================================
-- Praxis Prep — Add organic_chemistry as a top-level section
--
-- Organic Chemistry warrants its own top-level subject in the
-- Flashcards UI (alongside Biology, Biochemistry, Chemistry,
-- Physics, and Psych/Soc) — both because it has its own
-- distinct chapter sequence in the curriculum and because
-- grouping it under "chemistry" buries it behind the General
-- Chemistry decks.
--
-- This migration:
--   1. Drops the existing section CHECK constraint
--   2. Migrates any Organic-Chemistry-topic decks from
--      section='chemistry' to section='organic_chemistry'
--   3. Re-adds the CHECK constraint with the new value allowed
--
-- After this runs, any seed file with section='organic_chemistry'
-- will pass the constraint, and existing shipped Orgo decks
-- will appear in their own top-level row in the UI.
--
-- Idempotent: re-running has no additional effect.
-- ============================================================

-- 1. Drop the old check constraint so we can update rows that
--    would otherwise violate it.
ALTER TABLE flashcard_decks
  DROP CONSTRAINT IF EXISTS flashcard_decks_section_check;

-- 2. Migrate any decks currently filed under section='chemistry'
--    with topic='Organic Chemistry' over to section='organic_chemistry'.
--    Safe no-op when no such rows exist.
UPDATE flashcard_decks
   SET section = 'organic_chemistry'
 WHERE section = 'chemistry'
   AND topic   = 'Organic Chemistry';

-- 3. Re-add the CHECK constraint with the new value allowed.
ALTER TABLE flashcard_decks
  ADD CONSTRAINT flashcard_decks_section_check
  CHECK (section IN (
    'biology',
    'biochemistry',
    'chemistry',
    'organic_chemistry',
    'physics',
    'psych_soc'
  ));
