-- Fix: run-together word-subscript mashes in force/fluid formulas (5 cards).
-- Fb, ρfluid, Vdisp, Fg, Fnet render as glued-together tokens; no Unicode
-- subscripts exist for b/f/d/g/net, so they get the parenthesized form used by
-- the E°(cell) family: F(b) = ρ(fluid)·V(disp)·g, F(g), F(net).
-- Cards touched: buoyant force + fluid weight (Physics Ch4), universal
-- gravitation + Newton's first and second laws (Physics Ch1).
-- SRS-safe: UPDATE-only token replacements, cloze groups untouched. Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'ρfluid', 'ρ(fluid)')
WHERE cloze_text LIKE '%ρfluid%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Vdisp', 'V(disp)')
WHERE cloze_text LIKE '%Vdisp%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Fb =', 'F(b) =')
WHERE cloze_text LIKE '%Fb =%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Fg =', 'F(g) =')
WHERE cloze_text LIKE '%Fg =%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Fnet =', 'F(net) =')
WHERE cloze_text LIKE '%Fnet =%';

-- Verification 1: expect 0 rows (no mashed token remains anywhere).
SELECT id, LEFT(cloze_text, 90) AS still_mashed
FROM public.flashcards
WHERE cloze_text LIKE '%ρfluid%' OR cloze_text LIKE '%Vdisp%'
   OR cloze_text LIKE '%Fb =%' OR cloze_text LIKE '%Fg =%' OR cloze_text LIKE '%Fnet%'
   OR front_text LIKE '%ρfluid%' OR back_text LIKE '%ρfluid%';

-- Verification 2: expect 5 rows, the fixed cards.
SELECT id, LEFT(cloze_text, 100) AS fixed
FROM public.flashcards
WHERE cloze_text LIKE '%F(b) =%' OR cloze_text LIKE '%F(g) =%' OR cloze_text LIKE '%F(net) =%';
