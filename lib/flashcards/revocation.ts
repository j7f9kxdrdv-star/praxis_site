/**
 * The ordering rules that make signing out actually end an image session.
 *
 * WHY THIS IS A MODULE AND NOT A FEW LINES IN THE ROUTE. What makes these two
 * operations safe is the ORDER of their steps relative to each other, across
 * two concurrent requests. That is exactly the property you cannot test by
 * calling a route handler: you have to be able to stop one sequence halfway and
 * run the other. So the sequencing lives here, as two functions over injected
 * dependencies, and revocation.test.ts drives them through interleavings that
 * are chosen rather than hoped for.
 *
 * ─── THE TWO SEQUENCES ──────────────────────────────────────────────────────
 *
 * Signing out (advanceRevocationMarker, called AFTER the Supabase sessions are
 * deleted):
 *      S1  delete every Supabase session for the account   (the route does this)
 *      S2  advance profiles.image_sessions_valid_from       (this module)
 *
 * Minting a cookie (decideMint):
 *      P1  verify the Supabase session
 *      P2  read the account's revocation marker
 *      P3  verify the Supabase session AGAIN
 *
 * ─── WHY P3 EXISTS, WHICH IS THE WHOLE POINT ────────────────────────────────
 *
 * Without P3 there is an interleaving that defeats the scheme completely:
 *
 *      P1  mint verifies the session       (alive)
 *      S1  sign-out deletes the sessions
 *      S2  sign-out advances the marker to M1
 *      P2  mint reads the marker           (gets M1)
 *          -> mints a cookie carrying M1, which MATCHES the column,
 *             so it is accepted for its full lifetime after a sign-out.
 *
 * Reordering S1 and S2 does not help; it only moves the window. P3 closes it,
 * and here is the argument, which is the thing to check if any of this changes:
 *
 *      A cookie is issued only if P3 succeeded.
 *      P3 succeeded  =>  the session still existed at P3  =>  P3 < S1.
 *      P2 < P3 < S1 < S2, so P2 read the marker strictly before S2 changed it.
 *      Therefore the cookie carries the PRE-sign-out marker, and the column
 *      now holds the post-sign-out one, so the route refuses it.
 *
 * It rests on S1 happening before S2. If someone ever "optimises" by advancing
 * the marker first, the proof collapses and case A comes back.
 *
 * ─── WHAT THIS STILL DOES NOT GUARANTEE ─────────────────────────────────────
 *
 * Immediate invalidation holds if and only if S2 SUCCEEDS. If the sessions are
 * deleted and the marker write then fails, every outstanding cookie still
 * matches the column and keeps working until it expires. No new one can be
 * minted, because P1 fails, and the signing-out browser's own cookie is cleared
 * regardless, but cookies held on other devices survive for up to the cookie
 * lifetime. That is a real residual risk and it is reported rather than hidden:
 * `revoked` is true only when the column actually changed.
 */

/** Unix-ms clock, injected so tests can interleave deliberately. */
export type Clock = () => number;

export type MarkerRead =
  | { ok: true; exists: true; marker: string | null }
  | { ok: true; exists: false }
  | { ok: false };

export type SwapOutcome =
  /** The predicate matched and the write landed. */
  | { outcome: "written"; stored: string | null }
  /** The predicate did not match: somebody else moved it first. Not an error. */
  | { outcome: "conflict" }
  /** The write genuinely failed. */
  | { outcome: "error" };

export type RevocationDeps = {
  read: () => Promise<MarkerRead>;
  /** Writes `next` only while the stored marker still equals `expected`. */
  swap: (expected: string | null, next: string) => Promise<SwapOutcome>;
  now: Clock;
  /** Attempts at the compare-and-swap before giving up. Default 4. */
  maxAttempts?: number;
};

export type RevocationReason =
  /** This request moved the marker. */
  | "advanced"
  /** A concurrent sign-out moved it past where we started, which is just as good. */
  | "advanced_by_peer"
  /** No profile row, so there is nothing to carry a marker. */
  | "no_profile"
  /** Lost the compare-and-swap repeatedly and the marker never moved. */
  | "contended"
  /** A read or write failed. */
  | "unavailable";

export type RevocationResult = {
  /** True ONLY when the column actually differs from where this request found it. */
  revoked: boolean;
  reason: RevocationReason;
  marker: string | null;
};

/**
 * The next marker value: strictly later than both the clock and the value we
 * are replacing.
 *
 * The `+ 1` is what makes two sign-outs in the same millisecond advance twice
 * instead of once. Before this, both read the same value, both computed the
 * same replacement from `Date.now()`, and the second write was a no-op that
 * still reported success, so a cookie minted between them survived.
 *
 * Strictly-greater also keeps the column monotonic without relying on the
 * database trigger, which turned out not to apply here at all: its body is
 * guarded by `auth.role() = 'authenticated'` and this path runs as the service
 * role. Monotonicity is this function's job plus the compare-and-swap's, and
 * nothing else enforces it.
 */
export function nextMarker(seen: string | null, nowMs: number): string {
  const seenMs = seen === null ? Number.NaN : Date.parse(seen);
  const base = Number.isNaN(seenMs) ? nowMs : Math.max(nowMs, seenMs + 1);
  return new Date(base).toISOString();
}

/**
 * Has the marker changed from what a cookie would be carrying?
 *
 * CHANGE, not order, because change is what the route actually tests: it
 * compares the cookie's marker with the column's for identity. A value that
 * differs invalidates every cookie carrying the old one, whichever way round
 * the two instants happen to be.
 */
export function markerChanged(from: string | null, to: string | null): boolean {
  return (from ?? null) !== (to ?? null);
}

/**
 * Advance the account's revocation marker, with a compare-and-swap so that
 * concurrent sign-outs cannot collapse into a single advance.
 *
 * MUST be called only after the Supabase sessions have been deleted. See the
 * proof at the top of this file.
 */
export async function advanceRevocationMarker(
  deps: RevocationDeps,
): Promise<RevocationResult> {
  const maxAttempts = deps.maxAttempts ?? 4;

  const first = await deps.read();
  if (!first.ok) return { revoked: false, reason: "unavailable", marker: null };
  if (!first.exists) return { revoked: false, reason: "no_profile", marker: null };

  // What outstanding cookies are carrying. Success means moving away from THIS,
  // not merely writing something.
  const original = first.marker;
  let seen = original;

  for (let attempt = 0; attempt < maxAttempts; attempt += 1) {
    const result = await deps.swap(seen, nextMarker(seen, deps.now()));

    if (result.outcome === "error") {
      return { revoked: false, reason: "unavailable", marker: seen };
    }

    if (result.outcome === "written") {
      // Confirmed from what the database handed back, not from what we sent.
      return markerChanged(original, result.stored)
        ? { revoked: true, reason: "advanced", marker: result.stored }
        : { revoked: false, reason: "unavailable", marker: result.stored };
    }

    // Conflict: somebody wrote between our read and our write. Re-read and
    // decide whether their write already did our job.
    const again = await deps.read();
    if (!again.ok) return { revoked: false, reason: "unavailable", marker: seen };
    if (!again.exists) return { revoked: false, reason: "no_profile", marker: null };

    if (markerChanged(original, again.marker)) {
      // A peer moved it past where we started, so every cookie we were trying
      // to kill is already refused. Reporting failure here would be a lie in
      // the pessimistic direction, which is still a lie.
      return { revoked: true, reason: "advanced_by_peer", marker: again.marker };
    }
    seen = again.marker;
  }

  return { revoked: false, reason: "contended", marker: seen };
}

export type MintDeps = {
  /** The verified user id behind the caller's bearer token, or null. */
  verifySession: () => Promise<string | null>;
  readMarker: (userId: string) => Promise<MarkerRead>;
};

export type MintDecision =
  | { ok: true; userId: string; marker: string | null }
  | { ok: false; reason: "not_signed_in" | "session_ended" | "marker_unavailable" };

/**
 * Decide whether to mint, and with which marker.
 *
 * Verifies, reads, then verifies AGAIN. The second verification is not
 * belt-and-braces; it is the only thing standing between a sign-out and a
 * cookie that outlives it. See the proof at the top of this file.
 */
export async function decideMint(deps: MintDeps): Promise<MintDecision> {
  const before = await deps.verifySession();
  if (!before) return { ok: false, reason: "not_signed_in" };

  const read = await deps.readMarker(before);
  if (!read.ok) return { ok: false, reason: "marker_unavailable" };
  // A missing profile row carries no marker; null is the honest value and the
  // route's identity comparison handles it.
  const marker = read.exists ? read.marker : null;

  // ── P3 ──
  const after = await deps.verifySession();
  if (!after) return { ok: false, reason: "session_ended" };
  // One token cannot name two people, but if it ever did, the marker we just
  // read would belong to the wrong account.
  if (after !== before) return { ok: false, reason: "session_ended" };

  return { ok: true, userId: before, marker };
}
