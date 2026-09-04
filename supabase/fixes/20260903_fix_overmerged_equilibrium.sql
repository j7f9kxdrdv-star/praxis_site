-- ============================================================
-- Undoing an over-merge I caused
--
-- The split-contrast repair folds both halves of a pair into one group so
-- neither can be read off the other. On this card the pair "reactant/product"
-- occurs FOUR times, and the tool merged every occurrence, leaving six blanks
-- in a single group:
--
--   "Adding a [____] or removing a [____] shifts an equilibrium toward the
--    [____], whereas removing a [____] or adding a [____] shifts it toward
--    the [____]."
--
-- Nothing is left to read. Mikko has raised this exact complaint before, that
-- a card with too many blanks gives no clue what it is asking, and I
-- reintroduced it with an automated merge.
--
-- The card is restored by separating question from answer. The MANIPULATIONS
-- are the question and stay visible; only the two OUTCOMES are hidden, and
-- they share a group so neither gives away the other:
--
--   "Adding a reactant or removing a product shifts an equilibrium toward the
--    [products (forward, right)], whereas removing a reactant or adding a
--    product shifts it toward the [reactants (reverse, left)]."
--
-- The merge tool now refuses any merge that would leave more than three spans
-- in one group, and reports it for hand design instead. Merging is right for a
-- two-way contrast and wrong for a phrase that recurs throughout a sentence.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'Adding a reactant or removing a product shifts an equilibrium toward the {{c1::products (forward, right)}}, whereas removing a reactant or adding a product shifts it toward the {{c1::reactants (reverse, left)}}.',
    cloze_count = 1
WHERE id = 'a40381d0-252e-46e4-90b4-6fcf50f273fd';

UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = 'a40381d0-252e-46e4-90b4-6fcf50f273fd';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 1 group and exactly 2 blanks.
SELECT cloze_count,
       (length(cloze_text) - length(replace(cloze_text, '{{c1::', ''))) / 6 AS blanks
FROM public.flashcards WHERE id = 'a40381d0-252e-46e4-90b4-6fcf50f273fd';
