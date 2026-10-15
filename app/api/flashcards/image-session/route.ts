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
 * DELETE is sign-out: it clears the cookie here and revokes every image
 * session this account holds anywhere.
 */
import { NextResponse } from "next/server";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { ENTITLEMENT_COLUMNS } from "@/lib/flashcards/entitlement";
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

/** The verified user behind a bearer token, or null. */
async function userFromBearer(
  request: Request,
  url: string,
  anonKey: string,
): Promise<string | null> {
  const authHeader = request.headers.get("authorization") ?? "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  if (!token) return null;
  const identity = createClient(url, anonKey, { auth: { persistSession: false } });
  const { data, error } = await identity.auth.getUser(token);
  if (error || !data?.user) return null;
  return data.user.id;
}

export async function POST(request: Request) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const secret = process.env.IMAGE_SESSION_SECRET;

  if (!url || !anonKey || !serviceRoleKey || !secret) {
    // Including the secret and the service role: without either, nothing
    // mintable can be minted, and a server that cannot mint must say so
    // rather than hand back something useless.
    return NextResponse.json({ error: "Image sessions are not configured." }, { status: 500 });
  }

  const userId = await userFromBearer(request, url, anonKey);
  if (!userId) return NextResponse.json({ error: "Not signed in." }, { status: 401 });

  // ─── The revocation marker goes INTO the cookie ──────────────────────────
  //
  // The cookie records the revocation state it was minted under, and the image
  // route refuses it the moment that state changes. So this read is not
  // decoration: a cookie minted without the current marker is a cookie every
  // image request will refuse. See lib/flashcards/imageSession.ts.
  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
  const { data: profile, error: profileError } = await admin
    .from("profiles")
    .select(ENTITLEMENT_COLUMNS)
    .eq("id", userId)
    .maybeSingle();

  if (profileError) {
    // REFUSING TO MINT IS THE SAFE ANSWER. Minting with a guessed marker would
    // produce a cookie that fails on every image until it expired, with the
    // renewal timer cheerfully replacing it with another one just as broken.
    // A 503 tells the client to come back, and the cookie it already holds
    // keeps working until it lapses.
    return NextResponse.json(
      { error: "Could not read the account's session state." },
      { status: 503, headers: { "cache-control": "no-store" } },
    );
  }

  const marker = (profile as { image_sessions_valid_from?: string | null } | null)
    ?.image_sessions_valid_from ?? null;

  const { token: session, expiresAt } = mintImageSession(userId, secret, marker);
  const response = NextResponse.json({ expiresAt }, { status: 200 });
  response.headers.set("set-cookie", imageSessionCookie(session, { secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");
  return response;
}

/**
 * Move the account's revocation marker so that every outstanding image cookie
 * stops being accepted. Returns the new marker, or null if it did not move.
 *
 * WHY IT READS BEFORE IT WRITES. The column is forward-only: the trigger
 * profiles_image_sessions_forward_only silently reverts any write that would
 * move it backwards. Writing a bare `new Date()` from a lambda whose clock sits
 * a little behind the stored value therefore does nothing at all, and sign-out
 * reports success while revoking nothing. Reading first and writing something
 * strictly greater makes the write independent of how the two clocks compare.
 *
 * AND WHY IT CHECKS THE RESULT. `.select()` on the update returns the value as
 * stored, which is after the trigger has had its say. That is the difference
 * between knowing the sessions are revoked and assuming it.
 */
async function revokeImageSessions(
  admin: SupabaseClient,
  userId: string,
): Promise<string | null> {
  const { data: before } = await admin
    .from("profiles")
    .select(ENTITLEMENT_COLUMNS)
    .eq("id", userId)
    .maybeSingle();

  const current = (before as { image_sessions_valid_from?: string | null } | null)
    ?.image_sessions_valid_from ?? null;
  const currentMs = current ? Date.parse(current) : NaN;

  // Strictly after both now and whatever is stored, so the trigger keeps it.
  // Date.parse truncates any microseconds the column might hold, so the extra
  // millisecond is what guarantees "greater" rather than "possibly equal".
  const next = new Date(
    Number.isNaN(currentMs) ? Date.now() : Math.max(Date.now(), currentMs + 1),
  ).toISOString();

  const { data: after, error } = await admin
    .from("profiles")
    .update({ image_sessions_valid_from: next })
    .eq("id", userId)
    .select(ENTITLEMENT_COLUMNS)
    .maybeSingle();

  if (error) return null;
  const stored = (after as { image_sessions_valid_from?: string | null } | null)
    ?.image_sessions_valid_from ?? null;
  // It moved, or it did not. Equality with what was there before means the
  // trigger reverted us, or no row matched.
  return stored !== null && stored !== current ? stored : null;
}

/**
 * Sign-out. Clears the cookie on this device AND revokes every image session
 * the account holds, on every device, without waiting for one to expire.
 * Clearing the cookie alone would only ask this browser nicely; the column is
 * what makes it true for everyone.
 *
 * The response says whether the revocation actually happened, so the client is
 * not left believing something that did not occur.
 */
export async function DELETE(request: Request) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  let revoked = false;

  // Best effort on the REVOCATION ONLY, and deliberately so: signing out must
  // never fail because the database was unreachable. The cookie is gone from
  // this browser either way, and its own lifetime is minutes. One retry,
  // because the write is a read-modify-write and a concurrent sign-out can
  // legitimately make the first attempt lose.
  if (url && anonKey && serviceRoleKey) {
    try {
      const userId = await userFromBearer(request, url, anonKey);
      if (userId) {
        const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
        revoked = (await revokeImageSessions(admin, userId)) !== null
          || (await revokeImageSessions(admin, userId)) !== null;
      }
    } catch {
      // Swallowed on purpose. See above.
    }
  }

  const response = NextResponse.json({ cleared: true, revoked }, { status: 200 });
  response.headers.set("set-cookie", clearImageSessionCookie({ secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");
  return response;
}
