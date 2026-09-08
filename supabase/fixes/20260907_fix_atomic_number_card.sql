-- ============================================================
-- The atomic number card printed its own answer
--
-- Stored with the particles split across groups:
--
--   "Z counts {c1 protons}, the mass number A counts {c1 protons} +
--    {c2 neutrons}, so the number of the latter is {c3 A - Z}."
--
-- Asking for c2 revealed both instances of "protons", and the sentence
-- structure does the rest: "A counts protons + ___" has one sensible
-- completion for anyone who knows what a nucleus contains. The visible
-- "A - Z" confirms it a second time.
--
-- The two particle names now share a group, so the card asks what each number
-- actually counts. The A - Z relationship becomes its own blank, which is a
-- separate and worthwhile thing to recall:
--
--   asking group 1: "Z counts ___, A counts ___ + ___"  -> name the particles
--   asking group 2: "the number of the latter is ___"   -> derive it
--
-- Verified before writing: wording unchanged, two contiguous groups, at most
-- three spans in a group, no malformed or jammed blanks.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'The atomic number Z counts {{c1::protons}}, the mass number A counts {{c1::protons}} + {{c1::neutrons}}, so the number of the latter is {{c2::A − Z}}.',
    cloze_count = 2
WHERE id = '91f9fb12-d969-46ad-b90f-b666deb94b28';

-- Three groups become two, so progress on the old c3 points at a blank that no
-- longer exists.
DELETE FROM public.flashcard_user_state
WHERE flashcard_id = '91f9fb12-d969-46ad-b90f-b666deb94b28' AND cloze_index > 2;

UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = '91f9fb12-d969-46ad-b90f-b666deb94b28';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count FROM public.flashcards WHERE id = '91f9fb12-d969-46ad-b90f-b666deb94b28';
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
