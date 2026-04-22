// ─── Cloze parser ─────────────────────────────────────────────────────────────
//
// Cloze syntax (admin-authored content):
//   "The {{c1::mitochondria}} produces ATP via {{c2::oxidative phosphorylation::energy step}}."
//
// - {{cN::answer}}                — answer with no hint
// - {{cN::answer::hint}}          — answer with a hint shown while masked
// - Multiple groups with the same N collapse together (rare, but supported)
//
// At study time, a card with N distinct cN groups expands into N "review items"
// (one per group). Item k masks cN=k and reveals everything else.

const CLOZE_RE = /\{\{c(\d+)::([\s\S]+?)(?:::([\s\S]+?))?\}\}/g;

export interface ClozeMatch {
  groupIndex: number; // the cN number (1-based)
  answer: string;
  hint?: string;
  start: number; // index in source string
  end: number;   // index in source string (exclusive)
  raw: string;   // full {{cN::...}} token
}

/** Find every {{cN::...}} occurrence in the source text. */
export function findClozes(text: string): ClozeMatch[] {
  const out: ClozeMatch[] = [];
  CLOZE_RE.lastIndex = 0;
  let m: RegExpExecArray | null;
  while ((m = CLOZE_RE.exec(text)) !== null) {
    out.push({
      groupIndex: parseInt(m[1], 10),
      answer: m[2],
      hint: m[3],
      start: m.index,
      end: m.index + m[0].length,
      raw: m[0],
    });
  }
  return out;
}

/** Number of distinct cN groups in the source text (1, 2, 3, ...). */
export function countClozeGroups(text: string): number {
  const groups = new Set<number>();
  for (const c of findClozes(text)) groups.add(c.groupIndex);
  return groups.size;
}

/** All distinct cN group indices, sorted ascending. */
export function clozeGroupIndices(text: string): number[] {
  const groups = new Set<number>();
  for (const c of findClozes(text)) groups.add(c.groupIndex);
  return Array.from(groups).sort((a, b) => a - b);
}

// ─── Render segments ──────────────────────────────────────────────────────────

export type ClozeSegment =
  | { kind: "text"; text: string }
  | { kind: "blank"; groupIndex: number; answer: string; hint?: string; revealed: boolean };

/**
 * Build a segment list for rendering a single review item.
 *
 * @param text         - source cloze text
 * @param activeGroup  - which cN group is the masked target for this item
 * @param revealActive - whether the active blank should display its answer
 *
 * Non-active cN groups are always shown as their answer (Anki behavior).
 * The active group is shown as a masked blank, then revealed when the user flips.
 */
export function renderClozeSegments(
  text: string,
  activeGroup: number,
  revealActive: boolean,
): ClozeSegment[] {
  const matches = findClozes(text);
  const segs: ClozeSegment[] = [];
  let cursor = 0;

  for (const m of matches) {
    if (m.start > cursor) {
      segs.push({ kind: "text", text: text.slice(cursor, m.start) });
    }
    if (m.groupIndex === activeGroup) {
      segs.push({
        kind: "blank",
        groupIndex: m.groupIndex,
        answer: m.answer,
        hint: m.hint,
        revealed: revealActive,
      });
    } else {
      // Non-active groups: render as their answer text inline.
      segs.push({ kind: "text", text: m.answer });
    }
    cursor = m.end;
  }
  if (cursor < text.length) {
    segs.push({ kind: "text", text: text.slice(cursor) });
  }
  return segs;
}

// ─── Validation (used by seed scripts) ────────────────────────────────────────

export interface ClozeValidationResult {
  valid: boolean;
  errors: string[];
  warnings: string[];
  groupCount: number;
}

/**
 * Validate cloze text before storing. Catches the common authoring mistakes:
 * - no cloze tokens at all
 * - empty answer
 * - non-contiguous group numbering (e.g. c1, c3 with no c2)
 * - trailing/leading whitespace inside the answer
 */
export function validateClozeText(text: string): ClozeValidationResult {
  const errors: string[] = [];
  const warnings: string[] = [];
  const matches = findClozes(text);

  if (matches.length === 0) {
    errors.push("No cloze tokens found. Use {{c1::answer}} syntax.");
    return { valid: false, errors, warnings, groupCount: 0 };
  }

  for (const m of matches) {
    if (!m.answer.trim()) {
      errors.push(`Empty answer in ${m.raw}`);
    }
    if (m.answer !== m.answer.trim()) {
      warnings.push(`Whitespace around answer in ${m.raw}`);
    }
    if (m.groupIndex < 1) {
      errors.push(`Cloze group must be >= 1 (found c${m.groupIndex})`);
    }
  }

  const groups = clozeGroupIndices(text);
  // Expect contiguous 1..N
  for (let i = 0; i < groups.length; i++) {
    if (groups[i] !== i + 1) {
      warnings.push(
        `Cloze groups should be contiguous starting at c1. Found: ${groups.join(", ")}`,
      );
      break;
    }
  }

  return {
    valid: errors.length === 0,
    errors,
    warnings,
    groupCount: groups.length,
  };
}

// ─── Plain-text helpers ───────────────────────────────────────────────────────

/** Strip cloze syntax for previews/listings — replaces blanks with their answers. */
export function clozeToPlain(text: string): string {
  return text.replace(CLOZE_RE, (_full, _n, answer) => answer);
}

/** Mask all clozes (e.g. "The ___ produces ATP via ___.") for preview chips. */
export function clozeToMaskedPreview(text: string, mask: string = "____"): string {
  return text.replace(CLOZE_RE, () => mask);
}
