// ─── MCAT score estimate, provisional calibration ──────────────────────────
//
// EVERY TUNABLE NUMBER IN THE ESTIMATE LIVES IN THIS FILE. That is the point of
// it. The previous version buried a percentage-to-score lookup inside the
// analytics page, so improving it meant editing a UI component, and nothing
// recorded which version of the mapping a given estimate came from.
//
// WHAT THIS IS. A provisional mapping from practice performance to a score
// range, plus an uncertainty model. It is NOT calibrated against real MCAT
// outcomes, because Praxist has none yet; official_mcat_scores exists to
// collect them, and when enough accumulate, ACCURACY_TO_CENTRE and the widening
// terms below get replaced with fitted values and PREDICTOR_VERSION bumps.
//
// WHAT IT DELIBERATELY DOES. It gets less certain, not more confident, when the
// evidence is thin. Two things drive that:
//
//   sample size    few first attempts means a wider range
//   coverage       an MCAT section with no questions at all widens the range
//                  hard, because the total score includes sections we have
//                  never measured
//
// Today the bank holds only Biology/Biochemistry and Chemistry/Physics content,
// so CARS and Psych/Soc are always unmeasured and the range is always wide.
// That is correct, and it narrows on its own the day that content ships.

export const PREDICTOR_VERSION = "1.1.0-provisional";

/**
 * Centre of the estimate, from FIRST-ATTEMPT accuracy.
 *
 * First attempts only. A repeat of a question whose answer has already been
 * seen is not an independent measurement of ability, and roughly a quarter of
 * all attempts in the bank are repeats, which previously inflated this number.
 *
 * These boundaries are expert judgement, not fitted values. They are the single
 * most important thing to replace once real outcomes exist.
 */
const ACCURACY_TO_CENTRE: { minAccuracy: number; centre: number }[] = [
  { minAccuracy: 90, centre: 519 },
  { minAccuracy: 85, centre: 516 },
  { minAccuracy: 80, centre: 513 },
  { minAccuracy: 75, centre: 510 },
  { minAccuracy: 70, centre: 507 },
  { minAccuracy: 60, centre: 503 },
  { minAccuracy: 0, centre: 500 },
];

/** The four MCAT sections, and which question-bank sections feed each. */
export const MCAT_SECTIONS = [
  { key: "cp", label: "C/P", bankSections: ["chem_phys"] },
  { key: "cars", label: "CARS", bankSections: ["cars"] },
  { key: "bb", label: "B/B", bankSections: ["bio_biochem"] },
  { key: "ps", label: "P/S", bankSections: ["psych_soc"] },
] as const;

const BASE_HALF_WIDTH = 3;      // even with plenty of evidence, not a point estimate
const MAX_SAMPLE_WIDENING = 4;  // how much thin sample size can add
const WIDENING_PER_BLIND_SECTION = 2;
const MAX_HALF_WIDTH = 9;       // beyond this the range says nothing useful
const MIN_ATTEMPTS_TO_ESTIMATE = 20;

export const SCORE_FLOOR = 472;
export const SCORE_CEILING = 528;

export type Confidence = "Low" | "Moderate" | "High";

export interface ScoreEstimate {
  /** Null when there is too little evidence to say anything at all. */
  low: number | null;
  high: number | null;
  centre: number | null;
  confidence: Confidence;
  /** MCAT sections with no first-attempt evidence behind them. */
  blindSections: string[];
  firstAttempts: number;
  version: string;
}

/**
 * Estimate a score range from first-attempt practice performance.
 *
 * @param firstAttemptAccuracy 0-100, computed over FIRST attempts only
 * @param firstAttempts        how many first attempts that figure rests on
 * @param sectionsWithData     bank section slugs the student has answered in
 */
export function estimateScore(
  firstAttemptAccuracy: number,
  firstAttempts: number,
  sectionsWithData: Set<string>
): ScoreEstimate {
  const blindSections = MCAT_SECTIONS.filter(
    (s) => !s.bankSections.some((b) => sectionsWithData.has(b))
  ).map((s) => s.label);

  if (firstAttempts < MIN_ATTEMPTS_TO_ESTIMATE) {
    return {
      low: null,
      high: null,
      centre: null,
      confidence: "Low",
      blindSections,
      firstAttempts,
      version: PREDICTOR_VERSION,
    };
  }

  const centre =
    ACCURACY_TO_CENTRE.find((b) => firstAttemptAccuracy >= b.minAccuracy)?.centre ?? 500;

  // Thin evidence widens the range. Falls off with the square root of the
  // sample, so the first hundred questions buy most of the certainty that
  // question count alone can buy.
  const sampleWidening = Math.min(
    MAX_SAMPLE_WIDENING,
    Math.round(10 / Math.sqrt(firstAttempts))
  );

  const halfWidth = Math.min(
    MAX_HALF_WIDTH,
    BASE_HALF_WIDTH + sampleWidening + blindSections.length * WIDENING_PER_BLIND_SECTION
  );

  // A range is only as trustworthy as its blindest section. Two unmeasured
  // sections is half the exam, and no amount of practice in the other two can
  // make the TOTAL confident.
  const confidence: Confidence =
    blindSections.length >= 2
      ? "Low"
      : blindSections.length === 1 || firstAttempts < 150
      ? "Moderate"
      : "High";

  return {
    low: Math.max(SCORE_FLOOR, centre - halfWidth),
    high: Math.min(SCORE_CEILING, centre + halfWidth),
    centre,
    confidence,
    blindSections,
    firstAttempts,
    version: PREDICTOR_VERSION,
  };
}

/** One line explaining what the estimate rests on, in the student's terms. */
export function estimateBasis(e: ScoreEstimate): string {
  if (e.low === null) {
    return `Answer at least ${MIN_ATTEMPTS_TO_ESTIMATE} practice questions to see an estimated range.`;
  }
  if (e.blindSections.length) {
    return `Based on ${e.firstAttempts.toLocaleString()} first-attempt questions. No ${e.blindSections.join(
      " or "
    )} questions yet, so this range is wide.`;
  }
  return `Based on ${e.firstAttempts.toLocaleString()} first-attempt questions across all four sections.`;
}
