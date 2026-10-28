/**
 * The image route, run as production code, against an in-memory stand-in for
 * the four Supabase endpoints it calls: the profile read, the card read, the
 * entitlement rule and the storage object.
 *
 * Self-contained on purpose, so it ships with the route fix on its own branch
 * (app/flashcards/backs/[cardId]/[file]/route.ts). The same cases run against
 * a real PostgreSQL with the publisher installed in
 * supabase/tests/imageRoute.db.test.ts on the feature branch.
 *
 * The stand-in also records every call the route makes, so the tests can say
 * exactly what each request costs the database.
 */
import { afterAll, beforeAll, beforeEach, describe, expect, it } from "vitest";
import { createHash, randomUUID } from "node:crypto";
import http from "node:http";
import type { AddressInfo } from "node:net";
import { IMAGE_SESSION_COOKIE, mintImageSession } from "@/lib/flashcards/imageSession";

const SECRET = "route-test-image-session-secret-0123456789";
const SERVICE_KEY = "route-test-service-key";

const cards = new Map<string, string | null>();                  // card id -> back_image_url
const objects = new Map<string, { bytes: Buffer; type: string }>(); // object path -> stored bytes
const markers = new Map<string, string | null>();                 // user id -> image_sessions_valid_from
const entitled = new Set<string>();
const unreadableCards = new Set<string>();
let calls: string[] = [];

let server: http.Server;
let GET: (req: Request, ctx: { params: Promise<{ cardId: string; file: string }> }) => Promise<Response>;

const sha = (b: Buffer) => createHash("sha256").update(b).digest("hex");
const json = (res: http.ServerResponse, single: boolean, rows: unknown[]) => {
  if (single && rows.length !== 1) {
    res.writeHead(406, { "content-type": "application/json" }).end(JSON.stringify({ message: "not one row" }));
    return;
  }
  res.writeHead(200, { "content-type": "application/json" }).end(JSON.stringify(single ? rows[0] : rows));
};

beforeAll(async () => {
  server = http.createServer(async (req, res) => {
    if (req.headers.authorization !== `Bearer ${SERVICE_KEY}`) {
      res.writeHead(401).end();
      return;
    }
    const url = new URL(req.url ?? "/", "http://x");
    const id = (url.searchParams.get("id") ?? "").replace(/^eq\./, "");
    const single = (req.headers.accept ?? "").includes("vnd.pgrst.object");
    if (req.method === "GET" && url.pathname === "/rest/v1/profiles") {
      calls.push("profile");
      json(res, single, markers.has(id) ? [{ image_sessions_valid_from: markers.get(id) }] : []);
      return;
    }
    if (req.method === "GET" && url.pathname === "/rest/v1/flashcards") {
      calls.push("card");
      if (unreadableCards.has(id)) {
        res.writeHead(500, { "content-type": "application/json" }).end(JSON.stringify({ message: "simulated read failure" }));
        return;
      }
      json(res, single, cards.has(id) ? [{ back_image_url: cards.get(id) }] : []);
      return;
    }
    if (req.method === "POST" && url.pathname.startsWith("/rest/v1/rpc/")) {
      const chunks: Buffer[] = [];
      for await (const c of req) chunks.push(c as Buffer);
      const body = chunks.length ? JSON.parse(Buffer.concat(chunks).toString("utf8")) : {};
      if (url.pathname.endsWith("/has_content_entitlement_for")) {
        calls.push("entitlement");
        res.writeHead(200, { "content-type": "application/json" }).end(JSON.stringify(entitled.has(body.p_user)));
        return;
      }
      if (url.pathname.endsWith("/entitlement_guard_installed")) {
        res.writeHead(200, { "content-type": "application/json" }).end("true");
        return;
      }
    }
    const obj = url.pathname.match(/^\/storage\/v1\/object\/flashcard-images\/(.+)$/);
    if (req.method === "GET" && obj) {
      calls.push("storage");
      const o = objects.get(decodeURIComponent(obj[1]));
      if (!o) {
        res.writeHead(400, { "content-type": "application/json" }).end(JSON.stringify({ error: "not_found" }));
        return;
      }
      res.writeHead(200, { "content-type": o.type, "content-length": String(o.bytes.length) }).end(o.bytes);
      return;
    }
    res.writeHead(404).end();
  });
  await new Promise<void>((r) => server.listen(0, "127.0.0.1", () => r()));
  process.env.NEXT_PUBLIC_SUPABASE_URL = `http://127.0.0.1:${(server.address() as AddressInfo).port}`;
  process.env.SUPABASE_SERVICE_ROLE_KEY = SERVICE_KEY;
  process.env.IMAGE_SESSION_SECRET = SECRET;
  ({ GET } = await import("@/app/flashcards/backs/[cardId]/[file]/route"));
});
afterAll(async () => {
  await new Promise<void>((r) => server.close(() => r()));
});
beforeEach(() => {
  calls = [];
});

type Image = { url: string; path: string; bytes: Buffer; digest: string };
/** Store an image the way the pipeline does: named by the start of its own SHA-256. */
function store(cardId: string, label: string, ext: "webp" | "png" = "webp"): Image {
  const bytes = Buffer.from(`${ext}:${label}:${randomUUID()}`);
  const digest = sha(bytes).slice(0, 8);
  const path = `cards/${cardId}/${digest}.${ext}`;
  objects.set(path, { bytes, type: ext === "webp" ? "image/webp" : "image/png" });
  return { url: `/flashcards/backs/${cardId}/${digest}.${ext}`, path, bytes, digest };
}
function card(image: Image | null = null): string {
  const id = randomUUID();
  cards.set(id, image?.url ?? null);
  return id;
}
function learner({ paid = true, marker = null as string | null } = {}): string {
  const id = randomUUID();
  markers.set(id, marker);
  if (paid) entitled.add(id);
  return id;
}

/** A request from `user` (null: signed out), with an image session minted against `mintMarker`. */
async function get(url: string, user: string | null, extra: Record<string, string> = {}, mintMarker?: string | null) {
  const headers: Record<string, string> = { ...extra };
  if (user) {
    const { token } = mintImageSession(user, SECRET, mintMarker !== undefined ? mintMarker : markers.get(user) ?? null);
    headers.cookie = `${IMAGE_SESSION_COOKIE}=${token}`;
  }
  const [, , , cardId, file] = url.split("?")[0].split("/");
  const res = await GET(new Request(`http://localhost${url}`, { headers }), { params: Promise.resolve({ cardId, file }) });
  return {
    status: res.status,
    headers: res.headers,
    bytes: res.status === 200 ? Buffer.from(await res.arrayBuffer()) : null,
  };
}
const count = (what: string) => calls.filter((c) => c === what).length;

describe("the image route serves a card's current illustration, and nothing else", () => {
  it("serves the current approved image to an entitled learner, byte for byte, at one card lookup", async () => {
    const me = learner();
    const id = card();
    const img = store(id, "current");
    cards.set(id, img.url);
    const r = await get(img.url, me);
    expect(r.status).toBe(200);
    expect(r.headers.get("content-type")).toBe("image/webp");
    expect(r.headers.get("cache-control")).toBe("private, no-cache, must-revalidate");
    expect(r.headers.get("etag")).toBe(`"${img.digest}"`);
    expect(r.bytes).toEqual(img.bytes);
    expect([count("profile"), count("card"), count("entitlement"), count("storage")]).toEqual([1, 1, 1, 1]);
    // The study screen's retry adds a query string; it is the same path.
    expect((await get(`${img.url}?r=1`, me)).status).toBe(200);
  });

  it("refuses an image the quarantine removed from its card, without touching storage", async () => {
    const me = learner();
    const id = card();
    const img = store(id, "quarantined");
    cards.set(id, img.url);
    expect((await get(img.url, me)).status).toBe(200);
    cards.set(id, null);
    calls = [];
    const r = await get(img.url, me);
    expect(r.status).toBe(404);
    expect(r.headers.get("cache-control")).toBe("no-store");
    expect(count("storage")).toBe(0);
  });

  it("after a replacement, serves the new image and refuses the old one", async () => {
    const me = learner();
    const id = card();
    const before = store(id, "before");
    cards.set(id, before.url);
    const after = store(id, "after");
    cards.set(id, after.url);
    expect((await get(after.url, me)).status).toBe(200);
    expect((await get(before.url, me)).status).toBe(404);
  });

  it("refuses an uploaded image the card does not show yet (staged, not published)", async () => {
    const me = learner();
    const id = card();
    const staged = store(id, "staged");
    expect(objects.has(staged.path)).toBe(true);
    expect((await get(staged.url, me)).status).toBe(404);
    const live = store(id, "live");
    cards.set(id, live.url);
    expect((await get(staged.url, me)).status).toBe(404);
  });

  it("refuses the PNG master stored beside the live WebP", async () => {
    const me = learner();
    const id = card();
    const master = store(id, "master", "png");
    const live = store(id, "live");
    cards.set(id, live.url);
    expect((await get(live.url, me)).status).toBe(200);
    expect((await get(master.url, me)).status).toBe(404);
  });

  it("refuses another card's image under the wrong card id, an unknown file and an unknown card", async () => {
    const me = learner();
    const a = card();
    const b = card();
    const imgB = store(b, "b");
    cards.set(b, imgB.url);
    const file = imgB.url.split("/").pop()!;
    expect((await get(`/flashcards/backs/${a}/${file}`, me)).status).toBe(404);
    expect((await get(`/flashcards/backs/${b}/deadbeef.webp`, me)).status).toBe(404);
    expect((await get(`/flashcards/backs/${randomUUID()}/${file}`, me)).status).toBe(404);
  });

  it("refuses, never guesses, when the card cannot be read", async () => {
    const me = learner();
    const id = card();
    const img = store(id, "unreadable");
    cards.set(id, img.url);
    unreadableCards.add(id);
    const r = await get(img.url, me);
    expect(r.status).toBe(403);
    expect(r.headers.get("x-praxist-denied")).toBe("card_unreadable");
    expect(count("storage")).toBe(0);
  });

  it("refuses bytes that no longer hash to the digest in their path", async () => {
    const me = learner();
    const id = card();
    const img = store(id, "tamper");
    cards.set(id, img.url);
    objects.set(img.path, { bytes: Buffer.from("not the approved image"), type: "image/webp" });
    const r = await get(img.url, me);
    expect(r.status).toBe(502);
    expect(r.headers.get("cache-control")).toBe("no-store");
    expect(r.headers.get("x-praxist-integrity")).toBe("mismatch");
    expect(r.bytes).toBeNull();
  });
});

describe("the existing protections are unchanged", () => {
  it("a signed-out request is refused before any database or storage call", async () => {
    const id = card();
    const img = store(id, "out");
    cards.set(id, img.url);
    const r = await get(img.url, null);
    expect(r.status).toBe(403);
    expect(r.headers.get("x-praxist-denied")).toBe("session_absent");
    expect(calls).toEqual([]);
  });

  it("an unentitled account is refused, and storage is never read", async () => {
    const unpaid = learner({ paid: false });
    const id = card();
    const img = store(id, "unpaid");
    cards.set(id, img.url);
    const r = await get(img.url, unpaid);
    expect(r.status).toBe(403);
    expect(count("storage")).toBe(0);
    // It learns nothing about which paths are current: refused either way.
    expect((await get(`/flashcards/backs/${id}/deadbeef.webp`, unpaid)).status).toBe(403);
  });

  it("signing out still kills an image session minted before it", async () => {
    const me = learner({ marker: null });
    const id = card();
    const img = store(id, "signout");
    cards.set(id, img.url);
    expect((await get(img.url, me)).status).toBe(200);
    markers.set(me, new Date().toISOString()); // what sign-out writes
    const r = await get(img.url, me, {}, null);   // the cookie minted before sign-out
    expect(r.status).toBe(403);
    expect(r.headers.get("x-praxist-denied")).toBe("session_superseded");
  });
});

describe("a conditional request (304) is authorized exactly like a full one", () => {
  it("answers 304 only for the current image and an entitled, current session, and never reads storage for it", async () => {
    const me = learner({ marker: null });
    const unpaid = learner({ paid: false });
    const id = card();
    const old = store(id, "etag-old");
    cards.set(id, old.url);
    const fresh = store(id, "etag-new");
    cards.set(id, fresh.url);
    const inm = (img: Image) => ({ "if-none-match": `"${img.digest}"` });

    calls = [];
    expect((await get(fresh.url, me, inm(fresh))).status).toBe(304);
    expect(count("storage")).toBe(0);
    expect(count("card")).toBe(1);

    expect((await get(old.url, me, inm(old))).status).toBe(404);
    expect((await get(fresh.url, null, inm(fresh))).status).toBe(403);
    expect((await get(fresh.url, unpaid, inm(fresh))).status).toBe(403);
    cards.set(id, null);
    expect((await get(fresh.url, me, inm(fresh))).status).toBe(404); // quarantined while cached
    cards.set(id, fresh.url);
    markers.set(me, new Date().toISOString());
    expect((await get(fresh.url, me, inm(fresh), null)).status).toBe(403); // signed out while cached
  });
});
