-- ============================================================
-- Watt card: hide the symbolic restatement with the words it restates
--
-- Spotted by Mikko while studying.
--
--   defined as {{c2::one joule per second}} (1 W = 1 J/s)
--
-- The parenthetical spells the answer in symbols immediately after the blank,
-- so the card is read rather than recalled. Pulling it inside the same group
-- hides both together; the fact is still taught, it just stops being given.
--
-- Group set {1,2} is unchanged and the blank count is unchanged, so no
-- scheduling row moves.
--
-- A SECOND, WEAKER LEAK IS LEFT ALONE ON PURPOSE. Testing c1 ("watt (W)")
-- leaves "kilowatt" visible further down the card, which contains the answer,
-- and the symbol W appears in "1 kW = 1000 W" and "1 hp ~= 746 W". Closing that
-- properly means giving up the numeric equivalences, which are worth keeping,
-- or rewording the multiples in a way that reads worse. That is a content
-- judgement rather than a mechanical fix, so it is flagged rather than made.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'The SI unit of power is the {{c1::watt (W)}}, defined as {{c2::one joule per second (1 W = 1 J/s)}}. Common multiples include the kilowatt (1 kW = 1000 W) for engines and appliances, and the horsepower (1 hp ≈ 746 W) in older mechanical contexts.'
WHERE id = 'f6f7948b-51c4-4fa5-9a6c-ba62305e46fa';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 2, two groups, two blanks, unchanged.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'f6f7948b-51c4-4fa5-9a6c-ba62305e46fa';
