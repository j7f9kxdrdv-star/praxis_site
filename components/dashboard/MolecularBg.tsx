/**
 * Faint scientific motif background for dashboard pages.
 * Decorative only — sits behind content at low opacity.
 *
 * Variants:
 *
 *   Section-themed (use directly via PraxPage `bgVariant`):
 *     "hex"       — Hex lattice + orbital rings + DNA strip. Dashboard.
 *     "neurons"   — Neurons + dendrites + a synaptic cleft. (Legacy; kept
 *                   in case we want to revert to it.)
 *     "study"     — Pencils, glasses, pens, markers, highlighters scattered
 *                   along visible cream zones. Analytics.
 *
 *   Flashcards Tweaks panel (switchable per-user):
 *     "none"      — Flat cream, nothing rendered.
 *     "grid"      — Paper graph ruling fading toward edges (Graph).
 *     "botanical" — Laurel wreath SVG flanking the card.
 *     "halo"      — Soft radial glow + concentric rings centered on card.
 *     "glyphs"    — Tiled Greek letter pattern (λ Ψ φ Ω). Default flashcards.
 *     "stack"     — Ghosted paper cards behind active one.
 *     "contour"   — Topographic ellipses radiating from center.
 *
 * For the Flashcards variants we port the SVG / CSS values verbatim from the
 * Claude Design prototype `Flashcards.html` so the visual matches the
 * intent. Don't redraw — copy values exactly.
 */

import { ReactNode } from "react";

export type BgVariant =
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

export default function MolecularBg({
  opacity,
  color = "#054f46",
  variant = "hex",
}: {
  opacity?: number;
  color?: string;
  variant?: BgVariant;
}) {
  // Per-variant default opacity. The Flashcards-prototype variants
  // (grid/botanical/halo/glyphs/stack/contour) bake their own rgba alphas
  // into the SVG/CSS, so the wrapper opacity stays at 1.0 for those.
  const variantDefaultOpacity: Record<BgVariant, number> = {
    hex: 0.07,
    neurons: 0.12,
    study: 0.11,
    none: 1,
    grid: 1,
    botanical: 1,
    halo: 1,
    glyphs: 1,
    stack: 1,
    contour: 1,
  };
  const finalOpacity = opacity ?? variantDefaultOpacity[variant];

  // Variants that render as a single full-bleed <svg>:
  const isSvgVariant =
    variant === "hex" ||
    variant === "neurons" ||
    variant === "study";

  if (variant === "none") return null;

  if (isSvgVariant) {
    return (
      <svg
        aria-hidden
        className="pointer-events-none absolute inset-0 h-full w-full"
        style={{ opacity: finalOpacity }}
        xmlns="http://www.w3.org/2000/svg"
        preserveAspectRatio="xMidYMid slice"
      >
        {variant === "hex" && <HexMotif color={color} />}
        {variant === "neurons" && <NeuronMotif color={color} />}
        {variant === "study" && <StudyMotif color={color} />}
      </svg>
    );
  }

  // DOM-based / mixed variants from the Flashcards prototype.
  return (
    <div
      aria-hidden
      className="pointer-events-none absolute inset-0 overflow-hidden"
      style={{ opacity: finalOpacity }}
    >
      {variant === "grid" && <GridTreatment />}
      {variant === "botanical" && <BotanicalTreatment />}
      {variant === "halo" && <HaloTreatment />}
      {variant === "glyphs" && <GlyphsTreatment />}
      {variant === "stack" && <StackTreatment />}
      {variant === "contour" && <ContourTreatment />}
    </div>
  );
}

/* ────────────────────────────────────────────────────────── */
/* HEX variant — original dashboard motif                      */
/* ────────────────────────────────────────────────────────── */

function HexMotif({ color }: { color: string }) {
  return (
    <>
      <defs>
        <pattern
          id="hexgrid"
          x="0"
          y="0"
          width="84"
          height="97"
          patternUnits="userSpaceOnUse"
        >
          <g fill="none" stroke={color} strokeWidth="0.7">
            <polygon points="42,4 78,24 78,68 42,88 6,68 6,24" />
            <circle cx="42" cy="4" r="1.4" fill={color} stroke="none" />
            <circle cx="78" cy="24" r="1.4" fill={color} stroke="none" />
            <circle cx="78" cy="68" r="1.4" fill={color} stroke="none" />
            <circle cx="42" cy="88" r="1.4" fill={color} stroke="none" />
            <circle cx="6" cy="24" r="1.4" fill={color} stroke="none" />
            <circle cx="6" cy="68" r="1.4" fill={color} stroke="none" />
          </g>
        </pattern>
      </defs>
      <rect x="0" y="0" width="100%" height="100%" fill="url(#hexgrid)" />

      <g stroke={color} fill="none" strokeWidth="0.8" opacity="0.9">
        <g transform="translate(180 220)">
          <ellipse cx="0" cy="0" rx="60" ry="22" />
          <ellipse cx="0" cy="0" rx="60" ry="22" transform="rotate(60)" />
          <ellipse cx="0" cy="0" rx="60" ry="22" transform="rotate(120)" />
          <circle cx="0" cy="0" r="3" fill={color} />
        </g>
        <g transform="translate(1320 780)">
          <ellipse cx="0" cy="0" rx="52" ry="19" />
          <ellipse cx="0" cy="0" rx="52" ry="19" transform="rotate(60)" />
          <ellipse cx="0" cy="0" rx="52" ry="19" transform="rotate(120)" />
          <circle cx="0" cy="0" r="2.4" fill={color} />
        </g>
        <g transform="translate(1100 140)">
          <circle r="38" />
          <circle r="22" />
          <circle r="8" fill={color} />
        </g>
        <g transform="translate(420 920)">
          <circle r="44" />
          <circle r="26" />
          <circle r="10" fill={color} />
        </g>
      </g>

      <g
        stroke={color}
        fill="none"
        strokeWidth="0.9"
        transform="translate(760 40)"
      >
        <path d="M0 0 Q 20 30 0 60 T 0 120 T 0 180 T 0 240 T 0 300" />
        <path d="M0 0 Q -20 30 0 60 T 0 120 T 0 180 T 0 240 T 0 300" />
        <g stroke={color} strokeWidth="0.6">
          {Array.from({ length: 10 }, (_, i) => (
            <line key={i} x1="-14" x2="14" y1={15 + i * 30} y2={15 + i * 30} />
          ))}
        </g>
      </g>
    </>
  );
}

/* ────────────────────────────────────────────────────────── */
/* NEURON variant — for legacy Flashcards (kept for opt-in)    */
/* ────────────────────────────────────────────────────────── */

function Neuron({ color }: { color: string }): ReactNode {
  return (
    <>
      <circle cx="0" cy="0" r="5.5" fill={color} stroke="none" />
      <g
        fill="none"
        stroke={color}
        strokeWidth="1"
        strokeLinecap="round"
      >
        <path d="M-3,-3 Q-15,-18 -28,-26 Q-34,-30 -32,-40" />
        <path d="M-28,-26 Q-38,-26 -44,-22" />
        <path d="M-32,-40 Q-30,-50 -22,-54" />
        <path d="M3,-3 Q12,-18 22,-26 Q28,-30 32,-26" />
        <path d="M22,-26 Q26,-36 22,-44" />
        <path d="M-4,2 Q-18,10 -30,16 Q-40,18 -44,12" />
        <path d="M-30,16 Q-32,26 -28,32" />
        <path d="M4,2 Q15,8 22,14" />
      </g>
      <g
        fill="none"
        stroke={color}
        strokeWidth="1.1"
        strokeLinecap="round"
      >
        <path d="M5,0 L 50,2" />
        <path d="M55,3 L 95,5" />
        <path d="M100,5 L 138,4" />
      </g>
      <circle cx="142" cy="4" r="2.2" fill={color} stroke="none" />
    </>
  );
}

function NeuronMotif({ color }: { color: string }) {
  return (
    <>
      <defs>
        <pattern
          id="prax-vesicles"
          x="0"
          y="0"
          width="92"
          height="92"
          patternUnits="userSpaceOnUse"
        >
          <g fill={color}>
            <circle cx="14" cy="22" r="1.4" />
            <circle cx="58" cy="14" r="1.1" />
            <circle cx="78" cy="48" r="1.3" />
            <circle cx="40" cy="56" r="1.2" />
            <circle cx="22" cy="76" r="1.3" />
            <circle cx="68" cy="80" r="1.0" />
          </g>
          <g fill="none" stroke={color} strokeWidth="0.7">
            <path d="M30,30 Q38,34 44,32" />
            <path d="M62,62 Q56,66 50,64" />
          </g>
        </pattern>
      </defs>
      <rect x="0" y="0" width="100%" height="100%" fill="url(#prax-vesicles)" />
      <g transform="translate(180 230) rotate(-15) scale(1.05)"><Neuron color={color} /></g>
      <g transform="translate(1140 160) rotate(195) scale(0.95)"><Neuron color={color} /></g>
      <g transform="translate(380 880) rotate(40) scale(1.1)"><Neuron color={color} /></g>
      <g transform="translate(1280 760) rotate(165) scale(1.0)"><Neuron color={color} /></g>
      <g transform="translate(820 440) rotate(85) scale(0.9)"><Neuron color={color} /></g>
      <g transform="translate(760 60)">
        <g fill="none" stroke={color} strokeWidth="1.1" strokeLinecap="round">
          <path d="M-26,-4 Q-22,-22 -4,-24 Q14,-22 22,-10 Q22,-2 22,4" />
          <path d="M-26,-4 Q-26,4 -22,8" />
        </g>
        <g fill={color}>
          <circle cx="-12" cy="-12" r="1.6" />
          <circle cx="2" cy="-14" r="1.6" />
          <circle cx="14" cy="-8" r="1.4" />
          <circle cx="-4" cy="-4" r="1.2" />
          <circle cx="10" cy="-2" r="1.3" />
        </g>
        <g fill={color}>
          <circle cx="-6" cy="14" r="0.9" />
          <circle cx="2" cy="16" r="0.9" />
          <circle cx="10" cy="14" r="0.9" />
          <circle cx="-2" cy="20" r="0.8" />
          <circle cx="6" cy="22" r="0.8" />
        </g>
        <g fill="none" stroke={color} strokeWidth="1.1" strokeLinecap="round">
          <path d="M-26,32 Q-22,50 -4,52 Q14,50 22,40 Q22,32 22,26" />
          <path d="M-26,32 Q-26,24 -22,20" />
        </g>
      </g>
    </>
  );
}

/* ────────────────────────────────────────────────────────── */
/* STUDY variant — for Analytics                                */
/* ────────────────────────────────────────────────────────── */

function Pencil({ color }: { color: string }): ReactNode {
  return (
    <g>
      <rect x="-35" y="-3" width="6" height="6" fill={color} />
      <rect x="-29" y="-3" width="2" height="6" fill={color} opacity="0.55" />
      <rect x="-27" y="-3" width="48" height="6" fill="none" stroke={color} strokeWidth="0.95" />
      <path d="M21,-3 L29,-1.5 L29,1.5 L21,3 Z" fill="none" stroke={color} strokeWidth="0.95" />
      <path d="M29,-1.5 L34,0 L29,1.5 Z" fill={color} />
    </g>
  );
}

function Glasses({ color }: { color: string }): ReactNode {
  return (
    <g fill="none" stroke={color} strokeWidth="1.05" strokeLinecap="round">
      <circle cx="-12" cy="0" r="9" />
      <circle cx="12" cy="0" r="9" />
      <line x1="-3" y1="0" x2="3" y2="0" />
      <path d="M-21,0 L-26,-2 L-29,-2" />
      <path d="M21,0 L26,-2 L29,-2" />
    </g>
  );
}

function Pen({ color }: { color: string }): ReactNode {
  return (
    <g>
      <rect x="-25" y="-2" width="38" height="4" fill="none" stroke={color} strokeWidth="0.95" />
      <line x1="-13" y1="-2" x2="-13" y2="2" stroke={color} strokeWidth="0.95" />
      <rect x="-23" y="-3.5" width="6" height="1.4" fill={color} />
      <path d="M13,-2 L21,0 L13,2 Z" fill={color} />
      <line x1="15" y1="0" x2="20" y2="0" stroke="#fff" strokeWidth="0.4" opacity="0.5" />
    </g>
  );
}

function Marker({ color }: { color: string }): ReactNode {
  return (
    <g>
      <rect x="-18" y="-4" width="28" height="8" fill="none" stroke={color} strokeWidth="0.95" />
      <line x1="-6" y1="-4" x2="-6" y2="4" stroke={color} strokeWidth="0.95" />
      <path d="M10,-3 L16,-1 L16,1 L10,3 Z" fill={color} />
    </g>
  );
}

function Highlighter({ color }: { color: string }): ReactNode {
  return (
    <g>
      <rect x="-19" y="-5" width="28" height="10" fill="none" stroke={color} strokeWidth="0.95" />
      <line x1="-3" y1="-5" x2="-3" y2="5" stroke={color} strokeWidth="0.95" />
      <path d="M9,-5 L18,-3 L18,3 L9,5 Z" fill="none" stroke={color} strokeWidth="0.95" />
    </g>
  );
}

function StudyMotif({ color }: { color: string }) {
  type Item = { x: number; y: number; rot: number; scale: number; type: number };
  const items: Item[] = [
    { x: 60, y: 30, rot: 0, scale: 1.0, type: 0 },
    { x: 180, y: 70, rot: 15, scale: 0.95, type: 1 },
    { x: 320, y: 50, rot: 20, scale: 1.0, type: 2 },
    { x: 480, y: 100, rot: -10, scale: 1.0, type: 3 },
    { x: 640, y: 30, rot: -15, scale: 0.95, type: 4 },
    { x: 800, y: 90, rot: 45, scale: 1.0, type: 0 },
    { x: 960, y: 30, rot: 0, scale: 1.0, type: 2 },
    { x: 1120, y: 100, rot: 0, scale: 0.95, type: 1 },
    { x: 1280, y: 50, rot: 5, scale: 1.0, type: 4 },
    { x: 1440, y: 90, rot: 35, scale: 0.95, type: 3 },
    { x: 40, y: 250, rot: 80, scale: 0.9, type: 2 },
    { x: 25, y: 420, rot: 95, scale: 0.85, type: 4 },
    { x: 50, y: 600, rot: 70, scale: 0.95, type: 0 },
    { x: 35, y: 800, rot: 100, scale: 0.9, type: 1 },
    { x: 30, y: 1000, rot: 85, scale: 0.9, type: 3 },
    { x: 1430, y: 240, rot: 100, scale: 0.9, type: 3 },
    { x: 1450, y: 420, rot: 105, scale: 0.95, type: 0 },
    { x: 1415, y: 600, rot: 95, scale: 0.9, type: 2 },
    { x: 1440, y: 800, rot: 80, scale: 0.85, type: 4 },
    { x: 1450, y: 1000, rot: 90, scale: 0.9, type: 1 },
    { x: 220, y: 480, rot: 0, scale: 0.85, type: 2 },
    { x: 740, y: 470, rot: 10, scale: 0.9, type: 0 },
    { x: 1240, y: 480, rot: -8, scale: 0.85, type: 4 },
    { x: 380, y: 720, rot: 20, scale: 0.85, type: 3 },
    { x: 1080, y: 710, rot: 0, scale: 0.85, type: 1 },
    { x: 60, y: 1200, rot: 15, scale: 1.0, type: 0 },
    { x: 200, y: 1280, rot: -30, scale: 0.95, type: 2 },
    { x: 340, y: 1200, rot: 45, scale: 1.0, type: 3 },
    { x: 500, y: 1290, rot: -15, scale: 0.95, type: 4 },
    { x: 660, y: 1220, rot: 0, scale: 0.95, type: 1 },
    { x: 800, y: 1290, rot: 80, scale: 1.0, type: 0 },
    { x: 940, y: 1200, rot: -50, scale: 0.95, type: 3 },
    { x: 1080, y: 1290, rot: 25, scale: 1.0, type: 2 },
    { x: 1220, y: 1200, rot: 0, scale: 0.95, type: 4 },
    { x: 1380, y: 1290, rot: -20, scale: 1.0, type: 0 },
    { x: 240, y: 30, rot: 35, scale: 0.9, type: 2 },
    { x: 400, y: 60, rot: 50, scale: 0.95, type: 4 },
    { x: 560, y: 110, rot: -25, scale: 0.85, type: 3 },
    { x: 880, y: 110, rot: 20, scale: 0.9, type: 1 },
    { x: 1200, y: 110, rot: -25, scale: 0.9, type: 2 },
    { x: 60, y: 340, rot: 80, scale: 0.85, type: 3 },
    { x: 50, y: 700, rot: 80, scale: 0.85, type: 1 },
    { x: 40, y: 900, rot: 95, scale: 0.9, type: 4 },
    { x: 1430, y: 320, rot: 85, scale: 0.85, type: 2 },
    { x: 1430, y: 700, rot: 85, scale: 0.85, type: 4 },
    { x: 1440, y: 910, rot: 100, scale: 0.9, type: 0 },
    { x: 140, y: 480, rot: -15, scale: 0.8, type: 3 },
    { x: 1000, y: 480, rot: 20, scale: 0.85, type: 0 },
    { x: 240, y: 720, rot: 0, scale: 0.8, type: 4 },
    { x: 1320, y: 720, rot: 15, scale: 0.85, type: 2 },
    { x: 130, y: 1240, rot: 0, scale: 0.95, type: 1 },
    { x: 430, y: 1240, rot: -25, scale: 0.95, type: 2 },
    { x: 740, y: 1240, rot: -30, scale: 0.95, type: 3 },
    { x: 1010, y: 1240, rot: 0, scale: 0.95, type: 1 },
    { x: 1310, y: 1240, rot: 20, scale: 0.95, type: 3 },
    { x: 75, y: 200, rot: 75, scale: 0.9, type: 3 },
    { x: 130, y: 320, rot: 95, scale: 0.9, type: 0 },
    { x: 90, y: 460, rot: 80, scale: 0.85, type: 1 },
    { x: 140, y: 580, rot: 100, scale: 0.85, type: 2 },
    { x: 100, y: 680, rot: 85, scale: 0.9, type: 4 },
    { x: 130, y: 800, rot: 100, scale: 0.85, type: 3 },
    { x: 85, y: 920, rot: 80, scale: 0.9, type: 2 },
    { x: 140, y: 1040, rot: 110, scale: 0.85, type: 0 },
    { x: 90, y: 1140, rot: 85, scale: 0.9, type: 1 },
    { x: 130, y: 1280, rot: 75, scale: 0.9, type: 4 },
    { x: 50, y: 130, rot: 75, scale: 0.9, type: 0 },
    { x: 90, y: 240, rot: 85, scale: 0.85, type: 3 },
    { x: 110, y: 540, rot: 100, scale: 0.85, type: 4 },
    { x: 60, y: 1100, rot: 95, scale: 0.9, type: 2 },
    { x: 115, y: 1200, rot: 80, scale: 0.85, type: 1 },
    { x: 30, y: 1080, rot: 95, scale: 0.9, type: 2 },
    { x: 60, y: 1180, rot: 80, scale: 0.85, type: 1 },
    { x: 35, y: 1300, rot: 95, scale: 0.9, type: 3 },
    { x: 70, y: 1400, rot: 85, scale: 0.9, type: 0 },
    { x: 40, y: 1500, rot: 95, scale: 0.85, type: 4 },
    { x: 40, y: 100, rot: 85, scale: 0.85, type: 1 },
    { x: 25, y: 180, rot: 95, scale: 0.9, type: 3 },
    { x: 60, y: 270, rot: 80, scale: 0.85, type: 2 },
    { x: 35, y: 380, rot: 95, scale: 0.9, type: 0 },
    { x: 70, y: 470, rot: 80, scale: 0.85, type: 4 },
    { x: 45, y: 540, rot: 100, scale: 0.85, type: 3 },
    { x: 25, y: 640, rot: 90, scale: 0.85, type: 2 },
    { x: 60, y: 740, rot: 75, scale: 0.85, type: 1 },
    { x: 40, y: 830, rot: 100, scale: 0.9, type: 0 },
    { x: 75, y: 940, rot: 80, scale: 0.85, type: 3 },
    { x: 30, y: 1040, rot: 95, scale: 0.85, type: 4 },
    { x: 65, y: 1130, rot: 85, scale: 0.85, type: 2 },
    { x: 40, y: 1230, rot: 100, scale: 0.85, type: 3 },
    { x: 75, y: 1320, rot: 80, scale: 0.85, type: 1 },
    { x: 30, y: 1430, rot: 95, scale: 0.85, type: 0 },
    { x: 60, y: 1540, rot: 90, scale: 0.85, type: 2 },
    { x: 35, y: 1620, rot: 95, scale: 0.85, type: 4 },
    { x: 70, y: 1700, rot: 80, scale: 0.9, type: 3 },
    { x: 40, y: 1800, rot: 90, scale: 0.85, type: 1 },
    { x: 60, y: 1880, rot: 100, scale: 0.85, type: 0 },
    { x: 1450, y: 130, rot: 95, scale: 0.9, type: 2 },
    { x: 1420, y: 230, rot: 85, scale: 0.85, type: 1 },
    { x: 1450, y: 330, rot: 100, scale: 0.85, type: 3 },
    { x: 1410, y: 440, rot: 95, scale: 0.9, type: 0 },
    { x: 1450, y: 540, rot: 90, scale: 0.85, type: 4 },
    { x: 1420, y: 640, rot: 105, scale: 0.85, type: 2 },
    { x: 1410, y: 850, rot: 90, scale: 0.85, type: 1 },
    { x: 1440, y: 960, rot: 100, scale: 0.9, type: 0 },
    { x: 1470, y: 1060, rot: 90, scale: 0.85, type: 2 },
    { x: 1420, y: 1160, rot: 95, scale: 0.85, type: 4 },
    { x: 1410, y: 1380, rot: 85, scale: 0.85, type: 1 },
    { x: 1450, y: 1500, rot: 95, scale: 0.9, type: 0 },
    { x: 1420, y: 1620, rot: 100, scale: 0.85, type: 2 },
    { x: 1450, y: 1740, rot: 90, scale: 0.85, type: 4 },
    { x: 1410, y: 1860, rot: 95, scale: 0.85, type: 3 },
    { x: 220, y: 30, rot: 25, scale: 0.9, type: 3 },
    { x: 440, y: 50, rot: -10, scale: 0.85, type: 1 },
    { x: 720, y: 30, rot: 0, scale: 0.95, type: 2 },
    { x: 1000, y: 50, rot: -20, scale: 0.85, type: 4 },
    { x: 1320, y: 30, rot: 35, scale: 0.9, type: 0 },
    { x: 340, y: 480, rot: 0, scale: 0.8, type: 1 },
    { x: 620, y: 480, rot: -10, scale: 0.85, type: 3 },
    { x: 900, y: 480, rot: 15, scale: 0.85, type: 2 },
    { x: 520, y: 720, rot: 0, scale: 0.85, type: 4 },
    { x: 900, y: 720, rot: -20, scale: 0.85, type: 0 },
    { x: 640, y: 1340, rot: 25, scale: 0.9, type: 2 },
    { x: 920, y: 1340, rot: 0, scale: 0.9, type: 1 },
    { x: 1200, y: 1380, rot: -25, scale: 0.95, type: 3 },
    { x: 450, y: 1450, rot: 30, scale: 0.95, type: 0 },
    { x: 820, y: 1500, rot: 0, scale: 0.95, type: 4 },
    { x: 260, y: 1450, rot: 30, scale: 0.95, type: 0 },
    { x: 620, y: 1450, rot: 0, scale: 0.95, type: 1 },
    { x: 1080, y: 1450, rot: -10, scale: 0.95, type: 4 },
    { x: 1280, y: 1500, rot: 35, scale: 0.95, type: 0 },
    { x: 200, y: 1580, rot: -25, scale: 0.95, type: 2 },
    { x: 380, y: 1620, rot: 15, scale: 0.95, type: 3 },
    { x: 560, y: 1580, rot: 0, scale: 0.95, type: 1 },
    { x: 740, y: 1640, rot: -30, scale: 0.95, type: 4 },
    { x: 920, y: 1580, rot: 50, scale: 0.95, type: 0 },
    { x: 1100, y: 1640, rot: 0, scale: 0.95, type: 2 },
    { x: 1280, y: 1580, rot: -20, scale: 0.95, type: 3 },
    { x: 260, y: 1780, rot: -15, scale: 1.0, type: 0 },
    { x: 480, y: 1820, rot: 0, scale: 0.95, type: 1 },
    { x: 700, y: 1780, rot: 30, scale: 1.0, type: 3 },
    { x: 920, y: 1820, rot: -25, scale: 0.95, type: 4 },
    { x: 160, y: 250, rot: 85, scale: 0.85, type: 3 },
    { x: 180, y: 380, rot: 95, scale: 0.85, type: 2 },
    { x: 170, y: 520, rot: 80, scale: 0.85, type: 1 },
    { x: 155, y: 670, rot: 100, scale: 0.85, type: 4 },
    { x: 175, y: 820, rot: 90, scale: 0.85, type: 0 },
    { x: 160, y: 970, rot: 85, scale: 0.85, type: 3 },
    { x: 180, y: 1120, rot: 95, scale: 0.85, type: 2 },
    { x: 170, y: 1270, rot: 80, scale: 0.85, type: 1 },
    { x: 155, y: 1420, rot: 95, scale: 0.85, type: 4 },
    { x: 175, y: 1570, rot: 90, scale: 0.85, type: 0 },
    { x: 160, y: 1720, rot: 85, scale: 0.85, type: 3 },
    { x: 180, y: 1870, rot: 95, scale: 0.85, type: 2 },
  ];

  function renderShape(type: number, color: string): ReactNode {
    switch (type) {
      case 0:
        return <Pencil color={color} />;
      case 1:
        return <Glasses color={color} />;
      case 2:
        return <Pen color={color} />;
      case 3:
        return <Marker color={color} />;
      case 4:
        return <Highlighter color={color} />;
      default:
        return null;
    }
  }

  return (
    <>
      {items.map((it, i) => (
        <g
          key={i}
          transform={`translate(${it.x} ${it.y}) rotate(${it.rot}) scale(${it.scale})`}
        >
          {renderShape(it.type, color)}
        </g>
      ))}
    </>
  );
}

/* ────────────────────────────────────────────────────────── */
/* Flashcards Tweaks variants — ported from Flashcards.html    */
/* ────────────────────────────────────────────────────────── */

/** Treatment A: Paper graph ruling fading toward edges. */
function GridTreatment() {
  return (
    <div
      className="absolute"
      style={{
        inset: "20px 20px 0 20px",
        borderRadius: 18,
        background: [
          "linear-gradient(180deg, rgba(0,54,48,.06), rgba(0,54,48,.02) 30%, transparent 70%)",
          "repeating-linear-gradient(0deg, rgba(0,54,48,.055) 0 1px, transparent 1px 28px)",
          "repeating-linear-gradient(90deg, rgba(0,54,48,.055) 0 1px, transparent 1px 28px)",
        ].join(", "),
        WebkitMaskImage:
          "radial-gradient(120% 80% at 50% 40%, #000 55%, transparent 85%)",
        maskImage:
          "radial-gradient(120% 80% at 50% 40%, #000 55%, transparent 85%)",
      }}
    />
  );
}

/** Treatment B: Botanical laurel etching flanking the card. */
function BotanicalTreatment() {
  return (
    <svg
      className="absolute inset-0 h-full w-full"
      viewBox="0 0 800 700"
      preserveAspectRatio="xMidYMid meet"
    >
      <defs>
        <g id="prax-leaf">
          <path
            d="M0 0 C 4 -10 10 -14 18 -14 C 14 -6 8 -2 0 0 Z"
            fill="rgba(0,54,48,.14)"
          />
        </g>
        <g id="prax-branch">
          <path
            d="M0 0 Q 100 -30 200 -40"
            stroke="rgba(0,54,48,.22)"
            strokeWidth="1.2"
            fill="none"
          />
          <g transform="translate(20,-5) rotate(-30)"><use href="#prax-leaf" /></g>
          <g transform="translate(45,-12) rotate(-40)"><use href="#prax-leaf" /></g>
          <g transform="translate(75,-22) rotate(-45)"><use href="#prax-leaf" /></g>
          <g transform="translate(110,-30) rotate(-50)"><use href="#prax-leaf" /></g>
          <g transform="translate(145,-36) rotate(-55)"><use href="#prax-leaf" /></g>
          <g transform="translate(35,-3) rotate(30) scale(1,-1)"><use href="#prax-leaf" /></g>
          <g transform="translate(65,-13) rotate(40) scale(1,-1)"><use href="#prax-leaf" /></g>
          <g transform="translate(95,-22) rotate(45) scale(1,-1)"><use href="#prax-leaf" /></g>
          <g transform="translate(130,-30) rotate(50) scale(1,-1)"><use href="#prax-leaf" /></g>
        </g>
      </defs>
      <g transform="translate(120,380) rotate(60)" opacity=".9">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(130,340) rotate(45)" opacity=".6">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(80,430) rotate(75)" opacity=".5">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(680,380) rotate(-60) scale(-1,1)" opacity=".9">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(670,340) rotate(-45) scale(-1,1)" opacity=".6">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(720,430) rotate(-75) scale(-1,1)" opacity=".5">
        <use href="#prax-branch" />
      </g>
      <g transform="translate(400,60) scale(.6)" opacity=".35">
        <use href="#prax-branch" />
        <g transform="scale(-1,1)"><use href="#prax-branch" /></g>
      </g>
    </svg>
  );
}

/** Treatment C: Soft radial glow + concentric rings. */
function HaloTreatment() {
  return (
    <>
      <div
        className="absolute"
        style={{
          left: "50%",
          top: "42%",
          transform: "translate(-50%,-50%)",
          width: 820,
          height: 820,
          borderRadius: "50%",
          background:
            "radial-gradient(circle, rgba(0,54,48,.08), rgba(0,54,48,0) 55%)",
        }}
      />
      <div
        className="absolute"
        style={{
          left: "50%",
          top: "42%",
          transform: "translate(-50%,-50%)",
          width: 780,
          height: 780,
          borderRadius: "50%",
          border: "1px dashed rgba(0,54,48,.22)",
        }}
      />
      <div
        className="absolute"
        style={{
          left: "50%",
          top: "42%",
          transform: "translate(-50%,-50%)",
          width: 560,
          height: 560,
          borderRadius: "50%",
          border: "1px solid rgba(0,54,48,.08)",
        }}
      />
    </>
  );
}

/** Treatment D: Tiled Greek glyphs (λ Ψ φ Ω) — flashcards default. */
function GlyphsTreatment() {
  return (
    <svg
      className="absolute inset-0 h-full w-full"
      preserveAspectRatio="xMidYMid slice"
      style={{ userSelect: "none" }}
    >
      <defs>
        <pattern
          id="prax-glyphs"
          x="0"
          y="0"
          width="180"
          height="180"
          patternUnits="userSpaceOnUse"
        >
          <text
            x="10"
            y="50"
            fontFamily="var(--font-fraunces), Fraunces, serif"
            fontSize="42"
            fill="rgba(0,54,48,.07)"
            fontStyle="italic"
          >
            λ
          </text>
          <text
            x="90"
            y="110"
            fontFamily="var(--font-fraunces), Fraunces, serif"
            fontSize="34"
            fill="rgba(0,54,48,.055)"
          >
            Ψ
          </text>
          <text
            x="30"
            y="160"
            fontFamily="var(--font-fraunces), Fraunces, serif"
            fontSize="28"
            fill="rgba(0,54,48,.05)"
            fontStyle="italic"
          >
            φ
          </text>
          <text
            x="130"
            y="60"
            fontFamily="var(--font-fraunces), Fraunces, serif"
            fontSize="24"
            fill="rgba(0,54,48,.045)"
          >
            Ω
          </text>
        </pattern>
      </defs>
      <rect width="100%" height="100%" fill="url(#prax-glyphs)" />
    </svg>
  );
}

/** Treatment E: Stacked paper cards behind the active one. */
function StackTreatment() {
  const sharedCardStyle = {
    position: "absolute" as const,
    inset: 0,
    borderRadius: 18,
    background: "#FFFFFF",
    border: "1px solid rgba(0,54,48,.06)",
  };
  return (
    <div
      className="absolute"
      style={{
        left: "50%",
        top: "50%",
        transform: "translate(-50%,-50%)",
        width: "min(720px, 90%)",
        height: 320,
      }}
    >
      <div
        style={{
          ...sharedCardStyle,
          transform: "translate(-14px,-14px) rotate(-1.5deg)",
          opacity: 0.55,
          boxShadow: "0 10px 20px -16px rgba(0,54,48,.3)",
        }}
      />
      <div
        style={{
          ...sharedCardStyle,
          transform: "translate(14px,-8px) rotate(1.2deg)",
          opacity: 0.75,
          boxShadow: "0 10px 20px -16px rgba(0,54,48,.3)",
        }}
      />
      <div
        style={{
          ...sharedCardStyle,
          transform: "translate(6px,6px) rotate(.3deg)",
          opacity: 0.9,
          boxShadow: "0 10px 20px -16px rgba(0,54,48,.3)",
        }}
      />
    </div>
  );
}

/** Treatment F: Topographic ellipses radiating from center. */
function ContourTreatment() {
  return (
    <svg
      className="absolute inset-0 h-full w-full"
      viewBox="0 0 800 700"
      preserveAspectRatio="xMidYMid slice"
    >
      <g fill="none" stroke="rgba(0,54,48,.12)" strokeWidth="1">
        <ellipse cx="400" cy="350" rx="160" ry="110" />
        <ellipse cx="400" cy="350" rx="220" ry="150" />
        <ellipse cx="400" cy="350" rx="290" ry="200" />
        <ellipse cx="400" cy="350" rx="370" ry="258" />
        <ellipse cx="400" cy="350" rx="460" ry="322" />
        <ellipse cx="400" cy="350" rx="560" ry="392" />
      </g>
    </svg>
  );
}
