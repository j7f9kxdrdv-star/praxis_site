import fs from "fs";
import { fsrs, generatorParameters, createEmptyCard, Rating } from "ts-fsrs";
const src = fs.readFileSync("simulate.mjs", "utf8");
let head = src.slice(0, src.indexOf("function simulate"));
fs.writeFileSync("_lib3.mjs", head + "\nexport { RMAP, FIRST, PASS, rng, pick, SEC_PER_CARD, DECK };\n");
const { RMAP, FIRST, PASS, rng, pick, SEC_PER_CARD, DECK } = await import("./_lib3.mjs");

// Same simulation, but returns the full retrievability distribution at exam so
// one run can be scored at ANY threshold. If the winning target simply tracks
// whatever threshold I picked, the metric is measuring itself.
function run({ retention, days, minutesPerDay, seed }) {
  const f = fsrs(generatorParameters({ request_retention: retention, maximum_interval: 365,
    enable_short_term: true, enable_fuzz: false }));
  const rand = rng(seed);
  const perDay = Math.floor((minutesPerDay * 60) / SEC_PER_CARD);
  const t0 = new Date("2026-09-01T09:00:00Z"), day = d => new Date(t0.getTime() + d * 86400000);
  const cards = []; let unseen = DECK;
  for (let d = 0; d < days; d++) {
    const now = day(d); let budget = perDay;
    for (const item of cards.filter(x => x.due <= now).sort((a,b)=>a.due-b.due)) {
      if (budget <= 0) break;
      const R = f.get_retrievability(item.c, now, false);
      const passed = rand() < (typeof R === "number" ? R : 0.9);
      item.c = f.next(item.c, now, RMAP[passed ? pick(PASS, rand()) : "again"]).card;
      item.due = new Date(item.c.due); budget--;
      if (!passed && budget > 0) {
        item.c = f.next(item.c, new Date(now.getTime()+600000), RMAP[pick(PASS, rand())]).card;
        item.due = new Date(item.c.due); budget--;
      }
    }
    while (budget > 0 && unseen > 0) {
      const c = f.next(createEmptyCard(now), now, RMAP[pick(FIRST, rand())]).card;
      cards.push({ c, due: new Date(c.due) }); unseen--; budget--;
    }
  }
  const exam = day(days);
  return cards.map(x => { const R = f.get_retrievability(x.c, exam, false); return typeof R === "number" ? R : 0; });
}

const RET = [0.70, 0.75, 0.80, 0.85, 0.90, 0.95];
const dists = {};
for (const r of RET) dists[r] = [1,2,3].map(seed => run({ retention: r, days: 90, minutesPerDay: 60, seed }));
console.log("\n  Winning target when scored at different thresholds:\n");
console.log(`  threshold  ${RET.map(r=>((r*100).toFixed(0)+"%").padStart(6)).join("")}    winner`);
for (const th of [0.70, 0.75, 0.80, 0.85, 0.90, 0.95]) {
  const row = RET.map(r => dists[r].reduce((a,d)=>a+d.filter(x=>x>=th).length,0)/3);
  const win = RET[row.indexOf(Math.max(...row))];
  console.log(`     R>=${(th*100).toFixed(0)}   ${row.map(v=>v.toFixed(0).padStart(6)).join("")}     ${(win*100).toFixed(0)}%`);
}
