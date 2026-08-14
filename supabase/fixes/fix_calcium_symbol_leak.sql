-- Fix: the synaptic-transmission card (Biology Ch4 Nervous System) blanks the word
-- "calcium" while the visible text names Ca2+ two words later, so the card answers
-- itself. NEW LEAK CLASS: element NAME blanked while its chemical SYMBOL stays
-- visible; the earlier acronym sweep only matched uppercase acronym tokens and
-- could not see a word-versus-symbol pair.
-- The visible mention becomes "the ion", which keeps the physiology intact (the
-- influx is still the point) without naming the answer. Both the plain-text and
-- superscript renderings of the ion are handled, since the live row and the seed
-- have drifted. SRS-safe: same card, groups c1/c2 preserved, cloze_count unchanged.
-- Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'channels open and Ca2+ flows into', 'channels open and the ion flows into')
WHERE cloze_text LIKE '%channels open and Ca2+ flows into%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'channels open and Ca²⁺ flows into', 'channels open and the ion flows into')
WHERE cloze_text LIKE '%channels open and Ca²⁺ flows into%';


-- ── Glycine card (Amino Acids deck): same class, unanimous 3/3 judge verdict ──
-- The c3 blank is just "single hydrogen atom" while the visible tail says the
-- alpha-carbon carries "two identical H substituents" — the symbol hands over the
-- answer. Dropping the symbol keeps the fact (two identical substituents is still
-- why glycine is achiral) without naming it.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'two identical H substituents', 'two identical substituents')
WHERE cloze_text LIKE '%two identical H substituents%';

-- Verification 1: expect 0 rows (no calcium symbol left beside the calcium blank).
SELECT id, cloze_text AS still_leaking
FROM public.flashcards
WHERE (cloze_text LIKE '%{{c1::calcium}}%' AND (cloze_text LIKE '%Ca2+%' OR cloze_text LIKE '%Ca²⁺%'))
   OR cloze_text LIKE '%two identical H substituents%';

-- Verification 2: expect 2 rows, the fixed cards.
SELECT id, cloze_text AS fixed
FROM public.flashcards
WHERE cloze_text LIKE '%channels open and the ion flows into%'
   OR cloze_text LIKE '%two identical substituents%';
