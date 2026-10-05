-- ─── Migration 8b: one scientific wording correction ──────────────────────
-- REQUIRES: 20261006_01_card_too_broad_repairs.sql
-- because it rewrites the card and the concept that migration 8 created.
--
-- Migration 8 contained an internal contradiction, and the report that
-- described it is what makes the contradiction visible.
--
-- The card said all structural proteins "owe their strength to highly
-- repetitive secondary structure". The same report then declined elastin a
-- SECONDARY mapping on the grounds that elastin is precisely the one of the
-- three whose strength does NOT come from repetitive secondary structure: it
-- is cross-linked and comparatively amorphous, and its usefulness is recoil
-- rather than tensile strength.
--
-- Both cannot be true. The mapping decision was right and the wording was
-- wrong: collagen has its repetitive Gly-X-Y triple helix and keratin its
-- coiled coil, but elastin does not share that mechanism, and a card naming
-- all three while asserting one mechanism teaches a false generalisation.
--
-- WHAT CHANGES: the card text, and the concept description, which carried the
-- same overgeneralisation in its first sentence. Nothing else.
--
-- WHAT DOES NOT CHANGE: the elastin decision stands, with no SECONDARY mapping.
-- Correcting the wording removes the contradiction by fixing the claim, not by
-- widening the class to cover it.
--
-- The card keeps its id, its cloze_count and both cloze identities: c1 is the
-- class, c2 is keratin. The scheduler state and all 15 reviews therefore stay
-- attached to prompts that mean what they meant, which is the same standard
-- migration 8 was written to.

BEGIN;

DO $$
DECLARE t TEXT; n INT;
BEGIN
  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '4d56a412-90d2-47cb-b0d8-db3a3a06f232';
  IF t IS NULL THEN RAISE EXCEPTION 'FIX: the structural-proteins card is missing'; END IF;
  IF position('owe their strength to highly repetitive secondary structure' IN t) = 0 THEN
    RAISE EXCEPTION 'FIX: the card is not the text migration 8 left; refusing to overwrite';
  END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE slug = 'STRUCTURAL_PROTEINS' AND status = 'ACTIVE_SEED' AND object_type = 'CONTENT';
  IF n <> 1 THEN RAISE EXCEPTION 'FIX: Structural Proteins is not a live CONTENT concept'; END IF;

  -- Elastin must already be absent from the class, which is the decision this
  -- correction is protecting rather than revisiting.
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id
   WHERE fc.flashcard_id = 'd660225e-9617-4ee1-b7b0-d3d74ff80ba4' AND c.slug = 'STRUCTURAL_PROTEINS';
  IF n <> 0 THEN RAISE EXCEPTION 'FIX: elastin already carries a Structural Proteins mapping'; END IF;
END $$;

UPDATE public.flashcards
   SET cloze_text = $c${{c1::Structural proteins}} such as collagen, elastin and {{c2::keratin}} provide tissues with mechanical support through specialized fibrous architecture and cross-linking.$c$
 WHERE id = '4d56a412-90d2-47cb-b0d8-db3a3a06f232' AND cloze_count = 2;

UPDATE public.concepts
   SET description = $d$The protein class that gives tissues mechanical support through specialised fibrous architecture and cross-linking, rather than through catalysis, transport or signalling. The molecular mechanism differs by protein: collagen a repetitive Gly-X-Y triple helix, keratin a coiled coil, elastin a cross-linked network that recoils. The individual proteins keep their own concepts, collagen and elastin under connective tissue and keratin under intermediate filaments; this one holds the class identity, not their particulars.$d$,
       updated_at = now()
 WHERE slug = 'STRUCTURAL_PROTEINS';

DO $$
DECLARE t TEXT; d TEXT; n INT;
BEGIN
  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '4d56a412-90d2-47cb-b0d8-db3a3a06f232';
  IF position('mechanical support through specialized fibrous architecture' IN t) = 0 THEN
    RAISE EXCEPTION 'FIX: the card rewrite did not land';
  END IF;
  IF position('repetitive secondary structure' IN t) <> 0 THEN
    RAISE EXCEPTION 'FIX: the overgeneralisation survives in the card';
  END IF;
  IF position('{{c1::Structural proteins}}' IN t) = 0 OR position('{{c2::keratin}}' IN t) = 0 THEN
    RAISE EXCEPTION 'FIX: a cloze identity changed';
  END IF;
  SELECT cloze_count INTO n FROM public.flashcards WHERE id = '4d56a412-90d2-47cb-b0d8-db3a3a06f232';
  IF n <> 2 THEN RAISE EXCEPTION 'FIX: cloze_count changed to %', n; END IF;

  SELECT description INTO d FROM public.concepts WHERE slug = 'STRUCTURAL_PROTEINS';
  IF position('mechanism differs by protein' IN d) = 0 THEN
    RAISE EXCEPTION 'FIX: the definition must say the mechanism differs';
  END IF;
  IF position('whose strength comes from highly repetitive secondary structure' IN d) <> 0 THEN
    RAISE EXCEPTION 'FIX: the overgeneralisation survives in the definition';
  END IF;
  -- The definition must name all three and the mechanism each actually uses.
  IF position('collagen' IN d) = 0 OR position('keratin' IN d) = 0 OR position('elastin' IN d) = 0 THEN
    RAISE EXCEPTION 'FIX: the definition must name all three examples';
  END IF;

  -- Everything the correction must not touch.
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id WHERE c.slug = 'STRUCTURAL_PROTEINS';
  IF n <> 3 THEN RAISE EXCEPTION 'FIX: Structural Proteins should hold 3 mappings, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id
   WHERE c.slug = 'STRUCTURAL_PROTEINS' AND fc.role = 'SECONDARY';
  IF n <> 2 THEN RAISE EXCEPTION 'FIX: expected 2 secondaries, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id
   WHERE fc.flashcard_id = 'd660225e-9617-4ee1-b7b0-d3d74ff80ba4' AND c.slug = 'STRUCTURAL_PROTEINS';
  IF n <> 0 THEN RAISE EXCEPTION 'FIX: elastin gained a mapping'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = 'd660225e-9617-4ee1-b7b0-d3d74ff80ba4';
  IF n <> 1 THEN RAISE EXCEPTION 'FIX: elastin mapping count changed to %', n; END IF;

  SELECT version INTO n FROM public.concepts WHERE slug = 'STRUCTURAL_PROTEINS';
  IF n <> 1 THEN RAISE EXCEPTION 'FIX: concept version moved to %', n; END IF;
  SELECT count(*) INTO n FROM public.concept_sections cs JOIN public.concepts c ON c.id = cs.concept_id
   WHERE c.slug = 'STRUCTURAL_PROTEINS';
  IF n <> 1 THEN RAISE EXCEPTION 'FIX: taxonomy changed'; END IF;

  SELECT count(*) INTO n FROM public.flashcards;
  IF n <> 4118 THEN RAISE EXCEPTION 'FIX: flashcards is %, expected 4118', n; END IF;
  SELECT count(DISTINCT flashcard_id) INTO n FROM public.flashcard_concepts;
  IF n <> 4118 THEN RAISE EXCEPTION 'FIX: unique mapped cards is %, expected 4118', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4121 THEN RAISE EXCEPTION 'FIX: mapping rows is %, expected 4121', n; END IF;
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> 1139 THEN RAISE EXCEPTION 'FIX: concepts is %, expected 1139', n; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') z;
  IF n <> 29 THEN RAISE EXCEPTION 'FIX: NEEDS_REVIEW is %, expected 29', n; END IF;

  RAISE NOTICE 'FIX OK: card and definition corrected, elastin still excluded, 4,118 of 4,118 cards mapped.';
END $$;

COMMIT;
