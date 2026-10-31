-- ═══════════════════════════════════════════════════════════════════════════
-- READ-ONLY. Run AFTER applying
-- supabase/migrations/20261031032938_illustration_publishing.sql.
-- One SELECT: it cannot change anything. Every row must say ok = true. If
-- any row is false, run 20261031032938_illustration_publishing_rollback.sql
-- (nothing can have been published yet) and send the result table back.
--
-- `expected` holds the same reviewed production state as the pre-check, and
-- changes only together with it: the migration changes no card and makes no
-- one an administrator, so both numbers must be exactly what they were.
-- ═══════════════════════════════════════════════════════════════════════════
WITH expected (illustrated_cards, administrators) AS (VALUES (55, 0)),
fn(name, sig, operator_only) AS (
  VALUES ('illustration_record_verification', 'public.illustration_record_verification(text, text, bigint, text, text, text)', true),
         ('illustration_stage_batch',         'public.illustration_stage_batch(uuid, jsonb, text)',                          true),
         ('illustration_record_approval',     'public.illustration_record_approval(uuid, text, uuid, text, text)',           true),
         ('illustration_publish_batch',       'public.illustration_publish_batch(uuid, text)',                               true),
         ('illustration_record_postverify',   'public.illustration_record_postverify(uuid, boolean, jsonb)',                 true),
         ('illustration_rollback_batch',      'public.illustration_rollback_batch(uuid, text, uuid, text, text)',            true),
         ('illustration_approve_batch',       'public.illustration_approve_batch(uuid, text, text)',                         false),
         ('illustration_batch_status',        'public.illustration_batch_status(uuid)',                                      false)
)
SELECT * FROM (
  SELECT 1 AS n, 'the eight public.illustration_* functions exist with the reviewed signatures' AS check_name, '8' AS expected,
         (SELECT count(*)::text FROM fn WHERE to_regprocedure(fn.sig) IS NOT NULL) AS actual,
         (SELECT count(*) FROM fn WHERE to_regprocedure(fn.sig) IS NOT NULL) = 8 AS ok
  UNION ALL
  SELECT 2, 'every illustration function runs as its owner with an empty search_path', '0 exceptions',
         (SELECT count(*)::text || ' exceptions' FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace
           WHERE (s.nspname = 'illustrations' OR (s.nspname = 'public' AND p.proname LIKE 'illustration\_%'))
             AND p.prosecdef AND NOT COALESCE(p.proconfig @> ARRAY['search_path=""'], false)),
         NOT EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace s ON s.oid = p.pronamespace
                      WHERE (s.nspname = 'illustrations' OR (s.nspname = 'public' AND p.proname LIKE 'illustration\_%'))
                        AND p.prosecdef AND NOT COALESCE(p.proconfig @> ARRAY['search_path=""'], false))
  UNION ALL
  SELECT 3, 'the six operator functions: service_role only (not anon, not authenticated)', '6 of 6',
         (SELECT count(*)::text || ' of 6' FROM fn WHERE fn.operator_only AND to_regprocedure(fn.sig) IS NOT NULL
             AND has_function_privilege('service_role', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('authenticated', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('anon', to_regprocedure(fn.sig), 'EXECUTE')),
         (SELECT count(*) FROM fn WHERE fn.operator_only AND to_regprocedure(fn.sig) IS NOT NULL
             AND has_function_privilege('service_role', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('authenticated', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('anon', to_regprocedure(fn.sig), 'EXECUTE')) = 6
  UNION ALL
  SELECT 4, 'approve_batch and batch_status: signed-in accounts may call them (they refuse non-admins), anon may not', '2 of 2',
         (SELECT count(*)::text || ' of 2' FROM fn WHERE NOT fn.operator_only AND to_regprocedure(fn.sig) IS NOT NULL
             AND has_function_privilege('authenticated', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('anon', to_regprocedure(fn.sig), 'EXECUTE')),
         (SELECT count(*) FROM fn WHERE NOT fn.operator_only AND to_regprocedure(fn.sig) IS NOT NULL
             AND has_function_privilege('authenticated', to_regprocedure(fn.sig), 'EXECUTE')
             AND NOT has_function_privilege('anon', to_regprocedure(fn.sig), 'EXECUTE')) = 2
  UNION ALL
  SELECT 5, 'no API role can enter the private illustrations schema', 'no USAGE',
         CASE WHEN has_schema_privilege('anon', 'illustrations', 'USAGE') OR has_schema_privilege('authenticated', 'illustrations', 'USAGE')
                   OR has_schema_privilege('service_role', 'illustrations', 'USAGE') THEN 'USAGE granted' ELSE 'no USAGE' END,
         NOT (has_schema_privilege('anon', 'illustrations', 'USAGE') OR has_schema_privilege('authenticated', 'illustrations', 'USAGE')
              OR has_schema_privilege('service_role', 'illustrations', 'USAGE'))
  UNION ALL
  SELECT 6, 'the five private tables exist with row-level security on', '5',
         (SELECT count(*)::text FROM pg_class c JOIN pg_namespace s ON s.oid = c.relnamespace
           WHERE s.nspname = 'illustrations' AND c.relkind = 'r' AND c.relrowsecurity
             AND c.relname IN ('install_baseline', 'assets', 'batches', 'batch_items', 'events')),
         (SELECT count(*) FROM pg_class c JOIN pg_namespace s ON s.oid = c.relnamespace
           WHERE s.nspname = 'illustrations' AND c.relkind = 'r' AND c.relrowsecurity
             AND c.relname IN ('install_baseline', 'assets', 'batches', 'batch_items', 'events')) = 5
  UNION ALL
  SELECT 7, 'no API role can write an image column directly (administrators included)', 'none',
         CASE WHEN has_column_privilege('anon', 'public.flashcards', 'back_image_url', 'UPDATE')
                OR has_column_privilege('authenticated', 'public.flashcards', 'back_image_url', 'UPDATE')
                OR has_column_privilege('anon', 'public.flashcards', 'back_image_alt', 'UPDATE')
                OR has_column_privilege('authenticated', 'public.flashcards', 'back_image_alt', 'UPDATE') THEN 'still writable' ELSE 'none' END,
         NOT (has_column_privilege('anon', 'public.flashcards', 'back_image_url', 'UPDATE')
              OR has_column_privilege('authenticated', 'public.flashcards', 'back_image_url', 'UPDATE')
              OR has_column_privilege('anon', 'public.flashcards', 'back_image_alt', 'UPDATE')
              OR has_column_privilege('authenticated', 'public.flashcards', 'back_image_alt', 'UPDATE'))
  UNION ALL
  SELECT 8, 'no API role can insert, delete or truncate cards', 'none',
         CASE WHEN has_table_privilege('anon', 'public.flashcards', 'INSERT, DELETE, TRUNCATE')
                OR has_table_privilege('authenticated', 'public.flashcards', 'INSERT, DELETE, TRUNCATE') THEN 'still granted' ELSE 'none' END,
         NOT (has_table_privilege('anon', 'public.flashcards', 'INSERT, DELETE, TRUNCATE')
              OR has_table_privilege('authenticated', 'public.flashcards', 'INSERT, DELETE, TRUNCATE'))
  UNION ALL
  SELECT 9, 'the admin card editor keeps cloze_text and cloze_count; learners keep reading cards', 'true',
         (has_column_privilege('authenticated', 'public.flashcards', 'cloze_text', 'UPDATE')
          AND has_column_privilege('authenticated', 'public.flashcards', 'cloze_count', 'UPDATE')
          AND has_table_privilege('authenticated', 'public.flashcards', 'SELECT'))::text,
         has_column_privilege('authenticated', 'public.flashcards', 'cloze_text', 'UPDATE')
          AND has_column_privilege('authenticated', 'public.flashcards', 'cloze_count', 'UPDATE')
          AND has_table_privilege('authenticated', 'public.flashcards', 'SELECT')
  UNION ALL
  SELECT 10, 'the privileges as they were before are recorded for the rollback, every column included', '3 entries, every column',
         (SELECT count(*)::text FROM illustrations.install_baseline) || ' entries, '
           || (SELECT count(*) FROM pg_attribute a WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
                 AND NOT EXISTS (SELECT 1 FROM illustrations.install_baseline b WHERE b.key = 'flashcards_column_acl' AND b.value ? a.attname))::text
           || ' column(s) missing',
         (SELECT count(*) FROM illustrations.install_baseline) = 3
           AND NOT EXISTS (SELECT 1 FROM pg_attribute a WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
                 AND NOT EXISTS (SELECT 1 FROM illustrations.install_baseline b WHERE b.key = 'flashcards_column_acl' AND b.value ? a.attname))
  UNION ALL
  SELECT 11, 'nothing has been staged or published yet', '0 batches',
         (SELECT count(*)::text || ' batches' FROM illustrations.batches),
         NOT EXISTS (SELECT 1 FROM illustrations.batches)
  UNION ALL
  SELECT 12, 'administrators (none until administrator activation, a separate later step)',
         (SELECT administrators::text FROM expected),
         (SELECT count(*)::text FROM public.profiles WHERE is_admin),
         (SELECT count(*) FROM public.profiles WHERE is_admin) = (SELECT administrators FROM expected)
  UNION ALL
  SELECT 13, 'illustrated cards (unchanged by this migration)',
         (SELECT illustrated_cards::text FROM expected),
         (SELECT count(*)::text FROM public.flashcards WHERE back_image_url IS NOT NULL),
         (SELECT count(*) FROM public.flashcards WHERE back_image_url IS NOT NULL) = (SELECT illustrated_cards FROM expected)
  UNION ALL
  SELECT 14, 'no API role keeps a direct write on any column except the editor''s two', '0 columns',
         (SELECT count(*)::text || ' columns' FROM pg_attribute a
           WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
             AND (has_column_privilege('anon', a.attrelid, a.attnum, 'INSERT, UPDATE')
                  OR has_column_privilege('authenticated', a.attrelid, a.attnum, 'INSERT')
                  OR (a.attname NOT IN ('cloze_text', 'cloze_count') AND has_column_privilege('authenticated', a.attrelid, a.attnum, 'UPDATE')))),
         NOT EXISTS (SELECT 1 FROM pg_attribute a
           WHERE a.attrelid = 'public.flashcards'::regclass AND a.attnum > 0 AND NOT a.attisdropped
             AND (has_column_privilege('anon', a.attrelid, a.attnum, 'INSERT, UPDATE')
                  OR has_column_privilege('authenticated', a.attrelid, a.attnum, 'INSERT')
                  OR (a.attname NOT IN ('cloze_text', 'cloze_count') AND has_column_privilege('authenticated', a.attrelid, a.attnum, 'UPDATE'))))
) checks
ORDER BY n;
