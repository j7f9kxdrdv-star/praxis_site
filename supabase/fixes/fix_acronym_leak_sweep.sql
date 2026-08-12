-- Fix: bank-wide acronym answer-leak sweep (23 cards across 14 decks).
-- Trigger: four founder-flagged cards in three days shared one mechanism, a blanked term
-- restated in the card's visible text. A full-bank scan found 60 candidates; four judge
-- agents ruled each against explicit criteria (genus-given/qualifier-recalled and
-- deliberate stem definitions are ACCEPTABLE and untouched), confirming these 23 as true
-- self-leaks. Each fix removes only the leaking visible mention (pronoun or generic noun);
-- every cloze group, count, and tested fact is unchanged. SRS-safe and idempotent.

-- #4 . biochemistry_ch10_carbohydrate_metabolism_ii
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'per FADH₂ vs', 'each vs')
WHERE cloze_text LIKE '%per FADH₂ vs%';

-- #5 . biochemistry_ch10_carbohydrate_metabolism_ii
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '(preferred by cardiac muscle) transfers cytosolic NADH electrons to mitochondrial', '(preferred by cardiac muscle) transfers cytosolic reducing equivalents to mitochondrial')
WHERE cloze_text LIKE '%(preferred by cardiac muscle) transfers cytosolic NADH electrons to mitochondrial%';

-- #7 . biochemistry_ch10_carbohydrate_metabolism_ii
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'contributing ~7 ATP when those cytosolic NADH eventually feed', 'contributing ~7 more when those cytosolic carriers eventually feed')
WHERE cloze_text LIKE '%contributing ~7 ATP when those cytosolic NADH eventually feed%';

-- #21 . biology_ch11_the_musculoskeletal_system
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'by transferring a phosphate group from ATP to creatine', 'by transferring a phosphate group onto creatine')
WHERE cloze_text LIKE '%by transferring a phosphate group from ATP to creatine%';

-- #24 . biology_ch2_cell_division_and_reproduction
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'absent SRY, the default', 'without it, the default')
WHERE cloze_text LIKE '%absent SRY, the default%';

-- #26 . biology_ch2_cell_division_and_reproduction
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'unresponsive to FSH and LH', 'unresponsive to pituitary gonadotropins')
WHERE cloze_text LIKE '%unresponsive to FSH and LH%';

-- #27 . biology_ch4_the_nervous_system
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'the nerves connecting the CNS to the rest of the body', 'the nerves connecting it to the rest of the body')
WHERE cloze_text LIKE '%the nerves connecting the CNS to the rest of the body%';

-- #28 . biology_ch5_the_endocrine_system
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, '; ACTH then signals the adrenal cortex', '; this hormone then signals the adrenal cortex')
WHERE cloze_text LIKE '%; ACTH then signals the adrenal cortex%';

-- #29 . biology_ch6_the_respiratory_system
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'because CO2 crossing the blood-brain barrier raises', 'because it crosses the blood-brain barrier and raises')
WHERE cloze_text LIKE '%because CO2 crossing the blood-brain barrier raises%';

-- #34 . general_chemistry_ch11_oxidation_reduction_reactions
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'then add OH⁻ to both sides to neutralize H⁺', 'then neutralize the H⁺ on both sides')
WHERE cloze_text LIKE '%then add OH⁻ to both sides to neutralize H⁺%';

-- #35 . general_chemistry_ch12_electrochemistry
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'opposite signs: ΔG < 0 (favorable) ↔ EMF > 0; ΔG > 0 (unfavorable) ↔ EMF < 0.', 'opposite signs: a favorable reaction has the former negative and the latter positive.')
WHERE cloze_text LIKE '%opposite signs: ΔG < 0 (favorable) ↔ EMF > 0; ΔG > 0 (unfavorable) ↔ EMF < 0.%';

-- #37 . general_chemistry_ch2_periodic_trends_and_chemical_families
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'Successive ionization energies always rise: {{c1::IE₁ < IE₂ < IE₃}}, because each subsequent electron is being removed from a progressively more positive cation. A particularly large jump between IEₙ and IEₙ₊₁ signals', 'Successive ionization energies follow the pattern {{c1::IE₁ < IE₂ < IE₃}}, because each subsequent electron is being removed from a progressively more positive cation. A particularly large jump between consecutive values signals')
WHERE cloze_text LIKE '%Successive ionization energies always rise: {{c1::IE₁ < IE₂ < IE₃}}, because each subsequent electron is being removed from a progressively more positive cation. A particularly large jump between IEₙ and IEₙ₊₁ signals%';

-- #38 . organic_chemistry_ch11_spectroscopy
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'measures the absorption of UV/visible light, which excites', 'measures light absorption by a sample, which excites')
WHERE cloze_text LIKE '%measures the absorption of UV/visible light, which excites%';

-- #39 . organic_chemistry_ch11_spectroscopy
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'must exactly match the HOMO-LUMO energy gap', 'must exactly match the energy gap between the two')
WHERE cloze_text LIKE '%must exactly match the HOMO-LUMO energy gap%';

-- #40 . organic_chemistry_ch11_spectroscopy
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'uses the same proton-NMR principle as', 'uses the same principle as')
WHERE cloze_text LIKE '%uses the same proton-NMR principle as%';

-- #42 . organic_chemistry_ch12_separations_and_purifications
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'modern HPLC is distinguished instead by', 'the modern form is distinguished instead by')
WHERE cloze_text LIKE '%modern HPLC is distinguished instead by%';

-- #43 . organic_chemistry_ch1_naming_organic_molecules
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'a properly assigned IUPAC name maps uniquely', 'a properly assigned name maps uniquely')
WHERE cloze_text LIKE '%a properly assigned IUPAC name maps uniquely%';

-- #44 . organic_chemistry_ch6_aldehydes_and_ketones_i
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'with PCC, Na₂Cr₂O₇, CrO₃, or KMnO₄', 'with mild or strong oxidizers alike')
WHERE cloze_text LIKE '%with PCC, Na₂Cr₂O₇, CrO₃, or KMnO₄%';

-- #45 . physics_ch2_energy_work_and_simple_machines
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, ' A machine with MA = 5 lets you produce a 5 N output by applying only 1 N at the input.', '')
WHERE cloze_text LIKE '% A machine with MA = 5 lets you produce a 5 N output by applying only 1 N at the input.%';

-- #47 . psych_soc_ch1_brain_behavior_and_development
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'consists of all nerve tissue outside the CNS', 'consists of all nerve tissue outside it')
WHERE cloze_text LIKE '%consists of all nerve tissue outside the CNS%';

-- #48 . psych_soc_ch1_brain_behavior_and_development
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'extends MRI by tracking', 'extends it by tracking')
WHERE cloze_text LIKE '%extends MRI by tracking%';

-- #49 . psych_soc_ch2_sensory_systems_and_perception
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'generalizes the finding: the JND is a', 'generalizes the finding: this threshold is a')
WHERE cloze_text LIKE '%generalizes the finding: the JND is a%';

-- #51 . scientific_reasoning_ch12_data_based_and_statistical_reasoning
UPDATE public.flashcards
SET cloze_text = REPLACE(cloze_text, 'the box spans Q1 to Q3 with the median as a line inside', 'the box marks the central spread with a line inside')
WHERE cloze_text LIKE '%the box spans Q1 to Q3 with the median as a line inside%';

-- Verification: expect 0 rows (no leaking token remains anywhere).
SELECT id, LEFT(cloze_text, 90) AS still_leaking
FROM public.flashcards
WHERE cloze_text LIKE '%per FADH₂ vs%'
   OR cloze_text LIKE '%(preferred by cardiac muscle) transfers cytosolic NADH electrons to mitochondrial%'
   OR cloze_text LIKE '%contributing ~7 ATP when those cytosolic NADH eventually feed%'
   OR cloze_text LIKE '%by transferring a phosphate group from ATP to creatine%'
   OR cloze_text LIKE '%absent SRY, the default%'
   OR cloze_text LIKE '%unresponsive to FSH and LH%'
   OR cloze_text LIKE '%the nerves connecting the CNS to the rest of the body%'
   OR cloze_text LIKE '%; ACTH then signals the adrenal cortex%'
   OR cloze_text LIKE '%because CO2 crossing the blood-brain barrier raises%'
   OR cloze_text LIKE '%then add OH⁻ to both sides to neutralize H⁺%'
   OR cloze_text LIKE '%opposite signs: ΔG < 0 (favorable) ↔ EMF > 0; ΔG > 0 (unfavorable) ↔ EMF < 0.%'
   OR cloze_text LIKE '%Successive ionization energies always rise: {{c1::IE₁ < IE₂ < IE₃}}, because each subsequent electron is being removed from a progressively more positive cation. A particularly large jump between IEₙ and IEₙ₊₁ signals%'
   OR cloze_text LIKE '%measures the absorption of UV/visible light, which excites%'
   OR cloze_text LIKE '%must exactly match the HOMO-LUMO energy gap%'
   OR cloze_text LIKE '%uses the same proton-NMR principle as%'
   OR cloze_text LIKE '%modern HPLC is distinguished instead by%'
   OR cloze_text LIKE '%a properly assigned IUPAC name maps uniquely%'
   OR cloze_text LIKE '%with PCC, Na₂Cr₂O₇, CrO₃, or KMnO₄%'
   OR cloze_text LIKE '% A machine with MA = 5 lets you produce a 5 N output by applying only 1 N at the input.%'
   OR cloze_text LIKE '%consists of all nerve tissue outside the CNS%'
   OR cloze_text LIKE '%extends MRI by tracking%'
   OR cloze_text LIKE '%generalizes the finding: the JND is a%'
   OR cloze_text LIKE '%the box spans Q1 to Q3 with the median as a line inside%';
