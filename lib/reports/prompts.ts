import type { ReportMetrics, LearnerSignals } from './metrics';

// Shared system prompt text — referenced in generate.ts but also embedded in user prompt
// for single-call context clarity
const SYSTEM_PROMPT_NOTE = `You are a direct, no-fluff MCAT study coach. You write concise diagnostic reports based on structured performance data. You never invent numbers. You never use motivational language. You only reference the data you are given.

WRITING STYLE, NON-NEGOTIABLE: never use an em dash or an en dash. Use a period, comma, colon, or semicolon instead, or rewrite the sentence. This applies to ranges too: write "2 to 3", never "2-3" with a dash character. Dashes read as machine-written and this report goes to a student.`;

/**
 * Drop transition counts that are zero.
 *
 * A count of zero is the absence of an observation, not an observation. Sending
 * it invites a sentence about nothing having happened, which is how a thin week
 * gets padded into a full-looking report.
 *
 * Measures are kept even at zero: "cards reviewed: 0" is a real fact about the
 * week. Only the four transition counts are stripped.
 */
function stripZeroTransitions(l: LearnerSignals): Partial<LearnerSignals> {
  const out: Partial<LearnerSignals> = { ...l };
  const transitions = [
    'topics_improved',
    'topics_declined',
    'priorities_resolved',
    'priorities_added',
  ] as const;
  for (const k of transitions) {
    if (out[k] === 0) delete out[k];
  }
  return out;
}

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
    // Read from the snapshot system, never recomputed here.
    //
    // ZERO TRANSITIONS ARE STRIPPED, NOT JUST DISCOURAGED. The prompt asked
    // the model to omit them and the first real report still wrote "No topics
    // improved or declined. No priorities were resolved or added." An
    // instruction the model can decline is not a guarantee; a field that is
    // absent cannot be reported. Counts that are genuinely zero carry no
    // information, and a report listing four kinds of nothing reads as though
    // the week were being padded.
    learner: metrics.learner ? stripZeroTransitions(metrics.learner) : null,
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

${metrics.total_questions < 10 ? 'NOTE: Fewer than 10 questions were answered today. Data is limited and conclusions should be treated as preliminary.\n' : ''}

Performance data (JSON):
${JSON.stringify(safeMetrics, null, 2)}

Write the report with exactly these four sections:

**1. Daily Summary**
2 to 3 sentences. Include: accuracy percentage, number of questions answered, and the single most notable finding (top win or top concern).

**2. Weakest Areas Today**
List ALL subtopics with status "Struggling" or "Critical". For each, include the subtopic name, status, mastery score, and one sentence on why it matters for MCAT performance. If there are no struggling/critical subtopics, state "No struggling areas identified in today's data."

**3. Timing Insight**
Only include this section if the avg_time_seconds is notably high (>110 seconds average) or notably low (<45 seconds average). If neither, write "Timing is within normal range."

**4. What to Focus on Next**
One specific recommendation for the next study session. Name the exact subtopic to target, the difficulty level to work at, and why. Do not give generic advice.

**Memory and change**
Use ONLY the "learner" block, and only if it is present.
- If cards_reviewed is above zero, state it, and state first_look_recall if it is not null. first_look_recall is the share of SESSION-FIRST views of a card that were recalled. A session-first view is the first time a card is seen in a sitting, NOT the first time it has ever been seen: most are cards reviewed many times before. Do not describe it as performance on new or first-time material. It is NOT a test score and must not be called accuracy or mastery.
- If topics_improved, priorities_resolved, priorities_added or topics_declined are above zero, state them plainly. These are recorded state transitions, so they are facts, not inferences. Never report a transition that is zero as though it were an observation; simply omit it.
- If "learner" is null or every field is zero, omit this section entirely rather than writing that nothing changed.
Do not connect flashcard recall to a predicted MCAT score. Recall and applied performance are separate measures and this report must not merge them.

Maximum 350 words total. Use plain text formatting (no markdown bold, no bullet symbols beyond a plain hyphen).`;
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
    // Read from the snapshot system, never recomputed here.
    //
    // ZERO TRANSITIONS ARE STRIPPED, NOT JUST DISCOURAGED. The prompt asked
    // the model to omit them and the first real report still wrote "No topics
    // improved or declined. No priorities were resolved or added." An
    // instruction the model can decline is not a guarantee; a field that is
    // absent cannot be reported. Counts that are genuinely zero carry no
    // information, and a report listing four kinds of nothing reads as though
    // the week were being padded.
    learner: metrics.learner ? stripZeroTransitions(metrics.learner) : null,
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

${metrics.total_questions < 10 ? 'NOTE: Fewer than 10 questions were answered this week. Data is limited.\n' : ''}

Performance data (JSON):
${JSON.stringify(safeMetrics, null, 2)}

Write the report with exactly these six sections:

**1. Weekly Performance Summary**
State the accuracy, total questions answered, days studied, and any notable trend visible in the data. If exam_days_remaining is present, note how much time remains.

**2. Strongest Areas**
List all subtopics with status "Strong" or "Stable". Include the subtopic name and accuracy. Do NOT describe any of them as mastered: these are accuracy bands on practice questions, not evidence of mastery. If none, write "No subtopics reached a strong or stable band this week."

**3. Weakest Topics**
List ALL subtopics with status "Struggling" or "Critical". For each, include: subtopic name, status, mastery score, priority score, gap score context (days since last practiced), and one sentence on the specific weakness. If none, write "No struggling topics this week."

**4. Timing and Behavior Insight**
Comment on the average time per question. If avg_time_seconds > 110, flag it as a pacing issue. If < 45, flag potential rushing. Otherwise note timing is acceptable. Comment on consistency (days_studied vs 7 days in the week).

**5. What Changed This Week**
Use ONLY the "learner" block, and only if it is present.
- State cards_reviewed and, when it is not null, first_look_recall. first_look_recall is the share of SESSION-FIRST views of a card that were recalled. A session-first view is the first time a card is seen in a sitting, NOT the first time it has ever been seen: most are cards reviewed many times before. Do not describe it as performance on new or first-time material. It is NOT a test score and must not be called accuracy or mastery.
- State coverage_delta as percentage points of the question bank newly encountered, if it is not null. Coverage is how much material has been SEEN. Never describe it as material learned or mastered.
- State topics_improved, topics_declined, priorities_resolved and priorities_added where each is above zero. These are recorded state transitions, so they are facts. Omit any that are zero rather than reporting an absence.
- Close with one or two sentences interpreting the week: what moved, what did not, and which of the two is more informative. Name specific topics. Do not praise, do not encourage, and do not predict a score.
- If "learner" is null or every field is zero, omit this section entirely.
Do not connect flashcard recall to a predicted MCAT score. Recall and applied performance are separate measures and this report must not merge them.

**6. Study Plan for Next Week**
3 to 5 bullet points. Each bullet must name a specific subtopic from the data, the difficulty level to target (easy/medium/hard), and a brief rationale. Prioritize the highest-priority struggling topics. Where the learner block shows a priority that was ADDED this week, prefer it. Do not give generic advice.

Maximum 500 words total. Use plain text formatting (no markdown bold, use a plain hyphen for bullets).`;
}
