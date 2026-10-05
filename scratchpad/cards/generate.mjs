import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/cards/pre_state.json", "utf8"));
const CYTO = s.cytoskeletonCard, STRUCT = s.structuralProteinsCard;
const CYTO_NEW = "In order of increasing diameter: {{c1::microfilaments}} of {{c2::actin}}, {{c1::intermediate filaments}} of {{c2::keratin-family proteins}}, and {{c1::microtubules}} of {{c2::tubulin}}.";
const STRUCT_NEW = "{{c1::Structural proteins}} such as collagen, elastin and {{c2::keratin}} owe their strength to highly repetitive secondary structure.";
const NEW_CARD = "Intermediate filaments are built from tissue-specific proteins including {{c1::keratin}}, {{c1::vimentin}}, {{c1::desmin}}, and the {{c1::lamins}}.";
const DEF_FC = "The three cytoskeletal filament classes compared: microfilaments, intermediate filaments and microtubules, their order by diameter, and the characteristic protein subunit of each. What each class DOES belongs to its own concept; this one is the comparison that tells them apart.";
const DEF_SP = "The protein class whose strength comes from highly repetitive secondary structure, and the shared structural role that follows from it. The individual proteins keep their own concepts: collagen and elastin under connective tissue, keratin under intermediate filaments. This one holds the class identity, not their particulars.";
const COLLAGEN = "ca5f08a7-3bc2-493b-8e82-dd2835e122f0", KERATIN = "328bd950-1833-4c3c-902c-a6a514ec322c";

const sql = `-- ─── Migration 8: the last two authoring repairs ──────────────────────────
-- REQUIRES: 20261005_03_chemical_family_vocabulary.sql
-- because it asserts the whole bank has exactly two unmapped cards, which is
-- only true once the earlier cleanup migrations have run.
--
-- The final migration in the ontology cleanup, and the only one that changes
-- flashcard TEXT rather than where evidence points.
--
-- TWO CARDS, EACH DEFINING A CLASS AND THEN LISTING EXAMPLES THAT BELONG TO
-- OTHER CONCEPTS. That is why they were left unmapped: neither resolves to one
-- learning target, and force-mapping either would have put a student who failed
-- it in front of the wrong cards.
--
-- WHY THE REWRITES LOOK CONSERVATIVE. Both cards are being studied. The
-- cytoskeleton card carries 24 reviews across two clozes and the structural
-- proteins card 15, and one of those clozes sits at stability 0.49, meaning
-- someone has been failing it repeatedly for weeks. Scheduler state is keyed to
-- (flashcard_id, cloze_index), so it survives a text edit regardless of whether
-- the text still asks the same thing. The only way to keep that history
-- MEANINGFUL is to keep each cloze index asking what it asked before:
--
--   cytoskeleton        c1 = the filament class names      c2 = their subunits
--   structural proteins c1 = the class                     c2 = keratin
--
-- So the wording is chosen to preserve the cloze semantics, not to be the
-- tidiest sentence. "keratin-family proteins" stays inside c2 for exactly this
-- reason: exposing it would make c2 materially easier than the prompt whose
-- history it inherits.
--
-- THE FACT EACH CARD LOSES becomes a new card where it is worth keeping. The
-- intermediate-filament protein family (keratin, vimentin, desmin, lamins) was
-- buried in the cytoskeleton card and is now its own card with its own fresh
-- state, mapped to the existing Cytoskeleton: Intermediate Filaments. It is a
-- NEW card, not a clone: no scheduler row, no reviews, no inherited stability.
--
-- TWO CONCEPTS, both re-audited live before writing this. Neither exists:
-- the cytoskeleton has five per-structure concepts and no comparison object,
-- and the bank has no structural-protein class object at all, which is why
-- collagen and elastin sit under connective tissue and keratin under
-- intermediate filaments with nothing joining them.
--
-- THE SECONDARY MAPPINGS, each judged on the card and reported individually:
--   collagen  ADDED. "forms a characteristic triple helix" IS the repetitive
--             secondary structure the class is defined by, and "most abundant
--             protein in the extracellular matrix" is the structural role.
--   keratin   ADDED. "the primary structural component of hair and nails"
--             states the structural role outright.
--   elastin   DECLINED. Its card teaches elastic recoil and shape restoration,
--             which is a mechanical property rather than evidence for the
--             class. Elastin is also the one of the three whose strength does
--             NOT come from highly repetitive secondary structure, so mapping
--             it to a class defined that way would be evidence pointing the
--             wrong direction. Being structural is not the test.
--
-- GOVERNANCE: AI_PROPOSED / AI_PROPOSED on every new mapping. Nothing is
-- HUMAN_VALIDATED, nothing is NEEDS_REVIEW, and the 29 lipid rows are untouched.
--
-- Pre-state recorded immutably at scratchpad/cards/pre_state.json
-- (sha256 ${s.sha256.slice(0, 32)}).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT; t TEXT;
BEGIN
  SELECT count(*) INTO n FROM public.flashcards f
   WHERE NOT EXISTS (SELECT 1 FROM public.flashcard_concepts fc WHERE fc.flashcard_id = f.id);
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: expected exactly 2 unmapped cards, found %', n; END IF;

  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '${CYTO.id}';
  IF t IS NULL THEN RAISE EXCEPTION 'CARDS: the cytoskeleton card is missing'; END IF;
  IF position('three filament classes' IN t) = 0 THEN RAISE EXCEPTION 'CARDS: the cytoskeleton card is not the expected text'; END IF;

  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '${STRUCT.id}';
  IF t IS NULL THEN RAISE EXCEPTION 'CARDS: the structural-proteins card is missing'; END IF;
  IF position('highly repetitive secondary structure' IN t) = 0 THEN RAISE EXCEPTION 'CARDS: the structural-proteins card is not the expected text'; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: a new slug already exists'; END IF;
  SELECT count(*) INTO n FROM public.concepts
   WHERE canonical_name IN ($n$Cytoskeleton: Filament Classes$n$, $n$Structural Proteins$n$);
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: a new canonical name already exists'; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE slug = 'CYTOSKELETON_INTERMEDIATE_FILAMENTS' AND status = 'ACTIVE_SEED';
  IF n <> 1 THEN RAISE EXCEPTION 'CARDS: the intermediate-filament target is not active'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id IN ('${COLLAGEN}', '${KERATIN}') AND role = 'PRIMARY';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: the two secondary candidates do not both hold a PRIMARY'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id IN ('${COLLAGEN}', '${KERATIN}') AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: a secondary candidate is human-validated'; END IF;

  SELECT count(*) INTO n FROM public.flashcards WHERE deck_id = '${CYTO.deck_id}' AND position = 75;
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: position 75 in The Cell is already taken'; END IF;
END $$;

-- ─── 1. The two concepts ─────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES
  ('CYTOSKELETON_FILAMENT_CLASSES', $n$Cytoskeleton: Filament Classes$n$, $d$${DEF_FC}$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('STRUCTURAL_PROTEINS', $n$Structural Proteins$n$, $d$${DEF_SP}$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT');

-- Taxonomy copied from the concept each one sits beside, so neither invents a
-- classification: the cytoskeleton comparison from Cytoskeleton: Microfilaments,
-- the protein class from Tissues: Connective Tissue.
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT n.id, src.section_code, true
  FROM public.concepts n
  JOIN LATERAL (SELECT cs.section_code FROM public.concept_sections cs
                  JOIN public.concepts c ON c.id = cs.concept_id
                 WHERE c.slug = CASE n.slug WHEN 'CYTOSKELETON_FILAMENT_CLASSES'
                                 THEN 'CYTOSKELETON_MICROFILAMENTS' ELSE 'TISSUES_CONNECTIVE_TISSUE' END
                 LIMIT 1) src ON true
 WHERE n.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT n.id, src.discipline_code, 'PRIMARY'
  FROM public.concepts n
  JOIN LATERAL (SELECT cd.discipline_code FROM public.concept_disciplines cd
                  JOIN public.concepts c ON c.id = cd.concept_id
                 WHERE c.slug = CASE n.slug WHEN 'CYTOSKELETON_FILAMENT_CLASSES'
                                 THEN 'CYTOSKELETON_MICROFILAMENTS' ELSE 'TISSUES_CONNECTIVE_TISSUE' END
                 LIMIT 1) src ON true
 WHERE n.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT n.id, src.content_category, true
  FROM public.concepts n
  JOIN LATERAL (SELECT k.content_category FROM public.concept_content_categories k
                  JOIN public.concepts c ON c.id = k.concept_id
                 WHERE c.slug = CASE n.slug WHEN 'CYTOSKELETON_FILAMENT_CLASSES'
                                 THEN 'CYTOSKELETON_MICROFILAMENTS' ELSE 'TISSUES_CONNECTIVE_TISSUE' END
                   AND k.is_primary LIMIT 1) src ON true
 WHERE n.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');

-- ─── 2. The two rewrites. Same ids, same cloze_count, same cloze meanings. ──
UPDATE public.flashcards SET cloze_text = $c$${CYTO_NEW}$c$
 WHERE id = '${CYTO.id}' AND cloze_count = 2;

UPDATE public.flashcards SET cloze_text = $c$${STRUCT_NEW}$c$
 WHERE id = '${STRUCT.id}' AND cloze_count = 2;

-- ─── 3. The new card, appended so no existing position shifts ───────────
INSERT INTO public.flashcards (deck_id, card_type, cloze_text, cloze_count, position)
VALUES ('${CYTO.deck_id}', 'cloze', $c$${NEW_CARD}$c$, 1, 75);

-- ─── 4. Mappings ────────────────────────────────────────────────────────
INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT '${CYTO.id}', c.id, 'PRIMARY', 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM public.concepts c WHERE c.slug = 'CYTOSKELETON_FILAMENT_CLASSES';

INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT '${STRUCT.id}', c.id, 'PRIMARY', 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM public.concepts c WHERE c.slug = 'STRUCTURAL_PROTEINS';

INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT f.id, c.id, 'PRIMARY', 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM public.flashcards f, public.concepts c
 WHERE f.deck_id = '${CYTO.deck_id}' AND f.position = 75
   AND c.slug = 'CYTOSKELETON_INTERMEDIATE_FILAMENTS';

-- The two justified SECONDARY rows. Elastin is deliberately absent.
INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT v.card_id::uuid, c.id, 'SECONDARY', 0.90, 'AI_PROPOSED', 'AI_PROPOSED'
  FROM (VALUES
  -- collagen: the triple helix IS the repetitive secondary structure
  ('${COLLAGEN}'),
  -- keratin: "the primary structural component of hair and nails"
  ('${KERATIN}')
  ) AS v(card_id), public.concepts c
 WHERE c.slug = 'STRUCTURAL_PROTEINS';

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; t TEXT; nid UUID;
BEGIN
  SELECT count(*) INTO n FROM public.concepts
   WHERE slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS')
     AND status = 'ACTIVE_SEED' AND object_type = 'CONTENT' AND coalesce(btrim(description), '') <> '';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: % of 2 concepts are live, CONTENT and defined', n; END IF;

  SELECT count(*) INTO n FROM public.concept_sections cs JOIN public.concepts c ON c.id = cs.concept_id
   WHERE c.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: expected 2 section rows, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines cd JOIN public.concepts c ON c.id = cd.concept_id
   WHERE c.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: expected 2 discipline rows, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories k JOIN public.concepts c ON c.id = k.concept_id
   WHERE c.slug IN ('CYTOSKELETON_FILAMENT_CLASSES', 'STRUCTURAL_PROTEINS');
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: expected 2 category rows, found %', n; END IF;

  -- Text changed, identity did not.
  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '${CYTO.id}';
  IF position('increasing diameter' IN t) = 0 THEN RAISE EXCEPTION 'CARDS: the cytoskeleton rewrite did not land'; END IF;
  IF position('keratin-family proteins}}' IN t) = 0 THEN RAISE EXCEPTION 'CARDS: keratin-family proteins must stay inside c2'; END IF;
  SELECT cloze_count INTO n FROM public.flashcards WHERE id = '${CYTO.id}';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: the cytoskeleton cloze_count changed to %', n; END IF;

  SELECT cloze_text INTO t FROM public.flashcards WHERE id = '${STRUCT.id}';
  IF position('owe their strength' IN t) = 0 THEN RAISE EXCEPTION 'CARDS: the structural-proteins rewrite did not land'; END IF;
  SELECT cloze_count INTO n FROM public.flashcards WHERE id = '${STRUCT.id}';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: the structural-proteins cloze_count changed to %', n; END IF;

  -- The new card exists, is new, and carries no learner history.
  SELECT id INTO nid FROM public.flashcards WHERE deck_id = '${CYTO.deck_id}' AND position = 75;
  IF nid IS NULL THEN RAISE EXCEPTION 'CARDS: the new card was not created'; END IF;
  IF nid IN ('${CYTO.id}', '${STRUCT.id}') THEN RAISE EXCEPTION 'CARDS: the new card reused an existing id'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_user_state WHERE flashcard_id = nid;
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: the new card already has % scheduler row(s)', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_reviews WHERE flashcard_id = nid;
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: the new card already has % review(s)', n; END IF;

  -- The old cards kept every scheduler row and review they had.
  SELECT count(*) INTO n FROM public.flashcard_user_state WHERE flashcard_id = '${CYTO.id}';
  IF n <> ${CYTO.schedulerRows.length} THEN RAISE EXCEPTION 'CARDS: cytoskeleton scheduler rows are now %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_reviews WHERE flashcard_id = '${CYTO.id}';
  IF n <> ${CYTO.reviews.length} THEN RAISE EXCEPTION 'CARDS: cytoskeleton reviews are now %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_user_state WHERE flashcard_id = '${STRUCT.id}';
  IF n <> ${STRUCT.schedulerRows.length} THEN RAISE EXCEPTION 'CARDS: structural-proteins scheduler rows are now %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_reviews WHERE flashcard_id = '${STRUCT.id}';
  IF n <> ${STRUCT.reviews.length} THEN RAISE EXCEPTION 'CARDS: structural-proteins reviews are now %', n; END IF;

  -- THE GATE: every card in the bank now resolves to a learning object.
  SELECT count(*) INTO n FROM public.flashcards f
   WHERE NOT EXISTS (SELECT 1 FROM public.flashcard_concepts fc WHERE fc.flashcard_id = f.id);
  IF n <> 0 THEN RAISE EXCEPTION 'CARDS: % card(s) remain unmapped, expected 0', n; END IF;

  SELECT count(*) INTO n FROM public.flashcards;
  IF n <> ${s.totals.flashcards + 1} THEN RAISE EXCEPTION 'CARDS: flashcards is %, expected ${s.totals.flashcards + 1}', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> ${s.totals.flashcardConceptRows + 5} THEN RAISE EXCEPTION 'CARDS: mapping rows is %, expected ${s.totals.flashcardConceptRows + 5}', n; END IF;
  SELECT count(DISTINCT flashcard_id) INTO n FROM public.flashcard_concepts;
  IF n <> ${s.totals.flashcards + 1} THEN RAISE EXCEPTION 'CARDS: unique mapped cards is %, expected ${s.totals.flashcards + 1}', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = '${COLLAGEN}';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: collagen should hold 1 PRIMARY and 1 SECONDARY, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = '${KERATIN}';
  IF n <> 2 THEN RAISE EXCEPTION 'CARDS: keratin should hold 1 PRIMARY and 1 SECONDARY, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = '${s.elastinConsideredAndDeclined.id}';
  IF n <> 1 THEN RAISE EXCEPTION 'CARDS: elastin should be untouched with 1 mapping, found %', n; END IF;

  -- Nothing on the question side moved.
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> ${s.totals.questionConcepts} THEN RAISE EXCEPTION 'CARDS: question_concepts moved to %', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> ${s.totals.reasoningObjects} THEN RAISE EXCEPTION 'CARDS: reasoning mappings moved'; END IF;
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> ${s.totals.concepts + 2} THEN RAISE EXCEPTION 'CARDS: concepts is %, expected ${s.totals.concepts + 2}', n; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') z;
  IF n <> ${s.totals.needsReview} THEN RAISE EXCEPTION 'CARDS: NEEDS_REVIEW is %, expected ${s.totals.needsReview}', n; END IF;

  RAISE NOTICE 'CARDS OK: 2 concepts, 2 rewrites keeping their ids and cloze meanings, 1 new card with fresh state, 2 justified secondaries. Unmapped cards 2 -> 0.';
END $$;

COMMIT;
`;
fs.writeFileSync("supabase/migrations/20261006_card_too_broad_repairs.sql", sql);
console.log("wrote supabase/migrations/20261006_card_too_broad_repairs.sql");
