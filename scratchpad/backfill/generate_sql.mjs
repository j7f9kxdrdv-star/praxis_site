// Emits the final INSERT-only backfill migration. Every row is derived from the
// accumulator, the two design files and /tmp/widening.json. Nothing is typed.
import { all } from "./record.mjs";
import { EARLY } from "./defs.mjs";
import { PROPOSED as IM } from "../immune/design.mjs";
import { PROPOSED as CV } from "../cardio/design.mjs";
import fs from "node:fs";

const A=JSON.parse(fs.readFileSync("/tmp/backfill_map.json","utf8"));
const W=JSON.parse(fs.readFileSync("/tmp/widening.json","utf8"));
const C=await all("concepts","id,slug,canonical_name");
const liveSlug=new Set(C.map(c=>c.slug)), liveName=new Set(C.map(c=>c.canonical_name));
const STOP=new Set(["a","an","the","of","in","and","to","for","its","their","by","on","as","at","versus","with"]);
const slug=n=>n.toUpperCase().replace(/&/g," ").replace(/[^A-Z0-9 ]/g," ").split(/\s+/)
  .filter(w=>w&&!STOP.has(w.toLowerCase())).join("_");
const q=s=>"'"+String(s).replace(/'/g,"''")+"'";

// ── assemble the 42 ──────────────────────────────────────────────────────────
const defs=new Map();
for(const [n,[s,d,cat,def]] of Object.entries(EARLY)) defs.set(n,{sect:s,disc:d,cat,def});
for(const p of IM) defs.set(p.name,{sect:"BIO_BIOCHEM",disc:"BIOLOGY",cat:"Organ Systems",def:p.def});
for(const p of CV) defs.set(p.name,{sect:"BIO_BIOCHEM",disc:"BIOLOGY",cat:"Organ Systems",def:p.def});

const newNames=[...new Set(A.filter(r=>r.isNew).map(r=>r.name))].sort();
const problems=[];
for(const n of newNames){
  if(!defs.has(n)) problems.push(`no definition for "${n}"`);
  if(liveName.has(n)) problems.push(`"${n}" already live`);
  if(liveSlug.has(slug(n))) problems.push(`slug ${slug(n)} already live`);
}
const bySlug={}; newNames.forEach(n=>{const s=slug(n); if(bySlug[s]) problems.push(`slug clash ${s}`); bySlug[s]=n;});
if(problems.length){console.error("PROBLEMS:");problems.forEach(p=>console.error("  "+p));process.exit(1);}

// ── flashcard mappings ───────────────────────────────────────────────────────
// Emitted as (card_uuid, concept_slug) pairs resolved by ONE join rather than a
// correlated subquery per row. Smaller file, a single index scan instead of
// 2,154 lookups, and a slug that fails to resolve becomes a row-count shortfall
// the assertion catches rather than a silently dropped mapping.
const slugOfId=new Map(C.map(c=>[c.id,c.slug]));
const pairs=[];
for(const r of A){
  const sl = r.isNew ? slug(r.name) : slugOfId.get(r.concept);
  if(!sl) problems.push(`no slug resolves for card ${r.card}`);
  else pairs.push([r.card, sl]);
}
if(problems.length){console.error("PROBLEMS:");problems.forEach(x=>console.error("  "+x));process.exit(1);}
const mapLines=pairs.map(([c,sl])=>`  (${q(c)}, ${q(sl)})`);

const L=[];
const P=s=>L.push(s);
P(`-- ============================================================
-- Final flashcard backfill: 42 new CONTENT concepts and 2,154 card mappings
--
-- Closes the flashcard side of the canonical concept layer. Every remaining
-- unmapped flashcard in the bank receives exactly one PRIMARY concept, except
-- two cards held deliberately as CARD_TOO_BROAD authoring repairs.
--
-- WHY 42 NEW OBJECTS IN A MAPPING PHASE. 31 of the 33 decks needed almost no new
-- vocabulary; 376 existing concepts absorbed 1,969 cards. Two chapters had no
-- curriculum layer at all: The Immune System and The Cardiovascular System each
-- carried one concept per question, 89 and 99 of them, every one with an empty
-- description and a name copied verbatim from its question's subtopic. Those are
-- a question index, not a vocabulary, so 34 of the 42 objects build the layer
-- both modalities were missing. All 34 carry at least one exact question
-- alignment, so none ships memory-only once the question side migrates.
--
-- CROSS-MODALITY. Existing concepts holding BOTH recall and application evidence
-- go from 34 to 364. That is the point of the programme: comparing what a student
-- remembers against what they can apply requires one stable id for both.
--
-- PROVENANCE. Every mapping is AI_PROPOSED in both mapping_status and source.
-- The ontology design was approved; 2,154 individual rows were not reviewed one
-- by one, and the provenance must not claim otherwise.
--
-- WRITE SCOPE. concepts, concept_sections, concept_disciplines,
-- concept_content_categories, flashcard_concepts. INSERT only. No UPDATE, no
-- DELETE, no TRUNCATE. No question mapping is touched: question_concepts must
-- read 2,659 before and after. No learner table is read or written.
--
-- WIDENING. 38 rows, all SECONDARY / is_primary = false. These tables carry
-- partial unique indexes on the primary flag, so a widening row written as
-- primary would be silently discarded by ON CONFLICT DO NOTHING.
--
-- DEFERRED, deliberately not here: the lipid mobilisation split, the
-- reducing-sugar merge, the Types of Reactions review, the Personality Disorder
-- Clusters review, and the immune and cardiovascular scenario-label cleanup.
-- Each is an UPDATE or DELETE and belongs to its own lifecycle migration.
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. The 42 new CONTENT concepts.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concepts (slug, canonical_name, description, object_type, status, concept_level)
VALUES`);
const cLines=newNames.map(n=>{const d=defs.get(n);
  return `  (${q(slug(n))}, ${q(n)}, ${q(d.def)}, 'CONTENT', 'ACTIVE_SEED', 'CONCEPT')`;});
P(cLines.join(",\n")+"\nON CONFLICT (slug) DO NOTHING;");
P(`
-- All 42 must exist. Anything else means a slug collided and a concept is missing.
DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.concepts WHERE slug IN (${newNames.map(x=>q(slug(x))).join(", ")});
  IF n <> 42 THEN RAISE EXCEPTION 'expected 42 new concepts, found %', n; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 2. PRIMARY taxonomy for the 42.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, v.sect, true FROM (VALUES`);
P(newNames.map(n=>`  (${q(slug(n))}, ${q(defs.get(n).sect)})`).join(",\n"));
P(`) AS v(slug, sect) JOIN public.concepts c ON c.slug = v.slug
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, v.disc, 'PRIMARY' FROM (VALUES`);
P(newNames.map(n=>`  (${q(slug(n))}, ${q(defs.get(n).disc)})`).join(",\n"));
P(`) AS v(slug, disc) JOIN public.concepts c ON c.slug = v.slug
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_content_categories (concept_id, content_category, is_primary)
SELECT c.id, v.cat, true FROM (VALUES`);
P(newNames.map(n=>`  (${q(slug(n))}, ${q(defs.get(n).cat)})`).join(",\n"));
P(`) AS v(slug, cat) JOIN public.concepts c ON c.slug = v.slug
ON CONFLICT DO NOTHING;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 3. Widening for existing concepts taking a card from another section or
--    discipline. SECONDARY and is_primary = false, never primary.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.concept_disciplines (concept_id, discipline_code, role)
SELECT c.id, v.disc, 'SECONDARY' FROM (VALUES`);
P(W.disciplines.map(([s,d])=>`  (${q(s)}, ${q(d)})`).join(",\n"));
P(`) AS v(slug, disc) JOIN public.concepts c ON c.slug = v.slug
ON CONFLICT DO NOTHING;

INSERT INTO public.concept_sections (concept_id, section_code, is_primary)
SELECT c.id, v.sect, false FROM (VALUES`);
P(W.sections.map(([s,m])=>`  (${q(s)}, ${q(m)})`).join(",\n"));
P(`) AS v(slug, sect) JOIN public.concepts c ON c.slug = v.slug
ON CONFLICT DO NOTHING;

-- The widening must have landed. A partial unique index on the primary flag will
-- silently swallow these rows if they are ever written as primary.
DO $$
DECLARE d int; s int;
BEGIN
  SELECT count(*) INTO d FROM public.concept_disciplines cd JOIN public.concepts c ON c.id=cd.concept_id
    WHERE cd.role='SECONDARY' AND (c.slug, cd.discipline_code) IN (${W.disciplines.map(([s2,d2])=>`(${q(s2)},${q(d2)})`).join(", ")});
  IF d <> ${W.disciplines.length} THEN RAISE EXCEPTION 'expected ${W.disciplines.length} discipline widening rows, found %', d; END IF;
  SELECT count(*) INTO s FROM public.concept_sections cs JOIN public.concepts c ON c.id=cs.concept_id
    WHERE cs.is_primary = false AND (c.slug, cs.section_code) IN (${W.sections.map(([s2,m2])=>`(${q(s2)},${q(m2)})`).join(", ")});
  IF s <> ${W.sections.length} THEN RAISE EXCEPTION 'expected ${W.sections.length} section widening rows, found %', s; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 4. The 2,154 card mappings, one PRIMARY per card.
--
--    Pairs of (flashcard, concept slug) resolved by a single join. Every slug
--    below either already existed or was created in step 1, so a shortfall in
--    the inserted row count means a slug did not resolve.
-- ────────────────────────────────────────────────────────────
INSERT INTO public.flashcard_concepts (flashcard_id, concept_id, role, mapping_status, source)
SELECT v.card::uuid, c.id, 'PRIMARY', 'AI_PROPOSED', 'AI_PROPOSED'
FROM (VALUES`);
P(mapLines.join(",\n"));
P(`) AS v(card, slug)
JOIN public.concepts c ON c.slug = v.slug;

-- Every pair must have resolved. A slug that did not would silently drop rows.
DO $$
DECLARE n int;
BEGIN
  SELECT count(*) INTO n FROM public.flashcard_concepts WHERE source = 'AI_PROPOSED';
  IF n <> 4115 THEN RAISE EXCEPTION 'expected 4115 AI_PROPOSED card mappings, found %', n; END IF;
END $$;`);

P(`
-- ────────────────────────────────────────────────────────────
-- 5. Verification inside the transaction. Anything unexpected is a reason to
--    ROLLBACK rather than COMMIT.
-- ────────────────────────────────────────────────────────────
DO $$
DECLARE v int;
BEGIN
  SELECT count(*) INTO v FROM public.concepts;
  IF v <> 1127 THEN RAISE EXCEPTION 'expected 1127 objects, found %', v; END IF;
  SELECT count(*) INTO v FROM public.flashcard_concepts;
  IF v <> 4115 THEN RAISE EXCEPTION 'expected 4115 card mappings, found %', v; END IF;
  SELECT count(*) INTO v FROM public.question_concepts;
  IF v <> 2659 THEN RAISE EXCEPTION 'question mappings changed: %', v; END IF;
  SELECT count(*) INTO v FROM public.flashcard_concepts WHERE concept_id IS NULL;
  IF v <> 0 THEN RAISE EXCEPTION '% unresolved mappings', v; END IF;
  SELECT count(*) INTO v FROM public.flashcard_concepts
    WHERE mapping_status='HUMAN_VALIDATED' OR source IN ('DETERMINISTIC','DETERMINISTIC_EXACT','LEGACY_EXACT');
  IF v <> 0 THEN RAISE EXCEPTION '% card mappings overstate their provenance', v; END IF;
  SELECT count(*) INTO v FROM public.concept_sections s JOIN public.concepts c ON c.id=s.concept_id
    WHERE c.object_type <> 'CONTENT';
  IF v <> 0 THEN RAISE EXCEPTION '% non-CONTENT objects carry taxonomy', v; END IF;
  -- No card may carry two PRIMARY concepts.
  SELECT count(*) INTO v FROM (SELECT flashcard_id FROM public.flashcard_concepts
    WHERE role='PRIMARY' GROUP BY flashcard_id HAVING count(*) > 1) t;
  IF v <> 0 THEN RAISE EXCEPTION '% cards carry more than one PRIMARY concept', v; END IF;
END $$;

-- Exactly two flashcards remain unmapped, and they are the two authoring repairs.
SELECT count(*) AS unmapped_cards_expect_2
FROM public.flashcards f
WHERE NOT EXISTS (SELECT 1 FROM public.flashcard_concepts fc WHERE fc.flashcard_id = f.id);

-- Shape of the result. Objects 1127, CONTENT 1095, REASONING 12, QUANTITATIVE 20.
SELECT object_type, count(*) FROM public.concepts GROUP BY 1 ORDER BY 1;

-- Provenance of every card mapping. Expect AI_PROPOSED 4115.
SELECT mapping_status, source, count(*) FROM public.flashcard_concepts GROUP BY 1,2 ORDER BY 3 DESC;

COMMIT;`);

const out="supabase/migrations/20260926_flashcard_backfill.sql";
fs.writeFileSync(out,L.join("\n")+"\n");
console.log(`wrote ${out}`);
console.log(`  new concepts: ${newNames.length}`);
console.log(`  card mappings: ${A.length}`);
console.log(`  widening: ${W.disciplines.length} discipline + ${W.sections.length} section`);
console.log(`  lines: ${L.join("\n").split("\n").length}`);
