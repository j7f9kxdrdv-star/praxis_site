-- ─────────────────────────────────────────────────────────────────────────────
-- GRANDFATHERING: EVERY ACCOUNT THAT EXISTED BEFORE THE CUTOFF KEEPS EVERYTHING.
--
-- PROPOSED. NOT APPLIED. This is the migration that actually grants access, so
-- it is the one that needs Mikko's explicit authorisation.
--
-- REQUIREMENT B, in one sentence: nobody who already has an account loses
-- anything when the paywall goes up. This grants LEGACY_FULL_ACCESS, which has
-- no expiry, is not affected by subscription_tier, and ends only when somebody
-- revokes it deliberately and says why.
--
-- NO ALLOWLIST. The cohort is defined by a CUTOFF, not by a list of ids. The
-- migration selects from auth.users, which is the canonical account universe,
-- so an account nobody remembered is included automatically, and an account
-- created after the cutoff is not. There is no list to maintain and no id
-- written into the application.
--
-- WHO IS IN. Every account not deleted and not currently banned. Deliberately
-- NOT filtered on: having a profile, having signed in, having a confirmed
-- email, tier, age, or how much studying they have done. Mikko was explicit.
--
-- RUN 20261014_account_entitlements.sql FIRST. This refuses otherwise.
-- SAFE TO RUN TWICE: the live-grant index makes a second run a no-op.
-- ─────────────────────────────────────────────────────────────────────────────

-- ─── THE CUTOFF ─────────────────────────────────────────────────────────────
-- The instant the approved inventory was taken. Accounts created at or after
-- this are future signups and follow normal subscription rules.
-- Inventory: scratchpad/legacy/inventory.json, 9 accounts, all eligible.
-- It appears twice below, in the DO block and in the report. Change both.

DO $$
DECLARE
  v_cutoff    CONSTANT TIMESTAMPTZ := '2026-10-14T09:16:03.529Z';
  v_eligible  bigint;
  v_after     bigint;
  v_granted   bigint;
  v_live      bigint;
  v_missing   bigint;
BEGIN
  IF to_regclass('public.account_entitlements') IS NULL THEN
    RAISE EXCEPTION 'Run 20261014_account_entitlements.sql first.';
  END IF;

  SELECT count(*) INTO v_eligible
    FROM auth.users u
   WHERE u.created_at < v_cutoff
     AND u.deleted_at IS NULL
     AND (u.banned_until IS NULL OR u.banned_until < now());

  SELECT count(*) INTO v_after FROM auth.users u WHERE u.created_at >= v_cutoff;

  INSERT INTO public.account_entitlements
    (user_id, entitlement, expires_at, granted_by, grant_reason, source)
  SELECT
    u.id,
    'LEGACY_FULL_ACCESS',
    NULL,                       -- never expires, by requirement
    'migration 20261014_grandfather_legacy_access',
    'Existing account at the approved cutoff; retains full access to all content and features.',
    'grandfather_migration'
  FROM auth.users u
  WHERE u.created_at < v_cutoff
    AND u.deleted_at IS NULL
    AND (u.banned_until IS NULL OR u.banned_until < now())
    -- Idempotent: skip anyone who already holds a live grant.
    AND NOT EXISTS (
      SELECT 1 FROM public.account_entitlements e
       WHERE e.user_id = u.id
         AND e.entitlement = 'LEGACY_FULL_ACCESS'
         AND e.revoked_at IS NULL
    );

  GET DIAGNOSTICS v_granted = ROW_COUNT;

  SELECT count(*) INTO v_live
    FROM public.account_entitlements
   WHERE entitlement = 'LEGACY_FULL_ACCESS' AND revoked_at IS NULL;

  -- ─── THE ACCEPTANCE CHECK ────────────────────────────────────────────────
  -- Not a report: a hard stop. If even one eligible account would be left
  -- without a grant, the whole migration rolls back rather than leaving a
  -- cohort half covered.
  SELECT count(*) INTO v_missing
    FROM auth.users u
   WHERE u.created_at < v_cutoff
     AND u.deleted_at IS NULL
     AND (u.banned_until IS NULL OR u.banned_until < now())
     AND NOT EXISTS (
       SELECT 1 FROM public.account_entitlements e
        WHERE e.user_id = u.id
          AND e.entitlement = 'LEGACY_FULL_ACCESS'
          AND e.revoked_at IS NULL
     );

  IF v_missing <> 0 THEN
    RAISE EXCEPTION
      'BLOCKED: % eligible account(s) would not hold LEGACY_FULL_ACCESS. Nothing committed.', v_missing;
  END IF;

  RAISE NOTICE 'cutoff             : %', v_cutoff;
  RAISE NOTICE 'eligible accounts  : %', v_eligible;
  RAISE NOTICE 'granted this run   : %', v_granted;
  RAISE NOTICE 'live grants now    : %', v_live;
  RAISE NOTICE 'created after cutoff (not grandfathered): %', v_after;
END $$;

-- The same answer as rows, because the SQL editor does not show notices.
SELECT
  '2026-10-14T09:16:03.529Z'::timestamptz                                   AS cutoff,
  (SELECT count(*) FROM auth.users
    WHERE created_at < '2026-10-14T09:16:03.529Z'::timestamptz
      AND deleted_at IS NULL
      AND (banned_until IS NULL OR banned_until < now()))                   AS eligible_accounts,
  (SELECT count(*) FROM public.account_entitlements
    WHERE entitlement = 'LEGACY_FULL_ACCESS' AND revoked_at IS NULL)        AS live_legacy_grants,
  (SELECT count(*) FROM auth.users
    WHERE created_at >= '2026-10-14T09:16:03.529Z'::timestamptz)            AS future_accounts,
  (SELECT count(*) FROM auth.users u
    WHERE u.created_at < '2026-10-14T09:16:03.529Z'::timestamptz
      AND u.deleted_at IS NULL
      AND (u.banned_until IS NULL OR u.banned_until < now())
      AND NOT EXISTS (SELECT 1 FROM public.account_entitlements e
                       WHERE e.user_id = u.id
                         AND e.entitlement = 'LEGACY_FULL_ACCESS'
                         AND e.revoked_at IS NULL))                         AS uncovered_must_be_zero;
