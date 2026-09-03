-- ============================================================
-- Periodic trend cards: hide "increases" and "decreases" together
--
-- Spotted by Mikko while studying. Two cards share the defect:
--
--   Ionization energy {{c1::increases}} ... and {{c2::decreases}} ...
--   Electronegativity {{c1::increases}} ... and {{c2::decreases}} ...
--
-- A trend has exactly two directions, so displaying one hands over the other.
-- The blank tests nothing. Same shape as the projectile motion,
-- distal/proximal and forebrain cards.
--
-- THESE COST MORE THAN THE EARLIER ONES, AND THE NUMBERS ARE WORTH SEEING.
-- Merging c1 and c2 orphans the blank-2 scheduling rows:
--
--   Ionization energy   21.9d (founder), 5.0d (beta tester)
--   Electronegativity   37.8d (founder), 1.0d (beta tester)
--
-- Earlier merges in this directory cost 0.1 to 3 days. These are real intervals
-- on cards answered many times. The argument for going ahead anyway is that the
-- stability was earned on a blank answerable by elimination, so it measures
-- reading rather than recall, and a scheduler acting on it is acting on
-- evidence that was never collected. But it is a genuine trade rather than a
-- free repair, and if you would rather keep the intervals, skip this file: the
-- other card repairs do not depend on it.
--
-- A third card, atomic radius, has the identical defect and is NOT included
-- here; it turned up in the detector rather than by hand and belongs with the
-- other 22 that sweep found.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'Ionization energy {{c1::increases}} from left to right across a period (rising Zeff binds the valence electron more tightly) and {{c1::decreases}} from top to bottom in a group (valence electron is farther from the nucleus and more shielded).',
  cloze_count = 1
WHERE id = 'e948523f-2b46-496b-af2b-2ed14b2ddf1c';

UPDATE public.flashcards SET
  cloze_text = 'Electronegativity {{c1::increases}} from left to right across a period and {{c1::decreases}} from top to bottom in a group. The pattern runs in the same direction as ionization energy.',
  cloze_count = 1
WHERE id = '13281a26-cee4-432d-b74b-b7cb25a6a42c';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one group, two blanks, on both cards.
SELECT id, cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards
WHERE id IN ('e948523f-2b46-496b-af2b-2ed14b2ddf1c','13281a26-cee4-432d-b74b-b7cb25a6a42c');

-- No card anywhere should have a gap in its group numbers, which would leave a
-- blank the student can never be shown. Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
