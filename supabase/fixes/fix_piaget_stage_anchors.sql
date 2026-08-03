-- Anchor Piaget's four stage-intro flashcards to the process they belong to
-- ("of cognitive development"). Each card said "Piaget's Nth stage, the X stage"
-- without naming what the stages are stages OF — so on its own (spaced
-- repetition shows cards out of order) it floated. Added as context, not a
-- blank; the two clozes per card are unchanged. UPDATE in place → SRS preserved.

UPDATE public.flashcards
SET cloze_text = 'Piaget''s first stage of cognitive development, the {{c1::sensorimotor}} stage, lasts from birth to about {{c1::age 2}}.'
WHERE id = 'bf3ec05b-e3a0-4ba1-8d6b-38d3ee512118';

UPDATE public.flashcards
SET cloze_text = 'Piaget''s second stage of cognitive development, the {{c1::preoperational}} stage, spans roughly ages {{c1::2 to 7}}.'
WHERE id = '14d51cb5-68fd-44e2-b3c3-bd2dfa42a364';

UPDATE public.flashcards
SET cloze_text = 'Piaget''s third stage of cognitive development, the {{c1::concrete operational}} stage, runs from about ages {{c1::7 to 11}}.'
WHERE id = '7f83347d-9ad3-4fdd-95ed-59875c675df2';

UPDATE public.flashcards
SET cloze_text = 'Piaget''s fourth stage of cognitive development, the {{c1::formal operational}} stage, begins around {{c1::age 11}} and continues into adulthood.'
WHERE id = '470dd80a-05fc-4fc2-be46-101a2d00bed9';
