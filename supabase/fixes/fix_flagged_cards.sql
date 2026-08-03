-- Manually flagged flashcard fixes (self-giveaway / vague cards).
-- All UPDATE in place → SRS progress preserved. Idempotent (safe to re-run).

-- 1) Vague/circular: "equipotential ... same electric potential" restated the definition
--    with itself, and 3 sibling cards already cover the useful consequences.
--    → repoint at the field-strength ↔ spacing relationship (not otherwise in the deck).
UPDATE public.flashcards
SET cloze_text = 'Equipotential lines are spaced {{c1::closer together}} where the electric field is stronger.',
    cloze_count = 1
WHERE id = '46e23831-6783-4e09-9d28-74258a9dd54f';

-- 2) Answer giveaway: "positive ΔH (ΔH > 0)" — the parenthetical restates the blanked
--    answer ("positive") in symbols. Drop it; the card still tests both real facts.
UPDATE public.flashcards
SET cloze_text = 'An endothermic process {{c1::absorbs}} heat and has a {{c2::positive}} ΔH.',
    cloze_count = 2
WHERE id = '2fcdeb91-cbc0-4557-88f7-0e21d96ec219';
