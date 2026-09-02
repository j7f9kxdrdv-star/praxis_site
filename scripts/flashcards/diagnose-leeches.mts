/*
 * Why are these cards failing?
 *
 *   npx tsx scripts/flashcards/diagnose-leeches.mts [--limit N] [--out report.json]
 *
 * Pulls every card a student has lapsed on 5+ times (the 99th percentile in the
 * live bank) and asks Claude to separate broken cards from genuine gaps. Writes
 * a report; changes nothing. Rewrites are proposals for a human to accept.
 */
import { createClient } from "@supabase/supabase-js";
import Anthropic from "@anthropic-ai/sdk";
import fs from "fs";
import { diagnoseCard, type CardToDiagnose, type CardDiagnosis } from "../../lib/insights/diagnoseCard";

const env = Object.fromEntries(
  fs.readFileSync(".env.local", "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()]),
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const anthropic = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });

const arg = (f: string) => { const i = process.argv.indexOf(f); return i > -1 ? process.argv[i + 1] : null; };
const LIMIT = Number(arg("--limit") ?? 0) || Infinity;
const OUT = arg("--out") ?? "/tmp/leech-diagnosis.json";
const USER = "ee01e0e1-ac92-4ea7-92c9-2738b82b6dca";
const LEECH_LAPSES = 5;

async function page<T>(table: string, cols: string, order: [string, string]): Promise<T[]> {
  const out: T[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await db.from(table).select(cols)
      .order(order[0], { ascending: true }).order(order[1], { ascending: true })
      .range(from, from + 999);
    if (error) throw new Error(`${table}: ${error.message}`);
    if (!data.length) break;
    out.push(...(data as T[]));
    if (data.length < 1000) break;
  }
  return out;
}

const state = await page<any>("flashcard_user_state",
  "user_id,flashcard_id,cloze_index,lapses,reps,suspended", ["flashcard_id", "cloze_index"]);
const reviews = await page<any>("flashcard_reviews",
  "user_id,flashcard_id,cloze_index,rating,prev_interval_days,reviewed_at", ["reviewed_at", "id"]);
const cards = await page<any>("flashcards", "id,deck_id,cloze_text", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks!.map((d) => [d.id, d.title as string]));
const cardById = new Map(cards.map((c) => [c.id, c]));

const mine = reviews.filter((r) => r.user_id === USER);
const baseline = mine.filter((r) => Number(r.prev_interval_days) >= 1);
const baselineRate = baseline.filter((r) => r.rating === "again").length / baseline.length;

const history = new Map<string, string[]>();
for (const r of mine) {
  const k = `${r.flashcard_id}::${r.cloze_index}`;
  if (!history.has(k)) history.set(k, []);
  history.get(k)!.push(r.rating);
}

const leeches = state
  .filter((s) => s.user_id === USER && !s.suspended && (s.lapses ?? 0) >= LEECH_LAPSES)
  .sort((a, b) => (b.lapses ?? 0) - (a.lapses ?? 0))
  .slice(0, LIMIT === Infinity ? undefined : LIMIT);

console.error(`baseline Again rate: ${(100 * baselineRate).toFixed(1)}%`);
console.error(`cards to diagnose: ${leeches.length}\n`);

/**
 * A rewrite is only safe to apply if it keeps the same cN group set — the study
 * screen identifies a blank by position, so adding, dropping or renumbering a
 * group re-points saved progress at different material. And a rewrite that
 * sheds a lot of text is making a CONTENT decision (which facts to keep), which
 * is never the model's call. Both are checked here so the report says which
 * proposals are mechanical and which need a subject-matter eye.
 */
const GROUPS = /\{\{c(\d+)::/g;
const groupSet = (t: string) =>
  [...new Set([...t.matchAll(GROUPS)].map((m) => m[1]))].sort().join(",");

type Result = CardDiagnosis & {
  id: string; deck: string; lapses: number; clozeText: string;
  rewriteKeepsGroups: boolean | null; rewriteLengthDeltaPct: number | null;
};
const results: Result[] = [];
let done = 0;
const POOL = 6; // modest concurrency; this is a batch job, not a request path

async function worker(queue: any[]) {
  while (queue.length) {
    const s = queue.shift();
    if (!s) return;
    const card = cardById.get(s.flashcard_id);
    if (!card?.cloze_text) continue;
    const input: CardToDiagnose = {
      id: s.flashcard_id,
      deck: deckTitle.get(card.deck_id) ?? "Unknown",
      clozeText: card.cloze_text,
      lapses: s.lapses ?? 0,
      reps: s.reps ?? 0,
      ratingHistory: history.get(`${s.flashcard_id}::${s.cloze_index}`) ?? [],
      baselineAgainRate: baselineRate,
    };
    try {
      const d = await diagnoseCard(anthropic, input);
      if (d) {
        const rw = d.suggested_rewrite?.trim() || "";
        results.push({
          ...d, id: input.id, deck: input.deck, lapses: input.lapses, clozeText: input.clozeText,
          rewriteKeepsGroups: rw ? groupSet(rw) === groupSet(input.clozeText) : null,
          rewriteLengthDeltaPct: rw
            ? Math.round((100 * (rw.length - input.clozeText.length)) / input.clozeText.length)
            : null,
        });
      }
    } catch (e) {
      console.error(`  failed ${s.flashcard_id.slice(0, 8)}: ${e instanceof Error ? e.message : e}`);
    }
    done++;
    if (done % 5 === 0) console.error(`  ${done}/${leeches.length}`);
  }
}
const queue = [...leeches];
await Promise.all(Array.from({ length: POOL }, () => worker(queue)));

fs.writeFileSync(OUT, JSON.stringify(results, null, 1));
const by = (v: string) => results.filter((r) => r.verdict === v);
console.error(`\n──────────────────────────────────────────`);
console.error(`  card_defect    ${by("card_defect").length}`);
console.error(`  knowledge_gap  ${by("knowledge_gap").length}`);
console.error(`  unclear        ${by("unclear").length}`);
const defects = by("card_defect");
const unsafe = defects.filter((r) => r.rewriteKeepsGroups === false);
const contentCalls = defects.filter((r) => (r.rewriteLengthDeltaPct ?? 0) < -25);
console.error(`\n  of the defects:`);
console.error(`    rewrites that would break scheduling  ${unsafe.length}  (do not apply)`);
console.error(`    rewrites that drop >25% of the text   ${contentCalls.length}  (content call, needs you)`);
console.error(`    mechanically safe                     ${defects.length - unsafe.length - contentCalls.length}`);
console.error(`  written to ${OUT}`);
