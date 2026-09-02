-- ============================================================
-- Work function card: restore the lost subscript
--
-- Spotted by Mikko while studying, who asked whether the T was meant to be a
-- subscript on f. It was.
--
--   {{c1::W = h · fT}}
--
-- Inside a formula, juxtaposition means multiplication, so "h · fT" reads as h
-- times f times T. The intended quantity is f subscript T, the threshold
-- frequency, and the subscript was lost somewhere before this reached the
-- database. Flashcards render plain Unicode with no LaTeX, so the fix is the
-- real subscript character.
--
-- The bank is inconsistent about this rather than uniformly plain: 269 cards
-- already carry proper Unicode subscripts while 43 write the same kinds of
-- quantity flat (Vmax, Km, Ka, Ksp, Zeff, kcat). Most of those read fine,
-- because they are established shorthand a student meets that way in print.
-- This one does not, because it sits inside an equation where the flat form
-- means something different and wrong.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'The work function relates to the threshold frequency by {{c1::W = h · fₜ}} (Planck''s constant times the threshold frequency).'
WHERE id = 'a815b72c-de2f-4ac5-88c6-dcc24a01735f';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'a815b72c-de2f-4ac5-88c6-dcc24a01735f';

-- The other flat-notation cards, for a later consistency pass. Listed rather
-- than rewritten: most are fine as they stand, and deciding which need a
-- subscript is a judgement about how each one reads.
SELECT COUNT(*) AS flat_notation_cards
FROM public.flashcards
WHERE cloze_text ~ '\m(Vmax|Km|Ka|Kb|Kw|Ksp|Zeff|kcat|vrms)\M';
