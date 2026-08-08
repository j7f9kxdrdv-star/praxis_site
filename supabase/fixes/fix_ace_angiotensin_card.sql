-- Fix: Bio Ch5 Endocrine, the ACE card. Mikko: "angio I and II should be blanked out."
--
-- BEFORE: '{{c1::ACE (angiotensin-converting enzyme)}} converts angiotensin I into
--          {{c2::angiotensin II}}, ...'
-- Testing blank 2 showed "converts angiotensin I into ___", which hands over the answer
-- ("I into" -> II). And "angiotensin I" itself was never tested at all.
--
-- AFTER: both peptides share group c2, so they are masked TOGETHER and the student must
-- produce the whole conversion (substrate AND product):
--   item c1: "___ converts angiotensin I into angiotensin II"    (recall the enzyme)
--   item c2: "ACE (...) converts ___ into ___"                    (recall the conversion)
-- Same shared-group pattern as the ACC and respiratory-group cards.
--
-- SRS SAFE: groups c1 and c2 both survive, cloze_count stays 2, review history intact.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = 'In the lungs, {{c1::ACE (angiotensin-converting enzyme)}} converts {{c2::angiotensin I}} into {{c2::angiotensin II}}, the active signaling peptide.'
 WHERE cloze_text LIKE '%converts angiotensin I into {{c2::angiotensin II}}%';

COMMIT;

-- Verification: expect 1 row, cloze_count 2.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%converts {{c2::angiotensin I}} into {{c2::angiotensin II}}%';
