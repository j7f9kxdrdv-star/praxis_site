import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import { isValidTimezone, timezoneOf, DEFAULT_TIMEZONE } from "@/lib/flashcards/studyDay";
import { dispositionOf } from "@/lib/learner/accountUniverse";

// ─── TIMEZONE IS INITIALISED, NEVER TRACKED ─────────────────────────────────
//
// The failure these guard is not a crash. It is a learner whose study day
// quietly moves because they opened a laptop in another state, which after
// history exists would relabel their past.

const ROOT = process.cwd();
const read = (p: string) => fs.readFileSync(path.join(ROOT, p), "utf8");
const strip = (s: string) =>
  s.replace(/\/\*[\s\S]*?\*\//g, "").replace(/\{\/\*[\s\S]*?\*\/\}/g, "").replace(/^\s*\/\/.*$/gm, "");

const MIGRATION = read("supabase/migrations/20261007_04_timezone_capture.sql");
const INITIALIZER = read("components/dashboard/TimezoneInitializer.tsx");
const SIGNUP = read("app/signup/page.tsx");
const LAYOUT = read("app/dashboard/layout.tsx");

describe("layer A: signup carries the browser's zone", () => {
  it("the signup form sends a detected timezone in its metadata", () => {
    expect(strip(SIGNUP)).toMatch(/timezone: detectTimezone\(\)/);
    expect(SIGNUP).toMatch(/from "@\/lib\/flashcards\/studyDay"/);
  });

  it("handle_new_user initialises the profile from it", () => {
    expect(MIGRATION).toMatch(/raw_user_meta_data ->> 'timezone'/);
    expect(MIGRATION).toMatch(/INSERT INTO public\.profiles \(id, first_name, last_name, email, timezone\)/);
  });

  it("an unrecognised value falls back to NULL rather than failing the signup", () => {
    // A person must not be unable to create an account because their browser
    // reported a zone this server has never heard of.
    expect(MIGRATION).toMatch(/IF tz IS NOT NULL AND NOT EXISTS \(SELECT 1 FROM pg_timezone_names WHERE name = tz\) THEN\s*\n\s*tz := NULL;/);
  });

  it("keeps the fields it already carried", () => {
    // first_name and last_name come from the signup metadata; email comes
    // from the auth row itself. Checking all three the same way was wrong
    // about where email lives.
    for (const f of ["first_name", "last_name"]) {
      expect(MIGRATION, f).toMatch(new RegExp(`raw_user_meta_data ->> '${f}'`));
    }
    expect(MIGRATION).toMatch(/NEW\.email/);
  });
});

describe("layer B: the first authenticated load fills the gap", () => {
  it("exists, because OAuth signups cannot carry metadata at creation", () => {
    expect(LAYOUT).toMatch(/<TimezoneInitializer \/>/);
    expect(LAYOUT).toMatch(/import TimezoneInitializer/);
  });

  it("ONLY writes when the stored timezone is null", () => {
    const body = strip(INITIALIZER);
    expect(body).toMatch(/profile\?\.timezone != null\) return/);
    expect(body).toMatch(/\.is\("timezone", null\)/);
  });

  it("NEVER overwrites a stored zone, which is what stops a trip moving someone's day", () => {
    const body = strip(INITIALIZER);
    // No unconditional update anywhere: every write carries the null guard.
    const updates = [...body.matchAll(/\.update\(\{[^}]*\}\)[^;]*/g)].map((m) => m[0]);
    expect(updates.length).toBeGreaterThan(0);
    for (const u of updates) expect(u, u).toMatch(/\.is\("timezone", null\)/);
  });

  it("writes only this learner's own row", () => {
    const body = strip(INITIALIZER);
    expect(body).toMatch(/\.eq\("id", userId\)/);
    expect(body).toMatch(/supabase\.auth\.getUser\(\)/);
  });

  it("touches no other profile column", () => {
    const body = strip(INITIALIZER);
    const updates = [...body.matchAll(/\.update\(\{([^}]*)\}\)/g)].map((m) => m[1]);
    for (const u of updates) {
      expect(u).toMatch(/timezone/);
      for (const protectedCol of ["account_kind", "is_admin", "email", "day_start_hour", "daily_"]) {
        expect(u, protectedCol).not.toContain(protectedCol);
      }
    }
  });

  it("refuses to send a zone the shared helper does not recognise", () => {
    expect(strip(INITIALIZER)).toMatch(/if \(!isValidTimezone\(zone\)\) return/);
    // One definition of validity, shared with the server-side policy.
    expect(INITIALIZER).toMatch(/from "@\/lib\/flashcards\/studyDay"/);
  });

  it("asks for no location, only the zone identifier", () => {
    for (const forbidden of ["geolocation", "getCurrentPosition", "coords", "latitude", "longitude"]) {
      expect(INITIALIZER.toLowerCase(), forbidden).not.toContain(forbidden);
    }
  });
});

describe("the server refuses what a client should not be able to store", () => {
  it("validates on every write path, not just at signup", () => {
    expect(MIGRATION).toMatch(/CREATE TRIGGER profiles_validate_timezone/);
    expect(MIGRATION).toMatch(/BEFORE INSERT OR UPDATE OF timezone ON public\.profiles/);
  });

  it("uses the server's own IANA database rather than a hand-kept list", () => {
    expect(MIGRATION).toMatch(/FROM pg_timezone_names WHERE name = NEW\.timezone/);
    // A literal list of zone names would be stale the first time IANA moves.
    expect(MIGRATION).not.toMatch(/IN \('America\/New_York'/);
  });

  it("rejects the empty string, which is not the same as 'not reported'", () => {
    expect(MIGRATION).toMatch(/cannot be an empty string/);
  });

  it("keeps NULL legal, because some accounts can never report one", () => {
    expect(MIGRATION).toMatch(/IF NEW\.timezone IS NULL THEN\s*\n\s*RETURN NEW;/);
  });

  it("does NOT persist UTC in place of an invalid value", () => {
    // UTC is a read-time fallback for a missing zone. Writing it for a bad one
    // would record a claim about the learner that nobody made.
    const body = MIGRATION.split("\n").map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");
    expect(body).not.toMatch(/timezone\s*=\s*'UTC'/);
    expect(body).not.toMatch(/COALESCE\(NEW\.timezone, 'UTC'\)/);
  });

  it("leaves the other profile protections standing", () => {
    expect(MIGRATION).toMatch(/prevent_is_admin_self_update/);
    expect(MIGRATION).toMatch(/prevent_account_kind_self_update/);
    expect(MIGRATION).toMatch(/expected the 2 profile protection functions to still be attached/);
    // Matched on the FUNCTION, because the trigger names differ from the
    // function names and checking the latter found zero and aborted the apply.
    expect(MIGRATION).toMatch(/JOIN pg_proc p ON p\.oid = t\.tgfoid/);
    expect(MIGRATION).toMatch(/p\.proname IN \('prevent_is_admin_self_update', 'prevent_account_kind_self_update'\)/);
  });

  it("invents no timezone for the existing null profiles", () => {
    // Scoped to WRITES. The migration counts null timezones to prove it
    // changed none, and banning the phrase outright failed on that count.
    const body = MIGRATION.split("\n").map((l) => (l.indexOf("--") === -1 ? l : l.slice(0, l.indexOf("--")))).join("\n");
    const writes = [...body.matchAll(/(UPDATE|INSERT INTO)\s+public\.profiles[\s\S]*?;/g)].map((m) => m[0]);
    for (const w of writes) {
      expect(w, w.slice(0, 60)).not.toMatch(/WHERE timezone IS NULL/);
      expect(w, w.slice(0, 60)).not.toMatch(/timezone = 'America/);
    }
    // And the migration proves it left the count alone.
    expect(MIGRATION).toMatch(/the NULL timezone count moved from/);
    expect(MIGRATION).toMatch(/the probes changed a stored timezone/);
  });
});

describe("the runtime policy is unchanged by capture", () => {
  it("NULL is still READY and still falls back to UTC", () => {
    expect(dispositionOf({ accountKind: "STUDENT", dayStartHour: 4, timeZone: null }).disposition).toBe("READY");
    expect(timezoneOf(null)).toBe(DEFAULT_TIMEZONE);
    expect(DEFAULT_TIMEZONE).toBe("UTC");
  });

  it("an invalid stored value is still an integrity failure", () => {
    const d = dispositionOf({ accountKind: "STUDENT", dayStartHour: 4, timeZone: "Mars/Olympus_Mons" });
    expect(d.disposition).toBe("PROFILE_INCOMPLETE");
    expect(d.problem).toMatch(/not a valid IANA zone/);
  });

  it("a captured value is used as given", () => {
    expect(dispositionOf({ accountKind: "STUDENT", dayStartHour: 4, timeZone: "Asia/Tokyo" }).disposition).toBe("READY");
    expect(timezoneOf("Asia/Tokyo")).toBe("Asia/Tokyo");
  });

  it("client and server agree about what a valid zone is", () => {
    for (const z of ["America/New_York", "Asia/Tokyo", "Europe/London", "UTC"]) {
      expect(isValidTimezone(z), z).toBe(true);
    }
    for (const z of ["", "   ", "Mars/Olympus_Mons", null]) {
      expect(isValidTimezone(z), String(z)).toBe(false);
    }
  });
});
