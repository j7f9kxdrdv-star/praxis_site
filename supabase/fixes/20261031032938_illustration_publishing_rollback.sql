-- ═══════════════════════════════════════════════════════════════════════════
-- NOT APPLIED. Undo supabase/migrations/20261031032938_illustration_publishing.sql.
--
-- WHEN. Only if the publishing migration has to come out. Not needed to undo a
-- batch: a published batch is undone with public.illustration_rollback_batch.
--
-- WHAT IT DOES, in one transaction:
--   1. Refuses, changing nothing, if any batch is live (PUBLISHED or VERIFIED).
--      Those cards point at images only the audit trail explains; roll each
--      batch back first, newest first.
--   2. Restores, exactly, the privileges on public.flashcards and the policy
--      comment that the migration recorded in illustrations.install_baseline
--      the moment before it changed them. Nothing is guessed. Every grantee
--      (PUBLIC included), every privilege, every grant option, on the table
--      and on every column the baseline recorded, is made to match; then the
--      full access lists, grantor included, are compared entry by entry, and
--      any difference undoes the whole rollback. A privilege that cannot be
--      restored exactly is therefore never lost quietly: the rollback stops
--      and says where. A REVOKE that other grants depend on fails rather than
--      cascading. Columns added after the migration are left alone.
--   3. Drops the eight public.illustration_* functions, so no API role can
--      call anything the migration added.
--   4. Drops the private illustrations schema ONLY if no batch was ever
--      staged. If any batch exists, the schema and its audit trail stay (no API
--      role can reach them), and re-applying the migration would then need a
--      deliberate decision about that history.
--   5. Checks its own work and stops (undoing everything) if any of it is not
--      exactly as intended.
--
-- It never touches card content, illustrations on cards, storage objects,
-- learner reviews, card states or FSRS schedules.
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

DO $guard$
DECLARE n int;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_namespace WHERE nspname = 'illustrations') THEN
    RAISE EXCEPTION 'ABORT: the publishing migration is not installed; nothing was changed';
  END IF;
  SELECT count(*) INTO n FROM illustrations.batches WHERE state IN ('PUBLISHED', 'VERIFIED');
  IF n > 0 THEN
    RAISE EXCEPTION 'ABORT: % batch(es) are live. Roll each back with public.illustration_rollback_batch first, newest first; nothing was changed', n;
  END IF;
  IF (SELECT count(*) FROM illustrations.install_baseline
       WHERE key IN ('flashcards_table_acl', 'flashcards_column_acl', 'admin_policy_comment')) <> 3 THEN
    RAISE EXCEPTION 'ABORT: the install baseline is incomplete, so the privileges cannot be restored exactly; nothing was changed';
  END IF;
  SELECT count(*) INTO n
    FROM illustrations.install_baseline b, jsonb_object_keys(b.value) k(col)
   WHERE b.key = 'flashcards_column_acl'
     AND NOT EXISTS (SELECT 1 FROM pg_catalog.pg_attribute a
                      WHERE a.attrelid = 'public.flashcards'::regclass AND a.attname = k.col AND a.attnum > 0 AND NOT a.attisdropped);
  IF n > 0 THEN
    RAISE EXCEPTION 'ABORT: % column(s) recorded in the baseline no longer exist, so their privileges cannot be restored exactly; nothing was changed', n;
  END IF;
END
$guard$;

-- The recorded and current access lists, as one row per
-- (grantor, grantee, privilege, grant option). column_name is NULL for the
-- table itself. A table list stored as JSON null was never granted: that
-- means the owner's defaults (acldefault). A column list that is NULL holds
-- no privileges. Temporary, and dropped before COMMIT: the restore and the
-- final comparison read exactly the same rows, and nothing is left behind.
CREATE TEMP TABLE acl_columns ON COMMIT DROP AS
SELECT jsonb_object_keys(value)::name AS column_name
  FROM illustrations.install_baseline WHERE key = 'flashcards_column_acl';
CREATE TEMP TABLE acl_saved ON COMMIT DROP AS
SELECT NULL::name AS column_name, x.grantor, x.grantee, x.privilege_type, x.is_grantable
  FROM illustrations.install_baseline b
 CROSS JOIN LATERAL unnest(COALESCE(
         CASE WHEN jsonb_typeof(b.value) = 'array' THEN ARRAY(SELECT jsonb_array_elements_text(b.value))::aclitem[] END,
         acldefault('r', (SELECT relowner FROM pg_catalog.pg_class WHERE oid = 'public.flashcards'::regclass)))) u(item)
 CROSS JOIN LATERAL aclexplode(ARRAY[u.item]) x
 WHERE b.key = 'flashcards_table_acl'
UNION ALL
SELECT c.col::name, x.grantor, x.grantee, x.privilege_type, x.is_grantable
  FROM illustrations.install_baseline b
 CROSS JOIN LATERAL jsonb_each(b.value) c(col, acl)
 CROSS JOIN LATERAL unnest(CASE WHEN jsonb_typeof(c.acl) = 'array' THEN ARRAY(SELECT jsonb_array_elements_text(c.acl))::aclitem[]
                                ELSE '{}'::aclitem[] END) u(item)
 CROSS JOIN LATERAL aclexplode(ARRAY[u.item]) x
 WHERE b.key = 'flashcards_column_acl';

CREATE FUNCTION pg_temp.acl_now()
RETURNS TABLE (column_name name, grantor oid, grantee oid, privilege_type text, is_grantable boolean)
LANGUAGE sql STABLE AS $f$
  SELECT NULL::name, x.grantor, x.grantee, x.privilege_type, x.is_grantable
    FROM pg_catalog.pg_class k
   CROSS JOIN LATERAL unnest(COALESCE(k.relacl, acldefault('r', k.relowner))) u(item)
   CROSS JOIN LATERAL aclexplode(ARRAY[u.item]) x
   WHERE k.oid = 'public.flashcards'::regclass
  UNION ALL
  SELECT a.attname, x.grantor, x.grantee, x.privilege_type, x.is_grantable
    FROM pg_catalog.pg_attribute a
   CROSS JOIN LATERAL unnest(COALESCE(a.attacl, '{}'::aclitem[])) u(item)
   CROSS JOIN LATERAL aclexplode(ARRAY[u.item]) x
   WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
     AND a.attname IN (SELECT column_name FROM pg_temp.acl_columns);
$f$;

-- ─── Restore privileges and the policy comment exactly as recorded ─────────
DO $restore$
DECLARE
  d             record;
  who           text;
  target        text;
  saved_comment text;
  pass          int;
BEGIN
  SELECT value #>> '{}' INTO saved_comment FROM illustrations.install_baseline WHERE key = 'admin_policy_comment';

  -- Pass 1 is the table, pass 2 every recorded column. The table goes first
  -- because revoking a table privilege also revokes it from every column.
  FOR pass IN 1..2 LOOP
    FOR d IN
      WITH want AS (SELECT column_name, grantee, privilege_type, bool_or(is_grantable) AS g FROM pg_temp.acl_saved
                     WHERE (column_name IS NULL) = (pass = 1) GROUP BY 1, 2, 3),
           have AS (SELECT column_name, grantee, privilege_type, bool_or(is_grantable) AS g FROM pg_temp.acl_now()
                     WHERE (column_name IS NULL) = (pass = 1) GROUP BY 1, 2, 3)
      SELECT COALESCE(w.column_name, h.column_name) AS col, COALESCE(w.grantee, h.grantee) AS grantee,
             COALESCE(w.privilege_type, h.privilege_type) AS priv, w.g AS want_g, h.g AS have_g
        FROM want w FULL JOIN have h
          ON h.column_name IS NOT DISTINCT FROM w.column_name AND h.grantee = w.grantee AND h.privilege_type = w.privilege_type
       WHERE w.g IS DISTINCT FROM h.g
       ORDER BY 1 NULLS FIRST, 2, 3
    LOOP
      who := CASE WHEN d.grantee = 0 THEN 'PUBLIC' ELSE quote_ident(pg_get_userbyid(d.grantee)) END;
      target := CASE WHEN d.col IS NULL THEN d.priv || ' ON public.flashcards'
                     ELSE format('%s (%I) ON public.flashcards', d.priv, d.col) END;
      IF d.want_g IS NULL THEN
        EXECUTE format('REVOKE %s FROM %s', target, who);
      ELSIF d.have_g IS NULL OR d.want_g THEN
        EXECUTE format('GRANT %s TO %s%s', target, who, CASE WHEN d.want_g THEN ' WITH GRANT OPTION' ELSE '' END);
      ELSE
        EXECUTE format('REVOKE GRANT OPTION FOR %s FROM %s', target, who);
      END IF;
    END LOOP;
  END LOOP;

  EXECUTE format('COMMENT ON POLICY %I ON public.flashcards IS %L', 'Admins can update flashcards', saved_comment);
END
$restore$;

-- ─── Remove what the migration added ───────────────────────────────────────
DROP FUNCTION public.illustration_batch_status(uuid);
DROP FUNCTION public.illustration_rollback_batch(uuid, text, uuid, text, text);
DROP FUNCTION public.illustration_record_postverify(uuid, boolean, jsonb);
DROP FUNCTION public.illustration_publish_batch(uuid, text);
DROP FUNCTION public.illustration_record_approval(uuid, text, uuid, text, text);
DROP FUNCTION public.illustration_approve_batch(uuid, text, text);
DROP FUNCTION public.illustration_stage_batch(uuid, jsonb, text);
DROP FUNCTION public.illustration_record_verification(text, text, bigint, text, text, text);

-- ─── Check the result, then drop the schema if it never held a batch ───────
DO $post$
DECLARE
  diff    int;
  example text;
BEGIN
  IF EXISTS (SELECT 1 FROM pg_catalog.pg_proc p JOIN pg_catalog.pg_namespace s ON s.oid = p.pronamespace
              WHERE s.nspname = 'public' AND p.proname LIKE 'illustration\_%') THEN
    RAISE EXCEPTION 'POST: an illustration_* function is still installed';
  END IF;

  -- Every entry, grantor and grant option included, on the table and on every
  -- recorded column, must be exactly as recorded: nothing missing, nothing extra.
  SELECT count(*), min(format('%s %s %s%s by %s',
                              COALESCE('column ' || d.column_name, 'table'),
                              CASE WHEN d.grantee = 0 THEN 'PUBLIC' ELSE pg_get_userbyid(d.grantee) END,
                              d.privilege_type, CASE WHEN d.is_grantable THEN ' WITH GRANT OPTION' ELSE '' END,
                              pg_get_userbyid(d.grantor)))
    INTO diff, example
    FROM ((SELECT * FROM pg_temp.acl_saved EXCEPT SELECT * FROM pg_temp.acl_now())
          UNION ALL
          (SELECT * FROM pg_temp.acl_now() EXCEPT SELECT * FROM pg_temp.acl_saved)) d;
  IF diff <> 0 THEN
    RAISE EXCEPTION 'POST: privileges on flashcards differ from the recorded baseline in % place(s), e.g. %; nothing was changed', diff, example;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM illustrations.batches) THEN
    DROP SCHEMA illustrations CASCADE;
  END IF;
END
$post$;

DROP FUNCTION pg_temp.acl_now();

COMMIT;

-- ── What remains (run after; read-only) ────────────────────────────────────
SELECT
  (SELECT count(*) FROM pg_catalog.pg_proc p JOIN pg_catalog.pg_namespace s ON s.oid = p.pronamespace
    WHERE s.nspname = 'public' AND p.proname LIKE 'illustration\_%')            AS illustration_functions_left,  -- expect 0
  EXISTS (SELECT 1 FROM pg_catalog.pg_namespace WHERE nspname = 'illustrations') AS audit_schema_kept,            -- true only if a batch was ever staged
  (SELECT count(*) FROM public.flashcards WHERE back_image_url IS NOT NULL)      AS illustrated_cards;            -- unchanged by this script
