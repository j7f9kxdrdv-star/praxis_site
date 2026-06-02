-- ============================================================
-- Praxis Prep — Add scientific_reasoning as a top-level section
--
-- Research design, study types, statistics, and ethics are tested
-- across all four MCAT science sections (the AAMC "Scientific
-- Inquiry and Reasoning Skills" or SIRS framework). Burying that
-- content under Physics implies it's only physics-relevant, when
-- in reality it shows up in Biology, Biochemistry, and Psych/Soc
-- passages just as often. A dedicated top-level section gives
-- this content a home where users will actually look for it.
--
-- This migration:
--   1. Drops the existing section CHECK constraint
--   2. Re-adds the CHECK constraint with 'scientific_reasoning'
--      added to the allowed list
--
-- After this runs, any seed file with section='scientific_reasoning'
-- will pass the constraint.
--
-- Idempotent: re-running has no additional effect.
-- ============================================================

ALTER TABLE flashcard_decks
  DROP CONSTRAINT IF EXISTS flashcard_decks_section_check;

ALTER TABLE flashcard_decks
  ADD CONSTRAINT flashcard_decks_section_check
  CHECK (section IN (
    'biology',
    'biochemistry',
    'chemistry',
    'organic_chemistry',
    'amino_acids',
    'physics',
    'scientific_reasoning',
    'psych_soc'
  ));
