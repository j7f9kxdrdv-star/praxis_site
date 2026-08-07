"use client";

import { useEffect, useState, useRef, useCallback, useMemo, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import { renderClozeSegments } from "@/lib/flashcards/cloze";
import { nextSchedule, previewLabel, EASE_DEFAULT, type Rating } from "@/lib/flashcards/scheduler";
import { countTodaysReviews } from "@/lib/flashcards/quota";
import StudySurface from "@/components/flashcards/StudySurface";
import RotateGate from "@/components/flashcards/RotateGate";

// Cross-deck session: due | starred | cram
// Mirrors the per-deck study page but loads cards from EVERY deck the user has access to.

interface Card {
  id: string;
  card_type: "basic" | "cloze";
  front_text: string | null;
  back_text: string | null;
  cloze_text: string | null;
  cloze_count: number;
  explanation: string | null;
  deck_id: string;
}

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

interface ReviewItem {
  card: Card;
  clozeIndex: number;
  state: UserState | null;
}

type Mode = "due" | "starred" | "cram";

const MODE_TITLES: Record<Mode, string> = {
  due: "Due Review",
  starred: "Starred Cards",
  cram: "Cram Mode",
};

const MODE_EMPTY: Record<Mode, string> = {
  due: "Nothing is due across your library right now.",
  starred: "You haven't starred any cards yet. Tap the star while studying to add some.",
  cram: "No cards in your library yet.",
};

const MODE_SUBTITLE: Record<Mode, string> = {
  due: "All cards across every deck that need review now.",
  starred: "Your bookmarked cards from across the library.",
  cram: "Every card in your library, in random order.",
};

const RATING_DOT: Record<Rating, string> = {
  again: "bg-rose-400",
  hard: "bg-amber-400",
  medium: "bg-as-primary/60",
  easy: "bg-as-primary",
};

// When a card is rated "Again", re-insert it this many cards ahead so it
// comes back later in the SAME session (or at the end if fewer remain).
const REQUEUE_GAP = 3;

function SessionInner() {
  const router = useRouter();
  const search = useSearchParams();
  const { user, profile } = useDashboard();
  const rawMode = (search.get("mode") || "due") as Mode;
  const mode: Mode = ["due", "starred", "cram"].includes(rawMode) ? rawMode : "due";

  const [queue, setQueue] = useState<ReviewItem[]>([]);
  const [index, setIndex] = useState(0);
  const [revealed, setRevealed] = useState(false);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  // Progress is tracked per UNIQUE card (flashcard id + cloze index), not per
  // rating, so a card re-queued after "Again" never inflates the counts. A card
  // is "done" only once it earns a passing grade; recall % is first-try accuracy
  // (cards passed on the first attempt ÷ unique cards attempted).
  const seenRef = useRef<Set<string>>(new Set());
  const firstTryOkRef = useRef<Set<string>>(new Set());
  const doneRef = useRef<Set<string>>(new Set());
  const [stats, setStats] = useState({ done: 0, attempted: 0, firstTryCorrect: 0 });
  const [history, setHistory] = useState<Rating[]>([]);
  const [sessionStart] = useState(() => Date.now());
  const [now, setNow] = useState(() => Date.now());
  const [done, setDone] = useState(false);

  // When the queue loads empty in "due" mode, we want to explain why so
  // the user doesn't see a generic blank screen. Two distinct causes:
  // - "limit_reached": cards exist in the due pools but today's quota is
  //   already spent
  // - "nothing_due": no cards are actually due yet (caught up)
  type EmptyReason = "limit_reached" | "nothing_due" | null;
  const [emptyReason, setEmptyReason] = useState<EmptyReason>(null);
  const [emptyContext, setEmptyContext] = useState<{
    newToday: number;
    reviewsToday: number;
    newLimit: number;
    reviewLimit: number;
    poolNew: number;
    poolReview: number;
  } | null>(null);

  useEffect(() => {
    const t = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(t);
  }, []);

  // ─── Load cross-deck queue ────────────────────────────────────────────────
  useEffect(() => {
    async function load() {
      // Page through the ENTIRE card library. Without an explicit range,
      // PostgREST silently caps this at 1000 rows. Once the bank grew past
      // that, later decks were never fetched at all: their cards became
      // invisible to Due/Cram sessions, so the "new" pool looked empty even
      // with thousands of unseen cards remaining, and the session would
      // wrongly report "all caught up" the moment the review cap was hit.
      const cards: Card[] = [];
      const CARD_PAGE = 1000;
      for (let from = 0; ; from += CARD_PAGE) {
        const { data, error } = await supabase
          .from("flashcards")
          .select("id, card_type, front_text, back_text, cloze_text, cloze_count, explanation, deck_id")
          .order("id", { ascending: true })
          .range(from, from + CARD_PAGE - 1);
        if (error || !data || data.length === 0) break;
        cards.push(...(data as Card[]));
        if (data.length < CARD_PAGE) break;
      }

      if (cards.length === 0) {
        setLoading(false);
        return;
      }

      // Fetch every state row this user has. The previous
      // .in("flashcard_id", cards.map((c) => c.id)) clause produced an
      // ~80KB URL once the library grew past ~1k cards, which PostgREST
      // silently truncated — many state rows got dropped, the session
      // misclassified seen cards as "new," and the daily-limit projection
      // came out wrong. .eq("user_id") is selective enough on its own.
      // Also page through results to clear the default 1000-row cap.
      type SessionStateRow = UserState;
      const stateRows: SessionStateRow[] = [];
      const STATE_PAGE = 1000;
      for (let from = 0; ; from += STATE_PAGE) {
        const { data, error } = await supabase
          .from("flashcard_user_state")
          .select("flashcard_id, cloze_index, starred, suspended, interval_days, ease_factor, reps, lapses, next_review_at, last_rating, last_reviewed_at")
          .eq("user_id", user.id)
          // Stable order is REQUIRED for correct pagination: without it
          // Postgres may return pages in shifting physical order (rows move
          // when updated), silently dropping state rows — dropped rows made
          // already-studied cards reappear as "new" and re-seed on grading.
          .order("flashcard_id", { ascending: true })
          .order("cloze_index", { ascending: true })
          .range(from, from + STATE_PAGE - 1);
        if (error || !data || data.length === 0) break;
        stateRows.push(...(data as SessionStateRow[]));
        if (data.length < STATE_PAGE) break;
      }

      const stateMap = new Map<string, UserState>();
      (stateRows || []).forEach((s) =>
        stateMap.set(`${s.flashcard_id}::${s.cloze_index}`, s as UserState),
      );

      // Separate eligible items into "new" (never reviewed) and "review"
      // (seen and due) pools so we can apply the user's daily limits to
      // each independently. Starred and cram modes skip these caps —
      // they're user-initiated overrides.
      const newPool: ReviewItem[] = [];
      const reviewPool: ReviewItem[] = [];
      const now = new Date().toISOString();

      cards.forEach((c) => {
        const groups = c.card_type === "cloze" ? Math.max(c.cloze_count, 1) : 1;
        for (let i = 0; i < groups; i++) {
          const idx = c.card_type === "cloze" ? i + 1 : 0;
          const s = stateMap.get(`${c.id}::${idx}`) || null;
          if (s?.suspended) continue;

          const isDue = !s || s.next_review_at <= now;
          const isStarred = s?.starred === true;

          if (mode === "starred") {
            if (!isStarred) continue;
            reviewPool.push({ card: c, clozeIndex: idx, state: s });
            continue;
          }
          if (mode === "due") {
            if (!isDue) continue;
            (s ? reviewPool : newPool).push({
              card: c,
              clozeIndex: idx,
              state: s,
            });
            continue;
          }
          // mode === "cram" → include everything (incl. unseen)
          (s ? reviewPool : newPool).push({
            card: c,
            clozeIndex: idx,
            state: s,
          });
        }
      });

      let items: ReviewItem[];
      if (mode === "due") {
        // Apply the user's daily limits. Subtract whatever they've
        // already reviewed today so a second session in the same day
        // doesn't blow past the cap.
        const newLimit = profile?.daily_new_card_limit ?? 25;
        const reviewLimit = profile?.daily_review_limit ?? 150;
        const { newToday, reviewsToday } = await countTodaysReviews(user.id);
        // Both categories are throttled per day per the user's settings,
        // subtracting whatever they've already studied today so a second
        // session in the same day doesn't blow past either cap.
        const newQuota = Math.max(0, newLimit - newToday);
        const reviewQuota = Math.max(0, reviewLimit - reviewsToday);
        const poolNew = newPool.length;
        const poolReview = reviewPool.length;
        const servedNew = Math.min(poolNew, newQuota);
        const servedReview = Math.min(poolReview, reviewQuota);
        if (poolNew + poolReview === 0) {
          // Genuinely caught up — nothing due right now.
          setEmptyReason("nothing_due");
        } else if (servedNew + servedReview === 0) {
          // Cards exist in the due pools but today's quotas are already spent.
          setEmptyReason("limit_reached");
        } else {
          setEmptyReason(null);
        }
        setEmptyContext({
          newToday,
          reviewsToday,
          newLimit,
          reviewLimit,
          poolNew,
          poolReview,
        });
        items = [...newPool.slice(0, newQuota), ...reviewPool.slice(0, reviewQuota)];
      } else {
        items = [...newPool, ...reviewPool];
      }

      // Shuffle
      for (let i = items.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [items[i], items[j]] = [items[j], items[i]];
      }

      setQueue(items);
      setLoading(false);
    }
    load();
  }, [user.id, mode, profile?.daily_new_card_limit, profile?.daily_review_limit]);

  // ─── Actions ──────────────────────────────────────────────────────────────
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
    const prevEase = current.state?.ease_factor ?? EASE_DEFAULT;
    const sched = nextSchedule({ rating, intervalDays: prevInterval, easeFactor: prevEase, reps, lapses });

    await supabase.from("flashcard_user_state").upsert(
      {
        user_id: user.id,
        flashcard_id: current.card.id,
        cloze_index: current.clozeIndex,
        starred: current.state?.starred ?? false,
        suspended: false,
        interval_days: sched.intervalDays,
        ease_factor: sched.easeFactor,
        reps: sched.reps,
        lapses: sched.lapses,
        last_rating: rating,
        last_reviewed_at: new Date().toISOString(),
        next_review_at: sched.nextReviewAt.toISOString(),
      },
      { onConflict: "user_id,flashcard_id,cloze_index" },
    );

    await supabase.from("flashcard_reviews").insert({
      user_id: user.id,
      flashcard_id: current.card.id,
      cloze_index: current.clozeIndex,
      rating,
      prev_interval_days: prevInterval,
      new_interval_days: sched.intervalDays,
    });

    // Count each unique card once. "Done" = cards that reached a passing grade;
    // an "Again" re-queues the same card but never re-counts it. First-try
    // accuracy only credits cards passed on their very first attempt.
    const cardKey = `${current.card.id}:${current.clozeIndex}`;
    const firstAttempt = !seenRef.current.has(cardKey);
    const passed = rating !== "again";
    seenRef.current.add(cardKey);
    if (passed) doneRef.current.add(cardKey);
    if (firstAttempt && passed) firstTryOkRef.current.add(cardKey);
    setStats({
      done: doneRef.current.size,
      attempted: seenRef.current.size,
      firstTryCorrect: firstTryOkRef.current.size,
    });
    setHistory((h) => [...h, rating]);
    setSubmitting(false);

    if (rating === "again") {
      // Bring a wrong card back later this session so you keep seeing it until
      // you get it right, instead of waiting for a future session. Carry the
      // just-saved schedule onto the re-queued copy so a later pass builds on
      // the lapsed state rather than the original.
      const requeuedState: UserState = {
        flashcard_id: current.card.id,
        cloze_index: current.clozeIndex,
        starred: current.state?.starred ?? false,
        suspended: false,
        interval_days: sched.intervalDays,
        ease_factor: sched.easeFactor,
        reps: sched.reps,
        lapses: sched.lapses,
        next_review_at: sched.nextReviewAt.toISOString(),
        last_rating: rating,
        last_reviewed_at: new Date().toISOString(),
      };
      const requeued: ReviewItem = { ...current, state: requeuedState };
      setRevealed(false);
      setQueue((q) => {
        const next = [...q];
        const insertAt = Math.min(index + 1 + REQUEUE_GAP, next.length);
        next.splice(insertAt, 0, requeued);
        return next;
      });
      setIndex((i) => i + 1);
    } else {
      advance();
    }
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
    setQueue((q) =>
      q.map((item, i) =>
        i === index
          ? { ...item, state: { ...(item.state || ({} as UserState)), starred: newStarred } as UserState }
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

  // ─── Keyboard shortcuts ───────────────────────────────────────────────────
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

  // ─── Render data ──────────────────────────────────────────────────────────
  const segments = useMemo(() => {
    if (!current) return [];
    if (current.card.card_type === "basic") {
      return [{ kind: "text" as const, text: current.card.front_text || "" }];
    }
    return renderClozeSegments(current.card.cloze_text || "", current.clozeIndex, revealed);
  }, [current, revealed]);

  const backText = current?.card.card_type === "basic" ? current.card.back_text : null;

  // ─── States ───────────────────────────────────────────────────────────────
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (queue.length === 0) {
    // For "due" mode, give the user a contextual explanation + a way to
    // unblock themselves. For starred/cram, fall back to the original
    // generic empty message — those modes don't have daily caps applied.
    const isLimitReached = mode === "due" && emptyReason === "limit_reached";
    const isNothingDue = mode === "due" && emptyReason === "nothing_due";
    const ctx = emptyContext;

    return (
      <div className="max-w-2xl mx-auto px-4 sm:px-6 py-10 text-center">
        <p className="text-as-primary font-headline text-xl mb-2">
          {isLimitReached
            ? "You're all caught up"
            : isNothingDue
            ? "Caught up for today"
            : MODE_TITLES[mode]}
        </p>
        <p className="text-as-outline text-sm mb-6 max-w-md mx-auto leading-relaxed">
          {isLimitReached && ctx ? (
            <>
              You&apos;ve hit today&apos;s limits — <strong>{ctx.newToday}</strong> new
              card{ctx.newToday === 1 ? "" : "s"} and <strong>{ctx.reviewsToday}</strong>{" "}
              review{ctx.reviewsToday === 1 ? "" : "s"} studied. Spaced repetition works
              best if you stop here, but nothing&apos;s stopping you — Cram mode ignores
              the daily caps.
            </>
          ) : isNothingDue ? (
            <>
              Nothing is due right now. New cards land based on your spaced-
              repetition schedule — review more cards today to introduce new
              ones, or come back later as cards cycle back.
            </>
          ) : (
            MODE_EMPTY[mode]
          )}
        </p>
        <div className="flex flex-col sm:flex-row gap-2.5 justify-center max-w-md mx-auto">
          {(isLimitReached || isNothingDue) && (
            <Link
              href="/dashboard/flashcards/session?mode=cram"
              className="inline-block bg-as-primary text-white text-xs font-bold uppercase tracking-wider px-5 py-3 rounded-xl"
            >
              Keep going
            </Link>
          )}
          <Link
            href="/dashboard/flashcards"
            className={`inline-block text-xs font-bold uppercase tracking-wider px-5 py-3 rounded-xl ${
              isLimitReached || isNothingDue
                ? "bg-as-surface-container-low text-as-primary"
                : "bg-as-primary text-white"
            }`}
          >
            {isLimitReached ? "Done for today" : "Back to Decks"}
          </Link>
        </div>
      </div>
    );
  }

  if (done) {
    const missed = stats.attempted - stats.firstTryCorrect;
    return (
      <div className="max-w-2xl mx-auto px-4 sm:px-6 py-10">
        <div className="bg-as-primary text-white rounded-[2rem] p-8 text-center mb-6">
          <p className="text-[10px] font-bold uppercase tracking-[0.2em] text-white/60 mb-2">
            {MODE_TITLES[mode]} · Complete
          </p>
          <h1 className="font-headline text-3xl mb-3">{stats.done} cards reviewed</h1>
          <p className="text-sm text-white/70">
            {missed > 0
              ? `${missed} marked Again — they came back this session until you got them right.`
              : "Clean run. Cards rescheduled per your ratings."}
          </p>
        </div>
        <div className="flex gap-3">
          <button
            onClick={() => router.push(`/dashboard/flashcards`)}
            className="flex-1 bg-as-surface-container-low text-as-primary text-center text-xs font-bold uppercase tracking-wider px-5 py-4 rounded-xl"
          >
            All Decks
          </button>
          <button
            onClick={() => router.push(`/dashboard`)}
            className="flex-1 bg-as-primary text-white text-xs font-bold uppercase tracking-wider px-5 py-4 rounded-xl"
          >
            Dashboard
          </button>
        </div>
      </div>
    );
  }

  // ─── Active study UI ──────────────────────────────────────────────────────
  const starred = current?.state?.starred ?? false;
  const intervalDays = current?.state?.interval_days ?? 0;
  const easeFactor = current?.state?.ease_factor ?? EASE_DEFAULT;
  const elapsedSec = Math.floor((now - sessionStart) / 1000);
  const elapsedLabel = `${Math.floor(elapsedSec / 60)}:${String(elapsedSec % 60).padStart(2, "0")}`;
  const accuracyPct = stats.attempted > 0
    ? Math.round((stats.firstTryCorrect / stats.attempted) * 100)
    : null;

  return (
    <RotateGate>
    <div className="relative z-[1] lg:min-h-screen flex flex-col">
      <div className="w-full lg:max-w-7xl mx-auto pl-[max(env(safe-area-inset-left),0.75rem)] pr-[max(env(safe-area-inset-right),0.75rem)] py-0 lg:px-10 lg:py-8 lg:my-auto">
        <div className="grid grid-cols-1 lg:grid-cols-[1fr_320px] gap-6 lg:gap-10">

          {/* ═══════════ LEFT — card workspace (landscape-first) ═══════════ */}
          <StudySurface
            exitHref="/dashboard/flashcards"
            starred={starred}
            onToggleStar={toggleStar}
            progress={{ done: stats.done, total: Math.max(stats.done + Math.max(0, queue.length - index), stats.done, 1) }}
            cardType={current?.card.card_type ?? "cloze"}
            segments={segments}
            frontText={current?.card.front_text ?? null}
            backText={backText}
            explanation={current?.card.explanation ?? null}
            hint={segments.filter((s) => s.kind === "blank" && s.hint).map((s) => (s.kind === "blank" ? s.hint : "")).join(" · ") || undefined}
            revealed={revealed}
            onFlip={flip}
            intervalDays={intervalDays}
            easeFactor={easeFactor}
            submitting={submitting}
            onRate={submitRating}
            onSuspend={suspendCard}
          />

          {/* ═══════════ RIGHT — context panel ═══════════ */}
          <aside className="hidden lg:flex flex-col gap-5 lg:sticky lg:top-8 self-start">

            {/* Mode letterhead */}
            <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
              <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-1.5">
                Cross-Deck Session
              </p>
              <h2 className="font-headline text-lg text-as-primary leading-tight mb-1.5">
                {MODE_TITLES[mode]}
              </h2>
              <p className="text-xs text-as-on-surface-variant leading-relaxed">
                {MODE_SUBTITLE[mode]}
              </p>
            </div>

            {/* Session stats */}
            <div className="bg-as-surface-container-lowest border border-as-outline-variant/20 rounded-3xl p-5">
              <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-3">
                This Session
              </p>
              <div className="grid grid-cols-3 gap-2">
                <div>
                  <p className="font-headline text-2xl text-as-primary tabular-nums">{stats.done}</p>
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

              {history.length > 0 && (
                <div className="mt-4 pt-4 border-t border-as-outline-variant/20">
                  <p className="text-[9px] font-bold uppercase tracking-[0.2em] text-as-outline mb-2">
                    Recall Timeline
                  </p>
                  <div className="flex flex-wrap gap-1.5">
                    {history.slice(-30).map((r, i) => (
                      <span key={i} className={`w-2 h-2 rounded-full ${RATING_DOT[r]}`} title={r} />
                    ))}
                  </div>
                </div>
              )}
            </div>

            {/* Next interval preview */}
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
                        {previewLabel(intervalDays, easeFactor, r)}
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
    </RotateGate>
  );
}

export default function SessionPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="w-8 h-8 border-2 border-as-primary border-t-transparent rounded-full animate-spin" />
      </div>
    }>
      <SessionInner />
    </Suspense>
  );
}
