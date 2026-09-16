#!/usr/bin/env node
/**
 * Old judge vs corrected audit, on the same cards.
 *
 *   npx vite-node scripts/flashcards/leak-audit-compare.ts \
 *     --old <dir of old flashcard-leak-report.json files> \
 *     --new flashcard-leak-audit-organic_chemistry.json
 *
 * Changing a judge is a behaviour change, and the only honest way to describe
 * one is to run both over the same cards and read the difference. This does
 * that, and it takes the old tool's own suggestions and puts each one through
 * the renderer-aware safety check, so "37 of its fixes would have created a
 * leak" is a measurement rather than a recollection.
 *
 * Reads only. Writes nothing to the database.
 */
import fs from "node:fs";
import path from "node:path";
import { classifyRewrite, checkRewriteSafety, sanitizeRewrite } from "../../lib/flashcards/leakSafety";
import { coMaskedPairs, renumberContiguous } from "../../lib/flashcards/studyVariants";

const arg = (f: string) => {
  const i = process.argv.indexOf(f);
  return i > -1 ? process.argv[i + 1] : null;
};
const OLD_DIR = arg("--old");
const NEW_FILE = arg("--new");
const OUT = arg("--out");
if (!OLD_DIR || !NEW_FILE) {
  console.error(
    "Usage: npx vite-node scripts/flashcards/leak-audit-compare.ts --old <dir> --new <file.json>",
  );
  process.exit(2);
}

interface OldLeak {
  id: string;
  deck: string;
  orig: string;
  leak: boolean;
  groups: number[];
  why: string;
  suggestion: string;
}

// The old judge wrote only its FLAGS, one file per deck, clobbering the same
// filename each run. That is why last night's whole-section output no longer
// exists and this baseline had to be re-run.
const oldFlags: OldLeak[] = [];
for (const f of fs.readdirSync(OLD_DIR).filter((n) => n.endsWith(".json"))) {
  const parsed = JSON.parse(fs.readFileSync(path.join(OLD_DIR, f), "utf8"));
  for (const l of parsed.leaks ?? []) if (l.leak) oldFlags.push(l);
}

/** Only the fields this comparison reads; the audit row carries far more. */
interface NewRow {
  cardId: string;
  overallStatus: string;
  recommendedAction: string;
}

const newReport = JSON.parse(fs.readFileSync(NEW_FILE, "utf8"));
const newRows: NewRow[] = newReport.rows;
const newById = new Map(newRows.map((r) => [r.cardId, r]));

// --- What the old tool actually proposed --------------------------------------

type OldKind = "MERGE" | "SPLIT" | "REWORD" | "REGROUP" | "NONE" | "UNUSABLE";
type SplitVerdict = "CREATES A LEAK" | "NO EFFECT" | "FIXES A LEAK";
type MergeVerdict = "CONFIRMED MERGE" | "NOT NEEDED" | "HUMAN REVIEW" | "UNDECIDED (semantic pass not run)";

const classified = oldFlags.map((l) => {
  const raw = sanitizeRewrite(l.suggestion, l.orig);
  if (!raw) return { ...l, kind: "NONE" as OldKind, safe: null, safeAsWritten: null, violations: [] as string[] };
  // Judged twice: as the old tool wrote it, and with the numbering gap closed.
  // The second is the fair test of the idea behind the suggestion.
  const suggestion = renumberContiguous(raw);
  const kind = classifyRewrite(l.orig, suggestion);
  const safety = checkRewriteSafety(l.orig, suggestion);
  const safeAsWritten = checkRewriteSafety(l.orig, raw).safe;
  const mapped: OldKind =
    kind === "MERGE_GROUPS"
      ? "MERGE"
      : kind === "SPLIT_GROUPS"
        ? "SPLIT"
        : kind === "REWORD"
          ? "REWORD"
          : kind === "NO_CHANGE"
            ? "NONE"
            : "REGROUP";
  return {
    ...l,
    suggestion,
    kind: mapped,
    safe: safety.safe,
    safeAsWritten,
    violations: safety.violations.map((v) => v.code),
  };
});

const oldSplits = classified.filter((c) => c.kind === "SPLIT");
const oldMerges = classified.filter((c) => c.kind === "MERGE");
const oldRewords = classified.filter((c) => c.kind === "REWORD" || c.kind === "REGROUP");

function splitVerdict(c: (typeof classified)[number]): SplitVerdict {
  if (c.violations.includes("BREAKS_CO_MASKED_PAIR") || c.violations.includes("NEW_VERBATIM_EXPOSURE")) {
    return "CREATES A LEAK";
  }
  const row = newById.get(c.id);
  if (row && row.overallStatus === "LEAK_CONFIRMED") return "FIXES A LEAK";
  return "NO EFFECT";
}

const SEMANTIC_PASS_RAN = !newReport.summary.structureOnly;

function mergeVerdict(c: (typeof classified)[number]): MergeVerdict {
  const row = newById.get(c.id);
  if (!row) return "HUMAN REVIEW";
  // A structural pass calling a card SAFE means only that code found nothing.
  // Reporting that as "merge not needed" would be claiming a judgement nobody
  // made.
  if (row.overallStatus === "SAFE" && !SEMANTIC_PASS_RAN) {
    return "UNDECIDED (semantic pass not run)";
  }
  if (row.overallStatus === "SAFE") return "NOT NEEDED";
  if (row.overallStatus === "LEAK_CONFIRMED" && row.recommendedAction === "MERGE_GROUPS" && c.safe) {
    return "CONFIRMED MERGE";
  }
  return "HUMAN REVIEW";
}

// --- Numbers ------------------------------------------------------------------

const flaggedOld = new Set(oldFlags.map((l) => l.id));
const flaggedNew = new Set(
  newRows.filter((r) => r.overallStatus !== "SAFE").map((r) => r.cardId),
);
const disappeared = [...flaggedOld].filter((id) => !flaggedNew.has(id));
const brandNew = [...flaggedNew].filter((id) => !flaggedOld.has(id));

const tally = <T extends string>(items: T[]) => {
  const out: Record<string, number> = {};
  for (const i of items) out[i] = (out[i] || 0) + 1;
  return out;
};

const report = {
  oldJudge: {
    cardsFlagged: flaggedOld.size,
    // The claim that started this: how many flagged cards were ALREADY using
    // one shared group, and so cannot leak the way the old judge described.
    flaggedCardsAlreadySharingAGroup: [...new Map(oldFlags.map((l) => [l.id, l])).values()].filter(
      (l) => coMaskedPairs(l.orig).size > 0,
    ).length,
    suggestionsWithARewrite: classified.filter((c) => c.kind !== "NONE").length,
    byKind: tally(classified.map((c) => c.kind)),
    unsafeAsWritten: classified.filter((c) => c.safeAsWritten === false).length,
    unsafeEvenAfterClosingNumberingGaps: classified.filter((c) => c.safe === false).length,
  },
  newAudit: { ...newReport.summary.totals, structureOnly: !!newReport.summary.structureOnly },
  leaksByType: newReport.summary.leaksByType,
  movement: {
    previousFlagsThatDisappeared: disappeared.length,
    previousFlagsStillFlagged: flaggedOld.size - disappeared.length,
    leaksTheOldJudgeMissed: brandNew.length,
  },
  oldSplitSuggestions: {
    total: oldSplits.length,
    verdicts: tally(oldSplits.map(splitVerdict)),
  },
  oldMergeSuggestions: {
    total: oldMerges.length,
    verdicts: tally(oldMerges.map(mergeVerdict)),
  },
  oldRewordSuggestions: { total: oldRewords.length },
  byDeck: newReport.summary.byDeck,
};

console.log(JSON.stringify(report, null, 1));

if (OUT) {
  fs.writeFileSync(
    OUT,
    JSON.stringify(
      {
        report,
        oldSplitDetail: oldSplits.map((c) => ({
          id: c.id,
          deck: c.deck,
          verdict: splitVerdict(c),
          violations: c.violations,
          orig: c.orig,
          suggestion: c.suggestion,
          why: c.why,
        })),
        oldMergeDetail: oldMerges.map((c) => ({
          id: c.id,
          deck: c.deck,
          verdict: mergeVerdict(c),
          safe: c.safe,
          violations: c.violations,
          orig: c.orig,
          suggestion: c.suggestion,
          why: c.why,
        })),
        disappeared,
        brandNew,
      },
      null,
      1,
    ),
  );
  console.error(`detail written to ${OUT}`);
}
