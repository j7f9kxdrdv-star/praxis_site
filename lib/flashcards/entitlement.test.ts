import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { decideImageAccess } from "@/lib/flashcards/entitlement";

// ─── WHERE EACH RULE IS TESTED ──────────────────────────────────────────────
//
// Who is entitled is decided by has_content_entitlement_for() in the database,
// so it is tested against a real database by scratchpad/legacy/rule_check.mjs
// and scratchpad/legacy/image_matrix.mjs, not here. Asserting it twice in
// TypeScript is what produced the bug these tests now guard against: the rule
// was copied into this file, the authority moved into account_entitlements,
// and the stale copy silently denied every entitled account while every unit
// test still passed.
//
// What is tested here is the gate around that answer, and the properties of
// the migrations the application depends on.

const MIGRATIONS = path.join(process.cwd(), "supabase/migrations");
const read = (name: string) => fs.readFileSync(path.join(MIGRATIONS, name), "utf8");

describe("the gate around the database's answer", () => {
  const ok = { signedIn: true, entitled: true, entitlementColumnsAreTrustworthy: true };

  it("allows a signed-in, entitled caller", () => {
    expect(decideImageAccess(ok)).toEqual({ allowed: true, reason: "allowed" });
  });

  it("denies an unauthenticated request, however entitled the account", () => {
    expect(decideImageAccess({ ...ok, signedIn: false }))
      .toEqual({ allowed: false, reason: "denied_not_signed_in" });
  });

  it("denies a signed-in caller the database did not entitle", () => {
    expect(decideImageAccess({ ...ok, entitled: false }))
      .toEqual({ allowed: false, reason: "denied_not_entitled" });
  });

  it("denies everyone while the database cannot be trusted to defend the columns", () => {
    // Being entitled must not rescue this: if a learner can still write their
    // own entitlement, a true answer means nothing.
    expect(decideImageAccess({ ...ok, entitlementColumnsAreTrustworthy: false }))
      .toEqual({ allowed: false, reason: "denied_schema_not_ready" });
  });

  it("checks the session first, so a stranger is never looked up at all", () => {
    expect(decideImageAccess({ signedIn: false, entitled: true, entitlementColumnsAreTrustworthy: false }).reason)
      .toBe("denied_not_signed_in");
  });
});

describe("the rule is defined once, and only once", () => {
  const ENTITLEMENTS = read("20261014_account_entitlements.sql");
  const CONTENT = read("20261014_content_entitlement.sql");

  it("lives in the entitlements migration", () => {
    expect(ENTITLEMENTS.match(/CREATE OR REPLACE FUNCTION public\.has_content_entitlement_for/g)).toHaveLength(1);
    expect(ENTITLEMENTS.match(/CREATE OR REPLACE FUNCTION public\.has_content_entitlement\(\)/g)).toHaveLength(1);
  });

  it("is not redefined by the content migration, which only uses it", () => {
    expect(CONTENT).not.toMatch(/CREATE OR REPLACE FUNCTION public\.has_content_entitlement/);
    expect(CONTENT).toMatch(/to_regprocedure\('public\.has_content_entitlement\(\)'\)/);
  });

  it("has the no-argument form delegate rather than duplicate", () => {
    expect(ENTITLEMENTS).toMatch(/SELECT public\.has_content_entitlement_for\(auth\.uid\(\)\)/);
  });

  it("never consults subscription_tier, because a label is not a payment", () => {
    const from = ENTITLEMENTS.indexOf("CREATE OR REPLACE FUNCTION public.has_content_entitlement_for");
    const open = ENTITLEMENTS.indexOf("AS $$", from);
    const body = ENTITLEMENTS.slice(open, ENTITLEMENTS.indexOf("$$;", open));
    expect(body).not.toMatch(/subscription_tier/);
    expect(body).toMatch(/revoked_at IS NULL/);
    expect(body).toMatch(/expires_at IS NULL OR e\.expires_at > now\(\)/);
    expect(body).toMatch(/p\.is_admin = true/);
  });

  it("keeps the argument form away from authenticated callers", () => {
    // Taking a user id means an authenticated caller could ask about somebody
    // else, so only the service role may execute it.
    expect(ENTITLEMENTS).toMatch(
      /GRANT EXECUTE ON FUNCTION public\.has_content_entitlement_for\(UUID\) TO service_role;/);
    expect(ENTITLEMENTS).not.toMatch(
      /GRANT EXECUTE ON FUNCTION public\.has_content_entitlement_for\(UUID\)[^;]*authenticated/);
  });
});

describe("the entitlement record defends itself", () => {
  const ENTITLEMENTS = read("20261014_account_entitlements.sql");

  it("is append-only: a grant may only be revoked", () => {
    expect(ENTITLEMENTS).toMatch(/account_entitlements_append_only/);
    expect(ENTITLEMENTS).toMatch(/BEFORE UPDATE ON public\.account_entitlements/);
  });

  it("cannot be written by a learner at all", () => {
    expect(ENTITLEMENTS).toMatch(/ALTER TABLE public\.account_entitlements ENABLE ROW LEVEL SECURITY/);
    expect(ENTITLEMENTS).toMatch(/FOR SELECT\s*\n?\s*USING \(auth\.uid\(\) = user_id\)/);
    expect(ENTITLEMENTS).not.toMatch(/ON public\.account_entitlements FOR (INSERT|UPDATE|DELETE)/);
  });

  it("refuses a revocation that does not say who and why", () => {
    expect(ENTITLEMENTS).toMatch(/revoked_by IS NOT NULL AND revoke_reason IS NOT NULL/);
  });

  it("allows only one live grant of a kind per account", () => {
    expect(ENTITLEMENTS).toMatch(/UNIQUE INDEX[\s\S]*?account_entitlements[\s\S]*?WHERE revoked_at IS NULL/);
  });

  it("carries a forward-only sign-out cutoff", () => {
    expect(ENTITLEMENTS).toMatch(/image_sessions_valid_from/);
    expect(ENTITLEMENTS).toMatch(/image_sessions_valid_from_forward_only/);
  });
});

describe("grandfathering is defined by a cutoff, never by a list", () => {
  const GRANDFATHER = read("20261014_grandfather_legacy_access.sql");

  it("selects from the canonical account universe", () => {
    expect(GRANDFATHER).toMatch(/FROM auth\.users/);
    expect(GRANDFATHER).toMatch(/created_at < v_cutoff/);
  });

  it("contains no account identifier of any kind", () => {
    expect(GRANDFATHER).not.toMatch(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/);
    expect(GRANDFATHER).not.toMatch(/@/);
  });

  it("blocks rather than half-covering the cohort", () => {
    expect(GRANDFATHER).toMatch(/BLOCKED/);
    expect(GRANDFATHER).toMatch(/RAISE EXCEPTION/);
  });

  it("grants without an expiry, so grandfathering does not lapse", () => {
    expect(GRANDFATHER).toMatch(/NULL,\s*--\s*never expires/);
  });
});

describe("the content gate covers what it should and spares what it should not", () => {
  const CONTENT = read("20261014_content_entitlement.sql");

  it.each(["flashcard_decks", "flashcards", "questions", "passages", "lessons"])(
    "gates %s", (table) => {
      expect(CONTENT).toMatch(new RegExp(`CREATE POLICY[\\s\\S]*?ON public\\.${table} FOR SELECT`));
    });

  it.each(["flashcard_user_state", "flashcard_reviews", "question_attempts", "lesson_progress"])(
    "leaves %s alone, because a learner's own work stays theirs", (table) => {
      expect(CONTENT).not.toMatch(new RegExp(`CREATE POLICY[^;]*ON public\\.${table}`));
    });
});
