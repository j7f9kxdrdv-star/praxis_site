#!/usr/bin/env node
/**
 * Flashcard leak judge — LLM audit that catches answer-leaks a regex can't.
 *
 *   node scripts/flashcard-leak-judge.mjs "Endocrine"   # judge decks matching the title
 *   node scripts/flashcard-leak-judge.mjs --deck-id <uuid>
 *
 * Run this at ship time on a NEW deck (~100 cards, cheap). It flags cards where the
 * masked answer is recoverable from the visible text by ANY route — a term repeated
 * verbatim, a parallel list that spells it out, or plain semantic inference — the
 * classes the deterministic flashcard-qc.mjs cannot reliably detect. For each real
 * leak it prints the reason and a suggested corrected cloze_text (usually: wrap the
 * recurring term into the same {{cN}} group so both mask together).
 *
 * NOTE: treat the output as a REVIEW QUEUE, not an auto-fixer. "Recoverable from
 * context" is genuinely subjective, so even a strong model over-flags (well-written
 * cards carry helpful context). Eyeball each flag + its suggestion and apply the real
 * ones. For higher precision, add an adversarial second pass that tries to REFUTE each
 * flag and keeps only the confirmed leaks.
 *
 * Env (.env.local): NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, ANTHROPIC_API_KEY
 * Optional: LEAK_JUDGE_MODEL (default claude-haiku-4-5-20251001), LEAK_JUDGE_CONCURRENCY (default 8)
 * Exit code 1 if any real leak is found.
 */
import fs from "node:fs";
import path from "node:path";
import { createClient } from "@supabase/supabase-js";
import Anthropic from "@anthropic-ai/sdk";

const env = Object.fromEntries(
  fs.readFileSync(path.join(process.cwd(), ".env.local"), "utf8").split("\n").filter((l) => l.includes("=")).map((l) => {
    const i = l.indexOf("="); return [l.slice(0, i).trim(), l.slice(i + 1).trim().replace(/^["']|["']$/g, "")];
  }),
);
const sb = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const anthropic = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });
const MODEL = env.LEAK_JUDGE_MODEL || "claude-sonnet-5"; // Sonnet: far fewer false positives than Haiku here
const CONCURRENCY = Number(env.LEAK_JUDGE_CONCURRENCY || 8);

const args = process.argv.slice(2);
const deckIdArg = args.includes("--deck-id") ? args[args.indexOf("--deck-id") + 1] : null;
const filter = args.find((a) => !a.startsWith("--") && a !== deckIdArg) || null;
if (!deckIdArg && !filter) {
  console.error('Usage: node scripts/flashcard-leak-judge.mjs "<deck title substring>"  |  --deck-id <uuid>');
  const { data } = await sb.from("flashcard_decks").select("title").order("title");
  console.error("\nAvailable decks:\n" + (data || []).map((d) => "  " + d.title).join("\n"));
  process.exit(2);
}

const { data: decks } = await sb.from("flashcard_decks").select("id,title").order("title");
const targets = (decks || []).filter((d) => (deckIdArg ? d.id === deckIdArg : d.title.toLowerCase().includes(filter.toLowerCase())));
if (!targets.length) { console.error("No matching deck."); process.exit(2); }
const ids = new Set(targets.map((d) => d.id));
const cards = [];
for (let f = 0; ; f += 1000) {
  const { data } = await sb.from("flashcards").select("id,deck_id,card_type,cloze_text").order("id").range(f, f + 999);
  if (!data || !data.length) break; cards.push(...data.filter((c) => ids.has(c.deck_id) && c.card_type === "cloze" && c.cloze_text)); if (data.length < 1000) break;
}
const deckTitle = Object.fromEntries(targets.map((d) => [d.id, d.title]));
console.log(`Judging ${cards.length} cloze cards across ${targets.length} deck(s) with ${MODEL} …\n`);

const SYSTEM = `You audit MCAT cloze flashcards for ANSWER-LEAKS.
A cloze card hides {{cN::answer}} blanks. At study time exactly one group cN is masked; every OTHER group is shown as its answer text, and all non-cloze text is shown.
A LEAK = for some group, a student could recover the masked answer from the VISIBLE text without knowing the material, by any of:
  (a) verbatim — the answer term (or a trivial inflection) appears elsewhere as plain text or in another revealed group;
  (b) pattern — the card lists parallel cases and the others being shown makes the masked one obvious (e.g. two contrasting terms in separate groups, one revealed);
  (c) semantic — the visible text states the answer's defining consequence/synonym so it is trivially inferable.
STRICT BAR — only flag a leak if you are confident that a student who had NOT studied the material could produce the EXACT masked answer from the visible text alone. Do NOT flag a card merely because the answer is thematically related to visible words, because the wording could be tightened, or because a distractor-style inference is possible. When unsure, it is NOT a leak.
NOT a leak: only a generic/shared word overlaps while the distinctive word stays hidden; the answer still requires real recall from the visible cues; the visible text describes the concept but does not hand over the specific term.
Preferred fix: wrap the recurring/parallel term into the SAME {{cN}} group as the answer so both mask together (do not add or remove group indices). Otherwise minimally reword the visible text. Never change the tested fact.
Call the report_leak tool with your verdict.`;

const TOOL = {
  name: "report_leak",
  description: "Report whether this cloze card leaks its answer, and how to fix it.",
  input_schema: {
    type: "object",
    properties: {
      leak: { type: "boolean", description: "true only if the masked answer is genuinely recoverable from the visible text" },
      groups: { type: "array", items: { type: "integer" }, description: "cloze group numbers that leak (empty if none)" },
      why: { type: "string", description: "one-sentence reason (empty if no leak)" },
      suggestion: { type: "string", description: "the full corrected cloze_text, or empty string if no change" },
    },
    required: ["leak", "groups", "why", "suggestion"],
  },
};
async function judge(card) {
  try {
    const msg = await anthropic.messages.create({
      model: MODEL, max_tokens: 900, system: SYSTEM,
      tools: [TOOL], tool_choice: { type: "tool", name: "report_leak" },
      messages: [{ role: "user", content: `cloze_text:\n${card.cloze_text}` }],
    });
    const tu = msg.content.find((b) => b.type === "tool_use");
    if (!tu) return { id: card.id, error: "no-tool-use" };
    return { id: card.id, deck: deckTitle[card.deck_id], orig: card.cloze_text, ...tu.input };
  } catch (err) { return { id: card.id, error: String(err.message || err).slice(0, 120) }; }
}

// simple concurrency pool
const results = []; let idx = 0;
async function worker() { while (idx < cards.length) { const c = cards[idx++]; results.push(await judge(c)); if (results.length % 25 === 0) process.stderr.write(`  …${results.length}/${cards.length}\n`); } }
await Promise.all(Array.from({ length: Math.min(CONCURRENCY, cards.length) }, worker));

const leaks = results.filter((r) => r.leak);
const errs = results.filter((r) => r.error);
for (const l of leaks) {
  console.log(`\n● LEAK  [${l.deck}]  ${l.id}`);
  console.log(`  groups: ${JSON.stringify(l.groups)}  —  ${l.why}`);
  console.log(`  now: ${l.orig}`);
  if (l.suggestion && l.suggestion !== l.orig) console.log(`  fix: ${l.suggestion}`);
}
fs.writeFileSync("flashcard-leak-report.json", JSON.stringify({ model: MODEL, deckIds: [...ids], leaks, errors: errs }, null, 1));
console.log(`\n${leaks.length} real leak(s) across ${cards.length} cards${errs.length ? ` · ${errs.length} judge error(s)` : ""}.`);
console.log("Report: flashcard-leak-report.json");
process.exit(leaks.length ? 1 : 0);
