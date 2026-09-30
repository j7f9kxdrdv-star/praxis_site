import fs from "node:fs";
const {rows,noMap}=JSON.parse(fs.readFileSync("/tmp/m3_manifest.json","utf8"));
const q=s=>"'"+String(s).replace(/'/g,"''")+"'";
const by=t=>rows.filter(r=>r.target===t);
const L=[]; const P=s=>L.push(s);
P(`-- ============================================================
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
VALUES`);
const lines=[];
for(const t of ["Variables and Controls","Data Interpretation","Causal Inference"]){
  lines.push(`  -- ${t}  (${by(t).length})`);
  for(const r of by(t)) lines.push(`  (${q(r.question_id)}::uuid, ${q(r.concept_id)}::uuid, ${r.confidence.toFixed(2)}, 'AI_PROPOSED', 'AI_PROPOSED'),   -- ${r.subtopic}`);
}
// the delimiter must not sit behind a comment, so rebuild the last data line
const lastIdx=lines.length-1;
lines[lastIdx]=lines[lastIdx].replace(/\),   -- /, ");   -- ");
P(lines.join("\n"));
P(`
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
    WHERE question_id IN (${noMap.map(n=>q(n.question_id)+"::uuid").join(", ")});
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

COMMIT;`);
const out="supabase/migrations/20260930_seed_reasoning_mappings.sql";
fs.writeFileSync(out,L.join("\n")+"\n");
console.log(`wrote ${out}`);
console.log(`  rows ${rows.length} | lines ${L.join("\n").split("\n").length}`);
