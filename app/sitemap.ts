import type { MetadataRoute } from "next";
import { SITE_URL } from "@/lib/seo";
import { isLive } from "@/lib/launch-mode";

/**
 * Sitemap for search engines.
 *
 * In preview launch mode we don't expose any URLs — the coming-soon page is
 * the only thing reachable, and we don't want it ranking as canonical content
 * before launch. Combined with the robots.ts rules, this keeps Google from
 * indexing the gate.
 *
 * Once NEXT_PUBLIC_LAUNCH_MODE=live, we expose the marketing routes.
 *
 * Add new public routes (blog posts, landing pages) to this list as they're
 * built — anything that should rank in Google needs an entry here.
 */
export default function sitemap(): MetadataRoute.Sitemap {
  if (!isLive()) return [];

  const now = new Date();

  return [
    {
      url: SITE_URL,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 1,
    },
    {
      url: `${SITE_URL}/pricing`,
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.8,
    },
  ];
}
