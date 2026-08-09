-- Fix: GenChem Ch12 Electrochemistry, the E°cell / E°cathode / E°anode subscript mashes.
--
-- Mikko flagged the EMF formula card. "E°cell" is E with a degree mark and a subscript "cell"
-- flattened into one run-together token; same for cathode and anode. Unicode has no subscript
-- c or l, so the plain-text convention is the parenthesised subscript, matching the formal
-- charge fix: E°(cell) = E°(cathode) − E°(anode).
--
-- 16 occurrences across the electrochemistry deck (12 cell, 2 cathode, 2 anode), all fixed in
-- one pass. Idempotent: the guard skips rows already carrying the parenthesised form.
--
-- SRS SAFE: text-only REPLACEs, cloze groups and counts unchanged.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = REPLACE(REPLACE(REPLACE(cloze_text,
       'E°cathode', 'E°(cathode)'),
       'E°anode',   'E°(anode)'),
       'E°cell',    'E°(cell)')
 WHERE (cloze_text LIKE '%E°cell%' OR cloze_text LIKE '%E°cathode%' OR cloze_text LIKE '%E°anode%')
   AND cloze_text NOT LIKE '%E°(cell)%';

COMMIT;

-- Verification: expect 0 mashed tokens remaining, and the parenthesised form present.
SELECT COUNT(*) AS still_mashed FROM public.flashcards
 WHERE cloze_text LIKE '%E°cell%' OR cloze_text LIKE '%E°cathode%' OR cloze_text LIKE '%E°anode%';
SELECT COUNT(*) AS fixed_cards FROM public.flashcards WHERE cloze_text LIKE '%E°(cell)%';
