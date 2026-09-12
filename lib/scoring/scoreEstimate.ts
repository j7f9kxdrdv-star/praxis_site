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

export const PREDICTOR_VERSION = "1.3.0-provisional";

// ─── 1.2.0: the ceiling became evidence-aware ──────────────────────────────
//
// THE DEFECT. Uncertainty widened the interval in both directions, so thin
// evidence pushed the TOP of the range up. Twenty first attempts at 100% showed
// 510 to 528: the top of the band a student was shown was a perfect MCAT score,
// earned on twenty questions, across half an exam, at Low confidence. Five
// hundred perfect attempts showed 512 to 526, a LOWER ceiling than twenty. That
// inversion is the tell that width was doing a job it should not have had.
//
// THE SEPARATION. Range width and range ceiling answer different questions.
// Width asks how precisely we can place this student. The ceiling asks what
// claim the evidence can support at all. Thin evidence should widen the first
// and hold down the second, and previously it did both by widening.
//
// WHAT MODERATES THE CEILING. An evidence strength in [0,1], built from depth
// and breadth MULTIPLICATIVELY, so a zero in one cannot be bought with the
// other. A student cannot reach an elite ceiling on volume alone while half the
// exam has never been measured, which is the situation every Praxist student is
// in today and will be until CARS and Psych/Soc content ships.
//
// WHAT THIS IS NOT. It is not a fixed cap keyed off a question count. Every
// input moves continuously, and the ceiling rises on its own as the evidence
// base deepens and broadens. Nothing needs to be edited when CARS ships.

/**
 * Centre of the estimate, from FIRST-ATTEMPT accuracy.
 *
 * First attempts only. A repeat of a question whose answer has already been
 * seen is not an independent measurement of ability, and roughly a quarter of
 * all attempts in the bank are repeats, which previously inflated this number.
 *
 * These boundaries are expert judgement, not fitted values. They are the single
 * most important thing to replace once real outcomes exist.
 *
 * ─── 1.3.0: THE TABLE MUST SPAN THE WHOLE SCALE ─────────────────────────
 *
 * It previously saturated at both ends. Everything at or below 55% mapped to
 * 500 and everything at or above 90% mapped to 519, so the model could only
 * ever express 497 to 522: twenty-five points of a fifty-six point scale. A
 * student answering nothing correctly was told they looked average, and no
 * amount of evidence could ever produce a 525.
 *
 * That saturation was doing a job it should not have had. Before 1.2.0 the
 * table was the ONLY thing holding back an over-confident high-end claim, so
 * refusing to go above 519 was a crude but real protection. The evidence
 * ceiling does that job now, and does it properly: it asks what the evidence
 * base can support rather than capping everyone forever.
 *
 * So the table is free to span the real scale, and the ceiling decides HOW
 * QUICKLY a student can reach the top of it. 472 and 528 are both reachable
 * again, and a 528 requires a deep, broad, full-length-backed evidence base
 * rather than being impossible by construction.
 *
 * THE APPROVED MIDDLE IS UNTOUCHED. Every boundary from 60% to 90% is exactly
 * as it was, so no existing student's estimate moves except Mikko's, by one
 * point, from the new 52% band.
 */
const ACCURACY_TO_CENTRE: { minAccuracy: number; centre: number }[] = [
  // Extended upward in 1.3.0. Gated by the evidence ceiling, not by refusal.
  { minAccuracy: 98, centre: 527 },
  { minAccuracy: 95, centre: 524 },
  { minAccuracy: 92, centre: 521 },
  // ── unchanged since 1.0.0 ──
  { minAccuracy: 90, centre: 519 },
  { minAccuracy: 85, centre: 516 },
  { minAccuracy: 80, centre: 513 },
  { minAccuracy: 75, centre: 510 },
  { minAccuracy: 70, centre: 507 },
  { minAccuracy: 60, centre: 503 },
  // ── extended downward in 1.3.0 ──
  //
  // 25% is chance on four options, so an accuracy near it carries no evidence
  // of knowledge and belongs near the floor rather than at the median. The
  // steps widen below 60% because the scale itself compresses down there: the
  // distance from chance to competent is many more scaled points than the
  // distance between two strong students.
  { minAccuracy: 52, centre: 499 },
  { minAccuracy: 44, centre: 494 },
  { minAccuracy: 36, centre: 488 },
  { minAccuracy: 28, centre: 481 },
  { minAccuracy: 0, centre: 474 },
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
  /** How the ceiling was moderated. Internal diagnostics, not student copy. */
  evidence: EvidenceStrength | null;
  version: string;
}

/**
 * How much the question count alone can buy, saturating.
 *
 * Logarithmic, because the first hundred questions tell us far more than the
 * nine hundredth does. 800 is where depth is treated as effectively complete:
 * it is roughly two full MCAT question banks' worth of first attempts, and no
 * student in the system is close to it yet.
 *
 * JUDGEMENT, NOT MEASUREMENT. There are no MCAT outcomes to fit this against.
 */
const DEPTH_SATURATION = 800;

/**
 * Distinct subtopics that count as broad coverage WITHIN the sections a student
 * has touched.
 *
 * Breadth matters separately from depth because 300 questions inside three
 * subtopics is not 300 questions' worth of evidence about a section. Thirty is
 * an order-of-magnitude judgement about how many subtopics a section spans.
 */
const TOPIC_TARGET = 30;

/**
 * How much of the breadth term survives when topic coverage is at zero.
 *
 * Topic breadth modulates the estimate; it does not dominate it. A student with
 * deep evidence in few subtopics still has real evidence.
 */
const TOPIC_FLOOR = 0.7;

/**
 * The penalty for having no full-length exam evidence.
 *
 * A full length is the only thing that measures stamina, timing and section
 * ordering together, so its absence should cost something. It costs a little
 * rather than a lot because TODAY NO STUDENT CAN HAVE ONE: no full-length type
 * exists in the product, official_mcat_scores is empty, and penalising every
 * student hard for a thing none of them can do would make every estimate
 * uniformly worse while distinguishing nobody.
 *
 * The term is live so that the model does not need rewriting when full lengths
 * ship. It simply starts paying out.
 */
const NO_FULL_LENGTH_FACTOR = 0.85;

/**
 * The highest score claimable when the evidence is effectively nothing.
 *
 * THIS IS THE ONE GENUINELY NEW PRODUCT ASSUMPTION IN 1.2.0 and it deserves to
 * be argued with. 512 sits comfortably above the 500 median and below anything
 * that reads as elite. The claim it encodes is: "on almost no evidence, the
 * most we will say is that this student looks like a solid scorer."
 *
 * It is a floor on the CEILING, not a cap on the student. It rises immediately
 * as evidence arrives, and it never touches the centre of the estimate except
 * when the centre would otherwise sit above its own ceiling.
 */
const CEILING_FLOOR = 512;

export interface EvidenceStrength {
  /** 0 to 1. The moderating term applied to the ceiling. */
  overall: number;
  depth: number;
  sectionBreadth: number;
  topicBreadth: number;
  hasFullLength: boolean;
  /** The highest score this evidence base can support. */
  ceiling: number;
}

/**
 * How much this evidence base can be asked to support.
 *
 * MULTIPLICATIVE ON PURPOSE. Adding the terms would let a huge question count
 * compensate for never having answered a CARS question, and it cannot: the
 * total score is the sum of four sections, and two of them are unmeasured.
 */
export function evidenceStrength(
  firstAttempts: number,
  sectionsWithData: Set<string>,
  topicsWithData: Set<string>,
  fullLengths: number,
): EvidenceStrength {
  const depth = Math.min(1, Math.log1p(firstAttempts) / Math.log1p(DEPTH_SATURATION));

  const measuredSections = MCAT_SECTIONS.filter((s) =>
    s.bankSections.some((b) => sectionsWithData.has(b)),
  ).length;
  const sectionBreadth = measuredSections / MCAT_SECTIONS.length;

  const topicBreadth = Math.min(1, topicsWithData.size / TOPIC_TARGET);
  const topicTerm = TOPIC_FLOOR + (1 - TOPIC_FLOOR) * topicBreadth;

  const hasFullLength = fullLengths > 0;
  const examTerm = hasFullLength ? 1 : NO_FULL_LENGTH_FACTOR;

  const overall = depth * sectionBreadth * topicTerm * examTerm;
  const ceiling = CEILING_FLOOR + (SCORE_CEILING - CEILING_FLOOR) * overall;

  return { overall, depth, sectionBreadth, topicBreadth, hasFullLength, ceiling };
}

/**
 * Estimate a score range from first-attempt practice performance.
 *
 * @param firstAttemptAccuracy 0-100, computed over FIRST attempts only
 * @param firstAttempts        how many first attempts that figure rests on
 * @param sectionsWithData     bank section slugs the student has answered in
 * @param topicsWithData       distinct subtopics answered in, for breadth
 * @param fullLengths          full-length exams sat. Always 0 today; the
 *                             product has no full-length type yet.
 */
export function estimateScore(
  firstAttemptAccuracy: number,
  firstAttempts: number,
  sectionsWithData: Set<string>,
  topicsWithData: Set<string> = new Set(),
  fullLengths = 0,
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
      evidence: null,
      version: PREDICTOR_VERSION,
    };
  }

  const rawCentre =
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

  const evidence = evidenceStrength(
    firstAttempts,
    sectionsWithData,
    topicsWithData,
    fullLengths,
  );

  // ── The ceiling, applied ───────────────────────────────────────────────
  //
  // The top of the range is the LOWER of what uncertainty allows and what the
  // evidence can support. Width is still free to be wide; it is simply no
  // longer free to be wide UPWARD into a claim nobody has earned.
  const high = Math.min(
    SCORE_CEILING,
    rawCentre + halfWidth,
    Math.round(evidence.ceiling),
  );

  // THE CEILING SLIDES THE WINDOW DOWN, IT DOES NOT SQUEEZE IT.
  //
  // The first version of this clamped the centre instead, and the calibration
  // run caught what that did: 100 questions across four sections came out as
  // 515 to 519, a four-point range at Low confidence. A narrow range reads as
  // certainty, so moderating the ceiling had accidentally made thin evidence
  // look MORE authoritative, which is the opposite of the point.
  //
  // Width belongs to uncertainty and nothing else. The window keeps the full
  // width halfWidth earned and hangs from the ceiling, so capping the top
  // lowers the bottom by exactly as much.
  const centre = high - halfWidth;
  const low = Math.max(SCORE_FLOOR, high - 2 * halfWidth);

  // A range is only as trustworthy as its blindest section. Two unmeasured
  // sections is half the exam, and no amount of practice in the other two can
  // make the TOTAL confident. That rule is kept exactly as it was, and evidence
  // strength now decides the rest rather than the raw question count.
  const confidence: Confidence =
    blindSections.length >= 2
      ? "Low"
      : evidence.overall < 0.45
      ? "Low"
      : evidence.overall < 0.7
      ? "Moderate"
      : "High";

  return {
    low,
    high,
    centre,
    confidence,
    blindSections,
    firstAttempts,
    evidence,
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
