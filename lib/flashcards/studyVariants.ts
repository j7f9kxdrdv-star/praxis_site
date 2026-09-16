// ─── What the student actually sees ───────────────────────────────────────────
//
// THE AUDIT BUG THIS MODULE EXISTS TO PREVENT. The first leak judge read the
// cloze SOURCE and reasoned about it as if each {{cN::...}} token could be
// hidden on its own. It cannot. renderClozeSegments masks by GROUP:
//
//     if (m.groupIndex === activeGroup)  -> blank
//     else                               -> print the answer
//
// So {{c1::pulmonary}} ... {{c1::systemic}} is ONE study card with BOTH words
// blanked, not two cards that take turns. Judging the source instead of the
// render made the tool flag cards that were already correct, and worse, propose
// splitting them onto separate groups — which is exactly how the pulmonary /
// systemic leak got into the bank in the first place.
//
// Everything downstream of this file therefore reads a StudyVariant, never the
// raw cloze text. The variants come from the production renderer itself rather
// than a second implementation of it, so the two cannot drift apart.

import {
  findClozes,
  clozeGroupIndices,
  renderClozeSegments,
  type ClozeSegment,
} from "./cloze";

/**
 * How a masked blank is written when a rendered card is flattened to text.
 *
 * The real UI paints a filled box sized to the answer (transparent text
 * reserving width), so the student sees the answer's LENGTH but not its
 * letters. blankWidths below carries that cue explicitly; the token itself is
 * a fixed width so no judge can read letter counts out of it by accident.
 */
export const BLANK_TOKEN = "[____]";

export interface StudyVariant {
  /** The cN group masked on this card. */
  activeGroup: number;
  /** The front of the card, as text, with every masked blank replaced. */
  prompt: string;
  /** The same card after the flip, with the answers filled in. */
  revealed: string;
  /** Every answer hidden on this card. More than one when a group repeats. */
  hiddenAnswers: string[];
  /** Answers from other groups, printed in full on this card. */
  visibleAnswers: string[];
  /** Hints attached to the masked blanks, shown under the prompt. */
  hints: string[];
  /** Character width of each blank box, in source order. */
  blankWidths: number[];
  /**
   * True when this scheduled item masks nothing at all.
   *
   * Reachable in production: the session queue walks clozeIndex 1..cloze_count
   * (session/page.tsx), not the group numbers present in the text. A card
   * written with c1 and c3 has cloze_count 2, so item 2 renders with
   * activeGroup 2, matches no blank, and shows the entire card with the answers
   * in place. validateClozeText only warns about that; here it is a finding.
   */
  masksNothing: boolean;
}

/** Flatten rendered segments to the plain text a reader would see. */
function flatten(segments: ClozeSegment[], reveal: boolean): string {
  let out = "";
  for (const seg of segments) {
    if (seg.kind === "text") out += seg.text;
    else if (seg.kind === "image") out += `[image: ${seg.alt || "no alt text"}]`;
    else out += reveal ? seg.answer : BLANK_TOKEN;
  }
  return out.replace(/[ \t]+/g, " ").trim();
}

/**
 * Which study items the app will actually schedule for this card.
 *
 * Pass the stored cloze_count to audit what students really get. Leave it out
 * and you audit the text's own groups, which is what a seed-time check wants.
 */
export function scheduledIndices(clozeText: string, clozeCount?: number): number[] {
  if (typeof clozeCount === "number" && clozeCount > 0) {
    return Array.from({ length: clozeCount }, (_, i) => i + 1);
  }
  return clozeGroupIndices(clozeText);
}

/**
 * Expand one written card into the study cards it produces.
 *
 * N distinct groups give N variants. Repeating a group does NOT add a variant;
 * it adds another blank to the variant that group already owns.
 */
export function expandStudyVariants(
  clozeText: string,
  clozeCount?: number,
): StudyVariant[] {
  const matches = findClozes(clozeText);
  const out: StudyVariant[] = [];

  for (const group of scheduledIndices(clozeText, clozeCount)) {
    const masked = renderClozeSegments(clozeText, group, false);
    const shown = renderClozeSegments(clozeText, group, true);
    const hidden = matches.filter((m) => m.groupIndex === group);
    const visible = matches.filter((m) => m.groupIndex !== group);

    out.push({
      activeGroup: group,
      prompt: flatten(masked, false),
      revealed: flatten(shown, true),
      hiddenAnswers: hidden.map((m) => m.answer),
      visibleAnswers: visible.map((m) => m.answer),
      hints: hidden.map((m) => m.hint).filter((h): h is string => !!h),
      blankWidths: hidden.map((m) => m.answer.length),
      masksNothing: hidden.length === 0,
    });
  }
  return out;
}

/**
 * Close gaps in the group numbering, keeping the order.
 *
 * WHY A MERGE NEEDS THIS. Merging c2 into c1 on a four-group card leaves c1, c3,
 * c4 behind. The UPDATE then writes cloze_count 3, the session queue walks
 * indices 1, 2, 3, and index 2 matches no blank: the student is handed the whole
 * card with its answers in place. Seven of the old judge's twenty-six merge
 * suggestions had exactly this gap. The gap is clerical, not a judgement, so it
 * is closed here rather than counted against an otherwise sound rewrite.
 *
 * NOT FREE. Renumbering re-points the (user_id, flashcard_id, cloze_index)
 * scheduling unit, so saved progress on a renumbered index now refers to
 * different content. Merges already pay that cost by lowering the count; the
 * audit records every renumber so it is never a silent edit.
 */
export function renumberContiguous(text: string): string {
  const groups = clozeGroupIndices(text);
  const isContiguous = groups.every((g, i) => g === i + 1);
  if (isContiguous) return text;

  const remap = new Map(groups.map((g, i) => [g, i + 1]));
  let out = text;
  // Back to front, so earlier offsets stay valid as the string changes.
  for (const m of findClozes(text).slice().reverse()) {
    const renumbered = m.raw.replace(/^\{\{c\d+::/, `{{c${remap.get(m.groupIndex)}::`);
    out = out.slice(0, m.start) + renumbered + out.slice(m.end);
  }
  return out;
}

/**
 * Answers that are hidden together on the same study card.
 *
 * Returned as unordered normalized pairs. This is the set a rewrite is not
 * allowed to break apart: two terms masked together are being recalled as a
 * pair, and putting one of them back on screen hands over the other.
 */
export function coMaskedPairs(clozeText: string, clozeCount?: number): Set<string> {
  const pairs = new Set<string>();
  for (const v of expandStudyVariants(clozeText, clozeCount)) {
    const answers = v.hiddenAnswers.map(normalizeAnswer);
    for (let i = 0; i < answers.length; i++) {
      for (let j = i + 1; j < answers.length; j++) {
        if (answers[i] === answers[j]) continue;
        pairs.add(pairKey(answers[i], answers[j]));
      }
    }
  }
  return pairs;
}

/** Stable key for an unordered pair. */
export function pairKey(a: string, b: string): string {
  return a < b ? `${a} || ${b}` : `${b} || ${a}`;
}

/**
 * Comparison form for answer text.
 *
 * Case, spacing and dash variants are noise when asking "is this same word
 * already on screen"; the notation markup from parseScripts is too, since
 * k_(cat) and kcat are the same term to a reader.
 */
export function normalizeAnswer(s: string): string {
  return s
    .toLowerCase()
    .replace(/[_^]\(([^()]+)\)/g, "$1")
    .replace(/[‐-―−]/g, "-")
    .replace(/[‘’]/g, "'")
    .replace(/[“”]/g, '"')
    .replace(/\s+/g, " ")
    .trim();
}

/**
 * Characters that continue a word rather than ending one.
 *
 * The superscripts are here because of a real false positive: "sp" was reported
 * as visible on a card whose only other occurrence was "sp3" written with a
 * superscript three. A superscript digit is part of the term, not a space after
 * it, and sp and sp3 are different hybridisations.
 */
const WORD_CHARS = "a-z0-9\u2070\u00b9\u00b2\u00b3\u2074-\u2079\u2080-\u2089";

/**
 * Whole-word containment.
 *
 * Substring matching is useless here: "epinephrine" sits inside
 * "norepinephrine" and "oxidation" inside "beta-oxidation", and both of those
 * false positives cost real remediation time on an earlier sweep.
 */
export function containsWord(haystack: string, needle: string): boolean {
  const n = normalizeAnswer(needle);
  if (n.length < 2) return false;
  const esc = n.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return new RegExp(`(^|[^${WORD_CHARS}])${esc}([^${WORD_CHARS}]|$)`, "i").test(
    normalizeAnswer(haystack),
  );
}
