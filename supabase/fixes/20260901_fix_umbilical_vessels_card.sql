-- ============================================================
-- Umbilical vessels: hide vein and arteries together
--
-- Spotted by Mikko while studying.
--
--   the umbilical {{c1::vein}} carries oxygenated blood FROM the placenta,
--   while the umbilical {{c2::arteries}} carry deoxygenated blood BACK
--
-- Two vessels, one shown while the other is asked for. The whole point of this
-- card is that the umbilical pattern is inverted relative to the adult one, so
-- being handed half the pair defeats it.
--
-- Merging c2 into c1 needs no renumbering, c2 being the highest group.
-- cloze_count goes 2 to 1. Blank 2 is orphaned at 6.0d and 2.1d.
--
-- THE SURVIVING BLANK KEEPS 30.4 DAYS, which it earned naming "vein" with
-- "arteries" on screen. It now has to produce both. This is the same shape as
-- the denaturation card and it is why the interval reset in
-- 20260901_fix_denaturation_card.sql is worth applying across every merge from
-- tonight: repairing a card and then not seeing it again for a month is most
-- of the way to not repairing it.
--
-- A SECOND CARD HAS THE SAME DEFECT and is NOT included here:
--
--   9ffc1170  "the cord contains {{c1::two}} arteries ... and {{c2::one}} vein"
--
-- Weaker, because deriving "two" from "one" needs you to already know the cord
-- has three vessels, which is arguably the fact being taught. It also carries
-- 46.9d and 39.1d, the most expensive merge yet seen. That one is a judgement
-- call rather than a clear defect, so it is named rather than changed.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'Counter to the adult pattern, the umbilical {{c1::vein}} carries oxygenated blood from the placenta to the fetus, while the umbilical {{c1::arteries}} carry deoxygenated blood back to the placenta.',
  cloze_count = 1
WHERE id = '585deaf9-dbcd-46ba-8e91-5f8fc81970e2';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '585deaf9-dbcd-46ba-8e91-5f8fc81970e2';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
