-- ============================================================
-- The last split contrast: a three-item list merged only two ways
--
-- The card announces "the THREE main classes of ion channels" and then splits
-- them: ungated and voltage-gated in one group, ligand-gated in another. The
-- merge tool caught the un- negation between "ungated" and "ligand-gated" and
-- folded two groups, which left the third sitting in the open. Asking for
-- ligand-gated still printed the other two.
--
-- The series rule already folds every member of a counted sequence. This is
-- the same shape reached through the negation rule instead, which only ever
-- returns a pair. Fixed by hand rather than by widening that rule: a
-- count-word heuristic was tried earlier in this bank and flagged 203 cards,
-- nearly all of them ordinary prose that happened to say "two" or "three".
--
-- All three classes now blank together, which is what the stem promises.
--
-- Verified before writing: wording unchanged, one contiguous group, three
-- spans, no malformed or jammed blanks.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'The three main classes of ion channels are {{c1::ungated}} (always open), {{c1::voltage-gated}} (open in response to membrane potential), and {{c1::ligand-gated}} (open in response to a chemical messenger).',
    cloze_count = 1
WHERE id = '086d891f-7ff7-43d3-a335-28e4fd26b228';

DELETE FROM public.flashcard_user_state
WHERE flashcard_id = '086d891f-7ff7-43d3-a335-28e4fd26b228' AND cloze_index > 1;

UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = '086d891f-7ff7-43d3-a335-28e4fd26b228';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0 for both.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;

SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
