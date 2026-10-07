import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  listAuthAccounts, loadAccountUniverse, dispositionOf, readyAccounts,
  integrityFailures, ACCOUNT_PAGE_SIZE,
  type AdminLister, type AccountUniverse,
} from "@/lib/learner/accountUniverse";

// ─── THE UNIVERSE IS auth.users, AND IT IS DYNAMIC ──────────────────────────
//
// Not one of these tests asserts how many accounts exist. There are nine
// today; the number this project actually depends on is "whatever the admin
// API returns right now". A test that pinned the count would have to be edited
// the first time someone signs up, which is precisely the manual enrolment
// step the invariant forbids.

/** An admin API holding `n` users, served in pages, that counts its calls. */
function fakeAdmin(n: number, opts: { perPage?: number } = {}) {
  const per = opts.perPage ?? ACCOUNT_PAGE_SIZE;
  const users = Array.from({ length: n }, (_, i) => ({
    id: `u${String(i).padStart(5, "0")}`,
    email: `u${i}@example.com`,
    created_at: new Date(Date.UTC(2026, 0, 1, 0, 0, i)).toISOString(),
    last_sign_in_at: null,
  }));
  const calls: { page: number; perPage: number }[] = [];
  const admin: AdminLister & { calls: typeof calls } = {
    calls,
    auth: {
      admin: {
        async listUsers({ page, perPage }) {
          calls.push({ page, perPage });
          const start = (page - 1) * per;
          return { data: { users: users.slice(start, start + per) }, error: null };
        },
      },
    },
  };
  return admin;
}

describe("the account universe is paged, not assumed", () => {
  it.each([
    ["fewer than one page", 9, 1],
    ["exactly one page", ACCOUNT_PAGE_SIZE, 2],
    ["two pages and a partial", ACCOUNT_PAGE_SIZE * 2 + 7, 3],
    ["many pages", ACCOUNT_PAGE_SIZE * 12 + 1, 13],
  ])("%s: %i accounts", async (_label, n, expectedPages) => {
    const admin = fakeAdmin(n);
    const { accounts, pages } = await listAuthAccounts(admin);
    expect(accounts).toHaveLength(n);
    expect(pages).toBe(expectedPages);
    expect(new Set(accounts.map((a) => a.id)).size).toBe(n);
  });

  it("a full final page still asks once more, because a short page is the end signal", async () => {
    // The subtle one: when the count is an exact multiple of the page size,
    // the last full page looks identical to a middle page. Stopping there
    // would silently drop everyone created afterwards.
    const admin = fakeAdmin(ACCOUNT_PAGE_SIZE);
    const { accounts, pages } = await listAuthAccounts(admin);
    expect(accounts).toHaveLength(ACCOUNT_PAGE_SIZE);
    expect(pages).toBe(2);
    expect(admin.calls.map((c) => c.page)).toEqual([1, 2]);
  });

  it("works unchanged at 9, 100, 1,000 and 10,000 accounts", async () => {
    for (const n of [9, 100, 1000, 10000]) {
      const { accounts } = await listAuthAccounts(fakeAdmin(n));
      expect(accounts, `${n}`).toHaveLength(n);
    }
  });

  it("drops a duplicate rather than processing one learner twice", async () => {
    // A signup DURING the walk shifts the window and can repeat a user across
    // pages. Two batch runs for one learner is worse than a missed one.
    const dup = {
      auth: { admin: { async listUsers({ page }: { page: number; perPage: number }) {
        const u = (id: string) => ({ id, email: null, created_at: "2026-01-01T00:00:00Z", last_sign_in_at: null });
        const full = Array.from({ length: ACCOUNT_PAGE_SIZE }, (_, i) => u(`a${i}`));
        if (page === 1) return { data: { users: full }, error: null };
        // page 2 repeats the last of page 1, then one genuinely new user
        if (page === 2) return { data: { users: [full[ACCOUNT_PAGE_SIZE - 1], u("new")] }, error: null };
        return { data: { users: [] }, error: null };
      } } },
    };
    const { accounts } = await listAuthAccounts(dup);
    expect(accounts).toHaveLength(ACCOUNT_PAGE_SIZE + 1);
    expect(new Set(accounts.map((a) => a.id)).size).toBe(accounts.length);
  });

  it("refuses to loop forever if the API never signals the end", async () => {
    const endless = {
      auth: { admin: { async listUsers() {
        return { data: { users: Array.from({ length: ACCOUNT_PAGE_SIZE }, (_, i) => ({
          id: `x${Math.random()}${i}`, email: null, created_at: "2026-01-01T00:00:00Z", last_sign_in_at: null })) }, error: null };
      } } },
    };
    await expect(listAuthAccounts(endless)).rejects.toThrow(/never returned a short page/);
  });

  it("surfaces an admin error instead of reporting an empty universe", async () => {
    // Treating a failed listing as "no accounts" would make a batch job report
    // a clean run having processed nobody.
    const broken = { auth: { admin: { async listUsers() { return { data: null, error: { message: "bad key" } }; } } } };
    await expect(listAuthAccounts(broken)).rejects.toThrow(/listing auth users: bad key/);
  });
});

describe("a missing profile is an integrity failure, not a kind of account", () => {
  it.each([
    [null, "PROFILE_MISSING"],
    [{ accountKind: null, dayStartHour: 4 }, "PROFILE_INCOMPLETE"],
    [{ accountKind: "STUDENT" as const, dayStartHour: null }, "PROFILE_INCOMPLETE"],
    [{ accountKind: "WHATEVER" as never, dayStartHour: 4 }, "PROFILE_INCOMPLETE"],
    [{ accountKind: "STUDENT" as const, dayStartHour: 4 }, "READY"],
    [{ accountKind: "DEMO" as const, dayStartHour: 4 }, "READY"],
    [{ accountKind: "INTERNAL" as const, dayStartHour: 4 }, "READY"],
    [{ accountKind: "STUDENT" as const, dayStartHour: 0 }, "READY"],
  ])("%o -> %s", (profile, expected) => {
    expect(dispositionOf(profile as never).disposition).toBe(expected);
  });

  it("day_start_hour 0 is a real value, not a missing one", () => {
    // `?? null` on a falsy number is the classic way this breaks: midnight
    // becomes "no day start" and the account is wrongly held back.
    expect(dispositionOf({ accountKind: "STUDENT", dayStartHour: 0 }).disposition).toBe("READY");
  });

  it("every non-READY account carries a sentence an operator can act on", () => {
    for (const p of [null, { accountKind: null, dayStartHour: null }]) {
      const d = dispositionOf(p as never);
      expect(d.disposition).not.toBe("READY");
      expect(d.problem!.length).toBeGreaterThan(20);
    }
    expect(dispositionOf({ accountKind: "STUDENT", dayStartHour: 4 }).problem).toBeNull();
  });
});

describe("ALL THREE KINDS ARE RUNTIME MEMBERS", () => {
  it("account_kind never decides membership", () => {
    for (const kind of ["STUDENT", "DEMO", "INTERNAL"] as const) {
      expect(dispositionOf({ accountKind: kind, dayStartHour: 4 }).disposition).toBe("READY");
    }
  });

  it("the module never branches on a kind", () => {
    // Calibration excludes DEMO and INTERNAL. Runtime does not, and the only
    // way to keep that true is for this module to have no opinion about kind
    // beyond whether it is a known one.
    const src = fs.readFileSync(path.join(__dirname, "accountUniverse.ts"), "utf8")
      .split("\n").map((l) => (l.indexOf("//") === -1 ? l : l.slice(0, l.indexOf("//")))).join("\n");
    expect(src).not.toMatch(/===\s*["']DEMO["']|===\s*["']INTERNAL["']|===\s*["']STUDENT["']/);
    expect(src).not.toMatch(/CALIBRATION/);
  });
});

describe("a new account joins by existing, not by being added", () => {
  const profilesFor = (ids: string[]) => ({
    from() {
      return {
        select() { return this; },
        order() { return this; },
        range(from: number, to: number) {
          const rows = ids.map((id) => ({ id, account_kind: "STUDENT", day_start_hour: 4 }));
          return Promise.resolve({ data: rows.slice(from, to + 1), error: null });
        },
      };
    },
  });

  it("an account that appears in the auth source appears in the universe, with no code change", async () => {
    const before = fakeAdmin(9);
    const u1 = await loadAccountUniverse({ ...before, ...profilesFor(Array.from({ length: 9 }, (_, i) => `u${String(i).padStart(5, "0")}`)) } as never);
    expect(u1.accounts).toHaveLength(9);

    // Account number ten signs up. Nothing here is edited.
    const after = fakeAdmin(10);
    const u2 = await loadAccountUniverse({ ...after, ...profilesFor(Array.from({ length: 10 }, (_, i) => `u${String(i).padStart(5, "0")}`)) } as never);
    expect(u2.accounts).toHaveLength(10);
    expect(u2.accounts.map((a) => a.id)).toContain("u00009");
    expect(readyAccounts(u2)).toHaveLength(10);
    expect(integrityFailures(u2)).toEqual([]);
  });

  it("an account that stops existing stops being discovered", async () => {
    const u = await loadAccountUniverse({ ...fakeAdmin(3), ...profilesFor(["u00000", "u00001", "u00002"]) } as never);
    expect(u.accounts).toHaveLength(3);
    const fewer = await loadAccountUniverse({ ...fakeAdmin(2), ...profilesFor(["u00000", "u00001"]) } as never);
    expect(fewer.accounts.map((a) => a.id)).toEqual(["u00000", "u00001"]);
  });

  it("a new account with no profile is reported loudly, not skipped", async () => {
    const u = await loadAccountUniverse({ ...fakeAdmin(3), ...profilesFor(["u00000", "u00001"]) } as never);
    expect(u.accounts).toHaveLength(3);
    expect(readyAccounts(u)).toHaveLength(2);
    const failures = integrityFailures(u);
    expect(failures).toHaveLength(1);
    expect(failures[0]).toMatch(/u00002.*no public\.profiles row/);
  });

  it("a profile with no auth user is reported too, the other direction", async () => {
    const u = await loadAccountUniverse({ ...fakeAdmin(2), ...profilesFor(["u00000", "u00001", "ghost"]) } as never);
    expect(u.orphanProfileIds).toEqual(["ghost"]);
    expect(integrityFailures(u)).toContain("profile ghost has no auth user");
  });
});

describe("the module's own boundaries", () => {
  const src = fs.readFileSync(path.join(__dirname, "accountUniverse.ts"), "utf8");

  it("holds no account identity of any kind", () => {
    const body = src.split("\n").map((l) => (l.indexOf("//") === -1 ? l : l.slice(0, l.indexOf("//")))).join("\n");
    expect(body).not.toMatch(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/);
    expect(body).not.toMatch(/@praxisprep|@gmail|@yahoo/);
  });

  it("contains no account count", () => {
    // "9" is a fact about today, and the one number this file must not know.
    //
    // Scoped to a count OF ACCOUNTS. The first version of this banned any
    // `length === <digit>` and failed on `data.length === 0`, which is the
    // pagination end-check and has nothing to do with how many accounts exist.
    const body = src.split("\n").map((l) => (l.indexOf("//") === -1 ? l : l.slice(0, l.indexOf("//")))).join("\n");
    expect(body).not.toMatch(/\b(accounts|users|authAccounts|profiles)\.length\s*[=!<>]=*\s*[1-9]/);
    expect(body).not.toMatch(/\b9\b/);
  });

  it("the count ban can actually catch a count", () => {
    const bad = "if (accounts.length === 9) return;";
    expect(bad).toMatch(/\b(accounts|users|authAccounts|profiles)\.length\s*[=!<>]=*\s*[1-9]/);
    // And the pagination guard it used to trip on is not a count.
    expect("if (!data || data.length === 0) break;")
      .not.toMatch(/\b(accounts|users|authAccounts|profiles)\.length\s*[=!<>]=*\s*[1-9]/);
  });

  it("writes nothing", () => {
    for (const verb of ["insert(", "update(", "upsert(", "delete(", "rpc("]) {
      expect(src, verb).not.toContain(verb);
    }
  });
});
