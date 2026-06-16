-- GenChem Ch2 (The Periodic Table) — Batch 2 of 3: Types of Elements + Periodic Trends
-- 20 questions, all confidence >=4 (OpenStax Atoms First 2e); cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- Re-runnable. Run in Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'The Periodic Table' AND subtopic IN ('Types of Elements', 'Periodic Trends');

-- Q1 [Types of Elements · easy · Skill 1 · ans A] (g21)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt21$On a periodic table, the metalloid "staircase" separates two broad regions. An element sits in a group lying to the left of this dividing line. Where on the table, relative to the staircase, are such elements located, and what type are they?$qt21$,
    $op21$[{"label":"A","text":"To the left of the staircase, where the metals are found"},{"label":"B","text":"To the right of the staircase, where the metals are found"},{"label":"C","text":"To the left of the staircase, where the nonmetals are found"},{"label":"D","text":"Directly along the staircase, where the metals are found"}]$op21$::jsonb,
    'A',
    $ex21$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The metalloid staircase is the stepped diagonal line running roughly from \(\text{B}\) (boron) down toward \(\text{At}\) (astatine). Metals occupy the large region to the left of this line, nonmetals occupy the region to the right, and the metalloids themselves lie along the staircase. An element in a group to the left of the line is therefore a metal. (Choice B) This correctly places metals on a single side but reverses the geometry: the region to the right of the staircase holds the nonmetals, not the metals. (Choice C) The left side is correctly identified, but it is the metal region, not the nonmetal region; nonmetals sit to the right of the line. (Choice D) Elements positioned directly along the staircase are the metalloids (e.g., \(\text{Si}\), \(\text{Ge}\), \(\text{As}\)), which show intermediate properties and are not classified as metals. Skill 1$ex21$,
    'easy', '4E', $cc21$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc21$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a21B$Swaps the left/right sides of the staircase, assigning metals to the nonmetal region$a21B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a21C$Correct side but mislabels the left-hand region as nonmetals$a21C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a21D$Conflates elements on the staircase (metalloids) with the metal region beside it$a21D$ FROM q;

-- Q2 [Types of Elements · easy · Skill 1 · ans B] (g22)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt22$A freshly cut surface of solid \(\text{Na}\) reflects light with a bright, mirror-like sheen before it dulls in air. Among the broad classes into which the periodic table sorts the elements, the one whose members are characteristically described by this shiny, light-reflecting surface is the$qt22$,
    $op22$[{"label":"A","text":"nonmetals, such as \\(\\text{S}\\) and \\(\\text{P}\\)"},{"label":"B","text":"metals, such as \\(\\text{Na}\\) and \\(\\text{Fe}\\)"},{"label":"C","text":"metalloids, such as \\(\\text{Si}\\) and \\(\\text{Ge}\\)"},{"label":"D","text":"noble gases, such as \\(\\text{Ne}\\) and \\(\\text{Ar}\\)"}]$op22$::jsonb,
    'B',
    $ex22$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Luster, a bright surface that reflects light, is one of the defining physical properties of the metals: their delocalized, mobile valence electrons reflect incident light, giving species such as \(\text{Na}\) and \(\text{Fe}\) their characteristic shine. Nonmetals, by contrast, are typically dull, so the shiny class named in the stem is the metals, making B correct. (Choice A) Nonmetals such as \(\text{S}\) and \(\text{P}\) lack the sea of mobile electrons responsible for reflectivity and are characteristically dull rather than lustrous, so assigning luster to them inverts the metal/nonmetal property relationship. (Choice C) Metalloids such as \(\text{Si}\) and \(\text{Ge}\) form a genuine intermediate class along the metal/nonmetal staircase, but they are identified by their intermediate semiconducting and mixed chemical behavior, not by luster being their defining characteristic property. (Choice D) Noble gases such as \(\text{Ne}\) and \(\text{Ar}\) are classified by their full valence shells and chemical inertness; they are colorless monatomic gases, and luster is a property of solid metallic surfaces, not of this group. Skill 1$ex22$,
    'easy', '4E', $cc22$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc22$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a22A$luster assigned to nonmetals (metal/nonmetal property inverted)$a22A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a22C$metalloid intermediate class substituted for the metals$a22C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a22D$noble-gas inertness treated as governing the shiny physical property$a22D$ FROM q;

-- Q3 [Types of Elements · medium · Skill 2 · ans C] (g23)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt23$A student strikes a small crystalline solid of an unknown element with a hammer, and the sample shatters into angular fragments rather than flattening. Assuming the sample is a pure element, this mechanical response most likely indicates that the element is a nonmetal because$qt23$,
    $op23$[{"label":"A","text":"a delocalized sea of valence electrons lets planes of atoms slide past one another, absorbing the blow without fracture"},{"label":"B","text":"metallic luster and high thermal conductivity both correlate with a tendency to deform plastically under stress"},{"label":"C","text":"its bonding is directional and lacks a delocalized electron sea, so displaced atoms cannot re-establish bonding and the solid cleaves instead of deforming"},{"label":"D","text":"nonmetals possess larger atomic radii than metals, so their atomic planes are too widely spaced to resist an applied force"}]$op23$::jsonb,
    'C',
    $ex23$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Malleability is a hallmark of metals: their valence electrons are delocalized into a mobile electron sea, so when a blow displaces one layer of cations relative to another, the nondirectional metallic bonding is preserved and the planes simply slide, letting the metal deform without fracturing. Nonmetals lack this electron sea; their solids are held together by directional covalent (or, in molecular solids, weak intermolecular) interactions. When an applied force displaces atoms, like-charged or mismatched centers are forced together and bonding cannot re-form along the new arrangement, so the crystal relieves the stress by cleaving along a plane. A sample that shatters into angular fragments rather than flattening is therefore behaving as a brittle nonmetal, making Choice C correct. (Choice A) A delocalized electron sea and sliding atomic planes describe the mechanism of metallic malleability, the opposite of the brittle, shattering behavior observed. (Choice B) Luster and high thermal conductivity are indeed metallic properties, but they are correlated traits rather than the cause of brittleness, and they predict deformation, not the fracture seen here. (Choice D) Atomic radius does not govern brittleness; many metals have large radii yet remain malleable, and the response on striking is dictated by bonding character, not interplanar spacing. Skill 2$ex23$,
    'medium', '4E', $cc23$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc23$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a23A$Attributes the metallic malleability mechanism (electron-sea sliding) to the brittle nonmetal sample, inverting the cause$a23A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a23B$Cites genuine metallic properties (luster, conductivity) as if they explain the observed fracture$a23B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a23D$Invokes atomic radius / interplanar spacing as the determinant of brittleness instead of bonding character$a23D$ FROM q;

-- Q4 [Types of Elements · easy · Skill 1 · ans D] (g24)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt24$A length of copper, \(\text{Cu}\), is drawn through a die into a thin wire without fracturing. The property that allows a sample to be drawn into wires in this way, together with the class of elements that characteristically shows it, is most likely$qt24$,
    $op24$[{"label":"A","text":"malleability, a property of metals such as \\(\\text{Cu}\\)"},{"label":"B","text":"conductivity, a property of metals such as \\(\\text{Cu}\\)"},{"label":"C","text":"brittleness, a property of nonmetals such as \\(\\text{S}\\)"},{"label":"D","text":"ductility, a property of metals such as \\(\\text{Cu}\\)"}]$op24$::jsonb,
    'D',
    $ex24$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Ductility is the physical property that allows a material to be drawn into wires, and it is a hallmark of metals; the delocalized "sea" of valence electrons in a metal lets the cation lattice slide and re-form bonds under tensile stress without fracturing, so a metal such as \(\text{Cu}\) can be pulled through a die into wire. Pairing the wire-drawing property (ductility) with the metallic class makes D correct. (Choice A) Malleability is the related but distinct metallic property describing the ability to be hammered or rolled into thin sheets under compressive force, not drawn into wires under tensile force; the class assignment to metals is right, but the named property does not describe wire formation. (Choice B) Conductivity is a genuine metallic property, but it describes the transport of electric charge or heat, not the mechanical capacity to be drawn into a wire, so it does not name the property responsible for the deformation described. (Choice C) Brittleness describes fracturing under stress rather than deforming into a wire, and it is characteristic of many nonmetals such as \(\text{S}\); both the property and the element class are the reverse of what permits wire drawing. Skill 1$ex24$,
    'easy', '4E', $cc24$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc24$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a24A$malleability-confused-with-ductility (sheets vs. wires)$a24A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a24B$true-metallic-property-but-wrong-property (conductivity not deformation)$a24B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a24C$brittleness-of-nonmetals-opposite-of-ductile-metals$a24C$ FROM q;

-- Q5 [Types of Elements · medium · Skill 1 · ans A] (g25)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt25$A technician wires a length of pure copper into a circuit and finds it carries current readily, while an identically shaped rod of sulfur leaves the circuit dead. Based on the position of each element in the periodic table, the class of elements whose members are expected to conduct an electric current well is$qt25$,
    $op25$[{"label":"A","text":"the metals, located on the left and center of the table"},{"label":"B","text":"the nonmetals, located on the upper right of the table"},{"label":"C","text":"the noble gases, located in the far-right column"},{"label":"D","text":"the halogens, located in the next-to-last column"}]$op25$::jsonb,
    'A',
    $ex25$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Elements are sorted into metals, nonmetals, and metalloids partly by their physical behavior, and high electrical and thermal conductivity is a defining property of the metals. Metals occupy the left side and center of the periodic table; their loosely held valence electrons are delocalized into a mobile "sea" that drifts under an applied potential, so copper (\(\text{Cu}\)), a metal, carries current readily. Nonmetals such as sulfur (\(\text{S}\)) hold their valence electrons tightly in localized bonds, leaving no mobile carriers, which is why the sulfur rod does not conduct. (Choice B) The nonmetals, in the upper-right region of the table, are characteristically poor conductors or insulators; sulfur is itself a nonmetal, so naming this class reverses the observed behavior of the two rods. (Choice C) The noble gases of the far-right column \((ns^2 np^6)\) exist as monatomic, electrically neutral atoms with no delocalized electrons and conduct only when ionized into a plasma, so they are not the class expected to conduct as solids. (Choice D) The halogens of the next-to-last column \((ns^2 np^5)\) are reactive nonmetals; their electrons remain localized in molecular bonds, so this subset of nonmetals does not provide the mobile charge carriers needed for good conduction. Skill 1$ex25$,
    'medium', '4E', $cc25$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc25$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a25B$names the poor-conductor class (nonmetals) as the good conductors, inverting the conductivity rule$a25B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a25C$noble-gas group recalled as a distinct element class but irrelevant to solid-state conduction$a25C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a25D$halogens correctly placed as a real group yet are a nonmetal subset that does not conduct$a25D$ FROM q;

-- Q6 [Types of Elements · medium · Skill 2 · ans B] (g26)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt26$When sodium reacts with chlorine to form \(\text{NaCl}\), one reactant surrenders valence electrons while the other takes them up. Given that \(\text{Na}\) is a metal and \(\text{Cl}\) a nonmetal, which reactant most likely loses electrons, and on what property does this outcome chiefly depend?$qt26$,
    $op26$[{"label":"A","text":"\\(\\text{Cl}\\) loses electrons, because its high electronegativity drives it to release its valence electrons to the metal."},{"label":"B","text":"\\(\\text{Na}\\) loses electrons, because its low ionization energy makes its valence electron easy to remove."},{"label":"C","text":"\\(\\text{Na}\\) loses electrons, because its high electron affinity favors shedding its outer electron."},{"label":"D","text":"\\(\\text{Cl}\\) loses electrons, because its low ionization energy makes its valence electrons easy to remove."}]$op26$::jsonb,
    'B',
    $ex26$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Whether an element loses or gains electrons in a reaction is governed by its electropositive or electronegative character, which tracks ionization energy. Metals are electropositive: they hold their valence electrons loosely and have low ionization energies, so they readily lose those electrons to form cations. Sodium \(\left(\left[\text{Ne}\right]3s^1\right)\) has a single, easily removed valence electron and a low first ionization energy, so it loses an electron to become \(\text{Na}^+\); chlorine, a nonmetal with high electronegativity, instead gains that electron to become \(\text{Cl}^-\). The deciding property is therefore the metal's low ionization energy, making B correct. (Choice A) Chlorine has high electronegativity, but high electronegativity describes a tendency to attract and gain electrons, not to release them; the nonmetal is the electron acceptor, so it does not lose electrons. (Choice C) High electron affinity describes the energy released when an atom gains an electron and favors electron capture, not electron loss; sodium does lose its electron, but the governing property is its low ionization energy, not electron affinity. (Choice D) Chlorine has a high, not low, ionization energy and is the nonmetal that gains electrons; assigning electron loss to chlorine reverses the roles of the metal and nonmetal in the reaction. Skill 2$ex26$,
    'medium', '4E', $cc26$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc26$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a26A$high electronegativity cited as driving electron loss, inverting the gain/lose role of the nonmetal$a26A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a26C$correct element but substitutes electron affinity for ionization energy as the governing property$a26C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a26D$low ionization energy misattributed to the nonmetal, swapping which class loses electrons$a26D$ FROM q;

-- Q7 [Types of Elements · medium · Skill 2 · ans C] (g27)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt27$A compound forms directly from elemental nitrogen, \(\text{N}\), and elemental oxygen, \(\text{O}\), with no metal present in the system. Given that both elements sit on the nonmetal side of the periodic table, the bonding that most likely holds the resulting compound together is$qt27$,
    $op27$[{"label":"A","text":"ionic, because the more electronegative \\(\\text{O}\\) strips electrons completely from \\(\\text{N}\\) to form \\(\\text{N}^{3+}\\) and \\(\\text{O}^{2-}\\)."},{"label":"B","text":"metallic, because adjacent p-block elements pool their valence electrons into a shared delocalized sea."},{"label":"C","text":"covalent, because two nonmetals share valence electrons rather than transfer them outright."},{"label":"D","text":"ionic, because \\(\\text{N}\\) lies to the left of \\(\\text{O}\\) and therefore behaves as the metal that donates electrons."}]$op27$::jsonb,
    'C',
    $ex27$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Bonding behavior follows directly from the metal/nonmetal classification of the two combining elements: a metal paired with a nonmetal transfers electrons to form a cation–anion (ionic) compound, whereas two nonmetals have comparable, high electronegativities and neither can fully strip electrons from the other, so they share valence electrons in covalent bonds. Both \(\text{N}\) and \(\text{O}\) are nonmetals occupying the upper-right p-block, so the compound they form is held together by covalent (molecular) bonding, as in \(\text{NO}\) or \(\text{NO}_2\), making C correct. (Choice A) Complete electron transfer to give discrete ions such as \(\text{N}^{3+}\) and \(\text{O}^{2-}\) characterizes a metal–nonmetal pairing; two nonmetals of similar electronegativity do not produce a full transfer, so an ionic description does not apply here. (Choice B) Metallic bonding, a delocalized electron sea, requires metal atoms with loosely held valence electrons; nonmetals hold their valence electrons tightly and do not delocalize them across a lattice. (Choice D) Relative horizontal position within the same nonmetal region does not convert the left-hand element into a metal; \(\text{N}\) remains a nonmetal regardless of its position relative to \(\text{O}\), so it does not act as an electron-donating metal. Skill 2$ex27$,
    'medium', '4E', $cc27$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc27$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a27A$nonmetal pair forced into full electron transfer$a27A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a27B$metallic delocalization applied to nonmetals$a27B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a27D$periodic position misread as metal character$a27D$ FROM q;

-- Q8 [Types of Elements · medium · Skill 2 · ans D] (g28)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt28$A circuit designer selects silicon \(\left(\text{Si}\right)\) rather than copper or sulfur for the active layer of a transistor, citing that its room-temperature electrical conductivity sits between that of a typical metal and a typical nonmetal. Which property of silicon is most consistent with this intermediate conductivity?$qt28$,
    $op28$[{"label":"A","text":"It conducts electricity as freely as a metal because a sea of delocalized valence electrons is shared across all of its atoms."},{"label":"B","text":"Its conductivity rises as temperature falls, because cooling reduces the lattice vibrations that scatter its mobile charge carriers."},{"label":"C","text":"It is an electrical insulator at all temperatures because its valence electrons remain tightly localized in fixed covalent bonds."},{"label":"D","text":"It conducts better than a nonmetal but worse than a metal, because only a modest fraction of its valence electrons are free to carry charge."}]$op28$::jsonb,
    'D',
    $ex28$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Silicon is a metalloid, an element whose properties lie between those of metals and nonmetals. Electrically, metalloids behave as semiconductors: their conductivity is greater than that of nonmetals (insulators) but smaller than that of metals (conductors), placing them intermediate between a conductor and an insulator. This arises because only a modest fraction of silicon's valence electrons can be thermally excited into a mobile, charge-carrying state at a given temperature, in contrast to a metal where many delocalized electrons conduct freely. This tunable, intermediate conductivity is precisely why silicon is the workhorse material for semiconductor devices such as transistors, making D correct.\n(Choice A) Describing silicon as conducting "as freely as a metal" via a fully delocalized electron sea assigns it true metallic conductivity; this contradicts the stated observation that its conductivity is intermediate and lower than a metal's, and it is the bonding model for metals rather than metalloids.\n(Choice B) Conductivity that increases on cooling is characteristic of metals, where reduced lattice vibration lessens electron scattering; for a semiconductor like silicon, lowering the temperature instead reduces the number of thermally promoted charge carriers, so its conductivity falls rather than rises, reversing the actual temperature dependence.\n(Choice C) Calling silicon an insulator at all temperatures denies any charge transport whatsoever; that label fits a typical nonmetal, whereas a metalloid does conduct measurably—just less effectively than a metal—which is the intermediate behavior the question identifies.\nSkill 2$ex28$,
    'medium', '4E', $cc28$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc28$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a28A$Treats the metalloid as a full metal with a delocalized electron sea, overstating its conductivity to the metallic level$a28A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a28B$Applies the metallic temperature dependence (conductivity up on cooling) to a semiconductor, reversing the true carrier-population trend$a28B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a28C$Correctly notes covalent localized bonding but overextends it to a total insulator, the nonmetal extreme rather than the intermediate metalloid case$a28C$ FROM q;

-- Q9 [Types of Elements · medium · Skill 2 · ans A] (g29)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt29$An element sits in Group 4A (14) of Period 4, where the stair-step boundary that divides metals from nonmetals cuts through the group. Its classification is most consistent with which category?$qt29$,
    $op29$[{"label":"A","text":"Metalloid, because the Period 4 Group 4A position falls directly on the stair-step diagonal"},{"label":"B","text":"Nonmetal, because Group 4A is headed by carbon, a nonmetal"},{"label":"C","text":"Metal, because Period 4 lies below the metalloid band, which is confined to Periods 2 and 3"},{"label":"D","text":"Metalloid, because every element in Group 4A shares borderline metallic and nonmetallic character"}]$op29$::jsonb,
    'A',
    $ex29$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Elements are classed as metals, nonmetals, or metalloids by their position relative to the stair-step diagonal that runs from boron \(\left(\text{B}\right)\) down to astatine; the metalloids lie along that step (\(\text{B}\), \(\text{Si}\), \(\text{Ge}\), \(\text{As}\), \(\text{Sb}\), \(\text{Te}\)), metals lie to the lower-left, and nonmetals to the upper-right. Group 4A (14), Period 4 is germanium \(\left(\text{Ge}\right)\), which sits squarely on the stair-step and is therefore a metalloid with intermediate ionization energy and electronegativity, making A correct. (Choice B) Carbon heads Group 4A and is a nonmetal, but classification follows an element's own row position, not the group head; descending the group crosses the stair-step into metalloid and then metallic character (\(\text{Sn}\), \(\text{Pb}\)). (Choice C) The metalloid band is not confined to Periods 2 and 3; it runs diagonally through Period 6, so a Period 4 Group 4A element lies on the band rather than below it, and \(\text{Ge}\) is not a metal. (Choice D) Group 4A does not consist uniformly of metalloids: \(\text{C}\) is a nonmetal and \(\text{Sn}\) and \(\text{Pb}\) are metals, so the borderline character belongs only to the members crossed by the stair-step, not the whole group. Skill 2$ex29$,
    'medium', '4E', $cc29$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc29$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'partial_truth', $a29B$Applies the group head's classification (carbon, a nonmetal) to the whole group, ignoring the row-by-row crossing of the stair-step$a29B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a29C$Believes the metalloid band is restricted to the upper periods so that lower-period members must be metals$a29C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a29D$Reaches the correct label by an invalid generalization that all Group 4A elements are metalloids$a29D$ FROM q;

-- Q10 [Types of Elements · medium · Skill 1 · ans B] (g30)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt30$A materials lab needs a small contact pad to carry a steady electric current at room temperature, and a technician must choose between a pad cut from pure solid gold, \(\text{Au}\), and one cut from pure solid boron, \(\text{B}\). Assuming each pad is a clean, undamaged crystal of the pure element, which choice is expected to carry the current with the lower resistance, and why?$qt30$,
    $op30$[{"label":"A","text":"Boron, because as a metalloid it conducts electricity better than a metal such as \\(\\text{Au}\\)."},{"label":"B","text":"Gold, because its valence electrons are held loosely in a delocalized \"sea\" of mobile electrons that carries current freely, while \\(\\text{B}\\) lacks such free electrons."},{"label":"C","text":"Neither is favored, because both \\(\\text{Au}\\) and \\(\\text{B}\\) are solids at room temperature and solids of comparable purity conduct alike."},{"label":"D","text":"Boron, because it is a semiconductor, and semiconductors are the best electrical conductors among the elements."}]$op30$::jsonb,
    'B',
    $ex30$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Gold, \(\text{Au}\), is a metal, and metallic bonding pools the valence electrons into a delocalized "sea" of mobile charge carriers that drift freely under an applied field, giving metals their characteristically high electrical conductivity. Boron, \(\text{B}\), is a metalloid: its valence electrons are far more localized in covalent bonding, so it carries current much more poorly than a metal. With both pads pure and undamaged, the gold pad therefore offers the lower resistance and is the better conductor. (Choice A) This reverses the actual trend; metalloids such as \(\text{B}\) conduct electricity far worse than metals such as \(\text{Au}\), not better, because metalloids lack a metal's freely mobile electron sea. (Choice C) Existing as a solid does not by itself fix conductivity; what matters is bonding type and the availability of mobile carriers, so a metal like \(\text{Au}\) and a metalloid like \(\text{B}\) of equal purity do not conduct alike. (Choice D) Calling \(\text{B}\) a semiconductor does not make it a superior conductor; semiconductors carry far less current than metals at room temperature, and their utility lies in tunable, intermediate conductivity rather than in maximal conduction, so this does not place \(\text{B}\) above \(\text{Au}\). Skill 1$ex30$,
    'medium', '4E', $cc30$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc30$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a30A$Claims metalloids outconduct metals, inverting the true metal-versus-metalloid conductivity order$a30A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a30C$Treats shared physical state (both solid) as implying equal conductivity, ignoring bonding and mobile carriers$a30C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a30D$Invokes the real term semiconductor but misapplies it as meaning best conductor$a30D$ FROM q;

-- Q11 [Types of Elements · easy · Skill 1 · ans C] (g31)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt31$A periodic table highlights the staircase of metalloids that separates the metals from the nonmetals. Of the elements bordering that staircase, one is classified as a true metal rather than a metalloid. Which element is the metal?$qt31$,
    $op31$[{"label":"A","text":"Germanium, \\(\\text{Ge}\\)"},{"label":"B","text":"Antimony, \\(\\text{Sb}\\)"},{"label":"C","text":"Aluminum, \\(\\text{Al}\\)"},{"label":"D","text":"Tellurium, \\(\\text{Te}\\)"}]$op31$::jsonb,
    'C',
    $ex31$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. The metalloid staircase consists of \(\text{B}\), \(\text{Si}\), \(\text{Ge}\), \(\text{As}\), \(\text{Sb}\), and \(\text{Te}\), the elements straddling the diagonal that divides metals from nonmetals; they show properties intermediate between the two. Aluminum, \(\text{Al}\), sits in group 13 immediately to the left of the staircase and is a true metal: it is lustrous, malleable, and an excellent electrical conductor, so it is the non-member here. (Choice A) Germanium, \(\text{Ge}\), is a group 14 metalloid lying directly on the staircase and is a classic semiconductor. (Choice B) Antimony, \(\text{Sb}\), is a group 15 metalloid on the staircase whose intermediate character is reflected in its brittle, semi-metallic form. (Choice D) Tellurium, \(\text{Te}\), is a group 16 metalloid on the staircase that displays semiconducting behavior. Skill 1$ex31$,
    'easy', '4E', $cc31$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc31$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a31A$Names a genuine staircase metalloid (Ge) instead of the non-member metal$a31A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a31B$Names a genuine staircase metalloid (Sb) instead of the non-member metal$a31B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a31D$Names a genuine staircase metalloid (Te) instead of the non-member metal$a31D$ FROM q;

-- Q12 [Types of Elements · hard · Skill 4 · ans D] (g32)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Types of Elements',
    $qt32$Selenium sits in group 16 of the periodic table and is classified as a nonmetal. A sample of its oxide \(\text{SeO}_3\) is dissolved in water. Assuming the oxide reacts characteristically for its elemental classification, the resulting aqueous solution most likely registers a pH that is$qt32$,
    $op32$[{"label":"A","text":"above 7, because nonmetal oxides accept protons from water to liberate hydroxide ions."},{"label":"B","text":"above 7, because group 16 oxides dissolve to form the corresponding metal hydroxide."},{"label":"C","text":"near 7, because nonmetal oxides are amphoteric and neutralize themselves in water."},{"label":"D","text":"below 7, because nonmetal oxides react with water to form oxyacids that release protons."}]$op32$::jsonb,
    'D',
    $ex32$This is a General Chemistry question in the content category 'The Periodic Table: Classification of Elements Into Groups by Electronic Structure'. Classification of an element as a metal or nonmetal predicts the acid-base character of its oxide. Nonmetal oxides are acidic oxides (acid anhydrides): they react with water to produce oxyacids that ionize and release \(\text{H}^+\), lowering the pH below 7. Selenium is a nonmetal, so \(\text{SeO}_3\) behaves as the anhydride of selenic acid, \(\text{SeO}_3 + \text{H}_2\text{O} \rightarrow \text{H}_2\text{SeO}_4\), which dissociates to give \(\text{H}^+\) and an acidic solution. The metal/nonmetal split is the hinge: metal oxides (e.g. \(\text{Na}_2\text{O}\)) are basic, generating \(\text{OH}^-\), whereas nonmetal oxides are acidic. (Choice A) The direction of the acid-base behavior is reversed; a nonmetal oxide does not generate \(\text{OH}^-\), and oxide species that produce hydroxide and raise pH are basic metal oxides, not nonmetal oxides. (Choice B) Selenium is a nonmetal and forms no metal hydroxide; the premise misassigns group 16 oxides to metallic, base-forming behavior. (Choice C) Although some borderline oxides (e.g. \(\text{Al}_2\text{O}_3\)) are amphoteric, a clear-cut nonmetal oxide such as \(\text{SeO}_3\) is acidic rather than self-neutralizing, so the solution is not near pH 7. Skill 4$ex32$,
    'hard', '4E', $cc32$The Periodic Table: Classification of Elements Into Groups by Electronic Structure$cc32$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a32A$Assigns base-forming (hydroxide-releasing) behavior to a nonmetal oxide, inverting the acidic/basic oxide rule$a32A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a32B$Treats a group 16 nonmetal oxide as a metal oxide that forms a metal hydroxide$a32B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a32C$Over-extends amphoterism of borderline oxides to a clear nonmetal oxide, predicting neutral pH$a32C$ FROM q;

-- Q13 [Periodic Trends · hard · Skill 2 · ans A] (g33)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt33$A chemist surveying a row of binary compounds wants the one whose bond sits closest to the ionic end of the bonding continuum. Using only the periodic trend in electronegativity, where the value rises toward the upper right and falls toward the lower left, which of the following bonds is most likely the most ionic?$qt33$,
    $op33$[{"label":"A","text":"The bond in \\(\\text{KF}\\)"},{"label":"B","text":"The bond in \\(\\text{NaCl}\\)"},{"label":"C","text":"The bond in \\(\\text{HF}\\)"},{"label":"D","text":"The bond in \\(\\text{Cl}_2\\)"}]$op33$::jsonb,
    'A',
    $ex33$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row.' Bond character tracks the electronegativity difference \(\Delta\text{EN}\) between the bonded atoms: the larger the difference, the more unequally the bonding electrons are shared and the more ionic (more polar) the bond, while a difference near zero gives a nonpolar covalent bond. Electronegativity increases toward the upper right of the periodic table and decreases toward the lower left, so the largest difference pairs an element from the far lower left with one from the far upper right. Potassium lies at the bottom left (\(\text{EN}\approx 0.8\)) and fluorine at the top right (\(\text{EN}\approx 4.0\)), giving \(\text{KF}\) a difference of about \(3.2\) — the largest among the choices and therefore the most ionic bond. (Choice B) \(\text{NaCl}\) pairs sodium (\(\text{EN}\approx 0.9\)) with chlorine (\(\text{EN}\approx 3.0\)) for a difference near \(2.1\); chlorine sits a full row above and to the left of fluorine, so its electronegativity is lower and the difference is smaller than in \(\text{KF}\). (Choice C) \(\text{HF}\) has the same highly electronegative fluorine, but hydrogen (\(\text{EN}\approx 2.1\)) is far more electronegative than potassium, so the difference is only about \(1.9\); a shared, more electronegative partner shrinks rather than widens the gap. (Choice D) \(\text{Cl}_2\) joins two identical chlorine atoms, so \(\Delta\text{EN}=0\); identical atoms share electrons equally, producing a nonpolar covalent bond rather than an ionic one. Skill 2$ex33$,
    'hard', '4E', $cc33$The Periodic Table: Variations of Chemical Properties with Group and Row$cc33$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'partial_truth', $a33B$metal-nonmetal pair with a smaller halogen electronegativity$a33B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a33C$shares the most electronegative atom but with a less electropositive partner$a33C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a33D$homonuclear bond mistaken for ionic$a33D$ FROM q;

-- Q14 [Periodic Trends · medium · Skill 2 · ans B] (g34)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt34$A chemist dissolves the highest oxide of each period-3 element in water and records the acid-base behavior of the resulting solutions. Moving from \(\text{Na}_2\text{O}\) on the left to \(\text{Cl}_2\text{O}_7\) on the right, which sequence correctly describes how the oxides' acid-base character shifts across the period?$qt34$,
    $op34$[{"label":"A","text":"Acidic at \\(\\text{Na}_2\\text{O}\\), passing through amphoteric \\(\\text{Al}_2\\text{O}_3\\), to basic at \\(\\text{Cl}_2\\text{O}_7\\)"},{"label":"B","text":"Basic at \\(\\text{Na}_2\\text{O}\\), passing through amphoteric \\(\\text{Al}_2\\text{O}_3\\), to acidic at \\(\\text{Cl}_2\\text{O}_7\\)"},{"label":"C","text":"Basic at \\(\\text{Na}_2\\text{O}\\), through amphoteric \\(\\text{SO}_3\\), to weakly basic again at \\(\\text{Cl}_2\\text{O}_7\\)"},{"label":"D","text":"Amphoteric at \\(\\text{Na}_2\\text{O}\\), becoming strongly basic at \\(\\text{Al}_2\\text{O}_3\\), then acidic at \\(\\text{Cl}_2\\text{O}_7\\)"}]$op34$::jsonb,
    'B',
    $ex34$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. Across a period the elements shift from metallic (left) to nonmetallic (right), and the acid-base character of their oxides tracks that change. Ionic metal oxides such as \(\text{Na}_2\text{O}\) and \(\text{MgO}\) react with water to give hydroxides and are basic. Near the metal-nonmetal boundary, \(\text{Al}_2\text{O}_3\) is amphoteric, dissolving in both strong acid (forming \(\text{Al}^{3+}\)) and strong base (forming aluminate). Continuing right, the covalent nonmetal oxides \(\text{SiO}_2\), \(\text{P}_4\text{O}_{10}\), \(\text{SO}_3\), and \(\text{Cl}_2\text{O}_7\) react with water to give oxoacids and are increasingly acidic, so \(\text{Cl}_2\text{O}_7\) is the most acidic of the set. The overall progression is basic to amphoteric to acidic, matching B.\n(Choice A) This reverses the period-3 trend, placing acidic character at the metallic left end and basic character at the nonmetallic right end; the most electropositive element \(\text{Na}\) forms the most basic oxide, not the most acidic.\n(Choice C) The amphoteric crossover occurs at \(\text{Al}_2\text{O}_3\) near the metal-nonmetal divide, not at \(\text{SO}_3\); \(\text{SO}_3\) is a nonmetal oxide that yields sulfuric acid, and \(\text{Cl}_2\text{O}_7\) is strongly acidic rather than basic, so the trend does not return to basic at the right end.\n(Choice D) The amphoteric oxide is \(\text{Al}_2\text{O}_3\), positioned between the basic and acidic regions; \(\text{Na}_2\text{O}\) is the strongly basic terminus of the metallic side, not an amphoteric oxide, so labeling \(\text{Na}_2\text{O}\) amphoteric misplaces the crossover at the far left.\nSkill 2$ex34$,
    'medium', '4E', $cc34$The Periodic Table: Variations of Chemical Properties with Group and Row$cc34$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a34A$Inverts the period trend, assigning acidic oxides to the metallic left end and basic oxides to the nonmetallic right end$a34A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a34C$Places the amphoteric crossover at SO3 instead of Al2O3 and lets the trend loop back to basic at the right end$a34C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a34D$Misassigns the amphoteric label to Na2O at the far left rather than to Al2O3 at the metal-nonmetal boundary$a34D$ FROM q;

-- Q15 [Periodic Trends · easy · Skill 1 · ans C] (g35)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt35$Three halide anions, \(\text{F}^-\), \(\text{Cl}^-\), and \(\text{Br}^-\), each carry a single negative charge but occupy successive rows of Group 17. Which sequence lists them from smallest to largest ionic radius?$qt35$,
    $op35$[{"label":"A","text":"\\(\\text{Br}^- < \\text{Cl}^- < \\text{F}^-\\)"},{"label":"B","text":"\\(\\text{Cl}^- < \\text{F}^- < \\text{Br}^-\\)"},{"label":"C","text":"\\(\\text{F}^- < \\text{Cl}^- < \\text{Br}^-\\)"},{"label":"D","text":"\\(\\text{F}^- < \\text{Br}^- < \\text{Cl}^-\\)"}]$op35$::jsonb,
    'C',
    $ex35$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. For ions of like charge within the same group, ionic radius increases moving down the group because each successive ion adds a new occupied principal energy level, raising the principal quantum number \(n\) of the outermost electrons. Going from \(\text{F}^-\) (outermost \(n=2\)) to \(\text{Cl}^-\) (outermost \(n=3\)) to \(\text{Br}^-\) (outermost \(n=4\)), the valence shell lies progressively farther from the nucleus, so size increases in the order \(\text{F}^- < \text{Cl}^- < \text{Br}^-\). (Choice A) This reverses the trend; it would hold only if radius shrank down a group, but added principal levels make the larger-\(n\) ion the larger one, so \(\text{Br}^-\) is largest, not smallest. (Choice B) Placing \(\text{Cl}^-\) below \(\text{F}^-\) violates the monotonic increase with \(n\); \(\text{Cl}^-\) (\(n=3\)) must exceed \(\text{F}^-\) (\(n=2\)) because it occupies a higher principal level. (Choice D) This correctly identifies \(\text{F}^-\) as smallest but inverts the larger two; \(\text{Br}^-\) (\(n=4\)) is larger than \(\text{Cl}^-\) (\(n=3\)), so \(\text{Cl}^-\) cannot be the largest. Skill 1$ex35$,
    'easy', '4E', $cc35$The Periodic Table: Variations of Chemical Properties with Group and Row$cc35$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a35A$Inverts the group trend, treating ionic radius as decreasing down a group$a35A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a35B$Breaks the monotonic n-ordering by misranking the second-period ion above the third-period ion$a35B$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a35D$Correctly fixes the smallest ion but swaps the relative order of the two larger halides$a35D$ FROM q;

-- Q16 [Periodic Trends · medium · Skill 1 · ans D] (g36)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt36$A chemist is comparing three sulfur species generated in a discharge experiment: the gas-phase \(\text{S}^{2-}\) ion, a neutral sulfur atom, and the \(\text{S}^{2+}\) ion. To label the species on a plot of particle size, the chemist needs them placed from smallest to largest effective radius. Which ordering should be used?$qt36$,
    $op36$[{"label":"A","text":"\\(\\text{S}^{2-} < \\text{S} < \\text{S}^{2+}\\)"},{"label":"B","text":"\\(\\text{S} < \\text{S}^{2+} < \\text{S}^{2-}\\)"},{"label":"C","text":"\\(\\text{S}^{2-} < \\text{S}^{2+} < \\text{S}\\)"},{"label":"D","text":"\\(\\text{S}^{2+} < \\text{S} < \\text{S}^{2-}\\)"}]$op36$::jsonb,
    'D',
    $ex36$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. All three species share the same nuclear charge (16 protons) but differ in electron count: \(\text{S}^{2+}\) has 14 electrons, neutral \(\text{S}\) has 16, and \(\text{S}^{2-}\) has 18. As electrons are added at fixed nuclear charge, the per-electron attraction from the nucleus drops and electron-electron repulsion rises, so the electron cloud expands. The cation is therefore the most compact, the neutral atom intermediate, and the anion the largest, giving \(\text{S}^{2+} < \text{S} < \text{S}^{2-}\), which is choice D. (Choice A) This reverses the trend, placing the anion as smallest and the cation as largest; in fact removing electrons contracts the species and adding them expands it, so the order is inverted. (Choice B) This places the neutral atom as the smallest of the three, but the neutral atom holds more electrons than the cation and fewer than the anion, so it must fall between them rather than at an extreme. (Choice C) This treats both ions as smaller than the neutral atom, but only electron removal shrinks a species relative to the neutral atom; adding electrons to form the anion enlarges it, so the anion cannot be smaller than the neutral atom. Skill 1$ex36$,
    'medium', '4E', $cc36$The Periodic Table: Variations of Chemical Properties with Group and Row$cc36$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a36A$Inverts the charge-to-size relationship, ordering anion smallest to cation largest$a36A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a36B$Assumes the neutral atom is the smallest baseline and both ions are larger$a36B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a36C$Correctly shrinks the cation but wrongly shrinks the anion below the neutral atom$a36C$ FROM q;

-- Q17 [Periodic Trends · hard · Skill 2 · ans A] (g37)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt37$Across period 2 the electron affinity of carbon \(\left([\text{He}]2s^2 2p^2\right)\) is about \(-122\ \text{kJ/mol}\), yet nitrogen \(\left([\text{He}]2s^2 2p^3\right)\) lies near \(0\ \text{kJ/mol}\), breaking the expected leftward-to-rightward increase in how favorably an electron is captured. Given that nitrogen's incoming electron must enter an already singly-occupied \(2p\) orbital, which factor most directly accounts for nitrogen's anomalously low electron affinity relative to carbon?$qt37$,
    $op37$[{"label":"A","text":"The added electron is forced to pair within a \\(2p\\) orbital of the half-filled \\(2p^3\\) set, and the resulting electron-electron repulsion offsets much of the energy that nuclear attraction would otherwise release."},{"label":"B","text":"Nitrogen's larger effective nuclear charge \\(\\left(Z_\\text{eff}\\right)\\) pulls the incoming electron so tightly that the orbital cannot accommodate it without expelling a \\(2s\\) electron."},{"label":"C","text":"The added electron enters nitrogen's \\(3s\\) subshell rather than the \\(2p\\) subshell, placing it farther from the nucleus and weakening the attraction."},{"label":"D","text":"Filling the third \\(2p\\) orbital completes a stable half-filled set, and that extra stabilization is what makes nitrogen release less energy than carbon."}]$op37$::jsonb,
    'A',
    $ex37$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. Electron affinity generally grows more negative across a period as \(Z_\text{eff}\) rises, but the half-filled \(np^3\) configuration interrupts this trend. Nitrogen's three \(2p\) electrons singly occupy the three \(2p\) orbitals (\(2p_x^1 2p_y^1 2p_z^1\)), so an incoming fourth \(2p\) electron has no empty orbital to enter and must pair within one already-occupied orbital. Forcing two electrons into the same small \(2p\) region sharply increases electron-electron repulsion, and that repulsion cancels much of the stabilization that nuclear attraction would otherwise provide. The net energy released is therefore small, leaving nitrogen's electron affinity near zero and less negative than carbon's, whose added electron enters a still-empty \(2p\) orbital without an extra pairing penalty.\n\n(Choice B) \(Z_\text{eff}\) does rise from carbon to nitrogen, which by itself predicts a more negative electron affinity, the opposite of what is observed; rising \(Z_\text{eff}\) cannot account for the anomaly, and capturing an electron never ejects a tightly held \(2s\) electron.\n\n(Choice C) The added electron enters the \(2p\) subshell, the valence subshell still being filled across period 2, not the higher-energy \(3s\) subshell; promoting it to \(n=3\) is not energetically accessible during ground-state electron capture.\n\n(Choice D) This inverts the energetics: the half-filled \(2p^3\) arrangement is the configuration of the neutral atom, and disrupting it by adding an electron is destabilizing rather than stabilizing; it is the loss of the half-filled set, not its completion, that suppresses the energy released.\n\nSkill 2$ex37$,
    'hard', '4E', $cc37$The Periodic Table: Variations of Chemical Properties with Group and Row$cc37$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a37B$Invokes rising Z_eff (which predicts the opposite trend) as the cause of the anomaly, reversing the actual driver$a37B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a37C$Misplaces the incoming electron into the wrong subshell (3s instead of 2p), confusing where ground-state electron capture occurs$a37C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a37D$Treats completing/retaining the half-filled set as stabilizing the anion, when adding the electron actually destroys the half-filled stability$a37D$ FROM q;

-- Q18 [Periodic Trends · hard · Skill 4 · ans B] (g38)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt38$In aluminum trichloride the electronegativity values are \(3.16\) for \(\text{Cl}\) and \(1.61\) for \(\text{Al}\), and the customary threshold separating ionic from covalent bonding is an electronegativity difference of about \(1.7\). Applying that threshold to the \(\text{Al}-\text{Cl}\) bond, how is the bond most appropriately classified?$qt38$,
    $op38$[{"label":"A","text":"Ionic, because \\(\\text{Al}\\) is a metal and \\(\\text{Cl}\\) is a nonmetal, so the pairing must transfer electrons outright"},{"label":"B","text":"Polar covalent, because the difference of \\(1.55\\) falls below the \\(\\sim 1.7\\) ionic threshold yet is large enough to leave the shared electrons unequally distributed"},{"label":"C","text":"Ionic, because a difference as small as \\(1.55\\) keeps the electrons close to one center and concentrates the negative charge as in an ion pair"},{"label":"D","text":"Nonpolar covalent, because the difference of \\(1.55\\) lies under the \\(1.7\\) cutoff and therefore the electrons are shared essentially evenly"}]$op38$::jsonb,
    'B',
    $ex38$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. Bond character is read directly from the electronegativity difference \(\Delta\text{EN}\): \(\Delta\text{EN} < 0.4\)-\(0.5\) is nonpolar covalent, an intermediate \(\Delta\text{EN}\) up to about \(1.7\) is polar covalent, and \(\Delta\text{EN}\) larger than roughly \(1.7\)-\(2.0\) is ionic. Here \(\Delta\text{EN} = 3.16 - 1.61 = 1.55\), which sits just below the \(\sim 1.7\) ionic threshold and well above the nonpolar ceiling, so the bond is polar covalent: the bonding electrons are shared but pulled toward the more electronegative \(\text{Cl}\), consistent with the molecular (rather than lattice) behavior of \(\text{AlCl}_3\) (choice B). (Choice A) The metal-plus-nonmetal pairing is only a rough predictor; the quantitative criterion governs, and \(\Delta\text{EN} = 1.55\) does not reach the value required for full electron transfer, so an ionic label overstates the charge separation. (Choice C) This inverts the threshold rule by treating a small difference as a marker of ionic character; in fact a larger \(\Delta\text{EN}\), not a smaller one, drives a bond toward the ionic end, so a difference of \(1.55\) cannot indicate an ion pair. (Choice D) A nonpolar classification would require \(\Delta\text{EN}\) near zero (below about \(0.4\)); a difference of \(1.55\) is far above that range, so the electrons are not shared evenly even though the value stays under the ionic cutoff. Skill 4$ex38$,
    'hard', '4E', $cc38$The Periodic Table: Variations of Chemical Properties with Group and Row$cc38$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a38A$Applies the metal + nonmetal equals ionic heuristic and ignores the numerical electronegativity-difference threshold$a38A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a38C$Inverts the threshold rule, treating a small electronegativity difference as evidence of ionic rather than covalent character$a38C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a38D$Correctly rejects ionic but undershoots to nonpolar, ignoring that 1.55 far exceeds the nonpolar ceiling near 0.4$a38D$ FROM q;

-- Q19 [Periodic Trends · medium · Skill 2 · ans C] (g39)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt39$A lab tabulates the neutral atoms \(\text{N}\), \(\text{Si}\), \(\text{Ge}\), and \(\text{Ca}\), which sit in different periods and different groups. Because no two share both a row and a column, ranking them by atomic radius requires combining the across-period and down-group directions rather than following a single arrow. Which ordering lists these atoms from largest to smallest atomic radius?$qt39$,
    $op39$[{"label":"A","text":"\\(\\text{N} > \\text{Si} > \\text{Ge} > \\text{Ca}\\)"},{"label":"B","text":"\\(\\text{Ca} > \\text{Si} > \\text{Ge} > \\text{N}\\)"},{"label":"C","text":"\\(\\text{Ca} > \\text{Ge} > \\text{Si} > \\text{N}\\)"},{"label":"D","text":"\\(\\text{Ge} > \\text{Ca} > \\text{Si} > \\text{N}\\)"}]$op39$::jsonb,
    'C',
    $ex39$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. Atomic radius increases down a group as the valence shell occupies a higher principal level \(n\), and decreases across a period as the nuclear charge and thus \(Z_\text{eff}\) rise while electrons fill the same shell. Combining both directions for this mixed set: \(\text{Ca}\) (period 4, group 2) lies far to the left of \(\text{Ge}\) (period 4, group 14), so within the same row \(\text{Ca} > \text{Ge}\); \(\text{Ge}\) sits directly below \(\text{Si}\) in group 14, so down the group \(\text{Ge} > \text{Si}\); and \(\text{N}\) (period 2, group 15) lies both up a period and to the right of \(\text{Si}\), so \(\text{Si} > \text{N}\). Chaining these gives \(\text{Ca} > \text{Ge} > \text{Si} > \text{N}\), making C correct. (Choice A) This is the exact reverse of the size order, treating the upper-right, higher-\(Z_\text{eff}\) atom \(\text{N}\) as the largest; \(Z_\text{eff}\) is greatest for \(\text{N}\), so it is the smallest, not the largest. (Choice B) The endpoints \(\text{Ca}\) and \(\text{N}\) are placed correctly, but \(\text{Si}\) and \(\text{Ge}\) are inverted; this applies only the across-period rule and neglects that \(\text{Ge}\) lies one period below \(\text{Si}\) in the same group, where the higher principal level makes \(\text{Ge}\) larger. (Choice D) Ordering by descending nuclear charge places \(\text{Ge}\) (\(Z = 32\)) first; a larger proton count raises \(Z_\text{eff}\) and contracts an atom rather than enlarging it, so atomic number does not track radius across a mixed set. Skill 2$ex39$,
    'medium', '4E', $cc39$The Periodic Table: Variations of Chemical Properties with Group and Row$cc39$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a39A$Reverses the full ranking, treating the highest-Zeff upper-right atom as the largest and ordering smallest-to-largest$a39A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a39B$Applies only the across-period trend and inverts the down-group Si/Ge step, ignoring that lower period means larger radius$a39B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a39D$Ranks by nuclear charge or electron count, assuming a higher-Z atom is larger$a39D$ FROM q;

-- Q20 [Periodic Trends · medium · Skill 1 · ans D] (g40)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'The Periodic Table', 'Periodic Trends',
    $qt40$A halogen lamp filament is sealed with a trace of one Group 17 element to scavenge stray metal atoms, and the design calls for the element whose neutral atoms most readily gain an electron. Among \(\text{F}\), \(\text{Cl}\), \(\text{Br}\), and \(\text{I}\), which element is expected to be the most reactive toward electron capture?$qt40$,
    $op40$[{"label":"A","text":"\\(\\text{I}\\), because its valence electrons lie farthest from the nucleus and are least tightly held"},{"label":"B","text":"\\(\\text{Br}\\), because it sits midway in the group and balances atomic size against nuclear charge"},{"label":"C","text":"\\(\\text{F}\\), because its small radius gives it the largest experimentally measured electron affinity in the group"},{"label":"D","text":"\\(\\text{Cl}\\), because it combines a high effective nuclear charge with a valence shell large enough to accept an electron without severe electron-electron repulsion"}]$op40$::jsonb,
    'D',
    $ex40$This is a General Chemistry question in the content category 'The Periodic Table: Variations of Chemical Properties with Group and Row'. Reactivity toward electron capture for a nonmetal tracks how favorably a neutral atom accepts an electron, which is reported by electron affinity (energy released on adding an electron). The smooth periodic trend predicts electron affinity should increase up a group, pointing to \(\text{F}\); however, the measured values break this pattern within Group 17. The incoming electron must enter the compact \(2p\) subshell of \(\text{F}\), where the small \(n=2\) valence region forces strong electron-electron repulsion, lowering the energy released. \(\text{Cl}\) has a larger \(3p\) valence shell that accommodates the added electron with less repulsion while still feeling a high \(Z_\text{eff}\), so \(\text{Cl}\) has the most negative (most exothermic) electron affinity of the halogens and is the most reactive toward gaining an electron. (Choice A) \(\text{I}\) has valence electrons farthest from the nucleus, but distance and low \(Z_\text{eff}\) reduce the attraction for an added electron, giving iodine the smallest electron affinity of the group, not the largest. (Choice B) \(\text{Br}\) lies between \(\text{Cl}\) and \(\text{I}\) in electron affinity; an intermediate position does not make it the most reactive, and "balancing size against charge" does not identify a maximum. (Choice C) The reasoning that small radius yields the largest electron affinity reflects the idealized top-of-group trend, but the actual measured electron affinity of \(\text{F}\) is less exothermic than that of \(\text{Cl}\) because of repulsion in the small \(2p\) shell. Skill 1$ex40$,
    'medium', '4E', $cc40$The Periodic Table: Variations of Chemical Properties with Group and Row$cc40$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a40A$treats the metal-reactivity logic (loosely held, far electrons = more reactive) as the driver for a nonmetal gaining an electron, reversing the trend direction$a40A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a40B$assumes the most reactive member is the midpoint of the group via a vague size-charge balance$a40B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a40C$applies the idealized increase-up-a-group electron affinity trend, correct for the general rule but failing on the anomalous fluorine value$a40C$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch2_questions FROM questions WHERE topic='The Periodic Table' AND subtopic IN ('Types of Elements', 'Periodic Trends');
