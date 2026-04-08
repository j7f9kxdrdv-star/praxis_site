-- ============================================================
-- Praxis Prep — Spaced Repetition Review Schedule
-- Run this AFTER 004_seed_lessons.sql
-- ============================================================

CREATE TABLE review_schedule (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  next_review_date DATE NOT NULL DEFAULT CURRENT_DATE,
  interval_days INTEGER NOT NULL DEFAULT 1,
  ease_factor NUMERIC(3,1) NOT NULL DEFAULT 2.5,
  review_count INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, question_id)
);

CREATE INDEX idx_review_schedule_user_date ON review_schedule(user_id, next_review_date);

ALTER TABLE review_schedule ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own reviews" ON review_schedule FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create own reviews" ON review_schedule FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own reviews" ON review_schedule FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own reviews" ON review_schedule FOR DELETE USING (auth.uid() = user_id);
