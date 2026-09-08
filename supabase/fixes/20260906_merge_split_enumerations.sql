-- ============================================================
-- Lists whose members were split across different groups
--
-- Mikko found the antibody card: neutralization, opsonization and agglutination
-- in three separate groups, so asking for any one printed the other two. Not a
-- contrast and not a counted sequence, so every existing rule was blind to it.
--
-- The signature is the PARALLEL GLOSS. An author listing terms with a
-- definition after each one writes a very particular shape:
--
--   {{cA::term}} (gloss), {{cB::term}} (gloss), and {{cC::term}} (gloss)
--
-- Three or more blanks in a row, each followed by a parenthetical, separated
-- only by list punctuation. Mechanical to spot, and it found 4 cards with
-- zero false positives.
--
-- MERGED PAST THE USUAL THREE-SPAN CAP, deliberately. That cap exists to stop
-- prose being shredded into unanswerable blanks, and the sensory receptor card
-- here has SEVEN members. It is safe because every item keeps its own gloss:
-- "___ (light), ___ (pressure), ___ (pain)" is a real mapping task, where seven
-- blanks in ordinary prose would be a wall. Each merge is refused unless every
-- merged item has a DISTINCT gloss, which is the property that makes it work.
-- ============================================================

BEGIN;

-- Isomerism & Stereochemistry: 3 items  (angle strain, torsional strain, non-bonded (van der Waals) strain)
--   now: Three distinct strain types contribute to the instability of cyclic conformations: {{c1::angle strain}} (bonds forced to deviate from their ideal geom
UPDATE public.flashcards SET cloze_text = 'Three distinct strain types contribute to the instability of cyclic conformations: {{c1::angle strain}} (bonds forced to deviate from their ideal geometry), {{c1::torsional strain}} (eclipsing interactions on adjacent carbons), and {{c1::non-bonded (van der Waals) strain}} (atoms competing for the same space).', cloze_count = 1 WHERE id = '6be178c0-f513-4c7a-83cf-597458fa6d9c';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '6be178c0-f513-4c7a-83cf-597458fa6d9c' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '6be178c0-f513-4c7a-83cf-597458fa6d9c';

-- The Immune System: 3 items  (neutralization, opsonization, agglutination)
--   now: Secreted antibodies fight pathogens by {{c1::neutralization}} (blocking infective sites), {{c1::opsonization}} (tagging them for phagocytes), and {{c1
UPDATE public.flashcards SET cloze_text = 'Secreted antibodies fight pathogens by {{c1::neutralization}} (blocking infective sites), {{c1::opsonization}} (tagging them for phagocytes), and {{c1::agglutination}} (clumping them together).', cloze_count = 1 WHERE id = '83616a23-0b11-43a4-ace5-e246f8c8b67a';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '83616a23-0b11-43a4-ace5-e246f8c8b67a' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '83616a23-0b11-43a4-ace5-e246f8c8b67a';

-- Sensory Systems & Perception: 7 items  (photoreceptors, mechanoreceptors, nociceptors, ...)
--   now: Seven sensory receptor classes: {{c1::photoreceptors}} (light), {{c1::mechanoreceptors}} (pressure, movement, sound), {{c1::nociceptors}} (pain), {{c1
UPDATE public.flashcards SET cloze_text = 'Seven sensory receptor classes: {{c1::photoreceptors}} (light), {{c1::mechanoreceptors}} (pressure, movement, sound), {{c1::nociceptors}} (pain), {{c1::thermoreceptors}} (temperature), {{c1::osmoreceptors}} (blood osmolarity), {{c1::olfactory receptors}} (volatile chemicals), {{c1::taste receptors}} (dissolved chemicals).', cloze_count = 1 WHERE id = '98bf6226-6b48-4e1c-a415-0debb10e847d';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '98bf6226-6b48-4e1c-a415-0debb10e847d' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '98bf6226-6b48-4e1c-a415-0debb10e847d';

-- The Immune System: 3 items  (live-attenuated, inactivated, subunit)
--   now: Vaccines fall into three types: {{c1::live-attenuated}} (whole pathogen that still replicates weakly), {{c1::inactivated}} (whole pathogen that can no
UPDATE public.flashcards SET cloze_text = 'Vaccines fall into three types: {{c1::live-attenuated}} (whole pathogen that still replicates weakly), {{c1::inactivated}} (whole pathogen that can no longer replicate), and {{c1::subunit}} (isolated antigens only).', cloze_count = 1 WHERE id = 'a10fb606-2509-4119-982d-651ec1b4dff4';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'a10fb606-2509-4119-982d-651ec1b4dff4' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'a10fb606-2509-4119-982d-651ec1b4dff4';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0 for both, bank-wide.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;

SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
