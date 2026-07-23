/*
 * Praxist Prep — service worker (PWA).
 *
 * Conservative caching so we never serve stale app code:
 *  - Content-hashed build assets (/_next/static/*) → cache-first (safe forever;
 *    the filename changes whenever the content does).
 *  - A small precached app shell (offline page + icons), versioned by
 *    CACHE_VERSION → cache-first so it's available offline.
 *  - Everything else same-origin, INCLUDING stable-named public files like
 *    /logo-green.png, → network (default). This is deliberate: those names don't
 *    change when the file does, so caching them first would freeze a swapped
 *    logo/image at its old bytes until CACHE_VERSION is bumped.
 *  - Page navigations → network-first, fall back to cache, then a branded offline page.
 *  - Cross-origin requests (Supabase data/auth, anything off-domain) → untouched.
 *  - Non-GET → untouched.
 *
 * Bump CACHE_VERSION to invalidate all caches on the next activation.
 */
const CACHE_VERSION = "praxist-v1";
const STATIC_CACHE = `${CACHE_VERSION}-static`;
const PAGE_CACHE = `${CACHE_VERSION}-pages`;
const OFFLINE_URL = "/offline.html";

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(STATIC_CACHE)
      .then((cache) => cache.addAll([OFFLINE_URL, "/icon-192.png", "/icon-512.png"]))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(
          keys.filter((k) => !k.startsWith(CACHE_VERSION)).map((k) => caches.delete(k))
        )
      )
      .then(() => self.clients.claim())
  );
});

// Content-hashed build output — the URL changes when the bytes change, so it's
// always safe to serve from cache without revalidating.
const isImmutableAsset = (pathname) => pathname.startsWith("/_next/static/");

// App-shell files we precache (see install) so the app has an icon + offline
// page without a network round-trip. Versioned by CACHE_VERSION.
const PRECACHED_SHELL = new Set([OFFLINE_URL, "/icon-192.png", "/icon-512.png"]);

self.addEventListener("fetch", (event) => {
  const { request } = event;
  if (request.method !== "GET") return;

  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return; // never touch cross-origin (Supabase, etc.)

  // Immutable build assets + precached app shell → cache-first, then populate cache.
  if (isImmutableAsset(url.pathname) || PRECACHED_SHELL.has(url.pathname)) {
    event.respondWith(
      caches.match(request).then(
        (cached) =>
          cached ||
          fetch(request).then((res) => {
            if (res.ok) {
              const copy = res.clone();
              caches.open(STATIC_CACHE).then((c) => c.put(request, copy));
            }
            return res;
          })
      )
    );
    return;
  }

  // Page navigations → network-first, fall back to cached page, then offline page.
  if (request.mode === "navigate") {
    event.respondWith(
      fetch(request)
        .then((res) => {
          if (res.ok) {
            const copy = res.clone();
            caches.open(PAGE_CACHE).then((c) => c.put(request, copy));
          }
          return res;
        })
        .catch(() =>
          caches
            .match(request)
            .then((cached) => cached || caches.match(OFFLINE_URL))
        )
    );
    return;
  }

  // Everything else (API/data) → default network handling.
});
