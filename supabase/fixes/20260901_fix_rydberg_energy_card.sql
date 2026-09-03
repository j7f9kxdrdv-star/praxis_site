-- ============================================================
-- Rydberg energy card: match the notation its own sibling already uses
--
-- Spotted by Mikko while studying: nᵢ renders as a proper subscript and nf does
-- not, so the pair looks like a typo.
--
--   {{c2::E = Rₕ(1/nᵢ² − 1/nf²)}}, where nᵢ and nf are ...
--
-- It is not a typo, it is impossible. Unicode provides subscript forms for only
-- a e h i j k l m n o p r s t u v x. There is no subscript f, so n subscript f
-- cannot be written at all, and the card was left half-converted.
--
-- The WAVELENGTH version of the same formula, two cards away in this deck,
-- already solves it with subscript digits:
--
--   1/λ = Rₕ(1/n₁² − 1/n₂²), with n₁ < n₂
--
-- Subscript digits do exist, so this card now matches, and the sentence after
-- it says which is initial and which is final. Group set and blank count are
-- unchanged.
-- ============================================================

UPDATE public.flashcards SET cloze_text =
'The {{c1::Rydberg formula for energy}} predicts the photon energy of a hydrogen electron transition: {{c2::E = Rₕ(1/n₁² − 1/n₂²)}}, where n₁ and n₂ are the initial and final principal quantum numbers.'
WHERE id = 'eaeccf84-c20f-4c79-b5d8-22be958dfd79';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_text,
  cloze_text LIKE '%n₁%' AND cloze_text LIKE '%n₂%' AS uses_subscript_digits,
  cloze_text LIKE '%nf%' AS still_has_flat_nf,
  cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text
FROM public.flashcards WHERE id = 'eaeccf84-c20f-4c79-b5d8-22be958dfd79';
