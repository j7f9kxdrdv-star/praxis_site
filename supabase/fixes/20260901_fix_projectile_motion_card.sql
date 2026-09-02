-- ============================================================
-- Projectile motion card: blank "horizontal" too
--
-- Spotted by Mikko while studying, and it is a case the leech diagnosis could
-- never have found.
--
-- The card read:
--
--   the horizontal and {{c2::vertical}} motions are mathematically
--   {{c1::independent}}. Gravity acts only along the {{c2::vertical}} axis,
--   while no force acts along the horizontal axis
--
-- With "horizontal" printed twice in visible text, "vertical" is the only word
-- that can go in either blank. The student answers correctly without knowing
-- anything, and the scheduler records a successful retrieval that never
-- happened.
--
-- WHY THE DIAGNOSIS MISSED IT. That pass examined cards with 5 or more lapses.
-- This card has ZERO — it has never been failed, because it cannot be. A card
-- whose answer is visible looks EASY, not hard, so selecting on failure
-- excludes exactly the defect class this is. The filter was biased against its
-- own best finding.
--
-- Blanking both terms in the SAME group (c2) hides them together, so the
-- student must produce which motion is which rather than reading one off the
-- other. Group set {1,2} is unchanged; blank count rises from 3 to 5.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'In projectile motion (2D motion under gravity alone), the {{c2::horizontal}} and {{c2::vertical}} motions are mathematically {{c1::independent}}. Gravity acts only along the {{c2::vertical}} axis, while no force acts along the {{c2::horizontal}} axis (with air resistance neglected).'
WHERE id = '891a9211-2550-4e39-9d1e-959aa7201a6d';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count 2 and 2 distinct groups still in the text.
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks,
  cloze_text
FROM public.flashcards WHERE id = '891a9211-2550-4e39-9d1e-959aa7201a6d';
