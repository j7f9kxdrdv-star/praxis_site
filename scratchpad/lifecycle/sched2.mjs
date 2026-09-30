import { all } from "../backfill/record.mjs";
const F=await all("flashcards","id,cloze_count,position");
const S=await all("flashcard_user_state","flashcard_id,cloze_index,user_id,stability");
const R=await all("flashcard_reviews","flashcard_id,cloze_index,reviewed_at,rating");
const ids={"71959e9d-e9e0-4da5-aa03-6286378a591d":"cytoskeleton","4d56a412-90d2-47cb-b0d8-db3a3a06f232":"structural proteins"};
for(const [id,nm] of Object.entries(ids)){
  const f=F.find(x=>x.id===id);
  console.log(`\n### ${nm}  cloze_count=${f.cloze_count}`);
  S.filter(r=>r.flashcard_id===id).forEach(r=>console.log(`   state: cloze_index=${r.cloze_index} user=${String(r.user_id).slice(0,8)} stability=${r.stability}`));
  const rv=R.filter(r=>r.flashcard_id===id);
  const byIdx={}; rv.forEach(r=>byIdx[r.cloze_index]=(byIdx[r.cloze_index]||0)+1);
  console.log(`   reviews by cloze_index: ${JSON.stringify(byIdx)}   last: ${rv.map(r=>r.reviewed_at).sort().pop()}`);
}
const users=new Set(S.map(r=>r.user_id)); console.log(`\ndistinct users with scheduler state: ${users.size}`);
