-- ============================================================
-- Aufbau card: stop the clause after the blank from spelling the answer
--
-- Spotted by Mikko while studying.
--
--   The energy ordering is given by the {{c2::n + ℓ rule}}: lower n + ℓ fills
--   first, and when two subshells tie, the one with lower {{c3::n}} fills first
--
-- The words immediately after the blank are the answer. Asking "the ordering is
-- given by the ___" while "lower n + ℓ fills first" sits on the next line is
-- not a memory test.
--
-- The fix rewords the continuation rather than blanking it. Adding "n + ℓ" to
-- group c2 would hide the explanation along with the term and leave "lower ___
-- fills first", which teaches nothing. Saying "the lower sum" carries the same
-- meaning without naming the quantity.
--
-- Group set {1,2,3} and blank count are unchanged, so no scheduling row moves.
-- This is the cheapest kind of repair in this directory: no merge, no orphaned
-- interval, no judgement about earned progress.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'Electrons fill subshells from lowest to highest energy. That is the {{c1::Aufbau principle}}. The energy ordering is given by the {{c2::n + ℓ rule}}: the subshell with the lower sum fills first, and when two subshells tie, the one with lower {{c3::n}} fills first.'
WHERE id = 'de59d606-7298-4efe-ac67-5d60d4f5de95';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 3 groups, 3 blanks, count 3, and no bare "n + ℓ" outside the blank.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks,
  cloze_text
FROM public.flashcards WHERE id = 'de59d606-7298-4efe-ac67-5d60d4f5de95';
