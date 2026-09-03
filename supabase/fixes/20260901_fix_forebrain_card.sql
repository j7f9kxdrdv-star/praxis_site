-- ============================================================
-- Forebrain divisions: hide telencephalon and diencephalon together
--
-- Spotted by Mikko while studying. The card was:
--
--   The {{c1::telencephalon}} gives rise to {{c2::...}}; the
--   {{c3::diencephalon}} gives rise to {{c4::...}}.
--
-- The two division names sit in separate groups, so asking for one prints the
-- other. The card announces there are exactly two divisions, which makes the
-- visible half determine the hidden half. Same shape as the projectile motion,
-- sodium channel and distal/proximal cards.
--
-- THIS ONE NEEDS RENUMBERING, NOT JUST MERGING. Folding c3 into c1 would leave
-- groups {1, 2, 4}. The study screen iterates blanks 1..cloze_count and the
-- renderer matches the LITERAL group number, so a gap at 3 means blank 3 finds
-- nothing and c4 is never testable at all. The groups must stay contiguous, so
-- c4 becomes c3 and cloze_count drops from 4 to 3.
--
-- WHAT THAT COSTS, EXACTLY:
--   blank 1  telencephalon           -> telencephalon AND diencephalon
--   blank 2  cortex/basal ganglia    -> unchanged
--   blank 3  diencephalon            -> RE-POINTED to thalamus/hypothalamus/...
--   blank 4  thalamus/hypothalamus   -> orphaned
--
-- The re-pointed and orphaned rows carry 0.6 and 0.1 days of stability, so
-- almost nothing is lost. Had they been mature this fix would need a different
-- approach, and the numbers were checked before writing it rather than assumed.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'The forebrain develops embryonically from two divisions. The {{c1::telencephalon}} gives rise to the {{c2::cerebral cortex, basal ganglia, and limbic system}}; the {{c1::diencephalon}} gives rise to the {{c3::thalamus, hypothalamus, posterior pituitary, and pineal gland}}.',
  cloze_count = 3
WHERE id = 'b2b7a2a8-cbf8-4a6a-bcfc-8f6ac35f3b40';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 3 and groups 1,2,3 present with no gap. A gap here means
-- a blank the student can never be shown.
SELECT cloze_count,
  (SELECT string_agg(DISTINCT m[1], ',' ORDER BY m[1])
     FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_present,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'b2b7a2a8-cbf8-4a6a-bcfc-8f6ac35f3b40';

-- Nothing anywhere in the bank should have a non-contiguous group set.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
