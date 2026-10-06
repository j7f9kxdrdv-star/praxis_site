-- ─── The final lipid-split governance migration ───────────────────────────
-- REQUIRES: 20260930_lipid_mobilization_split.sql
-- because it closes the 29 NEEDS_REVIEW rows that migration created.
--
-- GENERATED FROM scratchpad/review/manifest.json. No mapping in this file was
-- typed by hand. The manifest holds one explicit human decision per row, each
-- with a reviewer, a timestamp and a rationale, recorded over three review
-- batches. Pre-state snapshot: sha256 cc88295fe48ac9e2, taken 2026-10-06T00:27:46.696Z.
--
-- WHAT THE REVIEW DECIDED. All 29 rows were CONFIRM_CURRENT_MAPPING: the split
-- put every one of them in the right place. Two cards additionally earned a
-- SECONDARY, under the rule this review established:
--
--   A SECONDARY mapping requires independently tested knowledge, not merely
--   mention, context, or distractor relevance.
--
-- That rule was applied three ways and refused twice: granted where both halves
-- sit in separate clozes the learner must produce (rows 3/4, 12, 17), refused
-- where the second concept is only supplied context (row 10), and refused where
-- it appears only in distractors (row 29).
--
-- SOURCE IS LEFT ALONE ON THE 29, AND HERE IS WHY. The schema carries dedicated
-- review fields, reviewed_at and reviewed_by, alongside mapping_status. With the
-- review act recorded in its own columns, source stays what the ontology seed
-- called it: where the mapping came from. So the 29 keep their origins,
-- 22 AI_PROPOSED cards and 7 DETERMINISTIC_EXACT questions, and only
-- mapping_status moves. Rewriting them all to HUMAN_REVIEWED would erase the
-- single most useful finding of this review: that those 7 questions reached
-- the deprecated parent by their subtopic label matching its name character for
-- character, with no stem ever read.
--
-- The apparent counter-precedent sets both fields together
-- (20260929_question_reasoning_objects_schema.sql line 176), but that statement
-- lives inside a probe that ends in RAISE EXCEPTION PROBE_ROLLBACK and was
-- discarded. It proves a trigger; it is not production governance.
--
-- The two NEW rows are different: they did not exist before a human asked for
-- them, so their origin genuinely is human review, and they carry
-- source HUMAN_REVIEWED.
--
-- reviewed_by IS LEFT NULL, deliberately. The column is a UUID. No profile in
-- this database is unambiguously the reviewer: no row has is_admin set, the
-- reviewer address is not among them, and two profiles share the name, one of
-- them the demo account. Writing a guessed uuid into a governance column is
-- worse than leaving it empty. The reviewer is recorded in the manifest, which
-- is committed. A one-line follow-up can set it once the right uuid is named.
--
-- THE CARD REWORDING TOUCHES TEXT, NOT STATE. Row 17's card carries
-- 2 scheduler rows and 8 reviews. Scheduler state is keyed to
-- (flashcard_id, cloze_index) and survives a text edit whether or not the text
-- still asks the same thing, so the new wording keeps c1 = LDL and c2 = de novo
-- exactly. The fix is to the science only: the old text called LDL delivery
-- "dietary uptake", but LDL cholesterol leaves the liver inside VLDL, which
-- carries both dietary and de novo cholesterol.
--
-- WRITES: concepts (1 description), flashcard_concepts (22 status upgrades,
-- 2 inserts), question_concepts (7 status upgrades), flashcards (1 text).
-- Touches no learner table, no FSRS state, no review history, no attempt, no
-- session, no snapshot, and no row in question_reasoning_objects.

BEGIN;

-- ─── 0. Pre-conditions. Drift aborts the whole transaction ───────────────
DO $pre$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW';
  IF n <> 22 THEN RAISE EXCEPTION 'expected 22 NEEDS_REVIEW card rows, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW';
  IF n <> 7 THEN RAISE EXCEPTION 'expected 7 NEEDS_REVIEW question rows, found %', n; END IF;

  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'HUMAN_VALIDATED'
    UNION ALL
    SELECT 1 FROM public.question_concepts WHERE mapping_status = 'HUMAN_VALIDATED') x;
  IF n <> 0 THEN RAISE EXCEPTION 'expected no HUMAN_VALIDATED mapping to exist yet, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid
     AND flashcard_id IN ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid, '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid);
  IF n <> 0 THEN RAISE EXCEPTION 'an approved SECONDARY already exists; refusing to duplicate (% found)', n; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE id = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid AND status <> 'DEPRECATED' AND description IS NULL;
  IF n <> 1 THEN RAISE EXCEPTION 'the definition target is missing, deprecated, or already described'; END IF;

  SELECT count(*) INTO n FROM public.flashcards
   WHERE id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid AND cloze_text LIKE '%dietary uptake%' AND cloze_count = 2;
  IF n <> 1 THEN RAISE EXCEPTION 'row 17 card is not in the expected pre-state'; END IF;

  RAISE NOTICE 'pre-conditions hold: 29 rows in review, nothing human-validated yet';
END $pre$;

-- ─── 1. The definition lands BEFORE the new human-validated evidence ────
-- Approved scope, recorded in the manifest as pending action
-- define-cholesterol-tag-synthesis. Description only: moves no evidence,
-- renames nothing, so no alias is filed and no mapping moves.
UPDATE public.concepts
   SET description = 'De novo production of lipid: the synthesis of cholesterol and of triacylglycerol from carbon precursors. Covers the citrate shuttle that carries acetyl-CoA into the cytosol, the acetyl-CoA, NADPH and ATP requirements, HMG-CoA reductase as the rate-limiting step, and the feedback and hormonal regulation of that step. It does not cover lipoprotein particle identity, particle density or ordering, particle cargo and destination, or the LCAT and CETP transfer reactions, all of which remain under Lipoprotein Classes & Cholesterol Transport.',
       version = version + 1
 WHERE id = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid
   AND description IS NULL;

-- ─── 2. The 29 reviewed rows become HUMAN_VALIDATED ─────────────────────
-- source is NOT touched. reviewed_at records the act; see the header.
  -- row  1  PRIMARY   9eeb0b22  Adipose Fat Mobilization
  -- row  2  PRIMARY   c8cd1838  Adipose Fat Mobilization
  -- row  3  PRIMARY   7ef7bb98  Adipose Fat Mobilization
  -- row  4  SECONDARY 7ef7bb98  Lipoprotein Classes & Cholesterol Transport
  -- row  5  PRIMARY   498fdb2c  Adipose Fat Mobilization
  -- row  6  PRIMARY   85066347  Lipoprotein Classes & Cholesterol Transport
  -- row  7  PRIMARY   286475e3  Lipoprotein Classes & Cholesterol Transport
  -- row  8  PRIMARY   ce248d8d  Lipoprotein Classes & Cholesterol Transport
  -- row  9  PRIMARY   2106f62c  Lipoprotein Classes & Cholesterol Transport
  -- row 10  PRIMARY   92f625de  Lipoprotein Classes & Cholesterol Transport
  -- row 11  PRIMARY   c273b5a0  Lipoprotein Classes & Cholesterol Transport
  -- row 12  PRIMARY   b393432e  Lipoprotein Classes & Cholesterol Transport
  -- row 13  PRIMARY   d2a3020b  Lipoprotein Classes & Cholesterol Transport
  -- row 14  PRIMARY   2eb0f47d  Lipoprotein Classes & Cholesterol Transport
  -- row 15  PRIMARY   d72ce200  Lipoprotein Classes & Cholesterol Transport
  -- row 16  PRIMARY   2f463545  Lipoprotein Classes & Cholesterol Transport
  -- row 17  PRIMARY   7d0c69e5  Lipoprotein Classes & Cholesterol Transport
  -- row 18  PRIMARY   5c2380c2  Lipoprotein Classes & Cholesterol Transport
  -- row 19  PRIMARY   d683d661  Lipoprotein Classes & Cholesterol Transport
  -- row 20  PRIMARY   c169a43b  Lipoprotein Classes & Cholesterol Transport
  -- row 21  PRIMARY   6da4235c  Adipose Fat Mobilization
  -- row 22  PRIMARY   f256e0af  Adipose Fat Mobilization
WITH approved(item, concept) AS (VALUES
    ('9eeb0b22-95e3-4b86-b4ef-5c4460951d4b'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('c8cd1838-574f-45d8-9493-95c342b7c657'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('7ef7bb98-09f0-4a25-9eb9-97aaab4a38b7'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('7ef7bb98-09f0-4a25-9eb9-97aaab4a38b7'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('498fdb2c-ecbf-4777-b7d4-df28d411c9c1'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('85066347-0336-4bb5-a0cf-d327cc69e41c'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('286475e3-dbee-4ddd-b12c-26182703f644'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('ce248d8d-4a46-488b-99fb-2bfa35c22199'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('2106f62c-1130-4b23-8e24-cd161fd8904d'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('92f625de-0ce2-4773-869b-efa1baf29a08'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('c273b5a0-39b2-49b5-802b-dea9567bd38a'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('d2a3020b-becf-4dc3-be67-66af3f77a507'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('2eb0f47d-be19-409d-ab0a-a0b2dc6cc5f4'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('d72ce200-fd17-4361-a5d8-bc87b10c0329'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('2f463545-6633-443b-8a92-9825b8e5871c'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('5c2380c2-0356-48ce-81ae-e90004635fb4'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('d683d661-8ba8-4336-b473-320bb498e6eb'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('c169a43b-a39a-4730-b4f4-9a6e93201213'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('6da4235c-1039-41f2-b061-060dc7218fd1'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('f256e0af-cd39-4e34-ac9c-8310e1100ba7'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid)
)
UPDATE public.flashcard_concepts fc
   SET mapping_status = 'HUMAN_VALIDATED',
       reviewed_at    = now()
  FROM approved a
 WHERE fc.flashcard_id = a.item
   AND fc.concept_id   = a.concept
   AND fc.mapping_status = 'NEEDS_REVIEW';

  -- row 23  PRIMARY   62d14d91  Adipose Fat Mobilization
  -- row 24  PRIMARY   654c9081  Adipose Fat Mobilization
  -- row 25  PRIMARY   80fbc6b8  Lipoprotein Classes & Cholesterol Transport
  -- row 26  PRIMARY   c34afa80  Adipose Fat Mobilization
  -- row 27  PRIMARY   cec05f2f  Lipoprotein Classes & Cholesterol Transport
  -- row 28  PRIMARY   d37819fd  Adipose Fat Mobilization
  -- row 29  PRIMARY   ecd55519  Lipoprotein Classes & Cholesterol Transport
WITH approved(item, concept) AS (VALUES
    ('62d14d91-b276-4753-a3e4-2a6fc1af478a'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('654c9081-a869-4aa3-8faa-723c83edc26a'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('80fbc6b8-a4b4-4e08-a72e-c6dd20b35ae6'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('c34afa80-036b-4483-8540-e2fd3fa19cd0'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('cec05f2f-6d03-449e-ae09-2592c6717821'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid),
    ('d37819fd-caca-45b6-81c2-690565f505f6'::uuid, 'ac90b4e9-98a5-4a47-bea6-7269f32adbf3'::uuid),
    ('ecd55519-61d8-4094-9536-8ceda50290d1'::uuid, '2bd9f11e-36cc-47d7-ab4f-4daa827b46be'::uuid)
)
UPDATE public.question_concepts qc
   SET mapping_status = 'HUMAN_VALIDATED',
       reviewed_at    = now()
  FROM approved a
 WHERE qc.question_id = a.item
   AND qc.concept_id  = a.concept
   AND qc.mapping_status = 'NEEDS_REVIEW';

-- ─── 3. The two approved SECONDARY additions ────────────────────────────
-- Both are new rows created by a human decision, so both carry
-- source HUMAN_REVIEWED. Neither may be PRIMARY: each card already holds its
-- PRIMARY on Lipoprotein Classes & Cholesterol Transport, and the partial
-- unique index would reject a second one.
  -- row 12 card b393432e The c1 cloze (excess dietary glucose converted to
  --  fatty acids in the liver) is de novo lipogenesis, which is this
  --  concept's territory and not covered by the transport definition.
  -- row 17 card 7d0c69e5 The c2 cloze (de novo) is the whole claim of this
  --  concept; the card's either/or structure makes both routes
  --  independently tested.
INSERT INTO public.flashcard_concepts
  (flashcard_id, concept_id, role, confidence, mapping_status, source, reviewed_at)
VALUES
  ('b393432e-665c-47fc-9b13-c66af880a80d'::uuid, '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid, 'SECONDARY', NULL, 'HUMAN_VALIDATED', 'HUMAN_REVIEWED', now()),
  ('7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid, '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid, 'SECONDARY', NULL, 'HUMAN_VALIDATED', 'HUMAN_REVIEWED', now());

-- ─── 4. Row 17: the wording correction, same clozes ─────────────────────
UPDATE public.flashcards
   SET cloze_text = 'Cells obtain cholesterol either by receptor-mediated uptake of circulating {{c1::LDL}} or by {{c2::de novo}} synthesis.'
 WHERE id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid
   AND cloze_text LIKE '%dietary uptake%';

-- ─── Post-conditions ────────────────────────────────────────────────────
DO $post$
DECLARE n INT; t TEXT;
BEGIN
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW'
    UNION ALL
    SELECT 1 FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW') x;
  IF n <> 0 THEN RAISE EXCEPTION 'NEEDS_REVIEW should be empty, % remain', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE mapping_status = 'HUMAN_VALIDATED';
  IF n <> 24 THEN RAISE EXCEPTION 'expected 24 human-validated card rows, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE mapping_status = 'HUMAN_VALIDATED';
  IF n <> 7 THEN RAISE EXCEPTION 'expected 7 human-validated question rows, found %', n; END IF;

  -- Origins preserved on the reviewed rows, declared on the new ones.
  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED' AND source = 'AI_PROPOSED';
  IF n <> 22 THEN RAISE EXCEPTION 'expected 22 reviewed card rows to keep source AI_PROPOSED, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED' AND source = 'DETERMINISTIC_EXACT';
  IF n <> 7 THEN RAISE EXCEPTION 'expected 7 reviewed question rows to keep source DETERMINISTIC_EXACT, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE source = 'HUMAN_REVIEWED';
  IF n <> 2 THEN RAISE EXCEPTION 'expected 2 rows with source HUMAN_REVIEWED, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE source = 'HUMAN_REVIEWED' AND role <> 'SECONDARY';
  IF n <> 0 THEN RAISE EXCEPTION 'a human-reviewed addition is not SECONDARY'; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE source = 'HUMAN_REVIEWED';
  IF n <> 0 THEN RAISE EXCEPTION 'no question row should carry source HUMAN_REVIEWED, found %', n; END IF;

  -- Every reviewed row carries a review timestamp, and nothing else does.
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE reviewed_at IS NOT NULL
    UNION ALL
    SELECT 1 FROM public.question_concepts WHERE reviewed_at IS NOT NULL) x;
  IF n <> 31 THEN RAISE EXCEPTION 'expected 31 rows stamped reviewed_at, found %', n; END IF;

  -- One PRIMARY per item survives.
  SELECT count(*) INTO n FROM (
    SELECT flashcard_id FROM public.flashcard_concepts WHERE role = 'PRIMARY'
     GROUP BY flashcard_id HAVING count(*) > 1) x;
  IF n <> 0 THEN RAISE EXCEPTION '% flashcards hold more than one PRIMARY', n; END IF;

  SELECT count(*) INTO n FROM (
    SELECT question_id FROM public.question_concepts WHERE role = 'PRIMARY'
     GROUP BY question_id HAVING count(*) > 1) x;
  IF n <> 0 THEN RAISE EXCEPTION '% questions hold more than one PRIMARY', n; END IF;

  -- No mapping points at a deprecated concept.
  SELECT count(*) INTO n FROM public.flashcard_concepts fc
    JOIN public.concepts c ON c.id = fc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION '% card mappings point at a DEPRECATED concept', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF n <> 0 THEN RAISE EXCEPTION '% question mappings point at a DEPRECATED concept', n; END IF;

  -- The definition landed, and says what it must not absorb.
  SELECT description INTO t FROM public.concepts WHERE id = '066ad4c3-e5b1-49b4-b8a2-951a8f721eed'::uuid;
  IF t IS NULL OR length(t) < 200 OR t NOT LIKE '%HMG-CoA reductase%' OR t NOT LIKE '%does not cover%'
    THEN RAISE EXCEPTION 'the synthesis definition is missing or incomplete'; END IF;

  -- The card reworded, both cloze indices intact, no third cloze introduced.
  SELECT count(*) INTO n FROM public.flashcards
   WHERE id = '7d0c69e5-1e1d-4061-826a-dd4ad94dc426'::uuid
     AND cloze_text LIKE '%{{c1::LDL}}%'
     AND cloze_text LIKE '%{{c2::de novo}}%'
     AND cloze_text NOT LIKE '%dietary uptake%'
     AND cloze_text NOT LIKE '%{{c3::%'
     AND cloze_count = 2;
  IF n <> 1 THEN RAISE EXCEPTION 'row 17 card did not reword cleanly'; END IF;

  RAISE NOTICE 'governance complete: 29 rows validated, 2 added, 1 definition, 1 rewording';
END $post$;

COMMIT;
