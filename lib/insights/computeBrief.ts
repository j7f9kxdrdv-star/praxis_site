import type { SupabaseClient } from "@supabase/supabase-js";
import type { Brief, Claim, Confidence } from "./types";
import { forecastPaces, type ForecastCard } from "./forecast";
import { studyDayKey, DEFAULT_DAY_START_HOUR } from "@/lib/flashcards/studyDay";

/**
 * Tier 1 brief: everything the product can honestly say from flashcard
 * evidence alone.
 *
 * Every claim below is computed here and carries its own evidence. Nothing
 * downstream — including a language model asked to phrase these — is given
 * room to decide WHAT is true, only how to say it.
 */

const LEECH_LAPSES = 5;      // 99th percentile in the live bank; 1.8% of cards
const STALE_DAYS = 7;        // a deck unseen for a week with work piled up
const MIN_DECK_BLANKS = 20;  // below this a deck's medians are noise

interface StateRow {
  flashcard_id: string;
  cloze_index: number;
  stability: number | null;
  difficulty: number | null;
  fsrs_state: number | null;
  reps: number | null;
  lapses: number | null;
  interval_days: number | null;
  next_review_at: string | null;
  last_reviewed_at: string | null;
  suspended: boolean | null;
}

/** Every .range() loop needs a stable .order(); this table has no id column. */
async function loadState(db: SupabaseClient, userId: string): Promise<StateRow[]> {
  const out: StateRow[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await db
      .from("flashcard_user_state")
      .select("flashcard_id, cloze_index, stability, difficulty, fsrs_state, reps, lapses, interval_days, next_review_at, last_reviewed_at, suspended")
      .eq("user_id", userId)
      .order("flashcard_id", { ascending: true })
      .order("cloze_index", { ascending: true })
      .range(from, from + 999);
    if (error) throw new Error(error.message);
    if (!data.length) break;
    out.push(...(data as StateRow[]));
    if (data.length < 1000) break;
  }
  return out;
}

async function loadDeckTitles(db: SupabaseClient): Promise<Map<string, string>> {
  const cards: { id: string; deck_id: string }[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await db
      .from("flashcards")
      .select("id, deck_id")
      .order("id", { ascending: true })
      .range(from, from + 999);
    if (error) throw new Error(error.message);
    if (!data.length) break;
    cards.push(...data);
    if (data.length < 1000) break;
  }
  const { data: decks } = await db.from("flashcard_decks").select("id, title");
  const deckTitle = new Map((decks ?? []).map((d) => [d.id, d.title as string]));
  return new Map(cards.map((c) => [c.id, deckTitle.get(c.deck_id) ?? "Unknown deck"]));
}

const median = (xs: number[]): number => {
  if (!xs.length) return 0;
  const s = [...xs].sort((a, b) => a - b);
  return s[Math.floor(s.length / 2)];
};

export async function computeBrief(
  db: SupabaseClient,
  userId: string,
  dayStartHour = DEFAULT_DAY_START_HOUR,
): Promise<Brief> {
  const [state, cardDeck] = await Promise.all([loadState(db, userId), loadDeckTitles(db)]);
  const now = new Date();
  const live = state.filter((r) => !r.suspended);
  const claims: Claim[] = [];

  // A student who has barely started gets an honest "nothing to say yet"
  // rather than confident noise fitted to a handful of reviews.
  if (live.length < 50) {
    return {
      generatedAt: now.toISOString(),
      studyDay: studyDayKey(now, dayStartHour),
      insufficientEvidence: true,
      claims: [
        {
          kind: "no_evidence",
          priority: 0,
          confidence: "high",
          headline: "Not enough history yet to tell you anything useful.",
          detail: `You have ${live.length} cards in circulation. Once a few hundred have been reviewed there will be a real pattern to read.`,
          evidence: { cardsInCirculation: live.length, needed: 50 },
        },
      ],
    };
  }

  const isDue = (r: StateRow) => r.next_review_at !== null && new Date(r.next_review_at) <= now;
  const due = live.filter(isDue);
  const dueShare = due.length / live.length;

  // ── Backlog, and what any given pace actually buys ──────────────────────
  //
  // Only worth simulating when the queue is genuinely beyond a sitting. Below
  // that the answer is "do your reviews", which needs no forecast.
  if (dueShare > 0.25 && due.length > 200) {
    const forecastCards: ForecastCard[] = live.map((r) => ({
      stability: Number(r.stability ?? Math.max(r.interval_days ?? 1, 0.5)),
      difficulty: Number(r.difficulty ?? 7.6),
      state: r.fsrs_state ?? 2,
      reps: r.reps ?? 0,
      lapses: r.lapses ?? 0,
      intervalDays: Number(r.interval_days ?? 0),
      dueAt: r.next_review_at ? new Date(r.next_review_at) : now,
      lastReviewedAt: r.last_reviewed_at ? new Date(r.last_reviewed_at) : null,
    }));
    const paces = forecastPaces(forecastCards, 90);
    const clearing = paces.find((p) => p.clears);
    const atSixty = paces.find((p) => p.minutesPerDay === 60);

    // Once a queue clears, "still waiting after 90 days" stops measuring the
    // backlog and starts measuring ordinary daily churn — which does not fall
    // as study time rises, and can wobble upward, because more reviewing means
    // more cards cycling back. Reporting that as though it were backlog
    // produces the nonsense of "more study, more waiting". So the two cases are
    // distinguished, and the pace table is only shown when it is measuring the
    // thing it claims to.
    const clearsEvenAtLowest = paces[0]?.clears === true;

    if (clearsEvenAtLowest) {
      claims.push({
        kind: "backlog",
        priority: 0,
        confidence: "high",
        headline: `${due.length.toLocaleString()} cards are waiting, and that is recoverable.`,
        detail: `Simulated forward against your real cards, ${paces[0].minutesPerDay} minutes a day is enough to work this down and keep it down. What is left after that is ordinary daily turnover, not a backlog.`,
        evidence: {
          dueNow: due.length,
          cardsInCirculation: live.length,
          shareDue: Number((100 * dueShare).toFixed(1)),
          minutesPerDayThatClearsIt: paces[0].minutesPerDay,
        },
      });
    } else {
      claims.push({
        kind: "backlog",
        priority: 0,
        confidence: "high",
        headline: `${due.length.toLocaleString()} of your ${live.length.toLocaleString()} cards are waiting.`,
        detail: clearing
          ? `Simulated forward against your real cards, about ${clearing.minutesPerDay} minutes a day works this down over three months. At 60 minutes it stays near ${atSixty ? atSixty.dueAfter.toLocaleString() : "the same"}.`
          : `Simulated forward against your real cards, no realistic daily amount clears this in three months. That is a signal about how much material is in circulation, not about how hard you are working.`,
        evidence: {
          dueNow: due.length,
          cardsInCirculation: live.length,
          shareDue: Number((100 * dueShare).toFixed(1)),
          ...Object.fromEntries(paces.map((p) => [`dueAfter90dAt${p.minutesPerDay}min`, p.dueAfter])),
        },
      });

      claims.push({
        kind: "pace",
        priority: 1,
        confidence: "high",
        headline: "What each daily amount actually buys you.",
        detail: paces
          .map((p) => `${p.minutesPerDay} min: ${p.dueAfter.toLocaleString()} still waiting after 90 days`)
          .join(" · "),
        evidence: Object.fromEntries(
          paces.map((p) => [`${p.minutesPerDay}min`, `${p.dueAfter} due / ${p.knownAfter} known`]),
        ),
      });
    }
  }

  // ── Cards that keep failing ─────────────────────────────────────────────
  const leeches = live
    .filter((r) => (r.lapses ?? 0) >= LEECH_LAPSES)
    .sort((a, b) => (b.lapses ?? 0) - (a.lapses ?? 0));
  if (leeches.length > 0) {
    const byDeck = new Map<string, number>();
    for (const l of leeches) {
      const t = cardDeck.get(l.flashcard_id) ?? "Unknown deck";
      byDeck.set(t, (byDeck.get(t) ?? 0) + 1);
    }
    const worst = [...byDeck.entries()].sort((a, b) => b[1] - a[1]).slice(0, 3);
    claims.push({
      kind: "leech",
      priority: 2,
      confidence: leeches.length >= 20 ? "high" : "medium",
      headline: `${leeches.length} cards have failed ${LEECH_LAPSES} or more times.`,
      detail: `Concentrated in ${worst.map(([t, n]) => `${t} (${n})`).join(", ")}. Cards that keep collapsing usually need rewording or breaking up, not more repetitions.`,
      evidence: {
        leechCount: leeches.length,
        threshold: LEECH_LAPSES,
        worstLapseCount: leeches[0]?.lapses ?? 0,
        ...Object.fromEntries(worst.map(([t, n]) => [t, n])),
      },
    });
  }

  // ── Decks going cold ────────────────────────────────────────────────────
  const deckStats = new Map<string, { blanks: number; due: number; lastSeen: string | null }>();
  for (const r of live) {
    const t = cardDeck.get(r.flashcard_id);
    if (!t) continue;
    const s = deckStats.get(t) ?? { blanks: 0, due: 0, lastSeen: null };
    s.blanks++;
    if (isDue(r)) s.due++;
    if (r.last_reviewed_at && (!s.lastSeen || r.last_reviewed_at > s.lastSeen)) s.lastSeen = r.last_reviewed_at;
    deckStats.set(t, s);
  }
  const stale = [...deckStats.entries()]
    .filter(([, s]) => s.blanks >= MIN_DECK_BLANKS && s.lastSeen !== null)
    .map(([title, s]) => ({
      title,
      idleDays: Math.floor((now.getTime() - new Date(s.lastSeen as string).getTime()) / 86_400_000),
      due: s.due,
      blanks: s.blanks,
    }))
    .filter((d) => d.idleDays >= STALE_DAYS && d.due > 0)
    .sort((a, b) => b.idleDays - a.idleDays);
  if (stale.length > 0) {
    const top = stale[0];
    claims.push({
      kind: "stale_deck",
      priority: 3,
      confidence: "high",
      headline: `${top.title} has not been touched in ${top.idleDays} days.`,
      detail:
        stale.length > 1
          ? `${top.due} of its ${top.blanks} cards are waiting, and ${stale.length - 1} other ${stale.length === 2 ? "deck is" : "decks are"} drifting the same way.`
          : `${top.due} of its ${top.blanks} cards are waiting.`,
      evidence: {
        deck: top.title,
        idleDays: top.idleDays,
        dueInDeck: top.due,
        blanksInDeck: top.blanks,
        otherStaleDecks: stale.length - 1,
      },
    });
  }

  // ── Today ───────────────────────────────────────────────────────────────
  const neverStudied = live.filter((r) => (r.reps ?? 0) === 0).length;
  claims.push({
    kind: "today",
    priority: 4,
    confidence: "high",
    headline: due.length > 0 ? `${due.length.toLocaleString()} cards are ready for you now.` : "Nothing is due right now.",
    detail:
      due.length > 0
        ? `Work them in the order they come up; that ordering tested better than any rearrangement. ${neverStudied.toLocaleString()} cards in your decks have never been seen.`
        : `${neverStudied.toLocaleString()} cards have never been seen, if you want to move forward.`,
    evidence: { dueNow: due.length, neverStudied, cardsInCirculation: live.length },
  });

  return {
    generatedAt: now.toISOString(),
    studyDay: studyDayKey(now, dayStartHour),
    insufficientEvidence: false,
    claims: claims.sort((a, b) => a.priority - b.priority),
  };
}
