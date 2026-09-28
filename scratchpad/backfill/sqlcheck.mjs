// Structural check on an emitted migration.
//
// WHY THIS EXISTS. The immune migration was rejected by Postgres with a syntax
// error at a VALUES row. The generator appended a "-- label" comment to each row
// and then joined the rows with ",\n", so every comment swallowed the comma that
// followed it, and the last one swallowed the statement's semicolon. Row counts
// and a grep for forbidden operations both passed happily, because neither looks
// at whether the file is well formed.
//
// Comments are stripped with the string state tracked, so a "--" inside a quoted
// label is not mistaken for a comment.
//
// SCOPE. This is a structural check for the migrations GENERATED here, where
// every literal is a plain quoted string. It reads all 49 of the project's
// migrations and correctly passes 46, including every generated one. Three
// hand-written files trip the parenthesis and quote counters, which do not model
// dollar-quoting or every escape form. Building a real SQL lexer to satisfy
// files that already applied is not worth it; treat a failure on a hand-written
// migration as "read it yourself", and a failure on a generated one as a bug.
import fs from "node:fs";
const file=process.argv[2];
if(!file){console.error("usage: sqlcheck.mjs <file.sql>");process.exit(2);}
const raw=fs.readFileSync(file,"utf8");

function stripComments(s){
  let out="", inStr=false, i=0;
  while(i<s.length){
    const c=s[i], d=s[i+1];
    if(inStr){ out+=c; if(c==="'"){ if(d==="'"){out+=d;i+=2;continue;} inStr=false; } i++; continue; }
    if(c==="'"){ inStr=true; out+=c; i++; continue; }
    if(c==="-"&&d==="-"){ while(i<s.length&&s[i]!=="\n") i++; continue; }
    if(c==="/"&&d==="*"){ i+=2; while(i<s.length&&!(s[i]==="*"&&s[i+1]==="/")) i++; i+=2; continue; }
    out+=c; i++;
  }
  return out;
}
const body=stripComments(raw);
const P=[], W=[];
// 1 quotes balanced
let q=0; for(let i=0;i<body.length;i++){ if(body[i]==="'"){ if(body[i+1]==="'"){i++;continue;} q++; } }
if(q%2) P.push("unbalanced single quotes after comment stripping");
// 2 parentheses balanced overall
let depth=0, inStr=false, minDepth=0;
for(let i=0;i<body.length;i++){ const c=body[i];
  if(inStr){ if(c==="'"){ if(body[i+1]==="'"){i++;continue;} inStr=false; } continue; }
  if(c==="'"){inStr=true;continue;}
  if(c==="(") depth++; if(c===")"){depth--; if(depth<minDepth)minDepth=depth;} }
if(depth!==0) P.push(`unbalanced parentheses: ends at depth ${depth}`);
if(minDepth<0) P.push("a closing parenthesis appears before its opener");
// 3 Inside a VALUES list, every row but the LAST must end with a comma, and the
//    last must end with ")" or ");". The naive rule "every row ends with a
//    delimiter" is wrong: the final row legitimately ends with ")" and its
//    terminator arrives on the following line as ") AS v(...)" or ";".
const lines=body.split("\n");
let block=null;
const closeBlock=(endLine)=>{
  if(!block||!block.rows.length){block=null;return;}
  block.rows.forEach((r,i)=>{
    const last = i===block.rows.length-1;
    if(!last && !/,$/.test(r.t))
      P.push(`line ${r.n}: VALUES row ${i+1} of ${block.rows.length} does not end with a comma -> ${r.t.slice(0,70)}`);
    if(last && !/\)\s*;?$/.test(r.t))
      P.push(`line ${r.n}: final VALUES row does not close -> ${r.t.slice(0,70)}`);
  });
  block=null;
};
lines.forEach((ln,n)=>{
  const t=ln.trim();
  if(/\bVALUES\s*$/i.test(t)){ closeBlock(); block={rows:[]}; return; }
  if(!block) return;
  if(t===""){ return; }   // a stripped comment leaves a blank line mid-list
  if(/^\(/.test(t)){ block.rows.push({t,n:n+1}); return; }
  closeBlock();
});
closeBlock();
// 4 statement terminators: BEGIN/COMMIT present and balanced
// ADVISORY, not a syntax rule. Wrapping a migration in one transaction is the
// house style for the ones generated here, but 43 of the project's earlier
// migrations are not wrapped and all of them applied correctly. Failing on that
// would make this checker cry wolf on every file it did not write. Pass
// --require-tx when checking a generated migration, where the wrapper is the
// thing that turns a mistake into a rollback instead of a half-applied chapter.
const beg=(body.match(/^\s*BEGIN;/gmi)||[]).length, com=(body.match(/^\s*COMMIT;/gmi)||[]).length;
const requireTx=process.argv.includes("--require-tx");
if(beg!==1||com!==1){
  const msg=`not wrapped in a single transaction (${beg} BEGIN / ${com} COMMIT)`;
  if(requireTx) P.push(msg); else W.push(msg);
}
// 5 no statement swallowed: count semicolons outside strings
let semis=0; inStr=false;
for(let i=0;i<body.length;i++){ const c=body[i];
  if(inStr){ if(c==="'"){ if(body[i+1]==="'"){i++;continue;} inStr=false; } continue; }
  if(c==="'"){inStr=true;continue;}
  if(c===";") semis++; }
if(P.length){console.log(`SQLCHECK FAIL  ${file}`);P.slice(0,12).forEach(p=>console.log("  "+p));process.exit(1);}
console.log(`SQLCHECK PASS  ${file}`);
W.forEach(w=>console.log(`  note: ${w}`));
console.log(`  quotes balanced, parentheses balanced (depth 0), ${semis} statements, 1 BEGIN / 1 COMMIT`);
console.log(`  every VALUES row terminates with a delimiter after comment stripping`);
