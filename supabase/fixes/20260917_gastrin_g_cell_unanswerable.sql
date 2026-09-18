-- ============================================================
-- Two cards Mikko hit in Daily Review, both about what a blank covers
--
-- ONE: a card with two blanks and nothing left to answer from.
-- TWO: a blank that swallowed the arrows along with the words.
--
-- FOUND WHILE STUDYING. Mikko hit this in a Daily Review session:
--
--   Enteroendocrine {{c1::G}} cells of the gastric glands secrete the
--   hormone {{c1::gastrin}}.
--
-- Both terms sit on c1, so they hide together and the student sees:
--
--   Enteroendocrine [____] cells of the gastric glands secrete the hormone [____].
--
-- Nothing remains to retrieve from. "Enteroendocrine cells of the gastric glands
-- secrete a hormone" points at no particular cell and no particular hormone.
--
-- WHY THE OBVIOUS FIX IS WRONG. Splitting them onto c1 and c2 is refused by
-- lib/flashcards/leakSafety.ts with BREAKS_CO_MASKED_PAIR, and correctly: the G
-- cell is NAMED for gastrin, so whichever term is visible hands over the other.
-- That is presumably why someone merged them in the first place. The merge cured
-- the leak and created an unanswerable card.
--
-- SO ONE FACT HAS TO LEAVE THE CARD. On one card you may have G or gastrin,
-- never both, in any arrangement: both hidden is unanswerable, either one
-- visible gives away the other. The safety checker reports DROPS_TESTED_ANSWER
-- for every rewrite here, which is not a defect in the rewrite but the shape of
-- the problem.
--
-- GASTRIN IS THE ONE TO KEEP. It is the higher-yield term, and it is the one the
-- deck never asks the student to PRODUCE anywhere else: on b9b62053 ("Gastrin
-- stimulates gastric HCl secretion and increases stomach motility") the word is
-- visible stem text, not a blank. The letter G is recoverable from the hormone
-- name, which is exactly why it cannot be tested beside it.
--
-- The new cue is the TRIGGER rather than the effect. Cueing by effect would have
-- printed "acid secretion" and "motility", which are the two blanks on b9b62053.
--
-- cloze_count stays 1. UPDATE by id. No reseed.
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = 'Enteroendocrine cells of the gastric glands secrete {{c1::gastrin}} in response to peptides and stomach distension.',
  cloze_count = 1
WHERE id = '40be548a-9fef-4004-842f-6c9a98d8f44c';

-- ============================================================
-- TWO: the blank that ate the arrows
--
-- Seen in the same session:
--
--   Food's path through the GI tract: mouth -> {{c1::pharynx -> esophagus ->
--   stomach -> small intestine -> large intestine}} -> anus.
--
-- One blank covered five organs AND the four arrows between them, so the
-- student saw a single grey slab:
--
--   Food's path through the GI tract: mouth -> [________________] -> anus.
--
-- Nothing indicated how many stations belonged in it. The card asked for a
-- sequence and hid the shape of the sequence.
--
-- THE FIX PUTS THE BLANKS AROUND THE WORDS ONLY. The arrows stay visible as
-- scaffolding, and each organ gets its own blank:
--
--   mouth -> [____] -> [____] -> [____] -> [____] -> [____] -> anus.
--
-- ALL FIVE STAY ON c1, which is the point. They hide together, so this remains
-- ONE study card, cloze_count stays 1, and the (user_id, flashcard_id,
-- cloze_index) scheduling unit is untouched. No progress is reset and no new
-- item enters the queue. Splitting them onto c1..c5 would have turned one card
-- into five and handed each one its neighbours as free answers.
--
-- ONE HONEST NOTE ON THE DIFFICULTY. Showing the arrows now tells the student
-- there are five slots. That is a real change, and the right one: the card
-- tests the sequence, and how many stations it has is part of the sequence.
-- The old version made you guess how MUCH to produce as well as what.
--
-- checkRewriteSafety reports DROPS_TESTED_ANSWER here, because the old single
-- answer string "pharynx -> esophagus -> ... -> large intestine" no longer
-- exists as one blank. The fact is fully preserved, distributed across five
-- blanks that still mask together. Recorded rather than suppressed.
--
-- Verified before writing: valid cloze text, cloze_count 1 -> 1, one study
-- card, 21 words (under the 28-word bar), nothing visible from another group.
--
-- UPDATE by id. No reseed.
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = 'Food''s path through the GI tract: mouth → {{c1::pharynx}} → {{c1::esophagus}} → {{c1::stomach}} → {{c1::small intestine}} → {{c1::large intestine}} → anus.',
  cloze_count = 1
WHERE id = 'faf722be-a771-4c36-8f04-309769c3c901';

-- ── Verification, both cards ────────────────────────────────────────────
SELECT
  id,
  cloze_count,
  cloze_text
FROM public.flashcards
WHERE id IN (
  '40be548a-9fef-4004-842f-6c9a98d8f44c',
  'faf722be-a771-4c36-8f04-309769c3c901'
);

-- ── Still outstanding, for a decision ───────────────────────────────────
-- The G-cell name now appears nowhere in the deck. The other two gastric gland
-- cell types are each taught on their own card:
--   34a92ef0  {{c1::Parietal}} cells secrete hydrochloric acid ...
--   c6dd96a7  {{c1::Chief}} cells of the gastric glands secrete {{c2::pepsinogen}} ...
-- A companion card could restore it without naming gastrin, cued by completing
-- that set rather than by the hormone:
--   "Alongside parietal and chief cells, the third secretory cell type of the
--    gastric glands is the {{c1::G}} cell."
-- Not included here: adding a card is an INSERT, not an UPDATE by id, and it puts
-- a new card into the new-card queue. Mikko's call.
