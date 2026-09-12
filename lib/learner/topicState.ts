// ─── Topic state ───────────────────────────────────────────────────────────
//
// What "improved" means, and what it costs to say it.
//
// The rule this exists to prevent is "got one question right, topic improved".
// Three separate things stop that here, and they stack:
//
//   1. The measure is a WILSON LOWER BOUND, not an accuracy. It asks how good
//      the topic could plausibly be given how little was seen, so a small
//      sample cannot reach a high band however lucky it was. Eight correct out
//      of eight scores 0.60, not 1.00.
//   2. A minimum attempt count, below which the topic is INSUFFICIENT_EVIDENCE
//      and has no state to move.
//   3. HYSTERESIS. Crossing a boundary is not enough; the new band has to be
//      cleared by a margin. Without it a topic sitting on 0.60 flips between
//      DEVELOPING and STABLE every session, and every flip is an event.
//
// PRIORITY USES SEPARATE ENTRY AND EXIT THRESHOLDS for the same reason, and a
// wider gap, because a priority appearing and vanishing repeatedly is worse
// than one that lingers: the student is told to work on something, then told
// they need not, then told again.

// 1.1.0 recalibrated two thresholds against real student data. See the notes
// on MIN_ATTEMPTS_FOR_STATE and PRIORITY_ENTER below for what changed and why.
//
// 1.2.0 made priority membership STICKY. Until then PRIORITY_ENTER decided both
// whether a topic became a priority and whether it stayed one, while
// PRIORITY_EXIT was consulted only by the resolution event. A topic that
// climbed into the gap between the two thresholds therefore vanished from the
// priority list without ever resolving, and no event was emitted. Eleven real
// topics sat in that gap and not one PRIORITY_TOPIC_RESOLVED had ever been
// generated. See topicPriority.
//
// Snapshots written by older versions remain interpretable: they carry their
// own version, and the band thresholds did not move in 1.2.0.
export const TOPIC_MODEL_VERSION = "1.2.0";

export type TopicState =
  | "INSUFFICIENT_EVIDENCE"
  | "NEEDS_ATTENTION"
  | "DEVELOPING"
  | "STABLE"
  | "STRONG";

/**
 * Order for comparison. INSUFFICIENT_EVIDENCE is deliberately absent: it is not
 * a rung on the ladder, it is the absence of one, and moving out of it is not
 * an improvement, it is the first measurement.
 */
const RANK: Record<Exclude<TopicState, "INSUFFICIENT_EVIDENCE">, number> = {
  NEEDS_ATTENTION: 0,
  DEVELOPING: 1,
  STABLE: 2,
  STRONG: 3,
};

/**
 * Attempts before a topic has any state at all.
 *
 * RAISED FROM 8 TO 12 IN 1.1.0. Eight created a fragile band: a perfect 8/8
 * scores 0.676 and reaches STABLE, and the very next wrong answer can drop it
 * again. That fires a DECLINE event, which tells the student they got worse
 * when what actually happened is that our estimate got more honest.
 *
 * All three declines in the reconstructed history sat in that zone, at n of 11
 * to 14. The worst read "Lipid and Amino Acid Metabolism, STABLE to DEVELOPING,
 * 9/11" — a topic at 82% being reported as a decline.
 *
 * Twelve is where a perfect run reaches STRONG rather than scraping STABLE, so
 * a band is earned on evidence thick enough to survive one bad answer.
 */
export const MIN_ATTEMPTS_FOR_STATE = 12;

/** Band floors, on the Wilson lower bound. */
export const BANDS = {
  developing: 0.45,
  stable: 0.6,
  strong: 0.75,
} as const;

/**
 * How far past a boundary the evidence must reach to change state.
 *
 * Applied in the direction of travel only: moving up needs the higher band's
 * floor plus the margin, moving down needs the current band's floor minus it.
 * A topic between the two keeps the state it had.
 */
export const HYSTERESIS = 0.05;

/**
 * Priority enters here.
 *
 * LOWERED FROM 0.55 TO 0.40 IN 1.1.0. At 0.55 a student needed 80% raw accuracy
 * at twenty attempts to avoid being flagged, and MCAT-par is around 65%. The
 * effect on real accounts was that almost everything was a priority: 10 of 10
 * measurable topics for one student, 22 of 31 for another, 11 of 12 for a
 * third. A priority list containing everything prioritises nothing.
 *
 * 0.40 asks for 65% at twenty attempts and 58% at forty, which tracks what the
 * exam itself demands rather than what a perfect student would score.
 */
export const PRIORITY_ENTER = 0.4;
/**
 * And leaves only here.
 *
 * Deliberately well clear of the entry threshold, not a hair above it. A
 * priority that resolves the moment it stops qualifying will re-enter on the
 * next bad morning, and the student sees the same topic appear and vanish.
 */
export const PRIORITY_EXIT = 0.5;
/** And never resolves on thin evidence, however good it looks. */
export const MIN_ATTEMPTS_TO_RESOLVE = 12;

/**
 * How good a topic could plausibly be, given how much was seen.
 *
 * The conservative end of the confidence interval, so small samples sit low
 * whatever their raw accuracy. This is what makes one lucky answer harmless.
 */
export function wilsonLowerBound(correct: number, attempts: number): number {
  if (attempts <= 0) return 0;
  const z = 1.96;
  const p = correct / attempts;
  return (
    (p + (z * z) / (2 * attempts) - z * Math.sqrt((p * (1 - p) + (z * z) / (4 * attempts)) / attempts)) /
    (1 + (z * z) / attempts)
  );
}

/** The band a score falls in, ignoring where it came from. */
function bandOf(lowerBound: number): Exclude<TopicState, "INSUFFICIENT_EVIDENCE"> {
  if (lowerBound >= BANDS.strong) return "STRONG";
  if (lowerBound >= BANDS.stable) return "STABLE";
  if (lowerBound >= BANDS.developing) return "DEVELOPING";
  return "NEEDS_ATTENTION";
}

const FLOOR: Record<Exclude<TopicState, "INSUFFICIENT_EVIDENCE">, number> = {
  NEEDS_ATTENTION: 0,
  DEVELOPING: BANDS.developing,
  STABLE: BANDS.stable,
  STRONG: BANDS.strong,
};

/**
 * The topic's state now, given what it was before.
 *
 * `previous` is what makes this stable rather than a lookup: a topic only
 * leaves its band when the evidence clears the next boundary by HYSTERESIS, in
 * whichever direction it is moving. Pass null on a first measurement.
 */
export function topicState(
  correct: number,
  attempts: number,
  previous: TopicState | null,
): TopicState {
  if (attempts < MIN_ATTEMPTS_FOR_STATE) return "INSUFFICIENT_EVIDENCE";

  const lb = wilsonLowerBound(correct, attempts);
  const raw = bandOf(lb);

  // No previous band to be sticky about.
  if (previous == null || previous === "INSUFFICIENT_EVIDENCE") return raw;
  if (raw === previous) return previous;

  // ONE BOUNDARY AT A TIME, in whichever direction.
  //
  // The first version tested only the TARGET band's margin and returned the
  // previous state if it was not met, which made hysteresis all-or-nothing on a
  // multi-band jump. A topic at 0.630 moving up from NEEDS_ATTENTION clears
  // DEVELOPING easily and falls short of STABLE's margin, and the old code sent
  // it back to NEEDS_ATTENTION: more evidence, worse state. 52/70 scored worse
  // than 42/60, which is nonsense and is exactly what the calibration run found.
  //
  // Walking the ladder settles the topic in the best band it has actually
  // earned, and still refuses any boundary it has not cleared by the margin.
  const LADDER = ["NEEDS_ATTENTION", "DEVELOPING", "STABLE", "STRONG"] as const;
  let result: Exclude<TopicState, "INSUFFICIENT_EVIDENCE"> = previous;

  if (RANK[raw] > RANK[previous]) {
    // Climb while the next rung up has been cleared by the margin.
    for (let i = RANK[previous] + 1; i < LADDER.length; i++) {
      if (lb >= FLOOR[LADDER[i]] + HYSTERESIS) result = LADDER[i];
      else break;
    }
    return result;
  }

  // Fall while the floor of the band currently held has been undercut by it.
  for (let i = RANK[previous]; i > 0; i--) {
    if (lb < FLOOR[LADDER[i]] - HYSTERESIS) result = LADDER[i - 1];
    else break;
  }
  return result;
}

/**
 * Did the topic genuinely improve?
 *
 * Both states must be real bands. Arriving from INSUFFICIENT_EVIDENCE is a
 * first measurement, not an improvement: the topic did not get better, it
 * became visible, and counting it would hand every new student a run of
 * "improvements" for doing nothing but showing up.
 */
export function isImprovement(previous: TopicState | null, current: TopicState): boolean {
  if (!previous || previous === "INSUFFICIENT_EVIDENCE") return false;
  if (current === "INSUFFICIENT_EVIDENCE") return false;
  return RANK[current] > RANK[previous];
}

export function isDecline(previous: TopicState | null, current: TopicState): boolean {
  if (!previous || previous === "INSUFFICIENT_EVIDENCE") return false;
  if (current === "INSUFFICIENT_EVIDENCE") return false;
  return RANK[current] < RANK[previous];
}

export type PriorityReasonCode =
  | "WEAK_APPLICATION"
  | "RECENT_MISSES"
  | "DECLINING_TREND"
  | "NEEDS_MORE_EVIDENCE"
  | "LOW_COVERAGE";

export interface TopicPriority {
  isPriority: boolean;
  /** 0 to 1, higher is worse. How far below the entry threshold it sits. */
  severity: number;
  reasons: { code: PriorityReasonCode; severity: number }[];
}

/**
 * Whether a topic is a priority, and why.
 *
 * Reason codes rather than sentences, so the wording can change without the
 * model changing. The frontend maps codes to copy.
 */
export function topicPriority(
  correct: number,
  attempts: number,
  state: TopicState,
  declined: boolean,
  wasPriority: boolean | null,
): TopicPriority {
  const reasons: { code: PriorityReasonCode; severity: number }[] = [];
  const lb = wilsonLowerBound(correct, attempts);
  const severity = Math.max(0, Math.min(1, (PRIORITY_ENTER - lb) / PRIORITY_ENTER));

  // ── STICKY MEMBERSHIP ──────────────────────────────────────────────────
  //
  // A topic that is already a priority leaves the list by RESOLVING and by no
  // other route. The predicate below is the identical one the
  // PRIORITY_TOPIC_RESOLVED event uses, which is the whole point: membership
  // and the event cannot disagree, so a priority can never disappear without
  // the student being told it did.
  //
  // The bug this replaces: entry and exit were both PRIORITY_ENTER, so a topic
  // climbing from 0.38 to 0.42 stopped being a priority while still failing the
  // 0.50 resolution bar. It left the list in silence. A student was told to
  // work on something, did the work, and got nothing back.
  if (wasPriority) {
    const resolved = isPriorityResolved(true, correct, attempts);
    if (!resolved) {
      // Still a priority. The reason is still worth recomputing, because a
      // topic can be sitting in the gap (improving, not yet resolved) and the
      // copy should reflect where it is rather than where it entered.
      if (state === "NEEDS_ATTENTION") reasons.push({ code: "WEAK_APPLICATION", severity });
      else reasons.push({ code: "RECENT_MISSES", severity });
      if (declined) reasons.push({ code: "DECLINING_TREND", severity: Math.max(severity, 0.5) });
      return { isPriority: true, severity, reasons };
    }
    // Resolved. Falls through to not-a-priority, and snapshot.ts emits the
    // event off the same condition.
    return { isPriority: false, severity, reasons: [] };
  }

  // ── ENTRY ──────────────────────────────────────────────────────────────
  if (attempts === 0) {
    return { isPriority: false, severity: 0, reasons: [] };
  }
  if (attempts < MIN_ATTEMPTS_FOR_STATE) {
    // Not a priority: a topic seen three times is unmeasured, not weak, and
    // saying otherwise is the thing this whole file exists to avoid.
    return {
      isPriority: false,
      severity: 0,
      reasons: [{ code: "NEEDS_MORE_EVIDENCE", severity: 0 }],
    };
  }

  const isPriority = lb < PRIORITY_ENTER;

  if (isPriority) {
    if (state === "NEEDS_ATTENTION") reasons.push({ code: "WEAK_APPLICATION", severity });
    else reasons.push({ code: "RECENT_MISSES", severity });
  }
  if (declined) reasons.push({ code: "DECLINING_TREND", severity: Math.max(severity, 0.5) });

  return { isPriority, severity, reasons };
}

/**
 * Has a priority been resolved?
 *
 * REVIEWING A TOPIC DOES NOT RESOLVE IT. Only new evidence does, and only
 * enough of it: the score has to clear PRIORITY_EXIT, which sits well above the
 * threshold that created the priority, on at least MIN_ATTEMPTS_TO_RESOLVE
 * attempts. A student who opens the topic, answers two questions correctly and
 * leaves has changed nothing this function will believe.
 */
export function isPriorityResolved(
  wasPriority: boolean,
  correct: number,
  attempts: number,
): boolean {
  if (!wasPriority) return false;
  if (attempts < MIN_ATTEMPTS_TO_RESOLVE) return false;
  return wilsonLowerBound(correct, attempts) >= PRIORITY_EXIT;
}
