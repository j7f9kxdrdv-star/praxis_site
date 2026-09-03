"use client";

import Link from "next/link";
import type { ClozeSegment } from "@/lib/flashcards/cloze";
import { previewLabel, type Rating } from "@/lib/flashcards/scheduler";
import RichText from "@/components/flashcards/RichText";

/**
 * Presentational study surface — the card + reveal + grade controls, shared by
 * the cross-deck session and the per-deck study pages.
 *
 * Mobile-first: fills the viewport, the card is the centered focus, and the
 * action bar is pinned to the bottom (thumb zone) with safe-area padding.
 * Before reveal it shows a single "Show answer" button; after reveal, the four
 * grade buttons. On desktop (lg) it relaxes to the classic card-with-buttons
 * layout so the page's context rail sits beside it.
 *
 * Purely presentational: all state + handlers come from the parent page.
 */

export interface StudySurfaceProps {
  exitHref: string;
  starred: boolean;
  onToggleStar: () => void;
  /** Session progress for the mobile header pill (rail is hidden on mobile). */
  progress?: { done: number; total: number };

  cardType: "basic" | "cloze";
  segments: ClozeSegment[];
  frontText?: string | null;
  backText?: string | null;
  explanation?: string | null;
  hint?: string;

  revealed: boolean;
  onFlip: () => void;

  intervalDays: number;
  /** Per-card ease factor, for accurate interval previews on the grade buttons. */
  easeFactor: number;
  /** The card's stored last rating — "again" means this is a post-lapse recheck. */
  lastRating: Rating | null;
  submitting: boolean;
  onRate: (rating: Rating) => void;
  onSuspend: () => void;
}

const GRADES: { rating: Rating; label: string; key: string; className: string }[] = [
  { rating: "again", label: "Again", key: "1", className: "bg-[#a8432c] hover:bg-[#96371f]" },
  { rating: "hard", label: "Hard", key: "2", className: "bg-[#87621d] hover:bg-[#725217]" },
  { rating: "medium", label: "Medium", key: "3", className: "bg-as-primary hover:bg-as-primary-container" },
  { rating: "easy", label: "Easy", key: "4", className: "bg-[#0b6f56] hover:bg-[#095b47]" },
];

export default function StudySurface({
  exitHref,
  starred,
  onToggleStar,
  progress,
  cardType,
  segments,
  frontText,
  backText,
  explanation,
  hint,
  revealed,
  onFlip,
  intervalDays,
  easeFactor,
  lastRating,
  submitting,
  onRate,
  onSuspend,
}: StudySurfaceProps) {
  const pct =
    progress && progress.total > 0
      ? Math.round((progress.done / progress.total) * 100)
      : null;

  return (
    <div className="flex flex-1 flex-col min-h-[calc(100dvh-3.5rem)] lg:min-h-0">
      {/* ── Top bar ─────────────────────────────────────────────── */}
      <div className="flex items-center justify-between gap-3 shrink-0 px-1 pt-[max(env(safe-area-inset-top),0px)]">
        <Link
          href={exitHref}
          className="inline-flex items-center gap-1.5 text-[11px] font-bold uppercase tracking-wider text-as-outline hover:text-as-primary transition-colors py-2 pr-2"
        >
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
            <path d="M6 18L18 6M6 6l12 12" strokeLinecap="round" />
          </svg>
          Exit
        </Link>

        {/* Progress — mobile only (desktop shows it in the rail) */}
        {pct !== null && (
          <div className="lg:hidden flex items-center gap-2 min-w-0 flex-1 max-w-[210px]">
            <div className="h-1.5 flex-1 rounded-full bg-as-primary/12 overflow-hidden">
              <div className="h-full rounded-full bg-as-primary transition-[width] duration-300" style={{ width: `${pct}%` }} />
            </div>
            <span className="text-[11px] font-semibold tabular-nums text-as-outline shrink-0">
              {progress!.done}/{progress!.total}
            </span>
          </div>
        )}

        <button
          onClick={onToggleStar}
          aria-label={starred ? "Unstar card" : "Star card"}
          className={`text-xl transition-transform hover:scale-110 py-2 pl-2 ${starred ? "text-amber-500" : "text-as-outline hover:text-as-primary"}`}
        >
          {starred ? "★" : "☆"}
        </button>
      </div>

      {/* ── Card — fills the landscape screen; a wide horizontal card ─── */}
      <div className="flex-1 flex items-center justify-center lg:items-start lg:flex-none min-h-0 my-2 lg:mt-3 lg:mb-0">
        <div className="relative w-full h-full lg:h-auto max-w-[760px] mx-auto rounded-[1.75rem] p-[1.5px] bg-gradient-to-br from-as-outline-variant/40 via-as-primary/10 to-as-outline-variant/40 shadow-[0_30px_60px_-20px_rgba(0,54,48,0.18),0_8px_24px_-12px_rgba(0,54,48,0.12)]">
          <button
            onClick={onFlip}
            className="relative w-full h-full flex items-center justify-center bg-as-surface-container-lowest rounded-[calc(1.75rem-1.5px)] px-6 py-5 sm:px-10 lg:p-14 text-center lg:min-h-[420px] lg:max-h-[480px] hover:bg-white transition-colors overflow-y-auto"
          >
            <div className="w-full max-w-3xl mx-auto">
              {cardType === "cloze" ? (
                <p className="font-headline text-xl sm:text-2xl text-as-primary leading-relaxed">
                  {segments.map((seg, i) =>
                    seg.kind === "text" ? (
                      <span key={i}><RichText>{seg.text}</RichText></span>
                    ) : seg.kind === "image" ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img key={i} src={seg.src} alt={seg.alt} className="block mx-auto my-4 max-h-56 sm:max-h-72 lg:max-h-80 w-auto object-contain" />
                    ) : seg.revealed ? (
                      <span key={i} className="inline-block bg-as-primary/10 text-as-primary font-bold italic px-2 py-0.5 rounded-md transition-all">
                        <RichText>{seg.answer}</RichText>
                      </span>
                    ) : (
                      <span key={i} className="inline-block bg-as-primary/15 text-transparent font-bold rounded-md px-2 py-0.5 select-none" title={seg.hint || ""}>
                        {/* Screen readers should hear a blank, not the answer.
                            The visible (transparent) text only reserves width. */}
                        <span className="sr-only">(blank)</span>
                        <span aria-hidden="true"><RichText>{seg.answer}</RichText></span>
                      </span>
                    ),
                  )}
                  {!revealed && hint && (
                    <span className="block mt-4 text-xs text-as-outline italic">Hint: {hint}</span>
                  )}
                </p>
              ) : (
                <div>
                  <p className="font-headline text-xl sm:text-2xl text-as-primary leading-relaxed mb-4">{frontText}</p>
                  {revealed && backText && (
                    <div className="pt-4 mt-4 border-t border-as-outline-variant/20">
                      <p className="text-sm sm:text-base text-as-on-surface-variant leading-relaxed">{backText}</p>
                    </div>
                  )}
                </div>
              )}

              {revealed && explanation && (
                <p className="mt-5 text-xs text-as-outline italic leading-relaxed">{explanation}</p>
              )}
            </div>
          </button>
        </div>
      </div>

      {/* ── Action bar — pinned to the bottom on mobile ─────────── */}
      <div className="shrink-0 mt-auto lg:mt-6 pt-3 lg:pt-0 pb-[max(env(safe-area-inset-bottom),0.25rem)]">
        {!revealed ? (
          <button
            onClick={onFlip}
            className="w-full py-4 rounded-2xl text-sm font-bold uppercase tracking-wider bg-as-primary text-white hover:bg-as-primary-container transition-colors shadow-[0_8px_24px_-12px_rgba(0,54,48,0.4)]"
          >
            Show answer
          </button>
        ) : (
          <div className="space-y-2.5">
            <div className="grid grid-cols-4 gap-2 sm:gap-3">
              {GRADES.map(({ rating, label, key, className }) => (
                <button
                  key={rating}
                  onClick={() => onRate(rating)}
                  disabled={submitting}
                  className={`flex flex-col items-center gap-0.5 py-3.5 rounded-2xl text-xs font-bold uppercase tracking-wide text-white transition-colors disabled:opacity-50 shadow-[0_8px_24px_-14px_rgba(0,54,48,0.45)] ${className}`}
                >
                  <span>{label}</span>
                  <span className="text-[9px] font-medium opacity-80 normal-case tracking-normal">
                    {previewLabel(intervalDays, easeFactor, lastRating, rating)} · {key}
                  </span>
                </button>
              ))}
            </div>
            <button
              onClick={onSuspend}
              className="w-full text-[10px] font-bold uppercase tracking-widest text-as-outline hover:text-as-primary py-1.5"
            >
              Suspend this card
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
