-- ============================================================
-- Abbreviations that are TRUNCATIONS, not initialisms
--
-- Mikko caught the methionine card: the blank is "Methionine" and the stem
-- prints "(Met, M)" immediately after it, the standard three-letter and
-- one-letter codes.
--
-- The acronym detector could not see this. It knew two shapes, an answer built
-- from initials ("HOMO" from "Highest Occupied Molecular Orbital") and an
-- answer whose initials appear in the stem. "Met" is neither: it is the first
-- three letters of a single-word answer. A third rule now covers truncations,
-- guarded so ordinary prose cannot trip it. The stem token must look like an
-- abbreviation, must be a strict prefix of a materially longer answer, and
-- must not be an English word in its own right.
--
-- That rule added exactly two cards to the detector's output and both are real,
-- which is the precision these detectors need to be worth running unread.
--
-- Verified before writing: wording unchanged, groups contiguous from 1, no
-- malformed or jammed blanks.
-- ============================================================

BEGIN;

-- Amino Acids: the stem printed "(Met, M)", the standard three-letter and one-letter codes
--   now: {{c1::Methionine}} ({{c1::Met, M}}) is the universal {{c2::translation start codon AUG}} amino acid. Every nascent eukaryotic polypeptide begins with 
UPDATE public.flashcards SET cloze_text = '{{c1::Methionine}} ({{c1::Met, M}}) is the universal {{c2::translation start codon AUG}} amino acid. Every nascent eukaryotic polypeptide begins with {{c1::methionine}} on its {{c3::N-terminus}} (sometimes cleaved post-translationally).', cloze_count = 3 WHERE id = '521cc80a-5d89-4cee-8fee-731a5b9b98e8';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '521cc80a-5d89-4cee-8fee-731a5b9b98e8';

-- Nonenzymatic Protein Function and Protein Analysis: "they hydrolyze ATP" in the next clause hands over the answer "ATPase"
--   now: {{c1::Motor proteins}} are enzymes with {{c2::ATPase}} activity; they hydrolyze {{c2::ATP}} to produce the conformational change that generates mechan
UPDATE public.flashcards SET cloze_text = '{{c1::Motor proteins}} are enzymes with {{c2::ATPase}} activity; they hydrolyze {{c2::ATP}} to produce the conformational change that generates mechanical force along actin or microtubules.', cloze_count = 2 WHERE id = 'c0e15647-de45-4991-a71b-25df5593b682';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'c0e15647-de45-4991-a71b-25df5593b682';

COMMIT;

-- Verification. Expect 0.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS mm) AS n
  FROM public.flashcards WHERE id IN ('521cc80a-5d89-4cee-8fee-731a5b9b98e8','c0e15647-de45-4991-a71b-25df5593b682')
) t WHERE n <> cloze_count;
