-- ═══════════════════════════════════════════════════════════════════════════
-- READ-ONLY. What production's own migration history holds.
-- One SELECT: it cannot change anything. Run in the Supabase SQL Editor and
-- send back the single result row.
--
-- WHY. The Supabase CLI records applied migrations in
-- supabase_migrations.schema_migrations. This project has applied all 81 of
-- its migrations by pasting them into the SQL Editor, which records nothing
-- there. Before the publishing migration is applied, we need to know whether
-- that table exists and what it contains, so the new migration is recorded the
-- same way as everything before it, and nothing is ever replayed.
--
-- The table may not exist; the queries against it only run if it does.
-- ═══════════════════════════════════════════════════════════════════════════
SELECT
  to_regclass('supabase_migrations.schema_migrations') IS NOT NULL AS history_table_exists,
  CASE WHEN to_regclass('supabase_migrations.schema_migrations') IS NOT NULL
       THEN (xpath('/row/n/text()', query_to_xml(
              'SELECT count(*) AS n FROM supabase_migrations.schema_migrations', false, true, '')))[1]::text
  END AS recorded_migrations,
  CASE WHEN to_regclass('supabase_migrations.schema_migrations') IS NOT NULL
       THEN query_to_xml(
              'SELECT version, name FROM supabase_migrations.schema_migrations ORDER BY version DESC LIMIT 15',
              false, true, '')::text
  END AS latest_15_recorded,
  (SELECT string_agg(nspname, ', ' ORDER BY nspname) FROM pg_catalog.pg_namespace
    WHERE nspname LIKE 'supabase_migrations%' OR nspname = 'illustrations') AS related_schemas,
  current_setting('server_version') AS postgres_version;
