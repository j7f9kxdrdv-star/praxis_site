import type { SupabaseClient } from "@supabase/supabase-js";
import { MIN_ATTEMPTS_FOR_STATE } from '@/lib/learner/topicState';
import { MIN_FIRST_LOOKS } from '@/lib/analytics/crossModality';

// ─── Types ────────────────────────────────────────────────────────────────────

export interface SubtopicMetrics {
  section: string;
  topic: string;
  subtopic: string;
  attempts: number;
  accuracy: number;
  avg_time_seconds: number;
  miss_frequency: number;
  difficulty_adjusted_accuracy: number;
  trend: number; // -100 to 100
  mastery_score: number;
  struggle_score: number;
  priority_score: number;
  confidence_score: number;
  spaced_repetition_gap_score: number;
  days_since_last_practiced: number;
  status: 'Strong' | 'Stable' | 'Developing' | 'Struggling' | 'Critical' | 'Insufficient Data';
  last_practiced: string;
  top_priority_reason?: string;
}

export interface ReportMetrics {
  period: 'daily' | 'weekly';
  start_date: string;
  end_date: string;
  total_questions: number;
  overall_accuracy: number;
  avg_time_seconds: number;
  subtopics: SubtopicMetrics[];
  struggling: SubtopicMetrics[];   // status = Struggling or Critical
  strong: SubtopicMetrics[];       // status = Strong or Stable
  top_priority: SubtopicMetrics | null;
  section_breakdown: Record<string, { attempts: number; accuracy: number }>;
  days_studied: number;
  exam_days_remaining: number | null;
  /**
   * What the learner-state system observed over the same window.
   *
   * THE REPORTS HAVE NEVER SEEN ANY OF THIS. They were built from question
   * attempts alone, so a week where a student reviewed six hundred cards and
   * resolved a priority read as a week where nothing happened outside
   * practice. Worse, the report carried its own status taxonomy derived from
   * accuracy, which could disagree with the dashboard about the same topic in
   * the same week.
   *
   * Every field here is READ from what the snapshot system already stored.
   * Nothing is recomputed and no second model is defined: topics_improved
   * counts deduped TOPIC_PERFORMANCE_IMPROVED events, not a fresh comparison.
   * That is what makes it safe for the prose to cite them.
   *
   * Null when the snapshot system has nothing for this window, so a prompt can
   * say nothing rather than say zero.
   */
  learner: LearnerSignals | null;
}

export interface LearnerSignals {
  /** Distinct card-blanks reviewed in the window. */
  cards_reviewed: number;
  /** First-look recall over the window, or null below the evidence floor. */
  first_look_recall: number | null;
  first_looks: number;
  /** Deduped events inside the window. Transitions, never totals. */
  topics_improved: number;
  topics_declined: number;
  priorities_resolved: number;
  priorities_added: number;
  /** Percentage points of the question bank newly encountered. */
  coverage_delta: number | null;
  coverage_percent: number | null;
}

// ─── Internal types ───────────────────────────────────────────────────────────

interface RawAttempt {
  user_id: string;
  question_id: string;
  session_id: string;
  selected_answer: string;
  is_correct: boolean;
  time_spent_seconds: number;
  created_at: string;
  questions: {
    id: string;
    section: string;
    topic: string;
    subtopic: string;
    difficulty: string;
  } | null;
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function clamp(val: number, min: number, max: number): number {
  return Math.max(min, Math.min(max, val));
}

function stdDev(values: number[]): number {
  if (values.length === 0) return 0;
  const mean = values.reduce((a, b) => a + b, 0) / values.length;
  const variance = values.reduce((sum, v) => sum + Math.pow(v - mean, 2), 0) / values.length;
  return Math.sqrt(variance);
}

function recencyWeight(daysAgo: number): number {
  if (daysAgo === 0) return 1.0;
  if (daysAgo <= 3) return 0.85;
  if (daysAgo <= 7) return 0.7;
  return 0.5;
}

function difficultyWeight(difficulty: string): number {
  if (difficulty === 'hard') return 1.5;
  if (difficulty === 'medium') return 1.25;
  return 1.0; // easy or unknown
}

function baselineTime(difficulty: string): number {
  if (difficulty === 'hard') return 120;
  if (difficulty === 'medium') return 90;
  return 60; // easy
}

function toDateString(d: Date): string {
  return d.toISOString().split('T')[0];
}

// ─── Core compute ─────────────────────────────────────────────────────────────

/**
 * Read the learner-state signals for one window.
 *
 * READS ONLY. Snapshots and events are written by the snapshot system and the
 * backfill; a report must never write them, and must never derive a transition
 * of its own, or the two surfaces will eventually disagree about the same week.
 *
 * Failures are swallowed into null. A report that cannot reach the snapshot
 * tables should still be a report about questions, not a 500.
 */
async function readLearnerSignals(
  userId: string,
  client: SupabaseClient,
  startIso: string,
  startDay: string,
): Promise<LearnerSignals | null> {
  try {
    const countEvents = async (type: string) => {
      const { count } = await client
        .from('learner_events')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', userId)
        .eq('type', type)
        .gte('occurred_on', startDay);
      return count ?? 0;
    };

    const [improved, declined, resolved, added] = await Promise.all([
      countEvents('TOPIC_PERFORMANCE_IMPROVED'),
      countEvents('TOPIC_PERFORMANCE_DECLINED'),
      countEvents('PRIORITY_TOPIC_RESOLVED'),
      countEvents('PRIORITY_TOPIC_ADDED'),
    ]);

    // First-look recall over the window.
    //
    // TWO THINGS THIS GETS RIGHT, BOTH OF WHICH IT GOT WRONG FIRST.
    //
    // PAGINATION. The largest real account has 42,553 reviews and Supabase
    // returns 1,000 rows unasked. Ordered oldest-first, the unpaginated version
    // fetched the oldest thousand, saw nothing inside the window, and reported
    // zero cards reviewed for a student who had reviewed hundreds that week.
    //
    // THE LOOKBACK. Classifying a review as a first look only needs to know
    // whether the SAME card was seen in the preceding thirty minutes, so the
    // fetch starts one session gap before the window rather than at the
    // beginning of history. That is enough to classify every in-window review
    // correctly, and it means a report costs a few hundred rows instead of
    // forty thousand.
    const SESSION_GAP_MS = 30 * 60 * 1000;
    const lookbackIso = new Date(new Date(startIso).getTime() - SESSION_GAP_MS).toISOString();

    const reviews: { flashcard_id: string; cloze_index: number; rating: string; reviewed_at: string }[] = [];
    for (let from = 0; ; from += 1000) {
      const { data, error } = await client
        .from('flashcard_reviews')
        .select('flashcard_id, cloze_index, rating, reviewed_at')
        .eq('user_id', userId)
        .gte('reviewed_at', lookbackIso)
        // A stable order is required or pages overlap and skip.
        .order('reviewed_at', { ascending: true })
        .order('flashcard_id', { ascending: true })
        .range(from, from + 999);
      if (error || !data || data.length === 0) break;
      reviews.push(...(data as typeof reviews));
      if (data.length < 1000) break;
    }

    const lastSeen = new Map<string, number>();
    const distinct = new Set<string>();
    let firstLooks = 0;
    let firstLookHits = 0;
    reviews.forEach((row) => {
      const id = `${row.flashcard_id}:${row.cloze_index}`;
      const t = new Date(row.reviewed_at).getTime();
      const prev = lastSeen.get(id);
      const isFirstLook = prev === undefined || t - prev > SESSION_GAP_MS;
      lastSeen.set(id, t);
      if (row.reviewed_at < startIso) return;
      distinct.add(id);
      if (isFirstLook) {
        firstLooks++;
        // Again is the only grade that means retrieval failed.
        if (row.rating !== 'again') firstLookHits++;
      }
    });

    // Coverage from the snapshots at both ends of the window.
    const { data: snaps } = await client
      .from('learner_state_snapshots')
      .select('study_day, state')
      .eq('user_id', userId)
      .order('study_day', { ascending: true });

    const rows = (snaps ?? []) as { study_day: string; state: { coveragePercent?: number } }[];
    const latest = rows[rows.length - 1]?.state?.coveragePercent ?? null;
    const atStart = [...rows].reverse().find((r) => r.study_day <= startDay)?.state?.coveragePercent ?? null;

    return {
      cards_reviewed: distinct.size,
      first_looks: firstLooks,
      first_look_recall:
        firstLooks >= MIN_FIRST_LOOKS ? Math.round((firstLookHits / firstLooks) * 100) : null,
      topics_improved: improved,
      topics_declined: declined,
      priorities_resolved: resolved,
      priorities_added: added,
      coverage_percent: latest,
      coverage_delta: latest !== null && atStart !== null ? latest - atStart : null,
    };
  } catch {
    return null;
  }
}

export async function computeMetrics(
  userId: string,
  client: SupabaseClient,
  period: 'daily' | 'weekly',
  mcatTestDate?: string | null,
): Promise<ReportMetrics> {
  const now = new Date();
  const cutoffHours = period === 'daily' ? 24 : 24 * 7;
  const cutoff = new Date(now.getTime() - cutoffHours * 60 * 60 * 1000);

  const startDate = toDateString(cutoff);
  const endDate = toDateString(now);

  // Fetched alongside the attempt work rather than after it; the report waits
  // on the slower of the two instead of the sum.
  const learnerPromise = readLearnerSignals(userId, client, cutoff.toISOString(), startDate);

  // Fetch period attempts
  const { data: periodData, error: periodError } = await client
    .from('question_attempts')
    .select(`
      user_id, question_id, session_id, selected_answer, is_correct,
      time_spent_seconds, created_at,
      questions!inner(id, section, topic, subtopic, difficulty)
    `)
    .eq('user_id', userId)
    .gte('created_at', cutoff.toISOString());

  if (periodError) throw new Error(`Failed to fetch period attempts: ${periodError.message}`);

  const periodAttempts = (periodData ?? []) as unknown as RawAttempt[];

  // Fetch ALL historical attempts (for spaced repetition gap)
  const { data: histData, error: histError } = await client
    .from('question_attempts')
    .select(`
      user_id, question_id, is_correct, time_spent_seconds, created_at,
      questions!inner(id, section, topic, subtopic, difficulty)
    `)
    .eq('user_id', userId);

  if (histError) throw new Error(`Failed to fetch historical attempts: ${histError.message}`);

  const historicalAttempts = (histData ?? []) as unknown as RawAttempt[];

  // Build map: subtopic key → last practiced date from all history
  const lastPracticedMap = new Map<string, Date>();
  for (const a of historicalAttempts) {
    if (!a.questions) continue;
    const key = `${a.questions.section}::${a.questions.topic}::${a.questions.subtopic}`;
    const d = new Date(a.created_at);
    const existing = lastPracticedMap.get(key);
    if (!existing || d > existing) lastPracticedMap.set(key, d);
  }

  // Group period attempts by subtopic
  type AttemptGroup = {
    section: string;
    topic: string;
    subtopic: string;
    attempts: RawAttempt[];
  };

  const groupMap = new Map<string, AttemptGroup>();
  for (const a of periodAttempts) {
    if (!a.questions) continue;
    const key = `${a.questions.section}::${a.questions.topic}::${a.questions.subtopic}`;
    if (!groupMap.has(key)) {
      groupMap.set(key, {
        section: a.questions.section,
        topic: a.questions.topic,
        subtopic: a.questions.subtopic,
        attempts: [],
      });
    }
    groupMap.get(key)!.attempts.push(a);
  }

  const subtopics: SubtopicMetrics[] = [];

  for (const [key, group] of groupMap) {
    const { section, topic, subtopic, attempts: groupAttempts } = group;

    // ── The evidence floor ──────────────────────────────────────────────
    //
    // WAS 3, AND THAT WAS INDEFENSIBLE. A subtopic could be labelled
    // "Mastered" on three attempts and then handed to a language model that
    // wrote confident prose about it. Going 3 for 3 happens one time in eight
    // for a student who knows the material at 50%, so the report was
    // describing coin flips in the voice of a coach.
    //
    // MIN_ATTEMPTS_FOR_STATE is the same floor the learner model uses to say
    // anything about a topic at all. Sharing it means the report and the
    // dashboard cannot disagree about whether a topic is measurable, which
    // they previously could and did.
    //
    // "Mastered" is also gone as a label. Raw accuracy is not mastery, however
    // much of it there is; the band is now Strong.
    if (groupAttempts.length < MIN_ATTEMPTS_FOR_STATE) {
      const lastPracticed = lastPracticedMap.get(key);
      subtopics.push({
        section, topic, subtopic,
        attempts: groupAttempts.length,
        accuracy: 0,
        avg_time_seconds: 0,
        miss_frequency: 0,
        difficulty_adjusted_accuracy: 0,
        trend: 0,
        mastery_score: 0,
        struggle_score: 0,
        priority_score: 0,
        confidence_score: 0,
        spaced_repetition_gap_score: 0,
        days_since_last_practiced: lastPracticed
          ? Math.floor((now.getTime() - lastPracticed.getTime()) / 86400000)
          : 0,
        status: 'Insufficient Data',
        last_practiced: lastPracticed ? toDateString(lastPracticed) : '',
      });
      continue;
    }

    // Sort by created_at
    const sorted = [...groupAttempts].sort(
      (a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime(),
    );

    // Weighted accuracy
    let weightedCorrectSum = 0;
    let weightedTotalSum = 0;
    let timingWeightedBaseline = 0;
    let timingWeightedSum = 0;
    let totalTime = 0;

    for (const a of sorted) {
      const attemptDate = new Date(a.created_at);
      const daysAgo = Math.floor((now.getTime() - attemptDate.getTime()) / 86400000);
      const rw = recencyWeight(daysAgo);
      const dw = difficultyWeight(a.questions?.difficulty ?? 'easy');
      const w = rw * dw;
      weightedCorrectSum += (a.is_correct ? 1 : 0) * w;
      weightedTotalSum += w;
      totalTime += a.time_spent_seconds ?? 0;
      timingWeightedBaseline += baselineTime(a.questions?.difficulty ?? 'easy') * w;
      timingWeightedSum += w;
    }

    const weighted_accuracy = weightedTotalSum > 0
      ? (weightedCorrectSum / weightedTotalSum) * 100
      : 0;
    const avg_time_seconds = sorted.length > 0 ? totalTime / sorted.length : 0;

    // Difficulty-adjusted accuracy (medium + hard only, fallback to overall)
    const hardMedAttempts = sorted.filter(
      (a) => a.questions?.difficulty === 'medium' || a.questions?.difficulty === 'hard',
    );
    const difficulty_adjusted_accuracy = hardMedAttempts.length > 0
      ? (hardMedAttempts.filter((a) => a.is_correct).length / hardMedAttempts.length) * 100
      : weighted_accuracy;

    // Trend: first half vs second half accuracy
    const half = Math.floor(sorted.length / 2);
    const firstHalf = sorted.slice(0, half);
    const secondHalf = sorted.slice(half);
    const firstAcc = firstHalf.length > 0
      ? (firstHalf.filter((a) => a.is_correct).length / firstHalf.length) * 100
      : 0;
    const secondAcc = secondHalf.length > 0
      ? (secondHalf.filter((a) => a.is_correct).length / secondHalf.length) * 100
      : 0;
    const trend = clamp(secondAcc - firstAcc, -100, 100);

    // Consistency: std dev of daily accuracy
    const dailyMap = new Map<string, { total: number; correct: number }>();
    for (const a of sorted) {
      const day = toDateString(new Date(a.created_at));
      const d = dailyMap.get(day) ?? { total: 0, correct: 0 };
      d.total++;
      if (a.is_correct) d.correct++;
      dailyMap.set(day, d);
    }
    const dailyAccuracies = Array.from(dailyMap.values()).map(
      (d) => (d.total > 0 ? (d.correct / d.total) * 100 : 0),
    );
    const consistency = Math.max(0, 100 - stdDev(dailyAccuracies));

    // Miss frequency
    const wrongCount = sorted.filter((a) => !a.is_correct).length;
    const miss_frequency = (wrongCount / sorted.length) * 100;

    // Timing difficulty
    const weightedBaseline = timingWeightedSum > 0 ? timingWeightedBaseline / timingWeightedSum : 60;
    const timingRatio = weightedBaseline > 0 ? avg_time_seconds / weightedBaseline : 1;
    const timing_difficulty = clamp((timingRatio - 1) * 100, 0, 100);

    // Mastery score
    const mastery_score = clamp(
      0.45 * weighted_accuracy +
      0.20 * ((trend + 100) / 2) +
      0.15 * difficulty_adjusted_accuracy +
      0.20 * consistency,
      0, 100,
    );

    // Struggle score
    const negative_trend = Math.max(0, -trend);
    const struggle_score = clamp(
      0.40 * (100 - weighted_accuracy) +
      0.25 * timing_difficulty +
      0.20 * miss_frequency +
      0.15 * negative_trend,
      0, 100,
    );

    // Confidence score
    const firstHalfAvgTime = firstHalf.length > 0
      ? firstHalf.reduce((s, a) => s + (a.time_spent_seconds ?? 0), 0) / firstHalf.length
      : 0;
    const secondHalfAvgTime = secondHalf.length > 0
      ? secondHalf.reduce((s, a) => s + (a.time_spent_seconds ?? 0), 0) / secondHalf.length
      : 0;
    const firstMissRate = firstHalf.length > 0
      ? firstHalf.filter((a) => !a.is_correct).length / firstHalf.length
      : 0;
    const secondMissRate = secondHalf.length > 0
      ? secondHalf.filter((a) => !a.is_correct).length / secondHalf.length
      : 0;

    const accuracy_improvement = clamp(Math.max(0, secondAcc - firstAcc), 0, 100);
    const miss_reduction = clamp(Math.max(0, firstMissRate - secondMissRate) * 100, 0, 100);
    const timing_improvement = firstHalfAvgTime > 0
      ? clamp(Math.max(0, (firstHalfAvgTime - secondHalfAvgTime) / firstHalfAvgTime * 100), 0, 100)
      : 0;
    const confidence_score = clamp(
      0.50 * accuracy_improvement + 0.25 * miss_reduction + 0.25 * timing_improvement,
      0, 100,
    );

    // Spaced repetition gap score
    const lastPracticed = lastPracticedMap.get(key);
    const days_since_last_practiced = lastPracticed
      ? Math.floor((now.getTime() - lastPracticed.getTime()) / 86400000)
      : 0;
    const forgetting_factor = 1 - (mastery_score / 100);
    const spaced_repetition_gap_score = clamp(
      days_since_last_practiced * forgetting_factor * 10,
      0, 100,
    );

    // Priority score
    const recency_frequency = clamp((sorted.length / 10) * 100, 0, 100);
    const priority_score = clamp(
      0.45 * struggle_score +
      0.25 * spaced_repetition_gap_score +
      0.15 * recency_frequency +
      0.15 * (100 - confidence_score),
      0, 100,
    );

    // Status
    let status: SubtopicMetrics['status'];
    if (mastery_score >= 85) {
      status = 'Strong';
    } else if (mastery_score >= 70) {
      status = 'Stable';
    } else if (mastery_score >= 55) {
      status = 'Developing';
    } else if (mastery_score >= 40) {
      status = 'Struggling';
    } else {
      status = 'Critical';
    }
    // Override if struggle_score > 70
    if (struggle_score > 70 && status !== 'Critical') {
      status = 'Critical';
    }

    subtopics.push({
      section,
      topic,
      subtopic,
      attempts: sorted.length,
      accuracy: Math.round(weighted_accuracy),
      avg_time_seconds: Math.round(avg_time_seconds),
      miss_frequency: Math.round(miss_frequency),
      difficulty_adjusted_accuracy: Math.round(difficulty_adjusted_accuracy),
      trend: Math.round(trend),
      mastery_score: Math.round(mastery_score),
      struggle_score: Math.round(struggle_score),
      priority_score: Math.round(priority_score),
      confidence_score: Math.round(confidence_score),
      spaced_repetition_gap_score: Math.round(spaced_repetition_gap_score),
      days_since_last_practiced,
      status,
      last_practiced: lastPracticed ? toDateString(lastPracticed) : '',
    });
  }

  // Top priority: Struggling or Critical, highest priority_score, tie-break gap_score
  const candidates = subtopics.filter(
    (s) => s.status === 'Struggling' || s.status === 'Critical',
  );
  candidates.sort((a, b) => {
    if (b.priority_score !== a.priority_score) return b.priority_score - a.priority_score;
    return b.spaced_repetition_gap_score - a.spaced_repetition_gap_score;
  });
  const top_priority_raw = candidates[0] ?? null;

  let top_priority: SubtopicMetrics | null = null;
  if (top_priority_raw) {
    const reason = `${top_priority_raw.days_since_last_practiced} days without practice, mastery at ${top_priority_raw.mastery_score}%`;
    top_priority = { ...top_priority_raw, top_priority_reason: reason };
  }

  // Section breakdown
  const section_breakdown: Record<string, { attempts: number; accuracy: number }> = {};
  for (const a of periodAttempts) {
    if (!a.questions) continue;
    const sec = a.questions.section;
    if (!section_breakdown[sec]) section_breakdown[sec] = { attempts: 0, accuracy: 0 };
    section_breakdown[sec].attempts++;
  }
  // Compute accuracy per section
  const sectionCorrect: Record<string, number> = {};
  for (const a of periodAttempts) {
    if (!a.questions) continue;
    const sec = a.questions.section;
    if (!sectionCorrect[sec]) sectionCorrect[sec] = 0;
    if (a.is_correct) sectionCorrect[sec]++;
  }
  for (const sec of Object.keys(section_breakdown)) {
    const total = section_breakdown[sec].attempts;
    const correct = sectionCorrect[sec] ?? 0;
    section_breakdown[sec].accuracy = total > 0 ? Math.round((correct / total) * 100) : 0;
  }

  // Overall accuracy
  const total_questions = periodAttempts.length;
  const total_correct = periodAttempts.filter((a) => a.is_correct).length;
  const overall_accuracy = total_questions > 0
    ? Math.round((total_correct / total_questions) * 100)
    : 0;

  // Avg time
  const avg_time_seconds = total_questions > 0
    ? Math.round(periodAttempts.reduce((s, a) => s + (a.time_spent_seconds ?? 0), 0) / total_questions)
    : 0;

  // Days studied
  const daysSet = new Set(periodAttempts.map((a) => toDateString(new Date(a.created_at))));
  const days_studied = daysSet.size;

  // Exam days remaining
  let exam_days_remaining: number | null = null;
  if (mcatTestDate) {
    const testDate = new Date(mcatTestDate + 'T00:00:00');
    const diff = Math.floor((testDate.getTime() - now.getTime()) / 86400000);
    exam_days_remaining = diff >= 0 ? diff : null;
  }

  const learner = await learnerPromise;

  return {
    period,
    start_date: startDate,
    end_date: endDate,
    total_questions,
    overall_accuracy,
    avg_time_seconds,
    subtopics,
    struggling: subtopics.filter((s) => s.status === 'Struggling' || s.status === 'Critical'),
    strong: subtopics.filter((s) => s.status === 'Strong' || s.status === 'Stable'),
    top_priority,
    section_breakdown,
    days_studied,
    exam_days_remaining,
    learner,
  };
}

// ─── Convenience wrappers ─────────────────────────────────────────────────────

export async function computeDailyMetrics(
  userId: string,
  client: SupabaseClient,
  mcatTestDate?: string | null,
): Promise<ReportMetrics> {
  return computeMetrics(userId, client, 'daily', mcatTestDate);
}

export async function computeWeeklyMetrics(
  userId: string,
  client: SupabaseClient,
  mcatTestDate?: string | null,
): Promise<ReportMetrics> {
  return computeMetrics(userId, client, 'weekly', mcatTestDate);
}
