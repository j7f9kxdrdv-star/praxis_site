-- Fix broken isotopic-notation flashcard (GenChem atomic structure).
-- Old text embedded a lone superscript-A glyph "ᴬZX" (U+1D2C + "ZX") AND set it as a
-- fill-in blank. Plain-unicode flashcards can't stack a mass number over an atomic
-- number (and there's no subscript capital Z), so it rendered as a floating "ᴬZX".
-- Rewrite to describe the positions in words (both numbers sit on the LEFT of the
-- symbol: A upper-left, Z lower-left). Drops the impossible glyph; 3 clozes -> 2.
-- UPDATE in place so SRS history is preserved.
UPDATE public.flashcards
SET cloze_text = 'In isotopic notation, the {{c1::mass number (A)}} sits at the upper-left of the element symbol and the {{c2::atomic number (Z)}} at the lower-left.',
    cloze_count = 2
WHERE id = '6d90402f-1053-4b92-806f-214ea05d8144';
