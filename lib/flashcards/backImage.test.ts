import { describe, it, expect } from "vitest";
import fs from "node:fs";
import path from "node:path";
import {
  BACK_IMAGE_BUCKET,
  BACK_IMAGE_PREFIX,
  backImagePath,
  isBackImagePath,
  parseBackImageRequest,
} from "@/lib/flashcards/backImage";

// ─── THE ROUTE IS ONLY AS SAFE AS THIS FILE ─────────────────────────────────
//
// app/flashcards/backs/[cardId]/[file]/route.ts fetches from a bucket with the
// service role key. The single thing standing between a request and that fetch
// is parseBackImageRequest returning null. So the interesting tests here are
// the refusals, not the happy path.

const CARD = "2159e61c-4077-431a-8584-0d223b97f8af";
const DIGEST = "349a0b20";

describe("the path a card stores", () => {
  it("is a local path under /flashcards/, which is all the database accepts", () => {
    expect(backImagePath(CARD, DIGEST)).toBe(
      `/flashcards/backs/${CARD}/${DIGEST}.png`,
    );
  });

  it("matches the database CHECK constraint as actually written in the migration", () => {
    // Read the constraint out of the migration rather than restating it, so
    // this test fails if the two ever drift apart.
    const sql = fs.readFileSync(
      path.join(
        process.cwd(),
        "supabase/migrations/20260908_flashcard_answer_image.sql",
      ),
      "utf8",
    );
    const found = sql.match(/back_image_url\s*~\s*'(\^[^']+\$)'/);
    expect(found, "the migration still states the url constraint").not.toBeNull();
    const constraint = new RegExp(found![1]);
    expect(constraint.test(backImagePath(CARD, DIGEST))).toBe(true);
    expect(constraint.test(backImagePath(CARD, DIGEST, "webp"))).toBe(true);
  });

  it("refuses to build a path it would later refuse to serve", () => {
    expect(() => backImagePath("../../etc", DIGEST)).toThrow();
    expect(() => backImagePath(CARD, "../secret")).toThrow();
  });
});

describe("what the route will fetch", () => {
  it("resolves a valid pair to one object in the one bucket", () => {
    expect(parseBackImageRequest(CARD, `${DIGEST}.png`)).toEqual({
      objectPath: `cards/${CARD}/${DIGEST}.png`,
      contentType: "image/png",
      digest: DIGEST,
    });
  });

  it("keeps the bucket a constant, not something a request can reach", () => {
    expect(BACK_IMAGE_BUCKET).toBe("flashcard-images");
    expect(BACK_IMAGE_PREFIX).toBe("/flashcards/backs/");
  });

  it.each([
    ["a parent directory in the card id", "..", `${DIGEST}.png`],
    ["a parent directory in the file", CARD, "../../secret.png"],
    ["an encoded slash", CARD, "..%2f..%2fsecret.png"],
    ["a backslash", CARD, `${DIGEST}\\..\\secret.png`],
    ["a nested path", CARD, `sub/${DIGEST}.png`],
    ["an absolute url as the card id", "https://evil.example", `${DIGEST}.png`],
    ["a protocol-relative file", CARD, "//evil.example/x.png"],
    ["a card id that is not a uuid", "not-a-uuid", `${DIGEST}.png`],
    ["an uppercase uuid, since the stored form is lowercase", CARD.toUpperCase(), `${DIGEST}.png`],
    ["a digest that is not hex", CARD, "zzzzzzzz.png"],
    ["a digest that is too short", CARD, "abc.png"],
    ["no extension", CARD, DIGEST],
    ["a double extension", CARD, `${DIGEST}.png.svg`],
    ["an empty card id", "", `${DIGEST}.png`],
    ["an empty file", CARD, ""],
    ["a null byte", CARD, `${DIGEST}.png\u0000`],
    ["trailing whitespace", CARD, `${DIGEST}.png `],
  ])("refuses %s", (_why, cardId, file) => {
    expect(parseBackImageRequest(cardId, file)).toBeNull();
  });

  it("refuses SVG, which is a document that can carry script", () => {
    expect(parseBackImageRequest(CARD, `${DIGEST}.svg`)).toBeNull();
  });

  it("serves webp as webp, so the files can be compressed without a code change", () => {
    expect(parseBackImageRequest(CARD, `${DIGEST}.webp`)?.contentType).toBe(
      "image/webp",
    );
  });
});

describe("recognising a stored url", () => {
  it("accepts what this scheme wrote", () => {
    expect(isBackImagePath(backImagePath(CARD, DIGEST))).toBe(true);
  });

  it("leaves the amino acid prompt images alone, which are real files in public/", () => {
    expect(
      isBackImagePath("/flashcards/amino-acids/structures/alanine.png"),
    ).toBe(false);
  });

  it("rejects an external url outright", () => {
    expect(isBackImagePath("https://example.com/x.png")).toBe(false);
  });
});
