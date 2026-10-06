import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  ACCOUNT_KINDS, DEFAULT_ACCOUNT_KIND, CALIBRATION_ELIGIBLE_KINDS,
  isCalibrationEligible, calibrationPopulation, isAccountKind,
  CALIBRATION_FILTER_COLUMN, CALIBRATION_FILTER_COLUMN_VALUE,
  type AccountKind,
} from "@/lib/learner/accountKind";

const MIGRATION = path.join(process.cwd(), "supabase", "migrations", "20261006_04_profiles_account_kind.sql");
const sql = fs.readFileSync(MIGRATION, "utf8");

describe("account_kind values", () => {
  it("is exactly the three kinds", () => {
    expect([...ACCOUNT_KINDS]).toEqual(["STUDENT", "DEMO", "INTERNAL"]);
  });

  it("defaults to STUDENT", () => {
    expect(DEFAULT_ACCOUNT_KIND).toBe("STUDENT");
    expect(sql).toMatch(/account_kind TEXT NOT NULL DEFAULT 'STUDENT'/);
  });

  it("the database constrains the same three values", () => {
    expect(sql).toMatch(/CHECK \(account_kind IN \('STUDENT', 'DEMO', 'INTERNAL'\)\)/);
    for (const k of ACCOUNT_KINDS) expect(sql).toContain(`'${k}'`);
  });

  it("rejects anything that is not one of the three", () => {
    for (const bad of ["student", "Student", "TEST", "ADMIN", "", "STUDENT ", null, 7, undefined]) {
      expect(isAccountKind(bad)).toBe(false);
    }
    for (const good of ACCOUNT_KINDS) expect(isAccountKind(good)).toBe(true);
  });
});

describe("CALIBRATION USES A POSITIVE STUDENT FILTER", () => {
  // The whole point of the column. The shorthand that looks equivalent is not.

  it("only STUDENT may fit a model", () => {
    expect(isCalibrationEligible("STUDENT")).toBe(true);
    expect(isCalibrationEligible("DEMO")).toBe(false);
    expect(isCalibrationEligible("INTERNAL")).toBe(false);
    expect([...CALIBRATION_ELIGIBLE_KINDS]).toEqual(["STUDENT"]);
  });

  it("the filter is a value, so the correct comparison is written once", () => {
    expect(CALIBRATION_FILTER_COLUMN).toBe("account_kind");
    expect(CALIBRATION_FILTER_COLUMN_VALUE).toBe("STUDENT");
  });

  it("THE != DEMO SHORTHAND WOULD READMIT THE ACCOUNT THAT CAUSED THIS", () => {
    // Not a hypothetical: the INTERNAL account holds 96% of all reviews and a
    // 33.7% Again rate. Fitting on it produced two wrong parameters.
    const rows: { account_kind: AccountKind; who: string }[] = [
      { account_kind: "STUDENT", who: "a real student" },
      { account_kind: "DEMO", who: "the IG demo account" },
      { account_kind: "INTERNAL", who: "the founder's QA account" },
    ];
    const correct = calibrationPopulation(rows);
    const tempting = rows.filter((r) => r.account_kind !== "DEMO");

    expect(correct.map((r) => r.who)).toEqual(["a real student"]);
    expect(tempting.map((r) => r.who)).toContain("the founder's QA account");
    expect(tempting.length).toBeGreaterThan(correct.length);
  });

  it("an empty population is empty, not everything", () => {
    expect(calibrationPopulation([])).toEqual([]);
    expect(calibrationPopulation([{ account_kind: "INTERNAL" as AccountKind }])).toEqual([]);
  });
});

describe("the migration classifies exactly the known accounts", () => {
  it("classifies by uuid, never by email", () => {
    // 20260602_add_admin_role.sql set is_admin WHERE email = an address that
    // does not exist in profiles, so it silently did nothing. Ids cannot miss.
    const updates = sql.split("UPDATE public.profiles").slice(1).join("");
    expect(updates).not.toMatch(/WHERE\s+email/i);
    expect(updates).toMatch(/WHERE id = /);
  });

  it("one INTERNAL account, by id", () => {
    expect(sql).toMatch(/SET account_kind = 'INTERNAL'\s*\n\s*WHERE id = 'ee01e0e1-ac92-4ea7-92c9-2738b82b6dca'/);
  });

  it("two DEMO accounts, by id", () => {
    expect(sql).toMatch(/SET account_kind = 'DEMO'/);
    expect(sql).toContain("35286b14-b18e-450b-b907-aba61c4d75eb");
    expect(sql).toContain("a8f57824-ed94-47c5-ad68-9cacff39dafd");
  });

  it("asserts its own outcome before committing", () => {
    expect(sql).toMatch(/expected exactly 1 INTERNAL account/);
    expect(sql).toMatch(/expected exactly 2 DEMO accounts/);
    expect(sql).toMatch(/have a null account_kind/);
  });

  it("no other account is classified", () => {
    const ids = [...sql.matchAll(/'([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})'/g)].map((m) => m[1]);
    expect(new Set(ids)).toEqual(new Set([
      "ee01e0e1-ac92-4ea7-92c9-2738b82b6dca",
      "35286b14-b18e-450b-b907-aba61c4d75eb",
      "a8f57824-ed94-47c5-ad68-9cacff39dafd",
    ]));
  });
});

describe("a user cannot reclassify themselves", () => {
  // RLS grants "Users can update own profile" with no column restriction, so
  // without a guard a student could set themselves INTERNAL and leave the
  // calibration population. The shape copies prevent_is_admin_self_update.
  it("a BEFORE UPDATE trigger reverts an authenticated change", () => {
    expect(sql).toMatch(/CREATE OR REPLACE FUNCTION public\.prevent_account_kind_self_update/);
    expect(sql).toMatch(/auth\.role\(\) = 'authenticated'/);
    expect(sql).toMatch(/NEW\.account_kind := OLD\.account_kind/);
    expect(sql).toMatch(/BEFORE UPDATE ON public\.profiles/);
  });

  it("the migration verifies the guard is attached", () => {
    expect(sql).toMatch(/the self-reclassification guard is not attached/);
  });

  it("follows the existing admin-column protection rather than inventing a role system", () => {
    const admin = fs.readFileSync(
      path.join(process.cwd(), "supabase", "migrations", "20260602_add_admin_role.sql"), "utf8");
    for (const shape of ["SECURITY DEFINER", "auth.role() = 'authenticated'", "BEFORE UPDATE ON profiles"]) {
      expect(admin).toContain(shape.replace("public.", ""));
    }
    expect(sql).toContain("SECURITY DEFINER");
  });
});

describe("ACCOUNT KIND MUST NOT ENTER THE PURE MODEL", () => {
  // Every account kind computes identical learner states. Segmentation happens
  // outside the model, in whatever fits a threshold, never inside it.
  const conceptState = fs.readFileSync(
    path.join(process.cwd(), "lib", "learner", "conceptState.ts"), "utf8");
  // Comments are stripped first: the module's own doc comment states that it
  // reads no account_kind, and that prose must stay allowed. Same convention as
  // the predictor firewall and the write-scope lint.
  const executable = (src: string) =>
    src.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");

  it("conceptState.ts never reads account kind in executable code", () => {
    expect(executable(conceptState)).not.toMatch(/account_kind|accountKind|AccountKind/);
  });

  it("and it does say so in prose, which is where the rule belongs", () => {
    expect(conceptState).toMatch(/account_kind/);
  });

  it("conceptState.ts does not import this module", () => {
    const imports = [...conceptState.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
    expect(imports.filter((i) => /accountKind/i.test(i))).toEqual([]);
  });

  it("the pure model takes no population argument", () => {
    expect(conceptState).toMatch(/evidence: ConceptEvidence,\s*\n\s*previous: ConceptState\[\] \| null,\s*\n\s*now: Date,/);
  });
});

describe("the score predictor never sees account kind", () => {
  it("scoreEstimate.ts does not mention it", () => {
    const predictor = fs.readFileSync(
      path.join(process.cwd(), "lib", "scoring", "scoreEstimate.ts"), "utf8");
    const code = predictor.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");
    expect(code).not.toMatch(/account_kind|accountKind/);
  });
});
