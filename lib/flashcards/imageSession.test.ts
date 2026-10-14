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
    const { token } = mintImageSession(USER, SECRET, NOW);
    const r = verifyImageSession(token, SECRET, NOW);
    expect(r.ok).toBe(true);
    if (r.ok) expect(r.claim.userId).toBe(USER);
  });

  it("expires, and is refused the instant it does", () => {
    const { token, expiresAt } = mintImageSession(USER, SECRET, NOW);
    const justBefore = new Date(expiresAt * 1000 - 1000);
    const atExpiry = new Date(expiresAt * 1000);
    expect(verifyImageSession(token, SECRET, justBefore).ok).toBe(true);
    expect(verifyImageSession(token, SECRET, atExpiry)).toEqual({ ok: false, reason: "expired" });
  });
});

describe("a token this server did not mint", () => {
  it("is refused when signed with another secret", () => {
    const { token } = mintImageSession(USER, OTHER, NOW);
    expect(verifyImageSession(token, SECRET, NOW)).toEqual({ ok: false, reason: "bad_signature" });
  });

  it("is refused when the payload is edited to name someone else", () => {
    const { token } = mintImageSession(USER, SECRET, NOW);
    const [v, payload, sig] = token.split(".");
    const claim = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    claim.u = "11111111-1111-4111-8111-111111111111";
    const forged = Buffer.from(JSON.stringify(claim)).toString("base64url");
    expect(verifyImageSession(`${v}.${forged}.${sig}`, SECRET, NOW)).toEqual({
      ok: false, reason: "bad_signature",
    });
  });

  it("is refused when the expiry is pushed into the future by hand", () => {
    const { token } = mintImageSession(USER, SECRET, NOW);
    const [v, payload, sig] = token.split(".");
    const claim = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    claim.e = claim.e + 86_400 * 3650;
    const forged = Buffer.from(JSON.stringify(claim)).toString("base64url");
    expect(verifyImageSession(`${v}.${forged}.${sig}`, SECRET, NOW).ok).toBe(false);
  });

  it.each([
    ["nothing at all", ""],
    ["a bare word", "letmein"],
    ["the wrong version", "v2.abc.def"],
    ["too few parts", "v1.abc"],
    ["too many parts", "v1.a.b.c"],
    ["an unsigned payload", `v1.${Buffer.from('{"u":"x","e":99999999999}').toString("base64url")}.`],
  ])("is refused: %s", (_why, token) => {
    expect(verifyImageSession(token, SECRET, NOW).ok).toBe(false);
  });

  it("is refused when the signature is a different length, without throwing", () => {
    const { token } = mintImageSession(USER, SECRET, NOW);
    const [v, payload] = token.split(".");
    expect(() => verifyImageSession(`${v}.${payload}.short`, SECRET, NOW)).not.toThrow();
    expect(verifyImageSession(`${v}.${payload}.short`, SECRET, NOW).ok).toBe(false);
  });
});

describe("without a secret nothing works, in the safe direction", () => {
  it("refuses to verify", () => {
    const { token } = mintImageSession(USER, SECRET, NOW);
    expect(verifyImageSession(token, "", NOW)).toEqual({ ok: false, reason: "no_secret" });
    expect(verifyImageSession(token, null, NOW)).toEqual({ ok: false, reason: "no_secret" });
  });

  it("refuses to mint", () => {
    expect(() => mintImageSession(USER, "", NOW)).toThrow();
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
// the rest of the day. The lifetime is now minutes, and the account carries a
// timestamp that kills every cookie issued before it.

describe("sign-out invalidates outstanding cookies", () => {
  const claimAt = (iso: string) => {
    const r = verifyImageSession(mintImageSession(USER, SECRET, new Date(iso)).token, SECRET, new Date(iso));
    if (!r.ok) throw new Error("mint failed");
    return r.claim;
  };

  it("refuses a cookie issued before the account's cutoff", () => {
    expect(isSessionSuperseded(claimAt("2026-10-13T11:00:00Z"), "2026-10-13T12:00:00Z")).toBe(true);
  });

  it("accepts one issued after it", () => {
    expect(isSessionSuperseded(claimAt("2026-10-13T13:00:00Z"), "2026-10-13T12:00:00Z")).toBe(false);
  });

  it("accepts anything when the account has never signed out", () => {
    expect(isSessionSuperseded(claimAt("2026-10-13T11:00:00Z"), null)).toBe(false);
  });

  it("refuses rather than guesses when the cutoff is unreadable", () => {
    expect(isSessionSuperseded(claimAt("2026-10-13T11:00:00Z"), "not a date")).toBe(true);
  });

  it("carries the issue time, or the cutoff could not be applied at all", () => {
    const r = verifyImageSession(mintImageSession(USER, SECRET, NOW).token, SECRET, NOW);
    expect(r.ok).toBe(true);
    if (r.ok) expect(r.claim.issuedAt).toBe(Math.floor(NOW.getTime() / 1000));
  });

  it("rejects a token with no issue time, so an old cookie cannot dodge the cutoff", () => {
    // Exactly the v1 payload shape from before this change.
    const legacy = Buffer.from(JSON.stringify({ u: USER, e: 9_999_999_999 })).toString("base64url");
    expect(verifyImageSession(`v1.${legacy}.anything`, SECRET, NOW).ok).toBe(false);
  });

  it("lives for minutes, not hours", () => {
    expect(IMAGE_SESSION_TTL_SECONDS).toBeLessThanOrEqual(30 * 60);
  });
});
