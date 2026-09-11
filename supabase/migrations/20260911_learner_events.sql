-- ============================================================
-- Learner state: snapshots, and the events derived from them
--
-- WHY SNAPSHOT-AND-DIFF RATHER THAN INSTRUMENTING EVERY WRITE.
--
-- The obvious design is to emit an event from each write path: the review
-- route, the question submit, the lesson complete. That means editing every
-- one of those paths, and an event that fires twice or not at all is then a
-- silent bug in a place nobody looks. Worse, the interesting events are not
-- writes at all. "Endocrine improved" is not something the student did; it is
-- something that became true about them AFTER a write, and no single write
-- knows it happened.
--
-- The raw behavioural log already exists and is complete: question_attempts,
-- flashcard_reviews, practice_sessions, lesson_progress. What was missing was
-- the DERIVED layer. So learner state is computed once per study day, stored
-- whole, and transitions are found by comparing consecutive snapshots.
--
-- That buys three things the emit-on-write design does not:
--
--   idempotent   one snapshot per student per study day, by primary key. A
--                recompute overwrites; it cannot double-count.
--   auditable    the state that produced an event is still there to inspect,
--                so "why did Endocrine count as improved" has an answer.
--   backfillable transitions can be reconstructed for any period already
--                covered by the raw logs, without inventing anything.
--
-- The cost is granularity: a transition is dated to a study day, not a moment.
-- For "what changed since your last session" that is the right resolution.
-- ============================================================

-- ── Snapshots ───────────────────────────────────────────────────────────
--
-- jsonb rather than columns because the shape is still moving and a snapshot is
-- only ever read whole. calculation_version records which model produced it, so
-- a later formula change does not silently reinterpret old rows.
CREATE TABLE IF NOT EXISTS public.learner_state_snapshots (
  user_id             UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  study_day           DATE        NOT NULL,
  state               JSONB       NOT NULL,
  calculation_version TEXT        NOT NULL,
  generated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, study_day)
);

COMMENT ON TABLE public.learner_state_snapshots IS
  'Learner state, one row per student per study day. Topic states, priorities, accuracy, coverage and memory health. Safe to delete any row to force a rebuild.';

CREATE INDEX IF NOT EXISTS learner_state_snapshots_user_day_idx
  ON public.learner_state_snapshots (user_id, study_day DESC);

ALTER TABLE public.learner_state_snapshots ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own snapshots" ON public.learner_state_snapshots;
CREATE POLICY "Users read own snapshots"
  ON public.learner_state_snapshots FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users write own snapshots" ON public.learner_state_snapshots;
CREATE POLICY "Users write own snapshots"
  ON public.learner_state_snapshots FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users refresh own snapshots" ON public.learner_state_snapshots;
CREATE POLICY "Users refresh own snapshots"
  ON public.learner_state_snapshots FOR UPDATE
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);


-- ── Events ──────────────────────────────────────────────────────────────
--
-- Derived from snapshot diffs, then stored so they can be counted and queried
-- over a period without re-diffing every day in it.
--
-- dedupe_key IS THE WHOLE IDEMPOTENCY STORY. It is unique per user, and every
-- event builds one from the facts that define it: type, subject, study day. A
-- rebuild of the same day therefore collides with itself and updates in place
-- instead of inserting a second "Endocrine improved" for the same morning.
CREATE TABLE IF NOT EXISTS public.learner_events (
  id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type                TEXT        NOT NULL,
  occurred_on         DATE        NOT NULL,
  -- What the event is about. Topics and sections are strings in this schema
  -- rather than foreign keys, because there is no topics table: they live as
  -- columns on questions and flashcard_decks.
  subject_kind        TEXT,
  subject_id          TEXT,
  previous_value      TEXT,
  new_value           TEXT,
  metadata            JSONB       NOT NULL DEFAULT '{}'::jsonb,
  calculation_version TEXT        NOT NULL,
  dedupe_key          TEXT        NOT NULL,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT learner_events_dedupe UNIQUE (user_id, dedupe_key)
);

COMMENT ON TABLE public.learner_events IS
  'Meaningful changes in learner state, derived from consecutive snapshots. Idempotent on (user_id, dedupe_key): recomputing a day updates rather than duplicating.';

COMMENT ON COLUMN public.learner_events.dedupe_key IS
  'Built from type, subject and study day. Makes a rebuild of the same day a no-op.';

-- Recent Progress asks for one user, one type, one window. This is that query.
CREATE INDEX IF NOT EXISTS learner_events_user_date_idx
  ON public.learner_events (user_id, occurred_on DESC);
CREATE INDEX IF NOT EXISTS learner_events_user_type_date_idx
  ON public.learner_events (user_id, type, occurred_on DESC);

ALTER TABLE public.learner_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own events" ON public.learner_events;
CREATE POLICY "Users read own events"
  ON public.learner_events FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users write own events" ON public.learner_events;
CREATE POLICY "Users write own events"
  ON public.learner_events FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users update own events" ON public.learner_events;
CREATE POLICY "Users update own events"
  ON public.learner_events FOR UPDATE
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);


-- ── Verification ────────────────────────────────────────────────────────
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('learner_state_snapshots', 'learner_events')
ORDER BY table_name, ordinal_position;

SELECT tablename, indexname FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN ('learner_state_snapshots', 'learner_events')
ORDER BY tablename, indexname;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('learner_state_snapshots', 'learner_events')
ORDER BY tablename, policyname;
