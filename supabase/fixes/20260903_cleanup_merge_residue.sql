-- ============================================================
-- Clean up after earlier merges
--
-- Found by the verification query on the split-contrast migration, which is
-- bank-wide rather than scoped to that batch. It reported 41 orphans that the
-- batch did not create. They came from merges in earlier sessions where
-- cloze_count was reduced without touching the progress underneath.
--
-- TWO SEPARATE PROBLEMS, and only the second one actually matters.
--
-- 1. 41 orphaned rows: progress pointing at a blank that no longer exists.
--    Harmless, because the study page only ever asks for blanks 1..cloze_count,
--    so nothing reads them. Deleted here as hygiene.
--
-- 2. 57 SURVIVING blanks on those same 29 cards still carry the stability
--    they earned BEFORE the merge, when the card was still leaking its own
--    answer. That evidence does not transfer: the merged blank asks a harder
--    question than the one that was graded. 16 of them are scheduled past the
--    2026-09-12 exam on that inflated confidence, the worst sitting on 87 days
--    of stability and due 2026-11-02.
--
-- These are reset to due now, as REVIEWS rather than new cards, so they come
-- back immediately instead of queueing behind the daily new-card limit. Their
-- rep and lapse history is kept; only the schedule is rebuilt.
--
-- NOT TOUCHED: the 1,160 blanks bank-wide scheduled past the exam. Those were
-- checked and they are legitimate. A sampled row with 7.85 days of stability
-- scheduled at 40 days works out to 88.6% predicted recall, right on the 0.90
-- target. Those cards are genuinely well known. Use Extra Study to reach them
-- before the exam; it ignores due dates and serves most-overdue first.
-- ============================================================

BEGIN;

-- 1. Progress pointing at blanks that no longer exist.
DELETE FROM public.flashcard_user_state s
USING public.flashcards f
WHERE f.id = s.flashcard_id
  AND s.cloze_index > f.cloze_count;

-- 2. Rebuild the schedule on the blanks that survived those merges.
UPDATE public.flashcard_user_state
SET stability      = 2.0,
    interval_days  = 0,
    scheduled_days = 0,
    next_review_at = now(),
    fsrs_state     = 2,
    learning_steps = 0
WHERE flashcard_id IN (
  '0d203e8b-7fd7-4457-9443-6918a30bf02c',
  '0fd383e2-8570-4811-9f0b-7774e24414cd',
  '13281a26-cee4-432d-b74b-b7cb25a6a42c',
  '1349f19e-e173-4b98-bbf2-e3242a92d844',
  '14e2fa26-4c54-4409-bda9-cf7f1ee1814e',
  '1cb06b5d-84bf-45a8-b3b6-ce85e28a2e4d',
  '282e7404-76cf-4e6e-8051-10eab00d24b8',
  '3c79921f-63d0-456c-998f-69c703a7340f',
  '4278ae9e-713d-45fa-b9b1-8ae78158c3f9',
  '49cd4cc7-1e67-403f-9dff-3dd1dc169a54',
  '4eb7e4ec-f2ed-4ea8-8d46-4f43e3dc4208',
  '51cbfa33-1072-4b94-b5cb-f68dca1b30a9',
  '585deaf9-dbcd-46ba-8e91-5f8fc81970e2',
  '67eb7343-55b4-4f4f-bd4a-d6d713d2c6a8',
  '6a4cf538-947d-457d-9b2e-ed8495e0cc8d',
  '6d90402f-1053-4b92-806f-214ea05d8144',
  '7258535d-0375-4ff5-a7f4-260021478f52',
  '786699b1-095d-48a5-a341-19c3c95a56c9',
  '8c32f9ba-59de-4110-9e1b-89bd48da1030',
  '91e92211-4318-4fd7-a03c-322c7339d792',
  '96aadd80-438b-47aa-9326-324694289b47',
  '9a1aafbf-21ed-4d12-9172-50a2e68e72d7',
  'a9cbd3c8-a2ec-45a6-b5b2-cc3ed1e24a87',
  'b2b7a2a8-cbf8-4a6a-bcfc-8f6ac35f3b40',
  'c902c8a7-7136-429a-a4b2-85ca8d9c9447',
  'd2e76daa-909f-46d1-bd52-1fa1c2983b1a',
  'e17b39f7-5df8-45ed-af28-a885df433763',
  'e948523f-2b46-496b-af2b-2ed14b2ddf1c',
  'f890a850-0ed6-48da-a94f-22a6773fe44e'
);

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0.
SELECT COUNT(*) AS orphaned_progress
FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;

-- Expect 0: nothing from a merged card still scheduled past the exam.
SELECT COUNT(*) AS merged_cards_past_exam
FROM public.flashcard_user_state
WHERE flashcard_id IN ('0d203e8b-7fd7-4457-9443-6918a30bf02c','0fd383e2-8570-4811-9f0b-7774e24414cd','13281a26-cee4-432d-b74b-b7cb25a6a42c','1349f19e-e173-4b98-bbf2-e3242a92d844','14e2fa26-4c54-4409-bda9-cf7f1ee1814e','1cb06b5d-84bf-45a8-b3b6-ce85e28a2e4d','282e7404-76cf-4e6e-8051-10eab00d24b8','3c79921f-63d0-456c-998f-69c703a7340f','4278ae9e-713d-45fa-b9b1-8ae78158c3f9','49cd4cc7-1e67-403f-9dff-3dd1dc169a54','4eb7e4ec-f2ed-4ea8-8d46-4f43e3dc4208','51cbfa33-1072-4b94-b5cb-f68dca1b30a9','585deaf9-dbcd-46ba-8e91-5f8fc81970e2','67eb7343-55b4-4f4f-bd4a-d6d713d2c6a8','6a4cf538-947d-457d-9b2e-ed8495e0cc8d','6d90402f-1053-4b92-806f-214ea05d8144','7258535d-0375-4ff5-a7f4-260021478f52','786699b1-095d-48a5-a341-19c3c95a56c9','8c32f9ba-59de-4110-9e1b-89bd48da1030','91e92211-4318-4fd7-a03c-322c7339d792','96aadd80-438b-47aa-9326-324694289b47','9a1aafbf-21ed-4d12-9172-50a2e68e72d7','a9cbd3c8-a2ec-45a6-b5b2-cc3ed1e24a87','b2b7a2a8-cbf8-4a6a-bcfc-8f6ac35f3b40','c902c8a7-7136-429a-a4b2-85ca8d9c9447','d2e76daa-909f-46d1-bd52-1fa1c2983b1a','e17b39f7-5df8-45ed-af28-a885df433763','e948523f-2b46-496b-af2b-2ed14b2ddf1c','f890a850-0ed6-48da-a94f-22a6773fe44e')
  AND next_review_at > TIMESTAMPTZ '2026-09-12';
