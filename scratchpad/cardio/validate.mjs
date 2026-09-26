import { all } from "../backfill/record.mjs";
import { PROPOSED, REUSE, LABELS } from "./design.mjs";
import fs from "node:fs";
const P=[];
const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const C=await all("concepts","id,canonical_name,object_type");
const live=new Map(C.map(c=>[c.canonical_name,c]));
const Q=await all("questions","id,topic");
const cvQ=new Set(Q.filter(q=>q.topic==="The Cardiovascular System").map(q=>q.id));
const QC=await all("question_concepts","question_id,concept_id");
const byId=new Map(C.map(c=>[c.id,c]));
const cvLabelIds=new Set(QC.filter(r=>cvQ.has(r.question_id)).map(r=>r.concept_id));
const cvLabels=new Set([...cvLabelIds].map(i=>byId.get(i).canonical_name));
// deck positions
const D=await all("flashcard_decks","id,title");
const F=await all("flashcards","id,deck_id,position");
const FC=await all("flashcard_concepts","flashcard_id"); const mapped=new Set(FC.map(m=>m.flashcard_id));
const key=new Map(); // "deck|pos" -> card id
for(const d of D){ const cards=F.filter(f=>f.deck_id===d.id&&!mapped.has(f.id)).sort((a,b)=>a.position-b.position);
  cards.forEach((c,i)=>key.set(`${d.title}|${i+1}`,c.id)); }
const accByCard=new Map(A.map(r=>[r.card,r]));

// 1. no proposed name may exist
for(const p of PROPOSED) if(live.has(p.name)) P.push(`proposed "${p.name}" ALREADY EXISTS`);
// 2. REUSE targets must be either live or an approved NEW already in the accumulator
const accNewNames=new Set(A.filter(r=>r.isNew).map(r=>r.name));
for(const r of REUSE) if(!live.has(r.concept)&&!accNewNames.has(r.concept)) P.push(`REUSE target "${r.concept}" is neither live nor an approved new concept`);
// 3. every [deck,pos] must resolve, be currently assigned, and not be claimed twice
const claimed=new Map();
const check=(name,pairs)=>{ for(const [deck,pos] of pairs){ const k=`${deck}|${pos}`; const id=key.get(k);
  if(!id){P.push(`${k} does not resolve to an unmapped card`);continue;}
  if(claimed.has(id)) P.push(`${k} claimed by "${name}" and "${claimed.get(id)}"`);
  claimed.set(id,name);
  if(!accByCard.has(id)) P.push(`${k} is not currently in the accumulator`); } };
for(const p of PROPOSED) check(p.name,p.cards);
for(const r of REUSE) check(r.concept,r.cards);
// 4. Each claimed card must be EITHER still on a cardio label (this design has
//    not been applied yet) OR already on its intended target (it has). Anything
//    else means the card drifted and the design no longer describes reality.
//    Written this way so the validator stays runnable after apply.mjs.
let pending=0, applied=0;
for(const [id,name] of claimed){ const cur=accByCard.get(id); if(!cur) continue;
  if(cur.name===name){applied++;continue;}
  if(cur.concept&&cvLabelIds.has(cur.concept)){pending++;continue;}
  P.push(`card for "${name}" sits on "${cur.name}": neither a cardio label nor the intended target`); }
// 5. no card may still be on a cardio label unless this design claims it
for(const r of A) if(r.concept&&cvLabelIds.has(r.concept)&&!claimed.has(r.card)) P.push(`card on label "${r.name}" (${r.deck}) is NOT re-homed`);
// 6. cited questions must be real cardio labels
for(const p of PROPOSED) for(const [n] of p.q) if(!cvLabels.has(n)) P.push(`"${p.name}" cites "${n}" which is not a cardio label`);
// 7. classification partitions the 99
const cls=new Map();
for(const [k,arr] of Object.entries(LABELS)) for(const n of arr){
  if(!cvLabels.has(n)) P.push(`classified "${n}" (${k}) is not a cardio label`);
  if(cls.has(n)) P.push(`"${n}" classified twice`); cls.set(n,k); }

if(P.length){console.log("PROBLEMS:");P.slice(0,25).forEach(p=>console.log("  "+p));console.log(`\n(${P.length} total) NOT APPLIED`);process.exit(1);}
console.log(`VALID (${pending} cards pending, ${applied} already applied)`);
console.log(`  proposed concepts: ${PROPOSED.length}`);
console.log(`  cards onto new concepts: ${PROPOSED.reduce((s,p)=>s+p.cards.length,0)}`);
console.log(`  cards onto reused approved concepts: ${REUSE.reduce((s,r)=>s+r.cards.length,0)}`);
console.log(`  total cards re-homed off cardio labels: ${claimed.size}`);
console.log(`  cardio labels: ${cvLabels.size} | classified A/C/D/E: ${cls.size} | implicitly B: ${cvLabels.size-cls.size}`);
const conf={}; PROPOSED.forEach(p=>conf[p.conf]=(conf[p.conf]||0)+1); console.log(`  confidence: ${JSON.stringify(conf)}`);
console.log(`  exact alignments: ${PROPOSED.reduce((s,p)=>s+p.q.filter(([,e])=>e).length,0)} | related: ${PROPOSED.reduce((s,p)=>s+p.q.filter(([,e])=>!e).length,0)}`);
console.log(`  proposed with >=1 exact question: ${PROPOSED.filter(p=>p.q.some(([,e])=>e)).length} of ${PROPOSED.length}`);
const cited=new Set(PROPOSED.flatMap(p=>p.q.map(([n])=>n)));
console.log(`  labels reached by an alignment: ${cited.size} of ${cvLabels.size}`);
const un=[...cvLabels].filter(n=>!cited.has(n));
console.log(`  labels reached by NO alignment: ${un.length}`); un.forEach(n=>console.log(`     - ${n} [${cls.get(n)||"B"}]`));
// completeness: with ALIGN_APPROVED and CARD_GAPS, every label must be accounted for
import { ALIGN_APPROVED, CARD_GAPS } from "./design.mjs";
const reached=new Set([...PROPOSED.flatMap(p=>p.q.map(([n])=>n)), ...ALIGN_APPROVED.flatMap(a=>a.q.map(([n])=>n)), ...CARD_GAPS.flatMap(g=>g.questions)]);
const missing=[...cvLabels].filter(n=>!reached.has(n));
console.log(`\nafter ALIGN_APPROVED + CARD_GAPS, labels unaccounted for: ${missing.length}`);
missing.forEach(n=>console.log(`   - ${n}`));
const dup=[...ALIGN_APPROVED.flatMap(a=>a.q.map(([n])=>n))].filter(n=>PROPOSED.some(p=>p.q.some(([m,e])=>m===n&&e)));
console.log(`ALIGN_APPROVED names also claimed EXACT by a new concept (should be 0): ${dup.length}${dup.length?" "+JSON.stringify(dup):""}`);
