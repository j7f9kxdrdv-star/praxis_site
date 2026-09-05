"use client";

import { useEffect, useState, useMemo } from "react";
import Link from "next/link";
import { useDashboard } from "@/components/dashboard/DashboardShell";
import { supabase } from "@/lib/supabase";
import {
  PraxPage,
  PageHeader,
  SmallCaps,
  PraxCard,
} from "@/components/dashboard/PraxUI";

/* ─────────── Types ─────────── */

interface Attempt {
  is_correct: boolean;
  created_at: string;
  question_id: string;
  questions: { section: string; subtopic: string; difficulty: string } | null;
}

/** A deck IS a subtopic in the flashcard library: one deck per subtopic. */
interface DeckMeta {
  id: string;
  section: string | null;
  topic: string | null;
  subtopic: string | null;
  title: string;
}

interface DailyActivity {
  activity_date: string;
  questions_completed: number;
}

interface FlashReview {
  flashcard_id: string;
  cloze_index: number;
  rating: "again" | "hard" | "medium" | "easy";
  reviewed_at: string;
}

type Period = "7d" | "30d" | "all" | "custom";

const SECTION_LABELS: Record<string, string> = {
  bio_biochem: "Biology & Biochemistry",
  chem_phys: "Physical Sciences",
  psych_soc: "Behavioral Sciences",
  cars: "CARS (Reading)",
};

/* ─────────── Helpers ─────────── */

function estimateScoreRange(accuracy: number): [number, number] {
  if (accuracy >= 90) return [519, 520];
  if (accuracy >= 85) return [516, 519];
  if (accuracy >= 80) return [513, 516];
  if (accuracy >= 75) return [510, 513];
  if (accuracy >= 70) return [507, 510];
  if (accuracy >= 60) return [503, 507];
  if (accuracy > 0) return [498, 503];
  return [0, 0];
}

/**
 * Lower bound of the Wilson score interval for a proportion.
 *
 * Ranking subtopics by raw accuracy is wrong when the counts differ. A student
 * who got 1 of 3 wrong in a topic they barely touched would outrank a topic
 * they have failed 200 times, and the advice would send them at the noise. The
 * Wilson lower bound asks "how bad could this plausibly be, given how little we
 * have seen", so a small sample cannot jump the queue on the strength of a
 * couple of unlucky cards.
 */
function wilsonLowerBound(passed: number, total: number, z = 1.96): number {
  if (total <= 0) return 0;
  const p = passed / total;
  const denom = 1 + (z * z) / total;
  const centre = p + (z * z) / (2 * total);
  const margin = z * Math.sqrt((p * (1 - p) + (z * z) / (4 * total)) / total);
  return (centre - margin) / denom;
}

/**
 * How far below your own recall a subtopic has to sit before it is called out.
 *
 * Bands are RELATIVE, not absolute. A 61% subtopic is strong for a student
 * averaging 57% and mediocre for one averaging 80%, and the question this panel
 * answers is "where should I spend my time", which is a question about your own
 * distribution rather than about a fixed pass mark.
 */
/**
 * Display names for FLASHCARD deck sections.
 *
 * Separate from SECTION_LABELS, which covers the question bank and uses an
 * entirely different taxonomy: "bio_biochem" and "chem_phys" there against
 * "biology", "biochemistry", "chemistry" and "organic_chemistry" here. Reusing
 * that map left seven of the eight flashcard sections falling through to their
 * raw slug, so the panel read "organic chemistry" and "biochemistry" in
 * lowercase.
 *
 * The deck `topic` column cannot stand in for this: biology spans two topics
 * ("Molecular and Cellular Biology" and "Body Systems"), and psych_soc is
 * recorded inconsistently as both "Psych / Soc" and "Psych/Soc".
 */
const FLASH_SECTION_LABELS: Record<string, string> = {
  biology: "Biology",
  biochemistry: "Biochemistry",
  chemistry: "General Chemistry",
  organic_chemistry: "Organic Chemistry",
  physics: "Physics",
  psych_soc: "Behavioral Sciences",
  scientific_reasoning: "Scientific Reasoning",
};

/** Last resort for a section slug nobody has named yet. */
function flashSectionLabel(section: string): string {
  return (
    FLASH_SECTION_LABELS[section] ||
    section
      .replace(/_/g, " ")
      .replace(/\b\w/g, (c) => c.toUpperCase())
  );
}

const FLASH_BANDS = [
  { key: "focus", label: "Focus here", below: -8 },
  { key: "shaky", label: "Shaky", below: -3 },
  { key: "onpace", label: "On pace", below: 3 },
  { key: "strong", label: "Strong", below: Infinity },
] as const;

type FlashBand = (typeof FLASH_BANDS)[number];

function flashBandOf(delta: number): FlashBand {
  return FLASH_BANDS.find((b) => delta < b.below) ?? FLASH_BANDS[FLASH_BANDS.length - 1];
}

const FLASH_BAND_STYLE: Record<
  FlashBand["key"],
  { bar: string; pillBg: string; pillFg: string }
> = {
  focus: {
    bar: "var(--color-prax-gold)",
    pillBg: "var(--color-prax-gold)",
    pillFg: "var(--color-prax-cream)",
  },
  shaky: {
    bar: "var(--color-prax-gold-soft)",
    pillBg: "var(--color-prax-cream-deep)",
    pillFg: "var(--color-prax-ink-soft)",
  },
  onpace: {
    bar: "var(--color-prax-green-soft)",
    pillBg: "var(--color-prax-green-tint)",
    pillFg: "var(--color-prax-green)",
  },
  strong: {
    bar: "var(--color-prax-green)",
    pillBg: "var(--color-prax-green)",
    pillFg: "var(--color-prax-cream)",
  },
};

function buildSvgPath(points: [number, number][]): string {
  if (points.length === 0) return "";
  if (points.length === 1) return `M${points[0][0]},${points[0][1]}`;
  let d = `M${points[0][0]},${points[0][1]}`;
  for (let i = 1; i < points.length; i++) {
    const [x0, y0] = points[i - 1];
    const [x1, y1] = points[i];
    const cpx = (x0 + x1) / 2;
    d += ` C${cpx},${y0} ${cpx},${y1} ${x1},${y1}`;
  }
  return d;
}

function buildAreaPath(points: [number, number][], height: number): string {
  if (points.length === 0) return "";
  const line = buildSvgPath(points);
  const last = points[points.length - 1];
  const first = points[0];
  return `${line} L${last[0]},${height} L${first[0]},${height} Z`;
}

function filterByPeriod(
  attempts: Attempt[],
  period: Period,
  customFrom?: string,
  customTo?: string
): Attempt[] {
  if (period === "custom" && customFrom && customTo) {
    const from = new Date(customFrom + "T00:00:00");
    const to = new Date(customTo + "T23:59:59");
    return attempts.filter((a) => {
      const d = new Date(a.created_at);
      return d >= from && d <= to;
    });
  }
  if (period === "all") return attempts;
  const now = new Date();
  const cutoff = new Date(now);
  cutoff.setDate(now.getDate() - (period === "7d" ? 7 : 30));
  return attempts.filter((a) => new Date(a.created_at) >= cutoff);
}

/* ─────────── Donut Ring ─────────── */

function DonutRing({ pct, label }: { pct: number; label: string }) {
  const r = 36;
  const circ = 2 * Math.PI * r;
  const offset = circ * (1 - pct / 100);
  return (
    <div className="flex flex-col items-center gap-3">
      <div className="relative w-24 h-24">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 88 88">
          <circle
            cx="44"
            cy="44"
            r={r}
            fill="none"
            stroke="var(--color-prax-cream-border)"
            strokeWidth="8"
          />
          <circle
            cx="44"
            cy="44"
            r={r}
            fill="none"
            stroke="var(--color-prax-green)"
            strokeWidth="8"
            strokeLinecap="round"
            strokeDasharray={circ}
            strokeDashoffset={offset}
            style={{ transition: "stroke-dashoffset 1s ease-out" }}
          />
        </svg>
        <span
          className="absolute inset-0 flex items-center justify-center font-medium"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 24,
            color: "var(--color-prax-green)",
            fontVariantNumeric: "tabular-nums lining-nums",
          }}
        >
          {pct > 0 ? `${pct}%` : "—"}
        </span>
      </div>
      <SmallCaps>{label}</SmallCaps>
    </div>
  );
}

/* ─────────── Performance panel ─────────── */

function PerfPanel({
  title,
  period,
  pct,
  stats,
  breakdownLabel,
  bars,
  empty,
  emptyText,
}: {
  title: string;
  period: string;
  pct: number;
  stats: { value: string; label: string }[];
  breakdownLabel: string;
  bars: { label: string; count: number; pct: number; color: string }[];
  empty: boolean;
  emptyText: string;
}) {
  return (
    <PraxCard variant="secondary" className="flex flex-col">
      <div className="flex items-center justify-between mb-5">
        <SmallCaps>{title}</SmallCaps>
        <SmallCaps style={{ color: "var(--color-prax-ink-soft)" }}>
          {period}
        </SmallCaps>
      </div>
      {empty ? (
        <div
          className="italic text-center py-8"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 13,
            color: "var(--color-prax-ink-mute)",
          }}
        >
          {emptyText}
        </div>
      ) : (
        <>
          <div className="flex items-center gap-5">
            <DonutRing pct={pct} label="First-Try" />
            <div className="flex-1 space-y-3">
              {stats.map((s) => (
                <div key={s.label}>
                  <div
                    style={{
                      fontFamily: "var(--font-prax-serif)",
                      fontSize: 20,
                      lineHeight: 1,
                      color: "var(--color-prax-green)",
                      fontVariantNumeric: "tabular-nums lining-nums",
                    }}
                  >
                    {s.value}
                  </div>
                  <SmallCaps style={{ marginTop: 3 }}>{s.label}</SmallCaps>
                </div>
              ))}
            </div>
          </div>
          <div
            className="mt-5 pt-5"
            style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
          >
            <SmallCaps
              style={{
                color: "var(--color-prax-ink-soft)",
                marginBottom: 14,
                display: "block",
              }}
            >
              {breakdownLabel}
            </SmallCaps>
            <div className="space-y-4">
              {bars.map((b) => (
                <div key={b.label}>
                  <div className="flex justify-between items-baseline mb-1.5">
                    <div
                      style={{
                        fontFamily: "var(--font-prax-sans)",
                        fontSize: 12.5,
                        fontWeight: 500,
                        color: "var(--color-prax-ink)",
                      }}
                    >
                      {b.label}
                    </div>
                    <div
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 16,
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {b.count.toLocaleString()}
                      <span
                        style={{
                          fontSize: 12,
                          color: "var(--color-prax-ink-mute)",
                        }}
                      >
                        {" "}
                        · {b.pct}%
                      </span>
                    </div>
                  </div>
                  <div
                    className="rounded-full overflow-hidden"
                    style={{
                      height: 5,
                      background: "var(--color-prax-cream-card)",
                    }}
                  >
                    <div
                      className="h-full rounded-full transition-all duration-1000"
                      style={{ width: `${b.pct}%`, background: b.color }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </PraxCard>
  );
}

/* ─────────── Page ─────────── */

export default function AnalyticsPage() {
  const { user } = useDashboard();
  const [allAttempts, setAllAttempts] = useState<Attempt[]>([]);
  const [allReviews, setAllReviews] = useState<FlashReview[]>([]);
  const [, setActivity] = useState<DailyActivity[]>([]);
  const [, setLessonsCompleted] = useState(0);
  const [loading, setLoading] = useState(true);
  const [period, setPeriod] = useState<Period>("30d");
  const [chartSection, setChartSection] = useState<string>("all");
  const [sectionDropdownOpen, setSectionDropdownOpen] = useState(false);
  // Flashcard taxonomy. Fetched as two small lookups rather than joined onto
  // every review row: the card list is ~4k rows and the deck list ~70, against
  // tens of thousands of reviews that would each drag a copy of the taxonomy.
  const [openFlashSections, setOpenFlashSections] = useState<Set<string>>(
    new Set()
  );
  const [cardToDeck, setCardToDeck] = useState<Map<string, string>>(new Map());
  const [deckMeta, setDeckMeta] = useState<Map<string, DeckMeta>>(new Map());
  const [customFrom, setCustomFrom] = useState("");
  const [customTo, setCustomTo] = useState("");

  const [hasDailyReport, setHasDailyReport] = useState(false);
  const [hasWeeklyReport, setHasWeeklyReport] = useState(false);

  useEffect(() => {
    async function load() {
      const [
        { data: attempts },
        { data: act },
        { data: progress },
        { data: reviews },
      ] = await Promise.all([
        supabase
          .from("question_attempts")
          .select(
            "is_correct, created_at, question_id, questions(section, subtopic, difficulty)"
          )
          .eq("user_id", user.id),
        supabase
          .from("daily_activity")
          .select("activity_date, questions_completed")
          .eq("user_id", user.id)
          .order("activity_date"),
        supabase
          .from("lesson_progress")
          .select("id")
          .eq("user_id", user.id)
          .eq("completed", true),
        // Page through the FULL review history. A single query caps at 1000
        // rows and the old `.limit(5000)` dropped everything older than the
        // most recent 5000 — which broke the "full chronological history"
        // first-look math and undercounted all-time totals for heavy users.
        // Order by time then unique `id` so pages are stable.
        (async () => {
          const all: FlashReview[] = [];
          const PAGE = 1000;
          for (let from = 0; ; from += PAGE) {
            const { data, error } = await supabase
              .from("flashcard_reviews")
              .select("flashcard_id, cloze_index, rating, reviewed_at")
              .eq("user_id", user.id)
              .order("reviewed_at", { ascending: false })
              .order("id", { ascending: false })
              .range(from, from + PAGE - 1);
            if (error || !data) break;
            all.push(...(data as unknown as FlashReview[]));
            if (data.length < PAGE) break;
          }
          return { data: all };
        })(),
      ]);

      // Card -> deck, and deck -> subtopic. Paged, because the card table is
      // larger than a single Supabase response.
      const cards: { id: string; deck_id: string }[] = [];
      for (let from = 0; ; from += 1000) {
        const { data, error } = await supabase
          .from("flashcards")
          .select("id, deck_id")
          .order("id", { ascending: true })
          .range(from, from + 999);
        if (error || !data) break;
        cards.push(...(data as { id: string; deck_id: string }[]));
        if (data.length < 1000) break;
      }
      const { data: deckRows } = await supabase
        .from("flashcard_decks")
        .select("id, section, topic, subtopic, title");
      setCardToDeck(new Map(cards.map((c) => [c.id, c.deck_id])));
      setDeckMeta(
        new Map(
          ((deckRows as DeckMeta[]) || []).map((d) => [d.id, d])
        )
      );

      setAllAttempts((attempts as unknown as Attempt[]) || []);
      setActivity(act || []);
      setLessonsCompleted(progress?.length || 0);
      setAllReviews((reviews as unknown as FlashReview[]) || []);

      setLoading(false);
    }
    load();
  }, [user.id]);

  // Check whether saved reports exist (for badge display)
  useEffect(() => {
    async function checkReports() {
      const { data } = await supabase
        .from("performance_reports")
        .select("report_type")
        .eq("user_id", user.id)
        .order("created_at", { ascending: false })
        .limit(10);
      const rows = (data ?? []) as { report_type: string }[];
      setHasDailyReport(rows.some((r) => r.report_type === "daily"));
      setHasWeeklyReport(rows.some((r) => r.report_type === "weekly"));
    }
    checkReports();
  }, [user.id]);

  // ── Derived stats ──
  const filtered = useMemo(
    () => filterByPeriod(allAttempts, period, customFrom, customTo),
    [allAttempts, period, customFrom, customTo]
  );

  const totalQuestions = filtered.length;
  const totalCorrect = filtered.filter((a) => a.is_correct).length;
  const overallAccuracy =
    totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 100) : 0;
  const [scoreLow, scoreHigh] = estimateScoreRange(overallAccuracy);

  // Section stats
  const sectionStats = useMemo(() => {
    const map = new Map<string, { total: number; correct: number }>();
    filtered.forEach((a) => {
      if (!a.questions) return;
      const sec = map.get(a.questions.section) || { total: 0, correct: 0 };
      sec.total++;
      if (a.is_correct) sec.correct++;
      map.set(a.questions.section, sec);
    });
    return ["bio_biochem", "chem_phys", "psych_soc", "cars"]
      .filter((s) => map.has(s))
      .map((s) => {
        const d = map.get(s)!;
        return {
          section: s,
          label: SECTION_LABELS[s],
          ...d,
          accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0,
        };
      });
  }, [filtered]);

  // Difficulty stats
  const diffStats = useMemo(() => {
    const map = new Map<string, { total: number; correct: number }>();
    filtered.forEach((a) => {
      if (!a.questions?.difficulty) return;
      const d = map.get(a.questions.difficulty) || { total: 0, correct: 0 };
      d.total++;
      if (a.is_correct) d.correct++;
      map.set(a.questions.difficulty, d);
    });
    return ["easy", "medium", "hard"].map((k) => {
      const d = map.get(k) || { total: 0, correct: 0 };
      return {
        label: k.charAt(0).toUpperCase() + k.slice(1),
        ...d,
        accuracy: d.total > 0 ? Math.round((d.correct / d.total) * 100) : 0,
      };
    });
  }, [filtered]);

  // Subtopic stats (weakest first)
  const subtopicStats = useMemo(() => {
    const map = new Map<
      string,
      { section: string; subtopic: string; total: number; correct: number }
    >();
    filtered.forEach((a) => {
      if (!a.questions) return;
      const key = `${a.questions.section}::${a.questions.subtopic}`;
      const s = map.get(key) || {
        section: a.questions.section,
        subtopic: a.questions.subtopic,
        total: 0,
        correct: 0,
      };
      s.total++;
      if (a.is_correct) s.correct++;
      map.set(key, s);
    });
    return Array.from(map.values())
      .filter((s) => s.total >= 3)
      .map((s) => ({ ...s, accuracy: Math.round((s.correct / s.total) * 100) }))
      .sort((a, b) => a.accuracy - b.accuracy);
  }, [filtered]);

  const weakestTopic = subtopicStats[0];

  /**
   * Which flashcard subtopics is this student actually weak on?
   *
   * Two decisions worth stating, because both change the answer:
   *
   * 1. ONE ATTEMPT PER BLANK PER DAY. Rating a card "Again" re-queues it inside
   *    the same session, so a card that was struggled with logs several rows.
   *    Counting all of them would score a topic by how stubbornly it was
   *    revisited rather than by how well it is known. Only the first rating of
   *    each blank on each day counts.
   *
   * 2. RANKED BY WILSON LOWER BOUND, not by raw accuracy, so a topic with a
   *    handful of attempts cannot lead the list on a couple of unlucky cards.
   *
   * The figure shown is the student's own accuracy against their own average,
   * because "eleven points below your baseline" is actionable in a way that a
   * bare percentage is not: it separates a topic that is genuinely lagging from
   * one that merely looks low because everything is hard this week.
   */
  const flashTopicStats = useMemo(() => {
    const MIN_ATTEMPTS = 10;
    const seen = new Set<string>();
    const map = new Map<
      string,
      {
        deckId: string;
        section: string;
        subtopic: string;
        label: string;
        attempts: number;
        passed: number;
      }
    >();

    // Oldest first, so "first attempt of the day" really is the first one.
    const ordered = [...allReviews].sort((a, b) =>
      a.reviewed_at < b.reviewed_at ? -1 : a.reviewed_at > b.reviewed_at ? 1 : 0
    );

    for (const r of ordered) {
      const deckId = cardToDeck.get(r.flashcard_id);
      if (!deckId) continue;
      const deck = deckMeta.get(deckId);
      if (!deck) continue;

      const day = (r.reviewed_at || "").slice(0, 10);
      const once = `${r.flashcard_id}::${r.cloze_index}::${day}`;
      if (seen.has(once)) continue;
      seen.add(once);

      // Group on the SLUG, display the TITLE. The title column is already
      // curated ("Carbohydrate Metabolism II", "DNA and Biotechnology"), while
      // the slug needs a formatter that would have to know about roman numerals
      // and acronyms to produce the same thing, and would still get
      // "Aldehydes And Ketones Ii" wrong. The slugs are also inconsistent, some
      // separated by underscores and some by spaces, so they are unfit to show.
      // Every column here is nullable, hence the chain.
      const subtopic = deck.subtopic || deck.topic || deck.title || "Untitled deck";
      const label = deck.title || deck.subtopic || deck.topic || "Untitled deck";
      const key = `${deck.section ?? "other"}::${subtopic}`;
      const row =
        map.get(key) || {
          deckId,
          section: deck.section ?? "other",
          subtopic,
          label,
          attempts: 0,
          passed: 0,
        };
      row.attempts++;
      if (r.rating !== "again") row.passed++;
      map.set(key, row);
    }

    const rows = Array.from(map.values());
    const totalAttempts = rows.reduce((a, r) => a + r.attempts, 0);
    const totalPassed = rows.reduce((a, r) => a + r.passed, 0);
    const baseline = totalAttempts > 0 ? totalPassed / totalAttempts : 0;

    const scored = rows
      .filter((r) => r.attempts >= MIN_ATTEMPTS)
      .map((r) => ({
        ...r,
        accuracy: Math.round((r.passed / r.attempts) * 100),
        floor: wilsonLowerBound(r.passed, r.attempts),
        delta: Math.round((r.passed / r.attempts - baseline) * 100),
      }));

    // Grouped by section, because a flat weakest-first list cannot tell two
    // very different situations apart. Organic Chemistry sits exactly at this
    // student's average while holding both their worst subtopic and five of
    // their best: the fix is two decks. Behavioral Sciences is six points down
    // with nothing strong anywhere in it: the fix is the whole subject. Flat,
    // both look identical, because only the failing subtopics are visible.
    const groups = new Map<
      string,
      { section: string; attempts: number; passed: number; subs: typeof scored }
    >();
    for (const r of scored) {
      const g =
        groups.get(r.section) || {
          section: r.section,
          attempts: 0,
          passed: 0,
          subs: [] as typeof scored,
        };
      g.attempts += r.attempts;
      g.passed += r.passed;
      g.subs.push(r);
      groups.set(r.section, g);
    }

    const sections = Array.from(groups.values())
      .map((g) => ({
        section: g.section,
        attempts: g.attempts,
        accuracy: Math.round((g.passed / g.attempts) * 100),
        delta: Math.round((g.passed / g.attempts - baseline) * 100),
        // Weakest first inside a section too, on the Wilson floor rather than
        // raw accuracy.
        subs: [...g.subs].sort((a, b) => a.floor - b.floor),
        focusCount: g.subs.filter((s) => flashBandOf(s.delta).key === "focus")
          .length,
      }))
      .sort((a, b) => a.accuracy - b.accuracy);

    return {
      sections,
      subtopicCount: scored.length,
      baseline: Math.round(baseline * 100),
      // Subtopics that exist but have not been studied enough to judge.
      // Reported rather than hidden, so the list is not silently incomplete.
      tooFewCount: rows.filter((r) => r.attempts < MIN_ATTEMPTS).length,
      minAttempts: MIN_ATTEMPTS,
    };
  }, [allReviews, cardToDeck, deckMeta]);

  // ── Flashcard recall stats (from review history) ──
  const flashStats = useMemo(() => {
    const inPeriod = (iso: string): boolean => {
      if (period === "all") return true;
      const d = new Date(iso);
      if (period === "custom") {
        if (!customFrom || !customTo) return true;
        return (
          d >= new Date(customFrom + "T00:00:00") &&
          d <= new Date(customTo + "T23:59:59")
        );
      }
      const cutoff = new Date();
      cutoff.setDate(cutoff.getDate() - (period === "7d" ? 7 : 30));
      return d >= cutoff;
    };

    const counts = { again: 0, hard: 0, medium: 0, easy: 0 };
    let total = 0;

    // "First-try" = the first time a card is seen in a study session. A card
    // re-queued after "Again" recurs within minutes, so a gap larger than
    // SESSION_GAP_MS marks a genuine new look. First-look is computed over the
    // FULL chronological history (so a period boundary can't turn a same-session
    // repeat into a false first look); only in-period first looks are tallied.
    const SESSION_GAP_MS = 30 * 60 * 1000;
    const lastSeen = new Map<string, number>();
    const chron = [...allReviews].sort(
      (a, b) =>
        new Date(a.reviewed_at).getTime() - new Date(b.reviewed_at).getTime()
    );
    let firstTryTotal = 0;
    let firstTryCorrect = 0;

    chron.forEach((r) => {
      const key = `${r.flashcard_id}:${r.cloze_index}`;
      const t = new Date(r.reviewed_at).getTime();
      const prev = lastSeen.get(key);
      const isFirstLook = prev === undefined || t - prev > SESSION_GAP_MS;
      lastSeen.set(key, t);

      if (!inPeriod(r.reviewed_at)) return;
      total++;
      counts[r.rating]++;
      if (isFirstLook) {
        firstTryTotal++;
        if (r.rating !== "again") firstTryCorrect++;
      }
    });

    return {
      total,
      counts,
      againCount: counts.again,
      firstTryTotal,
      firstTryCorrect,
      firstTryPct:
        firstTryTotal > 0
          ? Math.round((firstTryCorrect / firstTryTotal) * 100)
          : null,
    };
  }, [allReviews, period, customFrom, customTo]);

  // ── Question first-try accuracy (first attempt per question) ──
  const qStats = useMemo(() => {
    const inPeriod = (ms: number): boolean => {
      if (period === "all") return true;
      if (period === "custom") {
        if (!customFrom || !customTo) return true;
        return (
          ms >= new Date(customFrom + "T00:00:00").getTime() &&
          ms <= new Date(customTo + "T23:59:59").getTime()
        );
      }
      const cutoff = new Date();
      cutoff.setDate(cutoff.getDate() - (period === "7d" ? 7 : 30));
      return ms >= cutoff.getTime();
    };
    // Earliest attempt per question over full history; a question's first-try
    // is tallied only if that first attempt falls inside the selected period.
    const firstByQ = new Map<string, { at: number; correct: boolean }>();
    allAttempts.forEach((a) => {
      if (!a.question_id) return;
      const t = new Date(a.created_at).getTime();
      const cur = firstByQ.get(a.question_id);
      if (!cur || t < cur.at)
        firstByQ.set(a.question_id, { at: t, correct: a.is_correct });
    });
    let firstTryTotal = 0;
    let firstTryCorrect = 0;
    firstByQ.forEach((v) => {
      if (!inPeriod(v.at)) return;
      firstTryTotal++;
      if (v.correct) firstTryCorrect++;
    });
    return {
      firstTryTotal,
      firstTryCorrect,
      firstTryPct:
        firstTryTotal > 0
          ? Math.round((firstTryCorrect / firstTryTotal) * 100)
          : null,
    };
  }, [allAttempts, period, customFrom, customTo]);

  // Weekly accuracy chart
  const { chartPoints, chartWeekLabels } = useMemo(() => {
    const empty = {
      chartPoints: [] as [number, number][],
      chartWeekLabels: [] as string[],
    };
    if (allAttempts.length === 0) return empty;

    const src =
      chartSection === "all"
        ? allAttempts
        : allAttempts.filter((a) => a.questions?.section === chartSection);

    if (src.length === 0) return empty;

    const weekMap = new Map<string, { total: number; correct: number }>();
    src.forEach((a) => {
      const d = new Date(a.created_at);
      const day = d.getDay();
      const mon = new Date(d);
      mon.setDate(d.getDate() - ((day + 6) % 7));
      const key = mon.toISOString().split("T")[0];
      const w = weekMap.get(key) || { total: 0, correct: 0 };
      w.total++;
      if (a.is_correct) w.correct++;
      weekMap.set(key, w);
    });

    const weeks = Array.from(weekMap.entries())
      .sort(([a], [b]) => a.localeCompare(b))
      .filter(([, w]) => w.total >= 5);

    if (weeks.length === 0) return empty;

    const X_START = 0,
      X_END = 1000,
      Y_TOP = 20,
      Y_BOT = 280;
    const points: [number, number][] = weeks.map(([, w], i) => {
      const acc = (w.correct / w.total) * 100;
      const x =
        weeks.length === 1
          ? (X_START + X_END) / 2
          : X_START + (i / (weeks.length - 1)) * (X_END - X_START);
      const y = Y_BOT - (acc / 100) * (Y_BOT - Y_TOP);
      return [x, y];
    });

    const labels = weeks.map(([key]) =>
      new Date(key + "T00:00:00").toLocaleDateString("en-US", {
        month: "short",
        day: "numeric",
      })
    );

    return { chartPoints: points, chartWeekLabels: labels };
  }, [allAttempts, chartSection]);

  const linePath = buildSvgPath(chartPoints);
  const areaPath = buildAreaPath(chartPoints, 280);

  /* ─────────── Loading ─────────── */
  if (loading) {
    return (
      <PraxPage bgVariant="study">
        <div className="flex items-center justify-center min-h-[60vh]">
          <div
            className="w-8 h-8 border-2 rounded-full animate-spin"
            style={{
              borderColor: "var(--color-prax-green)",
              borderTopColor: "transparent",
            }}
          />
        </div>
      </PraxPage>
    );
  }

  /* ─────────── Render ─────────── */

  // Period selector — shared across header
  const periodSelector = (
    <div className="flex flex-col sm:flex-row sm:items-center gap-3 self-start sm:self-auto">
      {/* Preset tabs */}
      <div
        className="flex items-center p-1 rounded-full gap-1"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        {(["7d", "30d", "all"] as Period[]).map((p) => (
          <button
            key={p}
            onClick={() => {
              setPeriod(p);
              setCustomFrom("");
              setCustomTo("");
            }}
            className="px-3.5 py-1.5 font-semibold uppercase rounded-full transition-all"
            style={{
              fontSize: 10,
              letterSpacing: "0.16em",
              background:
                period === p ? "var(--color-prax-green)" : "transparent",
              color:
                period === p
                  ? "var(--color-prax-cream)"
                  : "var(--color-prax-ink-mute)",
              cursor: "pointer",
            }}
          >
            {p === "7d" ? "Week" : p === "30d" ? "30 Days" : "All Time"}
          </button>
        ))}
      </div>

      {/* Custom date range */}
      <div
        className="flex items-center p-1 rounded-full gap-1"
        style={{
          background: "var(--color-prax-cream-card)",
          border: "1px solid var(--color-prax-cream-border)",
        }}
      >
        <input
          type="date"
          value={customFrom}
          onChange={(e) => {
            setCustomFrom(e.target.value);
            if (e.target.value) setPeriod("custom");
          }}
          className="px-3 py-1.5 rounded-full border-0 outline-none cursor-pointer"
          style={{
            fontSize: 10,
            fontWeight: 600,
            color: "var(--color-prax-ink)",
            background: "transparent",
          }}
        />
        <span
          className="px-1"
          style={{ color: "var(--color-prax-ink-mute)", fontSize: 11 }}
        >
          to
        </span>
        <input
          type="date"
          value={customTo}
          min={customFrom || undefined}
          onChange={(e) => {
            setCustomTo(e.target.value);
            if (e.target.value) setPeriod("custom");
          }}
          className="px-3 py-1.5 rounded-full border-0 outline-none cursor-pointer"
          style={{
            fontSize: 10,
            fontWeight: 600,
            color: "var(--color-prax-ink)",
            background: "transparent",
          }}
        />
      </div>
    </div>
  );

  const periodLabel =
    period === "7d"
      ? "Last week"
      : period === "30d"
      ? "Last 30 days"
      : period === "custom" && customFrom && customTo
      ? `${customFrom} to ${customTo}`
      : "All time";

  return (
    <PraxPage bgVariant="study">
      <PageHeader
        eyebrow="Diagnostic · Performance Intelligence"
        title="Performance."
        subtitle="Where your accuracy lives, where to push, what to fix next."
        right={periodSelector}
      />

      {/* ── Top bento — Accuracy / Questions / Score Estimate ── */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-5 mb-6">
        {/* Overall Question Accuracy */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>Overall Question Accuracy</SmallCaps>
            <svg
              className="opacity-60"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="var(--color-prax-green)"
              strokeWidth={1.6}
            >
              <polyline points="23 6 13.5 15.5 8.5 10.5 1 18" />
              <polyline points="17 6 23 6 23 12" />
            </svg>
          </div>
          <div className="flex items-baseline gap-1">
            <div
              className="leading-none font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 48,
                color: "var(--color-prax-green)",
                fontVariantNumeric: "tabular-nums lining-nums",
              }}
            >
              {totalQuestions > 0 ? overallAccuracy : "—"}
            </div>
            {totalQuestions > 0 && (
              <div
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-ink-soft)",
                  fontStyle: "italic",
                }}
              >
                %
              </div>
            )}
          </div>
          <div
            className="mt-3"
            style={{
              fontSize: 11.5,
              color: "var(--color-prax-ink-mute)",
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {totalCorrect} of {totalQuestions} correct
          </div>
        </PraxCard>

        {/* Overall Flashcard Accuracy */}
        <PraxCard variant="secondary">
          <div className="flex justify-between items-start mb-3">
            <SmallCaps>Overall Flashcard Accuracy</SmallCaps>
            <svg
              className="opacity-60"
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="var(--color-prax-green)"
              strokeWidth={1.6}
            >
              <polygon points="12 2 2 7 12 12 22 7 12 2" />
              <polyline points="2 17 12 22 22 17" />
              <polyline points="2 12 12 17 22 12" />
            </svg>
          </div>
          <div className="flex items-baseline gap-1">
            <div
              className="leading-none font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 48,
                color: "var(--color-prax-green)",
                fontVariantNumeric: "tabular-nums lining-nums",
              }}
            >
              {flashStats.firstTryTotal > 0 ? flashStats.firstTryPct : "—"}
            </div>
            {flashStats.firstTryTotal > 0 && (
              <div
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-ink-soft)",
                  fontStyle: "italic",
                }}
              >
                %
              </div>
            )}
          </div>
          <div
            className="mt-3"
            style={{
              fontSize: 11.5,
              color: "var(--color-prax-ink-mute)",
              fontVariantNumeric: "tabular-nums",
            }}
          >
            {flashStats.firstTryCorrect} of {flashStats.firstTryTotal} on first
            try
          </div>
        </PraxCard>

        {/* Score Estimate — primary green card */}
        <PraxCard variant="primary" className="overflow-hidden">
          <svg
            className="absolute opacity-15"
            style={{ right: -40, top: -50 }}
            width="200"
            height="200"
            viewBox="0 0 200 200"
            aria-hidden
          >
            <g
              fill="none"
              stroke="var(--color-prax-cream)"
              strokeWidth="0.8"
            >
              <circle cx="100" cy="100" r="80" />
              <circle cx="100" cy="100" r="55" />
              <circle cx="100" cy="100" r="30" />
            </g>
          </svg>
          <div className="relative">
            <div className="flex justify-between items-start mb-3">
              <SmallCaps style={{ color: "var(--color-prax-gold-soft)" }}>
                Est. Score Range
              </SmallCaps>
              <svg
                width="18"
                height="18"
                viewBox="0 0 24 24"
                fill="var(--color-prax-gold-soft)"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>
            </div>
            {totalQuestions > 0 ? (
              <div className="flex items-baseline gap-2">
                <div
                  className="leading-none font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 44,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {scoreLow}
                </div>
                <div
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 22,
                    color: "rgba(246,244,227,0.5)",
                  }}
                >
                  to
                </div>
                <div
                  className="leading-none font-medium"
                  style={{
                    fontFamily: "var(--font-prax-serif)",
                    fontSize: 44,
                    color: "var(--color-prax-cream)",
                    fontVariantNumeric: "tabular-nums lining-nums",
                  }}
                >
                  {scoreHigh}
                </div>
              </div>
            ) : (
              <div
                className="font-medium italic"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 24,
                  color: "rgba(246,244,227,0.5)",
                }}
              >
                No data yet
              </div>
            )}
            <div className="mt-4">
              <div
                className="rounded-full overflow-hidden"
                style={{ height: 5, background: "rgba(246,244,227,0.18)" }}
              >
                <div
                  className="h-full rounded-full transition-all duration-1000"
                  style={{
                    width: `${Math.min(overallAccuracy, 100)}%`,
                    background: "var(--color-prax-gold-soft)",
                  }}
                />
              </div>
              <div
                className="flex justify-between mt-2"
                style={{
                  fontSize: 9.5,
                  letterSpacing: "0.16em",
                  textTransform: "uppercase",
                  color: "rgba(246,244,227,0.55)",
                  fontWeight: 600,
                }}
              >
                <span>Based on accuracy</span>
                <span>Target 520</span>
              </div>
            </div>
          </div>
        </PraxCard>
      </div>

      {/* ── Performance panels (Questions | Flashcards) ── */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-6">
        <PerfPanel
          title="Questions"
          period={periodLabel}
          pct={qStats.firstTryPct ?? 0}
          stats={[
            {
              value: `${qStats.firstTryCorrect}/${qStats.firstTryTotal}`,
              label: "Correct on first try",
            },
            { value: totalQuestions.toLocaleString(), label: "Total attempts" },
          ]}
          breakdownLabel="By difficulty"
          bars={diffStats.map((d, i) => ({
            label: d.label,
            count: d.correct,
            pct: d.accuracy,
            color:
              i === 0
                ? "var(--color-prax-green)"
                : i === 1
                ? "var(--color-prax-green-soft)"
                : "var(--color-prax-gold)",
          }))}
          empty={qStats.firstTryTotal === 0}
          emptyText="Answer questions to see your first-try accuracy."
        />
        <PerfPanel
          title="Flashcards"
          period={periodLabel}
          pct={flashStats.firstTryPct ?? 0}
          stats={[
            {
              value: `${flashStats.firstTryCorrect}/${flashStats.firstTryTotal}`,
              label: "Passed on first look",
            },
            { value: flashStats.total.toLocaleString(), label: "Total reviews" },
          ]}
          breakdownLabel="Grade breakdown"
          bars={[
            {
              label: "Again",
              count: flashStats.counts.again,
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.again / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-gold)",
            },
            {
              label: "Hard",
              count: flashStats.counts.hard,
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.hard / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-ink-soft)",
            },
            {
              label: "Medium",
              count: flashStats.counts.medium,
              pct:
                flashStats.total > 0
                  ? Math.round(
                      (flashStats.counts.medium / flashStats.total) * 100
                    )
                  : 0,
              color: "var(--color-prax-green-soft)",
            },
            {
              label: "Easy",
              count: flashStats.counts.easy,
              pct:
                flashStats.total > 0
                  ? Math.round((flashStats.counts.easy / flashStats.total) * 100)
                  : 0,
              color: "var(--color-prax-green)",
            },
          ]}
          empty={flashStats.total === 0}
          emptyText="Study flashcards to see your recall analytics."
        />
      </div>

      {/* ── Accuracy Over Time chart ── */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-start justify-between mb-6 gap-4">
          <div>
            <div
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Accuracy over time
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              Weekly · weeks with &lt;5 questions excluded
            </SmallCaps>
          </div>

          {/* Section filter dropdown */}
          <div className="relative shrink-0">
            <button
              onClick={() => setSectionDropdownOpen((v) => !v)}
              className="flex items-center gap-2 px-3.5 py-2 rounded-full"
              style={{
                background: "var(--color-prax-cream-card)",
                border: "1px solid var(--color-prax-cream-border)",
                fontSize: 10,
                fontWeight: 600,
                letterSpacing: "0.16em",
                textTransform: "uppercase",
                color: "var(--color-prax-green)",
                cursor: "pointer",
              }}
            >
              <span>
                {chartSection === "all"
                  ? "All Subjects"
                  : SECTION_LABELS[chartSection] ?? chartSection}
              </span>
              <svg
                width="10"
                height="10"
                fill="none"
                stroke="currentColor"
                strokeWidth={2.5}
                viewBox="0 0 24 24"
                style={{
                  transform: sectionDropdownOpen ? "rotate(180deg)" : "none",
                  transition: "transform 0.2s",
                }}
              >
                <path
                  d="M6 9l6 6 6-6"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </button>
            {sectionDropdownOpen && (
              <div
                className="absolute right-0 top-full mt-2 z-20 overflow-hidden"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                  borderRadius: 12,
                  minWidth: 180,
                  boxShadow: "0 8px 32px -10px rgba(3,56,48,0.15)",
                }}
              >
                {[
                  { value: "all", label: "All Subjects" },
                  { value: "bio_biochem", label: "Biology & Biochem" },
                  { value: "chem_phys", label: "Physical Sciences" },
                  { value: "psych_soc", label: "Behavioral Sciences" },
                  { value: "cars", label: "CARS (Reading)" },
                ].map(({ value, label }) => (
                  <button
                    key={value}
                    onClick={() => {
                      setChartSection(value);
                      setSectionDropdownOpen(false);
                    }}
                    className="w-full text-left px-4 py-2.5"
                    style={{
                      fontSize: 10,
                      fontWeight: 600,
                      letterSpacing: "0.14em",
                      textTransform: "uppercase",
                      background:
                        chartSection === value
                          ? "var(--color-prax-green)"
                          : "transparent",
                      color:
                        chartSection === value
                          ? "var(--color-prax-cream)"
                          : "var(--color-prax-green)",
                      cursor: "pointer",
                    }}
                  >
                    {label}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>

        {chartPoints.length < 2 ? (
          <div
            className="h-48 flex items-center justify-center italic"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 14,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Complete more sessions to see your accuracy chart.
          </div>
        ) : (
          <div className="flex gap-3">
            <div
              className="flex flex-col justify-between shrink-0 w-8 text-right"
              style={{ height: 220 }}
            >
              {["100%", "75%", "50%", "25%", "0%"].map((label) => (
                <span
                  key={label}
                  style={{
                    fontSize: 9,
                    fontWeight: 600,
                    letterSpacing: "0.1em",
                    color: "var(--color-prax-ink-mute)",
                    fontVariantNumeric: "tabular-nums",
                    lineHeight: 1,
                  }}
                >
                  {label}
                </span>
              ))}
            </div>
            <div className="flex-1 min-w-0">
              <svg
                className="w-full overflow-visible"
                viewBox="0 0 1000 300"
                preserveAspectRatio="none"
                style={{ height: 220 }}
              >
                <defs>
                  <linearGradient id="prax-area-grad" x1="0" y1="0" x2="0" y2="1">
                    <stop
                      offset="0%"
                      stopColor="var(--color-prax-green)"
                      stopOpacity="0.22"
                    />
                    <stop
                      offset="100%"
                      stopColor="var(--color-prax-green)"
                      stopOpacity="0"
                    />
                  </linearGradient>
                </defs>
                {[20, 85, 150, 215, 280].map((y) => (
                  <line
                    key={y}
                    x1="0"
                    x2="1000"
                    y1={y}
                    y2={y}
                    stroke="var(--color-prax-cream-border)"
                    strokeWidth="0.8"
                  />
                ))}
                <path d={areaPath} fill="url(#prax-area-grad)" />
                <path
                  d={linePath}
                  fill="none"
                  stroke="var(--color-prax-green)"
                  strokeWidth="3.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  style={{
                    strokeDasharray: 2000,
                    strokeDashoffset: 2000,
                    animation: "praxChartDash 2s ease-in-out forwards",
                  }}
                />
                {chartPoints.map(([x, y], i) => (
                  <circle
                    key={i}
                    cx={x}
                    cy={y}
                    r="5"
                    fill="var(--color-prax-green)"
                  />
                ))}
              </svg>
              <style>{`@keyframes praxChartDash { to { stroke-dashoffset: 0; } }`}</style>
              <div
                className="flex justify-between mt-3"
                style={{
                  fontSize: 9.5,
                  fontWeight: 600,
                  letterSpacing: "0.16em",
                  textTransform: "uppercase",
                  color: "var(--color-prax-ink-mute)",
                }}
              >
                <span>{chartWeekLabels[0]}</span>
                {chartWeekLabels.length > 2 && (
                  <span>
                    {chartWeekLabels[Math.floor(chartWeekLabels.length / 2)]}
                  </span>
                )}
                <span>{chartWeekLabels[chartWeekLabels.length - 1]}</span>
              </div>
            </div>
          </div>
        )}
      </PraxCard>

      {/* ── Focus Insight (weakest area + report cards) ── */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-5 mb-6">
        {/* Weakest Area */}
        <PraxCard variant="secondary">
          <div className="flex items-center gap-2 mb-3">
            <div
              className="rounded-full"
              style={{
                width: 6,
                height: 6,
                background: "var(--color-prax-gold)",
              }}
            />
            <SmallCaps>Weakest Area</SmallCaps>
          </div>
          {weakestTopic ? (
            <>
              <div
                className="font-medium mb-2"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 22,
                  color: "var(--color-prax-green)",
                  letterSpacing: "-0.005em",
                }}
              >
                {weakestTopic.subtopic.replace(/_/g, " ")}
              </div>
              <div
                style={{
                  fontSize: 12.5,
                  lineHeight: 1.55,
                  color: "var(--color-prax-ink-soft)",
                }}
              >
                Accuracy{" "}
                <span
                  style={{
                    fontWeight: 700,
                    color: "var(--color-prax-gold)",
                    fontVariantNumeric: "tabular-nums",
                  }}
                >
                  {weakestTopic.accuracy}%
                </span>{" "}
                is your weakest topic right now. Targeting it directly will do
                the most for your overall score.
              </div>
              <div
                className="mt-4 p-3.5 rounded-xl"
                style={{
                  background: "var(--color-prax-cream-card)",
                  border: "1px solid var(--color-prax-cream-border)",
                }}
              >
                <SmallCaps style={{ marginBottom: 6 }}>
                  Recommended Strategy
                </SmallCaps>
                <p
                  style={{
                    fontSize: 12,
                    lineHeight: 1.5,
                    color: "var(--color-prax-ink-soft)",
                  }}
                >
                  Filter practice to{" "}
                  {SECTION_LABELS[weakestTopic.section] || weakestTopic.section}{" "}
                  and start with Easy difficulty. Build the foundation before
                  attempting hard questions on this topic.
                </p>
              </div>
            </>
          ) : (
            <div
              className="italic"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 14,
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Answer at least 3 questions per topic to unlock personalised
              insights.
            </div>
          )}
        </PraxCard>

        {/* Daily Report Card */}
        <PraxCard variant="secondary" href="/dashboard/analytics/daily">
          <div className="flex items-start justify-between mb-3">
            <SmallCaps>Daily Report</SmallCaps>
            {hasDailyReport && (
              <span
                className="px-2 py-0.5 rounded-full"
                style={{
                  background: "var(--color-prax-green-tint)",
                  color: "var(--color-prax-green)",
                  fontSize: 9,
                  fontWeight: 700,
                  letterSpacing: "0.14em",
                  textTransform: "uppercase",
                }}
              >
                Ready
              </span>
            )}
          </div>
          <div
            className="font-medium mb-2"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            Last 24 hours
          </div>
          <p
            style={{
              fontSize: 12.5,
              lineHeight: 1.55,
              color: "var(--color-prax-ink-soft)",
            }}
          >
            Today&apos;s accuracy, section performance, and a personalised coach
            analysis.
          </p>
          <div
            className="flex items-center gap-2 mt-5"
            style={{
              fontSize: 10,
              fontWeight: 700,
              letterSpacing: "0.18em",
              textTransform: "uppercase",
              color: "var(--color-prax-green)",
            }}
          >
            <span>{hasDailyReport ? "View Report" : "Generate"}</span>
            <svg
              width="12"
              height="12"
              fill="none"
              stroke="currentColor"
              strokeWidth={2.5}
              viewBox="0 0 24 24"
            >
              <path
                d="M5 12h14M12 5l7 7-7 7"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
        </PraxCard>

        {/* Weekly Report Card */}
        <PraxCard variant="secondary" href="/dashboard/analytics/weekly">
          <div className="flex items-start justify-between mb-3">
            <SmallCaps>Weekly Report</SmallCaps>
            {hasWeeklyReport && (
              <span
                className="px-2 py-0.5 rounded-full"
                style={{
                  background: "var(--color-prax-green-tint)",
                  color: "var(--color-prax-green)",
                  fontSize: 9,
                  fontWeight: 700,
                  letterSpacing: "0.14em",
                  textTransform: "uppercase",
                }}
              >
                Ready
              </span>
            )}
          </div>
          <div
            className="font-medium mb-2"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 22,
              color: "var(--color-prax-green)",
            }}
          >
            Last 7 days
          </div>
          <p
            style={{
              fontSize: 12.5,
              lineHeight: 1.55,
              color: "var(--color-prax-ink-soft)",
            }}
          >
            Daily accuracy trend, topics ranked by priority, and a 5-part study
            plan.
          </p>
          <div
            className="flex items-center gap-2 mt-5"
            style={{
              fontSize: 10,
              fontWeight: 700,
              letterSpacing: "0.18em",
              textTransform: "uppercase",
              color: "var(--color-prax-green)",
            }}
          >
            <span>{hasWeeklyReport ? "View Report" : "Generate"}</span>
            <svg
              width="12"
              height="12"
              fill="none"
              stroke="currentColor"
              strokeWidth={2.5}
              viewBox="0 0 24 24"
            >
              <path
                d="M5 12h14M12 5l7 7-7 7"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
        </PraxCard>
      </div>

      {/* ── Subject Mastery ── */}
      <div className="mb-6">
        {/* Subject Mastery */}
        <PraxCard variant="secondary">
          <div className="flex items-center justify-between mb-5">
            <SmallCaps>Subject Mastery</SmallCaps>
            <SmallCaps style={{ color: "var(--color-prax-ink-soft)" }}>
              {periodLabel}
            </SmallCaps>
          </div>
          {sectionStats.length === 0 ? (
            <div
              className="italic text-center py-8"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 13,
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Answer practice questions to see your section breakdown.
            </div>
          ) : (
            <div className="space-y-5">
              {(() => {
                // mark weakest section in gold
                const minAcc =
                  sectionStats.length > 0
                    ? Math.min(...sectionStats.map((s) => s.accuracy))
                    : 0;
                return sectionStats.map((s) => {
                  const attention = s.accuracy === minAcc;
                  return (
                    <div key={s.section}>
                      <div className="flex justify-between items-baseline mb-1.5">
                        <div className="flex items-center gap-2">
                          {attention && (
                            <div
                              className="rounded-full"
                              style={{
                                width: 5,
                                height: 5,
                                background: "var(--color-prax-gold)",
                              }}
                            />
                          )}
                          <div
                            style={{
                              fontFamily: "var(--font-prax-sans)",
                              fontSize: 12.5,
                              fontWeight: attention ? 600 : 500,
                              color: "var(--color-prax-ink)",
                            }}
                          >
                            {s.label}
                          </div>
                        </div>
                        <div
                          style={{
                            fontFamily: "var(--font-prax-serif)",
                            fontSize: 16,
                            color: attention
                              ? "var(--color-prax-gold)"
                              : "var(--color-prax-green)",
                            fontVariantNumeric: "tabular-nums lining-nums",
                          }}
                        >
                          {s.accuracy}
                          <span
                            style={{
                              fontSize: 12,
                              color: "var(--color-prax-ink-mute)",
                            }}
                          >
                            %
                          </span>
                        </div>
                      </div>
                      <div
                        className="rounded-full overflow-hidden"
                        style={{
                          height: 5,
                          background: "var(--color-prax-cream-card)",
                        }}
                      >
                        <div
                          className="h-full rounded-full transition-all duration-1000"
                          style={{
                            width: `${s.accuracy}%`,
                            background: attention
                              ? "var(--color-prax-gold)"
                              : "var(--color-prax-green)",
                          }}
                        />
                      </div>
                      <div
                        className="mt-1"
                        style={{
                          fontSize: 10,
                          color: "var(--color-prax-ink-mute)",
                          fontVariantNumeric: "tabular-nums",
                        }}
                      >
                        {s.correct}/{s.total} correct
                      </div>
                    </div>
                  );
                });
              })()}
            </div>
          )}
        </PraxCard>
      </div>

      {/* ── Flashcard focus areas ── */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-end justify-between mb-2 gap-3">
          <div>
            <div
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Flashcard focus areas
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              {flashTopicStats.sections.length > 0
                ? "Weakest sections first · graded against your own recall"
                : "Study flashcards to see which subtopics need work"}
            </SmallCaps>
          </div>
          {flashTopicStats.subtopicCount > 0 && (
            <SmallCaps>{flashTopicStats.subtopicCount} subtopics</SmallCaps>
          )}
        </div>

        {flashTopicStats.sections.length === 0 ? (
          <div
            className="italic text-center py-8"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 13,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Review at least {flashTopicStats.minAttempts} cards in a subtopic to
            see where you stand.
          </div>
        ) : (
          <div>
            {flashTopicStats.sections.map((sec) => {
              const isOpen = openFlashSections.has(sec.section);
              const summary =
                sec.focusCount > 0
                  ? `${sec.focusCount} need${sec.focusCount === 1 ? "s" : ""} focus`
                  : "nothing urgent";

              return (
                <div
                  key={sec.section}
                  style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
                >
                  <button
                    type="button"
                    onClick={() =>
                      setOpenFlashSections((prev) => {
                        const next = new Set(prev);
                        if (next.has(sec.section)) next.delete(sec.section);
                        else next.add(sec.section);
                        return next;
                      })
                    }
                    aria-expanded={isOpen}
                    className="w-full flex items-center gap-3 py-4 text-left"
                    style={{ background: "none", border: 0, cursor: "pointer" }}
                  >
                    <svg
                      width="9"
                      height="9"
                      viewBox="0 0 10 10"
                      aria-hidden="true"
                      className="shrink-0"
                      style={{
                        transform: isOpen ? "rotate(90deg)" : "none",
                        transition: "transform 160ms",
                      }}
                    >
                      <path
                        d="M3 1l4 4-4 4"
                        fill="none"
                        stroke="var(--color-prax-ink-mute)"
                        strokeWidth="1.6"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                    </svg>
                    <span
                      className="font-medium shrink-0"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 18,
                        color: "var(--color-prax-green)",
                      }}
                    >
                      {flashSectionLabel(sec.section)}
                    </span>
                    <span
                      className="flex-1 min-w-0 truncate font-semibold uppercase"
                      style={{
                        fontSize: 10,
                        letterSpacing: "0.22em",
                        color: "var(--color-prax-ink-mute)",
                      }}
                    >
                      {sec.subs.length} subtopic{sec.subs.length === 1 ? "" : "s"} ·{" "}
                      {summary}
                    </span>
                    <span
                      className="tabular-nums shrink-0 text-right"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 18,
                        color: "var(--color-prax-green)",
                        minWidth: 46,
                      }}
                    >
                      {sec.accuracy}%
                    </span>
                    <span
                      className="shrink-0 text-right font-semibold uppercase"
                      style={{
                        fontSize: 10,
                        letterSpacing: "0.22em",
                        minWidth: 62,
                        color:
                          sec.delta < -3
                            ? "var(--color-prax-gold)"
                            : sec.delta > 3
                            ? "var(--color-prax-green-soft)"
                            : "var(--color-prax-ink-mute)",
                      }}
                    >
                      {sec.delta > 0 ? "+" : ""}
                      {sec.delta} pts
                    </span>
                  </button>

                  {isOpen && (
                    <div style={{ padding: "0 0 12px 20px" }}>
                      {sec.subs.map((sub) => {
                        const band = flashBandOf(sub.delta);
                        const tone = FLASH_BAND_STYLE[band.key];
                        return (
                          <div
                            key={sub.deckId}
                            className="flex items-center gap-3.5 py-2.5"
                            style={{
                              borderTop:
                                "1px solid var(--color-prax-cream-border)",
                            }}
                          >
                            <div
                              className="rounded-full overflow-hidden shrink-0"
                              style={{
                                width: 3,
                                height: 26,
                                background: "var(--color-prax-cream-deep)",
                              }}
                            >
                              <div
                                className="w-full rounded-full transition-all duration-700"
                                style={{
                                  height: `${sub.accuracy}%`,
                                  marginTop: `${100 - sub.accuracy}%`,
                                  background: tone.bar,
                                }}
                              />
                            </div>

                            <div className="flex-1 min-w-0">
                              <div
                                className="truncate"
                                style={{
                                  fontFamily: "var(--font-prax-serif)",
                                  fontSize: 14.5,
                                  color: "var(--color-prax-ink)",
                                }}
                              >
                                {sub.label}
                              </div>
                              <SmallCaps style={{ marginTop: 1 }}>
                                {sub.attempts} cards
                              </SmallCaps>
                            </div>

                            <div
                              className="text-right shrink-0"
                              style={{ minWidth: 44 }}
                            >
                              <div
                                className="tabular-nums"
                                style={{
                                  fontFamily: "var(--font-prax-serif)",
                                  fontSize: 15,
                                  color: "var(--color-prax-green)",
                                }}
                              >
                                {sub.accuracy}%
                              </div>
                              <SmallCaps style={{ marginTop: 1 }}>
                                {sub.delta > 0 ? "+" : ""}
                                {sub.delta} pts
                              </SmallCaps>
                            </div>

                            <div
                              className="shrink-0 rounded-full px-2.5 py-1"
                              style={{
                                background: tone.pillBg,
                                color: tone.pillFg,
                                fontSize: 9,
                                letterSpacing: "0.13em",
                                textTransform: "uppercase",
                                fontWeight: 600,
                                minWidth: 80,
                                textAlign: "center",
                              }}
                            >
                              {band.label}
                            </div>

                            <Link
                              href={`/dashboard/flashcards/${sub.deckId}`}
                              className="shrink-0 rounded-full px-3 py-1.5 transition-colors"
                              style={{
                                border:
                                  "1px solid var(--color-prax-cream-border)",
                                color: "var(--color-prax-green)",
                                fontSize: 9,
                                letterSpacing: "0.13em",
                                textTransform: "uppercase",
                                fontWeight: 600,
                              }}
                            >
                              Study
                            </Link>
                          </div>
                        );
                      })}
                    </div>
                  )}
                </div>
              );
            })}

            <div
              style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
            />

            {flashTopicStats.tooFewCount > 0 && (
              <SmallCaps style={{ marginTop: 12, display: "block" }}>
                {flashTopicStats.tooFewCount} more subtopic
                {flashTopicStats.tooFewCount === 1 ? "" : "s"} studied fewer than{" "}
                {flashTopicStats.minAttempts} times, too little to judge yet
              </SmallCaps>
            )}
          </div>
        )}
      </PraxCard>

      {/* ── Topic Mastery list ── */}
      <PraxCard variant="secondary" className="mb-6">
        <div className="flex items-end justify-between mb-5 gap-3">
          <div>
            <div
              className="font-medium"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 22,
                color: "var(--color-prax-green)",
              }}
            >
              Topic mastery
            </div>
            <SmallCaps style={{ marginTop: 4 }}>
              Weakest first. These move your score the most
            </SmallCaps>
          </div>
          {subtopicStats.length > 0 && (
            <SmallCaps>{subtopicStats.length} topics</SmallCaps>
          )}
        </div>

        {subtopicStats.length === 0 ? (
          <div
            className="italic text-center py-8"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 13,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            Answer at least 3 questions per topic to see mastery data.
          </div>
        ) : (
          <div>
            {subtopicStats.map((s) => {
              const accuracy = s.accuracy;
              const isStrong = accuracy >= 80;
              const isDeveloping = accuracy >= 60 && accuracy < 80;

              const badgeBg = isStrong
                ? "var(--color-prax-green-tint)"
                : isDeveloping
                ? "var(--color-prax-cream-card)"
                : "var(--color-prax-gold)";
              const badgeColor = isStrong
                ? "var(--color-prax-green)"
                : isDeveloping
                ? "var(--color-prax-ink-soft)"
                : "var(--color-prax-cream)";
              const badgeLabel = isStrong
                ? "Strong"
                : isDeveloping
                ? "Developing"
                : "Focus Here";

              return (
                <div
                  key={`${s.section}::${s.subtopic}`}
                  className="flex items-center gap-4 py-3"
                  style={{
                    borderBottom: "1px solid var(--color-prax-cream-border)",
                  }}
                >
                  <div
                    className="w-1 rounded-full overflow-hidden shrink-0"
                    style={{
                      height: 32,
                      background: "var(--color-prax-cream-card)",
                    }}
                  >
                    <div
                      className="w-full rounded-full transition-all duration-700"
                      style={{
                        height: `${accuracy}%`,
                        marginTop: `${100 - accuracy}%`,
                        background: isStrong
                          ? "var(--color-prax-green)"
                          : isDeveloping
                          ? "var(--color-prax-green-soft)"
                          : "var(--color-prax-gold)",
                      }}
                    />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div
                      className="font-medium truncate"
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 14.5,
                        color: "var(--color-prax-green)",
                      }}
                    >
                      {s.subtopic.replace(/_/g, " ")}
                    </div>
                    <div
                      style={{
                        fontSize: 10.5,
                        color: "var(--color-prax-ink-mute)",
                        fontVariantNumeric: "tabular-nums",
                      }}
                    >
                      {SECTION_LABELS[s.section] || s.section} · {s.correct}/
                      {s.total} correct
                    </div>
                  </div>
                  <div className="flex items-center gap-2.5 shrink-0">
                    <div
                      style={{
                        fontFamily: "var(--font-prax-serif)",
                        fontSize: 17,
                        fontStyle: "italic",
                        color: "var(--color-prax-green)",
                        fontVariantNumeric: "tabular-nums lining-nums",
                      }}
                    >
                      {accuracy}%
                    </div>
                    <span
                      className="px-2.5 py-1 rounded-full whitespace-nowrap"
                      style={{
                        background: badgeBg,
                        color: badgeColor,
                        fontSize: 9.5,
                        fontWeight: 700,
                        letterSpacing: "0.14em",
                        textTransform: "uppercase",
                      }}
                    >
                      {badgeLabel}
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </PraxCard>
    </PraxPage>
  );
}
