"use client";

/**
 * Renders an optional figure attached to a practice question, slotted between the
 * question stem and the answer choices.
 *
 * Primary path: `svg` — inline original SVG markup authored in-house. This is trusted,
 * repo-committed content (same trust model as the KaTeX HTML rendered by MathText), but
 * because SVG can carry scripts we strip <script> tags and inline event handlers as
 * defense-in-depth before injecting.
 *
 * Escape hatch: `url` — an externally hosted image, used only if no inline SVG is present.
 */

function sanitizeSvg(svg: string): string {
  return svg
    .replace(/<script[\s\S]*?<\/script>/gi, "")
    .replace(/\son\w+\s*=\s*"[^"]*"/gi, "")
    .replace(/\son\w+\s*=\s*'[^']*'/gi, "")
    .replace(/\son\w+\s*=\s*[^\s>]+/gi, "")
    .replace(/javascript:/gi, "");
}

export default function QuestionFigure({
  svg,
  url,
}: {
  svg?: string | null;
  url?: string | null;
}) {
  if (svg) {
    // Give the wrapper a definite (responsive) width and force the SVG to fill it with height
    // auto-derived from its viewBox — so a viewBox-only SVG (no width/height attrs) renders at a
    // sensible size instead of collapsing inside the flex layout.
    return (
      <figure className="mb-6">
        <div
          className="mx-auto w-full max-w-[520px] overflow-x-auto rounded-lg border border-[#ddd] bg-white p-3 [&_svg]:block [&_svg]:h-auto [&_svg]:w-full"
          dangerouslySetInnerHTML={{ __html: sanitizeSvg(svg) }}
        />
      </figure>
    );
  }

  if (url) {
    return (
      <figure className="mb-6">
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={url}
          alt="Question figure"
          className="mx-auto block max-w-full h-auto rounded-lg border border-[#ddd]"
        />
      </figure>
    );
  }

  return null;
}
