-- ============================================================
-- object_type: three kinds of learning object in one table
--
-- APPROVED ARCHITECTURE. A flashcard must resolve to exactly one learning
-- target, and there are three legitimate kinds: disciplinary CONTENT, a
-- cross-cutting REASONING operation, and foundational QUANTITATIVE knowledge.
--
-- WHY NOT A SUPERTYPE TABLE. All three share every structural property already
-- built and tested here: stable id, canonical name, description, aliases,
-- status, versioning, deprecation, the human-validation trigger, and the
-- flashcard_concepts join. A LEARNING_OBJECT supertype would duplicate all of
-- that and force a polymorphic foreign key into flashcard_concepts. One column
-- with a CHECK is smaller, and the 576 existing rows migrate by defaulting.
--
-- THE RISK THIS CREATES, AND THE ANSWER TO IT. Three kinds of thing in one
-- table means a content query that forgets to filter silently starts counting
-- "confounding" as biology. Convention will not hold that line, so the boundary
-- is enforced three ways: a view per type, a constraint that stops a
-- cross-cutting object acquiring content taxonomy, and verifier checks.
--
-- Additive and reversible. No existing row changes meaning: everything already
-- in the table IS content.
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. The column
-- ────────────────────────────────────────────────────────────
ALTER TABLE public.concepts
  ADD COLUMN IF NOT EXISTS object_type TEXT NOT NULL DEFAULT 'CONTENT';

ALTER TABLE public.concepts DROP CONSTRAINT IF EXISTS concepts_object_type_check;
ALTER TABLE public.concepts ADD CONSTRAINT concepts_object_type_check
  CHECK (object_type IN ('CONTENT', 'REASONING', 'QUANTITATIVE'));

COMMENT ON COLUMN public.concepts.object_type IS
  'What KIND of learning object this is. CONTENT is disciplinary knowledge and the only kind that may enter memory-versus-application content analytics. REASONING is a cross-cutting analytical operation (confounding, blinding). QUANTITATIVE is foundational tool knowledge (logarithms, standard deviation). Defaults to CONTENT, which is what every pre-existing row is.';

CREATE INDEX IF NOT EXISTS concepts_object_type_idx ON public.concepts(object_type);

-- ────────────────────────────────────────────────────────────
-- 2. A cross-cutting object may not carry content taxonomy
--
-- Section, discipline and AAMC category are properties of DISCIPLINARY
-- content. "Confounding" has no MCAT section and no discipline; inventing one
-- to make the database look complete would be a lie that later analytics would
-- read as fact. Zero rows is the honest representation, and these triggers make
-- it the only representation available.
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.reject_taxonomy_on_non_content()
RETURNS TRIGGER AS $$
DECLARE t TEXT;
BEGIN
  SELECT object_type INTO t FROM public.concepts WHERE id = NEW.concept_id;
  IF t IS DISTINCT FROM 'CONTENT' THEN
    RAISE EXCEPTION
      'Concept % is %, not CONTENT, and may not carry % rows. Section, discipline and AAMC category describe disciplinary content; a cross-cutting object legitimately has none.',
      NEW.concept_id, t, TG_TABLE_NAME;
  END IF;
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DO $$
DECLARE t TEXT;
BEGIN
  FOREACH t IN ARRAY ARRAY['concept_sections','concept_disciplines','concept_content_categories'] LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS %I ON public.%I', t||'_content_only', t);
    EXECUTE format(
      'CREATE TRIGGER %I BEFORE INSERT OR UPDATE ON public.%I FOR EACH ROW EXECUTE FUNCTION public.reject_taxonomy_on_non_content()',
      t||'_content_only', t);
  END LOOP;
END $$;

-- ────────────────────────────────────────────────────────────
-- 3. One view per type
--
-- So a content query says what it means. Any feature measuring disciplinary
-- content reads content_concepts and cannot accidentally include the other two.
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW public.content_concepts AS
  SELECT * FROM public.concepts WHERE object_type = 'CONTENT';
CREATE OR REPLACE VIEW public.reasoning_objects AS
  SELECT * FROM public.concepts WHERE object_type = 'REASONING';
CREATE OR REPLACE VIEW public.quantitative_objects AS
  SELECT * FROM public.concepts WHERE object_type = 'QUANTITATIVE';

COMMENT ON VIEW public.content_concepts IS
  'Disciplinary content only. Memory-versus-application, content coverage, content weakness and mastery must read THIS, never the concepts table directly.';

-- ────────────────────────────────────────────────────────────
-- 4. Verification
-- ────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM public.concepts)              AS all_objects,   -- 576
  (SELECT count(*) FROM public.content_concepts)      AS content,       -- 576
  (SELECT count(*) FROM public.reasoning_objects)     AS reasoning,     -- 0
  (SELECT count(*) FROM public.quantitative_objects)  AS quantitative;  -- 0

-- Every pre-existing concept must still be CONTENT. Expect zero rows.
SELECT 'non-content leaked in' AS problem, slug, object_type
FROM public.concepts WHERE object_type <> 'CONTENT';

-- Nothing else moved.
SELECT (SELECT count(*) FROM public.question_concepts)  AS question_mappings,  -- 2659
       (SELECT count(*) FROM public.flashcard_concepts) AS flashcard_mappings, -- 0
       (SELECT count(*) FROM public.flashcards)         AS cards;              -- 4117

-- ── ROLLBACK ────────────────────────────────────────────────────────────
-- DROP VIEW IF EXISTS public.quantitative_objects;
-- DROP VIEW IF EXISTS public.reasoning_objects;
-- DROP VIEW IF EXISTS public.content_concepts;
-- DROP TRIGGER IF EXISTS concept_content_categories_content_only ON public.concept_content_categories;
-- DROP TRIGGER IF EXISTS concept_disciplines_content_only ON public.concept_disciplines;
-- DROP TRIGGER IF EXISTS concept_sections_content_only ON public.concept_sections;
-- DROP FUNCTION IF EXISTS public.reject_taxonomy_on_non_content();
-- ALTER TABLE public.concepts DROP CONSTRAINT IF EXISTS concepts_object_type_check;
-- ALTER TABLE public.concepts DROP COLUMN IF EXISTS object_type;
