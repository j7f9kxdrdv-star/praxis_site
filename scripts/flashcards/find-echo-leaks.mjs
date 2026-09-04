/*
 * Cards that print a word of their own answer somewhere the student can see it.
 *
 *   node scripts/flashcards/find-echo-leaks.mjs
 *
 * Mikko found this on the anhydride card:
 *
 *   "If an [asymmetric anhydride] is formed from two different carboxylic
 *    acids, both acids are named in alphabetical order before the word
 *    ANHYDRIDE. For example, acetic and propionic acids give ethanoic
 *    propanoic ANHYDRIDE."
 *
 * Half the answer is sitting in plain text, twice. The student supplies one
 * word instead of two, and the card is easier than the deck believes.
 *
 * This rule is MECHANICAL, which makes it far more trustworthy than the
 * contrast rules: it compares an answer against the visible text of its own
 * card, with no vocabulary to guess at and no judgement about what counts as
 * an opposite. The only tuning is which words are too common to matter.
 *
 * ---------------------------------------------------------------------------
 * DEAD END. KEPT SO IT IS NOT REBUILT.
 *
 * This rule does not work and its output must not be applied in bulk.
 *
 * The loose form (any distinctive answer word echoed) flagged 493 of 4116
 * cards, 12% of the bank. Almost all were ordinary technical writing: "an
 * amino acid contains an amino group" is a correct card, not a defect.
 *
 * Tightening to the answer's HEAD NOUN cut it to 142, and the survivors are
 * still overwhelmingly legitimate, because paired scientific terms share a
 * head by construction: N-terminus / C-terminus, white matter / gray matter,
 * oval window / round window, atomic number / mass number. Asking one of a
 * pair necessarily shows the shared noun, and that is how the vocabulary
 * works, not a leak.
 *
 * The card that prompted this, the anhydride card, was genuinely broken, but
 * not for a reason this rule can isolate: its stem both defined the answer in
 * plain language ("two different carboxylic acids" means asymmetric) AND
 * printed half of it twice. It was repaired by hand in
 * supabase/fixes/20260903_fix_anhydride_card.sql.
 *
 * Precision is the whole game for these detectors. A rule that flags 12% of
 * the bank costs more to review than the defects cost to leave, and applying
 * it unread would damage correct cards. Compare find-acronym-leaks.mjs, which
 * is mechanical and lands at 3 to 7 cards.
 * ---------------------------------------------------------------------------
 * Reads only. Prints a list.
 */
import {
  db, CLOZE, norm, page, visibleText,
} from "./lib/contrast-vocab.mjs";

// Words that carry no information about the answer. A card about the kidney
// will say "kidney" repeatedly and that is not a leak; a card whose ANSWER is
// "countercurrent multiplier" and which also prints "countercurrent" is.
const COMMON = new Set([
  "which", "where", "there", "these", "those", "their", "would", "could",
  "about", "after", "before", "between", "during", "through", "while",
  "because", "other", "another", "under", "above", "using", "used", "uses",
  "first", "second", "third", "given", "since", "than", "then", "also",
  "into", "from", "with", "that", "this", "when", "what", "each", "both",
  "more", "most", "less", "least", "same", "such", "only", "very", "much",
  "cannot", "does", "have", "been", "being", "were", "will", "must", "may",
  "them", "they", "its", "it", "as", "at", "by", "on", "or", "an", "a",
]);

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

/** Crude stem so "acids" matches "acid" and "named" matches "name". */
function stem(w) {
  return w.replace(/(ies|es|s|ed|ing)$/, "");
}

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
    const visible = new Set(norm(visibleText(c.cloze_text, g)).split(" ").map(stem));
    const echoed = [];
    for (const rawAns of answers) {
      const ws = norm(rawAns).split(" ").filter(Boolean);
      // ONLY the head noun counts. A card may legitimately repeat a modifier
      // from its own subject ("an amino acid contains an amino group"); what
      // makes a card unanswerable-as-intended is the HEAD of the answer being
      // printed, because then the student supplies only the modifier. On the
      // anhydride card the answer is "asymmetric anhydride" and "anhydride" is
      // printed twice, so only "asymmetric" is actually being recalled.
      if (ws.length < 2 || ws.length > 3) continue;
      const head = ws[ws.length - 1];
      if (head.length < 6 || COMMON.has(head)) continue;
      if (visible.has(stem(head)) && !echoed.includes(head)) echoed.push(head);
    }
    if (!echoed.length) continue;

    // A multi-word answer that is ENTIRELY echoed is a total giveaway; one
    // echoed word out of several is a partial one. Report the distinction.
    const answerWords = new Set(answers.flatMap((a) => norm(a).split(" ")).filter((w) => w.length >= 5 && !COMMON.has(w)));
    const total = echoed.length === answerWords.size;
    found.push({
      id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", group: g, total,
      echoed, text: c.cloze_text.replace(/\s+/g, " "),
    });
  }
}

const byCard = new Map();
for (const f of found) if (!byCard.has(f.id) || (f.total && !byCard.get(f.id).total)) byCard.set(f.id, f);
const list = [...byCard.values()].sort((a, b) => Number(b.total) - Number(a.total));
const totals = list.filter((f) => f.total);

console.log(`cards echoing a word of their own answer: ${list.length} of ${cards.length}`);
console.log(`  every distinctive word echoed (total giveaway): ${totals.length}`);
console.log(`  some words echoed (partial giveaway):           ${list.length - totals.length}`);
console.log("");
for (const f of list) {
  console.log(`${f.total ? "TOTAL  " : "partial"}  ${f.deck}  (c${f.group})  echoes: ${f.echoed.join(", ")}`);
  console.log(`   ${f.text.slice(0, 180)}`);
  console.log("");
}
