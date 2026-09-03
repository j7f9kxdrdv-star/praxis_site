-- ============================================================
-- Autonomic two-neuron chain: hide preganglionic and postganglionic together
--
-- Spotted by Mikko while studying.
--
--   a {{c2::preganglionic}} neuron in the CNS synapses on a
--   {{c3::postganglionic}} neuron in a peripheral ganglion
--
-- The card states there are exactly two neurons and puts each in its own group,
-- so asking for one prints the other and "pre" follows from seeing "post".
--
-- Merging c3 into c2 keeps the group set contiguous at {1,2} with no
-- renumbering, because c3 is the highest group. cloze_count goes 3 to 2 and the
-- blank-3 scheduling rows are orphaned:
--
--   beta tester  39.1d stability
--   founder       0.9d
--
-- 39.1 days is the largest single loss of any repair in this directory. The
-- case for it is unchanged: that interval was earned on a blank answerable by
-- reading the other half of the sentence, so it records reading rather than
-- recall. But it is the one most worth pausing over, and skipping this file
-- costs nothing else.
--
-- THIS CARD IS WHY THE DETECTOR NOW HAS A PREFIX RULE. An explicit list of
-- opposing pairs missed it, because nobody had written down
-- preganglionic/postganglionic. Two answers sharing a root and differing only
-- by an opposing prefix are a contrast whatever the root is, which generalises
-- instead of needing the vocabulary enumerated in advance.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'The {{c1::autonomic}} nervous system uses a two-neuron chain: a {{c2::preganglionic}} neuron in the CNS synapses on a {{c2::postganglionic}} neuron in a peripheral ganglion, which then innervates the target.',
  cloze_count = 2
WHERE id = 'a9cbd3c8-a2ec-45a6-b5b2-cc3ed1e24a87';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT string_agg(DISTINCT m[1], ',' ORDER BY m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_present,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'a9cbd3c8-a2ec-45a6-b5b2-cc3ed1e24a87';

-- Expect zero: no card should have a gap in its group numbers.
SELECT COUNT(*) AS cards_with_group_gaps FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS n,
    (SELECT MAX(m[1]::int) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS hi
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> hi OR n <> cloze_count;
