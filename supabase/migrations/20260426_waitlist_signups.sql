-- ============================================================
-- Praxist Prep — Waitlist signups
--
-- Captures emails from the public coming-soon page (app/page.tsx)
-- so we can notify interested users when the product opens.
--
-- Public anonymous inserts are allowed (with rate-limiting via the
-- API route, not at the DB layer). Reads are restricted to the
-- service role — visitors should never be able to enumerate signups.
-- ============================================================

CREATE TABLE IF NOT EXISTS waitlist_signups (
  id          UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT         NOT NULL,
  source      TEXT,                                  -- 'coming_soon', 'pricing', etc.
  user_agent  TEXT,                                  -- captured server-side
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Case-insensitive uniqueness on email so duplicate signups don't blow up.
CREATE UNIQUE INDEX IF NOT EXISTS idx_waitlist_email_lower
  ON waitlist_signups (LOWER(email));

CREATE INDEX IF NOT EXISTS idx_waitlist_created_at
  ON waitlist_signups (created_at DESC);

-- Row-level security: anon can INSERT but not SELECT/UPDATE/DELETE.
-- The service role (used in API routes server-side) has full access.
ALTER TABLE waitlist_signups ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anonymous waitlist signups" ON waitlist_signups;
CREATE POLICY "Anonymous waitlist signups"
  ON waitlist_signups
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);
-- (Intentionally no SELECT policy: only service-role reads.)
