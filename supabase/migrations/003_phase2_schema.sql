-- ============================================================
-- Praxis Prep — Phase 2: Course Content + Study Plan
-- Run this in your Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- 1. Lessons table (course content organized by section → topic)
CREATE TABLE lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  section TEXT NOT NULL CHECK (section IN ('bio_biochem', 'chem_phys', 'psych_soc', 'cars')),
  topic TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  estimated_minutes INTEGER DEFAULT 15,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Lesson progress (tracks which lessons each student has completed)
CREATE TABLE lesson_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  UNIQUE(user_id, lesson_id)
);

-- 3. Study plan tasks (weekly schedule items)
CREATE TABLE study_plan_tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  scheduled_date DATE NOT NULL,
  task_type TEXT NOT NULL CHECK (task_type IN ('lesson', 'practice', 'review')),
  title TEXT NOT NULL,
  description TEXT,
  reference_id UUID,
  completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMPTZ,
  sort_order INTEGER DEFAULT 0
);

-- ============================================================
-- Indexes
-- ============================================================
CREATE INDEX idx_lessons_section ON lessons(section, sort_order);
CREATE INDEX idx_lesson_progress_user ON lesson_progress(user_id);
CREATE INDEX idx_study_plan_user_date ON study_plan_tasks(user_id, scheduled_date);

-- ============================================================
-- Row Level Security
-- ============================================================
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE study_plan_tasks ENABLE ROW LEVEL SECURITY;

-- Lessons: all authenticated users can read
CREATE POLICY "Authenticated users can read lessons" ON lessons FOR SELECT USING (auth.role() = 'authenticated');

-- Lesson progress: users can CRUD their own
CREATE POLICY "Users can view own lesson progress" ON lesson_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create own lesson progress" ON lesson_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own lesson progress" ON lesson_progress FOR UPDATE USING (auth.uid() = user_id);

-- Study plan: users can CRUD their own
CREATE POLICY "Users can view own study plan" ON study_plan_tasks FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create own study plan" ON study_plan_tasks FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own study plan" ON study_plan_tasks FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own study plan" ON study_plan_tasks FOR DELETE USING (auth.uid() = user_id);
