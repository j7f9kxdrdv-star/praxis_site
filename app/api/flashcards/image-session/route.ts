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
 * DELETE is sign-out. It ends the account's Supabase sessions and THEN advances
 * its revocation marker, in that order, and the order is load-bearing: see the
 * proof in lib/flashcards/revocation.ts, which owns both sequences so that the
 * interleavings can be driven deliberately in tests.
 */
import { NextResponse } from "next/server";
import { createClient, type SupabaseClient } from "@supabase/supabase-js";
import { ENTITLEMENT_COLUMNS } from "@/lib/flashcards/entitlement";
import {
  advanceRevocationMarker,
  decideMint,
  type MarkerRead,
  type SwapOutcome,
} from "@/lib/flashcards/revocation";
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

function bearer(request: Request): string {
  const header = request.headers.get("authorization") ?? "";
  return header.startsWith("Bearer ") ? header.slice(7) : "";
}

/**
 * The verified user behind a bearer token, or null.
 *
 * `getUser` is a request to the Auth server, not a local signature check, and
 * that is exactly why it is used here: GoTrue looks the token's `session_id`
 * claim up in `auth.sessions` and answers 403 `session_not_found` once the row
 * is gone, which is what makes a sign-out stick. `getClaims()` must never be
 * substituted. This project signs with asymmetric keys, so `getClaims()` would
 * verify locally and happily accept a token whose session had been deleted.
 */
async function verifiedUser(token: string, url: string, anonKey: string): Promise<string | null> {
  if (!token) return null;
  const identity = createClient(url, anonKey, { auth: { persistSession: false } });
  const { data, error } = await identity.auth.getUser(token);
  if (error || !data?.user) return null;
  return data.user.id;
}

/** Read the account's revocation marker, distinguishing "no row" from "failed". */
async function readMarker(admin: SupabaseClient, userId: string): Promise<MarkerRead> {
  const { data, error } = await admin
    .from("profiles")
    .select(ENTITLEMENT_COLUMNS)
    .eq("id", userId)
    .maybeSingle();
  if (error) return { ok: false };
  if (!data) return { ok: true, exists: false };
  return {
    ok: true,
    exists: true,
    marker: (data as { image_sessions_valid_from?: string | null })
      .image_sessions_valid_from ?? null,
  };
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

  const token = bearer(request);
  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });

  // ─── VERIFY, READ THE MARKER, VERIFY AGAIN ───────────────────────────────
  //
  // The second verification is the fix for the race the Phase 32.2 audit
  // found. Without it: a mint passes the first check while the session is
  // still alive, the sign-out then deletes the sessions AND advances the
  // marker, and the marker read picks up the NEW value, producing a cookie
  // that matches the column and is therefore served for its whole life after
  // the learner signed out. Checking again after the read means a cookie can
  // only ever carry a marker that was current while the session was alive.
  // decideMint owns the ordering; revocation.test.ts drives the interleavings.
  const decision = await decideMint({
    verifySession: () => verifiedUser(token, url, anonKey),
    readMarker: (userId) => readMarker(admin, userId),
  });

  if (!decision.ok) {
    if (decision.reason === "marker_unavailable") {
      // REFUSING TO MINT IS THE SAFE ANSWER. Minting with a guessed marker
      // would produce a cookie that fails on every image until it expired,
      // with the renewal timer cheerfully replacing it with another one just
      // as broken. A 503 tells the client to come back, and the cookie it
      // already holds keeps working until it lapses.
      return NextResponse.json(
        { error: "Could not read the account's session state." },
        { status: 503, headers: { "cache-control": "no-store" } },
      );
    }
    return NextResponse.json({ error: "Not signed in." }, { status: 401 });
  }

  const { token: session, expiresAt } = mintImageSession(
    decision.userId, secret, decision.marker,
  );
  const response = NextResponse.json({ expiresAt }, { status: 200 });
  response.headers.set("set-cookie", imageSessionCookie(session, { secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");
  return response;
}

/**
 * Sign-out.
 *
 * Three things happen, and the order of the first two is the security property:
 *
 *   1. Every Supabase session for the account is deleted, server side. That is
 *      what stops a retained token minting anything, and it has to happen
 *      BEFORE the marker moves, or a concurrent mint can pick up the new
 *      marker while its own session is still alive.
 *   2. The revocation marker is advanced with a compare-and-swap, so two
 *      sign-outs landing in the same millisecond cannot collapse into one.
 *   3. The cookie is cleared in this browser.
 *
 * The response reports whether the revocation actually happened, and why not
 * when it did not. Signing out never fails because of any of this: step 3 is
 * unconditional and the client navigates away regardless.
 */
export async function DELETE(request: Request) {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  let revoked = false;
  let reason = "not_attempted";
  let sessionsEnded = false;

  if (!url || !anonKey || !serviceRoleKey) {
    reason = "not_configured";
  } else {
    try {
      const token = bearer(request);
      const userId = await verifiedUser(token, url, anonKey);
      if (!userId) {
        // Either never signed in, or already signed out. Both mean there is
        // nothing to revoke and nothing has been lost: a sign-out that
        // completed has already moved the marker.
        reason = "no_live_session";
      } else {
        const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });

        // ── 1. end the Supabase sessions, on every device ──
        const { error: signOutError } = await admin.auth.admin.signOut(token, "global");
        sessionsEnded = !signOutError;

        // ── 2. advance the marker, even if step 1 failed ──
        // Advancing refuses every outstanding cookie, which is the larger
        // win. What is lost when step 1 failed is only the ordering guarantee
        // against a mint already in flight, and the client's own signOut()
        // ends the sessions a moment later regardless.
        const result = await advanceRevocationMarker({
          read: () => readMarker(admin, userId),
          swap: async (expected, next): Promise<SwapOutcome> => {
            let query = admin
              .from("profiles")
              .update({ image_sessions_valid_from: next })
              .eq("id", userId);
            // The compare-and-swap predicate. `.is(..., null)` and not
            // `.eq(..., null)`, because SQL equality against NULL is never true
            // and the first write on a fresh account would silently match
            // nothing at all.
            query = expected === null
              ? query.is("image_sessions_valid_from", null)
              : query.eq("image_sessions_valid_from", expected);

            const { data, error } = await query.select(ENTITLEMENT_COLUMNS).maybeSingle();
            if (error) return { outcome: "error" };
            // Nothing matched: somebody moved it between our read and our
            // write. A conflict rather than a failure, and the caller re-reads.
            if (!data) return { outcome: "conflict" };
            return {
              outcome: "written",
              stored: (data as { image_sessions_valid_from?: string | null })
                .image_sessions_valid_from ?? null,
            };
          },
          now: () => Date.now(),
        });
        revoked = result.revoked;
        reason = result.reason;
      }
    } catch {
      // Swallowed on purpose: signing out must not fail because of this.
      reason = "unavailable";
    }
  }

  const response = NextResponse.json(
    { cleared: true, revoked, reason, sessionsEnded },
    { status: 200 },
  );
  response.headers.set("set-cookie", clearImageSessionCookie({ secure: isSecure(request) }));
  response.headers.set("cache-control", "no-store");
  return response;
}
