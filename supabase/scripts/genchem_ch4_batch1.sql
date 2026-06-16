-- GenChem Ch4 (Compounds & Stoichiometry) — Batch 1 of 3: Moles, Molar Mass, Formulas & Percent Composition
-- 25 questions, all confidence >=4 (OpenStax Atoms First 2e; every calculation independently re-verified); cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- AAMC foundation 4E "Stoichiometry (GC)" for most rows; the ions/nomenclature/electrolytes items are tagged 5A "Ions in Solutions (GC)".
-- Out of MCAT scope and deliberately excluded: normality / equivalents / gram-equivalent weight, molarity calcs.
-- Re-runnable (subtopic-scoped DELETE). Run the three batches in any order in the Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Compounds & Stoichiometry' AND subtopic IN ('Molecules, Moles & Molar Mass', 'Empirical & Molecular Formula + Percent Composition');

-- Q1 [Molecules, Moles & Molar Mass · easy · Skill 2 · 4E Stoichiometry (GC) · ans A] (g1)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt1$Glucose has the molecular formula \(\text{C}_6\text{H}_{12}\text{O}_6\). Using atomic weights of \(12.01\) for carbon, \(1.008\) for hydrogen, and \(16.00\) for oxygen, what is its molar mass in \(\text{g/mol}\)?$qt1$,
    $op1$[{"label":"A","text":"\\(180.16\\)"},{"label":"B","text":"\\(29.02\\)"},{"label":"C","text":"\\(270.11\\)"},{"label":"D","text":"\\(174.11\\)"}]$op1$::jsonb,
    'A',
    $ex1$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the molar mass of a compound is the sum of the atomic weights of every atom in its molecular formula, each multiplied by its subscript. For \(\text{C}_6\text{H}_{12}\text{O}_6\): carbon contributes \(6 \times 12.01 = 72.06\), hydrogen contributes \(12 \times 1.008 = 12.096\), and oxygen contributes \(6 \times 16.00 = 96.00\). Summing gives \(72.06 + 12.096 + 96.00 = 180.156 \approx 180.16\,\text{g/mol}\). (Choice B) \(29.02\) results from summing one atom of each element, \(12.01 + 1.008 + 16.00\), and ignoring the subscripts that count how many of each atom are present. (Choice C) \(270.11\) results from swapping the hydrogen and oxygen subscripts, computing \(6(12.01) + 6(1.008) + 12(16.00)\), which applies the count of \(12\) to oxygen rather than hydrogen. (Choice D) \(174.11\) results from treating every subscript as \(6\), computing \(6(12.01) + 6(1.008) + 6(16.00)\) as though the formula were \(\text{C}_6\text{H}_6\text{O}_6\), which undercounts the hydrogen atoms. Skill 2$ex1$,
    'easy', '4E', $cc1$Stoichiometry (GC)$cc1$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a1B$summed one atom of each element and ignored the formula subscripts$a1B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a1C$swapped the hydrogen and oxygen subscripts when multiplying$a1C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a1D$applied the same subscript of 6 to all three elements (off-by-subscript on hydrogen)$a1D$ FROM q;

-- Q2 [Molecules, Moles & Molar Mass · easy · Skill 2 · 4E Stoichiometry (GC) · ans C] (g2)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt2$A technician needs the molar mass of potassium dichromate, \(\text{K}_2\text{Cr}_2\text{O}_7\), to prepare a standard solution. Using the atomic weights \(\text{K}=39.10\), \(\text{Cr}=52.00\), and \(\text{O}=16.00\) (all in \(\text{g/mol}\)), what is the molar mass of the compound?$qt2$,
    $op2$[{"label":"A","text":"\\(242.20\\,\\text{g/mol}\\)"},{"label":"B","text":"\\(255.10\\,\\text{g/mol}\\)"},{"label":"C","text":"\\(294.20\\,\\text{g/mol}\\)"},{"label":"D","text":"\\(278.20\\,\\text{g/mol}\\)"}]$op2$::jsonb,
    'C',
    $ex2$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the formula \(\text{K}_2\text{Cr}_2\text{O}_7\) contains 2 potassium atoms, 2 chromium atoms, and 7 oxygen atoms, and the molar mass is the sum of each atom's contribution. Computing each term: potassium gives \(2 \times 39.10 = 78.20\,\text{g/mol}\), chromium gives \(2 \times 52.00 = 104.00\,\text{g/mol}\), and oxygen gives \(7 \times 16.00 = 112.00\,\text{g/mol}\). Adding these contributions: \(78.20 + 104.00 + 112.00 = 294.20\,\text{g/mol}\). (Choice A) The value \(242.20\,\text{g/mol}\) results from counting only 1 chromium atom \((1 \times 52.00 = 52.00)\) rather than the 2 indicated by the subscript, giving \(78.20 + 52.00 + 112.00\). (Choice B) The value \(255.10\,\text{g/mol}\) results from counting only 1 potassium atom \((1 \times 39.10 = 39.10)\) rather than the 2 indicated by the subscript, giving \(39.10 + 104.00 + 112.00\). (Choice D) The value \(278.20\,\text{g/mol}\) results from using 6 oxygen atoms \((6 \times 16.00 = 96.00)\) instead of the 7 indicated by the subscript, giving \(78.20 + 104.00 + 96.00\). Skill 2$ex2$,
    'easy', '4E', $cc2$Stoichiometry (GC)$cc2$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a2A$Drops the chromium subscript, counting 1 Cr instead of 2$a2A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a2B$Drops the potassium subscript, counting 1 K instead of 2$a2B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a2D$Uses 6 oxygen atoms instead of the 7 given by the subscript$a2D$ FROM q;

-- Q3 [Molecules, Moles & Molar Mass · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g3)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt3$Using atomic masses \(\text{Mg}=24.31\), \(\text{O}=16.00\), and \(\text{H}=1.008\), what is the molar mass of magnesium hydroxide, \(\text{Mg(OH)}_2\)?$qt3$,
    $op3$[{"label":"A","text":"\\(41.32\\,\\text{g/mol}\\)"},{"label":"B","text":"\\(42.33\\,\\text{g/mol}\\)"},{"label":"C","text":"\\(57.32\\,\\text{g/mol}\\)"},{"label":"D","text":"\\(58.33\\,\\text{g/mol}\\)"}]$op3$::jsonb,
    'D',
    $ex3$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the subscript \(2\) in \(\text{Mg(OH)}_2\) applies to the entire hydroxide group, so the formula contains one \(\text{Mg}\), two \(\text{O}\), and two \(\text{H}\). Computing: the mass of one \(\text{OH}\) group is \(16.00+1.008=17.008\,\text{g/mol}\); doubling it gives \(2(17.008)=34.02\,\text{g/mol}\); adding magnesium gives \(24.31+34.02=58.33\,\text{g/mol}\). (Choice A) \(41.32\,\text{g/mol}\) results from treating the subscript as if there were only one hydroxide group, \(24.31+17.008\), failing to multiply the parenthetical group by \(2\). (Choice B) \(42.33\,\text{g/mol}\) results from doubling only the hydrogen while leaving a single oxygen, \(24.31+16.00+2(1.008)\), so the subscript is applied to only one atom inside the parentheses. (Choice C) \(57.32\,\text{g/mol}\) results from doubling only the oxygen while leaving a single hydrogen, \(24.31+2(16.00)+1.008\), again distributing the subscript to only one atom in the group. Skill 2$ex3$,
    'medium', '4E', $cc3$Stoichiometry (GC)$cc3$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a3A$Failed to apply the parenthetical subscript to the hydroxide group, counting only one OH$a3A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a3B$Applied the subscript to only the hydrogen atom, leaving oxygen un-doubled$a3B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a3C$Applied the subscript to only the oxygen atom, leaving hydrogen un-doubled$a3C$ FROM q;

-- Q4 [Molecules, Moles & Molar Mass · hard · Skill 2 · 4E Stoichiometry (GC) · ans B] (g4)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt4$Aluminum sulfate, \(\text{Al}_2(\text{SO}_4)_3\), is assembled from atomic weights of \(\text{Al} = 27.0\), \(\text{S} = 32.1\), and \(\text{O} = 16.0\) (all in \(\text{g/mol}\)). The formula mass of this compound in \(\text{g/mol}\) is closest to$qt4$,
    $op4$[{"label":"A","text":"\\(150.1\\)"},{"label":"B","text":"\\(342.3\\)"},{"label":"C","text":"\\(214.3\\)"},{"label":"D","text":"\\(278.1\\)"}]$op4$::jsonb,
    'B',
    $ex4$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the subscript \(3\) outside the parentheses multiplies every atom inside, giving \(3\) sulfur and \(12\) oxygen atoms, and the full atom inventory summed against the given atomic weights totals \(342.3\,\text{g/mol}\). The formula \(\text{Al}_2(\text{SO}_4)_3\) contains \(2\) aluminum atoms, \(3 \times 1 = 3\) sulfur atoms, and \(3 \times 4 = 12\) oxygen atoms. Summing the masses: \(2 \times 27.0 = 54.0\) for aluminum, \(3 \times 32.1 = 96.3\) for sulfur, and \(12 \times 16.0 = 192.0\) for oxygen, so the formula mass is \(54.0 + 96.3 + 192.0 = 342.3\,\text{g/mol}\). (Choice A) This value \(150.1\) results from ignoring the parenthetical subscript \(3\) entirely and counting only \(2\) aluminum, \(1\) sulfur, and \(4\) oxygen: \(54.0 + 32.1 + 64.0 = 150.1\), which fails to apply the multiplier to the polyatomic group at all. (Choice C) This value \(214.3\) results from distributing the subscript \(3\) to sulfur but not to oxygen, counting \(3\) sulfur yet only \(4\) oxygen: \(54.0 + 96.3 + 64.0 = 214.3\), which stops the multiplication one atom short inside the parentheses. (Choice D) This value \(278.1\) results from distributing the subscript \(3\) to oxygen but not to sulfur, counting \(12\) oxygen yet only \(1\) sulfur: \(54.0 + 32.1 + 192.0 = 278.1\), which applies the multiplier inconsistently across the two atoms in the group. Skill 2$ex4$,
    'hard', '4E', $cc4$Stoichiometry (GC)$cc4$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a4A$parenthetical subscript ignored entirely$a4A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a4C$subscript distributed to S but not O (off-by-subscript on oxygen)$a4C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a4D$subscript distributed to O but not S (off-by-subscript on sulfur)$a4D$ FROM q;

-- Q5 [Molecules, Moles & Molar Mass · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g5)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt5$A technician needs the molar mass of barium chloride, \(\text{BaCl}_2\), to prepare a standard solution. Using \(\text{Ba}=137.33\,\text{g/mol}\) and \(\text{Cl}=35.45\,\text{g/mol}\), the molar mass is closest to:$qt5$,
    $op5$[{"label":"A","text":"\\(208.23\\,\\text{g/mol}\\)"},{"label":"B","text":"\\(172.78\\,\\text{g/mol}\\)"},{"label":"C","text":"\\(243.68\\,\\text{g/mol}\\)"},{"label":"D","text":"\\(310.11\\,\\text{g/mol}\\)"}]$op5$::jsonb,
    'A',
    $ex5$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the molar mass of \(\text{BaCl}_2\) is the sum of one barium atom and two chlorine atoms, with the subscript \(2\) applied only to chlorine: \(137.33 + 2(35.45) = 137.33 + 70.90 = 208.23\,\text{g/mol}\). (Choice B) \(172.78\,\text{g/mol}\) comes from dropping the chlorine subscript and adding only one chlorine, \(137.33 + 35.45\), treating the formula as \(\text{BaCl}\). (Choice C) \(243.68\,\text{g/mol}\) results from using a subscript of \(3\) instead of \(2\) for chlorine, \(137.33 + 3(35.45) = 137.33 + 106.35\). (Choice D) \(310.11\,\text{g/mol}\) results from applying the subscript \(2\) to barium instead of chlorine, \(2(137.33) + 35.45 = 274.66 + 35.45\). Skill 2$ex5$,
    'medium', '4E', $cc5$Stoichiometry (GC)$cc5$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a5B$Omits the chlorine subscript and adds only one Cl (treats formula as BaCl)$a5B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a5C$Uses a chlorine subscript of 3 instead of 2$a5C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a5D$Applies the subscript 2 to barium instead of chlorine$a5D$ FROM q;

-- Q6 [Molecules, Moles & Molar Mass · medium · Skill 1 · 4E Stoichiometry (GC) · ans C] (g6)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt6$Solid magnesium chloride, \(\text{MgCl}_2\), is an ionic compound whose crystal lattice contains no discrete two-atom units, whereas carbon dioxide, \(\text{CO}_2\), exists as separate three-atom units. For the mass obtained by summing the atomic weights in one \(\text{MgCl}_2\) unit, which term is the appropriate one to use?$qt6$,
    $op6$[{"label":"A","text":"Molecular weight, because the summed atomic weights of any compound are called its molecular weight"},{"label":"B","text":"Molecular weight, because \\(\\text{MgCl}_2\\) contains three atoms held together just as \\(\\text{CO}_2\\) does"},{"label":"C","text":"Formula weight, because \\(\\text{MgCl}_2\\) has no discrete molecules and the formula represents only the smallest whole-number ion ratio"},{"label":"D","text":"Formula weight, because the mass of an ionic compound is found from its ion charges rather than from atomic weights"}]$op6$::jsonb,
    'C',
    $ex6$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because an ionic solid such as \(\text{MgCl}_2\) does not exist as discrete molecules: its crystal is a continuous lattice of \(\text{Mg}^{2+}\) and \(\text{Cl}^{-}\) ions, and the chemical formula \(\text{MgCl}_2\) states only the smallest whole-number ratio of those ions (one \(\text{Mg}^{2+}\) per two \(\text{Cl}^{-}\)). Because there is no real molecule to weigh, the mass obtained by summing the atomic weights in one formula unit is called the formula weight (or formula mass). The term molecular weight is reserved for covalent species like \(\text{CO}_2\) that truly exist as separate discrete molecules; for such a molecule the summed atomic weights describe an actual particle. The arithmetic of summing atomic weights is identical for both terms, so the distinction is purely about whether discrete molecules exist. (Choice A) The claim that summed atomic weights are called molecular weight for any compound is incorrect; that name applies only to compounds made of discrete molecules, while ionic compounds, which have no molecules, use formula weight. (Choice B) An ionic formula unit is not a bonded three-atom molecule like \(\text{CO}_2\); the \(\text{Mg}^{2+}\) and \(\text{Cl}^{-}\) ions sit in an extended lattice rather than as an isolated \(\text{MgCl}_2\) particle, so the comparison to \(\text{CO}_2\) fails and molecular weight is the wrong term. (Choice D) Although formula weight is the correct term, the stated reason is wrong: a formula weight is calculated by summing atomic weights of the atoms in the formula, not from the ion charges; the charges only determine the subscripts in the formula, not the mass. Skill 1$ex6$,
    'medium', '4E', $cc6$Stoichiometry (GC)$cc6$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a6A$Believes 'molecular weight' is a universal term for summed atomic weights of every compound, ignoring that ionic solids lack discrete molecules$a6A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a6B$Correctly counts atoms in the formula but wrongly treats an ionic formula unit as a bonded discrete molecule like CO2$a6B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a6D$Picks the right term but confuses how the value is obtained, attributing the mass to ion charges instead of summed atomic weights$a6D$ FROM q;

-- Q7 [Molecules, Moles & Molar Mass · easy · Skill 2 · 4E Stoichiometry (GC) · ans D] (g7)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt7$A technician sets out four separate \(10.0\ \text{g}\) samples, one each of methane (\(\text{CH}_4 = 16.0\ \text{g/mol}\)), nitrogen gas (\(\text{N}_2 = 28.0\ \text{g/mol}\)), oxygen gas (\(\text{O}_2 = 32.0\ \text{g/mol}\)), and carbon dioxide (\(\text{CO}_2 = 44.0\ \text{g/mol}\)). The sample most likely to contain the greatest number of moles is the$qt7$,
    $op7$[{"label":"A","text":"carbon dioxide, \\(\\text{CO}_2\\) (\\(44.0\\ \\text{g/mol}\\))."},{"label":"B","text":"oxygen gas, \\(\\text{O}_2\\) (\\(32.0\\ \\text{g/mol}\\))."},{"label":"C","text":"nitrogen gas, \\(\\text{N}_2\\) (\\(28.0\\ \\text{g/mol}\\))."},{"label":"D","text":"methane, \\(\\text{CH}_4\\) (\\(16.0\\ \\text{g/mol}\\))."}]$op7$::jsonb,
    'D',
    $ex7$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the number of moles in a fixed mass is given by \(n = \frac{m}{M}\), so when the mass \(m\) is held constant across all four samples, the mole count is largest for the substance with the smallest molar mass \(M\), and \(\text{CH}_4\) at \(16.0\ \text{g/mol}\) has the smallest molar mass of the four. Dividing the common \(10.0\ \text{g}\) mass by each molar mass gives \(\text{CH}_4: \frac{10.0}{16.0} = 0.625\ \text{mol}\); \(\text{N}_2: \frac{10.0}{28.0} = 0.357\ \text{mol}\); \(\text{O}_2: \frac{10.0}{32.0} = 0.313\ \text{mol}\); and \(\text{CO}_2: \frac{10.0}{44.0} = 0.227\ \text{mol}\). Methane yields the most moles because each gram of it corresponds to more particles when its formula mass is lower. (Choice A) \(\text{CO}_2\) has the largest molar mass (\(44.0\ \text{g/mol}\)) and therefore the fewest moles (\(0.227\ \text{mol}\)) in a \(10.0\ \text{g}\) sample; selecting it reverses the inverse relationship between molar mass and mole count, treating the heaviest molar mass as if it produced the most moles. (Choice B) \(\text{O}_2\) (\(32.0\ \text{g/mol}\)) gives \(0.313\ \text{mol}\), more than \(\text{CO}_2\) but still fewer than \(\text{CH}_4\); it is an intermediate molar mass, not the smallest, so it does not maximize the mole count. (Choice C) \(\text{N}_2\) (\(28.0\ \text{g/mol}\)) gives \(0.357\ \text{mol}\), the second-greatest amount, but its molar mass is still larger than that of \(\text{CH}_4\), so a \(10.0\ \text{g}\) sample of \(\text{N}_2\) contains fewer moles than the same mass of methane. Skill 2$ex7$,
    'easy', '4E', $cc7$Stoichiometry (GC)$cc7$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a7A$selects the largest molar mass as giving the most moles, inverting the n = m/M relationship for fixed mass$a7A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a7B$picks an intermediate molar mass that gives more moles than the heaviest but is not the smallest$a7B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a7C$picks the second-smallest molar mass, close to but not the actual smallest$a7C$ FROM q;

-- Q8 [Molecules, Moles & Molar Mass · medium · Skill 2 · 4E Stoichiometry (GC) · ans B] (g8)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt8$A technician weighs out \(47.65\,\text{g}\) of pure magnesium chloride, \(\text{MgCl}_2\), to dissolve for a later dilution. Using atomic masses \(\text{Mg} = 24.30\) and \(\text{Cl} = 35.45\), how many moles of \(\text{MgCl}_2\) does this mass represent?$qt8$,
    $op8$[{"label":"A","text":"\\(0.797\\,\\text{mol}\\)"},{"label":"B","text":"\\(0.500\\,\\text{mol}\\)"},{"label":"C","text":"\\(0.671\\,\\text{mol}\\)"},{"label":"D","text":"\\(2.00\\,\\text{mol}\\)"}]$op8$::jsonb,
    'B',
    $ex8$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because dividing the given mass by the correctly summed molar mass of the compound yields the number of moles. The molar mass of \(\text{MgCl}_2\) is the sum of one Mg and two Cl: \(24.30 + 2(35.45) = 24.30 + 70.90 = 95.30\,\text{g/mol}\). Moles \(= \dfrac{\text{mass}}{\text{molar mass}} = \dfrac{47.65\,\text{g}}{95.30\,\text{g/mol}} = 0.500\,\text{mol}\), which is the setup quantity for any subsequent dilution or stoichiometric step. (Choice A) \(0.797\,\text{mol}\) results from using only one chlorine in the molar mass, \(24.30 + 35.45 = 59.75\,\text{g/mol}\), so the subscript-2 on chlorine is dropped before dividing. (Choice C) \(0.671\,\text{mol}\) results from counting only the two chlorine atoms and omitting magnesium, \(2(35.45) = 70.90\,\text{g/mol}\), then dividing \(47.65/70.90\). (Choice D) \(2.00\,\text{mol}\) results from inverting the conversion and dividing the molar mass by the mass, \(95.30/47.65\), rather than mass by molar mass. Skill 2$ex8$,
    'medium', '4E', $cc8$Stoichiometry (GC)$cc8$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a8A$off_by_subscript_dropped_chlorine_count$a8A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a8C$omitted_one_element_from_molar_mass_sum$a8C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a8D$inverted_mass_over_molar_mass_division$a8D$ FROM q;

-- Q9 [Molecules, Moles & Molar Mass · hard · Skill 4 · 4E Stoichiometry (GC) · ans D] (g9)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt9$A sample of solid calcium phosphate, \(\text{Ca}_3(\text{PO}_4)_2\) (molar mass \(310.18\ \text{g/mol}\); atomic mass of \(\text{O}=16.00\ \text{g/mol}\)), has a mass of \(62.0\ \text{g}\). How many moles of oxygen atoms does this sample contain?$qt9$,
    $op9$[{"label":"A","text":"\\(0.200\\ \\text{mol O}\\)"},{"label":"B","text":"\\(0.800\\ \\text{mol O}\\)"},{"label":"C","text":"\\(0.400\\ \\text{mol O}\\)"},{"label":"D","text":"\\(1.60\\ \\text{mol O}\\)"}]$op9$::jsonb,
    'D',
    $ex9$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because each formula unit of \(\text{Ca}_3(\text{PO}_4)_2\) contains \(2\times4 = 8\) oxygen atoms, so the moles of oxygen atoms equal eight times the moles of the compound. First convert mass to moles of compound: \(\frac{62.0\ \text{g}}{310.18\ \text{g/mol}} = 0.200\ \text{mol}\ \text{Ca}_3(\text{PO}_4)_2\). Then apply the oxygen-to-formula ratio: \(0.200\ \text{mol}\times 8 = 1.60\ \text{mol O}\). (Choice A) \(0.200\ \text{mol}\) is the moles of the compound itself; this value omits the final step of multiplying by the 8 oxygen atoms per formula unit. (Choice B) \(0.800\ \text{mol}\) results from counting only the 4 oxygen atoms inside a single \(\text{PO}_4\) group and ignoring the subscript \(2\) outside the parentheses, giving \(0.200\times 4\). (Choice C) \(0.400\ \text{mol}\) results from multiplying the moles of compound by only the subscript \(2\) outside the parentheses, \(0.200\times 2\), rather than by the total of \(8\) oxygen atoms per formula unit. Skill 4$ex9$,
    'hard', '4E', $cc9$Stoichiometry (GC)$cc9$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a9A$Reports the moles of the compound and stops before scaling by atoms of the target element per formula unit$a9A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a9B$Counts oxygen atoms in only one polyatomic group, ignoring the multiplier subscript outside the parentheses (off-by-subscript)$a9B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a9C$Multiplies moles of compound by the parenthetical subscript alone instead of the full atom count per formula unit$a9C$ FROM q;

-- Q10 [Molecules, Moles & Molar Mass · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g10)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt10$A fertilizer sample contains \(33.0\,\text{g}\) of pure ammonium sulfate, \((\text{NH}_4)_2\text{SO}_4\) (molar mass \(132.15\,\text{g/mol}\)). How many moles of nitrogen atoms does this sample contain?$qt10$,
    $op10$[{"label":"A","text":"\\(0.500\\ \\text{mol N}\\)"},{"label":"B","text":"\\(0.250\\ \\text{mol N}\\)"},{"label":"C","text":"\\(1.00\\ \\text{mol N}\\)"},{"label":"D","text":"\\(1.18\\ \\text{mol N}\\)"}]$op10$::jsonb,
    'A',
    $ex10$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because chaining mass to moles of compound to moles of element gives one-half mole of nitrogen. First convert mass to moles of compound: \(33.0\,\text{g} \div 132.15\,\text{g/mol} = 0.2497\,\text{mol }(\text{NH}_4)_2\text{SO}_4\). Each formula unit of \((\text{NH}_4)_2\text{SO}_4\) contains two ammonium ions, so it holds \(2\) nitrogen atoms. Multiply by the element-to-compound ratio: \(0.2497\,\text{mol} \times 2 = 0.499 \approx 0.500\,\text{mol N}\). (Choice B) \(0.250\,\text{mol}\) is the moles of compound \((33.0 \div 132.15)\) reported as the final answer; it omits the final step of multiplying by the \(2\) nitrogen atoms per formula unit. (Choice C) \(1.00\,\text{mol}\) results from multiplying the moles of compound by \(4\) instead of \(2\), misreading the subscript \(4\) in \(\text{NH}_4\) as the count of nitrogen atoms rather than hydrogen atoms. (Choice D) \(1.18\,\text{mol}\) comes from dividing the \(33.0\,\text{g}\) by \(28.02\,\text{g/mol}\) (the combined mass of two nitrogen atoms) instead of by the molar mass of the whole compound, treating the nitrogen content as if it were the entire sample mass. Skill 4$ex10$,
    'hard', '4E', $cc10$Stoichiometry (GC)$cc10$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a10B$Stops at moles of compound and omits the compound-to-element multiplication by 2 N per formula unit$a10B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a10C$Uses the subscript 4 from NH4 as the nitrogen-atom count, multiplying by 4 instead of 2$a10C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a10D$Divides the sample mass by the mass of 2 N atoms (28.02 g/mol) instead of the full compound molar mass$a10D$ FROM q;

-- Q11 [Molecules, Moles & Molar Mass · hard · Skill 4 · 4E Stoichiometry (GC) · ans C] (g11)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Molecules, Moles & Molar Mass',
    $qt11$A sample of magnesium bromide \(\text{MgBr}_2\) has a mass of \(9.21\ \text{g}\). Given molar masses \(\text{Mg} = 24.31\ \text{g/mol}\) and \(\text{Br} = 79.90\ \text{g/mol}\), how many bromide ions \(\text{Br}^-\) does the sample contain?$qt11$,
    $op11$[{"label":"A","text":"\\(3.01\\times10^{22}\\) bromide ions"},{"label":"B","text":"\\(0.0500\\) bromide ions"},{"label":"C","text":"\\(6.02\\times10^{22}\\) bromide ions"},{"label":"D","text":"\\(1.66\\times10^{-25}\\) bromide ions"}]$op11$::jsonb,
    'C',
    $ex11$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because converting mass to moles of compound, then to moles of bromide ion, then to ion count gives \(6.02\times10^{22}\) bromide ions. First the molar mass of \(\text{MgBr}_2\) is \(24.31 + 2(79.90) = 184.11\ \text{g/mol}\). Moles of compound: \(\frac{9.21\ \text{g}}{184.11\ \text{g/mol}} = 0.0500\ \text{mol}\ \text{MgBr}_2\). Each formula unit releases \(2\ \text{Br}^-\), so moles of bromide \(= 0.0500 \times 2 = 0.100\ \text{mol}\ \text{Br}^-\). Multiplying by Avogadro's number: \(0.100 \times 6.022\times10^{23} = 6.02\times10^{22}\) bromide ions. (Choice A) This results from converting \(0.0500\ \text{mol}\) of compound directly to ions, \(0.0500 \times 6.022\times10^{23} = 3.01\times10^{22}\), omitting the factor of \(2\) bromide ions per formula unit. (Choice B) This is simply the moles of \(\text{MgBr}_2\), \(0.0500\), reported as if moles equaled the ion count without applying Avogadro's number at all. (Choice D) This results from dividing the moles of bromide by Avogadro's number, \(\frac{0.100}{6.022\times10^{23}} = 1.66\times10^{-25}\), rather than multiplying by it. Skill 4$ex11$,
    'hard', '4E', $cc11$Stoichiometry (GC)$cc11$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a11A$omits the 2 bromide ions per formula unit, converting moles of compound directly to ion count$a11A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a11B$treats moles of compound as the ion count without applying Avogadro's number$a11B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a11D$divides moles by Avogadro's number instead of multiplying$a11D$ FROM q;

-- Q12 [Empirical & Molecular Formula + Percent Composition · easy · Skill 2 · 4E Stoichiometry (GC) · ans B] (g12)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt12$Ethanol has the molecular formula \(\text{C}_2\text{H}_6\text{O}\). Using atomic weights \(\text{C}=12.01\), \(\text{H}=1.008\), and \(\text{O}=16.00\;\text{g/mol}\), determine the percent composition by mass of carbon in ethanol.$qt12$,
    $op12$[{"label":"A","text":"26.1%"},{"label":"B","text":"52.1%"},{"label":"C","text":"58.6%"},{"label":"D","text":"22.2%"}]$op12$::jsonb,
    'B',
    $ex12$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the mass percent of an element equals the total mass contributed by that element divided by the molar mass of the whole compound, times 100. First sum the atomic weights to get the molar mass of \(\text{C}_2\text{H}_6\text{O}\): carbon contributes \(2\times12.01=24.02\), hydrogen contributes \(6\times1.008=6.048\), and oxygen contributes \(1\times16.00=16.00\), for a total of \(24.02+6.048+16.00=46.07\;\text{g/mol}\). The carbon mass percent is then \(\frac{24.02}{46.07}\times100=52.1\%\). (Choice A) 26.1% comes from using only one carbon atom, \(\frac{12.01}{46.07}\times100\), ignoring the subscript 2 on carbon while keeping the correct full molar mass in the denominator. (Choice C) 58.6% comes from dropping five of the six hydrogen atoms, computing \(\frac{24.02}{24.02+1.008+16.00}\times100\) with a denominator of \(41.03\;\text{g/mol}\) instead of the correct \(46.07\). (Choice D) 22.2% comes from counting atoms rather than mass, taking the 2 carbon atoms out of the 9 total atoms in the formula, \(\frac{2}{9}\times100\), which is not a mass-based percent composition. Skill 2$ex12$,
    'easy', '4E', $cc12$Stoichiometry (GC)$cc12$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a12A$off-by-subscript: used 1 C atom instead of 2 in the numerator$a12A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a12C$off-by-subscript: used 1 H atom instead of 6, shrinking the molar-mass denominator$a12C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a12D$percent by atom count (2 of 9 atoms) instead of percent by mass$a12D$ FROM q;

-- Q13 [Empirical & Molecular Formula + Percent Composition · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g13)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt13$A fertilizer's nitrogen rating depends on the mass percent of \(\text{N}\) in its active compound. Urea, \(\text{CH}_4\text{N}_2\text{O}\), has a molar mass of \(60.06\ \text{g/mol}\) (atomic masses: \(\text{C}=12.01\), \(\text{H}=1.008\), \(\text{N}=14.01\), \(\text{O}=16.00\)). What is the mass percent of nitrogen in urea?$qt13$,
    $op13$[{"label":"A","text":"\\(46.7\\%\\)"},{"label":"B","text":"\\(23.3\\%\\)"},{"label":"C","text":"\\(26.6\\%\\)"},{"label":"D","text":"\\(28.0\\%\\)"}]$op13$::jsonb,
    'A',
    $ex13$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the mass percent of an element equals the total mass contributed by that element in one mole of the compound divided by the compound's molar mass, times 100. Urea, \(\text{CH}_4\text{N}_2\text{O}\), contains two nitrogen atoms, so the nitrogen mass in one mole is \(2\times14.01=28.02\ \text{g}\). Dividing by the molar mass and converting to a percent gives \(\frac{28.02}{60.06}\times100=46.7\%\). (Choice B) The value \(23.3\%\) comes from using a single nitrogen atom, \(\frac{14.01}{60.06}\times100\), which drops the subscript \(2\) on nitrogen and counts only one of the two N atoms present in the formula. (Choice C) The value \(26.6\%\) is the mass percent of oxygen, \(\frac{16.00}{60.06}\times100\), obtained by computing the contribution of the wrong element rather than nitrogen. (Choice D) The value \(28.0\%\) reports the nitrogen mass of \(28.02\ \text{g}\) directly as a percentage, omitting the division by the \(60.06\ \text{g/mol}\) molar mass and treating a mass in grams as if it were already a percent. Skill 2$ex13$,
    'medium', '4E', $cc13$Stoichiometry (GC)$cc13$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a13B$used one nitrogen atom instead of two (ignored the subscript 2)$a13B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a13C$computed mass percent of oxygen instead of nitrogen$a13C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a13D$reported nitrogen mass in grams as the percent (skipped division by molar mass)$a13D$ FROM q;

-- Q14 [Empirical & Molecular Formula + Percent Composition · medium · Skill 4 · 4E Stoichiometry (GC) · ans C] (g14)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt14$A compound contains only carbon, hydrogen, and oxygen and is found by analysis to be 40.0% C, 6.7% H, and 53.3% O by mass. Using atomic masses \(\text{C}=12.01\), \(\text{H}=1.008\), and \(\text{O}=16.00\,\text{g/mol}\), what is its empirical formula?$qt14$,
    $op14$[{"label":"A","text":"\\(\\text{C}_2\\text{H}_4\\text{O}_2\\)"},{"label":"B","text":"\\(\\text{C}_6\\text{H}\\text{O}_8\\)"},{"label":"C","text":"\\(\\text{CH}_2\\text{O}\\)"},{"label":"D","text":"\\(\\text{CHO}\\)"}]$op14$::jsonb,
    'C',
    $ex14$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because converting each mass percent to moles and dividing by the smallest mole value gives a 1:2:1 ratio, the simplest whole-number formula \(\text{CH}_2\text{O}\). Taking a 100 g sample makes the percentages numerically equal to grams: 40.0 g C, 6.7 g H, and 53.3 g O. Dividing each mass by its atomic mass gives moles: \(40.0/12.01 = 3.33\,\text{mol C}\), \(6.7/1.008 = 6.65\,\text{mol H}\), and \(53.3/16.00 = 3.33\,\text{mol O}\). Dividing every value by the smallest (3.33) yields \(\text{C}:1.00\), \(\text{H}:2.00\), \(\text{O}:1.00\), so the empirical (simplest whole-number) formula is \(\text{CH}_2\text{O}\). (Choice A) \(\text{C}_2\text{H}_4\text{O}_2\) is the 2:4:2 ratio, which is a whole-number multiple of the correct ratio rather than the reduced one; an empirical formula must be expressed in the smallest whole-number subscripts, so this multiple must be divided down to \(\text{CH}_2\text{O}\). (Choice B) \(\text{C}_6\text{H}\text{O}_8\) results from treating the mass percentages (40.0, 6.7, 53.3) directly as mole counts and dividing by the smallest value 6.7 to get roughly 6:1:8, which skips the required step of dividing each mass by its atomic mass to convert grams to moles. (Choice D) \(\text{CHO}\) assumes one atom of each element because the carbon and oxygen mole values happen to be equal (3.33 each), but this overlooks that hydrogen is present at 6.65 mol, twice the others, so the hydrogen subscript must be 2 rather than 1. Skill 4$ex14$,
    'medium', '4E', $cc14$Stoichiometry (GC)$cc14$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a14A$Reports a whole-number multiple of the ratio (2:4:2) instead of reducing to the simplest whole-number subscripts$a14A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a14B$Uses the mass percentages directly as mole counts, skipping division by each element's atomic mass to convert grams to moles$a14B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a14D$Assumes a 1:1:1 atom ratio because carbon and oxygen moles are equal, ignoring that hydrogen moles are double$a14D$ FROM q;

-- Q15 [Empirical & Molecular Formula + Percent Composition · hard · Skill 4 · 4E Stoichiometry (GC) · ans D] (g15)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt15$A binary chromium oxide is found to be \(68.4\%\) chromium and \(31.6\%\) oxygen by mass (atomic masses: \(\text{Cr} = 52.0\,\text{g/mol}\), \(\text{O} = 16.0\,\text{g/mol}\)). Based on a \(100\,\text{g}\) sample, the empirical formula of this oxide is most likely$qt15$,
    $op15$[{"label":"A","text":"\\(\\text{Cr}_2\\text{O}\\)"},{"label":"B","text":"\\(\\text{Cr}_3\\text{O}_2\\)"},{"label":"C","text":"\\(\\text{CrO}\\)"},{"label":"D","text":"\\(\\text{Cr}_2\\text{O}_3\\)"}]$op15$::jsonb,
    'D',
    $ex15$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because converting each element's mass to moles and reducing the mole ratio to smallest whole numbers yields \(\text{Cr}_2\text{O}_3\). Taking a \(100\,\text{g}\) sample gives \(68.4\,\text{g}\) Cr and \(31.6\,\text{g}\) O. Dividing each mass by its atomic mass converts grams to moles: \(\text{Cr} = 68.4 / 52.0 = 1.32\,\text{mol}\) and \(\text{O} = 31.6 / 16.0 = 1.975\,\text{mol}\). Dividing both by the smaller value gives \(\text{Cr}:\text{O} = 1.32/1.32 : 1.975/1.32 = 1 : 1.50\). Because \(1.50\) is not a whole number, multiplying both subscripts by \(2\) clears the fraction to give \(\text{Cr}:\text{O} = 2 : 3\), the empirical formula \(\text{Cr}_2\text{O}_3\). (Choice A) \(\text{Cr}_2\text{O}\) results from treating the mass percents as though they were mole counts and reducing \(68.4 : 31.6 \approx 2 : 1\) directly; the grams must first be divided by the atomic masses, since the heavier Cr atom contributes fewer moles per gram than its mass fraction suggests. (Choice B) \(\text{Cr}_3\text{O}_2\) results from inverting the conversion and dividing atomic mass by mass percent (\(52.0/68.4 = 0.760\) and \(16.0/31.6 = 0.506\)), giving a ratio of \(1.50 : 1\); moles equal mass divided by molar mass, not molar mass divided by mass, so this inverts which element is more abundant. (Choice C) \(\text{CrO}\) results from obtaining the correct \(1 : 1.50\) mole ratio but rounding \(1.50\) down to \(1\) instead of multiplying both subscripts by \(2\) to clear the half-integer into whole numbers. Skill 4$ex15$,
    'hard', '4E', $cc15$Stoichiometry (GC)$cc15$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a15A$mass percents used directly as mole counts (grams treated as moles)$a15A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a15B$inverted the conversion, dividing atomic mass by mass percent instead of mass by atomic mass$a15B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a15C$rounded the 1.50 mole ratio down to 1:1 instead of multiplying to clear the fraction$a15C$ FROM q;

-- Q16 [Empirical & Molecular Formula + Percent Composition · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g16)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt16$Complete combustion of a 0.441 g sample of a hydrocarbon containing only carbon and hydrogen yields 1.320 g of \(\text{CO}_2\) and 0.721 g of \(\text{H}_2\text{O}\). Using molar masses \(\text{CO}_2 = 44.01\ \text{g/mol}\), \(\text{H}_2\text{O} = 18.02\ \text{g/mol}\), \(\text{C} = 12.01\ \text{g/mol}\), and \(\text{H} = 1.008\ \text{g/mol}\), the empirical formula of the hydrocarbon is which of the following?$qt16$,
    $op16$[{"label":"A","text":"\\(\\text{C}_3\\text{H}_8\\)"},{"label":"B","text":"\\(\\text{C}_3\\text{H}_4\\)"},{"label":"C","text":"\\(\\text{CH}\\)"},{"label":"D","text":"\\(\\text{C}_8\\text{H}_3\\)"}]$op16$::jsonb,
    'A',
    $ex16$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because converting the combustion products to moles of each element and reducing the ratio gives \(\text{C}_3\text{H}_8\). All carbon in the sample ends up in \(\text{CO}_2\): \(\text{mol C} = 1.320\ \text{g} \div 44.01\ \text{g/mol} = 0.0300\ \text{mol}\). All hydrogen ends up in \(\text{H}_2\text{O}\), and each water molecule carries two H atoms: \(\text{mol H} = 2 \times (0.721\ \text{g} \div 18.02\ \text{g/mol}) = 2 \times 0.0400 = 0.0800\ \text{mol}\). Dividing both by the smaller value, \(0.0300\), gives \(\text{C}:\text{H} = 1 : 2.67\); multiplying through by 3 clears the fraction to \(3 : 8\), so the empirical formula is \(\text{C}_3\text{H}_8\). (Choice B) \(\text{C}_3\text{H}_4\) results from omitting the factor of two when converting water to hydrogen, i.e. using \(0.0400\ \text{mol H}_2\text{O}\) directly as \(0.0400\ \text{mol H}\); the ratio \(0.0300 : 0.0400\) reduces to \(3 : 4\), undercounting hydrogen by half. (Choice C) \(\text{CH}\) results from treating the gram masses of \(\text{CO}_2\) and \(\text{H}_2\text{O}\) as if they were mole quantities and skipping division by molar mass; \(1.320\) against \(2 \times 0.721 = 1.442\) is roughly \(1 : 1\), a scale error from never converting mass to moles. (Choice D) \(\text{C}_8\text{H}_3\) is the correct \(3 : 8\) mole ratio with the subscripts transposed, assigning the carbon count to hydrogen and the hydrogen count to carbon. Skill 4$ex16$,
    'hard', '4E', $cc16$Stoichiometry (GC)$cc16$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a16B$Omits the two-hydrogen-per-water conversion, using moles of H2O directly as moles of H$a16B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a16C$Treats gram masses of the combustion products as mole quantities, skipping division by molar mass$a16C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a16D$Derives the correct mole ratio but transposes the element subscripts when writing the formula$a16D$ FROM q;

-- Q17 [Empirical & Molecular Formula + Percent Composition · medium · Skill 4 · 4E Stoichiometry (GC) · ans B] (g17)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt17$A sample of a binary phosphorus oxide is decomposed and found to contain \(6.20\ \text{g}\) of phosphorus and \(8.00\ \text{g}\) of oxygen \((\text{P} = 30.97\ \text{g/mol},\ \text{O} = 16.00\ \text{g/mol})\). Which empirical formula is most consistent with these masses?$qt17$,
    $op17$[{"label":"A","text":"\\(\\text{PO}_2\\)"},{"label":"B","text":"\\(\\text{P}_2\\text{O}_5\\)"},{"label":"C","text":"\\(\\text{PO}_3\\)"},{"label":"D","text":"\\(\\text{P}_5\\text{O}_2\\)"}]$op17$::jsonb,
    'B',
    $ex17$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because converting each mass to moles and reducing the mole ratio to the smallest whole numbers gives two phosphorus atoms per five oxygen atoms, i.e. \(\text{P}_2\text{O}_5\). Moles of phosphorus: \(6.20\ \text{g} \div 30.97\ \text{g/mol} = 0.200\ \text{mol}\). Moles of oxygen: \(8.00\ \text{g} \div 16.00\ \text{g/mol} = 0.500\ \text{mol}\). Dividing both by the smaller value gives \(\text{P} : \text{O} = 0.200/0.200 : 0.500/0.200 = 1 : 2.5\); multiplying through by \(2\) clears the fraction to \(2 : 5\), so the empirical formula is \(\text{P}_2\text{O}_5\). (Choice A) \(\text{PO}_2\) results from truncating the \(1 : 2.5\) ratio down to \(1 : 2\) rather than scaling it to whole numbers; the half cannot simply be dropped. (Choice C) \(\text{PO}_3\) results from rounding the non-integer ratio \(1 : 2.5\) up to the nearest whole number \(1 : 3\); a ratio ending in \(.5\) must be cleared by multiplication, not rounded. (Choice D) \(\text{P}_5\text{O}_2\) inverts the ratio by assigning the larger mole amount to phosphorus and the smaller to oxygen; the element present in greater moles (oxygen, \(0.500\ \text{mol}\)) must take the larger subscript. Skill 4$ex17$,
    'medium', '4E', $cc17$Stoichiometry (GC)$cc17$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a17A$Truncated the 1:2.5 mole ratio to 1:2 instead of scaling to whole numbers$a17A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a17C$Rounded the non-integer subscript 2.5 up to the nearest whole number instead of clearing the fraction$a17C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a17D$Inverted the mole ratio, assigning the larger mole count to the wrong element$a17D$ FROM q;

-- Q18 [Empirical & Molecular Formula + Percent Composition · medium · Skill 4 · 4E Stoichiometry (GC) · ans D] (g18)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt18$A peroxide compound has the empirical formula \(\text{HO}\) and a measured molar mass of \(34\,\text{g/mol}\). What is its molecular formula?$qt18$,
    $op18$[{"label":"A","text":"\\(\\text{HO}\\)"},{"label":"B","text":"\\(\\text{HO}_2\\)"},{"label":"C","text":"\\(\\text{H}_3\\text{O}_3\\)"},{"label":"D","text":"\\(\\text{H}_2\\text{O}_2\\)"}]$op18$::jsonb,
    'D',
    $ex18$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the molecular formula equals the empirical formula scaled by the integer ratio of the molar mass to the empirical-formula mass, which here is 2, giving \(\text{H}_2\text{O}_2\). Empirical-formula mass of \(\text{HO}\): \(1.008 + 16.00 = 17.01\,\text{g/mol}\). Multiplier: \(n = 34 / 17.01 \approx 2\). Multiply each subscript in \(\text{HO}\) by 2: \(\text{H}_{1\times2}\text{O}_{1\times2} = \text{H}_2\text{O}_2\), which is hydrogen peroxide (molar mass \(2(1.008) + 2(16.00) = 34.02\,\text{g/mol}\), matching the measurement). (Choice A) \(\text{HO}\) is the empirical formula itself; it has a mass of about \(17\,\text{g/mol}\), only half the measured \(34\,\text{g/mol}\), so the multiplier was never applied. (Choice B) \(\text{HO}_2\) doubles only the oxygen subscript instead of multiplying every subscript by the same factor, and its mass (\(\approx 33\,\text{g/mol}\)) does not arise from a whole-number scaling of \(\text{HO}\). (Choice C) \(\text{H}_3\text{O}_3\) uses a multiplier of 3, which gives a mass of about \(51\,\text{g/mol}\) rather than the measured \(34\,\text{g/mol}\). Skill 4$ex18$,
    'medium', '4E', $cc18$Stoichiometry (GC)$cc18$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a18A$Reports the empirical formula without applying the molar-mass multiplier$a18A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a18B$Scales only one element's subscript instead of all subscripts uniformly$a18B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a18C$Uses an incorrect integer multiplier (3 instead of 2)$a18C$ FROM q;

-- Q19 [Empirical & Molecular Formula + Percent Composition · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g19)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt19$A nitrogen oxide has the empirical formula \(\text{NO}_2\) and a measured molar mass of \(92\ \text{g/mol}\). Using atomic masses \(\text{N} = 14.01\ \text{g/mol}\) and \(\text{O} = 16.00\ \text{g/mol}\), determine its molecular formula.$qt19$,
    $op19$[{"label":"A","text":"\\(\\text{NO}_2\\)"},{"label":"B","text":"\\(\\text{N}_4\\text{O}_8\\)"},{"label":"C","text":"\\(\\text{N}_2\\text{O}_4\\)"},{"label":"D","text":"\\(\\text{N}_2\\text{O}_2\\)"}]$op19$::jsonb,
    'C',
    $ex19$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the molecular formula is a whole-number multiple of the empirical formula, and that multiple is the molar mass divided by the empirical-formula mass. The empirical-formula mass of \(\text{NO}_2\) is the sum of the atomic masses of its atoms: \(14.01 + 2(16.00) = 14.01 + 32.00 = 46.01\ \text{g/mol}\). Dividing the molar mass by this value gives the multiplier \(n = \dfrac{92\ \text{g/mol}}{46.01\ \text{g/mol}} \approx 2\). Multiplying every subscript in \(\text{NO}_2\) by \(2\) yields \(\text{N}_{1\times2}\text{O}_{2\times2} = \text{N}_2\text{O}_4\), whose molar mass \(2(14.01) + 4(16.00) = 28.02 + 64.00 = 92.02\ \text{g/mol}\) confirms the match. (Choice A) \(\text{NO}_2\) is the empirical formula itself and corresponds to a molar mass of about \(46\ \text{g/mol}\), half the measured \(92\ \text{g/mol}\); reporting it skips the step of dividing the molar mass by the empirical-formula mass to find the multiplier. (Choice B) \(\text{N}_4\text{O}_8\) results from dividing \(92\) by an incorrect empirical-formula mass of about \(23\) (half of \(46\)) to obtain a multiplier of \(4\); the empirical-formula mass is \(46.01\ \text{g/mol}\), not \(23\), so the correct multiplier is \(2\), not \(4\). (Choice D) \(\text{N}_2\text{O}_2\) results from multiplying only the nitrogen subscript by \(2\) while leaving the oxygen subscript unchanged; the multiplier must be applied to every subscript in the empirical formula, so the oxygen subscript becomes \(2\times2 = 4\), giving \(\text{N}_2\text{O}_4\). Skill 2$ex19$,
    'medium', '4E', $cc19$Stoichiometry (GC)$cc19$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a19A$reports empirical formula without scaling to molecular formula$a19A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a19B$divides molar mass by half the empirical-formula mass, doubling the multiplier$a19B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a19D$applies the multiplier to only one element's subscript$a19D$ FROM q;

-- Q20 [Empirical & Molecular Formula + Percent Composition · medium · Skill 3 · 4E Stoichiometry (GC) · ans B] (g20)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt20$A hydrocarbon has the empirical formula \(\text{CH}_2\) and a measured molar mass of \(56\ \text{g/mol}\) (atomic weights: \(\text{C}=12.0\), \(\text{H}=1.0\)). Which molecular formula is consistent with both the empirical formula and this molar mass?$qt20$,
    $op20$[{"label":"A","text":"\\(\\text{C}_4\\text{H}_{10}\\)"},{"label":"B","text":"\\(\\text{C}_4\\text{H}_8\\)"},{"label":"C","text":"\\(\\text{C}_3\\text{H}_8\\)"},{"label":"D","text":"\\(\\text{C}_2\\text{H}_4\\)"}]$op20$::jsonb,
    'B',
    $ex20$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because \(\text{C}_4\text{H}_8\) is the empirical unit \(\text{CH}_2\) multiplied by a whole number that reproduces the measured molar mass. First find the empirical formula mass: \(\text{CH}_2 = 12.0 + 2(1.0) = 14.0\ \text{g/mol}\). The multiplier is \(n = \tfrac{\text{molar mass}}{\text{empirical mass}} = \tfrac{56}{14.0} = 4\). Multiplying every subscript in \(\text{CH}_2\) by \(4\) gives \(\text{C}_4\text{H}_8\), and its mass check is \(4(12.0) + 8(1.0) = 48.0 + 8.0 = 56.0\ \text{g/mol}\), matching the stated value. A correct molecular formula must be a whole-number multiple of \(\text{CH}_2\) (so its C:H ratio stays \(1{:}2\)) AND must sum to \(\approx 56\ \text{g/mol}\); only \(\text{C}_4\text{H}_8\) satisfies both. (Choice A) \(\text{C}_4\text{H}_{10}\) sums to \(4(12.0)+10(1.0) = 58\ \text{g/mol}\) and has a C:H ratio of \(1{:}2.5\), not \(1{:}2\); this matches the general alkane pattern \(\text{C}_n\text{H}_{2n+2}\) rather than the required \(\text{CH}_2\) multiple, so it is not consistent with the given empirical formula. (Choice C) \(\text{C}_3\text{H}_8\) sums to \(3(12.0)+8(1.0) = 44\ \text{g/mol}\) and has a C:H ratio of \(3{:}8\), which is not a whole-number multiple of \(\text{CH}_2\); it fails both the ratio and the molar-mass requirement. (Choice D) \(\text{C}_2\text{H}_4\) is a valid multiple of \(\text{CH}_2\) (here \(n=2\)) and preserves the \(1{:}2\) ratio, but it sums to only \(2(12.0)+4(1.0) = 28\ \text{g/mol}\); this corresponds to using \(n=2\) instead of \(n = 56/14 = 4\), so it does not reproduce the \(56\ \text{g/mol}\) molar mass. Skill 3$ex20$,
    'medium', '4E', $cc20$Stoichiometry (GC)$cc20$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a20A$Applies the alkane formula CnH2n+2 instead of multiplying the empirical CH2 unit, giving a non-1:2 ratio and a molar mass of 58$a20A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a20C$Selects a formula whose C:H ratio (3:8) is not a whole-number multiple of CH2 while loosely aiming near the target mass$a20C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a20D$Uses the wrong multiplier n=2 instead of n = 56/14 = 4, yielding a valid CH2 multiple at the wrong molar mass (28 g/mol)$a20D$ FROM q;

-- Q21 [Empirical & Molecular Formula + Percent Composition · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g21)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt21$A metallurgist processes a \(320\,\text{g}\) sample of pure iron(III) oxide, \(\text{Fe}_2\text{O}_3\), to recover all of its iron. Using atomic masses \(\text{Fe} = 55.85\,\text{g/mol}\) and \(\text{O} = 16.00\,\text{g/mol}\), what mass of iron can the sample yield?$qt21$,
    $op21$[{"label":"A","text":"\\(224\\,\\text{g}\\)"},{"label":"B","text":"\\(112\\,\\text{g}\\)"},{"label":"C","text":"\\(96\\,\\text{g}\\)"},{"label":"D","text":"\\(70\\,\\text{g}\\)"}]$op21$::jsonb,
    'A',
    $ex21$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because iron makes up \(69.9\%\) of the mass of \(\text{Fe}_2\text{O}_3\), and applying that fraction to \(320\,\text{g}\) gives about \(224\,\text{g}\) of iron. First sum the atomic masses to get the molar mass of the compound: \(2(55.85) + 3(16.00) = 111.70 + 48.00 = 159.70\,\text{g/mol}\). The mass of iron per mole of \(\text{Fe}_2\text{O}_3\) is \(2 \times 55.85 = 111.70\,\text{g}\), because the formula contains two \(\text{Fe}\) atoms. The mass fraction of iron is therefore \(\dfrac{111.70}{159.70} = 0.699\), and the iron recoverable from the sample is \(0.699 \times 320\,\text{g} \approx 224\,\text{g}\). (Choice B) \(112\,\text{g}\) results from using the mass of only one iron atom, \(\dfrac{55.85}{159.70} \times 320 \approx 112\,\text{g}\), which ignores the subscript 2 indicating two iron atoms per formula unit. (Choice C) \(96\,\text{g}\) is the mass of oxygen in the sample, \(\dfrac{48.00}{159.70} \times 320 \approx 96\,\text{g}\); this inverts the target by applying the oxygen mass fraction instead of the iron mass fraction. (Choice D) \(70\,\text{g}\) is the numerical value of the iron mass percent (\(69.9\%\)) reported directly as a mass in grams, confusing the percent figure with the actual mass that must still be multiplied by the \(320\,\text{g}\) sample. Skill 2$ex21$,
    'medium', '4E', $cc21$Stoichiometry (GC)$cc21$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a21B$Uses the mass of a single Fe atom in the numerator, dropping the subscript 2 that gives two iron atoms per formula unit$a21B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a21C$Applies the oxygen mass fraction instead of the iron mass fraction, computing the mass of the wrong element$a21C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a21D$Reports the mass-percent value (69.9) as grams without multiplying by the sample mass, confusing a percent with a mass$a21D$ FROM q;

-- Q22 [Empirical & Molecular Formula + Percent Composition · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g22)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt22$A farmer applies \(250\,\text{g}\) of pure ammonium nitrate, \(\text{NH}_4\text{NO}_3\), as fertilizer. Using atomic masses \(\text{N}=14.01\), \(\text{H}=1.008\), and \(\text{O}=16.00\,\text{g/mol}\), what mass of nitrogen does this sample supply to the soil?$qt22$,
    $op22$[{"label":"A","text":"\\(43.8\\,\\text{g}\\)"},{"label":"B","text":"\\(28.0\\,\\text{g}\\)"},{"label":"C","text":"\\(87.5\\,\\text{g}\\)"},{"label":"D","text":"\\(162.5\\,\\text{g}\\)"}]$op22$::jsonb,
    'C',
    $ex22$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the nitrogen mass percent of \(\text{NH}_4\text{NO}_3\), applied to the \(250\,\text{g}\) sample, gives \(87.5\,\text{g}\) of nitrogen. First sum the atomic masses for one formula unit: \(2\,\text{N} = 2(14.01) = 28.02\), \(4\,\text{H} = 4(1.008) = 4.032\), and \(3\,\text{O} = 3(16.00) = 48.00\), so the molar mass is \(28.02 + 4.032 + 48.00 = 80.05\,\text{g/mol}\). The compound contains two nitrogen atoms, so the nitrogen mass fraction is \(\frac{28.02}{80.05} = 0.350\), i.e. \(35.0\%\). Multiplying by the sample mass gives \(250\,\text{g} \times 0.350 = 87.5\,\text{g}\) of nitrogen. (Choice A) \(43.8\,\text{g}\) counts only one nitrogen atom, using \(\frac{14.01}{80.05} = 0.175\) and \(250 \times 0.175 = 43.75\,\text{g}\); the formula \(\text{NH}_4\text{NO}_3\) contains two N atoms, so the numerator must be \(28.02\), not \(14.01\). (Choice B) \(28.0\,\text{g}\) is simply the mass of nitrogen in one mole of the compound \((2 \times 14.01)\); this ignores that the \(250\,\text{g}\) sample is far more than one mole, so the per-mole nitrogen mass cannot be reported as the nitrogen in the whole sample. (Choice D) \(162.5\,\text{g}\) applies the non-nitrogen mass fraction, \(\frac{80.05 - 28.02}{80.05} = 0.650\), giving \(250 \times 0.650\); this returns the combined hydrogen-and-oxygen mass rather than the nitrogen mass, inverting which portion of the compound the question asks for. Skill 2$ex22$,
    'medium', '4E', $cc22$Stoichiometry (GC)$cc22$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a22A$counted only one of the two nitrogen atoms (off-by-subscript)$a22A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a22B$reported nitrogen mass per mole instead of per the 250 g sample$a22B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a22D$used the non-nitrogen (H+O) mass fraction instead of the nitrogen fraction$a22D$ FROM q;

-- Q23 [Empirical & Molecular Formula + Percent Composition · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g23)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt23$Copper(II) sulfate pentahydrate, \(\text{CuSO}_4\cdot 5\,\text{H}_2\text{O}\), is heated to drive off its water. Using atomic weights \(\text{Cu}=63.55\), \(\text{S}=32.07\), \(\text{O}=16.00\), and \(\text{H}=1.01\;(\text{g/mol})\), what is the percent of water by mass in the intact hydrate?$qt23$,
    $op23$[{"label":"A","text":"56.4%"},{"label":"B","text":"63.9%"},{"label":"C","text":"10.1%"},{"label":"D","text":"36.1%"}]$op23$::jsonb,
    'D',
    $ex23$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the water makes up 36.1% of the hydrate's total molar mass. First find the mass of the water portion: one \(\text{H}_2\text{O}\) is \(2(1.01)+16.00=18.02\;\text{g/mol}\), and the formula contains five of them, so \(5\times 18.02=90.10\;\text{g/mol}\). Next find the mass of the anhydrous \(\text{CuSO}_4\): \(63.55+32.07+4(16.00)=63.55+32.07+64.00=159.62\;\text{g/mol}\). The total molar mass of \(\text{CuSO}_4\cdot 5\,\text{H}_2\text{O}\) is \(159.62+90.10=249.72\;\text{g/mol}\). The mass percent of water is therefore \(\dfrac{90.10}{249.72}\times 100\% = 36.1\%\). (Choice A) 56.4% comes from dividing the water mass by the anhydrous salt mass, \(90.10/159.62\), instead of by the full hydrate mass; the denominator must be the total formula mass that includes the water. (Choice B) 63.9% is the mass percent of the anhydrous \(\text{CuSO}_4\) portion, \(159.62/249.72\), which is the complement of the requested water percentage rather than the water percentage itself. (Choice C) 10.1% results from including only a single \(\text{H}_2\text{O}\) (\(18.02/(159.62+18.02)\)) rather than all five waters of hydration indicated by the subscript 5. Skill 2$ex23$,
    'medium', '4E', $cc23$Stoichiometry (GC)$cc23$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a23A$divided water mass by the anhydrous-salt mass instead of by the total hydrate mass$a23A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a23B$computed the percent of the anhydrous salt (the complement) instead of the water$a23B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a23C$used only one water of hydration instead of the five required by the subscript$a23C$ FROM q;

-- Q24 [Empirical & Molecular Formula + Percent Composition · hard · Skill 2 · 4E Stoichiometry (GC) · ans B] (g24)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt24$Epsom salt is magnesium sulfate heptahydrate, \(\text{MgSO}_4\cdot 7\,\text{H}_2\text{O}\), in which seven water molecules are bound per formula unit. Using atomic weights \(\text{Mg}=24.31\), \(\text{S}=32.07\), \(\text{O}=16.00\), and \(\text{H}=1.008\,\text{g/mol}\), what is the percent by mass of water in this hydrate?$qt24$,
    $op24$[{"label":"A","text":"\\(13.0\\%\\)"},{"label":"B","text":"\\(51.2\\%\\)"},{"label":"C","text":"\\(48.8\\%\\)"},{"label":"D","text":"\\(47.3\\%\\)"}]$op24$::jsonb,
    'B',
    $ex24$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the mass of all seven water molecules must be divided by the molar mass of the entire hydrate. First find the molar mass of the anhydrous \(\text{MgSO}_4\) portion: \(24.31 + 32.07 + 4(16.00) = 120.38\,\text{g/mol}\). One water is \(2(1.008) + 16.00 = 18.02\,\text{g/mol}\), so seven waters contribute \(7 \times 18.02 = 126.11\,\text{g/mol}\). The total molar mass of \(\text{MgSO}_4\cdot 7\,\text{H}_2\text{O}\) is \(120.38 + 126.11 = 246.49\,\text{g/mol}\). The percent water by mass is \(\dfrac{126.11}{246.49}\times 100\% = 51.2\%\). (Choice A) \(13.0\%\) results from including only a single water molecule, \(\dfrac{18.02}{120.38 + 18.02}\times 100\%\), which ignores the \(\cdot 7\) coefficient that specifies seven waters per formula unit. (Choice C) \(48.8\%\) is the percent by mass of the anhydrous \(\text{MgSO}_4\) portion, \(\dfrac{120.38}{246.49}\times 100\%\), which is the complement of the water fraction rather than the water fraction itself. (Choice D) \(47.3\%\) results from counting only six waters, \(\dfrac{6 \times 18.02}{120.38 + 6 \times 18.02}\times 100\%\), an off-by-one error in the hydration subscript. Skill 2$ex24$,
    'hard', '4E', $cc24$Stoichiometry (GC)$cc24$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a24A$uses a single water molecule and ignores the 7 hydration coefficient$a24A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a24C$reports the anhydrous-salt mass fraction instead of the water fraction$a24C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a24D$off-by-one in the hydration subscript, counting six waters instead of seven$a24D$ FROM q;

-- Q25 [Empirical & Molecular Formula + Percent Composition · hard · Skill 3 · 4E Stoichiometry (GC) · ans D] (g25)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Empirical & Molecular Formula + Percent Composition',
    $qt25$A liquid hydrocarbon is found to be \(92.3\%\) carbon and \(7.7\%\) hydrogen by mass, and a separate measurement gives its molar mass as approximately \(78\ \text{g/mol}\). Which molecular formula is most consistent with these data?$qt25$,
    $op25$[{"label":"A","text":"\\(\\text{CH}\\)"},{"label":"B","text":"\\(\\text{C}_2\\text{H}_2\\)"},{"label":"C","text":"\\(\\text{C}_5\\text{H}_6\\)"},{"label":"D","text":"\\(\\text{C}_6\\text{H}_6\\)"}]$op25$::jsonb,
    'D',
    $ex25$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the empirical formula derived from the mass percents is \(\text{CH}\), and scaling that unit by the ratio of the molar mass to the empirical-formula mass gives the molecular formula \(\text{C}_6\text{H}_6\). Taking a \(100\ \text{g}\) sample, the moles of each element are \(\frac{92.3}{12.0}\approx 7.69\ \text{mol C}\) and \(\frac{7.7}{1.0}\approx 7.7\ \text{mol H}\); dividing by the smaller value gives a mole ratio of about \(1:1\), so the empirical formula is \(\text{CH}\) with empirical-formula mass \(12.0+1.0 = 13\ \text{g/mol}\). The multiplier is \(n = \frac{78}{13} = 6\), so the molecular formula is \((\text{CH})_6 = \text{C}_6\text{H}_6\), which is benzene. (Choice A) \(\text{CH}\) is the empirical formula, the simplest whole-number ratio, but it has a formula mass of only \(13\ \text{g/mol}\) and so does not match the measured \(78\ \text{g/mol}\); the molar-mass scaling step has been omitted. (Choice B) \(\text{C}_2\text{H}_2\) keeps the correct \(1:1\) ratio but uses a multiplier of \(n = 2\) rather than \(n = \frac{78}{13} = 6\); its formula mass is \(26\ \text{g/mol}\), one-third of the target, so the molar mass was scaled by the wrong factor. (Choice C) \(\text{C}_5\text{H}_6\) does not preserve the \(1:1\) C:H ratio and appears to come from dividing the molar mass by carbon's atomic mass (\(\frac{78}{12}\approx 6.5\), truncated to about \(5\)) instead of by the \(13\ \text{g/mol}\) empirical-formula mass, mishandling the step that converts molar mass into the formula multiplier. Skill 3$ex25$,
    'hard', '4E', $cc25$Stoichiometry (GC)$cc25$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a25A$reports empirical formula instead of molecular formula (omits molar-mass scaling)$a25A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a25B$correct empirical ratio scaled by wrong multiplier (n=2 instead of 6)$a25B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a25C$divides molar mass by carbon atomic mass instead of empirical-formula mass$a25C$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='Compounds & Stoichiometry' AND subtopic IN ('Molecules, Moles & Molar Mass', 'Empirical & Molecular Formula + Percent Composition');
