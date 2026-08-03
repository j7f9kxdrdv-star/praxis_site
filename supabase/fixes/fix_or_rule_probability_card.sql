-- Split the confusing OR-rule flashcard (deck: Data-Based and Statistical Reasoning).
--
-- The old card fused TWO unrelated rules into one review:
--   "OR rule: P(A OR B) = {{c1::P(A) + P(B) - P(A AND B)}}; for the "at least one" question,
--    use the shortcut P(at least one) = {{c2::1 - P(none)}}."
-- The addition rule and the complement shortcut have different trigger conditions, so the card
-- had no clean cue, and its first blank was a bare formula to reproduce with no hint of WHY the
-- overlap is subtracted. Neighbouring card 22 ("AND rule ... P(A) x P(B)") shows the house style:
-- one rule, one card.
--
-- Card 1 (replaces the original, keeping its SRS history) now carries the reasoning: you subtract
-- the overlap because those outcomes were counted twice.
-- Card 2 (new) owns the "at least one" shortcut, cued by the phrasing that triggers it.

UPDATE public.flashcards
SET cloze_text = 'OR rule: to get P(A OR B), add P(A) and P(B), then subtract {{c1::P(A AND B)}}, since outcomes in both events were {{c2::counted twice}}.',
    cloze_count = 2
WHERE id = '841506f5-786c-40a1-8425-2b70cde17eb6';

INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
SELECT 'd17efe8d-3fb1-4e12-b318-a41c742f464c',
       'cloze',
       'When a question asks for the probability of "at least one", compute {{c1::1 - P(none)}} instead of summing every case.',
       1,
       (SELECT COALESCE(MAX(position), 0) + 1
        FROM public.flashcards
        WHERE deck_id = 'd17efe8d-3fb1-4e12-b318-a41c742f464c')
WHERE NOT EXISTS (
  SELECT 1 FROM public.flashcards
  WHERE deck_id = 'd17efe8d-3fb1-4e12-b318-a41c742f464c'
    AND cloze_text LIKE '%instead of summing every case%'
);

-- Verification: expect TWO rows, the OR rule and the at-least-one shortcut, as separate cards.
SELECT position, cloze_count, cloze_text
FROM public.flashcards
WHERE deck_id = 'd17efe8d-3fb1-4e12-b318-a41c742f464c'
  AND (cloze_text LIKE '%OR rule%' OR cloze_text LIKE '%at least one%')
ORDER BY position;
