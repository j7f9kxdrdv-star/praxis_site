// Compare the live descriptions against the COMMITTED MIGRATION FILE rather
// than against a JSON fixture written before the file was finalised. The file
// is what ran; the fixture was a snapshot of an earlier draft.
import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const sql = fs.readFileSync("supabase/migrations/20260930_vector_slug_convention.sql", "utf8");
const want = new Map();
const re = /slug\s*=\s*'(QK_[A-Z_]+)',\s*\n\s*description\s*=\s*\$d\$([\s\S]*?)\$d\$/g;
let m; while ((m = re.exec(sql))) want.set(m[1], m[2]);
console.log(`parsed ${want.size} slug/description pairs out of the migration file\n`);
const C = await all("concepts", "slug,description");
let bad = 0;
for (const [slug, def] of want) {
  const live = C.find((c) => c.slug === slug);
  const same = live && live.description === def;
  if (!same) bad++;
  console.log(`  ${same ? "ok  " : "FAIL"}  ${slug}`);
  console.log(`         file: ${JSON.stringify(def)}`);
  console.log(`         live: ${JSON.stringify(live?.description)}`);
}
console.log(bad ? `\n${bad} MISMATCH(ES)` : "\nAll four descriptions in the database are byte-identical to the file that ran.");
process.exit(bad ? 1 : 0);
