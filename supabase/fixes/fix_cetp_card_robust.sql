-- Fix: the one remaining bare-abbreviation card, CETP.
--
-- The earlier batch matched on 'the enzyme CETP', which is what the SEED file says. The live text
-- differs (the seed files and the database have drifted apart, since sweeps like the em-dash removal
-- were applied to the database but never written back). That statement therefore matched 0 rows
-- while the other five succeeded.
--
-- This version does not depend on the surrounding wording at all. It expands CETP wherever it
-- appears, and the NOT LIKE guard skips any card that already carries the full term, so the sibling
-- card reading '{{c1::CETP (cholesteryl ester transfer protein)}}' is left untouched and nothing can
-- be double-expanded. Safe to re-run.
--
-- SRS SAFE: text-only edit on existing rows. No id minted or deleted, no cloze_count change.

BEGIN;

UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'CETP', 'cholesteryl ester transfer protein (CETP)')
 WHERE cloze_text LIKE '%CETP%'
   AND cloze_text NOT LIKE '%cholesteryl ester transfer protein%';

COMMIT;

-- Verification: expect every CETP card to now carry the full term.
SELECT id, cloze_count, cloze_text
  FROM public.flashcards
 WHERE cloze_text LIKE '%CETP%'
 ORDER BY id;
