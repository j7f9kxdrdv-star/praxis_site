import type { ReportMetrics } from './metrics';

// Shared system prompt text — referenced in generate.ts but also embedded in user prompt
// for single-call context clarity
const SYSTEM_PROMPT_NOTE = `You are a direct, no-fluff MCAT study coach. You write concise diagnostic reports based on structured performance data. You never invent numbers. You never use motivational language. You only reference the data you are given.`;

export function buildDailyPrompt(metrics: ReportMetrics): string {
  const safeMetrics = {
    period: metrics.period,
    start_date: metrics.start_date,
    end_date: metrics.end_date,
    total_questions: metrics.total_questions,
    overall_accuracy: metrics.overall_accuracy,
    avg_time_seconds: metrics.avg_time_seconds,
    days_studied: metrics.days_studied,
    exam_days_remaining: metrics.exam_days_remaining,
    section_breakdown: metrics.section_breakdown,
    struggling: metrics.struggling.map((s) => ({
      section: s.section,
      subtopic: s.subtopic,
      status: s.status,
      mastery_score: s.mastery_score,
      struggle_score: s.struggle_score,
      accuracy: s.accuracy,
      attempts: s.attempts,
      trend: s.trend,
      miss_frequency: s.miss_frequency,
      avg_time_seconds: s.avg_time_seconds,
      days_since_last_practiced: s.days_since_last_practiced,
    })),
    strong: metrics.strong.map((s) => ({
      section: s.section,
      subtopic: s.subtopic,
      status: s.status,
      mastery_score: s.mastery_score,
      accuracy: s.accuracy,
      attempts: s.attempts,
    })),
    top_priority: metrics.top_priority
      ? {
          subtopic: metrics.top_priority.subtopic,
          section: metrics.top_priority.section,
          status: metrics.top_priority.status,
          mastery_score: metrics.top_priority.mastery_score,
          priority_score: metrics.top_priority.priority_score,
          struggle_score: metrics.top_priority.struggle_score,
          days_since_last_practiced: metrics.top_priority.days_since_last_practiced,
          top_priority_reason: metrics.top_priority.top_priority_reason,
        }
      : null,
  };

  return `${SYSTEM_PROMPT_NOTE}

Write a daily MCAT performance report using ONLY the data below. Do not invent numbers. Do not use motivational language. Write like a coach, not a cheerleader.

${metrics.total_questions < 10 ? 'NOTE: Fewer than 10 questions were answered today — data is limited and conclusions should be treated as preliminary.\n' : ''}

Performance data (JSON):
${JSON.stringify(safeMetrics, null, 2)}

Write the report with exactly these four sections:

**1. Daily Summary**
2–3 sentences. Include: accuracy percentage, number of questions answered, and the single most notable finding (top win or top concern).

**2. Weakest Areas Today**
List ALL subtopics with status "Struggling" or "Critical". For each, include the subtopic name, status, mastery score, and one sentence on why it matters for MCAT performance. If there are no struggling/critical subtopics, state "No struggling areas identified in today's data."

**3. Timing Insight**
Only include this section if the avg_time_seconds is notably high (>110 seconds average) or notably low (<45 seconds average). If neither, write "Timing is within normal range."

**4. What to Focus on Next**
One specific recommendation for the next study session. Name the exact subtopic to target, the difficulty level to work at, and why. Do not give generic advice.

Maximum 350 words total. Use plain text formatting (no markdown bold, no bullet symbols beyond dashes).`;
}

export function buildWeeklyPrompt(metrics: ReportMetrics): string {
  const safeMetrics = {
    period: metrics.period,
    start_date: metrics.start_date,
    end_date: metrics.end_date,
    total_questions: metrics.total_questions,
    overall_accuracy: metrics.overall_accuracy,
    avg_time_seconds: metrics.avg_time_seconds,
    days_studied: metrics.days_studied,
    exam_days_remaining: metrics.exam_days_remaining,
    section_breakdown: metrics.section_breakdown,
    struggling: metrics.struggling.map((s) => ({
      section: s.section,
      subtopic: s.subtopic,
      status: s.status,
      mastery_score: s.mastery_score,
      struggle_score: s.struggle_score,
      priority_score: s.priority_score,
      accuracy: s.accuracy,
      attempts: s.attempts,
      trend: s.trend,
      miss_frequency: s.miss_frequency,
      avg_time_seconds: s.avg_time_seconds,
      days_since_last_practiced: s.days_since_last_practiced,
      spaced_repetition_gap_score: s.spaced_repetition_gap_score,
    })),
    strong: metrics.strong.map((s) => ({
      section: s.section,
      subtopic: s.subtopic,
      status: s.status,
      mastery_score: s.mastery_score,
      accuracy: s.accuracy,
      attempts: s.attempts,
    })),
    top_priority: metrics.top_priority
      ? {
          subtopic: metrics.top_priority.subtopic,
          section: metrics.top_priority.section,
          status: metrics.top_priority.status,
          mastery_score: metrics.top_priority.mastery_score,
          priority_score: metrics.top_priority.priority_score,
          struggle_score: metrics.top_priority.struggle_score,
          days_since_last_practiced: metrics.top_priority.days_since_last_practiced,
          top_priority_reason: metrics.top_priority.top_priority_reason,
        }
      : null,
  };

  return `${SYSTEM_PROMPT_NOTE}

Write a weekly MCAT performance report using ONLY the data below. Do not invent numbers. Do not use motivational language. Write like a coach, not a cheerleader.

${metrics.total_questions < 10 ? 'NOTE: Fewer than 10 questions were answered this week — data is limited.\n' : ''}

Performance data (JSON):
${JSON.stringify(safeMetrics, null, 2)}

Write the report with exactly these five sections:

**1. Weekly Performance Summary**
State the accuracy, total questions answered, days studied, and any notable trend visible in the data. If exam_days_remaining is present, note how much time remains.

**2. Strongest Areas**
List all subtopics with status "Mastered" or "Stable". Include the subtopic name, mastery score, and accuracy. If none, write "No mastered or stable subtopics identified this week."

**3. Weakest Topics**
List ALL subtopics with status "Struggling" or "Critical". For each, include: subtopic name, status, mastery score, priority score, gap score context (days since last practiced), and one sentence on the specific weakness. If none, write "No struggling topics this week."

**4. Timing and Behavior Insight**
Comment on the average time per question. If avg_time_seconds > 110, flag it as a pacing issue. If < 45, flag potential rushing. Otherwise note timing is acceptable. Comment on consistency (days_studied vs 7 days in the week).

**5. Study Plan for Next Week**
3–5 bullet points. Each bullet must name a specific subtopic from the data, the difficulty level to target (easy/medium/hard), and a brief rationale. Prioritize the highest-priority struggling topics. Do not give generic advice.

Maximum 500 words total. Use plain text formatting (no markdown bold, use dashes for bullets).`;
}
