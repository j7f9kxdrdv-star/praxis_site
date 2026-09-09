-- ============================================================
-- Cards that withheld the question
--
-- Mikko found the thermodynamics card:
--
--   "A process carried out at constant {c1 pressure} is called {c1 isobaric}."
--
-- Blank both and the sentence reads "carried out at constant ___ is called
-- ___", which fits pressure/isobaric, volume/isochoric or
-- temperature/isothermal equally well. Its own sibling card gets this right,
-- leaving the cue visible: "at constant volume is called {c1 isochoric}".
--
-- THIS IS THE OPPOSITE FAILURE to the one most of these repairs chase. A leak
-- gives the answer away; this withholds the question. Merging fixes leaks and,
-- pushed too far, causes exactly this, so the two have to be watched together.
--
-- A new check now scans for it: blank each group and count what CONTENT
-- survives, treating numbers and symbols as cues since "10^12 = ___" is cued by
-- the exponent, and skipping cards that carry an image, since the picture is
-- the cue. Across 4,116 cards it finds these 2.
-- ============================================================

BEGIN;

-- both the cue and the term were hidden, so the sentence could equally have been volume/isochoric or temperature/isothermal. Its sibling card leaves the cue visible; this now matches it.
--   was: A process carried out at constant {{c1::pressure}} is called {{c1::isobaric}}.
--   now: A process carried out at constant pressure is called {{c1::isobaric}}.
UPDATE public.flashcards SET cloze_text = 'A process carried out at constant pressure is called {{c1::isobaric}}.', cloze_count = 1 WHERE id = 'afb2a4e3-7e06-461c-9bfa-9f8c06e506ca';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'afb2a4e3-7e06-461c-9bfa-9f8c06e506ca' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'afb2a4e3-7e06-461c-9bfa-9f8c06e506ca';

-- the whole reactant side was one blank, leaving only an arrow and the product. The reagent now stays visible, so each side can be asked for on its own.
--   was: {{c1::Secondary alcohols + PCC (or any stronger oxidizer)}} → {{c2::ketones}}.
--   now: {{c1::Secondary alcohols}} + PCC (or any stronger oxidizer) → {{c2::ketones}}.
UPDATE public.flashcards SET cloze_text = '{{c1::Secondary alcohols}} + PCC (or any stronger oxidizer) → {{c2::ketones}}.', cloze_count = 2 WHERE id = '703c0f9e-5d3c-40a7-bb57-375ca678d7ba';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '703c0f9e-5d3c-40a7-bb57-375ca678d7ba' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '703c0f9e-5d3c-40a7-bb57-375ca678d7ba';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;
