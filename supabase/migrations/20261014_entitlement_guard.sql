-- ─────────────────────────────────────────────────────────────────────────────
-- ENTITLEMENT, AND A DATABASE THAT WILL NOT LET A LEARNER WRITE THEIR OWN.
--
-- PROPOSED. NOT APPLIED. Nothing in the app grants access until this runs.
--
-- WHY THIS EXISTS. Flashcard illustrations are subscriber-only content. The
-- obvious column to gate on, profiles.subscription_tier, cannot be believed:
-- the policy "Users can update own profile" is FOR UPDATE USING (auth.uid() =
-- id) with no column restriction, so a learner may write their own row. This
-- was verified against production with a disposable account acting through the
-- anon key exactly as the browser does:
--
--     self-set subscription_tier  -> ACCEPTED        (now 'self_paced')
--     self-set is_admin           -> silently reverted
--     self-set account_kind       -> silently reverted
--
-- is_admin and account_kind are safe because each already has a BEFORE UPDATE
-- trigger putting the old value back. This migration gives the entitlement
-- columns the same defence, and adds the states an entitlement actually needs,
-- because a tier alone cannot express "cancelled, with three weeks left" or
-- "revoked".
--
-- SAFE TO RUN TWICE. Every statement is idempotent.
-- ─────────────────────────────────────────────────────────────────────────────

-- 1. The states an entitlement can be in ─────────────────────────────────────
--
-- A tier says WHAT was bought. These say WHETHER it is still owed.
--   none      never subscribed
--   active    paid and current
--   granted   comped: an explicitly granted equivalent entitlement
--   past_due  payment failed, not yet resolved
--   canceled  cancelled; entitlement_expires_at decides what is left
--   expired   the term ended
--   revoked   withdrawn by us
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS subscription_status TEXT NOT NULL DEFAULT 'none';

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS entitlement_expires_at TIMESTAMPTZ;

-- Why a grant was given, for the human who has to explain it later.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS entitlement_note TEXT;

ALTER TABLE public.profiles
  DROP CONSTRAINT IF EXISTS profiles_subscription_status_known;

ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_subscription_status_known
  CHECK (subscription_status IN
    ('none', 'active', 'granted', 'past_due', 'canceled', 'expired', 'revoked'));

COMMENT ON COLUMN public.profiles.subscription_status IS
  'Whether the entitlement is owed. Written by staff and billing only; the self-update trigger reverts any change made by an authenticated learner.';
COMMENT ON COLUMN public.profiles.entitlement_expires_at IS
  'When access stops. NULL means open-ended, which only entitles alongside an entitling status. A cancelled subscriber keeps access until this passes.';

-- 2. The guard ───────────────────────────────────────────────────────────────
--
-- Same shape as prevent_is_admin_self_update, deliberately: one pattern for
-- "a column the row owner may read but not write". auth.role() is
-- 'authenticated' for a learner and 'service_role' for our server, so staff
-- tooling and billing webhooks are unaffected.
CREATE OR REPLACE FUNCTION public.prevent_entitlement_self_update()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF auth.role() = 'authenticated' THEN
    IF OLD.subscription_tier IS DISTINCT FROM NEW.subscription_tier THEN
      NEW.subscription_tier := OLD.subscription_tier;
    END IF;
    IF OLD.subscription_status IS DISTINCT FROM NEW.subscription_status THEN
      NEW.subscription_status := OLD.subscription_status;
    END IF;
    IF OLD.entitlement_expires_at IS DISTINCT FROM NEW.entitlement_expires_at THEN
      NEW.entitlement_expires_at := OLD.entitlement_expires_at;
    END IF;
    IF OLD.entitlement_note IS DISTINCT FROM NEW.entitlement_note THEN
      NEW.entitlement_note := OLD.entitlement_note;
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS profiles_prevent_entitlement_self_update ON public.profiles;
CREATE TRIGGER profiles_prevent_entitlement_self_update
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.prevent_entitlement_self_update();

-- 3. The marker the application checks ───────────────────────────────────────
--
-- The image route refuses to grant anything until this returns true, so the
-- app cannot be configured to trust columns the database is not yet defending.
-- It reads the catalog, so it cannot be faked by an environment variable.
CREATE OR REPLACE FUNCTION public.entitlement_guard_installed()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_catalog
AS $$
  SELECT EXISTS (
    SELECT 1 FROM pg_trigger
     WHERE tgname = 'profiles_prevent_entitlement_self_update'
       AND tgrelid = 'public.profiles'::regclass
       AND NOT tgisinternal
  );
$$;

REVOKE ALL ON FUNCTION public.entitlement_guard_installed() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.entitlement_guard_installed() TO service_role;

-- 4. Nobody who is paying today loses access tomorrow ────────────────────────
--
-- Runs as the migration role, so the trigger above lets it through. Only
-- touches rows that are still at the default, so re-running changes nothing.
UPDATE public.profiles
   SET subscription_status = 'active'
 WHERE subscription_tier IN ('practice', 'self_paced')
   AND subscription_status = 'none';

-- 5. Report, so the result is visible in the SQL editor ──────────────────────
SELECT
  (SELECT public.entitlement_guard_installed())                      AS guard_installed,
  (SELECT count(*) FROM public.profiles)                             AS profiles,
  (SELECT count(*) FROM public.profiles
    WHERE subscription_status IN ('active', 'granted'))              AS entitled_now,
  (SELECT count(*) FROM public.profiles
    WHERE subscription_status = 'none')                              AS not_entitled;
