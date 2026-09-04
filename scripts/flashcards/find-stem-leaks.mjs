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

/* ------------------------------------------------------------------ *
 * A DIFFERENT LEAK, invisible to find-split-contrasts.mjs.
 *
 * That script compares blanked groups against EACH OTHER. This one compares a
 * blanked answer against the card's PLAIN, UNBLANKED text.
 *
 * Mikko found it on the menstrual-cycle card:
 *
 *   "negative feedback dominates ... briefly flipping to [____]
 *    (the LH surge), then reverting to NEGATIVE FEEDBACK ..."
 *
 * The answer is "positive feedback", and the stem prints its opposite twice in
 * plain text. Nothing needs to be recalled: "flipping to" plus a visible
 * "negative" leaves exactly one option. The sibling-group rule cannot see this,
 * because the giveaway was never in a group at all.
 *
 * Reads only. Prints a list.
 * ------------------------------------------------------------------ */

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

/** The card as a student sees it while `group` is being tested: every OTHER
 *  group is revealed, and `group` itself is a blank. */

const found = [];
for (const c of cards) {
  if (!c.cloze_text) continue;
  CLOZE.lastIndex = 0;
  const groups = new Map();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) {
    if (!groups.has(+m[1])) groups.set(+m[1], []);
    groups.get(+m[1]).push(norm(m[2]));
  }

  for (const [g, answers] of groups) {
    const visible = norm(visibleText(c.cloze_text, g)).split(" ");
    let reason = null;
    for (const ans of answers) {
      const words = ans.split(" ").filter(Boolean);
      for (const w of words) {
        for (const [a, b] of PAIRS) {
          if (w === a && visible.includes(b)) { reason = `answer says "${a}", stem shows "${b}"`; break; }
          if (w === b && visible.includes(a)) { reason = `answer says "${b}", stem shows "${a}"`; break; }
        }
        if (reason) break;
        for (const v of visible) {
          if (v.length < 5 || v === w) continue;
          const hit = opposingPrefix(w, v) || negatedPair(w, v);
          if (hit) { reason = `${hit}, the other half visible in the stem`; break; }
        }
        if (reason) break;
      }
      if (reason) break;
    }
    if (!reason) continue;
    found.push({ id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", group: g, reason,
                 text: c.cloze_text.replace(/\s+/g, " ") });
  }
}

const byCard = new Map();
for (const f of found) if (!byCard.has(f.id)) byCard.set(f.id, f);
const list = [...byCard.values()];

console.log(`cards whose stem prints the opposite of their own answer: ${list.length} of ${cards.length}`);
console.log("");
for (const f of list) {
  console.log(`${f.deck}  (c${f.group})`);
  console.log(`   ${f.reason}`);
  console.log(`   ${f.text.slice(0, 190)}`);
  console.log("");
}
