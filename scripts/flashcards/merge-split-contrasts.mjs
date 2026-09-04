/*
 * Cards that reveal their own answer through a contrast in a sibling group.
 *
 *   node scripts/flashcards/find-split-contrasts.mjs
 *
 * A cloze card shows every group except the one being tested. So when a card
 * is built on a two-way contrast and puts each half in its OWN group, asking
 * for one prints the other, and the answer follows by elimination.
 *
 * Mikko found five of these by studying — horizontal/vertical,
 * closed/open/inactivated, distal/proximal, telencephalon/diencephalon,
 * increases/decreases. This finds the rest without a model, because the
 * signature is mechanical: a known opposition split across groups, or a stem
 * that announces a count while each item sits alone.
 *
 * Reads only. Prints a list.
 */
import {
  db, PAIRS, negatedPair, opposingPrefix, CLOZE, norm, page,
} from "./lib/contrast-vocab.mjs";
import fs from "fs";

/* ------------------------------------------------------------------ *
 * Everything above is the detector, unchanged. Below: the repair.
 *
 * A split contrast is fixed by putting both halves in the SAME group, so
 * they blank together and neither can be read off the other.
 *
 * Merging renumbers groups, and that is the dangerous part. The renderer
 * matches the literal cN in the text; the study page feeds a POSITIONAL
 * index. The two agree only while groups run 1..N with no gaps, so after any
 * merge the groups must be renumbered contiguously and the saved progress
 * repointed to match. Rather than repoint it, this deletes the progress on the
 * repaired cards outright. That is the honest choice: a leaking card could be
 * answered without knowing it, so its review history is not evidence of
 * knowledge, and re-learning 27 cards costs a few minutes.
 * ------------------------------------------------------------------ */

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const state = await page("flashcard_user_state", "user_id,flashcard_id,cloze_index,stability,next_review_at", ["flashcard_id", "cloze_index"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

function detect(c) {
  if (!c.cloze_text || (c.cloze_count ?? 0) < 2) return null;
  CLOZE.lastIndex = 0;
  const groups = new Map();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) {
    if (!groups.has(+m[1])) groups.set(+m[1], []);
    groups.get(+m[1]).push(norm(m[2]));
  }
  if (groups.size < 2) return null;
  for (const [a, b] of PAIRS) {
    const ga = [...groups.entries()].find(([, v]) => v.some((x) => x === a || x.split(" ").includes(a)));
    const gb = [...groups.entries()].find(([, v]) => v.some((x) => x === b || x.split(" ").includes(b)));
    if (ga && gb && ga[0] !== gb[0]) return { reason: `${a} / ${b}`, pair: [ga[0], gb[0]] };
  }
  const entries = [...groups.entries()];
  for (let i = 0; i < entries.length; i++)
    for (let j = i + 1; j < entries.length; j++)
      for (const wa of entries[i][1]) for (const wb of entries[j][1]) {
        const hit = opposingPrefix(wa, wb) || negatedPair(wa, wb);
        if (hit) return { reason: hit, pair: [entries[i][0], entries[j][0]] };
      }
  return null;
}

/** Fold `from` into `keep`, then renumber every group to a contiguous 1..N. */
function merge(text, keep, from) {
  const folded = text.replace(CLOZE, (full, g, ans, hint) => {
    const n = +g === from ? keep : +g;
    return hint === undefined ? `{{c${n}::${ans}}}` : `{{c${n}::${ans}::${hint}}}`;
  });
  CLOZE.lastIndex = 0;
  const seen = new Set();
  let m;
  while ((m = CLOZE.exec(folded)) !== null) seen.add(+m[1]);
  const remap = new Map([...seen].sort((a, b) => a - b).map((g, i) => [g, i + 1]));
  const out = folded.replace(CLOZE, (full, g, ans, hint) => {
    const n = remap.get(+g);
    return hint === undefined ? `{{c${n}::${ans}}}` : `{{c${n}::${ans}::${hint}}}`;
  });
  return { text: out, count: remap.size };
}

const q = (s) => "'" + s.replace(/'/g, "''") + "'";
const wordbag = (s) => s.replace(/\{\{c\d+::/g, "").replace(/\}\}/g, "")
  .toLowerCase().replace(/[^a-z0-9]+/g, " ").trim().split(" ").filter(Boolean).sort().join(" ");

const fixes = [];
const tooMany = [];
for (const c of cards) {
  const d = detect(c);
  if (!d) continue;
  const [a, b] = d.pair;
  const keep = Math.min(a, b), from = Math.max(a, b);
  const { text, count } = merge(c.cloze_text, keep, from);

  // Verification, per card, before anything is written.
  CLOZE.lastIndex = 0;
  const groups = new Set();
  let m;
  while ((m = CLOZE.exec(text)) !== null) groups.add(+m[1]);
  // A merge that leaves a group hiding many separate spans destroys the card.
  // "reactant/product" recurs four times in the Le Chatelier card, and merging
  // every occurrence left six blanks in one group with nothing readable around
  // them. Merging is right for a TWO-WAY CONTRAST and wrong for a phrase that
  // recurs through a sentence, so cap it and report the rest for hand design.
  CLOZE.lastIndex = 0;
  const spansPerGroup = new Map();
  let mm;
  while ((mm = CLOZE.exec(text)) !== null) {
    spansPerGroup.set(+mm[1], (spansPerGroup.get(+mm[1]) ?? 0) + 1);
  }
  const worst = Math.max(...spansPerGroup.values());
  if (worst > 3) {
    tooMany.push({ id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", worst,
                   reason: d.reason, text: c.cloze_text.replace(/\s+/g, " ") });
    continue;
  }

  const contiguous = [...groups].sort((x, y) => x - y).every((g, i) => g === i + 1);
  const sameWords = wordbag(text) === wordbag(c.cloze_text);
  const shrank = count === (c.cloze_count ?? 0) - 1;
  if (!contiguous || !sameWords || !shrank || groups.size !== count) {
    console.error(`REFUSED ${c.id}: contiguous=${contiguous} words=${sameWords} shrank=${shrank}`);
    continue;
  }
  fixes.push({ id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", reason: d.reason,
               before: c.cloze_text, after: text, count, oldCount: c.cloze_count });
}

const ids = new Set(fixes.map((f) => f.id));
const rows = state.filter((s) => ids.has(s.flashcard_id));
const users = new Set(rows.map((s) => s.user_id));
const EXAM = new Date("2026-09-12T00:00:00Z");
const pastExam = rows.filter((s) => s.next_review_at && new Date(s.next_review_at) > EXAM).length;

let sql = `-- ============================================================
-- Split contrasts: put both halves of a contrast in the same blank
--
-- A cloze card shows every group except the one being tested. When a card is
-- built on a two-way contrast and puts each half in its OWN group, asking for
-- one PRINTS the other, and the answer follows by elimination. Mikko hit this
-- again on the microtubule card: "the ___ end sits near the nucleus and the
-- POSITIVE end points toward the cell periphery."
--
-- Round two. The first pass fixed 27; these are the ones its vocabulary could
-- not see. Mikko hit "Relative configuration ... Absolute configuration" and
-- the pair list had no entry for relative/absolute. That list had also been
-- copy-pasted into three detector scripts, so learning a pair fixed only one of
-- them. It now lives in lib/contrast-vocab.mjs and every detector imports it.
--
-- ${fixes.length} cards are repaired here by folding the two halves into one group, so
-- they blank together. Groups are then renumbered contiguously, because the
-- renderer matches the literal cN while the study page feeds a positional
-- index; those agree only while groups run 1..N with no gaps.
--
-- Each merge was verified before being written: groups contiguous from 1,
-- exactly one group fewer than before, and the card's words unchanged (only
-- the blanking moved).
--
-- PROGRESS ON THESE CARDS IS DELETED: ${rows.length} rows across ${users.size} account(s).
-- ${pastExam} of those blanks were scheduled past the 2026-09-12 exam and would never
-- have come back in time. A leaking card could be answered without knowing it,
-- so its review history is not evidence of knowledge. These re-enter as new
-- cards and will come back within days, with the leak closed.
-- ============================================================

BEGIN;

`;
for (const f of fixes) {
  sql += `-- ${f.deck}: ${f.reason}\n`;
  sql += `--   was: ${f.before.replace(/\s+/g, " ").slice(0, 160)}\n`;
  sql += `--   now: ${f.after.replace(/\s+/g, " ").slice(0, 160)}\n`;
  sql += `UPDATE public.flashcards SET cloze_text = ${q(f.after)}, cloze_count = ${f.count} WHERE id = '${f.id}';\n`;
  sql += `DELETE FROM public.flashcard_user_state WHERE flashcard_id = '${f.id}';\n\n`;
}
sql += `COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0: every repaired card's group count must equal cloze_count.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\\{\\{c(\\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE id IN (${fixes.map((f) => `'${f.id}'`).join(",")})
) t WHERE n <> cloze_count;

-- Expect 0: no leftover progress pointing at a blank that no longer exists.
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
`;
fs.writeFileSync("supabase/fixes/20260903_merge_split_contrasts_round3.sql", sql);
if (tooMany.length) {
  console.log(`\nREFUSED as over-merges, these need hand design: ${tooMany.length}`);
  for (const t of tooMany) {
    console.log(`  ${t.worst} spans in one group  ${t.deck}  (${t.reason})`);
    console.log(`     ${t.text.slice(0, 150)}`);
  }
  console.log("");
}
console.log(`repaired          : ${fixes.length} cards`);
console.log(`progress deleted  : ${rows.length} rows across ${users.size} account(s)`);
console.log(`of those, past exam: ${pastExam} blanks that would never have returned in time`);
console.log(`\nwrote supabase/fixes/20260903_merge_split_contrasts_round3.sql`);
