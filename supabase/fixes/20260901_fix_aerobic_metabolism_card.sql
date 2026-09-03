-- ============================================================
-- Aerobic / anaerobic metabolism: hide both together
--
-- Spotted by Mikko while studying.
--
--   {{c1::Aerobic}} metabolism uses oxygen ... {{c2::anaerobic}} metabolism
--   either uses an alternative inorganic acceptor ...
--
-- The two terms are the same word with and without a negating prefix, in
-- separate groups, so asking for one prints the other.
--
-- Merging c2 into c1 needs no renumbering because c2 is the highest group.
-- cloze_count goes 2 to 1 and the blank-2 rows are orphaned:
--
--   beta tester  39.1d
--   founder       6.4d
--
-- THIS EXPOSED A THIRD SHAPE THE DETECTOR DID NOT COVER. It knew about
-- explicit opposing pairs (increases/decreases) and opposing prefixes
-- (pre/post), but not NEGATION, where one answer is simply the other with a
-- negating prefix attached: anaerobic is an + aerobic, nonpolar is non + polar,
-- irreversible is ir + reversible. That shape is now checked too, and unlike
-- the pair list it needs no vocabulary written down in advance.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = '{{c1::Aerobic}} metabolism uses oxygen as the terminal electron acceptor and yields a large ATP harvest via oxidative phosphorylation; {{c1::anaerobic}} metabolism either uses an alternative inorganic acceptor (sulfate, nitrate) or skips oxidative phosphorylation entirely in favor of fermentation.',
  cloze_count = 1
WHERE id = 'f890a850-0ed6-48da-a94f-22a6773fe44e';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'f890a850-0ed6-48da-a94f-22a6773fe44e';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
