-- Fix: cards that hide TWO INDEPENDENT FACTS in the same cloze group, so both
-- words disappear at once and the card becomes unanswerable. Founder-flagged
-- example: "An {{c1::ammeter}} measures {{c1::current}} and is connected in
-- {{c2::series}}" renders as "An ___ measures ___ and is connected in series",
-- which gives the student nothing to reason from.
--
-- RULE APPLIED: one fact per blank, revealed one at a time.
--
-- SRS SAFETY: existing group numbers are NEVER renumbered, because a cloze group
-- number is the key that ties a scheduling row to a fact; renumbering would
-- transplant one fact's interval history onto a different fact. Instead the
-- freed word is promoted to the NEXT UNUSED group number, so every existing
-- schedule stays attached to the fact it was earned on and only the newly split
-- blank enters as a fresh card. cloze_count is raised to match.
--
-- Four cards, all in the instrumentation lane. Idempotent (guarded by LIKE).

-- 1. Ammeter (Physics Ch6). c1 keeps "ammeter", c2 keeps "series",
--    "current" becomes the new c3.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'measures {{c1::current}}', 'measures {{c3::current}}'),
    cloze_count = 3
WHERE cloze_text LIKE '%{{c1::ammeter}} measures {{c1::current}}%';

-- 2. Voltmeter (Physics Ch6). c1 keeps "voltmeter", "parallel" becomes c2.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'connected in {{c1::parallel}}', 'connected in {{c2::parallel}}'),
    cloze_count = 2
WHERE cloze_text LIKE '%{{c1::voltmeter}} measures the potential difference%'
  AND cloze_text LIKE '%{{c1::parallel}}%';

-- 3. Ohmmeter (Physics Ch6). c1 keeps "self-powered", the usage condition becomes c2.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'when {{c1::no other current}}', 'when {{c2::no other current}}'),
    cloze_count = 2
WHERE cloze_text LIKE '%{{c1::self-powered}}%'
  AND cloze_text LIKE '%{{c1::no other current}}%';

-- 4. Voltmeter vs potentiometer (GenChem Ch12). c1 keeps "voltmeter",
--    "potentiometer" becomes c2.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'a {{c1::potentiometer}}', 'a {{c2::potentiometer}}'),
    cloze_count = 2
WHERE cloze_text LIKE '%{{c1::voltmeter}} measures cell EMF%'
  AND cloze_text LIKE '%{{c1::potentiometer}}%';

-- 5. Barometer (GenChem Ch8 Gas Phase). Same subject-verb-object shape as the
--    ammeter card, found by a targeted scan. c1 keeps "barometer",
--    "atmospheric" becomes c2.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'measures {{c1::atmospheric}}', 'measures {{c2::atmospheric}}'),
    cloze_count = 2
WHERE cloze_text LIKE '%{{c1::barometer}} measures {{c1::atmospheric}}%';

-- Verification 1: expect 0 rows (no card still hides two independent facts together).
SELECT id, LEFT(cloze_text, 100) AS still_double_blanked
FROM public.flashcards
WHERE cloze_text LIKE '%{{c1::ammeter}} measures {{c1::current}}%'
   OR (cloze_text LIKE '%{{c1::voltmeter}}%' AND cloze_text LIKE '%{{c1::parallel}}%')
   OR (cloze_text LIKE '%{{c1::self-powered}}%' AND cloze_text LIKE '%{{c1::no other current}}%')
   OR (cloze_text LIKE '%{{c1::voltmeter}}%' AND cloze_text LIKE '%{{c1::potentiometer}}%')
   OR cloze_text LIKE '%{{c1::barometer}} measures {{c1::atmospheric}}%';

-- Verification 2: expect 5 rows, each with its new group and matching cloze_count.
SELECT id, cloze_count, LEFT(cloze_text, 110) AS fixed
FROM public.flashcards
WHERE cloze_text LIKE '%{{c3::current}}%'
   OR cloze_text LIKE '%{{c2::parallel}}%'
   OR cloze_text LIKE '%{{c2::no other current}}%'
   OR cloze_text LIKE '%{{c2::potentiometer}}%'
   OR cloze_text LIKE '%{{c2::atmospheric}}%'
ORDER BY cloze_count;
