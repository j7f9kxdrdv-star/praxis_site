// Item 10: before-state for everything this migration can touch.
import { all } from "../backfill/record.mjs";
import crypto from "node:crypto";
import fs from "node:fs";
const mode=process.argv[2]||"before";
const Q=await all("questions","id,topic");
const imIds=new Set(Q.filter(q=>q.topic==="The Immune System").map(q=>q.id));
const QC=await all("question_concepts","question_id,concept_id,role,mapping_status,source");
const C=await all("concepts","id,slug,canonical_name,status,deprecated_by,version");
const AL=await all("concept_aliases","concept_id,alias,alias_type,source,status");
const CS=await all("concept_sections","concept_id,section_code,is_primary");
const CD=await all("concept_disciplines","concept_id,discipline_code,role");
const CCC=await all("concept_content_categories","concept_id,content_category,is_primary");
const FC=await all("flashcard_concepts","flashcard_id,concept_id,role,mapping_status,source");
const h=x=>crypto.createHash("sha256").update(JSON.stringify(x)).digest("hex").slice(0,16);
const snap={
 mode,
 immuneMappings: QC.filter(r=>imIds.has(r.question_id))
   .map(r=>`${r.question_id}|${r.concept_id}|${r.role}|${r.mapping_status}|${r.source}`).sort(),
 questionMappingsTotal: QC.length,
 conceptStatus: C.map(c=>`${c.id}|${c.status}|${c.deprecated_by||""}|${c.version}`).sort(),
 aliases: AL.map(a=>`${a.concept_id}|${a.alias}|${a.alias_type}|${a.source}|${a.status}`).sort(),
 taxonomy: {sections:CS.length, disciplines:CD.length, categories:CCC.length},
 taxonomyDigest: h([CS.map(r=>`${r.concept_id}|${r.section_code}|${r.is_primary}`).sort(),
                    CD.map(r=>`${r.concept_id}|${r.discipline_code}|${r.role}`).sort(),
                    CCC.map(r=>`${r.concept_id}|${r.content_category}|${r.is_primary}`).sort()]),
 flashcardDigest: h(FC.map(r=>`${r.flashcard_id}|${r.concept_id}|${r.role}|${r.mapping_status}|${r.source}`).sort()),
 flashcardCount: FC.length,
 conceptCount: C.length,
};
fs.writeFileSync(`/tmp/imsnap_${mode}.json`,JSON.stringify(snap,null,1));
console.log(`${mode.toUpperCase()} immune snapshot`);
console.log(`  immune question mappings: ${snap.immuneMappings.length}`);
console.log(`  question mappings total:  ${snap.questionMappingsTotal}`);
console.log(`  concepts: ${snap.conceptCount} | deprecated: ${C.filter(c=>c.status==="DEPRECATED").length}`);
console.log(`  aliases: ${snap.aliases.length}`);
console.log(`  taxonomy: ${JSON.stringify(snap.taxonomy)} digest ${snap.taxonomyDigest}`);
console.log(`  flashcard mappings: ${snap.flashcardCount} digest ${snap.flashcardDigest}`);
