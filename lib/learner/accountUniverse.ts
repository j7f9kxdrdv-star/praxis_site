// ─── Who the accounts are ───────────────────────────────────────────────────
//
// THE CANONICAL ACCOUNT UNIVERSE IS auth.users. Not profiles, not a list, not
// a count. Every batch or operational job that needs "all the accounts" asks
// here, and gets whatever exists at the moment it asks.
//
// WHY THIS MODULE EXISTS AT ALL. Every tally in this project up to Phase 2
// step 7 came from `profiles`, which had 7 rows while `auth.users` had 9. Two
// accounts were invisible to every count, every audit and every report, and
// nothing was wrong with any of them: they simply had no profile row, so a
// universe defined as "the profiles table" did not contain them. That is the
// failure this module is built to make impossible to repeat.
//
// WHY IT NEEDS THE ADMIN API. service_role has no privileges in the auth
// schema, so PostgREST cannot read auth.users at all: a select against it comes
// back PGRST205. The GoTrue admin endpoint is a different path with the same
// key, and it is the only way a server-side job can enumerate the real set.
//
// IT PAGINATES, and that is not decoration. The admin API returns a page at a
// time; at nine accounts one page is the whole universe and any broken
// pagination looks perfect. It has to still be correct at ten thousand.
//
// WHAT THIS MODULE IS NOT FOR. A per-user request — a learner opening their
// own dashboard — already knows which account it is and must NOT enumerate
// anything. Loading every account to serve one of them would be slower, would
// need admin privileges a user-scoped route should not hold, and would break
// the moment the product has real numbers of users. Batch work asks here;
// per-user work uses the authenticated id it already has.

import type { SupabaseClient } from "@supabase/supabase-js";
import { isAccountKind, type AccountKind } from "@/lib/learner/accountKind";

/** The page size asked of the admin API. Not the universe size. */
export const ACCOUNT_PAGE_SIZE = 200;

/** One auth user, as the admin API reports them. */
export interface AuthAccount {
  id: string;
  email: string | null;
  createdAt: string;
  lastSignInAt: string | null;
}

/** The runtime metadata a profile supplies, where one exists. */
export interface AccountProfile {
  accountKind: AccountKind | null;
  dayStartHour: number | null;
}

/**
 * What a batch job needs to know about one account.
 *
 * `READY` means the computation can run: an auth user with a profile carrying
 * the metadata the model needs. `PROFILE_MISSING` and `PROFILE_INCOMPLETE` are
 * INTEGRITY FAILURES, not dispositions to live with — after the legacy repair
 * every auth user has a profile, and a future account that does not is a
 * broken signup rather than a kind of account.
 */
export type AccountDisposition = "READY" | "PROFILE_MISSING" | "PROFILE_INCOMPLETE";

export interface Account extends AuthAccount {
  profile: AccountProfile | null;
  disposition: AccountDisposition;
  /** Why it is not READY, for an operator to act on. Null when it is. */
  problem: string | null;
}

export interface AccountUniverse {
  accounts: Account[];
  /** Profiles with no auth user. The other direction of the same integrity rule. */
  orphanProfileIds: string[];
  pagesFetched: number;
  takenAt: string;
}

/** The admin surface this module needs, named so a test can supply one. */
export interface AdminLister {
  auth: {
    admin: {
      listUsers(args: { page: number; perPage: number }): Promise<{
        data: { users: { id: string; email?: string | null; created_at: string; last_sign_in_at?: string | null }[] } | null;
        error: { message: string } | null;
      }>;
    };
  };
}

/**
 * Every auth user, paged until the API runs out.
 *
 * Stops on a short page, which is the documented end-of-list signal, and
 * refuses to loop forever if the API ever stops honouring it. Duplicate ids
 * across pages are dropped rather than double-counted: a user created DURING
 * the walk can shift the window and show up twice, which would otherwise
 * become two batch runs for one learner.
 */
export async function listAuthAccounts(admin: AdminLister): Promise<{ accounts: AuthAccount[]; pages: number }> {
  const seen = new Map<string, AuthAccount>();
  let pages = 0;
  for (let page = 1; ; page++) {
    const { data, error } = await admin.auth.admin.listUsers({ page, perPage: ACCOUNT_PAGE_SIZE });
    if (error) throw new Error(`accountUniverse: listing auth users: ${error.message}`);
    const users = data?.users ?? [];
    pages++;
    for (const u of users) {
      if (!seen.has(u.id)) {
        seen.set(u.id, {
          id: u.id,
          email: u.email ?? null,
          createdAt: u.created_at,
          lastSignInAt: u.last_sign_in_at ?? null,
        });
      }
    }
    if (users.length < ACCOUNT_PAGE_SIZE) break;
    // A guard, not a limit: 500 full pages is 100,000 accounts, far past any
    // plausible size, and reaching it means the API is not signalling the end.
    if (page >= 500) throw new Error("accountUniverse: the admin API never returned a short page");
  }
  return { accounts: [...seen.values()].sort((a, b) => a.createdAt.localeCompare(b.createdAt)), pages };
}

/** One account's disposition, from its auth row and whatever profile it has. */
export function dispositionOf(profile: AccountProfile | null): { disposition: AccountDisposition; problem: string | null } {
  if (profile == null) {
    return { disposition: "PROFILE_MISSING", problem: "no public.profiles row, so no account_kind and no day_start_hour" };
  }
  const missing: string[] = [];
  if (profile.accountKind == null) missing.push("account_kind");
  if (profile.dayStartHour == null) missing.push("day_start_hour");
  if (missing.length > 0) {
    return { disposition: "PROFILE_INCOMPLETE", problem: `profile is missing ${missing.join(" and ")}` };
  }
  if (!isAccountKind(profile.accountKind)) {
    return { disposition: "PROFILE_INCOMPLETE", problem: `account_kind ${JSON.stringify(profile.accountKind)} is not a known kind` };
  }
  return { disposition: "READY", problem: null };
}

/**
 * The complete account universe, reconciled against profiles.
 *
 * Every auth user appears exactly once, in creation order, whether or not it
 * has a profile, has ever signed in, or has studied anything. An account with
 * no evidence is a correct member of the universe that will compute to zero
 * states; an account left out because nobody added it is the bug.
 */
export async function loadAccountUniverse(
  db: SupabaseClient & AdminLister,
): Promise<AccountUniverse> {
  const takenAt = new Date().toISOString();
  const { accounts: authAccounts, pages } = await listAuthAccounts(db);

  const profiles: { id: string; account_kind: string | null; day_start_hour: number | null }[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await db
      .from("profiles")
      .select("id, account_kind, day_start_hour")
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error) throw new Error(`accountUniverse: loading profiles: ${error.message}`);
    if (!data || data.length === 0) break;
    profiles.push(...(data as typeof profiles));
    if (data.length < 1000) break;
  }
  const byId = new Map(profiles.map((p) => [p.id, p]));

  const accounts: Account[] = authAccounts.map((a) => {
    const row = byId.get(a.id);
    const profile: AccountProfile | null = row
      ? { accountKind: (row.account_kind as AccountKind | null) ?? null, dayStartHour: row.day_start_hour }
      : null;
    const { disposition, problem } = dispositionOf(profile);
    return { ...a, profile, disposition, problem };
  });

  const authIds = new Set(authAccounts.map((a) => a.id));
  const orphanProfileIds = profiles.map((p) => p.id).filter((id) => !authIds.has(id));

  return { accounts, orphanProfileIds, pagesFetched: pages, takenAt };
}

/** The accounts a batch computation may process. */
export const readyAccounts = (u: AccountUniverse): Account[] =>
  u.accounts.filter((a) => a.disposition === "READY");

/**
 * Everything wrong with the universe, in sentences an operator can act on.
 *
 * Empty is the healthy state and the one the project expects after the legacy
 * repair. A non-empty result is an integrity failure: a batch job may not
 * quietly process the rest and call it a success.
 */
export function integrityFailures(u: AccountUniverse): string[] {
  const out: string[] = [];
  for (const a of u.accounts) {
    if (a.disposition !== "READY") out.push(`auth user ${a.id} (${a.email ?? "no email"}): ${a.problem}`);
  }
  for (const id of u.orphanProfileIds) out.push(`profile ${id} has no auth user`);
  return out;
}
