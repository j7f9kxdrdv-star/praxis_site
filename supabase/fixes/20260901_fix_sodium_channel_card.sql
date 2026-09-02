-- ============================================================
-- Sodium channel states: hide all three together
--
-- Spotted by Mikko while studying. The card already blanks all three states,
-- but in SEPARATE groups:
--
--   three states: {{c1::closed}} (...), {{c2::open}} (...), and
--   {{c3::inactivated}} (...)
--
-- A cloze card reveals every group except the one being tested, so asking for
-- "open" prints "closed" and "inactivated" on screen. With the stem announcing
-- that there are exactly three, the answer is pure elimination. The card is
-- answered correctly without the student knowing anything, and the scheduler
-- banks a retrieval that never happened.
--
-- THE FIX COSTS SOMETHING, DELIBERATELY. Merging the three into one group takes
-- cloze_count from 3 to 1, so the scheduling rows at blank 2 and blank 3 are
-- orphaned: 37.5d and 46.9d of stability on the beta tester's account, 28.6d
-- and 2.1d on the founder's.
--
-- That progress should go. It was earned on a card whose answers were legible,
-- so the stability is inflated rather than real, and keeping it would mean
-- keeping a number the system has no evidence for. The surviving blank now
-- asks for all three states at once, which is the fact the card was always
-- meant to test.
--
-- This is the exception to the group-set rule used everywhere else in this
-- repository. It is safe ONLY because it is one hand-checked card and the
-- orphaned rows are known and accounted for. Do not do this in bulk.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'Voltage-gated sodium channels exist in three states: {{c1::closed}} (below threshold and after inactivation reverses), {{c1::open}} (from threshold to ~+35 mV), and {{c1::inactivated}} (~+35 mV down to the resting potential).',
  cloze_count = 1
WHERE id = '9a1aafbf-21ed-4d12-9172-50a2e68e72d7';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 1, one distinct group, three blanks inside it.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = '9a1aafbf-21ed-4d12-9172-50a2e68e72d7';

-- The now-dead scheduling rows. They stop being served because the study screen
-- iterates blanks 1..cloze_count. Left in place rather than deleted: they are
-- harmless, and flashcard_reviews still references this card's history.
SELECT cloze_index, COUNT(*) AS rows
FROM public.flashcard_user_state
WHERE flashcard_id = '9a1aafbf-21ed-4d12-9172-50a2e68e72d7'
GROUP BY cloze_index ORDER BY cloze_index;
