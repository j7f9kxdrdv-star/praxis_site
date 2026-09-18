-- ============================================================
-- The E/Z card printed the letters it was asking for
--
-- FOUND WHILE STUDYING, 2026-09-18. The card had three groups:
--
--   c1  "E/Z"
--   c2  "same side" and "opposite sides"   (correctly co-masked)
--   c3  "Z" and "E"                         (correctly co-masked)
--
-- Studying c1 hid "E/Z" while c3 PRINTED its letters two lines below, as
-- "-> Z (zusammen)" and "-> E (entgegen)". The answer was spelled out on the
-- same screen, one character at a time.
--
-- Note that whoever wrote this card got two pairings right: same side/opposite
-- sides share c2, and Z/E share c3. The mistake was treating the NAME of the
-- notation as independent of the letters it is made of.
--
-- THE STRUCTURAL CHECKER MISSED THIS, and it is worth recording why. Its
-- verbatim test asks whether a hidden answer appears in the visible text as a
-- whole word. The hidden answer here is the string "E/Z"; what is visible is
-- "Z" and "E" separately. No string matches, so nothing fires. The check is
-- sound and the composition is what defeats it: an answer assembled from other
-- answers on the same card. Third distinct leak class the free half of the
-- audit cannot see, after synonyms (broad/wide) and numerals (2 vs two).
--
-- THE FIX. The notation name joins its own letters on c1, so all three mask
-- together. cloze_count 3 -> 2, and c2 keeps the same side / opposite sides
-- pairing untouched.
--
-- WHAT THE MERGED CARD ASKS. "configuration is given by ____ notation ... same
-- side -> ____ (zusammen); opposite sides -> ____ (entgegen)". The German
-- glosses stay visible and do hint at the letters, which is deliberate: they
-- are the mnemonic the card exists to teach, not an accident. A student still
-- has to know which arrangement is which.
--
-- NOT FIXED, NOTED. At 49 words this card is nearly double the house bar of
-- about 28. Tightening it is a rewrite rather than a regroup, and a rewrite of
-- a card this dense deserves its own pass rather than being folded into a leak
-- fix.
--
-- Verified: MERGE_GROUPS, safety clean, and the card now co-masks
-- "e/z || z", "e || e/z" and "e || z" alongside the existing side pairing.
--
-- UPDATE by id. No reseed.
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = 'For alkenes with poly-substituted double bonds, configuration is given by {{c1::E/Z}} notation rather than cis/trans. Apply CIP rules at each double-bonded carbon to identify the higher-priority substituent on each side; if both higher-priority groups are on the {{c2::same side}} → {{c1::Z}} (zusammen); if on {{c2::opposite sides}} → {{c1::E}} (entgegen).',
  cloze_count = 2
WHERE id = 'b8f1fb73-2b10-40f0-b90e-6182d49732be';

-- ── Verification ────────────────────────────────────────────────────────
SELECT id, cloze_count, cloze_text
FROM public.flashcards
WHERE id = 'b8f1fb73-2b10-40f0-b90e-6182d49732be';
