import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Pre-launch: visitors should not reach the marketing surface.
  // Redirect public marketing routes to the coming-soon homepage.
  // Once we go live, remove these and the routes will resolve normally.
  async redirects() {
    return [
      { source: "/pricing", destination: "/", permanent: false },
      { source: "/signup", destination: "/", permanent: false },
    ];
  },
};

export default nextConfig;
