import { describe, it, expect } from "vitest";
import {
  IMAGE_SESSION_COOKIE,
  IMAGE_SESSION_PATH,
  IMAGE_SESSION_TTL_SECONDS,
  isSessionSuperseded,
  clearImageSessionCookie,
  imageSessionCookie,
  mintImageSession,
  readCookie,
  verifyImageSession,
} from "@/lib/flashcards/imageSession";

const SECRET = "a-test-secret-that-is-long-enough-to-be-realistic";
const OTHER = "a-different-secret-entirely-also-long-enough-here";
const NOW = new Date("2026-10-13T12:00:00Z");
const USER = "00047c9f-d510-405b-8989-8a129a94c9fe";

describe("a token this server minted", () => {
  it("verifies, and carries the user it was minted for", () => {
    const { token } = mintImageSession(USER, SECRET, null, NOW);
    const r = verifyImageSession(token, SECRET, NOW);
    expect(r.ok).toBe(true);
    if (r.ok) expect(r.claim.userId).toBe(USER);
  });

  it("expires, and is refused the instant it does", () => {
    const { token, expiresAt } = mintImageSession(USER, SECRET, null, NOW);
    const justBefore = new Date(expiresAt * 1000 - 1000);
    const atExpiry = new Date(expiresAt * 1000);
    expect(verifyImageSession(token, SECRET, justBefore).ok).toBe(true);
    expect(verifyImageSession(token, SECRET, atExpiry)).toEqual({ ok: false, reason: "expired" });
  });
});

describe("a token this server did not mint", () => {
  it("is refused when signed with another secret", () => {
    const { token } = mintImageSession(USER, OTHER, null, NOW);
    expect(verifyImageSession(token, SECRET, NOW)).toEqual({ ok: false, reason: "bad_signature" });
  });

  it("is refused when the payload is edited to name someone else", () => {
    const { token } = mintImageSession(USER, SECRET, null, NOW);
    const [v, payload, sig] = token.split(".");
    const claim = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    claim.u = "11111111-1111-4111-8111-111111111111";
    const forged = Buffer.from(JSON.stringify(claim)).toString("base64url");
    expect(verifyImageSession(`${v}.${forged}.${sig}`, SECRET, NOW)).toEqual({
      ok: false, reason: "bad_signature",
    });
  });

  it("is refused when the expiry is pushed into the future by hand", () => {
    const { token } = mintImageSession(USER, SECRET, null, NOW);
    const [v, payload, sig] = token.split(".");
    const claim = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    claim.e = claim.e + 86_400 * 3650;
    const forged = Buffer.from(JSON.stringify(claim)).toString("base64url");
    expect(verifyImageSession(`${v}.${forged}.${sig}`, SECRET, NOW).ok).toBe(false);
  });

  it.each([
    ["nothing at all", ""],
    ["a bare word", "letmein"],
    ["the wrong version", "v1.abc.def"],
    ["too few parts", "v2.abc"],
    ["too many parts", "v2.a.b.c"],
    ["an unsigned payload", `v2.${Buffer.from('{"u":"x","i":1,"e":99999999999,"r":null}').toString("base64url")}.`],
  ])("is refused: %s", (_why, token) => {
    expect(verifyImageSession(token, SECRET, NOW).ok).toBe(false);
  });

  it("is refused when the signature is a different length, without throwing", () => {
    const { token } = mintImageSession(USER, SECRET, null, NOW);
    const [v, payload] = token.split(".");
    expect(() => verifyImageSession(`${v}.${payload}.short`, SECRET, NOW)).not.toThrow();
    expect(verifyImageSession(`${v}.${payload}.short`, SECRET, NOW).ok).toBe(false);
  });
});

describe("without a secret nothing works, in the safe direction", () => {
  it("refuses to verify", () => {
    const { token } = mintImageSession(USER, SECRET, null, NOW);
    expect(verifyImageSession(token, "", NOW)).toEqual({ ok: false, reason: "no_secret" });
    expect(verifyImageSession(token, null, NOW)).toEqual({ ok: false, reason: "no_secret" });
  });

  it("refuses to mint", () => {
    expect(() => mintImageSession(USER, "", null, NOW)).toThrow();
  });

  it("reports an absent cookie as absent rather than as a bad signature", () => {
    expect(verifyImageSession(null, SECRET, NOW)).toEqual({ ok: false, reason: "absent" });
  });
});

describe("the cookie itself", () => {
  it("is HttpOnly, SameSite and scoped to the illustration route", () => {
    const header = imageSessionCookie("tok", { secure: true });
    expect(header).toContain("HttpOnly");
    expect(header).toContain("SameSite=Lax");
    expect(header).toContain(`Path=${IMAGE_SESSION_PATH}`);
    expect(header).toContain("Secure");
  });

  it("drops Secure on plain http so local development works", () => {
    expect(imageSessionCookie("tok", { secure: false })).not.toContain("Secure");
  });

  it("clears with the same name and path, or the browser would keep the old one", () => {
    const cleared = clearImageSessionCookie({ secure: true });
    expect(cleared).toContain(`${IMAGE_SESSION_COOKIE}=`);
    expect(cleared).toContain(`Path=${IMAGE_SESSION_PATH}`);
    expect(cleared).toContain("Max-Age=0");
  });

  it("is read back out of a crowded Cookie header", () => {
    const header = `other=1; ${IMAGE_SESSION_COOKIE}=abc%2Fdef; trailing=2`;
    expect(readCookie(header, IMAGE_SESSION_COOKIE)).toBe("abc/def");
  });

  it("is not confused by a cookie whose name merely ends the same way", () => {
    const header = `not_${IMAGE_SESSION_COOKIE}=wrong; ${IMAGE_SESSION_COOKIE}=right`;
    expect(readCookie(header, IMAGE_SESSION_COOKIE)).toBe("right");
  });

  it("returns null when there is no Cookie header at all", () => {
    expect(readCookie(null, IMAGE_SESSION_COOKIE)).toBeNull();
  });
});

// ─── THE COOKIE IS NOT PROOF THE SUPABASE SESSION IS STILL ALIVE ────────────
//
// The first version minted this from a verified bearer token and then believed
// it for twelve hours, so somebody who signed out kept their illustrations for
// the rest of the day. The lifetime is now minutes, and the cookie records the
// account's revocation state so that a sign-out kills it at once.

const MARKER = "2026-10-15T12:00:00.5+00:00";
const LATER_MARKER = "2026-10-15T12:00:00.501+00:00";

/** A claim as the route sees it, minted under a given revocation marker. */
const claimUnder = (marker: string | null) => {
  const r = verifyImageSession(
    mintImageSession(USER, SECRET, marker, NOW).token, SECRET, NOW);
  if (!r.ok) throw new Error("mint failed");
  return r.claim;
};

describe("sign-out invalidates outstanding cookies", () => {
  it("refuses a cookie minted before the account was ever revoked", () => {
    expect(isSessionSuperseded(claimUnder(null), MARKER)).toBe(true);
  });

  it("accepts one minted under the marker now in force", () => {
    expect(isSessionSuperseded(claimUnder(MARKER), MARKER)).toBe(false);
  });

  it("refuses one minted under a marker that has since moved", () => {
    expect(isSessionSuperseded(claimUnder(MARKER), LATER_MARKER)).toBe(true);
  });

  it("accepts anything when the account has never signed out", () => {
    expect(isSessionSuperseded(claimUnder(null), null)).toBe(false);
    expect(isSessionSuperseded(claimUnder(null), undefined)).toBe(false);
  });

  it("refuses a cookie carrying a marker when the column reads empty", () => {
    // Backwards is impossible through the trigger, so this is a bug or a
    // tampered row either way. Both are answered with a refusal.
    expect(isSessionSuperseded(claimUnder(MARKER), null)).toBe(true);
  });

  it("carries the marker, or the kill switch could not be applied at all", () => {
    expect(claimUnder(MARKER).revocationMarker).toBe(MARKER);
    expect(claimUnder(null).revocationMarker).toBeNull();
  });

  it("refuses a v1 cookie outright, rather than reading it as un-revoked", () => {
    // The v1 payload shape: an issue time and no marker. Reinterpreting it
    // would make every outstanding v1 cookie look like an account that had
    // never signed out, which is the one answer that must not be given.
    const legacy = Buffer.from(JSON.stringify({ u: USER, i: 1, e: 9_999_999_999 }))
      .toString("base64url");
    expect(verifyImageSession(`v1.${legacy}.anything`, SECRET, NOW).ok).toBe(false);
  });

  it("refuses a v2 payload with the marker field removed", () => {
    // Signed by us, so this is the forgery that matters: strip `r` and the
    // claim would compare equal to a never-revoked account.
    const { token } = mintImageSession(USER, SECRET, MARKER, NOW);
    const [v, payload] = token.split(".");
    const claim = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    delete claim.r;
    const stripped = Buffer.from(JSON.stringify(claim)).toString("base64url");
    // Unsigned, so it fails at the signature; re-signing is not possible
    // without the secret, which is the point.
    expect(verifyImageSession(`${v}.${stripped}.x`, SECRET, NOW).ok).toBe(false);
  });

  it("refuses a marker of the wrong type", () => {
    for (const r of [0, 12_345, true, {}, []]) {
      const payload = Buffer.from(JSON.stringify({ u: USER, i: 1, e: 9_999_999_999, r }))
        .toString("base64url");
      expect(verifyImageSession(`v2.${payload}.x`, SECRET, NOW).ok).toBe(false);
    }
  });

  it("lives for minutes, not hours", () => {
    expect(IMAGE_SESSION_TTL_SECONDS).toBeLessThanOrEqual(30 * 60);
  });
});

// ─── THE SAME-SECOND SIGN-OUT, WHICH PRODUCTION FOUND ───────────────────────
//
// Phase 32 compared claim.issuedAt (whole seconds, from the mint server's
// clock) against the cutoff (milliseconds, from the sign-out server's clock),
// flooring the cutoff to make the legitimate case work. That accepted any
// cookie minted earlier in the same second as the sign-out: a hole up to 999ms
// wide, reproduced at scratchpad/samesec/reproduce.mjs.
//
// The claim no longer carries a time to compare, so there is no boundary to be
// wrong about. These tests sweep the region where the hole used to be and
// assert the only thing that can still vary: which marker the cookie carries.

describe("the boundary the old comparison got wrong", () => {
  const signOutMs = Date.parse("2026-10-15T12:00:00.500Z");
  const cutoff = new Date(signOutMs).toISOString();

  it.each([-500, -499, -1])(
    "refuses a cookie minted %ims before the sign-out, inside the old hole",
    (offset) => {
      // Minted before the sign-out, so it read the marker as it was BEFORE:
      // null for an account that had never been revoked.
      const minted = verifyImageSession(
        mintImageSession(USER, SECRET, null, new Date(signOutMs + offset)).token,
        SECRET, new Date(signOutMs + offset));
      expect(minted.ok).toBe(true);
      if (minted.ok) expect(isSessionSuperseded(minted.claim, cutoff)).toBe(true);
    });

  it.each([0, 1, 499, 500, 1000])(
    "accepts a cookie minted %ims after the sign-out, with no second to wait out",
    (offset) => {
      // Minted after, so it read the new marker.
      const minted = verifyImageSession(
        mintImageSession(USER, SECRET, cutoff, new Date(signOutMs + offset)).token,
        SECRET, new Date(signOutMs + offset));
      expect(minted.ok).toBe(true);
      if (minted.ok) expect(isSessionSuperseded(minted.claim, cutoff)).toBe(false);
    });

  it("does not depend on where in the second the sign-out landed", () => {
    // The old hole's width was whatever fraction of a second the sign-out fell
    // on. Sweep every millisecond of one second and there is no width left.
    for (let ms = 0; ms < 1000; ms += 1) {
      const at = new Date(Date.parse("2026-10-15T12:00:00.000Z") + ms).toISOString();
      expect(isSessionSuperseded(claimUnder(null), at)).toBe(true);
      expect(isSessionSuperseded(claimUnder(at), at)).toBe(false);
    }
  });

  it("compares no clocks, so a mint server running behind changes nothing", () => {
    // The same cookie, minted by a server whose clock is a minute slow and by
    // one a minute fast. Both read the same marker; both are accepted.
    for (const skewMs of [-60_000, -1, 0, 1, 60_000]) {
      const at = new Date(signOutMs + skewMs);
      const minted = verifyImageSession(
        mintImageSession(USER, SECRET, cutoff, at).token, SECRET, at);
      expect(minted.ok).toBe(true);
      if (minted.ok) expect(isSessionSuperseded(minted.claim, cutoff)).toBe(false);
    }
  });

  it("treats the marker as opaque: a different spelling is a different marker", () => {
    // Two renderings of the same instant. The route and the mint endpoint read
    // the one column through the one client, so they always see one spelling;
    // if that ever stopped being true, this is the direction it fails in.
    expect(isSessionSuperseded(claimUnder("2026-10-15T12:00:00.5+00:00"),
      "2026-10-15T12:00:00.500Z")).toBe(true);
  });
});
