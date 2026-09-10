"use client";

// The panel that replaced "Today's Focus". The rule for what appears and what
// each number means lives in lib/dashboard/checklist.ts; this file only draws
// it, so the two cannot drift the way three copies of the flashcard contrast
// vocabulary once did.

import Link from "next/link";
import {
  buildChecklist,
  countable,
  headline,
  overallProgress,
  type ChecklistInput,
  type ChecklistLine,
} from "@/lib/dashboard/checklist";
import type { PhaseResult } from "@/lib/dashboard/phase";

const RING_R = 45;
const RING_C = 2 * Math.PI * RING_R;

function Tick({ state }: { state: ChecklistLine["state"] }) {
  const base: React.CSSProperties = {
    width: 21,
    height: 21,
    borderRadius: "50%",
    display: "grid",
    placeItems: "center",
    fontSize: 11,
    lineHeight: 1,
    flexShrink: 0,
    border: "1.5px solid rgba(216,229,223,0.42)",
  };
  if (state === "done") {
    return (
      <span
        style={{
          ...base,
          background: "var(--color-prax-gold)",
          borderColor: "var(--color-prax-gold)",
          color: "var(--color-prax-green-deep)",
          fontWeight: 700,
        }}
        aria-hidden
      >
        ✓
      </span>
    );
  }
  if (state === "partial") {
    return (
      <span
        style={{
          ...base,
          borderColor: "var(--color-prax-gold)",
          color: "var(--color-prax-gold)",
          fontSize: 9,
        }}
        aria-hidden
      >
        ◐
      </span>
    );
  }
  return <span style={base} aria-hidden />;
}

function Row({ line }: { line: ChecklistLine }) {
  const soon = line.state === "soon";
  const done = line.state === "done";
  const pct = line.target > 0 ? Math.min(1, line.done / line.target) : 0;

  const body = (
    <>
      <Tick state={line.state} />
      <span className="flex-1 min-w-0">
        <span
          className="block"
          style={{
            fontSize: 14.5,
            fontWeight: 500,
            letterSpacing: "-0.005em",
            color: done ? "rgba(246,244,227,0.55)" : "var(--color-prax-cream)",
          }}
        >
          {line.title}
        </span>
        {line.note && (
          <span
            className="block truncate"
            style={{ fontSize: 11.5, color: "rgba(246,244,227,0.55)", marginTop: 2 }}
          >
            {line.note}
          </span>
        )}
        {!soon && (
          <span
            className="block overflow-hidden"
            style={{
              height: 3,
              borderRadius: 2,
              background: "rgba(216,229,223,0.16)",
              marginTop: 7,
            }}
          >
            <span
              className="block h-full"
              style={{
                width: `${pct * 100}%`,
                borderRadius: 2,
                background: done ? "rgba(216,229,223,0.4)" : "var(--color-prax-gold)",
                transition: "width 240ms ease",
              }}
            />
          </span>
        )}
      </span>
      <span
        className="shrink-0"
        style={{
          fontFamily: "var(--font-prax-serif)",
          fontSize: 16,
          fontVariantNumeric: "tabular-nums",
          color: done ? "rgba(246,244,227,0.55)" : "var(--color-prax-cream)",
        }}
      >
        {soon ? (
          <span style={{ fontSize: 12, fontFamily: "inherit", opacity: 0.6 }}>soon</span>
        ) : (
          <>
            {line.done}{" "}
            <span style={{ fontSize: 12, color: "rgba(246,244,227,0.5)" }}>/ {line.target}</span>
          </>
        )}
      </span>
    </>
  );

  const style: React.CSSProperties = {
    background: done ? "rgba(255,255,255,0.015)" : "rgba(255,255,255,0.03)",
    borderRadius: 12,
    padding: "11px 12px",
    opacity: soon ? 0.44 : 1,
  };

  // A row you cannot act on yet is not a link. Making it one would promise a
  // destination that does not exist.
  if (soon) {
    return (
      <li className="flex items-center gap-3.5" style={style}>
        {body}
      </li>
    );
  }
  return (
    <li>
      <Link
        href={line.href}
        className="flex items-center gap-3.5 transition-colors hover:bg-white/[0.06]"
        style={{ ...style, textDecoration: "none" }}
      >
        {body}
      </Link>
    </li>
  );
}

export default function TodayChecklist({
  input,
  phase,
  loading,
}: {
  input: ChecklistInput | null;
  /** Why the lines are in this order. Shown, because an order a student cannot
   *  account for reads as arbitrary, which is what it used to be. */
  phase: PhaseResult | null;
  loading: boolean;
}) {
  const lines = input ? buildChecklist(input) : [];
  const live = countable(lines);
  const progress = overallProgress(lines);
  const nextUp = live.find((l) => l.state !== "done");

  return (
    <div
      className="relative overflow-hidden mb-8"
      style={{
        background: "var(--color-prax-green)",
        borderRadius: 20,
        padding: "28px 30px 24px",
        boxShadow: "0 1px 2px rgba(3,56,48,0.05), 0 12px 40px -20px rgba(3,56,48,0.35)",
      }}
    >
      {/* Decorative orbital motif, carried over from the panel this replaced */}
      <svg
        className="absolute opacity-20 pointer-events-none"
        style={{ right: -80, top: -100 }}
        width="440"
        height="440"
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
      </svg>

      <div className="relative">
        <div className="flex items-start justify-between gap-6 flex-wrap mb-5">
          <div className="min-w-0">
            <div className="flex items-center gap-2.5">
              <span
                className="rounded-full"
                style={{ width: 6, height: 6, background: "var(--color-prax-gold-soft)" }}
              />
              <span
                className="font-semibold uppercase"
                style={{
                  fontSize: 10,
                  letterSpacing: "0.22em",
                  color: "var(--color-prax-gold-soft)",
                }}
              >
                Today&apos;s Checklist
              </span>
            </div>
            <h2
              className="font-normal m-0 mt-3"
              style={{
                fontFamily: "var(--font-prax-serif)",
                fontSize: 33,
                lineHeight: 1.12,
                color: "var(--color-prax-cream)",
                letterSpacing: "-0.005em",
              }}
            >
              {loading ? "Working out today." : headline(lines)}
            </h2>
            <p
              className="m-0 mt-2"
              style={{ fontSize: 13.5, color: "rgba(246,244,227,0.72)", maxWidth: "46ch" }}
            >
              {phase
                ? phase.reason
                : "Each line fills as you work and ticks itself when it is done."}
            </p>
          </div>

          <div className="relative shrink-0" style={{ width: 104, height: 104 }}>
            <svg width="104" height="104" viewBox="0 0 104 104" style={{ transform: "rotate(-90deg)" }}>
              <circle cx="52" cy="52" r={RING_R} fill="none" stroke="rgba(216,229,223,0.18)" strokeWidth="7" />
              <circle
                cx="52"
                cy="52"
                r={RING_R}
                fill="none"
                stroke="var(--color-prax-gold)"
                strokeWidth="7"
                strokeLinecap="round"
                strokeDasharray={`${progress * RING_C} ${RING_C}`}
                style={{ transition: "stroke-dasharray 320ms ease" }}
              />
            </svg>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 25,
                  lineHeight: 1,
                  color: "var(--color-prax-cream)",
                }}
              >
                {Math.round(progress * 100)}
                <span style={{ fontSize: 13 }}>%</span>
              </span>
              <span
                className="font-semibold uppercase"
                style={{ fontSize: 8, letterSpacing: "0.14em", color: "var(--color-prax-gold-soft)" }}
              >
                Today
              </span>
            </div>
          </div>
        </div>

        {loading ? (
          <div style={{ height: 232 }} aria-hidden />
        ) : (
          <ul className="list-none m-0 p-0 flex flex-col gap-0.5">
            {lines.map((l) => (
              <Row key={l.key} line={l} />
            ))}
          </ul>
        )}

        {!loading && nextUp && (
          <div className="mt-5 flex items-center gap-4 flex-wrap">
            <Link
              href={nextUp.href}
              className="inline-flex items-center gap-2"
              style={{
                background: "var(--color-prax-cream-card)",
                color: "var(--color-prax-green-deep)",
                borderRadius: 999,
                padding: "12px 26px",
                fontSize: 14,
                fontWeight: 600,
                textDecoration: "none",
              }}
            >
              Start with {nextUp.title.toLowerCase()} <span aria-hidden>→</span>
            </Link>
            {input && input.unseenBlanks === 0 && (
              <span style={{ fontSize: 12, color: "rgba(246,244,227,0.6)" }}>
                You have seen every card at least once, so there are no new ones today.
              </span>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
