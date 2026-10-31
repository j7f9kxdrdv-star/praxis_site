-- ═══════════════════════════════════════════════════════════════════════════
-- READ-ONLY. Run BEFORE applying
-- supabase/migrations/20261031032938_illustration_publishing.sql.
-- One SELECT: it cannot change anything. Every row must say ok = true (the
-- one row marked "info" reports a value and is always ok). Send the whole
-- result table back before the migration is applied.
--
-- THE EXPECTED PRODUCTION STATE is the one line in `expected` below:
-- 71 illustrated cards (after the 15-image quarantine of 31 October) and no
-- administrator (one is activated only after this migration, as its own step).
-- Both are pass/fail. If the state changes before Phase B (for example the
-- 6-image quarantine runs first, leaving 65), this file is not loosened:
-- that one line is changed to the new reviewed number, in its own reviewed
-- change, and the tests prove the file then refuses every other count.
-- ═══════════════════════════════════════════════════════════════════════════
WITH expected (illustrated_cards, administrators) AS (VALUES (71, 0))
SELECT * FROM (
  SELECT 1 AS n, 'PostgreSQL is 14 or newer' AS check_name, '>= 140000' AS expected,
         current_setting('server_version_num') AS actual,
         current_setting('server_version_num')::int >= 140000 AS ok
  UNION ALL
  SELECT 2, 'public.flashcards is owned by the role running this (so its REVOKE takes effect)', current_user::text,
         (SELECT pg_get_userbyid(relowner) FROM pg_class WHERE oid = 'public.flashcards'::regclass),
         (SELECT pg_get_userbyid(relowner) FROM pg_class WHERE oid = 'public.flashcards'::regclass) = current_user::text
  UNION ALL
  SELECT 3, 'schema "illustrations" does not exist yet', 'absent',
         CASE WHEN EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = 'illustrations') THEN 'present' ELSE 'absent' END,
         NOT EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = 'illustrations')
  UNION ALL
  SELECT 4, 'no public.illustration_* function exists yet', '0',
         (SELECT count(*)::text FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace
           WHERE s.nspname = 'public' AND p.proname LIKE 'illustration\_%'),
         NOT EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace
                      WHERE s.nspname = 'public' AND p.proname LIKE 'illustration\_%')
  UNION ALL
  SELECT 5, 'flashcards has the columns the migration uses', 'id uuid, back_image_url text, back_image_alt text, cloze_text text, cloze_count integer',
         (SELECT string_agg(attname || ' ' || format_type(atttypid, atttypmod), ', ' ORDER BY attname) FROM pg_attribute
           WHERE attrelid = 'public.flashcards'::regclass AND attname IN ('id', 'back_image_url', 'back_image_alt', 'cloze_text', 'cloze_count') AND NOT attisdropped),
         (SELECT count(*) FROM pg_attribute WHERE attrelid = 'public.flashcards'::regclass AND NOT attisdropped
             AND ((attname = 'id' AND atttypid = 'uuid'::regtype) OR (attname IN ('back_image_url', 'back_image_alt', 'cloze_text') AND atttypid = 'text'::regtype)
                  OR (attname = 'cloze_count' AND atttypid = 'int4'::regtype))) = 5
  UNION ALL
  SELECT 6, 'the only trigger on flashcards is the reviewed one (it never writes another table)', 'flashcards_protect_scoped_cloze_mappings',
         (SELECT COALESCE(string_agg(tgname, ',' ORDER BY tgname), '(none)') FROM pg_trigger WHERE tgrelid = 'public.flashcards'::regclass AND NOT tgisinternal),
         (SELECT COALESCE(string_agg(tgname, ',' ORDER BY tgname), '') FROM pg_trigger WHERE tgrelid = 'public.flashcards'::regclass AND NOT tgisinternal)
           = 'flashcards_protect_scoped_cloze_mappings'
  UNION ALL
  SELECT 7, 'row-level security is on for flashcards', 'true',
         (SELECT relrowsecurity::text FROM pg_class WHERE oid = 'public.flashcards'::regclass),
         (SELECT relrowsecurity FROM pg_class WHERE oid = 'public.flashcards'::regclass)
  UNION ALL
  SELECT 8, 'policy "Admins can update flashcards" exists and is an UPDATE policy', 'w (UPDATE)',
         COALESCE((SELECT polcmd::text FROM pg_policy WHERE polrelid = 'public.flashcards'::regclass AND polname = 'Admins can update flashcards'), 'missing'),
         EXISTS (SELECT 1 FROM pg_policy WHERE polrelid = 'public.flashcards'::regclass AND polname = 'Admins can update flashcards' AND polcmd = 'w')
  UNION ALL
  SELECT 9, 'profiles.is_admin exists and users cannot set it on themselves', 'boolean column + trigger profiles_prevent_self_admin_update',
         COALESCE((SELECT format_type(atttypid, atttypmod) FROM pg_attribute WHERE attrelid = 'public.profiles'::regclass AND attname = 'is_admin' AND NOT attisdropped), 'missing')
           || ' / ' || CASE WHEN EXISTS (SELECT 1 FROM pg_trigger WHERE tgrelid = 'public.profiles'::regclass AND tgname = 'profiles_prevent_self_admin_update') THEN 'trigger present' ELSE 'trigger missing' END,
         EXISTS (SELECT 1 FROM pg_attribute WHERE attrelid = 'public.profiles'::regclass AND attname = 'is_admin' AND atttypid = 'bool'::regtype AND NOT attisdropped)
           AND EXISTS (SELECT 1 FROM pg_trigger WHERE tgrelid = 'public.profiles'::regclass AND tgname = 'profiles_prevent_self_admin_update')
  UNION ALL
  SELECT 10, 'auth.uid() and auth.role() exist', '2',
         (SELECT count(*)::text FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace WHERE s.nspname = 'auth' AND p.proname IN ('uid', 'role')),
         (SELECT count(DISTINCT p.proname) FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace WHERE s.nspname = 'auth' AND p.proname IN ('uid', 'role')) = 2
  UNION ALL
  SELECT 11, 'storage.objects has id, bucket_id, name, version, metadata', '5',
         (SELECT count(*)::text FROM pg_attribute WHERE attrelid = 'storage.objects'::regclass AND attname IN ('id', 'bucket_id', 'name', 'version', 'metadata') AND NOT attisdropped),
         (SELECT count(*) FROM pg_attribute WHERE attrelid = 'storage.objects'::regclass AND attname IN ('id', 'bucket_id', 'name', 'version', 'metadata') AND NOT attisdropped) = 5
  UNION ALL
  SELECT 12, 'bucket flashcard-images exists and is private', 'private',
         COALESCE((SELECT CASE WHEN public THEN 'PUBLIC' ELSE 'private' END FROM storage.buckets WHERE id = 'flashcard-images'), 'missing'),
         EXISTS (SELECT 1 FROM storage.buckets WHERE id = 'flashcard-images' AND public = false)
  UNION ALL
  SELECT 13, 'every illustration object has a storage version (replacement is detectable)', '0 without a version',
         (SELECT count(*) FILTER (WHERE COALESCE(version, '') = '') || ' without a version, of ' || count(*) FROM storage.objects WHERE bucket_id = 'flashcard-images'),
         NOT EXISTS (SELECT 1 FROM storage.objects WHERE bucket_id = 'flashcard-images' AND COALESCE(version, '') = '')
  UNION ALL
  SELECT 14, 'learners can read cards (SELECT is kept by the migration)', 'true',
         has_table_privilege('authenticated', 'public.flashcards', 'SELECT')::text,
         has_table_privilege('authenticated', 'public.flashcards', 'SELECT')
  UNION ALL
  SELECT 18, 'no storage policy lets an API role upload, overwrite or delete objects (only the service key can)', 'none',
         (SELECT COALESCE(string_agg(polname || ' (' || CASE polcmd WHEN 'a' THEN 'INSERT' WHEN 'w' THEN 'UPDATE' WHEN 'd' THEN 'DELETE' ELSE 'ALL' END || ')', ', ' ORDER BY polname), 'none')
            FROM pg_policy WHERE polrelid = 'storage.objects'::regclass AND polcmd IN ('a', 'w', 'd', '*')),
         NOT EXISTS (SELECT 1 FROM pg_policy WHERE polrelid = 'storage.objects'::regclass AND polcmd IN ('a', 'w', 'd', '*'))
  UNION ALL
  SELECT 15, 'info: direct privileges of anon/authenticated on flashcards (the migration records every list, then revokes INSERT/UPDATE/DELETE/TRUNCATE)', 'recorded',
         (SELECT COALESCE(string_agg(t.entry, ', ' ORDER BY t.entry), '(none)') FROM (
            SELECT 'table ' || pg_get_userbyid(x.grantee) || ':' || x.privilege_type || CASE WHEN x.is_grantable THEN '+grant' ELSE '' END AS entry
              FROM pg_class k, unnest(k.relacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE k.oid = 'public.flashcards'::regclass AND pg_get_userbyid(x.grantee) IN ('anon', 'authenticated')
            UNION ALL
            SELECT 'column ' || a.attname || ' ' || pg_get_userbyid(x.grantee) || ':' || x.privilege_type || CASE WHEN x.is_grantable THEN '+grant' ELSE '' END
              FROM pg_attribute a, unnest(a.attacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped) t),
         true
  UNION ALL
  SELECT 16, 'administrators today (none until administrator activation, a separate later step)',
         (SELECT administrators::text FROM expected),
         (SELECT count(*)::text FROM public.profiles WHERE is_admin),
         (SELECT count(*) FROM public.profiles WHERE is_admin) = (SELECT administrators FROM expected)
  UNION ALL
  SELECT 17, 'illustrated cards today (71 after the 15-image quarantine)',
         (SELECT illustrated_cards::text FROM expected),
         (SELECT count(*)::text FROM public.flashcards WHERE back_image_url IS NOT NULL),
         (SELECT count(*) FROM public.flashcards WHERE back_image_url IS NOT NULL) = (SELECT illustrated_cards FROM expected)
  UNION ALL
  SELECT 19, 'every privilege on flashcards and its columns was granted by the table owner (so the REVOKE takes full effect and the rollback restores it exactly)', '0 from another grantor',
         (SELECT count(*)::text || ' from another grantor' FROM (
            SELECT x.grantor FROM pg_class k, unnest(k.relacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE k.oid = 'public.flashcards'::regclass AND x.grantor <> k.relowner
            UNION ALL
            SELECT x.grantor FROM pg_class k JOIN pg_attribute a ON a.attrelid = k.oid, unnest(a.attacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE k.oid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped AND x.grantor <> k.relowner) g),
         NOT EXISTS (
            SELECT 1 FROM pg_class k, unnest(k.relacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE k.oid = 'public.flashcards'::regclass AND x.grantor <> k.relowner
            UNION ALL
            SELECT 1 FROM pg_class k JOIN pg_attribute a ON a.attrelid = k.oid, unnest(a.attacl) u(item), aclexplode(ARRAY[u.item]) x
             WHERE k.oid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped AND x.grantor <> k.relowner)
) checks
ORDER BY n;
