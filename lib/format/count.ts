// ─── Counts, written the same way everywhere ─────────────────────────────────
//
// The dashboard wrote "6,544" while the Flashcards page wrote "6544" for the
// same number. Every count a student reads goes through this one function, in
// the same locale the rest of the app already uses ("en-US"), so the two pages
// cannot drift apart again.

export function formatCount(n: number): string {
  return Math.round(n).toLocaleString("en-US");
}
