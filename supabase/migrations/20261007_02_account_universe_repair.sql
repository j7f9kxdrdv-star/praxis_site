-- ─── Every auth user is an account; two of them were not ──────────────────
-- REQUIRES: 20261007_01_writer_runs_as_service_role.sql
--
-- THE INVARIANT THIS ESTABLISHES. auth.users is the canonical account
-- universe, and public.profiles supplies the runtime metadata each account
-- needs. After this migration those two agree exactly: every auth user has one
-- profile, every profile has one auth user. An auth user with no profile stops
-- being a disposition to live with and becomes an integrity failure.
--
-- WHY IT MATTERED. Every account tally in this project came from profiles,
-- which held 7 rows while auth.users held 9. Two accounts were invisible to
-- every count, audit and report for six months, and nothing was wrong with
-- either of them: they simply had no profile row, so a universe defined as
-- "the profiles table" did not contain them.
--
-- THE TWO ACCOUNTS, identified by full id rather than by prefix, and audited
-- before this was written:
--
--   6ca9f8d5-3f38-4603-85af-2bba40f2aef3   test@praxisprep.com    13:41 UTC
--   cc869a7d-a240-4762-be7e-9306707cec10   test2@praxisprep.com   13:42 UTC
--
-- Both created on 7 April within one minute of each other, during the initial
-- auth setup and before the demo and internal accounts. Neither has EVER
-- signed in. Neither holds a single scheduler row, review, question attempt or
-- snapshot. The likeliest explanation is that they predate the
-- handle_new_user() trigger that has created a profile for every account
-- since; four later accounts all have one, so nothing blocks creation today.
--
-- THE SHAPE OF THE REPAIR. Not a minimal three-column insert. The profiles
-- these receive are the shape a normal signup produces today — handle_new_user
-- supplies id, first_name, last_name and email, and every other column takes
-- its schema default, including account_kind STUDENT and day_start_hour 4 —
-- with one explicitly approved override: account_kind INTERNAL, because these
-- are project-owned accounts and classifying them STUDENT would put them in
-- the calibration population, where two never-used accounts do not belong.
--
-- The email is read from auth.users rather than typed here, so the profile
-- carries the address the account actually has.
--
-- NO LEARNER EVIDENCE IS FABRICATED. These accounts have studied nothing and
-- will compute to zero concept states, which is the correct sparse answer.

BEGIN;

-- ── Before ────────────────────────────────────────────────────────────────
DO $pre$
DECLARE a INT; p INT; missing INT; orphan INT;
BEGIN
  SELECT count(*) INTO a FROM auth.users;
  SELECT count(*) INTO p FROM public.profiles;
  SELECT count(*) INTO missing FROM auth.users u
   WHERE NOT EXISTS (SELECT 1 FROM public.profiles x WHERE x.id = u.id);
  SELECT count(*) INTO orphan FROM public.profiles x
   WHERE NOT EXISTS (SELECT 1 FROM auth.users u WHERE u.id = x.id);
  RAISE NOTICE 'BEFORE: % auth user(s), % profile(s), % without a profile, % orphan profile(s)', a, p, missing, orphan;

  IF orphan <> 0 THEN
    RAISE EXCEPTION 'REPAIR: % profile(s) have no auth user. That is a different fault and this migration does not address it.', orphan;
  END IF;

  -- The two reviewed accounts, and only those two. If a THIRD account has
  -- appeared without a profile since the audit, that is a live signup fault
  -- rather than the legacy case, and it must be looked at rather than swept
  -- up by a migration written about two specific accounts.
  IF missing <> 2 THEN
    RAISE EXCEPTION 'REPAIR: expected exactly the 2 audited legacy accounts without a profile, found %. Re-audit before repairing.', missing;
  END IF;
  IF EXISTS (
    SELECT 1 FROM auth.users u
     WHERE NOT EXISTS (SELECT 1 FROM public.profiles x WHERE x.id = u.id)
       AND u.id NOT IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10')
  ) THEN
    RAISE EXCEPTION 'REPAIR: an account other than the two audited ones has no profile. Stop and audit.';
  END IF;

  -- And they must still be what the audit found them to be. A repair written
  -- for two empty, never-used accounts must not quietly run against accounts
  -- that have since been used.
  IF EXISTS (
    SELECT 1 FROM auth.users u
     WHERE u.id IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10')
       AND (u.last_sign_in_at IS NOT NULL
         OR EXISTS (SELECT 1 FROM public.flashcard_user_state s WHERE s.user_id = u.id)
         OR EXISTS (SELECT 1 FROM public.flashcard_reviews r WHERE r.user_id = u.id)
         OR EXISTS (SELECT 1 FROM public.question_attempts q WHERE q.user_id = u.id)
         OR EXISTS (SELECT 1 FROM public.learner_state_snapshots n WHERE n.user_id = u.id))
  ) THEN
    RAISE EXCEPTION 'REPAIR: one of the two accounts has signed in or holds learner data since the audit. Re-audit before repairing.';
  END IF;
END $pre$;

-- ── The repair ────────────────────────────────────────────────────────────
-- Column list deliberately matches handle_new_user(), plus the one approved
-- override. Everything else takes its schema default, which is what makes
-- these profiles the same shape a signup produces today.
INSERT INTO public.profiles (id, first_name, last_name, email, account_kind)
SELECT
  u.id,
  u.raw_user_meta_data ->> 'first_name',
  u.raw_user_meta_data ->> 'last_name',
  u.email,
  'INTERNAL'
FROM auth.users u
WHERE u.id IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10')
  AND NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id);

-- ── After ─────────────────────────────────────────────────────────────────
DO $post$
DECLARE a INT; p INT; missing INT; orphan INT; r RECORD; bad INT;
BEGIN
  SELECT count(*) INTO a FROM auth.users;
  SELECT count(*) INTO p FROM public.profiles;
  SELECT count(*) INTO missing FROM auth.users u
   WHERE NOT EXISTS (SELECT 1 FROM public.profiles x WHERE x.id = u.id);
  SELECT count(*) INTO orphan FROM public.profiles x
   WHERE NOT EXISTS (SELECT 1 FROM auth.users u WHERE u.id = x.id);

  IF missing <> 0 THEN RAISE EXCEPTION 'REPAIR: % auth user(s) still have no profile', missing; END IF;
  IF orphan <> 0 THEN RAISE EXCEPTION 'REPAIR: % profile(s) have no auth user', orphan; END IF;
  IF a <> p THEN RAISE EXCEPTION 'REPAIR: % auth users but % profiles', a, p; END IF;

  -- One profile per auth user, not merely the same count.
  SELECT count(*) INTO bad FROM (
    SELECT id FROM public.profiles GROUP BY id HAVING count(*) > 1) d;
  IF bad <> 0 THEN RAISE EXCEPTION 'REPAIR: % duplicated profile id(s)', bad; END IF;

  -- Every profile now carries what a batch computation needs.
  SELECT count(*) INTO bad FROM public.profiles
   WHERE account_kind IS NULL OR day_start_hour IS NULL
      OR account_kind NOT IN ('STUDENT', 'DEMO', 'INTERNAL');
  IF bad <> 0 THEN RAISE EXCEPTION 'REPAIR: % profile(s) lack usable account_kind or day_start_hour', bad; END IF;

  -- The two repaired rows are the shape intended.
  FOR r IN SELECT id, email, account_kind, day_start_hour, onboarding_completed,
                  daily_new_card_limit, daily_review_limit, weekly_question_goal
             FROM public.profiles
            WHERE id IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10')
  LOOP
    IF r.account_kind <> 'INTERNAL' THEN
      RAISE EXCEPTION 'REPAIR: % has account_kind %, expected INTERNAL', r.id, r.account_kind;
    END IF;
    IF r.day_start_hour <> 4 THEN
      RAISE EXCEPTION 'REPAIR: % has day_start_hour %, expected the schema default 4', r.id, r.day_start_hour;
    END IF;
    IF r.email IS NULL THEN
      RAISE EXCEPTION 'REPAIR: % has no email, so it did not come from auth.users', r.id;
    END IF;
    RAISE NOTICE 'REPAIRED: % (%) kind % day_start_hour % onboarding % limits %/%/%',
      r.id, r.email, r.account_kind, r.day_start_hour, r.onboarding_completed,
      r.daily_new_card_limit, r.daily_review_limit, r.weekly_question_goal;
  END LOOP;

  -- And no OTHER profile moved. The repair inserts two rows and touches
  -- nothing else; this proves it rather than trusting the WHERE clause.
  SELECT count(*) INTO bad FROM public.profiles
   WHERE id NOT IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10')
     AND updated_at > now() - interval '1 minute';
  IF bad <> 0 THEN
    RAISE EXCEPTION 'REPAIR: % existing profile(s) were modified, which this migration must not do', bad;
  END IF;

  RAISE NOTICE 'AFTER: % auth user(s), % profile(s), 0 without a profile, 0 orphan. Every auth user is now an account.', a, p;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT
  (SELECT count(*) FROM auth.users)      AS auth_users,
  (SELECT count(*) FROM public.profiles) AS profiles,
  (SELECT count(*) FROM auth.users u
    WHERE NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id)) AS auth_without_profile,
  (SELECT count(*) FROM public.profiles p
    WHERE NOT EXISTS (SELECT 1 FROM auth.users u WHERE u.id = p.id))      AS profile_without_auth;

SELECT account_kind, count(*) FROM public.profiles GROUP BY account_kind ORDER BY account_kind;

SELECT id, email, account_kind, day_start_hour
FROM public.profiles
WHERE id IN ('6ca9f8d5-3f38-4603-85af-2bba40f2aef3', 'cc869a7d-a240-4762-be7e-9306707cec10');
