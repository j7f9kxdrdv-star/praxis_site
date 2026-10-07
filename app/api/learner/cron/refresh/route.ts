// ─── The scheduled current-state refresh ────────────────────────────────────
//
// GET /api/learner/cron/refresh          refresh every account
// GET /api/learner/cron/refresh?dry=1    compute and report, write nothing
// GET /api/learner/cron/refresh?force=1  ignore the recency guard
//
// Authenticated the way this project already authenticates crons: a bearer
// CRON_SECRET, checked before anything else happens. A learner cannot reach
// this, and neither can an anonymous caller — an all-account refresh is far
// too expensive to leave triggerable by whoever finds the URL.
//
// The orchestration lives in lib/learner/refreshRun.ts so the scheduled job
// and a manual operator invocation run exactly the same code. A cron route
// that works and an operator script that does something slightly different is
// how the two drift until only one of them is right.

import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { runRefresh, runSucceeded } from "@/lib/learner/refreshRun";

// The weekly report cron's limit, for the same reason: this is a batch job and
// the platform's default request budget is not meant for one.
export const maxDuration = 300;

export async function GET(req: NextRequest) {
  const auth = req.headers.get("authorization");
  if (!process.env.CRON_SECRET || auth !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceRoleKey) {
    return NextResponse.json({ error: "Server is not configured." }, { status: 500 });
  }

  // The admin API is needed to enumerate auth.users, which is the canonical
  // account universe and is not reachable through PostgREST at all.
  const db = createClient(url, serviceRoleKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  try {
    const report = await runRefresh(db, {
      dryRun: req.nextUrl.searchParams.get("dry") === "1",
      force: req.nextUrl.searchParams.get("force") === "1",
    });

    // FAIL LOUDLY. A non-2xx is what makes a broken run visible in the
    // platform's own cron history without anyone building a notifier: an
    // integrity failure or a single failed account must never answer 200.
    if (report.outcome === "INTEGRITY_FAILURE") {
      console.error("[cron refresh] ACCOUNT UNIVERSE INTEGRITY FAILURE", report.integrityFailures);
      return NextResponse.json(report, { status: 500 });
    }
    if (report.failed > 0) {
      for (const a of report.accounts.filter((x) => x.error)) {
        console.error("[cron refresh]", a.userId, a.stage, a.error);
      }
      return NextResponse.json(report, { status: 500 });
    }
    console.log("[cron refresh]", JSON.stringify({
      runId: report.runId, outcome: report.outcome, accounts: report.attempted,
      states: report.statesComputed, zeroState: report.zeroState, ms: report.durationMs,
    }));
    return NextResponse.json(report, { status: runSucceeded(report) || report.outcome === "ALREADY_RUNNING" ? 200 : 500 });
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    console.error("[cron refresh] run threw", message);
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
