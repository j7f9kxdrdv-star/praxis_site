// ─── Learner concept states: memory and application, kept apart ────────────
//
// For one canonical CONTENT concept this answers two separate questions:
//
//   MEMORY        what the learner can retrieve, from flashcard scheduler state
//   APPLICATION   what the learner can correctly use, from question attempts
//
// They are never blended. The product line this exists to support, "you
// remember this but you are struggling to apply it", only means anything if the
// two can disagree, and a single score cannot disagree with itself.
//
// WHY MEMORY HAS TWO COMPONENTS. Durability and freshness answer different
// questions and move at different speeds. Calibration against live data showed
// why that matters: the learner with 580 reviewed cards scored HIGHER on
// retrievability than the learner with 7,146, purely because they had studied
// more recently. A single memory number would have told the learner who had
// done the most work that their memory was the weakest. Durability is what was
// built; freshness is what is accessible today.
//
// WHY APPLICATION IS DELIBERATELY TIMID. In production no learner has ever
// reached five first attempts on a single concept. 618 first attempts exist
// across 2,681 questions and 445 question-bearing concepts. So this axis can
// report that misses happened and can make a negative claim at depth, and it
// makes no positive competence claim at all in v1. A positive claim would be an
// untested code path that first fires for a real student weeks before an exam.
//
// EVERY THRESHOLD HERE IS PROVISIONAL. None was fitted to student outcomes,
// because none exist at concept granularity. The version says so.

import { FSRS_PARAMS } from "@/lib/flashcards/fsrsScheduler";
import { forgetting_curve } from "ts-fsrs";

export const CONCEPT_STATE_MODEL_VERSION = "2.0.0-provisional";

/**
 * Statuses a learner may hold state against.
 *
 * A NAMED POSITIVE SET, not `!== "DEPRECATED"`. The negation would admit a
 * future DRAFT or PROPOSED concept silently; this refuses anything not listed.
 *
 * The literal is `ACTIVE_SEED` because that is what production actually holds.
 * There is no `ACTIVE` row in the database: filtering on it would have matched
 * nothing and computed zero states for every learner, with no error.
 */
export const LEARNER_FACING_STATUSES: ReadonlySet<string> = new Set(["ACTIVE_SEED"]);

/** Days of stability at which a memory is treated as fully durable. */
export const DURABILITY_HORIZON_DAYS = 30;
/** d >= this is DURABLE. At H=30 this is a stability of 5.61 days. */
export const DURABLE_FLOOR = 0.55;
/** d < this is THIN, and a card below it is a weak card. At H=30, 1.80 days. */
export const THIN_CEILING = 0.30;
export const FRESH_FLOOR = 0.80;
export const COOLING_FLOOR = 0.60;

export const MEMORY_CONFIDENCE_HIGH = 0.70;
export const MEMORY_CONFIDENCE_MODERATE = 0.40;
/** Applied to bands, never to the stored value. Matches topicState's margin. */
export const HYSTERESIS = 0.05;

/** Below this many eligible first attempts the application axis says nothing. */
export const APPLICATION_FLOOR = 3;
/** The observation reads only this many most-recent attempts. See below. */
export const OBSERVATION_WINDOW = 5;
/** Misses inside the window that trigger the observation. */
export const OBSERVATION_MISSES = 2;
/** Wilson UPPER bound below this is a struggle. 0.65 is MCAT-par. */
export const STRUGGLING_ENTER = 0.65;
/** And it clears here, a 0.05 margin above, mirroring PRIORITY_ENTER/EXIT. */
export const STRUGGLING_EXIT = 0.70;

export type Role = "PRIMARY" | "SECONDARY";
export type EvidenceStrength = "UNREVIEWED" | "STANDARD" | "SELF_CONTAINED" | "RECOGNITION_ONLY";
/** Only these two are evidence. The others are excluded, not down-weighted. */
const ELIGIBLE_STRENGTHS: ReadonlySet<EvidenceStrength> = new Set(["UNREVIEWED", "STANDARD"]);

export type MemorySignal = "DURABLE" | "BUILDING" | "THIN" | "INSUFFICIENT";
export type FreshnessSignal = "FRESH" | "COOLING" | "STALE" | "INSUFFICIENT";
export type ApplicationSignal = "STRUGGLING" | "MISSES_OBSERVED" | "NOT_ESTABLISHED" | "INSUFFICIENT";
export type ConfidenceBand = "LOW" | "MODERATE" | "HIGH";
export type CoverageState = "BOTH_MODALITIES" | "MEMORY_ONLY" | "QUESTION_ONLY" | "NO_EVIDENCE";
export type CoverageReason =
  | "BANK_HAS_NO_QUESTIONS" | "BANK_HAS_NO_CARDS"
  | "LEARNER_HAS_NOT_ATTEMPTED" | "LEARNER_HAS_NOT_REVIEWED" | null;
export type ConfidenceLimitedBy = "LEARNER_COVERAGE" | "BANK_COVERAGE" | "ROLE" | "NONE";
export type StateLabel =
  | "DURABLE_RECALL_APPLICATION_MISSES" | "STALE_RECALL_APPLICATION_MISSES"
  | "THIN_RECALL_APPLICATION_MISSES" | "APPLICATION_MISSES_MEMORY_UNKNOWN"
  | "MEMORY_DURABLE" | "MEMORY_DURABLE_STALE" | "MEMORY_BUILDING" | "MEMORY_THIN"
  | "INSUFFICIENT_EVIDENCE";

export interface ConceptRow { id: string; objectType: string; status: string; }
export interface FlashcardRow { id: string; clozeCount: number; }

export interface CardMapping {
  conceptId: string;
  flashcardId: string;
  role: Role;
  /** null means every cloze on the card. An array scopes the mapping. */
  clozeIndices: number[] | null;
}

export interface SchedulerRow {
  flashcardId: string;
  clozeIndex: number;
  stability: number;
  reps: number;
  suspended: boolean;
  lastReviewedAt: string | null;
}

export interface QuestionMapping {
  conceptId: string;
  questionId: string;
  role: Role;
  evidenceStrength: EvidenceStrength;
}

export interface AttemptRow {
  id: string;
  questionId: string;
  isCorrect: boolean;
  /** null counts as a first attempt: legacy rows predate the flag. */
  isFirstAttempt: boolean | null;
  createdAt: string;
}

export interface ConceptEvidence {
  concepts: ConceptRow[];
  flashcards: FlashcardRow[];
  cardMappings: CardMapping[];
  schedulerRows: SchedulerRow[];
  questionMappings: QuestionMapping[];
  attempts: AttemptRow[];
}

export interface ConceptState {
  conceptId: string;
  coverageState: CoverageState;
  coverageReason: CoverageReason;

  memoryDurability: number | null;
  memoryFreshness: number | null;
  memorySignal: MemorySignal;
  freshnessSignal: FreshnessSignal;
  memoryConfidence: ConfidenceBand;
  memoryConfidenceRaw: number;
  memoryConfidenceLimitedBy: ConfidenceLimitedBy;
  memoryItems: number;
  memoryItemsAvailable: number;
  weakCardCount: number;

  applicationSignal: ApplicationSignal;
  applicationConfidence: ConfidenceBand;
  applicationAttempts: number;
  applicationCorrect: number;
  applicationMissesInWindow: number;
  applicationLowerBound: number | null;
  applicationUpperBound: number | null;

  stateLabel: StateLabel;
  lastMemoryEvidenceAt: string | null;
  lastApplicationEvidenceAt: string | null;
  modelVersion: string;
}

const clip = (x: number, lo: number, hi: number) => Math.max(lo, Math.min(hi, x));
const mean = (xs: number[]) => xs.reduce((a, b) => a + b, 0) / xs.length;

/**
 * Both ends of the Wilson score interval.
 *
 * The LOWER bound answers "how good could this plausibly be, read
 * pessimistically", which is what positive claims need and what
 * `topicState.wilsonLowerBound` already computes. The UPPER bound answers "how
 * good could this be, read as favourably as the evidence allows", which is what
 * a NEGATIVE claim needs: if even the optimistic end sits below MCAT-par, the
 * learner is struggling whatever luck they had.
 *
 * A test asserts the lower bound here is identical to topicState's, so the two
 * cannot drift into disagreeing about the same statistic.
 */
export function wilsonInterval(correct: number, attempts: number): [number, number] {
  if (attempts <= 0) return [0, 0];
  const z = 1.96;
  const p = correct / attempts;
  const denom = 1 + (z * z) / attempts;
  const centre = p + (z * z) / (2 * attempts);
  const margin = z * Math.sqrt((p * (1 - p) + (z * z) / (4 * attempts)) / attempts);
  return [(centre - margin) / denom, (centre + margin) / denom];
}

/** Stability in days to a 0..1 durability, log-compressed against the horizon. */
export function durabilityOf(stabilityDays: number): number {
  const s = Math.max(0, stabilityDays);
  return clip(Math.log(1 + s) / Math.log(1 + DURABILITY_HORIZON_DAYS), 0, 1);
}

/**
 * Retrievability right now, from FSRS's own forgetting curve.
 *
 * `forgetting_curve(w, elapsed, stability)` is the function `get_retrievability`
 * calls internally; using it directly keeps this pure and avoids fabricating a
 * Card object whose unused fields would be invented. A test asserts the two
 * agree. No calibration factor is applied: the measured correction living in
 * lib/insights/forecast.ts was fit almost entirely on an internal QA account,
 * and students run the other way, above 1.0 at every measurable gap.
 */
export function freshnessOf(stabilityDays: number, lastReviewedAt: string | null, now: Date): number {
  if (!lastReviewedAt) return 0;
  const elapsed = Math.max(0, (now.getTime() - new Date(lastReviewedAt).getTime()) / 86_400_000);
  return clip(forgetting_curve(FSRS_PARAMS.w, elapsed, Math.max(0.1, stabilityDays)), 0, 1);
}

const DURABILITY_LADDER = ["THIN", "BUILDING", "DURABLE"] as const;
type DurabilityBand = (typeof DURABILITY_LADDER)[number];
const DURABILITY_FLOORS: Record<DurabilityBand, number> = {
  THIN: 0, BUILDING: THIN_CEILING, DURABLE: DURABLE_FLOOR,
};
const bandOfDurability = (d: number): DurabilityBand =>
  d >= DURABLE_FLOOR ? "DURABLE" : d >= THIN_CEILING ? "BUILDING" : "THIN";

/**
 * The band, given the one held before.
 *
 * Walks ONE RUNG AT A TIME in the direction of travel. The alternative, testing
 * only the target band's margin, sends a concept BACKWARDS on a multi-band
 * jump: more evidence, worse state. topicState paid for that bug once and the
 * fix is copied here rather than rediscovered.
 */
function stickyBand(d: number, previous: DurabilityBand | null): DurabilityBand {
  const raw = bandOfDurability(d);
  if (previous == null || raw === previous) return raw;
  const rank = (b: DurabilityBand) => DURABILITY_LADDER.indexOf(b);
  let result = previous;
  if (rank(raw) > rank(previous)) {
    for (let i = rank(previous) + 1; i < DURABILITY_LADDER.length; i++) {
      if (d >= DURABILITY_FLOORS[DURABILITY_LADDER[i]] + HYSTERESIS) result = DURABILITY_LADDER[i];
      else break;
    }
    return result;
  }
  for (let i = rank(previous); i > 0; i--) {
    if (d < DURABILITY_FLOORS[DURABILITY_LADDER[i]] - HYSTERESIS) result = DURABILITY_LADDER[i - 1];
    else break;
  }
  return result;
}

const confidenceBandOf = (raw: number): ConfidenceBand =>
  raw >= MEMORY_CONFIDENCE_HIGH ? "HIGH" : raw >= MEMORY_CONFIDENCE_MODERATE ? "MODERATE" : "LOW";

const CONFIDENCE_RANK: Record<ConfidenceBand, number> = { LOW: 0, MODERATE: 1, HIGH: 2 };

/** Confidence with a margin, so a concept sitting on a boundary cannot flicker. */
function stickyConfidence(raw: number, previous: ConfidenceBand | null): ConfidenceBand {
  const band = confidenceBandOf(raw);
  if (previous == null || band === previous) return band;
  if (CONFIDENCE_RANK[band] > CONFIDENCE_RANK[previous]) {
    if (band === "HIGH" && raw < MEMORY_CONFIDENCE_HIGH + HYSTERESIS) return previous;
    if (band === "MODERATE" && raw < MEMORY_CONFIDENCE_MODERATE + HYSTERESIS) return previous;
    return band;
  }
  if (previous === "HIGH" && raw >= MEMORY_CONFIDENCE_HIGH - HYSTERESIS) return previous;
  if (previous === "MODERATE" && raw >= MEMORY_CONFIDENCE_MODERATE - HYSTERESIS) return previous;
  return band;
}

/** Eligible by the project's existing rule: only an explicit false is a repeat. */
export const isEligibleAttempt = (a: AttemptRow): boolean => a.isFirstAttempt !== false;

interface CardContribution { flashcardId: string; durability: number; freshness: number; role: Role; lastReviewedAt: string | null; }

/**
 * Build one state per learner-facing CONTENT concept that has any evidence.
 *
 * PURE. No database, no clock, no environment, no account_kind. `now` is an
 * explicit argument, which is what makes a historical day reproducible: the
 * same evidence and the same `now` always return the same states.
 *
 * Concepts with no learner evidence at all are omitted, not returned as
 * NO_EVIDENCE rows. Storage is sparse and absence is the signal.
 */
export function buildConceptStates(
  evidence: ConceptEvidence,
  previous: ConceptState[] | null,
  now: Date,
): ConceptState[] {
  const eligibleConcepts = evidence.concepts.filter(
    (c) => c.objectType === "CONTENT" && LEARNER_FACING_STATUSES.has(c.status),
  );
  const conceptIds = new Set(eligibleConcepts.map((c) => c.id));
  const clozeCount = new Map(evidence.flashcards.map((f) => [f.id, f.clozeCount]));
  const prior = new Map((previous ?? []).map((p) => [p.conceptId, p]));

  // Scheduler rows by card, filtered once. An orphan row whose cloze_index
  // exceeds the card's current cloze_count is a blank the learner can no longer
  // be shown: 12 such rows exist in production, one at stability 0.54, and
  // including it would score a concept on a question that no longer renders.
  const rowsByCard = new Map<string, SchedulerRow[]>();
  for (const r of evidence.schedulerRows) {
    const count = clozeCount.get(r.flashcardId);
    if (count == null) continue;
    if (r.reps <= 0 || r.suspended) continue;
    if (!Number.isInteger(r.clozeIndex) || r.clozeIndex < 1 || r.clozeIndex > count) continue;
    const list = rowsByCard.get(r.flashcardId);
    if (list) list.push(r); else rowsByCard.set(r.flashcardId, [r]);
  }

  const bankCards = new Map<string, Set<string>>();
  for (const m of evidence.cardMappings) {
    if (!conceptIds.has(m.conceptId)) continue;
    const s = bankCards.get(m.conceptId) ?? new Set<string>();
    s.add(m.flashcardId);
    bankCards.set(m.conceptId, s);
  }
  const bankQuestions = new Map<string, Set<string>>();
  for (const m of evidence.questionMappings) {
    if (!conceptIds.has(m.conceptId)) continue;
    const s = bankQuestions.get(m.conceptId) ?? new Set<string>();
    s.add(m.questionId);
    bankQuestions.set(m.conceptId, s);
  }

  // ── Memory contributions, one value per (concept, card) ──────────────────
  const contributions = new Map<string, CardContribution[]>();
  for (const m of evidence.cardMappings) {
    if (!conceptIds.has(m.conceptId)) continue;
    const rows = rowsByCard.get(m.flashcardId);
    if (!rows || rows.length === 0) continue;
    const inScope = m.clozeIndices == null
      ? rows
      : rows.filter((r) => m.clozeIndices!.includes(r.clozeIndex));
    if (inScope.length === 0) continue;

    // The WEAKEST in-scope cloze supplies the card's value, on both axes. A card
    // you can only half produce is not known, and one card gets one vote however
    // many blanks it carries: a 7-cloze card must not outweigh seven cards.
    const durability = Math.min(...inScope.map((r) => durabilityOf(r.stability)));
    const freshness = Math.min(...inScope.map((r) => freshnessOf(r.stability, r.lastReviewedAt, now)));
    const lastReviewedAt = inScope.reduce<string | null>(
      (acc, r) => (r.lastReviewedAt && (!acc || r.lastReviewedAt > acc) ? r.lastReviewedAt : acc), null);

    const list = contributions.get(m.conceptId) ?? [];
    list.push({ flashcardId: m.flashcardId, durability, freshness, role: m.role, lastReviewedAt });
    contributions.set(m.conceptId, list);
  }

  // ── Application evidence, one bucket per concept ─────────────────────────
  const attemptsById = new Map<string, AttemptRow[]>();
  for (const a of evidence.attempts) {
    if (!isEligibleAttempt(a)) continue;
    const list = attemptsById.get(a.questionId);
    if (list) list.push(a); else attemptsById.set(a.questionId, [a]);
  }
  interface AppRow { attempt: AttemptRow; role: Role; }
  const appByConcept = new Map<string, AppRow[]>();
  for (const m of evidence.questionMappings) {
    if (!conceptIds.has(m.conceptId)) continue;
    if (!ELIGIBLE_STRENGTHS.has(m.evidenceStrength)) continue;
    for (const attempt of attemptsById.get(m.questionId) ?? []) {
      const list = appByConcept.get(m.conceptId) ?? [];
      list.push({ attempt, role: m.role });
      appByConcept.set(m.conceptId, list);
    }
  }

  const states: ConceptState[] = [];
  for (const concept of eligibleConcepts) {
    const cards = contributions.get(concept.id) ?? [];
    const app = (appByConcept.get(concept.id) ?? [])
      // Deterministic even when timestamps tie: id breaks the tie, never insertion order.
      .slice()
      .sort((x, y) =>
        x.attempt.createdAt.localeCompare(y.attempt.createdAt) || x.attempt.id.localeCompare(y.attempt.id));

    if (cards.length === 0 && app.length === 0) continue; // sparse: absence is NO_EVIDENCE
    const prev = prior.get(concept.id) ?? null;

    // ── Memory ──────────────────────────────────────────────────────────
    const n = cards.length;
    const available = bankCards.get(concept.id)?.size ?? n;
    const durability = n > 0 ? mean(cards.map((c) => c.durability)) : null;
    const freshness = n > 0 ? mean(cards.map((c) => c.freshness)) : null;
    const weakCardCount = cards.filter((c) => c.durability < THIN_CEILING).length;
    const allSecondary = n > 0 && cards.every((c) => c.role === "SECONDARY");
    const breadth = available > 0 ? Math.min(1, n / available) : 1;
    const roleCap = allSecondary ? 0.6 : 1;
    const rawConfidence = n === 0 ? 0 : Math.min((1 - Math.exp(-n / 3)) * (0.5 + 0.5 * breadth), roleCap);
    const memoryConfidence = n === 0 ? "LOW" : stickyConfidence(rawConfidence, prev?.memoryConfidence ?? null);

    let limitedBy: ConfidenceLimitedBy = "NONE";
    if (memoryConfidence !== "HIGH" && n > 0) {
      if (allSecondary && roleCap <= rawConfidence) limitedBy = "ROLE";
      else if (n < available) limitedBy = "LEARNER_COVERAGE";
      else limitedBy = "BANK_COVERAGE";
    }

    // THE SIGNAL REPORTS WHAT THE EVIDENCE SAYS. CONFIDENCE SAYS HOW FAR TO
    // TRUST IT. Those are different questions and the fields stay separate: a
    // concept with one reviewed card at d = 0.20 really is THIN on the evidence
    // we have, and saying INSUFFICIENT would throw away a real measurement to
    // express a doubt that memoryConfidence already carries.
    //
    // INSUFFICIENT here means exactly one thing: no eligible memory evidence.
    // It is not a synonym for low confidence.
    //
    // The conservative gate lives on stateLabel instead, which is the
    // interpretation layer. This mirrors the application axis, where
    // MISSES_OBSERVED may be reported before any competence claim is allowed.
    const band = durability == null ? null : stickyBand(durability, prevDurabilityBand(prev));
    const memorySignal: MemorySignal = durability == null ? "INSUFFICIENT" : band!;
    const freshnessSignal: FreshnessSignal =
      freshness == null
        ? "INSUFFICIENT"
        : freshness >= FRESH_FLOOR ? "FRESH" : freshness >= COOLING_FLOOR ? "COOLING" : "STALE";

    // ── Application ─────────────────────────────────────────────────────
    const attempts = app.length;
    const correct = app.filter((r) => r.attempt.isCorrect).length;
    const window = app.slice(Math.max(0, attempts - OBSERVATION_WINDOW));
    const missesInWindow = window.filter((r) => !r.attempt.isCorrect).length;
    const [lower, upper] = attempts > 0 ? wilsonInterval(correct, attempts) : [null, null];

    // STRUGGLING is a negative claim, so it uses the UPPER bound: even read as
    // favourably as the evidence allows, the learner sits below MCAT-par. It
    // clears at a 0.05 margin above, so it cannot flicker.
    const strugglingEntry = attempts >= 5 && upper != null && upper < STRUGGLING_ENTER;
    const wasStruggling = prev?.applicationSignal === "STRUGGLING";
    const struggling = attempts >= 5 && upper != null
      ? (wasStruggling ? upper < STRUGGLING_EXIT : strugglingEntry)
      : false;
    // The observation reads only the recent window, which is what makes it
    // clearable. A lifetime miss count can only ever rise, so a learner who
    // missed twice in January could never shed the flag.
    const observed = window.length >= APPLICATION_FLOOR && missesInWindow >= OBSERVATION_MISSES;

    const applicationSignal: ApplicationSignal =
      attempts < APPLICATION_FLOOR ? "INSUFFICIENT"
        : struggling ? "STRUGGLING"
        : observed ? "MISSES_OBSERVED"
        : "NOT_ESTABLISHED";

    const appAllSecondary = attempts > 0 && app.every((r) => r.role === "SECONDARY");
    let applicationConfidence: ConfidenceBand =
      attempts >= 12 ? "HIGH" : attempts >= 5 ? "MODERATE" : "LOW";
    // All-SECONDARY application evidence may not reach HIGH. The discrete
    // equivalent of the memory side's role cap; no numeric 0.6 is invented.
    if (appAllSecondary && applicationConfidence === "HIGH") applicationConfidence = "MODERATE";

    // ── Coverage ────────────────────────────────────────────────────────
    const bankHasCards = (bankCards.get(concept.id)?.size ?? 0) > 0;
    const bankHasQuestions = (bankQuestions.get(concept.id)?.size ?? 0) > 0;
    let coverageState: CoverageState;
    let coverageReason: CoverageReason = null;
    if (n > 0 && attempts > 0) coverageState = "BOTH_MODALITIES";
    else if (n > 0) {
      coverageState = "MEMORY_ONLY";
      coverageReason = bankHasQuestions ? "LEARNER_HAS_NOT_ATTEMPTED" : "BANK_HAS_NO_QUESTIONS";
    } else if (attempts > 0) {
      coverageState = "QUESTION_ONLY";
      coverageReason = bankHasCards ? "LEARNER_HAS_NOT_REVIEWED" : "BANK_HAS_NO_CARDS";
    } else coverageState = "NO_EVIDENCE";

    // ── Label ───────────────────────────────────────────────────────────
    // A cross-axis label needs an ESTABLISHED negative reading, which needs
    // MODERATE application confidence. An observation at LOW confidence is a
    // countable fact and may be reported, but it is not a competence claim.
    const crossAxis = applicationSignal === "STRUGGLING"
      && CONFIDENCE_RANK[applicationConfidence] >= CONFIDENCE_RANK.MODERATE;
    // A label is a claim about the learner, so it needs both a measurement and
    // enough evidence to generalise it. LOW confidence withholds the claim
    // while memorySignal keeps reporting the observation.
    const memoryClaimable = memorySignal !== "INSUFFICIENT" && memoryConfidence !== "LOW";
    let stateLabel: StateLabel;
    if (crossAxis) {
      stateLabel = !memoryClaimable ? "APPLICATION_MISSES_MEMORY_UNKNOWN"
        : memorySignal === "DURABLE"
          ? (freshnessSignal === "STALE" ? "STALE_RECALL_APPLICATION_MISSES" : "DURABLE_RECALL_APPLICATION_MISSES")
          : "THIN_RECALL_APPLICATION_MISSES";
    } else if (!memoryClaimable) {
      stateLabel = "INSUFFICIENT_EVIDENCE";
    } else if (memorySignal === "DURABLE") {
      stateLabel = freshnessSignal === "STALE" ? "MEMORY_DURABLE_STALE" : "MEMORY_DURABLE";
    } else stateLabel = memorySignal === "BUILDING" ? "MEMORY_BUILDING" : "MEMORY_THIN";

    states.push({
      conceptId: concept.id,
      coverageState, coverageReason,
      memoryDurability: durability, memoryFreshness: freshness,
      memorySignal, freshnessSignal,
      memoryConfidence, memoryConfidenceRaw: rawConfidence, memoryConfidenceLimitedBy: limitedBy,
      memoryItems: n, memoryItemsAvailable: available, weakCardCount,
      applicationSignal, applicationConfidence,
      applicationAttempts: attempts, applicationCorrect: correct,
      applicationMissesInWindow: missesInWindow,
      applicationLowerBound: lower, applicationUpperBound: upper,
      stateLabel,
      lastMemoryEvidenceAt: cards.reduce<string | null>(
        (acc, c) => (c.lastReviewedAt && (!acc || c.lastReviewedAt > acc) ? c.lastReviewedAt : acc), null),
      lastApplicationEvidenceAt: app.length ? app[app.length - 1].attempt.createdAt : null,
      modelVersion: CONCEPT_STATE_MODEL_VERSION,
    });
  }

  // Stable output order, so two runs are byte-identical and a diff is meaningful.
  return states.sort((a, b) => a.conceptId.localeCompare(b.conceptId));
}

/**
 * The durability band a previous state was in.
 *
 * Read back from the SIGNAL, which now carries the real band at every
 * confidence level, so hysteresis survives a spell at LOW confidence rather
 * than resetting when the band stops being reported.
 *
 * INSUFFICIENT still maps to null: a concept with no memory evidence last time
 * has no band to be sticky about, and treating it as THIN would make the first
 * real measurement look like a climb.
 */
function prevDurabilityBand(prev: ConceptState | null): DurabilityBand | null {
  if (!prev) return null;
  if (prev.memorySignal === "INSUFFICIENT") return null;
  return prev.memorySignal;
}
