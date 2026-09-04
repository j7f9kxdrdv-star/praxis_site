-- ============================================================
-- The anhydride card asked for the one thing it gave away
--
-- Stored as a single blank on the TERM:
--
--   "If an [asymmetric anhydride] is formed from two different carboxylic
--    acids, both acids are named in alphabetical order before the word
--    'anhydride.' For example, acetic and propionic acids give ethanoic
--    propanoic anhydride."
--
-- Two separate giveaways. "Formed from two DIFFERENT carboxylic acids" is a
-- plain-language definition of asymmetric, and the word "anhydride" is printed
-- twice in the visible text, so half the answer was never being recalled.
--
-- The deeper problem is what the card was testing. Its actual content is the
-- NAMING RULE, and that rule sat entirely in plain text where it was never
-- asked. The blank moves off the term and onto the rule and its worked
-- example, both in one group so the example cannot demonstrate the rule it is
-- meant to test.
--
-- No wording changed, only which words are hidden. Verified before writing:
-- one group, contiguous, no malformed blanks, card wording identical.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'If an asymmetric anhydride is formed from two different carboxylic acids, both acids are named in {{c1::alphabetical order}} before the word "anhydride." For example, acetic and propionic acids give {{c1::ethanoic propanoic}} anhydride.'
WHERE id = 'dc55baad-92c5-48b6-954e-871823f14a69';

-- Graded on the leaking version, so the history does not carry over.
UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = 'dc55baad-92c5-48b6-954e-871823f14a69';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 1 group and no blank containing "asymmetric".
SELECT cloze_count, cloze_text NOT LIKE '%::asymmetric%' AS term_no_longer_blanked
FROM public.flashcards WHERE id = 'dc55baad-92c5-48b6-954e-871823f14a69';
