"use client";

import Link from "next/link";
import { useEffect, useState, useSyncExternalStore } from "react";
import { createPortal } from "react-dom";
import { recoverImageSession } from "@/lib/flashcards/ensureImageSession";
import type { ClozeSegment } from "@/lib/flashcards/cloze";
import type { Rating } from "@/lib/flashcards/scheduler";
import type { RelearnAnswer } from "@/lib/flashcards/relearn";
import RichText from "@/components/flashcards/RichText";

/**
 * Presentational study surface — the card + reveal + grade controls, shared by
 * the cross-deck session and the per-deck study pages.
 *
 * Mobile-first: fills the viewport, the card is the centered focus, and the
 * action bar is pinned to the bottom (thumb zone) with safe-area padding.
 * Before reveal it shows a single "Show answer" button; after reveal, the four
 * grade buttons — or, on a card that came back owing recalls, the two
 * repeat-view buttons instead. See `owed` below. On desktop (lg) it relaxes to
 * the classic card-with-buttons layout so the page's context rail sits beside
 * it.
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
  /**
   * An image belonging to the ANSWER, shown under the card once revealed and
   * absent otherwise. Distinct from an image inside the card text, which is
   * part of the prompt and stays on the front: on the amino acid cards the
   * structure IS the question.
   */
  backImageUrl?: string | null;
  backImageAlt?: string | null;

  revealed: boolean;
  onFlip: () => void;

  submitting: boolean;
  onRate: (rating: Rating) => void;
  /**
   * Successful recalls this card still owes before it may leave the session.
   * Above zero the card is a REPEAT: it was already graded minutes ago and has
   * come back to be retrieved, so the four-point scale is replaced by the one
   * question a repeat actually asks. Grading a card Easy thirty seconds after
   * failing it measured working memory and overwrote the Again that mattered.
   */
  owed?: number;
  /** Answer to a repeat view. Required whenever `owed` can be above zero. */
  onRecallAnswer?: (answer: RelearnAnswer) => void;
  onSuspend: () => void;
}

// WORST ON THE LEFT, BEST ON THE RIGHT, exactly like the grade bar above it.
//
// Shipped the other way round and it cost Mikko a whole session. The grade bar
// runs Again, Hard, Medium, Easy, so the hand learns "reach right to say I knew
// it". Putting Correct on the left inverted that, every repeat he answered
// landed on Missed, and Missed resets the debt: two cards cycled seven times
// each before the appearance cap let them go. Every repeat in the review log
// that evening was written as "again", which is what told us.
//
// Key 1 is the wrong answer on both bars, for the same reason.
const RECALL: { answer: RelearnAnswer; label: string; key: string; className: string }[] = [
  { answer: "missed", label: "Missed", key: "1", className: "bg-[#a8432c] hover:bg-[#96371f]" },
  { answer: "correct", label: "Correct", key: "2", className: "bg-as-primary hover:bg-as-primary-container" },
];

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
  backImageUrl,
  backImageAlt,
  revealed,
  onFlip,
  submitting,
  onRate,
  owed = 0,
  onRecallAnswer,
  onSuspend,
}: StudySurfaceProps) {
  // A repeat view needs somewhere to send the answer. Without a handler the
  // buttons would render and do nothing, so fall back to the grade bar.
  const isRepeatView = owed > 0 && !!onRecallAnswer;
  // The answer image, when the card has one and the answer is showing. Win or
  // lose: it appears on reveal, not on a passing grade.
  const showAnswerImage = revealed && !!backImageUrl;

  // ─── Full-size view of the answer illustration ─────────────────────────────
  //
  // The artwork is 1456px wide and dense with labels. The study column is at
  // most 840px with the context rail beside it, so the finest labels only
  // resolve in an overlay. In-page the figure takes the whole column; the
  // overlay is what makes the detail readable.
  // WHAT IS STORED IS *WHICH IMAGE* IS OPEN, NOT A BOOLEAN.
  //
  // A boolean needed an effect to put it back to false whenever the card
  // changed, or the overlay would reopen over the next card's answer. Holding
  // the image's own url instead makes that impossible to get wrong: the
  // overlay is open only while the stored url is still the card's url, so
  // advancing closes it as a consequence of the data rather than of a tidy-up
  // effect that has to remember to run.
  const [zoomedUrl, setZoomedUrl] = useState<string | null>(null);
  const zoomed = showAnswerImage && zoomedUrl === backImageUrl;

  // ── ONE recovery attempt when an illustration fails to load ─────────────
  //
  // The image session cookie lasts fifteen minutes and is normally renewed
  // underneath the learner. If one ever lapses anyway, the browser shows a
  // broken image and nothing in the page notices. So a failure gets exactly one
  // chance: re-mint, then reload this same protected path with a cache-busting
  // parameter, because the browser will not re-request a URL it has just
  // failed on.
  //
  // Keyed by url, so the allowance resets on the next card and can never
  // become a loop: one attempt per image, and a second failure is left alone.
  // Recovery proves identity, never entitlement — an unentitled account gets a
  // perfectly valid cookie and is still refused, which is correct.
  const [retriedUrl, setRetriedUrl] = useState<string | null>(null);
  const [retryToken, setRetryToken] = useState(0);
  const imageSrc = backImageUrl
    ? (retriedUrl === backImageUrl && retryToken > 0
        ? `${backImageUrl}?r=${retryToken}`
        : backImageUrl)
    : null;

  async function recoverOnce() {
    if (!backImageUrl || retriedUrl === backImageUrl) return;
    setRetriedUrl(backImageUrl);
    const ok = await recoverImageSession();
    if (ok) setRetryToken(Date.now());
  }

  // The overlay is portalled to document.body, which exists only in the
  // browser, so nothing may be portalled on the server's first render. This is
  // the "am I hydrated" subscription: it returns false on the server and true
  // in the browser without setting state from an effect.
  const mounted = useSyncExternalStore(
    () => () => {},
    () => true,
    () => false,
  );

  // Closing must also drop focus. The trigger is a button, so leaving it
  // focused meant the learner's next Space — the key that reveals and
  // advances all day — activated the button and reopened the image instead.
  // Caught on the preview: Escape, Space, and the overlay came straight back.
  function closeZoom() {
    setZoomedUrl(null);
    const active = typeof document === "undefined" ? null : document.activeElement;
    if (active instanceof HTMLElement) active.blur();
  }

  // While the overlay is open it owns the keyboard and the page does not
  // scroll behind it. The listener is in the CAPTURE phase on window so the
  // study page's own window handler never sees these keys: without that,
  // Space would flip the card and 1-4 would grade it, both underneath an
  // overlay still showing the old answer.
  useEffect(() => {
    if (!zoomed) return;
    function onKey(e: KeyboardEvent) {
      e.stopPropagation();
      if (e.key === " ") e.preventDefault();
      if (e.key === "Escape") closeZoom();
    }
    window.addEventListener("keydown", onKey, true);
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    return () => {
      window.removeEventListener("keydown", onKey, true);
      document.body.style.overflow = previousOverflow;
    };
  }, [zoomed]);

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
      {/*
        A column, so an answer image can sit under the card. With no image the
        geometry is unchanged: a column's justify-center is a row's items-center,
        and the card keeps h-full so it still fills the landscape screen. With
        one, the card shrinks to its content and the pair scrolls together,
        because on a phone a card plus a diagram will not always fit.
      */}
      <div
        className={`flex-1 flex flex-col min-h-0 my-2 lg:mt-3 lg:mb-0 ${
          showAnswerImage
            ? "justify-start gap-3 overflow-y-auto"
            : "justify-center lg:justify-start lg:flex-none"
        }`}
      >
        <div className={`relative w-full ${showAnswerImage ? "shrink-0" : "h-full"} lg:h-auto max-w-[760px] lg:max-w-[840px] mx-auto rounded-[1.75rem] p-[1.5px] bg-gradient-to-br from-as-outline-variant/40 via-as-primary/10 to-as-outline-variant/40 shadow-[0_30px_60px_-20px_rgba(0,54,48,0.18),0_8px_24px_-12px_rgba(0,54,48,0.12)]`}>
          <button
            onClick={onFlip}
            // A card on its own reserves 420px so a one-line cloze still
            // reads as a card. With an illustration below it that reserved
            // height is dead space that pushes the diagram off a laptop
            // screen, so the prompt shrinks to its content instead and the
            // vertical room goes to the artwork.
            className={`relative w-full h-full flex items-center justify-center bg-as-surface-container-lowest rounded-[calc(1.75rem-1.5px)] px-6 py-5 sm:px-10 text-center hover:bg-white transition-colors overflow-y-auto ${
              showAnswerImage
                ? "lg:px-14 lg:py-8 lg:min-h-0 lg:max-h-[280px]"
                : "lg:p-14 lg:min-h-[420px] lg:max-h-[480px]"
            }`}
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

        {/*
          A card with no answer image renders NOTHING here: no frame, no
          reserved space, no gap. That was the whole requirement, so it is a
          plain conditional rather than an empty container that collapses.
        */}
        {showAnswerImage && (
          <figure className="w-full max-w-[760px] lg:max-w-[840px] mx-auto shrink-0 rounded-[1.5rem] border border-as-outline-variant/25 bg-as-surface-container-lowest p-3 sm:p-4 shadow-[0_12px_32px_-20px_rgba(0,54,48,0.18)]">
            {/*
              No desktop height cap: the figure takes the whole column and the
              image's own aspect ratio sets its height. The old 300px cap was
              exactly the height a 1456x600 illustration reached at the old
              760px width, so it bound on every card and threw away the width.

              The keydown handler is not decoration. The study page listens on
              window and preventDefaults Space and Enter, so without stopping
              the event here a keyboard user activating this button would flip
              the card instead of opening the image.
            */}
            <button
              type="button"
              onClick={() => setZoomedUrl(backImageUrl ?? null)}
              onKeyDown={(e) => {
                // Enter only. Space belongs to the study page — it reveals and
                // advances — and a focused button that swallowed it would
                // break the one key the learner presses hundreds of times.
                if (e.key === "Enter") {
                  e.preventDefault();
                  e.stopPropagation();
                  setZoomedUrl(backImageUrl ?? null);
                }
              }}
              aria-label="View this illustration at full size"
              className="group block w-full cursor-zoom-in rounded-xl focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-as-primary"
            >
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={imageSrc!}
                alt={backImageAlt ?? ""}
                onError={() => { void recoverOnce(); }}
                className="w-full max-h-[38dvh] lg:max-h-none object-contain rounded-xl"
              />
              <span className="hidden lg:flex items-center justify-center gap-1.5 pt-2 text-[10px] font-bold uppercase tracking-wider text-as-outline/70 group-hover:text-as-primary transition-colors">
                <svg className="w-3 h-3" fill="none" stroke="currentColor" strokeWidth={2.2} viewBox="0 0 24 24">
                  <circle cx="11" cy="11" r="7" />
                  <path d="M20 20l-4.5-4.5M11 8.5v5M8.5 11h5" strokeLinecap="round" />
                </svg>
                Click to enlarge
              </span>
            </button>
          </figure>
        )}
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
            {isRepeatView ? (
              <div className="grid grid-cols-2 gap-2 sm:gap-3">
                {RECALL.map(({ answer, label, key, className }) => (
                  <button
                    key={answer}
                    onClick={() => onRecallAnswer!(answer)}
                    disabled={submitting}
                    className={`flex flex-col items-center gap-0.5 py-3.5 rounded-2xl text-xs font-bold uppercase tracking-wide text-white transition-colors disabled:opacity-50 shadow-[0_8px_24px_-14px_rgba(0,54,48,0.45)] ${className}`}
                  >
                    <span>{label}</span>
                    <span className="text-[9px] font-medium opacity-80 normal-case tracking-normal">
                      {answer === "missed"
                        ? "back to 3"
                        : owed === 1
                          ? "clears it"
                          : `${owed - 1} more`}{" "}
                      · {key}
                    </span>
                  </button>
                ))}
              </div>
            ) : (
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
                    {key}
                  </span>
                </button>
              ))}
            </div>
            )}
            <button
              onClick={onSuspend}
              className="w-full text-[10px] font-bold uppercase tracking-widest text-as-outline hover:text-as-primary py-1.5"
            >
              Suspend this card
            </button>
          </div>
        )}
      </div>

      {/*
        The full-size view.

        Portalled to document.body on purpose: the study page's wrapper is its
        own stacking context (`relative z-[1]`) and the sidebar and bottom tabs
        live outside it, so an overlay rendered in place would be trapped
        beneath them whatever z-index it carried.
      */}
      {mounted && zoomed && backImageUrl
        ? createPortal(
            <div
              role="dialog"
              aria-modal="true"
              aria-label={backImageAlt ?? "Illustration at full size"}
              onClick={closeZoom}
              className="fixed inset-0 z-[200] flex items-center justify-center cursor-zoom-out bg-[rgba(0,54,48,0.9)] p-3 sm:p-6 lg:p-8"
            >
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={imageSrc ?? backImageUrl}
                alt={backImageAlt ?? ""}
                // Clicking the artwork itself must not dismiss the thing the
                // learner opened to study.
                onClick={(e) => e.stopPropagation()}
                className="max-w-full max-h-full w-auto h-auto object-contain rounded-xl bg-white cursor-default shadow-[0_40px_120px_-30px_rgba(0,0,0,0.55)]"
              />
              <button
                type="button"
                onClick={closeZoom}
                aria-label="Close the full-size view"
                className="absolute top-3 right-3 sm:top-5 sm:right-5 inline-flex items-center gap-1.5 rounded-full bg-white/10 px-3 py-2 text-[10px] font-bold uppercase tracking-widest text-white/75 hover:bg-white/20 hover:text-white transition-colors"
              >
                <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth={2.5} viewBox="0 0 24 24">
                  <path d="M6 18L18 6M6 6l12 12" strokeLinecap="round" />
                </svg>
                {/* A phone has no Esc key, and the button is tapped there. */}
                <span className="hidden sm:inline">Esc</span>
              </button>
            </div>,
            document.body,
          )
        : null}
    </div>
  );
}
