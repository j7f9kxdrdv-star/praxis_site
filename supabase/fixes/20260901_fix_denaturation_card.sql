-- ============================================================
-- Denaturation: hide both causes together
--
-- Spotted by Mikko while studying.
--
--   The two main causes of denaturation are {{c1::heat}} ... and
--   {{c2::solutes}} ...
--
-- The stem says there are exactly two and shows one of them, so the blank is
-- answered by elimination rather than recall.
--
-- Merging c2 into c1 needs no renumbering, c2 being the highest group.
-- cloze_count goes 2 to 1. Blank 2 is orphaned at 2.5d, which is cheap.
--
-- BUT READ THE NEXT PARAGRAPH BEFORE RUNNING THIS.
--
-- Blank 1 carries 87.0 DAYS of stability, the highest on any card touched
-- tonight, and it SURVIVES the merge. That interval was earned answering
-- "heat" while "solutes" sat on screen. After this fix the same blank asks for
-- both causes, which is materially harder, but it keeps an 87 day interval
-- earned on the easier version.
--
-- FSRS self-corrects the first time the card is failed. The problem is when:
-- 87 days from now is long after the exam date on this account. So the
-- correction never happens before it matters, and the card silently drops out
-- of circulation.
--
-- The optional statement at the bottom brings that interval back to something
-- the new difficulty justifies. It is separated deliberately: the card repair
-- is mechanical, resetting earned progress is a judgement, and they should not
-- be one decision.
-- ============================================================

UPDATE public.flashcards SET
  cloze_text = 'The two main causes of denaturation are {{c1::heat}}, which overcomes hydrophobic and noncovalent interactions, and {{c1::solutes}} (including reducing agents and detergents), which break disulfide bridges and disrupt other forces.',
  cloze_count = 1
WHERE id = 'c902c8a7-7136-429a-a4b2-85ca8d9c9447';

-- ── Verification ────────────────────────────────────────────────────────
SELECT cloze_count,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text,
  (SELECT COUNT(*) FROM regexp_matches(cloze_text,'\{\{c\d+::','g')) AS blanks
FROM public.flashcards WHERE id = 'c902c8a7-7136-429a-a4b2-85ca8d9c9447';

SELECT cloze_index, ROUND(stability::numeric, 1) AS stability_days, next_review_at
FROM public.flashcard_user_state
WHERE flashcard_id = 'c902c8a7-7136-429a-a4b2-85ca8d9c9447' ORDER BY cloze_index;

-- ── OPTIONAL, and only if you agree with the reasoning above ─────────────
-- Bring the surviving blank back into circulation, since its 87 day interval
-- was earned on a question that no longer exists. 14 days is roughly what a
-- card of this difficulty would carry with a few honest reviews behind it, and
-- it puts the card in front of you before the exam rather than after.
--
-- UPDATE public.flashcard_user_state
-- SET stability = 14, next_review_at = now() + interval '3 days'
-- WHERE flashcard_id = 'c902c8a7-7136-429a-a4b2-85ca8d9c9447' AND cloze_index = 1;
