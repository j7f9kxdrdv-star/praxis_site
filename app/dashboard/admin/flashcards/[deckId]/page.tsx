"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useDashboard } from "@/components/dashboard/DashboardShell";

interface Deck {
  id: string;
  title: string;
  section: string;
  topic: string;
  subtopic: string | null;
}

interface Card {
  id: string;
  position: number;
  card_type: string;
  cloze_text: string;
  cloze_count: number | null;
}

// Count distinct {{cN::...}} groups in the cloze text. Used so the
// stored cloze_count stays consistent with the text on save.
function countClozeGroups(text: string): number {
  const groups = new Set<number>();
  const re = /\{\{c(\d+)::/g;
  let m: RegExpExecArray | null;
  while ((m = re.exec(text)) !== null) {
    groups.add(parseInt(m[1], 10));
  }
  return Math.max(1, groups.size);
}

export default function AdminDeckEditPage() {
  const params = useParams<{ deckId: string }>();
  const router = useRouter();
  const { profile } = useDashboard();
  const [deck, setDeck] = useState<Deck | null>(null);
  const [cards, setCards] = useState<Card[]>([]);
  const [drafts, setDrafts] = useState<Map<string, string>>(new Map());
  const [savingId, setSavingId] = useState<string | null>(null);
  const [savedFlash, setSavedFlash] = useState<Map<string, number>>(new Map());
  const [errorFlash, setErrorFlash] = useState<Map<string, string>>(new Map());
  const [loading, setLoading] = useState(true);

  // Gate: redirect non-admins
  useEffect(() => {
    if (profile && !profile.is_admin) {
      router.replace("/dashboard");
    }
  }, [profile, router]);

  useEffect(() => {
    async function load() {
      const [deckRes, cardsRes] = await Promise.all([
        supabase
          .from("flashcard_decks")
          .select("id, title, section, topic, subtopic")
          .eq("id", params.deckId)
          .single(),
        supabase
          .from("flashcards")
          .select("id, position, card_type, cloze_text, cloze_count")
          .eq("deck_id", params.deckId)
          .order("position"),
      ]);

      setDeck(deckRes.data);
      setCards(cardsRes.data || []);
      setLoading(false);
    }
    if (params.deckId) load();
  }, [params.deckId]);

  function setDraft(cardId: string, text: string) {
    const next = new Map(drafts);
    next.set(cardId, text);
    setDrafts(next);
    // Clear error on edit
    if (errorFlash.has(cardId)) {
      const err = new Map(errorFlash);
      err.delete(cardId);
      setErrorFlash(err);
    }
  }

  async function saveCard(card: Card) {
    const draft = drafts.get(card.id);
    if (draft === undefined || draft === card.cloze_text) return;

    const newClozeCount = countClozeGroups(draft);
    setSavingId(card.id);

    const { error } = await supabase
      .from("flashcards")
      .update({
        cloze_text: draft,
        cloze_count: newClozeCount,
      })
      .eq("id", card.id);

    setSavingId(null);

    if (error) {
      const err = new Map(errorFlash);
      err.set(card.id, error.message || "Save failed");
      setErrorFlash(err);
      return;
    }

    // Update local state, drop draft, flash a "saved" indicator
    setCards((prev) =>
      prev.map((c) =>
        c.id === card.id
          ? { ...c, cloze_text: draft, cloze_count: newClozeCount }
          : c
      )
    );
    const nextDrafts = new Map(drafts);
    nextDrafts.delete(card.id);
    setDrafts(nextDrafts);
    const flashId = Date.now();
    const flash = new Map(savedFlash);
    flash.set(card.id, flashId);
    setSavedFlash(flash);
    setTimeout(() => {
      setSavedFlash((prev) => {
        if (prev.get(card.id) !== flashId) return prev;
        const next = new Map(prev);
        next.delete(card.id);
        return next;
      });
    }, 2200);
  }

  function revert(cardId: string) {
    const next = new Map(drafts);
    next.delete(cardId);
    setDrafts(next);
    const err = new Map(errorFlash);
    err.delete(cardId);
    setErrorFlash(err);
  }

  if (!profile?.is_admin) return null;

  return (
    <div className="font-body px-5 py-8 lg:px-0 lg:py-0 max-w-[900px]">
      <Link
        href="/dashboard/admin/flashcards"
        className="text-[12px] inline-flex items-center gap-1 mb-4 hover:underline"
        style={{ color: "var(--color-prax-ink-mute)" }}
      >
        ← All decks
      </Link>

      {deck && (
        <div className="mb-6">
          <div
            className="text-[11px] uppercase mb-2 font-semibold"
            style={{
              letterSpacing: "0.22em",
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Admin · {deck.topic}
            {deck.subtopic ? ` · ${deck.subtopic.replace(/_/g, " ")}` : ""}
          </div>
          <h1
            className="font-serif mb-2"
            style={{
              fontSize: 30,
              fontWeight: 500,
              color: "var(--color-prax-ink)",
              lineHeight: 1.15,
            }}
          >
            {deck.title}
          </h1>
          <p
            className="text-[12px]"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            {cards.length} card{cards.length === 1 ? "" : "s"} · cloze blanks
            written as <code>&#123;&#123;c1::answer&#125;&#125;</code>. Saves
            run live against the database — be careful.
          </p>
        </div>
      )}

      {loading ? (
        <div className="text-[14px]" style={{ color: "var(--color-prax-ink-mute)" }}>
          Loading…
        </div>
      ) : (
        <div className="space-y-3">
          {cards.map((card) => {
            const draft = drafts.get(card.id);
            const isDirty = draft !== undefined && draft !== card.cloze_text;
            const isSaving = savingId === card.id;
            const isSaved = savedFlash.has(card.id);
            const error = errorFlash.get(card.id);
            const value = draft ?? card.cloze_text;
            const projectedClozeCount = isDirty
              ? countClozeGroups(value)
              : card.cloze_count ?? countClozeGroups(card.cloze_text);

            return (
              <div
                key={card.id}
                className="px-4 py-3 rounded-lg"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: `1px solid ${
                    error
                      ? "var(--color-prax-red, #b94a4a)"
                      : isDirty
                      ? "var(--color-prax-green)"
                      : "var(--color-prax-cream-border)"
                  }`,
                }}
              >
                <div className="flex items-center justify-between mb-2">
                  <div
                    className="text-[11px] font-semibold uppercase"
                    style={{
                      letterSpacing: "0.18em",
                      color: "var(--color-prax-ink-mute)",
                    }}
                  >
                    Card #{card.position + 1} · {projectedClozeCount} cloze
                    {projectedClozeCount === 1 ? "" : "s"}
                  </div>
                  <div className="flex items-center gap-2">
                    {isSaved && (
                      <span
                        className="text-[11px]"
                        style={{ color: "var(--color-prax-green)" }}
                      >
                        ✓ Saved
                      </span>
                    )}
                    {isDirty && !isSaving && (
                      <>
                        <button
                          onClick={() => revert(card.id)}
                          className="text-[12px] px-2 py-1 rounded hover:underline"
                          style={{ color: "var(--color-prax-ink-mute)" }}
                        >
                          Revert
                        </button>
                        <button
                          onClick={() => saveCard(card)}
                          className="text-[12px] px-3 py-1 rounded font-semibold"
                          style={{
                            background: "var(--color-prax-green)",
                            color: "#fff",
                          }}
                        >
                          Save
                        </button>
                      </>
                    )}
                    {isSaving && (
                      <span
                        className="text-[12px]"
                        style={{ color: "var(--color-prax-ink-mute)" }}
                      >
                        Saving…
                      </span>
                    )}
                  </div>
                </div>
                <textarea
                  value={value}
                  onChange={(e) => setDraft(card.id, e.target.value)}
                  onKeyDown={(e) => {
                    // Cmd/Ctrl+Enter saves
                    if (
                      (e.metaKey || e.ctrlKey) &&
                      e.key === "Enter" &&
                      isDirty &&
                      !isSaving
                    ) {
                      e.preventDefault();
                      saveCard(card);
                    }
                    // Escape reverts
                    if (e.key === "Escape" && isDirty) {
                      revert(card.id);
                    }
                  }}
                  className="w-full font-mono text-[13px] resize-y leading-relaxed p-2 rounded"
                  style={{
                    minHeight: 80,
                    background: "var(--color-prax-cream)",
                    color: "var(--color-prax-ink)",
                    border: "1px solid var(--color-prax-cream-border)",
                  }}
                />
                {error && (
                  <div
                    className="text-[12px] mt-2"
                    style={{ color: "var(--color-prax-red, #b94a4a)" }}
                  >
                    Error: {error}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
