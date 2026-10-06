// Emits the final governance migration FROM THE MANIFEST. No mapping is typed
// by hand here: every uuid comes out of manifest.json, which is itself built
// from the live queue and carries one human decision per row.
import fs from "node:fs";
const MAN = JSON.parse(fs.readFileSync("scratchpad/review/manifest.json", "utf8"));
const SNAP = JSON.parse(fs.readFileSync("scratchpad/govern/pre_state.json", "utf8"));
const OUT = "supabase/migrations/20261006_03_lipid_split_governance.sql";
const SYNTH = "066ad4c3-e5b1-49b4-b8a2-951a8f721eed";
const ROW17 = "7d0c69e5-1e1d-4061-826a-dd4ad94dc426";

const dec = MAN.decisions;
const adds = dec.flatMap((d) => (d.additions || []).map((a) => ({ ...a, row: d.row })));
const byTable = (t) => dec.filter((d) => d.table === t);
const cards = byTable("flashcard_concepts"), qs = byTable("question_concepts");
const srcOf = (t, s) => dec.filter((d) => d.table === t && SNAP.reviewedRows.find((r) => r.row === d.row).liveBefore.source === s).length;

const DEFINITION = "De novo production of lipid: the synthesis of cholesterol and of triacylglycerol from carbon precursors. Covers the citrate shuttle that carries acetyl-CoA into the cytosol, the acetyl-CoA, NADPH and ATP requirements, HMG-CoA reductase as the rate-limiting step, and the feedback and hormonal regulation of that step. It does not cover lipoprotein particle identity, particle density or ordering, particle cargo and destination, or the LCAT and CETP transfer reactions, all of which remain under Lipoprotein Classes & Cholesterol Transport.";
const NEW_CARD_TEXT = "Cells obtain cholesterol either by receptor-mediated uptake of circulating {{c1::LDL}} or by {{c2::de novo}} synthesis.";

const vals = (rows, key) => rows.map((d) => `    ('${d.item_id}'::uuid, '${d.approved_concept_id}'::uuid)`).join(",\n");
// A rationale is wrapped across comment lines rather than cut off: this file is
// the permanent record of why each row exists.
const wrapComment = (text) => {
  const out = []; let line = "  --";
  for (const w of text.split(/\s+/)) {
    if ((line + " " + w).length > 76) { out.push(line); line = "  --  " + w; } else { line += " " + w; }
  }
  out.push(line); return out.join("\n");
};
const rowComment = (d) => `  -- row ${String(d.row).padStart(2)}  ${d.approved_role.padEnd(9)} ${d.item_id.slice(0, 8)}  ${d.approved_concept}`;

const sql = `-- ─── The final lipid-split governance migration ───────────────────────────
-- REQUIRES: 20260930_lipid_mobilization_split.sql
-- because it closes the 29 NEEDS_REVIEW rows that migration created.
--
-- GENERATED FROM scratchpad/review/manifest.json. No mapping in this file was
-- typed by hand. The manifest holds one explicit human decision per row, each
-- with a reviewer, a timestamp and a rationale, recorded over three review
-- batches. Pre-state snapshot: sha256 ${SNAP.sha256.slice(0, 16)}, taken ${SNAP.takenAt}.
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
-- ${srcOf("flashcard_concepts", "AI_PROPOSED")} AI_PROPOSED cards and ${srcOf("question_concepts", "DETERMINISTIC_EXACT")} DETERMINISTIC_EXACT questions, and only
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
-- ${SNAP.row17Card.schedulerRows.length} scheduler rows and ${SNAP.row17Card.reviews.length} reviews. Scheduler state is keyed to
-- (flashcard_id, cloze_index) and survives a text edit whether or not the text
-- still asks the same thing, so the new wording keeps c1 = LDL and c2 = de novo
-- exactly. The fix is to the science only: the old text called LDL delivery
-- "dietary uptake", but LDL cholesterol leaves the liver inside VLDL, which
-- carries both dietary and de novo cholesterol.
--
-- WRITES: concepts (1 description), flashcard_concepts (${cards.length} status upgrades,
-- 2 inserts), question_concepts (${qs.length} status upgrades), flashcards (1 text).
-- Touches no learner table, no FSRS state, no review history, no attempt, no
-- session, no snapshot, and no row in question_reasoning_objects.

BEGIN;

-- ─── 0. Pre-conditions. Drift aborts the whole transaction ───────────────
DO $pre$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE mapping_status = 'NEEDS_REVIEW';
  IF n <> ${cards.length} THEN RAISE EXCEPTION 'expected ${cards.length} NEEDS_REVIEW card rows, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE mapping_status = 'NEEDS_REVIEW';
  IF n <> ${qs.length} THEN RAISE EXCEPTION 'expected ${qs.length} NEEDS_REVIEW question rows, found %', n; END IF;

  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.flashcard_concepts WHERE mapping_status = 'HUMAN_VALIDATED'
    UNION ALL
    SELECT 1 FROM public.question_concepts WHERE mapping_status = 'HUMAN_VALIDATED') x;
  IF n <> 0 THEN RAISE EXCEPTION 'expected no HUMAN_VALIDATED mapping to exist yet, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE concept_id = '${SYNTH}'::uuid
     AND flashcard_id IN (${adds.map((a) => `'${a.item_id}'::uuid`).join(", ")});
  IF n <> 0 THEN RAISE EXCEPTION 'an approved SECONDARY already exists; refusing to duplicate (% found)', n; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE id = '${SYNTH}'::uuid AND status <> 'DEPRECATED' AND description IS NULL;
  IF n <> 1 THEN RAISE EXCEPTION 'the definition target is missing, deprecated, or already described'; END IF;

  SELECT count(*) INTO n FROM public.flashcards
   WHERE id = '${ROW17}'::uuid AND cloze_text LIKE '%dietary uptake%' AND cloze_count = 2;
  IF n <> 1 THEN RAISE EXCEPTION 'row 17 card is not in the expected pre-state'; END IF;

  RAISE NOTICE 'pre-conditions hold: ${dec.length} rows in review, nothing human-validated yet';
END $pre$;

-- ─── 1. The definition lands BEFORE the new human-validated evidence ────
-- Approved scope, recorded in the manifest as pending action
-- define-cholesterol-tag-synthesis. Description only: moves no evidence,
-- renames nothing, so no alias is filed and no mapping moves.
UPDATE public.concepts
   SET description = '${DEFINITION}',
       version = version + 1
 WHERE id = '${SYNTH}'::uuid
   AND description IS NULL;

-- ─── 2. The 29 reviewed rows become HUMAN_VALIDATED ─────────────────────
-- source is NOT touched. reviewed_at records the act; see the header.
${cards.map(rowComment).join("\n")}
WITH approved(item, concept) AS (VALUES
${vals(cards)}
)
UPDATE public.flashcard_concepts fc
   SET mapping_status = 'HUMAN_VALIDATED',
       reviewed_at    = now()
  FROM approved a
 WHERE fc.flashcard_id = a.item
   AND fc.concept_id   = a.concept
   AND fc.mapping_status = 'NEEDS_REVIEW';

${qs.map(rowComment).join("\n")}
WITH approved(item, concept) AS (VALUES
${vals(qs)}
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
${adds.map((a) => wrapComment(`row ${a.row}  card ${a.item_id.slice(0, 8)}  ${a.rationale}`)).join("\n")}
INSERT INTO public.flashcard_concepts
  (flashcard_id, concept_id, role, confidence, mapping_status, source, reviewed_at)
VALUES
${adds.map((a) => `  ('${a.item_id}'::uuid, '${a.concept_id}'::uuid, 'SECONDARY', NULL, 'HUMAN_VALIDATED', 'HUMAN_REVIEWED', now())`).join(",\n")};

-- ─── 4. Row 17: the wording correction, same clozes ─────────────────────
UPDATE public.flashcards
   SET cloze_text = '${NEW_CARD_TEXT}'
 WHERE id = '${ROW17}'::uuid
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
  IF n <> ${cards.length + adds.length} THEN RAISE EXCEPTION 'expected ${cards.length + adds.length} human-validated card rows, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts WHERE mapping_status = 'HUMAN_VALIDATED';
  IF n <> ${qs.length} THEN RAISE EXCEPTION 'expected ${qs.length} human-validated question rows, found %', n; END IF;

  -- Origins preserved on the reviewed rows, declared on the new ones.
  SELECT count(*) INTO n FROM public.flashcard_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED' AND source = 'AI_PROPOSED';
  IF n <> ${srcOf("flashcard_concepts", "AI_PROPOSED")} THEN RAISE EXCEPTION 'expected ${srcOf("flashcard_concepts", "AI_PROPOSED")} reviewed card rows to keep source AI_PROPOSED, found %', n; END IF;

  SELECT count(*) INTO n FROM public.question_concepts
   WHERE mapping_status = 'HUMAN_VALIDATED' AND source = 'DETERMINISTIC_EXACT';
  IF n <> ${srcOf("question_concepts", "DETERMINISTIC_EXACT")} THEN RAISE EXCEPTION 'expected ${srcOf("question_concepts", "DETERMINISTIC_EXACT")} reviewed question rows to keep source DETERMINISTIC_EXACT, found %', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE source = 'HUMAN_REVIEWED';
  IF n <> ${adds.length} THEN RAISE EXCEPTION 'expected ${adds.length} rows with source HUMAN_REVIEWED, found %', n; END IF;

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
  IF n <> ${dec.length + adds.length} THEN RAISE EXCEPTION 'expected ${dec.length + adds.length} rows stamped reviewed_at, found %', n; END IF;

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
  SELECT description INTO t FROM public.concepts WHERE id = '${SYNTH}'::uuid;
  IF t IS NULL OR length(t) < 200 OR t NOT LIKE '%HMG-CoA reductase%' OR t NOT LIKE '%does not cover%'
    THEN RAISE EXCEPTION 'the synthesis definition is missing or incomplete'; END IF;

  -- The card reworded, both cloze indices intact, no third cloze introduced.
  SELECT count(*) INTO n FROM public.flashcards
   WHERE id = '${ROW17}'::uuid
     AND cloze_text LIKE '%{{c1::LDL}}%'
     AND cloze_text LIKE '%{{c2::de novo}}%'
     AND cloze_text NOT LIKE '%dietary uptake%'
     AND cloze_text NOT LIKE '%{{c3::%'
     AND cloze_count = 2;
  IF n <> 1 THEN RAISE EXCEPTION 'row 17 card did not reword cleanly'; END IF;

  RAISE NOTICE 'governance complete: ${dec.length} rows validated, ${adds.length} added, 1 definition, 1 rewording';
END $post$;

COMMIT;
`;
fs.writeFileSync(OUT, sql);
console.log(`WROTE ${OUT}  ${sql.split("\n").length} lines`);
console.log(`  ${cards.length} card status upgrades, ${qs.length} question status upgrades, ${adds.length} inserts`);
console.log(`  origins preserved: ${srcOf("flashcard_concepts", "AI_PROPOSED")} AI_PROPOSED cards, ${srcOf("question_concepts", "DETERMINISTIC_EXACT")} DETERMINISTIC_EXACT questions`);
