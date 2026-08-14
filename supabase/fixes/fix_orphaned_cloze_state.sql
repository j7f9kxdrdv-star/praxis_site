-- Fix: orphaned scheduling rows in flashcard_user_state.
--
-- WHAT THEY ARE. Each row in flashcard_user_state schedules ONE blank of one
-- card, keyed by (flashcard_id, cloze_index). When a past card edit REDUCED a
-- card's cloze_count -- e.g. the respiratory fix that merged c3 into c2, taking
-- the card from 3 blanks to 2 -- the scheduling row for the removed blank was
-- left behind, still pointing at cloze_index 3 on a card that now has only 2.
--
-- WHY THEY MATTER. The two pages disagree because they handle them differently:
--   . the dashboard counts globally (unseen = total instances - state rows), so
--     each orphan inflates the "seen" set and under-reports unseen cards;
--   . the flashcards page counts per deck and clamps negatives to zero, so the
--     same orphans are silently absorbed instead.
-- That is the residual 6-card disagreement between the two headline numbers.
--
-- IS DELETING SAFE? Yes. These rows describe a blank that no longer exists, so
-- no session can ever serve them and no live card reads them. Leaving them is
-- the riskier option: if a card's blank count were ever raised again, the stale
-- interval would silently resurrect and mis-schedule the new blank.
--
-- This deletes review history rows, so STEP 1 shows exactly what will go before
-- STEP 2 removes it. Run step 1, read the list, then run step 2.
-- Scoped to every user, not just the founder's account. Idempotent.

-- ── STEP 1: preview. Expect 16 rows on the founder's account today. ──────────
SELECT
  s.user_id,
  s.flashcard_id,
  s.cloze_index,
  f.cloze_count        AS card_now_has,
  f.card_type,
  s.reps,
  s.interval_days,
  LEFT(f.cloze_text, 60) AS card_preview
FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE (f.card_type = 'cloze'  AND (s.cloze_index < 1 OR s.cloze_index > GREATEST(COALESCE(f.cloze_count, 1), 1)))
   OR (f.card_type <> 'cloze' AND s.cloze_index <> 0)
ORDER BY s.flashcard_id, s.cloze_index;

-- Also surface any state row whose card was deleted outright (expect 0).
SELECT s.user_id, s.flashcard_id, s.cloze_index
FROM public.flashcard_user_state s
LEFT JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE f.id IS NULL;

-- ── STEP 2: delete the orphans. ─────────────────────────────────────────────
DELETE FROM public.flashcard_user_state s
USING public.flashcards f
WHERE f.id = s.flashcard_id
  AND ((f.card_type = 'cloze'  AND (s.cloze_index < 1 OR s.cloze_index > GREATEST(COALESCE(f.cloze_count, 1), 1)))
    OR (f.card_type <> 'cloze' AND s.cloze_index <> 0));

DELETE FROM public.flashcard_user_state s
WHERE NOT EXISTS (SELECT 1 FROM public.flashcards f WHERE f.id = s.flashcard_id);

-- ── Verification: expect 0 rows. ────────────────────────────────────────────
SELECT COUNT(*) AS orphans_remaining
FROM public.flashcard_user_state s
LEFT JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE f.id IS NULL
   OR (f.card_type = 'cloze'  AND (s.cloze_index < 1 OR s.cloze_index > GREATEST(COALESCE(f.cloze_count, 1), 1)))
   OR (f.card_type <> 'cloze' AND s.cloze_index <> 0);

-- ── STANDING RULE for future card edits ─────────────────────────────────────
-- Raising cloze_count is always safe: the new blank simply enters as unseen.
-- LOWERING cloze_count (or merging groups) MUST be followed by the STEP 2
-- delete in the same script, or it orphans a scheduling row and the headline
-- counts drift apart again.
