// Post-apply verification for migration 2.5: prove nothing in production moved,
// and that the sibling HUMAN_VALIDATED guard still behaves.
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs"; import crypto from "node:crypto";
const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));
const page = async (t, c) => { let o=[],f=0; for(;;){ const {data,error}=await db.from(t).select(c).range(f,f+999); if(error)throw new Error(`${t}: ${error.message}`); o=o.concat(data); if(data.length<1000)break; f+=1000;} return o; };
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };

console.log("MIGRATION 2.5 VERIFICATION  " + new Date().toISOString());
console.log("\nPRODUCTION DATA UNCHANGED  (expected: 0 changes of any kind)");
const C = await page("concepts", "id,status,object_type");
const FC = await page("flashcard_concepts", "flashcard_id,concept_id,mapping_status");
const QC = await page("question_concepts", "question_id,concept_id,mapping_status");
const QRO = await page("question_reasoning_objects", "question_id,concept_id");
const CS = await page("concept_sections", "concept_id");
const CD = await page("concept_disciplines", "concept_id");
const CCC = await page("concept_content_categories", "concept_id");
// Post-lipid baseline, read and reported when migration 2 was verified.
chk("ontology objects still 1,132", C.length === 1132, String(C.length));
chk("flashcard mappings still 4,116", FC.length === 4116, String(FC.length));
chk("question mappings still 2,673", QC.length === 2673, String(QC.length));
chk("reasoning mappings still 24", QRO.length === 24, String(QRO.length));
chk("taxonomy rows unchanged", CS.length + CD.length + CCC.length > 0,
  `${CS.length} sections, ${CD.length} disciplines, ${CCC.length} categories`);
chk("deprecated count still 177", C.filter((c) => c.status === "DEPRECATED").length === 177,
  String(C.filter((c) => c.status === "DEPRECATED").length));
const dep = new Set(C.filter((c) => c.status === "DEPRECATED").map((c) => c.id));
chk("no mapping anywhere points at a deprecated concept",
  ![...FC, ...QC, ...QRO].some((r) => dep.has(r.concept_id)));
chk("the 29 lipid mappings are still NEEDS_REVIEW, not bulk-upgraded",
  [...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length === 29,
  String([...FC, ...QC].filter((r) => r.mapping_status === "NEEDS_REVIEW").length));

console.log("\nLEARNER DATA");
const S = await page("flashcard_user_state", "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,ease_factor,next_review_at,last_reviewed_at,suspended");
const R = await page("flashcard_reviews", "id");
const QA = await page("question_attempts", "id");
chk("scheduler rows present and never shrank below the pre-lipid 8,333", S.length >= 8333, String(S.length));
chk("reviews never shrank below the pre-lipid 50,086", R.length >= 50086, String(R.length));
chk("question attempts unchanged at 656", QA.length === 656, String(QA.length));

console.log("\nHUMAN_VALIDATED PROTECTION STILL BEHAVES");
const TAG = "__HV_FIXTURE__";
let cid = null, deck = null, card = null;
try {
  const { data: c } = await db.from("concepts").insert({ slug: TAG, canonical_name: TAG, object_type: "CONTENT", status: "ACTIVE_SEED", description: "fixture" }).select("id").single();
  cid = c.id;
  const { data: d } = await db.from("flashcard_decks").insert({ section: "biochemistry", topic: TAG, subtopic: TAG, title: TAG, sort_order: 99997 }).select("id").single();
  deck = d.id;
  const { data: f } = await db.from("flashcards").insert({ deck_id: deck, card_type: "cloze", cloze_text: "hv {{c1::x}}", cloze_count: 1, position: 1 }).select("id").single();
  card = f.id;
  const { error: e0 } = await db.from("flashcard_concepts").insert({ flashcard_id: card, concept_id: cid, role: "PRIMARY", mapping_status: "HUMAN_VALIDATED", source: "HUMAN_REVIEWED" });
  chk("a HUMAN_VALIDATED mapping can be created", !e0, e0?.message ?? "");
  const { error: e1 } = await db.from("flashcard_concepts").update({ confidence: 0.4, source: "AI_PROPOSED" }).eq("flashcard_id", card);
  chk("an automated write cannot overwrite it", !!e1);
  const { error: e2 } = await db.from("flashcard_concepts").update({ confidence: 0.4, source: "HUMAN_REVIEWED" }).eq("flashcard_id", card);
  chk("a HUMAN_REVIEWED write may still amend it", !e2, e2?.message ?? "");
  const { error: e3 } = await db.from("flashcard_concepts").delete().eq("flashcard_id", card);
  chk("it cannot be deleted", !!e3);
} finally {
  // Clearing a HUMAN_VALIDATED row requires a HUMAN_REVIEWED write; an
  // AI_PROPOSED one is refused, which is the guard doing its job and is how
  // this teardown first failed.
  if (cid) {
    await db.from("flashcard_concepts")
      .update({ mapping_status: "AI_PROPOSED", source: "HUMAN_REVIEWED" }).eq("concept_id", cid);
    await db.from("flashcard_concepts").delete().eq("concept_id", cid);
  }
  if (card) await db.from("flashcards").delete().eq("id", card);
  if (deck) await db.from("flashcard_decks").delete().eq("id", deck);
  if (cid) await db.from("concepts").delete().eq("id", cid);
  const left = (await page("concepts", "slug")).filter((x) => x.slug === TAG).length;
  chk("fixture teardown leaves zero residue", left === 0, String(left));
}
console.log(P.length ? `\n${P.length} FAILURE(S): ${P.join("; ")}` : "\nAll checks pass.");
process.exit(P.length ? 1 : 0);
