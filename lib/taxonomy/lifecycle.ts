// ─── What may happen to a concept, and what must happen to its evidence ────
//
// A concept ID is a promise. Learner evidence accumulates against it for
// months, so the ID must outlive every change to the concept's wording, and
// must never be reused for something else. These functions encode the four
// approved lifecycle events as decisions rather than as prose, so the rules can
// be tested and so the eventual admin tooling has one place to obey.
//
// The database enforces the structural half (hierarchy depth, deprecated
// concepts refusing new mappings, human-validated mappings refusing to be
// overwritten). This module covers the half a trigger cannot see: what should
// happen to EXISTING mappings when a concept changes shape.

export type ConceptStatus =
  | "DRAFT"
  | "ACTIVE_SEED"
  | "APPROVED"
  | "HUMAN_VALIDATED"
  | "NEEDS_REVIEW"
  | "DEPRECATED";

export type MappingStatus = "AI_PROPOSED" | "DETERMINISTIC" | "HUMAN_VALIDATED" | "NEEDS_REVIEW";

export interface ConceptRecord {
  id: string;
  slug: string;
  canonicalName: string;
  status: ConceptStatus;
  version: number;
  deprecatedBy?: string | null;
}

export interface ExistingMapping {
  itemId: string;
  conceptId: string;
  mappingStatus: MappingStatus;
}

/** A change to apply, expressed so a caller cannot misread the intent. */
export type LifecycleAction =
  | { kind: "UPDATE_CONCEPT"; id: string; fields: Partial<ConceptRecord> }
  | { kind: "ADD_ALIAS"; conceptId: string; alias: string }
  | { kind: "REPOINT_MAPPING"; itemId: string; from: string; to: string }
  | { kind: "FLAG_MAPPING"; itemId: string; conceptId: string; status: MappingStatus; reason: string }
  | { kind: "CREATE_CONCEPT"; slug: string; canonicalName: string };

/**
 * RENAME. The ID survives; the old name becomes an alias.
 *
 * Renaming is the cheapest lifecycle event and must stay that way, because the
 * alternative is that people avoid fixing a bad name. Nothing happens to
 * mappings: the concept means what it always meant.
 */
export function renameConcept(c: ConceptRecord, newName: string): LifecycleAction[] {
  if (newName.trim() === c.canonicalName) return [];
  return [
    { kind: "ADD_ALIAS", conceptId: c.id, alias: c.canonicalName },
    { kind: "UPDATE_CONCEPT", id: c.id, fields: { canonicalName: newName.trim(), version: c.version + 1 } },
  ];
}

/**
 * MERGE. The loser is deprecated and points at the winner; its mappings move.
 *
 * Mappings are REPOINTED rather than deleted, because the learner's history is
 * about the idea, not about which of two names we happened to file it under.
 * A human-validated mapping moves too: a human validated that this question
 * tests this idea, and merging does not undo that judgement, it only renames
 * where the idea lives.
 */
export function mergeConcepts(
  loser: ConceptRecord,
  winner: ConceptRecord,
  mappings: ExistingMapping[],
): LifecycleAction[] {
  if (loser.id === winner.id) throw new Error("Cannot merge a concept into itself.");
  if (winner.status === "DEPRECATED") throw new Error("Cannot merge into a deprecated concept.");

  const out: LifecycleAction[] = mappings
    .filter((m) => m.conceptId === loser.id)
    .map((m) => ({ kind: "REPOINT_MAPPING", itemId: m.itemId, from: loser.id, to: winner.id }) as const);

  out.push({ kind: "ADD_ALIAS", conceptId: winner.id, alias: loser.canonicalName });
  out.push({
    kind: "UPDATE_CONCEPT",
    id: loser.id,
    fields: { status: "DEPRECATED", deprecatedBy: winner.id, version: loser.version + 1 },
  });
  return out;
}

/**
 * SPLIT. The original is deprecated, children are created, and every existing
 * mapping is flagged for review rather than guessed.
 *
 * THIS IS THE ONE THAT MUST NOT BE CLEVER. A split happens precisely because
 * the old concept conflated two ideas, which means the old mapping cannot say
 * which child it belonged to. Sending them all to the first child, or guessing
 * by question text, would manufacture evidence the learner never generated.
 * NEEDS_REVIEW is the honest outcome, even though it creates work.
 *
 * The parent is deprecated WITHOUT a deprecated_by, because there is no single
 * successor; that is the difference between a split and a merge.
 */
export function splitConcept(
  original: ConceptRecord,
  children: { slug: string; canonicalName: string }[],
  mappings: ExistingMapping[],
): LifecycleAction[] {
  if (children.length < 2) throw new Error("A split needs at least two children.");

  const out: LifecycleAction[] = children.map(
    (ch) => ({ kind: "CREATE_CONCEPT", slug: ch.slug, canonicalName: ch.canonicalName }) as const,
  );

  for (const m of mappings.filter((m) => m.conceptId === original.id)) {
    out.push({
      kind: "FLAG_MAPPING",
      itemId: m.itemId,
      conceptId: original.id,
      status: "NEEDS_REVIEW",
      reason: `${original.canonicalName} was split into ${children.length} concepts; which one applies cannot be derived from the old mapping.`,
    });
  }

  out.push({
    kind: "UPDATE_CONCEPT",
    id: original.id,
    fields: { status: "DEPRECATED", deprecatedBy: null, version: original.version + 1 },
  });
  return out;
}

/**
 * DEPRECATE. Blocks new mappings; existing evidence is left alone.
 *
 * Deleting a concept would make past learner data uninterpretable: an attempt
 * recorded against a concept that no longer exists cannot be explained to the
 * student or to us.
 */
export function deprecateConcept(c: ConceptRecord, successorId?: string): LifecycleAction[] {
  return [
    {
      kind: "UPDATE_CONCEPT",
      id: c.id,
      fields: { status: "DEPRECATED", deprecatedBy: successorId ?? null, version: c.version + 1 },
    },
  ];
}

/**
 * May this mapping be written by an automated pass?
 *
 * The database trigger enforces the same rule for UPDATE and DELETE. This is
 * the read-side check, so tooling can decline before attempting a write and
 * explain itself.
 */
export function mayAutomationWrite(existing: ExistingMapping | null): { allowed: boolean; reason: string } {
  if (!existing) return { allowed: true, reason: "No existing mapping." };
  if (existing.mappingStatus === "HUMAN_VALIDATED") {
    return {
      allowed: false,
      reason: "Human-validated. Record disagreement as a new NEEDS_REVIEW candidate rather than overwriting.",
    };
  }
  return { allowed: true, reason: `Existing mapping is ${existing.mappingStatus}.` };
}

/**
 * Bank coverage, derived rather than stored.
 *
 * This replaces the concepts.evidence_floor column that was proposed and then
 * withdrawn. Evidence sufficiency belongs to a learner's observations, not to a
 * concept's identity: a concept with one question today may have twenty next
 * month, and a threshold written into the row would freeze that accident as if
 * it were pedagogy. Counting at read time is always current and costs nothing.
 */
export function bankCoverage(questionCount: number): {
  level: "NONE" | "SPARSE" | "ADEQUATE";
  safeForInference: boolean;
} {
  if (questionCount === 0) return { level: "NONE", safeForInference: false };
  if (questionCount < 3) return { level: "SPARSE", safeForInference: false };
  return { level: "ADEQUATE", safeForInference: true };
}
