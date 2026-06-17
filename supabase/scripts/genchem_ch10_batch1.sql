-- GenChem Ch10 (Acids & Bases) — Batch 1 of 4: Autoionization, Kw & pH/pOH + Strong vs Weak Acids/Bases
-- 32 questions, all confidence >=4 (verified vs OpenStax Chemistry: Atoms First 2e + standard MCAT references; every calculation independently re-computed).
-- Cross-batch + cross-chapter deduped; final dedup audit PASS (0 genuine conflicts) after the systematic recall-answer-leak sweep.
-- AAMC foundations in this batch: 5A (per-row foundation/content_category/discipline below). Answer key balanced A/B/C/D = 24/24/24/24 across the full 96-question chapter.
-- Out of MCAT scope and deliberately excluded: normality / equivalents / gram-equivalent weight (Ch10.3 polyvalence-in-normality).
-- Re-runnable: subtopic-scoped DELETE. Run the four batches in any order in the Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Acids & Bases' AND subtopic IN ('Autoionization, Kw & the pH/pOH Scales', 'Strong vs Weak Acids/Bases; Ka and Kb');

-- Q1 [Autoionization, Kw & the pH/pOH Scales · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g1)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt1$In pure water at 25C, one water molecule transfers a proton to another. Which equation correctly represents this autoionization?$qt1$,
    $op1$[{"label":"A","text":"\\(2\\,\\text{H}_2\\text{O}(l) \\rightleftharpoons \\text{H}_3\\text{O}^+(aq) + \\text{OH}^-(aq)\\)"},{"label":"B","text":"\\(2\\,\\text{H}_2\\text{O}(l) \\rightleftharpoons 2\\,\\text{H}^+(aq) + \\text{O}_2^{2-}(aq)\\)"},{"label":"C","text":"\\(\\text{H}_2\\text{O}(l) \\rightleftharpoons \\text{H}_3\\text{O}^+(aq) + \\text{OH}^-(aq)\\)"},{"label":"D","text":"\\(\\text{H}_3\\text{O}^+(aq) + \\text{OH}^-(aq) \\rightleftharpoons 2\\,\\text{H}_2\\text{O}(l)\\)"}]$op1$::jsonb,
    'A',
    $ex1$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because autoionization involves two water molecules: one acts as a Bronsted-Lowry acid by donating a proton, and the other acts as a Bronsted-Lowry base by accepting it. The molecule that gains the proton becomes hydronium, \(\text{H}_3\text{O}^+\), and the molecule that loses the proton becomes hydroxide, \(\text{OH}^-\). The balanced equation \(2\,\text{H}_2\text{O}(l) \rightleftharpoons \text{H}_3\text{O}^+(aq) + \text{OH}^-(aq)\) conserves both mass and charge: two oxygens and four hydrogens appear on each side, and the \(+1\) and \(-1\) charges on the right sum to the neutral left side. This equilibrium is governed by \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-] = 1.0\times10^{-14}\) at 25C. (Choice B) This equation invents a peroxide-type oxygen species \(\text{O}_2^{2-}\) and bare protons rather than transferring a single proton between two water molecules; autoionization breaks one O-H bond, it does not strip both hydrogens from a water molecule or form an oxygen-oxygen species. (Choice C) Writing a single \(\text{H}_2\text{O}\) on the left cannot be balanced, because forming \(\text{H}_3\text{O}^+\) requires a second water molecule to supply the donated proton; one water molecule has only two hydrogens and one oxygen, so it cannot yield both \(\text{H}_3\text{O}^+\) (three H, one O) and \(\text{OH}^-\) (one H, one O). (Choice D) This reverses the direction of autoionization, showing hydronium and hydroxide recombining into water; the autoionization reaction is defined as water dissociating into the ions, so the reactant and product sides are written backward. Skill 1$ex1$,
    'easy', '5A', $cc1$Acid-Base Equilibria (GC, BC)$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a1B$Invents an incorrect product (peroxide ion and bare protons) instead of single-proton transfer$a1B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a1C$Uses only one water molecule, leaving the equation unbalanced for proton transfer$a1C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a1D$Writes the recombination of ions into water, reversing the autoionization direction$a1D$ FROM q;

-- Q2 [Autoionization, Kw & the pH/pOH Scales · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g2)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt2$The autoionization of water at \(25^\circ\text{C}\) is characterized by its ion-product constant, \(K_w\). In terms of the equilibrium molar concentrations of the two ions that water's self-ionization produces, which expression correctly defines \(K_w\)?$qt2$,
    $op2$[{"label":"A","text":"\\(K_w = [\\text{H}_3\\text{O}^+][\\text{OH}^-]\\)"},{"label":"B","text":"\\(K_w = [\\text{H}_3\\text{O}^+] + [\\text{OH}^-]\\)"},{"label":"C","text":"\\(K_w = \\dfrac{[\\text{H}_3\\text{O}^+]}{[\\text{OH}^-]}\\)"},{"label":"D","text":"\\(K_w = [\\text{H}_2\\text{O}][\\text{H}_3\\text{O}^+][\\text{OH}^-]\\)"}]$op2$::jsonb,
    'A',
    $ex2$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because the ion-product constant of water is the equilibrium constant for the autoionization \(2\,\text{H}_2\text{O}(l) \rightleftharpoons \text{H}_3\text{O}^+(aq) + \text{OH}^-(aq)\), and for any equilibrium the constant is the product of the product-species concentrations each raised to its stoichiometric coefficient. Because liquid water is the pure solvent, its activity is taken as 1 and does not appear, leaving \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-]\). (Choice B) An equilibrium constant multiplies the concentrations of the product species; it never adds them, so writing \(K_w\) as a sum misrepresents the mass-action expression and would not even carry units consistent with a product of two concentrations. (Choice C) A ratio of \([\text{H}_3\text{O}^+]\) to \([\text{OH}^-]\) is not the mass-action form for two species generated together on the product side; both ions are products and must be multiplied, not divided. (Choice D) The concentration of liquid water is omitted from the expression because pure water is the solvent with unit activity; including \([\text{H}_2\text{O}]\) as a factor improperly treats the solvent as a variable equilibrium species. Skill 1$ex2$,
    'easy', '5A', $cc2$Acid-Base Equilibria (GC, BC)$cc2$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a2B$sums the product concentrations instead of multiplying them$a2B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a2C$writes the ion product as a ratio of the two product ions$a2C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a2D$improperly includes the pure-solvent water concentration as an equilibrium factor$a2D$ FROM q;

-- Q3 [Autoionization, Kw & the pH/pOH Scales · easy · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g3)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt3$A sample of dilute hydrochloric acid at 25 C has a hydronium ion concentration of \([\text{H}_3\text{O}^+] = 1.0\times10^{-3}\ \text{M}\). What is the pH of this solution?$qt3$,
    $op3$[{"label":"A","text":"\\(\\text{pH} = 11.00\\)"},{"label":"B","text":"\\(\\text{pH} = -3.00\\)"},{"label":"C","text":"\\(\\text{pH} = 3.00\\)"},{"label":"D","text":"\\(\\text{pH} = 0.003\\)"}]$op3$::jsonb,
    'C',
    $ex3$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because pH is defined as \(\text{pH} = -\log[\text{H}_3\text{O}^+]\), and substituting the given concentration gives \(\text{pH} = -\log(1.0\times10^{-3}) = -(-3.00) = 3.00\). Because \([\text{H}_3\text{O}^+]\) is an exact power of ten, the logarithm is simply the exponent: \(\log(10^{-3}) = -3\), and the leading negative sign in the pH definition flips it to a positive 3.00. A pH of 3.00 is below 7, consistent with an acidic solution. (Choice A) \(\text{pH} = 11.00\) is the pOH of the solution, not the pH; it comes from computing \(\text{pOH} = -\log[\text{OH}^-]\) after finding \([\text{OH}^-] = K_w/[\text{H}_3\text{O}^+] = 1.0\times10^{-11}\ \text{M}\), or equivalently from \(14 - 3 = 11\), and then reporting that value as the pH. (Choice B) \(\text{pH} = -3.00\) drops the negative sign in the defining relation \(\text{pH} = -\log[\text{H}_3\text{O}^+]\), reporting \(\log(10^{-3}) = -3\) directly instead of its negative. (Choice D) \(\text{pH} = 0.003\) uses the concentration value \(1.0\times10^{-3} = 0.003\) itself rather than taking \(-\log\) of it. Skill 2$ex3$,
    'easy', '5A', $cc3$Acid-Base Equilibria (GC, BC)$cc3$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a3A$Computes or reports pOH (14 - 3 = 11) instead of pH$a3A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a3B$Omits the negative sign in pH = -log[H3O+], reporting log value directly$a3B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a3D$Reports the concentration in decimal form instead of taking its negative logarithm$a3D$ FROM q;

-- Q4 [Autoionization, Kw & the pH/pOH Scales · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g4)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt4$A sample of pure water sits at \(25^\circ\text{C}\), where its autoionization gives \(K_w = 1.0\times10^{-14}\) and \(\text{pH} = 7\). What is \([\text{H}_3\text{O}^+]\) in this water?$qt4$,
    $op4$[{"label":"A","text":"\\(1.0\\times10^{-14}\\ \\text{M}\\)"},{"label":"B","text":"\\(7.0\\ \\text{M}\\)"},{"label":"C","text":"\\(5.0\\times10^{-15}\\ \\text{M}\\)"},{"label":"D","text":"\\(1.0\\times10^{-7}\\ \\text{M}\\)"}]$op4$::jsonb,
    'D',
    $ex4$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because in pure water the only source of ions is autoionization, \(2\,\text{H}_2\text{O} \rightleftharpoons \text{H}_3\text{O}^+ + \text{OH}^-\), which produces \([\text{H}_3\text{O}^+]\) and \([\text{OH}^-]\) in a strict 1:1 ratio, so \([\text{H}_3\text{O}^+] = [\text{OH}^-]\). Substituting into \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-] = 1.0\times10^{-14}\) gives \([\text{H}_3\text{O}^+]^2 = 1.0\times10^{-14}\), so \([\text{H}_3\text{O}^+] = \sqrt{1.0\times10^{-14}} = 1.0\times10^{-7}\ \text{M}\). This is consistent with \(\text{pH} = -\log(1.0\times10^{-7}) = 7\), the defining value of a neutral solution at \(25^\circ\text{C}\). (Choice A) reports the value of \(K_w\) itself as the concentration, skipping the square-root step that converts the ion product into a single ion concentration. (Choice B) treats the numerical pH value of 7 as if it were a molarity, ignoring that pH is the negative logarithm of \([\text{H}_3\text{O}^+]\) and is dimensionless rather than a concentration in \(\text{M}\). (Choice C) divides \(K_w\) by 2 instead of taking its square root, incorrectly splitting the ion product between the two ions by halving rather than by \(\sqrt{K_w}\). Skill 1$ex4$,
    'easy', '5A', $cc4$Acid-Base Equilibria (GC, BC)$cc4$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a4A$Reports Kw directly as the ion concentration, omitting the square-root step that converts the ion product into a single ion concentration$a4A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a4B$Treats the dimensionless pH value (7) as a molarity, confusing the log scale with a concentration in M$a4B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a4C$Halves Kw to split it between the two ions instead of taking the square root of the ion product$a4C$ FROM q;

-- Q5 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g5)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt5$An aqueous sample at 25 °C, where \(K_w = 1.0\times10^{-14}\), is measured to have \([\text{H}_3\text{O}^+] = 2.0\times10^{-6}\ \text{M}\). What is the hydroxide ion concentration \([\text{OH}^-]\) in this sample?$qt5$,
    $op5$[{"label":"A","text":"\\(2.0\\times10^{-20}\\ \\text{M}\\)"},{"label":"B","text":"\\(5.0\\times10^{-9}\\ \\text{M}\\)"},{"label":"C","text":"\\(1.0\\times10^{-8}\\ \\text{M}\\)"},{"label":"D","text":"\\(2.0\\times10^{-6}\\ \\text{M}\\)"}]$op5$::jsonb,
    'B',
    $ex5$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because the autoionization of water fixes the product \([\text{H}_3\text{O}^+][\text{OH}^-] = K_w = 1.0\times10^{-14}\) at 25 °C, so \([\text{OH}^-]\) is found by dividing \(K_w\) by \([\text{H}_3\text{O}^+]\): \([\text{OH}^-] = K_w / [\text{H}_3\text{O}^+] = (1.0\times10^{-14}) / (2.0\times10^{-6})\). Dividing the coefficients gives \(1.0/2.0 = 0.50\), and subtracting the exponents gives \(10^{-14-(-6)} = 10^{-8}\), so \([\text{OH}^-] = 0.50\times10^{-8} = 5.0\times10^{-9}\ \text{M}\). Because this hydroxide concentration is smaller than \([\text{H}_3\text{O}^+]\), the sample is acidic, which is consistent with \([\text{H}_3\text{O}^+] = 2.0\times10^{-6}\ \text{M}\) exceeding \(1.0\times10^{-7}\ \text{M}\). (Choice A) \(2.0\times10^{-20}\ \text{M}\) results from multiplying \(K_w\) by \([\text{H}_3\text{O}^+]\) instead of dividing, which violates the relationship \([\text{H}_3\text{O}^+][\text{OH}^-] = K_w\) that requires the two concentrations to be inversely related. (Choice C) \(1.0\times10^{-8}\ \text{M}\) results from subtracting the exponents \((-14)-(-6) = -8\) but dropping the coefficient division, ignoring the factor of \(1.0/2.0 = 0.50\). (Choice D) \(2.0\times10^{-6}\ \text{M}\) results from setting \([\text{OH}^-]\) equal to \([\text{H}_3\text{O}^+]\) as if the solution were neutral, which would only hold when \([\text{H}_3\text{O}^+] = [\text{OH}^-] = 1.0\times10^{-7}\ \text{M}\), not at the given acidic concentration. Skill 2$ex5$,
    'medium', '5A', $cc5$Acid-Base Equilibria (GC, BC)$cc5$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a5A$Multiplied Kw by [H3O+] instead of dividing$a5A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a5C$Subtracted exponents but dropped the coefficient division (forgot the 2.0)$a5C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a5D$Set [OH-] equal to [H3O+] as if the solution were neutral$a5D$ FROM q;

-- Q6 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g6)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt6$A sample of a dilute aqueous solution at 25 °C has a hydroxide concentration of \([\text{OH}^-] = 1.0\times10^{-5}\ \text{M}\). What is the pOH of this solution?$qt6$,
    $op6$[{"label":"A","text":"\\(9.00\\)"},{"label":"B","text":"\\(-5.00\\)"},{"label":"C","text":"\\(5.00\\)"},{"label":"D","text":"\\(1.0\\times10^{-5}\\)"}]$op6$::jsonb,
    'C',
    $ex6$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because pOH is defined as the negative base-10 logarithm of the hydroxide-ion concentration, \(\text{pOH} = -\log[\text{OH}^-]\). Substituting the given value: \(\text{pOH} = -\log(1.0\times10^{-5})\). Because \(\log(1.0\times10^{-5}) = -5.00\), the negative of that value is \(\text{pOH} = -(-5.00) = 5.00\). (As a check, \(\text{pH} = 14.00 - \text{pOH} = 9.00\), confirming a basic solution, since \(\text{pOH} < 7\) means \([\text{OH}^-] > [\text{H}^+]\).) (Choice A) The value \(9.00\) is the pH of this solution, obtained from \(\text{pH} + \text{pOH} = 14.00\); it answers a different quantity than the one requested, since the question asks for pOH, not pH. (Choice B) The value \(-5.00\) results from omitting the negative sign in the defining relationship \(\text{pOH} = -\log[\text{OH}^-]\); pOH for a dilute aqueous solution at 25 °C cannot be negative because \([\text{OH}^-]\) is far below 1 M. (Choice D) The value \(1.0\times10^{-5}\) is simply the hydroxide concentration restated; pOH is a logarithmic quantity, so the \(-\log\) operation must still be applied to \([\text{OH}^-]\). Skill 2$ex6$,
    'medium', '5A', $cc6$Acid-Base Equilibria (GC, BC)$cc6$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a6A$Computed pH via pH + pOH = 14 and reported it instead of the requested pOH$a6A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a6B$Omitted the negative sign in pOH = -log[OH-], reporting the raw logarithm$a6B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a6D$Restated the hydroxide concentration without applying the -log operation$a6D$ FROM q;

-- Q7 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g7)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt7$An aqueous solution at 25C has a pH of 9.50, where \(K_w = 1.0\times10^{-14}\). What is the pOH of this solution?$qt7$,
    $op7$[{"label":"A","text":"\\(9.50\\)"},{"label":"B","text":"\\(5.50\\)"},{"label":"C","text":"\\(3.16\\times10^{-10}\\)"},{"label":"D","text":"\\(4.50\\)"}]$op7$::jsonb,
    'D',
    $ex7$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because at 25C the relationship \(\text{pH} + \text{pOH} = 14.00\) holds, so \(\text{pOH} = 14.00 - \text{pH} = 14.00 - 9.50 = 4.50\). This follows directly from the autoionization of water: taking the negative logarithm of \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-] = 1.0\times10^{-14}\) gives \(\text{p}K_w = \text{pH} + \text{pOH} = 14.00\). (Choice A) \(9.50\) simply restates the given pH as the pOH, which would only be true at the neutral point where pH equals pOH; here the solution is basic, so the two values are not equal. (Choice B) \(5.50\) comes from subtracting the pH from 15.00 rather than 14.00, an error in the value of \(\text{p}K_w\) at 25C. (Choice C) \(3.16\times10^{-10}\) is \([\text{H}_3\text{O}^+] = 10^{-9.50}\), the hydronium ion concentration, which results from converting the pH back to a concentration instead of computing the pOH. Skill 2$ex7$,
    'medium', '5A', $cc7$Acid-Base Equilibria (GC, BC)$cc7$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a7A$assumes pOH equals pH (treats every solution as if at the neutral point where pH = pOH)$a7A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a7B$uses an incorrect value of pKw (subtracts from 15.00 instead of 14.00)$a7B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a7C$computes [H3O+] = 10^-pH instead of the requested pOH$a7C$ FROM q;

-- Q8 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g8)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt8$A sample of aqueous \(\text{HCl}\) at 25 °C has a hydronium-ion concentration of \([\text{H}_3\text{O}^+] = 2.5\times10^{-4}\ \text{M}\). The pH of this solution is closest to$qt8$,
    $op8$[{"label":"A","text":"\\(3.60\\)"},{"label":"B","text":"\\(-3.60\\)"},{"label":"C","text":"\\(10.40\\)"},{"label":"D","text":"\\(4.00\\)"}]$op8$::jsonb,
    'A',
    $ex8$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because \(\text{pH} = -\log[\text{H}_3\text{O}^+] = -\log(2.5\times10^{-4})\). Splitting the logarithm gives \(-(\log 2.5 + \log 10^{-4}) = -(0.40 + (-4)) = -(-3.60) = 3.60\). Because the coefficient \(2.5\) is greater than \(1\), its logarithm (\(0.40\)) lowers the pH below \(4\), so the value lands between \(3\) and \(4\) and nearer to \(4\); the result \(3.60\) is correct. (Choice B) The value \(-3.60\) drops the negative sign in the definition and computes \(+\log(2.5\times10^{-4})\) instead of \(-\log(2.5\times10^{-4})\); pH for an acidic solution is a small positive number, not negative. (Choice C) The value \(10.40\) is the pOH, obtained from \(\text{pOH} = 14 - \text{pH} = 14 - 3.60\); the quantity requested is pH, and at \([\text{H}_3\text{O}^+] = 2.5\times10^{-4}\ \text{M}\) the solution is acidic, so its pH must be below \(7\). (Choice D) The value \(4.00\) ignores the leading coefficient and evaluates \(-\log(10^{-4})\) as though the concentration were \(1.0\times10^{-4}\ \text{M}\); retaining the \(2.5\) factor lowers the pH by \(\log 2.5 = 0.40\) to \(3.60\). Skill 2$ex8$,
    'medium', '5A', $cc8$Acid-Base Equilibria (GC, BC)$cc8$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a8B$dropped the negative sign in pH = -log[H3O+], reporting +log(2.5e-4)$a8B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a8C$reported pOH = 14 - pH instead of the requested pH$a8C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a8D$ignored the leading coefficient 2.5 and took -log(1.0e-4) = 4.00$a8D$ FROM q;

-- Q9 [Autoionization, Kw & the pH/pOH Scales · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g9)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt9$A sample of lemon juice at \(25^\circ\text{C}\) has a measured \(\text{pH}\) of \(4.0\). At this temperature \(K_w = 1.0\times10^{-14}\) and the neutral point is \(\text{pH} = 7.0\). The solution is$qt9$,
    $op9$[{"label":"A","text":"neutral, because its \\(\\text{pH}\\) is a whole number rather than a value above or below \\(7.0\\)."},{"label":"B","text":"acidic, because its \\(\\text{pH}\\) of \\(4.0\\) lies below the neutral value of \\(7.0\\)."},{"label":"C","text":"basic, because its \\(\\text{pH}\\) of \\(4.0\\) corresponds to a \\(\\text{pOH}\\) of \\(10.0\\), which exceeds \\(7.0\\)."},{"label":"D","text":"basic, because a \\(\\text{pH}\\) below \\(7.0\\) signals an excess of \\([\\text{OH}^-]\\) over \\([\\text{H}^+]\\)."}]$op9$::jsonb,
    'B',
    $ex9$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because at \(25^\circ\text{C}\) the neutral point is \(\text{pH} = 7.0\), and any solution with \(\text{pH} < 7.0\) is acidic; a \(\text{pH}\) of \(4.0\) lies below \(7.0\), so the solution is acidic. Quantitatively, \(\text{pH} = -\log[\text{H}^+]\), so \(\text{pH} = 4.0\) gives \([\text{H}^+] = 1.0\times10^{-4}\ \text{M}\), while the neutral concentration at \(25^\circ\text{C}\) is \([\text{H}^+] = \sqrt{K_w} = 1.0\times10^{-7}\ \text{M}\). Because \(1.0\times10^{-4}\ \text{M} > 1.0\times10^{-7}\ \text{M}\), the solution holds an excess of \([\text{H}^+]\) over \([\text{OH}^-]\) and is acidic. (Choice A) Neutrality at \(25^\circ\text{C}\) is defined by \(\text{pH} = 7.0\), not by whether the \(\text{pH}\) is a whole number; \(4.0\) is a whole number yet still lies below \(7.0\), so the solution is acidic rather than neutral. (Choice C) The \(\text{pOH}\) here is indeed \(14.0 - 4.0 = 10.0\), but a solution is classified relative to its \(\text{pH}\): \(\text{pH} = 4.0 < 7.0\) is acidic. A \(\text{pOH}\) of \(10.0\) (greater than \(7.0\)) likewise indicates an acidic solution, since high \(\text{pOH}\) means low \([\text{OH}^-]\), so this choice reaches the wrong label. (Choice D) A \(\text{pH}\) below \(7.0\) corresponds to \([\text{H}^+] > [\text{OH}^-]\), an excess of \([\text{H}^+]\), which is acidic; this choice inverts the relationship by claiming excess \([\text{OH}^-]\) and labeling the solution basic. Skill 1$ex9$,
    'easy', '5A', $cc9$Acid-Base Equilibria (GC, BC)$cc9$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a9A$treats a whole-number pH as the criterion for neutrality instead of comparing pH to 7.0$a9A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a9C$correctly computes pOH = 10.0 but classifies on pOH > 7.0 and mislabels the solution basic$a9C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a9D$inverts the pH-to-ion relationship, equating low pH with excess hydroxide$a9D$ FROM q;

-- Q10 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 4 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g10)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt10$A sample of an aqueous solution at \(25^\circ\text{C}\) is measured to have \([\text{H}_3\text{O}^+] = 3.0\times10^{-9}\ \text{M}\). On this basis, classify the solution.$qt10$,
    $op10$[{"label":"A","text":"Acidic, because \\([\\text{H}_3\\text{O}^+]\\) is a small number"},{"label":"B","text":"Neutral, because \\([\\text{H}_3\\text{O}^+]\\) is close to \\(1.0\\times10^{-7}\\ \\text{M}\\)"},{"label":"C","text":"Basic, because \\([\\text{H}_3\\text{O}^+] < [\\text{OH}^-]\\)"},{"label":"D","text":"Acidic, because its pH of \\(8.5\\) is below \\(14\\)"}]$op10$::jsonb,
    'C',
    $ex10$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because at \(25^\circ\text{C}\) a solution is basic whenever \([\text{H}_3\text{O}^+] < [\text{OH}^-]\), and that comparison can be made directly from the autoionization constant. At \(25^\circ\text{C}\), \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-] = 1.0\times10^{-14}\). Solving for hydroxide with the given \([\text{H}_3\text{O}^+] = 3.0\times10^{-9}\ \text{M}\) gives \([\text{OH}^-] = \frac{1.0\times10^{-14}}{3.0\times10^{-9}} = 3.3\times10^{-6}\ \text{M}\). Because \(3.0\times10^{-9} < 3.3\times10^{-6}\), hydroxide exceeds hydronium, so the solution is basic. The same conclusion follows from the benchmark \(1.0\times10^{-7}\ \text{M}\): the measured \([\text{H}_3\text{O}^+]\) of \(3.0\times10^{-9}\ \text{M}\) is well below \(1.0\times10^{-7}\ \text{M}\), and a hydronium concentration below \(1.0\times10^{-7}\ \text{M}\) is the defining condition for a basic solution at \(25^\circ\text{C}\). (Choice A) A small numerical value for \([\text{H}_3\text{O}^+]\) signals fewer hydronium ions, not more; a lower hydronium concentration corresponds to a less acidic (more basic) solution, so reading "small number" as "acidic" reverses the relationship between \([\text{H}_3\text{O}^+]\) magnitude and acidity. (Choice B) Neutrality at \(25^\circ\text{C}\) requires \([\text{H}_3\text{O}^+] = [\text{OH}^-] = 1.0\times10^{-7}\ \text{M}\) exactly, and \(3.0\times10^{-9}\ \text{M}\) differs from \(1.0\times10^{-7}\ \text{M}\) by more than a factor of \(30\) (nearly two orders of magnitude on a logarithmic scale), so the solution is not neutral. (Choice D) Taking \(\text{pH} = -\log(3.0\times10^{-9}) = 8.5\) is the correct pH, but a pH of \(8.5\) lies above \(7\), which is basic; comparing the pH to \(14\) instead of to the neutral value of \(7\) misapplies the scale and inverts the acidic/basic boundary. Skill 4$ex10$,
    'medium', '5A', $cc10$Acid-Base Equilibria (GC, BC)$cc10$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a10A$Equates a small numerical [H3O+] value with high acidity, reversing the inverse relationship between hydronium concentration magnitude and acidity$a10A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a10B$Treats a hydronium concentration near 1e-7 as effectively neutral, ignoring that neutrality at 25C requires [H3O+] to equal 1.0e-7 M exactly$a10B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a10D$Correctly computes pH = 8.5 but compares it to 14 instead of to the neutral benchmark of 7, mislocating the acidic/basic boundary$a10D$ FROM q;

-- Q11 [Autoionization, Kw & the pH/pOH Scales · hard · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g11)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt11$A sample of aqueous \(\text{Ba(OH)}_2\) solution at \(25\,^\circ\text{C}\) has \([\text{OH}^-] = 4.0\times10^{-3}\ \text{M}\), where \(K_w = 1.0\times10^{-14}\). The \([\text{H}_3\text{O}^+]\) and the acid-base character of this solution are most nearly$qt11$,
    $op11$[{"label":"A","text":"\\(1.0\\times10^{-11}\\ \\text{M}\\); basic"},{"label":"B","text":"\\(4.0\\times10^{-17}\\ \\text{M}\\); basic"},{"label":"C","text":"\\(2.5\\times10^{-12}\\ \\text{M}\\); acidic"},{"label":"D","text":"\\(2.5\\times10^{-12}\\ \\text{M}\\); basic"}]$op11$::jsonb,
    'D',
    $ex11$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because rearranging the water autoionization expression \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-]\) gives \([\text{H}_3\text{O}^+] = K_w / [\text{OH}^-]\), and dividing both the coefficients and the powers of ten yields \([\text{H}_3\text{O}^+] = (1.0\times10^{-14})/(4.0\times10^{-3}) = 0.25\times10^{-11} = 2.5\times10^{-12}\ \text{M}\). Because \([\text{H}_3\text{O}^+] = 2.5\times10^{-12}\ \text{M}\) is less than the neutral value of \(1.0\times10^{-7}\ \text{M}\) at \(25\,^\circ\text{C}\) (equivalently, \([\text{OH}^-] > [\text{H}_3\text{O}^+]\)), the solution is basic. (Choice A) \(1.0\times10^{-11}\ \text{M}\) results from dividing only the powers of ten, \(10^{-14}/10^{-3} = 10^{-11}\), while dropping the coefficient and failing to divide \(1.0\) by \(4.0\); the basic classification is correct, but the magnitude omits the required \(0.25\) factor. (Choice B) \(4.0\times10^{-17}\ \text{M}\) results from multiplying \(K_w\) by \([\text{OH}^-]\) instead of dividing, \((1.0\times10^{-14})(4.0\times10^{-3})\), which inverts the rearrangement of \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-]\) and does not isolate \([\text{H}_3\text{O}^+]\). (Choice C) The concentration \(2.5\times10^{-12}\ \text{M}\) is computed correctly, but the solution is labeled acidic; a solution is acidic only when \([\text{H}_3\text{O}^+] > 1.0\times10^{-7}\ \text{M}\), whereas here \([\text{H}_3\text{O}^+] < [\text{OH}^-]\), so the relationship between hydronium and hydroxide is reversed. Skill 2$ex11$,
    'hard', '5A', $cc11$Acid-Base Equilibria (GC, BC)$cc11$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a11A$divided powers of ten but dropped the 1.0/4.0 coefficient division$a11A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a11B$multiplied Kw by [OH-] instead of dividing to isolate [H3O+]$a11B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a11C$correct [H3O+] but classifies as acidic, reversing the hydronium-hydroxide comparison$a11C$ FROM q;

-- Q12 [Autoionization, Kw & the pH/pOH Scales · hard · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g12)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt12$A solution at \(25^\circ\text{C}\) has \([\text{OH}^-] = 1.0\times10^{-4}\ \text{M}\), where \(K_w = 1.0\times10^{-14}\). What is the pH of this solution?$qt12$,
    $op12$[{"label":"A","text":"\\(\\text{pH} = 10.00\\)"},{"label":"B","text":"\\(\\text{pH} = 4.00\\)"},{"label":"C","text":"\\(\\text{pH} = -4.00\\)"},{"label":"D","text":"\\(\\text{pH} = 7.00\\)"}]$op12$::jsonb,
    'A',
    $ex12$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because chaining the \(K_w\) and pH/pOH relationships gives \(\text{pH} = 10.00\). First take \(\text{pOH} = -\log[\text{OH}^-] = -\log(1.0\times10^{-4}) = 4.00\). Then, because \(\text{pH} + \text{pOH} = 14.00\) at \(25^\circ\text{C}\), \(\text{pH} = 14.00 - 4.00 = 10.00\). The same result follows by first converting through \(K_w\): \([\text{H}_3\text{O}^+] = K_w/[\text{OH}^-] = (1.0\times10^{-14})/(1.0\times10^{-4}) = 1.0\times10^{-10}\ \text{M}\), so \(\text{pH} = -\log(1.0\times10^{-10}) = 10.00\). A pH of 10.00 is consistent with a basic solution, as expected when \([\text{OH}^-] > 1.0\times10^{-7}\ \text{M}\). (Choice B) A value of 4.00 is the pOH, obtained from \(-\log[\text{OH}^-]\); it is reported as the pH without applying \(\text{pH} = 14.00 - \text{pOH}\), so the final conversion step is omitted. (Choice C) A value of \(-4.00\) results from a sign error in which \(\text{pH}\) is computed as \(+\log[\text{OH}^-] = \log(1.0\times10^{-4}) = -4.00\), dropping the negative sign in the logarithm definition and ignoring the \(K_w\) relationship entirely. (Choice D) A value of 7.00 corresponds to a neutral solution at \(25^\circ\text{C}\), but a solution with \([\text{OH}^-] = 1.0\times10^{-4}\ \text{M}\) has a hydroxide concentration above \(1.0\times10^{-7}\ \text{M}\) and is therefore basic, not neutral. Skill 2$ex12$,
    'hard', '5A', $cc12$Acid-Base Equilibria (GC, BC)$cc12$, 'general-chemistry', 2, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a12B$Computes pOH = 4.00 correctly but reports it as the pH, skipping the pH = 14.00 - pOH conversion$a12B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a12C$Sign error in the log definition: takes +log[OH-] = -4.00 instead of -log, and never applies the Kw relationship$a12C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a12D$Defaults to the neutral value pH = 7.00, ignoring that [OH-] above 1.0e-7 M makes the solution basic$a12D$ FROM q;

-- Q13 [Autoionization, Kw & the pH/pOH Scales · medium · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g13)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt13$A sample of pure water is heated from \(25\,^\circ\text{C}\) to \(60\,^\circ\text{C}\), and the autoionization of water is endothermic. As the temperature rises, what happens to \(K_w\) and to the relationship between \([\text{H}_3\text{O}^+]\) and \([\text{OH}^-]\)?$qt13$,
    $op13$[{"label":"A","text":"\\(K_w\\) stays fixed at \\(1.0\\times10^{-14}\\) because \\(K_w\\) is a true constant that does not depend on temperature."},{"label":"B","text":"\\(K_w\\) rises above \\(1.0\\times10^{-14}\\), and \\([\\text{H}_3\\text{O}^+]\\) and \\([\\text{OH}^-]\\) both increase but remain equal, so the water stays neutral."},{"label":"C","text":"\\(K_w\\) rises above \\(1.0\\times10^{-14}\\), and because \\([\\text{H}_3\\text{O}^+]\\) now exceeds \\([\\text{OH}^-]\\) the water becomes acidic."},{"label":"D","text":"\\(K_w\\) falls below \\(1.0\\times10^{-14}\\) because heating an endothermic reaction shifts it back toward reactants."}]$op13$::jsonb,
    'B',
    $ex13$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because the autoionization \(2\,\text{H}_2\text{O}(l) \rightleftharpoons \text{H}_3\text{O}^+(aq) + \text{OH}^-(aq)\) is endothermic, so by Le Chatelier's principle adding heat (raising the temperature from \(25\,^\circ\text{C}\) to \(60\,^\circ\text{C}\)) shifts the equilibrium to the right; this consumes water and produces more ions, raising \(K_w = [\text{H}_3\text{O}^+][\text{OH}^-]\) above its \(25\,^\circ\text{C}\) value of \(1.0\times10^{-14}\). Because each autoionization event produces exactly one \(\text{H}_3\text{O}^+\) and one \(\text{OH}^-\), the two concentrations rise together and stay equal, so the water remains neutral even though both ion concentrations are now larger and the neutral pH has dropped below 7. (Choice A) \(K_w\) is an equilibrium constant, and like any equilibrium constant its value depends on temperature; the familiar \(1.0\times10^{-14}\) holds only at \(25\,^\circ\text{C}\), so treating it as a fixed temperature-independent number is incorrect. (Choice C) Although \(K_w\) does increase, neutrality is defined by \([\text{H}_3\text{O}^+] = [\text{OH}^-]\), and autoionization generates the two ions in a 1:1 ratio; both rise by the same amount, so the water stays neutral rather than becoming acidic. (Choice D) The shift direction is reversed: for an endothermic reaction heat behaves as a reactant, so adding heat drives the equilibrium toward products and raises \(K_w\), it does not push the reaction back toward reactants or lower \(K_w\). Skill 1$ex13$,
    'medium', '5A', $cc13$Acid-Base Equilibria (GC, BC)$cc13$, 'general-chemistry', 1, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a13A$Kw treated as temperature-independent constant$a13A$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a13C$correct Kw direction but wrongly breaks the [H3O+]=[OH-] equality, calling heated water acidic$a13C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a13D$endothermic Le Chatelier shift direction inverted, lowering Kw$a13D$ FROM q;

-- Q14 [Autoionization, Kw & the pH/pOH Scales · hard · Skill 4 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g14)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Autoionization, Kw & the pH/pOH Scales',
    $qt14$At \(50\,^\circ\text{C}\) the autoionization constant of water is \(K_w = 5.5\times10^{-14}\), so pure (neutral) water at this temperature has \(\text{pH} \approx 6.63\), corresponding to \([\text{H}_3\text{O}^+] = [\text{OH}^-] = \sqrt{K_w} \approx 2.3\times10^{-7}\,\text{M}\). A particular aqueous sample held at \(50\,^\circ\text{C}\) is measured to have \(\text{pH} = 6.80\). On this basis, how must the sample be classified?$qt14$,
    $op14$[{"label":"A","text":"Neutral, because a measured \\(\\text{pH}\\) of \\(6.80\\) rounds to approximately \\(7\\), the value characteristic of pure water"},{"label":"B","text":"Acidic, because a measured \\(\\text{pH}\\) of \\(6.80\\) lies below \\(7.00\\), the dividing line between acidic and basic solutions"},{"label":"C","text":"Acidic, because \\([\\text{H}_3\\text{O}^+] = 1.6\\times10^{-7}\\,\\text{M}\\) exceeds \\(1.0\\times10^{-7}\\,\\text{M}\\), the concentration that marks a neutral solution"},{"label":"D","text":"Basic, because \\([\\text{H}_3\\text{O}^+] = 1.6\\times10^{-7}\\,\\text{M}\\) lies below the neutral value of \\(2.3\\times10^{-7}\\,\\text{M}\\), so \\([\\text{OH}^-] > [\\text{H}_3\\text{O}^+]\\)"}]$op14$::jsonb,
    'D',
    $ex14$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because the neutral point is fixed not by a memorized pH of 7 but by the condition \([\text{H}_3\text{O}^+] = [\text{OH}^-]\), which equals \(\sqrt{K_w}\) at whatever temperature applies. At \(50\,^\circ\text{C}\), \(\sqrt{5.5\times10^{-14}} \approx 2.3\times10^{-7}\,\text{M}\), so neutral water has \(\text{pH} \approx 6.63\). The measured sample has \(\text{pH} = 6.80\), giving \([\text{H}_3\text{O}^+] = 10^{-6.80} = 1.6\times10^{-7}\,\text{M}\). Because this hydronium concentration is smaller than the neutral \(2.3\times10^{-7}\,\text{M}\), the constraint \([\text{H}_3\text{O}^+][\text{OH}^-] = K_w\) forces \([\text{OH}^-] > [\text{H}_3\text{O}^+]\); equivalently, the sample's pH of \(6.80\) lies above the neutral pH of \(6.63\). The solution therefore has excess hydroxide and is basic. (Choice A) is wrong because rounding pH to "about 7" ignores the quantitative criterion for neutrality; neutrality requires \([\text{H}_3\text{O}^+] = [\text{OH}^-]\) (pH \(6.63\) here), and the sample's pH of \(6.80\) is distinctly different from that value, so it is not neutral. (Choice B) is wrong because it applies the pH 7 neutral threshold, which holds only at \(25\,^\circ\text{C}\); at \(50\,^\circ\text{C}\) the neutral pH has shifted down to \(6.63\), so a pH of \(6.80\) sits above neutral rather than below it, and comparing to \(7.00\) misidentifies the reference point. (Choice C) is wrong because it uses the \(25\,^\circ\text{C}\) neutral concentration of \(1.0\times10^{-7}\,\text{M}\) as the dividing line; at \(50\,^\circ\text{C}\) the neutral concentration is \(2.3\times10^{-7}\,\text{M}\), and the sample's \(1.6\times10^{-7}\,\text{M}\) is below that value, so the comparison against \(1.0\times10^{-7}\,\text{M}\) reverses the correct conclusion. Skill 4$ex14$,
    'hard', '5A', $cc14$Acid-Base Equilibria (GC, BC)$cc14$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a14A$rounding pH 6.80 to about 7 and calling it neutral$a14A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a14B$pH 7 is always the neutral cutoff regardless of temperature$a14B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a14C$using the 25 C reference concentration of 1.0e-7 M as the neutral marker at 50 C$a14C$ FROM q;

-- Q15 [Strong vs Weak Acids/Bases; Ka and Kb · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g15)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt15$Four acids are each dissolved in water at \(25^\circ\text{C}\): \(\text{HClO}_4\), \(\text{HF}\), \(\text{CH}_3\text{COOH}\), and \(\text{H}_2\text{CO}_3\). Only one of them ionizes essentially completely, leaving a negligible concentration of intact acid molecules at equilibrium. Which acid is it?$qt15$,
    $op15$[{"label":"A","text":"\\(\\text{HClO}_4\\)"},{"label":"B","text":"\\(\\text{HF}\\)"},{"label":"C","text":"\\(\\text{CH}_3\\text{COOH}\\)"},{"label":"D","text":"\\(\\text{H}_2\\text{CO}_3\\)"}]$op15$::jsonb,
    'A',
    $ex15$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because perchloric acid, \(\text{HClO}_4\), is one of the six common strong acids (\(\text{HCl}\), \(\text{HBr}\), \(\text{HI}\), \(\text{HNO}_3\), \(\text{H}_2\text{SO}_4\), \(\text{HClO}_4\)) that dissociate essentially completely in water. For a strong acid the ionization \(\text{HClO}_4 + \text{H}_2\text{O} \rightarrow \text{H}_3\text{O}^+ + \text{ClO}_4^-\) goes effectively to completion, so at equilibrium the concentration of undissociated \(\text{HClO}_4\) is negligible and \([\text{H}_3\text{O}^+]\) equals the formal concentration of the acid. The other three are weak acids with finite \(K_a\) values well below 1, meaning the great majority of their molecules remain intact in solution and an ICE-approximation equilibrium must be solved to find \([\text{H}_3\text{O}^+]\). (Choice B) \(\text{HF}\) is a weak acid (\(K_a \approx 6.8\times10^{-4}\)); despite fluorine's high electronegativity, the strong \(\text{H}-\text{F}\) bond keeps it from ionizing completely, so a large reservoir of intact \(\text{HF}\) persists at equilibrium. (Choice C) \(\text{CH}_3\text{COOH}\) (acetic acid) is the textbook example of a weak acid (\(K_a \approx 1.8\times10^{-5}\)); only about 1 percent of its molecules ionize at typical concentrations, so it does not ionize completely. (Choice D) \(\text{H}_2\text{CO}_3\) is a weak diprotic acid whose first ionization has \(K_a \approx 4.3\times10^{-7}\), far below that of a strong acid, so the overwhelming majority of carbonic acid molecules remain undissociated. Skill 1$ex15$,
    'easy', '5A', $cc15$Acid-Base Equilibria (GC, BC)$cc15$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a15B$Assumes the most electronegative halogen acid (HF) must be the strong acid, confusing high electronegativity of F with complete ionization while ignoring the strong H-F bond$a15B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a15C$Selects the canonical weak-acid example (acetic acid) by reflex association with acid equilibrium problems, mistaking familiarity for strong-acid status$a15C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a15D$Picks a diprotic acid assuming two ionizable protons imply complete/strong ionization, overlooking its very small Ka$a15D$ FROM q;

-- Q16 [Strong vs Weak Acids/Bases; Ka and Kb · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g16)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt16$A chemist needs the one species in the set \(\{\text{NH}_3,\ \text{CsOH},\ \text{Mg(OH)}_2,\ \text{CH}_3\text{NH}_2\}\) that is a group-IA (alkali metal) hydroxide and therefore dissociates essentially completely in water to release \(\text{OH}^-\). Which species is the strong base?$qt16$,
    $op16$[{"label":"A","text":"\\(\\text{NH}_3\\), because dissolving it in water generates \\(\\text{OH}^-\\)"},{"label":"B","text":"\\(\\text{CsOH}\\), because it is a group-IA hydroxide that dissociates completely into \\(\\text{Cs}^+\\) and \\(\\text{OH}^-\\)"},{"label":"C","text":"\\(\\text{Mg(OH)}_2\\), because it already contains two \\(\\text{OH}^-\\) units per formula"},{"label":"D","text":"\\(\\text{CH}_3\\text{NH}_2\\), because its amine nitrogen makes it the strongest base in the set"}]$op16$::jsonb,
    'B',
    $ex16$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because \(\text{CsOH}\) is a group-IA (alkali metal) hydroxide, and group-IA hydroxides are soluble ionic bases that dissociate essentially completely in water into the metal cation and \(\text{OH}^-\) — the defining behavior of a strong base, so \(\text{CsOH} \rightarrow \text{Cs}^+ + \text{OH}^-\). (Choice A) \(\text{NH}_3\) is a weak base: it does generate some \(\text{OH}^-\), but only by partially reacting with water (\(\text{NH}_3 + \text{H}_2\text{O} \rightleftharpoons \text{NH}_4^+ + \text{OH}^-\), small \(K_b\)), not by complete dissociation, so it is not strong. (Choice C) \(\text{Mg(OH)}_2\) is a group-IIA (alkaline-earth) hydroxide that is only sparingly soluble in water; the small amount that dissolves does dissociate, but its low solubility means it does not behave as a fully dissociated strong base in the way a group-IA hydroxide does. (Choice D) \(\text{CH}_3\text{NH}_2\) (methylamine) is a weak organic base with a finite \(K_b\); recognizing it as a base is correct, but it ionizes only partially and is not the strong base the question requires. Skill 1$ex16$,
    'easy', '5A', $cc16$Acid-Base Equilibria (GC, BC)$cc16$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a16A$treats ammonia as a strong base because it raises hydroxide concentration, ignoring that it only partially ionizes (small Kb)$a16A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a16C$picks a genuine metal hydroxide but confuses group-IIA (sparingly soluble) with the required group-IA soluble hydroxide$a16C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a16D$correctly recognizes an amine as a base but wrongly elevates it to strongest, when it is a weak base with a finite Kb$a16D$ FROM q;

-- Q17 [Strong vs Weak Acids/Bases; Ka and Kb · easy · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g17)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt17$Hydrochloric acid is one of the six strong acids and dissociates completely in water. A chemist prepares a \(1.0\times10^{-2}\ \text{M}\) \(\text{HCl}\) solution at 25\(^\circ\)C, where \(K_w = 1.0\times10^{-14}\). What is the pH of this solution?$qt17$,
    $op17$[{"label":"A","text":"1.00"},{"label":"B","text":"12.00"},{"label":"C","text":"2.00"},{"label":"D","text":"-2.00"}]$op17$::jsonb,
    'C',
    $ex17$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because \(\text{HCl}\) is a strong acid that dissociates completely, so \([\text{H}^+]\) equals the initial acid concentration: \([\text{H}^+] = 1.0\times10^{-2}\ \text{M} = 0.010\ \text{M}\). Applying \(\text{pH} = -\log[\text{H}^+] = -\log(1.0\times10^{-2}) = -(-2.00) = 2.00\). (Choice A) 1.00 results from misreading the concentration as \(0.10\ \text{M}\) (\(1.0\times10^{-1}\ \text{M}\)) rather than \(1.0\times10^{-2}\ \text{M}\), giving \(-\log(0.10) = 1.00\); this is a scale/unit error in the power of ten. (Choice B) 12.00 is the pOH of the solution, obtained by computing \([\text{OH}^-] = K_w/[\text{H}^+] = 1.0\times10^{-14}/1.0\times10^{-2} = 1.0\times10^{-12}\ \text{M}\) and reporting \(-\log[\text{OH}^-]\); it ignores that \(\text{pH} + \text{pOH} = 14\) and that pH is requested. (Choice D) -2.00 comes from a sign error, taking \(\text{pH} = +\log[\text{H}^+]\) instead of \(-\log[\text{H}^+]\), so the negative sign on the logarithm is dropped. Skill 2$ex17$,
    'easy', '5A', $cc17$Acid-Base Equilibria (GC, BC)$cc17$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a17A$Misread the molarity as 1.0x10^-1 M instead of 1.0x10^-2 M, giving pH = 1.00$a17A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a17B$Computed pOH from [OH-] = Kw/[H+] and reported it as the pH, forgetting pH + pOH = 14$a17B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a17D$Dropped the negative sign in pH = -log[H+], using +log instead$a17D$ FROM q;

-- Q18 [Strong vs Weak Acids/Bases; Ka and Kb · easy · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g18)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt18$A solution is prepared at 25 °C by dissolving NaOH to a concentration of \(1.0\times10^{-3}\ \text{M}\), where \(K_w = 1.0\times10^{-14}\). What is the pH of this solution?$qt18$,
    $op18$[{"label":"A","text":"\\(\\text{pH} = 3.00\\)"},{"label":"B","text":"\\(\\text{pH} = 7.00\\)"},{"label":"C","text":"\\(\\text{pH} = 12.00\\)"},{"label":"D","text":"\\(\\text{pH} = 11.00\\)"}]$op18$::jsonb,
    'D',
    $ex18$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because NaOH is a group-IA hydroxide strong base that dissociates completely, so the hydroxide concentration equals the formal concentration: \([\text{OH}^-] = 1.0\times10^{-3}\ \text{M}\). Then \(\text{pOH} = -\log(1.0\times10^{-3}) = 3.00\), and because \(\text{pH} + \text{pOH} = 14.00\) at 25 °C, \(\text{pH} = 14.00 - 3.00 = 11.00\). A pH above 7 is consistent with a basic solution. (Choice A) \(\text{pH} = 3.00\) is the correctly computed pOH reported as if it were the pH; it skips the \(\text{pH} = 14.00 - \text{pOH}\) conversion and would describe an acidic solution, the opposite of what a strong base produces. (Choice B) \(\text{pH} = 7.00\) treats the dilute solution as effectively neutral, but full dissociation of NaOH raises \([\text{OH}^-]\) far above the \(1.0\times10^{-7}\ \text{M}\) of pure water, so the solution is distinctly basic. (Choice C) \(\text{pH} = 12.00\) results from using \([\text{OH}^-] = 1.0\times10^{-2}\ \text{M}\) (an exponent off by one), giving \(\text{pOH} = 2.00\) and \(\text{pH} = 12.00\); the stated concentration is \(1.0\times10^{-3}\ \text{M}\), not \(1.0\times10^{-2}\ \text{M}\). Skill 2$ex18$,
    'easy', '5A', $cc18$Acid-Base Equilibria (GC, BC)$cc18$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a18A$reports pOH as pH, omitting the pH = 14 - pOH conversion$a18A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a18B$assumes a dilute solution is neutral at pH 7 despite full base dissociation$a18B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a18C$uses concentration exponent off by one (1e-2 instead of 1e-3)$a18C$ FROM q;

-- Q19 [Strong vs Weak Acids/Bases; Ka and Kb · easy · Skill 1 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g19)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt19$Acetic acid has \(K_a = 1.8\times10^{-5}\) and hypochlorous acid (\(\text{HOCl}\)) has \(K_a = 3.0\times10^{-8}\), both at 25 °C. Which species is the weaker acid, and why?$qt19$,
    $op19$[{"label":"A","text":"Acetic acid, because its larger \\(K_a\\) corresponds to a smaller degree of ionization at equilibrium."},{"label":"B","text":"Hypochlorous acid, because its smaller \\(K_a\\) reflects less ionization at equilibrium."},{"label":"C","text":"The two are equally weak, because both have \\(K_a\\) values far below 1."},{"label":"D","text":"Acetic acid, because a larger \\(K_a\\) means a larger fraction of its molecules remain un-ionized."}]$op19$::jsonb,
    'B',
    $ex19$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because the acid-ionization constant \(K_a\) measures the position of the ionization equilibrium \(\text{HA} + \text{H}_2\text{O} \rightleftharpoons \text{H}_3\text{O}^+ + \text{A}^-\): a larger \(K_a\) means the equilibrium lies farther toward the ionized products (more ionization, stronger acid), while a smaller \(K_a\) means it lies toward the un-ionized acid (less ionization, weaker acid). Comparing the two values, \(3.0\times10^{-8}\) (hypochlorous acid) is smaller than \(1.8\times10^{-5}\) (acetic acid) by about three orders of magnitude, so hypochlorous acid ionizes less and is therefore the weaker acid. (Choice A) This selects the wrong acid by inverting the relationship: a larger \(K_a\) corresponds to a greater, not smaller, degree of ionization, so acetic acid is the stronger acid, not the weaker one. (Choice C) Although both acids are weak relative to a strong acid, \(K_a\) values are not equal here; the roughly thousand-fold difference in \(K_a\) means the two acids differ measurably in strength, so they cannot be called equally weak. (Choice D) This identifies acetic acid as weaker on the false premise that a larger \(K_a\) leaves more molecules un-ionized; in fact a larger \(K_a\) means a larger fraction of molecules have ionized, making acetic acid the stronger acid. Skill 1$ex19$,
    'easy', '5A', $cc19$Acid-Base Equilibria (GC, BC)$cc19$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a19A$Treats the larger-Ka acid as the weaker one, inverting the Ka-to-ionization relationship$a19A$ FROM q
UNION ALL SELECT id, 'C', 'partial_truth', $a19C$Correctly notes both are weak acids but wrongly concludes equal strength, ignoring the difference in Ka magnitude$a19C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a19D$Believes a larger Ka means more molecules stay un-ionized, misreading what Ka quantifies about ionization extent$a19D$ FROM q;

-- Q20 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g20)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt20$Hydrobromic acid (\(\text{HBr}\)) is one of the six strong acids. A chemist prepares a \(1.0\times10^{-3}\ \text{M}\) aqueous solution of \(\text{HBr}\) at 25C, where \(K_w = 1.0\times10^{-14}\). What is the pH of this solution?$qt20$,
    $op20$[{"label":"A","text":"\\(\\text{pH} = 3.00\\)"},{"label":"B","text":"\\(\\text{pH} = 11.00\\)"},{"label":"C","text":"\\(\\text{pH} = -3.00\\)"},{"label":"D","text":"\\(\\text{pH} = 6.00\\)"}]$op20$::jsonb,
    'A',
    $ex20$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because \(\text{HBr}\) is a strong acid that dissociates completely, so a \(1.0\times10^{-3}\ \text{M}\) solution gives \([\text{H}^+] = 1.0\times10^{-3}\ \text{M}\), and \(\text{pH} = -\log[\text{H}^+] = -\log(1.0\times10^{-3}) = 3.00\). Because \(\text{HBr}\) is fully ionized, the formal concentration equals the hydronium concentration with no ICE approximation needed; the autoionization contribution of water is negligible at \(10^{-3}\ \text{M}\). Taking the negative base-10 logarithm of \(10^{-3}\) yields exactly \(+3.00\). (Choice B) \(11.00\) results from computing \(\text{pOH} = -\log(1.0\times10^{-3}) = 3.00\) and then reporting \(14 - 3.00\) as if the solute were a base, but \(\text{HBr}\) is acidic and \(-\log[\text{H}^+]\) is itself the pH. (Choice C) \(-3.00\) comes from taking \(+\log[\text{H}^+] = \log(1.0\times10^{-3})\) and omitting the negative sign in the definition \(\text{pH} = -\log[\text{H}^+]\). (Choice D) \(6.00\) arises from incorrectly treating \(\text{HBr}\) as a weak acid and assuming only partial ionization, which would lower \([\text{H}^+]\) below the formal concentration and push the pH toward neutral; \(\text{HBr}\) is a strong acid and ionizes completely. Skill 2$ex20$,
    'medium', '5A', $cc20$Acid-Base Equilibria (GC, BC)$cc20$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a20B$computed -log(C)=3.00 then reported 14-3 as pH, treating the strong acid as a base$a20B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a20C$sign error on the log: used +log[H+] instead of -log[H+]$a20C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a20D$treated HBr as a weak acid with only partial ionization, raising pH toward neutral$a20D$ FROM q;

-- Q21 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g21)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt21$A \(0.050\,\text{M}\) solution of nitric acid (\(\text{HNO}_3\)), which dissociates completely in water, is prepared at \(25\,^\circ\text{C}\). What is the pH of this solution?$qt21$,
    $op21$[{"label":"A","text":"\\(\\text{pH} = 1.00\\)"},{"label":"B","text":"\\(\\text{pH} = 2.00\\)"},{"label":"C","text":"\\(\\text{pH} = 1.30\\)"},{"label":"D","text":"\\(\\text{pH} = 12.70\\)"}]$op21$::jsonb,
    'C',
    $ex21$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because nitric acid dissociates completely, so every mole of \(\text{HNO}_3\) yields one mole of \(\text{H}_3\text{O}^+\); thus \([\text{H}_3\text{O}^+] = 0.050\,\text{M}\), and \(\text{pH} = -\log(0.050) = 1.30\). (Choice A) \(\text{pH} = 1.00\) results from treating the concentration as \(0.10\,\text{M}\) rather than the given \(0.050\,\text{M}\), giving \(-\log(0.10) = 1.00\). (Choice B) \(\text{pH} = 2.00\) comes from using \(1.0\times10^{-2}\,\text{M}\) instead of \(5.0\times10^{-2}\,\text{M}\) for the hydronium concentration, giving \(-\log(10^{-2}) = 2.00\). (Choice D) \(\text{pH} = 12.70\) is the pOH of the solution, \(14.00 - 1.30 = 12.70\), mistakenly reported as the pH. Skill 2$ex21$,
    'medium', '5A', $cc21$Acid-Base Equilibria (GC, BC)$cc21$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a21A$mis-set the concentration to 0.10 M instead of 0.050 M$a21A$ FROM q
UNION ALL SELECT id, 'B', 'scale_unit_error', $a21B$used 10^-2 in place of 5.0x10^-2 for the concentration$a21B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a21D$computed pOH and reported it as pH$a21D$ FROM q;

-- Q22 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g22)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt22$A \(0.010\,\text{M}\) solution of lithium hydroxide (\(\text{LiOH}\)), which dissociates completely in water, is prepared at \(25\,^\circ\text{C}\), where \(K_w = 1.0\times10^{-14}\). What is the pH of this solution?$qt22$,
    $op22$[{"label":"A","text":"\\(\\text{pH} = 2.00\\)"},{"label":"B","text":"\\(\\text{pH} = 7.00\\)"},{"label":"C","text":"\\(\\text{pH} = 11.00\\)"},{"label":"D","text":"\\(\\text{pH} = 12.00\\)"}]$op22$::jsonb,
    'D',
    $ex22$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because the dissolved base contributes one hydroxide ion per formula unit, so complete dissociation of a \(0.010\,\text{M}\) solution gives \([\text{OH}^-] = 0.010\,\text{M} = 1.0\times10^{-2}\,\text{M}\). Then \(\text{pOH} = -\log(1.0\times10^{-2}) = 2.00\), and at \(25\,^\circ\text{C}\) the relation \(\text{pH} + \text{pOH} = 14.00\) gives \(\text{pH} = 14.00 - 2.00 = 12.00\). (Choice A) \(\text{pH} = 2.00\) is the pOH of the solution; it was reported as the pH directly, skipping the conversion \(\text{pH} = 14.00 - \text{pOH}\), and a value below 7 would describe an acidic solution rather than a basic hydroxide one. (Choice B) \(\text{pH} = 7.00\) is the neutral value for pure water and would result only if the solution were assumed to have no net effect on \([\text{H}_3\text{O}^+]\), ignoring the added hydroxide. (Choice C) \(\text{pH} = 11.00\) follows from taking \([\text{OH}^-] = 1.0\times10^{-3}\,\text{M}\), which uses the wrong power of ten; the stated concentration is \(1.0\times10^{-2}\,\text{M}\), giving \(\text{pOH} = 2.00\), not \(3.00\). Skill 2$ex22$,
    'medium', '5A', $cc22$Acid-Base Equilibria (GC, BC)$cc22$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a22A$reports pOH as the final pH without subtracting from 14$a22A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a22B$assumes the solution is neutral and ignores the dissolved hydroxide$a22B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a22C$uses 10^-3 instead of 10^-2 for the hydroxide concentration$a22C$ FROM q;

-- Q23 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g23)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt23$Nitrous acid (\(\text{HNO}_2\)) has \(K_a = 4.0\times10^{-4}\). A solution is prepared at an initial concentration of \(0.10\ \text{M}\ \text{HNO}_2\). Using the small-\(x\) approximation, what is \([\text{H}^+]\) at equilibrium?$qt23$,
    $op23$[{"label":"A","text":"\\(4.0\\times10^{-5}\\ \\text{M}\\)"},{"label":"B","text":"\\(6.3\\times10^{-3}\\ \\text{M}\\)"},{"label":"C","text":"\\(2.0\\times10^{-3}\\ \\text{M}\\)"},{"label":"D","text":"\\(4.0\\times10^{-4}\\ \\text{M}\\)"}]$op23$::jsonb,
    'B',
    $ex23$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because the weak-acid equilibrium \(\text{HNO}_2 \rightleftharpoons \text{H}^+ + \text{NO}_2^-\) gives the expression \(K_a = \dfrac{x^2}{C-x}\), where \(x = [\text{H}^+]\) and \(C = 0.10\ \text{M}\). Because \(K_a\) is small, assume \(x \ll C\) so \(C - x \approx C\), leaving \(K_a \approx \dfrac{x^2}{C}\) and \(x = \sqrt{K_a \cdot C}\). Substituting: \(x = \sqrt{(4.0\times10^{-4})(0.10)} = \sqrt{4.0\times10^{-5}} = 6.3\times10^{-3}\ \text{M}\). (A check confirms the approximation: \(x/C = 6.3\times10^{-3}/0.10 \approx 6\%\), acceptably small.) (Choice A) \(4.0\times10^{-5}\ \text{M}\) is the product \(K_a \cdot C = (4.0\times10^{-4})(0.10)\) reported without taking its square root, so the final square-root step that converts \(x^2\) to \(x\) was omitted. (Choice C) \(2.0\times10^{-3}\ \text{M}\) results from taking the square root of \(K_a\) and \(C\) separately or mishandling the exponent as \(\sqrt{4.0\times10^{-5}} \to 2.0\times10^{-3}\); the radicand \(4.0\times10^{-5}\) has an odd power of ten, so its root is \(6.3\times10^{-3}\), not \(2.0\times10^{-3}\). (Choice D) \(4.0\times10^{-4}\ \text{M}\) simply restates \(K_a\) as if it were the hydrogen-ion concentration, ignoring that \([\text{H}^+]\) must be computed from \(\sqrt{K_a \cdot C}\). Skill 2$ex23$,
    'medium', '5A', $cc23$Acid-Base Equilibria (GC, BC)$cc23$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a23A$computed Ka*C but forgot to take the square root, reporting x^2 as x$a23A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a23C$mishandled the odd power of ten under the radical, giving sqrt(4.0e-5)=2.0e-3 instead of 6.3e-3$a23C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a23D$reported Ka itself as [H+] without using x=sqrt(Ka*C)$a23D$ FROM q;

-- Q24 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g24)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt24$Hydrofluoric acid (HF) is a weak acid with \(K_a = 6.8\times10^{-4}\). A \(0.10\ \text{M}\) solution of HF is prepared at \(25^\circ\text{C}\). Using the approximation \(x = \sqrt{K_a \cdot C}\), what is the pH of this solution?$qt24$,
    $op24$[{"label":"A","text":"\\(2.08\\)"},{"label":"B","text":"\\(4.17\\)"},{"label":"C","text":"\\(1.00\\)"},{"label":"D","text":"\\(11.92\\)"}]$op24$::jsonb,
    'A',
    $ex24$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because for a weak acid the equilibrium \(\text{HF} \rightleftharpoons \text{H}^+ + \text{F}^-\) is described by \(K_a = \frac{x^2}{C-x}\), where \(x = [\text{H}^+]\); applying the simplifying assumption that \(x \ll C\) gives \(K_a \approx \frac{x^2}{C}\), so \(x = \sqrt{K_a \cdot C}\). Substituting the given values: \(x = \sqrt{(6.8\times10^{-4})(0.10)} = \sqrt{6.8\times10^{-5}} = 8.2\times10^{-3}\ \text{M}\). Then \(\text{pH} = -\log[\text{H}^+] = -\log(8.2\times10^{-3}) = 3 - \log(8.2) = 3 - 0.92 = 2.08\). (Choice B) The value \(4.17\) results from omitting the square root and setting \([\text{H}^+] = K_a \cdot C = 6.8\times10^{-5}\ \text{M}\), then taking \(-\log(6.8\times10^{-5}) = 4.17\); this skips the step of solving \(x^2 = K_a \cdot C\) for \(x\). (Choice C) The value \(1.00\) results from treating HF as a strong acid that dissociates completely, setting \([\text{H}^+]\) equal to the full formal concentration \(0.10\ \text{M}\) so that \(\text{pH} = -\log(0.10) = 1.00\); this ignores that HF is a weak acid governed by \(K_a\). (Choice D) The value \(11.92\) results from computing the correct \([\text{H}^+]\) but then reporting \(\text{pOH}\) rather than \(\text{pH}\), or equivalently applying \(14 - 2.08 = 11.92\); the \(-\log\) of the hydrogen-ion concentration is the pH directly, with no subtraction from \(14\). Skill 2$ex24$,
    'medium', '5A', $cc24$Acid-Base Equilibria (GC, BC)$cc24$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a24B$Omitted the square root and set [H+] = Ka*C instead of sqrt(Ka*C)$a24B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a24C$Treated the weak acid HF as a strong acid with complete dissociation, [H+] = C$a24C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a24D$Reported pOH instead of pH (subtracted the correct pH from 14)$a24D$ FROM q;

-- Q25 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g25)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt25$A \(0.20\,\text{M}\) solution of acetic acid (\(\text{CH}_3\text{COOH}\), \(K_a = 1.8\times10^{-5}\)) is prepared at \(25^{\circ}\text{C}\). Using the approximation that the amount ionized is negligible relative to the initial concentration, what is the pH of the solution?$qt25$,
    $op25$[{"label":"A","text":"\\(\\text{pH} = 0.70\\)"},{"label":"B","text":"\\(\\text{pH} = 5.44\\)"},{"label":"C","text":"\\(\\text{pH} = 2.72\\)"},{"label":"D","text":"\\(\\text{pH} = 11.28\\)"}]$op25$::jsonb,
    'C',
    $ex25$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because acetic acid is a weak acid, so its equilibrium concentration of \(\text{H}_3\text{O}^+\) is found from the \(K_a\) expression rather than from full dissociation. Writing the equilibrium \(\text{CH}_3\text{COOH} \rightleftharpoons \text{H}^+ + \text{CH}_3\text{COO}^-\) and letting \(x = [\text{H}^+]\), the ICE table gives \(K_a = \dfrac{x^2}{C - x} \approx \dfrac{x^2}{C}\) when \(x \ll C\). Solving, \(x = \sqrt{K_a \cdot C} = \sqrt{(1.8\times10^{-5})(0.20)} = \sqrt{3.6\times10^{-6}} = 1.9\times10^{-3}\,\text{M}\). Then \(\text{pH} = -\log[\text{H}^+] = -\log(1.9\times10^{-3}) \approx 2.72\). (Choice A) \(\text{pH} = 0.70\) results from treating acetic acid as a strong acid that fully dissociates, setting \([\text{H}^+] = C = 0.20\,\text{M}\) and computing \(-\log(0.20)\); this ignores that a weak acid only partially ionizes. (Choice B) \(\text{pH} = 5.44\) results from omitting the square root and using \([\text{H}^+] = K_a \cdot C = 3.6\times10^{-6}\,\text{M}\) directly, so \(-\log(3.6\times10^{-6}) \approx 5.44\); the equilibrium relation requires \(x = \sqrt{K_a \cdot C}\), not \(K_a \cdot C\). (Choice D) \(\text{pH} = 11.28\) results from correctly finding \(x = 1.9\times10^{-3}\,\text{M}\) but treating that value as \([\text{OH}^-]\), computing \(\text{pOH} = 2.72\) and then \(\text{pH} = 14 - 2.72 = 11.28\); acetic acid is an acid, so the calculated \(x\) is \([\text{H}^+]\) and feeds \(-\log[\text{H}^+]\) directly. Skill 2$ex25$,
    'medium', '5A', $cc25$Acid-Base Equilibria (GC, BC)$cc25$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a25A$treated the weak acid as a strong acid, setting [H+] = C = 0.20 M and full dissociation$a25A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a25B$omitted the square root, using [H+] = Ka*C instead of sqrt(Ka*C)$a25B$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a25D$treated the computed x as [OH-] and used pH = 14 - pOH instead of pH = -log[H+]$a25D$ FROM q;

-- Q26 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g26)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt26$A \(0.50\ \text{M}\) solution of formic acid (\(\text{HCO}_2\text{H}\), \(K_a = 1.8\times10^{-4}\)) is prepared at 25 C. Using the standard ICE approximation \(x = \sqrt{K_a\,C}\), the percent ionization of the formic acid is most nearly$qt26$,
    $op26$[{"label":"A","text":"\\(0.018\\%\\)"},{"label":"B","text":"\\(0.95\\%\\)"},{"label":"C","text":"\\(9.5\\%\\)"},{"label":"D","text":"\\(1.9\\%\\)"}]$op26$::jsonb,
    'D',
    $ex26$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because percent ionization is the equilibrium \([\text{H}^+]\) divided by the initial acid concentration, times 100, and for a weak acid the ICE approximation gives \([\text{H}^+] = x = \sqrt{K_a\,C}\). Substituting the given values, \(x = \sqrt{(1.8\times10^{-4})(0.50)} = \sqrt{9.0\times10^{-5}} = 9.5\times10^{-3}\ \text{M}\). The percent ionization is then \(\left(\dfrac{x}{C}\right)\times100 = \left(\dfrac{9.5\times10^{-3}}{0.50}\right)\times100 = 1.9\%\), which matches choice D. (Choice A) The value \(0.018\%\) results from omitting the square root and using \(x = K_a\,C = 9.0\times10^{-5}\ \text{M}\) as the ionized concentration; the equilibrium expression \(K_a = x^2/(C-x)\) requires solving for \(x\) as \(\sqrt{K_a\,C}\), not as the product \(K_a\,C\) itself. (Choice B) The value \(0.95\%\) results from computing \(x = 9.5\times10^{-3}\ \text{M}\) correctly but then multiplying by 100 without first dividing by the initial concentration \(C = 0.50\ \text{M}\); percent ionization is defined relative to the starting acid concentration, so the division by \(C\) cannot be skipped. (Choice C) The value \(9.5\%\) results from reporting the numerical value of \(x = 9.5\times10^{-3}\) as though the \(10^{-3}\) factor were already a percentage, conflating the molar concentration of ionized acid with the percent ionization and misplacing the decimal scale by a factor that omits both the \(/C\) step and the \(\times100\) conversion. Skill 2$ex26$,
    'medium', '5A', $cc26$Acid-Base Equilibria (GC, BC)$cc26$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a26A$omitted the square root, used x = Ka*C as the ionized concentration$a26A$ FROM q
UNION ALL SELECT id, 'B', 'partial_truth', $a26B$correct x but multiplied by 100 without dividing by initial concentration C$a26B$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a26C$reported molar x value as a percent, misplacing the decimal scale$a26C$ FROM q;

-- Q27 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g27)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt27$A \(0.25\,\text{M}\) solution of hypochlorous acid (\(\text{HClO}\)) has \([\text{H}^+] = 9.0\times10^{-5}\,\text{M}\) at equilibrium. What is the percent ionization of the acid?$qt27$,
    $op27$[{"label":"A","text":"\\(0.00036\\%\\)"},{"label":"B","text":"\\(0.036\\%\\)"},{"label":"C","text":"\\(3.6\\%\\)"},{"label":"D","text":"\\(0.0090\\%\\)"}]$op27$::jsonb,
    'B',
    $ex27$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because percent ionization is the fraction of the initial acid that has dissociated, expressed as a percentage: \(\text{percent ionization} = \dfrac{x}{C}\times 100\%\), where \(x = [\text{H}^+]\) produced at equilibrium and \(C\) is the initial acid concentration. Here \(x = 9.0\times10^{-5}\,\text{M}\) and \(C = 0.25\,\text{M}\), so \(\dfrac{9.0\times10^{-5}}{0.25} = 3.6\times10^{-4}\), and multiplying by \(100\%\) gives \(3.6\times10^{-4}\times100\% = 0.036\%\). The very small value confirms that \(\text{HClO}\) is a weak acid that ionizes only slightly. (Choice A) The value \(0.00036\%\) is \(\dfrac{9.0\times10^{-5}}{0.25} = 3.6\times10^{-4}\) reported directly as a percent, omitting the multiplication by \(100\%\) that converts the dimensionless fraction into a percentage. (Choice C) The value \(3.6\%\) comes from applying the factor of \(100\) twice—correctly forming \(3.6\times10^{-4}\) and then multiplying by \(10^4\) instead of \(10^2\)—an order-of-magnitude scaling error. (Choice D) The value \(0.0090\%\) comes from computing \([\text{H}^+]\times100\% = 9.0\times10^{-5}\times100\%\) without dividing by the initial concentration \(C\), so the ionized amount is never normalized to how much acid was present. Skill 2$ex27$,
    'medium', '5A', $cc27$Acid-Base Equilibria (GC, BC)$cc27$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a27A$computed the fraction x/C correctly but omitted the multiplication by 100 that converts it to a percent$a27A$ FROM q
UNION ALL SELECT id, 'C', 'scale_unit_error', $a27C$applied the factor of 100 twice (multiplied by 10^4 instead of 10^2), an order-of-magnitude scaling error$a27C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a27D$scaled [H+] by 100 without dividing by the initial concentration C, so the ionized amount is never normalized to the acid present$a27D$ FROM q;

-- Q28 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g28)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt28$A weak monoprotic acid has an acid dissociation constant of \(K_a = 1.0\times10^{-5}\) at 25C. What is the \(\text{p}K_a\) of this acid?$qt28$,
    $op28$[{"label":"A","text":"\\(\\text{p}K_a = 5.00\\)"},{"label":"B","text":"\\(\\text{p}K_a = 9.00\\)"},{"label":"C","text":"\\(\\text{p}K_a = -5.00\\)"},{"label":"D","text":"\\(\\text{p}K_a = 4.00\\)"}]$op28$::jsonb,
    'A',
    $ex28$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because \(\text{p}K_a\) is defined as the negative base-10 logarithm of \(K_a\): \(\text{p}K_a = -\log(K_a)\). Substituting \(K_a = 1.0\times10^{-5}\) gives \(\text{p}K_a = -\log(1.0\times10^{-5})\). Because \(\log(1.0\times10^{-5}) = -5.00\), the negative of that is \(\text{p}K_a = -(-5.00) = 5.00\). (Choice B) \(9.00\) is the value of \(\text{p}K_b\) for the conjugate base, obtained by applying \(\text{p}K_a + \text{p}K_b = 14\) (i.e. \(14 - 5 = 9\)); it describes the conjugate base, not the \(\text{p}K_a\) of the acid itself. (Choice C) \(-5.00\) results from omitting the leading negative sign in the definition and reporting \(\log(K_a)\) directly rather than \(-\log(K_a)\); a true acid \(\text{p}K_a\) of this magnitude would be negative only for a very strong acid, not a weak one. (Choice D) \(4.00\) arises from misreading the exponent of \(1.0\times10^{-5}\) as \(-4\) and computing \(-\log(10^{-4})\); the exponent in the given \(K_a\) is \(-5\), so the correct logarithm is \(-5.00\). Skill 2$ex28$,
    'medium', '5A', $cc28$Acid-Base Equilibria (GC, BC)$cc28$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a28B$Computed pKb of the conjugate base via pKa + pKb = 14 and reported it as the acid's pKa$a28B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a28C$Dropped the negative sign in pKa = -log(Ka), reporting log(Ka) instead$a28C$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a28D$Misread the exponent of the Ka power of ten (used -4 instead of -5)$a28D$ FROM q;

-- Q29 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 2 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans C] (g29)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt29$A weak monoprotic acid \(\text{HA}\) is reported to have \(\text{p}K_a = 3.00\) at 25 C. Using \(\text{p}K_a = -\log K_a\), the acid-dissociation constant \(K_a\) for \(\text{HA}\) is closest to$qt29$,
    $op29$[{"label":"A","text":"\\(1.0\\times10^{3}\\)"},{"label":"B","text":"\\(1.0\\times10^{-11}\\)"},{"label":"C","text":"\\(1.0\\times10^{-3}\\)"},{"label":"D","text":"\\(3.0\\)"}]$op29$::jsonb,
    'C',
    $ex29$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is C because inverting the definition \(\text{p}K_a = -\log K_a\) gives \(K_a = 10^{-\text{p}K_a}\), and substituting \(\text{p}K_a = 3.00\) yields \(K_a = 10^{-3.00} = 1.0\times10^{-3}\). The negative sign in the definition means a small positive \(\text{p}K_a\) corresponds to a \(K_a\) less than 1, consistent with \(\text{HA}\) being a weak acid. (Choice A) \(1.0\times10^{3}\) results from dropping the negative sign and computing \(10^{+\text{p}K_a} = 10^{3}\); this reverses the relationship and would imply \(\text{HA}\) is an extraordinarily strong acid, which contradicts a positive \(\text{p}K_a\). (Choice B) \(1.0\times10^{-11}\) comes from first converting \(\text{p}K_a\) to a \(\text{p}K_b\) via \(\text{p}K_a + \text{p}K_b = 14\), giving \(\text{p}K_b = 11\), and then taking \(10^{-11}\); this computes the conjugate base's \(K_b\) rather than the acid's \(K_a\) that the question requests. (Choice D) \(3.0\) results from treating the \(\text{p}K_a\) value itself as \(K_a\) without applying the antilog \(10^{-\text{p}K_a}\), confusing the logarithmic scale value with the constant it encodes. Skill 2$ex29$,
    'medium', '5A', $cc29$Acid-Base Equilibria (GC, BC)$cc29$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a29A$dropped the negative sign, computed 10^(+pKa) instead of 10^(-pKa)$a29A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a29B$converted to pKb via pKa+pKb=14 and returned the conjugate Kb instead of Ka$a29B$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a29D$treated the pKa value as Ka without applying the antilog$a29D$ FROM q;

-- Q30 [Strong vs Weak Acids/Bases; Ka and Kb · medium · Skill 4 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans D] (g30)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt30$Three monoprotic weak acids are characterized in water at 25C: acid W has \(K_a = 7.2\times10^{-4}\), acid X has \(K_a = 1.8\times10^{-5}\), and acid Y has \(\text{p}K_a = 9.3\). Ranked from strongest to weakest acid, the correct order is:$qt30$,
    $op30$[{"label":"A","text":"\\(\\text{Y} > \\text{X} > \\text{W}\\)"},{"label":"B","text":"\\(\\text{Y} > \\text{W} > \\text{X}\\)"},{"label":"C","text":"\\(\\text{X} > \\text{W} > \\text{Y}\\)"},{"label":"D","text":"\\(\\text{W} > \\text{X} > \\text{Y}\\)"}]$op30$::jsonb,
    'D',
    $ex30$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is D because acid strength increases with a larger \(K_a\) (equivalently, a smaller \(\text{p}K_a\)), so to rank the three acids on one scale the \(\text{p}K_a\) of Y must first be converted into a \(K_a\). For acid Y, \(K_a = 10^{-\text{p}K_a} = 10^{-9.3} = 5.0\times10^{-10}\). The three \(K_a\) values are then \(W = 7.2\times10^{-4}\), \(X = 1.8\times10^{-5}\), and \(Y = 5.0\times10^{-10}\). Comparing them, \(7.2\times10^{-4} > 1.8\times10^{-5} > 5.0\times10^{-10}\), because a \(10^{-4}\) term exceeds a \(10^{-5}\) term, which in turn far exceeds a \(10^{-10}\) term. The acid with the largest \(K_a\) ionizes most completely and is the strongest, giving \(W > X > Y\). (Choice A) The order \(\text{Y} > \text{X} > \text{W}\) inverts the relationship by treating a smaller \(K_a\) (or, after conversion, the smallest \(K_a\) of \(5.0\times10^{-10}\)) as the strongest acid; the strength scale runs the opposite way, with larger \(K_a\) being stronger. (Choice B) The order \(\text{Y} > \text{W} > \text{X}\) ranks Y as strongest because its tabulated \(\text{p}K_a\) value of \(9.3\) is the largest single number printed in the stem; this compares a \(\text{p}K_a\) directly against \(K_a\) values without converting, whereas a larger \(\text{p}K_a\) actually marks the weakest acid. (Choice C) The order \(\text{X} > \text{W} > \text{Y}\) correctly places Y last after converting its \(\text{p}K_a\) but swaps W and X, treating \(1.8\times10^{-5}\) as larger than \(7.2\times10^{-4}\); a base-ten power of \(-5\) is smaller, not larger, than a power of \(-4\), so W has the greater \(K_a\). Skill 4$ex30$,
    'medium', '5A', $cc30$Acid-Base Equilibria (GC, BC)$cc30$, 'general-chemistry', 4, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a30A$orders acids by ascending Ka, treating the smallest Ka (weakest) as the strongest$a30A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a30B$ranks Y strongest because its printed pKa of 9.3 is the largest number, comparing pKa against Ka without converting$a30B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a30C$converts Y's pKa correctly but mis-orders W and X by treating 10^-5 as larger than 10^-4$a30C$ FROM q;

-- Q31 [Strong vs Weak Acids/Bases; Ka and Kb · hard · Skill 4 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans A] (g31)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt31$Trichloroacetic acid \(\text{CCl}_3\text{COOH}\) (\(\text{p}K_a = 0.66\)) is a markedly stronger acid than acetic acid \(\text{CH}_3\text{COOH}\) (\(\text{p}K_a = 4.76\)), despite both ionizing at the same carboxyl \(\text{O--H}\) bond. What accounts for the larger \(K_a\) of \(\text{CCl}_3\text{COOH}\)?$qt31$,
    $op31$[{"label":"A","text":"The three electronegative \\(\\text{Cl}\\) atoms withdraw electron density through the \\(\\sigma\\)-framework, dispersing the negative charge on the conjugate base \\(\\text{CCl}_3\\text{COO}^-\\) and lowering its energy so proton loss is more favorable."},{"label":"B","text":"The three electronegative \\(\\text{Cl}\\) atoms donate electron density toward the carboxyl group, concentrating negative charge on the conjugate base \\(\\text{CCl}_3\\text{COO}^-\\) and stabilizing it."},{"label":"C","text":"The three \\(\\text{Cl}\\) atoms increase the molar mass of \\(\\text{CCl}_3\\text{COOH}\\), and a heavier acid releases its proton more readily than a lighter one."},{"label":"D","text":"The three electronegative \\(\\text{Cl}\\) atoms withdraw electron density, which stabilizes the neutral \\(\\text{CCl}_3\\text{COOH}\\) molecule and makes it more reluctant to lose its proton."}]$op31$::jsonb,
    'A',
    $ex31$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is A because acid strength is governed by the stability of the conjugate base: the more stable the anion left behind after the proton departs, the further the ionization equilibrium lies to the right, the larger the \(K_a\), and the lower the \(\text{p}K_a\). Chlorine is far more electronegative than carbon, so the three \(\text{C--Cl}\) bonds in \(\text{CCl}_3\text{COOH}\) pull electron density away from the carboxyl group through the \(\sigma\)-bond framework. This inductive (electron-withdrawing) effect helps disperse the negative charge that builds up on the carboxylate oxygens of the conjugate base \(\text{CCl}_3\text{COO}^-\), lowering that anion's energy. A more stable conjugate base means \(\text{H}^+\) is released more readily, so \(\text{CCl}_3\text{COOH}\) is the stronger acid. Acetic acid has electron-donating \(\text{H}\) atoms in place of the \(\text{Cl}\) atoms and lacks this stabilization, which is why its \(K_a\) is roughly \(10^{4}\) times smaller (the \(\text{p}K_a\) is about 4 units higher). (Choice B) This reverses the direction of the inductive effect: the electronegative \(\text{Cl}\) atoms withdraw electron density rather than donate it, and stabilization of the conjugate base comes from spreading the negative charge out, not from concentrating it. (Choice C) Molar mass does not determine acid strength; the inductive electron-withdrawing capability of the substituents, not the mass they add, controls conjugate-base stability and therefore \(K_a\). (Choice D) This applies the electron-withdrawal to the wrong species: acid strength is set by the stability of the conjugate base relative to the neutral acid, so withdrawing density that stabilizes the anion increases ionization, and stabilizing the neutral acid instead would predict a weaker, not stronger, acid. Skill 4$ex31$,
    'hard', '5A', $cc31$Acid-Base Equilibria (GC, BC)$cc31$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a31B$Inverts the inductive effect, claiming the electronegative Cl atoms donate electron density and that concentrating charge stabilizes the conjugate base$a31B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a31C$Attributes greater acid strength to higher molar mass rather than to inductive conjugate-base stabilization$a31C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a31D$Applies the electron-withdrawing stabilization to the neutral acid instead of the conjugate base, conflating which species' stability sets Ka$a31D$ FROM q;

-- Q32 [Strong vs Weak Acids/Bases; Ka and Kb · hard · Skill 4 · 5A Acid-Base Equilibria (GC, BC) · general-chemistry · ans B] (g32)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Acids & Bases', 'Strong vs Weak Acids/Bases; Ka and Kb',
    $qt32$Among the binary hydrohalic acids, \(\text{HF}\) is a weak acid in water while \(\text{HCl}\), \(\text{HBr}\), and \(\text{HI}\) are strong, so acid strength rises in the order \(\text{HF} < \text{HCl} < \text{HBr} < \text{HI}\). Fluorine is the most electronegative halogen, yet \(\text{HF}\) is the weakest of the four. Which factor best explains why \(\text{HX}\) acid strength increases down the group despite the decrease in halogen electronegativity?$qt32$,
    $op32$[{"label":"A","text":"Electronegativity is the controlling factor, so the most electronegative halogen yields the strongest acid, which makes \\(\\text{HF}\\) the strongest of the four."},{"label":"B","text":"The \\(\\text{H–X}\\) bond grows longer and weaker from \\(\\text{HF}\\) to \\(\\text{HI}\\), so the proton is released more easily, and this bond-strength effect outweighs the falling electronegativity."},{"label":"C","text":"The larger halogens bind the shared electrons more tightly, strengthening the \\(\\text{H–X}\\) bond and making the proton progressively harder to remove down the group."},{"label":"D","text":"The conjugate base \\(\\text{X}^-\\) becomes less stable and more basic as the halogen grows larger, which is what raises the acid strength down the group."}]$op32$::jsonb,
    'B',
    $ex32$This is a General Chemistry question that falls under the content category 'Acid-Base Equilibria (GC, BC)'. The answer to this question is B because the strength of a binary acid \(\text{HX}\) is governed mainly by the strength of the \(\text{H–X}\) bond that must break to release the proton. Down the halogen group from \(\text{F}\) to \(\text{I}\) the atom grows larger, the \(\text{H–X}\) bond lengthens and weakens, and the proton is therefore released more readily, so acid strength rises \(\text{HF} < \text{HCl} < \text{HBr} < \text{HI}\). This bond-strength trend outweighs the opposing electronegativity trend: fluorine is the most electronegative halogen, which alone would favor \(\text{HF}\) as the strongest acid, but the short, strong \(\text{H–F}\) bond holds its proton so tightly that \(\text{HF}\) is in fact the weakest. (Choice A) Electronegativity is not the controlling factor for binary hydrohalic acids; if it were, \(\text{HF}\) would be the strongest acid, which directly contradicts the observed order in which \(\text{HF}\) is the weakest. (Choice C) The bond-strength trend is the reverse of what this choice states: the \(\text{H–X}\) bond becomes weaker, not stronger, as the halogen gets larger, because the longer bond and poorer orbital overlap make the proton easier to remove. (Choice D) The conjugate base \(\text{X}^-\) actually becomes more stable and less basic as the halogen grows larger, since the negative charge is spread over a bigger ion; a more stable conjugate base means a stronger acid, so this choice has the stability trend backwards. Skill 4$ex32$,
    'hard', '5A', $cc32$Acid-Base Equilibria (GC, BC)$cc32$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a32A$treats electronegativity as dominant, predicting HF strongest (opposite of the given order)$a32A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a32C$claims the H–X bond strengthens (not weakens) down the group$a32C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a32D$claims the larger halide conjugate base is less stable / more basic (reversed stability trend)$a32D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='Acids & Bases' AND subtopic IN ('Autoionization, Kw & the pH/pOH Scales', 'Strong vs Weak Acids/Bases; Ka and Kb');
