// Decorative background canvas for the Flashcards study area.
// Ported from the design-repo Flashcards.html "Glyphs" treatment.
//
// Implementation note: we use a CSS background-image with a data-URL SVG tile
// (instead of an inline <svg><pattern>) so the pattern is guaranteed to repeat
// across the full fixed layer regardless of how the browser sizes a child SVG.
// The fixed layer sits behind main content + right rail but not the sidebar
// (see .bg-canvas in globals.css — left offset = --sidebar-w on lg+).

export default function BackgroundCanvas() {
  return <div className="bg-canvas" aria-hidden="true" />;
}
