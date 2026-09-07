-- ============================================================
-- Split contrasts: put both halves of a contrast in the same blank
--
-- A cloze card shows every group except the one being tested. When a card is
-- built on a two-way contrast and puts each half in its OWN group, asking for
-- one PRINTS the other, and the answer follows by elimination. Mikko hit this
-- again on the microtubule card: "the ___ end sits near the nucleus and the
-- POSITIVE end points toward the cell periphery."
--
-- Round two. The first pass fixed 27; these are the ones its vocabulary could
-- not see. Mikko hit "Relative configuration ... Absolute configuration" and
-- the pair list had no entry for relative/absolute. That list had also been
-- copy-pasted into three detector scripts, so learning a pair fixed only one of
-- them. It now lives in lib/contrast-vocab.mjs and every detector imports it.
--
-- 3 cards are repaired here by folding the two halves into one group, so
-- they blank together. Groups are then renumbered contiguously, because the
-- renderer matches the literal cN while the study page feeds a positional
-- index; those agree only while groups run 1..N with no gaps.
--
-- Each merge was verified before being written: groups contiguous from 1,
-- exactly one group fewer than before, and the card's words unchanged (only
-- the blanking moved).
--
-- PROGRESS ON THESE CARDS IS RESET, NOT DELETED: 11 rows across 2 account(s).
-- The schedule is discarded because the merged blank asks a harder question
-- than the one that was graded, but the card stays SEEN. Deleting the row
-- instead would make a card studied for weeks reappear as brand new and spend
-- the daily new-card budget.
-- 1 of those blanks were scheduled past the 2026-09-12 exam and would never
-- have come back in time. A leaking card could be answered without knowing it,
-- so its review history is not evidence of knowledge. These re-enter as new
-- cards and will come back within days, with the leak closed.
-- ============================================================

BEGIN;

-- Aldehydes and Ketones II: Enolates: ketones / aldehydes
--   was: α-hydrogens of {{c1::ketones}} are slightly less acidic than those of {{c2::aldehydes}} because the additional {{c3::electron-donating alkyl group}} destabilize
--   now: α-hydrogens of {{c1::ketones}} are slightly less acidic than those of {{c1::aldehydes}} because the additional {{c2::electron-donating alkyl group}} destabilize
UPDATE public.flashcards SET cloze_text = 'α-hydrogens of {{c1::ketones}} are slightly less acidic than those of {{c1::aldehydes}} because the additional {{c2::electron-donating alkyl group}} destabilizes the enolate anion.', cloze_count = 2 WHERE id = '76036677-5275-4b45-8a1b-a28217d5cc90';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '76036677-5275-4b45-8a1b-a28217d5cc90' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '76036677-5275-4b45-8a1b-a28217d5cc90';

-- Analyzing Organic Reactions: ketones / aldehydes
--   was: {{c1::Aldehydes}} are more reactive toward nucleophiles than {{c2::ketones}} because they have less {{c3::steric hindrance}} at the carbonyl carbon (one alkyl g
--   now: {{c1::Aldehydes}} are more reactive toward nucleophiles than {{c1::ketones}} because they have less {{c2::steric hindrance}} at the carbonyl carbon (one alkyl g
UPDATE public.flashcards SET cloze_text = '{{c1::Aldehydes}} are more reactive toward nucleophiles than {{c1::ketones}} because they have less {{c2::steric hindrance}} at the carbonyl carbon (one alkyl group instead of two).', cloze_count = 2 WHERE id = 'a93a6f48-914f-4268-a7f2-5dfc7b32ee45';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'a93a6f48-914f-4268-a7f2-5dfc7b32ee45' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'a93a6f48-914f-4268-a7f2-5dfc7b32ee45';

-- Analyzing Organic Reactions: ketones / aldehydes
--   was: Reactivity ranking toward nucleophiles: {{c1::carboxylic acids and derivatives}} > {{c2::aldehydes}} > {{c3::ketones}} > {{c4::alcohols / amines}}.
--   now: Reactivity ranking toward nucleophiles: {{c1::carboxylic acids and derivatives}} > {{c2::aldehydes}} > {{c2::ketones}} > {{c3::alcohols / amines}}.
UPDATE public.flashcards SET cloze_text = 'Reactivity ranking toward nucleophiles: {{c1::carboxylic acids and derivatives}} > {{c2::aldehydes}} > {{c2::ketones}} > {{c3::alcohols / amines}}.', cloze_count = 3 WHERE id = 'acabc779-1e51-4116-a318-3c3662c94456';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'acabc779-1e51-4116-a318-3c3662c94456' AND cloze_index > 3;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'acabc779-1e51-4116-a318-3c3662c94456';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: every repaired card's group count must equal cloze_count.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE id IN ('76036677-5275-4b45-8a1b-a28217d5cc90','a93a6f48-914f-4268-a7f2-5dfc7b32ee45','acabc779-1e51-4116-a318-3c3662c94456')
) t WHERE n <> cloze_count;

-- Expect 0: no leftover progress pointing at a blank that no longer exists.
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
