-- ============================================================
-- kcat card: leave something to recall FROM
--
-- Spotted by Mikko while studying: "too many blanks, hard to know what it is
-- asking me to answer."
--
-- The card was:
--
--   {{c1::kcat}} can be calculated from {{c1::Vmax}} using
--   {{c1::kcat = Vmax / [E]total}}, where {{c1::[E]total}} is the total
--   enzyme concentration.
--
-- All four blanks share group c1, so they disappear together and the student
-- sees only: "___ can be calculated from ___ using ___, where ___ is the total
-- enzyme concentration." Roughly 90% of the card is hidden, against a median of
-- 16% across the bank. There is no stem left to cue anything.
--
-- This is the OPPOSITE failure from the answer leaks fixed elsewhere in this
-- directory. There the card gave too much away; here it gives nothing to hold
-- on to, and the student cannot even tell what is being asked.
--
-- The fix keeps the formula as the single thing being tested and restores the
-- surrounding sentence as context. cloze_count stays 1.
--
-- NOTE ON THE BLANK-COUNT GATE. Every other repair in this directory is
-- required not to REDUCE the number of blanks, because there the usual bad
-- "fix" was to make a card easier by testing less. Here reducing blanks is
-- precisely the repair. The gate is a heuristic about intent, not a law, and
-- this card is the case that shows the difference.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'kcat can be calculated from Vmax using {{c1::kcat = Vmax / [E]total}}, where [E]total is the total enzyme concentration.'
WHERE id = 'e929b270-cbaa-44ce-98fd-46dd6dcbbcd9';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one group, one blank, and a real stem around it.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks,
  cloze_text
FROM public.flashcards WHERE id = 'e929b270-cbaa-44ce-98fd-46dd6dcbbcd9';

-- The wider population this card came from: cards where more than half the
-- text is hidden. Reviewing these needs a human deciding what each card is
-- FOR, which is why they are listed rather than rewritten.
SELECT COUNT(*) AS cards_more_than_half_blanked FROM (
  SELECT id,
    (SELECT COALESCE(SUM(LENGTH(m[1])),0) FROM regexp_matches(cloze_text,'\{\{c\d+::([^}]+)\}\}','g') AS m) AS blanked,
    LENGTH(regexp_replace(cloze_text,'\{\{c\d+::[^}]+\}\}','','g')) AS stem
  FROM public.flashcards WHERE cloze_text IS NOT NULL
) t WHERE blanked + stem > 40 AND blanked::numeric / (blanked + stem) > 0.5;
