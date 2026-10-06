// ─── Who counts as a student ───────────────────────────────────────────────
//
// ONE RULE, STATED ONCE: only STUDENT data may fit a model threshold.
//
// This is not a permission system and it changes no behaviour. A DEMO account
// and a STUDENT account compute identical learner concept states, get identical
// scheduling and see identical dashboards. The column exists so that code which
// FITS something can say truthfully which population it fitted.
//
// WHY IT EXISTS. Phase 2 calibration found one INTERNAL account holding 96% of
// all flashcard reviews, behaving unlike any student: a 33.7% Again rate
// against the students' 18.2%. Two model parameters were fitted on it before
// this label existed and both were wrong. A lapse penalty looked strongly
// justified on 9,771 internal review transitions and disappeared entirely on
// the students' 1,516.

export const ACCOUNT_KINDS = ["STUDENT", "DEMO", "INTERNAL"] as const;
export type AccountKind = (typeof ACCOUNT_KINDS)[number];

export const DEFAULT_ACCOUNT_KIND: AccountKind = "STUDENT";

/**
 * The kinds whose data may fit a model threshold.
 *
 * A POSITIVE SET, deliberately. The tempting shorthand is `kind !== "DEMO"`,
 * and it is wrong in the exact way that matters: it readmits INTERNAL, which is
 * the account that made segmentation necessary in the first place. Anyone
 * writing a calibration query reaches for this constant rather than inventing a
 * comparison.
 */
export const CALIBRATION_ELIGIBLE_KINDS: ReadonlySet<AccountKind> = new Set<AccountKind>(["STUDENT"]);

export const isCalibrationEligible = (kind: AccountKind): boolean =>
  CALIBRATION_ELIGIBLE_KINDS.has(kind);

/** The rows a model may be fitted on. Nothing else may be. */
export function calibrationPopulation<T extends { account_kind: AccountKind }>(rows: T[]): T[] {
  return rows.filter((r) => isCalibrationEligible(r.account_kind));
}

/**
 * The filter a calibration query must apply, as a value rather than a habit.
 *
 * Used as `.eq("account_kind", CALIBRATION_FILTER_COLUMN_VALUE)` so the one
 * correct comparison is written once and imported, not retyped per script.
 */
export const CALIBRATION_FILTER_COLUMN = "account_kind" as const;
export const CALIBRATION_FILTER_COLUMN_VALUE: AccountKind = "STUDENT";

export const isAccountKind = (v: unknown): v is AccountKind =>
  typeof v === "string" && (ACCOUNT_KINDS as readonly string[]).includes(v);
