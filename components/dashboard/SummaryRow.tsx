"use client";

// ─── The four cards at the top of the dashboard ────────────────────────────
//
// Replaced Streak, Activity, Precision and Solved. Those are activity metrics:
// they tell a student how much they have done, which is not the same as how
// they are doing. They still exist, lower down, where their weight matches
// their value.
//
// These four answer "where am I?" instead. Every one of them can also say "not
// yet", and does, because a new student who is shown 0% four times has been
// told their dashboard is broken.

import Link from "next/link";
import { SmallCaps } from "@/components/dashboard/PraxUI";
import type { ScoreEstimate } from "@/lib/scoring/scoreEstimate";
import type { Coverage, RecentAccuracy, WeeklyProgress } from "@/lib/dashboard/summary";

function Card({
  label,
  aside,
  children,
}: {
  label: string;
  aside?: React.ReactNode;
  children: React.ReactNode;
}) {
  return (
    <div
      className="flex flex-col"
      style={{
        background: "var(--color-prax-cream-card)",
        border: "1px solid var(--color-prax-cream-border)",
        borderRadius: 14,
        padding: "16px 18px 15px",
        minHeight: 118,
      }}
    >
      <div className="flex items-baseline justify-between gap-2 mb-2.5">
        <SmallCaps>{label}</SmallCaps>
        {aside && (
          <span
            className="shrink-0"
            style={{ fontSize: 10.5, color: "var(--color-prax-ink-mute)" }}
          >
            {aside}
          </span>
        )}
      </div>
      {children}
    </div>
  );
}

/** The number itself. Serif, because it is the thing being read. */
function Figure({ value, unit }: { value: string; unit?: string }) {
  return (
    <div className="flex items-baseline gap-1">
      <span
        className="tabular-nums"
        style={{
          fontFamily: "var(--font-prax-serif)",
          fontSize: 30,
          lineHeight: 1,
          color: "var(--color-prax-green)",
          letterSpacing: "-0.01em",
        }}
      >
        {value}
      </span>
      {unit && (
        <span style={{ fontSize: 13, color: "var(--color-prax-ink-mute)" }}>{unit}</span>
      )}
    </div>
  );
}

/** A share of something, drawn the same way wherever it appears. */
function Bar({ percent }: { percent: number }) {
  return (
    <div
      className="mt-2"
      style={{
        height: 3,
        borderRadius: 2,
        background: "var(--color-prax-cream-border)",
        overflow: "hidden",
      }}
    >
      <div
        style={{
          width: `${Math.max(0, Math.min(100, percent))}%`,
          height: "100%",
          borderRadius: 2,
          background: "var(--color-prax-green)",
        }}
      />
    </div>
  );
}

/** What a card says before it has anything to say. Never a zero. */
function NotYet({ children }: { children: React.ReactNode }) {
  return (
    <p
      className="m-0 mt-0.5"
      style={{ fontSize: 12.5, lineHeight: 1.5, color: "var(--color-prax-ink-soft)" }}
    >
      {children}
    </p>
  );
}

function Caption({ children }: { children: React.ReactNode }) {
  return (
    <p
      className="m-0 mt-1.5"
      style={{ fontSize: 12.5, lineHeight: 1.45, color: "var(--color-prax-ink-soft)" }}
    >
      {children}
    </p>
  );
}

export default function SummaryRow({
  score,
  weekly,
  recent,
  cover,
  loading,
}: {
  score: ScoreEstimate | null;
  weekly: WeeklyProgress | null;
  recent: RecentAccuracy | null;
  cover: Coverage | null;
  loading: boolean;
}) {
  if (loading) {
    return (
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 mb-8">
        {[0, 1, 2, 3].map((i) => (
          <div
            key={i}
            style={{
              background: "var(--color-prax-cream-card)",
              border: "1px solid var(--color-prax-cream-border)",
              borderRadius: 14,
              minHeight: 118,
            }}
          />
        ))}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 mb-8">
      {/* ── Estimated range, from the existing predictor ───────────────── */}
      <Card label="Estimated Range" aside={score?.low !== null ? "provisional" : undefined}>
        {score && score.low !== null && score.high !== null ? (
          <>
            <Figure value={`${score.low}–${score.high}`} />
            {/* The predictor's own confidence field, not a second judgement
                layered on top of it. A range this wide has to say so. */}
            <div
              style={{
                fontSize: 11,
                fontWeight: 700,
                letterSpacing: "0.12em",
                textTransform: "uppercase",
                color:
                  score.confidence === "Low"
                    ? "var(--color-prax-gold)"
                    : "var(--color-prax-ink-mute)",
                marginTop: 6,
              }}
            >
              {score.confidence} confidence
            </div>
            <Caption>
              {score.blindSections.length > 0
                ? `${score.blindSections.join(" and ")} not yet measured. More eligible practice narrows this.`
                : `From ${score.firstAttempts.toLocaleString("en-US")} first attempts.`}
            </Caption>
          </>
        ) : (
          <NotYet>Complete more practice and an estimate will appear here.</NotYet>
        )}
      </Card>

      {/* ── Weekly progress, against the student's own goal ────────────── */}
      <Card label="This Week">
        {weekly && weekly.goal !== null ? (
          <>
            {/* The fraction leads. "40%" alone made a student work out what it
                was 40% of before the card told them anything. */}
            <Figure value={`${weekly.done} / ${weekly.goal}`} />
            <Caption>questions completed this week</Caption>
            <Bar percent={weekly.percent ?? 0} />
          </>
        ) : weekly ? (
          <>
            <Figure value={`${weekly.done}`} />
            <Caption>
              Questions this week.{" "}
              <Link href="/dashboard/settings" style={{ color: "var(--color-prax-green)" }}>
                Set a goal
              </Link>{" "}
              to track progress against it.
            </Caption>
          </>
        ) : (
          <NotYet>Your weekly progress will appear here.</NotYet>
        )}
      </Card>

      {/* ── Recent accuracy, not lifetime ──────────────────────────────── */}
      <Card label="Recent Accuracy">
        {recent && recent.percent !== null ? (
          <>
            <Figure value={`${recent.percent}`} unit="%" />
            {recent.deltaPoints !== null && recent.deltaPoints !== 0 && (
              <div
                style={{
                  fontSize: 11.5,
                  fontWeight: 600,
                  marginTop: 5,
                  color:
                    recent.deltaPoints > 0
                      ? "var(--color-prax-green-soft)"
                      : "var(--color-prax-gold)",
                }}
              >
                {recent.deltaPoints > 0 ? "↑" : "↓"} {Math.abs(recent.deltaPoints)} pts vs previous{" "}
                {recent.window}
              </div>
            )}
            <Caption>Last {recent.sampleSize} eligible questions.</Caption>
          </>
        ) : (
          <NotYet>
            {recent && recent.sampleSize > 0
              ? `${recent.sampleSize} answered so far. A few more and this becomes meaningful.`
              : "Answer some questions and your recent accuracy will appear."}
          </NotYet>
        )}
      </Card>

      {/* ── Coverage. Encountered, not mastered. ───────────────────────── */}
      <Card label="Content Coverage">
        {cover && cover.total > 0 ? (
          <>
            <Figure value={`${cover.percent}`} unit="%" />
            <Caption>
              of MCAT content attempted, {cover.attempted.toLocaleString("en-US")} of{" "}
              {cover.total.toLocaleString("en-US")} questions.
            </Caption>
            <Bar percent={cover.percent} />
          </>
        ) : (
          <NotYet>Start practising to build your coverage map.</NotYet>
        )}
      </Card>
    </div>
  );
}
