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
  | { kind: "blank"; groupIndex: number; answer: string; hint?: string; revealed: boolean }
  | { kind: "image"; src: string; alt: string };

// Matches a self-closing or open <img> tag with src and optional alt attributes.
// Intentionally narrow — we don't accept arbitrary HTML, only this one tag.
// Examples: <img src="/foo.png"> · <img alt="bar" src='/foo.png' /> · <img src="..." alt="...">
const IMG_RE =
  /<img\s+(?=[^>]*\bsrc\s*=)[^>]*?>/gi;
const ATTR_RE = /\b(src|alt)\s*=\s*(?:"([^"]*)"|'([^']*)')/gi;

function splitTextOnImages(
  text: string,
): { kind: "text"; text: string }[] | { kind: "image"; src: string; alt: string }[] {
  const out: ClozeSegment[] = [];
  let cursor = 0;
  IMG_RE.lastIndex = 0;
  let m: RegExpExecArray | null;
  while ((m = IMG_RE.exec(text)) !== null) {
    if (m.index > cursor) {
      out.push({ kind: "text", text: text.slice(cursor, m.index) });
    }
    let src = "";
    let alt = "";
    ATTR_RE.lastIndex = 0;
    let a: RegExpExecArray | null;
    while ((a = ATTR_RE.exec(m[0])) !== null) {
      const name = a[1].toLowerCase();
      const value = a[2] ?? a[3] ?? "";
      if (name === "src") src = value;
      else if (name === "alt") alt = value;
    }
    if (src) out.push({ kind: "image", src, alt });
    cursor = m.index + m[0].length;
  }
  if (cursor < text.length) {
    out.push({ kind: "text", text: text.slice(cursor) });
  }
  // Returned shape is "ClozeSegment[]" — only "text" and "image" kinds though.
  // (Loose type signature above just keeps callers happy.)
  return out as ClozeSegment[] as never;
}

/**
 * Build a segment list for rendering a single review item.
 *
 * Image support added 2026-05: cards may embed an <img src="..." alt="...">
 * tag and the renderer will emit an "image" segment for the UI to mount as
 * an <img> element. See splitTextOnImages above.
 *
 * @param text         - source cloze text
 * @param activeGroup  - which cN group is the masked target for this item
 * @param revealActive - whether the active blank should display its answer
 *
 * Non-active cN groups are always shown as their answer (Anki behavior).
 * The active group is shown as a masked blank, then revealed when the user flips.
 *
 * Text-kind segments can additionally contain <img src="..." alt="..."> tags;
 * those are extracted into separate "image" segments so the renderer can mount
 * a real <Image> element rather than rendering the tag as plain text.
 */
export function renderClozeSegments(
  text: string,
  activeGroup: number,
  revealActive: boolean,
): ClozeSegment[] {
  const matches = findClozes(text);
  const raw: ClozeSegment[] = [];
  let cursor = 0;

  for (const m of matches) {
    if (m.start > cursor) {
      raw.push({ kind: "text", text: text.slice(cursor, m.start) });
    }
    if (m.groupIndex === activeGroup) {
      raw.push({
        kind: "blank",
        groupIndex: m.groupIndex,
        answer: m.answer,
        hint: m.hint,
        revealed: revealActive,
      });
    } else {
      // Non-active groups: render as their answer text inline.
      raw.push({ kind: "text", text: m.answer });
    }
    cursor = m.end;
  }
  if (cursor < text.length) {
    raw.push({ kind: "text", text: text.slice(cursor) });
  }

  // Second pass: expand <img> tags inside text segments into image segments.
  const out: ClozeSegment[] = [];
  for (const seg of raw) {
    if (seg.kind !== "text" || !seg.text.includes("<img")) {
      out.push(seg);
      continue;
    }
    const sub = splitTextOnImages(seg.text) as unknown as ClozeSegment[];
    for (const s of sub) out.push(s);
  }
  return out;
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

  // Nested cloze tokens ({{...{{...}}...}}) break the flat, non-greedy renderer —
  // it closes on the first "}}", mangling both the answer and the trailing text.
  // Detect any point where brace-pair depth exceeds 1.
  let depth = 0;
  for (let i = 0; i < text.length - 1; i++) {
    if (text[i] === "{" && text[i + 1] === "{") {
      depth++;
      i++;
      if (depth >= 2) {
        errors.push("Nested cloze tokens are not supported ({{ ... {{ ... }} ... }}).");
        break;
      }
    } else if (text[i] === "}" && text[i + 1] === "}") {
      depth--;
      i++;
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
  return text.replace(CLOZE_RE, (_full, _n, answer) => answer).replace(IMG_RE, "");
}

/** Mask all clozes (e.g. "The ___ produces ATP via ___.") for preview chips. */
export function clozeToMaskedPreview(text: string, mask: string = "____"): string {
  return text.replace(CLOZE_RE, () => mask).replace(IMG_RE, "");
}

// ─── Subscripts and superscripts ──────────────────────────────────────────
//
// Card text is plain Unicode, which cannot express most scientific notation.
// Unicode has subscript forms for only a e h i j k l m n o p r s t u v x, so
// K_m is writable as Kₘ but V_max, k_cat, Z_eff and K_sp are not: there are no
// multi-character subscripts at all. Cards were therefore written flat, and
// "W = h · fT" reads as h times f times T rather than f subscript T.
//
// So the notation moves into markup the renderer understands rather than
// characters the font has to provide:
//
//   k_{cat}   ->  k with a subscript "cat"
//   10^{-5}   ->  10 with a superscript "-5"
//
// Deliberately NOT LaTeX. The braces delimit exactly one run, there is nothing
// to escape, and an unmatched brace renders as itself rather than swallowing
// the rest of the card.

export type Script = "sub" | "sup" | null;
export interface TextRun {
  text: string;
  script: Script;
}

const SCRIPT_RE = /([_^])\{([^{}]+)\}/g;

/**
 * Split a string into runs of normal, subscript and superscript text.
 *
 * Always returns at least one run, so a caller can map over the result without
 * a special case for plain text.
 */
export function parseScripts(input: string): TextRun[] {
  const out: TextRun[] = [];
  let cursor = 0;
  SCRIPT_RE.lastIndex = 0;
  let m: RegExpExecArray | null;
  while ((m = SCRIPT_RE.exec(input)) !== null) {
    if (m.index > cursor) out.push({ text: input.slice(cursor, m.index), script: null });
    out.push({ text: m[2], script: m[1] === "_" ? "sub" : "sup" });
    cursor = m.index + m[0].length;
  }
  if (cursor < input.length) out.push({ text: input.slice(cursor), script: null });
  return out.length ? out : [{ text: input, script: null }];
}

/** The string as a reader sees it, with the markup removed. */
export function stripScripts(input: string): string {
  return input.replace(SCRIPT_RE, "$2");
}
