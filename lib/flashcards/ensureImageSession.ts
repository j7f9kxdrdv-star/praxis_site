/**
 * Makes sure this browser is carrying the cookie that illustration requests
 * need, by trading the Supabase bearer token the app already holds for one.
 *
 * Called once when the dashboard loads, beside the timezone capture that is
 * already there. It is deliberately fail-soft: if it does not work, the only
 * consequence is that answer illustrations do not appear, and that must never
 * stop a student studying. Nothing here is a security control — the server
 * decides access on every single image request. See
 * app/flashcards/backs/[cardId]/[file]/route.ts.
 */
import { supabase } from "@/lib/supabase";

/** Mint at most once per page load, however many components ask. */
let inFlight: Promise<boolean> | null = null;

export function ensureImageSession(): Promise<boolean> {
  inFlight ??= mint().finally(() => {
    // Let a later navigation try again if this attempt failed.
    setTimeout(() => { inFlight = null; }, 0);
  });
  return inFlight;
}

async function mint(): Promise<boolean> {
  try {
    const { data } = await supabase.auth.getSession();
    const token = data.session?.access_token;
    if (!token) return false;

    const response = await fetch("/api/flashcards/image-session", {
      method: "POST",
      headers: { authorization: `Bearer ${token}` },
      // The cookie comes back on the response, so the browser must be allowed
      // to store it; same origin, so this is simply explicit.
      credentials: "same-origin",
    });
    return response.ok;
  } catch {
    return false;
  }
}

/** Drop the cookie on sign-out, so a shared machine does not keep it. */
export async function clearImageSession(): Promise<void> {
  try {
    await fetch("/api/flashcards/image-session", {
      method: "DELETE",
      credentials: "same-origin",
    });
  } catch {
    // Sign-out must not fail because of this.
  }
}
