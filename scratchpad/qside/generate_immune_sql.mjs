import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/immune_manifest.json","utf8"));
const q=s=>"'"+String(s).replace(/'/g,"''")+"'";
const C=await all("concepts","id,slug,canonical_name,version");
const ver=new Map(C.map(c=>[c.id,c.version]));
const L=[];const P=s=>L.push(s);
const nRepoint=M.repoint.length, nIns=M.insert.length, nSec=M.secondary.length,
      nMerge=M.lifecycle.filter(l=>l.action==="MERGE_TO").length, nAlias=M.aliases.length;
P(`-- ============================================================
-- Immune question-side reconciliation
--
-- Moves all 90 Immune questions onto durable curriculum concepts and retires the
-- question-instance labels they were filed under. This is the other half of the
-- backfill: the cards already point at these 19 concepts, and after this the
-- questions do too, so memory and application finally share one id.
--
-- WHAT THE OLD LABELS WERE. 89 objects for 90 questions, one question each, every
-- description empty, every canonical_name copied verbatim from the question's own
-- subtopic. They are a question index wearing concept clothing. Retiring them is
-- not a cleanup of untidy names, it is removing identities that cannot carry
-- evidence past the life of a single question.
--
-- NOTHING IS DELETED. Every repoint is an UPDATE that preserves the row and its
-- history, and the manifest records each question's old concept_id so this is
-- readable backwards. Each retired label is DEPRECATED with deprecated_by
-- pointing at its successor, so an attempt recorded against it years from now
-- can still be explained.
--
-- SIX LABELS SURVIVE. Skin as a Physical Barrier, Gastric Acid as a Chemical
-- Barrier, Colonization Resistance by Resident Flora, Chemotaxis and Gradient
-- Sensing, Population Value of MHC Allele Diversity and Epitope Size and
-- Response Diversity are genuinely narrower facets, not synonyms. Each keeps its
-- evidence as a SECONDARY mapping on the same question while the durable concept
-- takes PRIMARY, and each is flagged for the hierarchy review the ontology
-- cannot express yet. Four other class-A labels MERGE instead, because they name
-- the durable concept's whole subject rather than a part of it.
--
-- ORDER MATTERS. Repointing happens BEFORE deprecation, because the database
-- refuses new mappings onto a deprecated concept.
--
-- PROVENANCE. The old mappings were DETERMINISTIC, meaning derived by exact
-- subtopic match. Their destination is now chosen by analysis, so every row this
-- migration writes becomes AI_PROPOSED. Claiming DETERMINISTIC for a judgement
-- would be a lie about how the row was produced.
--
-- NOT TOUCHED: flashcard_concepts, flashcard_reviews, flashcard_user_state and
-- every FSRS field, question_attempts, learner_events, learner_state_snapshots,
-- practice_sessions. Questions keep their ids, so historical attempts stay
-- attached to exactly the same questions. Only the semantic metadata moves.
--
-- NOT DONE HERE: question-to-REASONING mappings. 23 of these questions name an
-- experimental operation, and a candidate report exists, but question_concepts
-- stays CONTENT-only until that relation is designed and approved.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. Repoint ${nRepoint} question mappings onto durable concepts.
--    UPDATE in place: the row, and anything referencing it, survives.
-- ────────────────────────────────────────────────────────────
UPDATE public.question_concepts qc
SET concept_id = v.new_id::uuid,
    mapping_status = 'AI_PROPOSED',
    source = 'AI_PROPOSED'
FROM (VALUES`);
P(M.repoint.map(r=>`  (${q(r.question_id)}, ${q(r.old_concept_id)}, ${q(r.new_concept_id)})`).join(",\n"));
P(`) AS v(question_id, old_id, new_id)
WHERE qc.question_id = v.question_id::uuid
  AND qc.concept_id  = v.old_id::uuid
  AND qc.role = 'PRIMARY';

DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.question_concepts qc
    JOIN public.questions qu ON qu.id = qc.question_id
    WHERE qu.topic = 'The Immune System' AND qc.role = 'PRIMARY' AND qc.source = 'AI_PROPOSED';
  IF n <> ${nRepoint} THEN RAISE EXCEPTION 'expected ${nRepoint} repointed immune mappings, found %', n; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 2. The one Immune question that was never mapped.
--    Random Repertoire and the Need for Tolerance. The stem describes random
--    gene-segment joining, but the tested inference is why a dedicated screen is
--    needed at all: blind recombination inevitably produces self-fitting sites.
--    That is negative selection, not diversity generation, which is why the
--    earlier design's destination was wrong.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES`);
P(M.insert.map(r=>`  (${q(r.question_id)}::uuid, ${q(r.new_concept_id)}::uuid, 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED')`).join(",\n")+";");

P(`
-- ────────────────────────────────────────────────────────────
-- 3. The six retained sub-objectives keep their evidence as SECONDARY.
--    question_concepts_one_primary allows exactly one PRIMARY per question and
--    any number of SECONDARY rows, so the durable concept and the narrower facet
--    can both be true of the same question without competing.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.question_concepts (question_id, concept_id, role, mapping_status, source)
VALUES`);
P(M.secondary.map(r=>`  (${q(r.question_id)}::uuid, ${q(r.concept_id)}::uuid, 'SECONDARY', 'AI_PROPOSED', 'AI_PROPOSED')  -- ${r.label}`).join(",\n")+";");

P(`
-- ────────────────────────────────────────────────────────────
-- 4. Aliases, for the four merged labels that name a real searchable term.
--    Declined for the other 79: "Why A Coated Organism Is The One That
--    Overwhelms" is a question stem, and 79 of those would turn the alias table
--    into a scenario index. deprecated_by already preserves the lineage.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concept_aliases (concept_id, alias, alias_type, source, status)
VALUES`);
P(M.aliases.map(r=>`  (${q(r.concept_id)}::uuid, ${q(r.alias)}, 'LEGACY_NAME', 'AI_PROPOSED', 'AI_PROPOSED')`).join(",\n")+`
ON CONFLICT DO NOTHING;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 5. Deprecate the ${nMerge} merged labels. AFTER the repoint, never before.
--    status DEPRECATED blocks new mappings; deprecated_by names the successor so
--    the lineage is recoverable. The object itself stays.
-- ────────────────────────────────────────────────────────────
UPDATE public.concepts c
SET status = 'DEPRECATED',
    deprecated_by = v.successor::uuid,
    version = c.version + 1,
    updated_at = now()
FROM (VALUES`);
P(M.lifecycle.filter(l=>l.action==="MERGE_TO").map(l=>`  (${q(l.concept_id)}, ${q(l.successor_id)})`).join(",\n"));
P(`) AS v(id, successor)
WHERE c.id = v.id::uuid;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 6. Verification inside the transaction.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  -- Every Immune question now carries exactly one PRIMARY.
  SELECT count(*) INTO v FROM (
    SELECT qu.id FROM public.questions qu
    LEFT JOIN public.question_concepts qc ON qc.question_id = qu.id AND qc.role = 'PRIMARY'
    WHERE qu.topic = 'The Immune System'
    GROUP BY qu.id HAVING count(qc.concept_id) <> 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% immune questions lack exactly one PRIMARY concept', v; END IF;

  -- No question mapping may point at a DEPRECATED concept.
  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.status = 'DEPRECATED';
  IF v <> 0 THEN RAISE EXCEPTION '% mappings still point at a deprecated concept', v; END IF;

  -- question_concepts stays CONTENT-only.
  SELECT count(*) INTO v FROM public.question_concepts qc
    JOIN public.concepts c ON c.id = qc.concept_id WHERE c.object_type <> 'CONTENT';
  IF v <> 0 THEN RAISE EXCEPTION '% question mappings point at a non-CONTENT object', v; END IF;

  -- Exactly ${nMerge} labels deprecated, each with a successor.
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED';
  IF v <> ${nMerge} THEN RAISE EXCEPTION 'expected ${nMerge} deprecated concepts, found %', v; END IF;
  SELECT count(*) INTO v FROM public.concepts WHERE status = 'DEPRECATED' AND deprecated_by IS NULL;
  IF v <> 0 THEN RAISE EXCEPTION '% deprecated concepts have no successor', v; END IF;

  -- Flashcard mappings untouched.
  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'flashcard mappings changed: %', v; END IF;

  -- Question mappings: 2659 + ${nIns} insert + ${nSec} secondary.
  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> ${2659+nIns+nSec} THEN RAISE EXCEPTION 'expected ${2659+nIns+nSec} question mappings, found %', v; END IF;

  -- Ontology size unchanged: this migration creates no objects.
  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1127 THEN RAISE EXCEPTION 'concept count changed: %', v; END IF;
END $$;

-- Every durable Immune concept and what it now holds.
SELECT c.canonical_name,
       count(*) FILTER (WHERE qc.role = 'PRIMARY')   AS questions,
       (SELECT count(*) FROM public.flashcard_concepts f WHERE f.concept_id = c.id) AS flashcards
FROM public.concepts c
LEFT JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.id IN (${[...new Set(M.repoint.map(r=>r.new_concept_id).concat(M.insert.map(r=>r.new_concept_id)))].map(x=>q(x)+"::uuid").join(", ")})
GROUP BY c.id, c.canonical_name ORDER BY 2 DESC;

-- The six retained sub-objectives: zero PRIMARY, one SECONDARY each.
SELECT c.canonical_name, qc.role, count(*)
FROM public.concepts c JOIN public.question_concepts qc ON qc.concept_id = c.id
WHERE c.id IN (${M.secondary.map(r=>q(r.concept_id)+"::uuid").join(", ")})
GROUP BY 1,2 ORDER BY 1;

COMMIT;`);
const out="supabase/migrations/20260926_immune_question_reconciliation.sql";
fs.writeFileSync(out,L.join("\n")+"\n");
console.log(`wrote ${out}`);
console.log(`  repoint ${nRepoint} | insert ${nIns} | secondary ${nSec} | aliases ${nAlias} | deprecate ${nMerge}`);
console.log(`  question mappings 2659 -> ${2659+nIns+nSec}`);
console.log(`  lines ${L.join("\n").split("\n").length}`);
