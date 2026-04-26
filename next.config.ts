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
    if (isLive) return [];
    return [
      // Pre-launch only: keep visitors out of the marketing surface so
      // they see the coming-soon page first.
      { source: "/pricing", destination: "/", permanent: false },
      { source: "/signup", destination: "/", permanent: false },
    ];
  },
};

export default nextConfig;
