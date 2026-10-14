/**
 * Exchanges the bearer token the app already holds for a cookie the browser
 * will actually send with an `<img>` request.
 *
 * This endpoint is the only place an image session is created, and it creates
 * one only after Supabase has confirmed the token. The user id is taken from
 * what Supabase returns, never from the request body, so a caller cannot ask
 * for a session belonging to somebody else.
 *
 * It deliberately does NOT check entitlement. The cookie says who you are; the
 * illustration route decides what you may see, every time it is asked, so a
 * subscription that ends stops working on the next image rather than whenever
 * this cookie happens to lapse. See lib/flashcards/entitlement.ts.
 *
 * DELETE clears the cookie, for sign-out.
 */
import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import {
  clearImageSessionCookie,
  imageSessionCookie,
  mintImageSession,
} from "@/lib/flashcards/imageSession";

function isSecure(request: Request): boolean {
  const proto = request.headers.get("x-forwarded-proto");
  if (proto) return proto.split(",")[0].trim() === "https";
  return new URL(request.url).protocol === "https:";
}

export async function POST(request: Request) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const secret = process.env.IMAGE_SESSION_SECRET;

  if (!url || !anonKey || !secret) {
    // Including the secret: without it nothing can be minted, and a server
    // that cannot mint must say so rather than hand back something useless.
    return NextResponse.json({ error: "Image sessions are not configured." }, { status: 500 });
  }

  const authHeader = request.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) return NextResponse.json({ error: "Not signed in." }, { status: 401 });

  const supabase = createClient(url, anonKey, { auth: { persistSession: false } });
  const { data, error } = await supabase.auth.getUser(token);
  if (error || !data?.user) {
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }

  const { token: session, expiresAt } = mintImageSession(data.user.id, secret);
  const response = NextResponse.json({ expiresAt }, { status: 200 });
  response.headers.set("set-cookie", imageSessionCookie(session, { secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");
  return response;
}

/**
 * Sign-out. Clears the cookie on this device AND moves the account's
 * kill-switch timestamp forward, which invalidates every image cookie issued
 * before now, on every device. Clearing the cookie alone would only ask this
 * browser nicely; the column is what makes it true for everyone.
 */
export async function DELETE(request: Request) {
  const response = NextResponse.json({ cleared: true }, { status: 200 });
  response.headers.set("set-cookie", clearImageSessionCookie({ secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  const authHeader = request.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";

  // Best effort, and deliberately so: signing out must never fail because the
  // kill switch could not be written. The cookie is gone from this browser
  // either way, and the cookie's own lifetime is minutes.
  if (url && anonKey && serviceRoleKey && token) {
    try {
      const identity = createClient(url, anonKey, { auth: { persistSession: false } });
      const { data } = await identity.auth.getUser(token);
      if (data?.user) {
        const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
        await admin
          .from("profiles")
          .update({ image_sessions_valid_from: new Date().toISOString() })
          .eq("id", data.user.id);
      }
    } catch {
      // Swallowed on purpose. See above.
    }
  }

  return response;
}
