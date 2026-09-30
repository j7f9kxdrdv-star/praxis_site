import { all } from "../backfill/record.mjs";
const CCC=await all("concept_content_categories","concept_id,content_category,is_primary");
const C=await all("concepts","id,canonical_name,status,object_type");
const Q=await all("questions","id,content_category,section,discipline");
const n={}; CCC.forEach(r=>n[r.content_category]=(n[r.content_category]||0)+1);
const qn={}; Q.forEach(q=>qn[q.content_category]=(qn[q.content_category]||0)+1);
const keys=[...new Set([...Object.keys(n),...Object.keys(qn)])].sort();
console.log("category".padEnd(52)+"concepts  questions");
keys.forEach(k=>console.log(String(k).padEnd(52)+String(n[k]||0).padStart(6)+String(qn[k]||0).padStart(11)));
console.log("\n--- concepts on 'Separation and Purification Methods (BC)' ---");
CCC.filter(r=>r.content_category==="Separation and Purification Methods (BC)").forEach(r=>{
  const c=C.find(x=>x.id===r.concept_id); console.log("   "+c.canonical_name+"  ["+c.object_type+"/"+c.status+"] primary="+r.is_primary);});
console.log("\n--- concepts on 'Separations and Purifications' ---");
CCC.filter(r=>r.content_category==="Separations and Purifications").forEach(r=>{
  const c=C.find(x=>x.id===r.concept_id); console.log("   "+c.canonical_name+"  primary="+r.is_primary);});
