import Anthropic from '@anthropic-ai/sdk';
import { buildDailyPrompt, buildWeeklyPrompt } from './prompts';
import type { ReportMetrics } from './metrics';

const client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });

/**
 * Pull the prose out of a model response.
 *
 * SEPARATED SO IT CAN BE TESTED WITHOUT AN API CALL, because the bug it fixes
 * was invisible until a real generation ran: Opus 5 returns a thinking block
 * ahead of its answer, the old code read content[0], found a non-text block,
 * and returned an empty string. The route then saved a blank report and
 * reported success.
 */
export function extractText(
  content: { type: string; text?: string }[],
): string {
  return content
    .filter((b) => b.type === 'text' && typeof b.text === 'string')
    .map((b) => b.text as string)
    .join('')
    .trim();
}

export async function generateReport(metrics: ReportMetrics): Promise<string> {
  const prompt = metrics.period === 'daily'
    ? buildDailyPrompt(metrics)
    : buildWeeklyPrompt(metrics);

  const message = await client.messages.create({
    // Opus 5. The rest of the app (diagnoseCard, auditVisibleAnswer) was
    // already here; reports were the one module left a generation behind.
    model: 'claude-opus-5',
    // THINKING TOKENS COUNT AGAINST THIS. The first Opus 5 run spent 385
    // tokens thinking and then hit the 1,024 ceiling partway through section
    // five, so the report was silently truncated mid-sentence. A five hundred
    // word report is roughly 700 tokens and the reasoning is on top of that.
    // Reports are generated rarely, so the headroom costs nothing.
    max_tokens: 4096,
    system: [
      {
        type: 'text',
        text: `You are a direct, no-fluff MCAT study coach. You write concise diagnostic reports based on structured performance data. You never invent numbers. You never use motivational language. You only reference the data you are given.`,
        cache_control: { type: 'ephemeral' },
      },
    ],
    messages: [{ role: 'user', content: prompt }],
  });

  const text = extractText(message.content as { type: string; text?: string }[]);

  // An empty generation is a failure, not a report. Throwing sends it to the
  // route's catch, which returns a 500; returning '' persisted a blank row and
  // told the student everything was fine.
  if (!text) {
    throw new Error(
      `Report generation returned no text (stop_reason: ${message.stop_reason}, blocks: ${message.content
        .map((b) => b.type)
        .join(',')})`,
    );
  }

  // Truncation is silent otherwise: the report simply stops mid-sentence and
  // looks like the model had nothing more to say.
  if (message.stop_reason === 'max_tokens') {
    console.warn('[report] hit max_tokens; the report is truncated');
  }

  return text;
}
