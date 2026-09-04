-- ============================================================
-- The middle-ear card had corrupt cloze markup
--
-- Stored text was:
--
--   the {{c1::malleus, incus, and }}{{c2::stapes}}{{c1:: (sometimes called
--   hammer, anvil, and }}{{c2::stirrup}}{{c1::)}}
--
-- One blank's entire answer was a single ")". Two others ended in a trailing
-- space, and blanks were jammed directly against each other. That is a botched
-- automated edit, not something authored by hand: an earlier script wrapped
-- "stapes" and "stirrup" in their own group and swept the surrounding prose
-- into c1 fragments. On screen it highlighted "malleus, incus, and" as the
-- answer while leaving "stapes" in plain text, and rendered a stray ")" as its
-- own blank.
--
-- A bank-wide scan for the same signature (punctuation-only answers, answers
-- with stray whitespace, blanks jammed together) found this card and no other.
-- Eight further hits were checked and dismissed as false alarms: their answers
-- are legitimate symbols such as lambda, epsilon and beta-minus, which contain
-- no ASCII letters or digits and so tripped an ASCII-centric test.
--
-- Rewritten so each bone is its own blank in one group, and the trailing
-- mention of "stapes" is blanked too, since leaving it visible would have
-- printed one of the answers. Verified before writing: groups contiguous from
-- 1, no malformed blanks, no jammed blanks, card wording unchanged.
-- ============================================================

UPDATE public.flashcards
SET cloze_text = 'The middle ear contains the three smallest bones in the body: the {{c1::malleus}}, {{c1::incus}}, and {{c1::stapes}} (sometimes called {{c1::hammer}}, {{c1::anvil}}, and {{c1::stirrup}}). They amplify the vibrations from the tympanic membrane and transmit them to the inner ear; the base of the {{c1::stapes}} rests on the {{c2::oval window}} of the cochlea.',
    cloze_count = 2
WHERE id = '88a45af1-92c4-4200-b7d7-30b91ebd9106';

-- This card drops from 3 groups to 2, so any progress recorded against the old
-- third blank now points at a blank that does not exist. Remove it first.
DELETE FROM public.flashcard_user_state
WHERE flashcard_id = '88a45af1-92c4-4200-b7d7-30b91ebd9106'
  AND cloze_index > 2;

-- Graded against corrupt text, so the history does not transfer. Reset to due
-- now as a review, not a new card, so it comes back today.
UPDATE public.flashcard_user_state
SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0
WHERE flashcard_id = '88a45af1-92c4-4200-b7d7-30b91ebd9106';

-- ── Verification ────────────────────────────────────────────────────────
-- Expect cloze_count = 2 and no jammed blanks anywhere in the bank.
SELECT cloze_count FROM public.flashcards WHERE id = '88a45af1-92c4-4200-b7d7-30b91ebd9106';
SELECT COUNT(*) AS jammed_blanks FROM public.flashcards WHERE cloze_text LIKE '%}}{{%';

-- Expect 0: no progress left pointing past this card's blanks.
SELECT COUNT(*) AS orphaned_here FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.flashcard_id = '88a45af1-92c4-4200-b7d7-30b91ebd9106'
  AND s.cloze_index > f.cloze_count;
