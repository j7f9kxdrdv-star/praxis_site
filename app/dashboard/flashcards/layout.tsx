import FlashcardsBg from "@/components/dashboard/FlashcardsBg";

/**
 * Flashcards section layout.
 *
 * Provides the cream background + swappable motif (Glyphs by default;
 * Tweaks panel lets the user switch between None / Graph / Botanical /
 * Halo / Glyphs / Stack / Contour / Neurons) for every flashcards
 * sub-page (listing, deck detail, per-deck study, cross-deck session).
 *
 * The chosen treatment persists per-user in localStorage.
 */
export default function FlashcardsLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div
      className="relative min-h-full w-full lg:-mx-16 lg:-my-16 overflow-hidden"
      style={{ background: "var(--color-prax-cream)" }}
    >
      <FlashcardsBg />
      <div className="relative z-[1]">{children}</div>
    </div>
  );
}
