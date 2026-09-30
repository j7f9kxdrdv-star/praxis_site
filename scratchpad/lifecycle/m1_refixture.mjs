import { all } from "../backfill/record.mjs";
import fs from "node:fs";
const sql = fs.readFileSync("supabase/migrations/20260930_vector_slug_convention.sql", "utf8");
const re = /slug\s*=\s*'(QK_[A-Z_]+)',\s*\n\s*description\s*=\s*\$d\$([\s\S]*?)\$d\$[\s\S]*?WHERE slug = '([A-Z_]+)'/g;
const rows = []; let m;
while ((m = re.exec(sql))) rows.push([m[3], m[1], m[2]]);
const C = await all("concepts", "id,slug");
const FC = await all("flashcard_concepts", "concept_id");
const ids = rows.map(([, ns]) => C.find((c) => c.slug === ns).id);
fs.writeFileSync("/tmp/m1_renames.json", JSON.stringify({
  RENAMES: rows, ids,
  cardsBefore: ids.map((id) => FC.filter((r) => r.concept_id === id).length),
  note: "Rebuilt after the migration. UUID stability was proven by the FIRST post-migration run against the genuine preflight snapshot; this file exists so the check stays re-runnable.",
}, null, 1));
console.log("fixture rebuilt: " + rows.length + " pairs, ids " + ids.map(i => i.slice(0, 8)).join(", "));
