-- GenChem Ch11 (Oxidation-Reduction Reactions) — Batch 1 of 4: Oxidation Numbers + Oxidation/Reduction & Identifying Agents
-- 26 questions, all confidence >=4 (verified vs OpenStax Chemistry: Atoms First 2e Ch.7; every oxidation number, electron count, and balancing coefficient independently re-computed).
-- Cross-batch + cross-chapter deduped (esp. vs Ch4 Types-of-Reactions / Balancing-redox / Ions-Electrolytes); final dedup audit PASS (0 genuine conflicts) after a systematic recall-answer-leak sweep.
-- AAMC foundations in this batch: 4E (per-row foundation/content_category below). Answer key balanced A/B/C/D = 18/18/18/18 across the full 72-question chapter.
-- Re-runnable: subtopic-scoped DELETE. Run the four batches in any order in the Supabase SQL editor.
BEGIN;
DELETE FROM questions WHERE topic = 'Oxidation-Reduction Reactions' AND subtopic IN ('Oxidation Numbers: Assignment & Rules', 'Oxidation/Reduction & Identifying Agents');

-- Q1 [Oxidation Numbers: Assignment & Rules · easy · Skill 1 · 4E Stoichiometry (GC) · ans A] (g1)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt1$In a sample of pure oxygen gas, \(\text{O}_2\), what is the oxidation number assigned to each oxygen atom?$qt1$,
    $op1$[{"label":"A","text":"\\(0\\)"},{"label":"B","text":"\\(-2\\)"},{"label":"C","text":"\\(+2\\)"},{"label":"D","text":"\\(-1\\)"}]$op1$::jsonb,
    'A',
    $ex1$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because an atom in a free (uncombined) element is assigned an oxidation number of \(0\). Elemental oxygen, \(\text{O}_2\), consists of two identical oxygen atoms bonded to each other. Because the two atoms have identical electronegativity, the bonding electrons are shared equally and neither atom gains or loses any electron density relative to its neutral state. By the rule that any atom in its free elemental form has an oxidation number of zero, each oxygen atom in \(\text{O}_2\) is assigned an oxidation number of \(0\). (Choice B) The value \(-2\) is the oxidation number oxygen most commonly takes when combined with less electronegative elements, as in oxides, but it does not apply to oxygen bonded only to itself in the free element. (Choice C) The value \(+2\) reverses the sign of oxygen's typical combined oxidation state and would imply oxygen lost electron density, which does not occur in the homonuclear, equally shared bond of \(\text{O}_2\). (Choice D) The value \(-1\) is the oxidation number of oxygen specifically in peroxides such as \(\text{H}_2\text{O}_2\); it does not apply to the free element \(\text{O}_2\). Skill 1$ex1$,
    'easy', '4E', $cc1$Stoichiometry (GC)$cc1$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a1B$applies oxygen's usual combined state of -2 to the free element$a1B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a1C$flips the sign of oxygen's typical oxidation state to +2$a1C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a1D$uses the peroxide oxidation state -1 instead of the free-element value$a1D$ FROM q;

-- Q2 [Oxidation Numbers: Assignment & Rules · easy · Skill 1 · 4E Stoichiometry (GC) · ans B] (g2)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt2$In the sulfide ion, \(\text{S}^{2-}\), which is a monatomic ion, what is the oxidation number of the sulfur atom?$qt2$,
    $op2$[{"label":"A","text":"\\(+2\\)"},{"label":"B","text":"\\(-2\\)"},{"label":"C","text":"\\(0\\)"},{"label":"D","text":"\\(-1\\)"}]$op2$::jsonb,
    'B',
    $ex2$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because, by the oxidation-number rules, the oxidation number of a monatomic ion is exactly equal to its ionic charge. The sulfide ion is written as \(\text{S}^{2-}\), meaning a single sulfur atom carries a charge of \(2-\). Because the ion consists of only one atom, all of that charge is assigned to sulfur, so its oxidation number is \(-2\). (Choice A) \(+2\) reverses the sign of the charge; the sulfide ion carries a net negative charge of \(2-\), so the oxidation number must be negative, not positive. (Choice C) \(0\) is the oxidation number assigned to an atom in its elemental form, such as \(\text{S}_8\) or \(\text{S}\) metal, not to sulfur in a charged monatomic ion. (Choice D) \(-1\) takes the correct (negative) sign but the wrong magnitude; the charge on the ion is \(2-\), so the magnitude of the oxidation number is \(2\), giving \(-2\). Skill 1$ex2$,
    'easy', '4E', $cc2$Stoichiometry (GC)$cc2$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a2A$Correct magnitude but flipped sign of the ionic charge$a2A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a2C$Treats the monatomic ion as if it were a neutral free element$a2C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a2D$Right negative sign but wrong magnitude of the charge$a2D$ FROM q;

-- Q3 [Oxidation Numbers: Assignment & Rules · easy · Skill 2 · 4E Stoichiometry (GC) · ans C] (g3)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt3$Aluminum oxide, \(\text{Al}_2\text{O}_3\), is a neutral binary compound in which oxygen is in its usual \(-2\) oxidation state. What is the oxidation state of aluminum in \(\text{Al}_2\text{O}_3\)?$qt3$,
    $op3$[{"label":"A","text":"\\(-3\\)"},{"label":"B","text":"\\(+2\\)"},{"label":"C","text":"\\(+3\\)"},{"label":"D","text":"\\(-6\\)"}]$op3$::jsonb,
    'C',
    $ex3$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the sum of all oxidation numbers in a neutral compound must equal \(0\). With three oxygen atoms each assigned \(-2\), the total contribution of oxygen is \(3 \times (-2) = -6\). Letting \(x\) be the oxidation state of each aluminum atom and noting there are two aluminum atoms, the balance is \(2x + (-6) = 0\), so \(2x = +6\) and \(x = +3\). Each aluminum is therefore \(+3\), consistent with aluminum being a Group 13 metal that forms \(\text{Al}^{3+}\). (Choice A) \(-3\) reverses the sign: aluminum is the less electronegative element and is assigned the positive oxidation state, while oxygen carries the negative value, so the magnitude is correct but the sign is wrong. (Choice B) \(+2\) would arise from incorrectly treating the compound as a 1:1 oxide such as a hypothetical \(\text{AlO}\) (i.e., setting \(x + (-2) = 0\)) rather than using the actual \(2:3\) ratio in \(\text{Al}_2\text{O}_3\). (Choice D) \(-6\) is the total oxidation contribution of all three oxygen atoms, not the oxidation state of a single aluminum atom; it also has the wrong sign for the metal. Skill 2$ex3$,
    'easy', '4E', $cc3$Stoichiometry (GC)$cc3$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a3A$correct magnitude but assigns the negative sign to the metal instead of oxygen$a3A$ FROM q
UNION ALL SELECT id, 'B', 'process_step_confusion', $a3B$ignores the 2:3 subscript ratio and balances as a 1:1 oxide$a3B$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a3D$reports the total oxygen contribution (-6) as the metal's oxidation state$a3D$ FROM q;

-- Q4 [Oxidation Numbers: Assignment & Rules · easy · Skill 1 · 4E Stoichiometry (GC) · ans D] (g4)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt4$In methane, \(\text{CH}_4\), hydrogen is bonded to carbon, a nonmetal. What is the oxidation number assigned to each hydrogen atom in this compound?$qt4$,
    $op4$[{"label":"A","text":"\\(+4\\)"},{"label":"B","text":"\\(-1\\)"},{"label":"C","text":"\\(0\\)"},{"label":"D","text":"\\(+1\\)"}]$op4$::jsonb,
    'D',
    $ex4$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the standard rules for assigning oxidation numbers state that hydrogen is assigned an oxidation number of \(+1\) when it is bonded to a nonmetal. In \(\text{CH}_4\), each hydrogen is bonded to carbon, a nonmetal, so each hydrogen carries an oxidation number of \(+1\). This is consistent with the requirement that the oxidation numbers sum to the overall charge: with four hydrogens at \(+1\) each (a total of \(+4\)) and carbon at \(-4\), the sum is \((-4) + 4(+1) = 0\), matching the neutral molecule. (Choice A) The value \(+4\) is the oxidation number magnitude associated with the single carbon atom (which is \(-4\)), or the combined \(+4\) contribution of all four hydrogens together; it is not the value carried by each individual hydrogen atom. (Choice B) An oxidation number of \(-1\) is the value hydrogen takes only in metal hydrides, where it is bonded to a less electronegative metal (such as in \(\text{NaH}\)); carbon is a nonmetal, so this reversed assignment does not apply here. (Choice C) Assigning \(0\) confuses the oxidation number with the oxidation number of an element in its pure elemental form, such as \(\text{H}_2\); hydrogen in a compound is not in its free elemental state. Skill 1$ex4$,
    'easy', '4E', $cc4$Stoichiometry (GC)$cc4$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a4A$reports carbon's magnitude / the summed H contribution as the per-atom H value$a4A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a4B$applies the metal-hydride \(-1\) value to H bonded to a nonmetal$a4B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a4C$treats combined hydrogen as if in its free elemental state (oxidation number 0)$a4C$ FROM q;

-- Q5 [Oxidation Numbers: Assignment & Rules · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g5)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt5$In the sulfate ion, \(\text{SO}_4^{2-}\), oxygen is assigned its usual oxidation number of \(-2\). What is the oxidation number of the sulfur atom?$qt5$,
    $op5$[{"label":"A","text":"\\(+6\\)"},{"label":"B","text":"\\(+8\\)"},{"label":"C","text":"\\(-2\\)"},{"label":"D","text":"\\(+4\\)"}]$op5$::jsonb,
    'A',
    $ex5$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the sum of the oxidation numbers of all atoms in a polyatomic ion must equal the ion's net charge. In \(\text{SO}_4^{2-}\) the net charge is \(-2\), and each of the four oxygen atoms is assigned \(-2\), contributing \(4 \times (-2) = -8\). Letting the sulfur oxidation number be \(x\), the bookkeeping gives \(x + (-8) = -2\), so \(x = -2 + 8 = +6\). The oxidation number of sulfur in sulfate is therefore \(+6\). (Choice B) \(+8\) results from setting the atom sum equal to \(0\) (treating the ion as if it were neutral) rather than to the net charge of \(-2\): \(x - 8 = 0\) gives \(x = +8\), which ignores the ionic charge. (Choice C) \(-2\) is simply the oxidation number assigned to oxygen, mistakenly carried over to sulfur instead of being solved for. (Choice D) \(+4\) arises from treating the ion's net charge as \(+2\) instead of \(-2\): solving \(x + (-8) = +2\) gives \(x = +4\). Skill 2$ex5$,
    'medium', '4E', $cc5$Stoichiometry (GC)$cc5$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'process_step_confusion', $a5B$Sets atom sum to zero, ignoring the ion's net charge$a5B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a5C$Copies oxygen's oxidation number onto sulfur instead of solving$a5C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a5D$Uses the wrong sign on the net charge (+2 instead of -2)$a5D$ FROM q;

-- Q6 [Oxidation Numbers: Assignment & Rules · medium · Skill 2 · 4E Stoichiometry (GC) · ans B] (g6)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt6$The nitrate ion, \(\text{NO}_3^-\), is a polyatomic oxyanion carrying an overall charge of \(-1\). In this ion each oxygen atom is assigned its usual oxidation state of \(-2\). What is the oxidation number of the nitrogen atom in \(\text{NO}_3^-\)?$qt6$,
    $op6$[{"label":"A","text":"\\(+6\\)"},{"label":"B","text":"\\(+5\\)"},{"label":"C","text":"\\(-5\\)"},{"label":"D","text":"\\(+1\\)"}]$op6$::jsonb,
    'B',
    $ex6$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the rule for a polyatomic ion is that the sum of the oxidation numbers of all its atoms must equal the overall charge of the ion. In \(\text{NO}_3^-\) there are three oxygen atoms, each assigned \(-2\), contributing \(3 \times (-2) = -6\). Letting the nitrogen oxidation number be \(x\), the bookkeeping equation is \(x + (-6) = -1\), the ion's overall charge. Solving, \(x = -1 + 6 = +5\), so nitrogen is \(+5\) in the nitrate ion. (Choice A) The value \(+6\) results from setting the atom sum equal to \(0\) as if \(\text{NO}_3^-\) were a neutral molecule, solving \(x + (-6) = 0\) and ignoring the \(-1\) ionic charge that the oxidation numbers must total. (Choice C) The value \(-5\) is the correct magnitude with the sign reversed; it arises from solving the balance as \(x = -1 - (+6)\) or otherwise treating nitrogen as the negatively charged center rather than recognizing that the highly electronegative oxygens force nitrogen to a positive oxidation state. (Choice D) The value \(+1\) results from counting only a single oxygen contribution of \(-2\) instead of multiplying by the subscript of three, solving \(x + (-2) = -1\) and so failing to account for all three oxygen atoms. Skill 2$ex6$,
    'medium', '4E', $cc6$Stoichiometry (GC)$cc6$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a6A$set the atom sum to 0 (neutral molecule) instead of the ion charge of -1$a6A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a6C$correct magnitude with sign reversed, treating nitrogen as the negative center$a6C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a6D$used one oxygen (-2) instead of multiplying by the subscript of three$a6D$ FROM q;

-- Q7 [Oxidation Numbers: Assignment & Rules · easy · Skill 1 · 4E Stoichiometry (GC) · ans C] (g7)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt7$In the iodate ion, \(\text{IO}_3^-\), oxygen is assigned its usual oxidation number of \(-2\). What is the oxidation number of the iodine atom?$qt7$,
    $op7$[{"label":"A","text":"\\(+7\\)"},{"label":"B","text":"\\(+3\\)"},{"label":"C","text":"\\(+5\\)"},{"label":"D","text":"\\(-1\\)"}]$op7$::jsonb,
    'C',
    $ex7$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the oxidation numbers of all atoms in an ion sum to the ion's charge. The three oxygen atoms contribute \(3 \times (-2) = -6\); for the iodate ion's overall charge of \(-1\), the iodine must satisfy \(x + (-6) = -1\), giving \(x = +5\). (Choice A) \(+7\) is the oxidation state of iodine in the periodate ion \(\text{IO}_4^-\), which has four oxygens, not the three present in iodate. (Choice B) \(+3\) corresponds to iodine in the iodite ion \(\text{IO}_2^-\), which has only two oxygens. (Choice D) \(-1\) is the oxidation state of iodine in the monatomic iodide ion \(\text{I}^-\), not in an oxyanion. Skill 1$ex7$,
    'easy', '4E', $cc7$Stoichiometry (GC)$cc7$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'adjacent_fact', $a7A$uses the periodate (IO4-) value +7$a7A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a7B$uses the iodite (IO2-) value +3$a7B$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a7D$uses the iodide ion value -1$a7D$ FROM q;

-- Q8 [Oxidation Numbers: Assignment & Rules · easy · Skill 1 · 4E Stoichiometry (GC) · ans D] (g8)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt8$In silicon dioxide, \(\text{SiO}_2\), a neutral compound, oxygen is in its usual \(-2\) oxidation state. What is the oxidation number of the silicon atom?$qt8$,
    $op8$[{"label":"A","text":"\\(+2\\)"},{"label":"B","text":"\\(-4\\)"},{"label":"C","text":"\\(-2\\)"},{"label":"D","text":"\\(+4\\)"}]$op8$::jsonb,
    'D',
    $ex8$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the oxidation numbers in a neutral compound sum to zero. The two oxygen atoms contribute \(2 \times (-2) = -4\); for the compound to be neutral, silicon must be \(+4\) (since \(+4 + (-4) = 0\)). (Choice A) \(+2\) would balance only a single oxygen, as in a hypothetical \(\text{SiO}\); \(\text{SiO}_2\) contains two oxygens and so requires a \(+4\) silicon. (Choice B) \(-4\) reverses the sign: silicon is less electronegative than oxygen, so silicon takes the positive oxidation state and oxygen the negative. (Choice C) \(-2\) is the oxidation number of each oxygen atom, not of silicon. Skill 1$ex8$,
    'easy', '4E', $cc8$Stoichiometry (GC)$cc8$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a8A$balances as a 1:1 oxide (SiO) ignoring the two oxygens$a8A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a8B$assigns the negative sign to silicon instead of oxygen$a8B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a8C$reports oxygen’s value as silicon’s$a8C$ FROM q;

-- Q9 [Oxidation Numbers: Assignment & Rules · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g9)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt9$Sulfur dioxide, \(\text{SO}_2\), is a neutral molecular oxide of sulfur. Using the standard rule that oxygen is assigned an oxidation number of \(-2\) in oxides, what is the oxidation number of sulfur in \(\text{SO}_2\), and how does it compare with sulfur's oxidation number in its higher oxide, \(\text{SO}_3\)?$qt9$,
    $op9$[{"label":"A","text":"Sulfur is \\(+4\\) in \\(\\text{SO}_2\\), which is lower than the \\(+6\\) it carries in \\(\\text{SO}_3\\)."},{"label":"B","text":"Sulfur is \\(+6\\) in \\(\\text{SO}_2\\), the same value it carries in \\(\\text{SO}_3\\)."},{"label":"C","text":"Sulfur is \\(+2\\) in \\(\\text{SO}_2\\), which is lower than the \\(+4\\) it carries in \\(\\text{SO}_3\\)."},{"label":"D","text":"Sulfur is \\(-4\\) in \\(\\text{SO}_2\\), which is higher than the \\(-6\\) it carries in \\(\\text{SO}_3\\)."}]$op9$::jsonb,
    'A',
    $ex9$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the oxidation numbers of all atoms in a neutral compound must sum to zero, and each oxygen in an oxide is assigned \(-2\). In \(\text{SO}_2\) the two oxygen atoms contribute \(2 \times (-2) = -4\), so sulfur must satisfy \(x + (-4) = 0\), giving \(x = +4\). Repeating the bookkeeping for the higher oxide \(\text{SO}_3\): the three oxygens contribute \(3 \times (-2) = -6\), so \(x + (-6) = 0\) gives \(x = +6\). Sulfur is therefore \(+4\) in \(\text{SO}_2\) and \(+6\) in \(\text{SO}_3\), so its oxidation number is lower in the dioxide than in the higher oxide. (Choice B) The value \(+6\) is sulfur's oxidation number in \(\text{SO}_3\), not in \(\text{SO}_2\); it incorrectly assigns the higher oxide's value to the dioxide by summing \(3 \times (-2)\) instead of \(2 \times (-2)\) for the oxygens. (Choice C) The value \(+2\) results from counting only one oxygen \((1 \times -2 = -2)\) so that \(x + (-2) = 0\) gives \(x = +2\), ignoring the subscript \(2\) that indicates two oxygen atoms in \(\text{SO}_2\); it likewise mislabels \(\text{SO}_3\) as \(+4\). (Choice D) The value \(-4\) reverses the roles of the atoms by treating sulfur as the more electronegative species: it assigns the total oxygen charge to sulfur with the sign flipped, so the relative ordering of the two oxides is also reversed and reported with negative signs. Skill 2$ex9$,
    'medium', '4E', $cc9$Stoichiometry (GC)$cc9$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'adjacent_fact', $a9B$reports SO3's sulfur oxidation number (+6) for SO2$a9B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a9C$counts only one oxygen instead of two, ignoring the subscript$a9C$ FROM q
UNION ALL SELECT id, 'D', 'reversed_relationship', $a9D$reverses atom roles, assigning the oxygen charge to sulfur with flipped sign$a9D$ FROM q;

-- Q10 [Oxidation Numbers: Assignment & Rules · medium · Skill 2 · 4E Stoichiometry (GC) · ans B] (g10)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt10$In a sample of household cleaning solution, nitrogen is present as ammonia, \(\text{NH}_3\). What is the oxidation number of nitrogen in \(\text{NH}_3\)?$qt10$,
    $op10$[{"label":"A","text":"\\(+3\\)"},{"label":"B","text":"\\(-3\\)"},{"label":"C","text":"\\(+5\\)"},{"label":"D","text":"\\(-1\\)"}]$op10$::jsonb,
    'B',
    $ex10$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the standard rules assign each hydrogen an oxidation number of \(+1\) when it is bonded to a more electronegative nonmetal. In \(\text{NH}_3\), nitrogen is more electronegative than hydrogen, so each of the three H atoms is \(+1\), and the three H atoms sum to \(3 \times (+1) = +3\). Because \(\text{NH}_3\) is a neutral molecule, the oxidation numbers must sum to \(0\): letting the oxidation number of N be \(x\), \(x + 3(+1) = 0\), so \(x = -3\). Note that this is the opposite sign from nitrogen in nitric acid, \(\text{HNO}_3\), where H is \(+1\) and the three O atoms are \(-2\) each, forcing N to \(+5\) (\(x + (+1) + 3(-2) = 0 \rightarrow x = +5\)); the same element is negative in \(\text{NH}_3\) but positive in \(\text{HNO}_3\). (Choice A) \(+3\) takes the magnitude of the hydrogen sum (\(+3\)) and mistakenly reports it as nitrogen's oxidation number, ignoring that the neutral-molecule constraint requires N to balance that \(+3\) with an equal and opposite \(-3\). (Choice C) \(+5\) is the oxidation number of nitrogen in nitric acid, \(\text{HNO}_3\), not in ammonia; it confuses nitrogen's state in an oxoacid with its state in a hydride. (Choice D) \(-1\) incorrectly treats each hydrogen as \(-1\) (as if H were the hydride ion bonded to a metal), which would give \(x + 3(-1) = 0\) and \(x = +3\); the value \(-1\) does not even result from that erroneous setup, reflecting a confused application of the H-assignment step. Skill 2$ex10$,
    'medium', '4E', $cc10$Stoichiometry (GC)$cc10$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'partial_truth', $a10A$Reports the correct +3 hydrogen sum as nitrogen's own oxidation number$a10A$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a10C$Gives N's +5 state in HNO3 instead of in NH3$a10C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a10D$Misassigns hydrogen as -1 hydride, garbling the assignment step$a10D$ FROM q;

-- Q11 [Oxidation Numbers: Assignment & Rules · hard · Skill 3 · 4E Stoichiometry (GC) · ans C] (g11)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt11$In hydrogen peroxide, \(\text{H}_2\text{O}_2\), what is the oxidation number of each oxygen atom?$qt11$,
    $op11$[{"label":"A","text":"\\(-2\\)"},{"label":"B","text":"\\(+1\\)"},{"label":"C","text":"\\(-1\\)"},{"label":"D","text":"\\(-\\tfrac{1}{2}\\)"}]$op11$::jsonb,
    'C',
    $ex11$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because hydrogen peroxide is one of the standard exceptions to the rule that oxygen is assigned \(-2\). Begin with the hydrogen atoms: each hydrogen bonded to a more electronegative element is \(+1\), so the two hydrogens contribute \(2 \times (+1) = +2\). Because \(\text{H}_2\text{O}_2\) is a neutral molecule, the sum of all oxidation numbers must equal \(0\). Letting \(x\) be the oxidation number of each oxygen: \(2(+1) + 2(x) = 0\), so \(2x = -2\) and \(x = -1\). Each oxygen is therefore \(-1\). This reflects the actual structure \(\text{H}-\text{O}-\text{O}-\text{H}\): the central \(\text{O}-\text{O}\) bond is between two identical atoms, so its electrons are split evenly and contribute nothing to either oxygen's oxidation number, while each oxygen pulls the electrons of its bond to the less electronegative hydrogen, gaining one (\(-1\)). (Choice A) \(-2\) is the oxidation number oxygen takes in most compounds (oxides, water), but peroxides are the named exception; applying the default rule here ignores the \(\text{O}-\text{O}\) linkage. (Choice B) \(+1\) reverses the assignment, treating oxygen as if it were the less electronegative partner and giving it hydrogen's value instead; oxygen is more electronegative than hydrogen and cannot be positive in this molecule. (Choice D) \(-\tfrac{1}{2}\) comes from dividing the total negative charge needed (\(-2\)) by the four atoms in the formula, or by mishandling the per-atom bookkeeping; oxidation numbers are assigned per atom of a given element (here \(-2\) shared over the two oxygens, not all four atoms), giving \(-1\) each. Skill 3$ex11$,
    'hard', '4E', $cc11$Stoichiometry (GC)$cc11$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a11A$Applies the default O = -2 rule and overlooks the peroxide exception$a11A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a11B$Swaps relative electronegativity, assigning oxygen hydrogen's positive value$a11B$ FROM q
UNION ALL SELECT id, 'D', 'scale_unit_error', $a11D$Divides total charge across all four atoms instead of per oxygen atom$a11D$ FROM q;

-- Q12 [Oxidation Numbers: Assignment & Rules · hard · Skill 3 · 4E Stoichiometry (GC) · ans D] (g12)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt12$Calcium hydride, \(\text{CaH}_2\), is an ionic hydride in which hydrogen is bonded to a less electronegative metal. Applying the rules for assigning oxidation numbers, what are the oxidation numbers of hydrogen and calcium, respectively, in \(\text{CaH}_2\)?$qt12$,
    $op12$[{"label":"A","text":"H is \\(-1\\) and Ca is \\(+1\\)"},{"label":"B","text":"H is \\(+1\\) and Ca is \\(-2\\)"},{"label":"C","text":"H is \\(+1\\) and Ca is \\(+2\\)"},{"label":"D","text":"H is \\(-1\\) and Ca is \\(+2\\)"}]$op12$::jsonb,
    'D',
    $ex12$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because hydrogen does not follow its usual \(+1\) assignment here: in a metal (ionic) hydride such as \(\text{CaH}_2\), hydrogen is bonded to a metal that is less electronegative than itself, so hydrogen carries the more negative charge and is assigned an oxidation number of \(-1\). Calcium is a Group IIA (alkaline earth) metal, which is assigned its characteristic oxidation number of \(+2\) in compounds. Checking against the rule that the oxidation numbers in a neutral compound must sum to zero: \((+2) + 2(-1) = +2 - 2 = 0\), which is consistent, confirming H \(=-1\) and Ca \(=+2\). (Choice A) This correctly recognizes H \(=-1\) but then balances the charge by assigning calcium \(+1\) (treating it as though it were a Group IA metal) instead of its mandated Group IIA value of \(+2\); the sum \((+1) + 2(-1) = -1 eq 0\) is not balanced. (Choice B) This assigns hydrogen its common \(+1\) value, failing to apply the metal-hydride exception; forcing the sum to zero then drives calcium to \(-2\), an impossible value for a Group IIA metal that has only two valence electrons to lose. (Choice C) This correctly assigns Ca \(=+2\) but uses hydrogen's usual \(+1\); the sum would be \((+2) + 2(+1) = +4 eq 0\), violating the neutral-compound rule and ignoring that hydrogen is bonded to a less electronegative metal. Skill 3$ex12$,
    'hard', '4E', $cc12$Stoichiometry (GC)$cc12$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a12A$correct H = -1 but assigned calcium a Group IA value of +1 instead of Group IIA +2$a12A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a12B$applied hydrogen's default +1 and let calcium absorb an impossible -2 to balance$a12B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a12C$used hydrogen's usual +1 rule and skipped the metal-hydride exception, leaving an unbalanced sum$a12C$ FROM q;

-- Q13 [Oxidation Numbers: Assignment & Rules · hard · Skill 3 · 4E Stoichiometry (GC) · ans A] (g13)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt13$In most of its compounds oxygen is assigned an oxidation number of \(-2\), but oxygen difluoride, \(\text{OF}_2\), is a well-known exception. Fluorine is the most electronegative element and is assigned \(-1\) in this neutral molecule. What is the oxidation number of oxygen in \(\text{OF}_2\)?$qt13$,
    $op13$[{"label":"A","text":"\\(+2\\)"},{"label":"B","text":"\\(-2\\)"},{"label":"C","text":"\\(-1\\)"},{"label":"D","text":"\\(+1\\)"}]$op13$::jsonb,
    'A',
    $ex13$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because oxidation numbers in a neutral molecule must sum to zero, and the oxidation number of an atom is determined by assigning the shared electrons to the more electronegative partner in each bond. In \(\text{OF}_2\), fluorine is more electronegative than oxygen (fluorine is the most electronegative element, so it is always assigned \(-1\) in its compounds), which means the bonding electrons are formally assigned to fluorine and oxygen is left electron-deficient. With two fluorine atoms each at \(-1\), their total is \(2 \times (-1) = -2\). Letting the oxidation number of oxygen be \(x\), the neutrality condition gives \(x + 2(-1) = 0\), so \(x = +2\). Oxygen is therefore \(+2\) in \(\text{OF}_2\); this is the standard exception to the usual \(-2\) rule, which holds only when oxygen is bonded to a less electronegative partner. (Choice B) The value \(-2\) is oxygen's usual oxidation number, but that assignment assumes oxygen is the more electronegative atom in its bonds; here oxygen is bonded to fluorine, which is more electronegative, so the \(-2\) rule does not apply. (Choice C) The value \(-1\) is the oxidation number of each fluorine atom, not of oxygen; assigning \(-1\) to oxygen confuses the central atom with the more electronegative ligand and also fails the neutrality check, since \((-1) + 2(-1) = -3 eq 0\). (Choice D) The value \(+1\) would balance the molecule only if a single fluorine were present, \((+1) + (-1) = 0\); it ignores that the formula \(\text{OF}_2\) contains two fluorine atoms, each contributing \(-1\), which forces oxygen to \(+2\). Skill 3$ex13$,
    'hard', '4E', $cc13$Stoichiometry (GC)$cc13$, 'general-chemistry', 3, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'misconception', $a13B$applied the default oxygen = -2 rule despite the more electronegative fluorine partner$a13B$ FROM q
UNION ALL SELECT id, 'C', 'adjacent_fact', $a13C$reported fluorine's -1 oxidation number instead of oxygen's$a13C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a13D$counted only one fluorine atom, ignoring the subscript 2 in the neutrality balance$a13D$ FROM q;

-- Q14 [Oxidation Numbers: Assignment & Rules · hard · Skill 4 · 4E Stoichiometry (GC) · ans B] (g14)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation Numbers: Assignment & Rules',
    $qt14$Magnetite, \(\text{Fe}_3\text{O}_4\), is a mixed-valence iron oxide in which iron exists in more than one oxidation state. Treating oxygen as having its usual oxidation number, what is the average oxidation state of iron in \(\text{Fe}_3\text{O}_4\)?$qt14$,
    $op14$[{"label":"A","text":"\\(+\\tfrac{8}{4}\\)"},{"label":"B","text":"\\(+\\tfrac{8}{3}\\)"},{"label":"C","text":"\\(+\\tfrac{3}{8}\\)"},{"label":"D","text":"\\(+3\\)"}]$op14$::jsonb,
    'B',
    $ex14$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because oxygen is assigned its usual oxidation number of \(-2\) in this oxide, and the four oxygen atoms therefore contribute \(4 \times (-2) = -8\). Because \(\text{Fe}_3\text{O}_4\) is a neutral compound, the sum of all oxidation numbers must equal zero, so the three iron atoms together must contribute \(+8\): \(3x + (-8) = 0 \Rightarrow 3x = +8 \Rightarrow x = +\tfrac{8}{3}\). The average oxidation state of iron is thus \(+\tfrac{8}{3} \approx +2.67\), consistent with magnetite being \(\text{FeO}\cdot\text{Fe}_2\text{O}_3\), which contains one \(\text{Fe}^{2+}\) and two \(\text{Fe}^{3+}\) ions: \((+2) + (+3) + (+3) = +8\), giving \(+\tfrac{8}{3}\) per iron. (Choice A) \(+\tfrac{8}{4}\) divides the total iron charge of \(+8\) by the number of oxygen atoms (4) rather than by the number of iron atoms (3); the average must be taken over the iron atoms whose oxidation state is being found. (Choice C) \(+\tfrac{3}{8}\) is the reciprocal of the correct value, obtained by dividing the number of iron atoms by the total positive charge instead of dividing the charge by the number of atoms. (Choice D) \(+3\) is the oxidation state of iron in pure \(\text{Fe}_2\text{O}_3\) and ignores the presence of the lower-valence \(\text{Fe}^{2+}\) center, so it overstates the average for the mixed-valence oxide. Skill 4$ex14$,
    'hard', '4E', $cc14$Stoichiometry (GC)$cc14$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a14A$Divides total iron charge by oxygen-atom count instead of iron-atom count$a14A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a14C$Inverts the ratio, dividing atom count by total charge$a14C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a14D$Quotes the single Fe(III) state of Fe2O3, ignoring the Fe(II) center$a14D$ FROM q;

-- Q15 [Oxidation/Reduction & Identifying Agents · easy · Skill 1 · 4E Stoichiometry (GC) · ans C] (g15)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt15$Consider the single-displacement reaction \(\text{Zn}(s) + 2\,\text{HCl}(aq) \rightarrow \text{ZnCl}_2(aq) + \text{H}_2(g)\). Which species is oxidized during this reaction?$qt15$,
    $op15$[{"label":"A","text":"\\(\\text{Cl}^-\\) (from HCl)"},{"label":"B","text":"\\(\\text{H}^+\\) (from HCl)"},{"label":"C","text":"\\(\\text{Zn}(s)\\)"},{"label":"D","text":"\\(\\text{H}_2(g)\\)"}]$op15$::jsonb,
    'C',
    $ex15$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the species that is oxidized is the one that loses electrons, which corresponds to an increase in oxidation number. Elemental zinc, \(\text{Zn}(s)\), has an oxidation state of \(0\) (any element in its pure form has an oxidation state of \(0\)). In the product \(\text{ZnCl}_2\), zinc is present as the \(\text{Zn}^{2+}\) cation with an oxidation state of \(+2\). The change from \(0\) to \(+2\) means each zinc atom loses 2 electrons, so \(\text{Zn}(s)\) is oxidized. (Choice A) Chlorine has an oxidation state of \(-1\) in HCl and remains \(-1\) in \(\text{ZnCl}_2\); because its oxidation number does not change, chloride is a spectator ion and is neither oxidized nor reduced. (Choice B) Hydrogen in HCl has an oxidation state of \(+1\), and in \(\text{H}_2\) it has an oxidation state of \(0\); going from \(+1\) to \(0\) is a gain of electrons, so \(\text{H}^+\) is reduced, not oxidized. (Choice D) \(\text{H}_2(g)\) is the product of reduction (oxidation state \(0\)) rather than a reactant that loses electrons; identifying it as oxidized reverses the direction of electron transfer for hydrogen. Skill 1$ex15$,
    'easy', '4E', $cc15$Stoichiometry (GC)$cc15$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a15A$Selects the spectator ion whose oxidation state is unchanged$a15A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a15B$Names the species that is reduced (H+ gains electrons) instead of the one oxidized$a15B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a15D$Confuses the reduction product (H2) with the species undergoing oxidation$a15D$ FROM q;

-- Q16 [Oxidation/Reduction & Identifying Agents · easy · Skill 1 · 4E Stoichiometry (GC) · ans D] (g16)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt16$The thermite reaction is a highly exothermic redox process used in welding, represented by the balanced equation \(2\,\text{Al} + \text{Fe}_2\text{O}_3 \rightarrow \text{Al}_2\text{O}_3 + 2\,\text{Fe}\). Which species acts as the reducing agent in this reaction?$qt16$,
    $op16$[{"label":"A","text":"\\(\\text{Fe}\\)"},{"label":"B","text":"\\(\\text{Fe}_2\\text{O}_3\\)"},{"label":"C","text":"\\(\\text{Al}_2\\text{O}_3\\)"},{"label":"D","text":"\\(\\text{Al}\\)"}]$op16$::jsonb,
    'D',
    $ex16$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the reducing agent is the species that is itself oxidized, meaning it loses electrons and increases in oxidation state. Elemental aluminum on the reactant side has an oxidation state of \(0\) (a free element). In the product \(\text{Al}_2\text{O}_3\), oxygen is \(-2\), so the two Al atoms must total \(+6\), giving each aluminum an oxidation state of \(+3\). Thus Al goes from \(0\) to \(+3\), losing 3 electrons per atom (oxidation). Because \(\text{Al}\) supplies the electrons that reduce iron, \(\text{Al}\) is the reducing agent. For comparison, in \(\text{Fe}_2\text{O}_3\) each iron is \(+3\) (oxygen \(-2\), so two Fe total \(+6\)), and in elemental \(\text{Fe}\) the oxidation state is \(0\); iron is therefore reduced from \(+3\) to \(0\), confirming that the aluminum it gained electrons from is the reducing agent. (Choice A) \(\text{Fe}\) is the elemental product formed by reduction (the substance that was reduced), so it is the result of the reaction rather than the electron donor driving it. (Choice B) \(\text{Fe}_2\text{O}_3\) is the oxidizing agent, not the reducing agent: its iron is reduced from \(+3\) to \(0\), so it gains electrons rather than supplying them. (Choice C) \(\text{Al}_2\text{O}_3\) is a product in which aluminum has already reached its oxidized \(+3\) state; a product that has finished being oxidized cannot serve as the reducing agent for this reaction. Skill 1$ex16$,
    'easy', '4E', $cc16$Stoichiometry (GC)$cc16$, 'general-chemistry', 1, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a16A$Identifying the reduced product as the agent, confusing what is reduced with what reduces$a16A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a16B$Naming the oxidizing agent (the species reduced) instead of the reducing agent$a16B$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a16C$Selecting the oxidized aluminum product rather than the elemental aluminum reactant that donates electrons$a16C$ FROM q;

-- Q17 [Oxidation/Reduction & Identifying Agents · easy · Skill 2 · 4E Stoichiometry (GC) · ans A] (g17)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt17$Consider the single-displacement reaction \(\text{Cu}(s) + 2\,\text{AgNO}_3(aq) \rightarrow \text{Cu(NO}_3)_2(aq) + 2\,\text{Ag}(s)\). Which species is reduced in this reaction?$qt17$,
    $op17$[{"label":"A","text":"\\(\\text{Ag}^+\\), because its oxidation state decreases from \\(+1\\) to \\(0\\)"},{"label":"B","text":"\\(\\text{Cu}\\), because its oxidation state decreases from \\(0\\) to \\(+2\\)"},{"label":"C","text":"\\(\\text{Cu}\\), because its oxidation state increases from \\(0\\) to \\(+2\\)"},{"label":"D","text":"\\(\\text{NO}_3^-\\), because its oxidation state decreases from \\(-1\\) to \\(-2\\)"}]$op17$::jsonb,
    'A',
    $ex17$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because reduction is defined as a gain of electrons, which corresponds to a decrease in oxidation number. In silver nitrate the silver exists as \(\text{Ag}^+\), with an oxidation state of \(+1\). In the product \(\text{Ag}(s)\), elemental silver has an oxidation state of \(0\). Going from \(+1\) to \(0\) means each silver ion gains one electron, so \(\text{Ag}^+\) is reduced (and acts as the oxidizing agent). By contrast, copper goes from \(0\) in \(\text{Cu}(s)\) to \(+2\) in \(\text{Cu(NO}_3)_2\), losing two electrons; copper is therefore oxidized, not reduced. The nitrate ion \(\text{NO}_3^-\) is a spectator: nitrogen remains \(+5\) and oxygen remains \(-2\) on both sides, so its overall \(-1\) charge is unchanged. (Choice B) Copper does change oxidation state, but it goes from \(0\) to \(+2\), which is an increase, not a decrease; this choice also mislabels an increase in oxidation number as reduction. (Choice C) This correctly identifies that copper's oxidation state increases from \(0\) to \(+2\), but an increase in oxidation number is oxidation, not reduction, so copper is the species oxidized rather than reduced. (Choice D) Nitrate is a spectator ion whose atoms do not change oxidation state; nitrogen stays \(+5\) and oxygen stays \(-2\), and the stated change from \(-1\) to \(-2\) does not occur. Skill 2$ex17$,
    'easy', '4E', $cc17$Stoichiometry (GC)$cc17$, 'general-chemistry', 2, 75
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a17B$Picks the oxidized species (Cu) but labels its change as reduction, with a direction error in the oxidation state$a17B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a17C$Correctly tracks Cu going 0 to +2 but confuses an increase in oxidation number with reduction$a17C$ FROM q
UNION ALL SELECT id, 'D', 'adjacent_fact', $a17D$Treats the spectator nitrate ion as undergoing reduction by inventing an oxidation-state change$a17D$ FROM q;

-- Q18 [Oxidation/Reduction & Identifying Agents · medium · Skill 3 · 4E Stoichiometry (GC) · ans B] (g18)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt18$Iron metal is dropped into aqueous copper(II) sulfate and reacts according to the balanced equation \(\text{Fe(s)} + \text{CuSO}_4\text{(aq)} \rightarrow \text{FeSO}_4\text{(aq)} + \text{Cu(s)}\). The sulfate ion \(\text{SO}_4^{2-}\) is a spectator and is unchanged. Which species acts as the oxidizing agent in this reaction, and what happens to it?$qt18$,
    $op18$[{"label":"A","text":"\\(\\text{CuSO}_4\\) (the \\(\\text{Cu}^{2+}\\)-containing species) is the oxidizing agent, and it is itself oxidized as \\(\\text{Cu}\\) goes from \\(+2\\) to \\(0\\)."},{"label":"B","text":"\\(\\text{CuSO}_4\\) (the \\(\\text{Cu}^{2+}\\)-containing species) is the oxidizing agent, and it is itself reduced as \\(\\text{Cu}\\) goes from \\(+2\\) to \\(0\\)."},{"label":"C","text":"\\(\\text{Fe(s)}\\) is the oxidizing agent, and it is itself reduced as \\(\\text{Fe}\\) goes from \\(0\\) to \\(+2\\)."},{"label":"D","text":"\\(\\text{SO}_4^{2-}\\) is the oxidizing agent, because it carries the negative charge that pulls electrons away from the metals."}]$op18$::jsonb,
    'B',
    $ex18$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the oxidizing agent is the reactant that causes another species to be oxidized by accepting its electrons, and in doing so the oxidizing agent is itself reduced. Tracking oxidation numbers: in \(\text{Fe(s)}\) iron is \(0\), and in \(\text{FeSO}_4\) iron is \(+2\) (since \(\text{SO}_4^{2-}\) is \(-2\)), so iron loses two electrons (\(0 \rightarrow +2\)) and is oxidized; that makes \(\text{Fe}\) the reducing agent. In \(\text{CuSO}_4\) copper is \(+2\) (paired with \(\text{SO}_4^{2-}\) at \(-2\)), and in \(\text{Cu(s)}\) copper is \(0\), so copper gains two electrons (\(+2 \rightarrow 0\)) and is reduced. Because the \(\text{Cu}^{2+}\)-containing species, \(\text{CuSO}_4\), is the one accepting electrons and being reduced, it is the oxidizing agent, and an oxidizing agent is always itself reduced. (Choice A) This correctly names \(\text{CuSO}_4\) as the oxidizing agent but states it is oxidized; a species going from \(+2\) to \(0\) gains electrons and is reduced, not oxidized, so the agent label and the direction of electron transfer are contradictory. (Choice C) \(\text{Fe}\) goes from \(0\) to \(+2\), which is a loss of electrons (oxidation), making iron the reducing agent that is itself oxidized; it is therefore neither the oxidizing agent nor a species that is reduced. (Choice D) \(\text{SO}_4^{2-}\) is a spectator ion whose sulfur (\(+6\)) and oxygen (\(-2\)) oxidation states are unchanged throughout, so it transfers no electrons and cannot serve as the oxidizing agent; ionic charge alone does not make a species an electron acceptor. Skill 3$ex18$,
    'medium', '4E', $cc18$Stoichiometry (GC)$cc18$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a18A$correct agent, reversed redox direction (calls the reduced species oxidized)$a18A$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a18C$labels the oxidized reducing agent (Fe) as the oxidizing agent$a18C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a18D$treats the spectator sulfate's negative charge as the source of oxidizing power$a18D$ FROM q;

-- Q19 [Oxidation/Reduction & Identifying Agents · medium · Skill 3 · 4E Stoichiometry (GC) · ans C] (g19)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt19$Aqueous sodium bromide reacts with chlorine gas according to the equation \(\text{Cl}_2(g) + 2\,\text{NaBr}(aq) \rightarrow 2\,\text{NaCl}(aq) + \text{Br}_2(l)\). Which species acts as the reducing agent in this reaction?$qt19$,
    $op19$[{"label":"A","text":"\\(\\text{Cl}^-\\), because it is oxidized from \\(-1\\) to \\(0\\)"},{"label":"B","text":"\\(\\text{Cl}_2\\), because it is reduced from \\(0\\) to \\(-1\\)"},{"label":"C","text":"\\(\\text{Br}^-\\), because it is oxidized from \\(-1\\) to \\(0\\)"},{"label":"D","text":"\\(\\text{Na}^+\\), because it is reduced from \\(+1\\) to \\(0\\)"}]$op19$::jsonb,
    'C',
    $ex19$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the reducing agent is the species that is itself oxidized (loses electrons) while causing the reduction of another species. Assigning oxidation states across the reaction: bromine begins as bromide ion \(\text{Br}^-\) in \(\text{NaBr}\) with an oxidation state of \(-1\) and ends as elemental \(\text{Br}_2(l)\) with an oxidation state of \(0\); this increase from \(-1\) to \(0\) is an oxidation, identifying \(\text{Br}^-\) as the reducing agent. Concurrently, chlorine in \(\text{Cl}_2\) goes from \(0\) to \(-1\) in \(\text{NaCl}\), an oxidation-state decrease (reduction), so \(\text{Cl}_2\) is the oxidizing agent, not the reducing agent. Sodium remains \(+1\) throughout (a spectator ion). Because bromide supplies the electrons that reduce chlorine, \(\text{Br}^-\) is the reducing agent. (Choice A) The oxidized halide is bromide, not \(\text{Cl}^-\); chlorine in this reaction is gaining electrons to form \(\text{Cl}^-\) (oxidation state \(0 \rightarrow -1\)), so describing \(\text{Cl}^-\) as being "oxidized from \(-1\) to \(0\)" misassigns both the element and the direction of electron transfer. (Choice B) \(\text{Cl}_2\) is indeed reduced from \(0\) to \(-1\), but the species that is reduced is the oxidizing agent, not the reducing agent; this choice reverses the definitions of oxidizing and reducing agent. (Choice D) Sodium is a spectator ion that stays at \(+1\) in both \(\text{NaBr}\) and \(\text{NaCl}\); it neither gains nor loses electrons, so treating \(\text{Na}^+\) as undergoing reduction incorrectly assumes the cation participates in the redox event. Skill 3$ex19$,
    'medium', '4E', $cc19$Stoichiometry (GC)$cc19$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a19A$Picks the chlorine-containing ion as the oxidized species, confusing which halogen is oxidized and the electron-transfer direction$a19A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a19B$Names the reduced species (Cl2) as the reducing agent, swapping the oxidizing/reducing agent definitions$a19B$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a19D$Treats the spectator cation Na+ as a redox-active species being reduced to metallic sodium$a19D$ FROM q;

-- Q20 [Oxidation/Reduction & Identifying Agents · medium · Skill 2 · 4E Stoichiometry (GC) · ans D] (g20)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt20$In acidic solution, tin(II) ion reacts with iron(III) ion according to the skeleton reaction \(\text{Sn}^{2+} + \text{Fe}^{3+} \rightarrow \text{Sn}^{4+} + \text{Fe}^{2+}\). Which statement correctly describes the oxidation-number change undergone by tin and the resulting role of the tin species?$qt20$,
    $op20$[{"label":"A","text":"Tin changes from \\(+2\\) to \\(+4\\), so \\(\\text{Sn}^{2+}\\) is reduced and acts as the oxidizing agent."},{"label":"B","text":"Tin changes from \\(+4\\) to \\(+2\\), so \\(\\text{Sn}^{2+}\\) is reduced and acts as the reducing agent."},{"label":"C","text":"Tin is unchanged at \\(+2\\) and acts as a spectator ion."},{"label":"D","text":"Tin changes from \\(+2\\) to \\(+4\\), so \\(\\text{Sn}^{2+}\\) is oxidized and acts as the reducing agent."}]$op20$::jsonb,
    'D',
    $ex20$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because tin's oxidation state rises from \(+2\) in \(\text{Sn}^{2+}\) to \(+4\) in \(\text{Sn}^{4+}\), a loss of two electrons; a species that loses electrons is oxidized, and the species that is oxidized is the reducing agent. (Iron is correspondingly reduced, from \(+3\) to \(+2\), so \(\text{Fe}^{3+}\) is the oxidizing agent.) (Choice A) A rise from \(+2\) to \(+4\) is a loss of electrons, which is oxidation, not reduction; and the oxidized species is the reducing agent, not the oxidizing agent. (Choice B) Tin's oxidation state rises rather than falls, so describing it as a change from \(+4\) to \(+2\) reverses the actual direction. (Choice C) Tin's oxidation state does change (from \(+2\) to \(+4\)), so tin is not a spectator. Skill 2$ex20$,
    'medium', '4E', $cc20$Stoichiometry (GC)$cc20$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'misconception', $a20A$labels an oxidation (+2->+4) as reduction and as the oxidizing agent$a20A$ FROM q
UNION ALL SELECT id, 'B', 'reversed_relationship', $a20B$reverses the direction of tin’s oxidation-state change$a20B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a20C$treats the redox-active ion as an unchanging spectator$a20C$ FROM q;

-- Q21 [Oxidation/Reduction & Identifying Agents · medium · Skill 2 · 4E Stoichiometry (GC) · ans A] (g21)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt21$Copper(II) oxide is reduced to copper metal by hydrogen gas according to the reaction \(\text{CuO}(s) + \text{H}_2(g) \rightarrow \text{Cu}(s) + \text{H}_2\text{O}(g)\). Based on the changes in oxidation number that occur, which species is oxidized and which is reduced?$qt21$,
    $op21$[{"label":"A","text":"\\(\\text{H}_2\\) is oxidized (H goes from \\(0\\) to \\(+1\\)) and \\(\\text{Cu}\\) is reduced (Cu goes from \\(+2\\) to \\(0\\))."},{"label":"B","text":"\\(\\text{Cu}\\) is oxidized (Cu goes from \\(0\\) to \\(+2\\)) and \\(\\text{H}_2\\) is reduced (H goes from \\(+1\\) to \\(0\\))."},{"label":"C","text":"\\(\\text{O}\\) is oxidized (O goes from \\(-2\\) to \\(0\\)) and \\(\\text{Cu}\\) is reduced (Cu goes from \\(+2\\) to \\(0\\))."},{"label":"D","text":"\\(\\text{H}_2\\) is oxidized (H goes from \\(0\\) to \\(+1\\)) and \\(\\text{H}_2\\) is also reduced because hydrogen both gains and loses electrons."}]$op21$::jsonb,
    'A',
    $ex21$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because oxidation is a loss of electrons (an increase in oxidation number) and reduction is a gain of electrons (a decrease in oxidation number). Assigning oxidation numbers: in \(\text{CuO}\), oxygen is \(-2\), so copper must be \(+2\); elemental \(\text{H}_2\) has H at \(0\). In the products, \(\text{Cu}(s)\) is an element so copper is \(0\), and in \(\text{H}_2\text{O}\) oxygen is \(-2\) and each hydrogen is \(+1\). Tracking each element: hydrogen changes from \(0\) to \(+1\), a loss of electrons, so \(\text{H}_2\) is oxidized (it is the reducing agent). Copper changes from \(+2\) to \(0\), a gain of electrons, so \(\text{Cu}^{2+}\) is reduced (\(\text{CuO}\) is the oxidizing agent). Oxygen remains \(-2\) in both \(\text{CuO}\) and \(\text{H}_2\text{O}\), so it is neither oxidized nor reduced. (Choice B) This reverses the two processes: it claims copper goes from \(0\) to \(+2\) (oxidation) and hydrogen goes from \(+1\) to \(0\) (reduction), which inverts the actual direction of every oxidation-number change and incorrectly assigns the starting states. (Choice C) Oxygen does not change oxidation state; it is \(-2\) in \(\text{CuO}\) and \(-2\) in \(\text{H}_2\text{O}\), so it is a spectator with respect to electron transfer and is not oxidized to \(0\). (Choice D) Hydrogen undergoes only one change, from \(0\) to \(+1\) (oxidation); it does not simultaneously get reduced, and treating a single element as both oxidized and reduced misapplies the concept of disproportionation, which does not occur here. Skill 2$ex21$,
    'medium', '4E', $cc21$Stoichiometry (GC)$cc21$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'reversed_relationship', $a21B$Swaps oxidized and reduced species by reversing every oxidation-number change$a21B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a21C$Treats unchanging spectator oxygen as the oxidized species$a21C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a21D$Invents disproportionation, claiming hydrogen is both oxidized and reduced$a21D$ FROM q;

-- Q22 [Oxidation/Reduction & Identifying Agents · medium · Skill 3 · 4E Stoichiometry (GC) · ans B] (g22)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt22$Methane burns in oxygen according to the balanced equation \(\text{CH}_4 + 2\,\text{O}_2 \rightarrow \text{CO}_2 + 2\,\text{H}_2\text{O}\). In this combustion reaction, which species acts as the oxidizing agent, and which element undergoes oxidation?$qt22$,
    $op22$[{"label":"A","text":"\\(\\text{CH}_4\\) is the oxidizing agent, and oxygen is oxidized (from \\(0\\) to \\(-2\\))."},{"label":"B","text":"\\(\\text{O}_2\\) is the oxidizing agent, and carbon is oxidized (from \\(-4\\) to \\(+4\\))."},{"label":"C","text":"\\(\\text{O}_2\\) is the oxidizing agent, and carbon is oxidized (from \\(+4\\) to \\(-4\\))."},{"label":"D","text":"\\(\\text{O}_2\\) is the oxidizing agent, and hydrogen is oxidized (from \\(+1\\) to \\(-1\\))."}]$op22$::jsonb,
    'B',
    $ex22$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because the oxidizing agent is the species that is itself reduced (it gains electrons and causes another species to be oxidized). Begin by assigning oxidation states. In \(\text{CH}_4\), each H is \(+1\) (four of them total \(+4\)), so for the neutral molecule carbon must be \(-4\). In \(\text{O}_2\), oxygen is in its elemental form, so its oxidation state is \(0\). On the product side, in \(\text{CO}_2\) each oxygen is \(-2\) (total \(-4\)), so carbon is \(+4\); in \(\text{H}_2\text{O}\), hydrogen is \(+1\) and oxygen is \(-2\). Tracking the changes: carbon goes from \(-4\) in \(\text{CH}_4\) to \(+4\) in \(\text{CO}_2\), a loss of \(8\) electrons (oxidation). Oxygen goes from \(0\) in \(\text{O}_2\) to \(-2\) in both products, a gain of electrons (reduction). Hydrogen stays \(+1\) throughout (unchanged). Because oxygen is reduced, \(\text{O}_2\) is the oxidizing agent, and the element that is oxidized is carbon, moving from \(-4\) to \(+4\). (Choice A) This reverses the roles: \(\text{CH}_4\) is the species oxidized (it contains the carbon that loses electrons), so it is the reducing agent, not the oxidizing agent; oxygen is reduced, not oxidized. (Choice C) The oxidizing agent is correctly identified as \(\text{O}_2\), but the direction of carbon's oxidation-state change is backward: carbon goes from \(-4\) to \(+4\) (oxidation, losing electrons), not from \(+4\) to \(-4\). (Choice D) \(\text{O}_2\) is correctly named, but hydrogen is not oxidized; its oxidation state remains \(+1\) in both \(\text{CH}_4\) and \(\text{H}_2\text{O}\), and \(-1\) would only apply to a metal hydride, which does not form here. Skill 3$ex22$,
    'medium', '4E', $cc22$Stoichiometry (GC)$cc22$, 'general-chemistry', 3, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a22A$Swaps oxidizing and reducing agent roles$a22A$ FROM q
UNION ALL SELECT id, 'C', 'process_step_confusion', $a22C$Correct agent but reversed oxidation-state direction$a22C$ FROM q
UNION ALL SELECT id, 'D', 'misconception', $a22D$Assigns spurious oxidation-state change to spectator hydrogen$a22D$ FROM q;

-- Q23 [Oxidation/Reduction & Identifying Agents · medium · Skill 2 · 4E Stoichiometry (GC) · ans C] (g23)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt23$Consider the spontaneous galvanic reaction \(\text{Zn} + \text{Cu}^{2+} \rightarrow \text{Zn}^{2+} + \text{Cu}\). When this equation is written so that the oxidation and reduction half-reactions are balanced against each other, how many moles of electrons are transferred per mole of \(\text{Zn}\) consumed?$qt23$,
    $op23$[{"label":"A","text":"1 mole of electrons"},{"label":"B","text":"3 moles of electrons"},{"label":"C","text":"2 moles of electrons"},{"label":"D","text":"4 moles of electrons"}]$op23$::jsonb,
    'C',
    $ex23$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is C because the number of electrons transferred is found by writing each half-reaction and matching the electrons lost in oxidation to the electrons gained in reduction. In the oxidation half-reaction, zinc metal goes from an oxidation state of \(0\) in \(\text{Zn}\) to \(+2\) in \(\text{Zn}^{2+}\), losing 2 electrons: \(\text{Zn} \rightarrow \text{Zn}^{2+} + 2\,e^-\). In the reduction half-reaction, copper goes from \(+2\) in \(\text{Cu}^{2+}\) to \(0\) in \(\text{Cu}\), gaining 2 electrons: \(\text{Cu}^{2+} + 2\,e^- \rightarrow \text{Cu}\). Because each half-change already involves 2 electrons, the half-reactions are balanced against each other with no extra multiplier, so exactly 2 moles of electrons are transferred per mole of \(\text{Zn}\) consumed. (Choice A) 1 mole of electrons corresponds to the magnitude of the change in the ionic charge digit (e.g., treating \(\text{Zn}^{2+}\) as a single unit charge transfer) rather than counting the actual electrons given up as \(\text{Zn}\) moves from \(0\) to \(+2\). (Choice B) 3 moles of electrons does not arise from any half-reaction here; it would require an oxidation-state change of 3 units, as for a metal going from \(0\) to \(+3\), which neither zinc nor copper undergoes in this reaction. (Choice D) 4 moles of electrons results from incorrectly adding the 2 electrons lost by zinc to the 2 electrons gained by copper, double-counting the same transferred electrons instead of recognizing that the electrons lost ARE the electrons gained. Skill 2$ex23$,
    'medium', '4E', $cc23$Stoichiometry (GC)$cc23$, 'general-chemistry', 2, 110
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'scale_unit_error', $a23A$Counts the ionic charge digit as one electron instead of the full oxidation-state change$a23A$ FROM q
UNION ALL SELECT id, 'B', 'adjacent_fact', $a23B$Assumes a 3-electron transfer typical of a +3 metal ion that is not present here$a23B$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a23D$Adds electrons lost and electrons gained instead of matching them as the same transferred electrons$a23D$ FROM q;

-- Q24 [Oxidation/Reduction & Identifying Agents · hard · Skill 4 · 4E Stoichiometry (GC) · ans D] (g24)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt24$Sodium metal burns vigorously in chlorine gas to form sodium chloride according to the balanced equation \(2\,\text{Na} + \text{Cl}_2 \rightarrow 2\,\text{NaCl}\). Which of the following correctly identifies the oxidizing agent in this reaction?$qt24$,
    $op24$[{"label":"A","text":"\\(\\text{NaCl}\\), because the product contains both the oxidized and reduced elements after electron transfer is complete."},{"label":"B","text":"\\(\\text{Na}\\), because it is the species oxidized as its oxidation state rises from \\(0\\) to \\(+1\\)."},{"label":"C","text":"\\(\\text{Cl}_2\\), because it is oxidized from \\(0\\) to \\(-1\\) and therefore donates electrons to sodium."},{"label":"D","text":"\\(\\text{Cl}_2\\), because each chlorine atom is reduced from \\(0\\) to \\(-1\\), accepting the electrons lost by sodium."}]$op24$::jsonb,
    'D',
    $ex24$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is D because the oxidizing agent is the species that is itself reduced (gains electrons) and thereby causes the oxidation of another species. Both reactants begin as neutral elements with an oxidation state of \(0\). In the product \(\text{NaCl}\), sodium is \(+1\) and chlorine is \(-1\). Sodium therefore loses one electron each (\(0 \rightarrow +1\)), so Na is oxidized and acts as the reducing agent. Chlorine gains one electron per atom (\(0 \rightarrow -1\)), so \(\text{Cl}_2\) is reduced and is the oxidizing agent. The half-reactions are \(\text{Na} \rightarrow \text{Na}^+ + e^-\) (oxidation) and \(\text{Cl}_2 + 2e^- \rightarrow 2\,\text{Cl}^-\) (reduction); the two electrons released by two Na atoms are exactly the two electrons accepted by \(\text{Cl}_2\). Because \(\text{Cl}_2\) accepts the electrons lost by sodium and is reduced from \(0\) to \(-1\), \(\text{Cl}_2\) is the oxidizing agent. (Choice A) \(\text{NaCl}\) is the product formed after electron transfer is complete and is neither a reactant nor a redox agent; an oxidizing agent must be a reactant species that is reduced during the reaction. (Choice B) Na has an oxidation state that rises from \(0\) to \(+1\), so it is indeed the species oxidized; however, the species oxidized is the reducing agent, not the oxidizing agent, so naming Na confuses the oxidized species with the agent label. (Choice C) \(\text{Cl}_2\) is the correct agent, but the justification is reversed: chlorine's oxidation state decreases from \(0\) to \(-1\), meaning it is reduced and gains electrons, not oxidized donating electrons. Skill 4$ex24$,
    'hard', '4E', $cc24$Stoichiometry (GC)$cc24$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'process_step_confusion', $a24A$Names the post-transfer product instead of the reactant that is reduced$a24A$ FROM q
UNION ALL SELECT id, 'B', 'misconception', $a24B$Conflates the species oxidized (reducing agent) with the oxidizing agent$a24B$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a24C$Correct agent but reverses gain/loss of electrons (calls reduction oxidation)$a24C$ FROM q;

-- Q25 [Oxidation/Reduction & Identifying Agents · hard · Skill 4 · 4E Stoichiometry (GC) · ans A] (g25)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt25$When chlorine gas is bubbled through hot concentrated sodium hydroxide, it disproportionates according to the balanced equation \(3\,\text{Cl}_2 + 6\,\text{NaOH} \rightarrow 5\,\text{NaCl} + \text{NaClO}_3 + 3\,\text{H}_2\text{O}\). Using the oxidation-state changes of chlorine, how many moles of electrons are transferred for each mole of \(\text{Cl}_2\) that reacts?$qt25$,
    $op25$[{"label":"A","text":"\\(\\tfrac{5}{3}\\) mol of electrons per mole of \\(\\text{Cl}_2\\)"},{"label":"B","text":"\\(5\\) mol of electrons per mole of \\(\\text{Cl}_2\\)"},{"label":"C","text":"\\(\\tfrac{10}{3}\\) mol of electrons per mole of \\(\\text{Cl}_2\\)"},{"label":"D","text":"\\(1\\) mol of electrons per mole of \\(\\text{Cl}_2\\)"}]$op25$::jsonb,
    'A',
    $ex25$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is A because the electron transfer must be counted once (the electrons lost by the oxidized chlorine are exactly the electrons gained by the reduced chlorine) and then normalized to a single mole of \(\text{Cl}_2\). In \(\text{Cl}_2\) each chlorine atom is at oxidation state \(0\). The equation consumes \(3\) mol \(\text{Cl}_2\), which is \(6\) mol of Cl atoms. On the product side, the \(5\) mol of chlorine in \(\text{NaCl}\) are at \(-1\) (Na is \(+1\)), so each is reduced \(0 \rightarrow -1\), gaining \(1\) electron, for \(5 \times 1 = 5\) mol of electrons gained. The \(1\) mol of chlorine in \(\text{NaClO}_3\) is at \(+5\) (Na \(+1\) and three O at \(-2\) sum to \(-6\), leaving Cl at \(+5\)), so it is oxidized \(0 \rightarrow +5\), losing \(5\) electrons, for \(1 \times 5 = 5\) mol of electrons lost. The electrons lost equal the electrons gained, so exactly \(5\) mol of electrons are transferred per the equation as written. Dividing by the \(3\) mol of \(\text{Cl}_2\) consumed gives \(\frac{5}{3}\) mol of electrons transferred per mole of \(\text{Cl}_2\). (Choice B) is incorrect because \(5\) mol is the total number of electrons transferred for the entire equation as written, which consumes \(3\) mol of \(\text{Cl}_2\); failing to divide by \(3\) reports a per-equation quantity in place of the requested per-mole-of-\(\text{Cl}_2\) quantity. (Choice C) is incorrect because it double-counts the electrons: it adds the \(5\) mol lost in the oxidation to the \(5\) mol gained in the reduction to get \(10\) mol per equation, but in any redox process the electrons released are the same electrons captured and must be counted only once before dividing by \(3\). (Choice D) is incorrect because it accounts only for the one-electron reduction \(0 \rightarrow -1\) and ignores the much larger five-electron oxidation \(0 \rightarrow +5\) as well as the \(5:1\) atom ratio between the reduced and oxidized products, so it understates the electrons actually transferred. Skill 4$ex25$,
    'hard', '4E', $cc25$Stoichiometry (GC)$cc25$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'B', 'scale_unit_error', $a25B$Reports the total electrons transferred for the whole balanced equation without dividing by the 3 mol of Cl2, giving a per-equation value instead of per-mole-of-Cl2$a25B$ FROM q
UNION ALL SELECT id, 'C', 'misconception', $a25C$Double-counts by adding electrons lost in the oxidation to electrons gained in the reduction, when the transferred electrons are one and the same and counted once$a25C$ FROM q
UNION ALL SELECT id, 'D', 'partial_truth', $a25D$Accounts only for the one-electron reduction to chloride and ignores the five-electron oxidation to chlorate and the 5:1 product ratio$a25D$ FROM q;

-- Q26 [Oxidation/Reduction & Identifying Agents · hard · Skill 4 · 4E Stoichiometry (GC) · ans B] (g26)
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys', 'Oxidation-Reduction Reactions', 'Oxidation/Reduction & Identifying Agents',
    $qt26$In acidic solution, dichromate oxidizes ethanol to acetaldehyde according to the skeleton (unbalanced for H and O) reaction \(\text{Cr}_2\text{O}_7^{2-} + 3\,\text{C}_2\text{H}_5\text{OH} \rightarrow 2\,\text{Cr}^{3+} + 3\,\text{CH}_3\text{CHO}\). Focusing on the carbon that is functionalized (the carbinol carbon of ethanol that becomes the carbonyl carbon of acetaldehyde), what is the change in its oxidation state, and which species is the oxidizing agent?$qt26$,
    $op26$[{"label":"A","text":"The carbon changes from \\(-1\\) to \\(+1\\), and \\(\\text{C}_2\\text{H}_5\\text{OH}\\) is the oxidizing agent."},{"label":"B","text":"The carbon changes from \\(-1\\) to \\(+1\\), and \\(\\text{Cr}_2\\text{O}_7^{2-}\\) is the oxidizing agent."},{"label":"C","text":"The carbon changes from \\(+1\\) to \\(-1\\), and \\(\\text{Cr}_2\\text{O}_7^{2-}\\) is the oxidizing agent."},{"label":"D","text":"The carbon changes from \\(-2\\) to \\(0\\), and \\(\\text{Cr}_2\\text{O}_7^{2-}\\) is the oxidizing agent."}]$op26$::jsonb,
    'B',
    $ex26$This is a General Chemistry question that falls under the content category 'Stoichiometry (GC)'. The answer to this question is B because assigning oxidation states atom-by-atom around the carbinol carbon of ethanol \(\text{CH}_3\text{CH}_2\text{OH}\) gives: this carbon is bonded to two H atoms (each contributes \(-1\) to carbon), one O atom (contributes \(+1\) to carbon), and one C atom (contributes \(0\), being the same element), so its oxidation state is \(2(-1) + (+1) + 0 = -1\). In acetaldehyde \(\text{CH}_3\text{CHO}\), the same carbon is the carbonyl carbon, bonded to one H (\(-1\)), a doubly bonded O (two bonds to oxygen contribute \(+2\)), and one C (\(0\)), so its oxidation state is \((-1) + (+2) + 0 = +1\). The carbon therefore goes from \(-1\) to \(+1\), an increase of two units that corresponds to losing 2 electrons; an increase in oxidation state is oxidation, so carbon is oxidized. The species that is reduced is the oxidizing agent: chromium goes from \(+6\) in \(\text{Cr}_2\text{O}_7^{2-}\) to \(+3\) in \(\text{Cr}^{3+}\) (it gains electrons), so \(\text{Cr}_2\text{O}_7^{2-}\) is the oxidizing agent while ethanol is the reducing agent. (Choice A) The oxidation-state change is correct, but the agent role is misassigned: the species that loses electrons (ethanol, whose carbon goes \(-1 \rightarrow +1\)) is the reducing agent, not the oxidizing agent. (Choice C) This reverses the direction of the oxidation-state change; converting an alcohol to an aldehyde removes hydrogen and raises the carbon's oxidation state, so the change is \(-1 \rightarrow +1\), not \(+1 \rightarrow -1\), which would describe a reduction. (Choice D) These values come from omitting the contribution of the C–O bond when counting, treating the carbinol carbon as if it were a CH2 bonded only to carbon and hydrogen; including the more electronegative oxygen shifts both values upward to \(-1\) and \(+1\). Skill 4$ex26$,
    'hard', '4E', $cc26$Stoichiometry (GC)$cc26$, 'general-chemistry', 4, 160
  ) RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
SELECT id, 'A', 'reversed_relationship', $a26A$correct oxidation-state change but swaps oxidizing and reducing agent roles$a26A$ FROM q
UNION ALL SELECT id, 'C', 'reversed_relationship', $a26C$reverses the direction of the carbon oxidation-state change (treats oxidation as reduction)$a26C$ FROM q
UNION ALL SELECT id, 'D', 'process_step_confusion', $a26D$omits the C-O bond contribution when assigning the carbon's oxidation state$a26D$ FROM q;

COMMIT;
SELECT COUNT(*) AS batch1_questions FROM questions WHERE topic='Oxidation-Reduction Reactions' AND subtopic IN ('Oxidation Numbers: Assignment & Rules', 'Oxidation/Reduction & Identifying Agents');
