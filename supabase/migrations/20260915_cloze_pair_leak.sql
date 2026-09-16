-- ============================================================
-- A contrasting pair split across two cloze indices gives itself away
--
-- TWO CARDS MIKKO HIT WHILE STUDYING, days apart:
--
--   The {{c1::pulmonary}} circuit ... while the {{c2::systemic}} circuit ...
--   {{c1::Dispositional}} ... ; {{c2::situational}} ...
--
-- Both are correctly AUTHORED: each term is clozed. The defect is that the two
-- halves of a defining pair sit on DIFFERENT indices, so studying c1 blanks one
-- and displays the other. Anyone who knows the pair exists names the answer
-- without recalling anything, and the card tests reading instead of memory.
--
-- THE FIX IS THE INDEX, NOT THE PROSE. Both terms move to c1 so they mask
-- together and the student has to produce the pair. That convention is already
-- used elsewhere in the bank, for instance "{{c1::pressure}} against greater
-- {{c1::resistance}}".
--
-- WHAT THIS COSTS. cloze_count drops 2 -> 1 on each card, so the (user_id,
-- flashcard_id, cloze_index) unit for c2 stops being scheduled. The review rows
-- that reference it stay: flashcard_reviews is append-only history and the
-- student really did review that blank, so the row remains true. Nothing is
-- deleted and no progress is reset.
--
-- UPDATE BY ID. No reseed, no deck rebuild.
--
-- NOT A COMPLETE SWEEP. These are the two cards Mikko found by studying. The
-- bank has not been audited for this class; see the note at the bottom.
-- ============================================================

-- ── The Cardiovascular System ───────────────────────────────────────────
UPDATE public.flashcards
SET
  cloze_text = 'The {{c1::pulmonary}} circuit carries blood between the heart and the lungs, while the {{c1::systemic}} circuit carries blood between the heart and the rest of the body''s tissues.',
  cloze_count = 1
WHERE id = '7c987ece-8264-4b83-a15c-f4e4b22cb933';

-- ── Social Thinking ─────────────────────────────────────────────────────
UPDATE public.flashcards
SET
  cloze_text = '{{c1::Dispositional}} (internal) attributions explain behavior by the person''s traits; {{c1::situational}} (external) attributions explain it by the surrounding context.',
  cloze_count = 1
WHERE id = 'e3890c3e-011c-4970-a634-ef73898a29c4';

-- ── Verification ────────────────────────────────────────────────────────
SELECT
  id,
  cloze_count,
  cloze_text
FROM public.flashcards
WHERE id IN (
  '7c987ece-8264-4b83-a15c-f4e4b22cb933',
  'e3890c3e-011c-4970-a634-ef73898a29c4'
);

-- ── Still outstanding ───────────────────────────────────────────────────
-- scripts/flashcard-leak-judge.mjs was written to catch exactly this class and
-- is documented as a ship-time check on a new deck. It has never been run over
-- the whole bank, which is why these two were live. Running it across all 4,116
-- cloze cards is the real fix; a regex cannot tell "wild-type / mutant" (a pair)
-- from "hypothalamus / homeostasis" (not one), and the judge can.
