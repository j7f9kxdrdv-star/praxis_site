// ─── Guardrails the judge cannot talk its way past ────────────────────────────
//
// SPLIT OF LABOUR. The model judges meaning: whether visible words hand over a
// hidden answer. This file judges MECHANICS: what the renderer will do with a
// proposed rewrite. Mechanics are decidable, so they are decided here, in code,
// where no amount of confident prose can override them.
//
// The rule that matters most: a rewrite may not take two answers that are
// currently hidden TOGETHER and put one of them back on screen while the other
// stays blank. That transformation has a name in this codebase — it is how the
// pulmonary / systemic card and the dispositional / situational card came to
// leak — and the old judge recommended it 37 times in one organic chemistry
// run. checkRewriteSafety refuses it outright, so the tool is structurally
// incapable of proposing the defect it was built to find.

import { countClozeGroups, clozeToPlain, validateClozeText, findClozes } from "./cloze";
import {
  BLANK_TOKEN,
  expandStudyVariants,
  coMaskedPairs,
  normalizeAnswer,
  containsWord,
  pairKey,
  type StudyVariant,
} from "./studyVariants";

/** Why a rendered study card gives its answer away. */
export type LeakType =
  // proven in code
  | "NOTHING_MASKED"
  | "VERBATIM_ANSWER_VISIBLE"
  // judged by the model
  | "COMPLEMENTARY_PAIR_VISIBLE"
  | "SYNONYM_VISIBLE"
  | "PARENTHETICAL_REVEAL"
  | "DEFINITION_REVEAL"
  | "CONTEXT_TRIVIALLY_REVEALS_ANSWER"
  | "OTHER_CONFIRMED_CUE";

export const CODE_PROVEN_LEAK_TYPES: LeakType[] = [
  "NOTHING_MASKED",
  "VERBATIM_ANSWER_VISIBLE",
];

export interface StructuralFinding {
  activeGroup: number;
  leakType: LeakType;
  explanation: string;
}

/**
 * The leaks that need no judgement at all.
 *
 * Both are things a model should never have been asked about: whether a blank
 * exists, and whether a string of letters appears twice. Deciding them here
 * means they are found on every card for free, and found identically on every
 * run.
 */
export function structuralFindings(
  clozeText: string,
  clozeCount?: number,
): StructuralFinding[] {
  const out: StructuralFinding[] = [];
  for (const v of expandStudyVariants(clozeText, clozeCount)) {
    if (v.masksNothing) {
      out.push({
        activeGroup: v.activeGroup,
        leakType: "NOTHING_MASKED",
        explanation:
          `Study item ${v.activeGroup} masks nothing: the card has no c${v.activeGroup} blank, ` +
          `so the student is shown the whole card with every answer in place.`,
      });
      continue;
    }
    for (const exposed of visibleVerbatim(v)) {
      out.push({
        activeGroup: v.activeGroup,
        leakType: "VERBATIM_ANSWER_VISIBLE",
        explanation: `Studying c${v.activeGroup} hides "${exposed}", but the same word is printed elsewhere on the same card.`,
      });
    }
  }
  return out;
}

/** Hidden answers of this variant that are also printed, in full, on it. */
export function visibleVerbatim(v: StudyVariant): string[] {
  const seen = new Set<string>();
  const out: string[] = [];
  for (const answer of v.hiddenAnswers) {
    const key = normalizeAnswer(answer);
    if (seen.has(key)) continue;
    if (containsWord(v.prompt, answer)) {
      seen.add(key);
      out.push(answer);
    }
  }
  return out;
}

// ─── Candidates for the model to look at ─────────────────────────────────────
//
// Not verdicts. A blank with a parenthetical glued to it is the shape of the
// two leaks that have actually shipped ("{{c2::one joule per second}} (1 W =
// 1 J/s)", "{{c1::downfield}} (higher chemical shift)"), but the same shape is
// also perfectly innocent ("{{c1::insulin}} (a peptide hormone)"). Code can
// find the shape cheaply and reliably; only the model can say which one it is.
// Handing these over as candidates raises recall without spending precision.

/** Blanks with a parenthetical immediately after them, on this rendered card. */
export function adjacentParentheticals(v: StudyVariant): string[] {
  const out: string[] = [];
  const token = BLANK_TOKEN.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const re = new RegExp(`${token}\\s*\\(([^()]{1,120})\\)`, "g");
  let m: RegExpExecArray | null;
  while ((m = re.exec(v.prompt)) !== null) out.push(m[1].trim());
  return out;
}

export interface CardStructure {
  variants: StudyVariant[];
  findings: StructuralFinding[];
  /** Parenthetical text sitting next to a blank, keyed by study item. */
  candidates: { activeGroup: number; parentheticals: string[] }[];
  groupCount: number;
}

/**
 * Everything about a card that can be decided without a model.
 *
 * Pure, so the same card gives the same structure on every run. The audit keys
 * its cache off this plus the card text, which is what makes a rerun over an
 * unchanged deck reproduce its previous classifications exactly.
 */
export function auditCardStructure(clozeText: string, clozeCount?: number): CardStructure {
  const variants = expandStudyVariants(clozeText, clozeCount);
  return {
    variants,
    findings: structuralFindings(clozeText, clozeCount),
    candidates: variants
      .map((v) => ({ activeGroup: v.activeGroup, parentheticals: adjacentParentheticals(v) }))
      .filter((c) => c.parentheticals.length > 0),
    groupCount: countClozeGroups(clozeText),
  };
}

// ─── Rewrite classification ───────────────────────────────────────────────────

export type RewriteKind =
  | "NO_CHANGE"
  | "MERGE_GROUPS"
  | "SPLIT_GROUPS"
  | "REGROUP_SAME_COUNT"
  | "REWORD"
  | "MIXED";

/** The grouping structure, ignoring which numbers were used. */
function partition(text: string): Set<string> {
  const byGroup = new Map<number, string[]>();
  for (const m of findClozes(text)) {
    const list = byGroup.get(m.groupIndex) ?? [];
    list.push(normalizeAnswer(m.answer));
    byGroup.set(m.groupIndex, list);
  }
  return new Set(
    Array.from(byGroup.values()).map((answers) => answers.slice().sort().join(" + ")),
  );
}

function sameSet(a: Set<string>, b: Set<string>): boolean {
  if (a.size !== b.size) return false;
  for (const v of a) if (!b.has(v)) return false;
  return true;
}

const flatProse = (text: string) => clozeToPlain(text).replace(/\s+/g, " ").trim();

/**
 * What the proposal actually does, read off the two texts.
 *
 * Derived rather than taken from the model's own label. A judge that
 * mislabelled its rewrite would otherwise slip a split through under the word
 * "merge", and the label is what decides whether it can be surfaced.
 */
export function classifyRewrite(original: string, proposed: string): RewriteKind {
  const proseSame = flatProse(original) === flatProse(proposed);
  const partSame = sameSet(partition(original), partition(proposed));
  if (proseSame && partSame) return "NO_CHANGE";
  if (proseSame && !partSame) {
    const delta = countClozeGroups(proposed) - countClozeGroups(original);
    if (delta < 0) return "MERGE_GROUPS";
    if (delta > 0) return "SPLIT_GROUPS";
    return "REGROUP_SAME_COUNT";
  }
  if (!proseSame && partSame) return "REWORD";
  return "MIXED";
}

// ─── Safety ───────────────────────────────────────────────────────────────────

export type SafetyCode =
  | "INVALID_CLOZE"
  | "NOTHING_MASKED"
  | "BREAKS_CO_MASKED_PAIR"
  | "NEW_VERBATIM_EXPOSURE"
  | "DROPS_TESTED_ANSWER";

export interface SafetyViolation {
  code: SafetyCode;
  detail: string;
}

export interface SafetyReport {
  safe: boolean;
  kind: RewriteKind;
  violations: SafetyViolation[];
}

/**
 * Render every study card the proposal would produce, and refuse it if any of
 * them is worse than what we have.
 *
 * The proposal is evaluated with cloze_count set to its own group count,
 * because that is what the UPDATE would write and what the session queue would
 * then walk. A rewrite that leaves a gap in the numbering (c1, c3) therefore
 * shows up here as an item that masks nothing, which is exactly how it would
 * behave for a student.
 */
export function checkRewriteSafety(
  original: string,
  proposed: string,
  originalClozeCount?: number,
): SafetyReport {
  const kind = classifyRewrite(original, proposed);
  const violations: SafetyViolation[] = [];

  const validation = validateClozeText(proposed);
  if (!validation.valid) {
    return {
      safe: false,
      kind,
      violations: [{ code: "INVALID_CLOZE", detail: validation.errors.join("; ") }],
    };
  }

  const proposedVariants = expandStudyVariants(proposed, countClozeGroups(proposed));
  const originalVariants = expandStudyVariants(original, originalClozeCount);

  for (const v of proposedVariants) {
    if (v.masksNothing) {
      violations.push({
        code: "NOTHING_MASKED",
        detail: `The rewrite produces a study item (c${v.activeGroup}) with no blank on it.`,
      });
    }
  }

  // An answer masked together with another may not be separated from it.
  const wasCoMasked = coMaskedPairs(original, originalClozeCount);
  if (wasCoMasked.size) {
    for (const v of proposedVariants) {
      const hidden = new Set(v.hiddenAnswers.map(normalizeAnswer));
      const visible = new Set(v.visibleAnswers.map(normalizeAnswer));
      for (const pair of wasCoMasked) {
        const [a, b] = pair.split(" || ");
        const broken =
          (hidden.has(a) && visible.has(b)) || (hidden.has(b) && visible.has(a));
        if (broken) {
          violations.push({
            code: "BREAKS_CO_MASKED_PAIR",
            detail:
              `"${a}" and "${b}" are hidden together today. The rewrite shows one of them ` +
              `while the other is blank on study item c${v.activeGroup}, which is the ` +
              `complementary-pair leak this audit exists to remove.`,
          });
        }
      }
    }
  }

  // No answer may become readable on its own card that was not readable before.
  const before = new Set<string>();
  for (const v of originalVariants) for (const a of visibleVerbatim(v)) before.add(normalizeAnswer(a));
  for (const v of proposedVariants) {
    for (const a of visibleVerbatim(v)) {
      if (!before.has(normalizeAnswer(a))) {
        violations.push({
          code: "NEW_VERBATIM_EXPOSURE",
          detail: `After the rewrite, study item c${v.activeGroup} hides "${a}" while printing the same word elsewhere.`,
        });
      }
    }
  }

  // The tested fact has to survive.
  //
  // ABSORBED IS NOT DROPPED. The canonical fix for a revealing parenthetical is
  // to pull it inside the blank it gives away: "{{c2::opposite spins}} (one
  // +1/2 and one -1/2)" becomes "{{c2::opposite spins (one +1/2 and one
  // -1/2)}}". The answer string changes, but the fact is still tested and now
  // the gloss is hidden with it. A naive set difference calls that a dropped
  // answer and rejects the single most common good rewrite, so an answer counts
  // as surviving when it still sits, whole, inside one of the new answers.
  const testedBefore = findClozes(original).map((m) => normalizeAnswer(m.answer));
  const testedAfter = findClozes(proposed).map((m) => normalizeAnswer(m.answer));
  for (const a of new Set(testedBefore)) {
    const survives = testedAfter.some((b) => b === a || containsWord(b, a));
    if (!survives) {
      violations.push({
        code: "DROPS_TESTED_ANSWER",
        detail: `"${a}" is tested today and is no longer a blank after the rewrite.`,
      });
    }
  }

  return { safe: violations.length === 0, kind, violations };
}

// --- Reading a rewrite the model sent back ----------------------------------

/**
 * Turn whatever arrived in proposedRewrite into a rewrite, or nothing.
 *
 * Seen on the very first live run: a judge with nothing to propose filled the
 * field with the two-character string `""` instead of leaving it empty. That
 * went through the safety check, came back INVALID_CLOZE, and was reported as a
 * withheld rewrite on a card nobody had suggested changing. A model is allowed
 * to be sloppy in a free-text field; the audit is not allowed to act on it.
 */
export function sanitizeRewrite(raw: string | null | undefined, original: string): string | null {
  if (!raw) return null;
  let text = raw.trim();
  // Strip one layer of wrapping quotes, then re-trim.
  if (text.length >= 2 && /^["'`]/.test(text) && text.at(-1) === text[0]) {
    text = text.slice(1, -1).trim();
  }
  if (!text) return null;
  if (findClozes(text).length === 0) return null;
  if (text === original.trim()) return null;
  return text;
}

// ─── What gets surfaced ───────────────────────────────────────────────────────

export type OverallStatus = "SAFE" | "LEAK_CONFIRMED" | "NEEDS_HUMAN_REVIEW";
export type RecommendedAction = "NONE" | "MERGE_GROUPS" | "REWORD" | "HUMAN_REVIEW";

export interface Decision {
  overallStatus: OverallStatus;
  recommendedAction: RecommendedAction;
  /** False when a rewrite existed but was withheld; notes say why. */
  surfaceRewrite: boolean;
  notes: string[];
}

/**
 * Turn a verdict plus a safety report into something a human can act on.
 *
 * SPLIT NEVER AUTO-SURFACES. Even a split that passes every mechanical check
 * goes to human review, because the remaining question — does each half still
 * test something on its own — is pedagogical, and this tool has no standing to
 * answer it. Deliberately asymmetric: merges that pass go straight through.
 */
export function decideAction(
  leakFound: boolean,
  proposedRewrite: string | null,
  safety: SafetyReport | null,
): Decision {
  const notes: string[] = [];
  if (!leakFound) {
    return { overallStatus: "SAFE", recommendedAction: "NONE", surfaceRewrite: false, notes };
  }
  if (!proposedRewrite || !safety) {
    notes.push("Leak reported with no rewrite attached.");
    return {
      overallStatus: "NEEDS_HUMAN_REVIEW",
      recommendedAction: "HUMAN_REVIEW",
      surfaceRewrite: false,
      notes,
    };
  }
  if (!safety.safe) {
    for (const v of safety.violations) notes.push(`${v.code}: ${v.detail}`);
    notes.push("Rewrite withheld. The leak may still be real; a human decides the fix.");
    return {
      overallStatus: "NEEDS_HUMAN_REVIEW",
      recommendedAction: "HUMAN_REVIEW",
      surfaceRewrite: false,
      notes,
    };
  }
  switch (safety.kind) {
    case "MERGE_GROUPS":
      return {
        overallStatus: "LEAK_CONFIRMED",
        recommendedAction: "MERGE_GROUPS",
        surfaceRewrite: true,
        notes,
      };
    case "REWORD":
      return {
        overallStatus: "LEAK_CONFIRMED",
        recommendedAction: "REWORD",
        surfaceRewrite: true,
        notes,
      };
    case "SPLIT_GROUPS":
      notes.push(
        "Rewrite splits one group into more. Mechanically clean, but whether each half " +
          "still tests something on its own is a teaching question, not a rendering one.",
      );
      return {
        overallStatus: "NEEDS_HUMAN_REVIEW",
        recommendedAction: "HUMAN_REVIEW",
        surfaceRewrite: true,
        notes,
      };
    case "NO_CHANGE":
      notes.push("Leak reported but the rewrite is identical to the current card.");
      return {
        overallStatus: "NEEDS_HUMAN_REVIEW",
        recommendedAction: "HUMAN_REVIEW",
        surfaceRewrite: false,
        notes,
      };
    default:
      notes.push(
        `Rewrite changes wording and grouping at once (${safety.kind}); read both before applying.`,
      );
      return {
        overallStatus: "NEEDS_HUMAN_REVIEW",
        recommendedAction: "HUMAN_REVIEW",
        surfaceRewrite: true,
        notes,
      };
  }
}

export { pairKey };
