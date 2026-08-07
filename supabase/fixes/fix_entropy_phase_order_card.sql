-- Fix: GenChem Ch7 Thermochemistry, entropy-by-phase card.
--
-- Mikko flagged this card while studying: it does not make sense on the front.
--
-- BEFORE (what the student sees with the blank in place):
--   "For a given substance, the entropy of its phases follows ______, reflecting greater
--    freedom of particle motion."
--
--   Two defects:
--     1. "follows ______" gives the blank no shape. Nothing signals that an ordering of the
--        three phases belongs there rather than a law, a trend or a formula.
--     2. "reflecting greater freedom of particle motion" is a dangling comparative. The thing
--        it compares against is the very content that has been blanked out, so with the blank
--        in place the clause compares nothing.
--   The sentence is therefore only interpretable AFTER the answer is revealed, which defeats
--   the point of the card.
--
-- AFTER:
--   "Ranked from highest to lowest entropy, the phases of a substance are ______."
--   The blank is anchored (an ordering is explicitly requested), the sentence is complete on
--   its own, and the answer is not given away. The mechanism (entropy rises with accessible
--   microstates) already has its own card at position 36 in this deck, so this card keeps to
--   one fact.
--
-- SRS SAFE: this is an UPDATE matched on the existing text. The flashcard id, deck and
-- cloze_count (1) are unchanged, so every review record and scheduling state for this card
-- survives untouched. No card is deleted and no id is minted.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = 'Ranked from highest to lowest entropy, the phases of a substance are {{c1::gas > liquid > solid}}.'
 WHERE cloze_text LIKE '%entropy of its phases follows%';

COMMIT;

-- Verification: expect exactly 1 row, cloze_count 1, and the new text.
SELECT id, deck_id, position, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%Ranked from highest to lowest entropy%';
