-- Fix the confusing skew / central-tendency card (Data-Based and Statistical Reasoning).
--
-- Old card asked the learner to reproduce BOTH inequality chains in a single blank group:
--   "In a positively skewed distribution, {{c1::mean > median > mode}}; in a negatively
--    skewed distribution, {{c1::mean < median < mode}}. The mean is always pulled toward
--    the {{c2::tail}}."
-- The two chains are visually near-identical (only the arrow direction differs), so recall
-- became symbol-matching with nothing to reason from — and the card already stated the
-- governing rule, making the chains derivable anyway.
--
-- Fix: split into two cards, ONE skew direction each, with the ordering written in WORDS
-- instead of > / < chains. The tail rule stays visible as the premise, so each answer is
-- reasoned (mean chases the tail; mode sits at the peak farthest from it; median between).

-- 1) Rewrite the existing card as the positive/right-skew case (SRS history preserved).
UPDATE public.flashcards
SET cloze_text = 'The mean is dragged toward the long tail. A right (positive) skew''s tail points to high values, so largest-to-smallest is {{c1::mean, median, mode}}.',
    cloze_count = 1
WHERE id = '75f7a84c-5d28-493b-b221-3088fef23866';

-- 2) Add the negative/left-skew counterpart as a new card in the same deck.
INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
SELECT 'd17efe8d-3fb1-4e12-b318-a41c742f464c',
       'cloze',
       'The mean is dragged toward the long tail. A left (negative) skew''s tail points to low values, so largest-to-smallest is {{c1::mode, median, mean}}.',
       1,
       43
WHERE NOT EXISTS (
  SELECT 1 FROM public.flashcards
  WHERE deck_id = 'd17efe8d-3fb1-4e12-b318-a41c742f464c'
    AND cloze_text LIKE '%left (negative) skew%largest-to-smallest%'
);

-- Verification: expect TWO rows — the right-skew card (mean, median, mode) and the
-- left-skew card (mode, median, mean), each with cloze_count = 1.
SELECT cloze_count, position, cloze_text
FROM public.flashcards
WHERE deck_id = 'd17efe8d-3fb1-4e12-b318-a41c742f464c'
  AND cloze_text LIKE '%largest-to-smallest%'
ORDER BY position;
