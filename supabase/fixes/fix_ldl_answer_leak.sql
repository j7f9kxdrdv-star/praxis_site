-- Fix: the LDL card (Biochem Ch11 deck) blanks "LDL (low-density lipoprotein)"
-- while the visible second clause names LDL outright, so the card answers
-- itself. The later mention becomes "levels". SRS-safe: same card, groups
-- c1/c2 preserved, cloze_count unchanged. Idempotent.

UPDATE public.flashcards
SET cloze_text = REPLACE(
  cloze_text,
  'high circulating LDL is the classic atherosclerosis risk factor',
  'high circulating levels are the classic atherosclerosis risk factor')
WHERE cloze_text LIKE '%high circulating LDL is the classic%';

-- Verification: expect 1 row; "LDL" must appear only inside the c1 blank.
SELECT id, cloze_text
FROM public.flashcards
WHERE cloze_text LIKE '%atherosclerosis risk factor%';
