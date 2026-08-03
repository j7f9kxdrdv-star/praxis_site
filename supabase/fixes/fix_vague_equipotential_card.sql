-- Fix: vague/circular equipotential flashcard (deck: Electrostatics and Magnetism)
-- Old: "Every point on an {{c1::equipotential}} line sits at the same {{c1::electric potential}}."
--   → circular (the word "equipotential" telegraphs the blank) and redundant with 3 sibling
--     cards already covering perpendicular-field, zero-work-along-line, and path-independence.
-- New: tests the field-strength ↔ equipotential-spacing relationship (high-yield, not otherwise
--     covered in the deck). UPDATE in place so SRS progress on this card is preserved.
UPDATE public.flashcards
SET cloze_text = 'Equipotential lines are spaced {{c1::closer together}} where the electric field is stronger.',
    cloze_count = 1
WHERE id = '46e23831-6783-4e09-9d28-74258a9dd54f';
