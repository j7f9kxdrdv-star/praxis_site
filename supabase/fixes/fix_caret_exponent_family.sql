-- Fix: caret-exponent family (16 spots across 4 decks + 1 deck description).
-- The flashcard renderer shows "^" literally, so e^(−λt), 2^n, X^(A+B) etc. read
-- as broken syntax. Where Unicode superscripts exist we use them (2ⁿ, mc², Xᴬ⁺ᴮ,
-- matching the math deck's existing ᴮ√ convention); the e^(...) exponentials have
-- no Unicode λ/Eₐ superscripts, so they become standard exp(...) function form.
-- SRS-safe: UPDATE-only token replacements, cloze groups and counts untouched.
-- Idempotent: every UPDATE is guarded by a LIKE on the broken token.

-- ── Physics Ch9: the flagged radioactive-decay card ─────────────────────────
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'e^(−λt)', 'exp(−λt)')
WHERE cloze_text LIKE '%e^(−λt)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '(½)^n', '(½)ⁿ')
WHERE cloze_text LIKE '%(½)^n%';

UPDATE public.flashcard_decks
SET description = REPLACE(description, 'E=mc^2', 'E=mc²')
WHERE description LIKE '%E=mc^2%';

-- ── GenChem Ch5 Kinetics: integrated rate law + Arrhenius ───────────────────
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '[A]₀e^(−kt)', '[A]₀ · exp(−kt)')
WHERE cloze_text LIKE '%[A]₀e^(−kt)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Ae^(−Eₐ/RT)', 'A · exp(−Eₐ/RT)')
WHERE cloze_text LIKE '%Ae^(−Eₐ/RT)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'e^(−Eₐ/RT)', 'exp(−Eₐ/RT)')
WHERE cloze_text LIKE '%e^(−Eₐ/RT)%';

-- ── Biochem Ch4: stereoisomer count ─────────────────────────────────────────
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '2^n', '2ⁿ')
WHERE cloze_text LIKE '%2^n%';

-- ── Scientific Reasoning Ch10: exponent-rule cards ──────────────────────────
-- Parenthesized compound exponents first, then bare X^A tokens.
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^(A+B)', 'Xᴬ⁺ᴮ')
WHERE cloze_text LIKE '%X^(A+B)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^(A−B)', 'Xᴬ⁻ᴮ')
WHERE cloze_text LIKE '%X^(A−B)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^(A·B)', 'Xᴬᴮ')
WHERE cloze_text LIKE '%X^(A·B)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^(−A)', 'X⁻ᴬ')
WHERE cloze_text LIKE '%X^(−A)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^(A/B)', 'X to the power A/B')
WHERE cloze_text LIKE '%X^(A/B)%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '(X/Y)^A', '(X/Y)ᴬ')
WHERE cloze_text LIKE '%(X/Y)^A%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^A', 'Xᴬ')
WHERE cloze_text LIKE '%X^A%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'X^B', 'Xᴮ')
WHERE cloze_text LIKE '%X^B%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, ')^B', ')ᴮ')
WHERE cloze_text LIKE '%)^B%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Y^A', 'Yᴬ')
WHERE cloze_text LIKE '%Y^A%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'A^B', 'Aᴮ')
WHERE cloze_text LIKE '%A^B%';

UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '× 10^exponent', '× a power of 10')
WHERE cloze_text LIKE '%× 10^exponent%';

-- ── Verification: list ANY remaining caret anywhere in the flashcard bank ───
-- Expect: 0 rows.
SELECT 'card' AS source, id::text, LEFT(COALESCE(cloze_text, front_text, back_text), 90) AS text
FROM public.flashcards
WHERE cloze_text LIKE '%^%' OR front_text LIKE '%^%'
   OR back_text LIKE '%^%' OR explanation LIKE '%^%'
UNION ALL
SELECT 'deck', id::text, LEFT(title || ': ' || description, 90)
FROM public.flashcard_decks
WHERE description LIKE '%^%';
