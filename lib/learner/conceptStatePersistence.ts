// ─── The shape learner concept state takes in the database ──────────────────
//
// buildConceptStates() is pure and knows nothing about storage. This is the one
// place that translates between its output and a row of
// public.learner_concept_states, so the mapping exists once and can be tested
// rather than being written out again at every call site.
//
// THIS MODULE TOUCHES NO DATABASE. No client, no fetch, no environment. It
// converts values, which is what makes the round trip testable without a
// connection: a fixture goes through toRow and back and has to come out the
// same. The writer that actually performs the upsert belongs to the next step.
//
// THE ROW IS NOT A SECOND MODEL. Every column is a field the pure function
// already emits, plus three facts the function cannot know: which learner the
// state belongs to, which study day the computation was attributed to, and the
// instant the model was given as `now`. Nothing is derived here, nothing is
// rounded, and nothing is added. If a value needs computing, it is computed in
// conceptState.ts where it can be tested against the model's own contract.

import {
  type ConceptState,
  type CoverageState,
  type CoverageReason,
  type MemorySignal,
  type FreshnessSignal,
  type ConfidenceBand,
  type ConfidenceLimitedBy,
  type ApplicationSignal,
  type StateLabel,
} from "@/lib/learner/conceptState";

/**
 * One row of public.learner_concept_states.
 *
 * snake_case because that is what PostgREST returns, and the names are the
 * column names exactly: a typo in a key is then a typecheck failure rather
 * than a column that silently stays at its NOT NULL default — of which there
 * are none, deliberately, so a missing key is a write error instead.
 */
export interface ConceptStateRow {
  user_id: string;
  concept_id: string;

  coverage_state: CoverageState;
  coverage_reason: Exclude<CoverageReason, null> | null;

  memory_durability: number | null;
  memory_freshness: number | null;
  memory_signal: MemorySignal;
  freshness_signal: FreshnessSignal;
  memory_confidence: ConfidenceBand;
  memory_confidence_raw: number;
  memory_confidence_limited_by: ConfidenceLimitedBy;
  memory_items: number;
  memory_items_available: number;
  weak_card_count: number;

  application_signal: ApplicationSignal;
  application_confidence: ConfidenceBand;
  application_attempts: number;
  application_correct: number;
  application_misses_in_window: number;
  application_lower_bound: number | null;
  application_upper_bound: number | null;

  state_label: StateLabel;
  last_memory_evidence_at: string | null;
  last_application_evidence_at: string | null;

  model_version: string;
  /** 'YYYY-MM-DD', from studyDayKey(). Never a UTC calendar day. */
  study_day: string;
  computed_at: string;
}

/**
 * Every column, in the order the table declares them.
 *
 * Used by the writer's select list and asserted against the migration, so a
 * column added to the table without being mapped here cannot go unnoticed: a
 * state silently missing a field is the kind of defect that only shows up as a
 * wrong answer on a dashboard weeks later.
 */
export const CONCEPT_STATE_COLUMNS = [
  "user_id", "concept_id",
  "coverage_state", "coverage_reason",
  "memory_durability", "memory_freshness", "memory_signal", "freshness_signal",
  "memory_confidence", "memory_confidence_raw", "memory_confidence_limited_by",
  "memory_items", "memory_items_available", "weak_card_count",
  "application_signal", "application_confidence", "application_attempts",
  "application_correct", "application_misses_in_window",
  "application_lower_bound", "application_upper_bound",
  "state_label", "last_memory_evidence_at", "last_application_evidence_at",
  "model_version", "study_day", "computed_at",
] as const;

/** What the writer must supply that the pure model cannot know. */
export interface PersistenceContext {
  userId: string;
  /** From studyDayKey(now, profile.day_start_hour). */
  studyDay: string;
  /** The SAME `now` the model was given, as an ISO-8601 instant. */
  computedAt: string;
}

/**
 * ISO-8601 UTC, or null.
 *
 * TIMESTAMPTZ stores an instant, not the text it arrived as, so a timestamp
 * written and read back may be spelled differently while naming the same
 * moment: '+00:00' instead of 'Z', a different number of fractional digits.
 * Normalising both directions makes the round trip exact instead of
 * approximately right, and keeps it IDEMPOTENT — a state read from the
 * database and written back produces the identical row.
 *
 * It is also safe for the model, which compares these strings with `>` to find
 * the most recent one. Z-form ISO-8601 sorts lexicographically in time order;
 * mixed offsets would not.
 */
function instant(value: string | null): string | null {
  if (value == null) return null;
  const d = new Date(value);
  if (Number.isNaN(d.getTime())) {
    throw new Error(`conceptStatePersistence: not a timestamp: ${JSON.stringify(value)}`);
  }
  return d.toISOString();
}

/*
 * ─── WHAT A ROUND TRIP THROUGH THE REAL DATABASE DOES AND DOES NOT PRESERVE ──
 *
 * float8 columns hold the exact binary64 value. Measured after the migration
 * was applied: a row written with memory_durability = 0.1234567890123456 is
 * matched on disk by an equality filter for that exact literal, and an
 * application_upper_bound of 1.0000000000000002 is stored rather than clamped.
 *
 * BUT POSTGREST RENDERS float8 AT 15 SIGNIFICANT DIGITS. The same row read back
 * through the REST API arrives in JavaScript as 0.123456789012346, and that
 * upper bound arrives as plain 1. The value on disk is right; the value that
 * comes back over HTTP has lost its last bit.
 *
 * This cannot affect what the model decides, and that is not a hope, it is a
 * property of the interface: buildConceptStates reads exactly three fields off
 * `previous` — memorySignal, memoryConfidence and applicationSignal — and all
 * three are enum strings. No number in a stored state is ever read back into a
 * decision, so the durability band, the confidence band and the STRUGGLING flag
 * all stay stable across storage. A test perturbs every numeric field of
 * `previous` into nonsense and asserts the output does not move.
 *
 * What it does mean: do not compare a freshly computed state with one read back
 * from the database using strict equality on the numbers. Compare the fields
 * that carry meaning, or compare on disk.
 */

/** A computed state, as the row that stores it. */
export function toRow(state: ConceptState, ctx: PersistenceContext): ConceptStateRow {
  return {
    user_id: ctx.userId,
    concept_id: state.conceptId,

    coverage_state: state.coverageState,
    coverage_reason: state.coverageReason,

    memory_durability: state.memoryDurability,
    memory_freshness: state.memoryFreshness,
    memory_signal: state.memorySignal,
    freshness_signal: state.freshnessSignal,
    memory_confidence: state.memoryConfidence,
    memory_confidence_raw: state.memoryConfidenceRaw,
    memory_confidence_limited_by: state.memoryConfidenceLimitedBy,
    memory_items: state.memoryItems,
    memory_items_available: state.memoryItemsAvailable,
    weak_card_count: state.weakCardCount,

    application_signal: state.applicationSignal,
    application_confidence: state.applicationConfidence,
    application_attempts: state.applicationAttempts,
    application_correct: state.applicationCorrect,
    application_misses_in_window: state.applicationMissesInWindow,
    application_lower_bound: state.applicationLowerBound,
    application_upper_bound: state.applicationUpperBound,

    state_label: state.stateLabel,
    last_memory_evidence_at: instant(state.lastMemoryEvidenceAt),
    last_application_evidence_at: instant(state.lastApplicationEvidenceAt),

    model_version: state.modelVersion,
    study_day: ctx.studyDay,
    computed_at: instant(ctx.computedAt)!,
  };
}

/**
 * A stored row, as the state it represents.
 *
 * The result is a ConceptState and can be handed straight back to
 * buildConceptStates() as `previous`, which is the point: hysteresis on the
 * durability band, the confidence band and the STRUGGLING flag all read the
 * state the learner held last time, and that has to survive a round trip
 * through the database or every recomputation would start from scratch and the
 * bands would flicker.
 */
export function fromRow(row: ConceptStateRow): ConceptState {
  return {
    conceptId: row.concept_id,

    coverageState: row.coverage_state,
    coverageReason: row.coverage_reason,

    memoryDurability: row.memory_durability,
    memoryFreshness: row.memory_freshness,
    memorySignal: row.memory_signal,
    freshnessSignal: row.freshness_signal,
    memoryConfidence: row.memory_confidence,
    memoryConfidenceRaw: row.memory_confidence_raw,
    memoryConfidenceLimitedBy: row.memory_confidence_limited_by,
    memoryItems: row.memory_items,
    memoryItemsAvailable: row.memory_items_available,
    weakCardCount: row.weak_card_count,

    applicationSignal: row.application_signal,
    applicationConfidence: row.application_confidence,
    applicationAttempts: row.application_attempts,
    applicationCorrect: row.application_correct,
    applicationMissesInWindow: row.application_misses_in_window,
    applicationLowerBound: row.application_lower_bound,
    applicationUpperBound: row.application_upper_bound,

    stateLabel: row.state_label,
    lastMemoryEvidenceAt: instant(row.last_memory_evidence_at),
    lastApplicationEvidenceAt: instant(row.last_application_evidence_at),

    modelVersion: row.model_version,
  };
}

/** Every state for one learner, as rows. */
export function toRows(states: ConceptState[], ctx: PersistenceContext): ConceptStateRow[] {
  return states.map((s) => toRow(s, ctx));
}

/*
 * ─── THE WRITER CONTRACT ──────────────────────────────────────────────────
 *
 * Not implemented here. This is what the next step has to satisfy, written
 * down now so the schema can be reviewed against it rather than after it.
 *
 * 1. SERVICE TOOLING ONLY. The table grants authenticated no write privilege
 *    and carries no write policy, so the writer runs with the service role,
 *    the way the account reset and the weekly report cron already do. A route
 *    that runs as the student, which is how learner_state_snapshots is
 *    written, CANNOT write this table, and that is deliberate: a student who
 *    can POST their own concept state can tell the product they have mastered
 *    anything.
 *
 * 2. UPSERT ON (user_id, concept_id). One current row per pair. A recompute
 *    replaces the row; it never adds a second one.
 *
 * 3. DELETE WHAT NO LONGER APPEARS. The model is sparse: a concept whose last
 *    eligible card mapping is removed, or whose evidence is reclassified, stops
 *    appearing in the output. Its stored row must go, because a stale row is
 *    indistinguishable from a current one — nothing on the row says "this was
 *    true in September". So the write is: upsert every state in the output,
 *    then delete this learner's rows for concepts NOT in it.
 *
 * 4. BOTH HALVES ATOMICALLY. Upserting and then failing to delete leaves state
 *    the model no longer believes; deleting and then failing to upsert leaves a
 *    learner looking like a beginner. PostgREST cannot span two statements in
 *    one transaction, so this needs a single database function, or a staged
 *    write that is idempotent enough to retry. The decision belongs to the next
 *    step, where it can be measured against the real row counts.
 *
 * 5. IDEMPOTENT FOR IDENTICAL INPUT. The same evidence, the same
 *    model_version and the same `now` must produce the same rows, so running
 *    the writer twice in a morning is a no-op rather than a second version of
 *    the truth. The model is already deterministic and sorts its output; this
 *    module normalises timestamps; so the remaining requirement is only that
 *    the writer passes the SAME `now` it gave the model, never a fresh
 *    Date.now() at insert time. That is why computed_at has no database
 *    default to fall back on.
 *
 * 6. NEVER TOUCH EVIDENCE. The writer reads flashcard_user_state,
 *    question_attempts, flashcard_concepts, question_concepts, flashcards and
 *    concepts, and writes exactly one table. No scheduler row, no review, no
 *    attempt and no mapping is modified by computing a state.
 */
