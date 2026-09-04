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
 * Cards that print the expansion of their own abbreviated answer.
 *
 * Mikko found this on the cDNA card:
 *
 *   "[____] (complementary DNA) is synthesized in vitro ..."
 *
 * The answer is "cDNA" and the next three words spell it out. An earlier pass
 * fixed the OPPOSITE arrangement, where the answer was the expansion and the
 * stem carried the acronym. This checks both directions.
 *
 * The match is mechanical, which is why it is trustworthy in a way the
 * contrast rules are not. Initials are built with one wrinkle: a word that is
 * already an all-caps acronym contributes the WHOLE token, so
 * "complementary DNA" yields "cDNA" rather than "cD".
 *
 * Reads only. Prints a list.
 * ------------------------------------------------------------------ */

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));


/** Initials of a word run, treating an existing all-caps token as atomic. */
function initials(words) {
  return words.map((w) => (/^[A-Z0-9]{2,}$/.test(w) ? w : w[0])).join("");
}
// Unicode sub/superscript digits must fold to real digits BEFORE anything is
// stripped. Without this "CO\u2082" keys as "co" and collides with any two words
// starting c- and o- ("cycle oxidatively", "chemoreceptors only"), which is
// what produced most of this rule's first-run false positives.
const SUPSUB = { "\u2080":"0","\u2081":"1","\u2082":"2","\u2083":"3","\u2084":"4","\u2085":"5","\u2086":"6","\u2087":"7","\u2088":"8","\u2089":"9",
                 "\u2070":"0","\u00b9":"1","\u00b2":"2","\u00b3":"3","\u2074":"4","\u2075":"5","\u2076":"6","\u2077":"7","\u2078":"8","\u2079":"9" };
const fold = (s) => s.replace(/[\u2080-\u2089\u2070\u00b9\u00b2\u00b3\u2074-\u2079]/g, (ch) => SUPSUB[ch] ?? ch);
const key = (s) => fold(s).replace(/[^A-Za-z0-9]/g, "").toLowerCase();
// Short capitalised tokens that are real words, not abbreviations. Without
// this, a sentence opening with "Both" would abbreviate an answer starting
// "both...", and "Each"/"When"/"This" behave the same way.
const NOT_ABBREV = new Set([
  "the","and","for","are","was","not","but","all","one","two","can","has","its",
  "may","new","now","out","per","see","use","who","why","this","that","when",
  "each","both","from","with","they","them","then","than","some","more","most",
  "such","only","also","into","over","under","after","before","since","while",
  "high","low","left","right","acid","base","cell","gene","bond","mass","heat",
]);
const STOP = new Set(["the", "a", "an", "of", "and", "or", "in", "to", "for", "is", "are"]);

const found = [];
for (const c of cards) {
  if (!c.cloze_text) continue;
  CLOZE.lastIndex = 0;
  const groups = new Map();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) {
    if (!groups.has(+m[1])) groups.set(+m[1], []);
    groups.get(+m[1]).push(m[2]);
  }

  for (const [g, answers] of groups) {
    const vis = visibleText(c.cloze_text, g);
    const toks = vis.split(/[^A-Za-z0-9]+/).filter(Boolean);
    let reason = null;

    for (const rawAns of answers) {
      const ansWords = rawAns.split(/[^A-Za-z0-9]+/).filter(Boolean);
      if (!ansWords.length) continue;
      const ansKey = key(rawAns);
      if (ansKey.length < 2) continue;

      // (a) the answer is an abbreviation; its expansion sits in the stem
      // Require a capital or a digit in the abbreviation. Without this, ordinary
      // lowercase words ("sp", "two") are read as acronyms and match any word
      // run with the same initials.
      const looksAbbrev = /[A-Z]/.test(rawAns) || /[0-9]/.test(fold(rawAns));
      if (ansWords.length === 1 && ansKey.length <= 6 && looksAbbrev) {
        for (let i = 0; i < toks.length; i++) {
          for (let n = 2; n <= 5 && i + n <= toks.length; n++) {
            const run = toks.slice(i, i + n);
            if (run.some((w) => STOP.has(w.toLowerCase()))) continue;
            if (key(initials(run)) === ansKey) {
              reason = `answer "${rawAns}" is spelled out as "${run.join(" ")}"`;
              break;
            }
          }
          if (reason) break;
        }
      }

      // (c) the answer is one word and the stem carries its TRUNCATION.
      // Initialisms are not the only way to abbreviate: "Methionine (Met, M)"
      // prints the first three letters, which branch (a) cannot see because
      // "Met" is not built from initials, and branch (b) cannot see because
      // the answer is a single word. Mikko found this on the methionine card.
      // Guarded three ways so ordinary prose cannot trip it: the stem token
      // must look like an abbreviation (initial capital or all caps), must be
      // a strict prefix of a materially longer answer, and must not be an
      // English word in its own right.
      if (!reason && ansWords.length === 1 && ansKey.length >= 5) {
        for (const t of toks) {
          if (t.length < 3 || t.length > 5) continue;
          if (!/^[A-Z]/.test(t)) continue;
          if (NOT_ABBREV.has(t.toLowerCase())) continue;
          const tk = key(t);
          if (tk.length + 2 > ansKey.length) continue;
          if (ansKey.startsWith(tk)) {
            reason = `answer "${rawAns}" is truncated to "${t}" in the stem`;
            break;
          }
        }
      }

      // (b) the answer is the expansion; its acronym sits in the stem
      if (!reason && ansWords.length >= 2 && ansWords.length <= 5) {
        const acr = key(initials(ansWords));
        if (acr.length >= 2) {
          for (const t of toks) {
            if (key(t) === acr && /[A-Z]/.test(t)) {
              reason = `answer "${rawAns}" is abbreviated as "${t}" in the stem`;
              break;
            }
          }
        }
      }
      if (reason) break;
    }
    if (!reason) continue;
    found.push({
      id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", group: g, reason,
      text: c.cloze_text.replace(/\s+/g, " "),
    });
  }
}

const byCard = new Map();
for (const f of found) if (!byCard.has(f.id)) byCard.set(f.id, f);
const list = [...byCard.values()];
console.log(`cards that spell out their own abbreviated answer: ${list.length} of ${cards.length}`);
console.log("");
for (const f of list) {
  console.log(`${f.deck}  (c${f.group})`);
  console.log(`   ${f.reason}`);
  console.log(`   ${f.text.slice(0, 175)}`);
  console.log("");
}
