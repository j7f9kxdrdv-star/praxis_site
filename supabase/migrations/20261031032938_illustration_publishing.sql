-- ═══════════════════════════════════════════════════════════════════════════
-- Migration 20261031032938: flashcard illustration publishing.
-- NOT APPLIED to production. This is its permanent name: it was renamed from
-- PROPOSED_20261027_illustration_publishing.sql before review so that the
-- file reviewed, committed and applied is the same file under the same name.
-- Production applies it by pasting it into the SQL Editor, like every earlier
-- migration (supabase/APPLIED.md records each application); never with
-- `supabase db push`.
--
-- Companion files, all in supabase/fixes/:
--   20261031032938_illustration_publishing_precheck.sql   run BEFORE (read-only)
--   20261031032938_illustration_publishing_postcheck.sql  run AFTER (read-only)
--   20261031032938_illustration_publishing_rollback.sql   undoes this migration
--
-- ONE TRANSACTION. CREATE FUNCTION grants EXECUTE to PUBLIC by default, and on
-- Supabase the public schema's default privileges also grant it to anon and
-- authenticated. Inside a single transaction no other session can observe a
-- function before its grants are revoked, so that window never exists. Any
-- statement that fails (an assumption about production that does not hold)
-- aborts the whole migration and leaves production exactly as it was.
--
-- ─── WHAT THIS GIVES ───────────────────────────────────────────────────────
--
-- A batch of illustrations moves through these states, each a separate call:
--
--   record_verification  the operator read the object's storage version,
--                        downloaded the full bytes, hashed them with SHA-256,
--                        read the version again, and reports all of it; the
--                        database requires that version to still be current
--   stage_batch          the exact card -> image mapping is fixed and given a
--                        digest; every image must already be verified
--   approve_batch        an administrator approves THAT digest from their own
--                        signed-in session (the database authenticates them)
--   record_approval      or the operator records an approval the administrator
--                        gave by instruction, quoting it (the database does
--                        NOT authenticate the administrator; see APPROVAL)
--   publish_batch        one transaction attaches every image or none
--   record_postverify    the operator's independent check of the live result,
--                        cross-checked by the database
--   rollback_batch       restores exactly what each card held before, only
--                        if nothing has changed on those cards since
--
-- ─── WHO CAN CALL WHAT ─────────────────────────────────────────────────────
--
--   anon                     nothing
--   authenticated            approve_batch and batch_status, and both refuse
--                            anyone whose profiles.is_admin is not true
--   service_role (operator)  everything else
--
-- Learners, subscribers and grandfathered LEGACY_FULL_ACCESS accounts are all
-- `authenticated` without is_admin, so they can do nothing here. No allowlist
-- of emails or UUIDs exists anywhere: auth.users stays canonical, and an
-- administrator is a flag on a profile, which a user cannot set on their own
-- (trigger profiles_prevent_self_admin_update, 20260602_add_admin_role.sql).
--
-- ─── APPROVAL: TWO CHANNELS, NEVER CONFLATED ───────────────────────────────
--
--   admin_session            the administrator's own signed-in session called
--                            illustration_approve_batch. The database itself
--                            authenticated them. approval_session_verified =
--                            true.
--   operator_on_instruction  the operator (service role) recorded an approval
--                            the administrator gave elsewhere (in chat). The
--                            database did NOT authenticate the administrator:
--                            it trusts the operator, which already holds the
--                            service key and could write any table anyway.
--                            approval_session_verified = false, the operator
--                            is named in approval_recorded_by, and the
--                            administrator's words are kept verbatim in
--                            approval_instruction. Those words must be
--                            exactly "approve batch <id> digest <64
--                            characters>" for this batch, with nothing
--                            before or after (see instruction_is_command).
--
-- Either way an approval binds ONE digest of ONE batch. Changed contents are a
-- different digest; another batch, even with identical contents, has its own
-- row and needs its own approval; a future import is a future batch.
--
-- ─── WHAT CHANGED FROM THE 20261016 PROPOSAL (PROPOSED_20261016_...) ────────
--
--  1. The verification table could never be written. It lived in a schema
--     PostgREST does not expose, and verify-uploads.mjs wrote to it through
--     PostgREST. Verification is now a service_role function.
--  2. Verification trusted the operator's hash alone; see 8 for how it is
--     now tied to storage's own record of the object.
--  3. Nothing detected an object swapped between verification and publishing.
--     Storage gives every object a version id that changes on overwrite; it is
--     recorded at verification and must be unchanged at staging and publish.
--  4. Replacement was one batch-wide flag, so two batches aimed at the same
--     card could overwrite each other. Every item now states what the card
--     must hold right now (expected_url/expected_alt: NULL for a new image);
--     a card that has changed since approval aborts the whole batch.
--  5. Two identical concurrent publishes could both pass the "already
--     published?" check. A transaction advisory lock on the batch id now
--     serialises them, and the second returns the first one's result.
--  6. The batch digest ignored alt text, so reusing a batch id with different
--     alt text looked like an identical retry. Alt and the expectations are
--     now in the digest.
--  7. There was no approval step separate from publishing, and no rollback
--     function: rollback was a comment. Both exist now, with the same guards.
--
-- ─── WHAT CHANGED IN THE PHASE 36 FINAL REVIEW ─────────────────────────────
--
--  8. Verification no longer assumes an ETag is the MD5 of the bytes (true for
--     a simple upload, not for multipart uploads or every storage backend).
--     The proof of content is the SHA-256 of the full bytes the operator
--     downloaded, compared with the approved manifest. What ties those bytes
--     to storage is the object's VERSION: the operator reads it before and
--     after downloading, and this function requires it to still be current.
--     A version is never reused, so an object replaced at any point after the
--     hash was taken is refused here, at staging, at publishing and at
--     post-verification. The ETag is kept only as a second change marker,
--     compared for equality and never interpreted.
--     WHAT THIS DOES NOT DO: after post-verification nothing here watches the
--     object, and the service role can still overwrite or delete it (storage
--     itself allows that to whoever holds the key). That is a trust boundary,
--     not something a version check can prevent. What covers it after
--     publication: the image route refuses bytes that no longer hash to the
--     digest in their path, and `npm run illustrations -- audit` re-hashes
--     every live image and compares storage versions with the last inventory.
--  9. Approval attribution is explicit (see APPROVAL above). The old columns
--     approved_by and actor implied the administrator had acted; on the
--     operator channel they had not.
-- 10. Operator-recorded approvals and rollbacks must quote an instruction that
--     names this batch's id and complete digest (a 12-character prefix is no
--     longer enough).
-- 11. Post-verification is cross-checked by the database: a pass is recorded
--     only if every card still holds its approved image and every object is
--     the verified, unchanged version.
-- 12. Removed the schema-wide REVOKE CREATE ON SCHEMA public. It changed a
--     privilege far outside this feature, and every function here pins an
--     empty search_path and qualifies every object, so it protected nothing.
-- 13. No foreign keys from the audit tables to public.flashcards or
--     auth.users: an audit row must never block deleting or re-seeding a card,
--     or deleting an account. Existence is checked by the functions instead.
-- 14. The migration records the exact privileges it changes before changing
--     them (illustrations.install_baseline), so the rollback file restores
--     them exactly rather than guessing Supabase's defaults.
--
-- ─── WHAT CHANGED IN THE PHASE B SOURCE AUDIT ──────────────────────────────
--
-- 15. An operator-recorded instruction was accepted if it contained the word
--     "approve" (or "roll back") anywhere, so "Do not approve batch <id>
--     digest <digest>" counted as an approval. The whole instruction must now
--     be exactly the command, with nothing before or after it
--     (instruction_is_command).
-- 16. Post-verification read the cards without locking them, so a
--     replacement committing at the same moment could leave a batch VERIFIED
--     whose card no longer held its image. It now takes the same card locks,
--     in the same order, as publishing and rollback.
-- 17. The baseline recorded column privileges for only the two columns this
--     migration grants. Revoking table-level UPDATE also removes UPDATE from
--     every column, so a grant on any other column would not have come back
--     on rollback. Every column is recorded now, with grant options and
--     grantor, and the rollback compares all of it.
-- 18. The post-conditions also prove that no API role keeps a table-level
--     write privilege or a direct write on any column except the editor's two.
--
-- ─── search_path = '' ──────────────────────────────────────────────────────
-- Every SECURITY DEFINER function pins an empty search_path and qualifies
-- every object. An object it forgets to qualify is then a creation-time error
-- rather than something resolved through a path an attacker could influence.
-- pg_catalog is still searched implicitly for types and operators.
-- ═══════════════════════════════════════════════════════════════════════════

BEGIN;

-- ─── 0. A schema of its own ────────────────────────────────────────────────
-- Not exposed by PostgREST, with no USAGE for any API role. CREATE SCHEMA
-- without IF NOT EXISTS: if something by this name already exists, the whole
-- migration stops rather than mixing into it.
CREATE SCHEMA illustrations;
REVOKE ALL ON SCHEMA illustrations FROM PUBLIC;
REVOKE ALL ON SCHEMA illustrations FROM anon, authenticated, service_role;

-- What this migration is about to change, recorded before it changes it, so
-- the rollback can restore exactly this (section 11 changes these privileges
-- and the policy comment; nothing else outside this schema is altered).
-- Every column is recorded, not only the two section 11 grants: revoking a
-- table-level privilege also removes that privilege from every column, so a
-- grant on any column could otherwise be lost without a trace. Each entry is
-- the full access list as PostgreSQL stores it (grantee, privileges, grant
-- options and grantor).
CREATE TABLE illustrations.install_baseline (
  key          text PRIMARY KEY,
  value        jsonb,
  recorded_at  timestamptz NOT NULL DEFAULT now()
);
INSERT INTO illustrations.install_baseline (key, value)
SELECT 'flashcards_table_acl', pg_catalog.to_jsonb(c.relacl::text[])
  FROM pg_catalog.pg_class c WHERE c.oid = 'public.flashcards'::regclass
UNION ALL
SELECT 'flashcards_column_acl', pg_catalog.jsonb_object_agg(a.attname, pg_catalog.to_jsonb(a.attacl::text[]))
  FROM pg_catalog.pg_attribute a
 WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
UNION ALL
SELECT 'admin_policy_comment', pg_catalog.to_jsonb(pg_catalog.obj_description(p.oid, 'pg_policy'))
  FROM pg_catalog.pg_policy p
 WHERE p.polrelid = 'public.flashcards'::regclass AND p.polname = 'Admins can update flashcards';

-- ─── 1. Tables ─────────────────────────────────────────────────────────────

-- What the operator verified about each uploaded object, tied to the exact
-- storage version whose bytes were hashed. Written only by
-- illustration_record_verification.
CREATE TABLE illustrations.assets (
  object_path        text PRIMARY KEY
                     CHECK (object_path ~ '^cards/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}\.(webp|png)$'),
  bucket_id          text        NOT NULL CHECK (bucket_id = 'flashcard-images'),
  sha256             text        NOT NULL CHECK (sha256 ~ '^[0-9a-f]{64}$'),
  byte_length        bigint      NOT NULL CHECK (byte_length > 0 AND byte_length <= 5242880),
  content_type       text        NOT NULL CHECK (content_type IN ('image/webp', 'image/png')),
  storage_object_id  uuid        NOT NULL,
  storage_version    text        NOT NULL CHECK (storage_version <> ''),
  -- Opaque. Compared for equality only, never treated as a hash of anything.
  storage_etag       text        NOT NULL CHECK (storage_etag <> ''),
  verified_at        timestamptz NOT NULL DEFAULT now()
);

-- One row per batch. digest is computed here, never accepted from the caller.
CREATE TABLE illustrations.batches (
  batch_id                   uuid PRIMARY KEY,
  digest                     text        NOT NULL CHECK (digest ~ '^[0-9a-f]{64}$'),
  source_document            text,
  item_count                 int         NOT NULL CHECK (item_count BETWEEN 1 AND 200),
  state                      text        NOT NULL DEFAULT 'STAGED'
                             CHECK (state IN ('STAGED', 'APPROVED', 'PUBLISHED', 'VERIFIED', 'ROLLED_BACK')),
  staged_at                  timestamptz NOT NULL DEFAULT now(),
  -- The administrator whose approval this is (see APPROVAL in the header).
  approval_authority         uuid,
  approval_channel           text CHECK (approval_channel IN ('admin_session', 'operator_on_instruction')),
  -- True only when the database itself authenticated approval_authority.
  approval_session_verified  boolean,
  -- Who actually made the call: the administrator's session, or the operator.
  approval_recorded_by       text,
  -- The administrator's words, verbatim (operator channel), or their note.
  approval_instruction       text,
  approved_at                timestamptz,
  published_at               timestamptz,
  postverify_ok              boolean,
  postverify_at              timestamptz,
  postverify_report          jsonb,
  rollback_authority         uuid,
  rollback_recorded_by       text,
  rollback_instruction       text,
  rolled_back_at             timestamptz,
  CHECK ((approval_channel IS NULL) = (approved_at IS NULL)),
  CHECK (approval_channel IS NULL OR approval_session_verified = (approval_channel = 'admin_session'))
);

-- The exact mapping. expected_url/expected_alt are what the card must hold at
-- publish time: NULL/NULL for a card with no illustration yet, the current
-- values for an approved replacement.
CREATE TABLE illustrations.batch_items (
  batch_id      uuid NOT NULL REFERENCES illustrations.batches(batch_id),
  card_id       uuid NOT NULL,
  object_path   text NOT NULL REFERENCES illustrations.assets(object_path),
  url           text NOT NULL,
  sha256        text NOT NULL,
  alt           text NOT NULL,
  expected_url  text,
  expected_alt  text,
  PRIMARY KEY (batch_id, card_id),
  CHECK ((expected_url IS NULL) = (expected_alt IS NULL))
);

-- The audit trail. One row per thing that happened; card-level rows carry the
-- before and after so any change can be explained, and undone, from here.
CREATE TABLE illustrations.events (
  id                bigserial PRIMARY KEY,
  batch_id          uuid        NOT NULL REFERENCES illustrations.batches(batch_id),
  card_id           uuid,
  event             text        NOT NULL CHECK (event IN ('STAGED', 'APPROVED', 'PUBLISHED',
                                                          'POSTVERIFY_PASSED', 'POSTVERIFY_FAILED', 'ROLLED_BACK')),
  -- The administrator on whose authority this happened, if any.
  authority         uuid,
  -- Who actually made the call.
  performed_by      text        NOT NULL,
  -- Did the database itself authenticate `authority` for this event?
  session_verified  boolean     NOT NULL DEFAULT false,
  detail            jsonb       NOT NULL DEFAULT '{}'::jsonb,
  at                timestamptz NOT NULL DEFAULT now()
);
-- A second audit row for the same card and event in the same batch is a bug
-- the database itself refuses, whatever the function logic does.
CREATE UNIQUE INDEX events_once_per_card ON illustrations.events (batch_id, card_id, event)
  WHERE card_id IS NOT NULL;
CREATE UNIQUE INDEX events_once_per_batch ON illustrations.events (batch_id, event)
  WHERE card_id IS NULL AND event IN ('STAGED', 'APPROVED', 'PUBLISHED', 'POSTVERIFY_PASSED', 'ROLLED_BACK');

ALTER TABLE illustrations.install_baseline ENABLE ROW LEVEL SECURITY;
ALTER TABLE illustrations.assets           ENABLE ROW LEVEL SECURITY;
ALTER TABLE illustrations.batches          ENABLE ROW LEVEL SECURITY;
ALTER TABLE illustrations.batch_items      ENABLE ROW LEVEL SECURITY;
ALTER TABLE illustrations.events           ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON ALL TABLES    IN SCHEMA illustrations FROM PUBLIC, anon, authenticated, service_role;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA illustrations FROM PUBLIC, anon, authenticated, service_role;

-- ─── 2. Helpers (not callable by any API role) ─────────────────────────────

-- Is this account an administrator right now? Read on every call, so revoking
-- the flag takes effect on the next request. Subscription, LEGACY_FULL_ACCESS
-- and account_kind are not consulted: paying for everything is not staff.
CREATE FUNCTION illustrations.is_admin(p_user uuid)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT COALESCE((SELECT p.is_admin FROM public.profiles p WHERE p.id = p_user), false);
$$;

-- Who is making this call, for the audit trail.
CREATE FUNCTION illustrations.caller()
RETURNS text
LANGUAGE sql
STABLE
SET search_path = ''
AS $$
  SELECT CASE
    WHEN (SELECT auth.role()) = 'service_role' THEN 'operator (service role)'
    WHEN (SELECT auth.uid()) IS NOT NULL THEN 'signed-in session ' || (SELECT auth.uid())::text
    ELSE 'database role ' || CURRENT_USER::text
  END;
$$;

-- The batch fingerprint. Order-independent (sorted by card), covers every
-- field that changes what a learner sees or what a publish requires.
-- Lines are tab-separated; stage_batch refuses control characters in alt
-- text, so a value cannot forge a field boundary. The TypeScript twin is
-- batchDigest() in lib/illustrations/batch.ts; a test proves they agree.
CREATE FUNCTION illustrations.items_digest(p_items jsonb)
RETURNS text
LANGUAGE sql
IMMUTABLE
SET search_path = ''
AS $$
  SELECT pg_catalog.encode(pg_catalog.sha256(pg_catalog.convert_to(
           pg_catalog.string_agg(s.line, E'\n' ORDER BY s.card), 'UTF8')), 'hex')
    FROM (SELECT (e.elem->>'card_id')::uuid::text AS card,
                 (e.elem->>'card_id')::uuid::text
                   || E'\t' || (e.elem->>'url')
                   || E'\t' || (e.elem->>'sha256')
                   || E'\t' || (e.elem->>'alt')
                   || E'\t' || COALESCE(e.elem->>'expected_url', '')
                   || E'\t' || COALESCE(e.elem->>'expected_alt', '') AS line
            FROM pg_catalog.jsonb_array_elements(p_items) AS e(elem)) AS s;
$$;

-- Is an administrator's instruction exactly the command for this batch?
-- The whole instruction must be one of these two sentences and nothing else:
--
--   approve batch <batch id> digest <64-character digest>
--   roll back batch <batch id> digest <64-character digest>
--
-- Letter case is free, words are separated by spaces, tabs or line breaks
-- (ASCII only, so both twins agree on every character), and one full stop may
-- end it. Nothing may come before or after, so a negation ("do not approve
-- ..."), a condition, a question, a second id or digest, or a shortened digest
-- is never a command. The command word comes from a fixed list here; no caller
-- supplies a pattern. The TypeScript twin is instructionProblems() in
-- lib/illustrations/batch.ts; a test proves they agree.
CREATE FUNCTION illustrations.instruction_is_command(p_instruction text, p_command text, p_batch_id uuid, p_digest text)
RETURNS boolean
LANGUAGE sql
IMMUTABLE
SET search_path = ''
AS $$
  SELECT COALESCE((
    SELECT pg_catalog.lower(c.m[1]) = p_batch_id::text
       AND pg_catalog.lower(c.m[2]) = pg_catalog.lower(p_digest)
      FROM (SELECT pg_catalog.regexp_match(p_instruction,
                     '^[ \t\r\n]*'
                     || CASE p_command WHEN 'approve' THEN 'approve' WHEN 'roll back' THEN 'roll[ \t\r\n]+back' END
                     || '[ \t\r\n]+batch[ \t\r\n]+([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})'
                     || '[ \t\r\n]+digest[ \t\r\n]+([0-9a-f]{64})[ \t\r\n]*[.]?[ \t\r\n]*$', 'i') AS m) AS c), false);
$$;

-- Is the verified object still exactly the version that was verified?
-- Read-only on storage's own table; this migration never writes there.
CREATE FUNCTION illustrations.asset_unchanged(p_object_path text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
  SELECT EXISTS (
    SELECT 1
      FROM illustrations.assets a
      JOIN storage.objects o
        ON o.bucket_id = a.bucket_id AND o.name = a.object_path
     WHERE a.object_path = p_object_path
       AND o.id = a.storage_object_id
       AND o.version = a.storage_version
       AND pg_catalog.btrim(o.metadata->>'eTag', '"') = a.storage_etag
       AND (o.metadata->>'size')::bigint = a.byte_length
       AND o.metadata->>'mimetype' = a.content_type);
$$;

-- One lock per batch id, held to the end of the transaction, so two calls on
-- the same batch run one after the other instead of both passing a check.
CREATE FUNCTION illustrations.lock_batch(p_batch_id uuid)
RETURNS void
LANGUAGE sql
SET search_path = ''
AS $$
  SELECT pg_catalog.pg_advisory_xact_lock(pg_catalog.hashtextextended('illustration-batch:' || p_batch_id::text, 0));
$$;

-- ─── 3. Verification of one uploaded object (operator) ─────────────────────
--
-- The operator, for the object it uploaded:
--   1. reads storage's record of it (version, ETag, size, type),
--   2. downloads the full bytes and computes their SHA-256, which must equal
--      the approved manifest's,
--   3. reads storage's record again; it must be unchanged, so the bytes
--      hashed belong to that version,
--   4. calls this function with the hash and the version it saw.
-- This function requires that version (and ETag, size and type) to be what
-- storage holds now. A version id is never reused, so an object replaced
-- before, during or after the download is refused. The path must be
-- content-addressed by the SHA-256. Re-verifying is allowed only if nothing
-- changed: a different hash or a new version at the same path is an
-- overwrite of an immutable object and is refused.
CREATE FUNCTION public.illustration_record_verification(
  p_object_path      text,
  p_sha256           text,
  p_byte_length      bigint,
  p_content_type     text,
  p_storage_version  text,
  p_storage_etag     text
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_obj   storage.objects%ROWTYPE;
  v_prior illustrations.assets%ROWTYPE;
  v_etag  text := pg_catalog.btrim(p_storage_etag, '"');
BEGIN
  IF p_object_path IS NULL
     OR p_object_path !~ '^cards/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}\.(webp|png)$' THEN
    RAISE EXCEPTION 'ABORT: % is not an illustration object path', p_object_path;
  END IF;
  IF p_sha256 IS NULL OR p_sha256 !~ '^[0-9a-f]{64}$' THEN
    RAISE EXCEPTION 'ABORT: malformed sha256 for %', p_object_path;
  END IF;
  IF pg_catalog.substring(p_object_path, '/([0-9a-f]{8})\.[a-z]+$') <> pg_catalog.left(p_sha256, 8) THEN
    RAISE EXCEPTION 'ABORT: % is not named by its own SHA-256', p_object_path;
  END IF;
  IF (p_object_path LIKE '%.webp' AND p_content_type IS DISTINCT FROM 'image/webp')
     OR (p_object_path LIKE '%.png' AND p_content_type IS DISTINCT FROM 'image/png') THEN
    RAISE EXCEPTION 'ABORT: % has a type that does not match its extension', p_object_path;
  END IF;
  IF COALESCE(p_storage_version, '') = '' OR COALESCE(v_etag, '') = '' THEN
    RAISE EXCEPTION 'ABORT: the storage version and ETag seen when % was hashed are required', p_object_path;
  END IF;

  SELECT * INTO v_obj FROM storage.objects o
   WHERE o.bucket_id = 'flashcard-images' AND o.name = p_object_path;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'ABORT: % is not in storage', p_object_path;
  END IF;
  IF COALESCE(v_obj.version, '') = '' THEN
    RAISE EXCEPTION 'ABORT: storage records no version for %, so a later replacement could not be detected', p_object_path;
  END IF;
  IF v_obj.version <> p_storage_version
     OR pg_catalog.btrim(v_obj.metadata->>'eTag', '"') IS DISTINCT FROM v_etag THEN
    RAISE EXCEPTION 'ABORT: % was replaced in storage after its bytes were hashed (storage now holds version %, the hash was of version %)',
      p_object_path, v_obj.version, p_storage_version;
  END IF;
  IF (v_obj.metadata->>'size')::bigint IS DISTINCT FROM p_byte_length THEN
    RAISE EXCEPTION 'ABORT: storage records a different size for %', p_object_path;
  END IF;
  IF v_obj.metadata->>'mimetype' IS DISTINCT FROM p_content_type THEN
    RAISE EXCEPTION 'ABORT: storage records a different content type for %', p_object_path;
  END IF;

  SELECT * INTO v_prior FROM illustrations.assets a WHERE a.object_path = p_object_path;
  IF FOUND THEN
    IF v_prior.sha256 <> p_sha256 OR v_prior.storage_object_id <> v_obj.id
       OR v_prior.storage_version <> v_obj.version THEN
      RAISE EXCEPTION 'ABORT: % was verified before with different bytes or a different storage version; objects are immutable', p_object_path;
    END IF;
    RETURN pg_catalog.jsonb_build_object('object_path', p_object_path, 'verified', true, 'note', 'already verified, unchanged');
  END IF;

  INSERT INTO illustrations.assets
    (object_path, bucket_id, sha256, byte_length, content_type, storage_object_id, storage_version, storage_etag)
  VALUES
    (p_object_path, 'flashcard-images', p_sha256, p_byte_length, p_content_type, v_obj.id, v_obj.version, v_etag);

  RETURN pg_catalog.jsonb_build_object('object_path', p_object_path, 'verified', true, 'storage_version', v_obj.version);
END;
$$;

-- ─── 4. Staging a batch (operator) ─────────────────────────────────────────
--
-- Items: [{card_id, url, sha256, alt, expected_url, expected_alt}, ...]. Every
-- key must be present (expected_* may be null) and no other key is accepted.
-- Re-staging the same id with the same contents is a no-op; with different
-- contents it is refused.
CREATE FUNCTION public.illustration_stage_batch(
  p_batch_id uuid,
  p_items    jsonb,
  p_source   text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_count  int;
  v_digest text;
  v_prior  illustrations.batches%ROWTYPE;
  v_row    jsonb;
  v_card   uuid;
  v_sha    text;
  v_object text;
  v_cur    public.flashcards%ROWTYPE;
BEGIN
  IF p_batch_id IS NULL THEN
    RAISE EXCEPTION 'ABORT: a batch id is required';
  END IF;
  PERFORM illustrations.lock_batch(p_batch_id);

  IF pg_catalog.jsonb_typeof(p_items) IS DISTINCT FROM 'array' THEN
    RAISE EXCEPTION 'ABORT: items must be a JSON array';
  END IF;
  v_count := pg_catalog.jsonb_array_length(p_items);
  IF v_count < 1 OR v_count > 200 THEN
    RAISE EXCEPTION 'ABORT: a batch holds between 1 and 200 items, not %', v_count;
  END IF;
  IF EXISTS (SELECT 1 FROM pg_catalog.jsonb_array_elements(p_items) e(elem)
              WHERE pg_catalog.jsonb_typeof(e.elem) <> 'object') THEN
    RAISE EXCEPTION 'ABORT: every item must be a JSON object';
  END IF;
  IF EXISTS (SELECT 1 FROM pg_catalog.jsonb_array_elements(p_items) e(elem),
                          pg_catalog.jsonb_object_keys(e.elem) k(key)
              WHERE k.key NOT IN ('card_id', 'url', 'sha256', 'alt', 'expected_url', 'expected_alt')) THEN
    RAISE EXCEPTION 'ABORT: an item carries a field this function does not accept';
  END IF;
  IF EXISTS (SELECT 1 FROM pg_catalog.jsonb_array_elements(p_items) e(elem)
              WHERE NOT (e.elem ? 'card_id' AND e.elem ? 'url' AND e.elem ? 'sha256' AND e.elem ? 'alt'
                         AND e.elem ? 'expected_url' AND e.elem ? 'expected_alt')) THEN
    RAISE EXCEPTION 'ABORT: every item must state card_id, url, sha256, alt, expected_url and expected_alt';
  END IF;
  IF (SELECT pg_catalog.count(DISTINCT (e.elem->>'card_id')::uuid)
        FROM pg_catalog.jsonb_array_elements(p_items) e(elem)) <> v_count THEN
    RAISE EXCEPTION 'ABORT: the batch names the same card more than once';
  END IF;

  v_digest := illustrations.items_digest(p_items);

  SELECT * INTO v_prior FROM illustrations.batches b WHERE b.batch_id = p_batch_id;
  IF FOUND THEN
    IF v_prior.digest <> v_digest THEN
      RAISE EXCEPTION 'ABORT: batch % already exists with different contents', p_batch_id;
    END IF;
    RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'digest', v_digest,
                                         'state', v_prior.state, 'note', 'already staged with identical contents');
  END IF;

  FOR v_row IN SELECT e.elem FROM pg_catalog.jsonb_array_elements(p_items) e(elem)
  LOOP
    v_card := (v_row->>'card_id')::uuid;
    v_sha  := v_row->>'sha256';
    IF v_sha IS NULL OR v_sha !~ '^[0-9a-f]{64}$' THEN
      RAISE EXCEPTION 'ABORT: card % has a malformed sha256', v_card;
    END IF;
    IF v_row->>'url' IS DISTINCT FROM
       ('/flashcards/backs/' || v_card::text || '/' || pg_catalog.left(v_sha, 8) || '.'
        || pg_catalog.substring(v_row->>'url', '\.(webp|png)$')) THEN
      RAISE EXCEPTION 'ABORT: card % must point at /flashcards/backs/<its own id>/<first 8 of its sha256>.webp|png', v_card;
    END IF;
    IF v_row->>'alt' IS NULL OR pg_catalog.length(pg_catalog.btrim(v_row->>'alt')) < 20
       OR pg_catalog.length(v_row->>'alt') > 600 OR v_row->>'alt' ~ '[[:cntrl:]]' THEN
      RAISE EXCEPTION 'ABORT: card % needs alt text of 20 to 600 characters with no control characters', v_card;
    END IF;
    IF (v_row->>'expected_url' IS NULL) <> (v_row->>'expected_alt' IS NULL) THEN
      RAISE EXCEPTION 'ABORT: card % states expected_url and expected_alt inconsistently', v_card;
    END IF;

    SELECT * INTO v_cur FROM public.flashcards f WHERE f.id = v_card;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'ABORT: card % does not exist', v_card;
    END IF;
    IF v_cur.back_image_url IS DISTINCT FROM v_row->>'expected_url'
       OR v_cur.back_image_alt IS DISTINCT FROM v_row->>'expected_alt' THEN
      RAISE EXCEPTION 'ABORT: card % does not hold what the batch expects (it has %)', v_card, COALESCE(v_cur.back_image_url, 'no illustration');
    END IF;

    v_object := 'cards/' || pg_catalog.substring(v_row->>'url', '^/flashcards/backs/(.*)$');
    IF NOT EXISTS (SELECT 1 FROM illustrations.assets a WHERE a.object_path = v_object AND a.sha256 = v_sha) THEN
      RAISE EXCEPTION 'ABORT: card % has no verified upload with this hash', v_card;
    END IF;
    IF NOT illustrations.asset_unchanged(v_object) THEN
      RAISE EXCEPTION 'ABORT: the object for card % has been replaced in storage since it was verified', v_card;
    END IF;
  END LOOP;

  INSERT INTO illustrations.batches (batch_id, digest, source_document, item_count)
  VALUES (p_batch_id, v_digest, p_source, v_count);

  INSERT INTO illustrations.batch_items (batch_id, card_id, object_path, url, sha256, alt, expected_url, expected_alt)
  SELECT p_batch_id, (e.elem->>'card_id')::uuid,
         'cards/' || pg_catalog.substring(e.elem->>'url', '^/flashcards/backs/(.*)$'),
         e.elem->>'url', e.elem->>'sha256', e.elem->>'alt', e.elem->>'expected_url', e.elem->>'expected_alt'
    FROM pg_catalog.jsonb_array_elements(p_items) e(elem);

  INSERT INTO illustrations.events (batch_id, event, performed_by, detail)
  VALUES (p_batch_id, 'STAGED', illustrations.caller(),
          pg_catalog.jsonb_build_object('digest', v_digest, 'items', v_count, 'source', p_source));

  RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'digest', v_digest, 'state', 'STAGED', 'items', v_count);
END;
$$;

-- ─── 5. Approval ───────────────────────────────────────────────────────────
--
-- Approval binds an administrator to ONE digest of ONE batch. A different
-- batch, or this batch with any field changed, needs its own approval.
-- Approving the same digest twice is a no-op that keeps the first approval's
-- attribution; approving after publish is refused.
CREATE FUNCTION illustrations.approve(
  p_batch_id uuid, p_digest text, p_authority uuid, p_channel text, p_recorded_by text, p_instruction text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_batch illustrations.batches%ROWTYPE;
BEGIN
  PERFORM illustrations.lock_batch(p_batch_id);
  IF NOT illustrations.is_admin(p_authority) THEN
    RAISE EXCEPTION 'forbidden: the approver is not an administrator';
  END IF;
  SELECT * INTO v_batch FROM illustrations.batches b WHERE b.batch_id = p_batch_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'ABORT: batch % does not exist', p_batch_id;
  END IF;
  IF v_batch.digest <> p_digest THEN
    RAISE EXCEPTION 'ABORT: batch % has digest %, not the one being approved', p_batch_id, v_batch.digest;
  END IF;
  IF v_batch.state = 'APPROVED' THEN
    RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'APPROVED', 'note', 'already approved',
      'approval_channel', v_batch.approval_channel, 'approval_session_verified', v_batch.approval_session_verified);
  END IF;
  IF v_batch.state <> 'STAGED' THEN
    RAISE EXCEPTION 'ABORT: batch % is %, not awaiting approval', p_batch_id, v_batch.state;
  END IF;

  UPDATE illustrations.batches
     SET state = 'APPROVED',
         approval_authority = p_authority,
         approval_channel = p_channel,
         approval_session_verified = (p_channel = 'admin_session'),
         approval_recorded_by = p_recorded_by,
         approval_instruction = p_instruction,
         approved_at = pg_catalog.now()
   WHERE batch_id = p_batch_id;
  INSERT INTO illustrations.events (batch_id, event, authority, performed_by, session_verified, detail)
  VALUES (p_batch_id, 'APPROVED', p_authority, p_recorded_by, p_channel = 'admin_session',
          pg_catalog.jsonb_build_object('digest', p_digest, 'channel', p_channel, 'instruction', p_instruction));
  RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'APPROVED', 'approval_authority', p_authority,
    'approval_channel', p_channel, 'approval_session_verified', p_channel = 'admin_session');
END;
$$;

-- Channel admin_session: an administrator approving from their own signed-in
-- session. The database authenticates them; nobody else can call this for them.
CREATE FUNCTION public.illustration_approve_batch(p_batch_id uuid, p_digest text, p_note text DEFAULT NULL)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF (SELECT auth.uid()) IS NULL THEN
    RAISE EXCEPTION 'forbidden: not signed in';
  END IF;
  RETURN illustrations.approve(p_batch_id, p_digest, (SELECT auth.uid()), 'admin_session',
                               'signed-in session ' || (SELECT auth.uid())::text, p_note);
END;
$$;

-- Channel operator_on_instruction: the operator recording an approval an
-- administrator gave by instruction. NOT an authentication of the
-- administrator: it is recorded as such (approval_session_verified = false),
-- with the operator named and the instruction kept verbatim. The named
-- account must be an administrator at this moment, and the instruction must
-- be exactly "approve batch <this id> digest <this complete digest>".
CREATE FUNCTION public.illustration_record_approval(
  p_batch_id uuid, p_digest text, p_on_behalf_of uuid, p_instruction text, p_recorded_by text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF p_recorded_by IS NULL OR pg_catalog.length(pg_catalog.btrim(p_recorded_by)) < 3 THEN
    RAISE EXCEPTION 'ABORT: name the operator recording this approval';
  END IF;
  IF NOT illustrations.instruction_is_command(p_instruction, 'approve', p_batch_id, p_digest) THEN
    RAISE EXCEPTION 'ABORT: the instruction must be exactly "approve batch % digest %", with nothing before or after it', p_batch_id, p_digest;
  END IF;
  RETURN illustrations.approve(p_batch_id, p_digest, p_on_behalf_of, 'operator_on_instruction',
                               'operator (service role): ' || pg_catalog.btrim(p_recorded_by), p_instruction);
END;
$$;

-- ─── 6. Publishing (operator) ──────────────────────────────────────────────
--
-- All of the batch or none of it, in this one transaction:
--   * the batch must be APPROVED for exactly this digest, and the
--     administrator whose approval it is must still be one;
--   * every target card is locked (in id order, so two batches cannot
--     deadlock) and must still hold exactly what the item expects;
--   * every image must still be the verified, unchanged storage version;
--   * each UPDATE must touch exactly one row, and afterwards every card must
--     hold exactly its new values.
-- Any failure raises, which rolls back every card in the batch. A retry of a
-- batch that already published returns the earlier result and writes nothing.
CREATE FUNCTION public.illustration_publish_batch(p_batch_id uuid, p_digest text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_batch   illustrations.batches%ROWTYPE;
  v_item    illustrations.batch_items%ROWTYPE;
  v_cur     public.flashcards%ROWTYPE;
  v_rows    int;
  v_changed uuid[] := '{}';
  v_by      text := illustrations.caller();
BEGIN
  PERFORM illustrations.lock_batch(p_batch_id);

  SELECT * INTO v_batch FROM illustrations.batches b WHERE b.batch_id = p_batch_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'ABORT: batch % does not exist', p_batch_id;
  END IF;
  IF v_batch.digest <> p_digest THEN
    RAISE EXCEPTION 'ABORT: batch % has digest %, not the one being published', p_batch_id, v_batch.digest;
  END IF;
  IF v_batch.state IN ('PUBLISHED', 'VERIFIED') THEN
    RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', v_batch.state,
      'written', 0, 'note', 'already published; this was an identical retry');
  END IF;
  IF v_batch.state <> 'APPROVED' THEN
    RAISE EXCEPTION 'ABORT: batch % is %, not APPROVED', p_batch_id, v_batch.state;
  END IF;
  IF NOT illustrations.is_admin(v_batch.approval_authority) THEN
    RAISE EXCEPTION 'forbidden: the administrator whose approval batch % carries no longer is one', p_batch_id;
  END IF;

  -- Lock every target card first, in a fixed order.
  PERFORM 1 FROM public.flashcards f
   WHERE f.id IN (SELECT i.card_id FROM illustrations.batch_items i WHERE i.batch_id = p_batch_id)
   ORDER BY f.id
     FOR UPDATE;

  FOR v_item IN SELECT * FROM illustrations.batch_items i WHERE i.batch_id = p_batch_id ORDER BY i.card_id
  LOOP
    SELECT * INTO v_cur FROM public.flashcards f WHERE f.id = v_item.card_id;
    IF NOT FOUND THEN
      RAISE EXCEPTION 'ABORT: card % no longer exists', v_item.card_id;
    END IF;
    IF v_cur.back_image_url IS DISTINCT FROM v_item.expected_url
       OR v_cur.back_image_alt IS DISTINCT FROM v_item.expected_alt THEN
      RAISE EXCEPTION 'ABORT: card % has changed since this batch was approved (it now has %); nothing was published',
        v_item.card_id, COALESCE(v_cur.back_image_url, 'no illustration');
    END IF;
    IF NOT illustrations.asset_unchanged(v_item.object_path) THEN
      RAISE EXCEPTION 'ABORT: the object for card % has been replaced in storage since it was verified; nothing was published', v_item.card_id;
    END IF;

    UPDATE public.flashcards f
       SET back_image_url = v_item.url,
           back_image_alt = v_item.alt
     WHERE f.id = v_item.card_id
       AND f.back_image_url IS NOT DISTINCT FROM v_item.expected_url
       AND f.back_image_alt IS NOT DISTINCT FROM v_item.expected_alt;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    IF v_rows <> 1 THEN
      RAISE EXCEPTION 'ABORT: updating card % touched % rows; nothing was published', v_item.card_id, v_rows;
    END IF;

    INSERT INTO illustrations.events (batch_id, card_id, event, authority, performed_by, detail)
    VALUES (p_batch_id, v_item.card_id, 'PUBLISHED', v_batch.approval_authority, v_by,
            pg_catalog.jsonb_build_object(
              'previous_url', v_cur.back_image_url, 'previous_alt', v_cur.back_image_alt,
              'new_url', v_item.url, 'new_alt', v_item.alt, 'sha256', v_item.sha256,
              'replacement', v_item.expected_url IS NOT NULL));
    v_changed := v_changed || v_item.card_id;
  END LOOP;

  -- Post-flight: every card now holds exactly what was approved.
  IF (SELECT pg_catalog.count(*) FROM illustrations.batch_items i
        JOIN public.flashcards f ON f.id = i.card_id
       WHERE i.batch_id = p_batch_id AND f.back_image_url = i.url AND f.back_image_alt = i.alt)
     <> v_batch.item_count THEN
    RAISE EXCEPTION 'ABORT: after writing, not every card holds its approved image; nothing was published';
  END IF;

  UPDATE illustrations.batches SET state = 'PUBLISHED', published_at = pg_catalog.now()
   WHERE batch_id = p_batch_id;
  INSERT INTO illustrations.events (batch_id, event, authority, performed_by, detail)
  VALUES (p_batch_id, 'PUBLISHED', v_batch.approval_authority, v_by,
          pg_catalog.jsonb_build_object('digest', p_digest, 'cards', pg_catalog.to_jsonb(v_changed),
            'approval_channel', v_batch.approval_channel,
            'approval_session_verified', v_batch.approval_session_verified));

  RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'PUBLISHED',
    'written', pg_catalog.cardinality(v_changed), 'cards', pg_catalog.to_jsonb(v_changed));
END;
$$;

-- ─── 7. The operator's independent post-publication check ──────────────────
--
-- The operator fetched every image through the live delivery route and
-- compared bytes, mapping and alt text, and reports its verdict. The database
-- adds its own cross-check: every card still holds its approved image, and
-- every object is still the verified storage version. Only both passing moves
-- the batch to VERIFIED. A failure is kept on the batch and in the audit
-- trail, and the batch stays PUBLISHED; the check can be run again.
--
-- The target cards are locked first, exactly as publish_batch and
-- rollback_batch lock them (after the batch's own lock, in card-id order), so
-- VERIFIED means "every card holds this batch's image at the moment this
-- commits". A publish or rollback touching the same cards either finishes
-- before this reads them (and is seen) or waits until this has committed.
-- Every function here takes its batch lock before any card lock, and card
-- locks in the same order, so none of them can deadlock another.
CREATE FUNCTION public.illustration_record_postverify(p_batch_id uuid, p_ok boolean, p_report jsonb)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_batch illustrations.batches%ROWTYPE;
  v_db_ok boolean;
  v_ok    boolean;
  v_report jsonb;
BEGIN
  PERFORM illustrations.lock_batch(p_batch_id);
  SELECT * INTO v_batch FROM illustrations.batches b WHERE b.batch_id = p_batch_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'ABORT: batch % does not exist', p_batch_id;
  END IF;
  IF v_batch.state = 'VERIFIED' THEN
    RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'VERIFIED', 'note', 'already verified');
  END IF;
  IF v_batch.state <> 'PUBLISHED' THEN
    RAISE EXCEPTION 'ABORT: batch % is %, not PUBLISHED', p_batch_id, v_batch.state;
  END IF;

  -- The same card locks as publishing, in the same order, held to commit.
  PERFORM 1 FROM public.flashcards f
   WHERE f.id IN (SELECT i.card_id FROM illustrations.batch_items i WHERE i.batch_id = p_batch_id)
   ORDER BY f.id
     FOR UPDATE;

  v_db_ok := NOT EXISTS (
    SELECT 1 FROM illustrations.batch_items i
      LEFT JOIN public.flashcards f ON f.id = i.card_id
     WHERE i.batch_id = p_batch_id
       AND (f.id IS NULL
            OR f.back_image_url IS DISTINCT FROM i.url
            OR f.back_image_alt IS DISTINCT FROM i.alt
            OR NOT illustrations.asset_unchanged(i.object_path)));
  v_ok := COALESCE(p_ok, false) AND v_db_ok;
  v_report := COALESCE(p_report, '{}'::jsonb) || pg_catalog.jsonb_build_object('database_cross_check', v_db_ok);

  UPDATE illustrations.batches
     SET postverify_ok = v_ok, postverify_at = pg_catalog.now(), postverify_report = v_report,
         state = CASE WHEN v_ok THEN 'VERIFIED' ELSE state END
   WHERE batch_id = p_batch_id;
  INSERT INTO illustrations.events (batch_id, event, performed_by, detail)
  VALUES (p_batch_id, CASE WHEN v_ok THEN 'POSTVERIFY_PASSED' ELSE 'POSTVERIFY_FAILED' END, illustrations.caller(), v_report);
  RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', CASE WHEN v_ok THEN 'VERIFIED' ELSE 'PUBLISHED' END,
    'database_cross_check', v_db_ok);
END;
$$;

-- ─── 8. Rollback (operator, on an administrator's instruction) ─────────────
--
-- Restores each card's previous image and alt text from the batch's own
-- record, only if every card still holds exactly what this batch put there.
-- If any card has changed since, nothing is rolled back: a later, unrelated
-- change is never reverted. The previous object must still be in storage.
-- Old objects are never deleted by this or any other function here.
-- Like record_approval, this is the operator acting on an instruction it
-- quotes, and it is recorded that way.
CREATE FUNCTION public.illustration_rollback_batch(
  p_batch_id uuid, p_digest text, p_on_behalf_of uuid, p_instruction text, p_recorded_by text)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_batch illustrations.batches%ROWTYPE;
  v_item  illustrations.batch_items%ROWTYPE;
  v_cur   public.flashcards%ROWTYPE;
  v_rows  int;
  v_prev_object text;
  v_by    text;
BEGIN
  PERFORM illustrations.lock_batch(p_batch_id);
  IF NOT illustrations.is_admin(p_on_behalf_of) THEN
    RAISE EXCEPTION 'forbidden: rollback must be on an administrator''s instruction';
  END IF;
  IF p_recorded_by IS NULL OR pg_catalog.length(pg_catalog.btrim(p_recorded_by)) < 3 THEN
    RAISE EXCEPTION 'ABORT: name the operator recording this rollback';
  END IF;
  IF NOT illustrations.instruction_is_command(p_instruction, 'roll back', p_batch_id, p_digest) THEN
    RAISE EXCEPTION 'ABORT: the instruction must be exactly "roll back batch % digest %", with nothing before or after it', p_batch_id, p_digest;
  END IF;
  v_by := 'operator (service role): ' || pg_catalog.btrim(p_recorded_by);
  SELECT * INTO v_batch FROM illustrations.batches b WHERE b.batch_id = p_batch_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'ABORT: batch % does not exist', p_batch_id;
  END IF;
  IF v_batch.digest <> p_digest THEN
    RAISE EXCEPTION 'ABORT: batch % has digest %, not the one being rolled back', p_batch_id, v_batch.digest;
  END IF;
  IF v_batch.state = 'ROLLED_BACK' THEN
    RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'ROLLED_BACK', 'restored', 0, 'note', 'already rolled back');
  END IF;
  IF v_batch.state NOT IN ('PUBLISHED', 'VERIFIED') THEN
    RAISE EXCEPTION 'ABORT: batch % is %; only a published batch can be rolled back', p_batch_id, v_batch.state;
  END IF;

  PERFORM 1 FROM public.flashcards f
   WHERE f.id IN (SELECT i.card_id FROM illustrations.batch_items i WHERE i.batch_id = p_batch_id)
   ORDER BY f.id
     FOR UPDATE;

  FOR v_item IN SELECT * FROM illustrations.batch_items i WHERE i.batch_id = p_batch_id ORDER BY i.card_id
  LOOP
    SELECT * INTO v_cur FROM public.flashcards f WHERE f.id = v_item.card_id;
    IF NOT FOUND OR v_cur.back_image_url IS DISTINCT FROM v_item.url OR v_cur.back_image_alt IS DISTINCT FROM v_item.alt THEN
      RAISE EXCEPTION 'ABORT: card % has changed since this batch published it; nothing was rolled back', v_item.card_id;
    END IF;
    IF v_item.expected_url IS NOT NULL THEN
      v_prev_object := 'cards/' || pg_catalog.substring(v_item.expected_url, '^/flashcards/backs/(.*)$');
      IF NOT EXISTS (SELECT 1 FROM storage.objects o WHERE o.bucket_id = 'flashcard-images' AND o.name = v_prev_object) THEN
        RAISE EXCEPTION 'ABORT: the previous image for card % is no longer in storage; nothing was rolled back', v_item.card_id;
      END IF;
    END IF;

    UPDATE public.flashcards f
       SET back_image_url = v_item.expected_url,
           back_image_alt = v_item.expected_alt
     WHERE f.id = v_item.card_id
       AND f.back_image_url = v_item.url
       AND f.back_image_alt = v_item.alt;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    IF v_rows <> 1 THEN
      RAISE EXCEPTION 'ABORT: restoring card % touched % rows; nothing was rolled back', v_item.card_id, v_rows;
    END IF;
    INSERT INTO illustrations.events (batch_id, card_id, event, authority, performed_by, detail)
    VALUES (p_batch_id, v_item.card_id, 'ROLLED_BACK', p_on_behalf_of, v_by,
            pg_catalog.jsonb_build_object('restored_url', v_item.expected_url, 'restored_alt', v_item.expected_alt,
                                          'removed_url', v_item.url));
  END LOOP;

  UPDATE illustrations.batches
     SET state = 'ROLLED_BACK', rollback_authority = p_on_behalf_of, rollback_recorded_by = v_by,
         rollback_instruction = p_instruction, rolled_back_at = pg_catalog.now()
   WHERE batch_id = p_batch_id;
  INSERT INTO illustrations.events (batch_id, event, authority, performed_by, detail)
  VALUES (p_batch_id, 'ROLLED_BACK', p_on_behalf_of, v_by,
          pg_catalog.jsonb_build_object('instruction', p_instruction, 'session_verified', false));
  RETURN pg_catalog.jsonb_build_object('batch_id', p_batch_id, 'state', 'ROLLED_BACK', 'restored', v_batch.item_count);
END;
$$;

-- ─── 9. Reading a batch ────────────────────────────────────────────────────
-- For the operator, and for administrators from their own session.
CREATE FUNCTION public.illustration_batch_status(p_batch_id uuid)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  IF (SELECT auth.role()) IS DISTINCT FROM 'service_role'
     AND NOT illustrations.is_admin((SELECT auth.uid())) THEN
    RAISE EXCEPTION 'forbidden: administrators only';
  END IF;
  RETURN (
    SELECT pg_catalog.jsonb_build_object(
      'batch', pg_catalog.to_jsonb(b),
      'items', COALESCE((SELECT pg_catalog.jsonb_agg(pg_catalog.to_jsonb(i) ORDER BY i.card_id)
                           FROM illustrations.batch_items i WHERE i.batch_id = b.batch_id), '[]'::jsonb),
      'events', COALESCE((SELECT pg_catalog.jsonb_agg(pg_catalog.to_jsonb(e) ORDER BY e.id)
                            FROM illustrations.events e WHERE e.batch_id = b.batch_id), '[]'::jsonb))
      FROM illustrations.batches b WHERE b.batch_id = p_batch_id);
END;
$$;

-- ─── 10. Function privileges ───────────────────────────────────────────────
-- Revoke everything every function was born with, then grant exactly.
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA illustrations FROM PUBLIC, anon, authenticated, service_role;

REVOKE ALL ON FUNCTION public.illustration_record_verification(text, text, bigint, text, text, text) FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_stage_batch(uuid, jsonb, text)                          FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_record_approval(uuid, text, uuid, text, text)           FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_publish_batch(uuid, text)                               FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_record_postverify(uuid, boolean, jsonb)                 FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_rollback_batch(uuid, text, uuid, text, text)            FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.illustration_approve_batch(uuid, text, text)                         FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION public.illustration_batch_status(uuid)                                      FROM PUBLIC, anon;

GRANT EXECUTE ON FUNCTION public.illustration_record_verification(text, text, bigint, text, text, text) TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_stage_batch(uuid, jsonb, text)                          TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_record_approval(uuid, text, uuid, text, text)           TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_publish_batch(uuid, text)                               TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_record_postverify(uuid, boolean, jsonb)                 TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_rollback_batch(uuid, text, uuid, text, text)            TO service_role;
GRANT EXECUTE ON FUNCTION public.illustration_approve_batch(uuid, text, text)                         TO authenticated;
GRANT EXECUTE ON FUNCTION public.illustration_batch_status(uuid)                                      TO authenticated, service_role;

-- ═══════════════════════════════════════════════════════════════════════════
-- 11. CLOSING THE DIRECT ROUTES AROUND THE PUBLISHER
--
-- No GRANT or REVOKE on public.flashcards exists in any earlier migration, so
-- Supabase's default stands: anon and authenticated hold every table
-- privilege and row-level security is the only gate. 20260602_add_admin_role
-- gives administrators an UPDATE policy with no column limit, so an
-- administrator could write back_image_url and back_image_alt directly through
-- PostgREST, unverified and unaudited.
--
-- The only application write to flashcards is the admin card editor
-- (app/dashboard/admin/flashcards/[deckId]/page.tsx), which updates exactly
-- cloze_text and cloze_count. Learner grading goes through
-- submit_flashcard_review, a SECURITY DEFINER function that never writes this
-- table. So: column-level UPDATE on those two columns only, and no INSERT,
-- DELETE or TRUNCATE for API roles (no policy allows insert or delete today,
-- and TRUNCATE is not subject to row-level security at all). SELECT is not
-- touched: learners read cards exactly as before.
--
-- service_role keeps its privileges: seed scripts run as it. The operator
-- tooling never writes image columns directly; it calls the functions above.
-- The privileges as they were a moment ago are in illustrations.install_baseline.
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON public.flashcards FROM anon, authenticated;
GRANT UPDATE (cloze_text, cloze_count) ON public.flashcards TO authenticated;

COMMENT ON POLICY "Admins can update flashcards" ON public.flashcards IS
  'Row gate for the admin cloze editor. Column grants limit API roles to cloze_text and cloze_count; back_image_url and back_image_alt change only through public.illustration_publish_batch, which verifies and audits every mapping.';

-- ─── 12. Post-conditions: the migration checks its own work ────────────────
DO $post$
DECLARE n int;
BEGIN
  -- The revoke took full effect: no API role keeps a direct write by any
  -- route (a grant from another grantor would survive a REVOKE).
  IF pg_catalog.has_table_privilege('anon', 'public.flashcards', 'INSERT, UPDATE, DELETE, TRUNCATE')
     OR pg_catalog.has_table_privilege('authenticated', 'public.flashcards', 'INSERT, UPDATE, DELETE, TRUNCATE') THEN
    RAISE EXCEPTION 'POST: an API role still holds a table-level write privilege on flashcards';
  END IF;
  SELECT pg_catalog.count(*) INTO n
    FROM pg_catalog.pg_attribute a
   WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
     AND (pg_catalog.has_column_privilege('anon', a.attrelid, a.attnum, 'INSERT, UPDATE')
          OR pg_catalog.has_column_privilege('authenticated', a.attrelid, a.attnum, 'INSERT')
          OR (a.attname NOT IN ('cloze_text', 'cloze_count')
              AND pg_catalog.has_column_privilege('authenticated', a.attrelid, a.attnum, 'UPDATE')));
  IF n <> 0 THEN
    RAISE EXCEPTION 'POST: an API role can still write % column(s) of flashcards directly', n;
  END IF;
  -- No API role may write an image column directly.
  IF pg_catalog.has_column_privilege('authenticated', 'public.flashcards', 'back_image_url', 'UPDATE')
     OR pg_catalog.has_column_privilege('anon', 'public.flashcards', 'back_image_url', 'UPDATE')
     OR pg_catalog.has_column_privilege('authenticated', 'public.flashcards', 'back_image_alt', 'UPDATE')
     OR pg_catalog.has_column_privilege('anon', 'public.flashcards', 'back_image_alt', 'UPDATE') THEN
    RAISE EXCEPTION 'POST: an API role can still write image columns directly';
  END IF;
  -- The admin editor's two columns still work, and learners can still read cards.
  IF NOT pg_catalog.has_column_privilege('authenticated', 'public.flashcards', 'cloze_text', 'UPDATE')
     OR NOT pg_catalog.has_column_privilege('authenticated', 'public.flashcards', 'cloze_count', 'UPDATE') THEN
    RAISE EXCEPTION 'POST: the admin cloze editor would lose its columns';
  END IF;
  IF NOT pg_catalog.has_table_privilege('authenticated', 'public.flashcards', 'SELECT') THEN
    RAISE EXCEPTION 'POST: learners would lose read access to cards';
  END IF;
  -- Operator-only functions are not executable by learners or the public.
  SELECT pg_catalog.count(*) INTO n
    FROM pg_catalog.pg_proc p JOIN pg_catalog.pg_namespace s ON s.oid = p.pronamespace
   WHERE s.nspname = 'public'
     AND p.proname IN ('illustration_record_verification', 'illustration_stage_batch', 'illustration_record_approval',
                       'illustration_publish_batch', 'illustration_record_postverify', 'illustration_rollback_batch')
     AND (pg_catalog.has_function_privilege('authenticated', p.oid, 'EXECUTE')
          OR pg_catalog.has_function_privilege('anon', p.oid, 'EXECUTE'));
  IF n <> 0 THEN
    RAISE EXCEPTION 'POST: % operator function(s) are executable by anon or authenticated', n;
  END IF;
  -- Nothing in the private schema is reachable by an API role.
  IF pg_catalog.has_schema_privilege('authenticated', 'illustrations', 'USAGE')
     OR pg_catalog.has_schema_privilege('anon', 'illustrations', 'USAGE') THEN
    RAISE EXCEPTION 'POST: an API role can enter the illustrations schema';
  END IF;
  -- Every SECURITY DEFINER function here pins an empty search_path.
  SELECT pg_catalog.count(*) INTO n
    FROM pg_catalog.pg_proc p JOIN pg_catalog.pg_namespace s ON s.oid = p.pronamespace
   WHERE (s.nspname = 'illustrations' OR p.proname LIKE 'illustration\_%')
     AND p.prosecdef
     AND NOT COALESCE(p.proconfig @> ARRAY['search_path=""'], false);
  IF n <> 0 THEN
    RAISE EXCEPTION 'POST: % SECURITY DEFINER function(s) without an empty search_path', n;
  END IF;
  -- The rollback has what it needs to restore exactly: both access lists, the
  -- policy comment, and an entry for every column of flashcards.
  IF (SELECT pg_catalog.count(*) FROM illustrations.install_baseline) <> 3
     OR EXISTS (SELECT 1 FROM pg_catalog.pg_attribute a
                 WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
                   AND NOT (SELECT b.value ? a.attname FROM illustrations.install_baseline b
                             WHERE b.key = 'flashcards_column_acl')) THEN
    RAISE EXCEPTION 'POST: the pre-install privileges were not all recorded';
  END IF;
END
$post$;

COMMIT;

-- Rollback: supabase/fixes/20261031032938_illustration_publishing_rollback.sql
-- (refuses while any batch is live; undo published batches first with
-- public.illustration_rollback_batch, newest first).
