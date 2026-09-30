import { all } from "../backfill/record.mjs";
const A=await all("concept_aliases","alias,alias_type,source,status");
const t={}; A.forEach(r=>t[`${r.alias_type} / ${r.source} / ${r.status}`]=(t[`${r.alias_type} / ${r.source} / ${r.status}`]||0)+1);
console.log(JSON.stringify(t,null,1));
console.log("total aliases: "+A.length);
console.log("\nsample: "+A.slice(0,3).map(r=>r.alias).join(" | "));
