"use client";

// ─── The cards below Today's Plan ──────────────────────────────────────────
//
// Each one has to answer a question a student actually has: what needs my
// attention, where do I stand, how much have I seen, am I moving. The two large
// cards these replaced answered none of them. "The Question Bank / Access Bank"
// and "Curated Modules / Explore Modules" were navigation, and both destinations
// are already in the sidebar, one click away, permanently.
//
// Anything with no evidence behind it says so. A card that shows 0% to a new
// student has told them their dashboard is broken.

import Link from "next/link";
import { PraxCard, SectionHeader, SmallCaps } from "@/components/dashboard/PraxUI";
import type { PriorityTopic, Trend, CoverageBand } from "@/lib/dashboard/summary";

/* ─────────────── shared bits ─────────────── */

function Empty({ children }: { children: React.ReactNode }) {
  return (
    <p
      className="m-0"
      style={{ fontSize: 13, lineHeight: 1.55, color: "var(--color-prax-ink-mute)" }}
    >
      {children}
    </p>
  );
}

function Row({
  left,
  right,
  sub,
}: {
  left: React.ReactNode;
  right?: React.ReactNode;
  sub?: React.ReactNode;
}) {
  return (
    <div
      className="flex items-baseline justify-between gap-3 py-2.5"
      style={{ borderBottom: "1px solid var(--color-prax-cream-border)" }}
    >
      <div className="min-w-0">
        <div
          className="truncate"
          style={{ fontSize: 14, color: "var(--color-prax-ink)", fontWeight: 500 }}
        >
          {left}
        </div>
        {sub && (
          <div style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)", marginTop: 2 }}>
            {sub}
          </div>
        )}
      </div>
      {right && (
        <div
          className="shrink-0 tabular-nums"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 15,
            color: "var(--color-prax-green)",
          }}
        >
          {right}
        </div>
      )}
    </div>
  );
}

function More({ href, label }: { href: string; label: string }) {
  return (
    <Link
      href={href}
      className="inline-block mt-4"
      style={{
        fontSize: 11,
        fontWeight: 700,
        letterSpacing: "0.14em",
        textTransform: "uppercase",
        color: "var(--color-prax-green)",
        textDecoration: "none",
      }}
    >
      {label} →
    </Link>
  );
}

/* ─────────────── Priority topics ─────────────── */

export function PriorityTopics({ topics, loading }: { topics: PriorityTopic[]; loading: boolean }) {
  return (
    <PraxCard>
      <SectionHeader label="Priority Topics" subtitle="worth your attention" />
      {loading ? (
        <Empty>Working out where you stand.</Empty>
      ) : topics.length === 0 ? (
        <Empty>
          We will identify priorities as you complete practice. Nothing here yet means nothing has
          enough evidence behind it, not that everything is fine.
        </Empty>
      ) : (
        <>
          {/* NO BARE PERCENTAGE. "Endocrine System 29%" invites the reading
              "29% of the topic done", which is not what it is, and the true
              reading needs a legend the card does not have. The reason says
              what was found; the count says how much it rests on. */}
          {topics.map((t) => (
            <Row
              key={t.topic}
              left={t.topic}
              sub={t.reason}
              right={
                <span style={{ fontSize: 12, color: "var(--color-prax-ink-mute)" }}>
                  {t.attempts} seen
                </span>
              }
            />
          ))}
          <More href="/dashboard/analytics" label="View priorities" />
        </>
      )}
    </PraxCard>
  );
}

/* ─────────────── Study status ─────────────── */

export function StudyStatusCard({
  status,
  note,
  trend,
  coverageBand,
  priorityCount,
  memoryPhase,
  loading,
}: {
  /** Display label from lib/learner/studyStatus.ts. Null while loading. */
  status: string | null;
  note: string;
  trend: Trend;
  coverageBand: CoverageBand | null;
  priorityCount: number;
  /** The measured flashcard phase. The one genuinely modelled signal here. */
  memoryPhase: string | null;
  loading: boolean;
}) {
  return (
    <PraxCard>
      <SectionHeader label="Study Status" subtitle="where you stand" />
      {loading || !status ? (
        <Empty>Working out where you stand.</Empty>
      ) : (
        <>
          <div
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 25,
              lineHeight: 1.1,
              color: "var(--color-prax-green)",
              marginBottom: 6,
            }}
          >
            {status}
          </div>
          <p
            className="m-0 mb-3"
            style={{ fontSize: 12.5, lineHeight: 1.5, color: "var(--color-prax-ink-soft)" }}
          >
            {note}
          </p>
          <Row left="Practice accuracy" right={trend} />
          <Row left="Content coverage" right={coverageBand ?? "Not yet"} />
          <Row left="Memory strength" right={memoryPhase ?? "Not yet"} />
          <Row left="Priority topics" right={String(priorityCount)} />
          <More href="/dashboard/analytics" label="View details" />
        </>
      )}
    </PraxCard>
  );
}

/* ─────────────── Memory review ─────────────── */

export function MemoryReview({
  recommendedToday,
  doneToday,
  comingSoon,
  backlog,
  loading,
}: {
  /** What the plan actually asks for today, not the historical pile. */
  recommendedToday: number;
  doneToday: number;
  comingSoon: number;
  backlog: number;
  loading: boolean;
}) {
  const nothingToDo = !loading && recommendedToday === 0 && backlog === 0 && comingSoon === 0;
  return (
    <PraxCard>
      <SectionHeader label="Memory Review" subtitle="spaced repetition" />
      {loading ? (
        <Empty>Working out today.</Empty>
      ) : nothingToDo ? (
        <Empty>Your review queue is empty. Start a deck and it will fill as you go.</Empty>
      ) : (
        <>
          {/* THE BIG NUMBER IS TODAY'S WORK, not the backlog. "5,004 cards
              due" reads as a verdict on the student rather than a task, and it
              is not what they are being asked to do this morning. */}
          <div className="flex items-baseline gap-2">
            <span
              className="tabular-nums"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 34,
                lineHeight: 1,
                color: "var(--color-prax-green)",
              }}
            >
              {doneToday} / {recommendedToday}
            </span>
          </div>
          <p
            className="m-0 mt-1.5 mb-3"
            style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}
          >
            recommended today
          </p>
          {/* Everything below the fold line is CONTEXT, not today's work. It is
              smaller and quieter on purpose: a student who reads the backlog as
              this morning's assignment has been told something false, and the
              old card's "5,004 cards due" said exactly that. */}
          <div
            className="flex flex-wrap gap-x-7 gap-y-1.5 pt-3"
            style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
          >
            <span style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}>
              Coming soon{" "}
              <span
                className="tabular-nums"
                style={{ color: "var(--color-prax-ink)", fontWeight: 500 }}
              >
                {comingSoon.toLocaleString("en-US")}
              </span>
            </span>
            {backlog > 0 && (
              <span style={{ fontSize: 12.5, color: "var(--color-prax-ink-soft)" }}>
                Backlog{" "}
                <span
                  className="tabular-nums"
                  style={{ color: "var(--color-prax-ink)", fontWeight: 500 }}
                >
                  {backlog.toLocaleString("en-US")}
                </span>
              </span>
            )}
          </div>
          {backlog > 0 && (
            <p
              className="m-0 mt-2"
              style={{ fontSize: 12, lineHeight: 1.45, color: "var(--color-prax-ink-mute)" }}
            >
              The backlog comes down a day at a time, at your daily limit. It is not today&apos;s
              work.
            </p>
          )}
          <Link
            href="/dashboard/flashcards/session?mode=due"
            className="inline-block mt-4"
            style={{
              background: "var(--color-prax-green)",
              color: "var(--color-prax-cream)",
              borderRadius: 999,
              padding: "10px 22px",
              fontSize: 12.5,
              fontWeight: 600,
              textDecoration: "none",
            }}
          >
            Review now →
          </Link>
        </>
      )}
    </PraxCard>
  );
}


/* ─────────────── Recent progress ─────────────── */

export interface ProgressSignal {
  label: string;
  value: string;
  detail?: string;
}

export function RecentProgress({
  signals,
  loading,
}: {
  signals: ProgressSignal[];
  loading: boolean;
}) {
  return (
    <PraxCard>
      <SectionHeader label="Recent Progress" subtitle="last seven days" />
      {loading ? (
        <Empty>Working out what changed.</Empty>
      ) : signals.length === 0 ? (
        <Empty>
          Keep studying to build your progress history. Meaningful changes appear here once there
          is enough to compare against.
        </Empty>
      ) : (
        signals.map((s) => <Row key={s.label} left={s.label} sub={s.detail} right={s.value} />)
      )}
    </PraxCard>
  );
}


/* ─────────────── Activity strip ─────────────── */

/**
 * Streak, lifetime questions and weekly count.
 *
 * Kept, demoted. They were four of the largest cards on the page, which said
 * they were the most important things on it. They are not: they measure effort
 * spent rather than ground gained. One quiet line at the foot of the page is
 * the weight they earn.
 */
export function ActivityStrip({
  streak,
  totalQuestions,
  questionsThisWeek,
  cardsThisWeek,
}: {
  streak: number;
  totalQuestions: number;
  questionsThisWeek: number;
  cardsThisWeek: number;
}) {
  // Four zeros in a row is a scoreboard telling a new student they have lost.
  // Nothing to count means nothing to show.
  if (streak + totalQuestions + questionsThisWeek + cardsThisWeek === 0) return null;

  const items = [
    { n: streak, label: streak === 1 ? "day streak" : "day streak" },
    { n: totalQuestions, label: "questions all time" },
    { n: questionsThisWeek, label: "questions this week" },
    { n: cardsThisWeek, label: "cards this week" },
  ];
  return (
    <div
      className="flex flex-wrap items-baseline gap-x-8 gap-y-2 mt-8 pt-5"
      style={{ borderTop: "1px solid var(--color-prax-cream-border)" }}
    >
      {items.map((i) => (
        <div key={i.label} className="flex items-baseline gap-1.5">
          <span
            className="tabular-nums"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 17,
              color: "var(--color-prax-green)",
            }}
          >
            {i.n.toLocaleString("en-US")}
          </span>
          <SmallCaps>{i.label}</SmallCaps>
        </div>
      ))}
    </div>
  );
}
