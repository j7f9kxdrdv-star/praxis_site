-- ============================================================
-- The parallel-frame queue, worked by hand
--
-- The structural detector flagged Mikko's Le Chatelier card DAYS before he hit
-- it. It sat in a queue of 78 that was never reviewed, because the rule runs at
-- roughly one third precision and I would not apply it blind.
--
-- Reading it properly, FRAME LENGTH PREDICTS PRECISION and I had missed that:
--
--   3-word frames   16 cards, about 85% real
--   2-word frames   34 cards, where nearly all the noise lives
--
-- These 9 are from the 3-word set, each read and confirmed. Two of that set were
-- rejected: the W = mg card, whose answer is pinned by the visible "9.8 m/s²"
-- rather than by the frame, and the NO2 enthalpy card, where seeing "+33.2 kJ"
-- and doubling it IS the lesson.
--
-- MOST ARE PAIRED, NOT FLATTENED. A card carrying two contrasts gets the
-- structures in one group and the properties in another, so each group still
-- tests a mapping:
--
--   asking group 1: "___ blastopore becomes the anus, ___ becomes the mouth"
--   asking group 2: "deuterostome blastopore becomes ___, protostome ___"
--
-- Merging all four into one blank would leave a sentence with nothing readable
-- in it, which is the over-merge that wrecked the Le Chatelier equilibrium card
-- earlier this week. No merged group here holds more than three spans.
-- ============================================================

BEGIN;

-- Separations and Purifications: spot and solvent front split, so the denominator names the numerator
--   now: The retention factor equals the distance traveled by the {{c1::spot}} divided by the distance traveled by the {{c1::solvent front}}; values fall betwe
UPDATE public.flashcards SET cloze_text = 'The retention factor equals the distance traveled by the {{c1::spot}} divided by the distance traveled by the {{c1::solvent front}}; values fall between {{c2::0 and 1}}.', cloze_count = 2 WHERE id = '00386356-7a41-46a8-9b4c-bd9ee863de59';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '00386356-7a41-46a8-9b4c-bd9ee863de59' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '00386356-7a41-46a8-9b4c-bd9ee863de59';

-- Brain, Behavior & Development: low/high split, and depression/anxiety split, in the same sentence
--   now: Imbalances of norepinephrine are linked to mood and {{c2::anxiety}} disorders: {{c1::low}} norepinephrine levels are associated with {{c2::depression}
UPDATE public.flashcards SET cloze_text = 'Imbalances of norepinephrine are linked to mood and {{c2::anxiety}} disorders: {{c1::low}} norepinephrine levels are associated with {{c2::depression}}, while {{c1::high}} levels are associated with {{c2::anxiety and mania}}.', cloze_count = 2 WHERE id = '03462709-b7db-421d-8f04-81a471de5690';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '03462709-b7db-421d-8f04-81a471de5690' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '03462709-b7db-421d-8f04-81a471de5690';

-- The Nervous System: acetylcholine visible while norepinephrine is asked for
--   now: Both sympathetic and parasympathetic {{c1::preganglionic}} neurons release {{c2::acetylcholine}}. Parasympathetic postganglionic neurons release {{c2:
UPDATE public.flashcards SET cloze_text = 'Both sympathetic and parasympathetic {{c1::preganglionic}} neurons release {{c2::acetylcholine}}. Parasympathetic postganglionic neurons release {{c2::acetylcholine}}, while most sympathetic postganglionic neurons release {{c2::norepinephrine}}.', cloze_count = 2 WHERE id = '21f0ddb4-5bf4-463b-83e4-8b2faf04e439';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '21f0ddb4-5bf4-463b-83e4-8b2faf04e439' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '21f0ddb4-5bf4-463b-83e4-8b2faf04e439';

-- Analyzing Organic Reactions: OH- and H3O+ split; each keeps its own conjugate label as the cue
--   now: {{c1::Amphoteric}} species act as either acid or base depending on environment; {{c2::water}} gives up H⁺ to become {{c3::OH⁻}} (conjugate base) or ac
UPDATE public.flashcards SET cloze_text = '{{c1::Amphoteric}} species act as either acid or base depending on environment; {{c2::water}} gives up H⁺ to become {{c3::OH⁻}} (conjugate base) or accepts H⁺ to become {{c3::H₃O⁺}} (conjugate acid).', cloze_count = 3 WHERE id = '329c1d59-b9ca-4981-bd42-643f2838ac7c';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '329c1d59-b9ca-4981-bd42-643f2838ac7c' AND cloze_index > 3;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '329c1d59-b9ca-4981-bd42-643f2838ac7c';

-- Analyzing Organic Reactions: the two pKa ranges define each other
--   now: Strong acids typically have {{c1::pKa < −2}} (they almost completely dissociate in water); weak organic acids typically have {{c1::pKa between −2 and 
UPDATE public.flashcards SET cloze_text = 'Strong acids typically have {{c1::pKa < −2}} (they almost completely dissociate in water); weak organic acids typically have {{c1::pKa between −2 and 20}}.', cloze_count = 1 WHERE id = '52ea443d-8daf-40bf-89e2-ea89abe377d7';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '52ea443d-8daf-40bf-89e2-ea89abe377d7' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '52ea443d-8daf-40bf-89e2-ea89abe377d7';

-- DNA and Biotechnology: with four bases, naming one pair names the other
--   now: In DNA, adenine always pairs with {{c1::thymine}}, and guanine always pairs with {{c1::cytosine}}.
UPDATE public.flashcards SET cloze_text = 'In DNA, adenine always pairs with {{c1::thymine}}, and guanine always pairs with {{c1::cytosine}}.', cloze_count = 1 WHERE id = '57dde7c3-3f09-4f5a-bdfa-4b356cb657af';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '57dde7c3-3f09-4f5a-bdfa-4b356cb657af' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '57dde7c3-3f09-4f5a-bdfa-4b356cb657af';

-- Brain, Behavior & Development: thalamus/hypothalamus split, and relay/regulator split
--   now: A useful contrast: the {{c1::thalamus}} acts as a sensory {{c2::relay}} (passing information from senses to cortex), while the {{c1::hypothalamus}} ac
UPDATE public.flashcards SET cloze_text = 'A useful contrast: the {{c1::thalamus}} acts as a sensory {{c2::relay}} (passing information from senses to cortex), while the {{c1::hypothalamus}} acts as a {{c2::regulator}} (maintaining homeostasis and driving behaviors). The two structures are anatomically adjacent but functionally distinct.', cloze_count = 2 WHERE id = '73daee9b-a682-4469-ad18-3ffb20a15e7d';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '73daee9b-a682-4469-ad18-3ffb20a15e7d' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '73daee9b-a682-4469-ad18-3ffb20a15e7d';

-- Embryonic Development & Gestation: deuterostome/protostome split, and anus/mouth split
--   now: In {{c1::deuterostomes}} like humans, the blastopore becomes the {{c2::anus}}. In {{c1::protostomes}}, the blastopore becomes the {{c2::mouth}}.
UPDATE public.flashcards SET cloze_text = 'In {{c1::deuterostomes}} like humans, the blastopore becomes the {{c2::anus}}. In {{c1::protostomes}}, the blastopore becomes the {{c2::mouth}}.', cloze_count = 2 WHERE id = '88c501a9-25d3-4d77-8611-0dbc59372a35';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '88c501a9-25d3-4d77-8611-0dbc59372a35' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '88c501a9-25d3-4d77-8611-0dbc59372a35';

-- Social Structure and Demographics: the two definitions are defined against each other
--   now: {{c1::Race}} is a social construct based on {{c2::inherited phenotypic characteristics}}; {{c1::ethnicity}} is a social construct based on {{c2::share
UPDATE public.flashcards SET cloze_text = '{{c1::Race}} is a social construct based on {{c2::inherited phenotypic characteristics}}; {{c1::ethnicity}} is a social construct based on {{c2::shared language, religion, culture, or national origin}}.', cloze_count = 2 WHERE id = '89cf6cf0-e47b-467c-b4b0-9d95d8103197';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '89cf6cf0-e47b-467c-b4b0-9d95d8103197' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '89cf6cf0-e47b-467c-b4b0-9d95d8103197';

COMMIT;

-- ── Verification ────────────────────────────────────────────────────────
-- Expect 0 for both, bank-wide.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;

SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
