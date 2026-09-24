/*
 * Propose canonical concepts for questions the deterministic pass could not map.
 *
 *   npx vite-node scripts/taxonomy/propose-question-concepts.mts            # all eligible
 *   npx vite-node scripts/taxonomy/propose-question-concepts.mts --topic "The Periodic Table"
 *   npx vite-node scripts/taxonomy/propose-question-concepts.mts --limit 5  # smoke test
 *
 * THIS SCRIPT NEVER WRITES TO THE DATABASE. It emits a proposal file for human
 * review. Writing is a separate, deliberate step, and no proposal from here may
 * be inserted as anything other than AI_PROPOSED.
 *
 * WHAT IT WILL AND WILL NOT ATTEMPT. Of the 439 unmapped questions, only those
 * whose chapter already HAS canonical concepts are eligible. 417 of them sit in
 * seven chapters with no concepts at all, and no amount of semantic matching
 * can place a question into a vocabulary that does not cover its subject. Those
 * are a vocabulary decision, not a mapping one, and the script refuses them by
 * design rather than forcing a neighbouring concept.
 *
 * CANDIDATES ARE NARROWED DETERMINISTICALLY FIRST. The model only ever chooses
 * among concepts that already share the question's MCAT section, AAMC content
 * category, discipline and chapter. An incompatible-section mapping is
 * therefore unreachable, not merely discouraged.
 */
import Anthropic from "@anthropic-ai/sdk";
import { createClient } from "@supabase/supabase-js";
import fs from "node:fs";
// Model ids live in lib/ai/models.ts and nowhere else. models.test.ts fails the
// build if a second place names one, which is how three call sites once drifted
// a generation apart without anyone being able to see it. This script is a .mts
// run through vite-node so it can import that constant rather than repeat it.
import { REASONING_MODEL } from "../../lib/ai/models";
// The deterministic narrowing lives in lib/ so it can be unit tested; the
// script must not carry a second copy that can disagree with the tested one.
import { candidatesFor, eligibility, type ConceptFacts } from "../../lib/taxonomy/candidates";

const args = process.argv.slice(2);
const arg = (n: string): string | null => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const onlyTopic = arg("--topic");
const limit = arg("--limit") ? Number(arg("--limit")) : null;
const OUT = arg("--out") || "scratchpad/question-concept-proposals.json";

const env = fs.readFileSync(".env.local", "utf8");
const g = (k: string): string => (env.match(new RegExp("^" + k + "=(.*)$", "m")) || [])[1]?.trim();
const db = createClient(g("NEXT_PUBLIC_SUPABASE_URL"), g("SUPABASE_SERVICE_ROLE_KEY"));
const ai = new Anthropic({ apiKey: g("ANTHROPIC_API_KEY") });

const MODEL = REASONING_MODEL;

async function all<T = any>(t: string, c: string): Promise<T[]> {
  let out: T[] = [], from = 0;
  for (;;) {
    const { data, error } = await db.from(t).select(c).range(from, from + 999);
    if (error) throw new Error(t + ": " + error.message);
    out = out.concat((data ?? []) as T[]);
    if (!data || data.length < 1000) break;
    from += 1000;
  }
  return out;
}

const SEC = { chem_phys: "CHEM_PHYS", bio_biochem: "BIO_BIOCHEM", psych_soc: "PSYCH_SOC", cars: "CARS" };
const DISC = {
  "general-chemistry": "GENERAL_CHEMISTRY", "organic-chemistry": "ORGANIC_CHEMISTRY",
  physics: "PHYSICS", biology: "BIOLOGY", biochemistry: "BIOCHEMISTRY",
  psychology: "PSYCHOLOGY", sociology: "SOCIOLOGY",
};

console.log("Loading…");
const Q = await all("questions", "id,question_text,options,correct_answer,explanation,subtopic,topic,content_category,discipline,section,foundation,cognitive_skill,difficulty");
const C = await all("concepts", "id,slug,canonical_name,status,split_candidate");
const CS = await all("concept_sections", "concept_id,section_code");
const CC = await all("concept_content_categories", "concept_id,content_category");
const CD = await all("concept_disciplines", "concept_id,discipline_code");
const QC = await all("question_concepts", "question_id,concept_id,mapping_status");

const secOf: Record<string, Set<string>> = {}, catOf: Record<string, Set<string>> = {}, discOf: Record<string, Set<string>> = {};
CS.forEach((r: any) => (secOf[r.concept_id] ??= new Set()).add(r.section_code));
CC.forEach((r: any) => (catOf[r.concept_id] ??= new Set()).add(r.content_category));
CD.forEach((r: any) => (discOf[r.concept_id] ??= new Set()).add(r.discipline_code));

// Which chapter does each concept belong to? Inherited from the questions that
// already carry it, which is the only evidence that exists.
const nameToConcept = new Map<string, any>(C.map((c: any) => [c.canonical_name, c]));
const topicsOf: Record<string, Set<string>> = {};
for (const q of Q) {
  const c = nameToConcept.get(q.subtopic);
  if (c) (topicsOf[c.id] ??= new Set()).add(q.topic);
}

const mapped = new Set(QC.map((m: any) => m.question_id));
let unmapped: any[] = Q.filter((q: any) => !mapped.has(q.id));
if (onlyTopic) unmapped = unmapped.filter((q: any) => q.topic === onlyTopic);

const facts: ConceptFacts[] = C.map((c: any) => ({
  id: c.id, canonicalName: c.canonical_name, status: c.status,
  sections: secOf[c.id] ?? new Set(), contentCategories: catOf[c.id] ?? new Set(),
  disciplines: discOf[c.id] ?? new Set(), topics: topicsOf[c.id] ?? new Set(),
}));
const qFacts = (q: any) => ({ section: q.section, contentCategory: q.content_category,
  discipline: q.discipline, topic: q.topic });

const eligible: { q: any; cands: ConceptFacts[] }[] = [];
const ineligible: { q: any; cands: ConceptFacts[]; reason: string }[] = [];
for (const q of unmapped) {
  const e = eligibility(qFacts(q), facts);
  if (e.eligible) eligible.push({ q, cands: e.candidates });
  else ineligible.push({ q, cands: [], reason: e.reason });
}

console.log(`\n${unmapped.length} unmapped question(s) considered.`);
console.log(`  ${eligible.length} eligible (their chapter has concepts)`);
console.log(`  ${ineligible.length} NOT eligible — no concept exists in their chapter.`);
if (ineligible.length) {
  const byTopic: Record<string, number> = {};
  ineligible.forEach((r) => (byTopic[r.q.topic] = (byTopic[r.q.topic] || 0) + 1));
  console.log("    These are a VOCABULARY GAP, not a mapping failure:");
  Object.entries(byTopic).sort((a, b) => b[1] - a[1])
    .forEach(([t, n]) => console.log(`      ${String(n).padStart(3)}  ${t}`));
}

const work = limit ? eligible.slice(0, limit) : eligible;
if (!work.length) { console.log("\nNothing to propose."); process.exit(0); }

const strip = (s: unknown): string => String(s || "").replace(/\s+/g, " ").trim();
const choicesOf = (o: unknown) => (Array.isArray(o) ? o : []).map((c: any) => `${c.label}. ${strip(c.text)}`).join("\n");

function prompt(q: any, cands: ConceptFacts[]) {
  return `You are mapping an MCAT question to ONE concept from a fixed, approved list.

RULES
- Choose only from the numbered list. Never invent a concept.
- Choose the concept a student must KNOW to answer, not every concept mentioned.
- A narrow scenario maps to the broader concept it tests. That is expected and correct.
- Add a SECONDARY concept only if a second concept is genuinely REQUIRED to solve it.
- If nothing on the list fits the tested objective, answer NO_GOOD_MATCH. That is a
  respectable answer and is preferred over a forced fit.

CONFIDENCE
- HIGH: the question, its explanation and the concept plainly agree.
- MEDIUM: plausible, but another listed concept could reasonably fit.
- LOW: substantial ambiguity.

QUESTION
${strip(q.question_text)}

CHOICES
${choicesOf(q.options)}

CORRECT ANSWER: ${q.correct_answer}

EXPLANATION
${strip(q.explanation).slice(0, 2200)}

EXISTING CLASSIFICATION
chapter: ${q.topic} | AAMC category: ${q.content_category} | discipline: ${q.discipline} | AAMC skill: ${q.cognitive_skill} | difficulty: ${q.difficulty}
author's per-question label: ${q.subtopic}

APPROVED CONCEPTS TO CHOOSE FROM
${cands.map((c, i) => `${i + 1}. ${c.canonicalName}`).join("\n")}

Reply with JSON only:
{"primary": <number or "NO_GOOD_MATCH">, "secondary": <number or null>,
 "confidence": "HIGH"|"MEDIUM"|"LOW", "reasoning": "<one or two sentences>",
 "evidence_used": ["question_text"|"explanation"|"classification"|"choices"],
 "alternatives": [<numbers>]}`;
}

const results: any[] = [];
let done = 0, errors = 0;
for (const { q, cands } of work) {
  try {
    const r = await ai.messages.create({
      model: MODEL, max_tokens: 700,
      messages: [{ role: "user", content: prompt(q, cands) }],
    });
    const text = r.content.filter((b: any) => b.type === "text").map((b: any) => b.text).join("");
    const json = JSON.parse(text.slice(text.indexOf("{"), text.lastIndexOf("}") + 1));
    const pick = (n: unknown): ConceptFacts | null => (typeof n === "number" && cands[n - 1] ? cands[n - 1] : null);
    const primary = json.primary === "NO_GOOD_MATCH" ? null : pick(json.primary);
    const secondary = pick(json.secondary);

    results.push({
      question_id: q.id,
      legacy_descriptor: q.subtopic,
      stem: strip(q.question_text).slice(0, 220),
      topic: q.topic, content_category: q.content_category,
      discipline: q.discipline, section: q.section,
      primary_concept: primary ? { id: primary.id, name: primary.canonicalName } : "NO_GOOD_MATCH",
      secondary_concept: secondary && secondary.id !== primary?.id
        ? { id: secondary.id, name: secondary.canonicalName } : null,
      confidence: primary ? json.confidence : "LOW",
      reasoning: strip(json.reasoning),
      evidence_used: json.evidence_used ?? [],
      alternatives: (json.alternatives ?? []).map(pick).filter(Boolean as any).map((c: ConceptFacts) => c.canonicalName),
      candidate_pool: cands.length,
      review_status: primary && json.confidence === "HIGH" ? "AI_PROPOSED" : "NEEDS_REVIEW",
    });
  } catch (e: any) {
    errors++;
    results.push({ question_id: q.id, legacy_descriptor: q.subtopic, error: e.message?.slice(0, 200), review_status: "NEEDS_REVIEW" });
    // A run that silently tolerates failure produces a proposal file nobody can
    // trust. Three in a row means something is wrong with the setup, not the data.
    if (errors >= 3 && errors === done + 1) {
      console.error("\nAborting: three consecutive failures. Last:", e.message?.slice(0, 160));
      break;
    }
  }
  done++;
  if (done % 10 === 0 || done === work.length) process.stdout.write(`\r  proposed ${done}/${work.length}`);
}

fs.mkdirSync(OUT.replace(/\/[^/]+$/, ""), { recursive: true });
fs.writeFileSync(OUT, JSON.stringify({
  generated_at: new Date().toISOString(),
  model: MODEL,
  note: "AI proposals for human review. Nothing here has been written to the database.",
  eligible: eligible.length,
  ineligible_vocabulary_gap: ineligible.length,
  proposals: results,
}, null, 1));

const by = (f: (r: any) => boolean) => results.filter(f).length;
console.log(`\n\nHIGH ${by(r => r.confidence === "HIGH")}  MEDIUM ${by(r => r.confidence === "MEDIUM")}  LOW ${by(r => r.confidence === "LOW")}`);
console.log(`NO_GOOD_MATCH ${by(r => r.primary_concept === "NO_GOOD_MATCH")}   errors ${errors}`);
console.log(`\nProposals written to ${OUT}. NOTHING was written to the database.`);
