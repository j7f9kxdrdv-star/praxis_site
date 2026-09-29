import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/cardio_manifest.json","utf8"));
const q=s=>"'"+String(s).replace(/'/g,"''")+"'";
const C=await all("concepts","id,slug,canonical_name");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const SLUG={"Oxygen Delivery and Extraction":"OXYGEN_DELIVERY_EXTRACTION","Endothelial Control of Vascular Tone":"ENDOTHELIAL_CONTROL_VASCULAR_TONE"};
const DEF={
 "Oxygen Delivery and Extraction":"Oxygen content as bound plus dissolved, delivery as cardiac output times arterial content, and the extraction reserve a tissue holds between rest and maximal demand.",
 "Endothelial Control of Vascular Tone":"Endothelium-derived vasodilation, chiefly nitric oxide, matching local perfusion to demand, and what is lost when the endothelium is absent or inhibited."};
const newRepoint=M.repoint.filter(r=>r.new_is_new), oldRepoint=M.repoint.filter(r=>!r.new_is_new);
const nMerge=M.lifecycle.filter(l=>l.action==="MERGE_TO").length;
const L=[]; const P=s=>L.push(s);
P(`-- ============================================================
-- Cardiovascular question-side reconciliation
--
-- The last chapter of the concept layer. Its 99 concepts were one per question,
-- every description empty, every canonical_name copied from the question's own
-- subtopic. The flashcard backfill already moved 61 cards off them onto durable
-- curriculum concepts; this moves the questions, and retires the labels.
--
-- TWO NEW CONCEPTS THAT WILL HAVE NO FLASHCARDS. Oxygen Delivery and Extraction
-- holds 6 questions and Endothelial Control of Vascular Tone holds 4, and
-- neither has a card. That is a coverage state, not a defect. Nothing existing
-- could take them: Oxygen-Binding Proteins is binding chemistry rather than
-- delivery arithmetic, and the concept already named Extraction turns out to be
-- organic chemistry liquid-liquid extraction, a pure name collision. Forcing
-- either objective into a neighbour to reach BOTH_MODALITIES would put wrong
-- evidence on a concept that is already correct about something else.
--
-- SIX LABELS SURVIVE as genuine narrower facets, keeping their evidence as
-- SECONDARY while the durable concept takes PRIMARY: isovolumic contraction,
-- the hepatic portal route, sphygmomanometry technique, plasma versus serum,
-- extramedullary hemopoiesis and lacteal routing. Two labels that an earlier
-- draft would have retained are merged instead, because re-reading them showed
-- they restate clauses already inside The Lymphatic System's own definition.
--
-- THREE QUESTIONS WERE PLACED BY READING THEM, not by their label. The clearest
-- is Peritubular Capillary Conditions, which looks like Portal Circulations
-- because it spans two beds in series, but plasma protein climbing 7.0 to 8.7
-- g/dL across the glomerulus is a Starling force argument end to end.
--
-- ORDER MATTERS TWICE. The two new concepts are created before anything is
-- repointed onto them, and every repoint happens before any deprecation,
-- because the database refuses new mappings onto a deprecated concept.
--
-- PROVENANCE. AI_PROPOSED on every row written, matching the immune migration.
-- The design was approved; the destination of each row was chosen by analysis,
-- and calling that DETERMINISTIC would describe a derivation that did not happen.
--
-- NOT TOUCHED: flashcard_concepts, flashcard content, flashcard_reviews,
-- flashcard_user_state and every FSRS field, question_attempts, learner_events,
-- learner_state_snapshots, practice_sessions. No question id changes, so every
-- historical attempt stays attached to exactly the question it was recorded
-- against. Only semantic metadata moves.
--
-- NOT DONE HERE: question-to-REASONING mappings. 13 of these questions name an
-- experimental operation and a candidate ledger exists, but question_concepts
-- stays CONTENT-only until that relation is designed.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The two question-only CONTENT concepts, with their taxonomy.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES`);
P(Object.entries(SLUG).map(([n,s])=>`  (${q(s)}, ${q(n)}, ${q(DEF[n])}, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT')`).join(",\n")+`
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, 'BIO_BIOCHEM', true FROM public.concepts c WHERE c.slug IN (${Object.values(SLUG).map(q).join(", ")})
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, 'BIOLOGY', 'PRIMARY' FROM public.concepts c WHERE c.slug IN (${Object.values(SLUG).map(q).join(", ")})
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, 'Organ Systems', true FROM public.concepts c WHERE c.slug IN (${Object.values(SLUG).map(q).join(", ")})
ON CONFLICT DO NOTHING;

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN (${Object.values(SLUG).map(q).join(", ")});
  IF n <> 2 THEN RAISE EXCEPTION 'expected 2 new concepts, found %', n; END IF;
  SELECT count(*) INTO n FROM public.concepts c
    WHERE c.slug IN (${Object.values(SLUG).map(q).join(", ")})
      AND EXISTS (SELECT 1 FROM public.concept_sections s WHERE s.concept_id=c.id)
      AND EXISTS (SELECT 1 FROM public.concept_disciplines d WHERE d.concept_id=c.id)
      AND EXISTS (SELECT 1 FROM public.concept_content_categories k WHERE k.concept_id=c.id);
  IF n <> 2 THEN RAISE EXCEPTION 'a new concept is missing taxonomy (% complete)', n; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 2. Repoint ${oldRepoint.length} questions onto existing durable concepts.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = v.new_id::uuid, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
FROM (VALUES`);
P(oldRepoint.map(r=>`  (${q(r.question_id)}, ${q(r.old_concept_id)}, ${q(r.new_concept_id)})`).join(",\n"));
P(`) AS v(question_id, old_id, new_id)
WHERE qc.question_id = v.question_id::uuid AND qc.concept_id = v.old_id::uuid AND qc.role = 'PRIMARY';`);

P(`
-- ────────────────────────────────────────────────────────────
-- 3. Repoint ${newRepoint.length} questions onto the two concepts just created.
--    Resolved by slug, so this cannot run before step 1.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = c.id, mapping_status = 'AI_PROPOSED', source = 'AI_PROPOSED'
FROM (VALUES`);
P(newRepoint.map(r=>`  (${q(r.question_id)}, ${q(r.old_concept_id)}, ${q(SLUG[r.new_label])})`).join(",\n"));
P(`) AS v(question_id, old_id, slug)
JOIN public.concepts c ON c.slug = v.slug
WHERE qc.question_id = v.question_id::uuid AND qc.concept_id = v.old_id::uuid AND qc.role = 'PRIMARY';

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.questions qu ON qu.id = qc.question_id
    WHERE qu.topic = 'The Cardiovascular System' AND qc.role = 'PRIMARY' AND qc.source = 'AI_PROPOSED';
  IF n <> ${M.repoint.length} THEN RAISE EXCEPTION 'expected ${M.repoint.length} repointed mappings, found %', n; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 4. The one cardiovascular question that was never mapped.
--    Confinement of Clotting to the Injury Site. The two correct mechanisms are
--    plasma anticoagulants inactivating enzymes swept downstream, and intact
--    endothelium keeping subendothelial collagen covered. Both are controls on
--    the coagulation cascade.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES`);
P(M.insert.map(r=>`  (${q(r.question_id)}::uuid, ${q(r.new_concept_id)}::uuid, 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED')`).join(",\n")+";");

P(`
-- ────────────────────────────────────────────────────────────
-- 5. The six retained sub-objectives keep their evidence as SECONDARY.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES`);
P(M.secondary.map((r,i)=>`  -- ${r.label}\n  (${q(r.question_id)}::uuid, ${q(r.concept_id)}::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED')${i<M.secondary.length-1?",":";"}`).join("\n"));

const mergedExisting=M.lifecycle.filter(l=>l.action==="MERGE_TO"&&!l.successor_is_new);
const mergedNew=M.lifecycle.filter(l=>l.action==="MERGE_TO"&&l.successor_is_new);
P(`
-- ────────────────────────────────────────────────────────────
-- 6. Deprecate the ${nMerge} merged labels. AFTER every repoint.
--    deprecated_by names the successor, so the lineage survives.
-- ────────────────────────────────────────────────────────────
UPDATE public.concepts c
SET status = 'DEPRECATED', deprecated_by = v.successor::uuid, version = c.version + 1, updated_at = now()
FROM (VALUES`);
P(mergedExisting.map(l=>`  (${q(l.concept_id)}, ${q(l.successor_id)})`).join(",\n"));
P(`) AS v(id, successor)
WHERE c.id = v.id::uuid;

-- The ${mergedNew.length} whose successor is one of the concepts created in step 1.
UPDATE public.concepts c
SET status = 'DEPRECATED', deprecated_by = s.id, version = c.version + 1, updated_at = now()
FROM (VALUES`);
P(mergedNew.map(l=>`  (${q(l.concept_id)}, ${q(SLUG[l.successor])})`).join(",\n"));
P(`) AS v(id, slug)
JOIN public.concepts s ON s.slug = v.slug
WHERE c.id = v.id::uuid;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 7. Verification inside the transaction.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  SELECT count(*) INTO v FROM (
    SELECT qu.id FROM public.questions qu
    LEFT JOIN public.question_concepts qc ON qc.question_id = qu.id AND qc.role = 'PRIMARY'
    WHERE qu.topic = 'The Cardiovascular System'
    GROUP BY qu.id HAVING count(qc.concept_id) <> 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% cardiovascular questions lack exactly one PRIMARY', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF v <> 0 THEN RAISE EXCEPTION '% mappings still point at a deprecated concept', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.object_type <> 'CONTENT';
  IF v <> 0 THEN RAISE EXCEPTION '% question mappings point at a non-CONTENT object', v; END IF;

  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED';
  IF v <> ${83+nMerge} THEN RAISE EXCEPTION 'expected ${83+nMerge} deprecated concepts, found %', v; END IF;
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED' AND deprecated_by IS NULL;
  IF v <> 0 THEN RAISE EXCEPTION '% deprecated concepts have no successor', v; END IF;
  SELECT count(*) INTO v FROM public.concepts c
    WHERE c.deprecated_by IS NOT NULL AND NOT EXISTS (SELECT 1 FROM public.concepts s WHERE s.id = c.deprecated_by);
  IF v <> 0 THEN RAISE EXCEPTION '% dangling successor references', v; END IF;

  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard mappings changed: %', v; END IF;

  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2673 THEN RAISE EXCEPTION 'expected 2673 question mappings, found %', v; END IF;

  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1129 THEN RAISE EXCEPTION 'expected 1129 concepts, found %', v; END IF;

  SELECT count(*) INTO v FROM (SELECT question_id FROM public.question_concepts
    WHERE role = 'PRIMARY' GROUP BY question_id HAVING count(*) > 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% questions carry more than one PRIMARY', v; END IF;
END $$;

-- The durable cardiovascular layer and what it now holds.
SELECT c.canonical_name,
       count(*) FILTER (WHERE qc.role = 'PRIMARY') AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c
LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.status = 'ACTIVE_SEED' AND EXISTS (
  SELECT 1 FROM public.question_concepts x JOIN public.questions y ON y.id = x.question_id
  WHERE x.concept_id = c.id AND y.topic = 'The Cardiovascular System')
GROUP BY c.id, c.canonical_name ORDER BY 2 DESC;

-- The two question-only concepts. Expect 6 and 4 questions, 0 flashcards each.
SELECT c.canonical_name, count(qc.*) AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.slug IN (${Object.values(SLUG).map(q).join(", ")})
GROUP BY c.id, c.canonical_name;

COMMIT;`);
const out="supabase/migrations/20260929_cardio_question_reconciliation.sql";
fs.writeFileSync(out,L.join("\n")+"\n");
console.log(`wrote ${out}`);
console.log(`  repoint ${oldRepoint.length} existing + ${newRepoint.length} onto new | insert ${M.insert.length} | secondary ${M.secondary.length}`);
console.log(`  deprecate ${mergedExisting.length} + ${mergedNew.length} = ${nMerge} | new concepts 2`);
console.log(`  concepts 1127 -> 1129 | question mappings 2666 -> 2673 | lines ${L.join("\n").split("\n").length}`);
