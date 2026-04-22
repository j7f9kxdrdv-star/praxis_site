"use client";

import { useEffect, useState, useCallback, useMemo } from "react";
import { useParams, useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import { renderClozeSegments } from "@/lib/flashcards/cloze";
import { nextSchedule, previewLabel, type Rating } from "@/lib/flashcards/scheduler";

// ─── Types ────────────────────────────────────────────────────────────────────

interface Card {
  id: string;
  card_type: "basic" | "cloze";
  front_text: string | null;
  back_text: string | null;
  cloze_text: string | null;
  cloze_count: number;
  explanation: string | null;
}

interface Deck {
  id: string;
  title: string;
  section: string;
  topic: string;
  subtopic: string | null;
}

const SECTION_LABELS: Record<string, string> = {
  biology: "Biology",
  biochemistry: "Biochemistry",
  chemistry: "Chemistry",
  physics: "Physics",
  psych_soc: "Psych/Soc",
};

const RATING_DOT: Record<Rating, string> = {
  again: "bg-rose-400",
  hard: "bg-amber-400",
  medium: "bg-as-primary/60",
  easy: "bg-as-primary",
};

interface UserState {
  flashcard_id: string;
  cloze_index: number;
  starred: boolean;
  suspended: boolean;
  interval_days: number;
  ease_factor: number;
  reps: number;
  lapses: number;
  next_review_at: string;
  last_rating?: string | null;
  last_reviewed_at?: string | null;
}

/** Each "review item" = one card-cloze pair. */
interface ReviewItem {
  card: Card;
  clozeIndex: number; // 0 for basic, 1..N for cloze
  state: UserState | null;
}

// ─── Page ─────────────────────────────────────────────────────────────────────

export default function StudyPage() {
  const params = useParams<{ deckId: string }>();
  const router = useRouter();
  const search = useSearchParams();
  const { user } = useDashboard();
  const filter = search.get("filter") || "due"; // due | all | starred

  const [deck, setDeck] = useState<Deck | null>(null);
  const [queue, setQueue] = useState<ReviewItem[]>([]);
  const [index, setIndex] = useState(0);
  const [revealed, setRevealed] = useState(false);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [stats, setStats] = useState({ reviewed: 0, again: 0 });
  const [history, setHistory] = useState<Rating[]>([]);
  const [sessionStart] = useState(() => Date.now());
  const [now, setNow] = useState(() => Date.now());
  const [done, setDone] = useState(false);

  // Tick the elapsed clock once per second
  useEffect(() => {
    const t = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(t);
  }, []);

  // ─── Load ──────────────────────────────────────────────────────────────────

  useEffect(() => {
    async function load() {
      const [{ data: deckRow }, { data: cardRows }] = await Promise.all([
        supabase
          .from("flashcard_decks")
          .select("id, title, section, topic, subtopic")
          .eq("id", params.deckId)
          .maybeSingle(),
        supabase
          .from("flashcards")
          .select("id, card_type, front_text, back_text, cloze_text, cloze_count, explanation, position")
          .eq("deck_id", params.deckId)
          .order("position"),
      ]);

      if (!deckRow || !cardRows) {
        setLoading(false);
        return;
      }
      setDeck(deckRow as Deck);

      const cards = cardRows as (Card & { position: number })[];

      // Pull state for these cards
      const { data: stateRows } = await supabase
        .from("flashcard_user_state")
        .select("flashcard_id, cloze_index, starred, suspended, interval_days, ease_factor, reps, lapses, next_review_at")
        .eq("user_id", user.id)
        .in("flashcard_id", cards.map((c) => c.id));

      const stateMap = new Map<string, UserState>();
      (stateRows || []).forEach((s) =>
        stateMap.set(`${s.flashcard_id}::${s.cloze_index}`, s as UserState),
      );

      // Build review items
      const allItems: ReviewItem[] = [];
      const now = new Date().toISOString();

      cards.forEach((c) => {
        const groups = c.card_type === "cloze" ? Math.max(c.cloze_count, 1) : 1;
        for (let i = 0; i < groups; i++) {
          const idx = c.card_type === "cloze" ? i + 1 : 0;
          const s = stateMap.get(`${c.id}::${idx}`) || null;
          if (s?.suspended) continue;

          const isDue = !s || s.next_review_at <= now;
          const isStarred = s?.starred === true;

          if (filter === "due" && !isDue) continue;
          if (filter === "starred" && !isStarred) continue;
          // filter === "all" → include everything

          allItems.push({ card: c, clozeIndex: idx, state: s });
        }
      });

      // Shuffle for variety (keeps cloze siblings non-adjacent)
      for (let i = allItems.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [allItems[i], allItems[j]] = [allItems[j], allItems[i]];
      }

      setQueue(allItems);
      setLoading(false);
    }
    load();
  }, [params.deckId, user.id, filter]);

  // ─── Actions ───────────────────────────────────────────────────────────────

  const current = queue[index];

  const flip = useCallback(() => {
    if (!current) return;
    setRevealed((v) => !v);
  }, [current]);

  const advance = useCallback(() => {
    setRevealed(false);
    if (index + 1 >= queue.length) {
      setDone(true);
    } else {
      setIndex((i) => i + 1);
    }
  }, [index, queue.length]);

  async function submitRating(rating: Rating) {
    if (!current || submitting) return;
    setSubmitting(true);

    const prevInterval = current.state?.interval_days ?? 0;
    const reps = current.state?.reps ?? 0;
    const lapses = current.state?.lapses ?? 0;
    const sched = nextSchedule({ rating, intervalDays: prevInterval, reps, lapses });

    // Upsert state
    await supabase.from("flashcard_user_state").upsert(
      {
        user_id: user.id,
        flashcard_id: current.card.id,
        cloze_index: current.clozeIndex,
        starred: current.state?.starred ?? false,
        suspended: false,
        interval_days: sched.intervalDays,
        ease_factor: current.state?.ease_factor ?? 2.5,
        reps: sched.reps,
        lapses: sched.lapses,
        last_rating: rating,
        last_reviewed_at: new Date().toISOString(),
        next_review_at: sched.nextReviewAt.toISOString(),
      },
      { onConflict: "user_id,flashcard_id,cloze_index" },
    );

    // Append review log
    await supabase.from("flashcard_reviews").insert({
      user_id: user.id,
      flashcard_id: current.card.id,
      cloze_index: current.clozeIndex,
      rating,
      prev_interval_days: prevInterval,
      new_interval_days: sched.intervalDays,
    });

    setStats((s) => ({
      reviewed: s.reviewed + 1,
      again: s.again + (rating === "again" ? 1 : 0),
    }));
    setHistory((h) => [...h, rating]);
    setSubmitting(false);
    advance();
  }

  async function toggleStar() {
    if (!current) return;
    const newStarred = !(current.state?.starred ?? false);
    await supabase.from("flashcard_user_state").upsert(
      {
        user_id: user.id,
        flashcard_id: current.card.id,
        cloze_index: current.clozeIndex,
        starred: newStarred,
        suspended: current.state?.suspended ?? false,
        interval_days: current.state?.interval_days ?? 0,
        ease_factor: current.state?.ease_factor ?? 2.5,
        reps: current.state?.reps ?? 0,
        lapses: current.state?.lapses ?? 0,
        last_rating: current.state?.last_rating ?? null,
        last_reviewed_at: current.state?.last_reviewed_at ?? null,
        next_review_at: current.state?.next_review_at ?? new Date().toISOString(),
      },
      { onConflict: "user_id,flashcard_id,cloze_index" },
    );
    // Optimistic update
    setQueue((q) =>
      q.map((item, i) =>
        i === index
          ? {
              ...item,
              state: { ...(item.state || ({} as UserState)), starred: newStarred } as UserState,
            }
          : item,
      ),
    );
  }

  async function suspendCard() {
    if (!current) return;
    await supabase.from("flashcard_user_state").upsert(
      {
        user_id: user.id,
        flashcard_id: current.card.id,
        cloze_index: current.clozeIndex,
        starred: current.state?.starred ?? false,
        suspended: true,
        interval_days: current.state?.interval_days ?? 0,
        ease_factor: current.state?.ease_factor ?? 2.5,
        reps: current.state?.reps ?? 0,
        lapses: current.state?.lapses ?? 0,
        last_rating: current.state?.last_rating ?? null,
        last_reviewed_at: current.state?.last_reviewed_at ?? null,
        next_review_at: current.state?.next_review_at ?? new Date().toISOString(),
      },
      { onConflict: "user_id,flashcard_id,cloze_index" },
    );
    advance();
  }

  // ─── Keyboard shortcuts ────────────────────────────────────────────────────

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (done || !current) return;
      if (e.key === " " || e.key === "Enter") {
        e.preventDefault();
        flip();
      } else if (revealed) {
        if (e.key === "1") submitRating("again");
        else if (e.key === "2") submitRating("hard");
        else if (e.key === "3") submitRating("medium");
        else if (e.key === "4") submitRating("easy");
      }
    }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [revealed, current, done]);

  // ─── Derived render data ──────────────────────────────────────────────────

  const segments = useMemo(() => {
    if (!current) return [];
    if (current.card.card_type === "basic") {
      return [{ kind: "text" as const, text: current.card.front_text || "" }];
    }
    return renderClozeSegments(current.card.cloze_text || "", current.clozeIndex, revealed);
  }, [current, revealed]);

  const backText = current?.card.card_type === "basic" ? current.card.back_text : null;

  // ─── States ────────────────────────────────────────────────────────────────

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

  if (queue.length === 0) {
    return (
      <div className="max-w-2xl mx-auto px-4 sm:px-6 py-10 text-center">
        <p className="text-as-primary font-headline text-xl mb-2">Nothing to review</p>
        <p className="text-as-outline text-sm mb-6">
          {filter === "due"
            ? "No cards are due in this deck right now."
            : filter === "starred"
            ? "You haven't starred any cards in this deck."
            : "This deck is empty."}
        </p>
        <Link
          href={`/dashboard/flashcards/${params.deckId}`}
          className="inline-block bg-as-primary text-white text-xs font-bold uppercase tracking-wider px-5 py-3 rounded-xl"
        >
          Back to Deck
        </Link>
      </div>
    );
  }

  if (done) {
    return (
      <div className="max-w-2xl mx-auto px-4 sm:px-6 py-10">
        <div className="bg-as-primary text-white rounded-[2rem] p-8 text-center mb-6">
          <p className="text-[10px] font-bold uppercase tracking-[0.2em] text-white/60 mb-2">Session Complete</p>
          <h1 className="font-headline text-3xl mb-3">{stats.reviewed} cards reviewed</h1>
          <p className="text-sm text-white/70">
            {stats.again > 0
              ? `${stats.again} marked Again — they'll come back in ~10 minutes.`
              : "Clean run. Cards rescheduled per your ratings."}
          </p>
        </div>
        <div className="flex gap-3">
          <Link
            href={`/dashboard/flashcards/${params.deckId}`}
            className="flex-1 bg-as-surface-container-low text-as-primary text-center text-xs font-bold uppercase tracking-wider px-5 py-4 rounded-xl"
          >
            Back to Deck
          </Link>
          <button
            onClick={() => router.push(`/dashboard/flashcards`)}
            className="flex-1 bg-as-primary text-white text-xs font-bold uppercase tracking-wider px-5 py-4 rounded-xl"
          >
            More Decks
          </button>
        </div>
      </div>
    );
  }

  // ─── Active study UI ───────────────────────────────────────────────────────

  const progressPct = Math.round((index / queue.length) * 100);
  const starred = current?.state?.starred ?? false;
  const intervalDays = current?.state?.interval_days ?? 0;
  const elapsedSec = Math.floor((now - sessionStart) / 1000);
  const elapsedLabel = `${Math.floor(elapsedSec / 60)}:${String(elapsedSec % 60).padStart(2, "0")}`;
  const accuracyPct = stats.reviewed > 0
    ? Math.round(((stats.reviewed - stats.again) / stats.reviewed) * 100)
    : null;

  return (
    <div className="relative z-[1] min-h-[calc(100vh-3.5rem)] lg:min-h-screen flex flex-col">
      <div className="w-full max-w-2xl lg:max-w-7xl mx-auto px-4 sm:px-6 lg:px-10 py-4 sm:py-8 lg:my-auto">
        <div className="grid grid-cols-1 lg:grid-cols-[1fr_320px] gap-6 lg:gap-10">

          {/* ═══════════ LEFT COLUMN — card workspace ═══════════ */}
          <div className="flex flex-col">

            {/* Top bar */}
            <div className="grid grid-cols-3 items-center mb-4">
              <Link
                href={`/dashboard/flashcards/${params.deckId}`}
                className="justify-self-start inline-flex items-center gap-1.5 text-[11px] font-bold uppercase tracking-wider text-as-outline hover:text-as-primary transition-colors"
              >
                <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path d="M6 18L18 6M6 6l12 12" strokeLinecap="round" />
                </svg>
                Exit
              </Link>
              <span className="justify-self-center font-headline text-base text-as-primary tabular-nums">
                <span className="text-as-primary">{index + 1}</span>
                <span className="text-as-outline/60 mx-1.5">/</span>
                <span className="text-as-outline">{queue.length}</span>
              </span>
              <button
                onClick={toggleStar}
                aria-label={starred ? "Unstar card" : "Star card"}
                className={`justify-self-end text-xl transition-transform hover:scale-110 ${starred ? "text-amber-500" : "text-as-outline hover:text-as-primary"}`}
              >
                {starred ? "★" : "☆"}
              </button>
            </div>

            {/* Progress strip */}
            <div className="h-1 w-full bg-as-surface-container rounded-full overflow-hidden mb-6">
              <div
                className="h-full bg-as-primary rounded-full transition-all duration-300"
                style={{ width: `${progressPct}%` }}
              />
            </div>

            {/* Card with library-style double border + layered shadow */}
            <div
              className="relative rounded-[2rem] p-[1.5px] bg-gradient-to-br from-as-outline-variant/40 via-as-primary/10 to-as-outline-variant/40 shadow-[0_30px_60px_-20px_rgba(0,54,48,0.18),0_8px_24px_-12px_rgba(0,54,48,0.12)] transition-all duration-300 hover:-translate-y-0.5 hover:shadow-[0_40px_70px_-20px_rgba(0,54,48,0.22),0_12px_30px_-12px_rgba(0,54,48,0.15)]"
            >
              <button
                onClick={flip}
                className="relative w-full flex items-center justify-center bg-as-surface-container-lowest rounded-[calc(2rem-1.5px)] p-8 sm:p-12 lg:p-14 text-center min-h-[320px] lg:min-h-[420px] lg:max-h-[480px] hover:bg-white transition-colors group"
              >
                <div className="w-full max-w-3xl mx-auto">
          {current?.card.card_type === "cloze" ? (
            <p className="font-headline text-xl sm:text-2xl text-as-primary leading-relaxed">
              {segments.map((seg, i) =>
                seg.kind === "text" ? (
                  <span key={i}>{seg.text}</span>
                ) : seg.revealed ? (
                  <span
                    key={i}
                    className="inline-block bg-as-primary/10 text-as-primary font-bold italic px-2 py-0.5 rounded-md transition-all"
                  >
                    {seg.answer}
                  </span>
                ) : (
                  <span
                    key={i}
                    className="inline-block bg-as-primary/15 text-transparent font-bold rounded-md px-2 py-0.5 select-none"
                    title={seg.hint || ""}
                  >
                    {/* preserve width; render answer as transparent so spacing matches */}
                    {seg.answer}
                  </span>
                ),
              )}
              {!revealed &&
                segments.some(
                  (s) => s.kind === "blank" && s.hint,
                ) && (
                  <span className="block mt-4 text-xs text-as-outline italic">
                    Hint:{" "}
                    {segments
                      .filter((s) => s.kind === "blank" && s.hint)
                      .map((s) => (s.kind === "blank" ? s.hint : ""))
                      .join(" · ")}
                  </span>
                )}
            </p>
          ) : (
            <div>
              <p className="font-headline text-xl sm:text-2xl text-as-primary leading-relaxed mb-4">
                {current?.card.front_text}
              </p>
              {revealed && backText && (
                <div className="pt-4 mt-4 border-t border-as-outline-variant/20">
                  <p className="text-sm sm:text-base text-as-on-surface-variant leading-relaxed">
                    {backText}
                  </p>
                </div>
              )}
            </div>
          )}

          {revealed && current?.card.explanation && (
            <p className="mt-5 text-xs text-as-outline italic leading-relaxed">
              {current.card.explanation}
            </p>
          )}

                </div>
              </button>
            </div>

            {/* Action bar — only rating buttons after reveal */}
            <div className="mt-6 min-h-[3.5rem]">
              {revealed && (
                <div className="space-y-3">
                  <div className="grid grid-cols-4 gap-2 sm:gap-3">
                    {(
                      [
                        { rating: "again" as Rating, label: "Again", key: "1" },
                        { rating: "hard" as Rating, label: "Hard", key: "2" },
                        { rating: "medium" as Rating, label: "Medium", key: "3" },
                        { rating: "easy" as Rating, label: "Easy", key: "4" },
                      ]
                    ).map(({ rating, label, key }) => (
                      <button
                        key={rating}
                        onClick={() => submitRating(rating)}
                        disabled={submitting}
                        className="flex flex-col items-center gap-0.5 py-4 rounded-2xl text-xs font-bold uppercase tracking-wider bg-as-primary text-white hover:bg-as-primary-container transition-colors disabled:opacity-50 shadow-[0_8px_24px_-12px_rgba(0,54,48,0.4)]"
                      >
                        <span>{label}</span>
                        <span className="text-[9px] font-medium opacity-70 normal-case tracking-normal">
                          {previewLabel(intervalDays, rating)} · {key}
                        </span>
                      </button>
                    ))}
                  </div>
                  <button
                    onClick={suspendCard}
                    className="w-full text-[10px] font-bold uppercase tracking-widest text-as-outline hover:text-as-primary py-2"
                  >
                    Suspend this card
                  </button>
                </div>
              )}
            </div>

            {/* Session map — every card in the queue as a tick */}
            <div className="mt-8 pt-6 border-t border-as-outline-variant/20">
              <div className="flex items-center justify-between mb-3">
                <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-as-outline">
                  Session Map
                </span>
                <span className="text-[10px] font-bold uppercase tracking-[0.2em] text-as-outline tabular-nums">
                  {queue.length - index} remaining
                </span>
              </div>
              <div className="flex flex-wrap gap-1">
                {queue.map((_, i) => {
                  const reviewed = i < history.length;
                  const isCurrent = i === index;
                  const dotColor = reviewed
                    ? RATING_DOT[history[i]]
                    : isCurrent
                    ? "bg-as-primary"
                    : "bg-as-outline-variant/40";
                  return (
                    <span
                      key={i}
                      className={`rounded-full transition-all ${dotColor} ${
                        isCurrent
                          ? "w-3 h-3 ring-2 ring-as-primary/30 ring-offset-1 ring-offset-as-surface-container-low"
                          : "w-1.5 h-1.5"
                      }`}
                      title={`Card ${i + 1}${reviewed ? ` · ${history[i]}` : isCurrent ? " · current" : ""}`}
                    />
                  );
                })}
              </div>
            </div>
          </div>

          {/* ═══════════ RIGHT COLUMN — session context panel ═══════════ */}
          <aside className="hidden lg:flex flex-col gap-5 lg:sticky lg:top-8 self-start">

            {/* Deck letterhead */}
            <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
              <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-1.5">
                {SECTION_LABELS[deck.section] || deck.section} · {deck.topic}
              </p>
              <h2 className="font-headline text-lg text-as-primary leading-tight">
                {deck.title}
              </h2>
            </div>

            {/* Session stats triplet */}
            <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
              <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-3">
                This Session
              </p>
              <div className="grid grid-cols-3 gap-2">
                <div>
                  <p className="font-headline text-2xl text-as-primary tabular-nums">{stats.reviewed}</p>
                  <p className="text-[9px] font-bold uppercase tracking-widest text-as-outline mt-0.5">Done</p>
                </div>
                <div>
                  <p className="font-headline text-2xl text-as-primary tabular-nums">
                    {accuracyPct === null ? "—" : `${accuracyPct}%`}
                  </p>
                  <p className="text-[9px] font-bold uppercase tracking-widest text-as-outline mt-0.5">Recall</p>
                </div>
                <div>
                  <p className="font-headline text-2xl text-as-primary tabular-nums">{elapsedLabel}</p>
                  <p className="text-[9px] font-bold uppercase tracking-widest text-as-outline mt-0.5">Time</p>
                </div>
              </div>

              {/* Rating dot timeline */}
              {history.length > 0 && (
                <div className="mt-4 pt-4 border-t border-as-outline-variant/20">
                  <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-2">
                    Recall Timeline
                  </p>
                  <div className="flex flex-wrap gap-1.5">
                    {history.slice(-30).map((r, i) => (
                      <span
                        key={i}
                        className={`w-2 h-2 rounded-full ${RATING_DOT[r]}`}
                        title={r}
                      />
                    ))}
                  </div>
                </div>
              )}
            </div>

            {/* Next interval preview (only after reveal) */}
            {revealed && (
              <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
                <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-3">
                  Next Review In
                </p>
                <div className="space-y-2">
                  {(["again", "hard", "medium", "easy"] as Rating[]).map((r) => (
                    <div key={r} className="flex items-center justify-between text-xs">
                      <span className="flex items-center gap-2">
                        <span className={`w-1.5 h-1.5 rounded-full ${RATING_DOT[r]}`} />
                        <span className="font-bold uppercase tracking-wider text-as-outline">{r}</span>
                      </span>
                      <span className="font-headline text-as-primary tabular-nums">
                        {previewLabel(intervalDays, r)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Keyboard legend */}
            <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
              <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-3">
                Keyboard
              </p>
              <div className="space-y-1.5 text-xs">
                {[
                  { keys: ["Space"], label: "Reveal / Flip" },
                  { keys: ["1"], label: "Again" },
                  { keys: ["2"], label: "Hard" },
                  { keys: ["3"], label: "Medium" },
                  { keys: ["4"], label: "Easy" },
                ].map(({ keys, label }) => (
                  <div key={label} className="flex items-center justify-between">
                    <span className="text-as-on-surface-variant">{label}</span>
                    <span className="flex gap-1">
                      {keys.map((k) => (
                        <kbd
                          key={k}
                          className="px-1.5 py-0.5 rounded-md bg-as-surface-container border border-as-outline-variant/30 text-[10px] font-bold text-as-primary tabular-nums"
                        >
                          {k}
                        </kbd>
                      ))}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </aside>
        </div>
      </div>
    </div>
  );
}
