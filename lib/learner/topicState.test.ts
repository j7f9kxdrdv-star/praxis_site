import { describe, it, expect } from "vitest";
import {
  topicState,
  isImprovement,
  isDecline,
  topicPriority,
  isPriorityResolved,
  wilsonLowerBound,
  MIN_ATTEMPTS_FOR_STATE,
  MIN_ATTEMPTS_TO_RESOLVE,
  PRIORITY_ENTER,
  PRIORITY_EXIT,
  type TopicState,
} from "./topicState";

describe("the lower bound is what makes small samples safe", () => {
  it("does not let a perfect tiny sample look strong", () => {
    // 8 of 8 is 100% accuracy and scores 0.60: STABLE at best, never STRONG.
    expect(wilsonLowerBound(8, 8)).toBeLessThan(0.75);
    expect(wilsonLowerBound(8, 8)).toBeGreaterThan(0.5);
  });

  it("rewards the same accuracy more when there is more of it", () => {
    expect(wilsonLowerBound(80, 100)).toBeGreaterThan(wilsonLowerBound(8, 10));
  });
});

describe("topic state", () => {
  it("has no state below the evidence floor", () => {
    expect(topicState(5, MIN_ATTEMPTS_FOR_STATE - 1, null)).toBe("INSUFFICIENT_EVIDENCE");
  });

  it("classifies once there is enough", () => {
    expect(topicState(2, 20, null)).toBe("NEEDS_ATTENTION");
    expect(topicState(19, 20, null)).toBe("STRONG");
  });

  it("ONE LUCKY ANSWER DOES NOT MOVE A TOPIC", () => {
    // 11 of 20 sits in DEVELOPING. Adding a single correct answer must not
    // promote it, which is the failure this whole model exists to prevent.
    const before = topicState(11, 20, null);
    const after = topicState(12, 21, before);
    expect(after).toBe(before);
    expect(isImprovement(before, after)).toBe(false);
  });

  it("does not flip back and forth on a boundary", () => {
    // A topic hovering either side of the STABLE floor must hold its state
    // rather than emit improved / declined / improved every session.
    let state: TopicState | null = null;
    const seen: TopicState[] = [];
    for (const [c, n] of [
      [14, 20],
      [15, 21],
      [14, 21],
      [15, 22],
      [14, 22],
    ] as [number, number][]) {
      state = topicState(c, n, state);
      seen.push(state);
    }
    expect(new Set(seen).size).toBe(1);
  });

  it("does believe a large, sustained improvement", () => {
    const before = topicState(8, 20, null); // 0.22, NEEDS_ATTENTION
    expect(before).toBe("NEEDS_ATTENTION");
    const after = topicState(48, 60, before); // 0.68, comfortably STABLE
    expect(after).toBe("STABLE");
    expect(isImprovement(before, after)).toBe(true);
  });

  it("believes a real decline too", () => {
    const before = topicState(48, 60, null);
    const after = topicState(50, 120, before); // 0.42
    expect(isDecline(before, after)).toBe(true);
  });

  it("MORE EVIDENCE NEVER PRODUCES A WORSE STATE", () => {
    // The defect the calibration run caught: hysteresis was all-or-nothing on
    // the target band, so a topic clearing DEVELOPING but short of STABLE's
    // margin fell all the way back to NEEDS_ATTENTION. 52/70 scored worse than
    // 42/60, which is nonsense. Monotonicity is the property that was missing.
    let previous: TopicState = topicState(4, 20, null);
    let lastRank = -1;
    const order = ["NEEDS_ATTENTION", "DEVELOPING", "STABLE", "STRONG"];
    for (const [c, n] of [
      [32, 50],
      [42, 60],
      [52, 70],
      [62, 80],
      [72, 90],
    ] as [number, number][]) {
      const state = topicState(c, n, previous);
      const rank = order.indexOf(state);
      expect(rank).toBeGreaterThanOrEqual(lastRank);
      lastRank = rank;
      previous = state;
    }
  });

  it("never calls a first measurement an improvement", () => {
    // Arriving from no evidence is becoming visible, not getting better.
    expect(isImprovement("INSUFFICIENT_EVIDENCE", "STRONG")).toBe(false);
    expect(isImprovement(null, "STABLE")).toBe(false);
  });

  it("never calls losing measurability a decline", () => {
    expect(isDecline("STRONG", "INSUFFICIENT_EVIDENCE")).toBe(false);
  });
});

describe("priority", () => {
  it("does not call a barely-seen topic weak", () => {
    const p = topicPriority(1, 4, "INSUFFICIENT_EVIDENCE", false, null);
    expect(p.isPriority).toBe(false);
    expect(p.reasons[0].code).toBe("NEEDS_MORE_EVIDENCE");
  });

  it("flags a genuinely weak topic, with a reason code", () => {
    const state = topicState(6, 30, null);
    const p = topicPriority(6, 30, state, false, null);
    expect(p.isPriority).toBe(true);
    expect(p.reasons.map((r) => r.code)).toContain("WEAK_APPLICATION");
    expect(p.severity).toBeGreaterThan(0);
  });

  it("adds a declining-trend reason on top", () => {
    const p = topicPriority(10, 30, "NEEDS_ATTENTION", true, null);
    expect(p.reasons.map((r) => r.code)).toContain("DECLINING_TREND");
  });

  it("entry and exit thresholds are meaningfully apart", () => {
    // toBeCloseTo, not >=: 0.65 - 0.55 is 0.09999999999999998 in binary
    // floating point, and a strict comparison here fails on arithmetic rather
    // than on the model.
    expect(PRIORITY_EXIT - PRIORITY_ENTER).toBeCloseTo(0.1, 10);
  });
});

describe("priority resolution", () => {
  it("REVIEWING ALONE DOES NOT RESOLVE ANYTHING", () => {
    // Two correct answers after opening the topic. Nothing has been shown.
    expect(isPriorityResolved(true, 2, 2)).toBe(false);
  });

  it("does not resolve on thin evidence however good it looks", () => {
    expect(isPriorityResolved(true, MIN_ATTEMPTS_TO_RESOLVE - 1, MIN_ATTEMPTS_TO_RESOLVE - 1)).toBe(
      false,
    );
  });

  it("resolves on real, sufficient improvement", () => {
    expect(isPriorityResolved(true, 28, 30)).toBe(true);
  });

  it("does not resolve at the entry threshold, only well past it", () => {
    // Scores between the two thresholds must leave the priority standing,
    // otherwise it resolves and re-enters on the next bad morning.
    // Derived from the constants rather than hardcoded, so a recalibration
    // moves the test with the model instead of silently invalidating it.
    const n = 30;
    const inGap = (c: number) => {
      const lb = wilsonLowerBound(c, n);
      return lb > PRIORITY_ENTER && lb < PRIORITY_EXIT;
    };
    const gapCount = Array.from({ length: n + 1 }, (_, c) => c).find(inGap);
    expect(gapCount).toBeDefined();

    // Between the thresholds: no longer bad enough to become a priority, not
    // yet good enough to clear one that already exists.
    expect(isPriorityResolved(true, gapCount!, n)).toBe(false);

    // Comfortably past the exit threshold: resolves.
    const clears = Array.from({ length: n + 1 }, (_, c) => c).find(
      (c) => wilsonLowerBound(c, n) >= PRIORITY_EXIT,
    );
    expect(isPriorityResolved(true, clears!, n)).toBe(true);
  });

  it("cannot resolve something that was never a priority", () => {
    expect(isPriorityResolved(false, 100, 100)).toBe(false);
  });
});

describe("PRIORITY MEMBERSHIP IS STICKY", () => {
  // The defect: entry and exit both used PRIORITY_ENTER, so a topic improving
  // from below 0.40 to just above it left the priority list while still failing
  // the 0.50 resolution bar. It vanished in silence. Eleven real topics were
  // sitting in that gap and no PRIORITY_TOPIC_RESOLVED had ever been emitted.

  /** Correct answers out of n that land the Wilson lower bound in a range. */
  const findScore = (n: number, lo: number, hi: number) => {
    for (let c = 0; c <= n; c++) {
      const lb = wilsonLowerBound(c, n);
      if (lb >= lo && lb < hi) return c;
    }
    throw new Error(`no score out of ${n} lands in [${lo}, ${hi})`);
  };

  it("enters priority below the entry threshold", () => {
    const n = 30;
    const c = findScore(n, 0, PRIORITY_ENTER);
    const p = topicPriority(c, n, topicState(c, n, null), false, false);
    expect(p.isPriority).toBe(true);
  });

  it("STAYS a priority in the gap between entry and exit", () => {
    // The exact case that was failing. Above entry, below exit.
    const n = 30;
    const c = findScore(n, PRIORITY_ENTER, PRIORITY_EXIT);
    const lb = wilsonLowerBound(c, n);
    expect(lb).toBeGreaterThanOrEqual(PRIORITY_ENTER);
    expect(lb).toBeLessThan(PRIORITY_EXIT);

    // A topic arriving here fresh is NOT a priority.
    expect(topicPriority(c, n, topicState(c, n, null), false, false).isPriority).toBe(false);
    // But one that was already a priority stays one.
    expect(topicPriority(c, n, topicState(c, n, null), false, true).isPriority).toBe(true);
  });

  it("resolves only after clearing the exit threshold on enough evidence", () => {
    const n = 30;
    const clears = findScore(n, PRIORITY_EXIT, 1.01);
    expect(topicPriority(clears, n, topicState(clears, n, null), false, true).isPriority).toBe(false);
    expect(isPriorityResolved(true, clears, n)).toBe(true);
  });

  it("cannot resolve on thin evidence however good it looks", () => {
    // Perfect, but below the attempts bar. Reviewing a topic and answering a
    // handful correctly must not clear a priority.
    const thin = MIN_ATTEMPTS_TO_RESOLVE - 1;
    expect(topicPriority(thin, thin, "INSUFFICIENT_EVIDENCE", false, true).isPriority).toBe(true);
    expect(isPriorityResolved(true, thin, thin)).toBe(false);
  });

  it("membership and the resolution event can never disagree", () => {
    // Both must be driven by the same predicate, or a topic leaves the list
    // without an event again. Swept across the whole space.
    for (let n = MIN_ATTEMPTS_FOR_STATE; n <= 60; n += 3) {
      for (let c = 0; c <= n; c++) {
        const stillPriority = topicPriority(c, n, topicState(c, n, null), false, true).isPriority;
        const resolved = isPriorityResolved(true, c, n);
        expect(stillPriority).toBe(!resolved);
      }
    }
  });

  it("one good answer does not resolve a priority", () => {
    // A topic deep in priority territory answers one more correctly.
    const before = topicPriority(6, 20, topicState(6, 20, null), false, true);
    const after = topicPriority(7, 21, topicState(7, 21, null), false, true);
    expect(before.isPriority).toBe(true);
    expect(after.isPriority).toBe(true);
  });

  it("one bad answer does not re-flag a resolved topic on the same evidence", () => {
    // Resolved at 25/30, then one miss. It should not snap straight back.
    const n = 30;
    const clears = findScore(n, PRIORITY_EXIT, 1.01);
    expect(topicPriority(clears, n, topicState(clears, n, null), false, true).isPriority).toBe(false);
    // Now not a priority, and one miss must not clear the ENTRY bar either.
    const next = topicPriority(clears, n + 1, topicState(clears, n + 1, null), false, false);
    expect(next.isPriority).toBe(false);
  });
});
