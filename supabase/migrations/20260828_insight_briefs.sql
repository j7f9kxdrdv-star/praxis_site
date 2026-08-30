-- ============================================================
-- Tier 1 insights — cached daily briefs
--
-- The brief is not a cheap read. Answering "does this backlog actually clear,
-- and at what daily cost" means running the student's real cards forward
-- through FSRS across several candidate paces, because arithmetic cannot
-- answer it: every card reviewed comes back, and a card graded Again comes
-- back within the hour. For the largest account in the bank that simulation
-- takes about eight seconds.
--
-- Eight seconds is fine once a day and absurd on every page load, so the
-- result is stored per student per STUDY DAY (4am local, matching the rest of
-- the system) and recomputed only when the day rolls over.
--
-- The brief is stored as jsonb rather than columns on purpose: its shape is
-- still moving, and a claim is only ever read as a whole.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.user_insight_briefs (
  user_id      UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  study_day    DATE        NOT NULL,
  brief        JSONB       NOT NULL,
  generated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, study_day)
);

COMMENT ON TABLE public.user_insight_briefs IS
  'Cached Tier 1 insight brief, one row per student per study day. Recomputed on the first read of a new study day; safe to delete any row to force a rebuild.';

ALTER TABLE public.user_insight_briefs ENABLE ROW LEVEL SECURITY;

-- A student may read their own brief and nothing else. Writes happen through
-- the API route, which runs as the user, so an insert policy is needed too.
DROP POLICY IF EXISTS "Users can read own briefs" ON public.user_insight_briefs;
CREATE POLICY "Users can read own briefs"
  ON public.user_insight_briefs FOR SELECT
  USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can write own briefs" ON public.user_insight_briefs;
CREATE POLICY "Users can write own briefs"
  ON public.user_insight_briefs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can refresh own briefs" ON public.user_insight_briefs;
CREATE POLICY "Users can refresh own briefs"
  ON public.user_insight_briefs FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ── Verification ────────────────────────────────────────────────────────
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'user_insight_briefs'
ORDER BY ordinal_position;

SELECT policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename = 'user_insight_briefs'
ORDER BY policyname;
