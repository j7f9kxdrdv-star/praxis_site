import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { computeWeeklyMetrics } from '@/lib/reports/metrics';
import { generateReport } from '@/lib/reports/generate';

export async function POST(req: NextRequest) {
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: 'Invalid JSON body' }, { status: 400 });
  }

  const { userId, accessToken } = body as Record<string, unknown>;

  if (!userId || typeof userId !== 'string') {
    return NextResponse.json({ error: 'Missing or invalid userId' }, { status: 400 });
  }
  if (!accessToken || typeof accessToken !== 'string') {
    return NextResponse.json({ error: 'Missing or invalid accessToken' }, { status: 400 });
  }

  try {
    // Build a user-auth Supabase client
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL!;
    const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;
    const client = createClient(url, anonKey, {
      global: { headers: { Authorization: 'Bearer ' + accessToken } },
    });

    const { data: profile } = await client
      .from('profiles')
      .select('mcat_test_date')
      .eq('id', userId)
      .single();

    const mcatTestDate = (profile as { mcat_test_date?: string } | null)?.mcat_test_date ?? null;

    // Compute metrics
    const metrics = await computeWeeklyMetrics(userId, client, mcatTestDate);

    // Generate AI report
    const report_text = await generateReport(metrics);

    // Save to performance_reports
    await client.from('performance_reports').insert({
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

    return NextResponse.json({
      report_text,
      metrics,
      top_priority: metrics.top_priority,
    });
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    console.error('[weekly report]', err);
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
