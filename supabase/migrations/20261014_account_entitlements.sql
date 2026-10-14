-- ─────────────────────────────────────────────────────────────────────────────
-- ACCOUNT ENTITLEMENTS: THE AUTHORITATIVE RECORD OF WHO MAY READ PAID CONTENT.
--
-- PROPOSED. NOT APPLIED. Grants nothing by itself.
--
-- WHY A TABLE AND NOT A COLUMN. An entitlement has to be auditable: who granted
-- it, when, on what authority, and if it ended, who ended it and why. A column
-- holds the current value and forgets everything else, so it can answer "may
-- they" but never "why, and who decided". Rows are append-and-revoke; the
-- history stays.
--
-- WHY subscription_tier IS NOT READ HERE AT ALL. A tier is a label. There is no
-- billing system wired up yet, so a 'self_paced' label is not evidence that
-- anybody paid, and Mikko's instruction is explicit: use authoritative billing
-- records or deliberately granted entitlements. Until billing exists, a grant
-- in this table is the only thing that entitles.
--
-- ADMINISTRATION IS NOT ENTITLEMENT. is_admin stays what it is: permission to
-- operate the product. It is kept separate on purpose, so that revoking
-- somebody's staff access does not silently take away their content, and
-- granting content does not hand anybody the card editor.
--
-- SAFE TO RUN TWICE. Every statement is idempotent.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.account_entitlements (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  entitlement   TEXT NOT NULL,
  -- Null means it does not expire. LEGACY_FULL_ACCESS is always null here:
  -- a grandfathered account does not quietly stop being grandfathered.
  expires_at    TIMESTAMPTZ,
  granted_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  granted_by    TEXT NOT NULL,
  grant_reason  TEXT NOT NULL,
  source        TEXT NOT NULL,
  revoked_at    TIMESTAMPTZ,
  revoked_by    TEXT,
  revoke_reason TEXT
);

ALTER TABLE public.account_entitlements
  DROP CONSTRAINT IF EXISTS account_entitlements_known;
ALTER TABLE public.account_entitlements
  ADD CONSTRAINT account_entitlements_known
  CHECK (entitlement IN ('LEGACY_FULL_ACCESS', 'SUBSCRIPTION_FULL_ACCESS'));

ALTER TABLE public.account_entitlements
  DROP CONSTRAINT IF EXISTS account_entitlements_source_known;
ALTER TABLE public.account_entitlements
  ADD CONSTRAINT account_entitlements_source_known
  CHECK (source IN ('grandfather_migration', 'manual_grant', 'billing'));

-- A revocation must say who and why, or it is not auditable.
ALTER TABLE public.account_entitlements
  DROP CONSTRAINT IF EXISTS account_entitlements_revocation_is_explained;
ALTER TABLE public.account_entitlements
  ADD CONSTRAINT account_entitlements_revocation_is_explained
  CHECK (revoked_at IS NULL OR (revoked_by IS NOT NULL AND revoke_reason IS NOT NULL));

-- One LIVE grant of a given entitlement per account. Revoked rows stay, as
-- many as there have been, because they are the history.
CREATE UNIQUE INDEX IF NOT EXISTS account_entitlements_one_live
  ON public.account_entitlements (user_id, entitlement)
  WHERE revoked_at IS NULL;

CREATE INDEX IF NOT EXISTS account_entitlements_by_user
  ON public.account_entitlements (user_id) WHERE revoked_at IS NULL;

COMMENT ON TABLE public.account_entitlements IS
  'Authoritative record of who may read paid content. Append and revoke only; never edited in place. subscription_tier is a label and is not consulted.';

-- ─── The audit trail is not editable ────────────────────────────────────────
--
-- A granted row may only ever be revoked. Nothing else about it may change, so
-- the record of what was granted and why cannot be rewritten after the fact.
CREATE OR REPLACE FUNCTION public.account_entitlements_append_only()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF OLD.id           IS DISTINCT FROM NEW.id
  OR OLD.user_id      IS DISTINCT FROM NEW.user_id
  OR OLD.entitlement  IS DISTINCT FROM NEW.entitlement
  OR OLD.expires_at   IS DISTINCT FROM NEW.expires_at
  OR OLD.granted_at   IS DISTINCT FROM NEW.granted_at
  OR OLD.granted_by   IS DISTINCT FROM NEW.granted_by
  OR OLD.grant_reason IS DISTINCT FROM NEW.grant_reason
  OR OLD.source       IS DISTINCT FROM NEW.source
  THEN
    RAISE EXCEPTION 'account_entitlements rows are append-only; a grant may only be revoked';
  END IF;

  IF OLD.revoked_at IS NOT NULL AND NEW.revoked_at IS DISTINCT FROM OLD.revoked_at THEN
    RAISE EXCEPTION 'a revocation cannot be undone; grant a new entitlement instead';
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS account_entitlements_append_only ON public.account_entitlements;
CREATE TRIGGER account_entitlements_append_only
BEFORE UPDATE ON public.account_entitlements
FOR EACH ROW EXECUTE FUNCTION public.account_entitlements_append_only();

-- ─── Row-level security: readable by its owner, writable by nobody ──────────
--
-- There is deliberately NO insert, update or delete policy. With RLS enabled
-- and no such policy, an authenticated learner cannot write this table at all,
-- whatever they send. Only service_role, which bypasses RLS, can grant or
-- revoke, which is what "a properly authorized administrative process" means.
ALTER TABLE public.account_entitlements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own entitlements" ON public.account_entitlements;
CREATE POLICY "Users can view own entitlements"
  ON public.account_entitlements FOR SELECT
  USING (auth.uid() = user_id);

-- ─── The question the application asks ──────────────────────────────────────
--
-- TWO ENTRY POINTS, ONE RULE, AND THAT IS THE WHOLE POINT.
--
-- Row-level security asks about the CURRENT user, so it needs a no-argument
-- function reading auth.uid(). The image route cannot use that: it runs with
-- the service role, where auth.uid() is null, and it already knows which user
-- is asking from the signed cookie. An earlier version answered that by
-- reimplementing the rule in TypeScript against profile columns, which went
-- stale the moment the authority moved into this table and silently denied
-- every entitled account. So the rule is written once, here, and both callers
-- go through it.
CREATE OR REPLACE FUNCTION public.has_content_entitlement_for(p_user UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT p_user IS NOT NULL AND (
    -- Staff operate the product, so they can see it.
    EXISTS (SELECT 1 FROM public.profiles p
             WHERE p.id = p_user AND p.is_admin = true)
    OR
    -- A live, unexpired grant. This is the only content authority.
    EXISTS (SELECT 1 FROM public.account_entitlements e
             WHERE e.user_id = p_user
               AND e.revoked_at IS NULL
               AND (e.expires_at IS NULL OR e.expires_at > now()))
  );
$$;

REVOKE ALL ON FUNCTION public.has_content_entitlement_for(UUID) FROM PUBLIC;
-- service_role only: an authenticated caller must never be able to ask this
-- about somebody else, which is exactly what passing an argument would allow.
GRANT EXECUTE ON FUNCTION public.has_content_entitlement_for(UUID) TO service_role;

CREATE OR REPLACE FUNCTION public.has_content_entitlement()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT public.has_content_entitlement_for(auth.uid());
$$;

REVOKE ALL ON FUNCTION public.has_content_entitlement() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.has_content_entitlement() TO authenticated, service_role;

COMMENT ON FUNCTION public.has_content_entitlement() IS
  'Whether the caller may read paid content: staff, or a live unexpired grant in account_entitlements. subscription_tier is never consulted.';

-- ─── Report ─────────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM public.account_entitlements)                        AS entitlement_rows,
  (SELECT count(*) FROM public.account_entitlements WHERE revoked_at IS NULL) AS live_grants,
  (SELECT count(*) FROM public.profiles WHERE is_admin)                     AS admins;

-- ─── The sign-out kill switch ───────────────────────────────────────────────
--
-- Image requests carry a short-lived signed cookie, because a browser cannot
-- put an Authorization header on an <img>. A cookie alone must never be taken
-- as proof that the Supabase session behind it is still alive: somebody who
-- signs out would otherwise keep their illustrations until the cookie lapsed.
--
-- This column is the server's answer. Signing out moves it to now(), and the
-- image route refuses any cookie issued before it, on every device at once.
--
-- The owner MAY move it forward, because that is self-revocation and is always
-- safe. The trigger below refuses to let anyone move it backwards, which is
-- the only direction that could restore a session somebody ended.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS image_sessions_valid_from TIMESTAMPTZ;

COMMENT ON COLUMN public.profiles.image_sessions_valid_from IS
  'Image cookies issued before this instant are refused. Moved to now() on sign-out. Forward-only.';

CREATE OR REPLACE FUNCTION public.image_sessions_valid_from_forward_only()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF auth.role() = 'authenticated'
     AND OLD.image_sessions_valid_from IS NOT NULL
     AND NEW.image_sessions_valid_from IS DISTINCT FROM OLD.image_sessions_valid_from
     AND (NEW.image_sessions_valid_from IS NULL
          OR NEW.image_sessions_valid_from < OLD.image_sessions_valid_from)
  THEN
    NEW.image_sessions_valid_from := OLD.image_sessions_valid_from;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS profiles_image_sessions_forward_only ON public.profiles;
CREATE TRIGGER profiles_image_sessions_forward_only
BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.image_sessions_valid_from_forward_only();
