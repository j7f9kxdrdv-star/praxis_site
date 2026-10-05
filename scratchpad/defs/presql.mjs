import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const sql = fs.readFileSync("supabase/migrations/20261005_research_settings_and_clusters_definitions.sql", "utf8");
const s = JSON.parse(fs.readFileSync("scratchpad/defs/pre_state.json", "utf8"));
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");
const P = []; const chk = (n, p, d = "") => { console.log(`  ${p ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!p) P.push(n); };
const RS = s.researchSettings, PDC = s.personalityDisorderClusters;
console.log("PRE-APPLY AUDIT, MIGRATION 5");
const verbs = [...new Set((exec.match(/^\s*(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE)\s+(?!OF\b)(public\.)?\w+/gim) || []).map((v) => v.trim().replace(/\s+/g, " ")))];
console.log("     write statements: " + verbs.join(" | "));
chk("the only table written is concepts", verbs.length === 1 && /public\.concepts$/.test(verbs[0]));
chk("exactly two UPDATE statements", (exec.match(/^\s*UPDATE public\.concepts/gm) || []).length === 2);
const setClauses = [...exec.matchAll(/\bUPDATE\s+public\.\w+[\s\S]*?\bSET\b([\s\S]*?)\bWHERE\b/gi)].map((m) => m[1]);
chk("each SET assigns only description and updated_at",
  setClauses.every((c) => /description\s*=/.test(c) && /updated_at\s*=\s*now\(\)/.test(c) &&
    !/\b(slug|canonical_name|object_type|status|version|parent_concept_id|concept_id|deprecated_by)\s*=/.test(c)));
chk("no mapping table is written",
  !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.(flashcard_concepts|question_concepts|question_reasoning_objects)/im.test(exec));
chk("no taxonomy table is written",
  !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.(concept_sections|concept_disciplines|concept_content_categories)/im.test(exec));
chk("no alias is written", !/^\s*(INSERT INTO|UPDATE|DELETE FROM)\s+public\.concept_aliases/im.test(exec));
chk("no learner table named", !/\b(flashcard_reviews|flashcard_user_state|question_attempts|practice_sessions|learner_events|learner_state_snapshots)\b/.test(exec));
chk("no INSERT, DELETE, DROP, TRUNCATE or ALTER", !/\b(INSERT\s+INTO|DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));
chk("each UPDATE is guarded on the expected object_type",
  /WHERE id = '\S+' AND object_type = 'REASONING'/.test(exec) && /WHERE id = '\S+' AND object_type = 'CONTENT'/.test(exec));
chk("only the two expected UUIDs appear",
  [...new Set([...exec.matchAll(/'([0-9a-f]{8}-[0-9a-f-]{27})'/g)].map((m) => m[1]))].every((u) => [RS.id, PDC.id].includes(u)));
chk("the Research Settings definition states the operation", /inferential/.test(exec));
chk("the clusters definition names where the individual disorders live", /Cluster A, Cluster B and Cluster C/.test(exec));

console.log("\nLIVE STATE STILL MATCHES THE SNAPSHOT");
const C = await all("concepts", "id,slug,canonical_name,description,object_type,status,version,parent_concept_id");
const FC = await all("flashcard_concepts", "flashcard_id,concept_id,role,mapping_status,source");
const QC = await all("question_concepts", "question_id,concept_id");
const QRO = await all("question_reasoning_objects", "question_id,concept_id");
const rs = C.find((c) => c.id === RS.id), pdc = C.find((c) => c.id === PDC.id);
chk("Research Settings still REASONING, ACTIVE, v" + RS.version,
  rs.object_type === "REASONING" && rs.status === "ACTIVE_SEED" && rs.version === RS.version);
chk("Personality Disorder Clusters still CONTENT, ACTIVE, v" + PDC.version,
  pdc.object_type === "CONTENT" && pdc.status === "ACTIVE_SEED" && pdc.version === PDC.version);
chk("neither has a parent", !rs.parent_concept_id && !pdc.parent_concept_id);
const setOf = (rows, k) => rows.map((r) => `${r[k]}|${r.role ?? ""}|${r.mapping_status ?? ""}|${r.source ?? ""}`).sort().join(",");
chk("Research Settings flashcard mapping SET is identical to the snapshot",
  setOf(FC.filter((r) => r.concept_id === RS.id), "flashcard_id") === setOf(RS.flashcardMappings, "flashcard_id"));
chk("clusters flashcard mapping SET is identical to the snapshot",
  setOf(FC.filter((r) => r.concept_id === PDC.id), "flashcard_id") === setOf(PDC.flashcardMappings, "flashcard_id"));
chk("neither object has any question or reasoning mapping",
  ![...QC, ...QRO].some((r) => r.concept_id === RS.id || r.concept_id === PDC.id));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nDefinitions-only migration: the only writes are two description fields.");
process.exit(P.length ? 1 : 0);
