// Exercise the ACTUAL split path against the live database on disposable
// fixtures, before trusting it with 28 real mappings.
//
// Everything here is purpose-built and destroyed: a fixture deck, four fixture
// flashcards, one fixture parent concept, two fixture children. Two real
// questions are borrowed from the Chemistry of the Groups backlog, chosen
// because they carry NO mapping at all, so a fixture PRIMARY can be attached
// and removed leaving them exactly as they were. No real flashcard is touched,
// and a fixture card has no review history by construction.
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
import crypto from "node:crypto";
const env = fs.readFileSync(".env.local", "utf8");
const g = (k) => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));

const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };
const page = async (t, c) => { let o = [], f = 0; for (;;) { const { data, error } = await db.from(t).select(c).range(f, f + 999); if (error) throw new Error(`${t}: ${error.message}`); o = o.concat(data); if (data.length < 1000) break; f += 1000; } return o; };

const TAG = "__SPLIT_FIXTURE__";
let deckId = null, cardIds = [], parentId = null, childA = null, childB = null, borrowedQ = [];

// ── learner baseline, taken immediately before anything is created ──
// A digest alone cannot tell studying apart from damage: both change rows.
// So capture the rows themselves, and afterwards demand that every row which
// moved is explained by a review landing in the window. Mikko is studying as
// this runs, so "nothing changed" is the wrong bar; "nothing changed that a
// review does not account for" is the right one.
const SCOLS = "flashcard_id,cloze_index,user_id,stability,difficulty,reps,lapses,fsrs_state,interval_days,next_review_at,last_reviewed_at";
const rowKey = (r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`;
const rowVal = (r) => `${r.stability}|${r.difficulty}|${r.reps}|${r.lapses}|${r.fsrs_state}|${r.interval_days}|${r.next_review_at}|${r.last_reviewed_at}`;
const learnerDigest = async () => {
  const S = await page("flashcard_user_state", SCOLS);
  const R = await page("flashcard_reviews", "flashcard_id,cloze_index,user_id,reviewed_at");
  const QA = await page("question_attempts", "id");
  const m = new Map(S.map((r) => [rowKey(r), rowVal(r)]));
  const lr = new Map(S.map((r) => [rowKey(r), r.last_reviewed_at]));
  return { state: S.length, reviews: R.length, attempts: QA.length, rows: m, lastReviewed: lr, reviewRows: R,
    digest: crypto.createHash("sha256").update([...m].sort().map(([k, v]) => k + "|" + v).join("\n")).digest("hex"),
    at: new Date().toISOString() };
};
const before = await learnerDigest();
console.log("SPLITCONCEPT FIXTURE  " + new Date().toISOString());
console.log(`  learner baseline: ${before.state} scheduler rows, ${before.reviews} reviews, ${before.attempts} attempts\n`);

try {
  // ── build the fixture ──
  const { data: deck, error: de } = await db.from("flashcard_decks")
    .insert({ section: "biochemistry", topic: TAG, subtopic: TAG, title: TAG, description: "disposable", sort_order: 99999 })
    .select("id").single();
  if (de) throw new Error("deck: " + de.message);
  deckId = deck.id;

  const mk = (pos, text) => ({ deck_id: deckId, card_type: "cloze", cloze_text: text, cloze_count: 1, position: pos, front_text: null, back_text: null });
  const { data: cards, error: ce } = await db.from("flashcards").insert([
    mk(1, "Fixture card {{c1::one}}"), mk(2, "Fixture card {{c1::two}}"),
    mk(3, "Fixture card {{c1::three}}"), mk(4, "Fixture straddle {{c1::card}}"),
  ]).select("id,position");
  if (ce) throw new Error("cards: " + ce.message);
  cardIds = cards.sort((a, b) => a.position - b.position).map((c) => c.id);

  const { data: par, error: pe } = await db.from("concepts")
    .insert({ slug: TAG + "PARENT", canonical_name: "Split Fixture Parent", status: "ACTIVE_SEED", object_type: "CONTENT" })
    .select("id,status,version").single();
  if (pe) throw new Error("parent: " + pe.message);
  parentId = par.id;

  // Two real questions with no mapping at all, so PRIMARY is free.
  const allQC = await page("question_concepts", "question_id,concept_id");
  const mapped = new Set(allQC.map((r) => r.question_id));
  const allQ = await page("questions", "id,subtopic");
  borrowedQ = allQ.filter((q) => !mapped.has(q.id)).slice(0, 2).map((q) => q.id);
  if (borrowedQ.length !== 2) throw new Error("need 2 unmapped questions to borrow");

  const fcRows = cardIds.map((id) => ({ flashcard_id: id, concept_id: parentId, role: "PRIMARY", mapping_status: "AI_PROPOSED", source: "AI_PROPOSED", confidence: 0.9 }));
  const { error: fe } = await db.from("flashcard_concepts").insert(fcRows);
  if (fe) throw new Error("fixture card mappings: " + fe.message);
  const qcRows = borrowedQ.map((id) => ({ question_id: id, concept_id: parentId, role: "PRIMARY", mapping_status: "AI_PROPOSED", source: "AI_PROPOSED", confidence: 0.9 }));
  const { error: qe } = await db.from("question_concepts").insert(qcRows);
  if (qe) throw new Error("fixture question mappings: " + qe.message);
  console.log(`  fixture built: 4 cards + 2 borrowed questions on one ACTIVE parent\n`);

  // ── ORDERING PROOF: the destination check is INSERT-only ──
  await db.from("concepts").update({ status: "DEPRECATED" }).eq("id", parentId);
  const { error: insDep } = await db.from("flashcard_concepts")
    .insert({ flashcard_id: cardIds[0], concept_id: parentId, role: "SECONDARY", mapping_status: "AI_PROPOSED", source: "AI_PROPOSED" });
  chk("a DEPRECATED concept refuses a NEW mapping (INSERT is guarded)", !!insDep);
  await db.from("concepts").update({ status: "ACTIVE_SEED" }).eq("id", parentId);

  // ── the split itself ──
  const { data: kids, error: ke } = await db.from("concepts").insert([
    { slug: TAG + "CHILD_A", canonical_name: "Split Fixture Child A", status: "ACTIVE_SEED", object_type: "CONTENT", description: "a" },
    { slug: TAG + "CHILD_B", canonical_name: "Split Fixture Child B", status: "ACTIVE_SEED", object_type: "CONTENT", description: "b" },
  ]).select("id,slug,status");
  if (ke) throw new Error("children: " + ke.message);
  childA = kids.find((k) => k.slug.endsWith("CHILD_A")).id;
  childB = kids.find((k) => k.slug.endsWith("CHILD_B")).id;

  chk("two new children created, both ACTIVE", kids.length === 2 && kids.every((k) => k.status === "ACTIVE_SEED"));
  chk("children have stable new UUIDs, distinct from each other and the parent",
    childA && childB && childA !== childB && childA !== parentId && childB !== parentId);

  // Repoint FIRST, while the parent is still active. Cards 1,2 -> A; 3,4 -> B.
  const toA = [cardIds[0], cardIds[1]], toB = [cardIds[2], cardIds[3]];
  for (const [ids, target] of [[toA, childA], [toB, childB]]) {
    const { error } = await db.from("flashcard_concepts")
      .update({ concept_id: target, mapping_status: "NEEDS_REVIEW" })
      .eq("concept_id", parentId).in("flashcard_id", ids);
    if (error) throw new Error("repoint cards: " + error.message);
  }
  const { error: qrep } = await db.from("question_concepts")
    .update({ concept_id: childA, mapping_status: "NEEDS_REVIEW" })
    .eq("concept_id", parentId).eq("question_id", borrowedQ[0]);
  if (qrep) throw new Error("repoint q1: " + qrep.message);
  const { error: qrep2 } = await db.from("question_concepts")
    .update({ concept_id: childB, mapping_status: "NEEDS_REVIEW" })
    .eq("concept_id", parentId).eq("question_id", borrowedQ[1]);
  if (qrep2) throw new Error("repoint q2: " + qrep2.message);

  // The justified extra SECONDARY, on the straddle card, inserted while the
  // destination is active.
  const { error: secErr } = await db.from("flashcard_concepts")
    .insert({ flashcard_id: cardIds[3], concept_id: childA, role: "SECONDARY", mapping_status: "NEEDS_REVIEW", source: "AI_PROPOSED", confidence: 0.9 });
  chk("a justified SECONDARY can be added alongside a PRIMARY", !secErr, secErr?.message ?? "");

  // Deprecate the parent LAST, with no successor.
  const { error: dep } = await db.from("concepts")
    .update({ status: "DEPRECATED", deprecated_by: null }).eq("id", parentId);
  if (dep) throw new Error("deprecate: " + dep.message);

  // ── assertions ──
  const par2 = (await page("concepts", "id,status,deprecated_by,version")).find((c) => c.id === parentId);
  chk("parent is DEPRECATED", par2.status === "DEPRECATED", par2.status);
  chk("parent deprecated_by is NULL, no fake successor", par2.deprecated_by === null, String(par2.deprecated_by));
  const allC = await page("concepts", "id,deprecated_by,status");
  chk("nothing else was pointed at either child as a successor",
    !allC.some((c) => c.deprecated_by === childA || c.deprecated_by === childB));

  const fcNow = (await page("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source")).filter((r) => cardIds.includes(r.flashcard_id));
  const qcNow = (await page("question_concepts", "question_id,concept_id,role,mapping_status,source")).filter((r) => borrowedQ.includes(r.question_id));
  chk("no flashcard mapping remains on the deprecated parent", !fcNow.some((r) => r.concept_id === parentId));
  chk("no question mapping remains on the deprecated parent", !qcNow.some((r) => r.concept_id === parentId));
  chk("cards redistributed to the intended children",
    toA.every((id) => fcNow.some((r) => r.flashcard_id === id && r.concept_id === childA && r.role === "PRIMARY")) &&
    toB.every((id) => fcNow.some((r) => r.flashcard_id === id && r.concept_id === childB && r.role === "PRIMARY")));
  chk("questions redistributed to the intended children",
    qcNow.some((r) => r.question_id === borrowedQ[0] && r.concept_id === childA) &&
    qcNow.some((r) => r.question_id === borrowedQ[1] && r.concept_id === childB));
  chk("every redistributed mapping is NEEDS_REVIEW",
    [...fcNow, ...qcNow].every((r) => r.mapping_status === "NEEDS_REVIEW"),
    [...new Set([...fcNow, ...qcNow].map((r) => r.mapping_status))].join(","));
  chk("PRIMARY role preserved on every repointed mapping",
    fcNow.filter((r) => toA.includes(r.flashcard_id) || r.flashcard_id === cardIds[2]).every((r) => r.role === "PRIMARY"));
  const straddle = fcNow.filter((r) => r.flashcard_id === cardIds[3]);
  chk("straddle card holds exactly one PRIMARY and one SECONDARY, on different children",
    straddle.length === 2 &&
    straddle.filter((r) => r.role === "PRIMARY").length === 1 &&
    straddle.filter((r) => r.role === "SECONDARY").length === 1 &&
    new Set(straddle.map((r) => r.concept_id)).size === 2,
    straddle.map((r) => `${r.role}->${r.concept_id === childA ? "A" : "B"}`).join(", "));
  const live = new Set(allC.filter((c) => c.status !== "DEPRECATED").map((c) => c.id));
  chk("no mapping targets a deprecated concept", [...fcNow, ...qcNow].every((r) => live.has(r.concept_id)));

  // ── the gap worth knowing about ──
  const { error: updOntoDep } = await db.from("flashcard_concepts")
    .update({ concept_id: parentId }).eq("flashcard_id", cardIds[0]).eq("concept_id", childA);
  chk("KNOWN GAP: an UPDATE onto a deprecated concept is NOT blocked, so order matters",
    !updOntoDep, updOntoDep ? "blocked after all" : "not blocked, as expected");
  if (!updOntoDep) await db.from("flashcard_concepts").update({ concept_id: childA }).eq("flashcard_id", cardIds[0]).eq("concept_id", parentId);
} catch (err) {
  console.error("  FIXTURE ERROR:", err.message);
  P.push("fixture threw: " + err.message);
} finally {
  // ── teardown ──
  for (const cid of [parentId, childA, childB].filter(Boolean)) {
    await db.from("flashcard_concepts").delete().eq("concept_id", cid);
    await db.from("question_concepts").delete().eq("concept_id", cid);
    await db.from("concept_aliases").delete().eq("concept_id", cid);
  }
  if (cardIds.length) await db.from("flashcards").delete().in("id", cardIds);
  if (deckId) await db.from("flashcard_decks").delete().eq("id", deckId);
  for (const cid of [parentId, childA, childB].filter(Boolean)) await db.from("concepts").delete().eq("id", cid);

  console.log("\nTEARDOWN");
  const C = await page("concepts", "id,slug");
  const leftC = C.filter((c) => c.slug.startsWith(TAG));
  const leftD = (await page("flashcard_decks", "id,title")).filter((d) => d.title === TAG);
  const leftF = (await page("flashcards", "id,deck_id")).filter((f) => cardIds.includes(f.id));
  const leftFC = (await page("flashcard_concepts", "flashcard_id,concept_id")).filter((r) => cardIds.includes(r.flashcard_id) || [parentId, childA, childB].includes(r.concept_id));
  const leftQC = (await page("question_concepts", "question_id,concept_id")).filter((r) => [parentId, childA, childB].includes(r.concept_id));
  chk("all fixture residue removed",
    !leftC.length && !leftD.length && !leftF.length && !leftFC.length && !leftQC.length,
    `concepts ${leftC.length}, decks ${leftD.length}, cards ${leftF.length}, card-maps ${leftFC.length}, q-maps ${leftQC.length}`);
  const qcBack = (await page("question_concepts", "question_id")).filter((r) => borrowedQ.includes(r.question_id));
  chk("borrowed questions returned to unmapped, exactly as found", qcBack.length === 0, String(qcBack.length));

  const after = await learnerDigest();
  // Correlate: every scheduler row that moved must have a review in the window.
  const changed = [], appeared = [], vanished = [];
  for (const [k, v] of after.rows) {
    if (!before.rows.has(k)) appeared.push(k);
    else if (before.rows.get(k) !== v) changed.push(k);
  }
  for (const k of before.rows.keys()) if (!after.rows.has(k)) vanished.push(k);
  // Correlate on the row's OWN last_reviewed_at rather than on a wall-clock
  // window. The baseline's reads are not atomic, so a review can land between
  // the state read and the review read and look unexplained purely from timing.
  // A row whose last_reviewed_at moved forward was, by construction, reviewed.
  const reviewKeys = new Set(after.reviewRows.map((r) => `${r.flashcard_id}|${r.cloze_index}|${r.user_id}`));
  const advanced = (k) => {
    const b = before.lastReviewed.get(k) ?? null, a = after.lastReviewed.get(k) ?? null;
    return a !== null && (b === null || new Date(a) > new Date(b));
  };
  const unexplained = [...changed, ...appeared].filter((k) => !(advanced(k) && reviewKeys.has(k)));
  chk("no scheduler row vanished", vanished.length === 0, String(vanished.length));
  chk("every scheduler row that moved is explained by a review in the window",
    unexplained.length === 0,
    `${changed.length} changed, ${appeared.length} new, ${changed.filter(advanced).length} with a fresh review on the row, ${unexplained.length} unexplained`);
  chk("no attempt row moved", after.attempts === before.attempts, `${after.attempts} attempts`);
  chk("reviews only ever grow", after.reviews >= before.reviews, `${before.reviews} -> ${after.reviews}`);

  console.log(P.length ? `\n${P.length} FAILURE(S):\n  ` + P.join("\n  ") : "\nAll fixture checks pass. The split path behaves as the module documents.");
  process.exit(P.length ? 1 : 0);
}
