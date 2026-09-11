// ─── Learner state snapshots, and the events between them ──────────────────
//
// A snapshot is what was true about a student on one study day. An event is the
// difference between two of them.
//
// This is why nothing here writes to a queue from a request handler. The
// interesting events are not writes: "Endocrine improved" is not something the
// student did, it is something that became true afterwards, and the request
// that made it true has no idea. Diffing consecutive snapshots finds those
// changes without touching a single write path, and a rebuild of a day
// overwrites rather than double-counting.

import {
  topicState,
  topicPriority,
  isImprovement,
  isDecline,
  isPriorityResolved,
  TOPIC_MODEL_VERSION,
  type TopicState,
  type PriorityReasonCode,
} from "@/lib/learner/topicState";

export const SNAPSHOT_VERSION = "1.0.0";

export interface TopicSnapshot {
  topic: string;
  section: string;
  /** Cumulative eligible first attempts, all time. */
  attempts: number;
  correct: number;
  state: TopicState;
  isPriority: boolean;
  severity: number;
  reasons: { code: PriorityReasonCode; severity: number }[];
}

export interface LearnerSnapshot {
  studyDay: string;
  /** Eligible first attempts overall; the gate on saying anything. */
  eligibleAttempts: number;
  recentAccuracy: number | null;
  recentSampleSize: number;
  coveragePercent: number;
  coverageAttempted: number;
  coverageTotal: number;
  topics: TopicSnapshot[];
  priorityTopics: string[];
  memoryHealth: string | null;
  version: string;
  topicModelVersion: string;
}

export interface SnapshotInput {
  studyDay: string;
  /** One row per eligible first attempt: which topic, and whether it was right. */
  attempts: { topic: string | null; section: string; isCorrect: boolean }[];
  recentAccuracy: number | null;
  recentSampleSize: number;
  coverageAttempted: number;
  coverageTotal: number;
  memoryHealth: string | null;
  /** Yesterday's snapshot, so topic states can be sticky. Null on the first. */
  previous: LearnerSnapshot | null;
}

/**
 * Build the snapshot for one study day.
 *
 * Topic states are CUMULATIVE, not per-day. A topic's state is what all the
 * evidence says about it so far, which is why a single bad morning cannot move
 * it and why the previous snapshot is needed: hysteresis compares against the
 * state the student was already in.
 */
export function buildSnapshot(input: SnapshotInput): LearnerSnapshot {
  const prevByTopic = new Map(
    (input.previous?.topics ?? []).map((t) => [t.topic, t] as const),
  );

  const tally = new Map<string, { section: string; attempts: number; correct: number }>();
  for (const a of input.attempts) {
    if (!a.topic) continue;
    const e = tally.get(a.topic) ?? { section: a.section, attempts: 0, correct: 0 };
    e.attempts++;
    if (a.isCorrect) e.correct++;
    tally.set(a.topic, e);
  }

  const topics: TopicSnapshot[] = [...tally.entries()].map(([topic, e]) => {
    const prev = prevByTopic.get(topic) ?? null;
    const state = topicState(e.correct, e.attempts, prev?.state ?? null);
    const declined = isDecline(prev?.state ?? null, state);
    const p = topicPriority(e.correct, e.attempts, state, declined);
    return {
      topic,
      section: e.section,
      attempts: e.attempts,
      correct: e.correct,
      state,
      isPriority: p.isPriority,
      severity: p.severity,
      reasons: p.reasons,
    };
  });

  return {
    studyDay: input.studyDay,
    eligibleAttempts: input.attempts.length,
    recentAccuracy: input.recentAccuracy,
    recentSampleSize: input.recentSampleSize,
    coveragePercent:
      input.coverageTotal > 0
        ? Math.round((input.coverageAttempted / input.coverageTotal) * 100)
        : 0,
    coverageAttempted: input.coverageAttempted,
    coverageTotal: input.coverageTotal,
    topics,
    priorityTopics: topics.filter((t) => t.isPriority).map((t) => t.topic),
    memoryHealth: input.memoryHealth,
    version: SNAPSHOT_VERSION,
    topicModelVersion: TOPIC_MODEL_VERSION,
  };
}

export type LearnerEventType =
  | "TOPIC_PERFORMANCE_IMPROVED"
  | "TOPIC_PERFORMANCE_DECLINED"
  | "PRIORITY_TOPIC_ADDED"
  | "PRIORITY_TOPIC_RESOLVED"
  | "CONTENT_COVERAGE_INCREASED";

export interface DerivedEvent {
  type: LearnerEventType;
  occurredOn: string;
  subjectKind: "TOPIC" | "OVERALL";
  subjectId: string;
  previousValue: string | null;
  newValue: string | null;
  metadata: Record<string, string | number>;
  /**
   * Unique per user. Built from the facts that define the event, so rebuilding
   * a day collides with itself and updates rather than inserting a duplicate.
   */
  dedupeKey: string;
  calculationVersion: string;
}

/**
 * Everything that changed between two snapshots.
 *
 * A topic appearing for the first time produces NOTHING. Becoming measurable is
 * not improving, and counting it would hand every new student a run of
 * improvements for doing nothing but showing up.
 */
export function deriveEvents(
  previous: LearnerSnapshot | null,
  current: LearnerSnapshot,
): DerivedEvent[] {
  if (!previous) return [];

  const events: DerivedEvent[] = [];
  const prevByTopic = new Map(previous.topics.map((t) => [t.topic, t] as const));
  const day = current.studyDay;
  const version = `${SNAPSHOT_VERSION}/${TOPIC_MODEL_VERSION}`;

  for (const t of current.topics) {
    const prev = prevByTopic.get(t.topic);
    if (!prev) continue; // first sighting: not a change in anything

    if (isImprovement(prev.state, t.state)) {
      events.push({
        type: "TOPIC_PERFORMANCE_IMPROVED",
        occurredOn: day,
        subjectKind: "TOPIC",
        subjectId: t.topic,
        previousValue: prev.state,
        newValue: t.state,
        metadata: { attempts: t.attempts, correct: t.correct, section: t.section },
        dedupeKey: `TOPIC_PERFORMANCE_IMPROVED:${t.topic}:${day}`,
        calculationVersion: version,
      });
    } else if (isDecline(prev.state, t.state)) {
      events.push({
        type: "TOPIC_PERFORMANCE_DECLINED",
        occurredOn: day,
        subjectKind: "TOPIC",
        subjectId: t.topic,
        previousValue: prev.state,
        newValue: t.state,
        metadata: { attempts: t.attempts, correct: t.correct, section: t.section },
        dedupeKey: `TOPIC_PERFORMANCE_DECLINED:${t.topic}:${day}`,
        calculationVersion: version,
      });
    }

    // A priority resolves on EVIDENCE, never on the flag flipping. The topic
    // must clear the exit threshold on enough attempts; see isPriorityResolved.
    if (prev.isPriority && isPriorityResolved(true, t.correct, t.attempts)) {
      events.push({
        type: "PRIORITY_TOPIC_RESOLVED",
        occurredOn: day,
        subjectKind: "TOPIC",
        subjectId: t.topic,
        // previous/new describe what this event is ABOUT, which is the priority
        // flag, not the band. A topic can gain or lose priority without
        // changing state at all: the priority threshold cuts through the
        // DEVELOPING band, so a topic can sit in one band on either side of it.
        // The band is carried in metadata instead.
        previousValue: "PRIORITY",
        newValue: "NOT_PRIORITY",
        metadata: { attempts: t.attempts, correct: t.correct, state: t.state },
        dedupeKey: `PRIORITY_TOPIC_RESOLVED:${t.topic}:${day}`,
        calculationVersion: version,
      });
    }

    if (!prev.isPriority && t.isPriority) {
      events.push({
        type: "PRIORITY_TOPIC_ADDED",
        occurredOn: day,
        subjectKind: "TOPIC",
        subjectId: t.topic,
        previousValue: "NOT_PRIORITY",
        newValue: "PRIORITY",
        metadata: {
          severity: Number(t.severity.toFixed(3)),
          reason: t.reasons[0]?.code ?? "RECENT_MISSES",
          state: t.state,
          previousState: prev.state,
        },
        dedupeKey: `PRIORITY_TOPIC_ADDED:${t.topic}:${day}`,
        calculationVersion: version,
      });
    }
  }

  if (current.coverageAttempted > previous.coverageAttempted) {
    events.push({
      type: "CONTENT_COVERAGE_INCREASED",
      occurredOn: day,
      subjectKind: "OVERALL",
      subjectId: "coverage",
      previousValue: String(previous.coveragePercent),
      newValue: String(current.coveragePercent),
      metadata: {
        questionsAdded: current.coverageAttempted - previous.coverageAttempted,
      },
      dedupeKey: `CONTENT_COVERAGE_INCREASED:${day}`,
      calculationVersion: version,
    });
  }

  return events;
}
