-- ============================================================
-- Praxis Prep — Flashcard System
-- Tables, indexes, and RLS for the flashcard module.
-- Run in Supabase Dashboard → SQL Editor → New Query.
-- ============================================================

-- 1. Decks (admin-curated; no user_id)
CREATE TABLE flashcard_decks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  section TEXT NOT NULL CHECK (section IN ('bio_biochem', 'chem_phys', 'psych_soc', 'cars')),
  topic TEXT NOT NULL,
  subtopic TEXT,
  title TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_flashcard_decks_section ON flashcard_decks(section);
CREATE INDEX idx_flashcard_decks_topic ON flashcard_decks(section, topic);

-- 2. Cards (admin-curated)
-- card_type 'basic' uses front_text + back_text (cloze_count = 0).
-- card_type 'cloze' uses cloze_text with {{cN::answer::hint}} syntax;
-- cloze_count is the number of distinct cN groups (computed at seed time).
CREATE TABLE flashcards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  deck_id UUID NOT NULL REFERENCES flashcard_decks(id) ON DELETE CASCADE,
  card_type TEXT NOT NULL CHECK (card_type IN ('basic', 'cloze')),
  front_text TEXT,
  back_text TEXT,
  cloze_text TEXT,
  cloze_count INTEGER DEFAULT 0,
  explanation TEXT,
  tags TEXT[],
  position INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT basic_has_front_back CHECK (
    card_type <> 'basic' OR (front_text IS NOT NULL AND back_text IS NOT NULL)
  ),
  CONSTRAINT cloze_has_text CHECK (
    card_type <> 'cloze' OR (cloze_text IS NOT NULL AND cloze_count >= 1)
  )
);

CREATE INDEX idx_flashcards_deck ON flashcards(deck_id, position);

-- 3. Review log (append-only, one row per review event)
-- For basic cards, cloze_index = 0.
-- For cloze cards, cloze_index = 1..N matching the cN groups.
CREATE TABLE flashcard_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  flashcard_id UUID NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE,
  cloze_index INTEGER NOT NULL DEFAULT 0,
  rating TEXT NOT NULL CHECK (rating IN ('again', 'hard', 'medium', 'easy')),
  prev_interval_days NUMERIC(8, 3),
  new_interval_days NUMERIC(8, 3),
  reviewed_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_flashcard_reviews_user ON flashcard_reviews(user_id, reviewed_at DESC);
CREATE INDEX idx_flashcard_reviews_card ON flashcard_reviews(user_id, flashcard_id, cloze_index);

-- 4. Per-user, per-card current state (one row per user/card/cloze_index)
CREATE TABLE flashcard_user_state (
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  flashcard_id UUID NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE,
  cloze_index INTEGER NOT NULL DEFAULT 0,
  starred BOOLEAN DEFAULT FALSE,
  suspended BOOLEAN DEFAULT FALSE,
  interval_days NUMERIC(8, 3) DEFAULT 0,
  ease_factor NUMERIC(4, 2) DEFAULT 2.5,
  reps INTEGER DEFAULT 0,
  lapses INTEGER DEFAULT 0,
  last_rating TEXT CHECK (last_rating IN ('again', 'hard', 'medium', 'easy')),
  last_reviewed_at TIMESTAMPTZ,
  next_review_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (user_id, flashcard_id, cloze_index)
);

CREATE INDEX idx_flashcard_state_due ON flashcard_user_state(user_id, next_review_at)
  WHERE suspended = FALSE;
CREATE INDEX idx_flashcard_state_starred ON flashcard_user_state(user_id, flashcard_id)
  WHERE starred = TRUE;

-- ============================================================
-- Row Level Security
-- ============================================================

ALTER TABLE flashcard_decks ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcards ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcard_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcard_user_state ENABLE ROW LEVEL SECURITY;

-- Decks + cards: world-readable to authenticated users (admin content)
CREATE POLICY "Authenticated users can read decks"
  ON flashcard_decks FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can read cards"
  ON flashcards FOR SELECT USING (auth.role() = 'authenticated');

-- Reviews: each user owns their review log
CREATE POLICY "Users can read own reviews"
  ON flashcard_reviews FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own reviews"
  ON flashcard_reviews FOR INSERT WITH CHECK (auth.uid() = user_id);

-- User state: each user owns their state rows
CREATE POLICY "Users can read own card state"
  ON flashcard_user_state FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can upsert own card state"
  ON flashcard_user_state FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own card state"
  ON flashcard_user_state FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own card state"
  ON flashcard_user_state FOR DELETE USING (auth.uid() = user_id);
