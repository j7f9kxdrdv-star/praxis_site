/**
 * Keeps the browser carrying a usable image-session cookie for as long as the
 * learner is studying.
 *
 * THE BUG THIS EXISTS TO FIX. The cookie lives fifteen minutes. The first
 * version minted it once, in the dashboard shell's mount effect, and never
 * again. The shell mounts on a full page load and client-side navigation does
 * not remount it, so anyone studying for more than fifteen minutes watched
 * every illustration quietly stop loading, with no error and no recovery short
 * of a page reload. Spaced repetition sessions are routinely longer than that.
 *
 * WHAT IT DOES NOW. Mints on demand, re-mints on a timer well before expiry,
 * re-mints when a backgrounded tab comes back, and gives a failed image exactly
 * one chance to recover. All of it is bounded: one request in flight at a time,
 * one retry per failure, one timer, and every listener removed on teardown.
 *
 * WHAT IT IS NOT. It is not a security control and it grants nothing. Minting
 * requires a current Supabase session and the server decides entitlement on
 * every single image request, so a renewal cannot turn an unentitled account
 * into an entitled one, and it cannot outlive a revocation or a sign-out. The
 * cookie is HttpOnly, so nothing here reads it: expiry is tracked from what the
 * mint endpoint reported, which is the only honest source available.
 */
import { supabase } from "@/lib/supabase";
import { IMAGE_SESSION_TTL_SECONDS } from "@/lib/flashcards/imageSession";

/** Re-mint once half the lifetime has gone, so a slow network has room. */
const RENEW_EVERY_MS = (IMAGE_SESSION_TTL_SECONDS / 2) * 1000;

/**
 * Treat a cookie with less than this left as due for renewal. Comfortably
 * larger than any plausible request, so a cookie never expires mid-flight.
 */
const RENEW_WHEN_REMAINING_MS = 5 * 60 * 1000;

/** Unix ms at which the cookie we last minted stops being accepted. */
let expiresAtMs = 0;
/** The one mint in flight, so concurrent callers share a single request. */
let inFlight: Promise<boolean> | null = null;
/**
 * Set by clearImageSession, cleared when renewal is started again.
 *
 * Sign-out revokes the session and then calls supabase.auth.signOut(), and
 * between those two the bearer token is still briefly valid. Without this, a
 * renewal tick landing in that gap would mint a cookie carrying the NEW
 * revocation marker, which the image route would accept: a session that
 * outlived the sign-out that ended it. The window is tiny and the fix is three
 * lines, so there is no reason to leave it open.
 */
let suppressed = false;

function freshEnough(now = Date.now()): boolean {
  return expiresAtMs - now > RENEW_WHEN_REMAINING_MS;
}

async function mint(): Promise<boolean> {
  try {
    // A renewal is only ever as good as the Supabase session behind it. No
    // session, no mint: this must not keep a signed-out browser alive.
    const { data } = await supabase.auth.getSession();
    const token = data.session?.access_token;
    if (!token) {
      expiresAtMs = 0;
      return false;
    }

    const response = await fetch("/api/flashcards/image-session", {
      method: "POST",
      headers: { authorization: `Bearer ${token}` },
      credentials: "same-origin",
    });
    if (!response.ok) {
      expiresAtMs = 0;
      return false;
    }

    const body = (await response.json().catch(() => null)) as { expiresAt?: number } | null;
    expiresAtMs = typeof body?.expiresAt === "number"
      ? body.expiresAt * 1000
      // The server did not say; assume the shortest sensible life rather than
      // the longest, so a missing field cannot stretch the cookie's apparent age.
      : Date.now() + RENEW_EVERY_MS;
    return true;
  } catch {
    expiresAtMs = 0;
    return false;
  }
}

/**
 * Make sure a usable cookie exists. Does nothing when the current one has
 * plenty of life left, so navigation and visibility changes do not produce a
 * stream of pointless requests.
 */
export function ensureImageSession(options: { force?: boolean } = {}): Promise<boolean> {
  // Checked before `force`, because forcing is for recovery and there is
  // nothing to recover once the account has signed out.
  if (suppressed) return Promise.resolve(false);
  if (!options.force && freshEnough()) return Promise.resolve(true);
  // Everyone who asks while a mint is running waits for that one.
  inFlight ??= mint().finally(() => { inFlight = null; });
  return inFlight;
}

/**
 * Start keeping the session alive, and return the teardown.
 *
 * Called once from the dashboard shell. The timer and the listener are removed
 * by the returned function, so a remount cannot leave a second set running.
 */
export function startImageSessionRenewal(): () => void {
  // A new shell mount is a new signed-in session, so whatever a previous
  // sign-out suppressed no longer applies.
  suppressed = false;
  void ensureImageSession();

  const timer = setInterval(() => {
    // IT RENEWS WHILE HIDDEN TOO, AND THAT IS THE CORRECTION.
    //
    // An earlier version skipped the tick for a backgrounded tab, on the
    // reasoning that nobody is looking so nothing needs keeping alive, and
    // left the visibility handler to catch up on return. A seventeen-minute
    // production test showed the hole: the cookie lapsed while the tab was
    // hidden, and the first image request after it came back was refused,
    // because the catch-up mint had not finished. Renewing anyway costs one
    // request every seven and a half minutes per open tab, which is nothing,
    // and removes the race entirely. Browsers throttle background timers, so
    // the visibility handler stays as the backstop for a tick that never fired.
    // FORCED, and that detail matters. With a freshness check here the tick
    // and the margin fight each other: seven and a half minutes in, the cookie
    // still has seven and a half minutes left, which reads as fresh, so the
    // tick does nothing and the next one arrives exactly as the cookie dies.
    // A test caught precisely that. The scheduled renewal is the thing keeping
    // the session alive, so it always renews; the freshness guard belongs on
    // the on-demand and visibility paths, where repeated calls are the risk.
    void ensureImageSession({ force: true });
  }, RENEW_EVERY_MS);

  const onVisible = () => {
    if (document.visibilityState !== "visible") return;
    // A tab asleep for an hour comes back with a long-dead cookie. Renew only
    // if it is actually due, so switching tabs is not a network event.
    if (!freshEnough()) void ensureImageSession();
  };

  if (typeof document !== "undefined") {
    document.addEventListener("visibilitychange", onVisible);
  }

  return () => {
    clearInterval(timer);
    if (typeof document !== "undefined") {
      document.removeEventListener("visibilitychange", onVisible);
    }
  };
}

/**
 * One recovery attempt for an image that failed to load.
 *
 * Forces a mint even if the cookie looks fresh, because the only evidence we
 * have is that the server refused. Returns whether a retry is worth making;
 * the caller is responsible for attempting it exactly once. If the account is
 * not entitled this will mint a perfectly valid cookie and the retry will still
 * be refused, which is correct: renewal proves identity, never entitlement.
 */
export function recoverImageSession(): Promise<boolean> {
  return ensureImageSession({ force: true });
}

/**
 * Sign out of the image session: clear the cookie here and revoke every image
 * session this account holds anywhere.
 *
 * MUST BE AWAITED BEFORE supabase.auth.signOut(). The server needs a live
 * bearer token to know whose sessions to revoke, and signOut() removes it. Both
 * sign-out buttons call this first; see components/dashboard/Sidebar.tsx.
 *
 * Never throws and never rejects. Signing out is the learner's instruction and
 * must not fail because a request did.
 *
 * Returns whether the server confirmed the revocation, for tests and for
 * diagnostics. The caller signs out either way: the cookie is gone from this
 * browser and its own life is minutes.
 */
export async function clearImageSession(): Promise<boolean> {
  expiresAtMs = 0;
  // Set before the request, not after, so a renewal tick cannot slip in while
  // it is in flight.
  suppressed = true;
  try {
    const { data } = await supabase.auth.getSession();
    const token = data.session?.access_token;
    const response = await fetch("/api/flashcards/image-session", {
      method: "DELETE",
      credentials: "same-origin",
      headers: token ? { authorization: `Bearer ${token}` } : {},
    });
    if (!response.ok) return false;
    const body = (await response.json().catch(() => null)) as { revoked?: boolean } | null;
    return body?.revoked === true;
  } catch {
    // Sign-out must not fail because of this.
    return false;
  }
}

/** Test seam. Not used by the application. */
export function __resetImageSessionStateForTests(): void {
  expiresAtMs = 0;
  inFlight = null;
  suppressed = false;
}

/** Test seam: what the module believes about the current cookie. */
export function __imageSessionStateForTests(): {
  expiresAtMs: number; minting: boolean; suppressed: boolean;
} {
  return { expiresAtMs, minting: inFlight !== null, suppressed };
}
