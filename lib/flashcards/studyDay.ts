// ─── The study day ───────────────────────────────────────────────────────────
//
// ONE definition of "today", used by every daily limit, counter and streak.
//
// Why this exists. Each surface used to compute its own day boundary with
// `new Date(); d.setHours(0,0,0,0)` — five copies in the web app and three more
// in the phone app, all silently assuming midnight. That produced two problems.
//
// 1. A session that runs past midnight splits into two study days and charges
//    two days of quota. Not hypothetical: this user's review log has sessions
//    at 21:00, 22:00 and 00:00 on the same sitting.
// 2. Deriving a day key from an ISO string uses UTC, so on a US evening every
//    row lands on tomorrow.
//
// The boundary is therefore a LOCAL hour, configurable per profile
// (profiles.day_start_hour), defaulting to 4am — the Anki convention. A 2am
// session belongs to the day it felt like, not the one the clock had rolled to.
//
// ─── AND THEN THE SECOND BUG, WHICH THIS FILE NOW FIXES ─────────────────────
//
// "LOCAL" was implemented with Date.setHours(), which means local to WHATEVER
// MACHINE RUNS THE CODE. In a browser that is the learner's own machine and is
// right. On Vercel it is UTC, and it is wrong: `day_start_hour = 4` meant 4am
// UTC, which is midnight in New York. A learner studying at 1am ET had their
// work filed under the next day, and a server-computed study_day disagreed
// with the one their own browser computed.
//
// So TIMEZONE IS NOW AN EXPLICIT ARGUMENT. No function here reads the machine
// timezone implicitly: the same inputs return the same answer whether they run
// on a laptop in New York, in a Vercel function in UTC, or in a test. A caller
// that genuinely wants the browser's zone asks for it by name.
//
// Implemented with Intl.DateTimeFormat, which carries the IANA database and is
// DST-correct by construction. No dependency was added: no timezone library is
// installed in this project, and arithmetic on fixed UTC offsets would be
// wrong twice a year in every zone that observes DST.

export const DEFAULT_DAY_START_HOUR = 4;

/**
 * The timezone used when a profile has none.
 *
 * UTC, deliberately, and NOT the server's zone — "wherever this code happens
 * to run" is the bug this file exists to remove. It is also not a guess at
 * where the learner probably is: five of nine live profiles have no timezone,
 * and inferring one from an email domain or from the other accounts would be
 * inventing data about a person.
 *
 * It is a stated placeholder. The real fix is to capture the browser's zone
 * and store it; see detectTimezone below, which exists and is not yet called
 * from anywhere.
 */
export const DEFAULT_TIMEZONE = "UTC";

/** Is this a timezone the runtime's IANA database recognises? */
export function isValidTimezone(timeZone: unknown): timeZone is string {
  if (typeof timeZone !== "string" || timeZone.trim() === "") return false;
  try {
    new Intl.DateTimeFormat("en-CA", { timeZone });
    return true;
  } catch {
    return false;
  }
}

/**
 * A profile's timezone, or the stated default.
 *
 * One place decides what a missing timezone means, so no call site invents its
 * own answer. An INVALID one is not silently defaulted — it is a value someone
 * wrote that nothing can interpret, and the account-universe preflight treats
 * it as an integrity failure rather than quietly picking a zone.
 */
export const timezoneOf = (profileTimezone: string | null | undefined): string =>
  isValidTimezone(profileTimezone) ? profileTimezone : DEFAULT_TIMEZONE;

interface LocalParts { year: number; month: number; day: number; hour: number; minute: number; }

/** What the wall clock reads in `timeZone` at this instant. */
function partsIn(now: Date, timeZone: string): LocalParts {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone, year: "numeric", month: "2-digit", day: "2-digit",
    hour: "2-digit", minute: "2-digit", hour12: false,
  }).formatToParts(now);
  const p: Record<string, string> = {};
  for (const part of parts) if (part.type !== "literal") p[part.type] = part.value;
  return {
    year: Number(p.year), month: Number(p.month), day: Number(p.day),
    // Some ICU builds render midnight as "24" under hour12:false.
    hour: p.hour === "24" ? 0 : Number(p.hour),
    minute: Number(p.minute),
  };
}

const pad = (n: number) => String(n).padStart(2, "0");
const dateKey = (y: number, m: number, d: number) => `${y}-${pad(m)}-${pad(d)}`;

/** The calendar date `days` before this one, as plain date arithmetic. */
function shiftDate(y: number, m: number, d: number, days: number): [number, number, number] {
  const t = new Date(Date.UTC(y, m - 1, d));
  t.setUTCDate(t.getUTCDate() + days);
  return [t.getUTCFullYear(), t.getUTCMonth() + 1, t.getUTCDate()];
}

function clampHour(h: unknown): number {
  const n = Number(h);
  if (!Number.isFinite(n)) return DEFAULT_DAY_START_HOUR;
  return Math.min(23, Math.max(0, Math.trunc(n)));
}

/**
 * Stable 'YYYY-MM-DD' key for the study day containing `now`, in the learner's
 * own timezone.
 *
 * With a 4am boundary in America/New_York: at 09:00 Tuesday ET this returns
 * Tuesday; at 01:30 Tuesday ET it returns MONDAY, because 1:30am still belongs
 * to Monday's study day. The same instant for a learner in Asia/Tokyo returns
 * whatever their own wall clock says, which is usually a different date.
 *
 * DST is handled by the IANA database rather than by offset arithmetic: the
 * boundary is 04:00 LOCAL on both sides of a transition, even though the UTC
 * instant it corresponds to moves by an hour.
 */
export function studyDayKey(
  now: Date,
  timeZone: string,
  dayStartHour: number = DEFAULT_DAY_START_HOUR,
): string {
  const hour = clampHour(dayStartHour);
  const tz = isValidTimezone(timeZone) ? timeZone : DEFAULT_TIMEZONE;
  const { year, month, day, hour: localHour } = partsIn(now, tz);
  if (localHour < hour) {
    const [y, m, d] = shiftDate(year, month, day, -1);
    return dateKey(y, m, d);
  }
  return dateKey(year, month, day);
}

/** The study-day key `offset` days before the one containing `now`. */
export function studyDayKeyOffset(
  offset: number,
  now: Date,
  timeZone: string,
  dayStartHour: number = DEFAULT_DAY_START_HOUR,
): string {
  const [y, m, d] = studyDayKey(now, timeZone, dayStartHour).split("-").map(Number);
  const [sy, sm, sd] = shiftDate(y, m, d, -offset);
  return dateKey(sy, sm, sd);
}

/**
 * The INSTANT at which the current study day began, as a Date.
 *
 * Callers compare review timestamps against this, so it has to be a real
 * moment in time rather than a local wall-clock reading. Finding the instant
 * that corresponds to a given local time is the inverse of reading a clock,
 * and there is no primitive for it: the two passes below converge on it by
 * formatting a guess, measuring how far off the result is, and correcting.
 *
 * The second pass is not belt and braces. On a spring-forward morning the
 * local hour 02:00 does not exist at all, and on a fall-back morning 01:30
 * happens twice; a single correction lands in the gap or picks the wrong one
 * of the pair. Two passes settle on the instant the zone actually had.
 */
export function startOfStudyDay(
  now: Date,
  timeZone: string,
  dayStartHour: number = DEFAULT_DAY_START_HOUR,
): Date {
  const hour = clampHour(dayStartHour);
  const tz = isValidTimezone(timeZone) ? timeZone : DEFAULT_TIMEZONE;
  const [y, m, d] = studyDayKey(now, tz, hour).split("-").map(Number);
  const wanted = Date.UTC(y, m - 1, d, hour, 0, 0, 0);

  let guess = wanted;
  for (let pass = 0; pass < 2; pass++) {
    const p = partsIn(new Date(guess), tz);
    const got = Date.UTC(p.year, p.month - 1, p.day, p.hour, p.minute, 0, 0);
    const drift = got - wanted;
    if (drift === 0) break;
    guess -= drift;
  }
  return new Date(guess);
}

/**
 * The browser's IANA timezone, e.g. "America/New_York", or null.
 *
 * NOT YET CALLED FROM ANYWHERE, which is the finding behind this step: the
 * column exists, its comment says "callers fall back to the browser timezone
 * until it is set", and nothing ever sets it. Five of nine live profiles are
 * NULL as a result, and every future signup would be too.
 */
export function detectTimezone(): string | null {
  try {
    return Intl.DateTimeFormat().resolvedOptions().timeZone || null;
  } catch {
    return null;
  }
}

/** The zone this runtime is in. Correct in a browser; UTC in a Vercel function. */
export const runtimeTimezone = (): string => detectTimezone() ?? DEFAULT_TIMEZONE;
