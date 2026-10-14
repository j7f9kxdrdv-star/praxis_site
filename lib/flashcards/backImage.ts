/**
 * The contract between a flashcard's stored image path and the object that
 * actually holds the picture.
 *
 * WHY THERE IS A CONTRACT AT ALL. The database refuses anything but a path
 * under /flashcards/ (supabase/migrations/20260908_flashcard_answer_image.sql),
 * so a card can never be pointed at someone else's host. But the illustrations
 * are roughly a megabyte each and there will be hundreds, which is not what a
 * git repository is for, and adding one would mean deploying the whole site.
 * So the files live in one Supabase bucket and are handed back out under that
 * same local path by app/flashcards/backs/[cardId]/[file]/route.ts.
 *
 * Everything that route trusts is decided here, in pure functions with no
 * network and no database, so the rule can be tested on its own.
 *
 * THE ALPHABET IS THE SECURITY. A card id must be a UUID and a file name must
 * be a hex digest plus one of two extensions, both matched whole. Neither can
 * hold a slash, a dot pair, a backslash, a percent sign or a colon, so there is
 * nothing to traverse out of, no second host to reach and no scheme to swap.
 * The bucket is a constant in this file; nothing in a request chooses it, which
 * is what keeps the route from being an open proxy.
 */

/** The one bucket this scheme will ever read. Never taken from a request. */
export const BACK_IMAGE_BUCKET = "flashcard-images";

/** The prefix the database sees, and the route that answers it. */
export const BACK_IMAGE_PREFIX = "/flashcards/backs/";

/** The prefix inside the bucket. Matches what the upload already wrote. */
export const BACK_IMAGE_OBJECT_PREFIX = "cards/";

const CARD_ID =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/;

// A content hash, then the extension. Eight hex is what the upload used; the
// range allows a longer digest later without another migration of meaning.
const FILE_NAME = /^([0-9a-f]{8,64})\.(png|webp)$/;

/**
 * Only raster types, and only ones the browser cannot be talked into running.
 * SVG is deliberately absent: it is a document, it can carry script, and it
 * would be served from our own origin.
 */
const CONTENT_TYPE: Record<string, string> = {
  png: "image/png",
  webp: "image/webp",
};

export type BackImageTarget = {
  /** The object's path inside BACK_IMAGE_BUCKET. */
  objectPath: string;
  /** The only content type this response may carry. */
  contentType: string;
  /**
   * The content hash out of the path. It doubles as the ETag: the bytes behind
   * a path never change, so a browser holding this digest is holding the
   * current file and can be answered 304 — after its subscription has been
   * checked again.
   */
  digest: string;
};

/**
 * The path written into flashcards.back_image_url.
 *
 * Content-addressed on purpose: the digest is in the name, so the bytes at a
 * path never change and the response can be cached for a year. A corrected
 * illustration gets a new digest and therefore a new path, which is also what
 * keeps one card to one picture rather than quietly swapping it underneath.
 */
export function backImagePath(
  cardId: string,
  digest: string,
  extension: "png" | "webp" = "png",
): string {
  const file = `${digest}.${extension}`;
  if (!CARD_ID.test(cardId) || !FILE_NAME.test(file)) {
    throw new Error(`refusing to build an image path from ${cardId}/${file}`);
  }
  return `${BACK_IMAGE_PREFIX}${cardId}/${file}`;
}

/**
 * Validate the two URL segments and say which object they mean.
 *
 * Returns null for anything that is not exactly a card id and a digest file.
 * The caller answers null with 404 and nothing else: a request that fails here
 * never reaches the network, so a probe learns nothing about what exists.
 */
export function parseBackImageRequest(
  cardId: string,
  file: string,
): BackImageTarget | null {
  if (!CARD_ID.test(cardId)) return null;
  const match = FILE_NAME.exec(file);
  if (!match) return null;
  const contentType = CONTENT_TYPE[match[2]];
  if (!contentType) return null;
  return {
    objectPath: `${BACK_IMAGE_OBJECT_PREFIX}${cardId}/${file}`,
    contentType,
    digest: match[1],
  };
}

/** Whether a stored back_image_url belongs to this scheme at all. */
export function isBackImagePath(url: string): boolean {
  if (!url.startsWith(BACK_IMAGE_PREFIX)) return false;
  const rest = url.slice(BACK_IMAGE_PREFIX.length).split("/");
  if (rest.length !== 2) return false;
  return parseBackImageRequest(rest[0], rest[1]) !== null;
}
