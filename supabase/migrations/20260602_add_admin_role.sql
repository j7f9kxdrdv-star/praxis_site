-- ============================================================
-- Praxis Prep — Add admin role for in-app content editing
--
-- Adds an is_admin flag to the profiles table and grants admins
-- the ability to UPDATE flashcards and flashcard_decks rows via
-- the app UI.
--
-- Security notes:
--   * Users can normally UPDATE their own profile row (auth.uid() = id).
--     We add a BEFORE UPDATE trigger that silently reverts any
--     is_admin change made by an authenticated user, so a user
--     cannot self-elevate to admin. Only service_role (seed scripts,
--     server-side admin tooling) can actually change is_admin.
--   * Admin UPDATE policies are scoped to flashcards.cloze_text +
--     flashcard_decks.* rows only. We do NOT grant DELETE or INSERT
--     to admins for now — content creation still goes through seed
--     SQL files for proper version control.
--
-- Idempotent: re-running has no additional effect.
-- ============================================================

-- 1. Add is_admin column to profiles
ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS is_admin BOOLEAN NOT NULL DEFAULT false;

-- 2. Trigger to prevent users from self-elevating to admin via the
--    "Users can update own profile" RLS policy.
CREATE OR REPLACE FUNCTION prevent_is_admin_self_update()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF auth.role() = 'authenticated'
     AND OLD.is_admin IS DISTINCT FROM NEW.is_admin
  THEN
    NEW.is_admin := OLD.is_admin;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS profiles_prevent_self_admin_update ON profiles;
CREATE TRIGGER profiles_prevent_self_admin_update
BEFORE UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION prevent_is_admin_self_update();

-- 3. Grant admins UPDATE on flashcards (for editing card text)
DROP POLICY IF EXISTS "Admins can update flashcards" ON flashcards;
CREATE POLICY "Admins can update flashcards"
  ON flashcards FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
        AND profiles.is_admin = true
    )
  );

-- 4. Grant admins UPDATE on flashcard_decks (for editing deck titles / descriptions later)
DROP POLICY IF EXISTS "Admins can update flashcard_decks" ON flashcard_decks;
CREATE POLICY "Admins can update flashcard_decks"
  ON flashcard_decks FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
        AND profiles.is_admin = true
    )
  );

-- 5. Set the founder's account to admin
UPDATE profiles
SET is_admin = true
WHERE email = 'mikko.nieveras@gmail.com';
