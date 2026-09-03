-- ============================================================
-- Distal / proximal stimulus: hide the contrasting pair together
--
-- Spotted by Mikko while studying.
--
--   A {{c1::distal stimulus}} is the actual object ... The
--   {{c2::proximal stimulus}} is the pattern of energy ...
--
-- Both terms are blanked, but in SEPARATE groups, so asking for one prints the
-- other on screen. The card is built entirely on the distal-versus-proximal
-- contrast, which means the visible half determines the hidden half and the
-- blank tests nothing. Same shape as the projectile motion card
-- (horizontal / vertical) and the sodium channel card.
--
-- Merging them into one group hides both, so the student has to produce which
-- is which. cloze_count goes 2 to 1, orphaning one scheduling row carrying 3.0
-- days of stability. That is cheap, and the stability was earned on a blank
-- that could be answered by reading, so it is inflated rather than real.
--
-- WHY NO SCANNER FOUND THIS. The leech pass looked at cards with 5+ lapses.
-- The visible-answer pass looked at cards with 0 lapses and 3+ reps. This card
-- has ONE lapse on one blank: too easy for the first filter, too hard for the
-- second. 3,470 of the 4,115 studied cards (84%) fall in that gap, most of them
-- the 1,518 cards with one to four lapses.
--
-- Both filters selected on how OFTEN a card is failed, and this defect class is
-- not a property of failure rate at all. Any future sweep for it should read the
-- text of every card and ignore the review history entirely.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'A {{c1::distal stimulus}} is the actual object or event in the world (a tree, a sound source, a hot stove). The {{c1::proximal stimulus}} is the pattern of energy that physically reaches the receptors: photons hitting the retina, sound waves vibrating the eardrum, heat touching skin thermoreceptors.',
  cloze_count = 1
WHERE id = '91e92211-4318-4fd7-a03c-322c7339d792';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one group, two blanks inside it.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '91e92211-4318-4fd7-a03c-322c7339d792';

-- The now-dead row at blank 2. Left in place: harmless, and the review log
-- still references this card.
SELECT cloze_index, COUNT(*) AS rows
FROM public.flashcard_user_state
WHERE flashcard_id = '91e92211-4318-4fd7-a03c-322c7339d792'
GROUP BY cloze_index ORDER BY cloze_index;
