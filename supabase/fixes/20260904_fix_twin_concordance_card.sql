-- ============================================================
-- The twin concordance card gave itself away twice
--
-- Stored with all five items in separate groups:
--
--   "{c1 Monozygotic (identical)} twins share approximately {c2 100%} of their
--    genes; {c3 dizygotic (fraternal)} twins share approximately {c4 50%}."
--
-- TWO split contrasts, not one. Mikko spotted the twin types: asking for
-- "dizygotic" printed "Monozygotic" in the sibling blank. The percentages leak
-- the same way, since seeing 50% tells you the other figure is 100%.
--
-- Repaired by pairing rather than merging everything. The two TWIN TYPES share
-- one group and the two PERCENTAGES share the other, so each group tests a
-- mapping instead of a symmetry:
--
--   asking group 1: "___ twins share 100%; ___ twins share 50%"  -> which is which
--   asking group 2: "Monozygotic share ___; dizygotic share ___" -> the figures
--
-- Merging all four into one group would have left a sentence with almost
-- nothing readable in it, which is the over-merge that wrecked the Le Chatelier
-- card earlier.
--
-- Verified before writing: wording unchanged, three contiguous groups, at most
-- two spans per group, no malformed or jammed blanks.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = '{{c1::Monozygotic (identical)}} twins share approximately {{c2::100%}} of their genes; {{c1::dizygotic (fraternal)}} twins share approximately {{c2::50%}}. Higher concordance rates for a trait in MZ than DZ twins indicates a {{c3::genetic contribution}} to that trait.',
    cloze_count = 3
WHERE id = 'bec101c3-5bed-4821-bd8d-c5636ee316ea';

-- Five blanks become three, so progress on the old c4 and c5 points at blanks
-- that no longer exist.
DELETE FROM public.flashcard_user_state
WHERE flashcard_id = 'bec101c3-5bed-4821-bd8d-c5636ee316ea' AND cloze_index > 3;

UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = 'bec101c3-5bed-4821-bd8d-c5636ee316ea';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count FROM public.flashcards WHERE id = 'bec101c3-5bed-4821-bd8d-c5636ee316ea';
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
