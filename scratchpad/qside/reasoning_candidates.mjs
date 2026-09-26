// Item 6: a REPORT, not a migration. question_concepts stays CONTENT-only and no
// question-to-REASONING relation is written, because that architecture has not
// been designed or approved. This is input for the later reasoning layer.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const M=JSON.parse(fs.readFileSync("/tmp/immune_manifest.json","utf8"));
const C=await all("concepts","id,slug,canonical_name,object_type");
const reasoning=C.filter(c=>c.object_type==="REASONING");
const Q=await all("questions","id,subtopic,cognitive_skill");
const qById=new Map(Q.map(q=>[q.id,q]));
// map a C-class label's operation to the closest existing REASONING object
const RULES=[
 [/control arm|control arms|cell-free control|specificity control/i,"Variables and Controls","HIGH"],
 [/adoptive transfer|causal necessity|localising a block|subset depletion|testing necessity/i,"Causal Inference","HIGH"],
 [/interpreting|reading a|reading expansion|reading fragment/i,"Data Display Formats","MEDIUM"],
 [/designing|culture arm|dose response/i,"Study Design Types","HIGH"],
 [/separating|distinguishing|locating/i,"Confounding","MEDIUM"],
 [/testing whether/i,"Hypothesis Formation","MEDIUM"],
];
const rows=[];
for(const l of M.lifecycle.filter(x=>x.classification==="C")){
  const r=M.repoint.find(x=>x.old_label===l.label);
  const hit=RULES.find(([rx])=>rx.test(l.label));
  const cand=hit?hit[1]:"(none obvious)";
  const exists=reasoning.find(c=>c.canonical_name===cand);
  rows.push({question_id:r.question_id, subtopic:l.label, content:r.new_label,
    reasoning:cand, exists:!!exists, conf:hit?hit[2]:"LOW",
    skill:qById.get(r.question_id)?.cognitive_skill||null});
}
fs.writeFileSync("/tmp/immune_reasoning_candidates.json",JSON.stringify(rows,null,1));
console.log(`REASONING CANDIDATES (report only, ${rows.length} questions)\n`);
console.log("| Question subtopic | CONTENT concept | Candidate REASONING object | Confidence |");
console.log("| --- | --- | --- | --- |");
rows.forEach(r=>console.log(`| ${r.subtopic} | \`${r.content}\` | \`${r.reasoning}\`${r.exists?"":" (does not exist)"} | ${r.conf} |`));
const t={}; rows.forEach(r=>t[r.reasoning]=(t[r.reasoning]||0)+1);
console.log(`\nby candidate: ${JSON.stringify(t)}`);
console.log(`all candidates exist as REASONING objects: ${rows.every(r=>r.exists||r.reasoning==="(none obvious)")}`);
console.log(`questions cognitive_skill values: ${JSON.stringify([...new Set(rows.map(r=>r.skill))])}`);
console.log(`\nNOTHING WRITTEN. question_concepts remains CONTENT-only.`);
