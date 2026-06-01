-- ============================================================
-- Praxis Prep — Add amino_acids as a top-level section
--
-- Amino acids are a high-yield MCAT memorization topic that
-- benefits from a focused drill deck (20 standard AAs + their
-- abbreviations, side-chain classes, pKa values, and special
-- features). Surfacing it as its own top-level section in the
-- Flashcards UI lets students review just this content as a
-- single reference set, separate from the broader Biochemistry
-- chapters that will eventually live alongside it.
--
-- This migration:
--   1. Drops the existing section CHECK constraint
--   2. Re-adds the CHECK constraint with 'amino_acids' allowed
--
-- After this runs, any seed file with section='amino_acids'
-- will pass the constraint.
--
-- Idempotent: re-running has no additional effect.
-- ============================================================

-- 1. Drop the old check constraint
ALTER TABLE flashcard_decks
  DROP CONSTRAINT IF EXISTS flashcard_decks_section_check;

-- 2. Re-add the CHECK constraint with amino_acids now allowed.
ALTER TABLE flashcard_decks
  ADD CONSTRAINT flashcard_decks_section_check
  CHECK (section IN (
    'biology',
    'biochemistry',
    'chemistry',
    'organic_chemistry',
    'amino_acids',
    'physics',
    'psych_soc'
  ));
