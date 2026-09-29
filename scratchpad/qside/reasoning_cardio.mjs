import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/cardio_manifest.json","utf8"));
const C=await all("concepts","id,canonical_name,object_type");
const reasoning=new Set(C.filter(c=>c.object_type==="REASONING").map(c=>c.canonical_name));
const Q=await all("questions","id,subtopic,cognitive_skill");
const qById=new Map(Q.map(q=>[q.id,q]));
const RULES=[
 [/control arm|controls?$|specificity control/i,"Variables and Controls","HIGH"],
 [/localis|localiz|cutting the afferent|depletion|necessity/i,"Causal Inference","HIGH"],
 [/interpreting|reading|comparing .* across|conditions$/i,"Data Display Formats","MEDIUM"],
 [/designing|manipulating|experimentally|assay/i,"Study Design Types","HIGH"],
 [/separating|distinguishing|versus .* and/i,"Confounding","MEDIUM"],
 [/testing whether|proposes/i,"Hypothesis Formation","MEDIUM"],
 [/sampling|screening/i,"Randomization and Sampling","MEDIUM"],
];
const rows=[];
for(const l of M.lifecycle.filter(x=>x.classification==="C")){
  const r=M.repoint.concat(M.insert).find(x=>x.old_label===l.label);
  const hit=RULES.find(([rx])=>rx.test(l.label));
  const cand=hit?hit[1]:"(none obvious)";
  rows.push({question_id:r.question_id, label:l.label, content:r.new_label, reasoning:cand,
    exists:reasoning.has(cand), conf:hit?hit[2]:"LOW", skill:qById.get(r.question_id)?.cognitive_skill});
}
fs.writeFileSync("/tmp/cardio_reasoning.json",JSON.stringify(rows,null,1));
console.log(`CARDIOVASCULAR REASONING CANDIDATES (report only, ${rows.length})\n`);
console.log("| Question label | CONTENT concept | Candidate REASONING | Exists | Conf |");
console.log("| --- | --- | --- | --- | --- |");
rows.forEach(r=>console.log(`| ${r.label} | \`${r.content}\` | \`${r.reasoning}\` | ${r.exists?"yes":"NO"} | ${r.conf} |`));
const t={}; rows.forEach(r=>t[r.reasoning]=(t[r.reasoning]||0)+1);
console.log(`\nby candidate: ${JSON.stringify(t)}`);
const gaps=[...new Set(rows.filter(r=>!r.exists).map(r=>r.reasoning))];
console.log(`vocabulary gaps in the REASONING layer: ${gaps.length ? gaps.join(", ") : "none"}`);
console.log(`\nNOTHING WRITTEN. question_concepts stays CONTENT-only.`);
