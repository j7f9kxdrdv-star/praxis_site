-- ============================================================
-- G protein notation: restore the subscripts that exist
--
-- Spotted by Mikko while studying: Gs and Gi should carry subscripts.
--
-- The card wrote them flat while the same deck writes PIP₂ and IP₃ with proper
-- subscripts, so this is an inconsistency within the content rather than a
-- deliberate house style.
--
-- A LIMIT WORTH RECORDING. Unicode has subscript forms for only a subset of
-- the Latin alphabet: a e h i j k l m n o p r s t u v x. There is no subscript
-- q, b, c, d, f, g, w, y or z. So Gₛ and Gᵢ can be written correctly and Gq
-- CANNOT, and the two Gq cards in the bank are deliberately left flat. Writing
-- G_q with an underscore would render as literal punctuation, and flashcards
-- take plain Unicode with no LaTeX, so there is no third option.
--
-- Gq is universally written flat in print anyway, which is why it reads fine
-- and fT did not: fT sat inside an equation where juxtaposition means
-- multiplication.
--
-- A SEPARATE ISSUE ON THIS CARD, NOT FIXED HERE. Gs is group c1 and Gi is c3,
-- so asking for one displays the other. Since the card is built on exactly that
-- stimulate-versus-inhibit contrast, seeing Gi narrows Gs to a near-certainty.
-- Closing it means merging c1 and c3, which changes the group set from {1,2,3}
-- to {1,2} and orphans a scheduling row. That is a judgement call about whether
-- the contrast is worth the progress, so it is flagged rather than made.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'{{c1::Gₛ}} stimulates {{c2::adenylyl cyclase}}, raising intracellular cAMP. {{c3::Gᵢ}} inhibits {{c2::adenylyl cyclase}}, lowering intracellular cAMP.'
WHERE id = 'c1166522-1c01-44d7-b165-207b2f6e96d2';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect the two subscript characters present and the group set unchanged.
SELECT cloze_text,
  cloze_text LIKE '%Gₛ%' AS has_g_sub_s,
  cloze_text LIKE '%Gᵢ%' AS has_g_sub_i,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text
FROM public.flashcards WHERE id = 'c1166522-1c01-44d7-b165-207b2f6e96d2';
