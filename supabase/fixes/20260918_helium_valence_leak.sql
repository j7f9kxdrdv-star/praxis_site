-- ============================================================
-- The helium card answered itself twice over
--
-- FOUND WHILE STUDYING, 2026-09-18. As it stood:
--
--   {{c1::Helium}} is grouped with the noble gases because of its chemical
--   behavior, but it has only {{c2::two}} valence electrons rather than eight.
--   A complete 1s² shell is enough to make it stable, since the n=1 shell holds
--   at most 2 electrons.
--
-- BOTH study cards gave their answer away, not just the one Mikko happened to
-- see:
--
--   c2 hides "two", and the visible text says 1s² and "holds at most 2
--   electrons". The answer is printed twice in the same sentence.
--
--   c1 hides "Helium", and "a complete 1s² shell" with "the n=1 shell holds at
--   most 2 electrons" is a definition of helium. A student who had never heard
--   of it could still fill the blank.
--
-- THE STRUCTURAL CHECKER FOUND NOTHING HERE, correctly and uselessly. Its
-- verbatim test compares strings, and "2" is not "two". This is the semantic
-- class that needs a reader, which is the argument for finishing the leak
-- audit's model pass rather than trusting the free half of it.
--
-- THE FIX CUTS THE LEAKING CLAUSE. The final sentence was the giveaway in both
-- directions, and it was also saying the same thing twice: "a complete 1s²
-- shell" and "the n=1 shell holds at most 2 electrons" are one fact stated
-- two ways. Removing it leaves both blanks answerable from knowledge rather
-- than from reading:
--
--   c1: "____ is grouped with the noble gases for its chemistry, but its
--        valence shell is complete at two electrons rather than eight."
--   c2: "Helium is grouped with the noble gases for its chemistry, but its
--        valence shell is complete at ____ electrons rather than eight."
--
-- Neither prompt now contains a digit.
--
-- WHAT THIS LOSES. The n=1 capacity fact leaves the deck; a grep of
-- Periodic Trends & Chemical Families shows it is taught nowhere else. It is
-- really an electron-configuration fact rather than a periodic-trends one, so
-- if it is wanted it belongs on its own card in a deck about shells, where it
-- would not be sitting next to the answer it gives away.
--
-- cloze_count stays 2, so both scheduling units survive and no progress is
-- reset. Verified before writing: valid cloze text, REWORD, safety clean,
-- 22 words, no digits left in either prompt.
--
-- UPDATE by id. No reseed.
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = '{{c1::Helium}} is grouped with the noble gases for its chemistry, but its valence shell is complete at {{c2::two}} electrons rather than eight.',
  cloze_count = 2
WHERE id = '41e199ef-5bd1-4082-8deb-a90b68650d4b';

-- ── Verification ────────────────────────────────────────────────────────
SELECT id, cloze_count, cloze_text
FROM public.flashcards
WHERE id = '41e199ef-5bd1-4082-8deb-a90b68650d4b';
