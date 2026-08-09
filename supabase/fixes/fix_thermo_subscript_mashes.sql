-- Fix: the run-together thermodynamics subscripts, found by widening the mash hunt after Mikko
-- flagged Qrev (following λ_max, E°cell, Nnonbonding — same disease, different spellings).
--
-- Seven tokens across two decks: Qrev x2 (Physics Ch3), Suniv / S°rxn / H°rxn / Hrxn / G°rxn
-- (GenChem Ch7 Thermochemistry). Every needed letter exists as a Unicode subscript, so these get
-- the true subscript form matching the bank's convention (n₁, Rₕ, λₘₐₓ):
--   Qrev -> Qᵣₑᵥ · Suniv -> Sᵤₙᵢᵥ · rxn -> ᵣₓₙ
-- Short conventional names (Keq, Vmax, Req, Ceq) are left alone as before.
--
-- SRS SAFE: text-only REPLACEs; cloze groups and counts unchanged. Idempotent.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = REPLACE(REPLACE(REPLACE(REPLACE(cloze_text,
       'Qrev',  'Qᵣₑᵥ'),
       'Suniv', 'Sᵤₙᵢᵥ'),
       '°rxn',  '°ᵣₓₙ'),
       'Hrxn',  'Hᵣₓₙ')
 WHERE cloze_text LIKE '%Qrev%' OR cloze_text LIKE '%Suniv%'
    OR cloze_text LIKE '%°rxn%' OR cloze_text LIKE '%Hrxn%';

COMMIT;

-- Verification: expect 0 remaining mashes.
SELECT COUNT(*) AS still_mashed FROM public.flashcards
 WHERE cloze_text LIKE '%Qrev%' OR cloze_text LIKE '%Suniv%'
    OR cloze_text LIKE '%°rxn%' OR cloze_text LIKE '%Hrxn%';
