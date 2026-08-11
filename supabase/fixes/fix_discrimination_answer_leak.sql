-- Fix: the discrimination card (Psych/Soc Ch10 Social Thinking) blanks
-- "Discrimination" while the word appears twice more in the visible text, so the
-- card answers itself. The later mentions become pronouns; every blank keeps its
-- fact: c1 the term, c2 behavior (versus prejudice the attitude), c3 not-always.
-- SRS-safe: same card id, groups c1/c2/c3 preserved, cloze_count stays 3. Idempotent.

UPDATE public.flashcards
SET cloze_text = $prax${{c1::Discrimination}} is a {{c2::behavior}} treating individuals differently by group membership; prejudice does {{c3::not always}} lead to it, and it can occur without prejudice.$prax$
WHERE id = 'd3761687-c5e6-437e-8e74-c42ea1e37748'
  AND cloze_text LIKE '%group membership%';

-- Verification: expect 1 row; "discrimination" must appear ONLY inside the c1 blank.
SELECT id, cloze_text, cloze_count
FROM public.flashcards
WHERE id = 'd3761687-c5e6-437e-8e74-c42ea1e37748';
