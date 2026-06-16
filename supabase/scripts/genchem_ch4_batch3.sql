-- GenChem Ch4 (Compounds & Stoichiometry) — Batch 3 of 3: Limiting Reagent, Yield & Ions/Nomenclature/Electrolytes
-- 28 questions, all confidence >=4 (OpenStax Atoms First 2e; every calculation independently re-verified); cross-batch + cross-chapter deduped, audit clean (PASS, 0 genuine conflicts).
-- AAMC foundation 4E "Stoichiometry (GC)" for most rows; the ions/nomenclature/electrolytes items are tagged 5A "Ions in Solutions (GC)".
-- Out of MCAT scope and deliberately excluded: normality / equivalents / gram-equivalent weight, molarity calcs.
-- Re-runnable (subtopic-scoped DELETE). Run the three batches in any order in the Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Compounds & Stoichiometry' AND subtopic IN ('Limiting Reagent, Theoretical & Percent Yield', 'Ions, Nomenclature & Electrolytes');

-- Q1 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g48)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt48$In the Haber process \(\text{N}_2 + 3\,\text{H}_2 \rightarrow 2\,\text{NH}_3\), a reaction vessel is charged with excess \(\text{N}_2\) and \(4.0\,\text{mol}\) of \(\text{H}_2\) that reacts completely. How many moles of \(\text{NH}_3\) form?$qt48$,
    $op48$[{"label":"A","text":"\\(1.33\\,\\text{mol}\\)"},{"label":"B","text":"\\(4.0\\,\\text{mol}\\)"},{"label":"C","text":"\\(2.67\\,\\text{mol}\\)"},{"label":"D","text":"\\(6.0\\,\\text{mol}\\)"}]$op48$::jsonb,
    'C',
    $ex48$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the balanced equation fixes a mole ratio of \(3\,\text{mol}\,\text{H}_2 : 2\,\text{mol}\,\text{NH}_3\), and that ratio is the bridge from the amount consumed to the amount produced. With \(\text{N}_2\) in excess, \(\text{H}_2\) is the limiting reactant, and all \(4.0\,\text{mol}\) is consumed: \(4.0\,\text{mol}\,\text{H}_2 \times \dfrac{2\,\text{mol}\,\text{NH}_3}{3\,\text{mol}\,\text{H}_2} = 2.67\,\text{mol}\,\text{NH}_3\). (Choice A) \(1.33\,\text{mol}\) results from multiplying by \(\dfrac{1}{3}\) (the \(\text{N}_2\):\text{H}_2\) sub-bridge) instead of by \(\dfrac{2}{3}\), dropping the \(\text{NH}_3\) coefficient of 2. (Choice B) \(4.0\,\text{mol}\) assumes a 1:1 ratio between \(\text{H}_2\) and \(\text{NH}_3\), ignoring the balancing coefficients entirely. (Choice D) \(6.0\,\text{mol}\) comes from inverting the ratio and multiplying by \(\dfrac{3}{2}\) instead of \(\dfrac{2}{3}\). Skill 2$ex48$,
    'medium', '4E', $cc48$Stoichiometry (GC)$cc48$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a48A$applied the N2:H2 (1:3) sub-ratio rather than the H2:NH3 (3:2) bridge, dropping the product coefficient$a48A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a48B$assumed a 1:1 mole ratio, ignoring balancing coefficients$a48B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a48D$inverted the mole ratio, multiplying by 3/2 instead of 2/3$a48D$ FROM q;

-- Q2 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g49)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt49$Propane burns according to the balanced equation \(\text{C}_3\text{H}_8 + 5\,\text{O}_2 \rightarrow 3\,\text{CO}_2 + 4\,\text{H}_2\text{O}\). A reaction consumes exactly \(5.0\,\text{mol}\) of \(\text{O}_2\). How many moles of \(\text{CO}_2\) are produced?$qt49$,
    $op49$[{"label":"A","text":"\\(4.0\\,\\text{mol CO}_2\\)"},{"label":"B","text":"\\(5.0\\,\\text{mol CO}_2\\)"},{"label":"C","text":"\\(8.3\\,\\text{mol CO}_2\\)"},{"label":"D","text":"\\(3.0\\,\\text{mol CO}_2\\)"}]$op49$::jsonb,
    'D',
    $ex49$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the balanced equation fixes the mole ratio of \(\text{O}_2\) to \(\text{CO}_2\) at \(5:3\), so the \(5.0\,\text{mol}\) of \(\text{O}_2\) consumed must be bridged to \(\text{CO}_2\) using that ratio. The coefficients \(5\) for \(\text{O}_2\) and \(3\) for \(\text{CO}_2\) give the conversion factor \(\dfrac{3\,\text{mol CO}_2}{5\,\text{mol O}_2}\), and applying it yields \(5.0\,\text{mol O}_2 \times \dfrac{3\,\text{mol CO}_2}{5\,\text{mol O}_2} = 3.0\,\text{mol CO}_2\). The factor is oriented so that \(\text{O}_2\) cancels and \(\text{CO}_2\) remains, and because \(3 < 5\) the amount of \(\text{CO}_2\) produced is smaller than the amount of \(\text{O}_2\) consumed. (Choice A) \(4.0\,\text{mol}\) results from bridging through the \(\text{H}_2\text{O}\) coefficient of \(4\) instead of the \(\text{CO}_2\) coefficient of \(3\), i.e. \(5.0 \times \tfrac{4}{5}\), which gives moles of water rather than carbon dioxide. (Choice B) \(5.0\,\text{mol}\) results from assuming a \(1:1\) relationship and copying the \(\text{O}_2\) amount directly, ignoring that the balanced coefficients require a \(5:3\) conversion. (Choice C) \(8.3\,\text{mol}\) results from inverting the ratio to \(\dfrac{5}{3}\) and computing \(5.0 \times \tfrac{5}{3}\), which places the reactant coefficient in the numerator and incorrectly makes more product than reactant consumed. Skill 2$ex49$,
    'medium', '4E', $cc49$Stoichiometry (GC)$cc49$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a49A$Bridges through the H2O coefficient (4) instead of the CO2 coefficient (3), computing 5.0 x 4/5 = 4.0 and reporting moles of water as moles of CO2$a49A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a49B$Skips the mole-ratio step and assumes a 1:1 relationship, copying the moles of O2 directly as moles of CO2$a49B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a49C$Inverts the mole ratio to 5/3 (reactant over product), computing 5.0 x 5/3 = 8.3 so more product forms than reactant consumed$a49C$ FROM q;

-- Q3 [Limiting Reagent, Theoretical & Percent Yield · easy · Skill 2 · 4E Stoichiometry (GC) · ans A] (g50)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt50$Aluminum reacts with chlorine gas according to \(2\,\text{Al} + 3\,\text{Cl}_2 \rightarrow 2\,\text{AlCl}_3\). If \(0.60\ \text{mol}\) of \(\text{Al}\) reacts completely with excess \(\text{Cl}_2\), how many moles of \(\text{AlCl}_3\) form?$qt50$,
    $op50$[{"label":"A","text":"\\(0.60\\ \\text{mol}\\)"},{"label":"B","text":"\\(0.40\\ \\text{mol}\\)"},{"label":"C","text":"\\(0.90\\ \\text{mol}\\)"},{"label":"D","text":"\\(1.20\\ \\text{mol}\\)"}]$op50$::jsonb,
    'A',
    $ex50$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the balanced equation sets the mole ratio of \(\text{Al}\) to \(\text{AlCl}_3\) at \(2:2\), which reduces to \(1:1\). With \(\text{Cl}_2\) in excess, \(\text{Al}\) is consumed completely, so \(0.60\ \text{mol}\ \text{Al} \times \dfrac{2\ \text{mol}\ \text{AlCl}_3}{2\ \text{mol}\ \text{Al}} = 0.60\ \text{mol}\ \text{AlCl}_3\). (Choice B) \(0.40\ \text{mol}\) results from multiplying by \(\dfrac{2}{3}\), the ratio of the \(\text{AlCl}_3\) coefficient to the \(\text{Cl}_2\) coefficient, which is the wrong bridge for an \(\text{Al}\)-to-\(\text{AlCl}_3\) conversion. (Choice C) \(0.90\ \text{mol}\) results from multiplying by \(\dfrac{3}{2}\), inverting the calculation and pairing the \(\text{Cl}_2\) coefficient of 3 with the \(\text{Al}\) coefficient of 2 instead of using the \(\text{Al}\)-to-\(\text{AlCl}_3\) ratio. (Choice D) \(1.20\ \text{mol}\) results from multiplying \(0.60\) by the bare coefficient 2 rather than by the \(2:2\) ratio, treating the product coefficient as a standalone multiplier. Skill 2$ex50$,
    'easy', '4E', $cc50$Stoichiometry (GC)$cc50$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a50B$applied AlCl3:Cl2 ratio (2/3) instead of Al:AlCl3 ratio$a50B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a50C$inverted the mole ratio, multiplying by 3/2 using the Cl2 coefficient$a50C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a50D$multiplied by the bare product coefficient (2) rather than the 2:2 ratio$a50D$ FROM q;

-- Q4 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 4 · 4E Stoichiometry (GC) · ans A] (g51)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt51$Aluminum reacts with chlorine gas by the balanced equation \(2\,\text{Al} + 3\,\text{Cl}_2 \rightarrow 2\,\text{AlCl}_3\). A reaction vessel is charged with \(5.4\,\text{g}\) of \(\text{Al}\) (molar mass \(27\,\text{g/mol}\)) and \(28.4\,\text{g}\) of \(\text{Cl}_2\) (molar mass \(71\,\text{g/mol}\)). Which reactant is the limiting reagent?$qt51$,
    $op51$[{"label":"A","text":"\\(\\text{Al}\\), because \\(0.20\\,\\text{mol}\\,\\text{Al}\\) divided by its coefficient (\\(0.10\\)) is smaller than \\(0.40\\,\\text{mol}\\,\\text{Cl}_2\\) divided by its coefficient (\\(0.13\\))"},{"label":"B","text":"\\(\\text{Cl}_2\\), because \\(28.4\\,\\text{g}\\,\\text{Cl}_2\\) is the larger mass and the heavier charge is consumed first"},{"label":"C","text":"\\(\\text{Cl}_2\\), because \\(0.40\\,\\text{mol}\\,\\text{Cl}_2\\) exceeds \\(0.20\\,\\text{mol}\\,\\text{Al}\\), so the larger mole amount runs out first"},{"label":"D","text":"Neither, because \\(0.20\\,\\text{mol}\\,\\text{Al}\\) requires exactly \\(0.40\\,\\text{mol}\\,\\text{Cl}_2\\) by the \\(2:3\\) ratio, so both are consumed completely"}]$op51$::jsonb,
    'A',
    $ex51$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because converting each mass to moles and dividing by the balancing coefficient identifies the reactant present in the smallest stoichiometric amount. First convert: \(5.4\,\text{g}\,\text{Al} \div 27\,\text{g/mol} = 0.20\,\text{mol}\,\text{Al}\), and \(28.4\,\text{g}\,\text{Cl}_2 \div 71\,\text{g/mol} = 0.40\,\text{mol}\,\text{Cl}_2\). Next divide each by its coefficient in \(2\,\text{Al} + 3\,\text{Cl}_2 \rightarrow 2\,\text{AlCl}_3\): for \(\text{Al}\), \(0.20 \div 2 = 0.10\); for \(\text{Cl}_2\), \(0.40 \div 3 = 0.133\). The smaller quotient (\(0.10\) for \(\text{Al}\)) marks the limiting reagent, so \(\text{Al}\) limits the reaction. Confirming by the required ratio, \(0.20\,\text{mol}\,\text{Al}\) needs \(0.20 \times \tfrac{3}{2} = 0.30\,\text{mol}\,\text{Cl}_2\); only \(0.30\,\text{mol}\,\text{Cl}_2\) is needed while \(0.40\,\text{mol}\) is available, leaving \(\text{Cl}_2\) in excess and \(\text{Al}\) limiting. (Choice B) This compares raw masses and treats the larger mass (\(28.4\,\text{g}\,\text{Cl}_2\)) as limiting, but mass alone cannot identify the limiting reagent because it ignores molar mass and the mole ratio; the masses must be converted to moles and weighed against the coefficients. (Choice C) This compares the raw mole amounts (\(0.40\,\text{mol}\,\text{Cl}_2\) versus \(0.20\,\text{mol}\,\text{Al}\)) without dividing by the \(2:3\) coefficients; the larger mole count is not automatically limiting, and once each is divided by its coefficient \(\text{Cl}_2\) (\(0.133\)) exceeds \(\text{Al}\) (\(0.10\)). (Choice D) This inverts the mole ratio, computing the \(\text{Cl}_2\) demand as \(0.20 \times 2 = 0.40\,\text{mol}\) instead of \(0.20 \times \tfrac{3}{2} = 0.30\,\text{mol}\); the correct \(2:3\) ratio shows only \(0.30\,\text{mol}\,\text{Cl}_2\) is consumed, leaving an excess rather than an exact match. Skill 4$ex51$,
    'medium', '4E', $cc51$Stoichiometry (GC)$cc51$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a51B$Selects limiting reagent by comparing raw masses without converting to moles$a51B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a51C$Compares raw mole amounts but ignores the coefficient (mole-ratio) division$a51C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a51D$Inverts the 2:3 mole ratio so the reactants appear to be consumed exactly$a51D$ FROM q;

-- Q5 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 4 · 4E Stoichiometry (GC) · ans B] (g52)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt52$In the Haber process, nitrogen and hydrogen react as \(\text{N}_2 + 3\,\text{H}_2 \rightarrow 2\,\text{NH}_3\). A reactor is charged with \(28\,\text{g}\) of \(\text{N}_2\) (molar mass \(28\,\text{g/mol}\)) and \(9.0\,\text{g}\) of \(\text{H}_2\) (molar mass \(2.0\,\text{g/mol}\)). Which reactant limits the amount of \(\text{NH}_3\) that can form?$qt52$,
    $op52$[{"label":"A","text":"\\(\\text{H}_2\\), because only \\(9.0\\,\\text{g}\\) of it is present versus \\(28\\,\\text{g}\\) of \\(\\text{N}_2\\)"},{"label":"B","text":"\\(\\text{N}_2\\), because \\(1.0\\,\\text{mol}\\) of it requires \\(3.0\\,\\text{mol}\\) \\(\\text{H}_2\\) and \\(4.5\\,\\text{mol}\\) \\(\\text{H}_2\\) is available"},{"label":"C","text":"\\(\\text{H}_2\\), because only \\(1.0\\,\\text{mol}\\) \\(\\text{N}_2\\) is present versus \\(4.5\\,\\text{mol}\\) \\(\\text{H}_2\\)"},{"label":"D","text":"Neither, because the \\(1.0\\,\\text{mol}\\) \\(\\text{N}_2\\) to \\(4.5\\,\\text{mol}\\) \\(\\text{H}_2\\) charge matches the required \\(3{:}1\\) ratio exactly"}]$op52$::jsonb,
    'B',
    $ex52$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because converting each mass to moles and comparing to the balanced 1:3 ratio shows that hydrogen is in excess, so nitrogen runs out first. Moles of \(\text{N}_2 = 28\,\text{g} \div 28\,\text{g/mol} = 1.0\,\text{mol}\). Moles of \(\text{H}_2 = 9.0\,\text{g} \div 2.0\,\text{g/mol} = 4.5\,\text{mol}\). The equation requires \(3\,\text{mol}\) \(\text{H}_2\) per \(1\,\text{mol}\) \(\text{N}_2\), so \(1.0\,\text{mol}\) \(\text{N}_2\) needs \(1.0 \times 3 = 3.0\,\text{mol}\) \(\text{H}_2\). Because \(4.5\,\text{mol}\) \(\text{H}_2\) is available (more than the \(3.0\,\text{mol}\) needed), \(\text{H}_2\) is in excess and \(\text{N}_2\) is the limiting reactant. (Choice A) Comparing raw masses (\(9.0\,\text{g}\) versus \(28\,\text{g}\)) ignores that the two reactants have very different molar masses; mass alone cannot identify the limiting reactant. (Choice C) Comparing raw mole counts (\(1.0\,\text{mol}\) versus \(4.5\,\text{mol}\)) without applying the 1:3 ratio incorrectly treats the smaller mole quantity as limiting. (Choice D) This inverts the stoichiometric ratio: the equation calls for \(3\,\text{mol}\) \(\text{H}_2\) per \(1\,\text{mol}\) \(\text{N}_2\), not a \(3{:}1\) \(\text{N}_2\text{-to-}\text{H}_2\) match, so the charge is not stoichiometric and a reactant must be limiting. Skill 4$ex52$,
    'medium', '4E', $cc52$Stoichiometry (GC)$cc52$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a52A$Compares raw grams of the two reactants instead of converting to moles$a52A$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a52C$Compares raw mole counts but omits the 1:3 mole ratio from the balanced equation$a52C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a52D$Inverts the 1:3 H2-to-N2 ratio and concludes the charge is stoichiometric$a52D$ FROM q;

-- Q6 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g53)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt53$In the reaction \(2\,\text{H}_2 + \text{O}_2 \rightarrow 2\,\text{H}_2\text{O}\), \(4.0\ \text{g}\) of \(\text{H}_2\) (molar mass \(2.0\ \text{g/mol}\)) reacts with excess \(\text{O}_2\). Using a molar mass of \(18\ \text{g/mol}\) for water, the theoretical yield of \(\text{H}_2\text{O}\) is what mass?$qt53$,
    $op53$[{"label":"A","text":"\\(18\\ \\text{g}\\)"},{"label":"B","text":"\\(32\\ \\text{g}\\)"},{"label":"C","text":"\\(36\\ \\text{g}\\)"},{"label":"D","text":"\\(72\\ \\text{g}\\)"}]$op53$::jsonb,
    'C',
    $ex53$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because converting the hydrogen mass to moles gives \(4.0\ \text{g} \div 2.0\ \text{g/mol} = 2.0\ \text{mol}\ \text{H}_2\), the balanced \(2:2\) (i.e. \(1:1\)) mole ratio between \(\text{H}_2\) and \(\text{H}_2\text{O}\) yields \(2.0\ \text{mol}\ \text{H}_2\text{O}\), and multiplying by the water molar mass gives \(2.0\ \text{mol} \times 18\ \text{g/mol} = 36\ \text{g}\). Because \(\text{O}_2\) is in excess, \(\text{H}_2\) is the limiting reactant and sets the theoretical yield. (Choice A) \(18\ \text{g}\) results from carrying only \(1.0\ \text{mol}\ \text{H}_2\text{O}\) (\(1.0 \times 18\)), which halves the product moles even though the \(2:2\) ratio is one-to-one, so \(2.0\ \text{mol}\ \text{H}_2\) must give \(2.0\ \text{mol}\ \text{H}_2\text{O}\). (Choice B) \(32\ \text{g}\) results from computing the mass of \(\text{O}_2\) consumed (\(1.0\ \text{mol}\ \text{O}_2 \times 32\ \text{g/mol}\)) rather than the mass of the requested product \(\text{H}_2\text{O}\). (Choice D) \(72\ \text{g}\) results from doubling the product moles to \(4.0\ \text{mol}\) by misapplying the coefficients as a \(2:1\) scale-up, when the \(\text{H}_2\)-to-\(\text{H}_2\text{O}\) ratio is \(2:2\) and leaves the moles unchanged. Skill 2$ex53$,
    'medium', '4E', $cc53$Stoichiometry (GC)$cc53$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a53A$Halves the product moles to 1.0 mol despite the 2:2 (one-to-one) mole ratio, computing 1.0 mol x 18 g/mol = 18 g$a53A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a53B$Reports the mass of O2 consumed (1.0 mol x 32 g/mol) instead of the mass of the requested H2O product$a53B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a53D$Doubles product moles to 4.0 mol by misreading the coefficients as a 2:1 scale-up, giving 4.0 mol x 18 g/mol = 72 g$a53D$ FROM q;

-- Q7 [Limiting Reagent, Theoretical & Percent Yield · easy · Skill 2 · 4E Stoichiometry (GC) · ans D] (g54)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt54$A precipitation reaction has a theoretical yield of \(50.0\,\text{g}\) of \(\text{CaCO}_3\), but only \(41.0\,\text{g}\) of \(\text{CaCO}_3\) is actually collected after filtering and drying. The percent yield of the reaction is closest to which value?$qt54$,
    $op54$[{"label":"A","text":"\\(122\\%\\)"},{"label":"B","text":"\\(9.0\\%\\)"},{"label":"C","text":"\\(91.0\\%\\)"},{"label":"D","text":"\\(82.0\\%\\)"}]$op54$::jsonb,
    'D',
    $ex54$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because percent yield is defined as the actual yield divided by the theoretical yield, multiplied by 100: \(\text{percent yield} = \frac{\text{actual}}{\text{theoretical}} \times 100 = \frac{41.0\,\text{g}}{50.0\,\text{g}} \times 100 = 82.0\%\). The actual yield (\(41.0\,\text{g}\), what was collected) is always the numerator and the theoretical yield (\(50.0\,\text{g}\), the maximum predicted by stoichiometry) is always the denominator, so a percent yield below \(100\%\) correctly reflects that less product was recovered than predicted. (Choice A) \(122\%\) results from inverting the ratio and computing \(\frac{50.0}{41.0} \times 100 \approx 122\%\); this places theoretical over actual, which would imply more product was collected than was possible. (Choice B) \(9.0\%\) results from subtracting the masses, \(50.0 - 41.0 = 9.0\), and labeling the difference a percentage instead of dividing the two yields. (Choice C) \(91.0\%\) results from taking that same \(9.0\,\text{g}\) shortfall and subtracting it from \(100\) as if each gram lost were one percentage point, rather than dividing actual by theoretical. Skill 2$ex54$,
    'easy', '4E', $cc54$Stoichiometry (GC)$cc54$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a54A$Inverts the percent-yield ratio, dividing theoretical by actual (50.0/41.0 x 100) so the recovered amount appears to exceed the maximum possible$a54A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a54B$Subtracts the two yields (50.0 - 41.0 = 9.0) and reports the mass difference as a percentage instead of dividing actual by theoretical$a54B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a54C$Treats the 9.0 g shortfall as 9.0 percentage points and subtracts from 100 (100 - 9.0) rather than dividing actual by theoretical$a54C$ FROM q;

-- Q8 [Limiting Reagent, Theoretical & Percent Yield · easy · Skill 2 · 4E Stoichiometry (GC) · ans A] (g55)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt55$A synthesis of aspirin \(\left(\text{C}_9\text{H}_8\text{O}_4\right)\) has a theoretical yield of \(20.0\,\text{g}\) and proceeds at a percent yield of \(75.0\%\). The chemist isolates the purified product. What mass of aspirin is actually recovered?$qt55$,
    $op55$[{"label":"A","text":"\\(15.0\\,\\text{g}\\)"},{"label":"B","text":"\\(26.7\\,\\text{g}\\)"},{"label":"C","text":"\\(5.0\\,\\text{g}\\)"},{"label":"D","text":"\\(75.0\\,\\text{g}\\)"}]$op55$::jsonb,
    'A',
    $ex55$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because percent yield is defined as \(\text{percent yield} = \dfrac{\text{actual yield}}{\text{theoretical yield}} \times 100\%\), so the actual yield is obtained by multiplying the theoretical yield by the percent yield expressed as a decimal fraction. Converting \(75.0\%\) to a fraction gives \(0.750\), and \(0.750 \times 20.0\,\text{g} = 15.0\,\text{g}\) of aspirin recovered. (Choice B) The value \(26.7\,\text{g}\) results from dividing the theoretical yield by \(0.750\) \(\left(20.0\,\text{g} \div 0.750 = 26.7\,\text{g}\right)\), which inverts the relationship and produces an actual yield larger than the theoretical yield, an impossibility. (Choice C) The value \(5.0\,\text{g}\) is the mass corresponding to the \(25\%\) that is not recovered \(\left(0.250 \times 20.0\,\text{g} = 5.0\,\text{g}\right)\); this is the unrealized portion of product, not the amount actually isolated. (Choice D) The value \(75.0\,\text{g}\) comes from using the percent as the whole number \(75.0\) rather than the decimal \(0.750\), failing to divide by \(100\) when converting the percentage. Skill 2$ex55$,
    'easy', '4E', $cc55$Stoichiometry (GC)$cc55$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a55B$Divided theoretical yield by the percent-as-decimal instead of multiplying, inverting the percent-yield formula$a55B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a55C$Computed the mass of the unrecovered fraction (25% lost) and reported it instead of the recovered product$a55C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a55D$Used the percent as a whole number (75.0) rather than the decimal (0.750), omitting division by 100$a55D$ FROM q;

-- Q9 [Limiting Reagent, Theoretical & Percent Yield · hard · Skill 4 · 4E Stoichiometry (GC) · ans B] (g56)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt56$In \(\text{Zn} + \text{S} \rightarrow \text{ZnS}\), \(6.5\,\text{g}\) of Zn (molar mass \(65\,\text{g/mol}\)) reacts with \(6.4\,\text{g}\) of S (molar mass \(32\,\text{g/mol}\)) until the limiting reactant is exhausted. What mass of the excess reactant remains?$qt56$,
    $op56$[{"label":"A","text":"\\(0\\,\\text{g}\\)"},{"label":"B","text":"\\(3.2\\,\\text{g}\\) of S"},{"label":"C","text":"\\(6.4\\,\\text{g}\\) of S"},{"label":"D","text":"\\(6.5\\,\\text{g}\\) of Zn"}]$op56$::jsonb,
    'B',
    $ex56$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because Zn is the limiting reactant, so only part of the sulfur is consumed and \(3.2\,\text{g}\) of S is left over. Convert each mass to moles: \(6.5\,\text{g} \div 65\,\text{g/mol} = 0.10\,\text{mol}\) Zn and \(6.4\,\text{g} \div 32\,\text{g/mol} = 0.20\,\text{mol}\) S. The balanced equation \(\text{Zn} + \text{S} \rightarrow \text{ZnS}\) requires a 1:1 mole ratio, so \(0.10\,\text{mol}\) Zn would need \(0.10\,\text{mol}\) S; because only \(0.10\,\text{mol}\) Zn is present versus \(0.20\,\text{mol}\) S, Zn limits the reaction and S is in excess. The S consumed equals \(0.10\,\text{mol} \times 32\,\text{g/mol} = 3.2\,\text{g}\), leaving \(6.4\,\text{g} - 3.2\,\text{g} = 3.2\,\text{g}\) of S unreacted. (Choice A) \(0\,\text{g}\) treats the reaction as if both reactants are fully consumed, which ignores that the 1:1 ratio leaves \(0.10\,\text{mol}\) of S unreacted. (Choice C) \(6.4\,\text{g}\) of S is the initial mass of sulfur and omits subtracting the \(3.2\,\text{g}\) that reacted with the available Zn. (Choice D) \(6.5\,\text{g}\) of Zn reports the leftover as the wrong species; Zn is the limiting reactant and is entirely consumed, so none of it remains. Skill 4$ex56$,
    'hard', '4E', $cc56$Stoichiometry (GC)$cc56$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a56A$Assumes both reactants are fully consumed, leaving zero excess$a56A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a56C$Reports initial mass of excess reactant without subtracting the amount that reacted$a56C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a56D$Identifies the leftover as the limiting reactant species instead of the excess reactant$a56D$ FROM q;

-- Q10 [Limiting Reagent, Theoretical & Percent Yield · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g57)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt57$Carbon burns in limited oxygen by the balanced equation \(2\,\text{C} + \text{O}_2 \rightarrow 2\,\text{CO}\). A reaction vessel is charged with exactly \(3.0\ \text{mol}\) of \(\text{C}\) and \(2.0\ \text{mol}\) of \(\text{O}_2\). Which reactant is limiting?$qt57$,
    $op57$[{"label":"A","text":"\\(\\text{C}\\), because consuming all \\(2.0\\ \\text{mol}\\) of \\(\\text{O}_2\\) would demand \\(4.0\\ \\text{mol}\\) of \\(\\text{C}\\) but only \\(3.0\\ \\text{mol}\\) is present."},{"label":"B","text":"\\(\\text{O}_2\\), because consuming all \\(3.0\\ \\text{mol}\\) of \\(\\text{C}\\) would demand \\(6.0\\ \\text{mol}\\) of \\(\\text{O}_2\\) but only \\(2.0\\ \\text{mol}\\) is present."},{"label":"C","text":"Neither, because the \\(3.0\\ \\text{mol}\\) of \\(\\text{C}\\) and \\(2.0\\ \\text{mol}\\) of \\(\\text{O}_2\\) are close enough that both are fully consumed together."},{"label":"D","text":"\\(\\text{O}_2\\), because at \\(2.0\\ \\text{mol}\\) it is the reactant present in the smaller molar amount."}]$op57$::jsonb,
    'A',
    $ex57$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the equation \(2\,\text{C} + \text{O}_2 \rightarrow 2\,\text{CO}\) requires \(\text{C}\) and \(\text{O}_2\) in a \(2:1\) mole ratio, and the supplied \(3.0:2.0\) mixture provides only a \(1.5:1\) ratio, which is short of the carbon needed. Test by trying to consume each reactant fully: to use all \(2.0\ \text{mol}\) of \(\text{O}_2\) you need \(2.0\ \text{mol}\ \text{O}_2 \times \tfrac{2\ \text{mol C}}{1\ \text{mol O}_2} = 4.0\ \text{mol}\ \text{C}\), but only \(3.0\ \text{mol}\ \text{C}\) is present, so carbon runs out first. Equivalently, to use all \(3.0\ \text{mol}\ \text{C}\) requires \(3.0\ \text{mol}\ \text{C} \times \tfrac{1\ \text{mol O}_2}{2\ \text{mol C}} = 1.5\ \text{mol}\ \text{O}_2\), leaving \(2.0 - 1.5 = 0.5\ \text{mol}\ \text{O}_2\) in excess. Carbon is therefore the limiting reactant. (Choice B) This inverts the stoichiometric ratio, using \(2\ \text{mol O}_2\) per \(1\ \text{mol C}\) to compute \(6.0\ \text{mol}\ \text{O}_2\); the balanced equation gives \(1\ \text{mol O}_2\) per \(2\ \text{mol C}\), so \(\text{C}\) (not \(\text{O}_2\)) is limiting. (Choice C) This skips the mole-ratio comparison and treats the raw amounts \(3.0\) and \(2.0\) as a matched pair; because the required ratio is \(2:1\) and the supplied ratio is only \(1.5:1\), one reactant must run out first and \(\text{O}_2\) is left in excess. (Choice D) This compares raw mole counts and assumes the reactant present in the smaller amount must be limiting; limiting reactant is set by the amount relative to the stoichiometric ratio, and here the \(2.0\ \text{mol}\ \text{O}_2\) is actually in excess. Skill 4$ex57$,
    'hard', '4E', $cc57$Stoichiometry (GC)$cc57$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a57B$Inverts the stoichiometric ratio, using 2 mol O2 per 1 mol C instead of 1 mol O2 per 2 mol C, so the wrong reactant is named limiting$a57B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a57C$Omits the mole-ratio comparison entirely and treats the raw 3.0 and 2.0 mol amounts as a stoichiometrically matched pair that consumes together$a57C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a57D$Assumes the reactant present in the smaller molar amount is automatically limiting, ignoring the stoichiometric ratio$a57D$ FROM q;

-- Q11 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g58)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt58$Sodium burns in excess chlorine by the reaction \(2\,\text{Na} + \text{Cl}_2 \rightarrow 2\,\text{NaCl}\). A \(4.6\,\text{g}\) sample of \(\text{Na}\) (molar mass \(23\,\text{g/mol}\)) reacts completely with the excess \(\text{Cl}_2\). The theoretical mass of \(\text{NaCl}\) (molar mass \(58.5\,\text{g/mol}\)) produced is most nearly$qt58$,
    $op58$[{"label":"A","text":"\\(23.4\\,\\text{g}\\)"},{"label":"B","text":"\\(5.85\\,\\text{g}\\)"},{"label":"C","text":"\\(9.2\\,\\text{g}\\)"},{"label":"D","text":"\\(11.7\\,\\text{g}\\)"}]$op58$::jsonb,
    'D',
    $ex58$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because converting the limiting reagent to moles, applying the balanced mole ratio, and converting product moles to grams gives \(11.7\,\text{g}\). First find moles of sodium: \(4.6\,\text{g} \div 23\,\text{g/mol} = 0.20\,\text{mol Na}\). The balanced equation \(2\,\text{Na} + \text{Cl}_2 \rightarrow 2\,\text{NaCl}\) sets a \(2{:}2\) (i.e. \(1{:}1\)) ratio of \(\text{Na}\) to \(\text{NaCl}\), so \(0.20\,\text{mol Na}\) yields \(0.20\,\text{mol NaCl}\). Finally, \(0.20\,\text{mol} \times 58.5\,\text{g/mol} = 11.7\,\text{g NaCl}\). Because \(\text{Cl}_2\) is in excess, sodium is the limiting reagent and fixes the theoretical yield. (Choice A) \(23.4\,\text{g}\) results from doubling the product moles to \(0.40\,\text{mol}\) by misreading the coefficient of \(2\) on \(\text{NaCl}\) as a multiplier on the moles already determined, then \(0.40 \times 58.5 = 23.4\); the coefficient defines the ratio, not an extra doubling. (Choice B) \(5.85\,\text{g}\) results from halving the product moles to \(0.10\,\text{mol}\), as if the \(2{:}2\) ratio meant two moles of \(\text{Na}\) per one mole of \(\text{NaCl}\); inverting that ratio understates the product, since the ratio is \(1{:}1\). (Choice C) \(9.2\,\text{g}\) results from multiplying the \(0.40\,\text{mol}\) value by the molar mass of \(\text{Na}\) (\(23\,\text{g/mol}\)) instead of \(\text{NaCl}\) (\(0.40 \times 23 = 9.2\)); the product mass must use the molar mass of the product, \(58.5\,\text{g/mol}\). Skill 2$ex58$,
    'medium', '4E', $cc58$Stoichiometry (GC)$cc58$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a58A$coefficient misread as extra mole-doubling$a58A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a58B$inverted Na-to-NaCl mole ratio halving product$a58B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a58C$product mass computed with reactant molar mass$a58C$ FROM q;

-- Q12 [Limiting Reagent, Theoretical & Percent Yield · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g59)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt59$Magnesium burns in nitrogen by the balanced equation \(3\,\text{Mg} + \text{N}_2 \rightarrow \text{Mg}_3\text{N}_2\). A reactor is charged with \(7.29\,\text{g}\) of \(\text{Mg}\) (\(24.3\,\text{g/mol}\)) and \(5.6\,\text{g}\) of \(\text{N}_2\) (\(28\,\text{g/mol}\)). Which reactant limits the amount of \(\text{Mg}_3\text{N}_2\) formed?$qt59$,
    $op59$[{"label":"A","text":"\\(\\text{Mg}\\)"},{"label":"B","text":"\\(\\text{N}_2\\), because \\(5.6\\,\\text{g}\\) is the smaller starting mass"},{"label":"C","text":"\\(\\text{N}_2\\), because \\(0.200\\,\\text{mol}\\) is fewer moles than \\(0.300\\,\\text{mol}\\)"},{"label":"D","text":"Neither; both are consumed exactly, so neither limits the reaction"}]$op59$::jsonb,
    'A',
    $ex59$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because \(\text{Mg}\) runs out first once the moles are scaled by the balanced 3:1 stoichiometric ratio. First convert each mass to moles: \(7.29\,\text{g} \div 24.3\,\text{g/mol} = 0.300\,\text{mol}\) \(\text{Mg}\) and \(5.6\,\text{g} \div 28\,\text{g/mol} = 0.200\,\text{mol}\) \(\text{N}_2\). The equation \(3\,\text{Mg} + \text{N}_2 \rightarrow \text{Mg}_3\text{N}_2\) consumes \(\text{Mg}\) and \(\text{N}_2\) in a 3:1 ratio, so \(0.300\,\text{mol}\) \(\text{Mg}\) requires only \(0.300 \div 3 = 0.100\,\text{mol}\) \(\text{N}_2\). Because \(0.200\,\text{mol}\) \(\text{N}_2\) is present but only \(0.100\,\text{mol}\) is needed, \(\text{N}_2\) is in excess (by \(0.100\,\text{mol}\)) and \(\text{Mg}\) is the limiting reactant. (Choice B) Comparing the raw starting masses (\(5.6\,\text{g} < 7.29\,\text{g}\)) ignores molar mass and the stoichiometric ratio; mass alone never identifies the limiting reactant. (Choice C) Comparing raw moles (\(0.200\,\text{mol}\) vs \(0.300\,\text{mol}\)) without dividing by the coefficients reverses the result, since the 3:1 ratio means the larger \(\text{Mg}\) mole count is actually the deficient one. (Choice D) The reactants are not in a 3:1 mole ratio (\(0.300:0.200\) is \(1.5:1\), not \(3:1\)), so they cannot both be consumed exactly; one must remain in excess. Skill 4$ex59$,
    'hard', '4E', $cc59$Stoichiometry (GC)$cc59$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a59B$Compares raw starting masses and picks the smaller mass as limiting without converting to moles$a59B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a59C$Compares raw moles without applying the 3:1 coefficient ratio, reversing which reactant is in deficit$a59C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a59D$Assumes the given amounts must react exactly, inverting/ignoring the required 3:1 mole ratio$a59D$ FROM q;

-- Q13 [Limiting Reagent, Theoretical & Percent Yield · hard · Skill 4 · 4E Stoichiometry (GC) · ans B] (g60)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt60$Heating \(10.0\,\text{g}\) of \(\text{CaCO}_3\) (molar mass \(100\,\text{g/mol}\)) drives the decomposition \(\text{CaCO}_3 \rightarrow \text{CaO} + \text{CO}_2\), and \(4.48\,\text{g}\) of \(\text{CaO}\) (molar mass \(56\,\text{g/mol}\); \(\text{CO}_2\) molar mass \(44\,\text{g/mol}\)) is recovered. The percent yield of \(\text{CaO}\) is closest to which value?$qt60$,
    $op60$[{"label":"A","text":"\\(44.8\\%\\)"},{"label":"B","text":"\\(80.0\\%\\)"},{"label":"C","text":"\\(125\\%\\)"},{"label":"D","text":"\\(89.6\\%\\)"}]$op60$::jsonb,
    'B',
    $ex60$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the actual \(4.48\,\text{g}\) of \(\text{CaO}\) recovered is \(80.0\%\) of the \(5.60\,\text{g}\) of \(\text{CaO}\) the reaction can theoretically produce. The \(10.0\,\text{g}\) of \(\text{CaCO}_3\) corresponds to \(\frac{10.0\,\text{g}}{100\,\text{g/mol}} = 0.100\,\text{mol}\). Because the balanced equation has a \(1:1\) mole ratio of \(\text{CaCO}_3\) to \(\text{CaO}\), the theoretical amount of \(\text{CaO}\) is \(0.100\,\text{mol}\), or \(0.100\,\text{mol} \times 56\,\text{g/mol} = 5.60\,\text{g}\). Percent yield is actual divided by theoretical times \(100\): \(\frac{4.48\,\text{g}}{5.60\,\text{g}} \times 100 = 80.0\%\). (Choice A) \(44.8\%\) comes from dividing the actual \(\text{CaO}\) mass by the starting reactant mass, \(\frac{4.48\,\text{g}}{10.0\,\text{g}} \times 100\); the denominator of percent yield is the theoretical product mass \((5.60\,\text{g})\), not the mass of \(\text{CaCO}_3\) charged. (Choice C) \(125\%\) inverts the ratio to theoretical over actual, \(\frac{5.60\,\text{g}}{4.48\,\text{g}} \times 100\); a yield above \(100\%\) is impossible here and signals the fraction was flipped. (Choice D) \(89.6\%\) results from splitting the \(100\,\text{g/mol}\) of \(\text{CaCO}_3\) evenly between the two products to assign \(\text{CaO}\) a molar mass of \(50\,\text{g/mol}\) (the average of \(56\) and \(44\,\text{g/mol}\)), giving a theoretical mass of \(0.100\,\text{mol} \times 50\,\text{g/mol} = 5.00\,\text{g}\) and \(\frac{4.48\,\text{g}}{5.00\,\text{g}} \times 100\); the theoretical \(\text{CaO}\) mass must use the actual \(\text{CaO}\) molar mass of \(56\,\text{g/mol}\), since the \(\text{CO}_2\) leaves as gas and does not lower the molar mass of the solid product. Skill 4$ex60$,
    'hard', '4E', $cc60$Stoichiometry (GC)$cc60$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a60A$divided actual product mass by reactant mass instead of theoretical product mass$a60A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a60C$inverted percent-yield ratio (theoretical over actual)$a60C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a60D$averaged CaO and CO2 molar masses to get a 50 g/mol product, folding the CO2 into the solid's theoretical mass$a60D$ FROM q;

-- Q14 [Limiting Reagent, Theoretical & Percent Yield · hard · Skill 4 · 4E Stoichiometry (GC) · ans C] (g61)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt61$In a blast furnace, iron(III) oxide reacts with carbon monoxide: \(\text{Fe}_2\text{O}_3 + 3\,\text{CO} \rightarrow 2\,\text{Fe} + 3\,\text{CO}_2\). A charge of \(0.10\ \text{mol}\) \(\text{Fe}_2\text{O}_3\) is combined with \(0.45\ \text{mol}\) \(\text{CO}\), and the molar mass of \(\text{Fe}\) is \(56\ \text{g/mol}\). What is the theoretical mass of \(\text{Fe}\) produced?$qt61$,
    $op61$[{"label":"A","text":"\\(25.2\\ \\text{g}\\)"},{"label":"B","text":"\\(16.8\\ \\text{g}\\)"},{"label":"C","text":"\\(11.2\\ \\text{g}\\)"},{"label":"D","text":"\\(5.6\\ \\text{g}\\)"}]$op61$::jsonb,
    'C',
    $ex61$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because \(\text{Fe}_2\text{O}_3\) is the limiting reagent, and it produces \(0.20\ \text{mol}\) of \(\text{Fe}\), or \(11.2\ \text{g}\). First identify the limiting reagent: the \(3:1\) coefficient ratio means \(0.10\ \text{mol}\) \(\text{Fe}_2\text{O}_3\) would require \(0.10 \times 3 = 0.30\ \text{mol}\) \(\text{CO}\). Because \(0.45\ \text{mol}\) \(\text{CO}\) is available and only \(0.30\ \text{mol}\) is needed, \(\text{CO}\) is in excess and \(\text{Fe}_2\text{O}_3\) limits the reaction. Using the \(1:2\) ratio of \(\text{Fe}_2\text{O}_3\) to \(\text{Fe}\): \(0.10\ \text{mol}\,\text{Fe}_2\text{O}_3 \times \frac{2\ \text{mol}\,\text{Fe}}{1\ \text{mol}\,\text{Fe}_2\text{O}_3} = 0.20\ \text{mol}\,\text{Fe}\). Converting to mass: \(0.20\ \text{mol} \times 56\ \text{g/mol} = 11.2\ \text{g}\). (Choice A) \(25.2\ \text{g}\) results from using the \(0.45\ \text{mol}\) of \(\text{CO}\) directly as the moles of \(\text{Fe}\) (\(0.45 \times 56 = 25.2\ \text{g}\)), ignoring the balanced equation and the limiting-reagent analysis entirely. (Choice B) \(16.8\ \text{g}\) results from treating \(\text{CO}\) as limiting and applying the \(3:2\) ratio (\(0.45 \times \tfrac{2}{3} = 0.30\ \text{mol}\,\text{Fe}\); \(0.30 \times 56 = 16.8\ \text{g}\)), even though \(\text{CO}\) is actually in excess. (Choice D) \(5.6\ \text{g}\) results from omitting the \(1:2\) product ratio and setting moles of \(\text{Fe}\) equal to moles of \(\text{Fe}_2\text{O}_3\) (\(0.10 \times 56 = 5.6\ \text{g}\)). Skill 4$ex61$,
    'hard', '4E', $cc61$Stoichiometry (GC)$cc61$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a61A$Uses the excess reagent's mole count directly as product moles, skipping the balanced-equation mole ratio$a61A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a61B$Selects the wrong limiting reagent (treats the excess CO as limiting) then applies the correct ratio$a61B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a61D$Forgets the 1:2 limiting-reagent-to-product ratio and equates moles of product with moles of limiting reactant$a61D$ FROM q;

-- Q15 [Limiting Reagent, Theoretical & Percent Yield · easy · Skill 1 · 4E Stoichiometry (GC) · ans D] (g62)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt62$A chemist runs the synthesis \(\text{N}_2 + 3\,\text{H}_2 \rightarrow 2\,\text{NH}_3\) and isolates \(11.2\ \text{g}\) of \(\text{NH}_3\) from a reaction whose stoichiometry predicts \(15.0\ \text{g}\). Which statement correctly characterizes the relationship between the \(15.0\ \text{g}\) theoretical yield and the \(11.2\ \text{g}\) actual yield?$qt62$,
    $op62$[{"label":"A","text":"The actual yield can exceed the theoretical yield whenever the limiting reactant is contaminated with impurities."},{"label":"B","text":"The theoretical yield is fixed by the amount of the excess reactant supplied rather than by the limiting reactant."},{"label":"C","text":"The percent yield for this reaction can exceed 100% if the conversion is carried out efficiently enough."},{"label":"D","text":"The theoretical yield is the maximum mass predicted from the limiting reactant, and the actual yield is lower because of side reactions, incomplete reaction, or losses during recovery."}]$op62$::jsonb,
    'D',
    $ex62$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the theoretical yield is the maximum mass of product that stoichiometry predicts when the limiting reactant is converted completely, and any genuinely measured actual yield is at most that value. Here stoichiometry of \(\text{N}_2 + 3\,\text{H}_2 \rightarrow 2\,\text{NH}_3\) predicts \(15.0\ \text{g}\) of \(\text{NH}_3\) (the theoretical yield), while the chemist recovers only \(11.2\ \text{g}\); the shortfall arises from real-world effects such as competing side reactions, reactions that do not go to completion, and mechanical losses during transfer, filtration, or purification. Consequently the actual yield is normally less than the theoretical yield and the percent yield, \(\frac{11.2}{15.0}\times100\% \approx 74.7\%\), is at most 100%. (Choice A) An actual yield greater than the theoretical yield is not possible from a clean weighing; a value above theoretical signals an error or residual impurity in the isolated product (e.g., trapped solvent or unreacted material), not a real excess of product, and impurity in the reactant cannot create more product than the limiting reactant allows. (Choice B) The theoretical yield is set by the limiting reactant, which is fully consumed; the excess reactant, by definition, remains left over and does not determine how much product can form. (Choice C) Percent yield is actual yield divided by theoretical yield times 100%, and because the theoretical yield is the maximum possible product, an efficiency interpretation cannot push a correctly measured percent yield above 100%. Skill 1$ex62$,
    'easy', '4E', $cc62$Stoichiometry (GC)$cc62$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a62A$actual yield exceeds theoretical when reactant is impure$a62A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a62B$theoretical yield depends on the excess reactant rather than the limiting reactant$a62B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a62C$percent yield can exceed 100% if the reaction is efficient$a62C$ FROM q;

-- Q16 [Limiting Reagent, Theoretical & Percent Yield · medium · Skill 3 · 4E Stoichiometry (GC) · ans A] (g63)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Limiting Reagent, Theoretical & Percent Yield',
    $qt63$A chemist runs the synthesis of aspirin twice from identical starting amounts; the first run gives a \(92\%\) yield and the second gives a \(60\%\) yield. Holding the reaction and the starting quantities fixed, the higher percent yield most accurately indicates which of the following about the first run?$qt63$,
    $op63$[{"label":"A","text":"A greater fraction of the theoretical maximum product was actually recovered."},{"label":"B","text":"A larger amount of the limiting reagent was consumed than in the second run."},{"label":"C","text":"The theoretical yield of product was higher than in the second run."},{"label":"D","text":"The molar mass of the product was larger than in the second run."}]$op63$::jsonb,
    'A',
    $ex63$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because percent yield is defined as \(\text{percent yield} = \frac{\text{actual yield}}{\text{theoretical yield}}\times100\%\), so it reports the fraction of the theoretical maximum that was actually obtained. Because both runs start from identical amounts of the same reactants, the theoretical yield (the amount predicted from the limiting reagent and the balanced equation) is the same fixed number for both runs. A \(92\%\) result therefore means \(92\%\) of that unchanged theoretical maximum was recovered, versus only \(60\%\) in the second run, so the higher percent yield reflects a more efficient recovery of product, not any change in the maximum that could have formed. (Choice B) The starting amounts, and therefore the moles of limiting reagent available, are stated to be identical in both runs; percent yield compares product recovered to the theoretical maximum and does not measure how much limiting reagent was used, so a higher percent yield does not mean more limiting reagent was consumed. (Choice C) Theoretical yield depends only on the limiting reagent amount and the stoichiometry of the balanced equation, both of which are fixed across the two identical runs, so the theoretical yield is the same denominator in both percent-yield calculations and is not raised by a higher percent yield. (Choice D) The molar mass of a given product is a fixed property of that compound and is the same regardless of how the reaction proceeds; it is an input used to convert between mass and moles, not a quantity that changes between runs or that a higher percent yield reflects. Skill 3$ex63$,
    'medium', '4E', $cc63$Stoichiometry (GC)$cc63$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a63B$Treats a higher percent yield as evidence that more limiting reagent was consumed, conflating recovery efficiency with reactant amount despite identical starting quantities$a63B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a63C$Attributes the higher percent yield to a larger theoretical yield, ignoring that identical starting amounts fix the theoretical maximum (the denominator) for both runs$a63C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a63D$Treats product molar mass as a variable affected by the run, when it is a fixed property of the compound and unrelated to percent yield$a63D$ FROM q;

-- Q17 [Ions, Nomenclature & Electrolytes · easy · Skill 2 · 5A Ions in Solutions (GC) · ans B] (g64)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt64$A salt forms from \(\text{Ca}^{2+}\) and \(\text{F}^{-}\) ions. Which formula represents the neutral compound?$qt64$,
    $op64$[{"label":"A","text":"\\(\\text{CaF}\\)"},{"label":"B","text":"\\(\\text{CaF}_2\\)"},{"label":"C","text":"\\(\\text{Ca}_2\\text{F}\\)"},{"label":"D","text":"\\(\\text{CaF}_3\\)"}]$op64$::jsonb,
    'B',
    $ex64$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is B because the formula must balance the given charges so the net charge is zero. A neutral ionic compound needs total positive charge equal to total negative charge. Each \(\text{Ca}^{2+}\) supplies \(+2\) and each \(\text{F}^{-}\) supplies \(-1\), so two fluoride ions are required to offset one calcium ion: \(1 \times (+2) + 2 \times (-1) = 0\). Criss-crossing the magnitudes of the charges gives the subscripts directly: the \(2\) from \(\text{Ca}^{2+}\) becomes the subscript on \(\text{F}\), and the \(1\) from \(\text{F}^{-}\) becomes the subscript on \(\text{Ca}\), yielding \(\text{CaF}_2\). (Choice A) \(\text{CaF}\) pairs the ions in a \(1{:}1\) ratio, which leaves a net charge of \(+2 + (-1) = +1\); it ignores that two \(-1\) fluoride ions are needed to cancel one \(+2\) calcium ion. (Choice C) \(\text{Ca}_2\text{F}\) applies the subscripts to the wrong ions, putting the \(2\) on calcium instead of fluoride; this gives a net charge of \(2 \times (+2) + (-1) = +3\) and is not neutral. (Choice D) \(\text{CaF}_3\) uses three fluoride ions, producing a net charge of \(+2 + 3 \times (-1) = -1\); only two fluoride ions are needed to balance the \(+2\) calcium ion. Skill 2$ex64$,
    'easy', '5A', $cc64$Ions in Solutions (GC)$cc64$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a64A$Ignored fluoride charge count, used 1:1 ratio$a64A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a64C$Crisscrossed subscript onto the wrong ion$a64C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a64D$Wrong subscript on fluoride, overcounted anions$a64D$ FROM q;

-- Q18 [Ions, Nomenclature & Electrolytes · medium · Skill 2 · 5A Ions in Solutions (GC) · ans C] (g65)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt65$An ionic compound forms from aluminum cations carrying a charge of \(\text{Al}^{3+}\) and sulfide anions carrying a charge of \(\text{S}^{2-}\). Combining these ions in the ratio that yields an electrically neutral formula unit most likely gives which formula?$qt65$,
    $op65$[{"label":"A","text":"\\(\\text{AlS}\\)"},{"label":"B","text":"\\(\\text{Al}_3\\text{S}_2\\)"},{"label":"C","text":"\\(\\text{Al}_2\\text{S}_3\\)"},{"label":"D","text":"\\(\\text{Al}_6\\text{S}_6\\)"}]$op65$::jsonb,
    'C',
    $ex65$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is C because the neutral formula unit must contain just enough cations and anions that the total positive and total negative charge cancel. The aluminum ion carries \(3+\) and the sulfide ion carries \(2-\); the smallest whole-number ratio that balances these is found by criss-crossing the charge magnitudes so each ion's subscript equals the other ion's charge. This makes the subscript on \(\text{Al}\) equal to \(2\) (the magnitude of the sulfide charge) and the subscript on \(\text{S}\) equal to \(3\) (the magnitude of the aluminum charge), giving \(\text{Al}_2\text{S}_3\). Checking the balance: two \(\text{Al}^{3+}\) contribute \(2 \times (+3) = +6\) and three \(\text{S}^{2-}\) contribute \(3 \times (-2) = -6\), so the net charge is \(+6 + (-6) = 0\) and the subscripts \(2\) and \(3\) share no common factor, confirming the lowest-ratio neutral formula. (Choice A) \(\text{AlS}\) pairs one \(\text{Al}^{3+}\) with one \(\text{S}^{2-}\), giving a net charge of \(+3 + (-2) = +1\); a 1:1 ratio ignores that the unequal charges require unequal numbers of ions to cancel. (Choice B) \(\text{Al}_3\text{S}_2\) assigns each ion a subscript equal to its own charge magnitude rather than the partner ion's charge, reversing the criss-cross and giving \(3 \times (+3) + 2 \times (-2) = +9 - 4 = +5\), which is not neutral. (Choice D) \(\text{Al}_6\text{S}_6\) uses the least common multiple \(6\) as the subscript on both ions; although \(6 \times (+3) + 6 \times (-2) = +18 - 12 = +6 \neq 0\) is not even neutral, the deeper error is failing to reduce to the smallest balancing ratio, which must instead pair the LCM-derived counts as \(2\) aluminum and \(3\) sulfide. Skill 2$ex65$,
    'medium', '5A', $cc65$Ions in Solutions (GC)$cc65$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a65A$naive 1:1 ratio ignoring criss-cross of unequal charges$a65A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a65B$subscripts set to each ion's own charge instead of partner's (criss-cross reversed)$a65B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a65D$LCM used as subscript on both ions without reducing to lowest balancing ratio$a65D$ FROM q;

-- Q19 [Ions, Nomenclature & Electrolytes · medium · Skill 2 · 5A Ions in Solutions (GC) · ans D] (g66)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt66$A solution contains sodium ions \(\text{Na}^{+}\) and carbonate ions \(\text{CO}_3^{2-}\). When these ions combine to form a neutral solid, which formula represents the resulting compound?$qt66$,
    $op66$[{"label":"A","text":"\\(\\text{NaCO}_3\\)"},{"label":"B","text":"\\(\\text{Na}(\\text{CO}_3)_2\\)"},{"label":"C","text":"\\(\\text{Na}_3\\text{CO}_3\\)"},{"label":"D","text":"\\(\\text{Na}_2\\text{CO}_3\\)"}]$op66$::jsonb,
    'D',
    $ex66$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is D because each sodium ion carries a \(+1\) charge and each carbonate ion carries a \(-2\) charge, so two \(\text{Na}^{+}\) (total \(+2\)) are needed to balance one \(\text{CO}_3^{2-}\) (total \(-2\)), giving the neutral formula \(\text{Na}_2\text{CO}_3\). Using the criss-cross method, the magnitude of the carbonate charge \((2)\) becomes the subscript on sodium, and the magnitude of the sodium charge \((1)\) becomes the subscript on the intact carbonate group: \(\text{Na}_{2}(\text{CO}_3)_{1} = \text{Na}_2\text{CO}_3\). Net charge check: \(2(+1) + 1(-2) = 0\). (Choice A) \(\text{NaCO}_3\) treats sodium as if it balanced carbonate one-to-one, ignoring that one \(\text{Na}^{+}\) supplies only \(+1\) and leaves a net charge of \(-1\). (Choice B) \(\text{Na}(\text{CO}_3)_2\) reverses the subscripts, placing the multiplier on carbonate instead of sodium and giving a net charge of \(+1 - 4 = -3\). (Choice C) \(\text{Na}_3\text{CO}_3\) uses three sodium ions, which would balance a \(-3\) anion, not the \(-2\) carbonate, leaving a net charge of \(+1\). Skill 2$ex66$,
    'medium', '5A', $cc66$Ions in Solutions (GC)$cc66$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a66A$ignored_ion_charge_one_to_one$a66A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a66B$swapped_crisscross_subscripts$a66B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a66C$mismatched_subscript_to_charge$a66C$ FROM q;

-- Q20 [Ions, Nomenclature & Electrolytes · medium · Skill 1 · 5A Ions in Solutions (GC) · ans A] (g67)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt67$The ionic compound \(\text{FeCl}_3\) contains chloride ions, each carrying a \(-1\) charge. Name this compound using both the Roman numeral (Stock) and the older \(\text{-ous}/\text{-ic}\) systems.$qt67$,
    $op67$[{"label":"A","text":"iron(III) chloride; ferric chloride"},{"label":"B","text":"iron(II) chloride; ferrous chloride"},{"label":"C","text":"iron(I) chloride; ferrous chloride"},{"label":"D","text":"iron(III) chloride; ironic chloride"}]$op67$::jsonb,
    'A',
    $ex67$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is A because the iron charge is fixed by the requirement that a neutral ionic compound have zero net charge. With three chloride ions at \(-1\) each, the total negative charge is \(3\times(-1) = -3\), so the single iron cation must be \(+3\) to balance it: \(\text{Fe}^{3+}\). In the Stock system the cation charge is written as a Roman numeral, giving iron(III) chloride. In the older Latin-root system, the higher of an element's two common charges takes the \(\text{-ic}\) suffix, so \(\text{Fe}^{3+}\) is ferric and the compound is ferric chloride. (Choice B) iron(II)/ferrous corresponds to \(\text{Fe}^{2+}\), which would balance only two chloride ions \((\text{FeCl}_2)\), not the three present in \(\text{FeCl}_3\). (Choice C) iron(I) treats iron as \(+1\), which would balance only one chloride \((\text{FeCl})\); it also mislabels \(+1\) as ferrous, a name reserved for \(\text{Fe}^{2+}\). (Choice D) the Stock name iron(III) is correct, but "ironic" is a malformed Latin-system name; the proper \(\text{-ic}\) form for \(\text{Fe}^{3+}\) uses the Latin stem ferr-, yielding ferric, not ironic. Skill 1$ex67$,
    'medium', '5A', $cc67$Ions in Solutions (GC)$cc67$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a67B$Uses the wrong (lower) iron charge Fe2+ that does not balance three chloride ions$a67B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a67C$Assigns Fe+1 ignoring the three-chloride charge balance and misapplies the ferrous label$a67C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a67D$Correct Stock name but forms the -ic name from the English root (ironic) instead of the Latin ferr- stem (ferric)$a67D$ FROM q;

-- Q21 [Ions, Nomenclature & Electrolytes · medium · Skill 1 · 5A Ions in Solutions (GC) · ans B] (g68)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt68$A binary compound has the formula \(\text{Cu}_2\text{O}\), in which oxygen is present as the oxide ion \(\text{O}^{2-}\). Given that the compound is electrically neutral, which name correctly specifies the oxidation state of copper using both the Stock (Roman numeral) and the classical (\(\text{-ous}/\text{-ic}\)) systems?$qt68$,
    $op68$[{"label":"A","text":"Copper(II) oxide, also called cupric oxide"},{"label":"B","text":"Copper(I) oxide, also called cuprous oxide"},{"label":"C","text":"Copper(I) oxide, also called cupric oxide"},{"label":"D","text":"Copper(II) oxide, also called cuprous oxide"}]$op68$::jsonb,
    'B',
    $ex68$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is B because in \(\text{Cu}_2\text{O}\) the single oxide ion carries a \(2-\) charge, and for the neutral compound the two copper atoms must together supply a \(2+\) charge; dividing that charge equally gives each copper a \(+1\) oxidation state. A copper cation of charge \(+1\) is named copper(I) in the Stock system, and the classical Latin-root system assigns the lower of a metal's two common charges the \(\text{-ous}\) suffix, giving cuprous. Both systems therefore name \(\text{Cu}_2\text{O}\) as copper(I) oxide / cuprous oxide. (Choice A) Copper(II) oxide / cupric oxide is the correct name for \(\text{CuO}\), the compound in which one \(\text{Cu}^{2+}\) balances one \(\text{O}^{2-}\); it assigns copper the \(+2\) charge that does not satisfy the \(2:1\) Cu-to-O ratio in \(\text{Cu}_2\text{O}\). (Choice C) The Stock numeral correctly reads copper(I), but \(\text{-ic}\) is the classical suffix reserved for the higher charge (\(\text{Cu}^{2+}\)); pairing copper(I) with cupric crosses the two naming systems so that the Roman numeral and the Latin suffix describe different charges. (Choice D) This pairing inverts both labels relative to the charge: it assigns the \(+2\) Stock numeral while attaching \(\text{-ous}\), the suffix reserved for the lower \(+1\) charge, so neither label matches the actual \(+1\) oxidation state of copper in \(\text{Cu}_2\text{O}\). Skill 1$ex68$,
    'medium', '5A', $cc68$Ions in Solutions (GC)$cc68$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a68A$name of the other copper oxide CuO (Cu2+) supplied for Cu2O$a68A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a68C$correct Stock numeral but mismatched -ic classical suffix (systems crossed)$a68C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a68D$both labels inverted: +2 numeral paired with the lower-charge -ous suffix$a68D$ FROM q;

-- Q22 [Ions, Nomenclature & Electrolytes · easy · Skill 1 · 5A Ions in Solutions (GC) · ans D] (g70)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt70$The ionic compound \(\text{Na}_2\text{S}\) is built from sodium cations and the monatomic anion \(\text{S}^{2-}\). The \(\text{S}^{2-}\) ion contributes which name to the compound \(\text{Na}_2\text{S}\)?$qt70$,
    $op70$[{"label":"A","text":"Sulfite"},{"label":"B","text":"Sulfate"},{"label":"C","text":"Sulfurous"},{"label":"D","text":"Sulfide"}]$op70$::jsonb,
    'D',
    $ex70$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is D because a monatomic anion is named by taking the root of the element's name and appending the suffix -ide. The element is sulfur, whose root is "sulf-," so the monatomic anion \(\text{S}^{2-}\) is named "sulfide," and the binary ionic compound \(\text{Na}_2\text{S}\) is sodium sulfide. The -ide ending is the defining marker of a single-element (monatomic) anion, distinguishing it from the polyatomic oxyanions of the same element. (Choice A) "Sulfite" is the name of the polyatomic oxyanion \(\text{SO}_3^{2-}\), which contains sulfur bonded to oxygen; the -ite suffix signals an oxygen-containing oxyanion, not the bare monatomic \(\text{S}^{2-}\). (Choice B) "Sulfate" is the name of the polyatomic oxyanion \(\text{SO}_4^{2-}\); the -ate suffix likewise denotes an oxygen-bearing oxyanion with more oxygen atoms than the -ite form, not a single sulfur anion. (Choice C) "Sulfurous" is an adjective used in naming the acid \(\text{H}_2\text{SO}_3\) (sulfurous acid), the parent acid of the sulfite ion; it is an acid name form, not the name of a monatomic anion. Skill 1$ex70$,
    'easy', '5A', $cc70$Ions in Solutions (GC)$cc70$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a70A$oxyanion -ite name (sulfite, SO3^2-) substituted for the monatomic -ide name$a70A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a70B$oxyanion -ate name (sulfate, SO4^2-) substituted for the monatomic -ide name$a70B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a70C$acid-form adjective (sulfurous, from H2SO3) used in place of the monatomic anion name$a70C$ FROM q;

-- Q23 [Ions, Nomenclature & Electrolytes · easy · Skill 1 · 5A Ions in Solutions (GC) · ans A] (g71)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt71$The nitrogen oxyanion named nitrite is \(\text{NO}_2^-\). Because the \(\text{-ate}\) ending denotes the oxyanion holding one more oxygen atom than its \(\text{-ite}\) counterpart, the formula of the nitrate ion is most likely$qt71$,
    $op71$[{"label":"A","text":"\\(\\text{NO}_3^-\\)"},{"label":"B","text":"\\(\\text{NO}_2^-\\)"},{"label":"C","text":"\\(\\text{NO}^-\\)"},{"label":"D","text":"\\(\\text{N}_2\\text{O}_3\\)"}]$op71$::jsonb,
    'A',
    $ex71$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is A because within a family of oxyanions formed by the same central atom, the name ending fixes the oxygen count: the \(\text{-ate}\) form carries exactly one more oxygen than the \(\text{-ite}\) form, while the ionic charge stays the same across the pair. Nitrite is given as \(\text{NO}_2^-\), so adding one oxygen and keeping the \(1-\) charge gives nitrate as \(\text{NO}_3^-\). (Choice B) \(\text{NO}_2^-\) is the formula of nitrite itself; assigning it to nitrate swaps the two members of the pair and ignores that \(\text{-ate}\) must hold one more oxygen than \(\text{-ite}\). (Choice C) \(\text{NO}^-\) has one fewer oxygen than nitrite rather than one more; this moves the oxygen count in the wrong direction, the change associated with the lower \(\text{hypo-...-ite}\) tier rather than with \(\text{-ate}\). (Choice D) \(\text{N}_2\text{O}_3\) merges the atoms of the two oxyanions into a single neutral formula and drops the ionic charge, treating the \(\text{-ite}\)/\(\text{-ate}\) relationship as a combination of formulas rather than a one-oxygen difference on a single anion. Skill 1$ex71$,
    'easy', '5A', $cc71$Ions in Solutions (GC)$cc71$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a71B$nitrate-formula-swapped-with-nitrite$a71B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a71C$oxygen-count-decremented-instead-of-incremented$a71C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a71D$two-oxyanion-formulas-combined-into-neutral-compound$a71D$ FROM q;

-- Q24 [Ions, Nomenclature & Electrolytes · medium · Skill 2 · 5A Ions in Solutions (GC) · ans B] (g72)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt72$A label lists the oxidizer in a solid rocket propellant as ammonium perchlorate. Using the chlorine oxyanion series in which each added oxygen advances the name from hypochlorite to chlorite to chlorate to perchlorate, which formula corresponds to the perchlorate ion in that compound?$qt72$,
    $op72$[{"label":"A","text":"\\(\\text{ClO}_3^{-}\\)"},{"label":"B","text":"\\(\\text{ClO}_4^{-}\\)"},{"label":"C","text":"\\(\\text{ClO}^{-}\\)"},{"label":"D","text":"\\(\\text{ClO}_2^{-}\\)"}]$op72$::jsonb,
    'B',
    $ex72$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is B because the prefix per- marks the oxyanion bearing the most oxygen atoms in the chlorine series, which is \(\text{ClO}_4^{-}\). The series builds from the central -ate name outward: chlorate is \(\text{ClO}_3^{-}\); adding one oxygen and the per- prefix gives perchlorate, \(\text{ClO}_4^{-}\); removing one oxygen and switching to -ite gives chlorite, \(\text{ClO}_2^{-}\); and removing one more oxygen with the hypo- prefix gives hypochlorite, \(\text{ClO}^{-}\). Per- (from "hyper") therefore denotes one more oxygen than the -ate ion, fixing perchlorate at four oxygen atoms. (Choice A) \(\text{ClO}_3^{-}\) is chlorate, the -ate ion with three oxygen atoms that serves as the reference point of the series; perchlorate carries one additional oxygen beyond it, so chlorate is the adjacent rung rather than the per- member. (Choice C) \(\text{ClO}^{-}\) is hypochlorite, the ion with the fewest oxygen atoms; assigning it to perchlorate inverts the direction of the prefix scale, since hypo- marks the oxygen-poor end and per- marks the oxygen-rich end. (Choice D) \(\text{ClO}_2^{-}\) is chlorite, the -ite ion with two oxygen atoms; matching the per- prefix to chlorite confuses the -ite root with the per-...-ate naming pattern that perchlorate follows. Skill 2$ex72$,
    'medium', '5A', $cc72$Ions in Solutions (GC)$cc72$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a72A$chlorate-ClO3-mistaken-for-perchlorate$a72A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a72C$hypochlorite-fewest-oxygen-assigned-to-per-prefix$a72C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a72D$per-prefix-matched-to-ite-root-chlorite$a72D$ FROM q;

-- Q25 [Ions, Nomenclature & Electrolytes · medium · Skill 1 · 5A Ions in Solutions (GC) · ans C] (g73)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt73$The antacid \(\text{NaHCO}_3\) dissociates in water to release a sodium cation and the polyatomic anion \(\text{HCO}_3^-\). Following standard ionic nomenclature, the \(\text{HCO}_3^-\) anion is named$qt73$,
    $op73$[{"label":"A","text":"carbonate"},{"label":"B","text":"carbonic acid"},{"label":"C","text":"hydrogen carbonate (bicarbonate)"},{"label":"D","text":"hydrogen carbide"}]$op73$::jsonb,
    'C',
    $ex73$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is C because an oxyanion that has gained one ionizable hydrogen is named by placing the prefix "hydrogen" (or, by the older convention, "bi-") in front of the parent oxyanion's name. The parent anion \(\text{CO}_3^{2-}\) is carbonate; adding a single \(\text{H}^+\) gives \(\text{HCO}_3^-\), whose systematic name is hydrogen carbonate and whose common name is bicarbonate. The hydrogen reduces the charge from \(2-\) to \(1-\) but the carbonate root is retained, so \(\text{HCO}_3^-\) is hydrogen carbonate (bicarbonate). (Choice A) Carbonate is the name of \(\text{CO}_3^{2-}\), the fully deprotonated parent oxyanion; this name drops the ionizable hydrogen present in \(\text{HCO}_3^-\) and reports the wrong charge of \(2-\) rather than \(1-\). (Choice B) Carbonic acid is the molecular neutral compound \(\text{H}_2\text{CO}_3\), the fully protonated acid, not the singly protonated anion \(\text{HCO}_3^-\); it carries two hydrogens and no net charge. (Choice D) Hydrogen carbide applies an "-ide" ending to carbon as though the species were a binary carbon anion, but \(\text{HCO}_3^-\) is an oxygen-containing oxyanion whose root is carbonate, not carbide. Skill 1$ex73$,
    'medium', '5A', $cc73$Ions in Solutions (GC)$cc73$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a73A$dropped the ionizable hydrogen, named the parent oxyanion carbonate$a73A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a73B$named the molecular acid H2CO3 instead of the anion$a73B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a73D$applied -ide carbide root to an oxyanion$a73D$ FROM q;

-- Q26 [Ions, Nomenclature & Electrolytes · easy · Skill 1 · 5A Ions in Solutions (GC) · ans D] (g74)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt74$A technician labeling reagent bottles writes the name "phosphate" for a polyatomic anion. Which formula belongs on that label?$qt74$,
    $op74$[{"label":"A","text":"\\(\\text{PO}_3^{\\;3-}\\)"},{"label":"B","text":"\\(\\text{SO}_4^{\\;2-}\\)"},{"label":"C","text":"\\(\\text{PO}_4^{\\;2-}\\)"},{"label":"D","text":"\\(\\text{PO}_4^{\\;3-}\\)"}]$op74$::jsonb,
    'D',
    $ex74$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is D because the phosphate ion is the oxyanion of phosphorus that carries one phosphorus atom, four oxygen atoms, and an overall charge of \(3-\), giving the formula \(\text{PO}_4^{\;3-}\). Among the common polyatomic ions, the \(-ate\) ending denotes the higher-oxygen member of an oxyanion pair, and phosphate is the memorized \(\text{PO}_4^{\;3-}\); the matching \(-ite\) form, phosphite, has one fewer oxygen. (Choice A) \(\text{PO}_3^{\;3-}\) is the phosphite ion, the \(-ite\) member with one fewer oxygen atom than phosphate; the \(-ate\) name "phosphate" specifies the four-oxygen form, so the three-oxygen formula corresponds to a different name. (Choice B) \(\text{SO}_4^{\;2-}\) is the sulfate ion, built on a sulfur center with a \(2-\) charge; it shares the \(-ate\)/four-oxygen pattern but has the wrong central atom, so it answers to the name "sulfate," not "phosphate." (Choice C) \(\text{PO}_4^{\;2-}\) keeps the correct phosphorus-and-four-oxygen skeleton of phosphate but assigns a \(2-\) charge; the phosphate ion's established charge is \(3-\), so this formula is not charge-balanced as written for phosphate. Skill 1$ex74$,
    'easy', '5A', $cc74$Ions in Solutions (GC)$cc74$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a74A$Names the real but distinct -ite oxyanion (phosphite) that has one fewer oxygen than the -ate form$a74A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a74B$Substitutes a different -ate oxyanion (sulfate) with the wrong central atom, conflating two memorized polyatomic ions$a74B$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a74C$Keeps the correct atomic skeleton of phosphate but assigns the wrong ionic charge$a74C$ FROM q;

-- Q27 [Ions, Nomenclature & Electrolytes · medium · Skill 3 · 5A Ions in Solutions (GC) · ans A] (g75)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt75$A chemist dissolves the soluble ionic salt \(\text{KCl}\) in water and measures a high electrical conductivity for the resulting \(\text{KCl(aq)}\) solution. Which characterization of \(\text{KCl}\) in water accounts for this observation?$qt75$,
    $op75$[{"label":"A","text":"A strong electrolyte, because it dissociates essentially completely into \\(\\text{K}^{+}\\) and \\(\\text{Cl}^{-}\\) ions"},{"label":"B","text":"A weak electrolyte, because it dissociates only partially into \\(\\text{K}^{+}\\) and \\(\\text{Cl}^{-}\\) ions"},{"label":"C","text":"A nonelectrolyte, because it dissolves as intact \\(\\text{KCl}\\) units that release no ions"},{"label":"D","text":"A strong electrolyte, because it dissolves as intact \\(\\text{KCl}\\) molecules that carry the current"}]$op75$::jsonb,
    'A',
    $ex75$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is A because a soluble ionic salt like \(\text{KCl}\) dissociates essentially completely in water, \(\text{KCl(s)} \rightarrow \text{K}^{+}\text{(aq)} + \text{Cl}^{-}\text{(aq)}\), so the solution is packed with mobile ions that carry charge. A high concentration of mobile ions is exactly what produces high conductivity, which is the defining behavior of a strong electrolyte. The completeness of the dissociation (not the mere presence of some ions) is the hinge: full dissociation gives the maximum number of charge carriers per formula unit and therefore high conductivity. (Choice B) A weak electrolyte dissociates only partially and conducts weakly; a fully soluble ionic salt such as \(\text{KCl}\) does not stop part-way, so this mischaracterizes the extent of dissociation that the high conductivity reports. (Choice C) A nonelectrolyte dissolves without producing ions (for example, a molecular species like glucose) and gives a non-conducting solution, which contradicts the observed high conductivity. (Choice D) The conclusion "strong electrolyte" is correct, but the stated mechanism is wrong: \(\text{KCl}\) is ionic and conducts because it separates into free \(\text{K}^{+}\) and \(\text{Cl}^{-}\) ions, not because intact neutral \(\text{KCl}\) molecules move through the solution. Skill 3$ex75$,
    'medium', '5A', $cc75$Ions in Solutions (GC)$cc75$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a75B$Treats a fully soluble ionic salt as only partially dissociating, conflating it with a weak electrolyte$a75B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a75C$Claims no ions are released (nonelectrolyte) despite observed conductivity, inverting the ion-presence/conductivity relationship$a75C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a75D$Correct classification (strong electrolyte) paired with the wrong mechanism (intact molecules instead of dissociated ions)$a75D$ FROM q;

-- Q28 [Ions, Nomenclature & Electrolytes · medium · Skill 4 · 5A Ions in Solutions (GC) · ans B] (g76)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Compounds & Stoichiometry', 'Ions, Nomenclature & Electrolytes',
    $qt76$Solid \(\text{NaCl}\) registers essentially zero current when placed between two electrodes, yet the same sample conducts electricity readily once it is melted into liquid \(\text{NaCl}\). Which explanation accounts for this change in conductivity?$qt76$,
    $op76$[{"label":"A","text":"The solid contains no \\(\\text{Na}^{+}\\) or \\(\\text{Cl}^{-}\\) ions; melting is what creates the ions that then carry the current."},{"label":"B","text":"In the solid the \\(\\text{Na}^{+}\\) and \\(\\text{Cl}^{-}\\) ions are locked in fixed lattice positions and cannot move, whereas melting frees the ions so they migrate toward the electrodes and carry charge."},{"label":"C","text":"Conduction requires free electrons, and the electrons released from the \\(\\text{Na}^{+}\\) and \\(\\text{Cl}^{-}\\) ions can flow only once the compound is in the liquid state."},{"label":"D","text":"Melting breaks the covalent bonds holding \\(\\text{NaCl}\\) together, and the resulting bond fragments are what conduct the current."}]$op76$::jsonb,
    'B',
    $ex76$This is a General Chemistry question that falls under the content category 'Ions in Solutions (GC)'. The answer to this question is B because conductivity in an ionic compound depends on the ability of charged particles to move, and the only thing that changes between the two states is ion mobility, not ion identity. Solid \(\text{NaCl}\) is already built entirely from \(\text{Na}^{+}\) and \(\text{Cl}^{-}\) ions, but in the crystalline lattice each ion is fixed in place by the electrostatic attractions of its neighbors and cannot travel, so no charge flows and the solid is a poor conductor. When the lattice is melted, those same ions break free of their fixed positions and are able to migrate through the liquid toward the oppositely charged electrodes; this directed motion of charged particles constitutes an electric current, so the molten compound conducts well. (Choice A) The \(\text{Na}^{+}\) and \(\text{Cl}^{-}\) ions exist in the solid the entire time, held in the lattice; melting does not create ions, it only releases the pre-existing ones to move. (Choice C) Conduction here is carried by mobile ions, not by free electrons; an ionic compound has no pool of delocalized electrons to flow, and melting does not strip electrons off the ions. (Choice D) \(\text{NaCl}\) is held together by ionic attractions rather than covalent bonds, and melting overcomes those attractions without producing neutral fragments; the current is carried by the freed ions themselves. Skill 4$ex76$,
    'medium', '5A', $cc76$Ions in Solutions (GC)$cc76$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a76A$solid_lacks_ions_until_melted$a76A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a76C$electron_flow_carries_current_in_ionic_liquid$a76C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a76D$covalent_bonds_break_on_melting_ionic_solid$a76D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch3_questions FROM questions WHERE topic='Compounds & Stoichiometry' AND subtopic IN ('Limiting Reagent, Theoretical & Percent Yield', 'Ions, Nomenclature & Electrolytes');
