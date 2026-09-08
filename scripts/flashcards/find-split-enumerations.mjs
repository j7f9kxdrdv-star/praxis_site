/*
 * Lists whose members are split across different cloze groups.
 *
 *   node scripts/flashcards/find-split-enumerations.mjs
 *
 * Mikko found this on the antibody card:
 *
 *   "Secreted antibodies fight pathogens by {c1 neutralization} (blocking
 *    infective sites), {c2 opsonization} (tagging them for phagocytes), and
 *    {c3 agglutination} (clumping them together)."
 *
 * Three members of one list, three separate groups, so asking for any one of
 * them prints the other two. Not a contrast and not a counted sequence, so the
 * pair rules and the series rule were both blind to it.
 *
 * THE SIGNATURE IS THE PARALLEL GLOSS. An author writing a list of terms with a
 * definition after each one produces a very particular shape:
 *
 *   {{cA::term}} (gloss), {{cB::term}} (gloss), and {{cC::term}} (gloss)
 *
 * Three or more blanks in a row, each immediately followed by a parenthetical,
 * separated only by list punctuation. That is mechanical to spot and almost
 * never occurs by accident, which is why this rule can be trusted in a way the
 * count-word rule could not: THAT one looked for a stem saying "two" or "three"
 * and flagged 203 cards, nearly all of them ordinary prose.
 *
 * Reads only. Prints a list.
 */
import { db, CLOZE, page } from "./lib/contrast-vocab.mjs";

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

/**
 * Find runs of glossed list members: a blank, a parenthetical, list
 * punctuation, another blank, and so on. Returns the groups involved.
 */
function glossedRun(text) {
  // A blank followed by its parenthetical gloss.
  const ITEM = /\{\{c(\d+)::([^}]+)\}\}\s*\(([^)]+)\)/g;
  const items = [];
  let m;
  ITEM.lastIndex = 0;
  while ((m = ITEM.exec(text)) !== null) {
    items.push({ group: +m[1], term: m[2], gloss: m[3], start: m.index, end: ITEM.lastIndex });
  }
  if (items.length < 3) return null;

  // Only count them as ONE list if consecutive items are separated by nothing
  // but list punctuation. Two unrelated glossed blanks at opposite ends of a
  // card are not an enumeration.
  const runs = [];
  let run = [items[0]];
  for (let i = 1; i < items.length; i++) {
    const between = text.slice(items[i - 1].end, items[i].start);
    if (/^[\s,;]*(and|or)?[\s,;]*$/i.test(between)) {
      run.push(items[i]);
    } else {
      if (run.length >= 3) runs.push(run);
      run = [items[i]];
    }
  }
  if (run.length >= 3) runs.push(run);

  for (const r of runs) {
    const groups = new Set(r.map((x) => x.group));
    if (groups.size > 1) return { run: r, groups: [...groups].sort((a, b) => a - b) };
  }
  return null;
}

const found = [];
for (const c of cards) {
  if (!c.cloze_text || (c.cloze_count ?? 0) < 2) continue;
  const hit = glossedRun(c.cloze_text);
  if (!hit) continue;
  found.push({
    id: c.id,
    deck: deckTitle.get(c.deck_id) ?? "?",
    groups: hit.groups,
    terms: hit.run.map((x) => x.term),
    text: c.cloze_text.replace(/\s+/g, " "),
  });
}

console.log(`lists whose members sit in different groups: ${found.length} of ${cards.length}`);
console.log("");
for (const f of found) {
  console.log(`${f.deck}`);
  console.log(`   ${f.terms.length} glossed items across groups ${f.groups.join(", ")}: ${f.terms.join(" / ")}`);
  console.log(`   ${f.text.slice(0, 175)}`);
  console.log("");
}
