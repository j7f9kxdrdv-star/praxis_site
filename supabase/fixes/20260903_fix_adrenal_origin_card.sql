-- ============================================================
-- The adrenal card could be answered by symmetry
--
-- Stored with all four items in separate groups:
--
--   "the adrenal {c1 cortex} is derived from {c2 mesoderm}, but the adrenal
--    {c3 medulla} is derived from {c4 neural crest} (ectoderm)."
--
-- Asking for c1 printed "the adrenal medulla" in the parallel clause, so the
-- answer followed without knowing any embryology. Asking for c3 printed
-- "cortex" for the same reason.
--
-- Repaired by pairing rather than merging everything: the two STRUCTURES share
-- one group and the two ORIGINS share the other. Each group then tests a real
-- mapping instead of a symmetry.
--
--   asking group 1: "the adrenal ___ is derived from mesoderm, but the adrenal
--                    ___ is derived from neural crest" -> which is which
--   asking group 2: "the adrenal cortex is derived from ___, but the adrenal
--                    medulla is derived from ___"      -> name the germ layers
--
-- Found by a new detector that needs no vocabulary. The other rules have to be
-- told what a contrast is, and that list is only ever as good as the last card
-- Mikko studied. This one keys on the SHAPE of the writing instead: the frame
-- "the adrenal" repeating on both sides of the contrast. It flags 81 cards
-- bank-wide at roughly one-third precision, so it is a review queue and not an
-- automatic fix; this card was confirmed by hand.
--
-- Verified before writing: wording unchanged, two contiguous groups, no
-- malformed or jammed blanks.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'A classic dissociation: the adrenal {{c1::cortex}} is derived from {{c2::mesoderm}}, but the adrenal {{c1::medulla}} is derived from {{c2::neural crest}} (ectoderm).',
    cloze_count = 2
WHERE id = '935bdfed-4dfd-436b-ada8-57c57df07b29';

-- Four blanks become two, so progress on the old c3 and c4 points at blanks
-- that no longer exist.
DELETE FROM public.flashcard_user_state
WHERE flashcard_id = '935bdfed-4dfd-436b-ada8-57c57df07b29' AND cloze_index > 2;

UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = '935bdfed-4dfd-436b-ada8-57c57df07b29';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count FROM public.flashcards WHERE id = '935bdfed-4dfd-436b-ada8-57c57df07b29';
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
