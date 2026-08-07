-- Fix: flashcards that use an abbreviation the card never expands.
--
-- Mikko flagged the ACC card while studying: "I think ACC needs its full term."
-- He is right, and the cause is structural. In the seed file the card immediately before it
-- introduces "Acetyl-CoA carboxylase (ACC)", and this card reuses the short form. That reads fine
-- top to bottom, but spaced repetition shuffles cards across all 75 decks, so a card is ALWAYS
-- seen in isolation, often weeks away from its neighbour. Every card must therefore stand alone.
--
-- I scanned all 4,178 cloze cards for the same defect. Most capitalised tokens are fine and are
-- left alone: chemical formulas (CO2, COOH), mnemonics where the acronym IS the content (OIL RIG,
-- SOH CAH TOA, OCEAN, FINER), formula variables defined by their own equation (SG, IQR, MA),
-- gene names (SRY, TP53, HTT), codons (AUG, UAA, TATA), and abbreviations already expanded on the
-- same card (HOMO, LUMO, LCAT, SCOT, VSEPR, ACE, THC). LGN, JND and CAM are each defined elsewhere
-- within their own deck and are standard MCAT vocabulary, so they are also left alone.
--
-- Six cards genuinely fail: five use a bare enzyme abbreviation as the subject of the sentence,
-- and EMF is used nine times in the electrochemistry deck without ever being expanded there.
--
-- SRS SAFE: every statement is a targeted string replacement on existing rows. No flashcard id is
-- minted or deleted, and no cloze_count changes, so all review history and scheduling survive.
-- Replacement (rather than assigning full new text) also makes these robust to the em-dash removal
-- already applied to the live database, which the seed files do not reflect.
-- Idempotent: re-running is harmless, since each WHERE no longer matches once applied.

BEGIN;

-- 1. Acetyl-CoA carboxylase (the card Mikko flagged)
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'ACC is activated by', 'Acetyl-CoA carboxylase (ACC) is activated by')
 WHERE cloze_text LIKE 'ACC is activated by%';

-- 2. Hormone-sensitive lipase, Biochem Ch11
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'HSL is activated by falling', 'Hormone-sensitive lipase (HSL) is activated by falling')
 WHERE cloze_text LIKE 'HSL is activated by falling%';

-- 3. Hormone-sensitive lipase, Biochem Ch12 (abbreviation not reused on this card, so spell it out)
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'in fasting, HSL activates', 'in fasting, hormone-sensitive lipase activates')
 WHERE cloze_text LIKE '%in fasting, HSL activates%';

-- 4. Phosphoenolpyruvate carboxykinase, Biochem Ch9
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'PEPCK converts oxaloacetate', 'PEPCK (phosphoenolpyruvate carboxykinase) converts oxaloacetate')
 WHERE cloze_text LIKE 'PEPCK converts oxaloacetate%';

-- 5. Cholesteryl ester transfer protein, Biochem Ch11
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'the enzyme CETP', 'cholesteryl ester transfer protein (CETP)')
 WHERE cloze_text LIKE '%the enzyme CETP%';

-- 6. Electromotive force, GenChem Ch12. Expanded once, on the definitional card.
UPDATE public.flashcards
   SET cloze_text = REPLACE(cloze_text, 'The standard cell EMF is', 'The standard cell EMF (electromotive force) is')
 WHERE cloze_text LIKE 'The standard cell EMF is%';

COMMIT;

-- Verification: expect 6 rows, each now carrying the expanded term.
SELECT id, cloze_count, LEFT(cloze_text, 95) AS card
  FROM public.flashcards
 WHERE cloze_text LIKE 'Acetyl-CoA carboxylase (ACC) is activated by%'
    OR cloze_text LIKE 'Hormone-sensitive lipase (HSL) is activated by%'
    OR cloze_text LIKE '%in fasting, hormone-sensitive lipase activates%'
    OR cloze_text LIKE 'PEPCK (phosphoenolpyruvate carboxykinase)%'
    OR cloze_text LIKE '%cholesteryl ester transfer protein (CETP)%'
    OR cloze_text LIKE 'The standard cell EMF (electromotive force)%'
 ORDER BY id;
