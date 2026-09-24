// ─── Three kinds of learning object, and the line between them ─────────────
//
// A flashcard resolves to exactly one learning target, and there are three
// legitimate kinds. They live in one table because they share every structural
// property, but they must never be counted together.
//
// THE FAILURE THIS GUARDS AGAINST is quiet and plausible: a content-coverage
// query selects from `concepts`, forgets a filter, and starts reporting that a
// student is weak at "confounding" as though it were biology. Nothing would
// error. The number would simply be wrong, and wrong in a direction that reads
// as a real finding.
//
// So the boundary is enforced in three places, not one: a database trigger
// stops a cross-cutting object acquiring content taxonomy, a view per type
// makes the filter explicit, and the types here make the omission a compile
// error rather than a silent miscount.

export type ObjectType = "CONTENT" | "REASONING" | "QUANTITATIVE";

export interface LearningObject {
  id: string;
  slug: string;
  canonicalName: string;
  objectType: ObjectType;
  status: string;
}

/** A learning object known at the type level to be disciplinary content. */
export type ContentConcept = LearningObject & { objectType: "CONTENT" };

/**
 * Narrow to content, discarding the rest.
 *
 * Every feature that measures DISCIPLINARY content goes through here: memory
 * versus application, content coverage, content weakness, mastery, and
 * section or topic analytics. Taking the whole table instead is the bug.
 */
export function contentOnly<T extends { objectType: ObjectType }>(
  objects: T[],
): (T & { objectType: "CONTENT" })[] {
  return objects.filter((o): o is T & { objectType: "CONTENT" } => o.objectType === "CONTENT");
}

export function reasoningOnly<T extends { objectType: ObjectType }>(objects: T[]): T[] {
  return objects.filter((o) => o.objectType === "REASONING");
}

export function quantitativeOnly<T extends { objectType: ObjectType }>(objects: T[]): T[] {
  return objects.filter((o) => o.objectType === "QUANTITATIVE");
}

/**
 * May this object carry a section, discipline or AAMC category?
 *
 * Only content may. "Confounding" has no MCAT section and no discipline, and
 * inventing one to make the schema look complete would plant a claim that later
 * analytics would read as a fact. The database enforces the same rule; this is
 * the read-side check so tooling can decline before attempting the write and
 * say why.
 */
export function mayCarryContentTaxonomy(objectType: ObjectType): { allowed: boolean; reason: string } {
  return objectType === "CONTENT"
    ? { allowed: true, reason: "Disciplinary content is classified by section, discipline and AAMC category." }
    : {
        allowed: false,
        reason: `${objectType} objects are cross-cutting. Zero taxonomy rows is the correct state, not an incomplete one.`,
      };
}

/**
 * Guard for anything about to be counted as content evidence.
 *
 * Throws rather than filtering, because a caller that hands non-content to a
 * content metric has a bug in its query, and silently dropping the rows would
 * hide it while producing a plausible-looking number.
 */
export function assertAllContent(objects: { slug: string; objectType: ObjectType }[]): void {
  const strays = objects.filter((o) => o.objectType !== "CONTENT");
  if (strays.length) {
    throw new Error(
      `Content analytics received ${strays.length} non-content object(s): ` +
        strays.slice(0, 3).map((s) => `${s.slug} (${s.objectType})`).join(", ") +
        ". Read the content_concepts view rather than the concepts table.",
    );
  }
}
