/**
 * Launch-mode flag.
 *
 * Controls whether the public site is in pre-launch "preview" mode (coming-soon
 * waitlist + auth gate) or "live" mode (full marketing site visible to everyone).
 *
 * Driven by the `NEXT_PUBLIC_LAUNCH_MODE` env var:
 *   - "live"      -> public marketing, /signup and /pricing reachable
 *   - anything else (default) -> "preview" mode, coming-soon gate
 *
 * Defaulting to "preview" is intentional — accidentally going live (e.g.,
 * forgetting to set the env var on a new environment) should fail closed,
 * not open.
 *
 * To flip the site to live:
 *   1. Set NEXT_PUBLIC_LAUNCH_MODE=live in Vercel project settings (Production)
 *   2. Trigger a redeploy (Vercel doesn't auto-rebuild on env-var changes;
 *      either click "Redeploy" in the Deployments tab or push a commit)
 *
 * The variable is `NEXT_PUBLIC_*` so it's available both server-side (in
 * next.config.ts redirects) and client-side (in components for conditional
 * rendering).
 */

export type LaunchMode = "preview" | "live";

export function getLaunchMode(): LaunchMode {
  return process.env.NEXT_PUBLIC_LAUNCH_MODE === "live" ? "live" : "preview";
}

export function isLive(): boolean {
  return getLaunchMode() === "live";
}

export function isPreview(): boolean {
  return getLaunchMode() === "preview";
}
