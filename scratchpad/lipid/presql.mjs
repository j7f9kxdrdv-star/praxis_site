// Read the generated SQL back and check it against the manifest and the rules.
import fs from "node:fs";
const sql = fs.readFileSync("supabase/migrations/20260930_lipid_mobilization_split.sql", "utf8");
const m = JSON.parse(fs.readFileSync("scratchpad/lipid/manifest.json", "utf8"));
const P = [];
const chk = (n, pass, d = "") => { console.log(`  ${pass ? "ok  " : "FAIL"}  ${n}${d ? "   " + d : ""}`); if (!pass) P.push(n); };
const exec = sql.replace(/\/\*[\s\S]*?\*\//g, " ").split("\n").map((l) => { const i = l.indexOf("--"); return i === -1 ? l : l.slice(0, i); }).join("\n");

console.log("PRE-APPLY AUDIT OF THE GENERATED SQL");
const LEARNER = ["flashcard_reviews","flashcard_user_state","question_attempts","practice_sessions","learner_events","learner_state_snapshots","performance_reports","daily_activity"];
const hits = [];
for (const t of LEARNER) for (const v of ["INSERT\\s+INTO","UPDATE","DELETE\\s+FROM","TRUNCATE"]) {
  const f = exec.match(new RegExp(`\\b${v}\\s+(?:ONLY\\s+)?(?:public\\.)?${t}\\b`, "gi"));
  if (f) hits.push(t);
}
chk("no learner-history table is written", hits.length === 0, hits.join(", "));
const verbs = [...new Set((exec.match(/\b(INSERT\s+INTO|UPDATE|DELETE\s+FROM|TRUNCATE|DROP|ALTER\s+TABLE)\s+\S+/gi) || []).map((v) => v.replace(/\s+/g, " ")))];
console.log("     write verbs: " + verbs.join(" | "));
chk("no DELETE, DROP, TRUNCATE or ALTER anywhere", !/\b(DELETE\s+FROM|TRUNCATE|DROP\s|ALTER\s+TABLE)/i.test(exec));

const ids = (re) => [...exec.matchAll(re)].map((x) => x[1]);
const quoted = [...new Set([...exec.matchAll(/'([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})'/g)].map((x) => x[1]))];
const expected = new Set([m.parentId, ...m.cardsA, ...m.cardsB, ...m.qA, ...m.qB]);
chk("every UUID in the file comes from the manifest", quoted.every((u) => expected.has(u)),
  quoted.filter((u) => !expected.has(u)).join(", "));
chk("every manifest UUID appears in the file", [...expected].every((u) => quoted.includes(u)),
  [...expected].filter((u) => !quoted.includes(u)).length + " missing");
chk("29 distinct UUIDs: 1 parent + 21 cards + 7 questions", quoted.length === 29, String(quoted.length));
// Count only in the DML, not in the assertions that also name it.
const dml = exec.slice(0, exec.indexOf("DECLARE n INT; a UUID"));
const straddleInDml = (dml.match(new RegExp(m.straddle, "g")) || []).length;
chk("the straddle card is written exactly twice: once repointed, once as the new SECONDARY",
  straddleInDml === 2, String(straddleInDml));
// Locate the two flashcard UPDATE blocks precisely, rather than keying off a
// slug that also appears in the CREATE above them.
const fcUpdates = [...dml.matchAll(/UPDATE public\.flashcard_concepts[\s\S]*?\);/g)].map((x) => x[0]);
chk("there are exactly two flashcard repoint statements", fcUpdates.length === 2, String(fcUpdates.length));
const mobBlock = fcUpdates.find((b) => b.includes(m.slugs[0])) ?? "";
const traBlock = fcUpdates.find((b) => b.includes(m.slugs[1])) ?? "";
chk("the straddle card is repointed to mobilization, and is absent from the transport block",
  mobBlock.includes(m.straddle) && !traBlock.includes(m.straddle));
// Each block also names the parent in its WHERE clause, so exclude it.
const cardsIn = (b) => (b.match(/'([0-9a-f-]{36})'/g) || []).map((x) => x.slice(1, -1)).filter((u) => u !== m.parentId);
chk("the mobilization block lists exactly the 6 approved cards",
  cardsIn(mobBlock).length === 6 && cardsIn(mobBlock).every((u) => m.cardsA.includes(u)),
  String(cardsIn(mobBlock).length));
chk("the transport block lists exactly the 15 approved cards",
  cardsIn(traBlock).length === 15 && cardsIn(traBlock).every((u) => m.cardsB.includes(u)),
  String(cardsIn(traBlock).length));
chk("no card appears in both blocks",
  !cardsIn(mobBlock).some((u) => cardsIn(traBlock).includes(u)));

chk("the parent is deprecated with deprecated_by NULL", /SET status = 'DEPRECATED', deprecated_by = NULL/.test(exec));
chk("nothing is marked HUMAN_VALIDATED", !/HUMAN_VALIDATED'/.test(exec.replace(/mapping_status = 'HUMAN_VALIDATED'/g, "")) || !/SET[^;]*HUMAN_VALIDATED/.test(exec));
chk("every repoint sets NEEDS_REVIEW", (exec.match(/mapping_status = 'NEEDS_REVIEW'/g) || []).length === 4,
  String((exec.match(/mapping_status = 'NEEDS_REVIEW'/g) || []).length));
chk("the new SECONDARY row is NEEDS_REVIEW / AI_PROPOSED", /'SECONDARY', NULL, 'NEEDS_REVIEW', 'AI_PROPOSED'/.test(exec));
chk("the parent is deprecated AFTER the repoints",
  exec.lastIndexOf("SET status = 'DEPRECATED'") > exec.lastIndexOf("SET concept_id = (SELECT id FROM public.concepts WHERE slug = '" + m.slugs[1] + "')"));
chk("the SECONDARY is inserted BEFORE the parent is deprecated",
  exec.indexOf("'SECONDARY'") < exec.lastIndexOf("SET status = 'DEPRECATED'"));
chk("both children are created before anything is repointed",
  exec.indexOf("INSERT INTO public.concepts") < exec.indexOf("UPDATE public.flashcard_concepts"));
console.log(P.length ? `\n${P.length} PROBLEM(S): ${P.join("; ")}` : "\nGenerated SQL matches the manifest and the ordering rules.");
process.exit(P.length ? 1 : 0);
