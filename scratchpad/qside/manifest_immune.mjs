// The reversible migration manifest. Every row records what it came from, so the
// migration can be read backwards: old concept_id is preserved per question, and
// each deprecated label keeps deprecated_by pointing at its successor.
import { all } from "../backfill/record.mjs";
import { A_DECISIONS, ALIAS_WORTHY } from "./lifecycle_immune.mjs";
import { OVERRIDES } from "./overrides.mjs";
import fs from "node:fs";
const rows=JSON.parse(fs.readFileSync("/tmp/immune_qmap.json","utf8"));
const C=await all("concepts","id,slug,canonical_name,status,description");
const byName=new Map(C.map(c=>[c.canonical_name,c]));
const Q=await all("questions","id,topic,subtopic");
const IM=Q.filter(q=>q.topic==="The Immune System");
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const imIds=new Set(IM.map(q=>q.id));
const curr=new Map(QC.filter(r=>imIds.has(r.question_id)).map(r=>[r.question_id,r]));
const P=[];

// the previously unmapped question
const vdj=IM.find(q=>!curr.has(q.id));
const vdjTarget=OVERRIDES["Random Repertoire and the Need for Tolerance"].target;

const manifest={ repoint:[], insert:[], lifecycle:[], secondary:[], aliases:[] };
for(const r of rows){
  const cur=curr.get(r.question);
  if(!cur){P.push(`question ${r.question} has no current mapping`);continue;}
  if(cur.concept_id!==r.oldConcept) P.push(`question ${r.question} moved since the design was built`);
  if(cur.mapping_status==="HUMAN_VALIDATED") P.push(`question ${r.question} is HUMAN_VALIDATED, refusing to repoint`);
  const target=byName.get(r.newName);
  if(!target){P.push(`target "${r.newName}" not live`);continue;}
  manifest.repoint.push({question_id:r.question, old_concept_id:r.oldConcept, old_label:r.oldName, old_slug:r.oldSlug,
    new_concept_id:target.id, new_label:r.newName, new_slug:target.slug,
    classification:r.cls, basis:r.basis, confidence:r.conf||"HIGH",
    reason:r.why||`The question applies ${r.newName}; ${r.oldName} names the scenario it applies it in.`,
    old_mapping_status:cur.mapping_status, old_source:cur.source});
}
manifest.insert.push({question_id:vdj.id, old_concept_id:null, old_label:null,
  new_concept_id:byName.get(vdjTarget).id, new_label:vdjTarget, new_slug:byName.get(vdjTarget).slug,
  classification:"UNMAPPED", basis:"read-the-question", confidence:"HIGH",
  reason:OVERRIDES["Random Repertoire and the Need for Tolerance"].why});

// lifecycle per label
const labelNames=[...new Set(rows.map(r=>r.oldName))];
for(const name of labelNames){
  const r=rows.find(x=>x.oldName===name);
  const c=byName.get(name);
  const a=A_DECISIONS[name];
  const action = a ? a.action : "MERGE_TO";
  const why = a ? a.why : `Class ${r.cls}: ${r.cls==="C"?"names an experimental operation rather than a piece of biology":r.cls==="D"?"a near-duplicate of another label testing the same idea":"a scenario-specific expression of the durable concept"}.`;
  manifest.lifecycle.push({concept_id:c.id, slug:c.slug, label:name, classification:r.cls, action,
    successor_id: action==="MERGE_TO" ? byName.get(r.newName).id : null,
    successor: action==="MERGE_TO" ? r.newName : null, why});
  if(action!=="MERGE_TO") manifest.secondary.push({question_id:r.question, concept_id:c.id, label:name,
    why:"Retained as a narrower facet, so its evidence survives as SECONDARY while the durable concept takes PRIMARY."});
  if(action==="MERGE_TO" && ALIAS_WORTHY.has(name)) manifest.aliases.push({concept_id:byName.get(r.newName).id, alias:name,
    why:"A real term someone would search for, folded into its successor."});
}
if(P.length){console.log("PROBLEMS:");P.slice(0,10).forEach(x=>console.log("  "+x));process.exit(1);}
fs.writeFileSync("/tmp/immune_manifest.json",JSON.stringify(manifest,null,1));
const act={}; manifest.lifecycle.forEach(l=>act[l.action]=(act[l.action]||0)+1);
console.log("IMMUNE MIGRATION MANIFEST");
console.log(`  repoint (question PRIMARY moves):      ${manifest.repoint.length}`);
console.log(`  insert (previously unmapped question): ${manifest.insert.length}`);
console.log(`  lifecycle decisions:                   ${manifest.lifecycle.length}  ${JSON.stringify(act)}`);
console.log(`  secondary mappings added:              ${manifest.secondary.length}`);
console.log(`  aliases created:                       ${manifest.aliases.length}`);
const conf={}; manifest.repoint.forEach(r=>conf[r.confidence]=(conf[r.confidence]||0)+1);
console.log(`  repoint confidence:                    ${JSON.stringify(conf)}`);
console.log(`\n  question mappings: 2659 -> ${2659 + manifest.insert.length + manifest.secondary.length}`);
console.log(`  (${manifest.repoint.length} repointed in place, +1 insert, +${manifest.secondary.length} secondary)`);
