-- Fix: Physics Ch4 Fluids, the specific gravity card.
--
-- Mikko flagged the syntax while studying. The card read:
--   "Specific gravity, SG = ρ/ρ_water, is dimensionless."
-- Flashcards render PLAIN UNICODE only, so "ρ_water" displays literally as
-- rho-underscore-water. Unicode has no subscript "w", so the honest plain-text
-- form is words, not fake subscript syntax.
--
-- A bank-wide grep confirms this is the LAST underscore-subscript survivor
-- (the 2026-07-14 notation sweep caught the rest; this one hid inside a cloze
-- answer, which that sweep's pattern did not reach).
--
-- SRS SAFE: text-only UPDATE, both blanks stay in the same c1 group, so
-- cloze_count (1) and all review history are untouched.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = 'Specific gravity, SG = {{c1::ρ / ρ of water}}, is {{c1::dimensionless}}.'
 WHERE cloze_text LIKE '%ρ/ρ_water%';

COMMIT;

-- Verification: expect 1 row, cloze_count 1.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%ρ / ρ of water%';
