"use client";

import { useState } from "react";

/**
 * Landscape gate for flashcard study. On a phone held in PORTRAIT it shows a
 * "turn your phone sideways" prompt; in landscape (or on any non-touch device)
 * it renders the study screen. The gate itself is pure CSS (orientation +
 * coarse-pointer media query) so there's no flash of the wrong state on load.
 *
 * ESCAPE HATCH: many people study with the iOS system rotation-lock ON, so the
 * browser never actually rotates and the media query can't flip — they'd be
 * stuck on the prompt forever. The "Continue in portrait" button overrides the
 * gate (via a class toggle) so study is always reachable. StudySurface is
 * mobile-first and works in portrait too; landscape is just the nicer default.
 *
 * iOS web apps can't lock orientation, so this prompt is how we nudge users
 * into landscape; a future native (Capacitor) build could auto-lock instead.
 */
export default function RotateGate({ children }: { children: React.ReactNode }) {
  const [override, setOverride] = useState(false);
  const force = override ? " pxt-force" : "";

  return (
    <>
      <style>{`
        .pxt-rotate{display:none}
        .pxt-study{display:contents}
        @media (orientation:portrait) and (pointer:coarse){
          .pxt-rotate{display:flex}
          .pxt-study{display:none}
        }
        /* Override: user chose to study in portrait — always show the card. */
        .pxt-rotate.pxt-force{display:none!important}
        .pxt-study.pxt-force{display:contents!important}
        @keyframes pxt-tip{0%,55%{transform:rotate(0)}75%,100%{transform:rotate(-90deg)}}
      `}</style>

      <div className={`pxt-rotate${force} flex-col items-center justify-center gap-5 text-center min-h-[calc(100dvh-3.5rem)] px-8`}>
        <div
          className="relative border-[3px] border-as-primary rounded-xl"
          style={{ width: 52, height: 86, animation: "pxt-tip 2.2s ease-in-out infinite" }}
        >
          <span className="absolute left-1/2 -translate-x-1/2 bottom-1.5 w-4 h-[2.5px] rounded bg-as-primary/50" />
        </div>
        <h2 className="font-headline text-2xl text-as-primary">Turn your phone sideways</h2>
        <p className="text-sm text-as-on-surface-variant max-w-[280px] leading-relaxed">
          Flashcards study best in landscape. Rotate your phone to begin.
        </p>
        <button
          type="button"
          onClick={() => setOverride(true)}
          className="mt-1 text-xs font-bold uppercase tracking-widest text-as-outline underline underline-offset-4 hover:text-as-primary py-2 px-3"
        >
          Continue in portrait
        </button>
      </div>

      <div className={`pxt-study${force}`}>{children}</div>
    </>
  );
}
