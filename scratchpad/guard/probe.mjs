// Behavioural audit of the deprecated-target guard on all three mapping tables.
// Reads the LIVE behaviour rather than the migration files: attempts an INSERT
// and a concept_id UPDATE onto a deprecated concept and records what happens.
// Runs identically before and after the fix, so the two outputs are comparable.
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));
const page = async (t, c) => { let o=[],f=0; for(;;){ const {data,error}=await db.from(t).select(c).range(f,f+999); if(error)throw new Error(`${t}: ${error.message}`); o=o.concat(data); if(data.length<1000)break; f+=1000;} return o; };
const TAG = "__GUARD_PROBE__";
const label = process.argv[2] ?? "probe";
let ids = { active: null, active2: null, deprecated: null, reasoning: null, deck: null, card: null };
const rows = [];
try {
  const mk = async (slug, name, type, status) => {
    const { data, error } = await db.from("concepts")
      .insert({ slug: TAG + slug, canonical_name: TAG + name, object_type: type, status, description: "probe" })
      .select("id").single();
    if (error) throw new Error(`concept ${slug}: ${error.message}`);
    return data.id;
  };
  ids.active = await mk("A", " A", "CONTENT", "ACTIVE_SEED");
  ids.active2 = await mk("B", " B", "CONTENT", "ACTIVE_SEED");
  ids.deprecated = await mk("D", " D", "CONTENT", "ACTIVE_SEED");
  ids.reasoning = await mk("R", " R", "REASONING", "ACTIVE_SEED");
  const { data: deck } = await db.from("flashcard_decks")
    .insert({ section: "biochemistry", topic: TAG, subtopic: TAG, title: TAG, sort_order: 99998 }).select("id").single();
  ids.deck = deck.id;
  const { data: card } = await db.from("flashcards")
    .insert({ deck_id: ids.deck, card_type: "cloze", cloze_text: "probe {{c1::x}}", cloze_count: 1, position: 1 }).select("id").single();
  ids.card = card.id;
  const allQC = await page("question_concepts", "question_id");
  const mapped = new Set(allQC.map((r) => r.question_id));
  const freeQ = (await page("questions", "id")).filter((q) => !mapped.has(q.id)).slice(0, 2).map((q) => q.id);
  // deprecate D only after the rows that must point at it are made
  const probe = async (table, idCol, idVal, targetCol = "concept_id") => {
    const base = { [idCol]: idVal, [targetCol]: ids.active, mapping_status: "AI_PROPOSED", source: "AI_PROPOSED" };
    if (table !== "question_reasoning_objects") base.role = "PRIMARY";
    const { error: insActive } = await db.from(table).insert(base);
    rows.push([table, "INSERT onto ACTIVE", insActive ? "REFUSED" : "allowed"]);
    const { error: updActive } = await db.from(table).update({ [targetCol]: ids.active2 }).eq(idCol, idVal).eq(targetCol, ids.active);
    rows.push([table, "UPDATE active -> active", updActive ? "REFUSED" : "allowed"]);
    const { error: updMeta } = await db.from(table).update({ confidence: 0.55 }).eq(idCol, idVal).eq(targetCol, ids.active2);
    rows.push([table, "UPDATE metadata only", updMeta ? "REFUSED" : "allowed"]);
    const { error: insDep } = await db.from(table).insert({ ...base, [targetCol]: ids.deprecated });
    rows.push([table, "INSERT onto DEPRECATED", insDep ? "REFUSED" : "ALLOWED <- gap"]);
    const { error: updDep } = await db.from(table).update({ [targetCol]: ids.deprecated }).eq(idCol, idVal).eq(targetCol, ids.active2);
    rows.push([table, "UPDATE active -> DEPRECATED", updDep ? "REFUSED" : "ALLOWED <- gap"]);
    await db.from(table).delete().eq(idCol, idVal);
  };
  await db.from("concepts").update({ status: "DEPRECATED" }).eq("id", ids.deprecated);
  await probe("flashcard_concepts", "flashcard_id", ids.card);
  await probe("question_concepts", "question_id", freeQ[0]);
  // reasoning table needs a REASONING target, so swap the active ones
  const rid = ids.active, rid2 = ids.active2;
  ids.active = ids.reasoning;
  const { data: r2 } = await db.from("concepts").insert({ slug: TAG + "R2", canonical_name: TAG + " R2", object_type: "REASONING", status: "ACTIVE_SEED", description: "probe" }).select("id").single();
  ids.active2 = r2.id;
  await db.from("concepts").update({ object_type: "REASONING" }).eq("id", ids.deprecated);
  await probe("question_reasoning_objects", "question_id", freeQ[1]);
  ids.active = rid; ids.active2 = rid2; ids.reasoning2 = r2.id;
} catch (e) {
  console.error("PROBE ERROR:", e.message);
} finally {
  const all = Object.values(ids).filter(Boolean);
  for (const t of ["flashcard_concepts", "question_concepts", "question_reasoning_objects"])
    for (const cid of all) await db.from(t).delete().eq("concept_id", cid);
  if (ids.card) await db.from("flashcards").delete().eq("id", ids.card);
  if (ids.deck) await db.from("flashcard_decks").delete().eq("id", ids.deck);
  const C = await page("concepts", "id,slug");
  for (const c of C.filter((x) => x.slug.startsWith(TAG))) await db.from("concepts").delete().eq("id", c.id);
  const left = (await page("concepts", "slug")).filter((x) => x.slug.startsWith(TAG)).length;
  console.log(`DEPRECATED-TARGET GUARD, ${label}`);
  const w = Math.max(...rows.map((r) => r[0].length));
  rows.forEach(([t, c, r]) => console.log(`  ${t.padEnd(w)}  ${c.padEnd(28)} ${r}`));
  console.log(`  fixture residue: ${left} concepts`);
}
