import fs from "node:fs";
const m = JSON.parse(fs.readFileSync("scratchpad/lipid/manifest.json", "utf8"));
const s = JSON.parse(fs.readFileSync("scratchpad/lipid/pre_split_snapshot.json", "utf8"));
const L = (a) => a.map((id) => `    '${id}'`).join(",\n");
const DEF_A = "How stored triacylglycerol is released from adipocytes under hormonal control: hormone-sensitive lipase, its regulation by fasting insulin and the counter-regulatory signals, and the transport and fate of the free fatty acids and glycerol that are released.";
const DEF_B = "The lipoprotein particles that move lipid through plasma: chylomicrons, VLDL, IDL, LDL and HDL, their density and composition ordering, apoproteins, where each is made and what it carries, the LCAT and CETP reactions, and forward versus reverse cholesterol transport.";

const sql = `-- ─── Migration 2 of the ontology lifecycle cleanup: the lipid split ───────
--
-- Lipid Mobilization & Transport names two ideas and its evidence divides
-- cleanly along that seam: 6 cards and 4 questions about releasing stored fat
-- from adipocytes, 15 cards and 3 questions about the lipoprotein particles
-- that carry lipid through plasma. A student can know one and not the other,
-- which is the test for whether a concept should be split.
--
-- THIS MIGRATION MOVES REAL EVIDENCE. Migration 1 could not affect a learner;
-- this one repoints 28 mappings that learner history already refers to.
--
-- WHAT THE LIFECYCLE MODULE DECIDES, AND WHAT IT REFUSES TO.
-- lib/taxonomy/lifecycle.ts splitConcept() emits CREATE_CONCEPT for each child,
-- FLAG_MAPPING(NEEDS_REVIEW) for every existing mapping, and deprecates the
-- parent with deprecated_by NULL. It deliberately does NOT emit a destination
-- for any mapping: "a split happens precisely because the old concept
-- conflated two ideas, which means the old mapping cannot say which child it
-- belonged to."
--
-- So this migration takes the module's three decisions unchanged, and supplies
-- the one thing it refuses to invent, from a manifest built by reading all 21
-- cards and all 7 questions and approved by Mikko. The mappings still land
-- NEEDS_REVIEW, because ontology-level approval is not row-by-row human
-- validation. Nothing here is marked HUMAN_VALIDATED.
--
-- ORDER MATTERS, AND NOT FOR THE REASON YOU WOULD GUESS.
-- reject_deprecated_concept_mapping() fires BEFORE INSERT only. An UPDATE that
-- moves a mapping ONTO a deprecated concept is not blocked; this was proven on
-- a fixture rather than assumed. So the parent is deprecated LAST, once it
-- holds no evidence, and every repoint happens while both ends are live.
--
-- MAPPING ARITHMETIC, stated so the report cannot read as a discrepancy:
--   21 flashcard mappings repointed
--  + 7 question mappings repointed
--  = 28 EXISTING mappings redistributed
--  + 1 NEW SECONDARY row on the HSL/LPL straddle card
--  = 29 total mapping changes
--
-- THE STRADDLE CARD (Lipid and Amino Acid Metabolism #12) contrasts where
-- hormone-sensitive lipase acts with where lipoprotein lipase acts. It was
-- reviewed individually and is a genuine two-object card: PRIMARY to
-- mobilization, SECONDARY to transport. No other card gets a SECONDARY merely
-- for mentioning both.
--
-- THE PARENT IS DEPRECATED WITH deprecated_by NULL. A split has no single
-- successor, and pointing the old ID at either child would assert something
-- false. It is not hard-deleted: historical references stay explainable.
--
-- Pre-state is recorded immutably at scratchpad/lipid/pre_split_snapshot.json
-- (sha256 ${s.sha256.slice(0, 32)}).

BEGIN;

-- ─── Pre-conditions. Refuse rather than half-apply. ───────────────────────
DO $$
DECLARE n INT; st TEXT;
BEGIN
  SELECT status INTO st FROM public.concepts WHERE id = '${m.parentId}';
  IF st IS NULL THEN RAISE EXCEPTION 'LIPID SPLIT: parent concept not found'; END IF;
  IF st = 'DEPRECATED' THEN RAISE EXCEPTION 'LIPID SPLIT: parent is already DEPRECATED; this migration has run'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${m.parentId}';
  IF n <> 21 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 21 flashcard mappings on the parent, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '${m.parentId}';
  IF n <> 7 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 7 question mappings on the parent, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_reasoning_objects WHERE concept_id = '${m.parentId}';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: unexpected reasoning evidence on the parent (%)', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE slug IN ('${m.slugs[0]}', '${m.slugs[1]}');
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: a child slug is already taken'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '${m.parentId}' AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % human-validated card mapping(s) would be overwritten', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id = '${m.parentId}' AND mapping_status = 'HUMAN_VALIDATED';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % human-validated question mapping(s) would be overwritten', n; END IF;
END $$;

-- ─── 1. The two children ──────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES
  ('${m.slugs[0]}', $n$${m.names[0]}$n$, $d$${DEF_A}$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT'),
  ('${m.slugs[1]}', $n$${m.names[1]}$n$, $d$${DEF_B}$d$, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT');

-- ─── 2. Taxonomy, inherited only where it stays true ──────────────────────
-- The parent carried exactly three rows: section BIO_BIOCHEM, discipline
-- BIOCHEMISTRY, category "Metabolism of Fatty Acids and Proteins". All three
-- remain correct for both children, so both inherit all three and nothing
-- broader is invented.
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, 'BIO_BIOCHEM', true FROM public.concepts c
 WHERE c.slug IN ('${m.slugs[0]}', '${m.slugs[1]}');

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, 'BIOCHEMISTRY', 'PRIMARY' FROM public.concepts c
 WHERE c.slug IN ('${m.slugs[0]}', '${m.slugs[1]}');

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'Metabolism of Fatty Acids and Proteins', true FROM public.concepts c
 WHERE c.slug IN ('${m.slugs[0]}', '${m.slugs[1]}');

-- ─── 3. Repoint the 21 flashcard mappings, while both ends are live ───────
UPDATE public.flashcard_concepts
   SET concept_id = (SELECT id FROM public.concepts WHERE slug = '${m.slugs[0]}'),
       mapping_status = 'NEEDS_REVIEW'
 WHERE concept_id = '${m.parentId}'
   AND flashcard_id IN (
${L(m.cardsA)}
   );

UPDATE public.flashcard_concepts
   SET concept_id = (SELECT id FROM public.concepts WHERE slug = '${m.slugs[1]}'),
       mapping_status = 'NEEDS_REVIEW'
 WHERE concept_id = '${m.parentId}'
   AND flashcard_id IN (
${L(m.cardsB)}
   );

-- ─── 4. Repoint the 7 question mappings ──────────────────────────────────
UPDATE public.question_concepts
   SET concept_id = (SELECT id FROM public.concepts WHERE slug = '${m.slugs[0]}'),
       mapping_status = 'NEEDS_REVIEW'
 WHERE concept_id = '${m.parentId}'
   AND question_id IN (
${L(m.qA)}
   );

UPDATE public.question_concepts
   SET concept_id = (SELECT id FROM public.concepts WHERE slug = '${m.slugs[1]}'),
       mapping_status = 'NEEDS_REVIEW'
 WHERE concept_id = '${m.parentId}'
   AND question_id IN (
${L(m.qB)}
   );

-- ─── 5. The one approved SECONDARY ───────────────────────────────────────
-- Governance, stated explicitly: NEEDS_REVIEW like every other row this
-- migration writes, and source AI_PROPOSED. The card was read individually and
-- the pairing approved at ontology level, which is not the same as a human
-- validating this row, so HUMAN_REVIEWED would overstate what happened.
INSERT INTO public.flashcard_concepts
  (flashcard_id, concept_id, role, confidence, mapping_status, source)
SELECT '${m.straddle}', c.id, 'SECONDARY', NULL, 'NEEDS_REVIEW', 'AI_PROPOSED'
  FROM public.concepts c WHERE c.slug = '${m.slugs[1]}';

-- ─── 6. Deprecate the parent LAST, with no successor ─────────────────────
UPDATE public.concepts
   SET status = 'DEPRECATED', deprecated_by = NULL, version = version + 1
 WHERE id = '${m.parentId}';

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; a UUID; b UUID; st TEXT; dep UUID;
BEGIN
  SELECT id INTO a FROM public.concepts WHERE slug = '${m.slugs[0]}';
  SELECT id INTO b FROM public.concepts WHERE slug = '${m.slugs[1]}';
  IF a IS NULL OR b IS NULL THEN RAISE EXCEPTION 'LIPID SPLIT: a child was not created'; END IF;
  IF a = b THEN RAISE EXCEPTION 'LIPID SPLIT: children share an id'; END IF;

  SELECT status, deprecated_by INTO st, dep FROM public.concepts WHERE id = '${m.parentId}';
  IF st <> 'DEPRECATED' THEN RAISE EXCEPTION 'LIPID SPLIT: parent is % not DEPRECATED', st; END IF;
  IF dep IS NOT NULL THEN RAISE EXCEPTION 'LIPID SPLIT: parent names a successor; a split has none'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${m.parentId}';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % flashcard mapping(s) left on the parent', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = '${m.parentId}';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % question mapping(s) left on the parent', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = a AND role = 'PRIMARY';
  IF n <> 6 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 6 primary cards on mobilization, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = b AND role = 'PRIMARY';
  IF n <> 15 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 15 primary cards on transport, found %', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = b AND role = 'SECONDARY';
  IF n <> 1 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 1 secondary card on transport, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = a;
  IF n <> 4 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 4 questions on mobilization, found %', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts WHERE concept_id = b;
  IF n <> 3 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 3 questions on transport, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id = '${m.straddle}' AND concept_id IN (a, b);
  IF n <> 2 THEN RAISE EXCEPTION 'LIPID SPLIT: straddle card has % rows, expected 2', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE flashcard_id = '${m.straddle}' AND concept_id = a AND role = 'PRIMARY';
  IF n <> 1 THEN RAISE EXCEPTION 'LIPID SPLIT: straddle card is not PRIMARY on mobilization'; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id IN (a, b) AND mapping_status <> 'NEEDS_REVIEW';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % card mapping(s) are not NEEDS_REVIEW', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts
   WHERE concept_id IN (a, b) AND mapping_status <> 'NEEDS_REVIEW';
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: % question mapping(s) are not NEEDS_REVIEW', n; END IF;

  SELECT count(*) INTO n FROM public.concept_sections WHERE concept_id IN (a, b);
  IF n <> 2 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 2 section rows, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines WHERE concept_id IN (a, b);
  IF n <> 2 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 2 discipline rows, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories WHERE concept_id IN (a, b);
  IF n <> 2 THEN RAISE EXCEPTION 'LIPID SPLIT: expected 2 category rows, found %', n; END IF;

  SELECT count(*) INTO n FROM public.concepts WHERE deprecated_by IN (a, b);
  IF n <> 0 THEN RAISE EXCEPTION 'LIPID SPLIT: something was pointed at a child as a successor'; END IF;

  RAISE NOTICE 'LIPID SPLIT OK: 2 children created, parent deprecated with no successor, 28 mappings redistributed, 1 secondary added, all NEEDS_REVIEW.';
END $$;

COMMIT;
`;
fs.writeFileSync("supabase/migrations/20260930_lipid_mobilization_split.sql", sql);
console.log("wrote supabase/migrations/20260930_lipid_mobilization_split.sql");
