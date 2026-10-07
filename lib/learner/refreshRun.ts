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
import {
  studyDayKey, DEFAULT_DAY_START_HOUR, timezoneOf, isValidTimezone, DEFAULT_TIMEZONE,
} from "@/lib/flashcards/studyDay";

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

/**
 * Which kind of run this is, and therefore whether it may write history.
 *
 * ONLY THE DESIGNATED SCHEDULED RUN PRODUCES HISTORY. A manual run replaces
 * current state, which is replaceable by definition, and records nothing: I
 * ran the refresh by hand five times in one afternoon while building this, and
 * if each had produced a daily observation there would be five competing
 * candidates for "the" observation of that day and nothing in the data to say
 * which was meant.
 *
 * It is a server-side argument, never a query parameter. `?force=1` and
 * `?dry=1` are request flags because they only ever make a run do LESS; the
 * authority to write an immutable record is not something a caller gets to ask
 * for in a URL.
 */
export type RunMode = "SCHEDULED" | "MANUAL" | "DRY";

/** The history outcome for one account in a scheduled run. */
export type HistoryStatus = "RECORDED" | "ALREADY_RECORDED";

/**
 * The UTC calendar date of a scheduled cycle.
 *
 * THE OBSERVATION IDENTITY, and deliberately not the learner's study day. A
 * study day is a local label that can repeat across consecutive cycles when a
 * timezone is captured or changed, and keying on it would silently refuse the
 * second of two genuine observations.
 */
export const observationCycleDate = (runNow: Date): string => runNow.toISOString().slice(0, 10);

export interface AccountResult {
  userId: string;
  accountKind: string | null;
  studyDay: string;
  /** The zone actually used, and whether the learner supplied it. */
  timeZone: string;
  timeZoneSource: "PROFILE" | "DEFAULT_UTC";
  dayStartHour: number;
  states: number;
  stored: number | null;
  deleted: number | null;
  /** Null on a manual or dry run, which never touch history. */
  historyStatus: HistoryStatus | null;
  observationId: string | null;
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
  mode: RunMode;
  dryRun: boolean;
  /** Present only on a scheduled run: the cycle this run belongs to. */
  observationCycle: string | null;
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
  observationsRecorded: number;
  observationsAlreadyRecorded: number;
  historyRowsWritten: number;
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
  options: { now?: Date; mode?: RunMode; force?: boolean; runId?: string } = {},
): Promise<RunReport> {
  const startedAt = new Date();
  const runNow = options.now ?? startedAt;
  const runId = options.runId ?? `refresh_${runNow.toISOString()}`;
  const mode: RunMode = options.mode ?? "MANUAL";
  const dryRun = mode === "DRY";
  const cycle = mode === "SCHEDULED" ? observationCycleDate(runNow) : null;

  const base = {
    runId, runNow: runNow.toISOString(), startedAt: startedAt.toISOString(),
    mode, dryRun, observationCycle: cycle, modelVersion: CONCEPT_STATE_MODEL_VERSION,
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
        statesComputed: 0, rowsStored: 0,
        observationsRecorded: 0, observationsAlreadyRecorded: 0, historyRowsWritten: 0,
        accounts: [],
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
      statesComputed: 0, rowsStored: 0,
      observationsRecorded: 0, observationsAlreadyRecorded: 0, historyRowsWritten: 0,
      accounts: [],
    });
  }

  const accounts: Account[] = readyAccounts(universe);
  const bank = await loadConceptBank(db);
  const results: AccountResult[] = [];

  for (const account of accounts) {
    const dayStartHour = account.profile?.dayStartHour ?? DEFAULT_DAY_START_HOUR;
    const timeZone = timezoneOf(account.profile?.timeZone);
    // PROFILE means the learner told us. DEFAULT_UTC means we did not know and
    // fell back, a distinction that must survive into history, so nothing
    // downstream ever reads "UTC" as a statement about where someone lives.
    const timeZoneSource: "PROFILE" | "DEFAULT_UTC" =
      isValidTimezone(account.profile?.timeZone) ? "PROFILE" : "DEFAULT_UTC";
    const studyDay = studyDayKey(runNow, timeZone, dayStartHour);
    const row: AccountResult = {
      userId: account.id, accountKind: account.profile?.accountKind ?? null,
      studyDay, timeZone, timeZoneSource, dayStartHour,
      states: 0, stored: null, deleted: null,
      historyStatus: null, observationId: null, error: null, stage: null,
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
        const payload = toPayload(states);
        if (mode === "SCHEDULED") {
          // ONE TRANSACTION for current state and the observation. Writing
          // them separately would allow history to claim one state while the
          // current table held another, with no way to tell afterwards which
          // was the real observation.
          const { data, error } = await db.rpc("record_scheduled_observation", {
            p_user_id: account.id,
            p_cycle_date: cycle,
            p_study_day: studyDay,
            p_observed_at: runNow.toISOString(),
            p_timezone_used: timeZone,
            p_timezone_source: timeZoneSource,
            p_day_start_hour: dayStartHour,
            p_model_version: version,
            p_states: payload,
            p_refresh_run_id: runId,
          });
          if (error) throw new Error(error.message);
          const obs = data as {
            history_status: HistoryStatus; observation_id: string | null;
            history_rows_inserted: number; current_rows_final: number;
          };
          row.historyStatus = obs.history_status;
          row.observationId = obs.observation_id;
          row.stored = obs.current_rows_final;
          row.deleted = 0;
          if (obs.current_rows_final !== states.length) {
            throw new Error(`computed ${states.length} states, stored ${obs.current_rows_final}`);
          }
        } else {
          // Manual: current state only. Replaceable, and it records nothing.
          const { data, error } = await db.rpc("replace_learner_concept_states", {
            p_user_id: account.id,
            p_study_day: studyDay,
            p_computed_at: runNow.toISOString(),
            p_model_version: version,
            p_states: payload,
          });
          if (error) throw new Error(error.message);
          const write = data as WriteReport;
          row.stored = write.final_row_count;
          row.deleted = write.rows_deleted;
          if (write.final_row_count !== states.length) {
            throw new Error(`computed ${states.length} states, stored ${write.final_row_count}`);
          }
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
    observationsRecorded: results.filter((r) => r.historyStatus === "RECORDED").length,
    observationsAlreadyRecorded: results.filter((r) => r.historyStatus === "ALREADY_RECORDED").length,
    historyRowsWritten: results
      .filter((r) => r.historyStatus === "RECORDED").reduce((n, r) => n + r.states, 0),
    accounts: results,
  });
}

/** Did the run do what it set out to do? Drives the HTTP status. */
export const runSucceeded = (r: RunReport): boolean =>
  r.outcome === "COMPLETED" && r.failed === 0;
