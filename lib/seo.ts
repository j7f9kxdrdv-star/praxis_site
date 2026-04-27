/**
 * Central SEO config — the canonical source of truth for site-wide metadata.
 *
 * Anything that needs to know "what's our public URL" or "what's the brand
 * tagline" should import from here so we don't drift between layout, sitemap,
 * robots, and structured data.
 */

export const SITE_URL = "https://www.praxistprep.com";

export const SITE_NAME = "Praxist Prep";

export const SITE_TAGLINE = "Mentor-Led MCAT Prep";

/** Default homepage title — used when no page-specific title is set. */
export const DEFAULT_TITLE = `${SITE_NAME} — ${SITE_TAGLINE}`;

/**
 * Default meta description. ~155 chars (Google typically truncates around 160).
 * Leads with the brand differentiator: affordability + mentorship. Avoids any
 * outcome guarantees per the brand voice rules.
 */
export const DEFAULT_DESCRIPTION =
  "Affordable, mentor-led MCAT prep. The tools, structure, and one-on-one coaching most pre-meds can't get from a course alone.";

/** Default Open Graph / social card image. */
export const DEFAULT_OG_IMAGE = {
  url: "/coming-soon-hero.jpg",
  width: 1200,
  height: 630,
  alt: "A pre-med student studying late at night by lamp light",
};
