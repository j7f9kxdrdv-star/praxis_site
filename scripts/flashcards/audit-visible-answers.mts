/*
 * Which cards can be answered without knowing the material?
 *
 *   npx tsx scripts/flashcards/audit-visible-answers.mts [--limit N] [--out f.json]
 *
 * Targets the population the leech diagnosis structurally could not see: cards
 * the student has never failed. A card whose answer is legible gets answered
 * correctly, so selecting on failure excludes exactly this defect class.
 *
 * Reads only. Writes a report.
 */
import { createClient } from "@supabase/supabase-js";
import Anthropic from "@anthropic-ai/sdk";
import fs from "fs";
import { auditVisibleAnswer, type VisibleAnswerAudit } from "../../lib/insights/auditVisibleAnswer";

const env = Object.fromEntries(
  fs.readFileSync(".env.local", "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()]),
);
const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);
const anthropic = new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });
const arg = (f: string) => { const i = process.argv.indexOf(f); return i > -1 ? process.argv[i + 1] : null; };
const LIMIT = Number(arg("--limit") ?? 0) || Infinity;
const OUT = arg("--out") ?? "/tmp/visible-answers.json";
const USER = "ee01e0e1-ac92-4ea7-92c9-2738b82b6dca";

async function page<T>(t: string, c: string, o: [string, string]): Promise<T[]> {
  const out: T[] = [];
  for (let f = 0; ; f += 1000) {
    const { data, error } = await db.from(t).select(c)
      .order(o[0], { ascending: true }).order(o[1], { ascending: true }).range(f, f + 999);
    if (error) throw new Error(`${t}: ${error.message}`);
    if (!data.length) break;
    out.push(...(data as T[]));
    if (data.length < 1000) break;
  }
  return out;
}

const state = await page<any>("flashcard_user_state", "user_id,flashcard_id,cloze_index,reps,lapses,suspended", ["flashcard_id", "cloze_index"]);
const cards = await page<any>("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks!.map((d) => [d.id, d.title as string]));
const cardById = new Map(cards.map((c) => [c.id, c]));

// Never failed, seen enough times that "never failed" means something.
const byCard = new Map<string, { reps: number; lapses: number }>();
for (const s of state) {
  if (s.user_id !== USER || s.suspended) continue;
  const cur = byCard.get(s.flashcard_id) ?? { reps: 0, lapses: 0 };
  cur.reps = Math.max(cur.reps, s.reps ?? 0);
  cur.lapses += s.lapses ?? 0;
  byCard.set(s.flashcard_id, cur);
}
const candidates = [...byCard.entries()]
  .filter(([id, v]) => v.lapses === 0 && v.reps >= 3 && cardById.get(id)?.cloze_text)
  .sort((a, b) => b[1].reps - a[1].reps)
  .slice(0, LIMIT === Infinity ? undefined : LIMIT)
  .map(([id]) => cardById.get(id));

console.error(`candidates (never failed, seen 3+ times): ${candidates.length}\n`);
const results: (VisibleAnswerAudit & { id: string; deck: string; clozeText: string })[] = [];
let done = 0;
const POOL = 8;
async function worker(q: any[]) {
  while (q.length) {
    const c = q.shift();
    if (!c) return;
    const deck = deckTitle.get(c.deck_id) ?? "Unknown";
    try {
      const a = await auditVisibleAnswer(anthropic, deck, c.cloze_text);
      if (a) results.push({ ...a, id: c.id, deck, clozeText: c.cloze_text });
    } catch (e) {
      console.error(`  failed ${c.id.slice(0, 8)}: ${e instanceof Error ? e.message : e}`);
    }
    if (++done % 25 === 0) console.error(`  ${done}/${candidates.length}`);
  }
}
const q = [...candidates];
await Promise.all(Array.from({ length: POOL }, () => worker(q)));
fs.writeFileSync(OUT, JSON.stringify(results, null, 1));
const bad = results.filter((r) => r.answerable_without_knowing);
console.error(`\n  answerable without knowing: ${bad.length} of ${results.length}`);
const how = new Map<string, number>();
bad.forEach((r) => how.set(r.how, (how.get(r.how) ?? 0) + 1));
[...how.entries()].sort((a, b) => b[1] - a[1]).forEach(([k, n]) => console.error(`    ${String(n).padStart(4)}  ${k}`));
console.error(`  fixes that preserve the group set: ${bad.filter((r) => r.fix_preserves_groups).length}`);
console.error(`  written to ${OUT}`);
