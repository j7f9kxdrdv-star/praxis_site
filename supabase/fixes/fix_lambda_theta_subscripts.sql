-- Fix: the two remaining underscore-subscript cards, found by a properly broad hunt after Mikko
-- flagged λ_max (the earlier hunt's character class covered ρ/v/P/T/V/K but not Greek λ or θ).
--
-- 1. OrgChem Ch11 Spectroscopy, three cards: "λ_max" rendered literally. Unicode has subscript
--    m/a/x, so the honest plain-text form is λₘₐₓ, matching the deck's existing Unicode-subscript
--    convention (n₁, n₂, Rₕ).
-- 2. Physics Ch8 Optics, one card: "sin θ_c = n₂/n₁". Unicode has NO subscript c, and the visible
--    text already names "the critical angle", so the symbol drops its redundant subscript:
--    "the critical angle θ obeys sin θ = n₂/n₁".
--
-- SRS SAFE: text-only REPLACEs, cloze groups and counts unchanged. Idempotent.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'λ_max', 'λₘₐₓ')
 WHERE cloze_text LIKE '%λ_max%';

UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text,
       'the critical angle obeys {{c1::sin θ_c = n₂/n₁}}',
       'the critical angle θ obeys {{c1::sin θ = n₂/n₁}}')
 WHERE cloze_text LIKE '%sin θ_c%';

COMMIT;

-- Verification: expect 3 rows then 1 row.
SELECT COUNT(*) AS lambda_cards FROM public.flashcards WHERE cloze_text LIKE '%λₘₐₓ%';
SELECT COUNT(*) AS theta_cards  FROM public.flashcards WHERE cloze_text LIKE '%critical angle θ obeys%';
