-- ─── profiles.account_kind: who counts as a student ───────────────────────
--
-- WHAT THIS IS FOR, AND WHAT IT IS NOT FOR.
--
-- It decides whose data may FIT a model. It does not decide how any model
-- behaves. A DEMO account and a STUDENT account compute identical learner
-- concept states, see identical dashboards and are scheduled identically. The
-- only difference is that calibration datasets filter to STUDENT.
--
-- WHY IT EXISTS. Phase 2 calibration found that one INTERNAL account holds 96%
-- of all flashcard reviews, and that its behaviour is not student behaviour:
-- a 33.7% Again rate against the students' 18.2%, and a median FSRS difficulty
-- of 9.20 against their 5.16. Two proposed model parameters were fitted on it
-- before the segmentation existed, and both were wrong. A lapse penalty of 0.07
-- looked strongly justified on 9,771 internal review transitions and vanished
-- on the students' 1,516. Without a truthful population label that mistake is
-- available to make again, silently, every time anyone fits anything.
--
-- WHY A POSITIVE FILTER. Calibration code must ask for account_kind = 'STUDENT'
-- and never for account_kind <> 'DEMO', because the second quietly readmits
-- INTERNAL, which is the account that caused the problem.
--
-- STORAGE: TEXT with a CHECK, matching subscription_tier on this same table.
-- This project uses no PostgreSQL enum types anywhere, and one field is not the
-- place to introduce a convention that then needs ALTER TYPE to extend.
--
-- CLASSIFICATION BY UUID, NOT EMAIL. The ids below were resolved from live
-- state and asserted unique before this file was written. Matching on email in
-- a migration is how 20260602_add_admin_role.sql silently did nothing: it set
-- is_admin WHERE email = 'mikko.nieveras@gmail.com', an address that does not
-- exist in profiles, so the founder was never made admin and is_admin is false
-- on all 7 rows to this day. Ids cannot miss quietly.
--
-- WRITES: profiles only, one new column and three row updates. No learner
-- history, no questions, no flashcards, no predictor data, no FSRS state.

BEGIN;

-- ─── 0. Pre-conditions ───────────────────────────────────────────────────
DO $pre$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.profiles;
  IF n <> 7 THEN RAISE NOTICE 'profile count is % (was 7 at authoring time)', n; END IF;

  SELECT count(*) INTO n FROM public.profiles
   WHERE id IN ('ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid,
                '35286b14-b18e-450b-b907-aba61c4d75eb'::uuid,
                'a8f57824-ed94-47c5-ad68-9cacff39dafd'::uuid);
  IF n <> 3 THEN
    RAISE EXCEPTION 'expected the 3 classified accounts to exist, found %', n;
  END IF;
END $pre$;

-- ─── 1. The column ───────────────────────────────────────────────────────
-- NOT NULL DEFAULT 'STUDENT' means ordinary signup needs no code change: the
-- handle_new_user() trigger inserts (id, first_name, last_name, email) and the
-- default supplies the rest. Every future account is a student until someone
-- deliberately says otherwise.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS account_kind TEXT NOT NULL DEFAULT 'STUDENT';

ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_account_kind_check;
ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_account_kind_check
  CHECK (account_kind IN ('STUDENT', 'DEMO', 'INTERNAL'));

COMMENT ON COLUMN public.profiles.account_kind IS
  'Calibration eligibility only. STUDENT data may fit model thresholds; DEMO and INTERNAL may not. Runtime learner-state logic is identical for all three.';

-- ─── 2. The three known non-student accounts ─────────────────────────────
-- By id. Each was asserted to resolve to exactly one row before this ran.
UPDATE public.profiles SET account_kind = 'INTERNAL'
 WHERE id = 'ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'::uuid;   -- mikko2@praxisprep.com

UPDATE public.profiles SET account_kind = 'DEMO'
 WHERE id IN ('35286b14-b18e-450b-b907-aba61c4d75eb'::uuid,  -- ig-demo@praxisprep.app
              'a8f57824-ed94-47c5-ad68-9cacff39dafd'::uuid); -- demo@praxisprep.com

-- ─── 3. A user may not reclassify themselves ─────────────────────────────
-- RLS grants "Users can update own profile" FOR UPDATE USING (auth.uid() = id)
-- with no column restriction, so without this a student could set themselves
-- INTERNAL and leave the calibration population, or set a rival DEMO. The
-- revert-silently shape is copied exactly from prevent_is_admin_self_update:
-- the write succeeds, the column does not move, and service_role is unaffected.
CREATE OR REPLACE FUNCTION public.prevent_account_kind_self_update()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF auth.role() = 'authenticated'
     AND OLD.account_kind IS DISTINCT FROM NEW.account_kind
  THEN
    NEW.account_kind := OLD.account_kind;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS profiles_prevent_self_account_kind_update ON public.profiles;
CREATE TRIGGER profiles_prevent_self_account_kind_update
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.prevent_account_kind_self_update();

-- ─── Post-conditions ─────────────────────────────────────────────────────
DO $post$
DECLARE n INT;
BEGIN
  SELECT count(*) INTO n FROM public.profiles WHERE account_kind IS NULL;
  IF n <> 0 THEN RAISE EXCEPTION '% profiles have a null account_kind', n; END IF;

  SELECT count(*) INTO n FROM public.profiles WHERE account_kind = 'INTERNAL';
  IF n <> 1 THEN RAISE EXCEPTION 'expected exactly 1 INTERNAL account, found %', n; END IF;

  SELECT count(*) INTO n FROM public.profiles WHERE account_kind = 'DEMO';
  IF n <> 2 THEN RAISE EXCEPTION 'expected exactly 2 DEMO accounts, found %', n; END IF;

  SELECT count(*) INTO n FROM public.profiles
   WHERE account_kind NOT IN ('STUDENT', 'DEMO', 'INTERNAL');
  IF n <> 0 THEN RAISE EXCEPTION '% profiles carry an unknown account_kind', n; END IF;

  SELECT count(*) INTO n FROM pg_trigger
   WHERE tgname = 'profiles_prevent_self_account_kind_update' AND NOT tgisinternal;
  IF n <> 1 THEN RAISE EXCEPTION 'the self-reclassification guard is not attached'; END IF;

  RAISE NOTICE 'account_kind live: 1 INTERNAL, 2 DEMO, the rest STUDENT, guard attached';
END $post$;

COMMIT;
