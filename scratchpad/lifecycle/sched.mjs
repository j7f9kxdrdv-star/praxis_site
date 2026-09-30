import { all } from "../backfill/record.mjs";
const S=await all("flashcard_user_state","flashcard_id,user_id");
const R=await all("flashcard_reviews","flashcard_id");
const ids=["71959e9d-e9e0-4da5-aa03-6286378a591d","4d56a412-90d2-47cb-b0d8-db3a3a06f232"];
ids.forEach(id=>console.log(`${id}\n   scheduler rows: ${S.filter(r=>r.flashcard_id===id).length}   reviews: ${R.filter(r=>r.flashcard_id===id).length}`));
console.log(`\ntotal scheduler rows ${S.length}, total reviews ${R.length}`);
