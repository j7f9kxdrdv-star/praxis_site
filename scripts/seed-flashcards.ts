/**
 * Seed flashcard decks + cards into Supabase.
 *
 * Usage:
 *   1. Edit the DECKS array below — add your decks and cards.
 *   2. Make sure these env vars are set (e.g. in .env.local):
 *        NEXT_PUBLIC_SUPABASE_URL=...
 *        SUPABASE_SERVICE_ROLE_KEY=...   (server-side key, never commit)
 *   3. Run:
 *        npx tsx scripts/seed-flashcards.ts
 *
 * What it does:
 *   - Validates every cloze card with `validateClozeText` before writing.
 *   - Upserts decks by (section, topic, subtopic, title) so re-running won't dupe.
 *   - For each deck, deletes existing cards and re-inserts from your spec.
 *     (Re-running fully refreshes that deck's content — user state on existing
 *     `flashcard_user_state` rows is preserved as long as deck rows survive.)
 *
 * NOTE: Deleting cards cascades to flashcard_user_state and flashcard_reviews
 *       for those cards. If you want to *add* cards without nuking history,
 *       comment out the `delete existing cards` block below.
 */

import { createClient } from "@supabase/supabase-js";
import {
  validateClozeText,
  countClozeGroups,
} from "../lib/flashcards/cloze";

// ─── Config ───────────────────────────────────────────────────────────────────

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SERVICE_KEY) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SERVICE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
});

// ─── Types matching the schema ────────────────────────────────────────────────

type Section = "bio_biochem" | "chem_phys" | "psych_soc" | "cars";

interface CardSpec {
  card_type: "basic" | "cloze";
  // Basic cards:
  front_text?: string;
  back_text?: string;
  // Cloze cards:
  cloze_text?: string;
  // Optional:
  notes?: string;
  difficulty?: 1 | 2 | 3 | 4 | 5;
  tags?: string[];
}

interface DeckSpec {
  section: Section;
  topic: string;
  subtopic?: string | null;
  title: string;
  description?: string;
  sort_order?: number;
  cards: CardSpec[];
}

// ─── EDIT BELOW: Add your decks ───────────────────────────────────────────────

const DECKS: DeckSpec[] = [
  {
    section: "bio_biochem",
    topic: "Cellular Respiration",
    subtopic: "glycolysis",
    title: "Glycolysis Essentials",
    description: "Key enzymes, regulation, and net yield of glycolysis.",
    sort_order: 1,
    cards: [
      {
        card_type: "cloze",
        cloze_text:
          "Glycolysis converts one glucose into two {{c1::pyruvate}}, generating a net of {{c2::2 ATP}} and {{c3::2 NADH}}.",
        difficulty: 2,
      },
      {
        card_type: "cloze",
        cloze_text:
          "The committed step of glycolysis is catalyzed by {{c1::phosphofructokinase-1::PFK-1}} and is inhibited by {{c2::ATP}} and {{c3::citrate}}.",
        difficulty: 3,
      },
      {
        card_type: "basic",
        front_text: "Which enzyme produces the only NADH in glycolysis?",
        back_text:
          "Glyceraldehyde-3-phosphate dehydrogenase (G3PDH) — oxidizes G3P to 1,3-BPG.",
        difficulty: 3,
      },
    ],
  },
  // → Add more decks here
];

// ─── Seeder ──────────────────────────────────────────────────────────────────

async function seed() {
  let totalCardsWritten = 0;
  let totalDecks = 0;

  for (const deck of DECKS) {
    // 1) Validate every cloze card up front so we fail fast.
    for (const [i, card] of deck.cards.entries()) {
      if (card.card_type === "cloze") {
        if (!card.cloze_text) {
          throw new Error(
            `Deck "${deck.title}" card #${i + 1}: cloze card missing cloze_text`,
          );
        }
        const result = validateClozeText(card.cloze_text);
        if (!result.valid) {
          throw new Error(
            `Deck "${deck.title}" card #${i + 1} invalid:\n  ${result.errors.join("\n  ")}`,
          );
        }
        if (result.warnings.length > 0) {
          console.warn(
            `Deck "${deck.title}" card #${i + 1} warnings:\n  ${result.warnings.join("\n  ")}`,
          );
        }
      } else {
        if (!card.front_text || !card.back_text) {
          throw new Error(
            `Deck "${deck.title}" card #${i + 1}: basic card needs both front_text and back_text`,
          );
        }
      }
    }

    // 2) Upsert deck (lookup by natural key so re-runs are idempotent).
    const { data: existing } = await supabase
      .from("flashcard_decks")
      .select("id")
      .eq("section", deck.section)
      .eq("topic", deck.topic)
      .eq("title", deck.title)
      .maybeSingle();

    let deckId: string;
    if (existing) {
      const { error } = await supabase
        .from("flashcard_decks")
        .update({
          subtopic: deck.subtopic ?? null,
          description: deck.description ?? null,
          sort_order: deck.sort_order ?? 0,
        })
        .eq("id", existing.id);
      if (error) throw error;
      deckId = existing.id;
      console.log(`↻ Updated deck: ${deck.title}`);
    } else {
      const { data: created, error } = await supabase
        .from("flashcard_decks")
        .insert({
          section: deck.section,
          topic: deck.topic,
          subtopic: deck.subtopic ?? null,
          title: deck.title,
          description: deck.description ?? null,
          sort_order: deck.sort_order ?? 0,
        })
        .select("id")
        .single();
      if (error) throw error;
      deckId = created.id;
      console.log(`+ Created deck: ${deck.title}`);
    }

    // 3) Wipe + re-insert cards. Comment this out to *append* without resetting.
    {
      const { error } = await supabase
        .from("flashcards")
        .delete()
        .eq("deck_id", deckId);
      if (error) throw error;
    }

    // 4) Insert cards in order.
    const cardRows = deck.cards.map((c, i) => {
      const cloze_count =
        c.card_type === "cloze" ? countClozeGroups(c.cloze_text || "") : 0;
      return {
        deck_id: deckId,
        position: i,
        card_type: c.card_type,
        front_text: c.front_text ?? null,
        back_text: c.back_text ?? null,
        cloze_text: c.cloze_text ?? null,
        cloze_count,
        notes: c.notes ?? null,
        difficulty: c.difficulty ?? 3,
        tags: c.tags ?? [],
      };
    });

    if (cardRows.length > 0) {
      const { error } = await supabase.from("flashcards").insert(cardRows);
      if (error) throw error;
    }

    totalDecks++;
    totalCardsWritten += cardRows.length;
    console.log(`  → ${cardRows.length} cards inserted`);
  }

  console.log(
    `\n✓ Done. ${totalDecks} deck(s), ${totalCardsWritten} card(s) written.`,
  );
}

seed().catch((err) => {
  console.error("\n✗ Seed failed:", err.message || err);
  process.exit(1);
});
