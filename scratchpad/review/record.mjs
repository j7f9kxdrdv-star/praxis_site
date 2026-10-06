// Append-only review manifest. A decision, once recorded, is not silently
// rewritten: re-recording a row that already has a decision is refused, because
// the manifest is the only record of what a human actually approved and the
// final migration is generated from it.
//
// A decision may carry `additions`: new mappings the reviewer approved alongside
// confirming the row. Concept names are resolved against the live table here, so
// no UUID is ever hand-copied into a decision, and an addition onto a DEPRECATED
// concept is refused at manifest time rather than by the database trigger.
import fs from "node:fs";
import { all } from "../backfill/record.mjs";
const MAN = "scratchpad/review/manifest.json";
const rows = JSON.parse(fs.readFileSync("scratchpad/review/rows.json", "utf8"));
const byN = new Map(rows.map((r) => [r.n, r]));
const C = await all("concepts", "id,canonical_name,status");
const byName = new Map(C.map((c) => [c.canonical_name, c]));
const man = fs.existsSync(MAN) ? JSON.parse(fs.readFileSync(MAN, "utf8")) : { reviewer: "Mikko", decisions: [] };
const decided = new Set(man.decisions.map((d) => d.row));
const incoming = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
const problems = [];
for (const d of incoming) {
  if (decided.has(d.row)) { problems.push(`row ${d.row} already decided on ${man.decisions.find((x) => x.row === d.row).timestamp}`); continue; }
  const r = byN.get(d.row);
  if (!r) { problems.push(`row ${d.row} is not in the queue`); continue; }
  if (d.decision === "CONFIRM_CURRENT_MAPPING") {
    if (d.approvedConcept !== r.concept) problems.push(`row ${d.row}: CONFIRM but approved concept "${d.approvedConcept}" != current "${r.concept}"`);
    if (d.approvedRole !== r.role) problems.push(`row ${d.row}: CONFIRM but approved role ${d.approvedRole} != current ${r.role}`);
  }
  for (const a of d.additions || []) {
    const c = byName.get(a.concept);
    if (!c) { problems.push(`row ${d.row}: addition names no live concept "${a.concept}"`); continue; }
    if (c.status === "DEPRECATED") problems.push(`row ${d.row}: addition targets DEPRECATED ${a.concept}`);
    if (c.canonical_name === r.concept) problems.push(`row ${d.row}: addition duplicates the row's own concept`);
    if (a.role !== "SECONDARY") problems.push(`row ${d.row}: an addition must be SECONDARY (one PRIMARY per item), got ${a.role}`);
  }
}
if (problems.length) { console.error("REFUSED:\n  " + problems.join("\n  ")); process.exit(1); }
const ts = new Date().toISOString();
for (const d of incoming) {
  const r = byN.get(d.row);
  man.decisions.push({
    row: d.row, table: r.table, item_id: r.item_id,
    old_concept_id: r.concept_id, old_concept: r.concept, old_role: r.role,
    approved_concept_id: d.decision === "CONFIRM_CURRENT_MAPPING" ? r.concept_id : null,
    approved_concept: d.approvedConcept, approved_role: d.approvedRole,
    decision: d.decision, reviewer: man.reviewer, timestamp: ts,
    rationale: d.rationale, resulting_mapping_status: d.decision === "REMAIN_UNRESOLVED" ? "NEEDS_REVIEW" : "HUMAN_VALIDATED",
    ...(d.additions ? { additions: d.additions.map((a) => ({
      new_row: true, table: r.table, item_id: r.item_id,
      concept_id: byName.get(a.concept).id, concept: a.concept, role: a.role,
      resulting_mapping_status: "HUMAN_VALIDATED", resulting_source: "HUMAN_REVIEWED",
      rationale: a.rationale,
    })) } : {}),
  });
}
man.decisions.sort((a, b) => a.row - b.row);
fs.writeFileSync(MAN, JSON.stringify(man, null, 1));
const adds = man.decisions.flatMap((d) => d.additions || []);
console.log(`recorded ${incoming.length} decision(s); manifest holds ${man.decisions.length} of ${rows.length} rows + ${adds.length} addition(s)`);
console.log("  " + JSON.stringify(man.decisions.reduce((a, d) => ((a[d.decision] = (a[d.decision] || 0) + 1), a), {})));
console.log("  undecided: " + (rows.filter((r) => !man.decisions.some((d) => d.row === r.n)).map((r) => r.n).join(", ") || "(none)"));
for (const a of adds) console.log(`  + ${a.table} ${a.item_id.slice(0, 8)} ${a.role} -> ${a.concept} (${a.concept_id.slice(0, 8)})`);
