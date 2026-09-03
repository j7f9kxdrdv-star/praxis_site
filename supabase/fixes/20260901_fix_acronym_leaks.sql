-- ============================================================
-- Two cards that print the abbreviation of their own answer
--
-- Spotted by Mikko while studying the electron affinity card. A scan for the
-- same shape across the bank found one more.
--
-- ELECTRON AFFINITY. "{{c1::Electron affinity}} is the energy change ...
-- making EA an exothermic process. By convention, EA is often reported ..."
-- The term is hidden and its abbreviation is printed twice. Both EAs move into
-- c1 so they hide with the term, which also teaches the abbreviation rather
-- than giving it away. Group set {1,2,3} and blank count unchanged, so no
-- scheduling row moves.
--
-- JUST NOTICEABLE DIFFERENCE. "... used to measure the JND ... recorded as the
-- {{c2::just noticeable difference}}". Same shape, reversed: the abbreviation
-- appears BEFORE the blank it gives away. JND moves into c2.
--
-- Both are the cheapest class of repair: adding an occurrence to an existing
-- group changes neither the group set nor the count, so nothing is orphaned and
-- no interval is lost. Compare the merges elsewhere in this directory, which
-- always cost a scheduling row.
--
-- ONE MORE CARD MATCHED THE SCAN AND IS DELIBERATELY UNTOUCHED. The SN2 card
-- has answers "substrate" and "nucleophile", whose initials spell SN, and SN2
-- appears in the stem. That is a coincidence, not a leak: SN2 is the name of
-- the reaction, and nobody derives "substrate" from seeing it.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'{{c1::Electron affinity}} is the energy change when a gaseous atom gains an electron; for most atoms this releases energy (ΔH negative), making {{c1::EA}} an {{c2::exothermic}} process. By convention, {{c1::EA}} is often reported as a {{c3::positive number}} reflecting the magnitude of energy released.'
WHERE id = 'b2515dd8-e7d6-4888-af9d-753521a1f0aa';

UPDATE public.flashcards SET cloze_text =
'{{c1::Discrimination testing}} is the experimental method used to measure the {{c2::JND}}. A baseline stimulus is presented, then varied by progressively larger amounts until the participant reports noticing a change. The smallest reliably noticed change is recorded as the {{c2::just noticeable difference}} for that baseline.'
WHERE id = 'c5482080-0060-4bdc-990f-c6060de5e18b';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect the group sets and counts to be exactly as before: 3 and 2.
SELECT id, cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards
WHERE id IN ('b2515dd8-e7d6-4888-af9d-753521a1f0aa','c5482080-0060-4bdc-990f-c6060de5e18b');

-- Expect zero: neither abbreviation should remain outside a blank.
SELECT COUNT(*) AS abbreviation_still_visible FROM public.flashcards
WHERE (id = 'b2515dd8-e7d6-4888-af9d-753521a1f0aa' AND regexp_replace(cloze_text,'\{\{c\d+::[^}]*\}\}','','g') ~ '\mEA\M')
   OR (id = 'c5482080-0060-4bdc-990f-c6060de5e18b' AND regexp_replace(cloze_text,'\{\{c\d+::[^}]*\}\}','','g') ~ '\mJND\M');
