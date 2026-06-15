-- GenChem Ch1 (Atomic Structure) — Batch 1 of 3: Subatomic Particles, Isotopes & Atomic Weight, The Mole & Avogadro
-- 25 questions, all confidence 5 (OpenStax Atoms First 2e); cross-batch deduped, audit clean.
-- Re-runnable. Run in Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Atomic Structure' AND subtopic IN ('Subatomic Particles', 'Isotopes & Atomic Weight', 'The Mole & Avogadro');

-- Q1 [Subatomic Particles · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s1$Subatomic Particles$s1$,
    $qt1$A neutral \(\text{Mg}\) atom loses two electrons to form \(\text{Mg}^{2+}\). Considering only the relative charges carried by its subatomic particles, which change in the ion's net charge most directly accounts for the \(+2\) value?$qt1$,
    $op1$[{"label": "A", "text": "Removing two particles each carrying \\(-1\\) leaves the unbalanced nuclear charge two units more positive."}, {"label": "B", "text": "Removing two particles each carrying \\(+1\\) leaves the electron cloud two units more negative."}, {"label": "C", "text": "Removing two neutral particles unmasks two protons that had been electrically hidden."}, {"label": "D", "text": "Removing two particles each carrying \\(-2\\) leaves a deficit of four negative units offset by repulsion."}]$op1$::jsonb,
    'A',
    $ex1$This item addresses the relative electric charges of subatomic particles, specifically the sign and magnitude assigned to the electron, proton, and neutron. Each electron carries a charge of \(-1\) (in units of the elementary charge), each proton \(+1\), and each neutron \(0\). A neutral atom has equal numbers of protons and electrons, so removing two electrons (two \(-1\) charges) leaves the proton count unchanged while the electron count drops by two; the proton charge that was formerly balanced is now unopposed, giving a net charge of \((+12)+(-10)=+2\). (Choice B) Protons carry \(+1\), not electrons, and protons reside in the nucleus and are not removed during ordinary ionization; losing positive particles would lower the net positive charge rather than raise it. (Choice C) Neutrons are electrically neutral and contribute nothing to net charge, so removing them cannot alter the charge balance, and protons are not "hidden" by neutrons since neutrons have zero charge. (Choice D) Electrons each carry a magnitude of exactly \(1\), not \(2\), so removing two electrons removes two negative units, not four, and no offsetting repulsion term enters the charge bookkeeping. Skill 1: This question targets recall and identification of the foundational charge values of subatomic particles.$ex1$,
    'easy', '4E', $cc1$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar1B$proton-electron charge sign swap$ar1B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar1C$neutron carries hidden charge$ar1C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar1D$electron charge magnitude inflated$ar1D$ FROM q;

-- Q2 [Subatomic Particles · easy · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s2$Subatomic Particles$s2$,
    $qt2$A neutral atom of \(^{40}_{20}\text{Ca}\) is bombarded such that every electron is stripped away, leaving only the bare nucleus intact. Which particles most likely remain bound within the residual structure?$qt2$,
    $op2$[{"label": "A", "text": "20 protons and 20 electrons"}, {"label": "B", "text": "20 protons and 20 neutrons"}, {"label": "C", "text": "20 protons and 40 neutrons"}, {"label": "D", "text": "20 neutrons and 20 electrons"}]$op2$::jsonb,
    'B',
    $ex2$This item addresses the spatial location of subatomic particles within the atom. The nucleus contains the protons and neutrons, while electrons occupy the surrounding region; stripping away all electrons therefore removes only the orbital particles and leaves the nucleus untouched. For \(^{40}_{20}\text{Ca}\), the atomic number \(Z=20\) fixes the proton count at 20, and the neutron count is the mass number minus the protons, \(A-Z = 40-20 = 20\). The bare nucleus thus retains 20 protons and 20 neutrons. (Choice A) Electrons reside outside the nucleus in the surrounding region, so they are precisely the particles removed during stripping and cannot remain in the residual nucleus. (Choice C) The neutron count is \(A-Z\), not the mass number itself; equating neutrons with \(A=40\) double-counts the nucleons and ignores that protons already account for 20 units of mass. (Choice D) Protons, not neutrons, define the element through \(Z=20\), and electrons cannot persist in a fully stripped nucleus, so this pairing misplaces both the charge-carrying nuclear particle and the orbital particle. Skill 1: this question requires recognizing where each subatomic particle is located within the atom.$ex2$,
    'easy', '4E', $cc2$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc2$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar2A$electrons-inside-nucleus$ar2A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar2C$neutron-count-equals-mass-number$ar2C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar2D$neutron-defines-element-not-proton$ar2D$ FROM q;

-- Q3 [Subatomic Particles · easy · Skill 1 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s3$Subatomic Particles$s3$,
    $qt3$A neutral \(\text{C}\) atom contains 6 protons, 6 neutrons, and 6 electrons. Which contribution to the atom's total mass is most nearly negligible?$qt3$,
    $op3$[{"label": "A", "text": "The 6 protons, because protons are the lightest of the three particle types"}, {"label": "B", "text": "The 6 neutrons, because a neutral atom carries no net charge from them"}, {"label": "C", "text": "The 6 electrons, because each electron has roughly \\(1/1836\\) the mass of a proton"}, {"label": "D", "text": "The 6 neutrons, because they are about \\(1/1836\\) the mass of a proton"}]$op3$::jsonb,
    'C',
    $ex3$This item addresses the relative masses of subatomic particles. A proton and a neutron each have a mass near \(1\ \text{amu}\), whereas an electron has a mass of about \(1/1836\) that of a proton (roughly \(5\times10^{-4}\ \text{amu}\)); the six electrons therefore contribute the smallest share of the atom's total mass and are the negligible term, making C correct. (Choice A) Protons carry essentially the same mass as neutrons, near \(1\ \text{amu}\) each, so they account for roughly half of the atom's mass rather than being negligible. (Choice B) Neutron mass is independent of charge, and neutrons each have a mass near \(1\ \text{amu}\); their contribution is comparable to that of the protons and is not negligible. (Choice D) The \(1/1836\) mass ratio relative to a proton applies to the electron, not the neutron; a neutron is nearly equal in mass to a proton, so this assignment misstates which particle is light. Skill 1: this question requires recalling the foundational fact that electrons are far less massive than nucleons.$ex3$,
    'easy', '4E', $cc3$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc3$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar3A$confusing-which-particle-is-lightest$ar3A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar3B$conflating-charge-with-mass$ar3B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar3D$misassigning-electron-mass-ratio-to-neutron$ar3D$ FROM q;

-- Q4 [Subatomic Particles · medium · Skill 1 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s4$Subatomic Particles$s4$,
    $qt4$A neutral atom of an unknown isotope contains 16 neutrons and a total of 15 electrons distributed across its orbitals. Which species does this atom most likely represent?$qt4$,
    $op4$[{"label": "A", "text": "A neutral atom of sulfur, \\(\\text{S}\\)"}, {"label": "B", "text": "An isotope of silicon, \\(^{31}\\text{Si}\\)"}, {"label": "C", "text": "A neutral atom of phosphorus, \\(\\text{P}\\)"}, {"label": "D", "text": "A sulfide ion, \\(\\text{S}^{2-}\\)"}]$op4$::jsonb,
    'C',
    $ex4$This item tests element identity from subatomic particle counts. In a neutral atom the number of protons equals the number of electrons, so 15 electrons fix \\(Z = 15\\); the element with \\(Z = 15\\) is phosphorus, and the mass number is \\(15 + 16 = 31\\), giving \\(^{31}\\text{P}\\). The atomic number, not the neutron count or mass number, is the sole determinant of which element an atom is. (Choice A) Sulfur has \\(Z = 16\\), requiring 16 protons and thus 16 electrons in the neutral state; the 16 neutrons are matched to proton count rather than being used to read off identity, since neutron number defines the isotope, not the element. (Choice B) Silicon has \\(Z = 14\\); the mass number 31 coincidentally matches \\(15 + 16\\), but pairing that mass number with the wrong proton count assigns an element whose 14 protons cannot host 15 electrons in a neutral atom. (Choice D) Adding two electrons to reach a closed-shell count of 16 invokes the sulfide configuration, but a species with 15 protons carrying a \\(2-\\) charge would have 17 electrons, and a neutral 15-electron atom cannot be an anion of a different element. Skill 1: this question requires identifying and recalling that atomic number determines elemental identity.$ex4$,
    'medium', '4E', $cc4$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc4$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar4A$neutron-count-read-as-atomic-number$ar4A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar4B$mass-number-matched-to-wrong-element$ar4B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar4D$electron-config-overrides-proton-identity$ar4D$ FROM q;

-- Q5 [Subatomic Particles · medium · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s5$Subatomic Particles$s5$,
    $qt5$A monatomic species has a mass number of \(A = 34\), contains 18 neutrons, and carries 18 electrons. Which identity is consistent with these counts?$qt5$,
    $op5$[{"label": "A", "text": "Argon, \\(\\text{Ar}\\), neutral"}, {"label": "B", "text": "Sulfur cation, \\(\\text{S}^{2+}\\)"}, {"label": "C", "text": "Argon cation, \\(\\text{Ar}^{2+}\\)"}, {"label": "D", "text": "Sulfide ion, \\(\\text{S}^{2-}\\)"}]$op5$::jsonb,
    'D',
    $ex5$This is an atomic-structure identification problem requiring the atomic number to fix the element and the proton-electron difference to fix the charge. The atomic number is set by the protons, which equal \(Z = A - N = 34 - 18 = 16\); an element with \(Z = 16\) is sulfur, regardless of how many electrons it carries. The charge is the proton count minus the electron count: \(16 - 18 = -2\). A species of sulfur with a \(2-\) charge is the sulfide ion \(\text{S}^{2-}\), so D is consistent with all three counts. (Choice A) Treating the 18 electrons as the atomic number points to argon (\(Z = 18\)), but the electron count does not define the element; the proton count \(A - N = 16\) does, so the species is sulfur, not neutral argon. (Choice B) The element is correctly identified as sulfur, but the charge sign is inverted: with more electrons (18) than protons (16) the net charge is negative, giving \(2-\), not \(2+\). (Choice C) This combines the misidentification of the element as argon with a charge derived as if the proton count were 20; both the element and the charge are inconsistent with \(Z = A - N = 16\) and charge \(= 16 - 18 = -2\). Skill 1$ex5$,
    'medium', '4E', $cc5$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc5$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar5A$Equates electron count with atomic number, identifying the element from E (18 → argon) instead of from Z = A - N, and assumes neutrality$ar5A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar5B$Correct element but inverts the charge sign by computing E - Z instead of Z - E, turning the anion into a cation$ar5B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar5C$Carries the electron-count-as-element error forward (argon) and assigns a charge inconsistent with the actual proton count$ar5C$ FROM q;

-- Q6 [Subatomic Particles · medium · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s6$Subatomic Particles$s6$,
    $qt6$A monatomic ion contains 16 protons, 16 neutrons, and 18 electrons. The charge on this ion is most likely$qt6$,
    $op6$[{"label": "A", "text": "\\(+2\\)"}, {"label": "B", "text": "\\(-2\\)"}, {"label": "C", "text": "\\(-1\\)"}, {"label": "D", "text": "\\(0\\)"}]$op6$::jsonb,
    'B',
    $ex6$This item addresses ionic charge as the net imbalance between nuclear protons and orbital electrons. Net charge equals (number of protons) minus (number of electrons): \(16 - 18 = -2\). The 18 electrons exceed the 16 protons by two, so the species carries two units of excess negative charge, consistent with \(\text{S}^{2-}\); neutrons are uncharged and do not enter the calculation. (Choice A) Reversing the subtraction to electrons minus protons, \(18 - 16\), yields \(+2\) and assigns the wrong sign, treating an electron surplus as though it produced a positive species. (Choice C) Counting only the difference between electrons and the combined non-electron count or otherwise tallying a single excess particle gives a magnitude of one, understating the two-electron surplus that sets the charge magnitude. (Choice D) Including the 16 neutrons so that protons plus neutrons (32) are balanced against electrons, or assuming any complete atom is neutral, ignores that neutrons carry no charge and that proton and electron counts are unequal here. Skill 2 tested: applying the proton-minus-electron relationship to determine ionic charge from particle counts.$ex6$,
    'medium', '4E', $cc6$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc6$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar6A$electrons-minus-protons sign flip$ar6A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $ar6C$single-unit charge magnitude error$ar6C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar6D$neutron-inclusive neutrality$ar6D$ FROM q;

-- Q7 [Subatomic Particles · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s7$Subatomic Particles$s7$,
    $qt7$A technician monitoring a sample notes that one neutral atom of an element simultaneously captures a free neutron into its nucleus and ejects one of its electrons. Tracking the atom before and after this combined event, what happens to its mass number, its net charge, and its identity as an element?$qt7$,
    $op7$[{"label": "A", "text": "Mass number stays the same, net charge becomes \\(+1\\), and the element changes."}, {"label": "B", "text": "Mass number increases by \\(1\\), net charge becomes \\(-1\\), and the element stays the same."}, {"label": "C", "text": "Mass number increases by \\(1\\), net charge stays at \\(0\\), and the element changes."}, {"label": "D", "text": "Mass number increases by \\(1\\), net charge becomes \\(+1\\), and the element stays the same."}]$op7$::jsonb,
    'D',
    $ex7$This question tests the independence of proton, neutron, and electron counts in defining mass number, net charge, and element identity. Mass number \\(A\\) is the sum of protons and neutrons, so capturing one neutron raises \\(A\\) by \\(1\\); it does not depend on electrons. Net charge is set by the difference between protons and electrons, so losing one electron from a neutral atom (equal counts) leaves protons exceeding electrons by one, giving a charge of \\(+1\\). Element identity is fixed solely by the atomic number \\(Z\\) (proton count), and neither a neutron capture nor an electron loss alters \\(Z\\), so the element is unchanged. The result is mass number \\(+1\\), net charge \\(+1\\), element unchanged. (Choice A) A neutron capture adds to the nucleon total, so the mass number must rise by \\(1\\) rather than remain constant; additionally, neither event changes the proton count, so the element cannot change. (Choice B) Removing an electron from a neutral atom leaves one more proton than electron, producing a \\(+1\\) charge, not \\(-1\\); a \\(-1\\) charge would require gaining an electron. (Choice C) Net charge cannot remain \\(0\\) once an electron is lost without a compensating proton change, and element identity is tied to \\(Z\\), which the neutron and electron events leave untouched, so the element does not change. Skill 2$ex7$,
    'medium', '4E', $cc7$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc7$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar7A$Treats neutron capture as not affecting mass number while wrongly attaching element change to the charge shift$ar7A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar7B$Reverses the sign of charge change, assigning electron loss a negative net charge$ar7B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar7C$Believes adding a neutron changes the element identity and that simultaneous electron loss can leave net charge neutral$ar7C$ FROM q;

-- Q8 [Subatomic Particles · hard · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s8$Subatomic Particles$s8$,
    $qt8$A salt contains the cation \(^{52}_{24}\text{Cr}^{3+}\). For a single such cation, the number of electrons present is most likely$qt8$,
    $op8$[{"label": "A", "text": "\\(21\\)"}, {"label": "B", "text": "\\(27\\)"}, {"label": "C", "text": "\\(24\\)"}, {"label": "D", "text": "\\(28\\)"}]$op8$::jsonb,
    'A',
    $ex8$This item tests electron counting for a charged species from a complete isotope symbol (atomic structure / subatomic particles). The subscript is the atomic number, \(Z=24\), fixing the proton count at 24 for any chromium species; the superscript \(3+\) indicates a net positive charge produced by removing 3 electrons from the neutral atom, so electrons \(=Z-\text{charge}=24-3=21\). The mass number 52 specifies nucleons (protons plus neutrons) and does not enter the electron count. (Choice B) The value 27 arises from adding the charge magnitude to \(Z\) (\(24+3\)); adding electrons would describe an anion, whereas a \(3+\) charge corresponds to a deficit of electrons relative to protons. (Choice C) The value 24 is the electron count of the neutral chromium atom, where electrons equal protons; it ignores that the net \(3+\) charge requires three fewer electrons than protons. (Choice D) The value 28 is the neutron count obtained from \(A-Z=52-24\); neutrons are uncharged nuclear particles and are unrelated to the electron count of an ion. Skill 2: this requires applying the symbol-to-count relationships (Z = protons, A − Z = neutrons, electrons = Z − charge) to a specific charged isotope rather than recalling a definition.$ex8$,
    'hard', '4E', $cc8$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc8$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $ar8B$added charge instead of subtracting (cation treated as anion)$ar8B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar8C$neutral-atom electron count (ignored ionic charge)$ar8C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar8D$reported neutron count (A − Z) instead of electron count$ar8D$ FROM q;

-- Q9 [Subatomic Particles · hard · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s9$Subatomic Particles$s9$,
    $qt9$A researcher characterizing a series of monatomic cations needs one whose electron configuration matches that of argon. Among the candidate ions below, which one carries exactly 18 electrons?$qt9$,
    $op9$[{"label": "A", "text": "\\(\\text{Ca}^{2+}\\)"}, {"label": "B", "text": "\\(\\text{K}^{2+}\\)"}, {"label": "C", "text": "\\(\\text{Mg}^{2+}\\)"}, {"label": "D", "text": "\\(\\text{Sc}^{2+}\\)"}]$op9$::jsonb,
    'A',
    $ex9$This question concerns subatomic particle counting, specifically determining an ion's electron count from atomic number and charge. For any monatomic ion, the number of electrons equals the atomic number \(Z\) minus the net charge. To be isoelectronic with argon, the ion must hold 18 electrons. Calcium has \(Z = 20\), so \(\text{Ca}^{2+}\) holds \(20 - 2 = 18\) electrons, matching argon exactly. (Choice B) Potassium has \(Z = 19\), so \(\text{K}^{2+}\) holds \(19 - 2 = 17\) electrons, one short of argon. (Choice C) Magnesium has \(Z = 12\), so \(\text{Mg}^{2+}\) holds \(12 - 2 = 10\) electrons; this ion is isoelectronic with neon, a different noble gas, not argon. (Choice D) Scandium has \(Z = 21\), so \(\text{Sc}^{2+}\) holds \(21 - 2 = 19\) electrons, one more than argon. Skill 1$ex9$,
    'hard', '4E', $cc9$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc9$, 'general-chemistry', 1, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $ar9B$Treats any +2 cation of a near-argon element as automatically reaching 18 electrons without tracking the specific atomic number$ar9B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar9C$Correctly identifies an ion isoelectronic with a noble gas but with the wrong noble gas (neon instead of argon)$ar9C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar9D$Off-by-one electron count from a transition-metal cation near the target atomic number$ar9D$ FROM q;

-- Q10 [Isotopes & Atomic Weight · easy · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s10$Isotopes & Atomic Weight$s10$,
    $qt10$A sample of elemental tin contains a nuclide written as \(^{118}_{50}\text{Sn}\). A second nuclide in the same sample is most likely an isotope of this one if it is denoted by which symbol?$qt10$,
    $op10$[{"label": "A", "text": "\\(^{118}_{52}\\text{Te}\\)"}, {"label": "B", "text": "\\(^{120}_{50}\\text{Sn}\\)"}, {"label": "C", "text": "\\(^{118}_{50}\\text{Sn}^{2+}\\)"}, {"label": "D", "text": "\\(^{116}_{48}\\text{Cd}\\)"}]$op10$::jsonb,
    'B',
    $ex10$This item targets the definition of isotopes within atomic structure. Isotopes are nuclides of the same element, meaning they share an identical atomic number \(Z\) (identical proton count) but differ in neutron number, which makes their mass numbers \(A\) differ. The reference nuclide \(^{118}_{50}\text{Sn}\) has \(Z=50\) and 68 neutrons. The nuclide \(^{120}_{50}\text{Sn}\) also has \(Z=50\), keeping it the same element (tin), but carries \(A=120\), giving 70 neutrons; the matching \(Z\) with a different \(A\) and neutron count is exactly the isotope relationship. (Choice A) \(^{118}_{52}\text{Te}\) shares the mass number \(A=118\) but has \(Z=52\), so it is a different element with a different proton count; equal mass number with different \(Z\) defines isobars, not isotopes. (Choice C) \(^{118}_{50}\text{Sn}^{2+}\) has the identical \(Z=50\) and identical \(A=118\), so it is the same nuclide differing only in electron count; a change in charge produces an ion, leaving neutron number and nuclide identity unchanged. (Choice D) \(^{116}_{48}\text{Cd}\) differs in both \(Z=48\) and \(A=116\), making it a separate element entirely rather than a tin nuclide of differing mass. Skill 1: this question assesses recall and recognition of the foundational definition distinguishing isotopes from isobars and ions.$ex10$,
    'easy', '4E', $cc10$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc10$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar10A$isobar-mistaken-for-isotope (same mass number A, different Z)$ar10A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar10C$ion-mistaken-for-isotope (charge change, same Z and A)$ar10C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar10D$different-element-with-similar-mass (both Z and A altered)$ar10D$ FROM q;

-- Q11 [Isotopes & Atomic Weight · medium · Skill 1 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s11$Isotopes & Atomic Weight$s11$,
    $qt11$A sample of the isotope \(^{58}_{26}\text{Fe}\) is fully ionized to \(\text{Fe}^{3+}\). How many neutrons does each ion in the sample contain?$qt11$,
    $op11$[{"label": "A", "text": "\\(26\\)"}, {"label": "B", "text": "\\(29\\)"}, {"label": "C", "text": "\\(58\\)"}, {"label": "D", "text": "\\(32\\)"}]$op11$::jsonb,
    'D',
    $ex11$This item concerns isotope notation and the relationship among mass number, atomic number, and subatomic particle counts. In the notation \(^{A}_{Z}\text{X}\), the atomic number \(Z = 26\) fixes the proton count, and the mass number \(A = 58\) counts protons plus neutrons; the neutron count is therefore \(A - Z = 58 - 26 = 32\). Ionization to \(\text{Fe}^{3+}\) removes electrons only, leaving both the nucleus and its neutron count unchanged, so the answer remains \(32\). (Choice A) The value \(26\) is the atomic number \(Z\), which counts protons rather than neutrons; it equals the neutron count only by coincidence in light nuclei where \(A \approx 2Z\), not here. (Choice B) The value \(29\) results from subtracting the \(3+\) charge from the correct neutron count (\(32 - 3\)); ionic charge reflects a deficit of electrons and has no bearing on the number of neutrons in the nucleus. (Choice C) The value \(58\) is the mass number \(A\), the total of protons and neutrons, not the neutrons alone. Skill 1: This question requires recalling the definitions encoded in isotope notation and applying \(N = A - Z\) to identify the neutron count.$ex11$,
    'medium', '4E', $cc11$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc11$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar11A$atomic-number-reported-as-neutron-count$ar11A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar11B$ionic-charge-subtracted-from-nucleon-count$ar11B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar11C$mass-number-mistaken-for-neutron-count$ar11C$ FROM q;

-- Q12 [Isotopes & Atomic Weight · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s12$Isotopes & Atomic Weight$s12$,
    $qt12$A nuclide is written as \(^{56}_{26}\text{Fe}\). The number of neutrons in this nucleus is best given by which calculation?$qt12$,
    $op12$[{"label": "A", "text": "\\(56 - 26 = 30\\)"}, {"label": "B", "text": "\\(56 + 26 = 82\\)"}, {"label": "C", "text": "\\(56 - 26 = 30\\), then \\(30 - 26 = 4\\)"}, {"label": "D", "text": "\\(26 - 0 = 26\\)"}]$op12$::jsonb,
    'A',
    $ex12$This item concerns isotope notation, where the left superscript is the mass number \(A\) and the left subscript is the atomic number \(Z\). For \(^{56}_{26}\text{Fe}\), \(A = 56\) counts protons plus neutrons and \(Z = 26\) counts protons, so the neutron count is \(A - Z = 56 - 26 = 30\). (Choice B) Adding \(A\) and \(Z\) double-counts the protons and has no physical meaning, since the mass number already contains the proton contribution. (Choice C) Subtracting \(Z\) a second time removes the protons twice and treats the intermediate value \(30\) as if it were another mass number rather than the neutron total. (Choice D) Using \(Z\) alone returns the proton count, which equals the electron count in a neutral atom but not the neutron count. Skill 1: This question tests recall and identification of the symbols in standard nuclide notation.$ex12$,
    'easy', '4E', $cc12$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc12$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar12B$adds mass number and atomic number instead of subtracting$ar12B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar12C$subtracts atomic number twice from mass number$ar12C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar12D$reports proton (atomic) number as the neutron count$ar12D$ FROM q;

-- Q13 [Isotopes & Atomic Weight · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s13$Isotopes & Atomic Weight$s13$,
    $qt13$A sample of magnesium contains both \(^{24}\text{Mg}\) and \(^{26}\text{Mg}\). Treated with the same reagent under identical conditions, the two isotopes react at indistinguishable rates and form products with the same chemical formula. This shared reactivity is best explained by the fact that the two nuclides have the same$qt13$,
    $op13$[{"label": "A", "text": "number of neutrons in the nucleus"}, {"label": "B", "text": "mass number \\(A\\)"}, {"label": "C", "text": "ground-state electron configuration"}, {"label": "D", "text": "binding energy per nucleon"}]$op13$::jsonb,
    'C',
    $ex13$This item addresses isotopes and atomic weight, specifically why isotopes of one element exhibit identical chemical behavior. Chemical reactivity is governed by the valence electrons, and the number of electrons in a neutral atom equals the atomic number \(Z\). Because \(^{24}\text{Mg}\) and \(^{26}\text{Mg}\) share \(Z = 12\), both have the neutral ground-state configuration \([\text{Ne}]3s^2\); identical valence electrons produce the same bonding and the same reaction rate and product formula. (Choice A) The two nuclides differ in neutron count, 12 versus 14, so neutron number is not shared and cannot account for matched chemistry; neutrons are nuclear and do not participate in bonding. (Choice B) Mass number \(A\) is the sum of protons and neutrons and differs between the nuclides, 24 versus 26, so it is not a shared property and does not control chemical behavior. (Choice D) Binding energy per nucleon is a nuclear quantity that varies between isotopes and governs nuclear stability, not electron-mediated chemical reactivity. Skill 2: relating shared atomic number and electron configuration to identical chemical properties across isotopes.$ex13$,
    'medium', '4E', $cc13$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc13$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar13A$neutron-count-drives-chemistry$ar13A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $ar13B$mass-number-as-shared-property$ar13B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar13D$nuclear-property-for-chemical-behavior$ar13D$ FROM q;

-- Q14 [Isotopes & Atomic Weight · hard · Skill 3 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s14$Isotopes & Atomic Weight$s14$,
    $qt14$A magnetic-sector mass spectrometer accelerates singly charged ions through a fixed potential difference \(V\) before they enter a uniform magnetic field, where each ion travels a semicircular path of radius \(r = \frac{1}{B}\sqrt{\frac{2Vm}{q}}\) toward a detector fixed at one radial position. An analyst running a sample of elemental tin needs the heaviest isotope, \(^{124}\text{Sn}^{+}\), to strike the detector instead of the lighter \(^{116}\text{Sn}^{+}\) currently in focus. Holding \(V\) and the detector geometry constant, the analyst is most likely to bring \(^{124}\text{Sn}^{+}\) into focus by$qt14$,
    $op14$[{"label": "A", "text": "lowering \\(B\\), because a weaker field lengthens the radius and the more massive ion needs the longer path to reach the fixed detector."}, {"label": "B", "text": "lowering \\(B\\), because reducing the field reduces the magnetic force, allowing the heavier ion to deflect onto the detector radius."}, {"label": "C", "text": "raising \\(V\\), because a larger accelerating potential delivers more kinetic energy to the heavier ion and steers it to the fixed radius."}, {"label": "D", "text": "raising \\(B\\), because at fixed \\(V\\) and \\(r\\) the focused mass scales as \\(m \\propto B^2\\), so a stronger field is required to focus the larger \\(m/q\\)."}]$op14$::jsonb,
    'D',
    $ex14$This item addresses mass-spectrometry experimental design: how the magnetic field, accelerating voltage, and detector geometry jointly select ions by mass-to-charge ratio. Solving \(r = \frac{1}{B}\sqrt{\frac{2Vm}{q}}\) for the focused mass gives \(\frac{m}{q} = \frac{B^2 r^2}{2V}\). With \(V\), \(r\), and \(q\) all held fixed, the mass that reaches the detector is proportional to \(B^2\), so focusing the heavier \(^{124}\text{Sn}^{+}\) in place of \(^{116}\text{Sn}^{+}\) requires increasing \(B\) by a factor of \(\sqrt{124/116}\). (Choice A) The radius relation shows \(r \propto 1/B\) only when mass is held constant; lowering \(B\) shifts focus toward lighter, not heavier, ions because the focused mass falls as \(B^2\), directing the lighter \(^{116}\text{Sn}^{+}\) further off-axis rather than capturing \(^{124}\text{Sn}^{+}\). (Choice B) Reducing the magnetic force does enlarge the orbit for a given ion, but the comparison across isotopes is governed by \(m/q \propto B^2\) at fixed \(r\); a weaker field selects a smaller focused mass, the opposite of the requirement. (Choice C) Raising \(V\) increases ion kinetic energy and, at fixed \(B\) and \(r\), lowers the focused mass since \(m/q \propto 1/V\); a larger accelerating potential therefore drives focus toward lighter ions, leaving \(^{124}\text{Sn}^{+}\) overshooting the fixed detector radius. This question targets Skill 3 (reasoning about experimental design and the quantitative relationships among instrument parameters and measured outcomes).$ex14$,
    'hard', '4E', $cc14$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc14$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $ar14A$inverted B-versus-mass focusing direction$ar14A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $ar14B$weaker-force-favors-heavier-ion fallacy$ar14B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar14C$voltage-mass focusing confounded with field$ar14C$ FROM q;

-- Q15 [Isotopes & Atomic Weight · easy · Skill 1 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s15$Isotopes & Atomic Weight$s15$,
    $qt15$Chlorine exists as two stable isotopes, \(^{35}\text{Cl}\) and \(^{37}\text{Cl}\), yet the periodic table lists chlorine's value as \(35.45\). Which quantity does \(35.45\) most directly represent?$qt15$,
    $op15$[{"label": "A", "text": "The mass of a single \\(^{35}\\text{Cl}\\) atom, the more abundant isotope"}, {"label": "B", "text": "The abundance-weighted average mass of all naturally occurring chlorine isotopes"}, {"label": "C", "text": "The total number of protons and neutrons in a \\(^{37}\\text{Cl}\\) nucleus"}, {"label": "D", "text": "The simple arithmetic mean of the masses of \\(^{35}\\text{Cl}\\) and \\(^{37}\\text{Cl}\\)"}]$op15$::jsonb,
    'B',
    $ex15$This question addresses isotopes and atomic weight, specifically the distinction between the atomic mass of an individual isotope and the atomic weight reported on the periodic table. The tabulated value \(35.45\) is chlorine's atomic weight: the average of all isotope masses weighted by each isotope's natural fractional abundance. Because \(^{35}\text{Cl}\) (mass \(\approx 35\)) is roughly three times more abundant than \(^{37}\text{Cl}\) (mass \(\approx 37\)), the weighted average sits much closer to \(35\) than to \(36\), giving \(35.45\). (Choice A) The mass of one \(^{35}\text{Cl}\) atom is an atomic mass of a single nuclide, approximately \(34.97\ \text{u}\); a periodic-table entry is not the mass of any one isotope but a population average. (Choice C) The count of protons plus neutrons in \(^{37}\text{Cl}\) is the integer mass number \(37\), a nucleon count for one nuclide, not a decimal averaged mass with units of \(\text{u}\). (Choice D) The unweighted arithmetic mean of \(35\) and \(37\) is \(36\); the actual value of \(35.45\) requires weighting by abundance rather than treating both isotopes as equally common. Skill 1: this item tests recall and identification of the definition of atomic weight versus atomic mass.$ex15$,
    'easy', '4E', $cc15$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc15$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar15A$atomic-weight-equals-most-abundant-isotope-mass$ar15A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar15C$mass-number-nucleon-count-confusion$ar15C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar15D$unweighted-mean-ignoring-abundance$ar15D$ FROM q;

-- Q16 [Isotopes & Atomic Weight · medium · Skill 4 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s16$Isotopes & Atomic Weight$s16$,
    $qt16$A mass spectrum of elemental magnesium shows three peaks: one at \(m/z = 24\) rising to a relative intensity of \(79\%\), one at \(m/z = 25\) reaching \(10\%\), and one at \(m/z = 26\) reaching \(11\%\). Singly charged ions dominate the spectrum. Which isotope is most likely present in the greatest amount in the sample?$qt16$,
    $op16$[{"label": "A", "text": "\\(^{26}\\text{Mg}\\), because its peak sits at the highest \\(m/z\\) value"}, {"label": "B", "text": "\\(^{25}\\text{Mg}\\), because its \\(m/z\\) lies closest to the standard atomic weight of \\(24.3\\)"}, {"label": "C", "text": "\\(^{24}\\text{Mg}\\), because its peak has the greatest relative intensity"}, {"label": "D", "text": "\\(^{26}\\text{Mg}\\), because its intensity slightly exceeds that of the \\(^{25}\\text{Mg}\\) peak"}]$op16$::jsonb,
    'C',
    $ex16$This item concerns isotopes and the interpretation of a mass spectrum, where relative peak intensity is proportional to the fractional abundance of each isotope. In a mass spectrum of singly charged ions, each peak's \(m/z\) gives the isotopic mass and its height (relative intensity) gives that isotope's natural abundance. The peak at \(m/z = 24\) reaches \(79\%\), far exceeding the \(10\%\) and \(11\%\) peaks, so \(^{24}\text{Mg}\) is present in the greatest amount. (Choice A) Position along the \(m/z\) axis encodes isotopic mass, not abundance; the highest \(m/z\) peak corresponds only to the heaviest isotope, which here is one of the two minor species. (Choice B) The standard atomic weight of \(24.3\) is the abundance-weighted average mass and is pulled close to \(24\) precisely because \(^{24}\text{Mg}\) dominates; proximity of an isotope's mass to the average does not by itself indicate abundance, and the average lies nearest \(m/z = 24\), not \(25\). (Choice D) Although the \(m/z = 26\) peak (\(11\%\)) is marginally taller than the \(m/z = 25\) peak (\(10\%\)), both are minor relative to the \(79\%\) peak at \(m/z = 24\), so neither minor isotope is the most abundant. This question targets Skill 4: analyzing data from a mass spectrum to draw a quantitative conclusion about isotopic composition.$ex16$,
    'medium', '4E', $cc16$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc16$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar16A$mass-axis-position-mistaken-for-abundance$ar16A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar16B$average-atomic-weight-proximity-as-abundance-proxy$ar16B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $ar16D$comparing-only-the-two-minor-peaks$ar16D$ FROM q;

-- Q17 [Isotopes & Atomic Weight · medium · Skill 4 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s17$Isotopes & Atomic Weight$s17$,
    $qt17$A technician runs a sample of elemental copper through a mass spectrometer and records two peaks: one at \(m/z = 63\) with a relative abundance of about 69%, and one at \(m/z = 65\) with a relative abundance of about 31%. The technician needs to report the number of neutrons present in the isotope responsible for the taller peak. Given that copper has \(Z = 29\), how many neutrons does that isotope contain?$qt17$,
    $op17$[{"label": "A", "text": "34 neutrons"}, {"label": "B", "text": "36 neutrons"}, {"label": "C", "text": "29 neutrons"}, {"label": "D", "text": "35 neutrons"}]$op17$::jsonb,
    'A',
    $ex17$This is a data-interpretation item: read the spectrum to identify the dominant isotope, then convert its mass number to a neutron count. The taller peak sits at \(m/z = 63\) with ~69% abundance, so the most abundant isotope is \(^{63}\text{Cu}\). Neutron number equals mass number minus atomic number: \(N = A - Z = 63 - 29 = 34\). (Choice B) 36 comes from reading the wrong peak: it uses the minor \(^{65}\text{Cu}\) isotope (\(65 - 29 = 36\)) rather than the tallest peak, which corresponds to the lower-abundance species at ~31%. (Choice C) 29 reports the atomic number \(Z\) (the proton count) instead of carrying out the \(A - Z\) subtraction to obtain neutrons. (Choice D) 35 results from subtracting \(Z\) from a weighted-average mass: \(63.5 - 29 \approx 35\) after rounding, but the question asks for neutrons in a specific isotope, which must use a whole-number mass number, not the averaged atomic weight. Skill 4$ex17$,
    'medium', '4E', $cc17$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc17$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $ar17B$Selects the minor (shorter) peak instead of the tallest peak, then correctly computes A-Z for the wrong isotope$ar17B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $ar17C$Reports the atomic number/proton count as the neutron count, skipping the A-Z subtraction$ar17C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar17D$Uses the weighted-average atomic weight (~63.5) rather than an integer mass number, treating the average as if it were a single isotope's mass$ar17D$ FROM q;

-- Q18 [Isotopes & Atomic Weight · hard · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s18$Isotopes & Atomic Weight$s18$,
    $qt18$A newly characterized element exists as three stable isotopes with masses \(62.93\ \text{u}\), \(64.93\ \text{u}\), and \(66.93\ \text{u}\), present at \(50.00\%\), \(30.00\%\), and \(20.00\%\) natural abundance, respectively. The standard atomic weight reported for this element is most nearly$qt18$,
    $op18$[{"label": "A", "text": "\\(64.93\\ \\text{u}\\)"}, {"label": "B", "text": "\\(65.13\\ \\text{u}\\)"}, {"label": "C", "text": "\\(65.53\\ \\text{u}\\)"}, {"label": "D", "text": "\\(64.33\\ \\text{u}\\)"}]$op18$::jsonb,
    'D',
    $ex18$This item targets the abundance-weighted average that defines standard atomic weight. The atomic weight is the sum of each isotope mass multiplied by its fractional abundance: \((62.93)(0.5000) + (64.93)(0.3000) + (66.93)(0.2000) = 31.465 + 19.479 + 13.386 = 64.33\ \text{u}\). Because the lightest isotope dominates at \(50.00\%\), the weighted value lies below the midpoint mass \(64.93\ \text{u}\), so option D is correct. (Choice A) \(64.93\ \text{u}\) is the simple arithmetic mean of the three masses, \((62.93+64.93+66.93)/3\); this equal-weighting ignores that the isotopes are not equally abundant and overweights the heavier isotopes relative to their true contribution. (Choice B) \(65.13\ \text{u}\) results from pairing the masses with abundances applied in the wrong order for the two outer isotopes while still summing to \(100\%\), shifting the average upward by attributing too much weight to the \(66.93\ \text{u}\) isotope. (Choice C) \(65.53\ \text{u}\) comes from fully reversing the abundance assignments—giving the heaviest isotope \(50.00\%\) and the lightest \(20.00\%\)—which inverts the true mass distribution and pushes the value above the central isotope mass. Skill 2: this question requires executing a multi-term weighted-average computation and recognizing how abundance distribution positions the result relative to the isotope masses.$ex18$,
    'hard', '4E', $cc18$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc18$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar18A$arithmetic-mean-ignoring-abundance$ar18A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $ar18B$partial-abundance-mismatch$ar18B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar18C$fully-inverted-abundance-mass-pairing$ar18C$ FROM q;

-- Q19 [Isotopes & Atomic Weight · medium · Skill 4 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s19$Isotopes & Atomic Weight$s19$,
    $qt19$A mass spectrum of a pure sample of element X resolves only two peaks. The peak at \(84.91\ \text{amu}\) accounts for \(72.2\%\) of the detected ions, and the peak at \(86.91\ \text{amu}\) accounts for the remaining \(27.8\%\). Based on these data, the standard atomic weight of X is most nearly$qt19$,
    $op19$[{"label": "A", "text": "\\(85.91\\ \\text{amu}\\)"}, {"label": "B", "text": "\\(85.47\\ \\text{amu}\\)"}, {"label": "C", "text": "\\(86.35\\ \\text{amu}\\)"}, {"label": "D", "text": "\\(84.91\\ \\text{amu}\\)"}]$op19$::jsonb,
    'B',
    $ex19$This item tests isotopes and atomic weight, specifically computing a weighted average from mass-spectrum abundance data. The atomic weight is the sum of each isotopic mass scaled by its fractional abundance: \((84.91)(0.722) + (86.91)(0.278) = 61.31 + 24.16 = 85.47\ \text{amu}\). Because the lighter isotope dominates the sample, the weighted result lies closer to \(84.91\) than to \(86.91\), landing at \(85.47\). (Choice A) \(85.91\ \text{amu}\) is the unweighted arithmetic mean \((84.91 + 86.91)/2\), which treats both isotopes as equally abundant and ignores the \(72.2\%\)-to-\(27.8\%\) ratio supplied by the spectrum. (Choice C) \(86.35\ \text{amu}\) results from pairing each abundance with the wrong isotope, \((84.91)(0.278) + (86.91)(0.722)\); assigning the larger fractional abundance to the heavier isotope shifts the average above the midpoint instead of below it. (Choice D) \(84.91\ \text{amu}\) is simply the mass of the most abundant isotope; reporting the dominant peak alone discards the contribution of the second isotope, which must still raise the average. Skill 4: this question requires quantitative reasoning to extract abundance values from tabular data and execute a weighted-average calculation.$ex19$,
    'medium', '4E', $cc19$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc19$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $ar19A$unweighted-arithmetic-mean-of-isotope-masses$ar19A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $ar19C$abundance-isotope-pairing-swap$ar19C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $ar19D$most-abundant-isotope-mass-as-atomic-weight$ar19D$ FROM q;

-- Q20 [Isotopes & Atomic Weight · hard · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s20$Isotopes & Atomic Weight$s20$,
    $qt20$A mass spectrometry technician is calibrating an instrument using a sample enriched in the chloride anion \(^{37}_{17}\text{Cl}^-\), and needs to log the subatomic composition of this exact species on the data sheet. For this single ion as written, how many neutrons and how many electrons must be recorded?$qt20$,
    $op20$[{"label": "A", "text": "17 neutrons and 18 electrons"}, {"label": "B", "text": "20 neutrons and 17 electrons"}, {"label": "C", "text": "20 neutrons and 18 electrons"}, {"label": "D", "text": "20 neutrons and 16 electrons"}]$op20$::jsonb,
    'C',
    $ex20$This is a nuclide-notation problem applied to an ion: read the mass number (A), atomic number (Z), and charge directly from the symbol, then compute particle counts. For \(^{37}_{17}\text{Cl}^-\), \(A = 37\) and \(Z = 17\). Neutrons = \(A - Z = 37 - 17 = 20\). Electrons in a monoatomic ion = \(Z - (\text{charge}) = 17 - (-1) = 18\), since a \(1-\) charge means one electron has been gained beyond the 17 protons. So the species has 20 neutrons and 18 electrons, matching Choice C. (Choice A) Reports 17 neutrons by subtracting nothing meaningful and instead carrying the proton count (Z = 17) into the neutron slot; neutrons must be \(A - Z = 20\), not \(Z\). The electron count of 18 is correct here, but the neutron value is wrong. (Choice B) Gives 20 neutrons correctly but lists 17 electrons, the value for a neutral chlorine atom; it ignores the \(1-\) charge, which requires adding one electron to give \(17 + 1 = 18\). (Choice D) Computes electrons as \(Z - 1 = 16\) by subtracting an electron, the operation appropriate for a cation; an anion with charge \(-1\) has gained an electron, so electrons = \(17 - (-1) = 18\), not 16. The neutron count of 20 is correct. Skill 2$ex20$,
    'hard', '4E', $cc20$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc20$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar20A$Uses Z as the neutron count instead of computing A - Z$ar20A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar20B$Correct neutrons but treats the ion as a neutral atom for electrons$ar20B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar20D$Subtracts an electron for a negative charge, treating the anion like a cation$ar20D$ FROM q;

-- Q21 [The Mole & Avogadro · easy · Skill 1 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s21$The Mole & Avogadro$s21$,
    $qt21$A sealed vial holds exactly \(1\ \text{mol}\) of neon gas at standard conditions. The quantity \(6.022 \times 10^{23}\) for this sample most directly specifies the number of which entities?$qt21$,
    $op21$[{"label": "A", "text": "Neon atoms"}, {"label": "B", "text": "Grams of neon"}, {"label": "C", "text": "Protons in the sample"}, {"label": "D", "text": "Neon molecules"}]$op21$::jsonb,
    'A',
    $ex21$This item addresses the mole concept and the operational meaning of Avogadro's number. By definition, one mole of any substance contains \(6.022 \times 10^{23}\) elementary entities of whatever species the substance is composed of; for elemental neon, a monatomic noble gas, those entities are individual neon atoms, so the count specifies neon atoms. (Choice B) Avogadro's number is a pure count of entities, not a mass; the mass of one mole of neon is its molar mass of roughly \(20.2\ \text{g}\), a value distinct from \(6.022 \times 10^{23}\) and carrying units of grams rather than a dimensionless tally. (Choice C) Each neon atom contains \(10\) protons, so the proton count in one mole is about \(10 \times 6.022 \times 10^{23}\); Avogadro's number alone counts the atoms, not the subatomic particles within them. (Choice D) Neon is monatomic and does not form diatomic or polyatomic molecules under standard conditions, so the entities counted are single atoms, not molecules; equating atoms with molecules holds only for substances whose fundamental units are molecules. This question targets Skill 1 (knowledge of scientific concepts), recalling that one mole equals \(6.022 \times 10^{23}\) of the substance's defining entities.$ex21$,
    'easy', '4E', $cc21$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc21$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'scale_unit_error', $ar21B$conflating mole count with molar mass$ar21B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $ar21C$counting subatomic particles instead of atoms$ar21C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $ar21D$treating monatomic element as molecular$ar21D$ FROM q;

-- Q22 [The Mole & Avogadro · medium · Skill 2 · ans D]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s22$The Mole & Avogadro$s22$,
    $qt22$A reagent vial holds \(0.250\ \text{mol}\) of solid aluminum sulfate, \(\text{Al}_2(\text{SO}_4)_3\). Which value most closely gives the total number of atoms present in the sample?$qt22$,
    $op22$[{"label": "A", "text": "\\(1.51 \\times 10^{23}\\) atoms"}, {"label": "B", "text": "\\(3.01 \\times 10^{23}\\) atoms"}, {"label": "C", "text": "\\(1.81 \\times 10^{24}\\) atoms"}, {"label": "D", "text": "\\(2.56 \\times 10^{24}\\) atoms"}]$op22$::jsonb,
    'D',
    $ex22$This item concerns mole-to-particle conversion using Avogadro's number. One formula unit of \(\text{Al}_2(\text{SO}_4)_3\) contains \(2\) Al \(+\) \(3\) S \(+\) \(12\) O \(=\) \(17\) atoms. The total atom count is the product of moles, atoms per formula unit, and Avogadro's number: \(0.250\ \text{mol} \times 17 \times 6.022 \times 10^{23}\ \text{mol}^{-1} = 2.56 \times 10^{24}\) atoms, matching choice D. (Choice A) The value \(1.51 \times 10^{23}\) results from \(0.250 \times 6.022 \times 10^{23}\) alone, counting formula units rather than constituent atoms and omitting the factor of \(17\) atoms per formula unit. (Choice B) The value \(3.01 \times 10^{23}\) comes from multiplying by only \(2\), the number of aluminum atoms per formula unit, which counts a single element instead of every atom in the compound. (Choice C) The value \(1.81 \times 10^{24}\) comes from multiplying by only the \(12\) oxygen atoms per formula unit, capturing the most numerous element but excluding the aluminum and sulfur contributions. This question requires applying a multi-step unit conversion to a specific quantity (Skill 2).$ex22$,
    'medium', '4E', $cc22$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc22$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar22A$formula-units-counted-as-atoms$ar22A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $ar22B$single-element-atom-count$ar22B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $ar22C$dominant-element-atom-count$ar22C$ FROM q;

-- Q23 [The Mole & Avogadro · medium · Skill 2 · ans B]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s23$The Mole & Avogadro$s23$,
    $qt23$A reaction vessel holds \(19.2\ \text{g}\) of elemental sulfur. The amount of sulfur present, in moles of \(\text{S}\) atoms, is most nearly$qt23$,
    $op23$[{"label": "A", "text": "\\(0.0749\\ \\text{mol}\\)"}, {"label": "B", "text": "\\(0.599\\ \\text{mol}\\)"}, {"label": "C", "text": "\\(1.20\\ \\text{mol}\\)"}, {"label": "D", "text": "\\(615\\ \\text{mol}\\)"}]$op23$::jsonb,
    'B',
    $ex23$This item tests mass-to-mole conversion using molar mass. Moles of an element equal mass divided by molar mass: \(n = \frac{19.2\ \text{g}}{32.06\ \text{g/mol}} = 0.599\ \text{mol}\) of \(\text{S}\) atoms, since the molar mass of atomic sulfur is \(32.06\ \text{g/mol}\). (Choice A) Dividing by \(256.5\ \text{g/mol}\), the molar mass of the \(\text{S}_8\) ring, gives moles of \(\text{S}_8\) molecules rather than moles of \(\text{S}\) atoms; the question asks for atoms, so the per-atom molar mass \(32.06\ \text{g/mol}\) is the correct divisor. (Choice C) Dividing by \(16\), the atomic number \(Z\) of sulfur, uses the wrong quantity; \(Z\) counts protons and is unrelated to molar mass, whereas the molar mass \(32.06\ \text{g/mol}\) reflects the mass of one mole of atoms. (Choice D) Multiplying mass by molar mass, \(19.2 \times 32.06\), inverts the relationship and yields units of \(\text{g}^2/\text{mol}\), not moles; moles require dividing mass by molar mass so that grams cancel. This is a Skill 2 (reasoning about scientific principles via quantitative conversion) question.$ex23$,
    'medium', '4E', $cc23$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc23$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $ar23A$atomic-vs-molecular molar mass (S vs S8)$ar23A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar23C$dividing by atomic number instead of molar mass$ar23C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $ar23D$multiplying by molar mass instead of dividing$ar23D$ FROM q;

-- Q24 [The Mole & Avogadro · medium · Skill 2 · ans A]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s24$The Mole & Avogadro$s24$,
    $qt24$A technician weighs out exactly \(6.02 \times 10^{23}\) atoms of phosphorus, whose atomic weight is \(30.97\). The same number of atoms is then weighed out for sulfur, atomic weight \(32.07\). The combined mass of the two samples is closest to which value?$qt24$,
    $op24$[{"label": "A", "text": "\\(63.0\\ \\text{g}\\)"}, {"label": "B", "text": "\\(63.0\\ \\text{amu}\\)"}, {"label": "C", "text": "\\(31.5\\ \\text{g}\\)"}, {"label": "D", "text": "\\(1.05 \\times 10^{-22}\\ \\text{g}\\)"}]$op24$::jsonb,
    'A',
    $ex24$This item addresses the mole concept and molar mass. The quantity \(6.02 \times 10^{23}\) atoms is one mole, and the molar mass of an element in grams per mole is numerically equal to its atomic weight in atomic mass units. One mole of phosphorus therefore has a mass of \(30.97\ \text{g}\) and one mole of sulfur \(32.07\ \text{g}\); summing gives \(63.04\ \text{g}\), closest to \(63.0\ \text{g}\). (Choice B) The numerical sum \(63.0\) is correct, but atomic mass units quantify the mass of a single atom, not a mole of atoms; the mass of one mole of an element is expressed in grams, so labeling a macroscopic sample in amu is a unit mismatch. (Choice C) The value \(31.5\ \text{g}\) is the average of the two atomic weights rather than their sum, which would apply only to a single mole total rather than one mole of each element. (Choice D) The value \(1.05 \times 10^{-22}\ \text{g}\) is the mass of one pair of atoms—the molar mass divided by Avogadro's number—rather than the mass of an entire mole of each element. Skill 2: this requires applying the equivalence between atomic weight and molar mass to compute a sample mass with correct units.$ex24$,
    'medium', '4E', $cc24$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc24$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'scale_unit_error', $ar24B$amu-for-molar-mass substitution$ar24B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $ar24C$averaging instead of summing molar masses$ar24C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $ar24D$single-atom mass for one mole$ar24D$ FROM q;

-- Q25 [The Mole & Avogadro · medium · Skill 2 · ans C]
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Atomic Structure', $s25$The Mole & Avogadro$s25$,
    $qt25$A jeweler weighs out \(3.18\ \text{g}\) of pure copper (\(M = 63.5\ \text{g/mol}\)) to electroplate a contact. How many copper atoms are present in the sample?$qt25$,
    $op25$[{"label": "A", "text": "\\(1.92 \\times 10^{24}\\ \\text{atoms}\\)"}, {"label": "B", "text": "\\(1.20 \\times 10^{25}\\ \\text{atoms}\\)"}, {"label": "C", "text": "\\(3.01 \\times 10^{22}\\ \\text{atoms}\\)"}, {"label": "D", "text": "\\(8.32 \\times 10^{-26}\\ \\text{atoms}\\)"}]$op25$::jsonb,
    'C',
    $ex25$This item tests the mole concept and Avogadro's number through a two-step mass-to-particle conversion. The mass converts to moles by dividing by the molar mass, \(3.18\ \text{g} \div 63.5\ \text{g/mol} = 0.0500\ \text{mol}\), and moles convert to atoms by multiplying by Avogadro's number, \(0.0500\ \text{mol} \times 6.022 \times 10^{23}\ \text{atoms/mol} = 3.01 \times 10^{22}\ \text{atoms}\). (Choice A) This value, \(3.18 \times 6.022 \times 10^{23} = 1.92 \times 10^{24}\), results from multiplying grams directly by Avogadro's number, omitting division by the molar mass; Avogadro's number scales moles, not mass, so the gram-to-mole step is required first. (Choice B) This value comes from inverting the mass ratio, \((63.5 \div 3.18) \times 6.022 \times 10^{23} = 1.20 \times 10^{25}\), which treats molar mass as the dividend; moles equal mass divided by molar mass, so the smaller mass must sit in the numerator. (Choice D) This value, \(0.0500 \div (6.022 \times 10^{23}) = 8.32 \times 10^{-26}\), divides moles by Avogadro's number; the number of particles per mole is a multiplier that converts moles up to a count, so dividing produces a physically meaningless sub-atomic quantity. Skill 2: this requires executing a multi-step unit conversion using the molar mass and Avogadro's number as conversion factors.$ex25$,
    'medium', '4E', $cc25$Atoms, nuclear decay, electronic structure, and atomic chemical behavior$cc25$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $ar25A$skip-the-mole-step (grams times Avogadro)$ar25A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $ar25B$inverted mass-over-molar-mass ratio$ar25B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $ar25D$divide-by-Avogadro instead of multiply$ar25D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='Atomic Structure' AND subtopic IN ('Subatomic Particles','Isotopes & Atomic Weight','The Mole & Avogadro');