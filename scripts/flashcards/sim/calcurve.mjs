import { fsrs, generatorParameters, createEmptyCard, Rating } from "ts-fsrs";
import fs from "fs";
const rows = JSON.parse(fs.readFileSync("reviews.json", "utf8"));
const cnt = new Map(); rows.forEach(r => cnt.set(r.user_id,(cnt.get(r.user_id)||0)+1));
const keep = new Set([...cnt.entries()].filter(([,n])=>n>=1000).map(([u])=>u));
const RMAP = { again: Rating.Again, hard: Rating.Hard, medium: Rating.Good, easy: Rating.Easy };
const seqs = new Map();
for (const r of rows) { if(!keep.has(r.user_id)) continue;
  const k=`${r.user_id}|${r.flashcard_id}|${r.cloze_index}`;
  if(!seqs.has(k)) seqs.set(k,[]); seqs.get(k).push(r); }
for (const v of seqs.values()) v.sort((a,b)=>a.reviewed_at.localeCompare(b.reviewed_at));
const f = fsrs(generatorParameters({ enable_short_term:true, enable_fuzz:false }));
const preds=[];
for (const seq of seqs.values()) {
  let card = createEmptyCard(new Date(seq[0].reviewed_at)), last=null;
  for (const rev of seq) {
    const now=new Date(rev.reviewed_at);
    if(last && (now-last)/86400000>=1){
      const R=f.get_retrievability(card,now,false);
      if(typeof R==="number"&&R>0&&R<1) preds.push({R,pass:rev.rating!=="again"?1:0});
    }
    card=f.next(card,now,RMAP[rev.rating]??Rating.Good).card; last=now;
  }
}
// Isotonic-ish calibration: sort by predicted R, sweep equal-count bins,
// and record the observed pass rate in each. This is the correction from
// "what FSRS believes" to "what actually happened to these students".
preds.sort((a,b)=>a.R-b.R);
const NB=20, curve=[];
for(let i=0;i<NB;i++){
  const lo=Math.floor(i*preds.length/NB), hi=Math.floor((i+1)*preds.length/NB);
  const b=preds.slice(lo,hi);
  curve.push({ p: b.reduce((s,x)=>s+x.R,0)/b.length, o: b.reduce((s,x)=>s+x.pass,0)/b.length, n: b.length });
}
// enforce monotonicity (pool adjacent violators)
let changed=true;
while(changed){ changed=false;
  for(let i=0;i<curve.length-1;i++) if(curve[i].o>curve[i+1].o){
    const n=curve[i].n+curve[i+1].n;
    const o=(curve[i].o*curve[i].n+curve[i+1].o*curve[i+1].n)/n;
    const p=(curve[i].p*curve[i].n+curve[i+1].p*curve[i+1].n)/n;
    curve.splice(i,2,{p,o,n}); changed=true; break; } }
console.log("calibration curve (FSRS says -> students actually did):");
curve.forEach(c=>console.log(`  ${(100*c.p).toFixed(1).padStart(5)}% -> ${(100*c.o).toFixed(1).padStart(5)}%   n=${c.n}`));
fs.writeFileSync("curve.json", JSON.stringify(curve));
