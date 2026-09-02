-- ============================================================
-- Flashcard defect repairs, from the card-level diagnosis
--
-- 34 cards a student has forgotten 5+ times, where a review of the card TEXT
-- found the card genuinely defective rather than simply hard.
--
-- WHAT IS DELIBERATELY NOT HERE. 47 cards were diagnosed as defective; 13 are
-- held back. Almost all of those "fixed" the card by DELETING BLANKS, testing
-- one of Darwin's three tenets instead of all three, one of four excretory
-- functions instead of four. That makes a card easier by teaching less, which
-- is a decision about content and not a model's to make.
--
-- A length check missed every one of them: the words all remain, they are
-- simply no longer blanked. Counting blanks rather than characters is what
-- caught it.
--
-- Every statement below passed five gates:
--   . cloze GROUP SET unchanged, a blank is identified by position, so
--     renumbering silently re-points saved progress at other material
--   . BLANK COUNT does not fall, the card still tests what it tested
--   . no nested clozes, which the flat renderer cannot parse
--   . no LaTeX (flashcards render plain Unicode only)
--   . no em or en dashes
--
-- One is a factual correction rather than a clarity fix: the double-blind card
-- listed three unaware parties, which describes a triple-blind design.
--
-- UPDATE by id. Card ids stay stable, scheduling rows stay attached.
-- ============================================================

-- Motion & Forces · 16 lapses · answer_too_long
-- The c2 blank demands recall of all seven base units plus their associated quantities in one shot, so a single lapse on any item fails the wh
UPDATE public.flashcards SET cloze_text = 'The {{c1::SI (Système International) system}} defines {{c2::seven}} base units from which all other physical units are derived: the meter (length), kilogram (mass), second (time), ampere (electric current), kelvin (temperature), mole (amount of substance), and candela (luminous intensity).' WHERE id = '38948550-0c56-4cf4-96fe-721adc416e68';

-- Oxidation-Reduction Reactions · 10 lapses · answer_too_long
-- A single blank demands an eight-item unordered list (O₂, four halogens, two Cr/Mn reagents, peroxide, two concentrated acids), so any one om
UPDATE public.flashcards SET cloze_text = 'Common metal-containing oxidizing agents to recognize on the MCAT: {{c1::KMnO₄, K₂Cr₂O₇, and CrO₃}}.' WHERE id = '08ee3b84-6622-4fe8-82ed-7373a1f13c7b';

-- Motivation, Emotion, and Stress · 12 lapses · asks_two_things
-- A single blank demands three separate items (autonomy, competence, relatedness), so the review is all-or-nothing: missing any one need marks
UPDATE public.flashcards SET cloze_text = 'Self-determination theory proposes three universal psychological needs: autonomy, competence, and {{c1::relatedness}}.' WHERE id = '35c9a9d6-1595-4b6c-a6e8-71528cfa6a1c';

-- Separations and Purifications · 9 lapses · answer_too_long
-- Both blanks hide whole verb phrases ('buffer is changed', 'disrupt the binding interaction') that admit many equally correct phrasings rathe
UPDATE public.flashcards SET cloze_text = 'To recover the target from an affinity column, change the {{c1::buffer}} (pH, salt, or competing ligand) to disrupt the {{c2::ligand-protein binding}} and elute the compound.' WHERE id = '465ac938-23ef-4c6f-a498-a0ac40c694bd';

-- Oxidation-Reduction Reactions · 8 lapses · answer_not_unique
-- The c3 blank asks for "active metals" with no constraint that picks out Zn, Mg, Na specifically, Li, K, Ca, Fe and others are equally valid
UPDATE public.flashcards SET cloze_text = 'Common reducing agents to recognize: {{c1::H₂}}, the hydride reagents {{c2::NaBH₄ and LiAlH₄}}, three active metals (one transition, one alkaline earth, one alkali): {{c3::Zn, Mg, Na}}, and the biological carriers {{c4::NADH and FADH₂}}.' WHERE id = '14c05658-e2f9-46a8-99bb-df95d2380074';

-- Circuits · 8 lapses · asks_two_things
-- The single blank demands two separate algebraic forms of the capacitor energy formula, and the prompt 'U = ?' does not uniquely specify whic
UPDATE public.flashcards SET cloze_text = 'The energy stored in a capacitor, in terms of capacitance C and voltage V, is U = {{c1::½CV²}}.' WHERE id = '31833cc4-02f2-49a1-b51e-5f734c7ee119';

-- Aldehydes and Ketones II: Enolates · 8 lapses · ambiguous_wording
-- The c2 answer "EDG-driven destabilization" of the "developing partial positive charge" is chemically backwards/confusing, alkyl electron do
UPDATE public.flashcards SET cloze_text = 'Ketones are also less reactive toward nucleophiles than aldehydes for two reasons: {{c1::greater steric hindrance}} at the carbonyl carbon and {{c2::electron donation by the second alkyl group}}, which reduces the {{c3::partial positive charge}} on the carbonyl carbon.' WHERE id = '34aaa006-33be-4852-a74d-d01931750111';

-- Embryonic Development & Gestation · 7 lapses · answer_not_unique
-- The c2 blank hides the generic phrase "structure and function," which is not a uniquely determined recall target (morphology, phenotype, cha
UPDATE public.flashcards SET cloze_text = '{{c1::Differentiation}} is the process in which a determined cell actually develops the specialized structure and function of its committed cell type; it follows {{c2::determination}}, the earlier commitment of the cell to a specific fate.' WHERE id = '04d0fa96-29a5-4909-ad13-0b55b638a8d8';

-- Reasoning About Research Design · 7 lapses · answer_not_unique
-- The c2 blank asks what is unaware in a double-blind trial but expects three parties (subject, investigator, and assessor), which is the stan
UPDATE public.flashcards SET cloze_text = 'In a {{c1::single-blind}} trial, only one party is unaware of group assignment; in a {{c1::double-blind}} trial, the {{c2::subject and the investigator}} are both unaware.' WHERE id = '158b3211-fc85-4bc1-82a8-68478a8a7465';

-- Brain, Behavior & Development · 7 lapses · answer_too_long
-- The c2 blank hides a three-item list of functions that is not uniquely recoverable from the stem (error detection, conflict monitoring, pain
UPDATE public.flashcards SET cloze_text = 'The {{c1::anterior cingulate cortex}} contributes to higher-order cognitive processes including {{c2::impulse control}}, decision-making, and emotional regulation. It bridges the limbic system with the prefrontal cortex.' WHERE id = '26fad192-2618-4ed8-b967-ad5d22a99fb2';

-- Inside the Atom · 7 lapses · ambiguous_wording
-- The stem says the photon's "wavelength is given by" the blank, but the answer supplied is solved for energy (E = hc/λ); a student who correc
UPDATE public.flashcards SET cloze_text = 'When an excited electron drops back to a lower energy level, the atom releases the energy difference as a {{c1::photon}} whose wavelength is given by {{c2::λ = hc/E}}. This is the physical basis of atomic emission spectra.' WHERE id = '30ca1157-f68d-41c2-9e1c-4c6aa2761a3c';

-- Chemical Kinetics · 7 lapses · answer_visible_elsewhere
-- The c1 answer spells out the full linearized equation including −(Eₐ/R)(1/T), so when c2 (the slope, −Eₐ/R) is tested the answer is sitting 
UPDATE public.flashcards SET cloze_text = 'Taking the natural log linearizes the Arrhenius equation, so a plot of {{c1::ln k versus 1/T}} is a straight line whose slope equals {{c2::−Eₐ/R}}.' WHERE id = '343b0b96-f840-4afe-9522-c537275dd2f8';

-- Carbohydrate Metabolism II · 7 lapses · asks_two_things
-- The c2 group bundles three blanks of different kinds, the intermediate metabolite (acetaldehyde, twice) and the second enzyme name (acetald
UPDATE public.flashcards SET cloze_text = 'Ethanol is converted to acetyl-CoA by {{c1::alcohol dehydrogenase}} (ethanol → {{c2::acetaldehyde}}) followed by {{c1::acetaldehyde dehydrogenase}} ({{c2::acetaldehyde}} → acetate → acetyl-CoA), generating NADH at each step.' WHERE id = '450ade1c-4c95-4f27-8e67-634074487963';

-- Solutions · 6 lapses · answer_not_unique
-- A single blank must be filled with a four-item list, and the stem gives no cue to how many or which anion classes are wanted, hydroxides, o
UPDATE public.flashcards SET cloze_text = 'The four anion classes that are insoluble unless the cation is a Group 1 metal or ammonium (NH₄⁺) are {{c1::carbonates, phosphates, sulfides, and sulfites}}.' WHERE id = '04f3265d-0b8c-43d9-910e-d153ebc6d827';

-- Spectroscopy · 6 lapses · answer_visible_elsewhere
-- When c2 is tested, the trailing visible sentence "This lets you count protons of each type" hands over the answer ("number of protons"), so 
UPDATE public.flashcards SET cloze_text = 'The {{c1::area under each NMR peak}} (called the integration) is proportional to the {{c2::number of protons}} producing that peak.' WHERE id = '0cda3ac9-bc3c-4195-8b07-93a01fac07a3';

-- Cognition, Consciousness, and Language · 6 lapses · answer_not_unique
-- The stem says "abilities such as ___ and ___," but Gardner posits seven to nine intelligences, so spatial, interpersonal, intrapersonal, or 
UPDATE public.flashcards SET cloze_text = 'In Gardner''s theory of multiple intelligences, sensitivity to rhythm and pitch is {{c1::musical}} intelligence and skilled physical coordination is {{c1::bodily-kinesthetic}} intelligence, each a full separate intelligence alongside linguistic and logical-mathematical ability.' WHERE id = '27054b63-fbed-4151-8db5-f16596bf66ce';

-- Waves and Sound · 6 lapses · answer_not_unique
-- "Sound is a {{c1::___}} wave" equally admits "longitudinal," a standard MCAT classification of sound, so the first blank is not uniquely det
UPDATE public.flashcards SET cloze_text = 'Classified by whether it needs a medium, sound is a {{c1::mechanical}} wave rather than electromagnetic, so it travels through solids, liquids, and gases but never through a {{c1::vacuum}}.' WHERE id = '25f77d6a-2e5c-4689-a094-120828e4f5cb';

-- Chemical Kinetics · 6 lapses · answer_visible_elsewhere
-- The trailing clause restates both answers in visible text: "k stays fixed as concentrations change" gives away c1, and "speeds up when heate
UPDATE public.flashcards SET cloze_text = 'The rate constant k is {{c1::independent of reactant concentration}}, but it does change with {{c2::temperature}}.' WHERE id = '2c8521f4-5397-462f-8290-5156b69917bd';

-- Biological Membranes · 6 lapses · answer_not_unique
-- The c2 blank asks for the type of "weak ... interactions" binding peripheral proteins, but hydrogen bonding, van der Waals, or simply "nonco
UPDATE public.flashcards SET cloze_text = '{{c1::Peripheral}} membrane proteins are not embedded in the bilayer; they bind the surface through weak {{c2::electrostatic}} attractions between charged residues and polar lipid head groups or integral proteins (noncovalent, so easily removed by salt changes).' WHERE id = '2b055227-36c5-4231-9365-2575ee56c551';

-- Social Structure and Demographics · 6 lapses · answer_not_unique
-- The stem "can provoke backlash and social change, including ___" is open-ended, so many correct answers (nationalism, xenophobia, protection
UPDATE public.flashcards SET cloze_text = 'Globalization''s rapid economic and cultural integration can provoke backlash and social change; one commonly cited violent consequence is domestic {{c1::civil unrest}}, alongside terrorism that crosses national borders.' WHERE id = '347af535-f086-407e-a4d1-80e08262a83d';

-- Social Stratification · 6 lapses · answer_not_unique
-- When c2 is tested the stem reads "Social epidemiology studies how ___ shape health and disease distribution," which admits many equally corr
UPDATE public.flashcards SET cloze_text = '{{c1::Social epidemiology}} studies how three levels of social factors, {{c2::structures, institutions, and relationships}}, shape health and disease distribution. For example, SES inequality drives mortality differences.' WHERE id = '2f682f5c-881f-4eb5-aa03-2eb842177464';

-- Bioenergetics and Regulation of Metabolism · 6 lapses · answer_not_unique
-- With c1 hidden the stem reads only "___ is measured at standard concentrations (1 M), pressure (1 atm), and temperature (25 °C)", which equa
UPDATE public.flashcards SET cloze_text = '{{c1::Standard free energy (ΔG°)}} is the free energy change of a reaction measured at standard concentrations (1 M), pressure (1 atm), and temperature ({{c2::25 °C}}).' WHERE id = '3693132e-65d5-4e86-982c-feaf45232379';

-- Aldehydes and Ketones I · 6 lapses · answer_not_unique
-- All four reagents sit in a single c1 group, so the student sees only an open-ended prompt ('common reagents that oxidize aldehydes') and mus
UPDATE public.flashcards SET cloze_text = 'Common oxidants converting aldehydes to carboxylic acids: the permanganate {{c1::KMnO₄}}, the chromium(VI) oxide {{c1::CrO₃}}, the silver oxide {{c1::Ag₂O}}, and the peroxide {{c1::H₂O₂}}.' WHERE id = '39c7ecfc-50b5-4ac2-bff5-f768eac0b785';

-- Brain, Behavior & Development · 6 lapses · answer_too_long
-- The c2 blank demands verbatim recall of a four-item list (intuition, creativity, music cognition, spatial processing) in a single deletion, 
UPDATE public.flashcards SET cloze_text = 'The {{c1::non-dominant hemisphere}} (typically the right) handles music cognition and spatial processing, and is also associated with {{c2::intuition and creativity}}. It is more sensitive to the {{c3::emotional tone}} of language and assembles individual stimuli into holistic perceptions.' WHERE id = '49344739-a47b-47ff-a207-76b500af491d';

-- Bioenergetics and Regulation of Metabolism · 5 lapses · answer_not_unique
-- The c1 blank ('insulin increases ___' in muscle cells) is not uniquely determined, 'glucose uptake' is the canonical, equally correct compl
UPDATE public.flashcards SET cloze_text = 'In muscle cells, insulin increases uptake of glucose and of {{c1::amino acids}}, stimulates {{c2::protein synthesis}}, and decreases protein breakdown.' WHERE id = '1b9e0c2e-2abe-4769-9b93-e116669186e4';

-- Carboxylic Acid Derivatives · 5 lapses · answer_not_unique
-- The c2 blank ('provides resonance stabilization of ___') is not uniquely cued, 'the carbonyl', 'the negative charge', 'the leaving group', 
UPDATE public.flashcards SET cloze_text = '{{c1::Conjugation}} (alternating single and multiple bonds with delocalized π electrons) can delocalize charge in the high-energy species along a reaction path, i.e. the {{c2::transition states and intermediates}}, lowering activation energy and often {{c3::increasing reactivity}} toward nucleophiles.' WHERE id = '1f35235e-5c6a-4959-a1c0-c0fbd4553648';

-- Spectroscopy · 5 lapses · answer_visible_elsewhere
-- The hidden answer 'extent of conjugation' is telegraphed by the visible text, which twice says 'conjugated' ('conjugated system', 'longer co
UPDATE public.flashcards SET cloze_text = 'The wavelength of maximum absorbance (λₘₐₓ) of a conjugated system tells you the extent of conjugation: longer conjugated chains have {{c1::larger}} λₘₐₓ values.' WHERE id = '2326f96a-9bbc-4d85-9be4-d44f2ce773ed';

-- Psychological Disorders · 5 lapses · answer_not_unique
-- The three blanks are undifferentiated items from one synonymous cluster, so no blank is uniquely cued: c2 could equally be 'inflexibility'/'
UPDATE public.flashcards SET cloze_text = 'Obsessive-compulsive personality disorder (Cluster C), unlike OCD, has no true obsessions or compulsions; its hallmark triad is {{c1::perfectionism}} (unattainably high standards that impair task completion), {{c2::rigidity}} (inflexible stubbornness about rules and morals), and preoccupation with {{c3::orderliness and control}} (lists, schedules, details, interpersonal control).' WHERE id = '283de500-b757-4859-88a0-5fe78096378c';

-- Fluids · 5 lapses · answer_not_unique
-- The stem "produced by the ___ of the fluid lying above that point" equally admits "mass", "height", or "column" as plausible fillers, so the
UPDATE public.flashcards SET cloze_text = 'Hydrostatic pressure at a point in a static fluid equals the {{c1::weight}} of the overlying fluid divided by the area it acts on (P = ρgh).' WHERE id = '2c15d847-83ce-4247-8247-06a09eb082cd';

-- Sensory Systems & Perception · 5 lapses · answer_too_long
-- The c2 blank bundles nine separate facts (three type names, three letter abbreviations, and three matched colors) into one all-or-nothing an
UPDATE public.flashcards SET cloze_text = '{{c1::Cones}} require bright light to function but support color vision and high-acuity discrimination of fine detail. There are three {{c1::cone}} types named for the wavelength they prefer, short (S), medium (M), and long (L), which correspond respectively to {{c2::blue, green, and red}}; together their activation patterns let the brain distinguish thousands of colors.' WHERE id = '31ef1d9f-7d8e-4274-b0fe-ddfbc4b3e5f7';

-- The Respiratory System · 5 lapses · answer_not_unique
-- The c2 blank is a bare descriptive adjective in "a ___ sheet of skeletal muscle", which equally admits "thin", "broad", "flat", or "muscular
UPDATE public.flashcards SET cloze_text = 'Separating the thorax from the abdomen sits the {{c1::diaphragm}}, a sheet of skeletal muscle whose relaxed resting shape is {{c2::dome-shaped}}; it drives inhalation: as it contracts it flattens and drops {{c3::inferiorly}}, enlarging the thoracic cavity and drawing air in.' WHERE id = '326ee06b-c5ef-4d08-a845-31ca48b859a1';

-- The Cell · 5 lapses · answer_not_unique
-- Both blanks are open-ended lists with no discriminating cue: "___, ___, and ___ are connective tissue cells" admits adipocytes, mast cells, 
UPDATE public.flashcards SET cloze_text = 'Connective tissue cells named for the matrix they build: the collagen-secreting {{c1::fibroblasts}}, the bone-matrix-depositing {{c1::osteoblasts}}, and the cartilage-matrix-depositing {{c1::chondroblasts}}. Epithelial in origin despite their internal location: the {{c2::endothelial cells}} lining blood vessel lumens and the glucagon-secreting {{c2::α-cells of pancreatic islets}}.' WHERE id = '3eb3e75a-951f-41ab-9593-d5559ba88ca6';

-- Psychological Disorders · 5 lapses · answer_too_long
-- A single blank demands verbatim recall of a four-item list, so any one missing or mis-worded cluster fails the whole card; that is four sepa
UPDATE public.flashcards SET cloze_text = 'The PTSD symptom cluster involving flashbacks, nightmares, and unwanted memories is {{c1::intrusion}} (the other three clusters: avoidance, negative changes in cognition and mood, arousal/reactivity).' WHERE id = 'caef813f-789b-44ac-8c74-3da9aa5bb060';

-- Aldehydes and Ketones II: Enolates · 5 lapses · answer_visible_elsewhere
-- The trailing appositive "a carbonyl with a hydroxyl group on the β-carbon" spells out the hidden answer, so the card tests exact wording of 
UPDATE public.flashcards SET cloze_text = 'The aldol addition product is a {{c1::β-hydroxy aldehyde or ketone}}, formed when an enolate attacks the carbonyl carbon of another aldehyde or ketone.' WHERE id = '53a02d5f-d0e7-42e8-9cde-33b169b267b0';

-- ── Verification ────────────────────────────────────────────────────────
-- Any row here means a rewrite re-pointed a scheduling row. Expect none.
SELECT f.id, f.cloze_count AS recorded_groups,
  (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(f.cloze_text,'\{\{c(\d+)::','g') AS m) AS groups_in_text
FROM public.flashcards f
WHERE f.id IN ('38948550-0c56-4cf4-96fe-721adc416e68',
                '08ee3b84-6622-4fe8-82ed-7373a1f13c7b',
                '35c9a9d6-1595-4b6c-a6e8-71528cfa6a1c',
                '465ac938-23ef-4c6f-a498-a0ac40c694bd',
                '14c05658-e2f9-46a8-99bb-df95d2380074',
                '31833cc4-02f2-49a1-b51e-5f734c7ee119',
                '34aaa006-33be-4852-a74d-d01931750111',
                '04d0fa96-29a5-4909-ad13-0b55b638a8d8',
                '158b3211-fc85-4bc1-82a8-68478a8a7465',
                '26fad192-2618-4ed8-b967-ad5d22a99fb2',
                '30ca1157-f68d-41c2-9e1c-4c6aa2761a3c',
                '343b0b96-f840-4afe-9522-c537275dd2f8',
                '450ade1c-4c95-4f27-8e67-634074487963',
                '04f3265d-0b8c-43d9-910e-d153ebc6d827',
                '0cda3ac9-bc3c-4195-8b07-93a01fac07a3',
                '27054b63-fbed-4151-8db5-f16596bf66ce',
                '25f77d6a-2e5c-4689-a094-120828e4f5cb',
                '2c8521f4-5397-462f-8290-5156b69917bd',
                '2b055227-36c5-4231-9365-2575ee56c551',
                '347af535-f086-407e-a4d1-80e08262a83d',
                '2f682f5c-881f-4eb5-aa03-2eb842177464',
                '3693132e-65d5-4e86-982c-feaf45232379',
                '39c7ecfc-50b5-4ac2-bff5-f768eac0b785',
                '49344739-a47b-47ff-a207-76b500af491d',
                '1b9e0c2e-2abe-4769-9b93-e116669186e4',
                '1f35235e-5c6a-4959-a1c0-c0fbd4553648',
                '2326f96a-9bbc-4d85-9be4-d44f2ce773ed',
                '283de500-b757-4859-88a0-5fe78096378c',
                '2c15d847-83ce-4247-8247-06a09eb082cd',
                '31ef1d9f-7d8e-4274-b0fe-ddfbc4b3e5f7',
                '326ee06b-c5ef-4d08-a845-31ca48b859a1',
                '3eb3e75a-951f-41ab-9593-d5559ba88ca6',
                'caef813f-789b-44ac-8c74-3da9aa5bb060',
                '53a02d5f-d0e7-42e8-9cde-33b169b267b0')
  AND f.cloze_count <> (SELECT COUNT(DISTINCT m[1]) FROM regexp_matches(f.cloze_text,'\{\{c(\d+)::','g') AS m);

-- Expect 34.
SELECT COUNT(*) AS cards_updated FROM public.flashcards
WHERE id IN ('38948550-0c56-4cf4-96fe-721adc416e68',
             '08ee3b84-6622-4fe8-82ed-7373a1f13c7b',
             '35c9a9d6-1595-4b6c-a6e8-71528cfa6a1c',
             '465ac938-23ef-4c6f-a498-a0ac40c694bd',
             '14c05658-e2f9-46a8-99bb-df95d2380074',
             '31833cc4-02f2-49a1-b51e-5f734c7ee119',
             '34aaa006-33be-4852-a74d-d01931750111',
             '04d0fa96-29a5-4909-ad13-0b55b638a8d8',
             '158b3211-fc85-4bc1-82a8-68478a8a7465',
             '26fad192-2618-4ed8-b967-ad5d22a99fb2',
             '30ca1157-f68d-41c2-9e1c-4c6aa2761a3c',
             '343b0b96-f840-4afe-9522-c537275dd2f8',
             '450ade1c-4c95-4f27-8e67-634074487963',
             '04f3265d-0b8c-43d9-910e-d153ebc6d827',
             '0cda3ac9-bc3c-4195-8b07-93a01fac07a3',
             '27054b63-fbed-4151-8db5-f16596bf66ce',
             '25f77d6a-2e5c-4689-a094-120828e4f5cb',
             '2c8521f4-5397-462f-8290-5156b69917bd',
             '2b055227-36c5-4231-9365-2575ee56c551',
             '347af535-f086-407e-a4d1-80e08262a83d',
             '2f682f5c-881f-4eb5-aa03-2eb842177464',
             '3693132e-65d5-4e86-982c-feaf45232379',
             '39c7ecfc-50b5-4ac2-bff5-f768eac0b785',
             '49344739-a47b-47ff-a207-76b500af491d',
             '1b9e0c2e-2abe-4769-9b93-e116669186e4',
             '1f35235e-5c6a-4959-a1c0-c0fbd4553648',
             '2326f96a-9bbc-4d85-9be4-d44f2ce773ed',
             '283de500-b757-4859-88a0-5fe78096378c',
             '2c15d847-83ce-4247-8247-06a09eb082cd',
             '31ef1d9f-7d8e-4274-b0fe-ddfbc4b3e5f7',
             '326ee06b-c5ef-4d08-a845-31ca48b859a1',
             '3eb3e75a-951f-41ab-9593-d5559ba88ca6',
             'caef813f-789b-44ac-8c74-3da9aa5bb060',
             '53a02d5f-d0e7-42e8-9cde-33b169b267b0');
