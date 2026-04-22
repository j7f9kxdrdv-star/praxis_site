"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";

// ─── Types ────────────────────────────────────────────────────────────────────

interface Deck {
  id: string;
  section: string;
  topic: string;
  subtopic: string | null;
  title: string;
  description: string | null;
  card_count: number;     // total review items (cloze expanded)
  reviewed_count: number; // distinct items with state
  due_count: number;
}

const sections = [
  {
    id: "biology",
    label: "Biology",
    color: "bg-as-primary/10 text-as-primary",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "biochemistry",
    label: "Biochemistry",
    color: "bg-as-primary-container/10 text-as-primary-container",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "chemistry",
    label: "Chemistry",
    color: "bg-as-surface-tint/10 text-as-surface-tint",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "physics",
    label: "Physics",
    color: "bg-as-on-surface-variant/10 text-as-on-surface-variant",
    accent: "bg-as-surface-container-high",
  },
  {
    id: "psych_soc",
    label: "Psych/Soc",
    color: "bg-as-secondary/10 text-as-secondary",
    accent: "bg-as-surface-container-high",
  },
];

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function FlashcardsHub() {
  const router = useRouter();
  const { user } = useDashboard();
  const [decks, setDecks] = useState<Deck[]>([]);
  const [totalDue, setTotalDue] = useState(0);
  const [totalItems, setTotalItems] = useState(0);
  const [starredCount, setStarredCount] = useState(0);
  const [dataLoaded, setDataLoaded] = useState(false);

  const [expandedSection, setExpandedSection] = useState<string | null>(null);

  useEffect(() => {
    async function load() {
      const { data: deckRows } = await supabase
        .from("flashcard_decks")
        .select("id, section, topic, subtopic, title, description, sort_order")
        .order("section")
        .order("sort_order")
        .order("topic");

      if (!deckRows || deckRows.length === 0) {
        setDataLoaded(true);
        return;
      }

      const { data: cardRows } = await supabase
        .from("flashcards")
        .select("id, deck_id, cloze_count, card_type")
        .in("deck_id", deckRows.map((d) => d.id));

      const itemsByDeck = new Map<string, number>();
      (cardRows || []).forEach((c) => {
        const items = c.card_type === "cloze" ? c.cloze_count || 1 : 1;
        itemsByDeck.set(c.deck_id, (itemsByDeck.get(c.deck_id) || 0) + items);
      });

      const allCardIds = (cardRows || []).map((c) => c.id);
      let stateRows: { flashcard_id: string; cloze_index: number; next_review_at: string; suspended: boolean; starred: boolean }[] = [];
      if (allCardIds.length > 0) {
        const { data } = await supabase
          .from("flashcard_user_state")
          .select("flashcard_id, cloze_index, next_review_at, suspended, starred")
          .eq("user_id", user.id)
          .in("flashcard_id", allCardIds);
        stateRows = data || [];
      }

      const cardToDeck = new Map<string, string>();
      (cardRows || []).forEach((c) => cardToDeck.set(c.id, c.deck_id));

      const reviewedByDeck = new Map<string, Set<string>>();
      const dueByDeck = new Map<string, number>();
      const now = new Date().toISOString();
      let dueAll = 0;
      let starAll = 0;

      stateRows.forEach((s) => {
        if (s.starred) starAll++;
        if (s.suspended) return;
        const deckId = cardToDeck.get(s.flashcard_id);
        if (!deckId) return;
        const seen = reviewedByDeck.get(deckId) || new Set<string>();
        seen.add(`${s.flashcard_id}::${s.cloze_index}`);
        reviewedByDeck.set(deckId, seen);
        if (s.next_review_at <= now) {
          dueByDeck.set(deckId, (dueByDeck.get(deckId) || 0) + 1);
          dueAll++;
        }
      });

      // Unseen items count as due
      let totalAll = 0;
      deckRows.forEach((d) => {
        const total = itemsByDeck.get(d.id) || 0;
        totalAll += total;
        const reviewed = reviewedByDeck.get(d.id)?.size || 0;
        const unseen = total - reviewed;
        if (unseen > 0) {
          dueByDeck.set(d.id, (dueByDeck.get(d.id) || 0) + unseen);
          dueAll += unseen;
        }
      });

      const enriched: Deck[] = deckRows.map((d) => ({
        id: d.id,
        section: d.section,
        topic: d.topic,
        subtopic: d.subtopic,
        title: d.title,
        description: d.description,
        card_count: itemsByDeck.get(d.id) || 0,
        reviewed_count: reviewedByDeck.get(d.id)?.size || 0,
        due_count: dueByDeck.get(d.id) || 0,
      }));

      setDecks(enriched);
      setTotalDue(dueAll);
      setTotalItems(totalAll);
      setStarredCount(starAll);
      setDataLoaded(true);
    }
    load();
  }, [user.id]);

  function decksInSection(section: string) {
    return decks.filter((d) => d.section === section);
  }

  function startDueSession() {
    router.push(`/dashboard/flashcards/session?mode=due`);
  }

  function startStarredSession() {
    router.push(`/dashboard/flashcards/session?mode=starred`);
  }

  function startCramSession() {
    router.push(`/dashboard/flashcards/session?mode=cram`);
  }

  // ─── Render ────────────────────────────────────────────────────────────────

  const noDecks = dataLoaded && decks.length === 0;

  return (
    <div className="max-w-2xl mx-auto px-4 sm:px-6 py-6 sm:py-10">
      <h1 className="font-headline text-2xl sm:text-3xl text-as-primary mb-2">
        Flashcards
      </h1>
      <p className="text-sm text-as-on-surface-variant mb-8">
        Review cloze and basic cards. Spaced repetition keeps you sharp.
      </p>

      {/* ===== EMPTY STATE ===== */}
      {noDecks && (
        <div className="bg-as-surface-container-lowest rounded-2xl border-2 border-dashed border-as-outline-variant/30 p-10 text-center">
          <svg className="w-12 h-12 text-as-outline/30 mx-auto mb-4" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" d="M3.75 8.25a2.25 2.25 0 012.25-2.25h12a2.25 2.25 0 012.25 2.25v8.25a2.25 2.25 0 01-2.25 2.25h-12A2.25 2.25 0 013.75 16.5V8.25z" />
          </svg>
          <p className="text-as-outline text-sm mb-1">No decks yet</p>
          <p className="text-as-outline/60 text-xs">Decks will appear here once content is added.</p>
        </div>
      )}

      {/* ===== REVIEW DUE — Primary CTA ===== */}
      {!noDecks && (
        <button
          onClick={startDueSession}
          disabled={!dataLoaded || totalDue === 0}
          className="w-full bg-as-primary text-as-on-primary rounded-2xl p-6 text-left hover:bg-as-primary-container transition-colors disabled:opacity-50 mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <h2 className="font-headline text-lg text-as-on-primary mb-1">
                Review Due Cards
              </h2>
              <p className="text-sm text-as-on-primary/70">
                {totalDue > 0
                  ? `${totalDue} card${totalDue === 1 ? "" : "s"} ready across all decks.`
                  : "Nothing due right now. Pick a deck below to get ahead."}
              </p>
              {dataLoaded && totalItems > 0 && (
                <p className="text-xs text-as-on-primary/50 mt-1">
                  {totalItems} total review items in library
                </p>
              )}
            </div>
            <svg
              className="w-6 h-6 text-as-on-primary/70 shrink-0 ml-4"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
            </svg>
          </div>
        </button>
      )}

      {/* ===== STARRED REVIEW — Tinted secondary ===== */}
      {!noDecks && dataLoaded && starredCount > 0 && (
        <button
          onClick={startStarredSession}
          className="w-full bg-as-surface-container-high rounded-2xl p-5 text-left hover:bg-as-surface-container-highest transition-colors mb-4"
        >
          <div className="flex items-center justify-between">
            <div>
              <div className="flex items-center gap-2 mb-0.5">
                <span className="text-base">⭐</span>
                <h3 className="font-headline text-base text-as-primary">
                  Starred Cards
                </h3>
              </div>
              <p className="text-sm text-as-on-surface-variant">
                {starredCount} card{starredCount === 1 ? "" : "s"} starred for focused review.
              </p>
            </div>
            <svg
              className="w-5 h-5 text-as-surface-tint shrink-0 ml-4"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
            </svg>
          </div>
        </button>
      )}

      {/* ===== CRAM MODE ===== */}
      {!noDecks && (
        <div className="mt-8">
          <div className="flex items-baseline gap-3 mb-1">
            <h2 className="font-headline text-lg text-as-primary">Cram Mode</h2>
            {dataLoaded && (
              <span className="text-xs text-as-outline">{totalItems} cards</span>
            )}
          </div>
          <p className="text-xs text-as-on-surface-variant mb-4">
            Cycle through cards regardless of due date. Useful right before an exam.
          </p>

          <button
            onClick={startCramSession}
            disabled={!dataLoaded || totalItems === 0}
            className="w-full bg-as-surface-container-lowest rounded-2xl border-2 border-as-outline-variant/15 p-5 text-left hover:border-as-primary/20 hover:shadow-sm transition-all disabled:opacity-50 mb-4"
          >
            <div className="flex items-center justify-between">
              <div>
                <h3 className="font-headline text-base text-as-primary mb-0.5">
                  Cram Across All Decks
                </h3>
                <p className="text-sm text-as-on-surface-variant">
                  Random shuffle through every card in your library.
                </p>
                {dataLoaded && totalItems === 0 && (
                  <p className="text-xs text-as-surface-tint mt-1">
                    Coming soon — no cards available yet.
                  </p>
                )}
              </div>
              <svg
                className="w-5 h-5 text-as-outline shrink-0 ml-4"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={2}
                stroke="currentColor"
              >
                <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
              </svg>
            </div>
          </button>
        </div>
      )}

      {/* ===== BROWSE DECKS ===== */}
      {!noDecks && (
        <div className="mt-10 mb-10">
          <div className="flex items-baseline gap-3 mb-1">
            <h2 className="font-headline text-lg text-as-primary">Browse Decks</h2>
            {dataLoaded && (
              <span className="text-xs text-as-outline">
                {decks.length} total
              </span>
            )}
          </div>
          <p className="text-xs text-as-on-surface-variant mb-4">
            Decks grouped by MCAT section, then by topic.
          </p>

          <div className="space-y-2.5">
            {sections.map((section) => {
              const isExpanded = expandedSection === section.id;
              const sectionDecks = decksInSection(section.id);
              if (dataLoaded && sectionDecks.length === 0) return null;

              const totalCards = sectionDecks.reduce((s, d) => s + d.card_count, 0);
              const totalDueInSection = sectionDecks.reduce((s, d) => s + d.due_count, 0);

              return (
                <div key={section.id}>
                  {/* Section header */}
                  <button
                    onClick={() => setExpandedSection(isExpanded ? null : section.id)}
                    className={`w-full bg-as-surface-container-lowest rounded-xl border p-4 text-left hover:shadow-sm transition-all ${
                      isExpanded
                        ? section.accent + " border-2"
                        : "border-as-outline-variant/15"
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <div
                        className={`w-8 h-8 rounded-lg ${section.color} flex items-center justify-center shrink-0`}
                      >
                        <span className="text-xs font-bold">{section.label.charAt(0)}</span>
                      </div>
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold text-sm text-as-primary">
                          {section.label}
                        </h3>
                        {dataLoaded && (
                          <p className="text-[10px] text-as-outline">
                            {sectionDecks.length} deck{sectionDecks.length === 1 ? "" : "s"} · {totalCards} cards
                            {totalDueInSection > 0 ? ` · ${totalDueInSection} due` : ""}
                          </p>
                        )}
                      </div>
                      <svg
                        className={`w-4 h-4 text-as-outline shrink-0 transition-transform ${
                          isExpanded ? "rotate-180" : ""
                        }`}
                        fill="none"
                        viewBox="0 0 24 24"
                        strokeWidth={2}
                        stroke="currentColor"
                      >
                        <path strokeLinecap="round" strokeLinejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                      </svg>
                    </div>
                  </button>

                  {/* Expanded: deck list */}
                  {isExpanded && (
                    <div className="mt-1.5 ml-4 space-y-1">
                      {sectionDecks.map((d) => (
                        <Link
                          key={d.id}
                          href={`/dashboard/flashcards/${d.id}`}
                          className="block rounded-lg bg-as-surface-container hover:bg-as-surface-container-high px-4 py-2.5 transition-colors"
                        >
                          <div className="flex items-center justify-between gap-3">
                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-medium text-as-primary truncate">
                                {d.title}
                              </p>
                              <p className="text-[10px] text-as-outline">
                                {d.topic}
                                {d.subtopic ? ` · ${d.subtopic.replace(/_/g, " ")}` : ""}
                                {" · "}
                                {d.card_count} cards
                                {d.reviewed_count > 0 ? ` · ${d.reviewed_count} reviewed` : ""}
                              </p>
                            </div>
                            {d.due_count > 0 && (
                              <span className="text-[10px] font-bold uppercase tracking-wide bg-as-primary/10 text-as-primary px-2.5 py-1 rounded-full shrink-0">
                                {d.due_count} due
                              </span>
                            )}
                          </div>
                        </Link>
                      ))}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
