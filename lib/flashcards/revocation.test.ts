import { describe, it, expect } from "vitest";
import {
  advanceRevocationMarker,
  decideMint,
  markerChanged,
  nextMarker,
  type MarkerRead,
  type SwapOutcome,
} from "@/lib/flashcards/revocation";
import { isSessionSuperseded } from "@/lib/flashcards/imageSession";

// ─── WHY THESE TESTS LOOK LIKE THIS ─────────────────────────────────────────
//
// Every defect this module exists to fix is an ORDERING defect between two
// concurrent requests. A test that calls one sequence and then the other proves
// nothing: that is the mistake the first draft of the Phase 32.2 audit script
// made, where both sign-outs read one after the other so the second saw the
// first's write and no race was possible. The model was wrong, not the code.
//
// So the world here is explicit. `World` holds the two pieces of state that
// matter, and a test advances it AT A CHOSEN POINT inside the other sequence by
// hooking the dependency that is called at that point. The interleavings are
// selected, not hoped for, and they are the same every run.

/** The two pieces of state a sign-out changes, and nothing else. */
class World {
  sessionsAlive = true;
  marker: string | null = null;
  profileExists = true;
  readable = true;
  writable = true;
  /** Markers this world has ever held, to catch a value being reused. */
  history: Array<string | null> = [null];

  /** S1: what the Supabase global logout does. */
  deleteSessions() {
    this.sessionsAlive = false;
  }

  /** S2, applied directly: what a successful marker advance does. */
  setMarker(value: string) {
    this.marker = value;
    this.history.push(value);
  }

  read(): MarkerRead {
    if (!this.readable) return { ok: false };
    if (!this.profileExists) return { ok: true, exists: false };
    return { ok: true, exists: true, marker: this.marker };
  }

  /** A real compare-and-swap: the predicate is checked against live state. */
  swap(expected: string | null, next: string): SwapOutcome {
    if (!this.writable) return { outcome: "error" };
    if ((this.marker ?? null) !== (expected ?? null)) return { outcome: "conflict" };
    this.setMarker(next);
    // `stored` is what the database hands back, which is what the module
    // judges success on. Omitting it here made six tests fail with "the column
    // did not move", which was the harness lying, not the module misbehaving.
    return { outcome: "written", stored: this.marker };
  }
}

/** A cookie, as the image route would see it. */
const cookie = (marker: string | null) => ({
  userId: "u", issuedAt: 0, expiresAt: 9_999_999_999, revocationMarker: marker,
});
/** The real rule the route applies. Nothing here reimplements it. */
const servedBy = (world: World, c: ReturnType<typeof cookie>) =>
  !isSessionSuperseded(c, world.marker);

/**
 * A mint against a world, with an optional hook fired at a chosen step so a
 * sign-out can be interleaved exactly there.
 */
function mintIn(
  world: World,
  hooks: { beforeMarkerRead?: () => void; afterMarkerRead?: () => void } = {},
  options: { recheck?: boolean } = {},
) {
  const recheck = options.recheck ?? true;
  const verify = async () => (world.sessionsAlive ? "u" : null);
  return decideMint({
    verifySession: recheck
      ? verify
      // The pre-Phase-33 behaviour: verify once, at the start, and never again.
      : (() => { let first = true; return async () => (first ? ((first = false), await verify()) : "u"); })(),
    readMarker: async () => {
      hooks.beforeMarkerRead?.();
      const r = world.read();
      hooks.afterMarkerRead?.();
      return r;
    },
  });
}

/** A sign-out, in the order the route performs it: sessions, then marker. */
function signOutIn(world: World, nowMs: number, maxAttempts?: number) {
  world.deleteSessions();                                    // S1
  return advanceRevocationMarker({                           // S2
    read: async () => world.read(),
    swap: async (expected, next) => world.swap(expected, next),
    now: () => nowMs,
    maxAttempts,
  });
}

// ─── THE ORIGINAL DEFECTS, REPRODUCED ───────────────────────────────────────

describe("defect A: a mint interleaved with a sign-out", () => {
  it("REPRODUCES the defect when the session is verified only once", async () => {
    // This is the shipped Phase 32.1 behaviour, kept as a test so the fix
    // cannot be quietly undone: P1 passes, the whole sign-out happens, then P2
    // reads the NEW marker.
    const world = new World();
    const decision = await mintIn(world, {
      beforeMarkerRead: () => {
        world.deleteSessions();
        world.setMarker("2026-10-16T10:00:00.000Z");
      },
    }, { recheck: false });

    expect(decision.ok).toBe(true);
    if (!decision.ok) return;
    expect(decision.marker).toBe("2026-10-16T10:00:00.000Z");
    // And the cookie it would issue is accepted, after a sign-out.
    expect(servedBy(world, cookie(decision.marker))).toBe(true);
  });

  it("is CLOSED by rechecking the session after the marker read", async () => {
    const world = new World();
    const decision = await mintIn(world, {
      beforeMarkerRead: () => {
        world.deleteSessions();
        world.setMarker("2026-10-16T10:00:00.000Z");
      },
    });
    // P3 finds no session, so nothing is minted at all.
    expect(decision).toEqual({ ok: false, reason: "session_ended" });
  });

  it("is closed wherever in the sequence the sign-out lands", async () => {
    // Sweep every interleaving point and assert the invariant directly: if a
    // cookie is issued, it is NOT accepted after the sign-out completes.
    const points: Array<keyof { beforeMarkerRead: 0; afterMarkerRead: 0 }> = [
      "beforeMarkerRead", "afterMarkerRead",
    ];
    for (const point of points) {
      const world = new World();
      const decision = await mintIn(world, {
        [point]: () => {
          world.deleteSessions();
          world.setMarker("2026-10-16T10:00:00.000Z");
        },
      });
      if (decision.ok) {
        expect(servedBy(world, cookie(decision.marker)), `issued at ${point}`).toBe(false);
      } else {
        expect(decision.reason).toBe("session_ended");
      }
    }
  });

  it("still mints normally when no sign-out is happening", async () => {
    const world = new World();
    world.setMarker("2026-10-16T09:00:00.000Z");
    const decision = await mintIn(world);
    expect(decision).toEqual({ ok: true, userId: "u", marker: "2026-10-16T09:00:00.000Z" });
    expect(servedBy(world, cookie("2026-10-16T09:00:00.000Z"))).toBe(true);
  });

  it("refuses to mint for a session that has already ended", async () => {
    const world = new World();
    world.deleteSessions();
    expect(await mintIn(world)).toEqual({ ok: false, reason: "not_signed_in" });
  });

  it("refuses to mint when the marker cannot be read, rather than guessing", async () => {
    const world = new World();
    world.readable = false;
    expect(await mintIn(world)).toEqual({ ok: false, reason: "marker_unavailable" });
  });
});

describe("defect B: two sign-outs in the same millisecond", () => {
  it("REPRODUCES the defect with a blind read-modify-write", async () => {
    // The shipped behaviour: both read, both compute the same replacement from
    // the same clock, the second write is a no-op.
    const world = new World();
    const seenA = world.marker, seenB = world.marker;
    const sameMs = Date.parse("2026-10-16T10:00:00.000Z");
    const nextA = nextMarker(seenA, sameMs);
    const nextB = nextMarker(seenB, sameMs);
    expect(nextA).toBe(nextB);

    world.marker = nextA;                       // A's blind write
    const racing = cookie(world.marker);        // a mint lands between them
    world.marker = nextB;                       // B's blind write: no change
    expect(servedBy(world, racing)).toBe(true); // survives sign-out B
  });

  it("is CLOSED by the compare-and-swap", async () => {
    const world = new World();
    const sameMs = Date.parse("2026-10-16T10:00:00.000Z");

    // Both sign-outs read first, as two concurrent requests do.
    const seenA = world.marker;
    const seenB = world.marker;

    // A commits.
    expect(world.swap(seenA, nextMarker(seenA, sameMs)).outcome).toBe("written");
    const racing = cookie(world.marker);

    // B's predicate no longer matches, so it cannot overwrite A's value with
    // the same one. It re-reads and must advance past it.
    expect(world.swap(seenB, nextMarker(seenB, sameMs)).outcome).toBe("conflict");
    const reread = world.marker;
    expect(world.swap(reread, nextMarker(reread, sameMs)).outcome).toBe("written");

    expect(servedBy(world, racing)).toBe(false);
    expect(new Set(world.history).size).toBe(world.history.length); // no value reused
  });
});

// ─── THE REPLACEMENT, AGAINST MIKKO'S CHECKLIST ─────────────────────────────

describe("the compare-and-swap, case by case", () => {
  const at = (iso: string) => Date.parse(iso);

  it("advances from a NULL marker", async () => {
    const world = new World();
    const r = await signOutIn(world, at("2026-10-16T10:00:00.000Z"));
    expect(r).toEqual({
      revoked: true, reason: "advanced", marker: "2026-10-16T10:00:00.000Z",
    });
  });

  it("advances strictly past a value the clock is BEHIND", async () => {
    // Server clock an hour behind the stored marker: the write must still move
    // forward, or the sign-out silently revokes nothing.
    const world = new World();
    world.setMarker("2026-10-16T11:00:00.000Z");
    const r = await signOutIn(world, at("2026-10-16T10:00:00.000Z"));
    expect(r.revoked).toBe(true);
    expect(Date.parse(r.marker!)).toBeGreaterThan(at("2026-10-16T11:00:00.000Z"));
    expect(r.marker).toBe("2026-10-16T11:00:00.001Z");
  });

  it("two simultaneous sign-outs BOTH end up reporting the truth", async () => {
    const world = new World();
    const sameMs = at("2026-10-16T10:00:00.000Z");
    const deps = {
      read: async () => world.read(),
      swap: async (e: string | null, n: string) => world.swap(e, n),
      now: () => sameMs,
    };
    world.deleteSessions();
    const [a, b] = await Promise.all([
      advanceRevocationMarker(deps),
      advanceRevocationMarker(deps),
    ]);
    // Both are honest: each either moved it or saw a peer move it past the
    // value it started from. Neither reports a failure it did not have.
    expect(a.revoked).toBe(true);
    expect(b.revoked).toBe(true);
    expect([a.reason, b.reason].every((x) => x === "advanced" || x === "advanced_by_peer")).toBe(true);
    expect(new Set(world.history).size).toBe(world.history.length);
  });

  it("three simultaneous sign-outs leave a monotonic history and no reused value", async () => {
    const world = new World();
    let tick = at("2026-10-16T10:00:00.000Z");
    const deps = {
      read: async () => world.read(),
      swap: async (e: string | null, n: string) => world.swap(e, n),
      now: () => tick++,
    };
    world.deleteSessions();
    const results = await Promise.all([1, 2, 3].map(() => advanceRevocationMarker(deps)));
    expect(results.every((r) => r.revoked)).toBe(true);
    const written = world.history.slice(1).map((m) => Date.parse(m!));
    expect(written).toEqual([...written].sort((x, y) => x - y));   // monotonic
    expect(new Set(written).size).toBe(written.length);            // no duplicates
  });

  it("treats a zero-row update as a conflict and retries, not as an error", async () => {
    const world = new World();
    let swaps = 0;
    const r = await advanceRevocationMarker({
      read: async () => world.read(),
      swap: async (expected, next) => {
        swaps += 1;
        // First attempt: somebody else got there, and they did NOT move it past
        // where we began, so our job is not done and we must try again.
        if (swaps === 1) return { outcome: "conflict" };
        return world.swap(expected, next);
      },
      now: () => Date.parse("2026-10-16T10:00:00.000Z"),
    });
    expect(swaps).toBe(2);
    expect(r.revoked).toBe(true);
    expect(r.reason).toBe("advanced");
  });

  it("stops on a genuine write error and reports it unavailable", async () => {
    const world = new World();
    world.writable = false;
    const r = await signOutIn(world, Date.parse("2026-10-16T10:00:00.000Z"));
    expect(r).toEqual({ revoked: false, reason: "unavailable", marker: null });
    expect(world.marker).toBeNull();
  });

  it("reports a peer's advance as success rather than lying pessimistically", async () => {
    const world = new World();
    const r = await advanceRevocationMarker({
      read: async () => world.read(),
      swap: async () => {
        // Lose the race, and the winner moved it past where we began.
        world.setMarker("2026-10-16T10:00:00.500Z");
        return { outcome: "conflict" };
      },
      now: () => Date.parse("2026-10-16T10:00:00.000Z"),
    });
    expect(r).toEqual({
      revoked: true, reason: "advanced_by_peer", marker: "2026-10-16T10:00:00.500Z",
    });
  });

  it("gives up after bounded attempts and does NOT claim success", async () => {
    const world = new World();
    let swaps = 0;
    const r = await advanceRevocationMarker({
      read: async () => world.read(),
      swap: async () => { swaps += 1; return { outcome: "conflict" }; },
      now: () => Date.parse("2026-10-16T10:00:00.000Z"),
      maxAttempts: 4,
    });
    expect(swaps).toBe(4);
    expect(r).toEqual({ revoked: false, reason: "contended", marker: null });
  });

  it("never reports success when the column did not move", async () => {
    // A write that lands but stores the value we started from is not a
    // revocation, whatever the database says about rows affected.
    const world = new World();
    const r = await advanceRevocationMarker({
      read: async () => ({ ok: true, exists: true, marker: "same" }),
      swap: async () => ({ outcome: "written", stored: "same" }),
      now: () => Date.parse("2026-10-16T10:00:00.000Z"),
    });
    expect(r.revoked).toBe(false);
    expect(r.reason).toBe("unavailable");
    void world;
  });

  it("says so plainly when there is no profile row", async () => {
    const world = new World();
    world.profileExists = false;
    expect(await signOutIn(world, 0)).toEqual({ revoked: false, reason: "no_profile", marker: null });
  });

  it("reports unavailable when the marker cannot even be read", async () => {
    const world = new World();
    world.readable = false;
    expect(await signOutIn(world, 0)).toEqual({ revoked: false, reason: "unavailable", marker: null });
  });
});

// ─── THE FAILURE PATHS, STATED RATHER THAN HIDDEN ───────────────────────────

describe("case B: the sessions go but the marker write does not", () => {
  it("leaves outstanding cookies valid, and REPORTS that it did", async () => {
    const world = new World();
    world.setMarker("2026-10-16T09:00:00.000Z");
    const outstanding = cookie("2026-10-16T09:00:00.000Z");
    world.writable = false;

    const r = await signOutIn(world, Date.parse("2026-10-16T10:00:00.000Z"));

    // This is the residual risk, asserted so nobody can claim it was closed.
    expect(r.revoked).toBe(false);
    expect(r.reason).toBe("unavailable");
    expect(servedBy(world, outstanding)).toBe(true);
    // But nothing new can be minted, because the sessions are gone.
    expect(await mintIn(world)).toEqual({ ok: false, reason: "not_signed_in" });
  });

  it("and a retry once the database recovers does invalidate them", async () => {
    const world = new World();
    world.setMarker("2026-10-16T09:00:00.000Z");
    const outstanding = cookie("2026-10-16T09:00:00.000Z");
    world.writable = false;
    expect((await signOutIn(world, Date.parse("2026-10-16T10:00:00.000Z"))).revoked).toBe(false);

    world.writable = true;
    const retry = await advanceRevocationMarker({
      read: async () => world.read(),
      swap: async (e, n) => world.swap(e, n),
      now: () => Date.parse("2026-10-16T10:00:01.000Z"),
    });
    expect(retry.revoked).toBe(true);
    expect(servedBy(world, outstanding)).toBe(false);
  });
});

describe("after a completed sign-out", () => {
  it("a repeated sign-out cannot be performed at all, and does not claim to be", async () => {
    const world = new World();
    const first = await signOutIn(world, Date.parse("2026-10-16T10:00:00.000Z"));
    expect(first.revoked).toBe(true);

    // The caller's token is dead now, so the route never reaches the marker.
    // Modelled here as what the route does: no verified user, no advance.
    const verified = world.sessionsAlive ? "u" : null;
    expect(verified).toBeNull();
    // And it did not need to: the marker already moved.
    expect(servedBy(world, cookie(null))).toBe(false);
  });

  it("signing straight back in works immediately, with no second to wait out", async () => {
    const world = new World();
    await signOutIn(world, Date.parse("2026-10-16T10:00:00.000Z"));
    const after = world.marker;

    world.sessionsAlive = true;                 // a new sign-in, same millisecond
    const decision = await mintIn(world);
    expect(decision.ok).toBe(true);
    if (!decision.ok) return;
    expect(decision.marker).toBe(after);
    expect(servedBy(world, cookie(decision.marker))).toBe(true);
  });

  it("concurrent mints during a sign-out either fail or carry the old marker", async () => {
    const world = new World();
    world.setMarker("2026-10-16T09:00:00.000Z");
    const old = world.marker;

    // Five mints in flight; the sign-out lands inside the third one's read.
    const decisions = await Promise.all([0, 1, 2, 3, 4].map((i) =>
      mintIn(world, i === 2 ? {
        beforeMarkerRead: () => {
          world.deleteSessions();
          world.setMarker("2026-10-16T10:00:00.000Z");
        },
      } : {}),
    ));

    for (const d of decisions) {
      if (d.ok) {
        expect(d.marker).toBe(old);                     // never the new one
        expect(servedBy(world, cookie(d.marker))).toBe(false);
      } else {
        expect(["session_ended", "not_signed_in"]).toContain(d.reason);
      }
    }
  });
});

describe("the helpers themselves", () => {
  it("nextMarker is strictly later than the value it replaces", () => {
    expect(nextMarker("2026-10-16T10:00:00.000Z", Date.parse("2026-10-16T09:00:00.000Z")))
      .toBe("2026-10-16T10:00:00.001Z");
    expect(nextMarker(null, Date.parse("2026-10-16T10:00:00.000Z")))
      .toBe("2026-10-16T10:00:00.000Z");
  });

  it("nextMarker falls back to the clock for an unreadable stored value", () => {
    expect(nextMarker("not a date", Date.parse("2026-10-16T10:00:00.000Z")))
      .toBe("2026-10-16T10:00:00.000Z");
  });

  it("markerChanged matches the rule the route actually applies", () => {
    // Identity, same as isSessionSuperseded, so the two can never disagree.
    for (const [a, b] of [[null, "x"], ["x", null], ["x", "y"], ["x", "x"], [null, null]] as const) {
      expect(markerChanged(a, b)).toBe(isSessionSuperseded(cookie(a), b));
    }
  });
});
