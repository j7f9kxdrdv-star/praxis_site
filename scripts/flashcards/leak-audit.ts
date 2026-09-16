#!/usr/bin/env node
/**
 * Flashcard leak audit - judges the study cards a student actually sees.
 *
 *   npx vite-node scripts/flashcards/leak-audit.ts --section organic_chemistry
 *   npx vite-node scripts/flashcards/leak-audit.ts "Spectroscopy"
 *   npx vite-node scripts/flashcards/leak-audit.ts --deck-id <uuid> --no-refute
 *
 * WHY THIS REPLACED flashcard-leak-judge.mjs. The old judge read the cloze
 * SOURCE and reasoned as though each {{cN::...}} token could be hidden on its
 * own. The renderer masks by GROUP: every blank carrying the active number goes
 * blank together. On 425 organic chemistry cards that mistake produced 153
 * flags, 84 of them on cards already using one shared group, cards that cannot
 * leak the way it described, and 37 recommendations to SPLIT a shared group,
 * which is precisely how the pulmonary / systemic card came to give itself
 * away. A tool that manufactures the defect it hunts is worse than no tool.
 *
 * So the audit is built the other way round now:
 *
 *   SOURCE -> render every study variant (with the production renderer)
 *          -> decide the mechanical questions in code
 *          -> ask the model only about meaning, on the rendered text
 *          -> simulate any rewrite it proposes and refuse the unsafe ones
 *
 * It never edits a card. The output is a review queue.
 *
 * Env (.env.local): NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, ANTHROPIC_API_KEY
 */
import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { createClient } from "@supabase/supabase-js";
import Anthropic from "@anthropic-ai/sdk";
import { BULK_JUDGE_MODEL } from "../../lib/ai/models";
import { expandStudyVariants, renumberContiguous, BLANK_TOKEN } from "../../lib/flashcards/studyVariants";
import {
  auditCardStructure,
  checkRewriteSafety,
  decideAction,
  sanitizeRewrite,
  type LeakType,
  type OverallStatus,
  type RecommendedAction,
  type SafetyReport,
} from "../../lib/flashcards/leakSafety";

/** Bump when the prompt or the rules change: it is part of the cache key. */
const PROMPT_VERSION = "2026-09-15-render-first";

// --- Env ---------------------------------------------------------------------

const env = Object.fromEntries(
  fs
    .readFileSync(path.join(process.cwd(), ".env.local"), "utf8")
    .split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => {
      const i = l.indexOf("=");
      return [l.slice(0, i).trim(), l.slice(i + 1).trim().replace(/^["']|["']$/g, "")];
    }),
);
const sb = createClient(env.NEXT_PUBLIC_SUPABASE_URL!, env.SUPABASE_SERVICE_ROLE_KEY!);
const anthropic = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });
const MODEL = env.LEAK_JUDGE_MODEL || BULK_JUDGE_MODEL;

// --- Args --------------------------------------------------------------------

const argv = process.argv.slice(2);
const VALUE_FLAGS = ["--deck-id", "--section", "--out", "--limit", "--concurrency"];
const flag = (name: string) => argv.includes(name);
const value = (name: string) => (argv.includes(name) ? argv[argv.indexOf(name) + 1] : null);

const deckIdArg = value("--deck-id");
const sectionArg = value("--section");
const outArg = value("--out");
const limitArg = Number(value("--limit") || 0);
const CONCURRENCY = Number(value("--concurrency") || env.LEAK_JUDGE_CONCURRENCY || 6);
const REFUTE = !flag("--no-refute");
/**
 * Skip the model entirely and report only what code can prove.
 *
 * Free, instant, and the half of the audit that never needs a judgement call:
 * a study item with no blank on it, and an answer printed beside the blank that
 * hides it. Worth running on its own before spending anything on the semantic
 * pass, and the only mode available when the API is not.
 */
const STRUCTURE_ONLY = flag("--structure-only");
const USE_CACHE = !flag("--no-cache");
const titleArg =
  argv.find((a, i) => !a.startsWith("--") && !VALUE_FLAGS.includes(argv[i - 1])) || null;

if (!deckIdArg && !sectionArg && !titleArg) {
  console.error(
    'Usage: npx vite-node scripts/flashcards/leak-audit.ts "<deck title>" | --deck-id <uuid> | --section <section>',
  );
  process.exit(2);
}

const CACHE_DIR = path.join(process.cwd(), "node_modules", ".cache", "leak-audit");

// --- The rules the model is given --------------------------------------------
//
// The first three paragraphs are the ones the old prompt lacked. Everything
// that went wrong on the organic chemistry run traces back to their absence.

const SYSTEM = `You audit MCAT cloze flashcards for ANSWER LEAKS. You are shown the RENDERED study cards a student actually sees. Judge those, never the markup.

HOW THE RENDERER WORKS. A written card contains blanks written {{cN::answer}}. Studying group N produces ONE study card on which EVERY blank carrying the number N is hidden simultaneously, and every blank carrying a different number is printed as its answer text.

Therefore: two blanks that share a number are hidden TOGETHER. A repeated cloze number is NOT a defect and is frequently the correct design for a pair of terms that should be recalled together.

NEVER reason about a state where one instance of the active group is visible and another instance of that same active group is hidden. The product cannot render that state. If you find yourself describing one, you have misread the card.

WHAT COUNTS AS A LEAK. A leak is when text VISIBLE on the rendered study card makes a hidden answer trivially recoverable by a student who has not learned the material. Pick the reason code that fits:

  COMPLEMENTARY_PAIR_VISIBLE - the card names two members of a closed, defining pair or set, one is printed and the other is blank, and naming the visible one gives the hidden one away.
  SYNONYM_VISIBLE - a synonym or near-synonym of the hidden answer is printed on the same card.
  PARENTHETICAL_REVEAL - a parenthetical beside the blank restates the answer, in words, symbols or an abbreviation.
  DEFINITION_REVEAL - visible text defines the hidden term so directly that the term follows from it.
  CONTEXT_TRIVIALLY_REVEALS_ANSWER - the remaining wording admits only one possible answer without testing the intended knowledge.
  OTHER_CONFIRMED_CUE - a real cue that none of the above describes. Say exactly what it is.

STRICT BAR. Flag only when a student who had NEVER studied this topic could produce the EXACT hidden answer from the visible text alone. Being guessable by someone with partial knowledge is ordinary reasoning and is fine. Thematic relatedness is not a leak. Wording you would have written differently is not a leak. When unsure, it is not a leak. Never write a vague reason such as "possible leak"; quote the giveaway text.

NOT A LEAK, EXPLICITLY:
  . two related or opposing terms sharing one cloze number (they are hidden together);
  . three or more blanks on one number (all hidden together);
  . a blank whose box is as wide as the answer, which is how every blank is drawn;
  . a hint deliberately attached to a blank;
  . context that helps a student who knows the material recall it.

FIXING A LEAK. Prefer, in this order:
  1. MERGE - move the revealing term into the SAME cloze number as the answer so both hide together. Right when the two belong to one recalled pair and hiding both still tests the objective.
  2. REWORD - delete or move the revealing text (a synonym, a parenthetical gloss, a defining clause) and leave the cloze numbers alone. Right for synonyms and parentheticals, which are a wording problem, not a numbering one.
  3. HUMAN REVIEW - when the right fix depends on what the card is meant to teach rather than on how it renders.

SPLITTING IS ALMOST NEVER THE ANSWER. Do not propose moving blanks that currently share a number onto separate numbers. Doing that prints one answer while hiding the other, which CREATES a complementary-pair leak. Before proposing ANY change to cloze numbers, render each study card the rewrite would produce and check that no answer becomes visible beside a blank it gives away. A rewrite that fails that check is rejected automatically, so proposing it wastes the flag.

Never change the fact being tested. Never delete an answer. Keep the plain Unicode style: no LaTeX, no markdown, no em or en dashes.`;

const JUDGE_TOOL: Anthropic.Tool = {
  name: "report_card",
  description: "Report whether any rendered study card of this flashcard leaks its answer.",
  input_schema: {
    type: "object",
    properties: {
      leak: { type: "boolean", description: "true only if at least one rendered card leaks" },
      variants: {
        type: "array",
        description: "One entry per rendered study card you were shown, in the same order.",
        items: {
          type: "object",
          properties: {
            activeGroup: { type: "integer" },
            leakDetected: { type: "boolean" },
            leakType: {
              type: "string",
              enum: [
                "COMPLEMENTARY_PAIR_VISIBLE",
                "SYNONYM_VISIBLE",
                "PARENTHETICAL_REVEAL",
                "DEFINITION_REVEAL",
                "CONTEXT_TRIVIALLY_REVEALS_ANSWER",
                "OTHER_CONFIRMED_CUE",
                "NONE",
              ],
            },
            explanation: {
              type: "string",
              description: "One sentence quoting the giveaway text, or empty when there is no leak.",
            },
          },
          required: ["activeGroup", "leakDetected", "leakType", "explanation"],
        },
      },
      confidence: { type: "string", enum: ["high", "medium", "low"] },
      fixKind: {
        type: "string",
        enum: ["NONE", "MERGE", "REWORD", "HUMAN_REVIEW"],
        description: "What kind of fix you are proposing. MERGE and REWORD need proposedRewrite.",
      },
      proposedRewrite: {
        type: "string",
        description: "The full corrected cloze_text, or an empty string when you propose no change.",
      },
      rewriteRationale: { type: "string" },
    },
    required: ["leak", "variants", "confidence", "fixKind", "proposedRewrite", "rewriteRationale"],
  },
};

const REFUTE_SYSTEM = `You are the second reader on a flashcard audit. A first pass flagged this card as leaking its answer. Your job is to REFUTE the flag if it does not hold.

You are shown the rendered study card exactly as a student sees it. Remember that every blank sharing the active number is hidden at the same time; a pair of terms hidden together is correct design, not a leak.

Uphold the flag ONLY if a student who had never studied this topic could read the visible text and produce the exact hidden answer. If the visible text merely sets the topic, or names a related idea, or would help someone who already knows the material, the flag does not hold.`;

const REFUTE_TOOL: Anthropic.Tool = {
  name: "rule_on_flag",
  description: "Uphold or overturn the leak flag.",
  input_schema: {
    type: "object",
    properties: {
      upheld: { type: "boolean" },
      reason: { type: "string", description: "One sentence." },
    },
    required: ["upheld", "reason"],
  },
};

// --- Types -------------------------------------------------------------------

interface Card {
  id: string;
  deck_id: string;
  cloze_text: string;
  cloze_count: number | null;
}

interface JudgeOutput {
  leak: boolean;
  variants: { activeGroup: number; leakDetected: boolean; leakType: string; explanation: string }[];
  confidence: "high" | "medium" | "low";
  fixKind: string;
  proposedRewrite: string;
  rewriteRationale: string;
}

interface AuditRow {
  cardId: string;
  deckId: string;
  deckTitle: string;
  sourceText: string;
  clozeCount: number | null;
  renderedVariants: {
    activeGroup: number;
    renderedPrompt: string;
    hiddenAnswers: string[];
    visibleAnswers: string[];
    leakDetected: boolean;
    leakType: LeakType | "NONE";
    explanation: string;
  }[];
  overallStatus: OverallStatus;
  recommendedAction: RecommendedAction;
  confidence: "high" | "medium" | "low";
  proposedRewrite: string | null;
  rewriteKind: SafetyReport["kind"] | null;
  safetyViolations: { code: string; detail: string }[];
  notes: string[];
  refuted: boolean;
  refuteReason: string | null;
  error?: string;
}

// --- Model plumbing ----------------------------------------------------------

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

/**
 * Stop the run when the failure is the same every time.
 *
 * An empty credit balance took 419 of 425 cards on the first organic chemistry
 * run: every call returned the identical 400, every card was written down as
 * "not audited", and the run still exited 0. One failure repeated is not 425
 * findings, it is one finding, and the tool should say so on the third card
 * rather than the four hundred and nineteenth.
 */
let abortReason: string | null = null;
let consecutiveFailures = 0;
const FAILURE_LIMIT = 3;

async function callTool<T>(
  system: string,
  tool: Anthropic.Tool,
  userText: string,
  maxTokens = 1500,
): Promise<T> {
  if (abortReason) throw new Error(abortReason);
  let lastErr: unknown;
  for (let attempt = 0; attempt < 4; attempt++) {
    try {
      const msg = await anthropic.messages.create({
        model: MODEL,
        max_tokens: maxTokens,
        system,
        tools: [tool],
        tool_choice: { type: "tool", name: tool.name },
        messages: [{ role: "user", content: userText }],
      });
      const use = msg.content.find((b) => b.type === "tool_use");
      if (!use || use.type !== "tool_use") throw new Error("no tool_use block in response");
      consecutiveFailures = 0;
      return use.input as T;
    } catch (err) {
      lastErr = err;
      // A 400 is a bad request, not a busy server: retrying it just wastes
      // three backoffs before reporting the same thing.
      const status = (err as { status?: number })?.status;
      if (status && status >= 400 && status < 500 && status !== 429) break;
      await sleep(800 * 2 ** attempt);
    }
  }
  if (++consecutiveFailures >= FAILURE_LIMIT) {
    abortReason = `${FAILURE_LIMIT} cards in a row failed the same way; stopping. Last error: ${String(
      (lastErr as Error)?.message || lastErr,
    ).slice(0, 200)}`;
  }
  throw lastErr;
}

/** The card as the model should see it: rendered first, source last. */
function renderForJudge(card: Card): string {
  const variants = expandStudyVariants(card.cloze_text, card.cloze_count ?? undefined);
  const lines: string[] = [];
  lines.push(`This written card produces ${variants.length} study card(s).`);
  lines.push("");
  for (const v of variants) {
    lines.push(`--- STUDY CARD ${v.activeGroup} (group c${v.activeGroup} is hidden) ---`);
    lines.push(`WHAT THE STUDENT SEES: ${v.prompt}`);
    lines.push(
      `HIDDEN ON THIS CARD (all at once): ${
        v.hiddenAnswers.map((a) => `"${a}"`).join(", ") || "nothing"
      }`,
    );
    if (v.visibleAnswers.length) {
      lines.push(
        `PRINTED ON THIS CARD FROM OTHER GROUPS: ${v.visibleAnswers.map((a) => `"${a}"`).join(", ")}`,
      );
    }
    if (v.hints.length) lines.push(`HINT SHOWN: ${v.hints.join(" / ")}`);
    lines.push("");
  }
  lines.push(
    `Each ${BLANK_TOKEN} above is a blank box. Its width matches the answer, which is normal and is not a leak.`,
  );
  lines.push("");
  lines.push("SOURCE (for writing a corrected version only, not for judging):");
  lines.push(card.cloze_text);
  return lines.join("\n");
}

function cacheKey(card: Card): string {
  return crypto
    .createHash("sha256")
    .update(
      [PROMPT_VERSION, MODEL, String(REFUTE), card.cloze_text, String(card.cloze_count)].join(" "),
    )
    .digest("hex");
}

function readCache(
  key: string,
): { judge: JudgeOutput; refute: { upheld: boolean; reason: string } | null } | null {
  if (!USE_CACHE) return null;
  try {
    return JSON.parse(fs.readFileSync(path.join(CACHE_DIR, `${key}.json`), "utf8"));
  } catch {
    return null;
  }
}

function writeCache(key: string, payload: unknown): void {
  if (!USE_CACHE) return;
  fs.mkdirSync(CACHE_DIR, { recursive: true });
  fs.writeFileSync(path.join(CACHE_DIR, `${key}.json`), JSON.stringify(payload));
}

// --- One card ----------------------------------------------------------------

async function auditCard(card: Card, deckTitle: string): Promise<AuditRow> {
  const structure = auditCardStructure(card.cloze_text, card.cloze_count ?? undefined);

  const base: AuditRow = {
    cardId: card.id,
    deckId: card.deck_id,
    deckTitle,
    sourceText: card.cloze_text,
    clozeCount: card.cloze_count,
    renderedVariants: structure.variants.map((v) => ({
      activeGroup: v.activeGroup,
      renderedPrompt: v.prompt,
      hiddenAnswers: v.hiddenAnswers,
      visibleAnswers: v.visibleAnswers,
      leakDetected: false,
      leakType: "NONE" as LeakType | "NONE",
      explanation: "",
    })),
    overallStatus: "SAFE",
    recommendedAction: "NONE",
    confidence: "high",
    proposedRewrite: null,
    rewriteKind: null,
    safetyViolations: [],
    notes: [],
    refuted: false,
    refuteReason: null,
  };

  // Decided in code, on every card, identically on every run.
  for (const f of structure.findings) {
    const slot = base.renderedVariants.find((v) => v.activeGroup === f.activeGroup);
    if (slot && !slot.leakDetected) {
      slot.leakDetected = true;
      slot.leakType = f.leakType;
      slot.explanation = f.explanation;
    }
  }
  const structuralLeak = structure.findings.length > 0;

  if (STRUCTURE_ONLY) {
    // SAFE here means "code found nothing", not "this card reads well". The
    // semantic classes (a synonym beside the blank, a gloss that restates the
    // answer) are invisible to this pass by construction.
    return {
      ...base,
      overallStatus: structuralLeak ? "LEAK_CONFIRMED" : "SAFE",
      recommendedAction: structuralLeak ? "HUMAN_REVIEW" : "NONE",
      confidence: "high",
      notes: structuralLeak
        ? ["Proven by rendering the card. No model was asked."]
        : ["Structural pass only. Nothing here says the card reads well."],
    };
  }

  let judged: JudgeOutput;
  let refute: { upheld: boolean; reason: string } | null = null;
  const key = cacheKey(card);
  const cached = readCache(key);

  try {
    if (cached) {
      judged = cached.judge;
      refute = cached.refute;
    } else {
      judged = await callTool<JudgeOutput>(SYSTEM, JUDGE_TOOL, renderForJudge(card));
      if (REFUTE && judged.leak) {
        const flagText = (judged.variants ?? [])
          .filter((v) => v.leakDetected)
          .map((v) => `card ${v.activeGroup}: ${v.leakType} - ${v.explanation}`)
          .join(" | ");
        refute = await callTool<{ upheld: boolean; reason: string }>(
          REFUTE_SYSTEM,
          REFUTE_TOOL,
          `${renderForJudge(card)}\n\nTHE FLAG TO RULE ON: ${flagText}`,
          600,
        );
      }
      writeCache(key, { judge: judged, refute });
    }
  } catch (err) {
    // NOT SAFE. An unjudged card is an unknown card, and letting it fall
    // through with the default status would quietly pad the safe column with
    // cards nobody looked at.
    return {
      ...base,
      overallStatus: "NEEDS_HUMAN_REVIEW",
      recommendedAction: "HUMAN_REVIEW",
      notes: [...base.notes, "The judge could not read this card; it has not been audited."],
      error: String((err as Error)?.message || err).slice(0, 160),
    };
  }

  base.confidence = judged.confidence ?? "medium";

  // A flag the second reader overturned is recorded, not acted on. Structural
  // findings are code-proven and are never subject to refutation.
  const semanticLeak = judged.leak && !(refute && refute.upheld === false);
  if (refute && refute.upheld === false) {
    base.refuted = true;
    base.refuteReason = refute.reason;
  }

  if (semanticLeak) {
    for (const v of judged.variants ?? []) {
      if (!v.leakDetected) continue;
      const slot = base.renderedVariants.find((s) => s.activeGroup === v.activeGroup);
      if (!slot || slot.leakDetected) continue; // a code-proven finding wins
      slot.leakDetected = true;
      slot.leakType = (v.leakType as LeakType) ?? "OTHER_CONFIRMED_CUE";
      slot.explanation = v.explanation;
    }
  }

  const leakFound = structuralLeak || semanticLeak;
  // A rewrite for a card nobody is flagging is not a proposal, it is noise.
  const raw = leakFound ? sanitizeRewrite(judged.proposedRewrite, card.cloze_text) : null;
  // A merge that leaves c1, c3, c4 behind is a good edit with a clerical gap.
  // Close it, and say so, rather than rejecting the whole suggestion.
  const proposed = raw ? renumberContiguous(raw) : null;
  if (proposed && raw && proposed !== raw) {
    base.notes.push("Cloze numbers renumbered to close a gap the rewrite left behind.");
  }

  const safety = proposed
    ? checkRewriteSafety(card.cloze_text, proposed, card.cloze_count ?? undefined)
    : null;

  const decision = decideAction(leakFound, proposed, safety);
  base.overallStatus = decision.overallStatus;
  base.recommendedAction = decision.recommendedAction;
  base.notes = [...base.notes, ...decision.notes];
  if (judged.rewriteRationale) base.notes.push(`Judge: ${judged.rewriteRationale}`);
  if (base.refuted) base.notes.push(`Second reader overturned the flag: ${base.refuteReason}`);
  base.rewriteKind = safety?.kind ?? null;
  base.safetyViolations = safety?.violations ?? [];
  base.proposedRewrite = decision.surfaceRewrite ? proposed : null;

  return base;
}

// --- Run ---------------------------------------------------------------------

const { data: allDecks, error: deckErr } = await sb
  .from("flashcard_decks")
  .select("id,title,section")
  .order("title");
if (deckErr) {
  console.error(deckErr.message);
  process.exit(1);
}

const decks = (allDecks ?? []).filter((d) =>
  deckIdArg
    ? d.id === deckIdArg
    : sectionArg
      ? d.section === sectionArg
      : d.title.toLowerCase().includes((titleArg || "").toLowerCase()),
);
if (!decks.length) {
  console.error(
    "No matching deck. Sections:",
    [...new Set((allDecks ?? []).map((d) => d.section))].join(", "),
  );
  process.exit(2);
}
const deckTitle = Object.fromEntries(decks.map((d) => [d.id, d.title]));
const deckIds = new Set(decks.map((d) => d.id));

const cards: Card[] = [];
for (let from = 0; ; from += 1000) {
  const { data } = await sb
    .from("flashcards")
    .select("id,deck_id,card_type,cloze_text,cloze_count")
    .order("id")
    .range(from, from + 999);
  if (!data || !data.length) break;
  for (const c of data) {
    if (deckIds.has(c.deck_id) && c.card_type === "cloze" && c.cloze_text) {
      cards.push({
        id: c.id,
        deck_id: c.deck_id,
        cloze_text: c.cloze_text,
        cloze_count: c.cloze_count,
      });
    }
  }
  if (data.length < 1000) break;
}
const targets = limitArg > 0 ? cards.slice(0, limitArg) : cards;

console.log(
  STRUCTURE_ONLY
    ? `Structural pass over ${targets.length} cloze cards across ${decks.length} deck(s). No model calls.\n`
    : `Auditing ${targets.length} cloze cards across ${decks.length} deck(s) with ${MODEL}` +
      `${REFUTE ? " (two passes)" : ""} ...\n`,
);

const rows: AuditRow[] = [];
let cursor = 0;
async function worker() {
  while (cursor < targets.length) {
    if (abortReason) return;
    const card = targets[cursor++];
    rows.push(await auditCard(card, deckTitle[card.deck_id]));
    if (rows.length % 25 === 0) process.stderr.write(`  ...${rows.length}/${targets.length}\n`);
  }
}
await Promise.all(Array.from({ length: Math.min(CONCURRENCY, targets.length) }, worker));
rows.sort((a, b) => (a.deckTitle + a.cardId).localeCompare(b.deckTitle + b.cardId));

// --- Report ------------------------------------------------------------------

const errors = rows.filter((r) => r.error);
const confirmed = rows.filter((r) => r.overallStatus === "LEAK_CONFIRMED");
const review = rows.filter((r) => r.overallStatus === "NEEDS_HUMAN_REVIEW");
const safe = rows.filter((r) => r.overallStatus === "SAFE");

for (const r of [...confirmed, ...review]) {
  const mark = r.overallStatus === "LEAK_CONFIRMED" ? "LEAK " : "?    ";
  console.log(`\n${mark} [${r.deckTitle}]  ${r.cardId}`);
  for (const v of r.renderedVariants.filter((v) => v.leakDetected)) {
    console.log(`   c${v.activeGroup} ${v.leakType}: ${v.explanation}`);
  }
  console.log(`   now: ${r.sourceText}`);
  if (r.proposedRewrite) console.log(`   fix (${r.rewriteKind}): ${r.proposedRewrite}`);
  for (const n of r.notes) console.log(`   note: ${n}`);
}

const byType: Record<string, number> = {};
for (const r of rows) {
  for (const v of r.renderedVariants) {
    if (v.leakDetected) byType[v.leakType] = (byType[v.leakType] || 0) + 1;
  }
}
const byDeck: Record<string, { cards: number; confirmed: number; review: number }> = {};
for (const r of rows) {
  const b = (byDeck[r.deckTitle] ||= { cards: 0, confirmed: 0, review: 0 });
  b.cards++;
  if (r.overallStatus === "LEAK_CONFIRMED") b.confirmed++;
  if (r.overallStatus === "NEEDS_HUMAN_REVIEW") b.review++;
}

const summary = {
  model: STRUCTURE_ONLY ? "none (structural pass only)" : MODEL,
  structureOnly: STRUCTURE_ONLY,
  promptVersion: PROMPT_VERSION,
  refutePass: REFUTE,
  abortReason,
  ranAt: new Date().toISOString(),
  decks: decks.map((d) => ({ id: d.id, title: d.title })),
  totals: {
    audited: rows.length,
    judged: rows.length - rows.filter((r) => r.error).length,
    neverReached: targets.length - rows.length,
    safe: safe.length,
    leakConfirmed: confirmed.length,
    needsHumanReview: review.length,
    refutedFlags: rows.filter((r) => r.refuted).length,
    errors: errors.length,
    merge: rows.filter((r) => r.recommendedAction === "MERGE_GROUPS").length,
    reword: rows.filter((r) => r.recommendedAction === "REWORD").length,
    humanReview: rows.filter((r) => r.recommendedAction === "HUMAN_REVIEW").length,
    rewritesWithheld: rows.filter(
      (r) => r.safetyViolations.length > 0 && r.overallStatus !== "SAFE",
    ).length,
    unsafeRewritesProposed: rows.filter((r) => r.safetyViolations.length > 0).length,
    splitRewritesProposed: rows.filter((r) => r.rewriteKind === "SPLIT_GROUPS").length,
  },
  leaksByType: byType,
  byDeck,
};

const out =
  outArg ||
  `flashcard-leak-audit-${sectionArg || deckIdArg || titleArg}.json`.replace(/[^\w.\-]+/g, "-");
fs.writeFileSync(out, JSON.stringify({ summary, rows }, null, 1));

console.log("\n" + "-".repeat(64));
console.log(
  `judged ${rows.length - errors.length} of ${targets.length}  safe ${safe.length}  ` +
    `confirmed ${confirmed.length}  human review ${review.length}`,
);
console.log(
  `merge ${summary.totals.merge}  reword ${summary.totals.reword}  rewrites withheld by the safety check ${summary.totals.rewritesWithheld}`,
);
if (summary.totals.refutedFlags) {
  console.log(`flags overturned by the second reader: ${summary.totals.refutedFlags}`);
}
if (errors.length) console.log(`judge errors: ${errors.length}`);
if (abortReason) {
  console.log(`\nRUN ABORTED: ${abortReason}`);
  console.log(`${targets.length - rows.length} card(s) were never reached.`);
}
console.log(`Report: ${out}`);
// Errors are a failure too. A run that could not read its cards must not exit
// 0 just because it found no leaks in the cards it never saw.
process.exit(confirmed.length || errors.length || abortReason ? 1 : 0);
