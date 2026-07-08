"use client";

import { Fragment } from "react";
import katex from "katex";
import "katex/dist/katex.min.css";

/**
 * Renders authored question content — stems, answer choices, explanations —
 * that may contain inline LaTeX math and/or GitHub-flavored Markdown tables.
 *
 * Math is delimited with:
 *   \( ... \)   inline   e.g.  \(m_l\), \(10^{-18}\ \text{J}\), \(P_{50}\)
 *   \[ ... \]   display  (rare; centered block)
 *
 * Tables use standard Markdown pipe syntax with a header separator row:
 *   | Male | Lifespan | Mass |
 *   |------|:--------:|-----:|
 *   | P    | 6        | 32   |
 * These render as real bordered tables (AAMC-style) rather than raw pipes,
 * with per-column alignment (`:--` left, `:-:` center, `--:` right) and a
 * horizontal-scroll wrapper so wide tables never break the mobile layout.
 *
 * Content with no table and no blank-line paragraph break renders inline
 * (a single <span>), so short pieces like answer choices flow naturally.
 * Anything richer renders as block-level paragraphs and tables.
 *
 * KaTeX runs with throwOnError:false so a malformed expression degrades to
 * its raw source rather than blanking the question.
 */

const MATH_RE = /(\\\([\s\S]*?\\\)|\\\[[\s\S]*?\\\])/g;

// Render one inline string (LaTeX-aware) to an array of React nodes.
function renderInline(text: string, keyPrefix: string) {
  return text.split(MATH_RE).map((part, i) => {
    if (!part) return null;
    const key = `${keyPrefix}-${i}`;
    const isInline = part.startsWith("\\(") && part.endsWith("\\)");
    const isDisplay = part.startsWith("\\[") && part.endsWith("\\]");

    if (isInline || isDisplay) {
      const inner = part.slice(2, -2);
      try {
        const html = katex.renderToString(inner, {
          throwOnError: false,
          displayMode: isDisplay,
        });
        // KaTeX output is generated from our own authored content.
        return <span key={key} dangerouslySetInnerHTML={{ __html: html }} />;
      } catch {
        return <span key={key}>{inner}</span>;
      }
    }
    return <span key={key}>{part}</span>;
  });
}

type Align = "left" | "center" | "right";
type Block =
  | { type: "text"; content: string }
  | { type: "table"; header: string[]; aligns: Align[]; rows: string[][] };

// Split a Markdown table row into trimmed cells, dropping the outer pipes.
function splitRow(line: string): string[] {
  let s = line.trim();
  if (s.startsWith("|")) s = s.slice(1);
  if (s.endsWith("|")) s = s.slice(0, -1);
  return s.split("|").map((c) => c.trim());
}

// A separator row is all dashes/colons, e.g. |---|:--:|--:|
function isSeparator(line: string): boolean {
  if (!line || !line.includes("-")) return false;
  const cells = splitRow(line);
  return cells.length > 0 && cells.every((c) => /^:?-{1,}:?$/.test(c));
}

function alignOf(sepCell: string): Align {
  const l = sepCell.startsWith(":");
  const r = sepCell.endsWith(":");
  if (l && r) return "center";
  if (r) return "right";
  return "left";
}

// Group raw text into paragraph/table blocks.
function parseBlocks(text: string): Block[] {
  const lines = text.split("\n");
  const blocks: Block[] = [];
  let buf: string[] = [];
  const flush = () => {
    if (buf.length) {
      const content = buf.join("\n").replace(/^\n+|\n+$/g, "");
      if (content.trim()) blocks.push({ type: "text", content });
      buf = [];
    }
  };

  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    const next = lines[i + 1];
    if (line.includes("|") && next !== undefined && isSeparator(next)) {
      flush();
      const header = splitRow(line);
      const aligns = splitRow(next).map(alignOf);
      const rows: string[][] = [];
      let j = i + 2;
      while (j < lines.length && lines[j].includes("|") && lines[j].trim() !== "") {
        rows.push(splitRow(lines[j]));
        j++;
      }
      blocks.push({ type: "table", header, aligns, rows });
      i = j;
    } else {
      buf.push(line);
      i++;
    }
  }
  flush();
  return blocks;
}

const alignClass: Record<Align, string> = {
  left: "text-left",
  center: "text-center",
  right: "text-right",
};

export default function MathText({
  text,
  className,
}: {
  text: string | null | undefined;
  className?: string;
}) {
  if (!text) return null;

  const blocks = parseBlocks(text);
  const isBlock = blocks.some(
    (b) => b.type === "table" || (b.type === "text" && /\n\s*\n/.test(b.content))
  );

  // Simple inline content (answer choices, short prose) — keep it inline.
  if (!isBlock) {
    return <span className={className}>{renderInline(text, "il")}</span>;
  }

  return (
    <>
      {blocks.map((block, bi) => {
        if (block.type === "table") {
          return (
            <div key={bi} className="my-3 overflow-x-auto">
              <table className="border-collapse text-[13px]">
                <thead>
                  <tr>
                    {block.header.map((cell, ci) => (
                      <th
                        key={ci}
                        className={`border border-[#bbb] bg-[#f3f4f6] px-3 py-1.5 font-semibold text-[#333] ${
                          alignClass[block.aligns[ci] ?? "left"]
                        }`}
                      >
                        {renderInline(cell, `h-${bi}-${ci}`)}
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {block.rows.map((row, ri) => (
                    <tr key={ri}>
                      {row.map((cell, ci) => (
                        <td
                          key={ci}
                          className={`border border-[#d5d5d5] px-3 py-1.5 text-[#333] ${
                            alignClass[block.aligns[ci] ?? "left"]
                          }`}
                        >
                          {renderInline(cell, `c-${bi}-${ri}-${ci}`)}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          );
        }

        // Text block → one <p> per blank-line-separated paragraph,
        // single newlines become <br/>.
        return block.content.split(/\n\s*\n/).map((para, pi) => (
          <p key={`${bi}-${pi}`} className="mb-3 last:mb-0">
            {para.split("\n").map((ln, li) => (
              <Fragment key={li}>
                {li > 0 && <br />}
                {renderInline(ln, `p-${bi}-${pi}-${li}`)}
              </Fragment>
            ))}
          </p>
        ));
      })}
    </>
  );
}
