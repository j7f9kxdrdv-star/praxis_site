import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));
const { data: c } = await db.from("concepts").select("id,slug").eq("slug", "__HV_FIXTURE__");
for (const x of c ?? []) {
  await db.from("flashcard_concepts").update({ mapping_status: "AI_PROPOSED", source: "HUMAN_REVIEWED" }).eq("concept_id", x.id);
  await db.from("flashcard_concepts").delete().eq("concept_id", x.id);
  await db.from("concepts").delete().eq("id", x.id);
}
const { data: decks } = await db.from("flashcard_decks").select("id").eq("title", "__HV_FIXTURE__");
for (const d of decks ?? []) { await db.from("flashcards").delete().eq("deck_id", d.id); await db.from("flashcard_decks").delete().eq("id", d.id); }
const { data: left } = await db.from("concepts").select("slug").eq("slug", "__HV_FIXTURE__");
const { data: leftD } = await db.from("flashcard_decks").select("id").eq("title", "__HV_FIXTURE__");
console.log(`residue now: ${left?.length ?? 0} concepts, ${leftD?.length ?? 0} decks`);
