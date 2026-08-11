-- Fix: the nucleophilic-addition first-step card (OrgChem Ch6 Aldehydes & Ketones)
-- lost its reaction context in the earlier cloze-tightening pass; it now opens
-- "In the first step, the ..." with no hint of WHICH reaction. Founder request:
-- name the reaction. Restoring context also forces one blank re-scope: with the
-- reaction named in plain words, blanking "nucleophile" would answer itself, so
-- c1 moves to the alkoxide intermediate (the third real fact of the step).
-- SRS-safe: same card id, still three cloze groups c1/c2/c3, cloze_count stays 3.
-- Facts tested: attack lands on the carbonyl CARBON (c2), electrons land on the
-- OXYGEN (c3), the resulting intermediate is an ALKOXIDE (c1). Idempotent.

UPDATE public.flashcards
SET cloze_text = $prax$When a nucleophile adds to an aldehyde or ketone, it attacks the {{c2::carbonyl carbon}} first, pushing the π electrons up onto the {{c3::oxygen}} to form an {{c1::alkoxide}} intermediate.$prax$
WHERE id = 'c5fd0e99-38da-4c0d-9344-af4fc4e06afc'
  AND cloze_text LIKE '%alkoxide intermediate%';

-- Verification: expect 1 row, opening "When a nucleophile adds to an aldehyde or ketone".
SELECT id, cloze_text, cloze_count
FROM public.flashcards
WHERE id = 'c5fd0e99-38da-4c0d-9344-af4fc4e06afc';
