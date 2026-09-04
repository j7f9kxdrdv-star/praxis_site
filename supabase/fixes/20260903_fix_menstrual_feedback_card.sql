-- ============================================================
-- The menstrual-cycle card handed over its own answer
--
-- Mikko caught this one studying. The blank is "positive feedback", and the
-- stem printed its opposite twice in plain text:
--
--   "negative feedback dominates ... briefly flipping to [____]
--    (the LH surge), then reverting to negative feedback ..."
--
-- Nothing had to be recalled. "Flipping to" with a visible "negative" on both
-- sides leaves exactly one option, and the LH-surge parenthetical confirms it
-- a second time.
--
-- This is a DIFFERENT defect from the split contrasts fixed earlier today.
-- Those hid one half of a pair in a sibling BLANK. Here the giveaway was never
-- in a blank at all, it was ordinary stem text, so the sibling-group detector
-- could not see it.
--
-- The fix puts all three feedback states in the same group, so they blank
-- together and the card tests the cycle's logic rather than reciting it.
-- Verified before writing: one group, three blanks, card wording unchanged.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'The cycle''s hormone logic in one line: {{c1::negative feedback}} dominates until estrogen peaks late in the follicular phase, briefly flipping to {{c1::positive feedback}} (the LH surge → ovulation), then reverting to {{c1::negative feedback}} during the luteal phase, and finally being removed entirely when the corpus luteum degenerates, letting the next cycle start.',
    cloze_count = 1
WHERE id = 'beb2dabc-1436-4bce-9319-333f2823ef0e';

-- The card's own history was earned on the leaking version, so it does not
-- carry over. Reset to due now, kept as a review rather than a new card so it
-- returns today instead of queueing behind the daily new-card limit.
UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = 'beb2dabc-1436-4bce-9319-333f2823ef0e';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect one row, cloze_count = 1, and three {{c1:: blanks.
SELECT cloze_count,
       (length(cloze_text) - length(replace(cloze_text, '{{c1::', ''))) / 6 AS c1_blanks
FROM public.flashcards WHERE id = 'beb2dabc-1436-4bce-9319-333f2823ef0e';
