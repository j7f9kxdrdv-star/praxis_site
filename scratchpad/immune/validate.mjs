import { all } from "../backfill/record.mjs";
import { PROPOSED, KEEP_EXISTING, LABELS } from "./design.mjs";
const P=[];
const C=await all("concepts","id,canonical_name");
const live=new Set(C.map(c=>c.canonical_name));
const Q=await all("questions","id,topic");
const imQ=new Set(Q.filter(q=>q.topic==="The Immune System").map(q=>q.id));
const QC=await all("question_concepts","question_id,concept_id");
const byId=new Map(C.map(c=>[c.id,c]));
const labelNames=new Set(QC.filter(r=>imQ.has(r.question_id)).map(r=>byId.get(r.concept_id).canonical_name));

// 1. no proposed name may already exist
// PRE-SEED GUARD. Before the migration runs, a proposed name that already
// exists is a duplicate waiting to happen. Once it has run, every proposed name
// exists BY DESIGN, so the guard would report the success as a failure. Detect
// which side of the migration we are on and say so instead.
const seeded = PROPOSED.filter((p) => live.has(p.name)).length;
const APPLIED = seeded === PROPOSED.length;
if (!APPLIED && seeded > 0) P.push(`${seeded} of ${PROPOSED.length} proposed names exist: partially applied`);
// 2. every card position 1..76 covered exactly once across PROPOSED + KEEP_EXISTING
const seen=new Map();
for(const p of PROPOSED) for(const c of p.cards){ if(seen.has(c)) P.push(`card ${c} claimed by "${p.name}" and "${seen.get(c)}"`); seen.set(c,p.name); }
for(const k of KEEP_EXISTING) for(const c of k.cards){ if(seen.has(c)) P.push(`card ${c} claimed by "${k.concept}" and "${seen.get(c)}"`); seen.set(c,k.concept); }
for(let i=1;i<=76;i++) if(!seen.has(i)) P.push(`card ${i} UNASSIGNED`);
for(const i of seen.keys()) if(i<1||i>76) P.push(`card ${i} out of range`);
// 3. KEEP_EXISTING concepts must exist
for(const k of KEEP_EXISTING) if(!live.has(k.concept)) P.push(`KEEP_EXISTING "${k.concept}" does not exist`);
// 4. every q[] name must be a real immune label
for(const p of PROPOSED) for(const [n] of p.q) if(!labelNames.has(n)) P.push(`"${p.name}" cites "${n}" which is not an immune question label`);
// 5. classification must partition all 89 exactly once
const cls=new Map();
for(const [k,arr] of Object.entries(LABELS)) for(const n of arr){
  if(!labelNames.has(n)) P.push(`classified "${n}" (${k}) is not an immune label`);
  if(cls.has(n)) P.push(`"${n}" classified twice: ${cls.get(n)} and ${k}`);
  cls.set(n,k);
}
const unclassified=[...labelNames].filter(n=>!cls.has(n));

if(P.length){console.log("PROBLEMS:");P.forEach(p=>console.log("  "+p));process.exit(1);}
console.log(APPLIED ? "VALID (migration APPLIED: all proposed concepts are seeded)" : "VALID");
console.log(`  proposed concepts: ${PROPOSED.length}`);
console.log(`  cards on proposed: ${PROPOSED.reduce((s,p)=>s+p.cards.length,0)}`);
console.log(`  cards kept on existing: ${KEEP_EXISTING.reduce((s,k)=>s+k.cards.length,0)}`);
console.log(`  total cards covered: ${seen.size} of 76`);
console.log(`  immune labels: ${labelNames.size} | classified A/C/D/E: ${cls.size} | implicitly B: ${unclassified.length}`);
const conf={}; PROPOSED.forEach(p=>conf[p.conf]=(conf[p.conf]||0)+1);
console.log(`  confidence: ${JSON.stringify(conf)}`);
const exact=PROPOSED.reduce((s,p)=>s+p.q.filter(([,e])=>e).length,0);
const rel=PROPOSED.reduce((s,p)=>s+p.q.filter(([,e])=>!e).length,0);
console.log(`  question alignments: ${exact} exact, ${rel} related`);
const withExact=PROPOSED.filter(p=>p.q.some(([,e])=>e)).length;
console.log(`  proposed concepts with at least one EXACT question: ${withExact} of ${PROPOSED.length}`);
const cited=new Set(PROPOSED.flatMap(p=>p.q.map(([n])=>n)));
console.log(`  distinct labels reached by an alignment: ${cited.size} of ${labelNames.size}`);
console.log(`  labels reached by NO alignment: ${[...labelNames].filter(n=>!cited.has(n)).length}`);
[...labelNames].filter(n=>!cited.has(n)).forEach(n=>console.log(`     - ${n} [${cls.get(n)||"B"}]`));
