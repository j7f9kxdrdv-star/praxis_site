-- ============================================================
-- V3 PR5 part B.2 — cards that showed the student their own answer
--
-- A cloze card reveals every group EXCEPT the one being tested. So the answer
-- to group N leaks whenever its text also appears in the visible stem or in a
-- sibling blank that is revealed. The student reads the answer off the card,
-- rates it Easy, and the scheduler records a successful retrieval that never
-- happened. Under V3 that is worse than a cosmetic bug: FSRS treats every
-- rating as evidence, so a leaking card teaches the scheduler a lie and then
-- stops showing the material.
--
-- 36 cards, hand-checked one at a time. Two more were flagged by the detector
-- and deliberately left alone:
--   . 8293ecb6  "first" — the stem's "you must first replace any intermediate"
--     is ordinary English, not the answer.
--   . 2b30bede  "[A] vs t" — visible siblings are "ln[A] vs t" and "1/[A] vs t".
--     Working the zero-order plot out by elimination is the skill being tested.
--
-- THE HARD CONSTRAINT ON EVERY REWRITE BELOW. renderClozeSegments matches the
-- literal cN number (m.groupIndex === activeGroup), while the study page feeds
-- it a POSITIONAL index, 1..cloze_count. The two agree only while groups are
-- contiguous 1..N. So merging or renumbering a group would silently re-point
-- every student's existing flashcard_user_state row at different material.
-- Every rewrite here therefore keeps the group numbers and the group count
-- exactly as they were; only prose moves. Verified mechanically before this
-- file was written: 36/36 unchanged group sets, no residual whole-word leak.
--
-- Ten fixes trade a small piece of content to close the leak. Each is marked
-- [TRIM] with what it drops, so you can veto any one of them.
--
-- ONE DOCUMENTED EXCEPTION. 4bda0236 (acid-base extraction) still trips the
-- detector on "acid" and "base" appearing in its own stem. That is structural:
-- a card about extracting an organic acid cannot avoid the word. It is not a
-- readback — both reagent words are in the SAME cloze group, so each visible
-- word points at the other blank, and the student still has to know which
-- reagent pairs with which substrate. The real leak on that card (the sibling
-- blank literally ended in "conjugate base" / "conjugate acid") is fixed.
--
-- UPDATE by id, per the live-deck rule: card ids stay stable, scheduling rows
-- stay attached, and no review history moves.
-- ============================================================

-- stem named the answer ("β-oxidation")
UPDATE public.flashcards SET cloze_text = 'Each cycle that shortens a fatty acyl-CoA by two carbons has four steps: {{c1::oxidation}} (creating a double bond), {{c1::hydration}} (adding water across it), a second {{c1::oxidation}} (forming a β-keto group), and {{c1::cleavage}} (releasing acetyl-CoA).' WHERE id = '04ec9f3d-87f9-4f65-aea0-4e8c905d5ef9';

-- c4 "non-representative elements" gave away c2 [TRIM: drops the non-representative label]
UPDATE public.flashcards SET cloze_text = 'The {{c1::A elements}} (groups 1A to 8A) are called {{c2::representative elements}}; the {{c3::B elements}} include the transition metals plus the {{c4::lanthanide and actinide series}}.' WHERE id = '07eadafd-f15e-4880-b269-d7a155ceb2c7';

-- c2 spelled out carnitine [TRIM: drops the acronym expansion]
UPDATE public.flashcards SET cloze_text = 'Long-chain fatty acyl-CoA cannot cross the inner mitochondrial membrane; it is transferred to {{c1::carnitine}} by the rate-limiting enzyme {{c2::CPT I}} for transport into the matrix.' WHERE id = '0b5fb450-0aca-4899-a7a5-fcb2796adc7e';

-- c2 formula began with the word Efficiency
UPDATE public.flashcards SET cloze_text = 'The {{c1::efficiency}} of a real machine is the ratio of its useful work output to the work input, usually expressed as a percentage: {{c2::(Wout / Win) × 100%}}. For an ideal frictionless machine this equals 100%; real machines are always less.' WHERE id = '0d9846de-b7f2-4020-9825-f839f31b582b';

-- c3 "anterior pituitary" gave away c1
UPDATE public.flashcards SET cloze_text = 'The {{c1::pituitary gland}} is sometimes called the {{c2::master gland}} because it secretes hormones that regulate other endocrine glands throughout the body. Its {{c3::anterior lobe}} actually performs this regulatory role; the posterior lobe instead stores and releases hormones made in the hypothalamus.' WHERE id = '16c551d9-9fa6-4fbd-9965-28101bfdf9e3';

-- stem listed "mechanical + thermal + chemical"
UPDATE public.flashcards SET cloze_text = 'Conservation of {{c1::mechanical}} energy requires no non-conservative forces. The broader {{c2::first law of thermodynamics}} states that {{c3::total energy}} (kinetic + potential + thermal + chemical + …) of an isolated system is always conserved, even when {{c1::mechanical}} energy alone is not.' WHERE id = '18d7c47c-f201-4574-8211-ca66b7da2b60';

-- c1 and c2 gave each other away
UPDATE public.flashcards SET cloze_text = '{{c1::Allosteric enzymes}} have at least one regulatory site {{c2::distinct from the active site}}; ligand binding there shifts the enzyme between active and inactive conformations.' WHERE id = '1fb846ff-521b-4247-ad51-8ac00e54ff7c';

-- c1 "cross product (vector product)" gave away c2
UPDATE public.flashcards SET cloze_text = 'The {{c1::cross product}} of two vectors yields a new {{c2::vector}} whose magnitude is |A||B|sin θ. The resulting {{c2::vector}} is always {{c3::perpendicular to the plane}} containing the two input vectors. Torque, the {{c1::cross product}} of position and force, is the classic example.' WHERE id = '27461a49-8ea5-440a-b4c7-9f0ca6ab19cb';

-- stem repeated "the weak acid's"
UPDATE public.flashcards SET cloze_text = 'A salt of a {{c1::weak acid}} and a {{c1::strong base}} dissolves to give a {{c2::basic}} solution; the anion hydrolyzes water to release OH⁻.' WHERE id = '3782072d-0d7d-4d73-bc99-a1ba3d351bdc';

-- stem repeated "the weak base's"
UPDATE public.flashcards SET cloze_text = 'A salt of a {{c1::strong acid}} and a {{c1::weak base}} dissolves to give an {{c2::acidic}} solution; the cation hydrolyzes water to release H⁺.' WHERE id = '43457e40-b3f5-4c1b-904b-15a81c710e1d';

-- c3 "(high-intensity)" gave away c2
UPDATE public.flashcards SET cloze_text = 'Whether emission happens depends on photon {{c1::frequency}}, not on {{c2::intensity}}. Below the threshold {{c1::frequency}}, even a {{c3::very bright}} beam ejects nothing.' WHERE id = '43de4f2a-714d-4d72-8ad5-6498adf28c25';

-- stem opened with "Cis-trans isomerism"
UPDATE public.flashcards SET cloze_text = 'Geometric isomerism around a carbon-carbon double bond is a specific subset of {{c1::diastereomerism}}: the two substituents on each side of the C=C bond cannot interconvert by rotation (the π-bond is rigid), so {{c2::cis}} and {{c2::trans}} forms are non-mirror-image stereoisomers.' WHERE id = '4619304e-28e7-4cba-a371-f64ca9e25a66';

-- c2 ended in "conjugate base" / "conjugate acid", the c1 answers
UPDATE public.flashcards SET cloze_text = 'Acid-base extraction trick: add aqueous {{c1::base}} to deprotonate an organic acid into its {{c2::water-soluble conjugate}}, or add aqueous {{c1::acid}} to protonate an organic base into its {{c2::water-soluble conjugate}}.' WHERE id = '4bda0236-75fe-4fb9-aaf9-d883248446fa';

-- c2 was the word "anhydride" itself [TRIM: drops the acetic anhydride example]
UPDATE public.flashcards SET cloze_text = 'An {{c1::anhydride}} forms when two carboxylic acid molecules condense and a water molecule is removed; if both acids are the same, it is named by {{c2::replacing "acid" in the parent name with the family name}}.' WHERE id = '4c469b8b-783b-48ae-8f82-e0f0721c283d';

-- stem said "motion-sensitive"
UPDATE public.flashcards SET cloze_text = '{{c1::Magnocellular}} cells in the LGN handle {{c2::motion}}. They have {{c3::high temporal resolution}} (excellent at tracking rapid change) but {{c4::low spatial resolution}}, so they produce a blurry picture that still registers movement well. This is particularly important for detecting objects approaching from the periphery.' WHERE id = '4d6d5be9-d7cb-421d-b05d-6dd32af5383b';

-- stem listed "calcium-binding proteins, and DNA-binding proteins"
UPDATE public.flashcards SET cloze_text = '{{c1::Binding proteins}} sequester, transport, or stabilize other molecules; classic examples are {{c2::hemoglobin}}, calmodulin, and transcription factors.' WHERE id = '4fc6db16-1d4a-439a-8194-12962ebbfec8';

-- stem repeated "liver glycogen"
UPDATE public.flashcards SET cloze_text = 'Glycogen is stored primarily in the {{c1::liver}} and {{c1::skeletal muscle}}; the first store buffers blood glucose, while the second fuels local contraction.' WHERE id = '53d6a717-8cef-4aa5-8477-7dfcc4598c54';

-- c2 and c3 both contained "glycogen"
UPDATE public.flashcards SET cloze_text = 'In the liver and muscle, insulin activates {{c1::glucokinase}} and glycogen {{c2::synthase}} while inactivating glycogen {{c3::phosphorylase}}. Net effect: glucose is stored as glycogen.' WHERE id = '55cfe696-6b8c-4451-94a8-d9291093dbd9';

-- stem said "The chair is by far the most stable"
UPDATE public.flashcards SET cloze_text = 'Cyclohexane primarily adopts three interconverting conformations: {{c1::chair}}, {{c1::boat}}, and {{c1::twist-boat (skew-boat)}}. The first of these is by far the most stable because it simultaneously minimizes all three forms of strain.' WHERE id = '63385a49-8ba1-43b6-ba15-4b7b4d9b2597';

-- stem said "the surroundings do positive work"
UPDATE public.flashcards SET cloze_text = 'Sign convention for P-V work: when a gas {{c1::expands}} (ΔV > 0), it does {{c2::positive}} work on the surroundings. When a gas is {{c1::compressed}} (ΔV < 0), the surroundings do work on it instead, and we say the work done by the gas is {{c2::negative}}.' WHERE id = '6fa95cc4-b3b7-4071-a9b5-ad1d87bfe5a5';

-- c3 "-amide" gave away c1 [TRIM: drops the -amide suffix]
UPDATE public.flashcards SET cloze_text = 'In an {{c1::amide}}, the hydroxyl (-OH) of a carboxylic acid is replaced by an {{c2::amino group}} (-NH₂, -NHR, or -NR₂). They are named by replacing the parent acid''s {{c3::-oic acid}} suffix with the family suffix.' WHERE id = '78bfe7f4-a88e-4562-8e3d-f286e285a178';

-- c3 "non-conservative" gave away c2
UPDATE public.flashcards SET cloze_text = 'To test whether a force is {{c2::conservative}}: have the object traverse a {{c1::closed loop}} back to its starting position. If the system returns with the same mechanical energy it started with, the force passes the test; if it has lost energy, the culprit is a {{c3::dissipative force such as friction}}.' WHERE id = '7dfb8484-5df0-440b-8716-d1407348f4d1';

-- c2 "carbonyl carbon" gave away c1
UPDATE public.flashcards SET cloze_text = 'The {{c1::α-carbon}} is the {{c1::carbon}} directly {{c2::adjacent to the carbonyl group}}, and any {{c3::hydrogens}} attached to it are called {{c3::α-hydrogens}}.' WHERE id = '8ed3ee2d-dbe7-449b-a7e8-3dfaedf8cefe';

-- c2 "metaphase plate" gave away c1 [uses the synonym equatorial plate]
UPDATE public.flashcards SET cloze_text = 'In {{c1::metaphase}}, condensed chromosomes align along the {{c2::equatorial plate}}, equidistant from the two poles, with spindle microtubules attached to each {{c3::kinetochore}} on the sister-chromatid centromeres.' WHERE id = '94e39e7c-12e0-441b-bd38-d467d2f6a765';

-- c1 "dot product (scalar product)" gave away c2
UPDATE public.flashcards SET cloze_text = 'The {{c1::dot product}} of two vectors yields a {{c2::scalar}}: A·B = |A||B|cos θ, where θ is the angle between them. Work, the {{c1::dot product}} of force and displacement, is the classic physics example.' WHERE id = '95109394-fba6-46f2-93ba-03d4b7826c74';

-- c1 "citrate synthase" gave away c3; c3 now tests the carbon count
UPDATE public.flashcards SET cloze_text = 'Citric acid cycle, Step 1: {{c1::citrate synthase}} joins acetyl-CoA and {{c2::oxaloacetate}} in a condensation reaction, producing the {{c3::6-carbon}} molecule citrate.' WHERE id = '9c66d252-6fa1-4550-949b-92f513324490';

-- c2 "urea cycle" gave away c1; "cycle" is now visible prose
UPDATE public.flashcards SET cloze_text = 'Deamination releases toxic {{c2::ammonia}}, which the {{c1::urea}} cycle converts into a safely excretable product in the {{c3::liver}}.' WHERE id = '9d4774e6-285f-4a25-a2f5-5e920c9b82e1';

-- c3 restated "the stationary phase"
UPDATE public.flashcards SET cloze_text = 'Every form of chromatography moves a sample dissolved in a {{c1::mobile phase}} past a {{c2::stationary phase}}, separating compounds by {{c3::how strongly each one is retained}}.' WHERE id = '9fe3ee39-b5ed-46e8-bb5d-1cfdd0257bac';

-- stem said "cross to the opposite side"
UPDATE public.flashcards SET cloze_text = 'At the {{c1::optic chiasm}}, only the {{c2::nasal}} retinal fibers cross to the other side; temporal fibers stay ipsilateral. Result: each hemisphere processes the {{c3::opposite}} visual field.' WHERE id = 'a327dc2d-3276-4f94-ab02-2f3b4c48ccc5';

-- c1 held the full ranking, which contained both c2 and c3
UPDATE public.flashcards SET cloze_text = 'Energy ranking of butane''s Newman conformations from highest to lowest: {{c1::totally eclipsed > eclipsed > gauche > anti}}. The lowest-energy one is most stable because {{c2::the two methyl groups are maximally separated}}; the highest-energy one is least stable because {{c3::the methyls directly overlap}}.' WHERE id = 'ada6ff9d-3730-43ea-b711-f99f6a759601';

-- stem ended "moving toward core status"
UPDATE public.flashcards SET cloze_text = '{{c1::World-Systems Theory (Wallerstein)}} divides the world into {{c2::core}} nations (economically dominant), {{c2::peripheral}} nations (exploited for cheap resources and labor), and {{c2::semi-peripheral}} nations (intermediate, often moving toward dominance).' WHERE id = 'b60e8a8f-c2c5-426c-810d-e89d6ad46d63';

-- c2 "empathy-altruism hypothesis" gave away c1 [TRIM: drops the formal hypothesis name]
UPDATE public.flashcards SET cloze_text = '{{c1::Altruism}} is helping behavior that benefits another at a cost to the self; one leading account proposes that we help specifically when we feel {{c2::empathy}} for the other person, {{c3::regardless of the cost to ourselves}}.' WHERE id = 'cf094abf-b728-4e7b-8307-075bf20689cc';

-- stem said "(silica or paper)"
UPDATE public.flashcards SET cloze_text = '{{c1::Thin-layer (TLC)}} and {{c1::paper}} chromatography identify {{c2::small, non-volatile compounds}}; both use a {{c3::polar}} stationary phase (silica gel or cellulose) with a {{c4::nonpolar}} mobile phase.' WHERE id = 'd61643e9-9c14-49a9-b677-52c9f6aa0f96';

-- c1 alias "palmitate synthase" gave away c3 [TRIM: drops the alias]
UPDATE public.flashcards SET cloze_text = 'Fatty acid {{c1::synthase}} cycles eight times, using {{c2::8 acetyl-CoA}} units to produce the 16-carbon saturated fatty acid {{c3::palmitate}}. It is the only fatty acid humans can synthesize de novo.' WHERE id = 'd71fd653-8e10-4c73-b5b6-65e208bbadc2';

-- stem repeated "a nearby N, O, or F"
UPDATE public.flashcards SET cloze_text = 'A {{c1::hydrogen bond}} is an unusually strong dipole-dipole interaction between an H atom covalently bonded to {{c2::N, O, or F}} and a lone pair on another such atom.' WHERE id = 'db480062-17c8-4974-af03-c0fbbc6753a9';

-- stem said "a cult is a sect that"
UPDATE public.flashcards SET cloze_text = 'Three religious subdivisions: a {{c1::denomination}} is a recognized branch of a religion, a {{c1::sect}} is a group that has {{c2::broken off from a parent religion}}, and a {{c1::cult}} is a smaller, more isolated group with {{c3::extreme or unconventional beliefs}}.' WHERE id = 'dc5b709d-dae6-41db-8562-3a9ff6c80cf4';

-- ── Verification ────────────────────────────────────────────────────────
-- Every card above must still report the group count it had before. If any row
-- comes back with a mismatch, STOP: that card's scheduling rows have been
-- re-pointed and the rewrite must be reverted.
SELECT
  f.id,
  f.cloze_count                                                   AS recorded_groups,
  (SELECT COUNT(DISTINCT m[1])
     FROM regexp_matches(f.cloze_text, '\{\{c(\d+)::', 'g') AS m) AS groups_in_text
FROM public.flashcards f
WHERE f.id IN ('04ec9f3d-87f9-4f65-aea0-4e8c905d5ef9',
                '07eadafd-f15e-4880-b269-d7a155ceb2c7',
                '0b5fb450-0aca-4899-a7a5-fcb2796adc7e',
                '0d9846de-b7f2-4020-9825-f839f31b582b',
                '16c551d9-9fa6-4fbd-9965-28101bfdf9e3',
                '18d7c47c-f201-4574-8211-ca66b7da2b60',
                '1fb846ff-521b-4247-ad51-8ac00e54ff7c',
                '27461a49-8ea5-440a-b4c7-9f0ca6ab19cb',
                '3782072d-0d7d-4d73-bc99-a1ba3d351bdc',
                '43457e40-b3f5-4c1b-904b-15a81c710e1d',
                '43de4f2a-714d-4d72-8ad5-6498adf28c25',
                '4619304e-28e7-4cba-a371-f64ca9e25a66',
                '4bda0236-75fe-4fb9-aaf9-d883248446fa',
                '4c469b8b-783b-48ae-8f82-e0f0721c283d',
                '4d6d5be9-d7cb-421d-b05d-6dd32af5383b',
                '4fc6db16-1d4a-439a-8194-12962ebbfec8',
                '53d6a717-8cef-4aa5-8477-7dfcc4598c54',
                '55cfe696-6b8c-4451-94a8-d9291093dbd9',
                '63385a49-8ba1-43b6-ba15-4b7b4d9b2597',
                '6fa95cc4-b3b7-4071-a9b5-ad1d87bfe5a5',
                '78bfe7f4-a88e-4562-8e3d-f286e285a178',
                '7dfb8484-5df0-440b-8716-d1407348f4d1',
                '8ed3ee2d-dbe7-449b-a7e8-3dfaedf8cefe',
                '94e39e7c-12e0-441b-bd38-d467d2f6a765',
                '95109394-fba6-46f2-93ba-03d4b7826c74',
                '9c66d252-6fa1-4550-949b-92f513324490',
                '9d4774e6-285f-4a25-a2f5-5e920c9b82e1',
                '9fe3ee39-b5ed-46e8-bb5d-1cfdd0257bac',
                'a327dc2d-3276-4f94-ab02-2f3b4c48ccc5',
                'ada6ff9d-3730-43ea-b711-f99f6a759601',
                'b60e8a8f-c2c5-426c-810d-e89d6ad46d63',
                'cf094abf-b728-4e7b-8307-075bf20689cc',
                'd61643e9-9c14-49a9-b677-52c9f6aa0f96',
                'd71fd653-8e10-4c73-b5b6-65e208bbadc2',
                'db480062-17c8-4974-af03-c0fbbc6753a9',
                'dc5b709d-dae6-41db-8562-3a9ff6c80cf4')
  AND f.cloze_count <> (SELECT COUNT(DISTINCT m[1])
                          FROM regexp_matches(f.cloze_text, '\{\{c(\d+)::', 'g') AS m);

-- Expect 36.
SELECT COUNT(*) AS cards_updated
FROM public.flashcards
WHERE id IN ('04ec9f3d-87f9-4f65-aea0-4e8c905d5ef9',
             '07eadafd-f15e-4880-b269-d7a155ceb2c7',
             '0b5fb450-0aca-4899-a7a5-fcb2796adc7e',
             '0d9846de-b7f2-4020-9825-f839f31b582b',
             '16c551d9-9fa6-4fbd-9965-28101bfdf9e3',
             '18d7c47c-f201-4574-8211-ca66b7da2b60',
             '1fb846ff-521b-4247-ad51-8ac00e54ff7c',
             '27461a49-8ea5-440a-b4c7-9f0ca6ab19cb',
             '3782072d-0d7d-4d73-bc99-a1ba3d351bdc',
             '43457e40-b3f5-4c1b-904b-15a81c710e1d',
             '43de4f2a-714d-4d72-8ad5-6498adf28c25',
             '4619304e-28e7-4cba-a371-f64ca9e25a66',
             '4bda0236-75fe-4fb9-aaf9-d883248446fa',
             '4c469b8b-783b-48ae-8f82-e0f0721c283d',
             '4d6d5be9-d7cb-421d-b05d-6dd32af5383b',
             '4fc6db16-1d4a-439a-8194-12962ebbfec8',
             '53d6a717-8cef-4aa5-8477-7dfcc4598c54',
             '55cfe696-6b8c-4451-94a8-d9291093dbd9',
             '63385a49-8ba1-43b6-ba15-4b7b4d9b2597',
             '6fa95cc4-b3b7-4071-a9b5-ad1d87bfe5a5',
             '78bfe7f4-a88e-4562-8e3d-f286e285a178',
             '7dfb8484-5df0-440b-8716-d1407348f4d1',
             '8ed3ee2d-dbe7-449b-a7e8-3dfaedf8cefe',
             '94e39e7c-12e0-441b-bd38-d467d2f6a765',
             '95109394-fba6-46f2-93ba-03d4b7826c74',
             '9c66d252-6fa1-4550-949b-92f513324490',
             '9d4774e6-285f-4a25-a2f5-5e920c9b82e1',
             '9fe3ee39-b5ed-46e8-bb5d-1cfdd0257bac',
             'a327dc2d-3276-4f94-ab02-2f3b4c48ccc5',
             'ada6ff9d-3730-43ea-b711-f99f6a759601',
             'b60e8a8f-c2c5-426c-810d-e89d6ad46d63',
             'cf094abf-b728-4e7b-8307-075bf20689cc',
             'd61643e9-9c14-49a9-b677-52c9f6aa0f96',
             'd71fd653-8e10-4c73-b5b6-65e208bbadc2',
             'db480062-17c8-4974-af03-c0fbbc6753a9',
             'dc5b709d-dae6-41db-8562-3a9ff6c80cf4');
