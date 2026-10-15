/**
 * The credential a browser can actually send with an image request.
 *
 * THE PROBLEM THIS SOLVES. Every other protected route in this app reads an
 * `Authorization: Bearer` header that the client code attaches by hand. A
 * browser fetching `<img src="...">` attaches no such header and there is no
 * way to make it. So an illustration cannot be authorised the way the rest of
 * the API is, and the only credential a browser will volunteer for a subresource
 * is a cookie.
 *
 * WHAT THIS COOKIE IS, AND IS NOT. It carries an identity, an issue time and
 * an expiry, signed with a server secret. It does NOT carry an entitlement.
 * Whether that person may see illustrations is decided per request against the
 * database by lib/flashcards/entitlement.ts, so a revoked subscription stops
 * working on the very next image rather than whenever a token happens to lapse.
 *
 * AND IT IS NOT PROOF THAT THE SUPABASE SESSION IS STILL ALIVE. That was the
 * flaw in the first version: it was minted from a verified bearer token and
 * then believed for twelve hours, so somebody who signed out — or was signed
 * out — kept their illustrations for the rest of the day. Two things fix it.
 * The lifetime is now minutes, not hours, so the window is small. And the
 * claim carries the instant it was issued, which the route compares against
 * profiles.image_sessions_valid_from: signing out moves that column forward,
 * which invalidates every cookie issued before it, everywhere, at once. That
 * is a server-side kill switch rather than a promise the client keeps.
 *
 * WHY A COOKIE IS SAFER HERE THAN THE BEARER TOKEN WE ALREADY HAVE. The
 * Supabase session sits in local storage, which any script on the page can
 * read. This cookie is HttpOnly, so script cannot read it at all, and it is
 * minted server-side only after the bearer token has been verified. It is also
 * Path-scoped to the illustration route, so it is not sent with anything else.
 *
 * It is a bearer credential, so it is only as private as the device. That is
 * the same property the Supabase session already has, and the blast radius is
 * smaller: it proves identity for pictures and nothing more.
 */
import { createHmac, timingSafeEqual } from "node:crypto";

export const IMAGE_SESSION_COOKIE = "px_img_session";

/**
 * Deliberately short. The app re-mints it whenever the dashboard loads, so a
 * studying learner never notices, while anybody holding a stolen or stale
 * cookie loses it within the quarter hour even if nothing else catches them.
 */
export const IMAGE_SESSION_TTL_SECONDS = 15 * 60;

/** Scoped to the illustrations, so it rides along with nothing else. */
export const IMAGE_SESSION_PATH = "/flashcards/backs";

const VERSION = "v1";

export type ImageSessionClaim = {
  userId: string;
  /** Unix seconds. Compared against the account's kill-switch timestamp. */
  issuedAt: number;
  expiresAt: number;
};

export type VerifyResult =
  | { ok: true; claim: ImageSessionClaim }
  | { ok: false; reason: "absent" | "malformed" | "bad_signature" | "expired" | "no_secret" };

/**
 * Was this cookie issued before the account's sessions were invalidated?
 *
 * `validFrom` is profiles.image_sessions_valid_from. Signing out moves it to
 * now, so every cookie minted before that instant is dead on its next use, on
 * every device, without waiting for anything to expire. A clock skew of a
 * second either way does not matter here: the comparison is against a column
 * the server wrote.
 */
export function isSessionSuperseded(
  claim: ImageSessionClaim,
  validFrom: string | null | undefined,
): boolean {
  if (!validFrom) return false;
  const boundary = new Date(validFrom);
  if (Number.isNaN(boundary.getTime())) return true; // unreadable: refuse

  // BOTH SIDES ARE COMPARED IN WHOLE SECONDS, and that is not a detail.
  //
  // The cutoff is written with millisecond precision, while a claim records
  // its issue time in whole seconds. Comparing them directly means a cookie
  // minted in the SAME second as a sign-out looks up to 999ms older than the
  // cutoff and is refused. A production test hit exactly that: signing out and
  // immediately re-minting produced a valid cookie that was rejected, and
  // waiting one second made it work. Flooring the cutoff to the same
  // resolution as the claim removes the mismatch.
  //
  // What this costs: a cookie issued earlier in the same second as a sign-out
  // is accepted. That is a sub-second window, against a bug that otherwise
  // refuses legitimate sessions for up to a full renewal interval.
  return claim.issuedAt < Math.floor(boundary.getTime() / 1000);
}

function b64url(input: Buffer): string {
  return input.toString("base64").replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function unb64url(input: string): Buffer {
  return Buffer.from(input.replace(/-/g, "+").replace(/_/g, "/"), "base64");
}

function sign(payload: string, secret: string): string {
  return b64url(createHmac("sha256", secret).update(`${VERSION}.${payload}`).digest());
}

/**
 * Mint a token for a user whose bearer token has ALREADY been verified.
 * This function does no verification of its own and must never be called with
 * a user id that arrived from the client.
 */
export function mintImageSession(
  userId: string,
  secret: string,
  now: Date = new Date(),
): { token: string; expiresAt: number } {
  if (!secret) throw new Error("refusing to mint an image session without a secret");
  const issuedAt = Math.floor(now.getTime() / 1000);
  const expiresAt = issuedAt + IMAGE_SESSION_TTL_SECONDS;
  const payload = b64url(Buffer.from(JSON.stringify({ u: userId, i: issuedAt, e: expiresAt })));
  return { token: `${VERSION}.${payload}.${sign(payload, secret)}`, expiresAt };
}

export function verifyImageSession(
  token: string | null | undefined,
  secret: string | null | undefined,
  now: Date = new Date(),
): VerifyResult {
  if (!secret) return { ok: false, reason: "no_secret" };
  if (!token) return { ok: false, reason: "absent" };

  const parts = token.split(".");
  if (parts.length !== 3 || parts[0] !== VERSION) return { ok: false, reason: "malformed" };
  const [, payload, provided] = parts;

  // Constant time, and only once both sides are the same length, because
  // timingSafeEqual throws on a length mismatch and that throw would itself
  // leak the length.
  const expected = Buffer.from(sign(payload, secret));
  const actual = Buffer.from(provided);
  if (expected.length !== actual.length) return { ok: false, reason: "bad_signature" };
  if (!timingSafeEqual(expected, actual)) return { ok: false, reason: "bad_signature" };

  let claim: { u?: unknown; i?: unknown; e?: unknown };
  try {
    claim = JSON.parse(unb64url(payload).toString("utf8"));
  } catch {
    return { ok: false, reason: "malformed" };
  }

  if (typeof claim.u !== "string" || !claim.u
   || typeof claim.e !== "number" || typeof claim.i !== "number") {
    return { ok: false, reason: "malformed" };
  }
  if (claim.e * 1000 <= now.getTime()) return { ok: false, reason: "expired" };

  return { ok: true, claim: { userId: claim.u, issuedAt: claim.i, expiresAt: claim.e } };
}

/** Read one cookie out of a request's Cookie header without a parser dependency. */
export function readCookie(header: string | null, name: string): string | null {
  if (!header) return null;
  for (const part of header.split(";")) {
    const eq = part.indexOf("=");
    if (eq === -1) continue;
    if (part.slice(0, eq).trim() !== name) continue;
    return decodeURIComponent(part.slice(eq + 1).trim());
  }
  return null;
}

/**
 * The Set-Cookie value. Secure is omitted on plain http so the cookie works in
 * local development; everywhere the app actually runs is https.
 */
export function imageSessionCookie(token: string, opts: { secure: boolean }): string {
  return [
    `${IMAGE_SESSION_COOKIE}=${encodeURIComponent(token)}`,
    `Path=${IMAGE_SESSION_PATH}`,
    `Max-Age=${IMAGE_SESSION_TTL_SECONDS}`,
    "HttpOnly",
    "SameSite=Lax",
    opts.secure ? "Secure" : null,
  ].filter(Boolean).join("; ");
}

/** Clear it: same name and path, zero lifetime. */
export function clearImageSessionCookie(opts: { secure: boolean }): string {
  return [
    `${IMAGE_SESSION_COOKIE}=`,
    `Path=${IMAGE_SESSION_PATH}`,
    "Max-Age=0",
    "HttpOnly",
    "SameSite=Lax",
    opts.secure ? "Secure" : null,
  ].filter(Boolean).join("; ");
}
