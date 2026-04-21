import type { SupabaseClient } from "@supabase/supabase-js";

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
  status: 'Mastered' | 'Stable' | 'Developing' | 'Struggling' | 'Critical' | 'Insufficient Data';
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
  strong: SubtopicMetrics[];       // status = Mastered or Stable
  top_priority: SubtopicMetrics | null;
  section_breakdown: Record<string, { attempts: number; accuracy: number }>;
  days_studied: number;
  exam_days_remaining: number | null;
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

    if (groupAttempts.length < 3) {
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
      status = 'Mastered';
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
    const reason = `${top_priority_raw.days_since_last_practiced} days without practice — mastery at ${top_priority_raw.mastery_score}%`;
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

  return {
    period,
    start_date: startDate,
    end_date: endDate,
    total_questions,
    overall_accuracy,
    avg_time_seconds,
    subtopics,
    struggling: subtopics.filter((s) => s.status === 'Struggling' || s.status === 'Critical'),
    strong: subtopics.filter((s) => s.status === 'Mastered' || s.status === 'Stable'),
    top_priority,
    section_breakdown,
    days_studied,
    exam_days_remaining,
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
