// ─── Computing and storing one learner's concept state ──────────────────────
//
// The production path, end to end:
//
//   evidence  ->  buildConceptStates()  ->  payload  ->  one atomic RPC
//
// Every interesting decision was made somewhere else and this module makes
// none of them. It loads, it calls the pure function, it serialises, it calls
// the writer, and it checks that the database did what it was told. It does
// not score anything, does not touch the MCAT score predictor, does not write
// to any source table, and generates no prose.
//
// ONE CLOCK. `now` is captured once by the caller and passed to the model and
// to the writer unchanged. Calling `new Date()` a second time during
// persistence would stamp rows with an instant the model never saw, and a day
// recomputed later would not reproduce. That is also why computed_at has no
// database default to fall back on.
//
// ONE STUDY DAY, resolved from the learner's own profile. Not a UTC calendar
// day: this project has already shipped that bug once and watched an evening's
// reviews land on tomorrow.

import type { SupabaseClient } from "@supabase/supabase-js";
import {
  buildConceptStates, CONCEPT_STATE_MODEL_VERSION, type ConceptState,
} from "@/lib/learner/conceptState";
import { loadConceptEvidence, type EvidenceCounts } from "@/lib/learner/conceptEvidence";
import {
  toPayload, singleModelVersion, fromRow, CONCEPT_STATE_COLUMNS,
  type ConceptStateRow,
} from "@/lib/learner/conceptStatePersistence";
import { studyDayKey, DEFAULT_DAY_START_HOUR, timezoneOf } from "@/lib/flashcards/studyDay";

/** What the writer reports back about what it actually did. */
export interface WriteReport {
  user_id: string;
  rows_received: number;
  rows_upserted: number;
  rows_deleted: number;
  final_row_count: number;
  model_version: string;
  study_day: string;
  computed_at: string;
}

export interface ComputeReport {
  userId: string;
  studyDay: string;
  computedAt: string;
  modelVersion: string;
  dayStartHour: number;
  timeZone: string;
  counts: EvidenceCounts;
  /** States the model emitted. Sparse: concepts with no evidence are absent. */
  states: ConceptState[];
  previousCount: number;
  /** Absent on a dry run, which is the point of a dry run. */
  write: WriteReport | null;
}

/** The learner's stored current states, as the model's own `previous`. */
export async function loadPreviousStates(
  db: SupabaseClient, userId: string,
): Promise<ConceptState[]> {
  const out: ConceptStateRow[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await db
      .from("learner_concept_states")
      .select(CONCEPT_STATE_COLUMNS.join(", "))
      .eq("user_id", userId)
      .order("concept_id", { ascending: true })
      .range(from, from + 999);
    if (error) throw new Error(`computeConceptStates: loading previous states: ${error.message}`);
    if (!data || data.length === 0) break;
    out.push(...(data as unknown as ConceptStateRow[]));
    if (data.length < 1000) break;
  }
  // Through the canonical adapter, never field by field. The model reads the
  // stored ENUM state for hysteresis — the durability band, the confidence
  // band and the STRUGGLING flag — and reconstructing those from the numbers
  // would be a second, differently-rounded copy of the band logic.
  return out.map(fromRow);
}

/** The learner's own day boundary, or the project default if unset. */
async function resolveDayContext(
  db: SupabaseClient, userId: string,
): Promise<{ dayStartHour: number; timeZone: string }> {
  const { data, error } = await db
    .from("profiles").select("day_start_hour, timezone").eq("id", userId).maybeSingle();
  if (error) throw new Error(`computeConceptStates: reading profile: ${error.message}`);
  return {
    dayStartHour: data?.day_start_hour ?? DEFAULT_DAY_START_HOUR,
    // THE LEARNER'S ZONE, NOT THE SERVER'S. timezoneOf decides in one place
    // what a missing one means, so no call site invents its own answer.
    timeZone: timezoneOf(data?.timezone),
  };
}

/**
 * Compute one learner's current concept state, and store it.
 *
 * With `dryRun`, everything happens except the write, and the report carries
 * the states the writer would have been given. That is how a backfill gets
 * inspected before it exists rather than after.
 */
export async function computeAndPersistLearnerConceptStates(
  db: SupabaseClient,
  userId: string,
  now: Date,
  options: { dryRun?: boolean } = {},
): Promise<ComputeReport> {
  const computedAt = now.toISOString();
  const { dayStartHour, timeZone } = await resolveDayContext(db, userId);
  const studyDay = studyDayKey(now, timeZone, dayStartHour);

  const { evidence, counts } = await loadConceptEvidence(db, userId);
  const previous = await loadPreviousStates(db, userId);
  const states = buildConceptStates(evidence, previous.length ? previous : null, now);

  // The model stamps its own version on every state; the writer takes one for
  // the batch. These have to be the same fact, so a batch that disagreed with
  // itself is refused here rather than resolved by picking one.
  const version = singleModelVersion(states) ?? CONCEPT_STATE_MODEL_VERSION;

  const report: ComputeReport = {
    userId, studyDay, computedAt, modelVersion: version, dayStartHour, timeZone,
    counts, states, previousCount: previous.length, write: null,
  };
  if (options.dryRun) return report;

  const { data, error } = await db.rpc("replace_learner_concept_states", {
    p_user_id: userId,
    p_study_day: studyDay,
    p_computed_at: computedAt,
    p_model_version: version,
    p_states: toPayload(states),
  });
  if (error) throw new Error(`computeConceptStates: the writer refused: ${error.message}`);

  const write = data as WriteReport;
  // The writer returns what the database did, so check it against what was
  // asked rather than treating a 200 as agreement.
  if (write.rows_received !== states.length) {
    throw new Error(`computeConceptStates: sent ${states.length} states, the writer saw ${write.rows_received}`);
  }
  if (write.final_row_count !== states.length) {
    throw new Error(`computeConceptStates: ${states.length} states computed, ${write.final_row_count} rows stored`);
  }
  report.write = write;
  return report;
}

/** Counts of one categorical field across a set of states, for reporting. */
export function distribution<K extends keyof ConceptState>(
  states: ConceptState[], field: K,
): Record<string, number> {
  const out: Record<string, number> = {};
  for (const s of states) {
    const key = String(s[field]);
    out[key] = (out[key] ?? 0) + 1;
  }
  return out;
}
