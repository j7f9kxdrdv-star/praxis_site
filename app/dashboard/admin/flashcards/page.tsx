"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

interface DeckRow {
  id: string;
  section: string;
  topic: string;
  subtopic: string | null;
  title: string;
  sort_order: number;
}

interface SectionGroup {
  section: string;
  label: string;
  decks: (DeckRow & { cardCount: number })[];
}

const SECTION_LABELS: Record<string, string> = {
  biology: "Biology",
  biochemistry: "Biochemistry",
  chemistry: "Chemistry",
  organic_chemistry: "Organic Chemistry",
  amino_acids: "Amino Acids",
  physics: "Physics",
  scientific_reasoning: "Scientific Reasoning",
  psych_soc: "Psych / Soc",
};

const SECTION_ORDER = [
  "biology",
  "biochemistry",
  "chemistry",
  "organic_chemistry",
  "amino_acids",
  "physics",
  "scientific_reasoning",
  "psych_soc",
];

export default function AdminFlashcardsPage() {
  const router = useRouter();
  const { profile } = useDashboard();
  const [groups, setGroups] = useState<SectionGroup[]>([]);
  const [loading, setLoading] = useState(true);

  // Gate: redirect non-admins
  useEffect(() => {
    if (profile && !profile.is_admin) {
      router.replace("/dashboard");
    }
  }, [profile, router]);

  useEffect(() => {
    async function load() {
      const { data: deckRows } = await supabase
        .from("flashcard_decks")
        .select("id, section, topic, subtopic, title, sort_order")
        .order("section")
        .order("sort_order");

      if (!deckRows || deckRows.length === 0) {
        setLoading(false);
        return;
      }

      // Paginated card-count fetch (bypasses 1000-row cap)
      const deckIds = deckRows.map((d) => d.id);
      const cardsByDeck = new Map<string, number>();
      const PAGE = 1000;
      for (let from = 0; ; from += PAGE) {
        const { data, error } = await supabase
          .from("flashcards")
          .select("id, deck_id")
          .in("deck_id", deckIds)
          // Stable sort is REQUIRED for correct pagination; unordered pages can
          // double-count or drop cards, mis-stating each deck's card count.
          .order("id", { ascending: true })
          .range(from, from + PAGE - 1);
        if (error || !data || data.length === 0) break;
        for (const c of data) {
          cardsByDeck.set(c.deck_id, (cardsByDeck.get(c.deck_id) || 0) + 1);
        }
        if (data.length < PAGE) break;
      }

      // Group by section
      const bySection = new Map<string, (DeckRow & { cardCount: number })[]>();
      for (const d of deckRows) {
        const arr = bySection.get(d.section) || [];
        arr.push({ ...d, cardCount: cardsByDeck.get(d.id) || 0 });
        bySection.set(d.section, arr);
      }

      const result: SectionGroup[] = SECTION_ORDER.filter((s) =>
        bySection.has(s)
      ).map((s) => ({
        section: s,
        label: SECTION_LABELS[s] || s,
        decks: bySection.get(s) || [],
      }));

      setGroups(result);
      setLoading(false);
    }
    load();
  }, []);

  if (!profile?.is_admin) return null;

  const totalDecks = groups.reduce((n, g) => n + g.decks.length, 0);
  const totalCards = groups.reduce(
    (n, g) => n + g.decks.reduce((m, d) => m + d.cardCount, 0),
    0
  );

  return (
    <div className="font-body px-5 py-8 lg:px-0 lg:py-0 max-w-[1100px]">
      <div className="mb-8">
        <div
          className="text-[11px] uppercase mb-2 font-semibold"
          style={{
            letterSpacing: "0.22em",
            color: "var(--color-prax-ink-mute)",
          }}
        >
          Admin · Content Library
        </div>
        <h1
          className="font-serif mb-2"
          style={{
            fontSize: 32,
            fontWeight: 500,
            color: "var(--color-prax-ink)",
            lineHeight: 1.15,
          }}
        >
          Edit flashcards
        </h1>
        <p
          className="text-[14px]"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          Pick a deck to edit individual card text. Changes save immediately
          to the live database.
        </p>
        {!loading && (
          <p
            className="text-[12px] mt-2"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            {totalDecks} deck{totalDecks === 1 ? "" : "s"} · {totalCards.toLocaleString()} cards
          </p>
        )}
      </div>

      {loading ? (
        <div className="text-[14px]" style={{ color: "var(--color-prax-ink-mute)" }}>
          Loading decks…
        </div>
      ) : (
        <div className="space-y-7">
          {groups.map((g) => (
            <div key={g.section}>
              <div
                className="text-[11px] uppercase font-semibold mb-3"
                style={{
                  letterSpacing: "0.18em",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                {g.label} · {g.decks.length} deck{g.decks.length === 1 ? "" : "s"}
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-2.5">
                {g.decks.map((d) => (
                  <Link
                    key={d.id}
                    href={`/dashboard/admin/flashcards/${d.id}`}
                    className="block px-4 py-3 rounded-lg transition hover:shadow-sm"
                    style={{
                      background: "var(--color-prax-cream-card)",
                      border: "1px solid var(--color-prax-cream-border)",
                    }}
                  >
                    <div
                      className="font-serif"
                      style={{
                        fontSize: 16,
                        fontWeight: 500,
                        color: "var(--color-prax-ink)",
                      }}
                    >
                      {d.title}
                    </div>
                    <div
                      className="text-[12px] mt-1"
                      style={{ color: "var(--color-prax-ink-mute)" }}
                    >
                      {d.subtopic ? d.subtopic.replace(/_/g, " ") : d.topic}
                      {" · "}
                      {d.cardCount} card{d.cardCount === 1 ? "" : "s"}
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
