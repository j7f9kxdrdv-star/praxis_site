-- ============================================================
-- Brain imaging techniques: hide all four together
--
-- Spotted by Mikko while studying.
--
--   Four key brain imaging techniques: {{c1::CT (CAT scan)}} ... {{c2::PET}}
--   ... {{c3::MRI}} ... {{c4::fMRI}} ...
--
-- The stem announces there are exactly four and each sits in its own group, so
-- asking for any one displays the other three and the answer is whichever is
-- missing. Being asked for fMRI while CT, PET and MRI are printed on screen is
-- not a memory test.
--
-- All four move into c1, so the student has to produce the whole set and match
-- each technique to its physical basis, which is the fact the card is for.
-- cloze_count goes 4 to 1 and blanks 2, 3 and 4 are orphaned:
--
--   founder  4.8d, 2.1d, 26.8d
--
-- THIS IS THE ENUMERATED-SET SHAPE, AND THE DETECTOR STILL CANNOT FIND IT.
-- An earlier rule flagged cards whose stem said "two", "three" or "four" while
-- each item sat alone. It returned 150+ cards and was almost all noise, because
-- those words appear constantly in ordinary content ("the two cerebral
-- hemispheres", "two enantiomers"), so it was dropped. The rules that survived
-- key on the ANSWERS being related to each other: explicit opposing pairs,
-- opposing prefixes, negation. Four unrelated acronyms share nothing a rule can
-- key on, so this shape needs either a model reading the card or a person
-- studying it. Tonight it was a person.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'Four key brain imaging techniques: {{c1::CT (CAT scan)}} uses multiple x-rays to build cross-sectional images of tissue; {{c1::PET}} uses a radioactive sugar to image metabolic uptake; {{c1::MRI}} uses magnetic fields and hydrogen-atom signals to image structure; {{c1::fMRI}} extends it by tracking the BOLD blood-oxygen signal to reveal regional activity in real time.',
  cloze_count = 1
WHERE id = '786699b1-095d-48a5-a341-19c3c95a56c9';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one group, four blanks inside it.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '786699b1-095d-48a5-a341-19c3c95a56c9';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
