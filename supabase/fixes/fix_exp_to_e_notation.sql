-- Fix: revert exp(...) exponential notation to the textbook e^(...) form (5 cards).
-- The earlier caret-family fix rewrote e^(−λt)-style exponents as exp(−λt), which
-- is mathematically identical but unfamiliar to MCAT students; the founder read
-- the decay card as wrong. Kaplan and every prep resource write e^(...), so the
-- familiar form wins. Affects the radioactive-decay card (Physics Ch9) and the
-- four kinetics/Arrhenius cards (GenChem Ch5).
-- SRS-safe: UPDATE-only token replacement, cloze groups untouched. Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'exp(', 'e^(')
WHERE cloze_text LIKE '%exp(%';

-- Verification 1: expect 0 rows (no exp( remains).
SELECT id, LEFT(cloze_text, 90) AS still_exp
FROM public.flashcards
WHERE cloze_text LIKE '%exp(%' OR front_text LIKE '%exp(%' OR back_text LIKE '%exp(%';

-- Verification 2: expect 5 rows in the familiar e^ form.
SELECT id, LEFT(cloze_text, 110) AS reverted
FROM public.flashcards
WHERE cloze_text LIKE '%e^(−λt)%' OR cloze_text LIKE '%e^(−kt)%' OR cloze_text LIKE '%e^(−Eₐ/RT)%';
