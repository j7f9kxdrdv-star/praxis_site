"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import { countClozeGroups, clozeToMaskedPreview } from "@/lib/flashcards/cloze";

interface Deck {
  id: string;
  section: string;
  topic: string;
  subtopic: string | null;
  title: string;
  description: string | null;
}

interface Card {
  id: string;
  card_type: "basic" | "cloze";
  front_text: string | null;
  back_text: string | null;
  cloze_text: string | null;
  cloze_count: number;
  position: number;
}

interface UserStateRow {
  flashcard_id: string;
  cloze_index: number;
  starred: boolean;
  suspended: boolean;
  next_review_at: string;
  last_reviewed_at: string | null;
  last_rating: string | null;
}

const SECTION_LABELS: Record<string, string> = {
  biology: "Biology",
  biochemistry: "Biochemistry",
  chemistry: "Chemistry",
  physics: "Physics",
  psych_soc: "Psych/Soc",
};

export default function DeckDetailPage() {
  const router = useRouter();
  const { user } = useDashboard();
  const params = useParams<{ deckId: string }>();
  const deckId = params.deckId;

  const [deck, setDeck] = useState<Deck | null>(null);
  const [cards, setCards] = useState<Card[]>([]);
  const [stateRows, setStateRows] = useState<UserStateRow[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      const [{ data: deckRow }, { data: cardRows }] = await Promise.all([
        supabase
          .from("flashcard_decks")
          .select("id, section, topic, subtopic, title, description")
          .eq("id", deckId)
          .maybeSingle(),
        supabase
          .from("flashcards")
          .select("id, card_type, front_text, back_text, cloze_text, cloze_count, position")
          .eq("deck_id", deckId)
          .order("position"),
      ]);

      setDeck(deckRow as Deck | null);
      setCards((cardRows as Card[]) || []);

      if (cardRows && cardRows.length > 0) {
        const { data: state } = await supabase
          .from("flashcard_user_state")
          .select("flashcard_id, cloze_index, starred, suspended, next_review_at, last_reviewed_at, last_rating")
          .eq("user_id", user.id)
          .in("flashcard_id", cardRows.map((c) => c.id));
        setStateRows((state as UserStateRow[]) || []);
      }
      setLoading(false);
    }
    load();
  }, [deckId, user.id]);

  // ─── Derived stats ────────────────────────────────────────────────────────

  const totalItems = cards.reduce(
    (s, c) => s + (c.card_type === "cloze" ? Math.max(c.cloze_count, 1) : 1),
    0,
  );

  const stateByKey = new Map<string, UserStateRow>();
  stateRows.forEach((s) => stateByKey.set(`${s.flashcard_id}::${s.cloze_index}`, s));

  let reviewedItems = 0;
  let dueItems = 0;
  let starredItems = 0;
  let suspendedItems = 0;
  const now = new Date().toISOString();

  cards.forEach((c) => {
    const groups = c.card_type === "cloze" ? Math.max(c.cloze_count, 1) : 1;
    for (let i = 0; i < groups; i++) {
      const idx = c.card_type === "cloze" ? i + 1 : 0;
      const s = stateByKey.get(`${c.id}::${idx}`);
      if (s) {
        reviewedItems++;
        if (s.suspended) suspendedItems++;
        else if (s.next_review_at <= now) dueItems++;
        if (s.starred) starredItems++;
      } else {
        // unseen → due
        dueItems++;
      }
    }
  });

  const accuracyKnown = stateRows.length > 0;
  const reviewProgress = totalItems > 0 ? Math.round((reviewedItems / totalItems) * 100) : 0;

  // ─── Render ────────────────────────────────────────────────────────────────

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!deck) {
    return (
      <div className="max-w-2xl mx-auto px-4 sm:px-6 py-10 text-center">
        <p className="text-as-outline mb-4">Deck not found.</p>
        <Link href="/dashboard/flashcards" className="text-as-primary text-sm underline">
          Back to all decks
        </Link>
      </div>
    );
  }

  return (
    <div className="max-w-2xl mx-auto px-4 sm:px-6 py-6 sm:py-10">

      {/* ── Back link ── */}
      <Link
        href="/dashboard/flashcards"
        className="inline-flex items-center gap-2 text-[11px] font-bold uppercase tracking-wider text-as-outline hover:text-as-primary transition-colors mb-6"
      >
        <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
          <path d="M19 12H5M12 5l-7 7 7 7" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
        All Decks
      </Link>

      {/* ── Header ── */}
      <div className="mb-8">
        <span className="text-[10px] font-bold tracking-[0.2em] text-as-outline uppercase block mb-2">
          {SECTION_LABELS[deck.section] || deck.section} · {deck.topic}
        </span>
        <h1 className="font-headline text-3xl sm:text-4xl text-as-primary mb-2">
          {deck.title}
        </h1>
        {deck.description && (
          <p className="text-sm text-as-on-surface-variant">{deck.description}</p>
        )}
      </div>

      {/* ── Stats grid ── */}
      <div className="grid grid-cols-3 gap-3 mb-6">
        {[
          { label: "Items", value: totalItems.toString() },
          { label: "Reviewed", value: `${reviewedItems}/${totalItems}` },
          { label: "Due", value: dueItems.toString() },
        ].map(({ label, value }) => (
          <div
            key={label}
            className="bg-as-surface-container-lowest rounded-2xl border border-as-outline-variant/15 p-4 flex flex-col gap-1"
          >
            <span className="text-[9px] font-bold uppercase tracking-widest text-as-outline">{label}</span>
            <span className="text-2xl font-bold text-as-primary">{value}</span>
          </div>
        ))}
      </div>

      {/* ── Progress bar ── */}
      {accuracyKnown && (
        <div className="mb-6">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-[10px] font-bold uppercase tracking-widest text-as-outline">
              Deck Progress
            </span>
            <span className="text-xs font-bold text-as-primary">{reviewProgress}%</span>
          </div>
          <div className="h-2 w-full bg-as-surface-container rounded-full overflow-hidden">
            <div
              className="h-full bg-as-primary rounded-full transition-all duration-1000"
              style={{ width: `${reviewProgress}%` }}
            />
          </div>
        </div>
      )}

      {/* ── Start studying (primary CTA) ── */}
      <button
        onClick={() => router.push(`/dashboard/flashcards/${deckId}/study`)}
        disabled={totalItems === 0}
        className="w-full bg-as-primary text-as-on-primary rounded-2xl p-6 text-left hover:bg-as-primary-container transition-colors disabled:opacity-50 mb-3"
      >
        <div className="flex items-center justify-between">
          <div>
            <h2 className="font-headline text-lg text-as-on-primary mb-1">
              {dueItems > 0 ? "Start Studying" : "Review All Cards"}
            </h2>
            <p className="text-sm text-as-on-primary/70">
              {dueItems > 0
                ? `${dueItems} due now — go through them in order.`
                : totalItems === 0
                ? "This deck has no cards yet."
                : "Nothing due. You can still review the whole deck if you want extra practice."}
            </p>
          </div>
          <svg className="w-6 h-6 text-as-on-primary/70 shrink-0 ml-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
          </svg>
        </div>
      </button>

      {/* ── Filter chips: starred / all ── */}
      <div className="grid grid-cols-2 gap-3 mb-10">
        <button
          onClick={() => router.push(`/dashboard/flashcards/${deckId}/study?filter=starred`)}
          disabled={starredItems === 0}
          className="bg-as-surface-container-lowest rounded-xl border border-as-outline-variant/15 p-4 text-left hover:border-as-primary/30 transition-all disabled:opacity-50"
        >
          <p className="text-[10px] font-bold uppercase tracking-widest text-as-outline mb-1">Starred</p>
          <p className="text-sm font-medium text-as-primary">
            {starredItems > 0 ? `Review ${starredItems}` : "None starred"}
          </p>
        </button>
        <button
          onClick={() => router.push(`/dashboard/flashcards/${deckId}/study?filter=all`)}
          disabled={totalItems === 0}
          className="bg-as-surface-container-lowest rounded-xl border border-as-outline-variant/15 p-4 text-left hover:border-as-primary/30 transition-all disabled:opacity-50"
        >
          <p className="text-[10px] font-bold uppercase tracking-widest text-as-outline mb-1">Cram Mode</p>
          <p className="text-sm font-medium text-as-primary">All {totalItems} cards</p>
        </button>
      </div>

      {/* ── Card preview list ── */}
      {cards.length > 0 && (
        <div>
          <h2 className="font-headline text-lg text-as-primary mb-3">Cards in this deck</h2>
          <div className="space-y-2">
            {cards.slice(0, 25).map((c) => {
              const preview =
                c.card_type === "cloze" && c.cloze_text
                  ? clozeToMaskedPreview(c.cloze_text)
                  : c.front_text || "";
              const groups = c.card_type === "cloze" ? countClozeGroups(c.cloze_text || "") : 1;
              return (
                <div
                  key={c.id}
                  className="bg-as-surface-container-lowest rounded-xl border border-as-outline-variant/15 p-3.5"
                >
                  <div className="flex items-start gap-3">
                    <span className="text-[9px] font-bold uppercase tracking-widest text-as-outline shrink-0 pt-1">
                      {c.card_type === "cloze" ? `Cloze · ${groups}` : "Basic"}
                    </span>
                    <p className="text-sm text-as-primary flex-1 leading-relaxed">{preview}</p>
                  </div>
                </div>
              );
            })}
            {cards.length > 25 && (
              <p className="text-xs text-as-outline text-center pt-2">
                + {cards.length - 25} more cards
              </p>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
