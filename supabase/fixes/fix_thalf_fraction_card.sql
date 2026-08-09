-- Fix: half-life symbol written t₁/₂ (subscript 1, full-size slash, subscript 2),
-- which renders as a broken stack. The bank convention is t½ (physics Ch9 deck).
-- One card, three occurrences (GenChem Ch5 Kinetics, half-life-by-order card).
-- SRS-safe: UPDATE-only token replacement, cloze groups and count untouched. Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 't₁/₂', 't½')
WHERE cloze_text LIKE '%t₁/₂%';

-- Verification: expect 0 rows (no t₁/₂ left anywhere), and 1 row showing the fixed card.
SELECT id, LEFT(cloze_text, 80) AS still_broken
FROM public.flashcards
WHERE cloze_text LIKE '%t₁/₂%' OR front_text LIKE '%t₁/₂%' OR back_text LIKE '%t₁/₂%';

SELECT id, LEFT(cloze_text, 100) AS fixed
FROM public.flashcards
WHERE cloze_text LIKE '%first-order t½%';
