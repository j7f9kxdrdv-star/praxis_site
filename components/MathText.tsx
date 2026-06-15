"use client";

import katex from "katex";
import "katex/dist/katex.min.css";

/**
 * Renders a plain-text string that may contain inline or display LaTeX
 * math, used for question stems, answer choices, and explanations.
 *
 * Math is delimited with:
 *   \( ... \)   inline   e.g.  \(m_l\), \(10^{-18}\ \text{J}\), \(\text{S}^{2-}\)
 *   \[ ... \]   display  (rare; centered block)
 *
 * Everything outside the delimiters is rendered as ordinary text, so
 * prose stays readable and only formulas go through KaTeX. KaTeX is run
 * with throwOnError:false so a malformed expression degrades to its raw
 * source rather than blanking the question.
 */

const MATH_RE = /(\\\([\s\S]*?\\\)|\\\[[\s\S]*?\\\])/g;

export default function MathText({
  text,
  className,
}: {
  text: string | null | undefined;
  className?: string;
}) {
  if (!text) return null;

  const parts = text.split(MATH_RE);

  return (
    <span className={className}>
      {parts.map((part, i) => {
        if (!part) return null;

        const isInline = part.startsWith("\\(") && part.endsWith("\\)");
        const isDisplay = part.startsWith("\\[") && part.endsWith("\\]");

        if (isInline || isDisplay) {
          const inner = part.slice(2, -2);
          let html: string;
          try {
            html = katex.renderToString(inner, {
              throwOnError: false,
              displayMode: isDisplay,
            });
          } catch {
            return <span key={i}>{inner}</span>;
          }
          return (
            <span
              key={i}
              // KaTeX output is generated from our own authored content.
              dangerouslySetInnerHTML={{ __html: html }}
            />
          );
        }

        return <span key={i}>{part}</span>;
      })}
    </span>
  );
}
