-- ============================================================
-- Cards that spell out their own abbreviated answer
--
-- Mikko caught this on the cDNA card: the blank is "cDNA" and the very next
-- words are "(complementary DNA)". Nothing is recalled, it is read off.
--
-- An earlier pass fixed the OPPOSITE arrangement, where the answer was the
-- expansion and the stem carried the acronym, so this direction survived. The
-- detector now checks both.
--
-- 4 cards are repaired. The detector flagged 7; the other 3 were checked and
-- dismissed: "As Na+ enters" opens a sentence and is not an abbreviation of
-- "adjacent segment"; naming the "Arrhenius equation" does not give away the
-- formula that is being asked for; and HCO3- is a different chemical species
-- from H2CO3, not its abbreviation.
--
-- An earlier run of this detector reported 14. Seven of those were caused by a
-- bug in the detector itself, not by the cards: Unicode subscript digits were
-- being stripped before comparison, so "CO2" keyed as "co" and matched any two
-- words beginning c- and o-, such as "cycle oxidatively". Fixed by folding
-- subscript and superscript digits to ASCII first.
--
-- Every rewrite was verified before being written: the card's wording is
-- unchanged, groups run contiguously from 1, no blank has stray whitespace,
-- and no two blanks are jammed together.
-- ============================================================

BEGIN;

-- The Cell: the answer "cDNA" was spelled out in the very next words
--   was: {{c1::cDNA}} (complementary DNA) is synthesized in vitro from a mature {{c2::mRNA}} template using the enzyme {{c2::reverse transcriptase}}. The technique 
--   now: {{c1::cDNA}} ({{c1::complementary DNA}}) is synthesized in vitro from a mature {{c2::mRNA}} template using the enzyme {{c2::reverse transcriptase}}. The te
UPDATE public.flashcards SET cloze_text = '{{c1::cDNA}} ({{c1::complementary DNA}}) is synthesized in vitro from a mature {{c2::mRNA}} template using the enzyme {{c2::reverse transcriptase}}. The technique lets molecular biologists clone the protein-coding sequence of a gene without its introns.', cloze_count = 2 WHERE id = '6de24fb6-36ae-41f7-833b-06e32e6a25e6';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '6de24fb6-36ae-41f7-833b-06e32e6a25e6';

-- Spectroscopy: both acronyms were expanded in parentheses beside themselves
--   was: The {{c1::HOMO}} (Highest Occupied Molecular Orbital) is the highest-energy orbital containing electrons; the {{c1::LUMO}} (Lowest Unoccupied Molecular Orb
--   now: The {{c1::HOMO}} ({{c1::Highest Occupied Molecular Orbital}}) is the highest-energy orbital containing electrons; the {{c1::LUMO}} ({{c1::Lowest Unoccupied
UPDATE public.flashcards SET cloze_text = 'The {{c1::HOMO}} ({{c1::Highest Occupied Molecular Orbital}}) is the highest-energy orbital containing electrons; the {{c1::LUMO}} ({{c1::Lowest Unoccupied Molecular Orbital}}) is the lowest-energy empty orbital.', cloze_count = 1 WHERE id = 'd70fa8f8-451f-4d9b-b534-2e918ae6ddfa';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'd70fa8f8-451f-4d9b-b534-2e918ae6ddfa';

-- Oxidation-Reduction Reactions: the stem printed "OIL RIG", which directly encodes both answers
--   was: The mnemonic OIL RIG stands for {{c1::Oxidation Is Loss}} (of electrons) and {{c1::Reduction Is Gain}} (of electrons).
--   now: The mnemonic {{c1::OIL RIG}} stands for {{c1::Oxidation Is Loss}} (of electrons) and {{c1::Reduction Is Gain}} (of electrons).
UPDATE public.flashcards SET cloze_text = 'The mnemonic {{c1::OIL RIG}} stands for {{c1::Oxidation Is Loss}} (of electrons) and {{c1::Reduction Is Gain}} (of electrons).', cloze_count = 1 WHERE id = '3dda94b5-2aa6-42d6-87b4-75f1bdf97e4b';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '3dda94b5-2aa6-42d6-87b4-75f1bdf97e4b';

-- Energy, Work & Simple Machines: the sibling blank showed "MA = ...", the initials of the answer
--   was: {{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c2::MA = F_(out) / F_(in)}}.
--   now: {{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c1::MA = F_(out) / F_(in)}}.
UPDATE public.flashcards SET cloze_text = '{{c1::Mechanical advantage}} of a simple machine is the ratio of the output force it produces to the input force applied: {{c1::MA = F_(out) / F_(in)}}.', cloze_count = 1 WHERE id = 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860';

COMMIT;

-- Verification. Expect 0 for both.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE id IN ('6de24fb6-36ae-41f7-833b-06e32e6a25e6','d70fa8f8-451f-4d9b-b534-2e918ae6ddfa','3dda94b5-2aa6-42d6-87b4-75f1bdf97e4b','a55d2eb6-82ae-4d85-88ef-2ac2d3f5a860')
) t WHERE n <> cloze_count;

SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
