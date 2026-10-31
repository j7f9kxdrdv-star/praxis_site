# Migration history and branch integration for the publishing migration

Updated 31 October 2026 with production's actual migration history. Nothing here changes
production, migration history or any branch on GitHub.

## What exists

**Production** (Mikko ran `supabase/fixes/READONLY_migration_history_check.sql`, 31 October):

| history_table_exists | recorded_migrations | latest_15_recorded | related_schemas | postgres_version |
|---|---|---|---|---|
| false | NULL | NULL | NULL | 17.6 |

There is no `supabase_migrations` schema at all, so no CLI history table and nothing in
it. Every one of the 81 migrations was applied by pasting it into the SQL Editor, which
records nothing. That matches the repository: no `supabase/config.toml`, no linked
project, no workflow or script that pushes migrations.

**The repository** (`main`, commit `575aabb`): 81 files in `supabase/migrations/`. None
uses the CLI's 14-digit version format (`001_…` to `011_…`, then `YYYYMMDD_…`); 15 dates
are shared by several files; 31 are content migrations that need seed data from outside
the folder; three same-day pairs depend on each other against their filename order.

**Consequence:** `supabase db push` must never be run against this project. The CLI would
read the shared dates as clashing versions and try to apply history it has no record of.
`supabase migration repair` and any insert into a history table are likewise not used:
with no table there is nothing to repair, and creating one would invent a history the 81
earlier files never had.

## How source control, production and the ledger stay consistent

1. **The permanent name is given before review, not at apply time.** The migration is
   `supabase/migrations/20261031032938_illustration_publishing.sql` (renamed from
   `PROPOSED_20261027_illustration_publishing.sql`; the version is the UTC time it was
   named). Its companions carry the same version:
   `supabase/fixes/20261031032938_illustration_publishing_{precheck,postcheck,rollback}.sql`.
   A full 14-digit version is unique and sorts after all 81 files, so the test harness
   replays it in order like any other migration: the file tested is the file applied.
2. **Source control holds it before production does.** A narrow change cut from `main`,
   `release/publishing-migration`, contains only the four files, the read-only history
   check, the ledger `supabase/APPLIED.md` and this document (prepared locally, not
   pushed). Merging it into `main` is its own authorization: it adds no application code,
   but a push to `main` starts a Vercel production build (of unchanged code).
3. **Apply exactly that file.** Before pasting, the operator records the SHA-256 of the
   four files and checks them against the reviewed hashes. Then the pre-check, the
   migration, the post-check, in the SQL Editor, as every earlier migration was applied.
4. **Record it twice, in two places that can be compared.** In the repository: one line in
   `supabase/APPLIED.md` (version, file, SHA-256, applied at, by whom, post-check result),
   in its own small commit. In the database: `illustrations.install_baseline.recorded_at`
   holds the moment the migration ran. No CLI history table is created or written.
5. **After that, the file never changes.** A later correction is a new migration with its
   own version, its own review and its own ledger line.

**If something goes wrong between steps:** applied but not yet in the ledger: add the line
(the post-check result is the evidence). In the ledger but rolled back: add a second line
recording the rollback, never delete the first. Committed but never applied: the ledger
has no line, which is the truth.

**Fresh development and test environments:** the test harness is the supported way to
build the schema from the repository (it handles the ordering pairs, defers on missing
objects, and skips and lists the 31 seed-dependent files). A fresh Supabase project cannot
be built by replaying the folder, because of those 31 files; that was true before this
migration and does not change.

**If the Supabase CLI is adopted later** (a separate decision): baseline from production's
schema, mark that baseline applied with `migration repair`, and keep the 81 historical
files (and this one) as an archive. Never replay them.

## Branch integration

**Today:** `main` = `575aabb` (production, with Phase R). `feat/illustration-importer` branches from
`7a4fa7d` and holds 24 more commits; 2 of them are the Phase R changes, byte-identical to what `main`
already has (`git cherry` reports them as equal patches). A trial merge computed in memory is clean:
no conflicts, no duplicate route changes.

**What the feature branch would change on the live site:**

| Kind | Files |
|---|---|
| Runtime code | `app/dashboard/flashcards/page.tsx` and `lib/flashcards/hubLoad.ts`: the library-loading fix, which is a separate decision |
| Install-time | `package.json` / `package-lock.json`: four test-only dev dependencies (`pg`, `embedded-postgres`, `tsx`, `@types/pg`) and one script. `embedded-postgres` downloads a database binary during install, which only slows the build |
| No runtime effect | `lib/account/resetScope.ts` (a classification list used only by its test), `lib/illustrations/*` (used only by scripts), `scripts/`, `supabase/`, `docs/`, tests, `vitest.config.ts`, `CLAUDE.md` |

**The plan: never merge the feature branch.** When each piece is approved, cut a fresh branch from
the then-current `main` and copy in only that piece's paths, without the branch history:

```bash
git checkout -b release/publishing-migration origin/main
git checkout feat/illustration-importer -- <the approved paths>
```

1. `release/publishing-migration`, BEFORE Phase B (prepared locally): the migration, its three companion
   files, the read-only history check, the ledger and this document. Nothing else. The database tests
   (`supabase/tests/`, `vitest.config.ts` and their dev dependencies) can follow in a later change of
   their own; they run from the feature branch until then.
2. `release/illustration-tooling`, optional: the command-line pipeline (`scripts/illustrations/`,
   `lib/illustrations/`). It already runs from the feature branch on Mikko's computer, so this is only
   for keeping the code in one place.
3. `fix/library-loading`, whenever Mikko chooses: the two runtime files above, on their own.

Each gets the same gate Phase R had: the exact branch type-checks, lints, passes its full test suite
and builds; `git diff --name-only origin/main` lists only that piece's paths (for 1 and 2, nothing under
`app/`, `components/` or `middleware`, and no `lib/` file the app imports); then a preview, then merge.
Phase R's two commits are never copied again, because they are already in `main`.
