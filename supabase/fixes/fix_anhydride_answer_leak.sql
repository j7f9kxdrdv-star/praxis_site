-- Fix: OrgChem Ch12 carboxylic acid derivatives, the anhydride naming card.
--
-- Mikko flagged it while studying: "this card gives the answer away."
--
-- BEFORE:
--   '{{c1::Anhydrides}} are the condensation dimers of two carboxylic acids (loss of water);
--    {{c2::symmetric anhydrides}} swap "acid" for "anhydride" in the parent name, while
--    {{c3::asymmetric anhydrides}} list both parent acids alphabetically before "anhydride."'
--
--   The card has three blanks, and the app reveals the OTHER blanks while testing one. So when
--   blank 1 is under test the student sees "symmetric anhydrides", "asymmetric anhydrides" and the
--   word "anhydride" twice in quotation marks: the answer appears on screen four times before it is
--   given. A plain answer-leak check does not catch this, because the leak comes from the sibling
--   blanks rather than from the fixed text.
--
--   It also failed the one-fact bar at about 40 words, packing the class definition and two separate
--   naming conventions into a single card.
--
-- AFTER:
--   'Two carboxylic acids condense with loss of {{c1::water}} to form an {{c2::anhydride}}; if the
--    two halves differ, the parent names are listed {{c3::alphabetically}}.'
--
--   24 words. Verified leak-free under the sibling-reveal rule: with any one blank under test,
--   neither that answer nor any word of it appears anywhere else on screen. The symmetric naming
--   convention ("acetic acid" becomes "acetic anhydride") is dropped as the lowest-yield of the
--   three facts, since it follows once the class name is known.
--
-- SRS SAFE: cloze_count stays 3, so all three sub-cards keep their review history and scheduling.
-- No flashcard id is minted or deleted.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = 'Two carboxylic acids condense with loss of {{c1::water}} to form an {{c2::anhydride}}; if the two halves differ, the parent names are listed {{c3::alphabetically}}.'
 WHERE cloze_text LIKE '%condensation dimers of two carboxylic acids%';

COMMIT;

-- Verification: expect 1 row with cloze_count 3.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE 'Two carboxylic acids condense with loss of%';
