// Re-records The Immune System deck from the approved design. record() replaces
// the deck wholesale, so this also performs the point-3 card moves: cards 12, 15,
// 70-73 leave the one-question labels they were provisionally on and land on
// `Surface Barriers to Infection` and `The Lymphatic System`.
import { record, R } from "../backfill/record.mjs";
import { PROPOSED, KEEP_EXISTING } from "./design.mjs";
const ranges = cards => { const s=[...cards].sort((a,b)=>a-b), out=[]; let a=s[0], p=s[0];
  for(const c of s.slice(1)){ if(c===p+1){p=c;continue;} out.push(R(a,p)); a=p=c; } out.push(R(a,p)); return out; };
const groups = [
  ...PROPOSED.map(p=>["NEW:"+p.name, ranges(p.cards)]),
  ...KEEP_EXISTING.map(k=>[k.concept, ranges(k.cards)]),
];
await record("The Immune System", groups, []);
