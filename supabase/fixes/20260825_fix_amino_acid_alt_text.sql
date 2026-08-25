-- ============================================================
-- V3 PR5 part B.1 — the amino acid alt-text leak
--
-- THE DEFECT. All 20 cards in the Amino Acids deck that carry a structure
-- image were authored from one template:
--
--     {{c1::Glycine}}, {{c1::Gly}}, {{c1::G}}
--     <img src=".../glycine.png" alt="Glycine structure">
--
-- The three blanks share group c1, so they mask together correctly and the
-- card works as intended: see the structure, name the amino acid. But the
-- IMAGE ALT TEXT spells the answer out. Alt text is not decoration. It is
-- read aloud by screen readers, and it is what the browser displays in place
-- of the picture whenever the image fails to load. In both cases the student
-- is shown the answer to the question they are being asked.
--
-- THE FIX. Replace the alt text with a generic description that still says
-- what the image IS without saying which one it is. These are visual
-- identification cards, so a non-visual student cannot answer them from alt
-- text regardless; the previous alt only "helped" by giving the answer away.
--
-- The src filename (.../glycine.png) is left alone deliberately. It is only
-- readable in devtools, browsers substitute alt text rather than the URL on a
-- broken image, and renaming 20 live asset files to hide it would trade a
-- non-leak for a real risk of broken images.
--
-- UPDATE by id, per the live-deck rule. Card ids stay stable, so cloze groups
-- stay attached to their scheduling rows and no review history moves.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = regexp_replace(cloze_text, 'alt="[^"]*"', 'alt="Amino acid structure"')
WHERE id IN (
  '205b5268-9f18-499e-bb5f-62dc0eaac552',  -- Glycine
  '276aee79-2e40-4fd8-a08b-d05d00c209f2',  -- Tyrosine
  '2b9ffe55-3845-4dc1-914f-ade50077265e',  -- Aspartate
  '302272dd-0eff-4898-add3-b57a7f0d2b04',  -- Cysteine
  '305d2abf-1ad7-48aa-a27c-2dc7160124d7',  -- Methionine
  '33261743-c9c1-4d66-b137-c159a08c4772',  -- Phenylalanine
  '4dd80918-99a1-436b-b908-0db7c4d9fc29',  -- Glutamine
  '5da8efd6-2c04-4a74-b6bf-e0b6b5b89d71',  -- Tryptophan
  '74772ce2-062e-4454-831c-4d67c00a46c9',  -- Leucine
  '7c09f351-94db-4dc3-aa23-eb65f8aef76c',  -- Arginine
  '84001854-6c71-45be-8805-79d0df949bca',  -- Lysine
  '8e8ec0bb-aa2c-4a9c-a119-b29bd877fac6',  -- Asparagine
  '9bac7565-f9fb-4e67-9ad5-c2ba2396a78b',  -- Histidine
  '9d5a2496-3b31-4f3c-85a6-3ef2384e6eeb',  -- Alanine
  'a029228d-86bb-4c21-be81-3430c4d84be0',  -- Valine
  'a7c5ea00-fa87-4a6f-9fb4-67b570fd1ef8',  -- Serine
  'b22cf8be-3dcd-455a-8a28-d2eeac4cfefa',  -- Threonine
  'b250bb89-2a52-4b38-9da5-34d17c5da33e',  -- Proline
  'b626244e-4686-4831-b771-1e8d404e44df',  -- Isoleucine
  'e6ac7a68-5615-4afa-bc1a-4a9b2f7b35ae'   -- Glutamate
);

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 20 rows, every alt reading "Amino acid structure", and the visible
-- cloze text and image src unchanged.
SELECT
  substring(cloze_text from 'alt="([^"]*)"')          AS alt_now,
  COUNT(*)                                            AS cards
FROM public.flashcards
WHERE cloze_text LIKE '%<img%'
GROUP BY 1
ORDER BY 2 DESC;

-- No card anywhere should still name one of its own answers in its alt text.
-- Expect zero rows.
SELECT id, substring(cloze_text from 'alt="([^"]*)"') AS alt_now, cloze_text
FROM public.flashcards
WHERE cloze_text LIKE '%<img%'
  AND substring(cloze_text from 'alt="([^"]*)"') !~* '^(Amino acid structure)$';
