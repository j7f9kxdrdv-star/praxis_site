/*
 * Subscripts written flat, swept bank-wide.
 *
 *   node scripts/flashcards/fix-flat-subscripts.mjs        # report only
 *   node scripts/flashcards/fix-flat-subscripts.mjs --sql  # write the fix file
 *
 * Mikko hit this on the buoyancy card:
 *
 *   "The buoyant force is Fb = ρfluid·Vdisp·g, where ρfluid is the fluid's
 *    density, Vdisp is the volume of fluid displaced ..."
 *
 * Every subscript is missing, so "ρfluid·Vdisp·g" reads as six variables
 * multiplied together. The renderer has understood k_(cat) notation since the
 * subscript work in cloze.ts; these cards were simply written before it, or
 * written flat by hand afterwards.
 *
 * WHY A SWEEP AND NOT ANOTHER ONE-OFF. supabase/fixes already holds five
 * separate files for this one defect: fix_ecell_subscripts, fix_sg_subscript_card,
 * fix_lambda_theta_subscripts, fix_force_subscript_mashes, fix_thermo_subscript_mashes.
 * Each fixed the card in front of it. This finds the rest in one pass.
 *
 * THE HARD PART IS TELLING A SUBSCRIPT FROM A PRODUCT. The same shape means
 * both things:
 *
 *   Fb = ρfluid·Vdisp·g     F sub b            -> broken
 *   W = Fd                  F times d          -> correct as written
 *   P = Fv                  F times v          -> correct
 *   Q = Av                  A times v          -> correct
 *   k = Ae^(-Ea/RT)         A times e^...      -> correct
 *   Fg = Gm₁m₂/r²           F sub g, G times m -> both in one expression
 *
 * No rule decides that: it is physics, not typography. So the detector's job
 * is only to produce a short candidate list, and the substitutions below were
 * chosen by reading every one. The scan that produced them is kept in
 * find-flat-subscripts.mjs so the next batch of cards can be checked the same
 * way.
 *
 * SAFETY. Every edit is checked to be notation-only: strip the markup back off
 * and the card must read exactly as it did before. A rule that changed a word
 * would fail that check and stop the run.
 */
import { db, page } from "./lib/contrast-vocab.mjs";
import fs from "fs";

const WRITE_SQL = process.argv.includes("--sql");

// ─── Substitutions ─────────────────────────────────────────────────────────
// Applied wherever the token stands alone (no letter either side). Each was
// read in place first; see the header on why this cannot be automatic.
const GLOBAL = [
  // Fluids: the card Mikko found, and its sibling.
  ["Fb", "F_(b)"], ["ρfluid", "ρ_(fluid)"], ["Vdisp", "V_(disp)"],
  ["Fg", "F_(g)"],

  // Mechanics and energy.
  ["Fnet", "F_(net)"], ["Wnet", "W_(net)"], ["Wnc", "W_(nc)"],
  ["Ug", "U_(g)"], ["Kmax", "K_(max)"], ["Ki", "K_(i)"],

  // Circuits: the equivalent-resistance and equivalent-capacitance formulas.
  ["Ceq", "C_(eq)"], ["Req", "R_(eq)"],

  // Equilibrium and solutions.
  ["Kc", "K_(c)"], ["Kp", "K_(p)"], ["Kd", "K_(d)"], ["Kf", "K_(f)"],
  ["ΔTb", "ΔT_(b)"], ["ΔTf", "ΔT_(f)"], ["ΔG°f", "ΔG°_(f)"],
  ["χsolvent", "χ_(solvent)"], ["P°solvent", "P°_(solvent)"],

  // Gases and thermodynamics.
  ["urms", "u_(rms)"], ["Cp", "C_(p)"], ["Cv", "C_(v)"],

  // Optics.
  ["mtotal", "m_(total)"],

  // Biochemistry: inorganic phosphate, transport maximum, the G-protein family.
  ["Pi", "P_(i)"], ["Tmax", "T_(max)"], ["Gq", "G_(q)"],

  // Electrochemistry: written with real parentheses, which the renderer shows
  // as parentheses. E°(cell) is E sub cell, not E° of a function called cell.
  ["E°(cell)", "E°_(cell)"], ["E°(cathode)", "E°_(cathode)"], ["E°(anode)", "E°_(anode)"],

  // pK values, for consistency with the K_(a) and K_(b) they refer to.
  ["pKa", "pK_(a)"], ["pKb", "pK_(b)"],
];

// Tokens that are ordinary English words elsewhere in the bank ("By the end of
// meiosis II"), so they are only substituted on the cards where they are vector
// components. Same for the Unicode subscripts: those render correctly on their
// own and are only touched where one expression mixes both notations, e.g.
// "√(Rₓ² + Ry²)", where the x is a subscript and the y is not.
const PER_CARD = {
  "7513b03d-c427-40a3-9723-ff03c2971d10": [["Rₓ", "R_(x)"], ["Ry", "R_(y)"]],
  "94a5254d-35e8-4573-97c2-2e34db7558ea": [
    ["Rₓ", "R_(x)"], ["Aₓ", "A_(x)"], ["Bₓ", "B_(x)"],
    ["Ry", "R_(y)"], ["Ay", "A_(y)"], ["By", "B_(y)"],
  ],
  "31d8f65e-5bbc-484d-91bf-f944cccf43fc": [["χᵢ", "χ_(i)"], ["nᵢ", "n_(i)"]],
  "1e2fb2ee-0000-0000-0000-000000000000": [], // placeholder, replaced below
};
delete PER_CARD["1e2fb2ee-0000-0000-0000-000000000000"];

const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
/**
 * The token, with no ASCII letter glued to either end.
 *
 * EXCEPT after a degree sign. "E°(cell)" is written "-nFE°(cell)" on three
 * cards, glued to the n and F beside it, and a left boundary silently skipped
 * exactly those: one card came out with its first E°(cell) flat and its second
 * marked up. A token carrying a ° cannot be the tail of an English word, so it
 * does not need the guard.
 */
const boundary = (tok) =>
  new RegExp(`${tok.includes("°") ? "" : "(?<![A-Za-z])"}${esc(tok)}(?![A-Za-z])`, "gu");

// ─── The safety check ──────────────────────────────────────────────────────
// What a reader sees, with notation flattened: markup removed, Unicode
// subscript letters folded to plain ones, parentheses dropped. If this differs
// before and after, the edit changed the card rather than its typography.
const SUBS = { "ₐ":"a","ₑ":"e","ₕ":"h","ᵢ":"i","ⱼ":"j","ₖ":"k","ₗ":"l","ₘ":"m",
  "ₙ":"n","ₒ":"o","ₚ":"p","ᵣ":"r","ₛ":"s","ₜ":"t","ᵤ":"u","ᵥ":"v","ₓ":"x" };
const reading = (s) =>
  s.replace(/[_^]\(([^()]+)\)/g, "$1")
   .replace(/[ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓ]/g, (c) => SUBS[c])
   .replace(/[()]/g, "");

const cards = await page("flashcards", "id,deck_id,cloze_text,cloze_count", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

const changed = [];
let bad = 0;
for (const c of cards) {
  if (!c.cloze_text) continue;
  let next = c.cloze_text;
  const applied = [];
  for (const [from, to] of [...GLOBAL, ...(PER_CARD[c.id] ?? [])]) {
    const re = boundary(from);
    const hits = (next.match(re) ?? []).length;
    if (!hits) continue;
    next = next.replace(re, to);
    applied.push(`${from} -> ${to}${hits > 1 ? ` (${hits}x)` : ""}`);
  }
  if (next === c.cloze_text) continue;

  if (reading(next) !== reading(c.cloze_text)) {
    console.log(`REFUSED ${c.id}: the reading changed, not just the notation`);
    console.log(`   was: ${reading(c.cloze_text)}`);
    console.log(`   now: ${reading(next)}`);
    bad++;
    continue;
  }
  changed.push({ ...c, next, applied });
}

for (const c of changed) {
  console.log(`${deckTitle.get(c.deck_id)}   ${c.applied.join(", ")}`);
  console.log(`   ${c.next.replace(/\s+/g, " ").slice(0, 190)}`);
}
console.log(`\n${changed.length} cards, ${bad} refused`);

if (!WRITE_SQL) process.exit(bad ? 1 : 0);
if (bad) { console.log("not writing SQL while a card is refused"); process.exit(1); }

const q = (s) => `'${s.replace(/'/g, "''")}'`;
let sql = `-- Subscripts written flat, swept bank-wide (${changed.length} cards).
--
-- Mikko found this on the buoyancy card: "Fb = ρfluid·Vdisp·g" reads as six
-- variables multiplied together, because none of the subscripts were marked up.
-- The renderer has understood k_(cat) notation since the subscript work in
-- lib/flashcards/cloze.ts; these cards were written flat.
--
-- Five earlier files in this directory each fixed one card of this same defect.
-- This is the sweep: generated by scripts/flashcards/fix-flat-subscripts.mjs,
-- and every edit verified to be notation-only. Strip the markup back off and
-- each card reads exactly as it did before, so no question has changed.
--
-- NO SCHEDULE RESET. Unlike the merge fixes, nothing here changes what a card
-- asks or how many blanks it has. Resetting would throw away real progress for
-- a change of typography.
--
-- Deliberately NOT changed: W = Fd, P = Fv, Q = Av, k = Ae^(-Ea/RT), Gm₁m₂/r².
-- Those are products, not subscripts. Same shape on the page, opposite meaning.

BEGIN;

`;
for (const c of changed) {
  sql += `-- ${deckTitle.get(c.deck_id)}: ${c.applied.join(", ")}\n`;
  sql += `UPDATE public.flashcards SET cloze_text = ${q(c.next)} WHERE id = '${c.id}';\n\n`;
}
sql += "COMMIT;\n";
const out = "supabase/fixes/20260908_fix_flat_subscripts.sql";
fs.writeFileSync(out, sql);
console.log(`\nwrote ${out}`);
