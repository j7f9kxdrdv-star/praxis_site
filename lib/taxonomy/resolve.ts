// ─── The one place taxonomy questions get answered ─────────────────────────
//
// Before this file, any code that wanted to know "what is this question about,
// and does it line up with that deck" had to know that decks.section is really
// a discipline, that the chapter join is questions.topic against
// decks.subtopic, and that neither fact is written down near the data. Three
// places already implement pieces of that independently.
//
// Everything below returns RESOLVED facts. Callers never re-derive levels.
//
// NO FALSE PRECISION. Until the canonical vocabulary exists, every item is
// UNMAPPED at concept level, and that is reported plainly. Nothing here infers
// a concept from similar text at runtime, and nothing falls back to a fuzzy
// match when an exact one is missing. "We cannot compare memory with
// application here" is a useful answer. A wrong concept is not.

import type { SupabaseClient } from "@supabase/supabase-js";
import {
  resolveLegacyValue,
  sectionForDiscipline,
  type DisciplineCode,
  type McatSection,
} from "./levels";

export type ConceptStatus = "MAPPED" | "UNMAPPED";

export interface ConceptRef {
  conceptId: string;
  slug: string;
  canonicalName: string;
  role: "PRIMARY" | "SECONDARY";
  mappingStatus: "AI_PROPOSED" | "HUMAN_VALIDATED" | "NEEDS_REVIEW";
  source: "LEGACY_EXACT" | "DETERMINISTIC" | "AI_PROPOSED" | "HUMAN_REVIEWED";
  confidence: number | null;
}

/**
 * Legacy values are returned ALONGSIDE canonical ones, never instead of them.
 * Existing screens read these strings and must keep working unchanged.
 */
export interface LegacyClassification {
  section: string | null;
  topic: string | null;
  subtopic: string | null;
  discipline?: string | null;
}

export interface CanonicalClassification {
  mcatSection: McatSection | null;
  discipline: DisciplineCode | null;
  /** True when the item sits on the reasoning axis rather than in content. */
  isCrossCutting: boolean;
  aamcFoundation?: string | null;
  contentCategory?: string | null;
  /** AAMC Scientific Inquiry and Reasoning Skill, 1 to 4. Questions only. */
  reasoningSkill?: number | null;
  concepts: ConceptRef[];
  conceptStatus: ConceptStatus;
}

export interface Classification {
  legacy: LegacyClassification;
  canonical: CanonicalClassification;
}

const CONCEPT_SELECT =
  "concept_id, role, mapping_status, source, confidence, concepts ( id, slug, canonical_name )";

/** Shape the join rows into ConceptRefs, dropping any whose concept vanished. */
function toConceptRefs(rows: unknown[] | null): ConceptRef[] {
  if (!rows) return [];
  const out: ConceptRef[] = [];
  for (const raw of rows) {
    const r = raw as {
      concept_id: string;
      role: ConceptRef["role"];
      mapping_status: ConceptRef["mappingStatus"];
      source: ConceptRef["source"];
      confidence: number | null;
      concepts: { id: string; slug: string; canonical_name: string } | null;
    };
    if (!r.concepts) continue;
    out.push({
      conceptId: r.concept_id,
      slug: r.concepts.slug,
      canonicalName: r.concepts.canonical_name,
      role: r.role,
      mappingStatus: r.mapping_status,
      source: r.source,
      confidence: r.confidence,
    });
  }
  // PRIMARY first, so a caller taking [0] gets the concept the item is about.
  return out.sort((a, b) => (a.role === b.role ? 0 : a.role === "PRIMARY" ? -1 : 1));
}

export async function resolveQuestionClassification(
  db: SupabaseClient,
  questionId: string,
): Promise<Classification | null> {
  const { data: q, error } = await db
    .from("questions")
    .select("id, section, discipline, topic, subtopic, foundation, content_category, cognitive_skill")
    .eq("id", questionId)
    .maybeSingle();
  if (error || !q) return null;

  const bySection = resolveLegacyValue("questions", "section", q.section);
  const byDiscipline = resolveLegacyValue("questions", "discipline", q.discipline);

  const { data: mapped } = await db
    .from("question_concepts")
    .select(CONCEPT_SELECT)
    .eq("question_id", questionId);
  const concepts = toConceptRefs(mapped);

  return {
    legacy: {
      section: q.section ?? null,
      topic: q.topic ?? null,
      subtopic: q.subtopic ?? null,
      discipline: q.discipline ?? null,
    },
    canonical: {
      // questions.section is already authoritative; discipline only fills a gap.
      mcatSection: bySection.section ?? sectionForDiscipline(byDiscipline.discipline),
      discipline: byDiscipline.discipline,
      isCrossCutting: byDiscipline.isCrossCutting,
      aamcFoundation: q.foundation ?? null,
      contentCategory: q.content_category ?? null,
      reasoningSkill: q.cognitive_skill ?? null,
      concepts,
      conceptStatus: concepts.length ? "MAPPED" : "UNMAPPED",
    },
  };
}

export async function resolveFlashcardClassification(
  db: SupabaseClient,
  flashcardId: string,
): Promise<Classification | null> {
  const { data: card, error } = await db
    .from("flashcards")
    .select("id, deck_id, flashcard_decks ( section, topic, subtopic )")
    .eq("id", flashcardId)
    .maybeSingle();
  if (error || !card) return null;

  // PostgREST returns an embedded relation as an array under some client
  // versions and as an object under others. Normalise rather than trust either.
  type DeckRow = { section: string | null; topic: string | null; subtopic: string | null };
  const embedded = (card as unknown as { flashcard_decks: DeckRow | DeckRow[] | null }).flashcard_decks;
  const deck: DeckRow | null = Array.isArray(embedded) ? embedded[0] ?? null : embedded;

  // The deck's `section` is the mixed-level column; read it at its true level.
  const meaning = resolveLegacyValue("flashcard_decks", "section", deck?.section);

  const { data: mapped } = await db
    .from("flashcard_concepts")
    .select(CONCEPT_SELECT)
    .eq("flashcard_id", flashcardId);
  const concepts = toConceptRefs(mapped);

  return {
    legacy: {
      section: deck?.section ?? null,
      topic: deck?.topic ?? null,
      subtopic: deck?.subtopic ?? null,
    },
    canonical: {
      mcatSection: meaning.section ?? sectionForDiscipline(meaning.discipline),
      discipline: meaning.discipline,
      isCrossCutting: meaning.isCrossCutting,
      concepts,
      conceptStatus: concepts.length ? "MAPPED" : "UNMAPPED",
    },
  };
}

/**
 * Can memory and application be compared for this concept yet?
 *
 * Exists so callers stop inferring comparability from an empty array. An empty
 * result has two very different causes and they must not be collapsed: nothing
 * is mapped yet (temporary, fixed by the vocabulary phase), or the content
 * genuinely exists on only one side (permanent until the bank grows, and the
 * honest answer is that no comparison is possible).
 */
export function comparability(
  questionConcepts: ConceptRef[],
  flashcardConcepts: ConceptRef[],
): { comparable: boolean; reason: "OK" | "QUESTIONS_UNMAPPED" | "FLASHCARDS_UNMAPPED" | "NO_SHARED_CONCEPT" } {
  if (!questionConcepts.length) return { comparable: false, reason: "QUESTIONS_UNMAPPED" };
  if (!flashcardConcepts.length) return { comparable: false, reason: "FLASHCARDS_UNMAPPED" };
  const shared = new Set(flashcardConcepts.map((c) => c.conceptId));
  return questionConcepts.some((c) => shared.has(c.conceptId))
    ? { comparable: true, reason: "OK" }
    : { comparable: false, reason: "NO_SHARED_CONCEPT" };
}
