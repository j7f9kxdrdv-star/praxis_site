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
 * then believed for twelve hours, so somebody who signed out, or was signed
 * out, kept their illustrations for the rest of the day. Two things fix it.
 * The lifetime is now minutes, not hours, so the window is small. And the
 * claim carries a copy of the account's revocation marker, which the route
 * compares against the marker in force now: signing out moves
 * profiles.image_sessions_valid_from, and every cookie minted under the old
 * value is refused, everywhere, at once. That is a server-side kill switch
 * rather than a promise the client keeps.
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

/**
 * Bumped from v1 when the claim stopped carrying an issue time to compare
 * against the cutoff and started carrying the cutoff itself. A v1 cookie is
 * refused as malformed rather than reinterpreted, which costs a learner one
 * image and one automatic re-mint, and is the only safe direction: a v1 claim
 * has no revocation marker, so there is nothing to check it against.
 */
const VERSION = "v2";

export type ImageSessionClaim = {
  userId: string;
  /**
   * Unix seconds, for logs and for support questions. DELIBERATELY NOT USED TO
   * DECIDE ANYTHING. Comparing it against the revocation cutoff is the bug this
   * version exists to remove; see isSessionSuperseded.
   */
  issuedAt: number;
  expiresAt: number;
  /**
   * The account's revocation marker as it stood when this cookie was minted:
   * the literal value of profiles.image_sessions_valid_from, or null if the
   * account has never had a session revoked.
   *
   * AN OPAQUE STRING, NOT A TIME. Nothing may parse it, order it or do
   * arithmetic on it. Its only job is to be compared for identity against the
   * value in the column, and treating it as a clock reading is exactly what
   * went wrong before.
   */
  revocationMarker: string | null;
};

export type VerifyResult =
  | { ok: true; claim: ImageSessionClaim }
  | { ok: false; reason: "absent" | "malformed" | "bad_signature" | "expired" | "no_secret" };

/**
 * Was this cookie minted under a revocation state that no longer holds?
 *
 * `currentMarker` is profiles.image_sessions_valid_from as the route just read
 * it. The cookie carries the same column's value as the mint endpoint read it.
 * If the two differ, the column moved in between, which only happens when a
 * session is revoked, so the cookie is dead.
 *
 * THERE IS NO CLOCK IN HERE, AND THAT IS THE WHOLE POINT. The previous version
 * asked whether the cookie's issue time came before the cutoff, which compared
 * the mint server's clock in whole seconds against the sign-out server's clock
 * in milliseconds. Two clocks, two resolutions. Flooring the cutoff to seconds
 * made legitimate sessions work again and, unavoidably, accepted any cookie
 * minted earlier in the same second as the sign-out: a hole up to 999ms wide,
 * reproduced at scratchpad/samesec/reproduce.mjs.
 *
 * Identity between two reads of one column has no resolution to get wrong, so
 * the hole is not narrowed here, it is absent. A cookie minted a microsecond
 * before a sign-out carries the old marker and is refused; one minted a
 * microsecond after carries the new one and is accepted.
 *
 * WHY IDENTITY RATHER THAN ORDER. Order would need the values to be
 * interpretable and would invite arithmetic on them again. The column is
 * forward-only (trigger profiles_image_sessions_forward_only), so it never
 * returns to a value an outstanding cookie could be carrying, and "different"
 * and "newer" are the same thing here.
 *
 * FAILURE DIRECTIONS. A cookie carrying a marker when the column is null, or
 * null when the column is set, differs and is refused. If the serialisation of
 * a timestamptz ever changed under us, every cookie would differ once and
 * every learner would re-mint on their next image. Every wrong answer this can
 * give is a refusal.
 */
export function isSessionSuperseded(
  claim: ImageSessionClaim,
  currentMarker: string | null | undefined,
): boolean {
  return (claim.revocationMarker ?? null) !== (currentMarker ?? null);
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
 *
 * `revocationMarker` is the account's current image_sessions_valid_from, which
 * the caller must have just read from the database. It is a required argument
 * rather than an optional one on purpose: a cookie minted without it would be
 * refused by every image request, so forgetting it has to be a type error
 * rather than a quiet runtime failure.
 */
export function mintImageSession(
  userId: string,
  secret: string,
  revocationMarker: string | null,
  now: Date = new Date(),
): { token: string; expiresAt: number } {
  if (!secret) throw new Error("refusing to mint an image session without a secret");
  const issuedAt = Math.floor(now.getTime() / 1000);
  const expiresAt = issuedAt + IMAGE_SESSION_TTL_SECONDS;
  const payload = b64url(Buffer.from(JSON.stringify({
    u: userId, i: issuedAt, e: expiresAt, r: revocationMarker ?? null,
  })));
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

  let claim: { u?: unknown; i?: unknown; e?: unknown; r?: unknown };
  try {
    claim = JSON.parse(unb64url(payload).toString("utf8"));
  } catch {
    return { ok: false, reason: "malformed" };
  }

  if (typeof claim.u !== "string" || !claim.u
   || typeof claim.e !== "number" || typeof claim.i !== "number") {
    return { ok: false, reason: "malformed" };
  }
  // The marker must be PRESENT, even when it is null. A payload without the
  // field is one minted before the field existed, and it would compare equal
  // to an account that has never been revoked no matter what the column says.
  if (!("r" in claim) || !(claim.r === null || typeof claim.r === "string")) {
    return { ok: false, reason: "malformed" };
  }
  if (claim.e * 1000 <= now.getTime()) return { ok: false, reason: "expired" };

  return {
    ok: true,
    claim: {
      userId: claim.u,
      issuedAt: claim.i,
      expiresAt: claim.e,
      revocationMarker: claim.r,
    },
  };
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
