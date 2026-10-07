-- ─── Capturing the learner's timezone, once ────────────────────────────────
-- REQUIRES: 20261007_03_writer_lock_64bit.sql
--
-- WHAT WAS WRONG. profiles.timezone has existed since August and its own
-- comment says "NULL means the client has not reported one yet; callers fall
-- back to the browser timezone until it is set". Nothing ever set it.
-- detectTimezone() exists in lib/flashcards/studyDay.ts, is exported, and is
-- called from nowhere. Five of nine live profiles are NULL and every future
-- signup would have been too, which left the learner-local study day correct
-- in principle and defaulted to UTC in practice.
--
-- This migration does the server half of fixing that:
--
--   1. handle_new_user() now initialises timezone from the signup metadata,
--      when the browser supplied one and the server recognises it.
--   2. A trigger refuses an unrecognised timezone on any write, from any path.
--
-- VALIDATION IS SERVER-SIDE AND NOT NEGOTIABLE. The value arrives from a
-- browser, which means it arrives from whoever is driving that browser. A
-- client that sends "Mars/Olympus_Mons", or an empty string, or a 10kB blob,
-- must not be able to persist it: a learner whose timezone cannot be parsed
-- has every study day computed against a fallback while the database claims
-- otherwise, and after history exists that misreads their past as well.
--
-- pg_timezone_names IS THE RIGHT AUTHORITY. It is PostgreSQL's own view of the
-- same IANA database the browser read the name out of, so the two agree by
-- construction. A hand-maintained list of zone names in a CHECK would be stale
-- the first time IANA adds one.
--
-- WHY NULL STAYS LEGAL. The capture path cannot reach an account that never
-- opens the app again, and OAuth signups cannot carry metadata at creation at
-- all. Making NULL illegal would lock those accounts out of a runtime they are
-- entitled to; the documented UTC fallback covers them, and the account
-- universe preflight treats NULL as ready and INVALID as a failure.
--
-- WHAT THIS MIGRATION DOES NOT DO. It writes no timezone for the five existing
-- NULL profiles. Four live accounts say America/New_York and guessing the same
-- for the other five would be inventing a fact about where five people live
-- from a sample of four. They stay NULL until a browser tells us.

BEGIN;

-- ── A timezone this server cannot resolve is not a timezone ───────────────
CREATE OR REPLACE FUNCTION public.validate_profile_timezone()
RETURNS TRIGGER AS $fn$
BEGIN
  -- Only a change matters, so an ordinary profile edit never pays for this,
  -- and a row that somehow already holds a bad value can still be repaired by
  -- a write that fixes it.
  IF TG_OP = 'UPDATE' AND NEW.timezone IS NOT DISTINCT FROM OLD.timezone THEN
    RETURN NEW;
  END IF;

  -- NULL is legal: it means nobody has reported one, and the runtime has a
  -- documented fallback for exactly that.
  IF NEW.timezone IS NULL THEN
    RETURN NEW;
  END IF;

  IF btrim(NEW.timezone) = '' THEN
    RAISE EXCEPTION 'profiles.timezone cannot be an empty string. Use NULL to mean "not reported yet".';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_timezone_names WHERE name = NEW.timezone) THEN
    RAISE EXCEPTION 'profiles.timezone % is not a timezone this server recognises. It must be an IANA name such as America/New_York.',
      NEW.timezone;
  END IF;

  RETURN NEW;
END; $fn$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS profiles_validate_timezone ON public.profiles;
CREATE TRIGGER profiles_validate_timezone
  BEFORE INSERT OR UPDATE OF timezone ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.validate_profile_timezone();

COMMENT ON FUNCTION public.validate_profile_timezone() IS
  'Refuses a timezone the server cannot resolve, on every write path. NULL stays legal and means "not reported yet"; the runtime falls back to UTC for it. Validated against pg_timezone_names, which is PostgreSQL''s view of the same IANA database the browser read the name from.';

-- ── Signup initialises it, when the browser could say ─────────────────────
-- Same shape as before: id, first_name, last_name and email all come from the
-- new auth row. Timezone joins them, read from the same metadata the signup
-- form already sends first_name through.
--
-- VALIDATED HERE TOO, not just by the trigger. An unrecognised value makes the
-- profile fall back to NULL rather than failing the signup: a person must not
-- be unable to create an account because their browser reported a zone this
-- server has never heard of. The trigger is the hard floor; this is the soft
-- landing in front of it.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE tz TEXT;
BEGIN
  tz := NULLIF(btrim(COALESCE(NEW.raw_user_meta_data ->> 'timezone', '')), '');
  IF tz IS NOT NULL AND NOT EXISTS (SELECT 1 FROM pg_timezone_names WHERE name = tz) THEN
    tz := NULL;
  END IF;

  INSERT INTO public.profiles (id, first_name, last_name, email, timezone)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data ->> 'first_name',
    NEW.raw_user_meta_data ->> 'last_name',
    NEW.email,
    tz
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─── Post-conditions ───────────────────────────────────────────────────────
DO $post$
DECLARE
  n INT; before_null INT; before_digest TEXT; after_digest TEXT;
  leaked TEXT[] := ARRAY[]::TEXT[];
  u UUID; defn TEXT;
BEGIN
  SELECT count(*) INTO before_null FROM public.profiles WHERE timezone IS NULL;
  SELECT md5(string_agg(id::TEXT || '|' || COALESCE(timezone, 'NULL'), '|' ORDER BY id))
    INTO before_digest FROM public.profiles;

  -- The trigger is attached where it needs to be.
  SELECT pg_get_triggerdef(t.oid) INTO defn
    FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
   WHERE NOT t.tgisinternal AND c.relname = 'profiles' AND t.tgname = 'profiles_validate_timezone';
  IF defn IS NULL THEN RAISE EXCEPTION 'TZ: the validation trigger is missing'; END IF;
  IF position('BEFORE INSERT OR UPDATE OF timezone' IN defn) = 0 THEN
    RAISE EXCEPTION 'TZ: the validation trigger fires on the wrong events: %', defn;
  END IF;

  -- The sibling guards that protect the rest of the profile must survive. A
  -- timezone write path must never become a way to edit account_kind or
  -- is_admin.
  --
  -- MATCHED ON THE FUNCTION, NOT THE TRIGGER NAME. The first version of this
  -- looked for triggers called prevent_is_admin_self_update and
  -- prevent_account_kind_self_update, which are the FUNCTIONS; the triggers
  -- are profiles_prevent_self_admin_update and
  -- profiles_prevent_self_account_kind_update. It found zero and refused to
  -- apply, which is the assertion working. The function is what actually does
  -- the protecting, so asking about it is both correct and immune to a
  -- trigger being renamed.
  SELECT count(*) INTO n
    FROM pg_trigger t
    JOIN pg_class c ON c.oid = t.tgrelid
    JOIN pg_proc p ON p.oid = t.tgfoid
   WHERE NOT t.tgisinternal AND c.relname = 'profiles'
     AND p.proname IN ('prevent_is_admin_self_update', 'prevent_account_kind_self_update');
  IF n <> 2 THEN
    RAISE EXCEPTION 'TZ: expected the 2 profile protection functions to still be attached to profiles, found %', n;
  END IF;

  -- ── Drive it, on a real row, and put it back ─────────────────────────────
  SELECT id INTO u FROM public.profiles WHERE timezone IS NOT NULL ORDER BY id LIMIT 1;
  IF u IS NULL THEN SELECT id INTO u FROM public.profiles ORDER BY id LIMIT 1; END IF;

  FOR n IN 1 .. 3 LOOP
    BEGIN
      UPDATE public.profiles SET timezone = CASE n
        WHEN 1 THEN 'Mars/Olympus_Mons'
        WHEN 2 THEN ''
        ELSE 'not a zone at all'
      END WHERE id = u;
      leaked := array_append(leaked, 'an unrecognised timezone (' || n || ') was accepted');
    EXCEPTION WHEN OTHERS THEN NULL;
    END;
  END LOOP;

  -- A real one is accepted, then restored.
  DECLARE original TEXT;
  BEGIN
    SELECT timezone INTO original FROM public.profiles WHERE id = u;
    BEGIN
      UPDATE public.profiles SET timezone = 'Asia/Tokyo' WHERE id = u;
    EXCEPTION WHEN OTHERS THEN
      leaked := array_append(leaked, 'a valid timezone was REFUSED: ' || SQLERRM);
    END;
    IF (SELECT timezone FROM public.profiles WHERE id = u) IS DISTINCT FROM 'Asia/Tokyo' THEN
      leaked := array_append(leaked, 'a valid timezone did not land');
    END IF;
    -- NULL is legal.
    BEGIN
      UPDATE public.profiles SET timezone = NULL WHERE id = u;
    EXCEPTION WHEN OTHERS THEN
      leaked := array_append(leaked, 'NULL was refused, but it means "not reported yet": ' || SQLERRM);
    END;
    UPDATE public.profiles SET timezone = original WHERE id = u;
  END;

  -- ── Nothing moved ───────────────────────────────────────────────────────
  SELECT md5(string_agg(id::TEXT || '|' || COALESCE(timezone, 'NULL'), '|' ORDER BY id))
    INTO after_digest FROM public.profiles;
  IF after_digest IS DISTINCT FROM before_digest THEN
    RAISE EXCEPTION 'TZ: the probes changed a stored timezone';
  END IF;
  SELECT count(*) INTO n FROM public.profiles WHERE timezone IS NULL;
  IF n <> before_null THEN
    RAISE EXCEPTION 'TZ: the NULL timezone count moved from % to %', before_null, n;
  END IF;

  IF array_length(leaked, 1) > 0 THEN
    RAISE EXCEPTION 'TZ FAILED: %', array_to_string(leaked, ' | ');
  END IF;

  RAISE NOTICE 'TZ OK: signup now initialises timezone from validated metadata, unrecognised values are refused on every write path, NULL remains legal, and all % profile(s) are untouched (% still NULL).',
    (SELECT count(*) FROM public.profiles), before_null;
END $post$;

COMMIT;

-- ─── Read-back ─────────────────────────────────────────────────────────────
SELECT tgname, pg_get_triggerdef(t.oid) AS definition
FROM pg_trigger t JOIN pg_class c ON c.oid = t.tgrelid
WHERE NOT t.tgisinternal AND c.relname = 'profiles'
ORDER BY tgname;

SELECT
  count(*) AS profiles,
  count(timezone) AS with_timezone,
  count(*) - count(timezone) AS null_timezone
FROM public.profiles;
