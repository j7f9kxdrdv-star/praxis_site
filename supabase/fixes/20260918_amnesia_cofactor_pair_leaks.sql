-- ============================================================
-- Two more closed pairs split across indices
--
-- ONE: anterograde and retrograde amnesia.
-- TWO: cofactors and coenzymes.
--
-- FOUND WHILE STUDYING, 2026-09-18. As it stood, with FOUR groups:
--
--   After hippocampal damage, patients typically show {{c1::anterograde
--   amnesia}}, the inability to form {{c2::new}} long-term memories from that
--   point forward, while older memories remain intact. {{c3::Retrograde
--   amnesia}} is the loss of memories formed {{c4::before}} the injury, with
--   the ability to form new memories often preserved.
--
-- The two terms are a defining opposed pair and sat on different indices, so
-- studying c1 printed "Retrograde amnesia" and studying c3 printed
-- "anterograde amnesia". Either way the hidden half follows from the visible
-- one for anyone who knows the pair exists. Fourth instance of this defect in
-- two days.
--
-- A SECOND DEFECT, FOUND BY THE CHECKER AFTER THE FIRST ATTEMPT. Studying c2
-- hides "new" while the card's final clause prints "the ability to form new
-- memories often preserved". The answer is sitting on the card in plain text.
-- VERBATIM_ANSWER_VISIBLE, code-proven, and missed in the first pass because I
-- was looking at the pair and not at the whole card.
--
-- So the "new" blank goes. It was the weaker of the two remaining blanks in any
-- case: "the inability to form ____ long-term memories" is close to forced by
-- the grammar even without the word appearing later. The sentence keeps the
-- word, it simply stops being a question.
--
-- BOTH TERMS MOVE TO c1. The card stays answerable because each term keeps its
-- own definition immediately after it: "the inability to form new long-term
-- memories from that point forward" and "the loss of memories formed before the
-- injury". The student now matches two definitions to two names instead of
-- being handed one of them.
--
-- THE GAP IS CLOSED. After merging and dropping "new", the groups left were c1
-- and c4. cloze_count 2 against a queue walking 1 and 2 would have made item 2
-- match no blank and show the whole card with its answers in place. "before" is
-- renumbered to c2.
--
-- cloze_count 4 -> 2. Two scheduling units stop being scheduled; their review
-- rows stay, because those reviews really happened.
--
-- NOT CHANGED, NOTED. "memories formed ____ the injury" is still a weak blank,
-- since "retro" two lines above most of the way gives it. It is not a leak in
-- either the closed-pair or the verbatim sense, and tightening it is a rewrite
-- rather than a regroup, so it is left alone rather than changed on my own
-- initiative.
--
-- Verified after: "anterograde amnesia || retrograde amnesia" recorded as
-- co-masked, and ZERO structural leaks where the card previously had one.
-- checkRewriteSafety reports DROPS_TESTED_ANSWER, which is correct and is the
-- point: "new" is deliberately no longer a tested answer.
--
-- UPDATE by id. No reseed.
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = 'After hippocampal damage, patients typically show {{c1::anterograde amnesia}}, the inability to form new long-term memories from that point forward, while older memories remain intact. {{c1::Retrograde amnesia}} is the loss of memories formed {{c2::before}} the injury, with the ability to form new memories often preserved.',
  cloze_count = 2
WHERE id = '58c5f82d-2812-4f9a-8649-d13fb9f41c51';

-- ============================================================
-- TWO: cofactors and coenzymes
--
--   {{c1::Cofactors}} are non-protein helpers required for enzyme activity;
--   they are typically {{c2::inorganic}} (metal ions like Zn2+, Mg2+), while
--   {{c3::coenzymes}} are small {{c2::organic}} helpers, usually vitamin-derived.
--
-- Studying c1 printed "coenzymes"; studying c3 printed "Cofactors". The stem
-- sets the two against each other with "while", so whichever is showing hands
-- over the other.
--
-- WORTH NOTING: whoever wrote this card ALREADY got the other pair right.
-- "inorganic" and "organic" share c2 and mask together, which is exactly the
-- correct treatment. Only the cofactor/coenzyme pair was left split.
--
-- Both terms move to c1. Groups become c1 and c2, already contiguous, so no
-- renumbering is needed. cloze_count 3 -> 2.
--
-- Verified: MERGE_GROUPS, safety clean, and the card now records TWO co-masked
-- pairs, "coenzymes || cofactors" and "inorganic || organic".
-- ============================================================

UPDATE public.flashcards
SET
  cloze_text = '{{c1::Cofactors}} are non-protein helpers required for enzyme activity; they are typically {{c2::inorganic}} (metal ions like Zn²⁺, Mg²⁺), while {{c1::coenzymes}} are small {{c2::organic}} helpers, usually vitamin-derived.',
  cloze_count = 2
WHERE id = '57a737b7-6bb0-46ca-9070-03fad0f9eb2a';

-- ── Verification ────────────────────────────────────────────────────────
SELECT id, cloze_count, cloze_text
FROM public.flashcards
WHERE id IN (
  '58c5f82d-2812-4f9a-8649-d13fb9f41c51',
  '57a737b7-6bb0-46ca-9070-03fad0f9eb2a'
);
