// ─── Loading the evidence the concept model reads ───────────────────────────
//
// THIS MODULE DECIDES NOTHING. It fetches rows and shapes them into the
// ConceptEvidence the pure function takes, and every judgement about what
// counts stays where it already lived:
//
//   which concepts are learner-facing   buildConceptStates, via LEARNER_FACING_STATUSES
//   which attempts are first attempts   buildConceptStates, via isEligibleAttempt
//   which scheduler rows are eligible   buildConceptStates (reps, suspended, cloze range)
//   which clozes a mapping covers       buildConceptStates, via cloze_indices
//   which question mappings are evidence buildConceptStates, via ELIGIBLE_STRENGTHS
//
// So the queries below filter by USER and by nothing else. It is tempting to
// push `reps > 0` or `is_first_attempt IS NOT FALSE` into SQL — the rows are
// smaller and the query is faster — and it is exactly how a second, slightly
// different definition of "first attempt" comes to exist in a codebase. The
// one in the model is the one that counts, and a filter here that drifted from
// it would change a learner's state with nothing to show for it.
//
// The pagination is the project's established shape: 1,000 rows at a time with
// a stable .order(), because .range() without one can repeat or skip rows.
// flashcard_user_state has no id column, so it orders on its natural key.

import type { SupabaseClient } from "@supabase/supabase-js";
import {
  type ConceptEvidence, type CardMapping, type QuestionMapping,
  type SchedulerRow, type AttemptRow, type ConceptRow, type FlashcardRow,
  type Role, type EvidenceStrength,
  EVIDENCE_STRENGTHS,
} from "@/lib/learner/conceptState";

const PAGE = 1000;

/**
 * Every row of a table, in pages, ordered so the pages cannot overlap.
 *
 * `userId` is the ONLY filter this loader offers, deliberately: it is the one
 * restriction that is not a judgement about what counts as evidence.
 */
async function all<T>(
  db: SupabaseClient, table: string, columns: string, order: string[], userId?: string,
): Promise<T[]> {
  const out: T[] = [];
  for (let from = 0; ; from += PAGE) {
    let q = db.from(table).select(columns);
    if (userId) q = q.eq("user_id", userId);
    for (const col of order) q = q.order(col, { ascending: true });
    const { data, error } = await q.range(from, from + PAGE - 1);
    if (error) throw new Error(`conceptEvidence: loading ${table}: ${error.message}`);
    if (!data || data.length === 0) break;
    out.push(...(data as T[]));
    if (data.length < PAGE) break;
  }
  return out;
}

/**
 * A role column, checked rather than cast.
 *
 * `as Role` would compile and would let an unexpected value through into the
 * model, where it would silently stop matching "SECONDARY" and quietly change
 * a confidence cap. Both mapping tables hold only PRIMARY and SECONDARY today;
 * if that ever stops being true, this says so instead of absorbing it.
 */
function role(value: unknown, where: string): Role {
  if (value === "PRIMARY" || value === "SECONDARY") return value;
  throw new Error(`conceptEvidence: ${where} has role ${JSON.stringify(value)}, expected PRIMARY or SECONDARY`);
}

/** Likewise for evidence strength, against the model's own vocabulary. */
function strength(value: unknown, where: string): EvidenceStrength {
  if (typeof value === "string" && (EVIDENCE_STRENGTHS as readonly string[]).includes(value)) {
    return value as EvidenceStrength;
  }
  throw new Error(`conceptEvidence: ${where} has evidence_strength ${JSON.stringify(value)}, which the model has no branch for`);
}

/** What the loader read, for the operational report. */
export interface EvidenceCounts {
  concepts: number;
  flashcards: number;
  cardMappings: number;
  schedulerRows: number;
  questionMappings: number;
  attempts: number;
}

export interface LoadedEvidence {
  evidence: ConceptEvidence;
  counts: EvidenceCounts;
}

/**
 * The bank-wide half of the evidence, which is the same for every learner.
 *
 * WHY THIS EXISTS. A single learner's evidence is about 12,000 bank rows plus
 * their own few thousand. Re-reading the bank per learner is invisible at nine
 * accounts and is the whole cost at a thousand: 12 million row-reads a run,
 * every one of them identical. A batch refresh loads it once and hands it to
 * each learner's load.
 *
 * IT IS A SNAPSHOT, deliberately. Every learner in one refresh run sees the
 * same bank, so the run is one coherent observation rather than nine readings
 * of a question bank that someone might be editing underneath it.
 */
export interface ConceptBank {
  concepts: ConceptRow[];
  flashcards: FlashcardRow[];
  cardMappings: CardMapping[];
  questionMappings: QuestionMapping[];
}

/**
 * Everything buildConceptStates() needs about one learner.
 *
 * The bank-wide tables (concepts, flashcards and the two mapping tables) are
 * loaded whole and unfiltered, because the model needs them to answer how many
 * cards EXIST for a concept, not just how many this learner has seen: that
 * ratio is the breadth term in memory confidence. Filtering them to the
 * learner's own cards would quietly make every concept look fully covered.
 */
export async function loadConceptEvidence(
  db: SupabaseClient, userId: string, bank?: ConceptBank,
): Promise<LoadedEvidence> {
  if (bank) {
    const { schedulerRows, attempts } = await loadLearnerEvidence(db, userId);
    return {
      evidence: { ...bank, schedulerRows, attempts },
      counts: {
        concepts: bank.concepts.length, flashcards: bank.flashcards.length,
        cardMappings: bank.cardMappings.length, questionMappings: bank.questionMappings.length,
        schedulerRows: schedulerRows.length, attempts: attempts.length,
      },
    };
  }
  const [concepts, flashcards, cardRows, schedulerRaw, questionRows, attemptRows] = await Promise.all([
    all<{ id: string; object_type: string; status: string }>(
      db, "concepts", "id, object_type, status", ["id"]),
    all<{ id: string; cloze_count: number | null }>(
      db, "flashcards", "id, cloze_count", ["id"]),
    all<{ flashcard_id: string; concept_id: string; role: string; cloze_indices: number[] | null }>(
      db, "flashcard_concepts", "flashcard_id, concept_id, role, cloze_indices", ["flashcard_id", "concept_id"]),
    all<{ flashcard_id: string; cloze_index: number; stability: number | null; reps: number | null;
          suspended: boolean | null; last_reviewed_at: string | null }>(
      db, "flashcard_user_state",
      "flashcard_id, cloze_index, stability, reps, suspended, last_reviewed_at",
      ["flashcard_id", "cloze_index"], userId),
    all<{ question_id: string; concept_id: string; role: string; evidence_strength: string }>(
      db, "question_concepts", "question_id, concept_id, role, evidence_strength", ["question_id", "concept_id"]),
    all<{ id: string; question_id: string; is_correct: boolean; is_first_attempt: boolean | null; created_at: string }>(
      db, "question_attempts", "id, question_id, is_correct, is_first_attempt, created_at",
      ["created_at", "id"], userId),
  ]);

  const conceptRows: ConceptRow[] = concepts.map((c) => ({
    id: c.id, objectType: c.object_type, status: c.status,
  }));

  // A card with no cloze_count cannot bound its own scheduler rows, so every
  // row on it would be an orphan. None exists today (4,118 of 4,118 carry
  // one); 0 is the honest value if one ever appears, and the model then
  // excludes that card rather than guessing a range.
  const cards: FlashcardRow[] = flashcards.map((f) => ({ id: f.id, clozeCount: f.cloze_count ?? 0 }));

  const cardMappings: CardMapping[] = cardRows.map((m) => ({
    conceptId: m.concept_id,
    flashcardId: m.flashcard_id,
    role: role(m.role, `flashcard_concepts ${m.flashcard_id}/${m.concept_id}`),
    clozeIndices: m.cloze_indices,
  }));

  const schedulerRows: SchedulerRow[] = schedulerRaw.map((r) => ({
    flashcardId: r.flashcard_id,
    clozeIndex: r.cloze_index,
    // A null stability is a row that has never been scheduled. 0 is what the
    // durability curve already treats as "nothing built", so it needs no
    // special case; the model's reps filter removes these anyway.
    stability: r.stability ?? 0,
    reps: r.reps ?? 0,
    suspended: r.suspended ?? false,
    lastReviewedAt: r.last_reviewed_at,
  }));

  const questionMappings: QuestionMapping[] = questionRows.map((m) => ({
    conceptId: m.concept_id,
    questionId: m.question_id,
    role: role(m.role, `question_concepts ${m.question_id}/${m.concept_id}`),
    evidenceStrength: strength(m.evidence_strength, `question_concepts ${m.question_id}/${m.concept_id}`),
  }));

  const attempts: AttemptRow[] = attemptRows.map((a) => ({
    id: a.id,
    questionId: a.question_id,
    isCorrect: a.is_correct,
    isFirstAttempt: a.is_first_attempt,
    createdAt: a.created_at,
  }));

  return {
    evidence: { concepts: conceptRows, flashcards: cards, cardMappings, schedulerRows, questionMappings, attempts },
    counts: {
      concepts: conceptRows.length, flashcards: cards.length, cardMappings: cardMappings.length,
      schedulerRows: schedulerRows.length, questionMappings: questionMappings.length, attempts: attempts.length,
    },
  };
}


/** Just the bank: the same rows for every learner in a run. */
export async function loadConceptBank(db: SupabaseClient): Promise<ConceptBank> {
  const [concepts, flashcards, cardRows, questionRows] = await Promise.all([
    all<{ id: string; object_type: string; status: string }>(
      db, "concepts", "id, object_type, status", ["id"]),
    all<{ id: string; cloze_count: number | null }>(
      db, "flashcards", "id, cloze_count", ["id"]),
    all<{ flashcard_id: string; concept_id: string; role: string; cloze_indices: number[] | null }>(
      db, "flashcard_concepts", "flashcard_id, concept_id, role, cloze_indices", ["flashcard_id", "concept_id"]),
    all<{ question_id: string; concept_id: string; role: string; evidence_strength: string }>(
      db, "question_concepts", "question_id, concept_id, role, evidence_strength", ["question_id", "concept_id"]),
  ]);
  return {
    concepts: concepts.map((c) => ({ id: c.id, objectType: c.object_type, status: c.status })),
    flashcards: flashcards.map((f) => ({ id: f.id, clozeCount: f.cloze_count ?? 0 })),
    cardMappings: cardRows.map((m) => ({
      conceptId: m.concept_id, flashcardId: m.flashcard_id,
      role: role(m.role, `flashcard_concepts ${m.flashcard_id}/${m.concept_id}`),
      clozeIndices: m.cloze_indices,
    })),
    questionMappings: questionRows.map((m) => ({
      conceptId: m.concept_id, questionId: m.question_id,
      role: role(m.role, `question_concepts ${m.question_id}/${m.concept_id}`),
      evidenceStrength: strength(m.evidence_strength, `question_concepts ${m.question_id}/${m.concept_id}`),
    })),
  };
}

/** Just this learner's own rows. Unfiltered beyond the user, as always. */
export async function loadLearnerEvidence(
  db: SupabaseClient, userId: string,
): Promise<{ schedulerRows: SchedulerRow[]; attempts: AttemptRow[] }> {
  const [schedulerRaw, attemptRows] = await Promise.all([
    all<{ flashcard_id: string; cloze_index: number; stability: number | null; reps: number | null;
          suspended: boolean | null; last_reviewed_at: string | null }>(
      db, "flashcard_user_state",
      "flashcard_id, cloze_index, stability, reps, suspended, last_reviewed_at",
      ["flashcard_id", "cloze_index"], userId),
    all<{ id: string; question_id: string; is_correct: boolean; is_first_attempt: boolean | null; created_at: string }>(
      db, "question_attempts", "id, question_id, is_correct, is_first_attempt, created_at",
      ["created_at", "id"], userId),
  ]);
  return {
    schedulerRows: schedulerRaw.map((r) => ({
      flashcardId: r.flashcard_id, clozeIndex: r.cloze_index,
      stability: r.stability ?? 0, reps: r.reps ?? 0,
      suspended: r.suspended ?? false, lastReviewedAt: r.last_reviewed_at,
    })),
    attempts: attemptRows.map((a) => ({
      id: a.id, questionId: a.question_id, isCorrect: a.is_correct,
      isFirstAttempt: a.is_first_attempt, createdAt: a.created_at,
    })),
  };
}
