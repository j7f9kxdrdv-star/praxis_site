/*
 * Shared vocabulary and helpers for the flashcard leak detectors.
 *
 * This file exists because the pair list had been copy-pasted into three
 * separate scripts. Mikko found a card leaking on "relative / absolute", a pair
 * none of them knew, and adding it in one place would have fixed one detector
 * out of three. The vocabulary now lives here and every detector imports it, so
 * a pair learned once is known everywhere.
 *
 * Used by:
 *   find-split-contrasts.mjs   one half of a pair hidden in a SIBLING BLANK
 *   find-stem-leaks.mjs        one half of a pair sitting in PLAIN STEM TEXT
 *   find-acronym-leaks.mjs     an answer spelled out, or abbreviated, nearby
 */
import { createClient } from "@supabase/supabase-js";
import fs from "fs";

export const env = Object.fromEntries(
  fs.readFileSync(".env.local", "utf8").split("\n")
    .filter((l) => l.includes("=") && !l.trim().startsWith("#"))
    .map((l) => [l.slice(0, l.indexOf("=")).trim(), l.slice(l.indexOf("=") + 1).trim()]),
);
export const db = createClient(env.NEXT_PUBLIC_SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY);

// Oppositions where knowing one half determines the other. Deliberately
// conservative: only pairs that are genuinely binary in MCAT usage. A pair that
// merely names two members of a larger set does NOT belong here, because
// showing one of three does not give away another.
export const PAIRS = [
  ["increases", "decreases"], ["increase", "decrease"], ["higher", "lower"],
  ["more", "less"], ["greater", "smaller"], ["positive", "negative"],
  ["hydrophilic", "hydrophobic"], ["polar", "nonpolar"], ["distal", "proximal"],
  ["afferent", "efferent"], ["agonist", "antagonist"], ["anabolic", "catabolic"],
  ["oxidation", "reduction"], ["oxidized", "reduced"], ["endothermic", "exothermic"],
  ["endergonic", "exergonic"], ["anterior", "posterior"], ["dorsal", "ventral"],
  ["horizontal", "vertical"], ["sympathetic", "parasympathetic"],
  ["telencephalon", "diencephalon"], ["visceral", "parietal"],
  ["competitive", "noncompetitive"], ["reversible", "irreversible"],
  ["prefix", "suffix"], ["stimulates", "inhibits"], ["activates", "inhibits"],
  ["intracellular", "extracellular"], ["hyperpolarization", "depolarization"],
  ["systolic", "diastolic"], ["inspiration", "expiration"],
  ["anode", "cathode"], ["aerobic", "anaerobic"], ["donates", "accepts"],
  ["vein", "arteries"], ["vein", "artery"], ["veins", "arteries"],
  ["oxygenated", "deoxygenated"], ["heat", "solutes"],
  ["absorbs", "releases"], ["influx", "efflux"], ["inhalation", "exhalation"],

  // Added after Mikko hit the configuration card. "Relative configuration
  // compares one molecule to another ... Absolute configuration specifies the
  // exact arrangement" blanks only the first, and the second is right there.
  ["relative", "absolute"],
  // The rest are the same shape: strictly two-valued in MCAT usage, so showing
  // one half determines the other.
  ["concave", "convex"], ["constructive", "destructive"],
  ["transverse", "longitudinal"], ["series", "parallel"],
  ["dominant", "recessive"], ["homozygous", "heterozygous"],
  ["genotype", "phenotype"], ["excitatory", "inhibitory"],
  ["sensory", "motor"], ["exon", "intron"], ["exons", "introns"],
  ["upstream", "downstream"], ["reactant", "product"], ["reactants", "products"],
  ["cis", "trans"], ["kinetic", "thermodynamic"],
  ["absorption", "emission"], ["acidic", "basic"],
  ["endocytosis", "exocytosis"], ["prokaryotic", "eukaryotic"],

  // Added after the Aufbau card: "For an ANION ... For a [cation]". The
  // parallel-frame detector missed it because the frames differ by one word,
  // "for an" against "for a", so the pair list still earns its keep for the
  // most common binaries even though it can never be complete.
  ["anion", "cation"], ["anions", "cations"],
  ["nucleophile", "electrophile"], ["purine", "pyrimidine"],
  ["monomer", "polymer"], ["scalar", "vector"],
  ["solute", "solvent"], ["ionic", "covalent"],
  ["enantiomer", "diastereomer"], ["enantiomers", "diastereomers"],
  ["real", "virtual"], ["glycolysis", "gluconeogenesis"],

  // Hormone antagonists. Added after the endometrium card, where "Estrogen"
  // was blanked and "progesterone" sat in the parallel clause.
  ["estrogen", "progesterone"], ["insulin", "glucagon"],
  ["calcitonin", "parathyroid"],
];

// ORDERED SERIES, not pairs. Mikko found the bond-composition card:
//
//   "a {c1 single} bond is 1 sigma; a {c2 double} bond is 1 sigma + 1 pi;
//    a {c3 triple} bond is 1 sigma + 2 pi"
//
// Nothing here is an opposite, so every pair-based rule was blind to it. But
// seeing two members of a counted sequence hands you the third just as surely
// as seeing one half of a contrast hands you the other. A series member in one
// group and another member in a DIFFERENT group is the same defect.
export const SERIES = [
  ["single", "double", "triple", "quadruple"],
  ["primary", "secondary", "tertiary", "quaternary"],
  ["mono", "di", "tri", "tetra"],
  ["first", "second", "third", "fourth"],
  ["alpha", "beta", "gamma", "delta"],
  ["one", "two", "three", "four"],
  ["initiation", "elongation", "termination"],
  ["prophase", "metaphase", "anaphase", "telophase"],
  ["sensory", "integration", "motor"],
  ["absorption", "distribution", "metabolism", "excretion"],
];

/** Are two answers different members of the same ordered series? */
export function sameSeries(a, b) {
  const has = (ans, term) => ans === term || ans.split(" ").includes(term);
  for (const list of SERIES) {
    const ia = list.findIndex((t) => has(a, t));
    const ib = list.findIndex((t) => has(b, t));
    if (ia >= 0 && ib >= 0 && ia !== ib) {
      return `"${list[ia]}" and "${list[ib]}" are members of the same series`;
    }
  }
  return null;
}

// A better rule than the list above, because it generalises: two answers that
// share a root and differ only by an opposing prefix are a contrast, whatever
// the root is. preganglionic/postganglionic was missed by the explicit list and
// caught by this. Each entry is a prefix pair that reverses meaning.
export const PREFIXES = [
  ["pre", "post"], ["hyper", "hypo"], ["endo", "exo"], ["intra", "extra"],
  // Counting prefixes. Mikko found the twin card, where "Monozygotic" sat in
  // plain stem text beside a blanked "dizygotic". These also appear in SERIES,
  // but that rule only compares one BLANK against another; a giveaway sitting
  // in unblanked prose needs the prefix rule to catch it.
  ["mono", "di"], ["mono", "poly"], ["homo", "hetero"], ["uni", "bi"],
  ["intra", "inter"], ["macro", "micro"], ["anti", "pro"], ["sub", "supra"],
  ["afferent", "efferent"], ["ana", "cata"], ["ecto", "endo"],
];

// One answer being the other with a NEGATING prefix is the same defect by a
// different route: anaerobic is an + aerobic, nonpolar is non + polar,
// irreversible is ir + reversible. Like the opposing-prefix rule this needs no
// vocabulary listed in advance, which is the point.
export const NEGATORS = ["an", "a", "non", "un", "in", "im", "ir", "il", "anti", "de", "dis"];

export function negatedPair(a, b) {
  for (const [x, y] of [[a, b], [b, a]]) {
    for (const n of NEGATORS) {
      if (x.startsWith(n) && x.slice(n.length) === y && y.length >= 5) return `${n}- negation of "${y}"`;
    }
  }
  return null;
}

/** Do two answers share a root but carry opposing prefixes? */
export function opposingPrefix(a, b) {
  for (const [p, q] of PREFIXES) {
    for (const [x, y] of [[p, q], [q, p]]) {
      if (a.startsWith(x) && b.startsWith(y)) {
        const ra = a.slice(x.length), rb = b.slice(y.length);
        // Require a real shared root, not two short words that happen to match.
        if (ra.length >= 4 && ra === rb) return `${x}- / ${y}- on "${ra}"`;
      }
    }
  }
  return null;
}

/**
 * Are two ANSWERS related, comparing word by word?
 *
 * opposingPrefix and negatedPair both require the root to match exactly, so
 * they only ever worked on single-word answers. Fed a whole phrase they fail
 * silently:
 *
 *   "monozygotic identical" vs "dizygotic fraternal"   -> no match
 *   "monozygotic"           vs "dizygotic"             -> mono- / di- on "zygotic"
 *
 * Mikko found the twin card that this had been letting through. Every
 * multi-word answer in the bank was invisible to those two rules until now.
 */
export function relatedAnswers(a, b) {
  const wa = String(a).split(" ").filter(Boolean);
  const wb = String(b).split(" ").filter(Boolean);
  for (const x of wa) {
    for (const y of wb) {
      if (x === y) continue;
      const hit = opposingPrefix(x, y) || negatedPair(x, y) || sameSeries(x, y);
      if (hit) return hit;
    }
  }
  return null;
}

export const CLOZE = /\{\{c(\d+)::([\s\S]+?)(?:::([\s\S]+?))?\}\}/g;
export const norm = (s) => s.toLowerCase().replace(/[^a-z0-9 ]/g, " ").replace(/\s+/g, " ").trim();

/** Every row of a table. A .range() loop needs a stable .order() or it repeats. */
export async function page(t, cols, order) {
  const out = [];
  for (let f = 0; ; f += 1000) {
    let q = db.from(t).select(cols);
    for (const c of order) q = q.order(c, { ascending: true });
    const { data, error } = await q.range(f, f + 999);
    if (error) throw new Error(error.message);
    if (!data.length) break;
    out.push(...data);
    if (data.length < 1000) break;
  }
  return out;
}

/** The card as a student sees it while `group` is being tested. */
export function visibleText(text, group) {
  CLOZE.lastIndex = 0;
  return text.replace(CLOZE, (full, g, ans) => (+g === group ? "   " : ans));
}

/** Group number -> list of normalised answers. */
export function groupsOf(text) {
  CLOZE.lastIndex = 0;
  const groups = new Map();
  let m;
  while ((m = CLOZE.exec(text)) !== null) {
    if (!groups.has(+m[1])) groups.set(+m[1], []);
    groups.get(+m[1]).push(norm(m[2]));
  }
  return groups;
}
