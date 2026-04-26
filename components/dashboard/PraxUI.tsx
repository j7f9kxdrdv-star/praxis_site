"use client";

/**
 * Praxist dashboard design system primitives.
 *
 * Use these in every dashboard page to keep the cream/green/gold palette,
 * Instrument Serif + Be Vietnam Pro typography, and three-tier card hierarchy
 * (primary green hero, secondary deeper-cream, tertiary cream-card) consistent.
 *
 * All color and font tokens are defined in app/globals.css under @theme inline:
 *   --color-prax-cream / cream-deep / cream-card / cream-border
 *   --color-prax-ink / ink-soft / ink-mute
 *   --color-prax-green / green-deep / green-soft / green-tint
 *   --color-prax-gold / gold-soft
 *   --font-prax-serif (Instrument Serif)
 *   --font-prax-sans  (Be Vietnam Pro)
 */

import { ReactNode, CSSProperties } from "react";
import Link from "next/link";
import MolecularBg from "./MolecularBg";

/* ────────────────────────────────────────────────────────────── */
/* PraxPage — the cream-bg + molecular-bg + padding-bleed wrapper */
/* ────────────────────────────────────────────────────────────── */

export function PraxPage({
  children,
  bgOpacity = 0.07,
  bgVariant = "hex",
}: {
  children: ReactNode;
  bgOpacity?: number;
  bgVariant?:
    | "hex"
    | "neurons"
    | "study"
    | "none"
    | "grid"
    | "botanical"
    | "halo"
    | "glyphs"
    | "stack"
    | "contour";
}) {
  return (
    <div
      className="relative min-h-full w-full lg:-mx-16 lg:-my-16 overflow-hidden"
      style={{
        background: "var(--color-prax-cream)",
        fontFamily: "var(--font-prax-sans)",
        color: "var(--color-prax-ink)",
      }}
    >
      <MolecularBg opacity={bgOpacity} variant={bgVariant} />
      <div className="relative z-[1] px-6 py-8 lg:px-12 lg:py-10">
        {children}
      </div>
    </div>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* SmallCaps — tracked uppercase label                            */
/* ────────────────────────────────────────────────────────────── */

export function SmallCaps({
  children,
  className = "",
  style = {},
}: {
  children: ReactNode;
  className?: string;
  style?: CSSProperties;
}) {
  return (
    <div
      className={`font-semibold uppercase ${className}`}
      style={{
        fontSize: 10,
        letterSpacing: "0.22em",
        color: "var(--color-prax-ink-mute)",
        ...style,
      }}
    >
      {children}
    </div>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* SectionHeader — small caps + optional italic subtitle + link   */
/* ────────────────────────────────────────────────────────────── */

export function SectionHeader({
  label,
  subtitle,
  rightHref,
  rightLabel,
  rightAction,
  bordered = true,
}: {
  label: string;
  subtitle?: string;
  rightHref?: string;
  rightLabel?: string;
  rightAction?: ReactNode;
  bordered?: boolean;
}) {
  return (
    <div
      className="flex justify-between items-baseline pb-3.5 mb-4 gap-4"
      style={
        bordered
          ? { borderBottom: "1px solid var(--color-prax-cream-border)" }
          : undefined
      }
    >
      <div className="flex items-baseline gap-2.5 min-w-0">
        <SmallCaps>{label}</SmallCaps>
        {subtitle && (
          <div
            className="italic truncate"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 13,
              color: "var(--color-prax-ink-mute)",
            }}
          >
            {subtitle}
          </div>
        )}
      </div>
      {rightAction
        ? rightAction
        : rightHref &&
          rightLabel && (
            <Link
              href={rightHref}
              className="font-semibold cursor-pointer shrink-0"
              style={{
                fontSize: 11.5,
                color: "var(--color-prax-green)",
              }}
            >
              {rightLabel} →
            </Link>
          )}
    </div>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* PraxCard — three-tier card variants                            */
/*                                                                 */
/*   primary   = dark-green hero (CTAs, "today's focus")          */
/*   secondary = deeper cream (recedes into page)                 */
/*   tertiary  = cream-card (lighter than page; for stat strips)  */
/* ────────────────────────────────────────────────────────────── */

type CardVariant = "primary" | "secondary" | "tertiary";

export function PraxCard({
  variant = "secondary",
  className = "",
  style = {},
  children,
  as = "div",
  href,
}: {
  variant?: CardVariant;
  className?: string;
  style?: CSSProperties;
  children: ReactNode;
  as?: "div" | "button";
  href?: string;
}) {
  const variantStyles: Record<CardVariant, CSSProperties> = {
    primary: {
      background: "var(--color-prax-green)",
      color: "var(--color-prax-cream)",
      borderRadius: 20,
      padding: "32px 36px",
      boxShadow:
        "0 1px 2px rgba(3,56,48,0.05), 0 12px 40px -20px rgba(3,56,48,0.35)",
    },
    secondary: {
      background: "var(--color-prax-cream-deep)",
      border: "1px solid var(--color-prax-cream-border)",
      borderRadius: 16,
      padding: "24px 26px",
    },
    tertiary: {
      background: "var(--color-prax-cream-card)",
      border: "1px solid var(--color-prax-cream-border)",
      borderRadius: 12,
      padding: "16px 18px 14px",
    },
  };

  const combined = { ...variantStyles[variant], ...style };

  if (href) {
    return (
      <Link href={href} className={`relative block ${className}`} style={combined}>
        {children}
      </Link>
    );
  }
  if (as === "button") {
    return (
      <button className={`relative ${className}`} style={combined}>
        {children}
      </button>
    );
  }
  return (
    <div className={`relative ${className}`} style={combined}>
      {children}
    </div>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* Spark — tiny sparkline trend                                   */
/* ────────────────────────────────────────────────────────────── */

export function Spark({
  points,
  color = "var(--color-prax-green-soft)",
  width = 72,
  height = 22,
}: {
  points: number[];
  color?: string;
  width?: number;
  height?: number;
}) {
  if (points.length === 0) return <div style={{ width, height }} />;
  const max = Math.max(...points, 1);
  const min = Math.min(...points, 0);
  const range = max - min || 1;
  const step = points.length > 1 ? width / (points.length - 1) : 0;
  const coords = points.map(
    (p, i) => [i * step, height - ((p - min) / range) * height] as [number, number]
  );
  const d = coords
    .map(
      (c, i) => (i === 0 ? "M" : "L") + c[0].toFixed(1) + " " + c[1].toFixed(1)
    )
    .join(" ");
  const area = d + ` L ${width} ${height} L 0 ${height} Z`;
  const last = coords[coords.length - 1];
  return (
    <svg width={width} height={height} style={{ display: "block" }}>
      <path d={area} fill={color} opacity="0.12" />
      <path
        d={d}
        fill="none"
        stroke={color}
        strokeWidth="1.4"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <circle cx={last[0]} cy={last[1]} r="2.2" fill={color} />
    </svg>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* Button styles (for inline use on Link / button elements)        */
/* ────────────────────────────────────────────────────────────── */

/** Solid cream pill on a green background — primary CTA inside green hero. */
export const praxBtnCreamOnGreen: CSSProperties = {
  background: "var(--color-prax-cream)",
  color: "var(--color-prax-green)",
  border: "none",
  borderRadius: 999,
  padding: "14px 26px",
  fontSize: 13.5,
  fontWeight: 600,
  letterSpacing: "0.02em",
  cursor: "pointer",
  display: "inline-flex",
  alignItems: "center",
  gap: 10,
};

/** Solid green pill on cream — primary CTA inside a secondary card. */
export const praxBtnGreenOnCream: CSSProperties = {
  background: "var(--color-prax-green)",
  color: "var(--color-prax-cream)",
  border: "none",
  borderRadius: 999,
  padding: "11px 22px",
  fontSize: 11.5,
  fontWeight: 600,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  cursor: "pointer",
  display: "inline-flex",
  alignItems: "center",
  gap: 8,
};

/** Gold-outlined pill — for the Elite footer banner / opt-ins. */
export const praxBtnGoldOutlined: CSSProperties = {
  background: "transparent",
  color: "var(--color-prax-gold-soft)",
  border: "1px solid var(--color-prax-gold-soft)",
  borderRadius: 999,
  padding: "9px 18px",
  fontSize: 11,
  fontWeight: 600,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  cursor: "pointer",
};

/** Subtle ghost button — text-only, becomes underlined-link feel. */
export const praxBtnGhost: CSSProperties = {
  background: "transparent",
  color: "var(--color-prax-green)",
  border: "1px solid var(--color-prax-cream-border)",
  borderRadius: 999,
  padding: "9px 18px",
  fontSize: 11,
  fontWeight: 600,
  letterSpacing: "0.14em",
  textTransform: "uppercase",
  cursor: "pointer",
};

/* ────────────────────────────────────────────────────────────── */
/* PageHeader — the cream "Good evening, Mikko." style header     */
/*                                                                 */
/* For pages that aren't the dashboard (e.g. Flashcards, Practice) */
/* use this for a consistent serif headline + italic subtitle +   */
/* optional right-aligned date pill.                              */
/* ────────────────────────────────────────────────────────────── */

export function PageHeader({
  eyebrow,
  title,
  subtitle,
  right,
}: {
  eyebrow?: string;
  title: string;
  subtitle?: string;
  right?: ReactNode;
}) {
  return (
    <div className="mb-8 flex items-start justify-between gap-4">
      <div>
        {eyebrow && (
          <SmallCaps style={{ marginBottom: 12 }}>{eyebrow}</SmallCaps>
        )}
        <h1
          className="font-medium m-0"
          style={{
            fontFamily: "var(--font-prax-serif)",
            fontSize: 44,
            lineHeight: 1.05,
            color: "var(--color-prax-green)",
            letterSpacing: "-0.015em",
          }}
        >
          {title}
        </h1>
        {subtitle && (
          <div
            className="italic mt-1.5 max-w-[520px]"
            style={{
              fontFamily: "var(--font-prax-serif)",
              fontSize: 16,
              color: "var(--color-prax-ink-soft)",
            }}
          >
            {subtitle}
          </div>
        )}
      </div>
      {right && <div className="shrink-0">{right}</div>}
    </div>
  );
}

/* ────────────────────────────────────────────────────────────── */
/* ActiveNowPill — the live date / "active now" pill              */
/* ────────────────────────────────────────────────────────────── */

export function ActiveNowPill() {
  const today = new Date().toLocaleDateString("en-US", {
    weekday: "long",
    month: "long",
    day: "numeric",
  });
  return (
    <div className="hidden sm:flex items-center gap-2.5 pt-2 shrink-0">
      <div className="relative w-2 h-2">
        <div
          className="absolute inset-0 rounded-full"
          style={{ background: "var(--color-prax-green-soft)" }}
        />
        <div
          className="absolute inset-0 rounded-full animate-prax-pulse"
          style={{ background: "var(--color-prax-green-soft)" }}
        />
      </div>
      <SmallCaps style={{ whiteSpace: "nowrap" }}>{today} · Active now</SmallCaps>
    </div>
  );
}
