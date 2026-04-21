import Anthropic from '@anthropic-ai/sdk';
import { buildDailyPrompt, buildWeeklyPrompt } from './prompts';
import type { ReportMetrics } from './metrics';

const client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });

export async function generateReport(metrics: ReportMetrics): Promise<string> {
  const prompt = metrics.period === 'daily'
    ? buildDailyPrompt(metrics)
    : buildWeeklyPrompt(metrics);

  const message = await client.messages.create({
    model: 'claude-opus-4-5',
    max_tokens: 1024,
    system: [
      {
        type: 'text',
        text: `You are a direct, no-fluff MCAT study coach. You write concise diagnostic reports based on structured performance data. You never invent numbers. You never use motivational language. You only reference the data you are given.`,
        cache_control: { type: 'ephemeral' },
      },
    ],
    messages: [{ role: 'user', content: prompt }],
  });

  const block = message.content[0];
  return block.type === 'text' ? block.text : '';
}
