import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { computeWeeklyMetrics } from '@/lib/reports/metrics';
import { generateReport } from '@/lib/reports/generate';

export const maxDuration = 300;

export async function GET(req: NextRequest) {
  const auth = req.headers.get('authorization');
  if (auth !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL!;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY!;
  const adminClient = createClient(url, serviceRoleKey);

  const sevenDaysAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString();

  // Distinct user_ids with activity in the last 7 days
  const { data: attemptRows, error: attemptErr } = await adminClient
    .from('question_attempts')
    .select('user_id')
    .gte('created_at', sevenDaysAgo);

  if (attemptErr) {
    return NextResponse.json(
      { error: `Failed to fetch recent attempts: ${attemptErr.message}` },
      { status: 500 },
    );
  }

  const userIds = Array.from(
    new Set(((attemptRows ?? []) as { user_id: string }[]).map((r) => r.user_id)),
  );

  let succeeded = 0;
  let failed = 0;
  const errors: string[] = [];

  for (const userId of userIds) {
    try {
      const { data: profile } = await adminClient
        .from('profiles')
        .select('mcat_test_date')
        .eq('id', userId)
        .single();

      const mcatTestDate =
        (profile as { mcat_test_date?: string } | null)?.mcat_test_date ?? null;

      const metrics = await computeWeeklyMetrics(userId, adminClient, mcatTestDate);

      if (metrics.total_questions === 0) {
        continue;
      }

      const report_text = await generateReport(metrics);

      const { error: insertErr } = await adminClient
        .from('performance_reports')
        .insert({
          user_id: userId,
          report_type: 'weekly',
          start_date: metrics.start_date,
          end_date: metrics.end_date,
          raw_metrics_json: metrics,
          report_text,
          top_priority_subtopic: metrics.top_priority?.subtopic ?? null,
          top_priority_section: metrics.top_priority?.section ?? null,
          top_priority_reason: metrics.top_priority?.top_priority_reason ?? null,
        });

      if (insertErr) throw new Error(insertErr.message);

      succeeded++;
    } catch (err: unknown) {
      failed++;
      const msg = err instanceof Error ? err.message : String(err);
      errors.push(`${userId}: ${msg}`);
      console.error('[cron weekly]', userId, err);
    }
  }

  return NextResponse.json({
    succeeded,
    failed,
    errors,
    total_users: userIds.length,
  });
}
