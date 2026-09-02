import Anthropic from "@anthropic-ai/sdk";
import { zodOutputFormat } from "@anthropic-ai/sdk/helpers/zod";
import { z } from "zod";

/**
 * Why does this card keep failing?
 *
 * A card that has lapsed five or more times is telling you something, but the
 * numbers alone cannot say what. Two completely different problems produce the
 * same statistic:
 *
 *   . the CARD is broken — it asks two things at once, the answer is a
 *     sentence rather than a fact, the wording is ambiguous, the blank has no
 *     unique answer;
 *   . the STUDENT has a genuine gap — the card is fine and they do not know
 *     the material, often because something upstream of it is missing.
 *
 * The first needs an edit. The second needs teaching. Getting them backwards
 * is expensive in both directions: rewriting a card the student simply has not
 * learned, or drilling a student against a card that cannot be answered.
 *
 * This is the one place in the product where a language model earns its keep at
 * the card level. No amount of review-log statistics separates those two cases,
 * because the distinguishing evidence is the TEXT — and it needs no concept
 * ontology, so it is available now.
 *
 * WHAT THE MODEL IS AND IS NOT ASKED. It sees the card and the failure pattern
 * and classifies. It is explicitly told that a high lapse count is not by
 * itself evidence of a bad card, because the most likely failure mode here is
 * an eager model agreeing that everything it is shown must be broken. It never
 * decides what the student should study, and it never touches a card: the
 * output is a proposal for a human to accept.
 */

const DiagnosisSchema = z.object({
  verdict: z.enum(["card_defect", "knowledge_gap", "unclear"]),
  confidence: z.enum(["high", "medium", "low"]),
  defect_type: z
    .enum([
      "asks_two_things",
      "answer_not_unique",
      "answer_too_long",
      "ambiguous_wording",
      "answer_visible_elsewhere",
      "requires_missing_context",
      "none",
    ])
    .describe("none when the verdict is not card_defect"),
  reasoning: z.string().describe("One or two sentences. What in the card text drove this."),
  suggested_rewrite: z
    .string()
    .describe(
      "Only when verdict is card_defect: the corrected cloze text, preserving the exact same cN group numbers and group count. Empty string otherwise.",
    ),
  prerequisite: z
    .string()
    .describe(
      "Only when verdict is knowledge_gap: the upstream concept the student most likely lacks. Empty string otherwise.",
    ),
});

export type CardDiagnosis = z.infer<typeof DiagnosisSchema>;

export interface CardToDiagnose {
  id: string;
  deck: string;
  clozeText: string;
  lapses: number;
  reps: number;
  /** Ratings this student has given the card, oldest first. */
  ratingHistory: string[];
  /** How often this student fails cards across the whole bank, for context. */
  baselineAgainRate: number;
}

const SYSTEM = `You audit MCAT flashcards for a spaced repetition system.

Each card is a cloze deletion: {{cN::answer}} marks a blank. Every blank sharing
a group number N is hidden together, and all OTHER groups are shown as their
answers. So when group 1 is tested, groups 2 and 3 are visible on screen.

You are shown a card a student keeps forgetting, and you decide WHY.

  card_defect    the card cannot reliably be answered as written
  knowledge_gap  the card is sound; the student does not know this material
  unclear        you cannot tell from the text alone

BE SCEPTICAL OF card_defect. Every card you see has a high lapse count by
construction, so a high lapse count is NOT evidence of a defect. Hard material
is supposed to be hard, and most cards that are difficult are difficult because
the content is difficult. Reserve card_defect for a concrete flaw you can point
at in the text. If you find yourself reasoning "the student keeps missing it, so
something must be wrong with it", the answer is knowledge_gap or unclear.

Real defects look like: one blank that requires two unrelated facts; a blank
whose answer is not uniquely determined by the sentence; an answer that is a
whole clause rather than a recallable item; an answer that also appears in
visible text elsewhere on the card; wording that could equally admit another
correct answer.

When you propose a rewrite you MUST keep the same cN group numbers and the same
number of distinct groups. The scheduler identifies a blank by its position, so
adding, removing, or renumbering a group silently re-points the student's saved
progress at different material.

Flashcards render plain Unicode only. No LaTeX, no markdown.`;

export async function diagnoseCard(
  client: Anthropic,
  card: CardToDiagnose,
): Promise<CardDiagnosis | null> {
  const recent = card.ratingHistory.slice(-12).join(", ");
  const response = await client.messages.parse({
    model: "claude-opus-5",
    max_tokens: 4000,
    thinking: { type: "adaptive" },
    system: SYSTEM,
    messages: [
      {
        role: "user",
        content: `Deck: ${card.deck}

Card text:
${card.clozeText}

This student's history on this card: ${card.reps} successful reviews, ${card.lapses} lapses.
Their ratings, oldest first: ${recent}
Across the whole bank this student fails ${(100 * card.baselineAgainRate).toFixed(0)}% of reviews, so this card is failing more often than their normal.

Why does this card keep failing?`,
      },
    ],
    output_config: { format: zodOutputFormat(DiagnosisSchema) },
  });
  return response.parsed_output ?? null;
}
