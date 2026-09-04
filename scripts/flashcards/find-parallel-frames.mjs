/*
 * Contrast cards found by SHAPE rather than by vocabulary.
 *
 *   node scripts/flashcards/find-parallel-frames.mjs
 *
 * Every other leak detector here has to be TOLD what a contrast is:
 * positive/negative, anode/cathode, relative/absolute. That list can only ever
 * be as good as the last card Mikko happened to study. He found cortex/medulla
 * on the adrenal card, and relative/absolute before that, and each time the fix
 * was to append one more pair to a list that will be wrong again tomorrow.
 *
 * This rule needs no vocabulary at all. It keys on how contrast cards are
 * WRITTEN: the author repeats a frame on both sides of the contrast.
 *
 *   "the adrenal [____] is derived from mesoderm,
 *    but THE ADRENAL medulla is derived from neural crest"
 *
 * The words immediately before the blank, "the adrenal", occur again later in
 * the visible text, and whatever sits in the slot after them is the contrast
 * partner. Whatever the subject, if the student can see the parallel clause
 * spelled out in full, the blank is answerable by symmetry rather than recall.
 *
 * Reads only. Prints a list.
 */
import { db, CLOZE, norm, page } from "./lib/contrast-vocab.mjs";

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

// A frame built only from these carries no information; "is the" repeats in
// half the bank. A frame must contain at least one word outside this set.
const FUNCTION_WORDS = new Set([
  "the", "a", "an", "of", "and", "or", "in", "on", "to", "for", "is", "are",
  "was", "were", "be", "by", "with", "from", "at", "as", "that", "this",
  "its", "it", "their", "has", "have", "both", "each", "but", "while",
  "whereas", "than", "then", "so", "if", "when", "which", "into", "not",
  "can", "may", "will", "more", "most", "less", "other", "also", "one", "two",
]);

// Must survive norm(), which lowercases and drops punctuation, so it is a
// plain alphabetic word rather than brackets or a run of underscores.
const SENTINEL = "zzblankzz";

const found = [];
for (const c of cards) {
  if (!c.cloze_text) continue;
  CLOZE.lastIndex = 0;
  const groups = new Set();
  let m;
  while ((m = CLOZE.exec(c.cloze_text)) !== null) groups.add(+m[1]);

  for (const g of groups) {
    // The card as the student sees it, with the tested blank marked so its
    // position is recoverable after normalisation.
    const marked = c.cloze_text.replace(CLOZE, (full, gg, ans) => (+gg === g ? ` ${SENTINEL} ` : ans));
    const toks = norm(marked).split(" ").filter(Boolean);
    const at = toks.indexOf(SENTINEL);
    if (at < 2) continue; // need room for a frame in front of it

    let hit = null;
    // Longest frame first: a 3-word repeat is stronger evidence of deliberate
    // parallelism than a 2-word one.
    for (const k of [3, 2]) {
      if (at < k) continue;
      const frame = toks.slice(at - k, at);
      if (frame.includes(SENTINEL)) continue;
      if (frame.every((w) => FUNCTION_WORDS.has(w))) continue;

      for (let i = 0; i + k < toks.length; i++) {
        if (i === at - k) continue; // that is the blank's own frame
        let same = true;
        for (let j = 0; j < k; j++) {
          if (toks[i + j] !== frame[j]) { same = false; break; }
        }
        if (!same) continue;
        const partner = toks[i + k];
        if (!partner || partner === SENTINEL || FUNCTION_WORDS.has(partner)) continue;
        hit = { frame: frame.join(" "), partner };
        break;
      }
      if (hit) break;
    }
    if (!hit) continue;
    found.push({
      id: c.id, deck: deckTitle.get(c.deck_id) ?? "?", group: g,
      reason: `frame "${hit.frame}" repeats before "${hit.partner}"`,
      text: c.cloze_text.replace(/\s+/g, " "),
    });
  }
}

const byCard = new Map();
for (const f of found) if (!byCard.has(f.id)) byCard.set(f.id, f);
const list = [...byCard.values()];
console.log(`cards whose blank is mirrored by a parallel clause: ${list.length} of ${cards.length}`);
console.log("");
for (const f of list) {
  console.log(`${f.deck}  (c${f.group})`);
  console.log(`   ${f.reason}`);
  console.log(`   ${f.text.slice(0, 185)}`);
  console.log("");
}
