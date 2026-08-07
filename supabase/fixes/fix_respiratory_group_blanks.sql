-- Fix: Bio Ch6 Respiratory, the medullary respiratory centre card.
--
-- Mikko, studying: "I think both respiratory groups should be blanked out in this."
--
-- BEFORE the card had three separate blanks:
--   {{c1::medulla oblongata}} ... {{c2::ventral respiratory group (VRG)}} ...
--   {{c3::dorsal respiratory group (DRG)}}
--
-- Three blanks means three separate review items, and the renderer reveals the non-active blanks
-- (standard cloze behaviour, lib/flashcards/cloze.ts line 142). So the item testing the VENTRAL
-- group displayed "dorsal respiratory group (DRG)" in full. The phrase "respiratory group" was
-- therefore already on screen and the only thing left to supply was "ventral" versus "dorsal".
-- Same defect class as the anhydride card: the leak comes from a SIBLING blank, not from the
-- fixed text.
--
-- AFTER: both groups share cloze index 2, so they are masked TOGETHER and the student must produce
-- the full pairing of name to function. This is explicitly supported: cloze.ts line 8 documents
-- "Multiple groups with the same N collapse together", and renderClozeSegments masks every match
-- whose groupIndex equals the active group. The pattern is already used elsewhere in the bank
-- (the ACC card blanks insulin and citrate under a shared c1).
--
-- cloze_count goes 3 -> 2, which is what actually drives how many review items the card produces
-- (app/dashboard/flashcards/session/page.tsx line 187 reads cloze_count, not the progress rows).
--
-- SRS: blanks 1 and 2 keep their full review history. The progress row for the retired index 3
-- is left in place rather than deleted; it is never enumerated, so it cannot resurface as a
-- phantom due card, and it preserves the history if the card is ever split again.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text,
         '{{c3::dorsal respiratory group (DRG)}}',
         '{{c2::dorsal respiratory group (DRG)}}'),
       cloze_count = 2
 WHERE cloze_text LIKE '%{{c3::dorsal respiratory group (DRG)}}%';

COMMIT;

-- Verification: expect 1 row, cloze_count 2, and both groups now under c2.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%ventral respiratory group%';
