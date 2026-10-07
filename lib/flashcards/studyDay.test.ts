import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  studyDayKey, studyDayKeyOffset, startOfStudyDay, isValidTimezone, timezoneOf,
  DEFAULT_DAY_START_HOUR, DEFAULT_TIMEZONE, runtimeTimezone,
} from "@/lib/flashcards/studyDay";

// ─── THE DAY BOUNDARY IS THE LEARNER'S, NOT THE SERVER'S ────────────────────
//
// Every one of these would have passed before this change when run on a laptop
// in New York and failed in a Vercel function in UTC, which is exactly how the
// bug survived: the tests ran where the answer happened to be right.
//
// None of them depends on the machine's zone now. The timezone is an argument.

const at = (iso: string) => new Date(iso);

describe("the study day is read in the learner's own timezone", () => {
  it.each([
    // [zone, instant (UTC), expected study day, what the learner's clock reads]
    ["America/New_York", "2026-10-08T07:30:00Z", "2026-10-07", "03:30, before the 4am boundary"],
    ["America/New_York", "2026-10-08T08:00:00Z", "2026-10-08", "04:00, exactly the boundary"],
    ["America/New_York", "2026-10-08T08:01:00Z", "2026-10-08", "04:01, just after"],
    ["America/New_York", "2026-10-08T03:00:00Z", "2026-10-07", "23:00 the previous evening"],
    ["America/Chicago", "2026-10-08T08:30:00Z", "2026-10-07", "03:30 CDT"],
    ["America/Denver", "2026-10-08T09:30:00Z", "2026-10-07", "03:30 MDT"],
    ["America/Los_Angeles", "2026-10-08T10:30:00Z", "2026-10-07", "03:30 PDT"],
    ["America/Los_Angeles", "2026-10-08T11:00:00Z", "2026-10-08", "04:00 PDT"],
    ["UTC", "2026-10-08T03:59:00Z", "2026-10-07", "03:59 UTC"],
    ["UTC", "2026-10-08T04:00:00Z", "2026-10-08", "04:00 UTC"],
    ["Europe/London", "2026-10-08T02:59:00Z", "2026-10-07", "03:59 BST"],
    ["Europe/London", "2026-10-08T03:00:00Z", "2026-10-08", "04:00 BST"],
    ["Asia/Tokyo", "2026-10-07T18:59:00Z", "2026-10-07", "03:59 JST"],
    ["Asia/Tokyo", "2026-10-07T19:00:00Z", "2026-10-08", "04:00 JST"],
    ["Australia/Sydney", "2026-10-07T16:59:00Z", "2026-10-07", "03:59 AEDT"],
    ["Australia/Sydney", "2026-10-07T17:00:00Z", "2026-10-08", "04:00 AEDT"],
  ])("%s at %s -> %s", (zone, instant, expected) => {
    expect(studyDayKey(at(instant), zone, 4)).toBe(expected);
  });

  it("THE SAME INSTANT IS A DIFFERENT DAY IN DIFFERENT ZONES", () => {
    // The entire point. One run clock, many study days.
    const instant = at("2026-10-07T20:00:00Z");
    expect(studyDayKey(instant, "America/New_York", 4)).toBe("2026-10-07");
    expect(studyDayKey(instant, "Asia/Tokyo", 4)).toBe("2026-10-08");
    expect(studyDayKey(instant, "Australia/Sydney", 4)).toBe("2026-10-08");
  });

  it("the UTC calendar date and the study day genuinely disagree", () => {
    // 01:00 UTC on the 8th is 21:00 on the 7th in New York, which is the 7th's
    // study day. Taking the UTC date would file it under the 8th.
    const instant = at("2026-10-08T01:00:00Z");
    expect(instant.toISOString().slice(0, 10)).toBe("2026-10-08");
    expect(studyDayKey(instant, "America/New_York", 4)).toBe("2026-10-07");
  });
});

describe("DST", () => {
  // US spring forward 2026: 8 March, 02:00 EST -> 03:00 EDT.
  // The 4am boundary is 4am LOCAL on both sides; the UTC instant it
  // corresponds to moves by an hour.
  it("spring forward: the boundary stays at 04:00 local", () => {
    // 08:59 UTC on 8 March is 03:59 EST... but the clock jumped, so 02:00-03:00
    // never happened. 08:00 UTC = 04:00 EDT exactly.
    expect(studyDayKey(at("2026-03-08T07:59:00Z"), "America/New_York", 4)).toBe("2026-03-07");
    expect(studyDayKey(at("2026-03-08T08:00:00Z"), "America/New_York", 4)).toBe("2026-03-08");
  });

  it("fall back: the boundary stays at 04:00 local, an hour later in UTC", () => {
    // US fall back 2026: 1 November, 02:00 EDT -> 01:00 EST. The clock reads
    // 01:00 twice, so the whole morning slides an hour later against UTC.
    // Verified against what the zone actually reports:
    //   07:59Z -> 02:59 local      08:59Z -> 03:59 local      09:00Z -> 04:00
    expect(studyDayKey(at("2026-11-01T07:59:00Z"), "America/New_York", 4)).toBe("2026-10-31");
    expect(studyDayKey(at("2026-11-01T08:59:00Z"), "America/New_York", 4)).toBe("2026-10-31");
    expect(studyDayKey(at("2026-11-01T09:00:00Z"), "America/New_York", 4)).toBe("2026-11-01");
    // The day before, still on EDT, the same boundary sits at 08:00Z. That
    // one-hour shift IS the correct behaviour, not a bug to smooth over.
    expect(startOfStudyDay(at("2026-10-31T12:00:00Z"), "America/New_York", 4).toISOString())
      .toBe("2026-10-31T08:00:00.000Z");
    expect(startOfStudyDay(at("2026-11-01T12:00:00Z"), "America/New_York", 4).toISOString())
      .toBe("2026-11-01T09:00:00.000Z");
  });

  it("the boundary INSTANT moves across a transition, which is the right answer", () => {
    // Before the switch the 4am boundary is 09:00 UTC; after it, 08:00 UTC.
    const winter = startOfStudyDay(at("2026-02-10T12:00:00Z"), "America/New_York", 4);
    const summer = startOfStudyDay(at("2026-07-10T12:00:00Z"), "America/New_York", 4);
    expect(winter.toISOString()).toBe("2026-02-10T09:00:00.000Z");
    expect(summer.toISOString()).toBe("2026-07-10T08:00:00.000Z");
  });

  it("a zone with no DST is unaffected", () => {
    // Asia/Tokyo is UTC+9 all year, so the boundary instant never moves.
    const winter = startOfStudyDay(at("2026-02-10T12:00:00Z"), "Asia/Tokyo", 4);
    const summer = startOfStudyDay(at("2026-07-10T12:00:00Z"), "Asia/Tokyo", 4);
    expect(winter.toISOString()).toBe("2026-02-09T19:00:00.000Z");
    expect(summer.toISOString()).toBe("2026-07-09T19:00:00.000Z");
  });

  it("a half-hour offset zone is handled, not rounded", () => {
    // Asia/Kolkata is UTC+5:30. Offset arithmetic in whole hours gets this
    // wrong; reading the clock does not.
    expect(studyDayKey(at("2026-10-07T22:29:00Z"), "Asia/Kolkata", 4)).toBe("2026-10-07");
    expect(studyDayKey(at("2026-10-07T22:30:00Z"), "Asia/Kolkata", 4)).toBe("2026-10-08");
    expect(startOfStudyDay(at("2026-10-08T12:00:00Z"), "Asia/Kolkata", 4).toISOString())
      .toBe("2026-10-07T22:30:00.000Z");
  });
});

describe("startOfStudyDay returns a real instant", () => {
  it.each([
    ["America/New_York", "2026-10-08T12:00:00Z", "2026-10-08T08:00:00.000Z"],
    ["UTC", "2026-10-08T12:00:00Z", "2026-10-08T04:00:00.000Z"],
    ["Asia/Tokyo", "2026-10-08T12:00:00Z", "2026-10-07T19:00:00.000Z"],
    ["Australia/Sydney", "2026-10-08T12:00:00Z", "2026-10-07T17:00:00.000Z"],
  ])("%s", (zone, now, expected) => {
    expect(startOfStudyDay(at(now), zone, 4).toISOString()).toBe(expected);
  });

  it("agrees with studyDayKey about which day it is", () => {
    for (const zone of ["America/New_York", "Asia/Tokyo", "UTC", "Europe/London", "Asia/Kolkata"]) {
      for (const iso of ["2026-03-08T08:30:00Z", "2026-11-01T06:00:00Z", "2026-07-04T23:00:00Z"]) {
        const start = startOfStudyDay(at(iso), zone, 4);
        // The instant the day began is itself inside that day.
        expect(studyDayKey(start, zone, 4), `${zone} ${iso}`).toBe(studyDayKey(at(iso), zone, 4));
        // And it is never in the future.
        expect(start.getTime(), `${zone} ${iso}`).toBeLessThanOrEqual(at(iso).getTime());
        // And never more than 24 hours back.
        expect(at(iso).getTime() - start.getTime()).toBeLessThanOrEqual(25 * 3600_000);
      }
    }
  });
});

describe("day_start_hour", () => {
  it.each([0, 1, 4, 9, 12, 23])("hour %i puts the boundary where it says", (h) => {
    const before = new Date(Date.UTC(2026, 9, 8, h, 0) - 60_000);
    const atBoundary = new Date(Date.UTC(2026, 9, 8, h, 0));
    expect(studyDayKey(before, "UTC", h)).toBe(h === 0 ? "2026-10-07" : "2026-10-07");
    expect(studyDayKey(atBoundary, "UTC", h)).toBe("2026-10-08");
  });

  it("midnight is a real boundary, not a missing one", () => {
    // `?? DEFAULT` on a 0 would silently turn midnight into 4am.
    expect(studyDayKey(at("2026-10-08T00:00:00Z"), "UTC", 0)).toBe("2026-10-08");
    expect(studyDayKey(at("2026-10-07T23:59:00Z"), "UTC", 0)).toBe("2026-10-07");
  });

  it("clamps an impossible hour instead of producing a nonsense day", () => {
    expect(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", 99)).toBe(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", 23));
    expect(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", -5)).toBe(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", 0));
    expect(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", NaN)).toBe(studyDayKey(at("2026-10-08T12:00:00Z"), "UTC", DEFAULT_DAY_START_HOUR));
  });
});

describe("studyDayKeyOffset walks back by calendar day", () => {
  it("counts back correctly, including across a month end", () => {
    const now = at("2026-11-02T12:00:00Z");
    expect(studyDayKeyOffset(0, now, "America/New_York", 4)).toBe("2026-11-02");
    expect(studyDayKeyOffset(1, now, "America/New_York", 4)).toBe("2026-11-01");
    expect(studyDayKeyOffset(2, now, "America/New_York", 4)).toBe("2026-10-31");
    expect(studyDayKeyOffset(33, now, "America/New_York", 4)).toBe("2026-09-30");
  });

  it("is unaffected by the DST transition it walks over", () => {
    // 1 November 2026 is a fall-back day in New York. A streak walk that used
    // instant arithmetic would double-count or skip it.
    const now = at("2026-11-03T12:00:00Z");
    expect([0, 1, 2, 3].map((i) => studyDayKeyOffset(i, now, "America/New_York", 4)))
      .toEqual(["2026-11-03", "2026-11-02", "2026-11-01", "2026-10-31"]);
  });
});

describe("missing and invalid timezones", () => {
  it("recognises real zones and rejects nonsense", () => {
    for (const good of ["UTC", "America/New_York", "Asia/Tokyo", "Europe/London", "Asia/Kolkata"]) {
      expect(isValidTimezone(good), good).toBe(true);
    }
    for (const bad of [null, undefined, "", "   ", "Mars/Olympus_Mons", "EST5EDT_nope", 4, {}]) {
      expect(isValidTimezone(bad), String(bad)).toBe(false);
    }
  });

  it("a missing timezone becomes the stated default, not the machine's", () => {
    expect(timezoneOf(null)).toBe(DEFAULT_TIMEZONE);
    expect(timezoneOf(undefined)).toBe(DEFAULT_TIMEZONE);
    expect(timezoneOf("")).toBe(DEFAULT_TIMEZONE);
    expect(DEFAULT_TIMEZONE).toBe("UTC");
    // And the default is NOT whatever machine the tests happen to run on.
    expect(timezoneOf(null)).not.toBe("__the machine__");
  });

  it("an invalid timezone also resolves, so the day function never throws", () => {
    // timezoneOf is the lenient edge; the preflight is where an invalid value
    // is caught and reported, so a bad profile cannot crash a learner's page.
    expect(timezoneOf("Mars/Olympus_Mons")).toBe(DEFAULT_TIMEZONE);
    expect(() => studyDayKey(at("2026-10-08T12:00:00Z"), "Mars/Olympus_Mons", 4)).not.toThrow();
  });

  it("a valid timezone passes straight through", () => {
    expect(timezoneOf("Asia/Tokyo")).toBe("Asia/Tokyo");
  });
});

describe("NOTHING HERE READS THE MACHINE'S TIMEZONE IMPLICITLY", () => {
  const src = fs.readFileSync(path.join(__dirname, "studyDay.ts"), "utf8");
  const body = src.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*(\/\/|\*).*$/gm, "");

  it("uses no Date method that depends on where the code runs", () => {
    // setHours, getHours, getFullYear and friends are all machine-local. They
    // are the bug, and the only correct use of them was in a browser.
    for (const m of ["setHours", "getHours", "getFullYear", "getMonth(", "getDate(", "setDate"]) {
      expect(body, m).not.toContain(m);
    }
  });

  it("reads the runtime zone in exactly one place, and names it", () => {
    const hits = [...body.matchAll(/resolvedOptions\(\)/g)];
    expect(hits).toHaveLength(1);
    expect(body).toMatch(/export function detectTimezone/);
    expect(typeof runtimeTimezone()).toBe("string");
  });

  it("never touches process.env.TZ", () => {
    expect(body).not.toMatch(/process\.env/);
  });

  it("the same inputs give the same answer wherever this runs", () => {
    // The real guarantee, stated as a test: the result is a pure function of
    // (instant, zone, hour) and nothing else.
    const instant = at("2026-10-08T07:30:00Z");
    expect(studyDayKey(instant, "America/New_York", 4)).toBe("2026-10-07");
    expect(studyDayKey(instant, "UTC", 4)).toBe("2026-10-08");
    // Two calls, no hidden state, no drift.
    expect(studyDayKey(instant, "America/New_York", 4)).toBe(studyDayKey(instant, "America/New_York", 4));
  });
});
