/*
 * Subscripts written as plain adjacent characters.
 *
 *   node scripts/flashcards/find-flat-subscripts.mjs
 *
 * "Fb = ρfluid·Vdisp·g" is F sub b equals rho sub fluid times V sub disp times
 * g. Written flat it reads as six variables multiplied together. cloze.ts has
 * understood k_(cat) notation since the subscript work; cards written before it
 * are still flat, and so are cards written by hand since.
 *
 * WHAT THIS CAN AND CANNOT DECIDE. Juxtaposition means BOTH subscript and
 * multiplication, and nothing in the text says which:
 *
 *   Fb = ρfluid·Vdisp·g     subscripts        broken
 *   W = Fd, P = Fv, Q = Av  products          correct as written
 *   Fg = Gm₁m₂/r²           one of each
 *
 * So this prints candidates to be read, and does not fix anything. Precision
 * comes from the two lists below: a curated set of subscript tails, and the
 * element symbols, which have the same capital-then-lowercase shape and would
 * otherwise dominate the output (Na, Cl, Fe, Hg).
 *
 * Reads only. The substitutions chosen from a previous run of this live in
 * fix-flat-subscripts.mjs.
 */
import { db, page } from "./lib/contrast-vocab.mjs";

const ELEMENTS = new Set(("H He Li Be B C N O F Ne Na Mg Al Si P S Cl Ar K Ca Sc Ti V Cr Mn Fe Co "
  + "Ni Cu Zn Ga Ge As Se Br Kr Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I Xe Cs Ba La Ce Hf "
  + "Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn Fr Ra Ac Th Pa U Np Pu Am Cm").split(" "));

// Tails a subscript actually takes on the MCAT. An open [a-z]+ tail returns
// nine hundred English words ("The", "In", "For") and buries the real ones.
const TAILS = new Set(("max min cat sp eq cell total tot net avg rms disp fluid obj obs out ext int "
  + "sys surr rev gas atm eff term half init final app th crit sol solute solvent water air blood "
  + "nucleus orbit rest inst mech elec chem nc "
  + "a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4").split(" "));

const PATTERNS = [
  // A symbol glued to a tail: Fb, Vdisp, ρfluid, Kmax, ΔTf.
  [/(?<![A-Za-zͰ-Ͽ_(])((?:Δ|∆)?[A-ZΑ-Ωα-ω])([a-z]{1,8}|\d)(?![A-Za-z])/gu,
    (m) => TAILS.has(m[2]) && !ELEMENTS.has(m[0])],
  // A subscript written with real parentheses, which render as parentheses:
  // E°(cell). The degree sign is what separates these from P(none), a genuine
  // probability of an event.
  [/[A-Zρμλχ]°\([a-z]{2,10}\)/gu, () => true],
  // pKa, pKb: the K is subscripted in the constants these refer to.
  [/\bpK[a-z0-9]\b/gu, () => true],
  // A lowercase symbol glued to a word tail: urms, mtotal, kcat.
  [/(?<![A-Za-z])[a-z](?:cat|max|min|eq|rev|net|tot|total|avg|rms|obs|eff|sp|half|crit)\b/gu, () => true],
];

const cards = await page("flashcards", "id,deck_id,cloze_text", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

const hits = new Map();
for (const c of cards) {
  if (!c.cloze_text) continue;
  for (const [re, keep] of PATTERNS) {
    re.lastIndex = 0;
    let m;
    while ((m = re.exec(c.cloze_text)) !== null) {
      if (!keep(m)) continue;
      if (!hits.has(m[0])) hits.set(m[0], { n: 0, cards: new Set(), ex: "", deck: "" });
      const e = hits.get(m[0]);
      e.n++;
      e.cards.add(c.id);
      if (!e.ex) {
        e.deck = deckTitle.get(c.deck_id) ?? "?";
        e.ex = c.cloze_text.replace(/\s+/g, " ").slice(Math.max(0, m.index - 50), m.index + 60);
      }
    }
  }
}

const rows = [...hits.entries()].sort((a, b) => b[1].n - a[1].n);
console.log(`flat-subscript candidates: ${rows.length} tokens across ${cards.length} cards`);
console.log("read each one: a product looks exactly like a subscript\n");
for (const [tok, e] of rows) {
  console.log(`${String(e.n).padStart(3)}  ${tok.padEnd(12)} [${e.deck}]`);
  console.log(`     …${e.ex}…`);
}
