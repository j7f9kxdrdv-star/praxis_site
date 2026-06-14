-- ============================================================
-- Question classification + distractor metadata
--
-- Phase 3 prep for the standalone-questions rebuild. Adds the
-- AAMC-alignment fields the QBank authoring pipeline produces, and
-- a companion table that records, per distractor, which named error
-- category it punishes.
--
-- Fully idempotent (date-prefixed convention): ADD COLUMN IF NOT
-- EXISTS, DROP CONSTRAINT before ADD, CREATE ... IF NOT EXISTS,
-- DROP POLICY before CREATE POLICY. Safe to re-run.
--
-- Compatibility notes:
--   * The questions table is read with explicit column lists
--     everywhere except the session runner (which selects *). New
--     columns are additive and nullable, so no existing read or
--     write breaks. They simply go unused until wired into the UI.
--   * Answer choices stay in the existing `options` JSONB column
--     ([{label,text},...]) and the keyed letter stays in
--     `correct_answer`. We are NOT adding choice_a/b/c/d columns.
--   * Difficulty stays in the existing `difficulty` column
--     (easy/medium/hard); Praxist tiers 1/2/3 map onto those.
--   * No question_banks table — a "chapter" is the `topic` column.
--
-- Run in Supabase Studio -> SQL Editor. Run AFTER 009_add_topic_column.sql.
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- 1. Classification columns on questions
-- ────────────────────────────────────────────────────────────

ALTER TABLE questions ADD COLUMN IF NOT EXISTS foundation TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS content_category TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS discipline TEXT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS cognitive_skill SMALLINT;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS estimated_time_seconds INTEGER;

COMMENT ON COLUMN questions.foundation IS
  'AAMC content-category code, e.g. 4E. NULL until classified.';
COMMENT ON COLUMN questions.content_category IS
  'AAMC content-category descriptive name, verbatim from the 2026 outline.';
COMMENT ON COLUMN questions.discipline IS
  'Subject discipline: general-chemistry / organic-chemistry / physics / biology / biochemistry / psychology / sociology.';
COMMENT ON COLUMN questions.cognitive_skill IS
  'AAMC Scientific Inquiry & Reasoning Skill, 1-4.';
COMMENT ON COLUMN questions.estimated_time_seconds IS
  'Author-estimated time to solve, in seconds.';

-- AAMC content-category codes — the full, finite 2026 set (1A..10A).
-- NULL is permitted (unclassified rows); a non-NULL value must be valid.
ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_foundation_check;
ALTER TABLE questions ADD CONSTRAINT questions_foundation_check CHECK (
  foundation IS NULL OR foundation IN (
    '1A','1B','1C','1D',
    '2A','2B','2C',
    '3A','3B',
    '4A','4B','4C','4D','4E',
    '5A','5B','5C','5D','5E',
    '6A','6B','6C',
    '7A','7B','7C',
    '8A','8B','8C',
    '9A','9B',
    '10A'
  )
);

ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_discipline_check;
ALTER TABLE questions ADD CONSTRAINT questions_discipline_check CHECK (
  discipline IS NULL OR discipline IN (
    'general-chemistry',
    'organic-chemistry',
    'physics',
    'biology',
    'biochemistry',
    'psychology',
    'sociology'
  )
);

ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_cognitive_skill_check;
ALTER TABLE questions ADD CONSTRAINT questions_cognitive_skill_check CHECK (
  cognitive_skill IS NULL OR cognitive_skill BETWEEN 1 AND 4
);

ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_estimated_time_check;
ALTER TABLE questions ADD CONSTRAINT questions_estimated_time_check CHECK (
  estimated_time_seconds IS NULL OR estimated_time_seconds > 0
);

-- Lightweight indexes for future scope/analytics filtering.
CREATE INDEX IF NOT EXISTS idx_questions_foundation ON questions(foundation);
CREATE INDEX IF NOT EXISTS idx_questions_discipline ON questions(discipline);

-- ────────────────────────────────────────────────────────────
-- 2. question_distractor_metadata — one row per distractor
-- ────────────────────────────────────────────────────────────
-- The keyed-correct choice has no row here; only the three wrong
-- choices do. Joinable to question_attempts on
-- (question_id, choice_label = selected_answer) to analyze which
-- error categories trip students up most.

CREATE TABLE IF NOT EXISTS question_distractor_metadata (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  choice_label TEXT NOT NULL CHECK (choice_label IN ('A', 'B', 'C', 'D')),
  distractor_category TEXT NOT NULL CHECK (distractor_category IN (
    'misconception',
    'adjacent_fact',
    'partial_truth',
    'reversed_relationship',
    'process_step_confusion',
    'scale_unit_error'
  )),
  archetype TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (question_id, choice_label)
);

COMMENT ON TABLE question_distractor_metadata IS
  'Per-distractor classification: the named error category each wrong choice punishes, plus an optional subject-specific archetype.';

CREATE INDEX IF NOT EXISTS question_distractor_metadata_question_id_idx
  ON question_distractor_metadata(question_id);

-- ────────────────────────────────────────────────────────────
-- 3. RLS — reference-data pattern (read for all authenticated;
--    writes via service_role seed migrations, which bypass RLS)
-- ────────────────────────────────────────────────────────────

ALTER TABLE question_distractor_metadata ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Authenticated users can read distractor metadata"
  ON question_distractor_metadata;
CREATE POLICY "Authenticated users can read distractor metadata"
  ON question_distractor_metadata FOR SELECT
  USING (auth.role() = 'authenticated');

-- No INSERT/UPDATE/DELETE policies: matches questions/passages/lessons.
-- Seed migrations run as service_role and bypass RLS entirely.

-- ────────────────────────────────────────────────────────────
-- 4. Verification
-- ────────────────────────────────────────────────────────────

SELECT
  (SELECT COUNT(*) FROM information_schema.columns
     WHERE table_name = 'questions'
       AND column_name IN ('foundation','content_category','discipline',
                           'cognitive_skill','estimated_time_seconds')
  ) AS new_question_columns,   -- expect 5
  (SELECT COUNT(*) FROM information_schema.tables
     WHERE table_name = 'question_distractor_metadata'
  ) AS metadata_table_exists,  -- expect 1
  (SELECT COUNT(*) FROM pg_policies
     WHERE tablename = 'question_distractor_metadata'
  ) AS metadata_policies;      -- expect 1
