import type { MetadataRoute } from "next";

/**
 * Web App Manifest — makes Praxist installable to the home screen as a
 * standalone app (PWA). Next serves this at /manifest.webmanifest and injects
 * the <link rel="manifest"> automatically.
 *
 * Brand: deep green #003630 on warm cream #FAF7F2 (see globals.css).
 * The installed app opens straight into the dashboard, not the marketing site.
 */
export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "Praxist Prep — MCAT Flashcards & Practice",
    short_name: "Praxist",
    description:
      "Study MCAT flashcards and practice questions with spaced repetition — your whole prep, on your phone.",
    id: "/dashboard",
    start_url: "/dashboard",
    scope: "/",
    display: "standalone",
    // "any" (not "portrait") — the flashcard study screen is landscape-first, so
    // the installed app must be allowed to follow device rotation. Locking to
    // portrait would leave Android PWA users stuck on the "rotate" prompt forever.
    orientation: "any",
    background_color: "#FAF7F2",
    theme_color: "#003630",
    categories: ["education", "medical"],
    icons: [
      { src: "/icon-192.png", sizes: "192x192", type: "image/png", purpose: "any" },
      { src: "/icon-512.png", sizes: "512x512", type: "image/png", purpose: "any" },
      { src: "/icon-512.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
    ],
  };
}
