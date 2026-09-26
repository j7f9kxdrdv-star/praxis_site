// Recomputes the taxonomy widening required by the FINAL accumulator. A widening
// row is needed when an EXISTING concept receives a card from a deck whose
// section or discipline that concept does not already carry. Every such row is
// SECONDARY / is_primary=false: the tables carry partial unique indexes on the
// primary flag, so a widening row written as primary is silently dropped by
// ON CONFLICT DO NOTHING.
import { all } from "./record.mjs";
import fs from "node:fs";
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const C=await all("concepts","id,slug,canonical_name,object_type");
const byId=new Map(C.map(c=>[c.id,c]));
const CD=await all("concept_disciplines","concept_id,discipline_code,role");
const CS=await all("concept_sections","concept_id,section_code,is_primary");
const disc={},sect={};
CD.forEach(r=>(disc[r.concept_id]=disc[r.concept_id]||new Set()).add(r.discipline_code));
CS.forEach(r=>(sect[r.concept_id]=sect[r.concept_id]||new Set()).add(r.section_code));
const D=await all("flashcard_decks","id,title,section");
const dsec=new Map(D.map(d=>[d.title,d.section]));
const SEC2DISC={biology:"BIOLOGY",biochemistry:"BIOCHEMISTRY",chemistry:"GENERAL_CHEMISTRY",organic_chemistry:"ORGANIC_CHEMISTRY",physics:"PHYSICS",psych_soc:null,scientific_reasoning:null};
const SEC2MCAT={biology:"BIO_BIOCHEM",biochemistry:"BIO_BIOCHEM",chemistry:"CHEM_PHYS",organic_chemistry:"CHEM_PHYS",physics:"CHEM_PHYS",psych_soc:"PSYCH_SOC",scientific_reasoning:null};
const needD=new Map(), needS=new Map();
for(const r of A){
  if(r.isNew||!r.concept) continue;
  const c=byId.get(r.concept);
  if(c.object_type!=="CONTENT") continue;   // trigger forbids taxonomy on non-CONTENT
  const s=dsec.get(r.deck), wantD=SEC2DISC[s], wantM=SEC2MCAT[s];
  if(wantD && !(disc[r.concept]||new Set()).has(wantD)) needD.set(`${c.slug}|${wantD}`,(needD.get(`${c.slug}|${wantD}`)||0)+1);
  if(wantM && !(sect[r.concept]||new Set()).has(wantM)) needS.set(`${c.slug}|${wantM}`,(needS.get(`${c.slug}|${wantM}`)||0)+1);
}
const out={disciplines:[...needD.keys()].map(k=>k.split("|")).sort(), sections:[...needS.keys()].map(k=>k.split("|")).sort()};
fs.writeFileSync("/tmp/widening.json",JSON.stringify(out,null,1));
console.log(`discipline widening rows: ${out.disciplines.length}`);
out.disciplines.forEach(([s,d])=>console.log(`   ${String(needD.get(s+"|"+d)).padStart(2)} cards  ${s} += ${d} SECONDARY`));
console.log(`\nsection widening rows: ${out.sections.length}`);
out.sections.forEach(([s,m])=>console.log(`   ${String(needS.get(s+"|"+m)).padStart(2)} cards  ${s} += ${m} is_primary=false`));
console.log(`\nTOTAL widening rows: ${out.disciplines.length+out.sections.length}`);
