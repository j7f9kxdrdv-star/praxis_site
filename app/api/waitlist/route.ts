import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { sendWaitlistWelcome } from "@/lib/email/welcome";

/**
 * Public waitlist signup endpoint.
 *
 * POST /api/waitlist  { email: string, source?: string }
 *
 * Inserts into the `waitlist_signups` table. Idempotent on email — if the
 * address is already in the list we return success quietly (so the UI shows
 * the same "you're on the list" state and we don't leak existence of an
 * email).
 */

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export async function POST(req: NextRequest) {
  let body: { email?: string; source?: string };
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid request body." }, { status: 400 });
  }

  const email = (body.email ?? "").trim().toLowerCase();
  if (!email || !EMAIL_RE.test(email) || email.length > 254) {
    return NextResponse.json(
      { error: "Please enter a valid email address." },
      { status: 400 }
    );
  }

  const source = (body.source ?? "coming_soon").slice(0, 64);
  const userAgent = req.headers.get("user-agent")?.slice(0, 512) ?? null;

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !anonKey) {
    return NextResponse.json(
      { error: "Server misconfigured. Try again later." },
      { status: 500 }
    );
  }

  const supabase = createClient(url, anonKey);

  const { error } = await supabase
    .from("waitlist_signups")
    .insert({ email, source, user_agent: userAgent });

  if (error) {
    // Postgres unique-violation = already on list. Treat as success — don't
    // resend the welcome email (they've already had it).
    if (error.code === "23505") {
      return NextResponse.json({ ok: true, alreadyOnList: true });
    }
    console.error("waitlist insert failed:", error);
    return NextResponse.json(
      { error: "Could not save your email. Please try again." },
      { status: 500 }
    );
  }

  // Fire-and-forget: don't await, don't fail the signup if email send fails.
  // sendWaitlistWelcome handles its own errors internally and never throws.
  void sendWaitlistWelcome(email);

  return NextResponse.json({ ok: true });
}
