/*
 * Cards that leave nothing to answer from.
 *
 *   node scripts/flashcards/find-cueless-cards.mjs
 *
 * Mikko found this on the thermodynamics card:
 *
 *   "A process carried out at constant {c1 pressure} is called {c1 isobaric}."
 *
 * Blank both and the sentence reads "A process carried out at constant ___ is
 * called ___", which could be pressure/isobaric, volume/isochoric or
 * temperature/isothermal. Its own sibling card gets this right by leaving the
 * cue visible: "carried out at constant volume is called {c1 isochoric}".
 *
 * This is the OPPOSITE failure to the one most of these tools chase. A leak is
 * a card that gives its answer away; this is a card that withholds the
 * question. Merging fixes leaks and, pushed too far, causes exactly this, so
 * the two have to be watched together.
 *
 * THE TEST IS WHAT SURVIVES. For each group, blank it and count the CONTENT
 * left standing: words that are not function words, plus any number or symbol,
 * since "10^12 = ___" is cued by the exponent rather than by prose. Under a
 * handful of surviving cues there is nothing to reason from.
 *
 * Reads only. Prints a list.
 */
import { db, CLOZE, page } from "./lib/contrast-vocab.mjs";

const FUNCTION_WORDS = new Set([
  "a", "an", "the", "of", "to", "in", "on", "at", "for", "is", "are", "was",
  "were", "be", "been", "being", "by", "with", "from", "as", "that", "this",
  "these", "those", "it", "its", "their", "has", "have", "had", "and", "or",
  "but", "if", "then", "so", "than", "when", "while", "which", "what", "into",
  "not", "no", "can", "may", "will", "would", "should", "each", "both", "also",
  "called", "known", "term", "process", "carried", "out", "given", "said",
]);

// A card carrying an IMAGE is cued by the picture. The amino acid cards are
// exactly this: "{{c1::Glycine}}, {{c1::Gly}}, {{c1::G}}" beside a structure
// diagram is a real question, and stripping the image made them look empty.
const hasImage = (t) => /<img[^>]*>/i.test(t);

// Two surviving cues is enough when they carry the discrimination: "carried out
// at constant volume is called ___" leaves only "constant" and "volume", and
// "volume" is the whole question. The bar is set at fewer than two, which
// catches a card with nothing but function words left.
const MIN_CUES = 2;

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

/** The card as seen while `group` is tested: other groups revealed. */
function visible(text, group) {
  CLOZE.lastIndex = 0;
  return text.replace(CLOZE, (full, g, ans) => (+g === group ? "  " : ans));
}

const found = [];
for (const c of cards) {
  if (!c.cloze_text) continue;
  if (hasImage(c.cloze_text)) continue;
  CLOZE.lastIndex = 0;
  const groups = new Set();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) groups.add(+m[1]);

  for (const g of groups) {
    const shown = visible(c.cloze_text, g)
      .replace(/<img[^>]*>/g, " ")
      .toLowerCase();
    const cues = shown
      .split(/[^a-z0-9µΔ°%^+\-=/]+/)
      .filter(Boolean)
      .filter((w) => !FUNCTION_WORDS.has(w));
    if (cues.length >= MIN_CUES) continue;
    found.push({
      id: c.id,
      deck: deckTitle.get(c.deck_id) ?? "?",
      group: g,
      cues,
      text: c.cloze_text.replace(/\s+/g, " "),
    });
  }
}

const byCard = new Map();
for (const f of found) if (!byCard.has(f.id)) byCard.set(f.id, f);
const list = [...byCard.values()];

console.log(`cards leaving fewer than ${MIN_CUES} cues when a group is blanked: ${list.length} of ${cards.length}`);
console.log("");
for (const f of list) {
  console.log(`${f.deck}  (c${f.group})`);
  console.log(`   survives: ${f.cues.length ? f.cues.join(", ") : "(nothing)"}`);
  console.log(`   ${f.text.slice(0, 175)}`);
  console.log("");
}
