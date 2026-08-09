-- Fix: CETP card blanks too much. The cloze currently covers the enzyme name AND
-- its action ("CETP (cholesteryl ester transfer protein) transfers cholesteryl
-- esters"); founder wants only the name blanked, so the card tests "which protein
-- does this transfer". SRS-safe: the c1 group keeps its identity, the blank just
-- narrows; cloze_count unchanged. Both name orders are handled (this card has
-- drifted between seed and live before). Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(
  cloze_text,
  '{{c1::CETP (cholesteryl ester transfer protein) transfers cholesteryl esters}}',
  '{{c1::CETP (cholesteryl ester transfer protein)}} transfers cholesteryl esters')
WHERE cloze_text LIKE '%{{c1::CETP (cholesteryl ester transfer protein) transfers cholesteryl esters}}%';

UPDATE public.flashcards
SET cloze_text = REPLACE(
  cloze_text,
  '{{c1::cholesteryl ester transfer protein (CETP) transfers cholesteryl esters}}',
  '{{c1::cholesteryl ester transfer protein (CETP)}} transfers cholesteryl esters')
WHERE cloze_text LIKE '%{{c1::cholesteryl ester transfer protein (CETP) transfers cholesteryl esters}}%';

-- Verification 1: expect 0 rows (no card still blanks the action inside c1).
SELECT id, cloze_text AS still_too_wide
FROM public.flashcards
WHERE cloze_text LIKE '%transfers cholesteryl esters}}%';

-- Verification 2: expect 1 row; the }} should sit right after the closing parenthesis.
SELECT id, cloze_text AS fixed_card
FROM public.flashcards
WHERE cloze_text LIKE '%CETP%' AND cloze_text LIKE '%converting IDL%';
