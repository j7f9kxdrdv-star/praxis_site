/*
 * Attach an image to a card's ANSWER.
 *
 *   node scripts/flashcards/attach-answer-image.mjs \
 *     --card "buoyant force is F_(b)" \
 *     --image ~/Desktop/buoyancy.png \
 *     --alt "A block floating in water, with the displaced volume shaded"
 *
 *   ... --card <uuid>      exact, when the search finds too many
 *   ... --apply            write it, instead of only printing the SQL
 *
 * WHAT THIS IS FOR. Mikko makes the images and hands over a card and a picture
 * each time. Doing that by hand is four fiddly steps that are easy to get
 * subtly wrong: find the right card among 4,116, put the file somewhere the app
 * actually serves, write the path with no typo, and update exactly one row. So
 * it is one command.
 *
 * NOT the image inside cloze_text. That one is the QUESTION: on the twenty
 * amino acid cards the structure is what you are being asked to name, and it
 * has to stay on the front. This is the other slot, shown under the card once
 * the answer is revealed.
 *
 * REFUSES rather than guesses. An ambiguous search prints the matches and
 * stops, and a card that already has an image has to be passed --replace.
 */
import { db, page } from "./lib/contrast-vocab.mjs";
import fs from "fs";
import path from "path";
import { execFileSync } from "child_process";

const args = process.argv.slice(2);
const arg = (n) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const has = (n) => args.includes(n);

const cardArg = arg("--card");
const imageArg = arg("--image");
const altArg = arg("--alt");
const APPLY = has("--apply");
const REPLACE = has("--replace");

if (!cardArg || !imageArg || !altArg) {
  console.error("usage: --card <uuid|text> --image <file> --alt <description> [--apply] [--replace]");
  process.exit(1);
}

// ─── The image ─────────────────────────────────────────────────────────────
const src = imageArg.replace(/^~/, process.env.HOME ?? "~");
if (!fs.existsSync(src)) { console.error(`no such file: ${src}`); process.exit(1); }

const ext = path.extname(src).toLowerCase();
const ALLOWED = [".png", ".jpg", ".jpeg", ".webp", ".svg"];
if (!ALLOWED.includes(ext)) {
  console.error(`${ext} is not one of ${ALLOWED.join(", ")}`);
  process.exit(1);
}
const bytes = fs.statSync(src).size;
// Not a hard limit, a warning: these load on a phone, often on cellular.
if (bytes > 400_000) console.log(`NOTE: ${(bytes / 1024).toFixed(0)}KB is large for a card image.`);

let dims = "";
try {
  const out = execFileSync("sips", ["-g", "pixelWidth", "-g", "pixelHeight", src], { encoding: "utf8" });
  const w = out.match(/pixelWidth: (\d+)/)?.[1];
  const h = out.match(/pixelHeight: (\d+)/)?.[1];
  if (w && h) dims = `${w}x${h}`;
} catch { /* sips is macOS-only and svg has no raster size; not worth failing over */ }

// ─── The card ──────────────────────────────────────────────────────────────
const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const cards = await page("flashcards", "id,deck_id,cloze_text,back_image_url", ["id", "id"]);
const { data: decks } = await db.from("flashcard_decks").select("id,title");
const deckTitle = new Map(decks.map((d) => [d.id, d.title]));

const needle = cardArg.toLowerCase();
const matches = UUID.test(cardArg)
  ? cards.filter((c) => c.id === cardArg)
  : cards.filter((c) => (c.cloze_text ?? "").toLowerCase().includes(needle));

if (matches.length === 0) { console.error(`no card matches "${cardArg}"`); process.exit(1); }
if (matches.length > 1) {
  console.error(`"${cardArg}" matches ${matches.length} cards. Pass one of these ids as --card:\n`);
  for (const c of matches.slice(0, 12)) {
    console.error(`  ${c.id}  [${deckTitle.get(c.deck_id)}]`);
    console.error(`     ${c.cloze_text.replace(/\s+/g, " ").slice(0, 120)}`);
  }
  if (matches.length > 12) console.error(`  ... and ${matches.length - 12} more`);
  process.exit(1);
}

const card = matches[0];
if (card.back_image_url && !REPLACE) {
  console.error(`that card already has an answer image: ${card.back_image_url}`);
  console.error("pass --replace to overwrite it.");
  process.exit(1);
}

// ─── Where it goes ─────────────────────────────────────────────────────────
// Beside the amino acid structures, one folder per deck, so the twenty images
// already on disk and every new one live under the same root.
const slug = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
const deckDir = slug(deckTitle.get(card.deck_id) ?? "misc");
const base = `${slug(path.basename(src, ext)) || card.id.slice(0, 8)}${ext}`;
const rel = `/flashcards/${deckDir}/answers/${base}`;
const dest = path.join(process.cwd(), "public", rel);

// The column's CHECK constraint enforces this too; failing here gives a better
// message than a Postgres violation would.
if (!/^\/flashcards\/[A-Za-z0-9._/-]+$/.test(rel)) {
  console.error(`generated path is not allowed: ${rel}`);
  process.exit(1);
}

const alt = altArg.trim();
if (!alt) { console.error("--alt cannot be empty: the image is unusable with a screen reader without it."); process.exit(1); }

console.log(`card    ${card.id}  [${deckTitle.get(card.deck_id)}]`);
console.log(`        ${card.cloze_text.replace(/\s+/g, " ").slice(0, 150)}`);
console.log(`image   ${src}`);
console.log(`        ${(bytes / 1024).toFixed(0)}KB${dims ? `, ${dims}` : ""} -> public${rel}`);
console.log(`alt     ${alt}`);

const q = (s) => `'${s.replace(/'/g, "''")}'`;
const sql = `-- ${deckTitle.get(card.deck_id)}: answer image
UPDATE public.flashcards
SET back_image_url = ${q(rel)},
    back_image_alt = ${q(alt)}
WHERE id = '${card.id}';
`;

if (!APPLY) {
  console.log(`\n--- not applied (pass --apply) ---\n${sql}`);
  process.exit(0);
}

fs.mkdirSync(path.dirname(dest), { recursive: true });
fs.copyFileSync(src, dest);
const { error } = await db.from("flashcards")
  .update({ back_image_url: rel, back_image_alt: alt })
  .eq("id", card.id);
if (error) { console.error(`\nthe file was copied but the row was not updated: ${error.message}`); process.exit(1); }

console.log(`\napplied. Commit public${rel} and push, or the path 404s in production.`);
