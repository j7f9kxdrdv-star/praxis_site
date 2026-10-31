# Migrations applied to production

Production does not use the Supabase CLI's migration history: on 31 October 2026
`supabase/fixes/READONLY_migration_history_check.sql` showed no
`supabase_migrations` schema at all (PostgreSQL 17.6). Every migration has been applied
by pasting it into the SQL Editor. This file is the record, from the publishing
migration on. The 81 earlier files in `supabase/migrations/` were applied the same way
before this ledger existed.

Rules:

* A file is applied only after it is committed here under its permanent name, with the
  same bytes (the SHA-256 below is taken before pasting and must equal the reviewed one).
* Once applied, a file is never edited. A correction is a new migration.
* `supabase db push` and `supabase migration repair` are never run, and no
  `supabase_migrations` table is created or written, unless that is decided and
  authorized separately (it would invent a history the earlier files never had).
* Each line is added right after the post-check passes, in its own commit.

| Version | File | SHA-256 | Applied (UTC) | By | Post-check |
|---|---|---|---|---|---|
