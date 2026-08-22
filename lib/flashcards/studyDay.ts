// ─── The study day ───────────────────────────────────────────────────────────
//
// ONE definition of "today", used by every daily limit, counter and streak.
//
// Why this exists. Until now each surface computed its own day boundary with
// `new Date(); d.setHours(0,0,0,0)` — five copies in the web app and three more
// in the phone app, all silently assuming midnight. That produced two problems.
//
// 1. A session that runs past midnight splits into two study days and charges
//    two days of quota. Not hypothetical: this user's review log has sessions
//    at 21:00, 22:00 and 00:00 on the same sitting.
// 2. Deriving a day key from an ISO string uses UTC, so on a US evening every
//    row lands on tomorrow. That mistake silently produced a streak of zero
//    while seeding demo data, which is how it was caught.
//
// The boundary is therefore a LOCAL hour, configurable per profile
// (profiles.day_start_hour), defaulting to 4am — the Anki convention. A 2am
// session belongs to the day it felt like, not the one the clock had rolled to.
//
// Calendar dates are NOT study days. The week grid on the plan page and the
// days-until-MCAT countdown are genuine calendar arithmetic and deliberately do
// not use these helpers.

export const DEFAULT_DAY_START_HOUR = 4;

/**
 * The instant the current study day began, in local time.
 *
 * With the default 4am boundary: at 09:00 Tuesday this returns Tuesday 04:00;
 * at 01:30 Tuesday it returns MONDAY 04:00, because 1:30am still belongs to
 * Monday's study day.
 */
export function startOfStudyDay(
  now: Date = new Date(),
  dayStartHour: number = DEFAULT_DAY_START_HOUR
): Date {
  const hour = clampHour(dayStartHour);
  const start = new Date(now);
  start.setHours(hour, 0, 0, 0);
  if (now.getHours() < hour) {
    start.setDate(start.getDate() - 1);
  }
  return start;
}

/**
 * Stable 'YYYY-MM-DD' key for the study day containing `now`.
 *
 * Built from LOCAL calendar fields on purpose. `toISOString().slice(0,10)`
 * would convert to UTC first and misfile every evening review onto the next
 * day for anyone west of Greenwich.
 */
export function studyDayKey(
  now: Date = new Date(),
  dayStartHour: number = DEFAULT_DAY_START_HOUR
): string {
  const start = startOfStudyDay(now, dayStartHour);
  const pad = (n: number) => String(n).padStart(2, "0");
  return `${start.getFullYear()}-${pad(start.getMonth() + 1)}-${pad(start.getDate())}`;
}

/**
 * The study-day key `offset` days before the one containing `now`.
 * Used by streak walks, which need yesterday, the day before, and so on.
 */
export function studyDayKeyOffset(
  offset: number,
  now: Date = new Date(),
  dayStartHour: number = DEFAULT_DAY_START_HOUR
): string {
  const start = startOfStudyDay(now, dayStartHour);
  start.setDate(start.getDate() - offset);
  const pad = (n: number) => String(n).padStart(2, "0");
  return `${start.getFullYear()}-${pad(start.getMonth() + 1)}-${pad(start.getDate())}`;
}

/**
 * The browser's IANA timezone, e.g. "America/New_York", or null if the
 * environment will not report one. Stored on the profile so the server can
 * compute a study day without asking the client (PR2).
 */
export function detectTimezone(): string | null {
  try {
    return Intl.DateTimeFormat().resolvedOptions().timeZone || null;
  } catch {
    return null;
  }
}

function clampHour(h: number): number {
  if (!Number.isFinite(h)) return DEFAULT_DAY_START_HOUR;
  return Math.min(12, Math.max(0, Math.trunc(h)));
}
