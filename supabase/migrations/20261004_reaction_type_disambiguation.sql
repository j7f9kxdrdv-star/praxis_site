-- ─── Migration 4: reaction-type disambiguation and the Haber repoint ──────
--
-- Two concepts whose names are near-synonyms. "Types of Reactions" held ten
-- flashcards teaching the family names and eleven questions; "Reaction Types &
-- Classification" held FIVE questions and NOT ONE flashcard. Every one of those
-- five asks the same thing: assign oxidation numbers, decide whether this is a
-- redox reaction, and reconcile that with the family label. Two of them say it
-- outright, one arguing that a decomposition cannot be redox and another that a
-- single displacement must be.
--
-- So the objectives are distinct and the names did not say so. A concept with
-- questions and no cards is the signature: the card evidence went to one
-- reading of the name and the question evidence went to the other.
--
-- RE-READ FROM LIVE STATE, not from the earlier audit.
--
-- THE CARD THAT MOVES, Oxidation-Reduction Reactions #25:
--   "Double-displacement (metathesis) reactions are typically {{c1::not}} redox
--    reactions because the ions {{c2::keep their oxidation states}}."
-- Both blanks are about redox status. The family label is GIVEN in the prompt,
-- not hidden, so the learner is not being asked to name it. That is one
-- objective, not two, which is why this takes a single PRIMARY move and no
-- SECONDARY. Card #24, which blanks all four family names, stays put.
--
-- THE QUESTION THAT MOVES, the Haber process: 28.0 g of N2 against 8.0 g of H2,
-- find the theoretical yield of NH3. That is limiting reagent and theoretical
-- yield; the Haber context is set dressing. Its evidence is three cards on
-- Limiting Reagent, Theoretical & Percent Yield: limiting reactant, theoretical
-- yield, percent yield. It was only ever filed here because its subtopic string
-- happened to read "Types of Reactions".
--
-- SLUG: unchanged, per the convention established in migration 3 and proven by
-- Respiratory Thermoregulation still carrying the slug THERMOREGULATION. A
-- rename changes canonical_name and version; renameConcept() touches nothing
-- else, and archive_renamed_concept() fires on canonical_name alone.
--
-- GOVERNANCE, consistent with migration 3: a designed repoint lands
-- AI_PROPOSED / AI_PROPOSED. The Haber row was DETERMINISTIC / DETERMINISTIC_EXACT,
-- a claim that it was derived by exact name equality, and it is being moved
-- precisely because that equality was wrong, so the label goes. The card row was
-- already AI_PROPOSED / AI_PROPOSED and is set explicitly anyway, so the SQL
-- states the governance rather than relying on what happened to be there.
--
-- NEITHER MOVE TOUCHES LEARNER STATE. The card carries 2 scheduler rows and 9
-- reviews, both clozes at stability near 0.5 with a lapse each. Mapping identity
-- and scheduler state are independent, and the verification compares those rows
-- field by field against the snapshot.
--
-- THE DEFINITIONS EACH NAME THE OTHER CONCEPT and say what belongs there. That
-- is the part meant to stop this recurring: a future author who reads either
-- definition is told where the neighbouring objective lives.
--
-- Pre-state recorded immutably at scratchpad/reaction/pre_state.json
-- (sha256 4dd70d15581470ba38560326cb45e9b8).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT; st TEXT; nm TEXT;
BEGIN
  SELECT status, canonical_name INTO st, nm FROM public.concepts WHERE id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF st IS DISTINCT FROM 'ACTIVE_SEED' THEN RAISE EXCEPTION 'REACTION: Types of Reactions is %', coalesce(st, 'missing'); END IF;
  IF nm <> 'Types of Reactions' THEN RAISE EXCEPTION 'REACTION: concept A is named %', nm; END IF;

  SELECT status, canonical_name INTO st, nm FROM public.concepts WHERE id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF st IS DISTINCT FROM 'ACTIVE_SEED' THEN RAISE EXCEPTION 'REACTION: concept B is %', coalesce(st, 'missing'); END IF;
  IF nm <> 'Reaction Types & Classification' THEN RAISE EXCEPTION 'REACTION: concept B is already named %', nm; END IF;

  SELECT status INTO st FROM public.concepts WHERE id = '304e09df-34ae-424b-97c0-f657726485f9';
  IF st IS DISTINCT FROM 'ACTIVE_SEED' THEN RAISE EXCEPTION 'REACTION: the Limiting Reagent target is %', coalesce(st, 'missing'); END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = 'd01a72af-36d7-41d7-bbd5-f683f6047d94' AND concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the metathesis card is not on Types of Reactions (found %)', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE question_id = '641ac692-1819-4b4c-833a-a86bd49bba38' AND concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the Haber question is not on Types of Reactions (found %)', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 10 THEN RAISE EXCEPTION 'REACTION: expected 10 cards on Types of Reactions, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 11 THEN RAISE EXCEPTION 'REACTION: expected 11 questions on Types of Reactions, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF n <> 5 THEN RAISE EXCEPTION 'REACTION: expected 5 questions on concept B, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: expected 0 cards on concept B, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '304e09df-34ae-424b-97c0-f657726485f9';
  IF n <> 16 THEN RAISE EXCEPTION 'REACTION: expected 16 questions on Limiting Reagent, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id IN ('8fddc347-a5c0-44c3-bcfd-77277b52de4e', 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27') AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: % human-validated card mapping(s) in scope', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id IN ('8fddc347-a5c0-44c3-bcfd-77277b52de4e', 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27', '304e09df-34ae-424b-97c0-f657726485f9') AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: % human-validated question mapping(s) in scope', n; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE id <> 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27'
     AND lower(regexp_replace(canonical_name, '[^a-zA-Z0-9]+', ' ', 'g')) =
         lower(regexp_replace('Redox Classification of Reaction Families', '[^a-zA-Z0-9]+', ' ', 'g'));
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: the new name collides with % concept(s)', n; END IF;

  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE alias = 'Reaction Types & Classification' AND alias_type = 'LEGACY_NAME';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: that LEGACY_NAME alias already exists'; END IF;
END $$;

-- ─── 1. Definitions. Each names the other and says what belongs there. ──
UPDATE public.concepts SET description = $d$Naming the family a reaction belongs to: combination, decomposition, combustion, single and double displacement, precipitation and neutralization. The learner question is which family this is. Whether the reaction is ALSO a redox reaction is a separate axis and belongs to Redox Classification of Reaction Families.$d$ WHERE id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
UPDATE public.concepts SET description = $d$Deciding whether a reaction is redox by assigning oxidation numbers, and reconciling that answer with the family label it already carries. The two axes are orthogonal: a decomposition can be redox, and a double displacement usually is not. The learner question is whether this is redox and how that sits with its family. Naming the family itself belongs to Types of Reactions.$d$ WHERE id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';

-- ─── 2. The rename. The trigger files the old name as a LEGACY_NAME alias. ──
UPDATE public.concepts
   SET canonical_name = 'Redox Classification of Reaction Families', version = version + 1
 WHERE id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';

-- ─── 3. One flashcard mapping: the metathesis-is-not-redox card ─────────
UPDATE public.flashcard_concepts
   SET concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27', mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
 WHERE flashcard_id = 'd01a72af-36d7-41d7-bbd5-f683f6047d94' AND concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';

-- ─── 4. One question mapping: the Haber theoretical-yield question ──────
UPDATE public.question_concepts
   SET concept_id = '304e09df-34ae-424b-97c0-f657726485f9', mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
 WHERE question_id = '641ac692-1819-4b4c-833a-a86bd49bba38' AND concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; nm TEXT; sl TEXT; v INT; dA TEXT; dB TEXT;
BEGIN
  SELECT canonical_name, slug, version INTO nm, sl, v FROM public.concepts WHERE id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF nm <> 'Redox Classification of Reaction Families' THEN RAISE EXCEPTION 'REACTION: rename did not land, name is %', nm; END IF;
  IF sl <> 'REACTION_TYPES_CLASSIFICATION' THEN RAISE EXCEPTION 'REACTION: the slug changed to %, it must not', sl; END IF;
  IF v <> 2 THEN RAISE EXCEPTION 'REACTION: version is %, expected 2', v; END IF;

  SELECT count(*) INTO n FROM public.concept_aliases
   WHERE concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27' AND alias = 'Reaction Types & Classification' AND alias_type = 'LEGACY_NAME';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the rename trigger did not file the LEGACY_NAME alias (found %)', n; END IF;
  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> 7 THEN RAISE EXCEPTION 'REACTION: alias total is %, expected 7', n; END IF;

  SELECT description INTO dA FROM public.concepts WHERE id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  SELECT description INTO dB FROM public.concepts WHERE id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF coalesce(btrim(dA), '') = '' OR coalesce(btrim(dB), '') = '' THEN
    RAISE EXCEPTION 'REACTION: a definition is empty';
  END IF;
  IF position('Redox Classification of Reaction Families' IN dA) = 0
     OR position('Types of Reactions' IN dB) = 0 THEN
    RAISE EXCEPTION 'REACTION: each definition must name the other concept';
  END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 9 THEN RAISE EXCEPTION 'REACTION: expected 9 cards left on Types of Reactions, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '8fddc347-a5c0-44c3-bcfd-77277b52de4e';
  IF n <> 10 THEN RAISE EXCEPTION 'REACTION: expected 10 questions left on Types of Reactions, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: expected 1 card on the renamed concept, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27';
  IF n <> 5 THEN RAISE EXCEPTION 'REACTION: the renamed concept should still hold 5 questions, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '304e09df-34ae-424b-97c0-f657726485f9';
  IF n <> 17 THEN RAISE EXCEPTION 'REACTION: expected 17 questions on Limiting Reagent, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id = 'd01a72af-36d7-41d7-bbd5-f683f6047d94' AND concept_id = 'e4e89b6f-fd4d-478a-90a1-bbb1d868bc27' AND role = 'PRIMARY'
     AND mapping_status = 'AI_PROPOSED' AND source = 'AI_PROPOSED';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the card did not land with the right governance'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE flashcard_id = 'd01a72af-36d7-41d7-bbd5-f683f6047d94';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the card now holds % mappings, expected exactly 1', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE question_id = '641ac692-1819-4b4c-833a-a86bd49bba38' AND concept_id = '304e09df-34ae-424b-97c0-f657726485f9' AND role = 'PRIMARY'
     AND mapping_status = 'AI_PROPOSED' AND source = 'AI_PROPOSED';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the Haber question did not land with the right governance'; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE question_id = '641ac692-1819-4b4c-833a-a86bd49bba38';
  IF n <> 1 THEN RAISE EXCEPTION 'REACTION: the Haber question now holds % mappings, expected exactly 1', n; END IF;

  -- Nothing else moved.
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> 1132 THEN RAISE EXCEPTION 'REACTION: ontology objects is %, expected 1132', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> 4116 THEN RAISE EXCEPTION 'REACTION: flashcard_concepts is %, expected 4116', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> 2673 THEN RAISE EXCEPTION 'REACTION: question_concepts is %, expected 2673', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> 24 THEN RAISE EXCEPTION 'REACTION: reasoning mappings is %, expected 24', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> 177 THEN RAISE EXCEPTION 'REACTION: deprecated is %, expected 177', n; END IF;
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') x;
  IF n <> 29 THEN RAISE EXCEPTION 'REACTION: NEEDS_REVIEW is %, expected 29', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: % question mapping(s) target a deprecated concept', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION 'REACTION: % card mapping(s) target a deprecated concept', n; END IF;

  RAISE NOTICE 'REACTION OK: renamed, old name filed, 1 card and 1 question repointed, 0 new NEEDS_REVIEW.';
END $$;

COMMIT;
