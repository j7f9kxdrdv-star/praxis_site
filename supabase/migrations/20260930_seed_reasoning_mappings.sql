-- ============================================================
-- Migration 3 of 3: the 24 approved question-to-reasoning mappings
--
-- INSERT only, into one table. No concept is created or updated, no taxonomy
-- moves, question_concepts is untouched and no learner table is read.
--
-- WHERE THESE CAME FROM. A keyword matcher produced 36 candidates and was wrong
-- more often than right: it sent 5 questions to Study Design Types, whose subject
-- is cohort and case-control epidemiology, when every one of them is a bench
-- experiment in a dish. All 36 were then read in full, stem, options, correct
-- answer and explanation, and 24 survived. The ledger was a way to find
-- questions worth reading, not a proposal.
--
-- TWELVE QUESTIONS DELIBERATELY GET NOTHING. A question is not a reasoning item
-- because it contains a table, an experiment or a control group. The clearest
-- case is Comparing Starling Forces Across Capillary Beds: four rows of
-- pressures, which looks exactly like data interpretation, and the work is
-- substituting into the Starling equation. That is content arithmetic, and
-- nothing about reading evidence would help a learner who does not know the
-- equation. No reasoning mapping is a valid result and these twelve keep it.
--
-- CONFIDENCE. The manifest recorded HIGH or MEDIUM per row, and the column is
-- NUMERIC(3,2), so those judgements are encoded as 0.90 and 0.60. 0.90 matches
-- the value already used for AI_PROPOSED content mappings; 0.60 marks the three
-- rows where the manifest records a defensible alternative reading, so a
-- reviewer can find them without re-deriving anything.
--
-- PROVENANCE. AI_PROPOSED in both fields on all 24. The architecture and the
-- mapping set were approved; the rows were not reviewed one at a time by a
-- human, and the provenance must not claim they were.
--
-- FLAT, NO ROLE. Reasoning operations are not subordinate to one another. None
-- of the 24 questions needs two objects; if one ever does, it is a second row.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The 24 mappings, grouped by the operation they name.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_reasoning_objects
  (question_id, concept_id, confidence, mapping_status, source)
VALUES
  -- Variables and Controls  (14)
  ('70e5a2cd-25fd-4c30-8266-995a4756f3c9'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Testing Whether a Plasma Defense Is Tailored to Its Target
  ('576817f5-483c-4890-b117-d5165c6e712a'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Distinguishing Resident from Recruited Phagocytes
  ('41554ad6-1968-46e3-9952-a2669207e974'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Control Arm for a Display-Blocking Reagent
  ('50117ffe-e9db-48d3-98f9-4490ab618273'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Designing a Donor Compatibility Culture
  ('b5527bc1-19e2-4410-baf5-d439853476e0'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Testing Necessity of a Licensing Contact
  ('a56c4029-8b23-4c79-aa53-d387558b61dd'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Culture Arm Testing Matched Versus Generic Help
  ('c81dddc2-2661-47af-8075-6735bdd42f9c'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Specificity Control in a Two Exposure Time Course
  ('645e6716-886f-425d-a81c-ae1dd06d365b'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Cell-Free Control in a Protection Transfer
  ('2674e7f3-7623-4549-8ecd-20fffe3b9363'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Control Arms for a Specificity Claim
  ('6d375224-96f6-4985-839d-80492963ee30'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Separating Irritant Injury from Host Response
  ('be78788b-ea91-4598-8785-4529e578e8e0'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Localising Transferable Reactivity to a Blood Fraction
  ('0243cc4d-deb0-4671-b69c-11adf49b06c0'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Localising a Block Upstream of Lymphocytes
  ('2ae211e1-556c-4068-8078-8bfb3b3c9c33'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.60, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Cannulated Lymph Sampling As A Permeability Assay
  ('497265f9-c4d6-4de6-a814-31b61386888c'::uuid, 'f7f670f6-66d4-40a5-aa49-819070ea0133'::uuid, 0.60, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Locating The Break In The Loop
  -- Data Interpretation  (9)
  ('10a94fd5-3f1b-426b-a691-6ad724cfebc4'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Interpreting a Phagocyte Migration Assay
  ('864760c9-99ef-40c7-a6d7-5e0395273989'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Reading Fragment Origin from an Assay
  ('26a77350-de62-40e4-8b72-07ee2362764a'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Interpreting a Matched Display Killing Assay
  ('b265fad0-64eb-4fa6-aab9-e966cd7760a5'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Dose Response With Licensing Withheld
  ('d94c841b-bcf0-47ef-b485-58d6687731e2'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Reading a Native Versus Fragment Binding Table
  ('3728898c-3f11-400b-825b-54fad43f1f69'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Reading Expansion of a Rare Clone
  ('cb8b3fa1-7c4e-4a9e-8f7c-a93fb7cb99ff'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Reading a Labelled Lymphocyte Distribution Time Course
  ('9acc6a94-4cba-4e69-a114-f74383244c88'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Reading a Prior Contact Patch Panel
  ('adb63b32-b47b-4214-af93-a92776b00184'::uuid, '06b183db-6e9f-44d6-a3f3-759049d5adc6'::uuid, 0.60, 'AI_PROPOSED', 'AI_PROPOSED'),   -- Testing Endothelial Function in Isolated Vessels
  -- Causal Inference  (1)
  ('282ca647-02a9-4319-b240-cbff276485dd'::uuid, 'fd193bb1-b08f-4c51-a563-153590b6d050'::uuid, 0.90, 'AI_PROPOSED', 'AI_PROPOSED');   -- Adoptive Transfer and Causal Necessity

-- ────────────────────────────────────────────────────────────
-- 2. Verification inside the transaction.
--    Exact counts are right HERE, where they prove this migration did what it
--    said. They are deliberately absent from the permanent verifier, which would
--    otherwise go false the next time a valid mapping is added.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  SELECT count(*) INTO v FROM public.question_reasoning_objects;
  IF v <> 24 THEN RAISE EXCEPTION 'expected 24 reasoning mappings, found %', v; END IF;

  SELECT count(*) INTO v FROM public.question_reasoning_objects r
    JOIN public.concepts c ON c.id = r.concept_id WHERE c.slug = 'RO_VARIABLES_AND_CONTROLS';
  IF v <> 14 THEN RAISE EXCEPTION 'expected 14 Variables and Controls, found %', v; END IF;

  SELECT count(*) INTO v FROM public.question_reasoning_objects r
    JOIN public.concepts c ON c.id = r.concept_id WHERE c.slug = 'RO_DATA_INTERPRETATION';
  IF v <> 9 THEN RAISE EXCEPTION 'expected 9 Data Interpretation, found %', v; END IF;

  SELECT count(*) INTO v FROM public.question_reasoning_objects r
    JOIN public.concepts c ON c.id = r.concept_id WHERE c.slug = 'RO_CAUSAL_INFERENCE';
  IF v <> 1 THEN RAISE EXCEPTION 'expected 1 Causal Inference, found %', v; END IF;

  SELECT count(*) INTO v FROM public.question_reasoning_objects
    WHERE mapping_status <> 'AI_PROPOSED' OR source <> 'AI_PROPOSED';
  IF v <> 0 THEN RAISE EXCEPTION '% rows overstate their provenance', v; END IF;

  -- Every target is a REASONING object. The trigger enforces this, so a failure
  -- here means the trigger is not attached.
  SELECT count(*) INTO v FROM public.question_reasoning_objects r
    JOIN public.concepts c ON c.id = r.concept_id WHERE c.object_type <> 'REASONING';
  IF v <> 0 THEN RAISE EXCEPTION '% mappings point at a non-REASONING object', v; END IF;

  -- The twelve reviewed and judged CONTENT-only must have received nothing.
  SELECT count(*) INTO v FROM public.question_reasoning_objects
    WHERE question_id IN ('df64f6ea-6ba0-48be-bba9-8d005cc9a78b'::uuid, 'd22628c6-0127-45ac-bc8f-d4ccc3b13650'::uuid, '8d133e13-2fbd-498d-b6c2-eb5762aad627'::uuid, '0e740998-1f1b-4434-9fe1-b792edb53068'::uuid, '17aa1091-ddd6-4b1e-85cf-8b74b8351b06'::uuid, '6d94b670-aaff-4831-8ed3-717eb42ea805'::uuid, '689543ba-9498-48e3-8da6-d0d8ed16620a'::uuid, 'f9292c77-0dca-4050-8149-3d5327b901b3'::uuid, '5379b470-723f-4992-bce8-d6b87a438de4'::uuid, 'a836b3c5-65f5-4eb3-88b5-501ff42dec3a'::uuid, '9e77626b-0191-4cee-a487-f22205217854'::uuid, '463912a0-6a6c-404c-8fa7-480bd7ef4103'::uuid);
  IF v <> 0 THEN RAISE EXCEPTION '% of the twelve NO_REASONING questions got a mapping', v; END IF;

  -- Nothing else moved.
  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2673 THEN RAISE EXCEPTION 'question_concepts was touched: %', v; END IF;
  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard_concepts was touched: %', v; END IF;
  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1130 THEN RAISE EXCEPTION 'concepts changed: %', v; END IF;
END $$;

SELECT c.canonical_name AS reasoning_object,
       count(*) AS questions,
       min(r.confidence) AS min_conf,
       max(r.confidence) AS max_conf
FROM public.question_reasoning_objects r
JOIN public.concepts c ON c.id = r.concept_id
GROUP BY c.canonical_name ORDER BY 2 DESC;

COMMIT;
