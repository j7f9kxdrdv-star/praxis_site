// ─── Keeping current state current ──────────────────────────────────────────
//
// WHY A SCHEDULE AND NOT AN EVENT. Memory freshness is a function of ELAPSED
// TIME, not of activity: a learner who stops studying has state that must keep
// ageing, and nothing they do will trigger a recomputation because they are
// doing nothing. An event-driven refresh can only ever update the people who
// are already active, which is exactly the population that needs it least. So
// there has to be a time-based path, and this is it.
//
// WHAT IT DOES NOT DO. It does not compute anything itself. Per account it
// loads evidence, calls the pure model and calls the atomic writer, which is
// the same path the manual rollout used. There is no bulk SQL version of the
// model, no direct write to learner_concept_states, and no second state
// contract. One model, one writer.
//
// THE PREFLIGHT IS THE POINT, almost as much as the refresh. The account
// universe invariant was false for six months and nothing noticed, because
// nothing was looking. Now every scheduled run checks it before writing a
// single row, so the longest anything can hide is one cadence.

import type { SupabaseClient } from "@supabase/supabase-js";
import {
  loadAccountUniverse, integrityFailures, readyAccounts,
  type Account, type AdminLister,
} from "@/lib/learner/accountUniverse";
import { loadConceptBank, loadConceptEvidence } from "@/lib/learner/conceptEvidence";
import { buildConceptStates, CONCEPT_STATE_MODEL_VERSION } from "@/lib/learner/conceptState";
import { loadPreviousStates, type WriteReport } from "@/lib/learner/computeConceptStates";
import { toPayload, singleModelVersion } from "@/lib/learner/conceptStatePersistence";
import { studyDayKey, DEFAULT_DAY_START_HOUR, timezoneOf } from "@/lib/flashcards/studyDay";

/**
 * How recently another run must have finished for this one to stand down.
 *
 * NOT A LOCK, and it does not pretend to be. Correctness against two
 * overlapping runs is already guaranteed by the writer's per-learner advisory
 * lock: whichever batch wins, a learner ends up with one complete batch and
 * never a mixture. This only stops the WASTE of recomputing the whole universe
 * twice when a manual invocation lands on top of a scheduled one.
 *
 * A session-level advisory lock would be the textbook answer and is the wrong
 * one here: PostgREST pools connections, so the session that took the lock is
 * not reliably the session that releases it, and a leaked lock would block
 * every future refresh until someone found it.
 */
export const RECENT_RUN_MINUTES = 20;

export type RunOutcome = "COMPLETED" | "ALREADY_RUNNING" | "INTEGRITY_FAILURE";

export interface AccountResult {
  userId: string;
  accountKind: string | null;
  studyDay: string;
  states: number;
  stored: number | null;
  deleted: number | null;
  error: string | null;
  /** Where it failed, when it did: load, compute or write. */
  stage: "LOAD" | "COMPUTE" | "WRITE" | null;
}

export interface RunReport {
  runId: string;
  runNow: string;
  startedAt: string;
  finishedAt: string;
  durationMs: number;
  outcome: RunOutcome;
  dryRun: boolean;
  modelVersion: string;
  authAccounts: number;
  profilesReconciled: number;
  pagesFetched: number;
  integrityOk: boolean;
  integrityFailures: string[];
  attempted: number;
  succeeded: number;
  failed: number;
  zeroState: number;
  statesComputed: number;
  rowsStored: number;
  accounts: AccountResult[];
}

/** Has a full refresh landed within the recency window? */
async function recentlyRefreshed(db: SupabaseClient, now: Date): Promise<string | null> {
  const { data, error } = await db
    .from("learner_concept_states")
    .select("computed_at")
    .order("computed_at", { ascending: false })
    .limit(1);
  if (error) throw new Error(`refreshRun: reading the last run: ${error.message}`);
  const last = data?.[0]?.computed_at;
  if (!last) return null;
  const age = now.getTime() - new Date(last).getTime();
  return age >= 0 && age < RECENT_RUN_MINUTES * 60_000 ? last : null;
}

/**
 * Refresh every account in the canonical universe.
 *
 * ONE CLOCK for the whole run, so cross-account state is one coherent
 * observation rather than N readings taken minutes apart. Each learner still
 * resolves their OWN study day from their own profile: one run clock does not
 * mean one study day, because day_start_hour is per profile.
 *
 * SEQUENTIAL, with the bank loaded once. Ten thousand learners' evidence will
 * not fit in memory together and does not need to: the expensive part is the
 * bank, it is identical for everyone, and it is read a single time.
 */
export async function runRefresh(
  db: SupabaseClient & AdminLister,
  options: { now?: Date; dryRun?: boolean; force?: boolean; runId?: string } = {},
): Promise<RunReport> {
  const startedAt = new Date();
  const runNow = options.now ?? startedAt;
  const runId = options.runId ?? `refresh_${runNow.toISOString()}`;
  const dryRun = options.dryRun ?? false;

  const base = {
    runId, runNow: runNow.toISOString(), startedAt: startedAt.toISOString(),
    dryRun, modelVersion: CONCEPT_STATE_MODEL_VERSION,
  };
  const finish = (r: Omit<RunReport, "finishedAt" | "durationMs">): RunReport => {
    const finishedAt = new Date();
    return { ...r, finishedAt: finishedAt.toISOString(), durationMs: finishedAt.getTime() - startedAt.getTime() };
  };

  // ── Stand down if one just ran ──────────────────────────────────────────
  if (!dryRun && !options.force) {
    const last = await recentlyRefreshed(db, runNow);
    if (last) {
      return finish({
        ...base, outcome: "ALREADY_RUNNING", authAccounts: 0, profilesReconciled: 0,
        pagesFetched: 0, integrityOk: true, integrityFailures: [],
        attempted: 0, succeeded: 0, failed: 0, zeroState: 0,
        statesComputed: 0, rowsStored: 0, accounts: [],
      });
    }
  }

  // ── The preflight, BEFORE any write ─────────────────────────────────────
  const universe = await loadAccountUniverse(db);
  const failures = integrityFailures(universe);
  if (failures.length > 0) {
    // LOUD, AND NOTHING IS WRITTEN. Refreshing the healthy accounts and
    // reporting success would be how an account stays invisible: the run would
    // look green every day while one learner was never processed.
    return finish({
      ...base, outcome: "INTEGRITY_FAILURE",
      authAccounts: universe.accounts.length,
      profilesReconciled: universe.accounts.filter((a) => a.profile != null).length,
      pagesFetched: universe.pagesFetched,
      integrityOk: false, integrityFailures: failures,
      attempted: 0, succeeded: 0, failed: 0, zeroState: 0,
      statesComputed: 0, rowsStored: 0, accounts: [],
    });
  }

  const accounts: Account[] = readyAccounts(universe);
  const bank = await loadConceptBank(db);
  const results: AccountResult[] = [];

  for (const account of accounts) {
    const dayStartHour = account.profile?.dayStartHour ?? DEFAULT_DAY_START_HOUR;
    const studyDay = studyDayKey(runNow, timezoneOf(account.profile?.timeZone), dayStartHour);
    const row: AccountResult = {
      userId: account.id, accountKind: account.profile?.accountKind ?? null,
      studyDay, states: 0, stored: null, deleted: null, error: null, stage: null,
    };
    try {
      const { evidence } = await loadConceptEvidence(db, account.id, bank);
      const previous = await loadPreviousStates(db, account.id);
      row.stage = "COMPUTE";
      const states = buildConceptStates(evidence, previous.length ? previous : null, runNow);
      row.states = states.length;
      if (!dryRun) {
        row.stage = "WRITE";
        const version = singleModelVersion(states) ?? CONCEPT_STATE_MODEL_VERSION;
        // EVEN WHEN EMPTY. An account with nothing to store is still written
        // with [], which clears any stale state and records that it was
        // processed. "No evidence" and "nobody ran this account" must not look
        // the same from the outside.
        const { data, error } = await db.rpc("replace_learner_concept_states", {
          p_user_id: account.id,
          p_study_day: studyDay,
          p_computed_at: runNow.toISOString(),
          p_model_version: version,
          p_states: toPayload(states),
        });
        if (error) throw new Error(error.message);
        const write = data as WriteReport;
        row.stored = write.final_row_count;
        row.deleted = write.rows_deleted;
        if (write.final_row_count !== states.length) {
          throw new Error(`computed ${states.length} states, stored ${write.final_row_count}`);
        }
      }
      row.stage = null;
    } catch (err) {
      // ONE ACCOUNT'S FAILURE DOES NOT STOP THE RUN, because current state is
      // replaceable and the writer is atomic: a failed account keeps whatever
      // it had, which is stale but coherent, while the rest get fresh state.
      // Stopping would punish every other learner for one learner's problem.
      // The run still reports failure, so it can never look like a clean pass.
      row.error = err instanceof Error ? err.message : String(err);
    }
    results.push(row);
  }

  const failedRows = results.filter((r) => r.error != null);
  return finish({
    ...base,
    outcome: "COMPLETED",
    authAccounts: universe.accounts.length,
    profilesReconciled: universe.accounts.filter((a) => a.profile != null).length,
    pagesFetched: universe.pagesFetched,
    integrityOk: true, integrityFailures: [],
    attempted: results.length,
    succeeded: results.length - failedRows.length,
    failed: failedRows.length,
    zeroState: results.filter((r) => r.error == null && r.states === 0).length,
    statesComputed: results.reduce((n, r) => n + r.states, 0),
    rowsStored: results.reduce((n, r) => n + (r.stored ?? 0), 0),
    accounts: results,
  });
}

/** Did the run do what it set out to do? Drives the HTTP status. */
export const runSucceeded = (r: RunReport): boolean =>
  r.outcome === "COMPLETED" && r.failed === 0;
