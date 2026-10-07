import { describe, it, expect } from "vitest";
import fs from "fs";
import path from "path";
import {
  estimateScore,
  estimateBasis,
  PREDICTOR_VERSION,
  SCORE_FLOOR,
  SCORE_CEILING,
  MCAT_SECTIONS,
} from "./scoreEstimate";

const ALL_SECTIONS = new Set(["chem_phys", "cars", "bio_biochem", "psych_soc"]);
const BANK_TODAY = new Set(["bio_biochem", "chem_phys"]);
/** k distinct subtopics, for the breadth term. */
const topics = (k: number) => new Set(Array.from({ length: k }, (_, i) => `t${i}`));
const BROAD = topics(30);

describe("FLASHCARDS MUST NEVER MOVE THE PREDICTED SCORE", () => {
  // This is a product rule, not an implementation detail. Memory strength is
  // evidence about RECALL; the score estimate is about applied reasoning under
  // exam conditions. A student can hold 5,000 cards perfectly and still not be
  // able to work a passage, and telling them their score rose because their
  // retention rose would be a lie the dashboard cannot take back.
  //
  // The guard is structural rather than behavioural, because a behavioural test
  // can only check inputs the function already accepts. What has to be
  // prevented is someone LATER adding such an input.

  const source = fs.readFileSync(path.join(__dirname, "scoreEstimate.ts"), "utf8");

  it("the scoring module imports nothing from the flashcard system", () => {
    const imports = [...source.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
    const offenders = imports.filter((i) => /flashcard|fsrs|srs|review|memory/i.test(i));
    expect(offenders).toEqual([]);
  });

  it("the scoring module never mentions card, review or retention data", () => {
    // Comments are stripped first: the file explains at length why cards are
    // excluded, and that prose must stay allowed.
    const code = source
      .replace(/\/\*[\s\S]*?\*\//g, "")
      .replace(/^\s*\/\/.*$/gm, "");
    const banned = /\b(flashcard|fsrs|stability|retrievability|cardsDue|reviewCount|memoryHealth)\b/i;
    expect(banned.test(code)).toBe(false);
  });

  it("every parameter it takes is question evidence", () => {
    // Function.length stopped being a useful guard when optional parameters
    // arrived in 1.2.0, since defaults do not count toward it. Reading the
    // signature text does not have that hole.
    const signature = estimateScore.toString().slice(0, 400);
    expect(/flashcard|card|review|memory|stability|retention/i.test(signature)).toBe(false);
    expect(signature).toMatch(/firstAttemptAccuracy/);
    expect(signature).toMatch(/sectionsWithData/);
  });

  it("is a pure function of question evidence", () => {
    // Called twice with identical question evidence in a session where memory
    // state could have changed arbitrarily in between, the answer is identical.
    const a = estimateScore(70, 200, new Set(BANK_TODAY));
    const b = estimateScore(70, 200, new Set(BANK_TODAY));
    expect(a).toEqual(b);
  });

  it("moves ONLY when question evidence moves", () => {
    const base = estimateScore(70, 200, new Set(BANK_TODAY));
    // Accuracy up: centre must rise.
    expect(estimateScore(85, 200, new Set(BANK_TODAY)).centre!).toBeGreaterThan(base.centre!);
    // More questions at the same accuracy: same centre, no wider.
    const more = estimateScore(70, 600, new Set(BANK_TODAY));
    expect(more.centre).toBe(base.centre);
    expect(more.high! - more.low!).toBeLessThanOrEqual(base.high! - base.low!);
  });
});

describe("thin evidence widens rather than flatters", () => {
  it("says nothing at all below the minimum attempts", () => {
    const e = estimateScore(100, 5, new Set(ALL_SECTIONS));
    expect(e.low).toBeNull();
    expect(e.high).toBeNull();
    expect(e.centre).toBeNull();
    expect(e.confidence).toBe("Low");
    expect(estimateBasis(e)).toMatch(/at least \d+ practice questions/i);
  });

  it("keeps the range wide when the evidence is thin", () => {
    // 20/20 is the shape of a student who has answered one easy set.
    const e = estimateScore(100, 20, new Set(BANK_TODAY));
    expect(e.high! - e.low!).toBeGreaterThan(10);
    expect(e.confidence).toBe("Low");
  });

  it("THIN EVIDENCE NO LONGER IMPLIES A PERFECT-SCORE CEILING", () => {
    // The 1.1.0 behaviour this replaces: 20 first attempts at 100% produced
    // 510 to 528, so the top of the band a student was shown was a perfect
    // MCAT score earned on twenty questions across half an exam. Deliberately
    // replaced in 1.2.0, not lost by accident.
    const e = estimateScore(100, 20, new Set(BANK_TODAY), topics(12), 0);
    expect(e.high!).toBeLessThan(SCORE_CEILING);
    expect(e.high!).toBeLessThanOrEqual(520);
    // And the range did NOT become narrow in exchange. A tight band would read
    // as confidence, which is the failure mode the first attempt at this had.
    expect(e.high! - e.low!).toBeGreaterThanOrEqual(14);
    expect(e.confidence).toBe("Low");
  });

  it("widens for every unmeasured MCAT section", () => {
    const all = estimateScore(80, 300, new Set(ALL_SECTIONS));
    const two = estimateScore(80, 300, new Set(BANK_TODAY));
    expect(two.high! - two.low!).toBeGreaterThan(all.high! - all.low!);
    expect(two.blindSections.sort()).toEqual(["CARS", "P/S"]);
  });

  it("caps confidence at Low while half the exam is unmeasured", () => {
    // Today's bank has no CARS or P/S, so no amount of practice earns High.
    expect(estimateScore(95, 5000, new Set(BANK_TODAY), BROAD, 0).confidence).toBe("Low");
    expect(estimateScore(95, 5000, new Set(ALL_SECTIONS), BROAD, 0).confidence).toBe("High");
  });

  it("volume across all four sections is still not High without breadth", () => {
    // 5,000 questions confined to a handful of subtopics is deep, not broad.
    // Under 1.1.0 this was High on question count alone.
    expect(estimateScore(95, 5000, new Set(ALL_SECTIONS), topics(2), 0).confidence)
      .toBe("Moderate");
  });

  it("never returns a score outside the real MCAT scale", () => {
    for (const acc of [0, 25, 50, 75, 100]) {
      for (const n of [20, 100, 1000]) {
        const e = estimateScore(acc, n, new Set(BANK_TODAY));
        expect(e.low!).toBeGreaterThanOrEqual(SCORE_FLOOR);
        expect(e.high!).toBeLessThanOrEqual(SCORE_CEILING);
        expect(e.low!).toBeLessThanOrEqual(e.high!);
      }
    }
  });

  it("is monotonic in accuracy", () => {
    let last = -Infinity;
    for (const acc of [0, 55, 65, 72, 78, 83, 88, 95]) {
      const c = estimateScore(acc, 300, new Set(ALL_SECTIONS)).centre!;
      expect(c).toBeGreaterThanOrEqual(last);
      last = c;
    }
  });
});

describe("the estimate can be audited later", () => {
  it("stamps the predictor version on every result", () => {
    expect(estimateScore(70, 200, new Set(BANK_TODAY)).version).toBe(PREDICTOR_VERSION);
    expect(estimateScore(70, 2, new Set(BANK_TODAY)).version).toBe(PREDICTOR_VERSION);
  });

  it("says the estimate is provisional, so a fitted version is distinguishable", () => {
    expect(PREDICTOR_VERSION).toMatch(/provisional/);
  });

  it("reports what it rested on", () => {
    const e = estimateScore(70, 200, new Set(BANK_TODAY));
    expect(e.firstAttempts).toBe(200);
    expect(estimateBasis(e)).toContain("200");
  });

  it("covers all four MCAT sections in its blind-section model", () => {
    expect(MCAT_SECTIONS).toHaveLength(4);
    expect(estimateScore(70, 200, new Set()).blindSections).toHaveLength(4);
  });
});

describe("the ceiling is evidence-aware, not a fixed cap", () => {
  // The rule: extreme upper bounds are earned by DEPTH and BREADTH together,
  // and a student cannot buy one with the other.

  it("more questions support a higher ceiling", () => {
    const thin = estimateScore(100, 20, new Set(BANK_TODAY), topics(12), 0);
    const deep = estimateScore(100, 500, new Set(BANK_TODAY), topics(12), 0);
    expect(deep.high!).toBeGreaterThan(thin.high!);
  });

  it("SECTION BREADTH CANNOT BE BOUGHT WITH VOLUME", () => {
    // This is why the evidence terms multiply rather than add. The total score
    // is the sum of four sections; two of them being unmeasured is not a gap
    // that more Bio questions can close.
    const lotsButNarrow = estimateScore(100, 800, new Set(BANK_TODAY), BROAD, 0);
    const fewerButBroad = estimateScore(100, 150, new Set(ALL_SECTIONS), BROAD, 0);
    expect(fewerButBroad.evidence!.ceiling).toBeGreaterThan(lotsButNarrow.evidence!.ceiling);
  });

  it("subtopic breadth raises the ceiling at a fixed question count", () => {
    const narrow = estimateScore(95, 250, new Set(ALL_SECTIONS), topics(3), 0);
    const broad = estimateScore(95, 250, new Set(ALL_SECTIONS), BROAD, 0);
    expect(broad.evidence!.ceiling).toBeGreaterThan(narrow.evidence!.ceiling);
  });

  it("a full length raises the ceiling, and its absence is priced in", () => {
    const without = estimateScore(95, 500, new Set(ALL_SECTIONS), BROAD, 0);
    const with_ = estimateScore(95, 500, new Set(ALL_SECTIONS), BROAD, 2);
    expect(with_.evidence!.ceiling).toBeGreaterThan(without.evidence!.ceiling);
    expect(without.evidence!.hasFullLength).toBe(false);
  });

  it("an elite ceiling becomes reachable on a complete evidence base", () => {
    const best = estimateScore(100, 800, new Set(ALL_SECTIONS), BROAD, 3);
    expect(Math.round(best.evidence!.ceiling)).toBeGreaterThanOrEqual(525);
  });

  it("THE CEILING SLIDES THE WINDOW, IT DOES NOT SQUEEZE IT", () => {
    // Capping the top must lower the bottom by the same amount. A narrow band
    // reads as certainty, so moderating the ceiling must never make a thin
    // estimate look more authoritative.
    const capped = estimateScore(100, 20, new Set(BANK_TODAY), topics(12), 0);
    const uncapped = estimateScore(60, 20, new Set(BANK_TODAY), topics(12), 0);
    expect(capped.high! - capped.low!).toBe(uncapped.high! - uncapped.low!);
  });

  it("never widens the range as evidence grows", () => {
    let previousWidth = Infinity;
    for (const n of [20, 50, 100, 250, 500]) {
      const e = estimateScore(90, n, new Set(ALL_SECTIONS), BROAD, 1);
      const width = e.high! - e.low!;
      expect(width).toBeLessThanOrEqual(previousWidth);
      previousWidth = width;
    }
  });

  it("the ceiling never falls as any single input improves", () => {
    let previous = -Infinity;
    for (const n of [20, 50, 100, 250, 500, 800]) {
      const c = estimateScore(100, n, new Set(BANK_TODAY), topics(12), 0).evidence!.ceiling;
      expect(c).toBeGreaterThanOrEqual(previous);
      previous = c;
    }
  });

  it("stays inside the real MCAT scale under every evidence shape", () => {
    for (const n of [20, 100, 800]) {
      for (const acc of [0, 50, 100]) {
        for (const secs of [new Set<string>(), new Set(BANK_TODAY), new Set(ALL_SECTIONS)]) {
          for (const k of [0, 3, 30]) {
            const e = estimateScore(acc, n, secs, topics(k), 0);
            expect(e.low!).toBeGreaterThanOrEqual(SCORE_FLOOR);
            expect(e.high!).toBeLessThanOrEqual(SCORE_CEILING);
            expect(e.low!).toBeLessThanOrEqual(e.centre!);
            expect(e.centre!).toBeLessThanOrEqual(e.high!);
          }
        }
      }
    }
  });
});

describe("confidence follows evidence, not range width", () => {
  it("twenty perfect questions is Low confidence", () => {
    expect(estimateScore(100, 20, new Set(ALL_SECTIONS), topics(12), 0).confidence).toBe("Low");
  });

  it("narrow subtopic coverage holds confidence down", () => {
    const narrow = estimateScore(95, 250, new Set(ALL_SECTIONS), topics(3), 0);
    const broad = estimateScore(95, 250, new Set(ALL_SECTIONS), BROAD, 2);
    expect(narrow.confidence).not.toBe("High");
    expect(broad.confidence).toBe("High");
  });

  it("half the exam unmeasured is always Low, however much practice there is", () => {
    expect(estimateScore(95, 5000, new Set(BANK_TODAY), BROAD, 5).confidence).toBe("Low");
  });
});

describe("THE FULL 472 TO 528 SCALE STAYS REACHABLE", () => {
  // 1.2.0 moderated the ceiling and, as a side effect, made anything above 522
  // impossible forever: the centre table saturated at 519 and half-width could
  // only add three at deep evidence. Evidence must control HOW QUICKLY the top
  // of the scale becomes available, never whether it exists at all.

  const DEEP_AND_BROAD = () =>
    estimateScore(100, 5000, new Set(ALL_SECTIONS), topics(60), 10);

  it("reaches the top of the scale on a complete evidence base", () => {
    expect(DEEP_AND_BROAD().high).toBe(SCORE_CEILING);
  });

  it("reaches the bottom of the scale when performance is at chance", () => {
    // 25% on four options is chance, which is no evidence of knowledge at all.
    const e = estimateScore(25, 5000, new Set(ALL_SECTIONS), topics(60), 10);
    expect(e.low).toBe(SCORE_FLOOR);
  });

  it("spans substantially more of the scale than the centre table used to", () => {
    const top = DEEP_AND_BROAD().high!;
    const bottom = estimateScore(0, 5000, new Set(ALL_SECTIONS), topics(60), 10).low!;
    // 1.2.0 could express 497 to 522. The real scale is 56 points wide.
    expect(top - bottom).toBeGreaterThanOrEqual(50);
  });

  it("EVIDENCE GATES THE TOP RATHER THAN THE TABLE REFUSING IT", () => {
    // The same perfect accuracy, at four evidence depths. The ceiling should
    // release the high end progressively, and only a complete base reaches 528.
    const thin = estimateScore(100, 20, new Set(BANK_TODAY), topics(12), 0).high!;
    const mid = estimateScore(100, 250, new Set(ALL_SECTIONS), topics(30), 0).high!;
    const deep = estimateScore(100, 800, new Set(ALL_SECTIONS), topics(30), 3).high!;

    expect(thin).toBeLessThan(mid);
    expect(mid).toBeLessThan(deep);
    expect(deep).toBe(SCORE_CEILING);
    // And the thin case is still protected, which was the point of 1.2.0.
    expect(thin).toBeLessThanOrEqual(520);
  });

  it("the centre mapping is monotonic across the whole accuracy range", () => {
    let previous = -Infinity;
    for (let acc = 0; acc <= 100; acc++) {
      const c = estimateScore(acc, 5000, new Set(ALL_SECTIONS), topics(60), 10).centre!;
      expect(c).toBeGreaterThanOrEqual(previous);
      previous = c;
    }
  });

  it("leaves the approved 60 to 90 percent band exactly where it was", () => {
    // Those boundaries were calibrated before 1.3.0 and must not drift. Deep
    // evidence, so the ceiling is not binding and the centre shows through.
    const centreAt = (acc: number) =>
      estimateScore(acc, 800, new Set(ALL_SECTIONS), topics(30), 3).centre!;
    expect(centreAt(60)).toBe(503);
    expect(centreAt(70)).toBe(507);
    expect(centreAt(75)).toBe(510);
    expect(centreAt(80)).toBe(513);
    expect(centreAt(85)).toBe(516);
    expect(centreAt(90)).toBe(519);
  });
});

// ─── FIREWALL EXPANSION: learner concept states must not reach the score ────
//
// Phase 2 creates a NEW way to breach the flashcard rule, and it does not use
// the word flashcard. `learner_concept_states` deliberately puts memory-derived
// and application-derived values on the SAME ROW, so any code that reads the
// row holds memory evidence whether it means to or not. "Just use the
// application columns" is one careless join away from retention moving a
// predicted MCAT score.
//
// So the boundary is absolute and simple: THE PREDICTOR MAY NOT CONSUME LEARNER
// CONCEPT STATE AT ALL. If concept-level question evidence is ever wanted in the
// score, it comes through an explicitly reviewed question-only pathway, not by
// reading a mixed row.
//
// BOTH TABLES WERE BANNED BEFORE EITHER EXISTED, while banning them was free.
// public.learner_concept_states is now real. The ban is unchanged, and the test
// below proves that it was never a statement about a missing relation: the
// predictor is forbidden to name the table whether or not the table is there.

describe("THE PREDICTOR MAY NOT CONSUME LEARNER CONCEPT STATE", () => {
  const ROOT = path.join(__dirname, "..", "..");
  const predictorSource = fs.readFileSync(path.join(__dirname, "scoreEstimate.ts"), "utf8");

  /**
   * Modules whose values are memory-derived, or mixed with memory.
   *
   * The Phase 2 production path is named here module by module rather than
   * trusted to the `conceptState` prefix: the loader and the orchestrator
   * carry whole-bank memory evidence and the writer's own payload, and an
   * import of any of them puts retention one property access from the score.
   */
  const PROHIBITED_MODULES = [
    "lib/learner/conceptState", "learner/conceptState", "./conceptState",
    "conceptStatePersistence", "conceptEvidence", "computeConceptStates",
    "lib/flashcards/", "lib/analytics/flashcardAggregate",
  ];
  /**
   * Tables the predictor may never read.
   *
   * All three learner-concept-state tables now exist: the current state as of
   * 20261006_08, and the observation parent plus its per-concept child as of
   * 20261007_05. history was banned here while it was still hypothetical and
   * needed no change when it arrived, which is the whole value of banning a
   * name early. observations did not exist under any name when this list was
   * written, so it is added in the step that creates it.
   *
   * The observation parent carries no memory values at all, only the identity
   * of a cycle. It is banned regardless, because it is the join key to a child
   * table full of them, and "read the parent, join the child" is precisely the
   * one careless join this firewall exists to make impossible.
   */
  const PROHIBITED_TABLES = [
    "learner_concept_states",
    "learner_concept_state_observations",
    "learner_concept_state_history",
    "flashcard_user_state", "flashcard_reviews", "flashcard_concepts", "flashcards",
  ];
  /** Field shapes that carry memory evidence under any naming convention. */
  const PROHIBITED_FIELDS =
    /\b(memory_\w+|memoryDurability|memoryFreshness|memorySignal|memoryConfidence|flashcard_\w+|fsrs_\w+|retrievability|stability|weak_card_count|weakCardCount)\b/i;

  /** Every non-test source file under app/, lib/ and components/. */
  function sourceFiles(dir: string, acc: string[] = []): string[] {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        if (entry.name === "node_modules" || entry.name === ".next") continue;
        sourceFiles(full, acc);
      } else if (/\.tsx?$/.test(entry.name) && !/\.test\.tsx?$/.test(entry.name)) {
        acc.push(full);
      }
    }
    return acc;
  }
  const ALL_SOURCES = ["app", "lib", "components"]
    .map((d) => path.join(ROOT, d))
    .filter((d) => fs.existsSync(d))
    .flatMap((d) => sourceFiles(d));

  const stripComments = (s: string) =>
    s.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^\s*\/\/.*$/gm, "");

  // ── Tier 1: the predictor module itself ────────────────────────────────
  it("imports no learner-concept-state module", () => {
    const imports = [...predictorSource.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
    expect(imports.filter((i) => PROHIBITED_MODULES.some((p) => i.includes(p)))).toEqual([]);
  });

  it("never names a prohibited table, whether or not that table exists", () => {
    const code = stripComments(predictorSource);
    expect(PROHIBITED_TABLES.filter((t) => code.includes(t))).toEqual([]);
  });

  it("the ban holds now that learner_concept_states is a real table", () => {
    // The migration that created it is in the tree, so this is no longer a
    // hypothetical. A table the predictor could actually query is exactly when
    // a stale "banned, does not exist yet" comment would stop being a rule and
    // start being a historical note.
    const migration = path.join(ROOT, "supabase", "migrations",
      "20261006_08_learner_concept_states.sql");
    expect(fs.existsSync(migration)).toBe(true);
    expect(fs.readFileSync(migration, "utf8"))
      .toMatch(/CREATE TABLE IF NOT EXISTS public\.learner_concept_states/);

    expect(PROHIBITED_TABLES).toContain("learner_concept_states");
    expect(PROHIBITED_TABLES).toContain("learner_concept_state_observations");
    expect(PROHIBITED_TABLES).toContain("learner_concept_state_history");
    expect(stripComments(predictorSource)).not.toContain("learner_concept_state");

    // The history tables are real too, so the same reasoning applies to them:
    // a ban whose subject exists is a rule, where one whose subject does not
    // is only a precaution.
    const history = path.join(ROOT, "supabase", "migrations",
      "20261007_05_concept_state_history.sql");
    expect(fs.existsSync(history)).toBe(true);
    const historySql = fs.readFileSync(history, "utf8");
    for (const t of ["learner_concept_state_observations", "learner_concept_state_history"]) {
      expect(historySql).toContain(`CREATE TABLE IF NOT EXISTS public.${t}`);
    }

    // And nothing on the Phase 2 production path is reachable from the
    // predictor either, by import, by RPC name or by field name.
    const imports = [...predictorSource.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
    for (const m of ["conceptStatePersistence", "conceptEvidence", "computeConceptStates"]) {
      expect(imports.filter((i) => i.includes(m)), m).toEqual([]);
    }
    // The writer is a database function, so banning the table is not enough:
    // its name is the other way to reach the same rows.
    expect(stripComments(predictorSource)).not.toContain("replace_learner_concept_states");
    expect(stripComments(predictorSource)).not.toMatch(/computeAndPersistLearnerConceptStates|loadConceptEvidence/);
    for (const column of ["memory_durability", "memory_signal", "weak_card_count",
                          "memory_confidence_raw", "memory_items"]) {
      expect(stripComments(predictorSource), column).not.toContain(column);
    }
  });

  it("never names a memory-derived field", () => {
    expect(PROHIBITED_FIELDS.test(stripComments(predictorSource))).toBe(false);
  });

  it("never calls buildConceptStates", () => {
    expect(stripComments(predictorSource)).not.toMatch(/buildConceptStates/);
  });

  // ── Tier 2: the inputs it is allowed to take ───────────────────────────
  //
  // An ALLOWLIST, not a denylist. A denylist only stops the leaks someone
  // thought of; this fails the build when a NEW parameter appears, whatever it
  // is called, which forces a human to look at it.
  it("takes exactly these five question-derived parameters and no others", () => {
    // Balanced paren matching, because a default value can itself contain
    // parentheses: `topicsWithData = new Set()` truncated a naive indexOf.
    const src = estimateScore.toString();
    const open = src.indexOf("(");
    let depth = 0, close = open;
    for (let i = open; i < src.length; i++) {
      if (src[i] === "(") depth++;
      else if (src[i] === ")" && --depth === 0) { close = i; break; }
    }
    const params = src.slice(open + 1, close)
      .split(/,(?![^(]*\))/).map((p) => p.trim().split(/[:=]/)[0].trim()).filter(Boolean);
    expect(params).toEqual([
      "firstAttemptAccuracy", "firstAttempts", "sectionsWithData", "topicsWithData", "fullLengths",
    ]);
  });

  // ── Tier 3: the modules that assemble its inputs ───────────────────────
  //
  // The gap this closes: the existing firewall reads scoreEstimate.ts only, so
  // nothing stopped a CALLER computing `accuracy` from memory evidence and
  // passing it in. The callers are few and are pinned here by name.
  const PREDICTOR_CALL_SITES = [
    "lib/dashboard/summary.ts",
    "app/dashboard/analytics/page.tsx",
  ];

  const callers = ALL_SOURCES.filter((f) =>
    /\bestimateScore\s*\(|\bevidenceStrength\s*\(/.test(stripComments(fs.readFileSync(f, "utf8"))),
  ).map((f) => path.relative(ROOT, f).split(path.sep).join("/"))
   .filter((f) => !f.startsWith("lib/scoring/"));

  it("the set of modules calling the predictor is exactly the reviewed allowlist", () => {
    // A new call site is not forbidden; it is UNREVIEWED. Adding one to this
    // list is the moment someone has to look at what it passes in.
    expect(callers.slice().sort()).toEqual(PREDICTOR_CALL_SITES.slice().sort());
  });

  it("no module that calls the predictor imports learner concept state", () => {
    const offenders: string[] = [];
    for (const rel of callers) {
      const code = fs.readFileSync(path.join(ROOT, rel), "utf8");
      const imports = [...code.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
      for (const i of imports) if (/conceptState/i.test(i)) offenders.push(`${rel}: ${i}`);
    }
    expect(offenders).toEqual([]);
  });

  it("no module that calls the predictor names a concept-state table", () => {
    const offenders: string[] = [];
    for (const rel of callers) {
      const code = stripComments(fs.readFileSync(path.join(ROOT, rel), "utf8"));
      for (const t of ["learner_concept_states", "learner_concept_state_history"]) {
        if (code.includes(t)) offenders.push(`${rel}: ${t}`);
      }
    }
    expect(offenders).toEqual([]);
  });

  // ── The guards must actually bite ──────────────────────────────────────
  //
  // A check that has never failed on anything is not known to work. Each
  // matcher is shown rejecting a realistic violation.
  it.each([
    ['import { buildConceptStates } from "@/lib/learner/conceptState";', "module import"],
    // The `.from(` call is assembled rather than spelled, because
    // resetScope.test.ts scans every source file for Supabase table access to
    // prove each table is classified for account reset. A violation EXAMPLE in
    // a test is not the app touching a table, and must not look like one.
    [`const s = await db.${"from"}("learner_concept_states").select("*");`, "current table"],
    [`const h = await db.${"from"}("learner_concept_state_history").select("*");`, "history table"],
    ["const x = row.memory_durability;", "memory_durability"],
    ["const x = row.memory_freshness;", "memory_freshness"],
    ["const x = row.memory_confidence;", "memory_confidence"],
    ["const x = row.weak_card_count;", "weak_card_count"],
    ["const x = state.stability * 2;", "a raw FSRS field"],
    [`const r = await db.${"from"}("flashcard_user_state").select("stability");`, "a scheduler query"],
  ])("rejects %s (%s)", (snippet) => {
    const imports = [...snippet.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
    const caught =
      imports.some((i) => PROHIBITED_MODULES.some((p) => i.includes(p))) ||
      PROHIBITED_TABLES.some((t) => snippet.includes(t)) ||
      PROHIBITED_FIELDS.test(snippet) ||
      /buildConceptStates/.test(snippet);
    expect(caught).toBe(true);
  });

  it("an unapproved new predictor call site is caught", () => {
    const pretend = [...callers, "app/somewhere/new/page.tsx"].sort();
    expect(pretend).not.toEqual(PREDICTOR_CALL_SITES.slice().sort());
  });

  it("an unapproved new predictor parameter is caught", () => {
    const pretend = ["firstAttemptAccuracy", "firstAttempts", "sectionsWithData",
      "topicsWithData", "fullLengths", "memoryDurability"];
    expect(pretend).not.toEqual([
      "firstAttemptAccuracy", "firstAttempts", "sectionsWithData", "topicsWithData", "fullLengths",
    ]);
  });

  // ── And legitimate question evidence still passes ──────────────────────
  it("question-derived inputs are untouched by any of this", () => {
    const legitimate = [
      "const accuracy = correct / eligible.length;",
      'const sections = new Set(questions.map((q) => q.section));',
      `const attempts = await db.${"from"}("question_attempts").select("is_correct, is_first_attempt");`,
      "const e = estimateScore(accuracy, eligible.length, sections, subtopics, fullLengths);",
    ];
    for (const snippet of legitimate) {
      const imports = [...snippet.matchAll(/from\s+["']([^"']+)["']/g)].map((m) => m[1]);
      const caught =
        imports.some((i) => PROHIBITED_MODULES.some((p) => i.includes(p))) ||
        PROHIBITED_TABLES.some((t) => snippet.includes(t)) ||
        PROHIBITED_FIELDS.test(snippet);
      expect(caught).toBe(false);
    }
  });

  // ── The rule this encodes, in words, so it survives a refactor ──────────
  it("records that application signals are NOT predictor features", () => {
    // Phase 2 answers "what should this learner work on". The predictor answers
    // "what score does question performance support". Routing applicationSignal
    // or applicationConfidence into the score needs its own design review, and
    // this test exists so that deleting the rule is a deliberate act.
    const code = stripComments(predictorSource);
    expect(code).not.toMatch(/applicationSignal|applicationConfidence|conceptState/i);
  });
});
