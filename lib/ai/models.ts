// ─── Which model runs what ─────────────────────────────────────────────────
//
// ONE PLACE, BECAUSE THERE WERE THREE. diagnoseCard, auditVisibleAnswer and
// the report generator each pinned a model id as a string literal. Two were
// moved to Opus 5 and the third was not, so reports ran a generation behind
// for months and nobody could see it: there was nowhere to look that would
// have shown the three side by side.
//
// The drift was invisible rather than careless, which is the point. A constant
// does not prevent someone editing one call site; models.test.ts does, by
// failing when a model id appears anywhere outside this file.
//
// ─── What changing one of these costs ─────────────────────────────────────
//
// A model swap is not a config change, it is a behaviour change, and moving
// reports to Opus 5 broke them twice over:
//
//   THE ANSWER STOPPED BEING THE FIRST CONTENT BLOCK. Opus 5 returns a
//   thinking block ahead of its prose, so code reading content[0] got a
//   non-text block and silently produced an empty string.
//
//   THINKING TOKENS COUNT AGAINST max_tokens. A budget sized for the answer
//   alone now truncates it mid-sentence, and the stop_reason is the only
//   sign.
//
// Anything moved here needs its output looked at, not just its build checked.

/**
 * Careful reasoning and student-facing prose.
 *
 * Everything on this model is either read by a student or decides what a
 * student is told, so it is the one place the cost of a better model is
 * obviously worth paying.
 */
export const REASONING_MODEL = "claude-opus-5";

/**
 * Bulk content judging in developer scripts.
 *
 * NOT A COST COMPROMISE. Sonnet produces far fewer false positives than Haiku
 * on the flashcard leak check specifically, which is the whole job: a judge
 * that cries wolf on clean cards is worse than no judge.
 *
 * scripts/flashcard-leak-judge.mjs is plain ESM and cannot import this file
 * without the TypeScript loader, so it keeps its own literal and an env
 * override. It is listed here so the inventory is complete, and
 * models.test.ts knows about that exception by name.
 */
export const BULK_JUDGE_MODEL = "claude-sonnet-5";

/** Every id this codebase is allowed to use, for the drift test. */
export const KNOWN_MODELS = [REASONING_MODEL, BULK_JUDGE_MODEL] as const;
