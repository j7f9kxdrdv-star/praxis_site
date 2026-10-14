-- ─────────────────────────────────────────────────────────────────────────────
-- CONTENT BECOMES SUBSCRIBER-ONLY.
--
-- PROPOSED. NOT APPLIED. READ THE SEQUENCING NOTE BEFORE RUNNING THIS.
--
-- Today every content table carries the same policy: readable by anyone who is
-- signed in. This swaps that one predicate for "signed in AND entitled" on the
-- decks, the cards, the questions, the passages and the lessons.
--
-- ─── RUN 20261014_entitlement_guard.sql FIRST ────────────────────────────────
-- That migration adds subscription_status and the trigger that stops a learner
-- writing their own entitlement. Without it this file gates on a column the
-- learner controls, which is not a gate. This file refuses to run without it.
--
-- ─── WHAT THIS LOCKS, AND FOR WHOM ───────────────────────────────────────────
-- One predicate, three clients. The website, the installable PWA and the
-- React Native iPhone app all read these tables through the anon key, so this
-- gates all three at once. That is the strength of doing it here: there is no
-- client left that can bypass it. It is also the risk: the iPhone app cannot
-- be hot-fixed, so anyone wrongly locked out stays locked out until a store
-- release.
--
-- There is no free-deck concept in the schema, so this is all or nothing:
-- 73 decks, 2,681 questions and 12 lessons, or none of them.
--
-- The dry run at the bottom reports who would lose access. Run this file's
-- final SELECT on its own first if you want that answer without committing.
-- ─────────────────────────────────────────────────────────────────────────────

-- 0. Refuse to run before the guard exists ───────────────────────────────────
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
     WHERE n.nspname = 'public' AND p.proname = 'entitlement_guard_installed'
  ) THEN
    RAISE EXCEPTION
      'Run 20261014_entitlement_guard.sql first: without it subscription_status is learner-writable.';
  END IF;
  IF NOT public.entitlement_guard_installed() THEN
    RAISE EXCEPTION
      'The entitlement self-update trigger is missing. Gating on a column the learner can write is not a gate.';
  END IF;
END $$;

-- 1. The rule lives in the entitlements migration, not here ────────────────
--
-- public.has_content_entitlement() is defined by
-- 20261014_account_entitlements.sql, which owns it because that is where the
-- authoritative record lives. An earlier draft of this file defined it too,
-- reading subscription_status; two migrations defining one function differently
-- means whichever ran last silently decided the paywall. This one only uses it.
DO $$
BEGIN
  IF to_regprocedure('public.has_content_entitlement()') IS NULL THEN
    RAISE EXCEPTION 'Run 20261014_account_entitlements.sql first: it defines has_content_entitlement().';
  END IF;
END $$;

-- 2. Swap the predicate on each content table ────────────────────────────────
--
-- Deliberately one statement per table rather than a loop, so the diff names
-- every table this closes and nothing is gated by accident.

DROP POLICY IF EXISTS "Authenticated users can read decks" ON public.flashcard_decks;
DROP POLICY IF EXISTS "Entitled users can read decks" ON public.flashcard_decks;
CREATE POLICY "Entitled users can read decks"
  ON public.flashcard_decks FOR SELECT
  USING (auth.role() = 'authenticated' AND public.has_content_entitlement());

DROP POLICY IF EXISTS "Authenticated users can read cards" ON public.flashcards;
DROP POLICY IF EXISTS "Entitled users can read cards" ON public.flashcards;
CREATE POLICY "Entitled users can read cards"
  ON public.flashcards FOR SELECT
  USING (auth.role() = 'authenticated' AND public.has_content_entitlement());

DROP POLICY IF EXISTS "Authenticated users can read questions" ON public.questions;
DROP POLICY IF EXISTS "Entitled users can read questions" ON public.questions;
CREATE POLICY "Entitled users can read questions"
  ON public.questions FOR SELECT
  USING (auth.role() = 'authenticated' AND public.has_content_entitlement());

DROP POLICY IF EXISTS "Authenticated users can read passages" ON public.passages;
DROP POLICY IF EXISTS "Entitled users can read passages" ON public.passages;
CREATE POLICY "Entitled users can read passages"
  ON public.passages FOR SELECT
  USING (auth.role() = 'authenticated' AND public.has_content_entitlement());

DROP POLICY IF EXISTS "Authenticated users can read lessons" ON public.lessons;
DROP POLICY IF EXISTS "Entitled users can read lessons" ON public.lessons;
CREATE POLICY "Entitled users can read lessons"
  ON public.lessons FOR SELECT
  USING (auth.role() = 'authenticated' AND public.has_content_entitlement());

-- A learner's OWN rows are untouched on purpose: review history, card state,
-- attempts and progress stay readable and keep accruing. Losing a subscription
-- must not look like losing your work.

-- 3. Report who this affects ─────────────────────────────────────────────────
--
-- Counted through the entitlements table and is_admin, which is exactly what
-- the policies now consult. subscription_tier is deliberately absent: a label
-- is not evidence that anybody paid.
SELECT
  (SELECT count(*) FROM auth.users WHERE deleted_at IS NULL)          AS live_accounts,
  (SELECT count(*) FROM public.account_entitlements
    WHERE revoked_at IS NULL
      AND (expires_at IS NULL OR expires_at > now()))                 AS accounts_entitled,
  (SELECT count(*) FROM public.profiles WHERE is_admin)               AS admins,
  (SELECT count(*) FROM auth.users u
    WHERE u.deleted_at IS NULL
      AND NOT EXISTS (SELECT 1 FROM public.account_entitlements e
                       WHERE e.user_id = u.id AND e.revoked_at IS NULL
                         AND (e.expires_at IS NULL OR e.expires_at > now()))
      AND NOT EXISTS (SELECT 1 FROM public.profiles p
                       WHERE p.id = u.id AND p.is_admin))             AS would_lose_access;
