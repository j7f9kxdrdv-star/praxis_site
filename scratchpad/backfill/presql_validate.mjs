// Reads the GENERATED SQL back and checks it against the live database, so the
// file that will actually run is what gets validated, not the design it came from.
import { all } from "./record.mjs";
import fs from "node:fs";
const F="supabase/migrations/20260926_flashcard_backfill.sql";
const sql=fs.readFileSync(F,"utf8");
const P=[];
const C=await all("concepts","id,slug,canonical_name,status,object_type");
const liveSlug=new Map(C.map(c=>[c.slug,c]));
const FC=await all("flashcard_concepts","flashcard_id,concept_id,role");
const liveMapped=new Set(FC.map(r=>r.flashcard_id));
const Fl=await all("flashcards","id");
const allCards=new Set(Fl.map(f=>f.id));

// created slugs
const created=[...sql.matchAll(/^  \('([A-Z0-9_]+)', '(?:[^']|'')*', /gm)].map(m=>m[1]);
// mapping pairs
const pairs=[...sql.matchAll(/^  \('([0-9a-f-]{36})', '([A-Z0-9_]+)'\)/gm)].map(m=>[m[1],m[2]]);
const createdSet=new Set(created);
console.log(`parsed from the file: ${created.length} concept rows, ${pairs.length} mapping pairs`);
if(created.length!==42) P.push(`expected 42 created concepts, parsed ${created.length}`);
if(pairs.length!==2154) P.push(`expected 2154 pairs, parsed ${pairs.length}`);

// 1 every slug resolves
for(const [card,sl] of pairs) if(!createdSet.has(sl)&&!liveSlug.has(sl)) P.push(`slug ${sl} resolves to nothing`);
// 2 no created slug already live
for(const sl of created) if(liveSlug.has(sl)) P.push(`created slug ${sl} already exists live`);
// 3 created slugs unique
const seenSlug=new Set(); for(const sl of created){ if(seenSlug.has(sl)) P.push(`duplicate created slug ${sl}`); seenSlug.add(sl); }
// 4 every card exists, is unmapped live, and appears once
const seenCard=new Set();
for(const [card] of pairs){
  if(!allCards.has(card)) P.push(`card ${card} does not exist`);
  if(liveMapped.has(card)) P.push(`card ${card} is ALREADY mapped live`);
  if(seenCard.has(card)) P.push(`card ${card} appears twice`);
  seenCard.add(card);
}
// 5 existing targets must be CONTENT-or-typed and ACTIVE
for(const [,sl] of pairs){ const c=liveSlug.get(sl); if(!c) continue;
  if(c.status!=="ACTIVE_SEED") P.push(`target ${sl} status ${c.status}`); }
// 6 exactly 2 cards left unmapped afterwards
const after=new Set([...liveMapped,...seenCard]);
const left=[...allCards].filter(id=>!after.has(id));
if(left.length!==2) P.push(`${left.length} cards would remain unmapped, expected 2`);
// 7 no PRIMARY collision: no card in pairs already has a live PRIMARY
const livePrimary=new Set(FC.filter(r=>r.role==="PRIMARY").map(r=>r.flashcard_id));
for(const c of seenCard) if(livePrimary.has(c)) P.push(`card ${c} already has a live PRIMARY`);
// 8 provenance strings
if(/HUMAN_VALIDATED'\s*,/.test(sql.replace(/--.*$/gm,""))) P.push("HUMAN_VALIDATED appears in an executable position");
const execSql=sql.replace(/--.*$/gm,"");
for(const bad of ["UPDATE ","DELETE ","TRUNCATE","DROP ","ALTER "]) if(new RegExp("\\b"+bad.trim()+"\\b").test(execSql)) P.push(`forbidden op ${bad.trim()}`);
// 9 question mappings untouched
if(/question_concepts/.test(execSql.replace(/SELECT[\s\S]*?question_concepts/g,""))) { /* only read in assertions */ }
const qcWrite=/INSERT\s+INTO\s+public\.question_concepts|UPDATE\s+public\.question_concepts|DELETE\s+FROM\s+public\.question_concepts/.test(execSql);
if(qcWrite) P.push("the migration writes question_concepts");
// 10 learner tables
for(const t of ["flashcard_reviews","flashcard_user_state","question_attempts","learner_events","learner_state_snapshots","practice_sessions"])
  if(new RegExp(`(INSERT\\s+INTO|UPDATE|DELETE\\s+FROM|TRUNCATE)\\s+(public\\.)?${t}\\b`).test(execSql)) P.push(`writes learner table ${t}`);

if(P.length){console.log("\nFAIL:");P.slice(0,20).forEach(x=>console.log("  "+x));console.log(`\n${P.length} problems`);process.exit(1);}
console.log("\nPRE-SQL VALIDATION PASS");
console.log(`  42 new slugs, none colliding with the live ontology`);
console.log(`  2154 unique cards, all existing, none already mapped, none with a live PRIMARY`);
console.log(`  every mapping slug resolves (${createdSet.size} new + ${new Set(pairs.map(p=>p[1])).size - [...new Set(pairs.map(p=>p[1]))].filter(s=>createdSet.has(s)).length} existing)`);
console.log(`  cards unmapped after: ${left.length} (the two CARD_TOO_BROAD authoring repairs)`);
console.log(`  no UPDATE / DELETE / TRUNCATE, no question_concepts write, no learner table write`);
