/**
 * Serves a flashcard's answer illustration from our own origin.
 *
 * The database only accepts a /flashcards/ path, and the files are too large
 * and too many to sit in the repository, so this route is the join: the card
 * stores /flashcards/backs/<card id>/<digest>.png, the bytes live in one
 * Supabase bucket, and the browser never learns there is a second host. See
 * lib/flashcards/backImage.ts for the rule itself.
 *
 * WHAT STOPS THIS BEING AN OPEN PROXY. Nothing in the request chooses where we
 * read from. The bucket is a constant, the Supabase project comes from the
 * environment, and the only parts a caller supplies are two segments that must
 * match a UUID and a hex digest with a raster extension before anything is
 * fetched. A request that does not match is answered 404 without a network
 * call, so it cannot be used to probe for objects either. Redirects are
 * refused rather than followed: an upstream 302 would be a chance to point us
 * somewhere else, and we would rather fail.
 *
 * WHY THE AUTHENTICATED ENDPOINT, WHEN THE BUCKET IS PUBLIC. So that making it
 * private is a bucket setting rather than a code change. Reading through the
 * object endpoint with the service role works for both, and once the bucket is
 * private this route becomes the only way to the illustrations.
 *
 * CACHING IS THE WHOLE PERFORMANCE STORY. The digest is in the path, so the
 * bytes behind a URL never change and the answer is immutable for a year. The
 * CDN serves the repeats; this function runs on a miss.
 *
 * ONLY THE CARD'S CURRENT IMAGE. A signed-in, entitled learner gets the object
 * named by the card's back_image_url and nothing else in its folder: not a
 * superseded, quarantined, staged or master file, whatever its path. And the
 * bytes must still hash to the digest in that path. See isCurrentBackImage
 * and bytesMatchDigest in lib/flashcards/backImage.ts.
 */
import { createHash } from "node:crypto";
import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import {
  BACK_IMAGE_BUCKET,
  bytesMatchDigest,
  isCurrentBackImage,
  parseBackImageRequest,
} from "@/lib/flashcards/backImage";
import {
  ENTITLEMENT_COLUMNS,
  decideImageAccess,
} from "@/lib/flashcards/entitlement";
import {
  IMAGE_SESSION_COOKIE,
  isSessionSuperseded,
  readCookie,
  verifyImageSession,
} from "@/lib/flashcards/imageSession";

function notFound() {
  // Same answer for a malformed path and a missing object, and never cached,
  // so a 404 now does not outlive the upload that fixes it.
  return new NextResponse("Not found", {
    status: 404,
    headers: { "cache-control": "no-store", "content-type": "text/plain" },
  });
}

/**
 * Has the database been taught to stop a learner writing their own
 * entitlement?
 *
 * Asked of the catalog, not of configuration, so the app cannot be switched
 * into trusting columns that are still writable: an environment variable can
 * be set by mistake, a trigger cannot. Any failure is a denial.
 *
 * ONLY A YES IS CACHED. A trigger cannot disappear without a migration, so a
 * true answer is good for the life of the process. A false one is asked again
 * every time, because otherwise a server that happened to start before the
 * migration ran would go on refusing every subscriber until somebody noticed
 * and redeployed it.
 *
 * See supabase/migrations/20261014_entitlement_guard.sql.
 */
let guardConfirmed = false;
async function entitlementGuardInstalled(db: {
  rpc: (fn: string) => PromiseLike<{ data: unknown; error: unknown }>;
}): Promise<boolean> {
  if (guardConfirmed) return true;
  const { data, error } = await db.rpc("entitlement_guard_installed");
  guardConfirmed = !error && data === true;
  return guardConfirmed;
}

/** The bucket's own limit; nothing larger can be a stored illustration. */
const MAX_IMAGE_BYTES = 10 * 1024 * 1024;

/** The stored object is not the image its path names. Never cached. */
function integrityFailure(why: "mismatch" | "too_large") {
  return new NextResponse("Image failed its integrity check.", {
    status: 502,
    headers: { "cache-control": "no-store", "content-type": "text/plain", "x-praxist-integrity": why },
  });
}

/** Denials are never cached, by anyone, and say nothing about the object. */
function denied(reason: string) {
  return new NextResponse("Not available on your plan.", {
    status: 403,
    headers: {
      "cache-control": "no-store, private",
      "content-type": "text/plain",
      // For our own logs and for support, never for the browser to act on.
      "x-praxist-denied": reason,
    },
  });
}

export async function GET(
  request: Request,
  context: { params: Promise<{ cardId: string; file: string }> },
) {
  const { cardId, file } = await context.params;

  const target = parseBackImageRequest(cardId, file);
  if (!target) return notFound();

  const projectUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!projectUrl || !serviceRoleKey) {
    return new NextResponse("Image delivery is not configured.", {
      status: 500,
      headers: { "cache-control": "no-store", "content-type": "text/plain" },
    });
  }

  // ─── Who is asking, and may they ─────────────────────────────────────────
  //
  // Decided here, server side, on every single request. Nothing the browser
  // says is trusted beyond the signed cookie, and the entitlement itself is
  // read fresh from the database rather than carried in the cookie, so a
  // subscription that ends stops working on the next image.
  const session = verifyImageSession(
    readCookie(request.headers.get("cookie"), IMAGE_SESSION_COOKIE),
    process.env.IMAGE_SESSION_SECRET,
  );
  if (!session.ok) return denied(`session_${session.reason}`);

  const db = createClient(projectUrl, serviceRoleKey, { auth: { persistSession: false } });
  // The card is read alongside the profile, not after it, so knowing which
  // image is current adds a primary-key lookup but no extra wait.
  const [profileRead, cardRead] = await Promise.all([
    db.from("profiles").select(ENTITLEMENT_COLUMNS).eq("id", session.claim.userId).maybeSingle(),
    db.from("flashcards").select("back_image_url").eq("id", cardId).maybeSingle(),
  ]);
  const { data: profile, error: profileError } = profileRead;

  if (profileError) {
    // A column that does not exist yet lands here too, which is the schema
    // guard doing its job: no entitlement columns means no entitlement.
    return denied("entitlement_unreadable");
  }

  // The cookie proves who minted it, not that their Supabase session is still
  // alive. Signing out moves this column forward, which kills every cookie
  // issued before that instant, on every device, without waiting for one to
  // expire. Checked before entitlement so a signed-out subscriber is refused
  // for the right reason.
  const validFrom = (profile as { image_sessions_valid_from?: string | null } | null)
    ?.image_sessions_valid_from ?? null;
  if (isSessionSuperseded(session.claim, validFrom)) {
    return denied("session_superseded");
  }

  // The rule itself is in the database, called here with the user id from the
  // signed cookie. One definition serves both this route and row-level
  // security, so the two can never disagree about who is entitled.
  const { data: entitled, error: ruleError } = await db
    .rpc("has_content_entitlement_for", { p_user: session.claim.userId });
  if (ruleError) return denied("entitlement_rule_unavailable");

  const decision = decideImageAccess({
    signedIn: true,
    entitled: entitled === true,
    entitlementColumnsAreTrustworthy: await entitlementGuardInstalled(db),
  });
  if (!decision.allowed) return denied(decision.reason);

  // Only now, for an entitled learner, does the path matter: is it the image
  // this card holds right now? Anything else in the card's folder (a master,
  // a superseded or quarantined image, one staged and not yet approved) is
  // answered exactly like a missing object. Checked before the 304 below, so a
  // browser holding an old image cannot keep revalidating it either. A card
  // that cannot be read is a denial, never a guess.
  if (cardRead.error) return denied("card_unreadable");
  const current = (cardRead.data as { back_image_url?: string | null } | null)?.back_image_url;
  if (!isCurrentBackImage(current, cardId, file)) return notFound();

  // Entitlement has now been checked. Only here is it safe to answer a
  // conditional request cheaply: the browser already holds these exact bytes,
  // because the digest it quotes is the file's own hash and those never
  // change. This is the whole point of `no-cache` over `no-store` — the
  // subscription is verified on every view, and the image is downloaded once.
  const inm = request.headers.get("if-none-match");
  if (inm && inm.split(",").some((tag) => tag.trim().replace(/^W\//, "") === `"${target.digest}"`)) {
    return new NextResponse(null, {
      status: 304,
      headers: {
        "cache-control": "private, no-cache, must-revalidate",
        etag: `"${target.digest}"`,
        vary: "Cookie",
      },
    });
  }

  const upstream = `${projectUrl}/storage/v1/object/${BACK_IMAGE_BUCKET}/${target.objectPath}`;

  let response: Response;
  try {
    response = await fetch(upstream, {
      headers: {
        Authorization: `Bearer ${serviceRoleKey}`,
        apikey: serviceRoleKey,
      },
      // An upstream redirect is a chance to be sent somewhere else. Refuse it.
      redirect: "error",
      // The bodies are around a megabyte each; they belong in the CDN in front
      // of this function, not in the framework's data cache behind it.
      cache: "no-store",
    });
  } catch {
    return new NextResponse("Image upstream unavailable.", {
      status: 502,
      headers: { "cache-control": "no-store", "content-type": "text/plain" },
    });
  }

  if (response.status === 404 || response.status === 400) return notFound();
  if (!response.ok || !response.body) {
    return new NextResponse("Image upstream failed.", {
      status: 502,
      headers: { "cache-control": "no-store", "content-type": "text/plain" },
    });
  }

  // The type we send is the one the path promised, and we only send it if the
  // stored object agrees. A bucket that somehow held a document at an image
  // path does not get to have it served from our origin.
  const upstreamType = (response.headers.get("content-type") ?? "")
    .split(";")[0]
    .trim()
    .toLowerCase();
  if (upstreamType !== target.contentType) {
    return new NextResponse("Image upstream returned an unexpected type.", {
      status: 502,
      headers: { "cache-control": "no-store", "content-type": "text/plain" },
    });
  }

  // The bytes must still be the ones the path is named after. An object
  // overwritten in storage after it was published keeps its path but not its
  // hash, and is refused rather than served as the approved illustration.
  // Buffered rather than streamed to make that check: a served WebP is tens of
  // kilobytes, and the bucket refuses anything over 10 MB.
  const declared = Number(response.headers.get("content-length") ?? "0");
  if (declared > MAX_IMAGE_BYTES) return integrityFailure("too_large");
  const bytes = Buffer.from(await response.arrayBuffer());
  if (bytes.length > MAX_IMAGE_BYTES) return integrityFailure("too_large");
  if (!bytesMatchDigest(createHash("sha256").update(bytes).digest("hex"), target.digest)) {
    return integrityFailure("mismatch");
  }

  // NO Content-Security-Policy HERE, AND THAT IS DELIBERATE. The first version
  // sent `default-src 'none'; sandbox`, which is only meaningful if this
  // response is ever rendered as a document — and it cannot be. The type is
  // pinned to an image, the upstream type is checked against it above, SVG is
  // refused by the path rule, and nosniff forbids the browser from deciding
  // otherwise. What the header did do was break the browser's own image
  // viewer: opening one of these URLs directly logged blocked scripts and
  // blocked inline styles. Cost without benefit, so it is gone.
  // CACHING, NOW THAT THE RESPONSE IS PRIVATE TO ONE SUBSCRIBER.
  //
  // The earlier version sent `public` plus a Vercel edge TTL, which was right
  // while the illustrations were public and is exactly wrong now: a shared
  // cache holding a subscriber-only image would serve it to whoever asked
  // next. So `private` (no shared cache may store this), `no-cache` (the
  // browser may store it but must revalidate before using it), and no CDN
  // header at all.
  //
  // `no-cache` is not `no-store`. The bytes stay in the browser; what changes
  // is that every view asks us again. With the content hash as the ETag the
  // answer is a 304 of a few hundred bytes, so a learner downloads each
  // illustration once and we still get to check their subscription every
  // single time. That is what makes revocation take effect immediately
  // instead of whenever a cache happens to expire.
  //
  // Vary: Cookie states the obvious for any intermediary that did not read
  // `private`.
  const headers = new Headers({
    "content-type": target.contentType,
    "cache-control": "private, no-cache, must-revalidate",
    "vary": "Cookie",
    "etag": `"${target.digest}"`,
    "x-content-type-options": "nosniff",
    "content-disposition": "inline",
  });
  headers.set("content-length", String(bytes.length));

  return new NextResponse(bytes, { status: 200, headers });
}
