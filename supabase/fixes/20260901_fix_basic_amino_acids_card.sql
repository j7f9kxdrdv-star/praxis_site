-- ============================================================
-- Basic amino acids: hide all three together
--
-- Spotted by Mikko while studying.
--
--   The basic amino acids are {{c1::lysine}}, {{c2::arginine}}, and
--   {{c3::histidine}}
--
-- A closed set of three, each in its own group, so asking for any one prints
-- the other two and the answer is whichever is missing. There are only three
-- basic amino acids, which is precisely what makes the elimination work.
--
-- All three move into c1. cloze_count goes 3 to 1 and blanks 2 and 3 are
-- orphaned: 3.8d, and 1.0d / 29.4d across two accounts.
--
-- SAME SHAPE AS THE BRAIN IMAGING CARD, AND STILL UNREACHABLE BY ANY RULE.
-- lysine, arginine and histidine share no root, no prefix, and no opposition,
-- so nothing morphological connects them. The earlier attempt to catch this
-- family by looking for a count word in the stem returned 150+ cards of noise.
-- Finding these needs a model reading the card or a person studying it.
--
-- WORTH NOTICING ABOUT THIS ONE: the visible text says the side chains are
-- "nitrogen-containing" and "positively charged at physiological pH", which is
-- the definition of a basic amino acid. So even with all three hidden, a
-- student who knows the chemistry can reason toward them. That is fine, and it
-- is the distinction these repairs rest on: reasoning from knowledge is the
-- point, reading three names off the screen is not.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'The basic amino acids are {{c1::lysine}}, {{c1::arginine}}, and {{c1::histidine}}; their side chains carry nitrogen-containing groups that are typically protonated and positively charged at physiological pH.',
  cloze_count = 1
WHERE id = 'e17b39f7-5df8-45ed-af28-a885df433763';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one group, three blanks inside it.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'e17b39f7-5df8-45ed-af28-a885df433763';

-- Expect zero.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
