import fs from "node:fs";
const s = JSON.parse(fs.readFileSync("scratchpad/defs/pre_state.json", "utf8"));
const RS = s.researchSettings, PDC = s.personalityDisorderClusters;
const DEF_RS = "Distinguishing basic, applied and clinical research from a study aim, its setting and how far the work is meant to translate, and judging which setting fits the question being asked. The operation is inferential: given a study described in a passage, work out what its setting affords in control and in generalisability, and therefore what its findings can and cannot support. Recognising the three labels is the vocabulary, not the objective.";
const DEF_PDC = "What personality disorders are as a class, how the DSM organises them into three clusters, the theme each cluster shares, and which disorders belong to which. The features and diagnostic criteria of the individual disorders live on the Cluster A, Cluster B and Cluster C concepts; this one holds the organising scheme and the membership.";

const sql = `-- ─── Migration 5: two definitions, and nothing else ───────────────────────
--
-- The cheapest migration in the sequence and the only remaining one that moves
-- no evidence at all. Two concepts get a definition; no mapping, taxonomy,
-- name, slug, type or hierarchy changes.
--
-- BOTH OF THESE ARE ITEMS WHERE THE ORIGINAL BRIEF'S PREMISE DID NOT SURVIVE
-- READING THE DATA, which is exactly why they need a definition: the database
-- held nothing that would stop the next reader reaching the same wrong
-- conclusion.
--
-- RESEARCH SETTINGS stays REASONING. Live state: object_type REASONING, 1
-- flashcard, 0 questions, and correctly zero section, discipline and category
-- rows, because a cross-cutting object carries no content taxonomy.
--
-- Its old definition read "Basic science versus applied and clinical settings,
-- and the control each affords", which describes three labels and invites the
-- reading that this is vocabulary recall filed on the wrong axis. The new one
-- states the inferential operation first and says outright that recognising the
-- labels is not the objective. The test for REASONING is what a question mapped
-- here would demand, not what its single card happens to look like, and that
-- distinction now lives in the row rather than in a report.
--
-- PERSONALITY DISORDER CLUSTERS stays CONTENT and is NOT deprecated. The brief
-- described it as an evidence-free umbrella above Cluster A, B and C. Live
-- state: it owns FIVE flashcards, the overlap with those three concepts is
-- ZERO, and none of the four has a parent_concept_id, so there is no hierarchy
-- to be an umbrella over. Its definition was NULL, which is how that reading
-- survived.
--
-- The new definition draws the line explicitly: this concept holds the
-- organising scheme and the membership, and the individual disorders' features
-- live on the cluster concepts. No parent_concept_id is added. The sibling
-- structure is correct as it stands and hierarchy for its own sake was ruled
-- out.
--
-- ON version AND updated_at. version is left alone: the established behaviour
-- in this programme is that a rename bumps it and a description-only edit does
-- not, which is what migrations 3 and 4 did. updated_at IS set here, because
-- the row genuinely changed. Worth recording that migrations 3 and 4 did not
-- set it when they wrote descriptions, so that column is not a reliable audit
-- trail across this sequence; git is.
--
-- Pre-state recorded immutably at scratchpad/defs/pre_state.json
-- (sha256 ${s.sha256.slice(0, 32)}).

BEGIN;

-- ─── Pre-conditions ──────────────────────────────────────────────────────
DO $$
DECLARE n INT; t TEXT; st TEXT;
BEGIN
  SELECT object_type, status INTO t, st FROM public.concepts WHERE id = '${RS.id}';
  IF t IS NULL THEN RAISE EXCEPTION 'DEFS: Research Settings not found at its expected UUID'; END IF;
  IF t <> 'REASONING' THEN RAISE EXCEPTION 'DEFS: Research Settings is %, expected REASONING', t; END IF;
  IF st <> 'ACTIVE_SEED' THEN RAISE EXCEPTION 'DEFS: Research Settings is %, expected ACTIVE_SEED', st; END IF;

  SELECT object_type, status INTO t, st FROM public.concepts WHERE id = '${PDC.id}';
  IF t IS NULL THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters not found at its expected UUID'; END IF;
  IF t <> 'CONTENT' THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters is %, expected CONTENT', t; END IF;
  IF st <> 'ACTIVE_SEED' THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters is %, expected ACTIVE_SEED', st; END IF;

  -- A REASONING object must carry no content taxonomy. If it did, that would be
  -- a defect outside this migration's approved scope and the right move is to
  -- stop rather than write a definition over it.
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.concept_sections WHERE concept_id = '${RS.id}'
    UNION ALL SELECT 1 FROM public.concept_disciplines WHERE concept_id = '${RS.id}'
    UNION ALL SELECT 1 FROM public.concept_content_categories WHERE concept_id = '${RS.id}') x;
  IF n <> 0 THEN RAISE EXCEPTION 'DEFS: Research Settings carries % content taxonomy row(s); stopping', n; END IF;

  SELECT count(*) INTO n FROM public.concept_sections WHERE concept_id = '${PDC.id}';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters has % section rows, expected 1', n; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines WHERE concept_id = '${PDC.id}';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters has % discipline rows, expected 1', n; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories WHERE concept_id = '${PDC.id}';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters has % category rows, expected 1', n; END IF;

  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${RS.id}';
  IF n <> ${RS.flashcardMappings.length} THEN RAISE EXCEPTION 'DEFS: Research Settings has % cards, expected ${RS.flashcardMappings.length}', n; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${PDC.id}';
  IF n <> ${PDC.flashcardMappings.length} THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters has % cards, expected ${PDC.flashcardMappings.length}', n; END IF;

  SELECT count(*) INTO n FROM public.concepts
   WHERE parent_concept_id IN ('${RS.id}', '${PDC.id}');
  IF n <> 0 THEN RAISE EXCEPTION 'DEFS: % concept(s) already claim one of these as a parent', n; END IF;
END $$;

-- ─── The only two writes in this migration ───────────────────────────────
UPDATE public.concepts
   SET description = $d$${DEF_RS}$d$, updated_at = now()
 WHERE id = '${RS.id}' AND object_type = 'REASONING';

UPDATE public.concepts
   SET description = $d$${DEF_PDC}$d$, updated_at = now()
 WHERE id = '${PDC.id}' AND object_type = 'CONTENT';

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $$
DECLARE n INT; d TEXT; c RECORD;
BEGIN
  SELECT * INTO c FROM public.concepts WHERE id = '${RS.id}';
  IF c.slug <> '${RS.slug}' OR c.canonical_name <> $n$${RS.canonicalName}$n$ THEN
    RAISE EXCEPTION 'DEFS: Research Settings slug or name changed';
  END IF;
  IF c.object_type <> 'REASONING' OR c.status <> 'ACTIVE_SEED' THEN
    RAISE EXCEPTION 'DEFS: Research Settings type or status changed';
  END IF;
  IF c.version <> ${RS.version} THEN RAISE EXCEPTION 'DEFS: Research Settings version moved to %', c.version; END IF;
  IF c.parent_concept_id IS NOT NULL THEN RAISE EXCEPTION 'DEFS: Research Settings gained a parent'; END IF;
  IF position('inferential' IN c.description) = 0 THEN
    RAISE EXCEPTION 'DEFS: the Research Settings definition must state the operation explicitly';
  END IF;

  SELECT * INTO c FROM public.concepts WHERE id = '${PDC.id}';
  IF c.slug <> '${PDC.slug}' OR c.canonical_name <> $n$${PDC.canonicalName}$n$ THEN
    RAISE EXCEPTION 'DEFS: Personality Disorder Clusters slug or name changed';
  END IF;
  IF c.object_type <> 'CONTENT' OR c.status <> 'ACTIVE_SEED' THEN
    RAISE EXCEPTION 'DEFS: Personality Disorder Clusters type or status changed';
  END IF;
  IF c.version <> ${PDC.version} THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters version moved to %', c.version; END IF;
  IF c.parent_concept_id IS NOT NULL THEN RAISE EXCEPTION 'DEFS: Personality Disorder Clusters gained a parent'; END IF;
  IF position('Cluster A, Cluster B and Cluster C' IN c.description) = 0 THEN
    RAISE EXCEPTION 'DEFS: the clusters definition must name where the individual disorders live';
  END IF;

  -- Taxonomy exactly as it was.
  SELECT count(*) INTO n FROM (
    SELECT 1 FROM public.concept_sections WHERE concept_id = '${RS.id}'
    UNION ALL SELECT 1 FROM public.concept_disciplines WHERE concept_id = '${RS.id}'
    UNION ALL SELECT 1 FROM public.concept_content_categories WHERE concept_id = '${RS.id}') x;
  IF n <> 0 THEN RAISE EXCEPTION 'DEFS: Research Settings acquired % taxonomy row(s)', n; END IF;
  SELECT count(*) INTO n FROM public.concept_sections WHERE concept_id = '${PDC.id}' AND section_code = 'PSYCH_SOC';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: the clusters section row changed'; END IF;
  SELECT count(*) INTO n FROM public.concept_disciplines WHERE concept_id = '${PDC.id}' AND discipline_code = 'PSYCHOLOGY';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: the clusters discipline row changed'; END IF;
  SELECT count(*) INTO n FROM public.concept_content_categories WHERE concept_id = '${PDC.id}';
  IF n <> 1 THEN RAISE EXCEPTION 'DEFS: the clusters category row changed'; END IF;

  -- No mapping moved, anywhere.
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${RS.id}';
  IF n <> ${RS.flashcardMappings.length} THEN RAISE EXCEPTION 'DEFS: Research Settings cards moved'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE concept_id = '${PDC.id}';
  IF n <> ${PDC.flashcardMappings.length} THEN RAISE EXCEPTION 'DEFS: clusters cards moved'; END IF;
  SELECT count(*) INTO n FROM public.flashcard_concepts;
  IF n <> ${s.totals.flashcardConcepts} THEN RAISE EXCEPTION 'DEFS: flashcard_concepts is %, expected ${s.totals.flashcardConcepts}', n; END IF;
  SELECT count(*) INTO n FROM public.question_concepts;
  IF n <> ${s.totals.questionConcepts} THEN RAISE EXCEPTION 'DEFS: question_concepts is %, expected ${s.totals.questionConcepts}', n; END IF;
  SELECT count(*) INTO n FROM public.question_reasoning_objects;
  IF n <> ${s.totals.reasoningObjects} THEN RAISE EXCEPTION 'DEFS: reasoning mappings is %, expected ${s.totals.reasoningObjects}', n; END IF;
  SELECT count(*) INTO n FROM public.concepts;
  IF n <> ${s.totals.concepts} THEN RAISE EXCEPTION 'DEFS: ontology objects is %, expected ${s.totals.concepts}', n; END IF;
  SELECT count(*) INTO n FROM public.concept_aliases;
  IF n <> ${s.totals.aliases} THEN RAISE EXCEPTION 'DEFS: aliases is %, expected ${s.totals.aliases}', n; END IF;
  SELECT count(*) INTO n FROM public.concepts WHERE status = 'DEPRECATED';
  IF n <> ${s.totals.deprecated} THEN RAISE EXCEPTION 'DEFS: deprecated is %, expected ${s.totals.deprecated}', n; END IF;

  RAISE NOTICE 'DEFS OK: 2 definitions written, 0 mappings moved, 0 taxonomy rows touched, 0 aliases filed.';
END $$;

COMMIT;
`;
fs.writeFileSync("supabase/migrations/20261005_research_settings_and_clusters_definitions.sql", sql);
console.log("wrote supabase/migrations/20261005_research_settings_and_clusters_definitions.sql");
