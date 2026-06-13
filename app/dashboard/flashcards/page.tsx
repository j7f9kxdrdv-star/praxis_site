"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import {
  PageHeader,
  ActiveNowPill,
  SmallCaps,
  PraxCard,
  SectionHeader,
  praxBtnCreamOnGreen,
  praxBtnGreenOnCream,
} from "@/components/dashboard/PraxUI";

/* ─────────────── Types ─────────────── */

interface Deck {
  id: string;
  section: string;
  topic: string;
  subtopic: string | null;
  title: string;
  description: string | null;
  card_count: number; // total review items (cloze expanded)
  reviewed_count: number; // distinct items with state
  due_count: number;
  urgent_count: number; // due now (next_review_at <= now) + unseen
  soon_count: number; // due within 3 days
  later_count: number; // due 4+ days out
}

const SECTIONS: { id: string; label: string }[] = [
  { id: "biology", label: "Biology" },
  { id: "biochemistry", label: "Biochemistry" },
  { id: "chemistry", label: "Chemistry" },
  { id: "organic_chemistry", label: "Organic Chemistry" },
  { id: "amino_acids", label: "Amino Acids" },
  { id: "physics", label: "Physics" },
  { id: "scientific_reasoning", label: "Scientific Reasoning" },
  { id: "psych_soc", label: "Psych / Soc" },
];

/* ─────────────── Page ─────────────── */

export default function FlashcardsHub() {
  const router = useRouter();
  const { user, profile, refreshProfile } = useDashboard();
  const [decks, setDecks] = useState<Deck[]>([]);
  const [totalDue, setTotalDue] = useState(0);
  const [totalUrgent, setTotalUrgent] = useState(0);
  const [totalSoon, setTotalSoon] = useState(0);
  const [totalLater, setTotalLater] = useState(0);
  const [totalItems, setTotalItems] = useState(0);
  const [starredCount, setStarredCount] = useState(0);
  const [dataLoaded, setDataLoaded] = useState(false);

  // Used to project how many cards today's "Due Review" session will actually
  // contain, given the user's daily caps and what they've already studied today.
  const [unseenAll, setUnseenAll] = useState(0);
  const [dueReviewAll, setDueReviewAll] = useState(0);
  const [newToday, setNewToday] = useState(0);
  const [reviewsToday, setReviewsToday] = useState(0);

  const [expandedSection, setExpandedSection] = useState<string | null>(null);

  // Daily limits settings modal
  const [showSettings, setShowSettings] = useState(false);

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

      // Page through flashcards to bypass Supabase's default 1000-row cap on .select()
      type CardRow = {
        id: string;
        deck_id: string;
        cloze_count: number | null;
        card_type: string;
      };
      const deckIds = deckRows.map((d) => d.id);
      const cardRows: CardRow[] = [];
      const PAGE = 1000;
      for (let from = 0; ; from += PAGE) {
        const { data: page, error } = await supabase
          .from("flashcards")
          .select("id, deck_id, cloze_count, card_type")
          .in("deck_id", deckIds)
          .range(from, from + PAGE - 1);
        if (error || !page || page.length === 0) break;
        cardRows.push(...(page as CardRow[]));
        if (page.length < PAGE) break;
      }

      const itemsByDeck = new Map<string, number>();
      (cardRows || []).forEach((c) => {
        const items = c.card_type === "cloze" ? c.cloze_count || 1 : 1;
        itemsByDeck.set(c.deck_id, (itemsByDeck.get(c.deck_id) || 0) + items);
      });

      const allCardIds = (cardRows || []).map((c) => c.id);
      let stateRows: {
        flashcard_id: string;
        cloze_index: number;
        next_review_at: string;
        suspended: boolean;
        starred: boolean;
      }[] = [];
      if (allCardIds.length > 0) {
        // Page through state rows too — same 1000-row default cap applies
        for (let from = 0; ; from += PAGE) {
          const { data, error } = await supabase
            .from("flashcard_user_state")
            .select(
              "flashcard_id, cloze_index, next_review_at, suspended, starred"
            )
            .eq("user_id", user.id)
            .in("flashcard_id", allCardIds)
            .range(from, from + PAGE - 1);
          if (error || !data || data.length === 0) break;
          stateRows.push(...data);
          if (data.length < PAGE) break;
        }
      }

      const cardToDeck = new Map<string, string>();
      (cardRows || []).forEach((c) => cardToDeck.set(c.id, c.deck_id));

      const reviewedByDeck = new Map<string, Set<string>>();
      const urgentByDeck = new Map<string, number>();
      const soonByDeck = new Map<string, number>();
      const laterByDeck = new Map<string, number>();
      const now = new Date().toISOString();
      const threeDays = new Date(Date.now() + 3 * 86400000).toISOString();
      let urgentAll = 0;
      let soonAll = 0;
      let laterAll = 0;
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
          urgentByDeck.set(deckId, (urgentByDeck.get(deckId) || 0) + 1);
          urgentAll++;
        } else if (s.next_review_at <= threeDays) {
          soonByDeck.set(deckId, (soonByDeck.get(deckId) || 0) + 1);
          soonAll++;
        } else {
          laterByDeck.set(deckId, (laterByDeck.get(deckId) || 0) + 1);
          laterAll++;
        }
      });

      // Unseen items count as urgent. Track unseen separately so we can
      // project today's session size against the user's daily limits.
      let totalAll = 0;
      let unseenTotal = 0;
      deckRows.forEach((d) => {
        const total = itemsByDeck.get(d.id) || 0;
        totalAll += total;
        const reviewed = reviewedByDeck.get(d.id)?.size || 0;
        const unseen = total - reviewed;
        if (unseen > 0) {
          urgentByDeck.set(d.id, (urgentByDeck.get(d.id) || 0) + unseen);
          urgentAll += unseen;
          unseenTotal += unseen;
        }
      });

      // Count today's review log so the projected session size matches the
      // running quota the session loader actually applies.
      const startOfToday = new Date();
      startOfToday.setHours(0, 0, 0, 0);
      const { data: todayRows } = await supabase
        .from("flashcard_reviews")
        .select("prev_interval_days")
        .eq("user_id", user.id)
        .gte("reviewed_at", startOfToday.toISOString());
      let newDoneToday = 0;
      let reviewsDoneToday = 0;
      for (const r of todayRows || []) {
        if ((r.prev_interval_days ?? 0) === 0) newDoneToday++;
        else reviewsDoneToday++;
      }

      const enriched: Deck[] = deckRows.map((d) => {
        const urgent = urgentByDeck.get(d.id) || 0;
        const soon = soonByDeck.get(d.id) || 0;
        const later = laterByDeck.get(d.id) || 0;
        return {
          id: d.id,
          section: d.section,
          topic: d.topic,
          subtopic: d.subtopic,
          title: d.title,
          description: d.description,
          card_count: itemsByDeck.get(d.id) || 0,
          reviewed_count: reviewedByDeck.get(d.id)?.size || 0,
          due_count: urgent + soon + later,
          urgent_count: urgent,
          soon_count: soon,
          later_count: later,
        };
      });

      setDecks(enriched);
      setTotalDue(urgentAll + soonAll + laterAll);
      setTotalUrgent(urgentAll);
      setTotalSoon(soonAll);
      setTotalLater(laterAll);
      setTotalItems(totalAll);
      setStarredCount(starAll);
      // urgentAll = unseen + due-reviews; split them out for the daily-limit preview
      setUnseenAll(unseenTotal);
      setDueReviewAll(urgentAll - unseenTotal);
      setNewToday(newDoneToday);
      setReviewsToday(reviewsDoneToday);
      setDataLoaded(true);
    }
    load();
  }, [user.id, profile?.daily_new_card_limit, profile?.daily_review_limit]);

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

  /* ─────────────── Render ─────────────── */

  const noDecks = dataLoaded && decks.length === 0;

  // Project how many cards today's Due Review session will actually serve up,
  // given the user's daily limits and what they've already done today.
  const newLimit = profile?.daily_new_card_limit ?? 25;
  const reviewLimit = profile?.daily_review_limit ?? 150;
  const projectedNew = Math.max(
    0,
    Math.min(unseenAll, newLimit - newToday)
  );
  const projectedReview = Math.max(
    0,
    Math.min(dueReviewAll, reviewLimit - reviewsToday)
  );
  const projectedSession = projectedNew + projectedReview;
  // Show the limit explainer only when a cap is actually trimming the queue.
  const isCapping = projectedSession < totalDue && totalDue > 0;

  return (
    <div
      className="px-6 py-8 lg:px-12 lg:py-10"
      style={{
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <PageHeader
        eyebrow="Library · Spaced Repetition"
        title="Flashcards."
        subtitle="Review cloze and basic cards. Spaced repetition keeps recall sharp."
        right={
          <div className="flex items-center gap-2">
            <ActiveNowPill />
            <button
              type="button"
              onClick={() => setShowSettings(true)}
              aria-label="Flashcard settings"
              className="grid place-items-center rounded-full transition-colors"
              style={{
                width: 34,
                height: 34,
                background: "var(--color-prax-cream-card)",
                border: "1px solid var(--color-prax-cream-border)",
                color: "var(--color-prax-ink-soft)",
              }}
            >
              <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={1.6} strokeLinecap="round" strokeLinejoin="round">
                <circle cx={12} cy={12} r={3} />
                <path d="M19.4 15a1.65 1.65 0 00.33 1.82l.06.06a2 2 0 11-2.83 2.83l-.06-.06a1.65 1.65 0 00-1.82-.33 1.65 1.65 0 00-1 1.51V21a2 2 0 11-4 0v-.09A1.65 1.65 0 009 19.4a1.65 1.65 0 00-1.82.33l-.06.06a2 2 0 11-2.83-2.83l.06-.06a1.65 1.65 0 00.33-1.82 1.65 1.65 0 00-1.51-1H3a2 2 0 110-4h.09A1.65 1.65 0 004.6 9a1.65 1.65 0 00-.33-1.82l-.06-.06a2 2 0 112.83-2.83l.06.06a1.65 1.65 0 001.82.33H9a1.65 1.65 0 001-1.51V3a2 2 0 114 0v.09a1.65 1.65 0 001 1.51 1.65 1.65 0 001.82-.33l.06-.06a2 2 0 112.83 2.83l-.06.06a1.65 1.65 0 00-.33 1.82V9a1.65 1.65 0 001.51 1H21a2 2 0 110 4h-.09a1.65 1.65 0 00-1.51 1z" />
              </svg>
            </button>
          </div>
        }
      />

      {/* ===== EMPTY STATE ===== */}
      {noDecks && (
        <PraxCard variant="secondary" className="text-center py-12">
          <svg
            className="mx-auto mb-4"
            width={48}
            height={48}
            viewBox="0 0 24 24"
            fill="none"
            stroke="var(--color-prax-ink-mute)"
            strokeWidth={1.5}
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M3.75 8.25a2.25 2.25 0 012.25-2.25h12a2.25 2.25 0 012.25 2.25v8.25a2.25 2.25 0 01-2.25 2.25h-12A2.25 2.25 0 013.75 16.5V8.25z"
            />
            <path strokeLinecap="round" strokeLinejoin="round" d="M7.5 3.75h9" />
          </svg>
          <div
            className="font-medium mb-1"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            No decks yet
          </div>
          <div
            style={{ fontSize: 13, color: "var(--color-prax-ink-mute)" }}
            className="italic"
          >
            Decks will appear here once content is added.
          </div>
        </PraxCard>
      )}

      {/* ===== PRIMARY: Review Due — green hero ===== */}
      {!noDecks && (
        <PraxCard variant="primary" className="overflow-hidden mb-6">
          {/* Decorative orbital motif */}
          <svg
            className="absolute opacity-20"
            style={{ right: -80, top: -100 }}
            width="380"
            height="380"
            viewBox="0 0 440 440"
            aria-hidden
          >
            <g fill="none" stroke="var(--color-prax-cream)" strokeWidth="1">
              <circle cx="220" cy="220" r="200" />
              <circle cx="220" cy="220" r="150" />
              <circle cx="220" cy="220" r="100" />
              <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(30 220 220)" />
              <ellipse cx="220" cy="220" rx="200" ry="70" transform="rotate(-30 220 220)" />
            </g>
            <circle cx="220" cy="220" r="5" fill="var(--color-prax-gold-soft)" />
          </svg>

          <div className="relative grid grid-cols-1 lg:[grid-template-columns:1.45fr_auto] gap-10 items-center">
            <div>
              <div className="flex items-center gap-2.5 mb-4">
                <div
                  className="rounded-full"
                  style={{
                    width: 6,
                    height: 6,
                    background: "var(--color-prax-gold-soft)",
                  }}
                />
                <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                  Today&apos;s Review · Spaced Repetition
                </SmallCaps>
              </div>
              <div className="flex items-baseline gap-3">
                <div
                  className="leading-none font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 56,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {totalDue}
                </div>
                <div
                  className="italic"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 22,
                    color: "rgba(246,244,227,0.72)",
                  }}
                >
                  cards due
                </div>
              </div>
              <div
                className="mt-3 max-w-[480px]"
                style={{
                  color: "rgba(246,244,227,0.72)",
                  fontSize: 13.5,
                  lineHeight: 1.6,
                }}
              >
                {totalDue > 0
                  ? "Clear your queue today to keep retention strong. Unseen cards are new to you; due cards are scheduled for review now; soon cards land within 3 days."
                  : "Caught up. Pick a deck below to get ahead of the curve, or jump into Cram mode."}
              </div>

              {/* Urgency segmented bar */}
              {totalDue > 0 && (
                <div className="mt-6 max-w-[480px]">
                  <div
                    className="flex rounded-full overflow-hidden"
                    style={{ height: 8, gap: 2 }}
                  >
                    {unseenAll > 0 && (
                      <div
                        style={{
                          flex: unseenAll,
                          background: "var(--color-prax-gold-soft)",
                        }}
                      />
                    )}
                    {dueReviewAll > 0 && (
                      <div
                        style={{
                          flex: dueReviewAll,
                          background: "rgba(212, 161, 78, 0.75)",
                        }}
                      />
                    )}
                    {totalSoon > 0 && (
                      <div
                        style={{
                          flex: totalSoon,
                          background: "rgba(246,244,227,0.45)",
                        }}
                      />
                    )}
                    {totalLater > 0 && (
                      <div
                        style={{
                          flex: totalLater,
                          background: "rgba(246,244,227,0.18)",
                        }}
                      />
                    )}
                  </div>
                  <div
                    className="flex justify-between mt-2"
                    style={{ fontSize: 11, color: "rgba(246,244,227,0.7)" }}
                  >
                    <span>
                      <strong
                        style={{
                          color: "var(--color-prax-gold-soft)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {unseenAll}
                      </strong>{" "}
                      unseen
                    </span>
                    <span>
                      <strong
                        style={{
                          color: "rgba(212, 161, 78, 0.95)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {dueReviewAll}
                      </strong>{" "}
                      due
                    </span>
                    <span>
                      <strong
                        style={{
                          color: "var(--color-prax-cream)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {totalSoon}
                      </strong>{" "}
                      soon
                    </span>
                    <span>
                      <strong
                        style={{
                          color: "rgba(246,244,227,0.85)",
                          fontWeight: 700,
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {totalLater}
                      </strong>{" "}
                      later
                    </span>
                  </div>
                </div>
              )}

              {totalDue > 0 && (
                <div className="mt-7">
                  <button
                    onClick={startDueSession}
                    style={praxBtnCreamOnGreen}
                  >
                    {!isCapping
                      ? "Start Review"
                      : projectedReview === 0
                      ? `Start Review · ${projectedNew} new today`
                      : projectedNew === 0
                      ? `Start Review · ${projectedReview} review today`
                      : `Start Review · ${projectedNew} new + ${projectedReview} review`}
                    <svg
                      width="14"
                      height="14"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                    >
                      <path d="M5 12h14M13 6l6 6-6 6" />
                    </svg>
                  </button>
                  {isCapping && (
                    <div
                      className="mt-3 max-w-[480px]"
                      style={{
                        fontSize: 12,
                        lineHeight: 1.5,
                        color: "rgba(246,244,227,0.72)",
                      }}
                    >
                      {dueReviewAll === 0 ? (
                        <>
                          You haven&apos;t built a review queue yet, so today
                          is all{" "}
                          <strong style={{ color: "var(--color-prax-cream)" }}>
                            {projectedNew} new card
                            {projectedNew === 1 ? "" : "s"}
                          </strong>{" "}
                          (out of {totalDue} unseen). Your review cap kicks in
                          once you start finishing new cards and they cycle
                          back.
                        </>
                      ) : (
                        <>
                          Your daily limits are trimming the queue: you&apos;ll
                          see{" "}
                          <strong style={{ color: "var(--color-prax-cream)" }}>
                            {projectedNew} new
                          </strong>{" "}
                          and{" "}
                          <strong style={{ color: "var(--color-prax-cream)" }}>
                            {projectedReview} review
                          </strong>{" "}
                          card{projectedSession === 1 ? "" : "s"} today (of{" "}
                          {totalDue} due).
                        </>
                      )}{" "}
                      <button
                        type="button"
                        onClick={() => setShowSettings(true)}
                        className="underline"
                        style={{
                          background: "transparent",
                          padding: 0,
                          color: "var(--color-prax-cream)",
                          fontSize: 12,
                          cursor: "pointer",
                        }}
                      >
                        Adjust limits
                      </button>
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Right: lifetime totals */}
            <div className="hidden lg:block text-right pr-2">
              <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                Library
              </SmallCaps>
              <div
                className="leading-none mt-2 font-medium"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 38,
                  color: "var(--color-prax-cream)",
                  fontVariantNumeric: "tabular-nums lining-nums",
                }}
              >
                {totalItems}
              </div>
              <div
                className="italic mt-1"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 13,
                  color: "rgba(246,244,227,0.65)",
                }}
              >
                review items
              </div>
              <div
                className="mt-4"
                style={{
                  fontSize: 12,
                  color: "rgba(246,244,227,0.55)",
                }}
              >
                {decks.length} deck{decks.length === 1 ? "" : "s"}
              </div>
            </div>
          </div>
        </PraxCard>
      )}

      {/* ===== SECONDARY ROW: Starred + Cram ===== */}
      {!noDecks && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-8">
          {/* Starred */}
          <PraxCard variant="secondary">
            <div className="flex items-start justify-between gap-4">
              <div className="min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <div
                    className="rounded-full"
                    style={{
                      width: 5,
                      height: 5,
                      background: "var(--color-prax-gold)",
                    }}
                  />
                  <SmallCaps>Starred Cards</SmallCaps>
                </div>
                <div className="flex items-baseline gap-2">
                  <div
                    className="leading-none font-medium"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 30,
                      color: "var(--color-prax-green)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {starredCount}
                  </div>
                  <div
                    className="italic"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 14,
                      color: "var(--color-prax-ink-soft)",
                    }}
                  >
                    flagged
                  </div>
                </div>
                <p
                  className="mt-2 max-w-[280px]"
                  style={{
                    fontSize: 12.5,
                    color: "var(--color-prax-ink-soft)",
                    lineHeight: 1.5,
                  }}
                >
                  Cards you&apos;ve marked for focused review.
                </p>
              </div>
              {starredCount > 0 && (
                <button
                  onClick={startStarredSession}
                  style={praxBtnGreenOnCream}
                  className="shrink-0"
                >
                  Review
                </button>
              )}
            </div>
          </PraxCard>

          {/* Cram */}
          <PraxCard variant="secondary">
            <div className="flex items-start justify-between gap-4">
              <div className="min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <div
                    className="rounded-full"
                    style={{
                      width: 5,
                      height: 5,
                      background: "var(--color-prax-green-soft)",
                    }}
                  />
                  <SmallCaps>Cram Mode</SmallCaps>
                </div>
                <div className="flex items-baseline gap-2">
                  <div
                    className="leading-none font-medium"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 30,
                      color: "var(--color-prax-green)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {totalItems}
                  </div>
                  <div
                    className="italic"
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 14,
                      color: "var(--color-prax-ink-soft)",
                    }}
                  >
                    items
                  </div>
                </div>
                <p
                  className="mt-2 max-w-[300px]"
                  style={{
                    fontSize: 12.5,
                    color: "var(--color-prax-ink-soft)",
                    lineHeight: 1.5,
                  }}
                >
                  Random shuffle through every card. Useful right before an exam.
                </p>
              </div>
              {totalItems > 0 && (
                <button
                  onClick={startCramSession}
                  style={praxBtnGreenOnCream}
                  className="shrink-0"
                >
                  Start
                </button>
              )}
            </div>
          </PraxCard>
        </div>
      )}

      {/* ===== BROWSE DECKS ===== */}
      {!noDecks && (
        <div className="mb-8">
          <SectionHeader
            label="Browse Decks"
            subtitle={
              dataLoaded
                ? `${decks.length} deck${decks.length === 1 ? "" : "s"} grouped by MCAT section`
                : "Loading library…"
            }
          />

          <div className="space-y-3">
            {SECTIONS.map((section) => {
              const sectionDecks = decksInSection(section.id);
              if (dataLoaded && sectionDecks.length === 0) return null;

              const isExpanded = expandedSection === section.id;
              const totalCards = sectionDecks.reduce(
                (s, d) => s + d.card_count,
                0
              );
              const sectionDue = sectionDecks.reduce(
                (s, d) => s + d.due_count,
                0
              );
              const sectionUrgent = sectionDecks.reduce(
                (s, d) => s + d.urgent_count,
                0
              );
              // Mark as attention if 25%+ of cards are urgent
              const attention =
                totalCards > 0 && sectionUrgent / totalCards >= 0.25;

              return (
                <div key={section.id}>
                  <button
                    onClick={() =>
                      setExpandedSection(isExpanded ? null : section.id)
                    }
                    className="w-full text-left relative"
                    style={{
                      background: isExpanded
                        ? "var(--color-prax-cream-card)"
                        : "var(--color-prax-cream-deep)",
                      border: `1px solid ${
                        attention
                          ? "var(--color-prax-gold-soft)"
                          : "var(--color-prax-cream-border)"
                      }`,
                      borderRadius: 14,
                      padding: "16px 22px",
                      cursor: "pointer",
                    }}
                  >
                    {attention && (
                      <div
                        className="absolute"
                        style={{
                          top: 0,
                          left: 22,
                          right: 22,
                          height: 2,
                          background: "var(--color-prax-gold)",
                        }}
                      />
                    )}
                    <div className="flex items-center gap-4">
                      <div className="flex-1 min-w-0">
                        <div
                          className="font-medium"
                          style={{
                            fontFamily: "var(--font-prax-serif)",
                            fontSize: 18,
                            color: "var(--color-prax-green)",
                          }}
                        >
                          {section.label}
                        </div>
                        {dataLoaded && (
                          <SmallCaps
                            style={{
                              marginTop: 4,
                              color: "var(--color-prax-ink-mute)",
                            }}
                          >
                            {sectionDecks.length} deck
                            {sectionDecks.length === 1 ? "" : "s"} · {totalCards} cards
                            {sectionDue > 0 && ` · ${sectionDue} due`}
                          </SmallCaps>
                        )}
                      </div>
                      {sectionUrgent > 0 && (
                        <div
                          className="px-2.5 py-1 rounded-full"
                          style={{
                            background: "var(--color-prax-gold)",
                            color: "var(--color-prax-cream)",
                            fontSize: 10,
                            fontWeight: 700,
                            letterSpacing: "0.12em",
                            fontVariantNumeric: "tabular-nums",
                          }}
                        >
                          {sectionUrgent} URGENT
                        </div>
                      )}
                      <svg
                        width="16"
                        height="16"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="var(--color-prax-ink-mute)"
                        strokeWidth="2"
                        style={{
                          transform: isExpanded ? "rotate(180deg)" : "none",
                          transition: "transform 0.2s",
                          flexShrink: 0,
                        }}
                      >
                        <path d="M6 9l6 6 6-6" />
                      </svg>
                    </div>
                  </button>

                  {isExpanded && (
                    <div className="mt-2 ml-4 space-y-1">
                      {sectionDecks.map((d) => (
                        <Link
                          key={d.id}
                          href={`/dashboard/flashcards/${d.id}`}
                          className="block px-4 py-3 transition-colors"
                          style={{
                            background: "var(--color-prax-cream-card)",
                            border: "1px solid var(--color-prax-cream-border)",
                            borderRadius: 10,
                          }}
                        >
                          <div className="flex items-center justify-between gap-3">
                            <div className="flex-1 min-w-0">
                              <div
                                className="font-medium truncate"
                                style={{
                                  fontFamily: "var(--font-prax-serif)",
                                  fontSize: 15,
                                  color: "var(--color-prax-green)",
                                }}
                              >
                                {d.title}
                              </div>
                              <div
                                className="mt-0.5"
                                style={{
                                  fontSize: 11,
                                  color: "var(--color-prax-ink-mute)",
                                  fontVariantNumeric: "tabular-nums",
                                }}
                              >
                                {d.topic}
                                {d.subtopic
                                  ? ` · ${d.subtopic.replace(/_/g, " ")}`
                                  : ""}
                                {" · "}
                                {d.card_count} cards
                                {d.reviewed_count > 0
                                  ? ` · ${d.reviewed_count} reviewed`
                                  : ""}
                              </div>
                            </div>
                            {d.urgent_count > 0 ? (
                              <span
                                className="px-2.5 py-1 rounded-full whitespace-nowrap"
                                style={{
                                  background: "var(--color-prax-gold)",
                                  color: "var(--color-prax-cream)",
                                  fontSize: 10,
                                  fontWeight: 700,
                                  letterSpacing: "0.1em",
                                  fontVariantNumeric: "tabular-nums",
                                }}
                              >
                                {d.urgent_count} due
                              </span>
                            ) : d.due_count > 0 ? (
                              <span
                                className="px-2.5 py-1 rounded-full whitespace-nowrap"
                                style={{
                                  background: "var(--color-prax-green-tint)",
                                  color: "var(--color-prax-green)",
                                  fontSize: 10,
                                  fontWeight: 700,
                                  letterSpacing: "0.1em",
                                  fontVariantNumeric: "tabular-nums",
                                }}
                              >
                                {d.due_count} soon
                              </span>
                            ) : null}
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

      {/* ===== FLASHCARD SETTINGS MODAL ===== */}
      {showSettings && (
        <FlashcardSettingsModal
          userId={user.id}
          initialNewLimit={profile?.daily_new_card_limit ?? 25}
          initialReviewLimit={profile?.daily_review_limit ?? 150}
          onClose={() => setShowSettings(false)}
          onSaved={async () => {
            await refreshProfile();
          }}
        />
      )}
    </div>
  );
}

/* ─────────────── Settings modal ─────────────── */

function FlashcardSettingsModal({
  userId,
  initialNewLimit,
  initialReviewLimit,
  onClose,
  onSaved,
}: {
  userId: string;
  initialNewLimit: number;
  initialReviewLimit: number;
  onClose: () => void;
  onSaved: () => Promise<void>;
}) {
  const [newLimit, setNewLimit] = useState(String(initialNewLimit));
  const [reviewLimit, setReviewLimit] = useState(String(initialReviewLimit));
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function save(e: React.FormEvent) {
    e.preventDefault();
    setError(null);
    setSaved(false);

    const newNum = Number(newLimit);
    const reviewNum = Number(reviewLimit);
    if (!Number.isInteger(newNum) || newNum < 0) {
      setError("New cards per day must be a whole number ≥ 0.");
      return;
    }
    if (!Number.isInteger(reviewNum) || reviewNum < 0) {
      setError("Reviews per day must be a whole number ≥ 0.");
      return;
    }

    setSaving(true);
    const { error: dbError } = await supabase
      .from("profiles")
      .update({
        daily_new_card_limit: newNum,
        daily_review_limit: reviewNum,
      })
      .eq("id", userId);
    setSaving(false);

    if (dbError) {
      setError(dbError.message || "Save failed");
      return;
    }

    setSaved(true);
    await onSaved();
    setTimeout(() => setSaved(false), 2000);
  }

  return (
    <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center">
      {/* Backdrop */}
      <div
        className="absolute inset-0"
        style={{ background: "rgba(28, 28, 19, 0.45)" }}
        onClick={onClose}
      />
      {/* Card */}
      <div
        className="relative rounded-t-2xl sm:rounded-2xl w-full sm:max-w-md max-h-[92vh] overflow-y-auto p-8 pb-10"
        style={{
          background: "var(--color-prax-cream)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        {/* Header */}
        <div className="flex items-start justify-between mb-5">
          <div>
            <div
              className="text-[10px] uppercase mb-2 font-semibold"
              style={{
                letterSpacing: "0.22em",
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Flashcards · Daily Limits
            </div>
            <h3
              className="font-serif"
              style={{
                fontSize: 22,
                fontWeight: 500,
                color: "var(--color-prax-ink)",
                lineHeight: 1.1,
              }}
            >
              Study settings
            </h3>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label="Close"
            className="transition-colors"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            <svg width={18} height={18} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={1.8} strokeLinecap="round" strokeLinejoin="round">
              <path d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <p
          className="text-[13px] mb-5"
          style={{ color: "var(--color-prax-ink-soft)" }}
        >
          Cap how many cards your study sessions show each day. The session
          picker respects these in <em>Due</em> mode; <em>Cram</em> and
          <em> Starred</em> ignore them on purpose.
        </p>

        <form onSubmit={save} className="space-y-4">
          <ModalField
            label="New cards per day"
            hint="Cards you've never seen before"
            value={newLimit}
            onChange={setNewLimit}
            placeholder="e.g. 25"
          />
          <ModalField
            label="Reviews per day"
            hint="Cards you've already studied that have come back due"
            value={reviewLimit}
            onChange={setReviewLimit}
            placeholder="e.g. 150"
          />
          <p
            className="text-[12px]"
            style={{ color: "var(--color-prax-ink-mute)" }}
          >
            A <strong>new card</strong> is one you&apos;ve never reviewed
            before. A <strong>review</strong> is one you&apos;ve seen that
            is now due. Set either to 0 to pause that category for the day.
          </p>

          {error && (
            <div
              className="text-[12px]"
              style={{ color: "var(--color-prax-red, #b94a4a)" }}
            >
              {error}
            </div>
          )}

          <div className="flex items-center justify-end gap-3 pt-3">
            {saved && (
              <span
                className="text-[12px]"
                style={{ color: "var(--color-prax-green)" }}
              >
                ✓ Saved
              </span>
            )}
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 rounded-lg text-[13px] font-semibold"
              style={{
                background: "transparent",
                color: "var(--color-prax-ink-soft)",
                border: "1px solid var(--color-prax-cream-border)",
              }}
            >
              Close
            </button>
            <button
              type="submit"
              disabled={saving}
              className="px-5 py-2 rounded-lg font-semibold text-[13px] disabled:opacity-50"
              style={{
                background: "var(--color-prax-green)",
                color: "#fff",
              }}
            >
              {saving ? "Saving…" : "Save"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

function ModalField({
  label,
  hint,
  value,
  onChange,
  placeholder,
}: {
  label: string;
  hint?: string;
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
}) {
  return (
    <label className="block">
      <div
        className="text-[11px] font-semibold uppercase mb-1"
        style={{
          letterSpacing: "0.14em",
          color: "var(--color-prax-ink-mute)",
        }}
      >
        {label}
      </div>
      {hint && (
        <div
          className="text-[11.5px] mb-1.5"
          style={{
            color: "var(--color-prax-ink-soft)",
            fontStyle: "italic",
          }}
        >
          {hint}
        </div>
      )}
      <input
        type="number"
        min={0}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className="w-full px-3 py-2 rounded-lg text-[14px]"
        style={{
          background: "var(--color-prax-cream-card)",
          color: "var(--color-prax-ink)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      />
    </label>
  );
}
