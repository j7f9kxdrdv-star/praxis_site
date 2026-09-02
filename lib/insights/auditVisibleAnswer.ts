import Anthropic from "@anthropic-ai/sdk";
import { zodOutputFormat } from "@anthropic-ai/sdk/helpers/zod";
import { z } from "zod";

/**
 * Can this card be answered WITHOUT knowing the material?
 *
 * The leech diagnosis asked why cards fail. This asks the opposite question,
 * and it exists because that first pass had a blind spot it could not see past.
 *
 * It selected cards with five or more lapses. But a card whose answer is
 * legible on screen gets answered CORRECTLY — it looks easy, not hard — so
 * selecting on failure systematically excluded the defect class the model is
 * best at finding. Mikko then found four of them in a single study session,
 * every one with few or no lapses.
 *
 * These are the most damaging cards in the bank. A card that cannot be failed
 * teaches the scheduler a successful retrieval that never happened, so FSRS
 * pushes it further out on evidence that is fabricated.
 *
 * Three shapes seen so far, all from real cards:
 *   . the answer restated in the next parenthetical  ("{{c2::one joule per
 *     second}} (1 W = 1 J/s)")
 *   . an enumerated set with each item in its OWN group, so testing one
 *     reveals the others  ("three states: {{c1::closed}}, {{c2::open}},
 *     {{c3::inactivated}}")
 *   . a paired term left visible  ("the horizontal and {{c2::vertical}}
 *     motions")
 */

const AuditSchema = z.object({
  answerable_without_knowing: z
    .boolean()
    .describe("True if a student who has never studied this could still answer it correctly."),
  how: z
    .enum([
      "restated_in_parenthetical",
      "sibling_group_reveals_it",
      "paired_term_visible",
      "paraphrased_in_stem",
      "only_one_option_fits",
      "not_answerable_without_knowing",
    ])
    .describe("not_answerable_without_knowing when the card is sound"),
  confidence: z.enum(["high", "medium", "low"]),
  reasoning: z.string().describe("One or two sentences, quoting the giveaway text."),
  fix_preserves_groups: z
    .boolean()
    .describe("True if the fix can be made without changing which cN groups exist."),
  suggested_rewrite: z
    .string()
    .describe("The corrected cloze text, or empty string if the card is sound."),
});

export type VisibleAnswerAudit = z.infer<typeof AuditSchema>;

const SYSTEM = `You audit MCAT cloze flashcards for answers that are legible without knowing the material.

A cloze card hides one group at a time: every blank sharing a group number N is
hidden together, and ALL OTHER groups are displayed as their answers. So when
group 1 is tested, groups 2 and 3 appear on screen as ordinary text.

For each card, work out whether a student who had never studied the topic could
still produce the hidden answer, by reading what remains visible. Look for:

  . the answer restated nearby, including in symbols or an abbreviation
  . an enumerated set ("three states: ...") with each item in a separate group,
    so revealing the siblings leaves only one possibility
  . a paired or contrasting term left visible, where the answer is the obvious
    partner
  . a trailing clause that paraphrases or defines the answer
  . a stem so constrained that only one word fits regardless of knowledge

BE STRICT ABOUT WHAT COUNTS. Being GUESSABLE by someone with partial subject
knowledge is not a defect; that is ordinary reasoning and is fine. The test is
whether the card supplies the answer to someone who does not have the knowledge.
If real understanding is still required, answer false.

When you propose a rewrite, strongly prefer one that keeps the same cN group
numbers and the same group count: the study screen identifies a blank by its
position, so changing the group set silently re-points students' saved progress
at different material. Usually the fix is to pull the giving-away text INSIDE
the group it gives away, so the two hide together. Only set
fix_preserves_groups false when merging groups is genuinely the only remedy,
which is mainly the enumerated-set case.

Flashcards render plain Unicode only. No LaTeX, no markdown. Never use em or en
dashes.`;

export async function auditVisibleAnswer(
  client: Anthropic,
  deck: string,
  clozeText: string,
): Promise<VisibleAnswerAudit | null> {
  const response = await client.messages.parse({
    model: "claude-opus-5",
    max_tokens: 4000,
    thinking: { type: "adaptive" },
    system: SYSTEM,
    messages: [
      { role: "user", content: `Deck: ${deck}\n\nCard:\n${clozeText}\n\nCan this be answered without knowing the material?` },
    ],
    output_config: { format: zodOutputFormat(AuditSchema) },
  });
  return response.parsed_output ?? null;
}
