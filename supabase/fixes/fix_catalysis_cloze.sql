-- Merge the homogeneous/heterogeneous catalysis blanks into ONE cloze group.
-- Both terms were already blanked, but as SEPARATE clozes (c1, c2) — so each was tested
-- on its own review with the other term visible, giving away the answer. Making both c1
-- hides them together, so you reason from "same phase" vs "different phase".
-- UPDATE in place; SRS preserved.
UPDATE public.flashcards
SET cloze_text = 'In {{c1::homogeneous}} catalysis the catalyst shares the same phase as the reactants; in {{c1::heterogeneous}} catalysis it occupies a different phase, usually a solid whose surface hosts the reaction.',
    cloze_count = 1
WHERE id = '7258535d-0375-4ff5-a7f4-260021478f52';

-- Verification: this SELECT prints the card afterward. It must show ONE row where
-- both blanks are c1 and cloze_count = 1. (If you see c2 in the text, the UPDATE
-- above did not run — check you executed this whole tab.)
SELECT cloze_count,
       cloze_text
FROM public.flashcards
WHERE id = '7258535d-0375-4ff5-a7f4-260021478f52';
