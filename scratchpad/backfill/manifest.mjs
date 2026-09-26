// Derives the complete new-object manifest FROM the accumulator and the design
// files, then reconciles the count against the accumulator itself. Nothing here
// is typed from a previous report.
import { all } from "./record.mjs";
import { PROPOSED as IM } from "../immune/design.mjs";
import { PROPOSED as CV } from "../cardio/design.mjs";
import fs from "node:fs";
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));

// Taxonomy for the three earlier gap concepts, which are not biology organ systems.
const PHASE_A = {
 "Amino Acid Recognition and Abbreviations": ["BIO_BIOCHEM","BIOCHEMISTRY","Structure and Function of Proteins and Their Constituent Amino Acids"],
 "Polyprotic Acids and Stepwise Dissociation": ["CHEM_PHYS","GENERAL_CHEMISTRY","Acid-Base Equilibria (GC, BC)"],
 "Protein Structure Determination": ["BIO_BIOCHEM","BIOCHEMISTRY","Structure and Function of Proteins and Their Constituent Amino Acids"],
};
const PHASE_B = ["Renin-Angiotensin-Aldosterone System","Blood Vessel Structure and Types","Heart Chambers and Valves","Urinary Tract and Micturition","ABO and Rh Blood Types"];
const imNames=new Set(IM.map(p=>p.name)), cvNames=new Set(CV.map(p=>p.name));

const STOP=new Set(["a","an","the","of","in","and","to","for","its","their","by","on","as","at","versus","with"]);
const slug=n=>n.toUpperCase().replace(/&/g," ").replace(/[^A-Z0-9 ]/g," ").split(/\s+/)
  .filter(w=>w&&!STOP.has(w.toLowerCase())).join("_");

const C=await all("concepts","id,slug,canonical_name");
const liveSlugs=new Set(C.map(c=>c.slug));
const liveNames=new Set(C.map(c=>c.canonical_name));

const cardsOf={}; A.filter(r=>r.isNew).forEach(r=>cardsOf[r.name]=(cardsOf[r.name]||0)+1);
const names=Object.keys(cardsOf);
const rows=[];
for(const n of names){
  let group,sect,disc,cat;
  if(PHASE_A[n]){group="A"; [sect,disc,cat]=PHASE_A[n];}
  else if(PHASE_B.includes(n)){group="B"; [sect,disc,cat]=["BIO_BIOCHEM","BIOLOGY","Organ Systems"];}
  else if(imNames.has(n)){group="C"; [sect,disc,cat]=["BIO_BIOCHEM","BIOLOGY","Organ Systems"];}
  else if(cvNames.has(n)){group="D"; [sect,disc,cat]=["BIO_BIOCHEM","BIOLOGY","Organ Systems"];}
  else {group="?"; [sect,disc,cat]=["?","?","?"];}
  rows.push({group,slug:slug(n),name:n,cards:cardsOf[n],sect,disc,cat});
}
rows.sort((a,b)=>a.group.localeCompare(b.group)||a.name.localeCompare(b.name));
const LABEL={A:"A. Earlier backfill gaps",B:"B. Five physiology concepts",C:"C. Immune reconciliation",D:"D. Cardiovascular reconciliation","?":"UNATTRIBUTED"};
let last=null;
for(const r of rows){
  if(r.group!==last){console.log(`\n### ${LABEL[r.group]}`); console.log("| # | Slug | Canonical name | Cards | Section | Discipline | AAMC category |");
    console.log("| --- | --- | --- | --- | --- | --- | --- |"); last=r.group;}
  const i=rows.filter(x=>x.group===r.group).indexOf(r)+1;
  console.log(`| ${i} | \`${r.slug}\` | ${r.name} | ${r.cards} | ${r.sect} | ${r.disc} | ${r.cat} |`);
}
const per={}; rows.forEach(r=>per[r.group]=(per[r.group]||0)+1);
console.log("\n### Reconciliation, derived");
console.log(`  A earlier gaps           ${per.A||0}`);
console.log(`  B physiology             ${per.B||0}`);
console.log(`  C immune                 ${per.C||0}`);
console.log(`  D cardiovascular         ${per.D||0}`);
console.log(`  unattributed             ${per["?"]||0}`);
console.log(`  SUM                      ${rows.length}`);
console.log(`  distinct isNew names in the accumulator: ${new Set(A.filter(r=>r.isNew).map(r=>r.name)).size}`);
console.log(`  cards on new concepts: ${rows.reduce((s,r)=>s+r.cards,0)} (accumulator says ${A.filter(r=>r.isNew).length})`);
// collision checks
const dupSlug=rows.filter(r=>liveSlugs.has(r.slug));
const dupName=rows.filter(r=>liveNames.has(r.name));
const selfSlug=Object.entries(rows.reduce((a,r)=>((a[r.slug]=(a[r.slug]||0)+1),a),{})).filter(([,v])=>v>1);
console.log(`\n  slug collisions with live ontology: ${dupSlug.length}${dupSlug.length?" "+JSON.stringify(dupSlug.map(r=>r.slug)):""}`);
console.log(`  name collisions with live ontology: ${dupName.length}`);
console.log(`  slug collisions within the manifest: ${selfSlug.length}${selfSlug.length?" "+JSON.stringify(selfSlug):""}`);
console.log(`  object_type for all rows: CONTENT (no REASONING or QUANTITATIVE objects are created)`);
