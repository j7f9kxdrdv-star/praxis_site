-- ============================================================
-- Stem leaks: the giveaway was never in a blank
--
-- A split contrast hides one half of a pair in a sibling BLANK. These are the
-- other shape: the half that gives the answer away sits in ordinary visible
-- prose, so the sibling-group detector was structurally unable to see it.
--
--   "a patient running hot rather than cold points toward [____]
--    INSTEAD OF HYPOTHYROIDISM"
--
-- 9 cards. Each repair pulls the giving-away words into the SAME group as the
-- answer so the two hide together. The carrier-protein card is the exception:
-- there both halves were already blanked in different groups, so they are
-- merged instead.
--
-- WRITTEN OUT ONE CARD AT A TIME ON PURPOSE. The stem-leak detector flags 51
-- cards bank-wide and only about a third are real: it cannot tell a contrast
-- from a premise, so it reads "As n INCREASES, the spacing DECREASES" as a
-- leak when the first clause is the setup rather than a giveaway. Applying its
-- output wholesale would damage two cards for every one it fixed. These nine
-- were read and confirmed by hand.
--
-- Each edit is verified before writing: the anchor text must appear exactly
-- once, the card's wording must be unchanged, groups must run contiguously
-- from 1, and no blank may be malformed or jammed against another.
-- ============================================================

BEGIN;

-- The Endocrine System: "instead of hypothyroidism" states the answer's opposite outright
--   now: Because thyroid hormone sets basal metabolic rate, a patient running hot rather than cold points toward {{c1::hyperthyroidism}} instead of {{c1::hypothyroi
UPDATE public.flashcards SET cloze_text = 'Because thyroid hormone sets basal metabolic rate, a patient running hot rather than cold points toward {{c1::hyperthyroidism}} instead of {{c1::hypothyroidism}}.', cloze_count = 1 WHERE id = '100988c9-a75d-4329-84f4-20b778bea707';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '100988c9-a75d-4329-84f4-20b778bea707';

-- The Endocrine System: "governed by negative feedback" leaves only one thing the exception can be
--   now: Most endocrine axes are governed by {{c1::negative}} feedback, making {{c1::positive}} feedback the rare exception among hormonal control loops.
UPDATE public.flashcards SET cloze_text = 'Most endocrine axes are governed by {{c1::negative}} feedback, making {{c1::positive}} feedback the rare exception among hormonal control loops.', cloze_count = 1 WHERE id = 'ac752184-e080-4699-b37d-84062d42fc0a';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'ac752184-e080-4699-b37d-84062d42fc0a';

-- Cell Division & Human Reproduction: "from negative to ___" is a fixed idiom with one completion
--   now: Late in the follicular phase, estrogen rises to a threshold that flips the hypothalamic feedback from {{c1::negative}} to {{c1::positive}}, producing a sha
UPDATE public.flashcards SET cloze_text = 'Late in the follicular phase, estrogen rises to a threshold that flips the hypothalamic feedback from {{c1::negative}} to {{c1::positive}}, producing a sharp surge in {{c2::LH}} (and a smaller spike in FSH) that triggers {{c3::ovulation}}, releasing the ovum from the dominant follicle into the peritoneal cavity.', cloze_count = 3 WHERE id = '54902c83-9d0a-4488-9108-02c40d4e993d';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '54902c83-9d0a-4488-9108-02c40d4e993d';

-- Periodic Trends & Chemical Families: "essentially the opposite of metals" defines the answer in the stem
--   now: {{c1::Nonmetals}} sit in the upper right of the periodic table and are essentially the opposite of {{c1::metals}}: {{c2::brittle}} as solids with no metall
UPDATE public.flashcards SET cloze_text = '{{c1::Nonmetals}} sit in the upper right of the periodic table and are essentially the opposite of {{c1::metals}}: {{c2::brittle}} as solids with no metallic luster, with {{c3::high}} electronegativity, ionization energy, and electron affinity, and a {{c4::small}} atomic radius but a {{c4::large}} ionic radius.', cloze_count = 4 WHERE id = 'd1345b3a-df4b-41c1-9c67-46a3b82a39ab';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'd1345b3a-df4b-41c1-9c67-46a3b82a39ab';

-- Social Stratification: "than those with higher SES" supplies the contrast the blank asks for
--   now: The {{c1::socioeconomic gradient in health}}: individuals with {{c2::lower SES}} systematically experience worse health outcomes and shorter lifespans than
UPDATE public.flashcards SET cloze_text = 'The {{c1::socioeconomic gradient in health}}: individuals with {{c2::lower SES}} systematically experience worse health outcomes and shorter lifespans than those with {{c2::higher}} SES.', cloze_count = 2 WHERE id = '6a4cf538-947d-457d-9b2e-ed8495e0cc8d';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '6a4cf538-947d-457d-9b2e-ed8495e0cc8d';

-- Electrochemistry: the cathode's sign was printed, so the anode's follows by elimination
--   now: In a {{c1::galvanic}} cell, the {{c2::anode}} carries the {{c3::negative (−)}} sign and the {{c2::cathode}} carries the {{c3::positive (+)}} sign. Electron
UPDATE public.flashcards SET cloze_text = 'In a {{c1::galvanic}} cell, the {{c2::anode}} carries the {{c3::negative (−)}} sign and the {{c2::cathode}} carries the {{c3::positive (+)}} sign. Electrons leave the {{c2::anode}} and flow to the {{c2::cathode}}.', cloze_count = 3 WHERE id = 'e9ce851d-d1d7-481c-882c-467a112cf17a';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'e9ce851d-d1d7-481c-882c-467a112cf17a';

-- The Endocrine System: "free (unbound)" in a sibling blank negates the answer "bound"
--   now: Carrier proteins keep a lipid-soluble hormone {{c1::bound}} and biologically {{c1::inactive}}; only the {{c1::free (unbound)}} fraction can enter target ce
UPDATE public.flashcards SET cloze_text = 'Carrier proteins keep a lipid-soluble hormone {{c1::bound}} and biologically {{c1::inactive}}; only the {{c1::free (unbound)}} fraction can enter target cells and act.', cloze_count = 1 WHERE id = 'd16f8f11-b75b-476b-88cb-cb07e61d9884';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'd16f8f11-b75b-476b-88cb-cb07e61d9884' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'd16f8f11-b75b-476b-88cb-cb07e61d9884';

-- The Cell: the "(-strand)" annotation sits directly beside the blank it explains
--   now: A {{c1::negative-sense}} ({{c1::−-strand}}) RNA genome cannot be translated directly; the virion must carry its own {{c2::RNA-dependent RNA polymerase}} to
UPDATE public.flashcards SET cloze_text = 'A {{c1::negative-sense}} ({{c1::−-strand}}) RNA genome cannot be translated directly; the virion must carry its own {{c2::RNA-dependent RNA polymerase}} to first transcribe a complementary positive-sense strand that ribosomes can read.', cloze_count = 2 WHERE id = 'bdbb7706-d165-4cd4-bb9c-3f0fe128cdd7';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'bdbb7706-d165-4cd4-bb9c-3f0fe128cdd7';

-- Social Thinking: "an overall positive impression" already contains the answer word
--   now: The {{c1::halo effect}} is a cognitive bias in which an overall {{c2::positive}} impression of someone makes specific traits also {{c2::seem positive}} (an
UPDATE public.flashcards SET cloze_text = 'The {{c1::halo effect}} is a cognitive bias in which an overall {{c2::positive}} impression of someone makes specific traits also {{c2::seem positive}} (and vice versa for an overall negative impression).', cloze_count = 2 WHERE id = '02c55685-5c97-4e53-b4c4-b1bd23506837';
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '02c55685-5c97-4e53-b4c4-b1bd23506837';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0 for both.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE id IN ('100988c9-a75d-4329-84f4-20b778bea707','ac752184-e080-4699-b37d-84062d42fc0a','54902c83-9d0a-4488-9108-02c40d4e993d','d1345b3a-df4b-41c1-9c67-46a3b82a39ab','6a4cf538-947d-457d-9b2e-ed8495e0cc8d','e9ce851d-d1d7-481c-882c-467a112cf17a','d16f8f11-b75b-476b-88cb-cb07e61d9884','bdbb7706-d165-4cd4-bb9c-3f0fe128cdd7','02c55685-5c97-4e53-b4c4-b1bd23506837')
) t WHERE n <> cloze_count;

SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
