import { parseScripts } from "@/lib/flashcards/cloze";

/**
 * Card text with real subscripts and superscripts.
 *
 * Cards are plain Unicode, which cannot express most scientific notation.
 * Unicode provides subscript forms for only a e h i j k l m n o p r s t u v x,
 * and no multi-character forms at all, so F_out, V_max, k_cat and Z_eff can
 * never be written as characters however the card is edited. Subscript DIGITS
 * do exist, which is why chemical formulas could be fixed in the content and
 * these cannot.
 *
 * So the notation lives in markup the renderer understands:
 *
 *   MA = F_(out) / F_(in)     ->   MA = F(out) / F(in) with real subscripts
 *   10^(-5)                   ->   ten to the minus five
 *
 * Text with no markup is returned unchanged, so this is safe to wrap around
 * every string on a card whether or not it contains notation.
 */
export default function RichText({ children }: { children: string }) {
  const runs = parseScripts(children);
  if (runs.length === 1 && runs[0].script === null) return <>{children}</>;
  return (
    <>
      {runs.map((run, i) =>
        run.script === "sub" ? (
          <sub key={i} className="text-[0.68em] align-[-0.18em]">{run.text}</sub>
        ) : run.script === "sup" ? (
          <sup key={i} className="text-[0.66em] align-[0.45em]">{run.text}</sup>
        ) : (
          <span key={i}>{run.text}</span>
        ),
      )}
    </>
  );
}
