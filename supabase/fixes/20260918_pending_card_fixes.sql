-- ============================================================
-- Every outstanding card fix, in one file
--
-- CONSOLIDATED ON PURPOSE. These shipped as three separate files and two of
-- them never reached the database, so they are gathered here to be run once.
-- All four statements are plain UPDATE by id: no transaction block, no
-- INSERT, no position shuffling, nothing that can half-apply.
--
-- The one outstanding change NOT folded in is the G cell INSERT
-- (20260917_add_g_cell_card.sql). That file has failed to land three times and
-- is the only one that shuffles positions, so it stays separate rather than
-- taking these four down with it.
--
-- FOUR CARDS, all found by Mikko while studying, all the same family: a closed
-- set whose members sat on different cloze indices, so whichever member was
-- hidden had the others printed beside it.
--
--   1. diols          e1388a68   TWO split pairs on one card
--   2. E/Z notation   b8f1fb73   the answer spelled out by another group
--   3. amnesia        58c5f82d   split pair, plus a verbatim leak
--   4. cofactors      57a737b7   split pair
--
-- Every rewrite below was put through checkRewriteSafety before being written:
-- all four come back MERGE_GROUPS with no violations, and each now records its
-- pair as co-masked, which is what stops a future audit proposing the split
-- back.
-- ============================================================

-- ── 1. Naming Organic Molecules: diols ──────────────────────────────────
--
-- The card carried TWO closed pairs and split both:
--
--   c1 "same carbon"     vs  c3 "adjacent carbons"     the positions
--   c2 "geminal diols"   vs  c4 "vicinal diols"        the names
--
-- Studying c1 printed "adjacent carbons"; studying c2 printed "vicinal diols".
-- Either way the hidden half followed from the visible one.
--
-- Each pair now shares a group: positions on c1, names on c2, and the
-- dehydration fact keeps its own group, renumbered from c5 to c3. The card
-- ends up testing one axis at a time, which is what it was trying to do.
--
-- cloze_count 5 -> 3.
UPDATE public.flashcards
SET
  cloze_text = 'Diols with both hydroxyl groups on the {{c1::same carbon}} are called {{c2::geminal diols}}; diols with hydroxyl groups on {{c1::adjacent carbons}} are called {{c2::vicinal diols}}. {{c2::Geminal diols}} are unstable and spontaneously {{c3::dehydrate}} to form a carbonyl compound (C=O).',
  cloze_count = 3
WHERE id = 'e1388a68-3e7a-45c2-9ea5-8eab42b29d19';

-- ── 2. Isomerism & Stereochemistry: E/Z notation ────────────────────────
--
-- c1 hid "E/Z" while c3 printed its letters two lines below as "-> Z
-- (zusammen)" and "-> E (entgegen)". The answer was on screen one character at
-- a time, which the verbatim check could not see because it compares whole
-- strings. The notation name now masks with its own letters.
--
-- The German glosses stay visible deliberately: they are the mnemonic the card
-- exists to teach, and a student still has to know which arrangement is which.
--
-- NOTED, NOT FIXED: at 49 words this card is nearly double the house bar of
-- about 28. Tightening it deserves its own pass.
--
-- cloze_count 3 -> 2.
UPDATE public.flashcards
SET
  cloze_text = 'For alkenes with poly-substituted double bonds, configuration is given by {{c1::E/Z}} notation rather than cis/trans. Apply CIP rules at each double-bonded carbon to identify the higher-priority substituent on each side; if both higher-priority groups are on the {{c2::same side}} → {{c1::Z}} (zusammen); if on {{c2::opposite sides}} → {{c1::E}} (entgegen).',
  cloze_count = 2
WHERE id = 'b8f1fb73-2b10-40f0-b90e-6182d49732be';

-- ── 3. Brain, Behavior & Development: amnesia ───────────────────────────
--
-- Anterograde and retrograde sat on c1 and c3, so each printed the other. Both
-- move to c1; each keeps its own definition immediately after it, so the card
-- now asks you to match two definitions to two names.
--
-- A SECOND DEFECT, found by the checker: c2 hid "new" while the final clause
-- printed "the ability to form new memories often preserved". That blank is
-- dropped. It was the weaker of the two remaining in any case, since "the
-- inability to form ____ long-term memories" is close to forced by the grammar.
--
-- cloze_count 4 -> 2, with "before" renumbered to c2.
UPDATE public.flashcards
SET
  cloze_text = 'After hippocampal damage, patients typically show {{c1::anterograde amnesia}}, the inability to form new long-term memories from that point forward, while older memories remain intact. {{c1::Retrograde amnesia}} is the loss of memories formed {{c2::before}} the injury, with the ability to form new memories often preserved.',
  cloze_count = 2
WHERE id = '58c5f82d-2812-4f9a-8649-d13fb9f41c51';

-- ── 4. Enzymes: cofactors and coenzymes ─────────────────────────────────
--
-- Studying c1 printed "coenzymes"; studying c3 printed "Cofactors". The stem
-- sets the two against each other with "while", so whichever showed handed over
-- the other.
--
-- Worth noting that whoever wrote this card ALREADY got the other pair right:
-- "inorganic" and "organic" share c2 and mask together. Only the
-- cofactor/coenzyme pair was left split.
--
-- cloze_count 3 -> 2. Groups end up c1 and c2, already contiguous.
UPDATE public.flashcards
SET
  cloze_text = '{{c1::Cofactors}} are non-protein helpers required for enzyme activity; they are typically {{c2::inorganic}} (metal ions like Zn²⁺, Mg²⁺), while {{c1::coenzymes}} are small {{c2::organic}} helpers, usually vitamin-derived.',
  cloze_count = 2
WHERE id = '57a737b7-6bb0-46ca-9070-03fad0f9eb2a';

-- ── Verification: expect 4 rows with cloze_count 3, 2, 2, 2 ─────────────
SELECT id, cloze_count, cloze_text
FROM public.flashcards
WHERE id IN (
  'e1388a68-3e7a-45c2-9ea5-8eab42b29d19',
  'b8f1fb73-2b10-40f0-b90e-6182d49732be',
  '58c5f82d-2812-4f9a-8649-d13fb9f41c51',
  '57a737b7-6bb0-46ca-9070-03fad0f9eb2a'
);
