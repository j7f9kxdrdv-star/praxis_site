-- ============================================================
-- Split contrasts: put both halves of a contrast in the same blank
--
-- A cloze card shows every group except the one being tested. When a card is
-- built on a two-way contrast and puts each half in its OWN group, asking for
-- one PRINTS the other, and the answer follows by elimination. Mikko hit this
-- again on the microtubule card: "the ___ end sits near the nucleus and the
-- POSITIVE end points toward the cell periphery."
--
-- Round two. The first pass fixed 27; these are the ones its vocabulary could
-- not see. Mikko hit "Relative configuration ... Absolute configuration" and
-- the pair list had no entry for relative/absolute. That list had also been
-- copy-pasted into three detector scripts, so learning a pair fixed only one of
-- them. It now lives in lib/contrast-vocab.mjs and every detector imports it.
--
-- 12 cards are repaired here by folding the two halves into one group, so
-- they blank together. Groups are then renumbered contiguously, because the
-- renderer matches the literal cN while the study page feeds a positional
-- index; those agree only while groups run 1..N with no gaps.
--
-- Each merge was verified before being written: groups contiguous from 1,
-- exactly one group fewer than before, and the card's words unchanged (only
-- the blanking moved).
--
-- PROGRESS ON THESE CARDS IS RESET, NOT DELETED: 47 rows across 3 account(s).
-- The schedule is discarded because the merged blank asks a harder question
-- than the one that was graded, but the card stays SEEN. Deleting the row
-- instead would make a card studied for weeks reappear as brand new and spend
-- the daily new-card budget.
-- 10 of those blanks were scheduled past the 2026-09-12 exam and would never
-- have come back in time. A leaking card could be answered without knowing it,
-- so its review history is not evidence of knowledge. These re-enter as new
-- cards and will come back within days, with the leak closed.
-- ============================================================

BEGIN;

-- Cell Division & Human Reproduction: two / four are members of one series
--   was: Meiosis takes a single diploid germ cell through one round of replication and {{c1::two}} rounds of division, yielding up to {{c2::four}} genetically unique {{c
--   now: Meiosis takes a single diploid germ cell through one round of replication and {{c1::two}} rounds of division, yielding up to {{c1::four}} genetically unique {{c
UPDATE public.flashcards SET cloze_text = 'Meiosis takes a single diploid germ cell through one round of replication and {{c1::two}} rounds of division, yielding up to {{c1::four}} genetically unique {{c2::haploid (n = 23)}} gametes.', cloze_count = 2 WHERE id = '03a38f3a-9a5e-42cd-b8f4-e98e3b653a54';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '03a38f3a-9a5e-42cd-b8f4-e98e3b653a54' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '03a38f3a-9a5e-42cd-b8f4-e98e3b653a54';

-- Nonenzymatic Protein Function and Protein Analysis: un- negation of "gated"
--   was: The three main classes of ion channels are {{c1::ungated}} (always open), {{c2::voltage-gated}} (open in response to membrane potential), and {{c3::ligand-gated
--   now: The three main classes of ion channels are {{c1::ungated}} (always open), {{c1::voltage-gated}} (open in response to membrane potential), and {{c2::ligand-gated
UPDATE public.flashcards SET cloze_text = 'The three main classes of ion channels are {{c1::ungated}} (always open), {{c1::voltage-gated}} (open in response to membrane potential), and {{c2::ligand-gated}} (open in response to a chemical messenger).', cloze_count = 2 WHERE id = '086d891f-7ff7-43d3-a335-28e4fd26b228';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '086d891f-7ff7-43d3-a335-28e4fd26b228' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '086d891f-7ff7-43d3-a335-28e4fd26b228';

-- The Respiratory System: in- negation of "voluntary"
--   was: Breathing runs by default under {{c1::autonomic (involuntary)}} control from the medullary respiratory center, but cortical areas grant {{c2::voluntary (somatic
--   now: Breathing runs by default under {{c1::autonomic (involuntary)}} control from the medullary respiratory center, but cortical areas grant {{c1::voluntary (somatic
UPDATE public.flashcards SET cloze_text = 'Breathing runs by default under {{c1::autonomic (involuntary)}} control from the medullary respiratory center, but cortical areas grant {{c1::voluntary (somatic)}} override (letting you hold your breath or speak) until rising CO₂ forces the {{c1::autonomic (involuntary)}} system to seize control again.', cloze_count = 1 WHERE id = '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '3a90b10c-e4e0-4f0c-8f36-a0d0009cac17';

-- Alcohols: primary / secondary are members of one series
--   was: {{c1::Jones oxidation}} (CrO₃ in dilute H₂SO₄ + acetone) oxidizes {{c2::primary alcohols → carboxylic acids}} and {{c3::secondary alcohols → ketones}}.
--   now: {{c1::Jones oxidation}} (CrO₃ in dilute H₂SO₄ + acetone) oxidizes {{c2::primary alcohols → carboxylic acids}} and {{c2::secondary alcohols → ketones}}.
UPDATE public.flashcards SET cloze_text = '{{c1::Jones oxidation}} (CrO₃ in dilute H₂SO₄ + acetone) oxidizes {{c2::primary alcohols → carboxylic acids}} and {{c2::secondary alcohols → ketones}}.', cloze_count = 2 WHERE id = '844c3aff-85e8-477f-affc-a5b6b1ac15cb';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '844c3aff-85e8-477f-affc-a5b6b1ac15cb' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '844c3aff-85e8-477f-affc-a5b6b1ac15cb';

-- Isomerism & Stereochemistry: double / single are members of one series
--   was: Under CIP priority rules, a {{c1::double bond}} to atom X is treated as {{c2::two single bonds}} to X. For example, a carbon double-bonded to oxygen counts as t
--   now: Under CIP priority rules, a {{c1::double bond}} to atom X is treated as {{c1::two single bonds}} to X. For example, a carbon double-bonded to oxygen counts as t
UPDATE public.flashcards SET cloze_text = 'Under CIP priority rules, a {{c1::double bond}} to atom X is treated as {{c1::two single bonds}} to X. For example, a carbon double-bonded to oxygen counts as two C-O bonds when assigning priority.', cloze_count = 1 WHERE id = '883d2267-b5ba-4ae5-a5a6-87ac7ce7eff3';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '883d2267-b5ba-4ae5-a5a6-87ac7ce7eff3' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '883d2267-b5ba-4ae5-a5a6-87ac7ce7eff3';

-- Carboxylic Acid Derivatives: primary / secondary / tertiary are members of one series
--   was: Amide H-bonding depends on N-H availability: {{c1::primary and secondary amides}} can H-bond (N-H donors), while {{c2::tertiary amides}} cannot, which affects w
--   now: Amide H-bonding depends on N-H availability: {{c1::primary and secondary amides}} can H-bond (N-H donors), while {{c1::tertiary amides}} cannot, which affects w
UPDATE public.flashcards SET cloze_text = 'Amide H-bonding depends on N-H availability: {{c1::primary and secondary amides}} can H-bond (N-H donors), while {{c1::tertiary amides}} cannot, which affects whether their boiling points approach the parent carboxylic acid.', cloze_count = 1 WHERE id = '8e412754-4b1f-402a-8581-862ed583dbd8';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '8e412754-4b1f-402a-8581-862ed583dbd8' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '8e412754-4b1f-402a-8581-862ed583dbd8';

-- Embryonic Development & Gestation: di- / mono- on "chorionic"
--   was: Whether monozygotic twins share a placenta depends on WHEN the zygote splits. An early split produces {{c1::dichorionic, diamniotic}} twins (two placentas, two 
--   now: Whether monozygotic twins share a placenta depends on WHEN the zygote splits. An early split produces {{c1::dichorionic, diamniotic}} twins (two placentas, two 
UPDATE public.flashcards SET cloze_text = 'Whether monozygotic twins share a placenta depends on WHEN the zygote splits. An early split produces {{c1::dichorionic, diamniotic}} twins (two placentas, two sacs); a later split produces {{c1::monochorionic}} twins that share one placenta.', cloze_count = 1 WHERE id = '9db8a6e3-2c03-4ad8-90af-6fe0a3683a47';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '9db8a6e3-2c03-4ad8-90af-6fe0a3683a47' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '9db8a6e3-2c03-4ad8-90af-6fe0a3683a47';

-- Embryonic Development & Gestation: two / one are members of one series
--   was: The umbilical cord contains {{c1::two}} arteries carrying deoxygenated blood from the fetus to the placenta, and {{c2::one}} vein returning oxygenated blood fro
--   now: The umbilical cord contains {{c1::two}} arteries carrying deoxygenated blood from the fetus to the placenta, and {{c1::one}} vein returning oxygenated blood fro
UPDATE public.flashcards SET cloze_text = 'The umbilical cord contains {{c1::two}} arteries carrying deoxygenated blood from the fetus to the placenta, and {{c1::one}} vein returning oxygenated blood from the placenta to the fetus.', cloze_count = 1 WHERE id = '9ffc1170-c701-42d6-b558-b07f9d4e3bc0';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = '9ffc1170-c701-42d6-b558-b07f9d4e3bc0' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = '9ffc1170-c701-42d6-b558-b07f9d4e3bc0';

-- The Endocrine System: three / four are members of one series
--   was: To build thyroid hormone, follicular cells stud residues of the amino acid {{c1::tyrosine}} (held on thyroglobulin) with iodine: linking {{c2::three}} iodines y
--   now: To build thyroid hormone, follicular cells stud residues of the amino acid {{c1::tyrosine}} (held on thyroglobulin) with iodine: linking {{c2::three}} iodines y
UPDATE public.flashcards SET cloze_text = 'To build thyroid hormone, follicular cells stud residues of the amino acid {{c1::tyrosine}} (held on thyroglobulin) with iodine: linking {{c2::three}} iodines yields T3, while {{c2::four}} iodines yields T4 (thyroxine).', cloze_count = 2 WHERE id = 'df28c2f4-36d0-4fa1-8d8d-abc12a30d50a';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'df28c2f4-36d0-4fa1-8d8d-abc12a30d50a' AND cloze_index > 2;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'df28c2f4-36d0-4fa1-8d8d-abc12a30d50a';

-- The Endocrine System: absorption / excretion are members of one series
--   was: When blood calcium climbs, the thyroid's {{c1::C (parafollicular) cells}} release calcitonin, which {{c2::lowers}} serum Ca²⁺ by {{c3::depositing it into bone}}
--   now: When blood calcium climbs, the thyroid's {{c1::C (parafollicular) cells}} release calcitonin, which {{c2::lowers}} serum Ca²⁺ by {{c3::depositing it into bone}}
UPDATE public.flashcards SET cloze_text = 'When blood calcium climbs, the thyroid''s {{c1::C (parafollicular) cells}} release calcitonin, which {{c2::lowers}} serum Ca²⁺ by {{c3::depositing it into bone}}, {{c4::reducing intestinal absorption}}, and {{c4::increasing urinary excretion}}.', cloze_count = 4 WHERE id = 'e84f7d06-6de8-4c7a-be06-250b8070da58';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'e84f7d06-6de8-4c7a-be06-250b8070da58' AND cloze_index > 4;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'e84f7d06-6de8-4c7a-be06-250b8070da58';

-- Bonding: single / double / triple are members of one series
--   was: Bond composition: a {{c1::single}} bond is 1 sigma; a {{c2::double}} bond is 1 sigma + 1 pi; a {{c3::triple}} bond is 1 sigma + 2 pi.
--   now: Bond composition: a {{c1::single}} bond is 1 sigma; a {{c1::double}} bond is 1 sigma + 1 pi; a {{c1::triple}} bond is 1 sigma + 2 pi.
UPDATE public.flashcards SET cloze_text = 'Bond composition: a {{c1::single}} bond is 1 sigma; a {{c1::double}} bond is 1 sigma + 1 pi; a {{c1::triple}} bond is 1 sigma + 2 pi.', cloze_count = 1 WHERE id = 'f2e8db61-60dc-485c-a1c4-e01bed785df9';
DELETE FROM public.flashcard_user_state WHERE flashcard_id = 'f2e8db61-60dc-485c-a1c4-e01bed785df9' AND cloze_index > 1;
UPDATE public.flashcard_user_state SET stability = 2.0, interval_days = 0, scheduled_days = 0,
    next_review_at = now(), fsrs_state = 2, learning_steps = 0 WHERE flashcard_id = 'f2e8db61-60dc-485c-a1c4-e01bed785df9';

COMMIT;

-- Expect 0: every card's group count matches cloze_count, bank-wide. Checked
-- across the whole bank rather than just these ids, which is how the earlier
-- orphan problem surfaced.
SELECT COUNT(*) AS count_mismatches FROM (
  SELECT id, cloze_count,
    (SELECT COUNT(DISTINCT mm[1]) FROM regexp_matches(cloze_text, '\{\{c(\d+)::', 'g') AS mm) AS n
  FROM public.flashcards WHERE cloze_text LIKE '%{{c%'
) t WHERE n <> cloze_count;

-- Expect 0: no leftover progress pointing at a blank that no longer exists.
SELECT COUNT(*) AS orphaned_progress FROM public.flashcard_user_state s
JOIN public.flashcards f ON f.id = s.flashcard_id
WHERE s.cloze_index > f.cloze_count;
