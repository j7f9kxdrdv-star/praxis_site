/**
 * Who is allowed to see a flashcard illustration.
 *
 * The illustrations are subscriber-only content. This file is the whole rule,
 * as one pure function with no network and no database, so every case can be
 * tested and so there is exactly one place to read when someone asks who gets
 * in. The route calls it; nothing decides access anywhere else, and nothing in
 * the browser decides anything at all.
 *
 * IT FAILS CLOSED. Every path that is not an explicit allow returns a denial,
 * including a missing profile, an unreadable record, an unknown status and a
 * schema that does not yet carry the columns this depends on. A bug here
 * should cost a subscriber a picture, never give a stranger one.
 *
 * WHY `subscription_tier` ALONE IS NOT ENOUGH, AND WAS NEVER SAFE.
 * `profiles` carries the RLS policy "Users can update own profile" with no
 * column restriction, so a signed-in learner can write their own row. Verified
 * against production with a disposable account: setting `subscription_tier` to
 * 'self_paced' was ACCEPTED. `is_admin` and `account_kind` were silently
 * reverted, because each has a BEFORE UPDATE trigger
 * (`prevent_is_admin_self_update`) doing exactly that. The entitlement columns
 * need the same trigger before any of them can be believed, which is why
 * `entitlementColumnsAreTrustworthy` exists and why this module refuses to
 * grant anything until the guard is in place.
 */

export type AccessDecision = {
  allowed: boolean;
  /** Short machine-readable reason, for logs and tests. Never shown raw. */
  reason:
    | "allowed"
    | "denied_not_signed_in"
    | "denied_not_entitled"
    | "denied_schema_not_ready";
};

/**
 * May this request have the illustration?
 *
 * THE ENTITLEMENT ITSELF IS NOT DECIDED HERE, AND THAT IS DELIBERATE. An
 * earlier version of this file reimplemented the rule in TypeScript against
 * profile columns. When the authority moved into account_entitlements the copy
 * here went stale and silently denied every entitled account, which is exactly
 * the failure a second copy of a rule produces. The rule now lives once, in
 * has_content_entitlement_for(), and `entitled` is that function's answer.
 *
 * What is left here is the part the database cannot see: whether there was a
 * usable session at all, and whether the schema is yet in a state where any
 * answer can be believed. Both fail closed.
 */
export function decideImageAccess(
  options: {
    signedIn: boolean;
    entitled: boolean;
    entitlementColumnsAreTrustworthy: boolean;
  },
): AccessDecision {
  if (!options.signedIn) return { allowed: false, reason: "denied_not_signed_in" };
  if (!options.entitlementColumnsAreTrustworthy) {
    return { allowed: false, reason: "denied_schema_not_ready" };
  }
  if (!options.entitled) return { allowed: false, reason: "denied_not_entitled" };
  return { allowed: true, reason: "allowed" };
}

/** The columns the route reads from the profile. Entitlement is not among them. */
export const ENTITLEMENT_COLUMNS = "image_sessions_valid_from";
