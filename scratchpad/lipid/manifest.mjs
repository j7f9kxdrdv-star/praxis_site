// Resolve the approved design to UUIDs, and refuse unless it reconciles
// EXACTLY against the immutable snapshot: every card and question accounted
// for once, none invented, none dropped.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const snap = JSON.parse(fs.readFileSync("scratchpad/lipid/pre_split_snapshot.json", "utf8"));
const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };

const F = await all("flashcards", "id,deck_id,position,cloze_text");
const D = await all("flashcard_decks", "id,title");
const Q = await all("questions", "id,question_text");
const deckOf = new Map(D.map((d) => [d.id, d.title]));
const at = (title, pos) => {
  const c = F.find((f) => deckOf.get(f.deck_id) === title && f.position === pos);
  if (!c) throw new Error(`no card ${title} #${pos}`);
  return c.id;
};
const LAA = "Lipid and Amino Acid Metabolism", LSF = "Lipid Structure and Function";

// ── the approved card split, by deck position ──
const MOBILIZATION_POS = [10, 11, 12, 13, 34];
const TRANSPORT_POS = [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 32, 33];
const cardsA = [...MOBILIZATION_POS.map((p) => at(LAA, p)), at(LSF, 12)];
const cardsB = TRANSPORT_POS.map((p) => at(LAA, p));
const STRADDLE = at(LAA, 12); // HSL in adipocytes vs LPL on endothelium

// ── the approved question split, by a distinctive phrase in each stem ──
const byText = (frag) => {
  const hits = Q.filter((q) => q.question_text.includes(frag));
  if (hits.length !== 1) throw new Error(`"${frag}" matched ${hits.length} questions`);
  return hits[0].id;
};
const qA = [
  byText("plasma insulin is low while epinephrine and cortisol are elevated"),
  byText("binding to the plasma protein albumin"),
  byText("plasma insulin has fallen well below its fed-state level"),
  byText("releasing its glycerol backbone and three fatty acids"),
];
const qB = [
  byText("anchored to the luminal surface of the capillary endothelium"),
  byText("Particle X is 22% protein"),
  byText("Process 1 delivers cholesterol from the liver outward"),
];

console.log("MANIFEST RECONCILIATION");
const snapCards = snap.flashcards.map((r) => r.flashcard_id);
const snapQs = snap.questions.map((r) => r.question_id);
const allCards = [...cardsA, ...cardsB], allQs = [...qA, ...qB];

chk("6 cards to Adipose Fat Mobilization", cardsA.length === 6, String(cardsA.length));
chk("15 cards to Lipoprotein Classes & Cholesterol Transport", cardsB.length === 15, String(cardsB.length));
chk("21 cards total, matching the snapshot", allCards.length === 21 && snapCards.length === 21);
chk("no card assigned twice", new Set(allCards).size === 21);
chk("every manifest card is one the parent actually holds",
  allCards.every((id) => snapCards.includes(id)),
  allCards.filter((id) => !snapCards.includes(id)).length + " stray");
chk("every card the parent holds is in the manifest",
  snapCards.every((id) => allCards.includes(id)),
  snapCards.filter((id) => !allCards.includes(id)).length + " unassigned");
chk("4 questions to Adipose Fat Mobilization", qA.length === 4);
chk("3 questions to Lipoprotein Classes & Cholesterol Transport", qB.length === 3);
chk("7 questions total, matching the snapshot", allQs.length === 7 && snapQs.length === 7);
chk("no question assigned twice", new Set(allQs).size === 7);
chk("every manifest question is one the parent actually holds", allQs.every((id) => snapQs.includes(id)));
chk("every question the parent holds is in the manifest", snapQs.every((id) => allQs.includes(id)));
chk("the straddle card is in the mobilization set", cardsA.includes(STRADDLE));
chk("every parent mapping is PRIMARY today, so roles carry over unchanged",
  snap.flashcards.every((r) => r.role === "PRIMARY") && snap.questions.every((r) => r.role === "PRIMARY"));
chk("no parent mapping is HUMAN_VALIDATED, so none is protected from the repoint",
  ![...snap.flashcards, ...snap.questions].some((r) => r.mapping_status === "HUMAN_VALIDATED"),
  [...new Set([...snap.flashcards, ...snap.questions].map((r) => r.mapping_status))].join(","));

// child names must not collide, before or after normalisation
const C = await all("concepts", "id,slug,canonical_name,status");
const norm = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
const names = ["Adipose Fat Mobilization", "Lipoprotein Classes & Cholesterol Transport"];
const slugs = ["ADIPOSE_FAT_MOBILIZATION", "LIPOPROTEIN_CLASSES_CHOLESTEROL_TRANSPORT"];
chk("child slugs are free", slugs.every((s) => !C.some((c) => c.slug === s)));
chk("child names do not collide, even after normalisation",
  names.every((n) => !C.some((c) => norm(c.canonical_name) === norm(n))));
chk("the two child names differ from each other under normalisation", norm(names[0]) !== norm(names[1]));

fs.writeFileSync("scratchpad/lipid/manifest.json", JSON.stringify({
  parentId: snap.parent.id, cardsA, cardsB, qA, qB, straddle: STRADDLE, names, slugs,
}, null, 1));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nManifest reconciles exactly. 21 cards, 7 questions, nothing invented or dropped.");
process.exit(P.length ? 1 : 0);
