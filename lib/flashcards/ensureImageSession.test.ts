import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import fs from "node:fs";
import path from "node:path";

// ─── THE BUG THESE TESTS EXIST FOR ──────────────────────────────────────────
//
// The cookie lives fifteen minutes and the first version minted it once, on
// mount, and never again. A study session outlasts that, so illustrations
// stopped loading part-way through with no error and no recovery. Every test
// below is about that lapse: renewing before it happens, noticing when a tab
// comes back from the dead, and recovering exactly once if it happens anyway.
//
// Supabase is mocked so these are pure: no network, no session, no database.

const getSession = vi.fn();
vi.mock("@/lib/supabase", () => ({
  supabase: { auth: { getSession: () => getSession() } },
}));

// This suite runs in the node environment, which has no document. The module
// only ever uses three things from it, so rather than pull in a whole DOM just
// for a visibility flag, stand up exactly those three. Listener bookkeeping is
// real, so the teardown test is still testing something.
if (typeof globalThis.document === "undefined") {
  const listeners = new Map<string, Set<EventListener>>();
  const fake = {
    visibilityState: "visible" as DocumentVisibilityState,
    addEventListener(type: string, fn: EventListener) {
      if (!listeners.has(type)) listeners.set(type, new Set());
      listeners.get(type)!.add(fn);
    },
    removeEventListener(type: string, fn: EventListener) {
      listeners.get(type)?.delete(fn);
    },
    dispatchEvent(event: { type: string }) {
      listeners.get(event.type)?.forEach((fn) => fn(event as unknown as Event));
      return true;
    },
  };
  Object.defineProperty(globalThis, "document", { value: fake, configurable: true, writable: true });
}
if (typeof globalThis.Event === "undefined") {
  Object.defineProperty(globalThis, "Event", {
    value: class { type: string; constructor(type: string) { this.type = type; } },
    configurable: true, writable: true,
  });
}

const {
  ensureImageSession,
  startImageSessionRenewal,
  recoverImageSession,
  clearImageSession,
  __resetImageSessionStateForTests,
  __imageSessionStateForTests,
} = await import("@/lib/flashcards/ensureImageSession");

const TTL = 15 * 60;
const signedIn = () => getSession.mockResolvedValue({ data: { session: { access_token: "tok" } } });
const signedOut = () => getSession.mockResolvedValue({ data: { session: null } });

/**
 * A stand-in for fetch. The implementation ignores its arguments, but the mock
 * is given fetch's call signature so the recorded calls can be inspected.
 */
type FetchLike = (input?: unknown, init?: unknown) => Promise<Response>;

function mintOk(ttl = TTL) {
  const impl: FetchLike = async () => new Response(
    JSON.stringify({ expiresAt: Math.floor(Date.now() / 1000) + ttl }),
    { status: 200, headers: { "content-type": "application/json" } },
  );
  return vi.fn(impl);
}

beforeEach(() => {
  vi.useFakeTimers();
  __resetImageSessionStateForTests();
  getSession.mockReset();
  signedIn();
});

afterEach(() => {
  vi.useRealTimers();
  vi.unstubAllGlobals();
});

describe("minting", () => {
  it("mints when there is no cookie yet", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await expect(ensureImageSession()).resolves.toBe(true);
    expect(fetchMock).toHaveBeenCalledTimes(1);
    expect(fetchMock.mock.calls.at(0)?.[0]).toBe("/api/flashcards/image-session");
  });

  it("sends the Supabase token, so a renewal still requires a real session", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    const init = fetchMock.mock.calls.at(0)?.[1] as RequestInit | undefined;
    expect((init?.headers as Record<string, string>).authorization).toBe("Bearer tok");
    expect(init?.method).toBe("POST");
  });

  it("refuses to mint when there is no Supabase session", async () => {
    signedOut();
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await expect(ensureImageSession()).resolves.toBe(false);
    expect(fetchMock).not.toHaveBeenCalled();
  });

  it("does not mint again while the cookie has plenty of life", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    await ensureImageSession();
    await ensureImageSession();
    expect(fetchMock).toHaveBeenCalledTimes(1);
  });

  it("collapses concurrent callers into a single request", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await Promise.all([ensureImageSession(), ensureImageSession(), ensureImageSession()]);
    expect(fetchMock).toHaveBeenCalledTimes(1);
  });
});

describe("failure is treated as having no cookie", () => {
  it("a non-ok mint leaves nothing to trust", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => new Response("no", { status: 401 })));
    await expect(ensureImageSession()).resolves.toBe(false);
    expect(__imageSessionStateForTests().expiresAtMs).toBe(0);
  });

  it("a network error does not throw", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => { throw new Error("offline"); }));
    await expect(ensureImageSession()).resolves.toBe(false);
  });

  it("a failed mint does not block the next attempt", async () => {
    const failing = vi.fn(async () => new Response("no", { status: 500 }));
    vi.stubGlobal("fetch", failing);
    await ensureImageSession();
    const working = mintOk();
    vi.stubGlobal("fetch", working);
    await expect(ensureImageSession()).resolves.toBe(true);
    expect(working).toHaveBeenCalledTimes(1);
  });

  it("a mint with no expiry in the body is assumed short-lived, not long-lived", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => new Response("{}", {
      status: 200, headers: { "content-type": "application/json" } })));
    await ensureImageSession();
    const { expiresAtMs } = __imageSessionStateForTests();
    expect(expiresAtMs - Date.now()).toBeLessThanOrEqual((TTL / 2) * 1000);
  });
});

describe("scheduled renewal", () => {
  it("renews on its own before the cookie expires", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    expect(fetchMock).toHaveBeenCalledTimes(1);

    // Past half the lifetime: the timer fires and the cookie is replaced
    // while the old one is still valid.
    await vi.advanceTimersByTimeAsync((TTL / 2) * 1000 + 10);
    expect(fetchMock).toHaveBeenCalledTimes(2);
    stop();
  });

  it("keeps renewing across a session far longer than one cookie", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    // An hour of study: four half-lives.
    await vi.advanceTimersByTimeAsync(60 * 60 * 1000);
    expect(fetchMock.mock.calls.length).toBeGreaterThanOrEqual(7);
    stop();
  });

  it("stops completely when torn down", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    stop();
    const before = fetchMock.mock.calls.length;
    await vi.advanceTimersByTimeAsync(60 * 60 * 1000);
    expect(fetchMock.mock.calls.length).toBe(before);
  });

  it("removes its visibility listener on teardown, so a remount cannot double up", async () => {
    vi.stubGlobal("fetch", mintOk());
    const add = vi.spyOn(document, "addEventListener");
    const remove = vi.spyOn(document, "removeEventListener");
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    stop();
    expect(add).toHaveBeenCalledWith("visibilitychange", expect.any(Function));
    expect(remove).toHaveBeenCalledWith("visibilitychange", expect.any(Function));
    add.mockRestore();
    remove.mockRestore();
  });
});

describe("returning to a backgrounded tab", () => {
  const setVisibility = (value: "visible" | "hidden") =>
    Object.defineProperty(document, "visibilityState", { value, configurable: true });

  afterEach(() => setVisibility("visible"));

  it("renews on return when the browser throttled the timer away", async () => {
    // This is what the visibility handler is for now that the interval runs
    // while hidden: browsers throttle background timers, and a phone may stop
    // them entirely. Simulated by moving the clock forward WITHOUT letting the
    // interval fire, which is exactly what a throttled tab looks like.
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    const whileHidden = fetchMock.mock.calls.length;

    setVisibility("hidden");
    vi.setSystemTime(Date.now() + TTL * 1000 * 3);   // time passes, no ticks

    setVisibility("visible");
    document.dispatchEvent(new Event("visibilitychange"));
    await vi.advanceTimersByTimeAsync(0);
    expect(fetchMock.mock.calls.length).toBeGreaterThan(whileHidden);
    stop();
  });

  it("does not renew when a tab returns with a cookie that is still fresh", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    const after = fetchMock.mock.calls.length;

    setVisibility("visible");
    document.dispatchEvent(new Event("visibilitychange"));
    document.dispatchEvent(new Event("visibilitychange"));
    await vi.advanceTimersByTimeAsync(0);
    expect(fetchMock.mock.calls.length).toBe(after);
    stop();
  });

  it("KEEPS renewing while hidden, so the cookie cannot lapse in the background", async () => {
    // A production test let a tab sit backgrounded for seventeen minutes with
    // an earlier version that skipped hidden ticks. The cookie expired, and the
    // first image request after the tab returned was refused because the
    // catch-up mint had not finished. Renewing anyway costs one request every
    // seven and a half minutes and removes the race.
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    const after = fetchMock.mock.calls.length;
    setVisibility("hidden");
    await vi.advanceTimersByTimeAsync((TTL / 2) * 1000 * 4);
    expect(fetchMock.mock.calls.length).toBeGreaterThan(after);
    stop();
  });

  it("a tab hidden for far longer than one cookie still has a live one on return", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    setVisibility("hidden");
    await vi.advanceTimersByTimeAsync(TTL * 1000 * 3);
    // Whatever the visibility handler does next, the cookie the module holds
    // must not already be expired.
    expect(__imageSessionStateForTests().expiresAtMs).toBeGreaterThan(Date.now());
    stop();
  });
});

describe("recovery after a failure", () => {
  it("forces a mint even when the cookie looks fresh", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    expect(fetchMock).toHaveBeenCalledTimes(1);
    await recoverImageSession();
    expect(fetchMock).toHaveBeenCalledTimes(2);
  });

  it("reports failure when there is no session, so a retry is not attempted", async () => {
    signedOut();
    vi.stubGlobal("fetch", mintOk());
    await expect(recoverImageSession()).resolves.toBe(false);
  });

  it("grants nothing: a successful mint is only identity", async () => {
    // The mint succeeding says the person is signed in. Whether they may see
    // the image is decided by the server on the retry, which this cannot touch.
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await expect(recoverImageSession()).resolves.toBe(true);
    const init = fetchMock.mock.calls.at(0)?.[1] as RequestInit | undefined;
    expect(JSON.stringify(init ?? {})).not.toMatch(/tier|entitle|subscription/i);
  });
});

describe("sign-out", () => {
  it("clears the cookie and stops treating one as alive", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    expect(__imageSessionStateForTests().expiresAtMs).toBeGreaterThan(0);

    await clearImageSession();
    expect(__imageSessionStateForTests().expiresAtMs).toBe(0);
    const del = fetchMock.mock.calls.at(-1)?.[1] as RequestInit | undefined;
    expect(del?.method).toBe("DELETE");
  });

  it("a renewal after sign-out mints nothing once the session is gone", async () => {
    vi.stubGlobal("fetch", mintOk());
    await ensureImageSession();
    await clearImageSession();
    signedOut();
    await expect(ensureImageSession()).resolves.toBe(false);
  });

  // ─── THE GAP BETWEEN REVOKING AND SIGNING OUT ────────────────────────────
  //
  // clearImageSession() runs while the bearer token is still valid, because
  // revoking needs it. So for a moment after the revocation the token would
  // still mint — and the cookie it minted would carry the NEW marker, which
  // the image route accepts. That is a session outliving the sign-out that
  // ended it, and these tests are what hold the gap shut.

  it("mints nothing after sign-out, even while the token is still valid", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    await clearImageSession();

    // Still signed in as far as Supabase is concerned.
    const callsBefore = fetchMock.mock.calls.length;
    await expect(ensureImageSession()).resolves.toBe(false);
    expect(fetchMock.mock.calls.length).toBe(callsBefore);
  });

  it("refuses a FORCED mint after sign-out, so recovery cannot reopen it", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    await clearImageSession();
    const callsBefore = fetchMock.mock.calls.length;
    await expect(recoverImageSession()).resolves.toBe(false);
    expect(fetchMock.mock.calls.length).toBe(callsBefore);
  });

  it("does not let a scheduled tick mint in the gap", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    const stop = startImageSessionRenewal();
    await vi.advanceTimersByTimeAsync(0);
    await clearImageSession();
    const callsBefore = fetchMock.mock.calls.length;
    // Every tick for the next hour.
    await vi.advanceTimersByTimeAsync(60 * 60 * 1000);
    expect(fetchMock.mock.calls.length).toBe(callsBefore);
    stop();
  });

  it("signing back in starts minting again", async () => {
    const fetchMock = mintOk();
    vi.stubGlobal("fetch", fetchMock);
    await ensureImageSession();
    await clearImageSession();
    expect(__imageSessionStateForTests().suppressed).toBe(true);

    // A new dashboard mount is a new signed-in session.
    const stop = startImageSessionRenewal();
    expect(__imageSessionStateForTests().suppressed).toBe(false);
    await vi.advanceTimersByTimeAsync(0);
    expect(__imageSessionStateForTests().expiresAtMs).toBeGreaterThan(0);
    stop();
  });

  it("reports whether the server confirmed the revocation", async () => {
    const revoked: FetchLike = async () => new Response(
      JSON.stringify({ cleared: true, revoked: true }),
      { status: 200, headers: { "content-type": "application/json" } },
    );
    vi.stubGlobal("fetch", vi.fn(revoked));
    await expect(clearImageSession()).resolves.toBe(true);

    __resetImageSessionStateForTests();
    const notRevoked: FetchLike = async () => new Response(
      JSON.stringify({ cleared: true, revoked: false }),
      { status: 200, headers: { "content-type": "application/json" } },
    );
    vi.stubGlobal("fetch", vi.fn(notRevoked));
    await expect(clearImageSession()).resolves.toBe(false);
  });

  // ─── THE RETRY, AND WHAT IT IS AND IS NOT FOR ───────────────────────────
  //
  // If the marker write fails, outstanding cookies on OTHER devices stay valid
  // until they expire, so a second request is worth making. If the sessions
  // are already gone, a retry cannot achieve anything and would just slow
  // signing out down.

  const deleteReplying = (bodies: Array<Record<string, unknown> | null>) => {
    let n = 0;
    return vi.fn(async (_input?: unknown, init?: unknown) => {
      const method = (init as RequestInit | undefined)?.method;
      if (method !== "DELETE") {
        return new Response(JSON.stringify({ expiresAt: Math.floor(Date.now() / 1000) + TTL }),
          { status: 200, headers: { "content-type": "application/json" } });
      }
      const body = bodies[Math.min(n, bodies.length - 1)];
      n += 1;
      if (body === null) return new Response("nope", { status: 500 });
      return new Response(JSON.stringify(body),
        { status: 200, headers: { "content-type": "application/json" } });
    });
  };
  const deleteCalls = (m: ReturnType<typeof deleteReplying>) =>
    m.mock.calls.filter((c) => (c[1] as RequestInit | undefined)?.method === "DELETE").length;

  it("does not retry when the first attempt already revoked", async () => {
    const fetchMock = deleteReplying([{ cleared: true, revoked: true, reason: "advanced" }]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(true);
    expect(deleteCalls(fetchMock)).toBe(1);
  });

  it("retries once when the marker write was unavailable, and reports the second result", async () => {
    const fetchMock = deleteReplying([
      { cleared: true, revoked: false, reason: "unavailable" },
      { cleared: true, revoked: true, reason: "advanced" },
    ]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(true);
    expect(deleteCalls(fetchMock)).toBe(2);
  });

  it("retries when it lost the race, since a retry can win it", async () => {
    const fetchMock = deleteReplying([
      { cleared: true, revoked: false, reason: "contended" },
      { cleared: true, revoked: true, reason: "advanced" },
    ]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(true);
    expect(deleteCalls(fetchMock)).toBe(2);
  });

  it("retries when the request itself failed", async () => {
    const fetchMock = deleteReplying([null, { cleared: true, revoked: true, reason: "advanced" }]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(true);
    expect(deleteCalls(fetchMock)).toBe(2);
  });

  it("does NOT retry when the sessions are already gone", async () => {
    const fetchMock = deleteReplying([{ cleared: true, revoked: false, reason: "no_live_session" }]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(false);
    expect(deleteCalls(fetchMock)).toBe(1);
  });

  it("does NOT retry when there is no profile to carry a marker", async () => {
    const fetchMock = deleteReplying([{ cleared: true, revoked: false, reason: "no_profile" }]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(false);
    expect(deleteCalls(fetchMock)).toBe(1);
  });

  it("gives up after the one retry rather than looping", async () => {
    const fetchMock = deleteReplying([{ cleared: true, revoked: false, reason: "unavailable" }]);
    vi.stubGlobal("fetch", fetchMock);
    await expect(clearImageSession()).resolves.toBe(false);
    expect(deleteCalls(fetchMock)).toBe(2);
  });

  it("suppresses minting throughout, retry included", async () => {
    const fetchMock = deleteReplying([{ cleared: true, revoked: false, reason: "unavailable" }]);
    vi.stubGlobal("fetch", fetchMock);
    await clearImageSession();
    expect(__imageSessionStateForTests().suppressed).toBe(true);
    await expect(ensureImageSession({ force: true })).resolves.toBe(false);
  });

  it("never throws, so it can never stop somebody signing out", async () => {
    vi.stubGlobal("fetch", vi.fn(async () => { throw new Error("offline"); }));
    await expect(clearImageSession()).resolves.toBe(false);
    expect(__imageSessionStateForTests().expiresAtMs).toBe(0);

    // And a server that answers badly is still not an exception.
    vi.stubGlobal("fetch", vi.fn(async () => new Response("nope", { status: 500 })));
    await expect(clearImageSession()).resolves.toBe(false);
  });

  it("suppresses even when the request fails, because the intent was to stop", async () => {
    const fetchMock = vi.fn(async () => { throw new Error("offline"); });
    vi.stubGlobal("fetch", fetchMock);
    await clearImageSession();
    const callsBefore = fetchMock.mock.calls.length;
    await expect(ensureImageSession({ force: true })).resolves.toBe(false);
    expect(fetchMock.mock.calls.length).toBe(callsBefore);
  });
});

// ─── THE KILL SWITCH HAS TO BE WIRED TO THE BUTTON ──────────────────────────
//
// clearImageSession() was written, exported, tested, and never called. Both
// sign-out buttons called supabase.auth.signOut() alone, so signing out in the
// real product left the image cookie live for the rest of its fifteen minutes
// and never moved the account's revocation marker. Checked against production:
// nought of nine accounts carried a marker, because nothing had ever written
// one. Unit tests cannot catch an uncalled function, so this reads the source.

describe("every sign-out path revokes the image session", () => {
  const SIGN_OUT_FILES = [
    "components/dashboard/Sidebar.tsx",
    "app/dashboard/settings/page.tsx",
  ];

  /** Every .ts/.tsx under a directory, so the scan cannot miss a new file. */
  const walk = (dir: string): string[] =>
    fs.readdirSync(path.join(process.cwd(), dir), { withFileTypes: true })
      .flatMap((e) => {
        const rel = `${dir}/${e.name}`;
        if (e.isDirectory()) return walk(rel);
        return /\.tsx?$/.test(e.name) && !/\.test\.tsx?$/.test(e.name) ? [rel] : [];
      });

  /** Source with comments removed, so a mention in prose is not a call site. */
  const code = (file: string) =>
    fs.readFileSync(path.join(process.cwd(), file), "utf8")
      .replace(/\/\*[\s\S]*?\*\//g, "")
      .replace(/^\s*\/\/.*$/gm, "");

  it("discovers every place that signs out, so this list cannot go stale", () => {
    // DISCOVERED, NOT LISTED. A hard-coded list is exactly how the gap this
    // suite exists for survived: the function was there, the list of callers
    // was in nobody's head, and no test could notice. If a third sign-out
    // appears anywhere under app/ or components/, this fails until somebody
    // adds it above and therefore looks at it.
    const callers = ["app", "components"]
      .flatMap(walk)
      .filter((f) => /auth\.signOut\s*\(/.test(code(f)));
    expect(callers.sort()).toEqual([...SIGN_OUT_FILES].sort());
  });

  it.each(SIGN_OUT_FILES)("%s clears the image session", (file) => {
    const src = fs.readFileSync(path.join(process.cwd(), file), "utf8");
    expect(src).toMatch(/clearImageSession\(\)/);
  });

  it.each(SIGN_OUT_FILES)("%s clears it BEFORE signOut, while the token is alive", (file) => {
    const src = fs.readFileSync(path.join(process.cwd(), file), "utf8");
    // Revoking needs a bearer token to say whose sessions to revoke, and
    // signOut() takes it away. The wrong order revokes nothing.
    expect(src.indexOf("clearImageSession()")).toBeLessThan(src.indexOf("auth.signOut()"));
  });

  it.each(SIGN_OUT_FILES)("%s awaits it, so the request is actually sent", (file) => {
    const src = fs.readFileSync(path.join(process.cwd(), file), "utf8");
    expect(src).toMatch(/await clearImageSession\(\)/);
  });
});
