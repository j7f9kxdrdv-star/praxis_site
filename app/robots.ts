import type { MetadataRoute } from "next";
import { SITE_URL } from "@/lib/seo";
import { isLive } from "@/lib/launch-mode";

/**
 * robots.txt directives.
 *
 * Preview mode: hard-block all crawlers. We don't want Google indexing the
 * coming-soon gate as our canonical content — any rank built there would have
 * to be unwound at launch.
 *
 * Live mode: allow indexing of public marketing routes; explicitly disallow
 * authenticated and API surfaces (no SEO value, and we don't want crawlers
 * spinning up auth flows).
 */
export default function robots(): MetadataRoute.Robots {
  if (!isLive()) {
    return {
      rules: { userAgent: "*", disallow: "/" },
    };
  }

  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: [
          "/api/",
          "/dashboard",
          "/dashboard/",
          "/check-email",
          "/login",
          "/signup",
        ],
      },
    ],
    sitemap: `${SITE_URL}/sitemap.xml`,
    host: SITE_URL,
  };
}
