// Is the FSRS digest stable when NOTHING happens between two reads?
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs"; import crypto from "node:crypto";
const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));

const pageUnordered = async (t, c) => { let o=[],f=0; for(;;){ const {data,error}=await db.from(t).select(c).range(f,f+999); if(error)throw new Error(error.message); o=o.concat(data); if(data.length<1000)break; f+=1000;} return o; };
const pageOrdered = async (t, c, key) => { let o=[],f=0; for(;;){ const {data,error}=await db.from(t).select(c).order(key,{ascending:true}).range(f,f+999); if(error)throw new Error(error.message); o=o.concat(data); if(data.length<1000)break; f+=1000;} return o; };

const cols = "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,next_review_at";
const key = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const line = (r) => `${key(r)}|${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.next_review_at}`;
const dig = (rows) => crypto.createHash("sha256").update(rows.map(line).sort().join("\n")).digest("hex");

const a = await pageUnordered("flashcard_user_state", cols);
const b = await pageUnordered("flashcard_user_state", cols);
console.log(`UNORDERED pagination, two back-to-back reads with nothing in between:`);
console.log(`  read 1: ${a.length} rows, digest ${dig(a).slice(0,16)}`);
console.log(`  read 2: ${b.length} rows, digest ${dig(b).slice(0,16)}`);
console.log(`  identical: ${dig(a) === dig(b)}`);
const ka = new Set(a.map(key)), kb = new Set(b.map(key));
console.log(`  distinct keys: ${ka.size} vs ${kb.size}   (row count ${a.length} vs ${b.length})`);
console.log(`  duplicate rows within read 1: ${a.length - ka.size}`);
console.log(`  keys in 1 missing from 2: ${[...ka].filter(k=>!kb.has(k)).length}`);

const c1 = await pageOrdered("flashcard_user_state", cols, "flashcard_id");
const c2 = await pageOrdered("flashcard_user_state", cols, "flashcard_id");
console.log(`\nORDERED pagination:`);
console.log(`  read 1: ${c1.length} rows, digest ${dig(c1).slice(0,16)}`);
console.log(`  read 2: ${c2.length} rows, digest ${dig(c2).slice(0,16)}`);
console.log(`  identical: ${dig(c1) === dig(c2)}`);
console.log(`  duplicates within read 1: ${c1.length - new Set(c1.map(key)).size}`);
