"use client";

import { useEffect } from "react";

/**
 * Registers the PWA service worker. Production-only: in dev the SW's
 * cache-first rules would fight Next's HMR and serve stale chunks. Renders
 * nothing. Failures are swallowed — the app works fine without the SW.
 */
export default function ServiceWorkerRegister() {
  useEffect(() => {
    if (
      process.env.NODE_ENV !== "production" ||
      typeof navigator === "undefined" ||
      !("serviceWorker" in navigator)
    ) {
      return;
    }
    const register = () =>
      navigator.serviceWorker.register("/sw.js").catch(() => {
        /* offline-first is best-effort */
      });
    // Register after load so it never competes with initial hydration.
    if (document.readyState === "complete") register();
    else window.addEventListener("load", register, { once: true });
  }, []);

  return null;
}
