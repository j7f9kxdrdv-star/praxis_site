-- ============================================================
-- Praxis Prep — Support messages table
--
-- Stores user-submitted support / contact-form messages so they
-- aren't lost in personal inboxes. Each message is owned by the
-- authenticated user who created it.
--
-- Authors of email notification (Resend / Postmark / etc.) can
-- attach a trigger later that calls out to a notification edge
-- function. For now the messages just sit in the database and
-- the founder reads them via the Supabase dashboard or a future
-- /dashboard/admin/support page.
-- ============================================================

CREATE TABLE IF NOT EXISTS support_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  email TEXT NOT NULL,
  name TEXT,
  subject TEXT NOT NULL,
  message TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'open'
    CHECK (status IN ('open', 'replied', 'closed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  replied_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS support_messages_created_at_idx
  ON support_messages (created_at DESC);
CREATE INDEX IF NOT EXISTS support_messages_user_id_idx
  ON support_messages (user_id);
CREATE INDEX IF NOT EXISTS support_messages_status_idx
  ON support_messages (status);

ALTER TABLE support_messages ENABLE ROW LEVEL SECURITY;

-- Authenticated users can submit their own messages
DROP POLICY IF EXISTS "Users can create own support messages" ON support_messages;
CREATE POLICY "Users can create own support messages"
  ON support_messages FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can read their own message history (so the support page can
-- show "your previous messages" later if we want it)
DROP POLICY IF EXISTS "Users can read own support messages" ON support_messages;
CREATE POLICY "Users can read own support messages"
  ON support_messages FOR SELECT
  USING (auth.uid() = user_id);

-- Admins can read every message
DROP POLICY IF EXISTS "Admins can read all support messages" ON support_messages;
CREATE POLICY "Admins can read all support messages"
  ON support_messages FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
        AND profiles.is_admin = true
    )
  );

-- Admins can update status (to mark replied / closed) and add replied_at
DROP POLICY IF EXISTS "Admins can update support messages" ON support_messages;
CREATE POLICY "Admins can update support messages"
  ON support_messages FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
        AND profiles.is_admin = true
    )
  );
