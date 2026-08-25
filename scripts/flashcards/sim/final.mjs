import { fsrs, generatorParameters, createEmptyCard, Rating } from "ts-fsrs";
import fs from "fs";
const SEC = 13.6, DECK = 7253;
const RMAP = { again: Rating.Again, hard: Rating.Hard, medium: Rating.Good, easy: Rating.Easy };
const rows = JSON.parse(fs.readFileSync("reviews.json","utf8"));
const cnt=new Map(); rows.forEach(r=>cnt.set(r.user_id,(cnt.get(r.user_id)||0)+1));
const keep=new Set([...cnt.entries()].filter(([,n])=>n>=1000).map(([u])=>u));
const seqs=new Map();
for(const r of rows){ if(!keep.has(r.user_id))continue; const k=`${r.user_id}|${r.flashcard_id}|${r.cloze_index}`;
  if(!seqs.has(k))seqs.set(k,[]); seqs.get(k).push(r); }
for(const v of seqs.values()) v.sort((a,b)=>a.reviewed_at.localeCompare(b.reviewed_at));
const fm={again:0,hard:0,medium:0,easy:0}, pm={hard:0,medium:0,easy:0};
for(const s of seqs.values()){ fm[s[0].rating]++; for(const r of s.slice(1)) if(r.rating!=="again") pm[r.rating]++; }
const norm=o=>{const t=Object.values(o).reduce((a,b)=>a+b,0);const e={};for(const k in o)e[k]=o[k]/t;return e;};
const FIRST=norm(fm), PASS=norm(pm);
const curve=JSON.parse(fs.readFileSync("curve.json","utf8"));
// Map an FSRS retrievability onto what students of this deck actually achieved.
function calibrated(R){
  if(R<=curve[0].p) return R*(curve[0].o/curve[0].p);
  if(R>=curve.at(-1).p) return curve.at(-1).o + (R-curve.at(-1).p)*(1-curve.at(-1).o)/(1-curve.at(-1).p);
  for(let i=0;i<curve.length-1;i++){ const a=curve[i],b=curve[i+1];
    if(R>=a.p&&R<=b.p) return a.o+(b.o-a.o)*(R-a.p)/(b.p-a.p); }
  return R;
}
function rng(s){let x=s>>>0;return()=>(x=(x*1664525+1013904223)>>>0)/4294967296;}
const pick=(d,u)=>{let a=0;for(const k in d){a+=d[k];if(u<a)return k;}return "medium";};
function run({retention,days,minutesPerDay,seed}){
  const f=fsrs(generatorParameters({request_retention:retention,maximum_interval:365,enable_short_term:true,enable_fuzz:false}));
  const rand=rng(seed), perDay=Math.floor(minutesPerDay*60/SEC);
  const t0=new Date("2026-09-01T09:00:00Z"), day=d=>new Date(t0.getTime()+d*86400000);
  const cards=[]; let unseen=DECK, reviews=0;
  for(let d=0;d<days;d++){
    const now=day(d); let budget=perDay;
    for(const it of cards.filter(x=>x.due<=now).sort((a,b)=>a.due-b.due)){
      if(budget<=0)break;
      const R=f.get_retrievability(it.c,now,false);
      const passed=rand()<calibrated(typeof R==="number"?R:0.9);   // outcome uses REAL rates
      it.c=f.next(it.c,now,RMAP[passed?pick(PASS,rand()):"again"]).card;
      it.due=new Date(it.c.due); budget--; reviews++;
      if(!passed&&budget>0){ it.c=f.next(it.c,new Date(now.getTime()+6e5),RMAP[pick(PASS,rand())]).card;
        it.due=new Date(it.c.due); budget--; reviews++; }
    }
    while(budget>0&&unseen>0){ const c=f.next(createEmptyCard(now),now,RMAP[pick(FIRST,rand())]).card;
      cards.push({c,due:new Date(c.due)}); unseen--; budget--; reviews++; }
  }
  const exam=day(days);
  let raw=0, real=0;
  for(const x of cards){ const R=f.get_retrievability(x.c,exam,false); const r=typeof R==="number"?R:0;
    raw+=r; real+=calibrated(r); }
  return { introduced:cards.length, reviews, raw, real };
}
const RET=[0.50,0.60,0.65,0.70,0.75,0.80,0.85,0.90,0.95];
for(const [m,d] of [[30,90],[60,90],[90,120]]){
  console.log(`\n════ ${m} min/day, ${d} days  (${(m*d/60).toFixed(0)} hours) ════`);
  console.log("  target  introduced   FSRS thinks you know   you ACTUALLY know   % of deck");
  const out=[];
  for(const r of RET){
    const runs=[1,2,3,4,5].map(s=>run({retention:r,days:d,minutesPerDay:m,seed:s}));
    const a=k=>runs.reduce((x,y)=>x+y[k],0)/runs.length;
    const o={r,introduced:a("introduced"),raw:a("raw"),real:a("real")}; out.push(o);
    console.log(`   ${(r*100).toFixed(0)}%  ${o.introduced.toFixed(0).padStart(9)}   ${o.raw.toFixed(0).padStart(18)}   ${o.real.toFixed(0).padStart(16)}   ${(100*o.real/DECK).toFixed(1).padStart(6)}%`);
  }
  const best=out.reduce((a,b)=>b.real>a.real?b:a);
  const near=out.filter(o=>o.real>=best.real*0.98).map(o=>(o.r*100).toFixed(0)+"%");
  console.log(`  -> best ${(best.r*100).toFixed(0)}%   within 2% of best: ${near.join(", ")}`);
}
