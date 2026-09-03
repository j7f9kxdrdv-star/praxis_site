-- ============================================================
-- Electrophoresis: hide anode and cathode together
--
-- Spotted by Mikko while studying.
--
--   negatively charged molecules migrate toward the {{c2::anode}}, and
--   positively charged molecules migrate toward the {{c3::cathode}}.
--
-- Two electrodes, one shown while the other is asked for. Whichever is hidden
-- follows from the one on screen, so neither blank tests the thing that is
-- actually hard here: remembering which charge runs to which electrode.
--
-- Merging c3 into c2 needs no renumbering because c3 is the highest group.
-- cloze_count goes 3 to 2 and blank 3 is orphaned, carrying 21.5d. With both
-- hidden the student has to place BOTH, which is the whole content of the card.
--
-- anode/cathode has been added to the detector's opposition list. It is a pair
-- neither the prefix rule nor the negation rule can reach, because the two
-- words share no root, so it has to be named. That is the standing weakness of
-- that list: it only knows the vocabulary someone has written into it.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = '{{c1::Electrophoresis}} drives charged molecules through a gel using an electric field; negatively charged molecules migrate toward the {{c2::anode}}, and positively charged molecules migrate toward the {{c2::cathode}}.',
  cloze_count = 2
WHERE id = '8c32f9ba-59de-4110-9e1b-89bd48da1030';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '8c32f9ba-59de-4110-9e1b-89bd48da1030';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
