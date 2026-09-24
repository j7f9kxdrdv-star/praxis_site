-- ============================================================
-- Taxonomy interoperability: the rails, not the vocabulary
--
-- WHAT THIS IS FOR. Questions and flashcards describe the same syllabus in two
-- shapes that do not join. This migration adds a canonical layer both sides can
-- eventually point at, and resolves the levels that are unambiguous today. It
-- deliberately does NOT choose the concept vocabulary: `concepts` ships empty
-- and stays empty until that vocabulary is approved.
--
-- ADDITIVE AND REVERSIBLE. Every statement is CREATE or INSERT on new objects.
-- Nothing existing is renamed, dropped, altered or rewritten. No question text,
-- flashcard text, FSRS state, review history or attempt history is touched. The
-- rollback at the foot of this file drops only what this file created.
--
-- WHAT WAS ALREADY HERE, and is being promoted rather than replaced:
-- lib/analytics/topicKey.ts already joins questions.topic to decks.subtopic by
-- deterministic normalisation plus a hand-written alias list. Measured today it
-- resolves 29 of 33 question topics, covering 2,450 of 2,681 questions (91.4%).
-- That approach is correct and this migration keeps it. What it lacked was
-- persistence, a level below the chapter, and any record of who decided what.
--
-- THE MISMATCH IN ONE LINE. The two taxonomies are OFFSET BY ONE LEVEL, which
-- is why identically-named columns share no values:
--
--   questions.section   bio_biochem            MCAT section code
--   questions.topic     "Carbohydrate Metab."  CHAPTER
--   questions.subtopic  908 labels             mixed: concept + per-question
--
--   decks.section       biochemistry           DISCIPLINE (not a section)
--   decks.topic         "Biochemistry"         SUBJECT
--   decks.subtopic      carbohydrate_metab_i   CHAPTER, slug
--
-- Run in Supabase Studio -> SQL Editor.
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. MCAT sections. Four, fixed by the exam.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.mcat_sections (
  code        TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  sort_order  SMALLINT NOT NULL DEFAULT 0
);

COMMENT ON TABLE public.mcat_sections IS
  'The four MCAT sections. A SECTION is not a discipline: chem_phys contains general chemistry, organic chemistry and physics.';

INSERT INTO public.mcat_sections (code, name, sort_order) VALUES
  ('CHEM_PHYS',  'Chemical and Physical Foundations of Biological Systems', 1),
  ('CARS',       'Critical Analysis and Reasoning Skills',                  2),
  ('BIO_BIOCHEM','Biological and Biochemical Foundations of Living Systems', 3),
  ('PSYCH_SOC',  'Psychological, Social, and Biological Foundations of Behavior', 4)
ON CONFLICT (code) DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 2. Disciplines, and the one axis that is not a discipline.
--
-- is_cross_cutting marks a grouping that is a REASONING SKILL rather than a
-- body of content. Scientific Reasoning is the live example: its three decks
-- are Mathematics, Data-Based and Statistical Reasoning, and Reasoning About
-- Research Design. Those are the AAMC skill axis, which questions already carry
-- in questions.cognitive_skill. Filing them as a discipline would put a skill
-- into the content tree and make "what does this learner know" incoherent.
-- A cross-cutting row therefore has NO primary_section_code.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.disciplines (
  code                  TEXT PRIMARY KEY,
  name                  TEXT NOT NULL,
  primary_section_code  TEXT REFERENCES public.mcat_sections(code),
  is_cross_cutting      BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT disciplines_cross_cutting_has_no_section
    CHECK (NOT is_cross_cutting OR primary_section_code IS NULL)
);

COMMENT ON COLUMN public.disciplines.primary_section_code IS
  'The MCAT section this discipline principally serves. NULL for cross-cutting skills. "Primary" because biochemistry is examined in both BIO_BIOCHEM and CHEM_PHYS; this records the main home, not an exclusive one.';

INSERT INTO public.disciplines (code, name, primary_section_code, is_cross_cutting) VALUES
  ('GENERAL_CHEMISTRY', 'General Chemistry', 'CHEM_PHYS',   FALSE),
  ('ORGANIC_CHEMISTRY', 'Organic Chemistry', 'CHEM_PHYS',   FALSE),
  ('PHYSICS',           'Physics',           'CHEM_PHYS',   FALSE),
  ('BIOLOGY',           'Biology',           'BIO_BIOCHEM', FALSE),
  ('BIOCHEMISTRY',      'Biochemistry',      'BIO_BIOCHEM', FALSE),
  ('PSYCHOLOGY',        'Psychology',        'PSYCH_SOC',   FALSE),
  ('SOCIOLOGY',         'Sociology',         'PSYCH_SOC',   FALSE),
  ('SCIENTIFIC_REASONING', 'Scientific Reasoning', NULL,    TRUE)
ON CONFLICT (code) DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 3. Legacy classification map.
--
-- THE POINT OF THIS TABLE. decks.section = 'organic_chemistry' is stored in a
-- column called "section" but is semantically a DISCIPLINE. decks.section =
-- 'psych_soc' in the same column is semantically an MCAT SECTION. And
-- 'scientific_reasoning' is neither. One column, three levels.
--
-- Rather than edit that column (which feeds the deck reseed path, and reseeding
-- wipes user progress), every legacy value gets an explicit row saying what it
-- actually means. The legacy value stays exactly as it is.
--
-- Rows are DATA, not code, so a correction is an UPDATE and not a deploy.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.legacy_taxonomy_map (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_system   TEXT NOT NULL CHECK (source_system IN ('questions', 'flashcard_decks')),
  source_field    TEXT NOT NULL,
  source_value    TEXT NOT NULL,
  section_code    TEXT REFERENCES public.mcat_sections(code),
  discipline_code TEXT REFERENCES public.disciplines(code),
  note            TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (source_system, source_field, source_value)
);

COMMENT ON TABLE public.legacy_taxonomy_map IS
  'What each legacy taxonomy string actually means. Deterministic and hand-written; never inferred from text similarity.';

-- questions.section already holds true MCAT section codes. One-to-one.
INSERT INTO public.legacy_taxonomy_map (source_system, source_field, source_value, section_code, discipline_code, note) VALUES
  ('questions','section','chem_phys',  'CHEM_PHYS',  NULL,'Already an MCAT section code.'),
  ('questions','section','bio_biochem','BIO_BIOCHEM',NULL,'Already an MCAT section code.'),
  ('questions','section','psych_soc',  'PSYCH_SOC',  NULL,'Already an MCAT section code. No questions use it yet.'),
  ('questions','section','cars',       'CARS',       NULL,'Already an MCAT section code. No questions use it yet.'),

-- questions.discipline is a true discipline. Hyphenated spelling is legacy.
  ('questions','discipline','general-chemistry','CHEM_PHYS',  'GENERAL_CHEMISTRY',NULL),
  ('questions','discipline','organic-chemistry','CHEM_PHYS',  'ORGANIC_CHEMISTRY',NULL),
  ('questions','discipline','physics',          'CHEM_PHYS',  'PHYSICS',          'No questions use it yet.'),
  ('questions','discipline','biology',          'BIO_BIOCHEM','BIOLOGY',          NULL),
  ('questions','discipline','biochemistry',     'BIO_BIOCHEM','BIOCHEMISTRY',     NULL),
  ('questions','discipline','psychology',       'PSYCH_SOC',  'PSYCHOLOGY',       'No questions use it yet.'),
  ('questions','discipline','sociology',        'PSYCH_SOC',  'SOCIOLOGY',        'No questions use it yet.'),

-- flashcard_decks.section is the mixed-level column. This is the repair.
  ('flashcard_decks','section','chemistry',           'CHEM_PHYS',  'GENERAL_CHEMISTRY',  'Named "chemistry"; means general chemistry.'),
  ('flashcard_decks','section','organic_chemistry',   'CHEM_PHYS',  'ORGANIC_CHEMISTRY',  'A DISCIPLINE stored in a column named section.'),
  ('flashcard_decks','section','physics',             'CHEM_PHYS',  'PHYSICS',            'A DISCIPLINE stored in a column named section.'),
  ('flashcard_decks','section','biology',             'BIO_BIOCHEM','BIOLOGY',            'A DISCIPLINE stored in a column named section.'),
  ('flashcard_decks','section','biochemistry',        'BIO_BIOCHEM','BIOCHEMISTRY',       'A DISCIPLINE stored in a column named section.'),
  ('flashcard_decks','section','psych_soc',           'PSYCH_SOC',  NULL,                 'An MCAT SECTION, not a discipline. Splitting its 12 decks into PSYCHOLOGY and SOCIOLOGY is a judgement call and is left for review.'),
  ('flashcard_decks','section','scientific_reasoning', NULL,        'SCIENTIFIC_REASONING','CROSS-CUTTING SKILL. Not a section and not content. Belongs on the AAMC skill axis (questions.cognitive_skill), not in the content tree.')
ON CONFLICT (source_system, source_field, source_value) DO NOTHING;

-- ────────────────────────────────────────────────────────────
-- 4. Topics and concepts. Created EMPTY on purpose.
--
-- Part 19 of the brief: the canonical vocabulary is the next project. These
-- tables exist so the mapping tables and resolver can be built and tested
-- against real constraints, not so they can be filled today.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.topics (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug            TEXT NOT NULL UNIQUE,
  name            TEXT NOT NULL,
  discipline_code TEXT REFERENCES public.disciplines(code),
  status          TEXT NOT NULL DEFAULT 'DRAFT'
                    CHECK (status IN ('DRAFT','APPROVED','DEPRECATED')),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.topics IS
  'Canonical chapter level. EMPTY until the vocabulary phase. The existing chapter join lives in lib/analytics/topicKey.ts and keeps working meanwhile.';

CREATE TABLE IF NOT EXISTS public.concepts (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug             TEXT NOT NULL UNIQUE,
  canonical_name   TEXT NOT NULL,
  description      TEXT,
  topic_id         UUID REFERENCES public.topics(id) ON DELETE SET NULL,
  discipline_code  TEXT REFERENCES public.disciplines(code),
  content_category TEXT,
  status           TEXT NOT NULL DEFAULT 'DRAFT'
                     CHECK (status IN ('DRAFT','APPROVED','DEPRECATED')),
  version          INTEGER NOT NULL DEFAULT 1,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.concepts IS
  'The canonical concept layer. INTENTIONALLY EMPTY in this migration. Populating it is the vocabulary-design phase and requires approval.';

-- ────────────────────────────────────────────────────────────
-- 5. Aliases. An authoring and migration aid, never a runtime join.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.concept_aliases (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  concept_id  UUID NOT NULL REFERENCES public.concepts(id) ON DELETE CASCADE,
  alias       TEXT NOT NULL,
  alias_type  TEXT NOT NULL CHECK (alias_type IN (
                'QUESTION_SUBTOPIC','FLASHCARD_LABEL','COMMON_NAME','ABBREVIATION','LEGACY_NAME')),
  source      TEXT NOT NULL DEFAULT 'HUMAN_REVIEWED' CHECK (source IN (
                'LEGACY_EXACT','DETERMINISTIC','AI_PROPOSED','HUMAN_REVIEWED')),
  status      TEXT NOT NULL DEFAULT 'AI_PROPOSED' CHECK (status IN (
                'AI_PROPOSED','HUMAN_VALIDATED','NEEDS_REVIEW')),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (alias, alias_type)
);

COMMENT ON TABLE public.concept_aliases IS
  'Alternative names for a concept, used when PROPOSING mappings and when a human searches. Runtime learner analytics must join on concept_id and must never resolve an alias by similarity.';

-- ────────────────────────────────────────────────────────────
-- 6. The many-to-many mapping tables.
--
-- Many-to-many rather than a column on questions/flashcards, because a question
-- routinely tests more than one concept and a card can serve more than one.
-- role separates the concept a row is ABOUT from the ones it touches.
-- ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.question_concepts (
  question_id    UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  concept_id     UUID NOT NULL REFERENCES public.concepts(id) ON DELETE CASCADE,
  role           TEXT NOT NULL DEFAULT 'PRIMARY' CHECK (role IN ('PRIMARY','SECONDARY')),
  confidence     NUMERIC(3,2) CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1)),
  mapping_status TEXT NOT NULL DEFAULT 'AI_PROPOSED' CHECK (mapping_status IN (
                   'AI_PROPOSED','HUMAN_VALIDATED','NEEDS_REVIEW')),
  source         TEXT NOT NULL CHECK (source IN (
                   'LEGACY_EXACT','DETERMINISTIC','AI_PROPOSED','HUMAN_REVIEWED')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at    TIMESTAMPTZ,
  reviewed_by    UUID,
  PRIMARY KEY (question_id, concept_id)
);

CREATE TABLE IF NOT EXISTS public.flashcard_concepts (
  flashcard_id   UUID NOT NULL REFERENCES public.flashcards(id) ON DELETE CASCADE,
  concept_id     UUID NOT NULL REFERENCES public.concepts(id) ON DELETE CASCADE,
  role           TEXT NOT NULL DEFAULT 'PRIMARY' CHECK (role IN ('PRIMARY','SECONDARY')),
  confidence     NUMERIC(3,2) CHECK (confidence IS NULL OR (confidence >= 0 AND confidence <= 1)),
  mapping_status TEXT NOT NULL DEFAULT 'AI_PROPOSED' CHECK (mapping_status IN (
                   'AI_PROPOSED','HUMAN_VALIDATED','NEEDS_REVIEW')),
  source         TEXT NOT NULL CHECK (source IN (
                   'LEGACY_EXACT','DETERMINISTIC','AI_PROPOSED','HUMAN_REVIEWED')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at    TIMESTAMPTZ,
  reviewed_by    UUID,
  PRIMARY KEY (flashcard_id, concept_id)
);

COMMENT ON TABLE public.question_concepts IS
  'Which canonical concepts a question tests. Mapped at question level. EMPTY until the vocabulary is approved.';
COMMENT ON TABLE public.flashcard_concepts IS
  'Which canonical concepts a card carries. Mapped at CARD level, not deck level: 73 decks against 908 question labels is far too coarse to compare memory with application.';

-- At most one PRIMARY concept per item. Secondary concepts are unlimited.
CREATE UNIQUE INDEX IF NOT EXISTS question_concepts_one_primary
  ON public.question_concepts(question_id) WHERE role = 'PRIMARY';
CREATE UNIQUE INDEX IF NOT EXISTS flashcard_concepts_one_primary
  ON public.flashcard_concepts(flashcard_id) WHERE role = 'PRIMARY';

CREATE INDEX IF NOT EXISTS question_concepts_concept_idx  ON public.question_concepts(concept_id);
CREATE INDEX IF NOT EXISTS flashcard_concepts_concept_idx ON public.flashcard_concepts(concept_id);

-- ────────────────────────────────────────────────────────────
-- 7. Human validation is authoritative, enforced in the database.
--
-- A policy that lives only in application code is a policy that holds until
-- somebody writes a script. Once a row is HUMAN_VALIDATED, an automated source
-- cannot change or delete it. Disagreement is expressed by INSERTING a review
-- candidate, never by overwriting the validated row.
--
-- A human can still correct a human decision: an UPDATE whose source is
-- HUMAN_REVIEWED is permitted.
-- ────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.protect_human_validated_mapping()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    IF OLD.mapping_status = 'HUMAN_VALIDATED' THEN
      RAISE EXCEPTION
        'Refusing to delete a HUMAN_VALIDATED mapping (%). Human review is authoritative; record disagreement as a new NEEDS_REVIEW row instead.',
        TG_TABLE_NAME;
    END IF;
    RETURN OLD;
  END IF;

  IF OLD.mapping_status = 'HUMAN_VALIDATED' AND NEW.source <> 'HUMAN_REVIEWED' THEN
    RAISE EXCEPTION
      'Refusing to overwrite a HUMAN_VALIDATED mapping (%) from source %. Only a HUMAN_REVIEWED write may amend a human decision.',
      TG_TABLE_NAME, NEW.source;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS question_concepts_protect ON public.question_concepts;
CREATE TRIGGER question_concepts_protect
  BEFORE UPDATE OR DELETE ON public.question_concepts
  FOR EACH ROW EXECUTE FUNCTION public.protect_human_validated_mapping();

DROP TRIGGER IF EXISTS flashcard_concepts_protect ON public.flashcard_concepts;
CREATE TRIGGER flashcard_concepts_protect
  BEFORE UPDATE OR DELETE ON public.flashcard_concepts
  FOR EACH ROW EXECUTE FUNCTION public.protect_human_validated_mapping();

-- ────────────────────────────────────────────────────────────
-- 8. RLS. Reference-data pattern, matching questions and passages:
--    readable by any authenticated user, written only by service_role.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE t TEXT;
BEGIN
  FOREACH t IN ARRAY ARRAY['mcat_sections','disciplines','legacy_taxonomy_map','topics',
                           'concepts','concept_aliases','question_concepts','flashcard_concepts']
  LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('DROP POLICY IF EXISTS "read taxonomy" ON public.%I', t);
    EXECUTE format(
      'CREATE POLICY "read taxonomy" ON public.%I FOR SELECT USING (auth.role() = ''authenticated'')', t);
  END LOOP;
END $$;

-- ────────────────────────────────────────────────────────────
-- 9. Verification
-- ────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM public.mcat_sections)                              AS sections,        -- 4
  (SELECT count(*) FROM public.disciplines)                                AS disciplines,     -- 8
  (SELECT count(*) FROM public.legacy_taxonomy_map)                        AS legacy_maps,     -- 18
  (SELECT count(*) FROM public.concepts)                                   AS concepts,        -- 0, on purpose
  (SELECT count(*) FROM public.question_concepts)                          AS question_maps,   -- 0, on purpose
  (SELECT count(*) FROM public.flashcard_concepts)                         AS flashcard_maps,  -- 0, on purpose
  (SELECT count(*) FROM public.questions)                                  AS questions_intact,-- 2681
  (SELECT count(*) FROM public.flashcards)                                 AS cards_intact;    -- 4117

-- Every legacy deck section and question discipline must be covered, or the
-- resolver will return UNKNOWN for real rows. Expect zero.
SELECT 'unmapped deck section' AS problem, d.section AS value
FROM (SELECT DISTINCT section FROM public.flashcard_decks) d
LEFT JOIN public.legacy_taxonomy_map m
  ON m.source_system = 'flashcard_decks' AND m.source_field = 'section' AND m.source_value = d.section
WHERE m.id IS NULL
UNION ALL
SELECT 'unmapped question discipline', q.discipline
FROM (SELECT DISTINCT discipline FROM public.questions WHERE discipline IS NOT NULL) q
LEFT JOIN public.legacy_taxonomy_map m
  ON m.source_system = 'questions' AND m.source_field = 'discipline' AND m.source_value = q.discipline
WHERE m.id IS NULL;

-- ────────────────────────────────────────────────────────────
-- ROLLBACK. Drops only what this file created; touches no existing table.
-- ────────────────────────────────────────────────────────────
-- DROP TRIGGER IF EXISTS flashcard_concepts_protect ON public.flashcard_concepts;
-- DROP TRIGGER IF EXISTS question_concepts_protect  ON public.question_concepts;
-- DROP FUNCTION IF EXISTS public.protect_human_validated_mapping();
-- DROP TABLE IF EXISTS public.flashcard_concepts;
-- DROP TABLE IF EXISTS public.question_concepts;
-- DROP TABLE IF EXISTS public.concept_aliases;
-- DROP TABLE IF EXISTS public.concepts;
-- DROP TABLE IF EXISTS public.topics;
-- DROP TABLE IF EXISTS public.legacy_taxonomy_map;
-- DROP TABLE IF EXISTS public.disciplines;
-- DROP TABLE IF EXISTS public.mcat_sections;
