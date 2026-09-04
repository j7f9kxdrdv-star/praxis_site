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
  db, PAIRS, PREFIXES, NEGATORS, negatedPair, opposingPrefix,
  CLOZE, norm, page, visibleText, groupsOf,
} from "./lib/contrast-vocab.mjs";
import fs from "fs";

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const state = await page("flashcard_user_state", "flashcard_id,cloze_index,stability,reps,suspended", ["flashcard_id", "cloze_index"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

// What a merge would cost: the stability sitting on the groups that get folded.
const cost = new Map();
for (const s of state) {
  if (s.suspended) continue;
  const k = `${s.flashcard_id}::${s.cloze_index}`;
  cost.set(k, Math.max(cost.get(k) ?? 0, Number(s.stability) || 0));
}

const found = [];
for (const c of cards) {
  if (!c.cloze_text || (c.cloze_count ?? 0) < 2) continue;
  CLOZE.lastIndex = 0;
  const groups = new Map();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) {
    if (!groups.has(+m[1])) groups.set(+m[1], []);
    groups.get(+m[1]).push(norm(m[2]));
  }
  if (groups.size < 2) continue;

  let reason = null, involved = null;
  // (a) a known opposition split across two different groups
  for (const [a, b] of PAIRS) {
    const ga = [...groups.entries()].find(([, v]) => v.some((x) => x === a || x.split(" ").includes(a)));
    const gb = [...groups.entries()].find(([, v]) => v.some((x) => x === b || x.split(" ").includes(b)));
    if (ga && gb && ga[0] !== gb[0]) { reason = `${a} / ${b} split across c${ga[0]} and c${gb[0]}`; involved = [ga[0], gb[0]]; break; }
  }
  // (b) the same root split across groups by an opposing prefix
  if (!reason) {
    const entries = [...groups.entries()];
    outer: for (let i = 0; i < entries.length; i++) {
      for (let j = i + 1; j < entries.length; j++) {
        for (const wa of entries[i][1]) for (const wb of entries[j][1]) {
          const hit = opposingPrefix(wa, wb) || negatedPair(wa, wb);
          if (hit) { reason = `${hit}, split across c${entries[i][0]} and c${entries[j][0]}`;
            involved = [entries[i][0], entries[j][0]]; break outer; }
        }
      }
    }
  }

  // A COUNT-WORD RULE WAS TRIED AND DROPPED. Flagging cards whose stem says
  // "two" or "three" while each item sits in its own group found 150+ cards and
  // almost all were noise: "the two cerebral hemispheres", "two enantiomers",
  // "two single bonds" are ordinary content, unrelated to how the card is
  // blanked. Only the explicit opposition list above is reliable, because it
  // keys on the ANSWERS rather than on the prose around them.
  if (!reason) continue;

  const lost = involved.slice(1).reduce((a, g) => a + (cost.get(`${c.id}::${g}`) ?? 0), 0);
  found.push({ id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", reason, lost, text: c.cloze_text.replace(/\s+/g, " ") });
}

found.sort((a, b) => a.lost - b.lost);
console.log(`cards where a sibling group gives the answer away: ${found.length} of ${cards.length}\n`);
const free = found.filter((f) => f.lost < 2);
console.log(`  merge costs under 2 days of stability: ${free.length}   <- cheap to fix`);
console.log(`  merge costs 2 days or more:            ${found.length - free.length}   <- your call\n`);
found.forEach((f) => {
  console.log(`[${f.lost.toFixed(1)}d]  ${f.deck}`);
  console.log(`   ${f.reason}`);
  console.log(`   ${f.text.slice(0, 150)}`);
});
