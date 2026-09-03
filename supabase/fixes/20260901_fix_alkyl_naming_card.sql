-- ============================================================
-- Alkyl substituent naming: two separate leaks on one card
--
-- Spotted by Mikko while studying. The card was:
--
--   ... named like the corresponding alkane, but its {{c1::-ane}} ending is
--   replaced by {{c2::-yl}} (e.g., methane -> methyl, ethane -> ethyl,
--   propane -> propyl).
--
-- LEAK ONE, the examples. The parenthetical demonstrates the exact
-- substitution three times over. Whichever ending is hidden, methane -> methyl
-- spells it out, so neither blank tests recall. Removed.
--
-- LEAK TWO, the split. The two endings sit in separate groups, so asking for
-- one prints the other. Merged into c1, which needs no renumbering because c2
-- is the highest group. cloze_count goes 2 to 1; blank 2 is orphaned at 3.0d.
--
-- A RESIDUAL HINT IS LEFT ON PURPOSE. The visible word "alkane" contains the
-- letters of the hidden "-ane". Removing it would mean not saying what the
-- substituent is named after, which is the fact the card teaches. A student who
-- reasons from "alkane" to "-ane" is doing chemistry, not reading an answer off
-- the screen, and that is the line these repairs are drawn on: guessable by
-- someone with knowledge is fine, legible to someone without it is not.
--
-- The surviving blank keeps 22.0d, earned when the examples were visible. Same
-- pattern as every merge tonight, and the same argument for resetting it.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'A carbon-chain substituent (a branch off the parent chain) is named like the corresponding alkane, but its {{c1::-ane}} ending is replaced by {{c1::-yl}}.',
  cloze_count = 1
WHERE id = 'd2e76daa-909f-46d1-bd52-1fa1c2983b1a';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 1 group, 2 blanks, and no worked examples left in the text.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks,
  cloze_text ~ 'methyl|ethyl|propyl' AS examples_still_present
FROM public.flashcards WHERE id = 'd2e76daa-909f-46d1-bd52-1fa1c2983b1a';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
