"use client";

/**
 * Background canvas + Tweaks panel for the Flashcards section.
 *
 * Owns the active background-treatment variant, persists the user's choice
 * to localStorage, and renders both the bg layer and a small floating
 * "Tweaks" panel that lets the user switch between treatments.
 *
 * Default variant is "glyphs" (the design's chosen default — tiled λΨφΩ
 * Greek letters in Fraunces).
 *
 * Mounted by the flashcards section layout. Renders behind every flashcards
 * sub-page (listing, deck detail, study session, cross-deck session).
 */

import { useEffect, useState } from "react";
import MolecularBg, { type BgVariant } from "./MolecularBg";

const STORAGE_KEY = "prax.flashcards.bg";
const DEFAULT_VARIANT: BgVariant = "glyphs";

const TREATMENTS: { id: BgVariant; label: string }[] = [
  { id: "none", label: "None" },
  { id: "grid", label: "Graph" },
  { id: "botanical", label: "Botanical" },
  { id: "halo", label: "Halo" },
  { id: "glyphs", label: "Glyphs" },
  { id: "stack", label: "Stack" },
  { id: "contour", label: "Contour" },
  { id: "neurons", label: "Neurons" },
];

function isValidVariant(v: string | null): v is BgVariant {
  return !!v && TREATMENTS.some((t) => t.id === v);
}

export default function FlashcardsBg() {
  const [variant, setVariant] = useState<BgVariant>(DEFAULT_VARIANT);
  const [tweaksOpen, setTweaksOpen] = useState(false);
  const [hydrated, setHydrated] = useState(false);

  // Load persisted choice on mount.
  useEffect(() => {
    try {
      const saved = window.localStorage.getItem(STORAGE_KEY);
      if (isValidVariant(saved)) setVariant(saved);
    } catch {
      // localStorage may be unavailable (SSR, private mode) — fall through.
    }
    setHydrated(true);
  }, []);

  function pick(next: BgVariant) {
    setVariant(next);
    try {
      window.localStorage.setItem(STORAGE_KEY, next);
    } catch {
      // ignore
    }
  }

  return (
    <>
      {/* Background layer — fills the parent (the layout's relative wrapper). */}
      {hydrated && <MolecularBg variant={variant} />}

      {/* Tweaks panel — fixed bottom-right. Click the gear to open. */}
      <div
        className="hidden lg:block fixed z-40"
        style={{ right: 16, bottom: 16, fontFamily: "var(--font-prax-sans)" }}
      >
        {tweaksOpen ? (
          <div
            style={{
              width: 260,
              padding: "14px 14px 12px",
              background: "var(--color-prax-cream-card)",
              border: "1px solid var(--color-prax-cream-border)",
              borderRadius: 14,
              boxShadow:
                "0 20px 50px -20px rgba(3,56,48,0.35), 0 2px 8px rgba(3,56,48,0.08)",
            }}
          >
            <div className="flex items-center justify-between mb-2.5">
              <div
                className="font-medium"
                style={{
                  fontFamily: "var(--font-prax-serif)",
                  fontSize: 15,
                  color: "var(--color-prax-green)",
                }}
              >
                Tweaks
              </div>
              <button
                onClick={() => setTweaksOpen(false)}
                aria-label="Close tweaks"
                className="cursor-pointer"
                style={{
                  background: "none",
                  border: "none",
                  color: "var(--color-prax-ink-mute)",
                  fontSize: 18,
                  lineHeight: 1,
                  padding: 0,
                }}
              >
                ×
              </button>
            </div>
            <div
              className="font-semibold uppercase mb-1.5"
              style={{
                fontSize: 10,
                letterSpacing: "0.14em",
                color: "var(--color-prax-ink-mute)",
              }}
            >
              Background treatment
            </div>
            <div
              className="grid gap-1.5"
              style={{ gridTemplateColumns: "repeat(3, 1fr)" }}
            >
              {TREATMENTS.map((t) => {
                const active = t.id === variant;
                return (
                  <button
                    key={t.id}
                    onClick={() => pick(t.id)}
                    className="cursor-pointer transition-colors"
                    style={{
                      padding: "8px 6px",
                      borderRadius: 8,
                      fontSize: 11,
                      fontWeight: 500,
                      background: active
                        ? "var(--color-prax-green)"
                        : "var(--color-prax-cream)",
                      color: active
                        ? "var(--color-prax-cream)"
                        : "var(--color-prax-ink)",
                      border: `1px solid ${
                        active
                          ? "var(--color-prax-green)"
                          : "var(--color-prax-cream-border)"
                      }`,
                      textAlign: "center",
                    }}
                  >
                    {t.label}
                  </button>
                );
              })}
            </div>
          </div>
        ) : (
          <button
            onClick={() => setTweaksOpen(true)}
            className="cursor-pointer"
            aria-label="Open tweaks"
            style={{
              width: 36,
              height: 36,
              borderRadius: "50%",
              background: "var(--color-prax-cream-card)",
              border: "1px solid var(--color-prax-cream-border)",
              boxShadow: "0 8px 20px -10px rgba(3,56,48,0.25)",
              display: "grid",
              placeItems: "center",
              color: "var(--color-prax-green)",
            }}
          >
            <svg
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="1.6"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <circle cx="12" cy="12" r="3" />
              <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
            </svg>
          </button>
        )}
      </div>
    </>
  );
}
