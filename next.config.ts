import type { NextConfig } from "next";

/**
 * Launch-mode-aware Next config.
 *
 * In `preview` mode (default), public marketing routes are redirected to /
 * so the coming-soon waitlist gate can't be bypassed. In `live` mode, those
 * routes resolve normally.
 *
 * Set NEXT_PUBLIC_LAUNCH_MODE=live in Vercel + redeploy to flip the gate.
 */

const isLive = process.env.NEXT_PUBLIC_LAUNCH_MODE === "live";

const nextConfig: NextConfig = {
  async redirects() {
    // Permanent (301) redirects always apply, regardless of launch mode.
    // /home was a legacy URL for the marketing site; the marketing content
    // now lives at / and is dispatched by app/page.tsx. A server-side 301
    // tells Google to consolidate any inbound /home link equity into /.
    const permanent = [
      { source: "/home", destination: "/", permanent: true },
    ];

    if (isLive) return permanent;

    return [
      ...permanent,
      // Pre-launch only: keep visitors out of the marketing surface so
      // they see the coming-soon page first.
      { source: "/pricing", destination: "/", permanent: false },
      { source: "/signup", destination: "/", permanent: false },
    ];
  },
};

export default nextConfig;
