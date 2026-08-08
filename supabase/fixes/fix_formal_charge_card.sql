-- Fix: GenChem Ch3 Bonding, the formal charge card.
--
-- Mikko flagged the syntax. The card read:
--   "Formal charge = V – Nnonbonding – ½·Nbonding, where V is the atom's neutral valence electron
--    count, Nnonbonding is its lone-pair electron count, and Nbonding is its shared electron count."
-- "Nnonbonding" is a subscript (N with "nonbonding" beneath it) mashed into plain text, which the
-- card display renders literally as one unreadable word.
--
-- The plain-text fix uses parenthesised words, which also makes the trailing definitions of the two
-- N terms redundant, tightening the card from 36 words to 19 (the card-length bar is ~28).
-- Bank-wide sibling check: Keq, Vmax, Fnet, Ptotal and similar SHORT conventional names read fine
-- and are left alone; this was the only genuine mash.
--
-- SRS SAFE: text-only UPDATE, the single c1 blank is unchanged, cloze_count stays 1.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = '{{c1::Formal charge}} = V − (lone-pair electrons) − ½·(bonding electrons), where V is the atom''s neutral valence electron count.'
 WHERE cloze_text LIKE '%Nnonbonding%';

COMMIT;

-- Verification: expect 1 row, cloze_count 1.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%lone-pair electrons) − ½·(bonding electrons%';
