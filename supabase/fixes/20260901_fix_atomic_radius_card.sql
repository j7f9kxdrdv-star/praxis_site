-- ============================================================
-- Atomic radius: hide the two trend directions together
--
-- {{c1::decreases}} across a period and {{c2::increases}} down a group, in
-- separate groups, so one is printed while the other is asked for. A trend has
-- two directions and this card shows you one of them.
--
-- Third card of this exact shape today, after ionization energy and
-- electronegativity. The detector had already flagged it; Mikko reached it
-- first by studying.
--
-- Merging c2 into c1 needs no renumbering. cloze_count 2 to 1, blank 2
-- orphaned at 5.0d and 1.1d, which is cheap by the standards of tonight.
--
-- NOTE: this card already carries Z_{eff} markup from the subscript migration.
-- It will render as literal braces until the web deploy ships the renderer.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'Atomic radius {{c1::decreases}} from left to right across a period (rising Z_{eff} pulls the same outer shell tighter) and {{c1::increases}} from top to bottom in a group (each new period adds an electron shell at a larger principal quantum number).',
  cloze_count = 1
WHERE id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '8f7d617e-ae05-4a2c-872d-811eb745bbe5';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
