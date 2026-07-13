-- ════════════════════════════════════════════════════════════════════
-- Biochemistry Ch12 — Bioenergetics and Regulation of Metabolism — 85 standalone questions
-- (thermodynamics/bioenergetics, ATP & high-energy carriers, integrative metabolic states,
--  hormonal regulation, tissue-specific metabolism, energy balance).
-- Foundation 1D. content categories: Principles of Bioenergetics / Hormonal Regulation and
--  Integration of Metabolism. Grounded in LibreTexts Biochemistry.
-- WHOLE-DOCUMENT cross-subject scope map (thermo fundamentals ride in via GC 5E); off-outline
--  items trimmed (respiratory quotient/indirect calorimetry, BMI, glutathione).
-- Cross-batch audit folded in the live Ch10 (bioenergetics), Ch11 (integration), and Bio Ch5
--  Endocrine (hormones) questions to catch true cross-chapter duplicates.
-- IDEMPOTENT: wipes the entire topic then re-inserts all 85.
-- ════════════════════════════════════════════════════════════════════

BEGIN;
DELETE FROM questions WHERE section = 'bio_biochem' AND topic = 'Bioenergetics and Regulation of Metabolism';

-- Q1 [A1 · Thermodynamics: Systems & Free Energy] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'A biologist describes a single bacterial cell suspended in liquid growth medium: it continuously takes up glucose and ions, releases CO₂ and metabolic waste back into the medium, and equilibrates heat with the surrounding fluid. Based strictly on what crosses its boundary, this cell is best classified as which type of thermodynamic system?', '[{"label": "A", "text": "An open system, because both matter and energy cross its boundary."}, {"label": "B", "text": "A closed system, because it exchanges energy with its surroundings but not matter."}, {"label": "C", "text": "An isolated system, because its boundary prevents any exchange of matter or energy."}, {"label": "D", "text": "A closed system, because the matter it takes in is fully recycled internally rather than exchanged."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because the cell described takes in matter (glucose, ions), releases matter (CO₂, waste), and exchanges heat with the fluid around it — both matter and energy cross its boundary, which is the defining feature of an open system and the reason every living cell or organism is thermodynamically open.

(Choice B) is incorrect: a closed system exchanges energy but not matter; this cell plainly imports glucose and exports waste, so ''closed'' ignores the matter it moves across its boundary.
(Choice C) is incorrect: an isolated system exchanges neither matter nor energy, but this cell exchanges both, making it the opposite of isolated.
(Choice A) is correct: because both matter and energy cross the boundary, the cell is an open system — the category that applies to all living things.
(Choice D) is incorrect: the cell does not merely recycle matter internally; it genuinely trades matter with the medium, so it cannot be classified as closed.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: classifying a system by identifying what actually crosses its boundary rather than recalling a bare definition.', 'easy', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'closed = exchanges energy only' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'isolated = nothing crosses boundary' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'matter recycled internally so closed' FROM q;

-- Q2 [A2 · Thermodynamics: Systems & Free Energy] medium skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'During one step of a process, a system absorbs 150 J of heat from its surroundings and, in the same interval, does 60 J of work on its surroundings by expanding against them. Applying the first law of thermodynamics, how does the internal energy of the system change?', '[{"label": "A", "text": "It increases by 210 J."}, {"label": "B", "text": "It increases by 90 J."}, {"label": "C", "text": "It decreases by 90 J."}, {"label": "D", "text": "It does not change, because the first law requires energy to be conserved."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because the first law states \(\Delta U = Q - W\), where Q is heat added to the system and W is work done by the system; with Q = +150 J and W = +60 J, \(\Delta U = 150 - 60 = +90\) J, an increase.

(Choice B) is correct: \(\Delta U = Q - W = 150 - 60 = +90\) J, so internal energy rises by 90 J.
(Choice A) is incorrect: adding the work (150 + 60 = 210 J) treats work done BY the system as energy gained, but work done by the system removes energy, so it must be subtracted.
(Choice C) is incorrect: 60 − 150 = −90 J reverses the roles of Q and W; heat is added while work is done by the system, giving a net gain, not a loss.
(Choice D) is incorrect: ''energy is conserved'' refers to the universe (system plus surroundings), not to the system''s internal energy staying fixed; here the system nets +90 J while the surroundings lose the same amount.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: applying \(\Delta U = Q - W\) with the correct sign convention for heat and work.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'work by system adds energy' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'computes W minus Q' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'conserved means zero net change' FROM q;

-- Q3 [A3 · Thermodynamics: Systems & Free Energy] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'A reaction is carried out in a beaker open to the atmosphere. As it proceeds, a thermometer in the reaction mixture reads a steadily falling temperature, and the outside of the beaker feels cold to the touch. At constant pressure, what does this behavior indicate about the enthalpy change of the reaction?', '[{"label": "A", "text": "ΔH < 0, because the reaction releases heat to its surroundings (exothermic)."}, {"label": "B", "text": "ΔH < 0, because heat is absorbed by the reaction, lowering its heat content."}, {"label": "C", "text": "ΔH > 0, because the reaction absorbs heat from its surroundings (endothermic)."}, {"label": "D", "text": "ΔH = 0, because heat merely moves between system and surroundings with no net change."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because a falling temperature and a cold beaker mean the reaction is drawing heat in from its surroundings; a process that absorbs heat at constant pressure is endothermic, so \(\Delta H > 0\).

(Choice A) is incorrect: releasing heat (exothermic, \(\Delta H < 0\)) would warm the mixture and the beaker; a cold beaker indicates the opposite direction of heat flow.
(Choice B) is incorrect: it correctly notes heat is absorbed but then assigns a negative sign; absorbing heat raises the system''s enthalpy, giving \(\Delta H > 0\).
(Choice D) is incorrect: the heat does not merely shuffle with no net effect — the reaction nets an absorption of heat, producing a definite positive \(\Delta H\).
(Choice C) is correct: absorbing heat from the surroundings (the cooling mixture) is endothermic, so \(\Delta H > 0\).

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: inferring the sign of \(\Delta H\) from the observed direction of heat flow rather than recalling a label.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'cold flask read as exothermic' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'absorbs heat but wrong sign' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'heat transfer means no net ΔH' FROM q;

-- Q4 [A4 · Thermodynamics: Systems & Free Energy] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'In solution, a fully denatured, unfolded polypeptide chain spontaneously collapses into its compact native globular structure. Considering only the polypeptide chain itself (not the surrounding water), what is the sign of its entropy change, and why?', '[{"label": "A", "text": "ΔS > 0, because folding is spontaneous and spontaneous processes must increase entropy."}, {"label": "B", "text": "ΔS > 0, because the folded state packs the atoms more densely together."}, {"label": "C", "text": "ΔS = 0, because the same atoms are present before and after folding."}, {"label": "D", "text": "ΔS < 0, because the chain goes from many possible conformations to a single ordered structure."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because the unfolded chain samples an enormous number of conformations (high disorder, many microstates), whereas the native fold is essentially one compact ordered arrangement; collapsing to that single structure lowers the chain''s disorder, so \(\Delta S < 0\).

(Choice A) is incorrect: spontaneity is governed by the entropy of the universe, not of the chain alone; folding can be spontaneous while the chain''s own entropy falls, offset by entropy released to the surrounding water.
(Choice D) is correct: moving from many accessible conformations to one ordered native structure decreases the number of microstates, giving \(\Delta S < 0\) for the chain.
(Choice B) is incorrect: denser packing describes volume, not the number of accessible microstates; a single, ordered conformation has lower entropy even though it is compact.
(Choice C) is incorrect: entropy reflects how configurations and energy are distributed, not the count of atoms (which is unchanged); the atoms are reorganized into far fewer arrangements.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: predicting the sign of \(\Delta S\) from the change in disorder and available microstates.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'spontaneous means system entropy rises' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'denser packing equals higher entropy' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'same atoms equals no entropy change' FROM q;

-- Q5 [A5 · Thermodynamics: Systems & Free Energy] medium skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'A reaction has ΔH = +55 kJ/mol and ΔS = +150 J/(mol·K). At T = 298 K, using ΔG = ΔH − TΔS, what is the free-energy change, and is the reaction spontaneous under these conditions?', '[{"label": "A", "text": "ΔG ≈ +10.3 kJ/mol, so the reaction is non-spontaneous."}, {"label": "B", "text": "ΔG ≈ −44,645 kJ/mol, so the reaction is spontaneous."}, {"label": "C", "text": "ΔG ≈ −10.3 kJ/mol, so the reaction is spontaneous."}, {"label": "D", "text": "ΔG ≈ +99.7 kJ/mol, so the reaction is non-spontaneous."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because \(\Delta G = \Delta H - T\Delta S\), but the entropy term must first be put in kJ: \(T\Delta S = (298\,\text{K})(150\,\text{J/mol·K}) = 44{,}700\,\text{J/mol} = 44.7\,\text{kJ/mol}\), so \(\Delta G = 55 - 44.7 = +10.3\) kJ/mol; a positive \(\Delta G\) means the reaction is non-spontaneous under these conditions.

(Choice A) is correct: with \(T\Delta S = 44.7\) kJ/mol, \(\Delta G = 55 - 44.7 = +10.3\) kJ/mol > 0, non-spontaneous.
(Choice B) is incorrect: −44,645 comes from subtracting 44,700 J directly from 55 kJ without converting the entropy term to kJ; mixing J and kJ inflates \(T\Delta S\) a thousand-fold.
(Choice C) is incorrect: −10.3 kJ/mol reverses the subtraction (computing \(T\Delta S - \Delta H\)); the equation is \(\Delta H - T\Delta S\), which is positive here.
(Choice D) is incorrect: +99.7 kJ/mol adds \(T\Delta S\) instead of subtracting it; the \(-T\Delta S\) term must be subtracted, so the magnitude is wrong even though it also happens to read ''non-spontaneous.''

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: applying the mathematical relationship \(\Delta G = \Delta H - T\Delta S\), carrying units correctly (J vs kJ), and interpreting the sign of the computed result.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'scale_unit_error', 'left ΔS in J against ΔH in kJ' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'computed TΔS minus ΔH' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'added TΔS instead of subtracting' FROM q;

-- Q6 [A6 · Thermodynamics: Systems & Free Energy] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'A reaction has a negative enthalpy change (ΔH < 0) and a negative entropy change (ΔS < 0). Using ΔG = ΔH − TΔS, at which temperatures will this reaction be spontaneous?', '[{"label": "A", "text": "At no temperature, because a negative ΔS by itself makes the reaction non-spontaneous."}, {"label": "B", "text": "Only at low temperatures, where the favorable ΔH term outweighs the unfavorable −TΔS term."}, {"label": "C", "text": "Only at high temperatures, where the −TΔS term becomes large and favorable."}, {"label": "D", "text": "At all temperatures, because a negative ΔH by itself makes ΔG negative."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because with \(\Delta H < 0\) and \(\Delta S < 0\), the term \(-T\Delta S\) is positive (unfavorable) and grows with temperature; at low T the favorable negative \(\Delta H\) dominates and \(\Delta G < 0\), but as T rises the positive \(-T\Delta S\) term overtakes it and \(\Delta G\) turns positive, so the reaction is spontaneous only at low temperatures. The crossover occurs at \(T = \Delta H/\Delta S\), which is positive; below it \(\Delta G < 0\) and above it \(\Delta G > 0\).

(Choice A) is incorrect: a negative \(\Delta S\) does not forbid spontaneity outright; paired with a favorable negative \(\Delta H\), the reaction is spontaneous as long as T is low enough.
(Choice C) is incorrect: high temperature favors reactions with \(\Delta S > 0\); here \(\Delta S < 0\), so raising T makes \(-T\Delta S\) more positive and drives \(\Delta G\) up, not down.
(Choice B) is correct: at low T the enthalpy term outweighs the unfavorable entropy term, giving \(\Delta G < 0\); the reaction is enthalpy-driven and spontaneous only at low temperatures.
(Choice D) is incorrect: a negative \(\Delta H\) does not guarantee \(\Delta G < 0\) at every temperature; the \(-T\Delta S\) term can dominate at high T and make \(\Delta G\) positive.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: reasoning through the temperature dependence of \(\Delta G\) from the signs of \(\Delta H\) and \(\Delta S\).', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'negative ΔS means never spontaneous' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'swaps low-T enthalpy-driven case for high-T entropy-driven case' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'negative ΔH means always spontaneous' FROM q;

-- Q7 [A7 · Thermodynamics: Systems & Free Energy] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'Under cellular conditions, the conversion of substrate X to product Y has a free-energy change of ΔG = −18 kJ/mol as written. What does this value indicate about the reaction?', '[{"label": "A", "text": "It is endergonic and requires an input of free energy to proceed forward."}, {"label": "B", "text": "It is at equilibrium, so there is no net conversion of substrate to product."}, {"label": "C", "text": "It is exergonic and proceeds spontaneously in the forward direction, releasing free energy."}, {"label": "D", "text": "It cannot proceed until it is coupled to an exergonic reaction to overcome the barrier."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because a negative free-energy change (\(\Delta G = -18\) kJ/mol) means the reaction releases free energy and proceeds spontaneously in the forward direction as written; such a reaction is termed exergonic.

(Choice A) is incorrect: endergonic reactions have \(\Delta G > 0\) and require an input of free energy; a negative \(\Delta G\) is the opposite situation.
(Choice C) is correct: \(\Delta G < 0\) marks an exergonic, spontaneous forward reaction that releases free energy.
(Choice B) is incorrect: \(\Delta G = 0\) defines equilibrium, but −18 kJ/mol is well away from zero, so there is a net forward drive.
(Choice D) is incorrect: a reaction that is already exergonic needs no coupling; coupling to an exergonic partner is what rescues an endergonic (positive-\(\Delta G\)) reaction, not this one.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: interpreting the sign of \(\Delta G\) to judge spontaneity and direction.', 'easy', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'negative ΔG read as needing energy' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'negative ΔG mistaken for equilibrium' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'spontaneous reaction still needs coupling' FROM q;

-- Q8 [A8 · Thermodynamics: Systems & Free Energy] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thermodynamics: Systems & Free Energy', 'A reversible enzymatic reaction in a test tube has reached equilibrium: the concentrations of substrate and product no longer change over time, although individual molecules continue to interconvert in both directions. What is the value of the actual free-energy change, ΔG, for the reaction at this point?', '[{"label": "A", "text": "ΔG = ΔG°, because equilibrium is by definition a standard-state condition."}, {"label": "B", "text": "ΔG < 0, because molecules are still interconverting and thus still releasing free energy."}, {"label": "C", "text": "ΔG > 0, because free energy must be supplied to keep the system at equilibrium."}, {"label": "D", "text": "ΔG = 0, because the forward and reverse rates balance, leaving no net free-energy change."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because at equilibrium the forward and reverse reactions proceed at equal rates, so there is no net conversion and no net change in free energy. Formally, \(\Delta G = \Delta G^\circ + RT\ln Q\) and \(\Delta G^\circ = -RT\ln K\), so \(\Delta G = RT\ln(Q/K)\); at equilibrium \(Q = K\), giving \(\ln(Q/K) = \ln 1 = 0\) and therefore the actual \(\Delta G\) (not \(\Delta G^\circ\)) equals zero.

(Choice D) is correct: balanced forward and reverse flux means zero net free-energy change, so \(\Delta G = 0\).
(Choice A) is incorrect: \(\Delta G^\circ\) is the free-energy change at standard conditions (1 M, 25 °C) and is generally nonzero (\(\Delta G^\circ = -RT\ln K\)); equilibrium is not standard state, and it is the actual \(\Delta G\), not \(\Delta G^\circ\), that becomes zero.
(Choice B) is incorrect: individual molecules still interconvert at equilibrium, but the forward and reverse fluxes cancel, so there is no NET release of free energy and \(\Delta G\) is zero, not negative.
(Choice C) is incorrect: equilibrium is a resting, minimum-free-energy state that requires no energy input to maintain; \(\Delta G > 0\) would describe a non-spontaneous forward reaction, not a system at equilibrium.

This item rewards Skill 2, Scientific Reasoning and Problem-Solving: distinguishing the actual \(\Delta G\) at equilibrium from \(\Delta G^\circ\) and from ongoing microscopic interconversion.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'conflates ΔG with ΔG standard' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'microscopic interconversion read as net negative ΔG' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'equilibrium requires energy input' FROM q;

-- Q9 [B9 · Free Energy & Equilibrium] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'Glucose is thermodynamically unstable toward complete oxidation: for \(\text{C}_6\text{H}_{12}\text{O}_6 + 6\,\text{O}_2 \rightarrow 6\,\text{CO}_2 + 6\,\text{H}_2\text{O}\), \(\Delta G \approx -2870\) kJ/mol, so the reaction is strongly exergonic. Yet a sterile flask of glucose dissolved in oxygenated buffer at 37 °C shows no detectable oxidation even after several months. Which principle best accounts for the fact that a reaction with such a large negative \(\Delta G\) can still proceed at a negligible rate?', '[{"label": "A", "text": "\\(\\Delta G\\) tells you only whether the reaction is favorable and how much energy it can release—not how fast it goes; the rate is instead set by the activation-energy barrier, which here is high enough to keep the oxidation immeasurably slow without a catalyst."}, {"label": "B", "text": "The absence of any detectable reaction shows the process is not truly spontaneous under these conditions; a genuinely negative \\(\\Delta G\\) would drive the mixture essentially to completion the instant the reactants were combined."}, {"label": "C", "text": "The rate of an exergonic reaction is fixed by the magnitude of its \\(\\Delta G\\): the more negative \\(\\Delta G\\) becomes, the lower its activation barrier must be, so a reaction as exergonic as \\(-2870\\) kJ/mol cannot possibly be slow, and the reported observation must reflect an experimental error."}, {"label": "D", "text": "The reaction is slow because its reactants must first climb an energy barrier equal in size to \\(\\Delta G\\); since \\(\\Delta G\\) here is very large in magnitude, that barrier is enormous, so a large \\(\\Delta G\\) always makes a reaction slow."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because thermodynamics and kinetics are independent. A large negative \(\Delta G\) tells you the reaction is exergonic—energetically favorable and capable of releasing free energy—and it fixes the position of equilibrium, but it says nothing about how quickly the reaction reaches that equilibrium. The rate is governed by the height of the activation-energy barrier (\(E_a\)) that separates reactants from the transition state. Glucose is thermodynamically unstable toward oxidation yet kinetically stable: its activation barrier is so high that at 37 °C essentially no molecules carry enough energy to cross it, so the oxidation crawls until a catalyst (in cells, an enzyme) lowers \(E_a\) and speeds the reaction up without changing \(\Delta G\).

(Choice A) is correct: \(\Delta G\) sets favorability and the energy available, but not the rate; the slow oxidation reflects a high activation barrier that a catalyst can lower without altering \(\Delta G\).

(Choice B) is incorrect: ''spontaneous'' is a thermodynamic label meaning \(\Delta G < 0\), not a claim about speed. A reaction can be spontaneous yet immeasurably slow, so the lack of detectable oxidation does not make \(\Delta G\) positive or the process non-spontaneous.

(Choice C) is incorrect: the magnitude of \(\Delta G\) does not determine the rate. \(\Delta G\) and \(E_a\) are independent quantities, so a strongly negative \(\Delta G\) does not force a low activation barrier or guarantee a fast reaction.

(Choice D) is incorrect: it confuses the activation energy with \(\Delta G\). The barrier the molecules must surmount is \(E_a\), measured from the reactants up to the transition state, not \(\Delta G\), which is only the reactant-to-product energy difference; a large \(|\Delta G|\) does not by itself imply a large \(E_a\).

This item is Skill 2: it requires distinguishing thermodynamic spontaneity (governed by \(\Delta G\)) from reaction rate (governed by activation energy) and reasoning about why an energetically favorable reaction can still be slow.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'thermodynamic spontaneity (negative ΔG) conflated with rate; a favorable reaction assumed to go instantly to completion' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'ΔG magnitude wrongly coupled to activation energy, so a more negative ΔG is taken to guarantee a lower barrier and a faster reaction' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'activation energy (Ea) conflated with ΔG; the reaction''s ΔG treated as the kinetic barrier molecules must climb' FROM q;

-- Q10 [B10 · Free Energy & Equilibrium] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'For the reaction A → B, \(\Delta G^{\circ\prime} = +7.5\) kJ/mol. Inside a cell, [A] = 1.0 M and [B] = 0.010 M. Using \(\Delta G = \Delta G^{\circ\prime} + RT\ln Q\) with R = 8.314 J/(mol·K), T = 298 K, and \(\ln(0.010) = -4.6\), what is the actual \(\Delta G\) for the reaction in the cell?', '[{"label": "A", "text": "+7.5 kJ/mol"}, {"label": "B", "text": "−3.9 kJ/mol"}, {"label": "C", "text": "+18.9 kJ/mol"}, {"label": "D", "text": "−11.4 kJ/mol"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because the operative free energy is \(\Delta G = \Delta G^{\circ\prime} + RT\ln Q\). Here Q = [B]/[A] = 0.010/1.0 = 0.010, so \(RT\ln Q = (8.314\,\text{J/mol·K})(298\,\text{K})(-4.6) \approx -11{,}400\ \text{J/mol} = -11.4\ \text{kJ/mol}\) (convert J → kJ before combining), giving \(\Delta G = +7.5 + (-11.4) = -3.9\) kJ/mol — negative, so the reaction runs forward in the cell despite the positive \(\Delta G^{\circ\prime}\), because the product is held far below 1 M.

(Choice A) is incorrect: +7.5 kJ/mol is \(\Delta G^{\circ\prime}\) itself and ignores the \(RT\ln Q\) correction supplied by the low product concentration.

(Choice C) is incorrect: +18.9 kJ/mol adds the magnitude of the \(RT\ln Q\) term to \(\Delta G^{\circ\prime}\) (7.5 + 11.4), giving that term the wrong sign; because Q < 1, its logarithm is negative.

(Choice D) is incorrect: −11.4 kJ/mol is only the \(RT\ln Q\) term and omits the +7.5 kJ/mol standard contribution.

(Choice B) is correct: combining the standard term (+7.5 kJ/mol) with the concentration term (−11.4 kJ/mol) yields −3.9 kJ/mol, a spontaneous forward process.

This item is Skill 4: you must compute Q from the given concentrations, evaluate \(RT\ln Q\), and combine it with \(\Delta G^{\circ\prime}\) to obtain the actual \(\Delta G\).', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'reports ΔG° as the actual ΔG' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'added RT ln Q term with wrong sign' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'used only the RT ln Q term, dropped ΔG°' FROM q;

-- Q11 [B11 · Free Energy & Equilibrium] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'A biochemical reaction has \(\Delta G^{\circ\prime} = -5.7\) kJ/mol at 298 K. Using \(\Delta G^{\circ\prime} = -RT\ln K\) with R = 8.314 J/(mol·K) (and noting that \(e^{2.3} \approx 10\)), what is the approximate value of the equilibrium constant K?', '[{"label": "A", "text": "K ≈ 0.1"}, {"label": "B", "text": "K ≈ 1"}, {"label": "C", "text": "K ≈ 10"}, {"label": "D", "text": "K ≈ 200"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because \(\Delta G^{\circ\prime} = -RT\ln K\) rearranges to \(\ln K = -\Delta G^{\circ\prime}/RT\). In joules, \(\ln K = -(-5700)/[(8.314)(298)] = 5700/2478 \approx 2.30\), so \(K = e^{2.30} \approx 10\). A negative \(\Delta G^{\circ\prime}\) must correspond to K > 1 (products favored).

(Choice C) is correct: \(\ln K \approx 2.3\) gives \(K = e^{2.3} \approx 10\), consistent with a product-favored reaction (\(\Delta G^{\circ\prime} < 0\)).

(Choice A) is incorrect: K ≈ 0.1 comes from a sign error — dropping the negative in \(\Delta G^{\circ\prime} = -RT\ln K\) gives \(\ln K = -2.3\); but a negative \(\Delta G^{\circ\prime}\) requires K > 1, not < 1.

(Choice B) is incorrect: K ≈ 1 results from leaving \(\Delta G^{\circ\prime}\) in kJ while R is in J (5.7/2478 ≈ 0.0023), collapsing \(\ln K\) to nearly zero; the units must match.

(Choice D) is incorrect: K ≈ 200 uses base-10 (\(10^{2.3}\)) instead of the natural log; because the equation contains \(\ln\), you exponentiate with e, giving ≈ 10.

This item is Skill 4: you must rearrange \(\Delta G^{\circ\prime} = -RT\ln K\), keep units consistent, and exponentiate correctly to extract K.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'sign flip in ΔG° = −RT ln K' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'kJ not converted to J → ln K ≈ 0' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'exponentiated base-10 instead of natural log' FROM q;

-- Q12 [B12 · Free Energy & Equilibrium] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'For the reversible reaction X ⇌ Y, \(K_{eq} = 5.0\). At a given instant a cell sample contains the two species at a ratio [Y]/[X] = 20. Based on how the reaction quotient Q compares with \(K_{eq}\), which direction does the net reaction proceed, and what is the sign of \(\Delta G\) for the forward reaction (X → Y)?', '[{"label": "A", "text": "Net reaction runs forward (X → Y); \\(\\Delta G_{forward}\\) is negative."}, {"label": "B", "text": "The system is at equilibrium; \\(\\Delta G_{forward} = 0\\)."}, {"label": "C", "text": "Net reaction runs forward (X → Y); \\(\\Delta G_{forward}\\) is positive."}, {"label": "D", "text": "Net reaction runs in reverse (Y → X); \\(\\Delta G_{forward}\\) is positive."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because the reaction quotient for the forward reaction is Q = [Y]/[X] = 20, which exceeds \(K_{eq} = 5.0\). Equivalently, \(\Delta G = \Delta G^\circ + RT\ln Q = -RT\ln K + RT\ln Q = RT\ln(Q/K) = RT\ln(20/5) = RT\ln 4 > 0\) (about +3.4 kJ/mol at 298 K). When Q > K there is too much product relative to equilibrium, so the net reaction runs in reverse (Y → X) and \(\Delta G\) for the forward reaction is positive; only as Q falls back toward K does \(\Delta G\) approach zero.

(Choice A) is incorrect: forward flow with \(\Delta G < 0\) is the Q < K case; here Q (20) is above K (5), so this reverses the actual situation.

(Choice B) is incorrect: equilibrium with \(\Delta G = 0\) requires Q = K, but Q (20) ≠ K (5), so there is a net direction.

(Choice D) is correct: Q (20) > K (5), so \(RT\ln(Q/K) > 0\); the forward \(\Delta G\) is positive and the reaction proceeds in reverse.

(Choice C) is incorrect: it pairs a positive forward \(\Delta G\) (right sign) with a forward net direction (wrong); a positive forward \(\Delta G\) means the forward reaction is non-spontaneous, so the net flow is reverse.

This item is Skill 2: it asks you to compare Q with K and reason out both the direction of the net reaction and the sign of \(\Delta G\).', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'applied the Q < K result (forward, ΔG < 0)' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'assumed the system is at equilibrium (Q = K)' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'correct sign of ΔG paired with wrong net direction' FROM q;

-- Q13 [B13 · Free Energy & Equilibrium] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'In actively respiring cells, the malate → oxaloacetate step (catalyzed by malate dehydrogenase) has \(\Delta G^{\circ\prime} = +29.7\) kJ/mol, yet it proceeds in the forward direction as part of the citric acid cycle. Which statement best explains how a reaction with a large positive \(\Delta G^{\circ\prime}\) runs forward in vivo?', '[{"label": "A", "text": "Oxaloacetate is continually removed by the next enzyme (citrate synthase), holding Q below K so that the actual \\(\\Delta G\\) becomes negative even though \\(\\Delta G^{\\circ\\prime}\\) is positive."}, {"label": "B", "text": "Malate dehydrogenase lowers the reaction''s \\(\\Delta G^{\\circ\\prime}\\) to a negative value, making it spontaneous."}, {"label": "C", "text": "Because \\(\\Delta G^{\\circ\\prime}\\) is fixed at +29.7 kJ/mol, the reaction can only proceed in reverse; the apparent forward flow is an artifact."}, {"label": "D", "text": "A reaction with positive \\(\\Delta G^{\\circ\\prime}\\) can proceed forward only if it is directly coupled to ATP hydrolysis; no other mechanism allows it."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because \(\Delta G^{\circ\prime}\) is fixed but the actual \(\Delta G = \Delta G^{\circ\prime} + RT\ln Q\) depends on concentrations. Citrate synthase continually consumes oxaloacetate, holding its concentration very low; this keeps Q below K, makes \(RT\ln Q\) strongly negative, and drives the actual \(\Delta G\) below zero even though \(\Delta G^{\circ\prime} = +29.7\) kJ/mol.

(Choice A) is correct: continuous removal of product lowers Q, so the concentration-dependent \(\Delta G\) becomes negative while \(\Delta G^{\circ\prime}\) stays positive.

(Choice B) is incorrect: enzymes accelerate a reaction by lowering its activation barrier; they do not change \(\Delta G^{\circ\prime}\) or the position of equilibrium.

(Choice C) is incorrect: \(\Delta G^{\circ\prime}\) being fixed and positive does not force the reaction backward — the actual \(\Delta G\), not \(\Delta G^{\circ\prime}\), sets the in-vivo direction, and it can be negative when Q is low.

(Choice D) is incorrect: coupling to ATP hydrolysis is one way to drive an endergonic step, but it is not the only way; keeping product concentrations low (as here) is enough to make the actual \(\Delta G\) negative.

This item is Skill 2: it requires distinguishing the fixed standard free energy from the concentration-dependent actual free energy and reasoning about how product removal changes spontaneity.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'enzyme changes ΔG°/equilibrium' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'fixed positive ΔG° forces reverse direction' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'ATP coupling treated as the only route' FROM q;

-- Q14 [B14 · Free Energy & Equilibrium] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'Hexokinase phosphorylates glucose using ATP. On its own, glucose + Pi → glucose-6-phosphate + H₂O has \(\Delta G^{\circ\prime} = +13.8\) kJ/mol, while ATP + H₂O → ADP + Pi has \(\Delta G^{\circ\prime} = -30.5\) kJ/mol. If the two are coupled through a shared phosphoryl intermediate to give glucose + ATP → glucose-6-phosphate + ADP, what is \(\Delta G^{\circ\prime}\) for the coupled reaction, and is it favorable?', '[{"label": "A", "text": "+44.3 kJ/mol; not favorable"}, {"label": "B", "text": "−16.7 kJ/mol; favorable"}, {"label": "C", "text": "−30.5 kJ/mol; favorable"}, {"label": "D", "text": "+13.8 kJ/mol; not favorable"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because coupled reactions that share a common intermediate have additive standard free energies. Summing the endergonic phosphorylation (+13.8 kJ/mol) with ATP hydrolysis (−30.5 kJ/mol) gives \(\Delta G^{\circ\prime}_{net} = +13.8 + (-30.5) = -16.7\) kJ/mol, so the coupled reaction (glucose + ATP → glucose-6-phosphate + ADP) is favorable.

(Choice A) is incorrect: +44.3 kJ/mol adds the two magnitudes (13.8 + 30.5) as if both were positive; ATP hydrolysis is exergonic, so its value carries a negative sign and is added as −30.5.

(Choice B) is correct: +13.8 and −30.5 sum to −16.7 kJ/mol, so coupling to ATP hydrolysis makes the overall process exergonic.

(Choice C) is incorrect: −30.5 kJ/mol counts only ATP hydrolysis and omits the +13.8 kJ/mol needed to phosphorylate glucose.

(Choice D) is incorrect: +13.8 kJ/mol is the uncoupled phosphorylation step alone; the point of coupling is that adding ATP hydrolysis flips the sign of the net \(\Delta G^{\circ\prime}\).

This item is Skill 4: you must add the two standard free-energy values and interpret the sign of the sum to judge whether the coupled reaction is favorable.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'summed magnitudes with wrong sign' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'counted only ATP hydrolysis' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'evaluated the uncoupled endergonic step' FROM q;

-- Q15 [B15 · Free Energy & Equilibrium] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Free Energy & Equilibrium', 'A metabolic reaction has an equilibrium constant \(K = 1.0 \times 10^{3}\) at 298 K. Using \(\Delta G^{\circ\prime} = -RT\ln K\) with \(R = 8.314\) J/(mol·K), what is the standard free-energy change for the reaction, and is it spontaneous in the forward direction under standard-state conditions?', '[{"label": "A", "text": "+17 kJ/mol; non-spontaneous"}, {"label": "B", "text": "−7.4 kJ/mol; spontaneous"}, {"label": "C", "text": "−17 kJ/mol; spontaneous"}, {"label": "D", "text": "−17 kJ/mol; non-spontaneous"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because \(\Delta G^{\circ\prime} = -RT\ln K\). With R = 8.314 J/(mol·K), T = 298 K, and K = 1.0 × 10³, ln K = ln(10³) = 2.303 × 3 ≈ 6.91, so \(\Delta G^{\circ\prime} = -(8.314)(298)(6.91) \approx -17{,}100\) J/mol ≈ −17 kJ/mol. Because K > 1, ln K is positive and \(\Delta G^{\circ\prime}\) comes out negative, so the reaction is spontaneous (exergonic) in the forward direction under standard-state conditions.

(Choice A) is incorrect: +17 kJ/mol drops the negative sign in \(-RT\ln K\). Since K > 1 makes ln K positive, \(-RT\ln K\) must be negative; a positive \(\Delta G^{\circ\prime}\) would instead require K < 1.

(Choice B) is incorrect: −7.4 kJ/mol comes from using the base-10 logarithm in place of the natural log, i.e. \(-RT\log_{10}K = -(8.314)(298)(3) \approx -7.4\) kJ/mol, and forgetting that \(\ln K = 2.303\log_{10}K\). The sign is still negative (spontaneous), but the magnitude is too small by the factor 2.303; the correct natural-log term uses ln K = 6.91 (not 3) and gives −17 kJ/mol.

(Choice C) is correct: \(-RT\ln K = -(8.314)(298)(6.91) \approx -17\) kJ/mol, a negative \(\Delta G^{\circ\prime}\) and therefore spontaneous in the forward direction.

(Choice D) is incorrect: −17 kJ/mol is the right value, but a negative \(\Delta G^{\circ\prime}\) is spontaneous, not non-spontaneous — this reverses the \(\Delta G\)–spontaneity rule.

This item is Skill 4: you must apply \(\Delta G^{\circ\prime} = -RT\ln K\) with the correct natural-log conversion and connect the sign of the result to spontaneity.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'dropped the negative sign in −RT ln K' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'used log₁₀ K = 3 instead of ln K = 6.91 (omitted the 2.303 conversion factor), yielding −7.4 instead of −17 kJ/mol' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correct value, negative ΔG°′ mislabeled non-spontaneous' FROM q;

-- Q16 [C16 · ATP & High-Energy Carriers] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'A student claims that ATP powers cellular work because its terminal phosphoanhydride bond "physically stores" a large packet of energy that is released only when that specific bond breaks — as if the bond itself were a compressed spring. Their instructor responds that this is a misconception: bond breaking always REQUIRES energy, and the large negative \(\Delta G^{\circ\prime}\) of ATP hydrolysis actually comes from properties of the products relative to the reactants. Which observation BEST supports the instructor''s corrected explanation for why ATP hydrolysis is strongly exergonic?', '[{"label": "A", "text": "The terminal phosphoanhydride bond holds an unusually large packet of stored energy that is liberated fully intact at the very instant the bond is cleaved, independent of the products."}, {"label": "B", "text": "Water is such a high-energy reactant that adding it to essentially any phosphate ester automatically makes the resulting hydrolysis strongly exergonic, no matter how stable the products are."}, {"label": "C", "text": "Cleaving the terminal phosphorus–oxygen bond is itself an exergonic, energy-releasing step, and that release upon bond breaking is precisely what makes the overall hydrolysis favorable."}, {"label": "D", "text": "The separated ADP and \\(P_i\\) products experience less mutual electrostatic repulsion than intact ATP did, and the freed \\(P_i\\) gains additional resonance stabilization and more extensive solvation."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because the large negative \(\Delta G^{\circ\prime}\) of ATP hydrolysis is a PRODUCT-side effect, not energy hidden in a special bond. At physiological pH, ATP carries several closely spaced negative charges that repel one another; splitting off \(P_i\) relieves that charge repulsion. In addition, the freed inorganic phosphate is stabilized by resonance across its several equivalent oxygens and is more extensively solvated (hydrated) than it was as part of ATP. These three product-favoring factors — charge-repulsion relief, resonance stabilization of \(P_i\), and greater solvation of the products — make the products lower in free energy than the reactants, which is what makes hydrolysis exergonic.

(Choice D) is correct: it names the actual product-stabilizing factors (relief of electrostatic repulsion, resonance stabilization of \(P_i\), and enhanced solvation) that lower the free energy of ADP + \(P_i\) relative to ATP.

(Choice A) is incorrect: it restates the very misconception the instructor is correcting — that a bond is a container of energy released "intact." Bond breaking always costs energy; the favorability comes from what the products look like afterward, not from a spring-loaded bond.

(Choice B) is incorrect: water is not an unusually high-energy reactant, and hydrolysis is not automatically exergonic for every phosphate compound (for example, hydrolyzing glucose-6-phosphate is far less exergonic, about -13.8 kJ/mol versus -30.5 kJ/mol for ATP). The magnitude depends on how much more stable the specific products are.

(Choice C) is incorrect: cleaving a bond is endergonic (it requires input of energy); no bond-breaking step is itself energy-releasing. The overall reaction is exergonic only because new bonds form and the products are strongly stabilized.

This item rewards Skill 2 reasoning: applying the thermodynamic principle that \(\Delta G\) is set by the free-energy difference between products and reactants, so the source of ATP''s "high-energy" character must be located in product stabilization rather than in a mythical energy-rich bond.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'bond-as-energy-container' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'water-is-high-energy' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'bond-breaking-releases-energy' FROM q;

-- Q17 [C17 · ATP & High-Energy Carriers] easy skill1 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'An intact ATP molecule consists of adenosine (adenine joined to ribose) attached to a chain of three phosphate groups in series. In an experiment, an enzyme sequentially removes phosphate groups from a pool of ATP: first it cleaves off one phosphate from each molecule, and then, in a second step, it removes one additional phosphate from those same molecules. After BOTH steps are complete, which nucleotide predominates in the pool?', '[{"label": "A", "text": "AMP (adenosine monophosphate), because two phosphates have been removed, leaving adenosine bound to a single phosphate."}, {"label": "B", "text": "ADP (adenosine diphosphate), because removing phosphates from ATP can never go further than the diphosphate stage."}, {"label": "C", "text": "Adenosine with no phosphates, because two removal steps strip all three phosphate groups at once."}, {"label": "D", "text": "ATP is regenerated, because the second removal step reattaches a phosphate to restore the triphosphate."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because ATP starts with three phosphates on adenosine. The first step removes one phosphate, giving ADP (two phosphates). The second step removes one more phosphate, giving AMP (one phosphate) — adenosine bearing a single monophosphate. Tracking the count from three down by one, then by one again, lands on a monophosphate.

(Choice A) is correct: three minus one is two (ADP), and two minus one is one (AMP), so a single phosphate remains on adenosine.

(Choice B) is incorrect: nothing prevents a second phosphate from being removed. ADP is only the intermediate after the first removal; the second step continues to AMP.

(Choice C) is incorrect: only two phosphates are removed across the two steps (one each), not all three. Adenosine would carry zero phosphates only if a third removal occurred.

(Choice D) is incorrect: the second step removes a phosphate; it does not add one. Rebuilding ATP would require an energy-coupled phosphorylation, not a removal step.

This item rewards Skill 1 reasoning: identifying the ATP → ADP → AMP naming series and reasoning from a described removal of phosphate groups to the correct product rather than recalling a definition.', 'easy', '1D', 'Principles of Bioenergetics', 'biochemistry', 1, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'stops-at-first-step' FROM q
  UNION ALL
  SELECT id, 'C', 'scale_unit_error', 'miscount-phosphates-removed' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'removal-mistaken-for-addition' FROM q;

-- Q18 [C18 · ATP & High-Energy Carriers] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'Consider the following phosphoryl-transfer potential ranking (most exergonic phosphate hydrolysis at the top): phosphoenolpyruvate (PEP) and creatine phosphate rank ABOVE ATP; ATP is intermediate; glucose-6-phosphate ranks BELOW ATP. A student argues that because ATP is only a mid-level phosphate donor, an even higher-potential carrier such as PEP would be a superior "universal energy currency" for the cell. Which analysis BEST explains why ATP''s INTERMEDIATE position — not the top position — is exactly what makes it the cell''s universal energy intermediary?', '[{"label": "A", "text": "ATP sits at the top of the ranking, so it can donate a phosphate to any acceptor while never needing to be recharged by another molecule."}, {"label": "B", "text": "Because ATP is intermediate, higher-ranked donors like PEP can spontaneously re-form it, and ATP can spontaneously phosphorylate lower-ranked acceptors like glucose — a two-way relay."}, {"label": "C", "text": "Because PEP has the highest transfer potential, it can neither accept nor donate phosphate under cellular conditions, which is why the cell must fall back on ATP."}, {"label": "D", "text": "ATP''s phosphoanhydride bonds hold more total energy than any other phosphate compound in the cell, so all transfers must flow outward from ATP only."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because a phosphate group flows spontaneously (exergonically) from a higher-transfer-potential compound to a lower-potential one. Since ATP sits in the MIDDLE of the ranking, higher-potential donors such as PEP or creatine phosphate can spontaneously hand their phosphate to ADP, regenerating ATP; and ATP, in turn, sits above acceptors like glucose, so ATP can spontaneously donate its phosphate to form glucose-6-phosphate. Being intermediate is precisely what lets ATP work both directions — receiving from the high end and delivering to the low end — which is the defining behavior of a universal intermediary.

(Choice B) is correct: it captures the two-way relay role that follows directly from ATP occupying a position below the top donors and above the bottom acceptors.

(Choice A) is incorrect: ATP is explicitly intermediate, not at the top. A top-ranked carrier could donate but could not be easily recharged by transfer from anything higher, which would make it a poor renewable currency.

(Choice C) is incorrect: PEP''s high potential does not freeze it — PEP readily DONATES its phosphate (that is what a high potential means). The claim that PEP cannot participate reverses the meaning of the ranking.

(Choice D) is incorrect: ATP is not the highest-energy phosphate in the ranking (PEP and creatine phosphate are above it), and the value of ATP is its intermediacy, not maximal stored energy. This restates the very misconception the stem sets out to overturn.

This item rewards Skill 2 reasoning: applying the rule that phosphate flows down a transfer-potential gradient to deduce why a mid-ranked carrier can both accept and donate, and is therefore the ideal universal intermediary.', 'hard', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'atp-is-highest-potential' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'high-potential-cannot-donate' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'atp-stores-most-energy' FROM q;

-- Q19 [C19 · ATP & High-Energy Carriers] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'When glucose enters a cell, hexokinase transfers a phosphate from ATP onto glucose, producing glucose-6-phosphate, a charged (negatively ionized) molecule. Cells rely on this immediate phosphorylation for two purposes at once. Which pair of consequences BEST explains WHY phosphorylating glucose the moment it arrives is metabolically advantageous?', '[{"label": "A", "text": "The phosphate makes glucose-6-phosphate small and uncharged so it diffuses freely across the membrane, letting the cell fine-tune how much glucose it retains."}, {"label": "B", "text": "Phosphorylation lowers the intracellular glucose concentration, which reverses the direction of glucose transport so that stored glucose is pumped back out into the blood."}, {"label": "C", "text": "The added negative charge stops glucose-6-phosphate from crossing the nonpolar membrane back out, trapping it inside, and also primes it as an activated substrate for the next step of metabolism."}, {"label": "D", "text": "Adding a phosphate makes glucose chemically inert and metabolically unreactive, protecting it as a long-term storage form until the cell needs energy."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is C because attaching a phosphate does two useful things simultaneously. First, the phosphate adds negative charge, and charged molecules cannot slip back across the nonpolar lipid membrane, so glucose-6-phosphate is TRAPPED inside the cell. Second, converting free glucose into a phosphorylated species raises its free energy and gives downstream enzymes a handle — it is an ACTIVATED intermediate primed to enter the next steps of metabolism (such as glycolysis). Trapping plus activation is exactly why cells phosphorylate glucose immediately on entry.

(Choice C) is correct: it names both effects — membrane trapping via added charge and priming/activation for further metabolism.

(Choice A) is incorrect: phosphorylation ADDS charge and does not shrink the molecule; a charged glucose-6-phosphate does the opposite of diffusing freely — it is retained precisely because it cannot cross the membrane.

(Choice B) is incorrect: keeping intracellular free glucose low actually favors continued glucose UPTAKE (maintaining the inward gradient), not export. This reverses the transport logic.

(Choice D) is incorrect: phosphorylation activates glucose for metabolism rather than rendering it inert. Glucose-6-phosphate is a reactive branch-point intermediate, not a metabolically dead storage form (that role belongs to glycogen).

This item rewards Skill 2 reasoning: applying the principles of membrane permeability and metabolic activation to explain why phosphoryl transfer both retains a substrate and prepares it for downstream reactions.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'charged-diffuses-freely' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'trapping-reverses-uptake' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'phosphorylation-makes-inert' FROM q;

-- Q20 [C20 · ATP & High-Energy Carriers] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'A sprinter''s leg muscle exhausts its small ATP supply within a couple of seconds of maximal effort, yet contraction continues for several more seconds before other pathways ramp up. Muscle maintains a reservoir of creatine phosphate, which sits ABOVE ATP in phosphoryl-transfer potential, and the enzyme creatine kinase catalyzes phosphate exchange between creatine phosphate and ADP. Which description BEST explains how this system sustains ATP during the initial burst and what happens to it afterward?', '[{"label": "A", "text": "During the burst, creatine phosphate is hydrolyzed directly to drive contraction rather than regenerating ATP; afterward the store is rebuilt straight from creatine and inorganic phosphate."}, {"label": "B", "text": "During the burst, ATP donates its phosphate to creatine because creatine phosphate has the lower transfer potential; this drains ATP faster, and the store fills only after ATP is exhausted."}, {"label": "C", "text": "During the burst, creatine phosphate takes over as the muscle''s permanent energy currency in place of ATP, so ATP is not resynthesized until glycolysis eventually restores it."}, {"label": "D", "text": "During the burst, creatine phosphate spontaneously donates its phosphate to ADP to regenerate ATP; when effort ends and ATP is plentiful, the reaction reverses to rebuild the creatine phosphate store."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is D because creatine phosphate ranks ABOVE ATP in phosphoryl-transfer potential, so a phosphate flows spontaneously (exergonically) from creatine phosphate onto ADP, regenerating ATP as fast as the muscle consumes it — a short-term ATP buffer that carries the muscle through the first few seconds before slower pathways (glycolysis, oxidative phosphorylation) engage. Creatine kinase catalyzes this exchange. When exertion stops and ATP is abundant again, the high [ATP]/[ADP] ratio (a very low reaction quotient Q for the forward direction) makes ΔG for the reverse reaction negative, driving it backward to re-form the creatine phosphate store for the next burst.

(Choice D) is correct: it captures both directions — rapid ATP regeneration during the burst (phosphate flowing from the higher-potential creatine phosphate to ADP) and store replenishment afterward when ATP is plentiful.

(Choice A) is incorrect: creatine phosphate does not directly power contraction — the contractile machinery hydrolyzes ATP, and creatine phosphate works by regenerating that ATP. Nor is the store rebuilt ''straight from creatine and Pi''; resynthesis runs the creatine kinase reaction backward using ATP.

(Choice B) is incorrect: it inverts the ranking. Creatine phosphate is HIGHER, not lower, than ATP in transfer potential, so phosphate flows from creatine phosphate TO ADP, not the reverse; the store is also rebuilt when ATP is plentiful, not after ATP is exhausted.

(Choice C) is incorrect: ATP, not creatine phosphate, remains the energy currency; creatine phosphate is a temporary reservoir that keeps ATP topped up, and ATP is continuously regenerated throughout the burst rather than left unreplenished until glycolysis.

This item rewards Skill 2 reasoning: applying the transfer-potential gradient and the concentration dependence (ΔG = ΔG° + RT ln Q) of a reversible reaction to explain how a high-potential store buffers ATP during demand and recharges during rest.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'direct-fuel-not-atp-buffer' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'inverted-transfer-potential' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'creatine-phosphate-as-currency' FROM q;

-- Q21 [C21 · ATP & High-Energy Carriers] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'An endergonic reaction, X → Y (\(\Delta G^{\circ\prime} = +15\) kJ/mol), is to be driven by the exergonic hydrolysis of ATP (\(\Delta G^{\circ\prime} = -30.5\) kJ/mol). A student proposes that simply placing ATP hydrolysis and the X → Y reaction in the SAME test tube, so both occur in one compartment, will make X → Y proceed. In fact, merely co-locating two reactions does not couple them. Which explanation BEST states what actually allows the favorable ATP hydrolysis to drive the unfavorable reaction?', '[{"label": "A", "text": "The two reactions must share a common chemical intermediate — for instance, ATP transfers its phosphate to X, forming a phosphorylated species that then reacts onward — so the linked pathway carries a single, net-negative \\(\\Delta G\\)."}, {"label": "B", "text": "As long as ATP hydrolysis releases more free energy than X → Y requires, the two reactions in the same solution will automatically sum to a negative \\(\\Delta G\\) without any physical link between them."}, {"label": "C", "text": "Coupling requires only that both reactions occur at the same temperature and pressure, which equalizes their free-energy changes and forces X → Y forward."}, {"label": "D", "text": "The heat released by exergonic ATP hydrolysis warms the surrounding solution, and that added thermal energy is what pushes the endergonic reaction over its barrier."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is A because free energy is not transmitted between two reactions just because they share a beaker. For the \(-30.5\) kJ/mol of ATP hydrolysis to actually drive the \(+15\) kJ/mol conversion, the reactions must be mechanistically connected through a SHARED INTERMEDIATE (or a common enzyme/active site). Typically ATP transfers its phosphate onto one of the reactants, creating a phosphorylated intermediate that carries the energy forward; the connected sequence then has a single summed \(\Delta G\) (about \(-15.5\) kJ/mol here), which is negative and therefore spontaneous.

(Choice A) is correct: it identifies the shared/phosphorylated intermediate as the physical linkage that lets one reaction''s favorability be transmitted to the other, yielding a net-negative pathway.

(Choice B) is incorrect: two thermodynamically favorable-on-paper numbers do not add unless the reactions are actually coupled. Without a shared intermediate, ATP hydrolysis simply proceeds on its own and X → Y stays unfavorable — the \(\Delta G\) values do not spontaneously combine.

(Choice C) is incorrect: shared temperature and pressure do not couple reactions and do not equalize free-energy changes; each reaction retains its own \(\Delta G\). Constant T and P are just the conditions under which \(\Delta G\) predicts spontaneity, not a coupling mechanism.

(Choice D) is incorrect: coupling is not a thermal effect. The heat from ATP hydrolysis is not what drives the endergonic reaction; energy is transmitted chemically through the shared intermediate, not by warming the solvent.

This item rewards Skill 2 reasoning: applying the additivity of \(\Delta G\) along a linked reaction pathway to recognize that thermodynamic coupling requires a shared chemical intermediate, not mere spatial proximity.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'proximity-auto-couples' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'same-conditions-equalize-dg' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'coupling-is-heat-transfer' FROM q;

-- Q22 [C22 · ATP & High-Energy Carriers] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'ATP & High-Energy Carriers', 'NADH and NADPH differ by only a single phosphate group and carry out nearly identical redox chemistry (each donates a hydride/electrons). Yet a cell holds its NAD pool largely in the OXIDIZED form (NAD+) while holding its NADP pool largely in the REDUCED form (NADPH), and the two are used for different tasks: NADH feeds electrons into the electron transport chain, whereas NADPH supplies electrons for biosynthesis such as fatty-acid synthesis. Which explanation BEST accounts for WHY the cell maintains these two chemically similar carriers as SEPARATE pools?', '[{"label": "A", "text": "The extra phosphate on NADPH makes its redox chemistry fundamentally different from NADH, so the two simply cannot participate in the same kinds of electron-transfer reactions."}, {"label": "B", "text": "Keeping NAD mostly oxidized makes NAD+ an eager electron ACCEPTOR for catabolic oxidations that feed the ETC, while keeping NADP mostly reduced makes NADPH a ready electron DONOR for reductive biosynthesis; separate pools let both drives stay high at once."}, {"label": "C", "text": "The cell keeps both pools in the same oxidation state, and the phosphate merely tags NADPH for degradation, which is the only reason the two are handled differently."}, {"label": "D", "text": "Because NADPH carries more energy per electron than NADH, it is used wherever the largest amount of ATP must be generated in the electron transport chain."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Principles of Bioenergetics.''

The answer is B because a carrier''s usefulness depends on which oxidation state is abundant. By holding NAD largely as NAD+ (oxidized), the cell keeps a strong pull to ACCEPT electrons from catabolic fuel oxidations, and those electrons are then delivered to the ETC for ATP production. By holding NADP largely as NADPH (reduced), the cell keeps a strong push to DONATE electrons into reductive biosynthesis (e.g., building fatty acids). Because the extra phosphate lets enzymes recognize one carrier versus the other, the cell can maintain these OPPOSITE ratios in the same compartment simultaneously — an oxidized catabolic pool and a reduced anabolic pool — instead of one intermediate ratio that would serve neither task well.

(Choice B) is correct: it ties the functional split to the separately maintained oxidation-state ratios (oxidized NAD+ for accepting/catabolism, reduced NADPH for donating/anabolism), which is the reason for keeping distinct pools.

(Choice A) is incorrect: the stem states the redox chemistry is nearly identical. The phosphate is a recognition tag for enzymes, not a change in the fundamental electron-transfer chemistry, so this contradicts the premise.

(Choice C) is incorrect: the pools are NOT held in the same oxidation state — NAD is kept oxidized and NADP kept reduced — and the phosphate is a functional discriminator, not a degradation signal.

(Choice D) is incorrect: NADPH does not carry more energy per electron (their reduction potentials are nearly the same, about −0.32 V each), and NADPH is not the ETC''s ATP-generating carrier; NADH fills that catabolic role. This misassigns NADPH''s anabolic function.

This item rewards Skill 2 reasoning: applying the principle that a redox carrier''s driving force depends on its maintained oxidized/reduced ratio to explain why nearly identical molecules are kept as separate catabolic and anabolic pools.', 'medium', '1D', 'Principles of Bioenergetics', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'phosphate-changes-redox-chemistry' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'phosphate-as-degradation-tag' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'nadph-more-energetic-for-etc' FROM q;

-- Q23 [D1 · Metabolic States] easy skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'A person eats a large, carbohydrate-rich meal, and plasma insulin surges. Within the first few minutes, skeletal muscle and adipose tissue sharply increase their glucose uptake, yet the brain''s rate of glucose uptake barely changes. Which mechanism best explains this immediate, tissue-selective response to the insulin surge?', '[{"label": "A", "text": "Insulin activates glucokinase inside muscle and adipose cells so they trap glucose faster, while brain tissue lacks glucokinase entirely."}, {"label": "B", "text": "Insulin inserts high-Km GLUT2 sensor transporters into muscle and adipose membranes, while the brain carries only low-Km transporters."}, {"label": "C", "text": "Insulin recruits GLUT4 transporters to the plasma membrane of muscle and adipose cells, while the brain relies on insulin-independent GLUT1 and GLUT3."}, {"label": "D", "text": "Insulin inhibits glucose-6-phosphatase in muscle and adipose so incoming glucose stays trapped, while the brain retains that enzyme."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because the fastest, first-line action of an insulin surge is to move GLUT4 glucose transporters from intracellular vesicles to the plasma membrane of skeletal muscle and adipose cells; because these two tissues carry the insulin-responsive GLUT4 isoform, their glucose uptake jumps within minutes, whereas the brain imports glucose through insulin-independent GLUT1/GLUT3 and therefore does not change its uptake rate when insulin rises.

(Choice C) is correct: GLUT4 is the insulin-dependent transporter of muscle and adipose, and insulin''s most immediate effect is to recruit it to the cell surface; the brain''s GLUT1 and GLUT3 operate regardless of insulin, which explains the tissue-selective response.

(Choice A) is incorrect: glucokinase is expressed in the liver and pancreatic beta cells, not in skeletal muscle or adipose tissue (which use hexokinase), so insulin does not speed muscle/adipose glucose uptake by activating glucokinase.

(Choice B) is incorrect: GLUT2 is the high-Km sensor of the liver and beta cells, not a muscle or adipose transporter, and it is insulin-independent, so insulin does not insert GLUT2 into muscle or fat membranes.

(Choice D) is incorrect: glucose-6-phosphatase is found only in the liver and kidney, not in muscle or adipose, so there is no such enzyme for insulin to inhibit in those tissues, and trapping already-absorbed glucose is not what drives the rapid rise in uptake.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must reason from a single hormonal signal to the specific transporter mechanism that makes some tissues, but not others, respond immediately, rather than recalling a labeled fact.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'glucokinase (liver/beta-cell enzyme) placed in muscle/adipose to drive uptake' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'real GLUT2 sensor misassigned to muscle/adipose and made insulin-recruited' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'glucose-6-phosphatase (liver/kidney only) imagined in muscle/adipose' FROM q;

-- Q24 [D2 · Metabolic States] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'A healthy person skips breakfast and lunch; by mid-afternoon (about 6 hours after the last meal) blood glucose is being held near normal. Which source is supplying the majority of that blood glucose, and why does it dominate over the alternatives so soon into the fast?', '[{"label": "A", "text": "Hepatic gluconeogenesis, because glucagon rapidly induces gluconeogenic enzymes that respond faster than glycogen breakdown."}, {"label": "B", "text": "Skeletal muscle glycogenolysis, because muscle releases free glucose from its large glycogen stores directly into the blood."}, {"label": "C", "text": "Adipose lipolysis feeding ketone production, because fatty acids are converted into glucose to maintain blood sugar."}, {"label": "D", "text": "Hepatic glycogenolysis, because glucagon activates glycogen phosphorylase to release stored glucose faster than making new glucose."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because only a few hours into a fast the fastest way to defend blood glucose is to release glucose that is already stored: glucagon activates glycogen phosphorylase, so hepatic glycogen is broken down almost immediately, whereas building new glucose by gluconeogenesis ramps up more slowly.

(Choice A) is incorrect: gluconeogenesis is stimulated in early fasting but responds comparatively slowly, so it cannot yet be the dominant source — this reverses the true speed ranking.

(Choice B) is incorrect: skeletal muscle lacks glucose-6-phosphatase, so muscle glycogen serves the muscle itself and cannot release free glucose into the blood.

(Choice C) is incorrect: fatty acids are not converted to glucose in humans, and ketone production is minimal this early; lipolysis at this stage mainly supplies fuel and gluconeogenic glycerol, not blood glucose directly.

(Choice D) is correct: mobilizing existing hepatic glycogen requires only enzyme activation, making it the first and fastest defense of blood glucose in the hours after a meal.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must reason about the relative speed of two glucose sources within a defined metabolic window rather than restate which pathway exists.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'gluconeogenesis assumed faster than glycogenolysis' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'muscle glycogen raises blood glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'fatty acids converted to glucose' FROM q;

-- Q25 [D3 · Metabolic States] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'A patient fasts for a full day (about 24 hours). Compared with the first few hours of the fast, which change best explains why gluconeogenesis has now become the predominant source of blood glucose?', '[{"label": "A", "text": "Hepatic glycogen stores are now largely depleted, so the liver must synthesize glucose from lactate, glycerol, and glucogenic amino acids."}, {"label": "B", "text": "Insulin has risen steadily over the day and shut down glycogenolysis, forcing the liver to switch to glucose synthesis."}, {"label": "C", "text": "The brain has now fully switched to ketone bodies, eliminating any need for the liver to release glucose."}, {"label": "D", "text": "Skeletal muscle glycogen has now been exhausted and can no longer contribute its glucose directly to the blood."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because by roughly 24 hours hepatic glycogen is nearly exhausted, so glycogenolysis can no longer keep up and the liver takes over glucose supply by building it de novo from lactate, glycerol, and glucogenic amino acids.

(Choice A) is correct: the handoff from glycogenolysis to gluconeogenesis is driven by the running-out of the glycogen substrate, which forces reliance on de novo synthesis.

(Choice B) is incorrect: during a fast insulin falls and stays low while glucagon is elevated; a rising insulin would promote storage, not glucose output, so this reverses the hormonal reality.

(Choice C) is incorrect: the brain''s major shift to ketones belongs to prolonged fasting over days, not at 24 hours, and lowering glucose demand would not explain why gluconeogenesis specifically becomes predominant now.

(Choice D) is incorrect: skeletal muscle lacks glucose-6-phosphatase and never contributed glucose to the blood, so its glycogen status is irrelevant to the source of blood glucose.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must reason about why a metabolic source is handed off over time rather than recall a static label.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'insulin rising during a fast' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'prolonged-fasting brain ketone shift placed too early' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'muscle glycogen supplies blood glucose' FROM q;

-- Q26 [D4 · Metabolic States] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'During prolonged starvation, urinary nitrogen excretion falls markedly, indicating that less body protein is being broken down. Which mechanism best explains how the rise in ketone bodies produces this protein-sparing effect?', '[{"label": "A", "text": "Ketone bodies are converted directly into glucose by the liver, replacing the glucose that would otherwise come from amino acids."}, {"label": "B", "text": "As the brain adapts to oxidizing ketone bodies, its glucose demand falls, reducing gluconeogenesis from amino acids and sparing muscle protein."}, {"label": "C", "text": "Ketone bodies stimulate insulin release, which promotes muscle protein synthesis and blocks proteolysis."}, {"label": "D", "text": "Ketone bodies inhibit hormone-sensitive lipase, so fatty acids replace amino acids as the liver''s gluconeogenic substrate."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because as ketone bodies rise the brain begins to oxidize them for much of its energy; with the brain covering its needs from ketones, it demands less glucose, so the liver performs less gluconeogenesis and breaks down less muscle protein for amino-acid substrate — which is why urinary nitrogen falls.

(Choice A) is incorrect: acetyl-CoA and the ketone bodies derived from it cannot be converted to net glucose in humans, so ketones cannot substitute for amino-acid-derived glucose.

(Choice C) is incorrect: insulin is low during starvation, not elevated; ketones do not switch the body into an insulin-driven protein-synthesizing state.

(Choice B) is correct: the protein-sparing effect works indirectly — brain ketone use lowers the glucose requirement, which lowers gluconeogenic demand for amino acids and thus muscle breakdown.

(Choice D) is incorrect: fatty acids (and their acetyl-CoA) are not gluconeogenic substrates, and lipolysis is actually high in starvation, so this mechanism is doubly wrong.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must trace an integrated, multi-tissue causal chain from a ketone rise to reduced protein catabolism rather than recall the phrase ''protein sparing.''', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'ketones treated as gluconeogenic' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'insulin high in starvation' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'fatty acids as gluconeogenic substrate' FROM q;

-- Q27 [D5 · Metabolic States] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'A person has eaten nothing for five days but has free access to water. Which statement best describes how blood glucose is being supplied at this stage and how the body is limiting its own protein loss?', '[{"label": "A", "text": "Hepatic glycogenolysis still supplies most blood glucose, while fatty acids spare protein."}, {"label": "B", "text": "Dietary glucose and hepatic glycogen together supply blood glucose, while ketone bodies are not yet being produced."}, {"label": "C", "text": "Gluconeogenesis from glycerol and amino acids supplies blood glucose, while widespread brain use of ketone bodies lowers glucose demand and spares protein."}, {"label": "D", "text": "Gluconeogenesis supplies blood glucose, but because the brain has not adapted to ketones it still relies fully on glucose, accelerating protein breakdown."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because five days without food is well past glycogen depletion, so blood glucose now comes from gluconeogenesis using glycerol and amino acids, and by this point the brain is using ketone bodies extensively — which lowers glucose demand and therefore spares body protein.

(Choice A) is incorrect: hepatic glycogen is essentially gone within about a day, so glycogenolysis cannot be the main source at day five.

(Choice B) is incorrect: this describes the absorptive/early phase; by day five dietary and glycogen sources are long exhausted and ketones are abundant, so it misplaces an early stage onto a late one.

(Choice D) is incorrect: it correctly names gluconeogenesis but denies the ketone adaptation that is precisely what curbs glucose demand and protects protein at this stage; in fact protein breakdown is slowing, not accelerating, by day five.

(Choice C) is correct: it pairs the correct late-fast glucose source with the ketone-driven, protein-sparing mechanism that defines prolonged starvation.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must place a specified point in the fasting timeline and reason out both the dominant glucose source and the sparing mechanism, not recall a single fact.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'early-fast glycogenolysis placed at day five' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'absorptive phase placed at day five' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'correct glucose source, denies ketone sparing' FROM q;

-- Q28 [D6 · Metabolic States] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'A clinician draws blood from a metabolically healthy patient and obtains the values below.

| Analyte | Patient value | Reference (well-fed) |
| --- | --- | --- |
| Blood glucose | 66 mg/dL | 80–110 mg/dL |
| Plasma insulin | 3 µU/mL | 15–70 µU/mL |
| Plasma glucagon | 155 pg/mL | 50–100 pg/mL |
| β-hydroxybutyrate | 4.6 mmol/L | < 0.3 mmol/L |
| Free fatty acids | 1.5 mmol/L | 0.3–0.6 mmol/L |

Which metabolic state best accounts for the entire pattern of values?', '[{"label": "A", "text": "Well-fed (postprandial) state."}, {"label": "B", "text": "Early, overnight postabsorptive fasting."}, {"label": "C", "text": "Refeeding, immediately after a meal ending a fast."}, {"label": "D", "text": "Prolonged fasting (starvation)."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the data show a fasting hormonal signal (insulin low at 3 µU/mL, glucagon elevated at 155 pg/mL) combined with markedly elevated ketones (β-hydroxybutyrate 4.6 mmol/L, more than fifteen-fold the reference ceiling) and high free fatty acids — the ketone level is what marks this as prolonged fasting rather than an early fast.

(Choice A) is incorrect: a well-fed state would show high insulin, low glucagon, and negligible ketones, which is the reverse of the measured pattern.

(Choice D) is correct: low insulin with high glucagon establishes fasting, and the very high β-hydroxybutyrate plus elevated free fatty acids place it in the prolonged, ketone-dependent phase in which the brain and muscle rely heavily on ketones and fatty acids, sparing glucose and protein.

(Choice B) is incorrect: an early overnight fast shares the low-insulin/high-glucagon signal, but its ketones would be well under about 1 mmol/L, not 4.6 mmol/L, so the ketone value rules it out.

(Choice C) is incorrect: refeeding would show a rising insulin surge with glucagon and ketones falling, not the low-insulin, high-ketone pattern measured here.

This item rewards Skill 4 (Data-Based and Statistical Reasoning): you must integrate five interacting analytes against reference ranges to infer a metabolic state, using the ketone magnitude to discriminate between two fasting phases.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'data inverted to the fed state' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'fasting signal fits but ketones too high for early fast' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'refeeding surge not matching the data' FROM q;

-- Q29 [D7 · Metabolic States] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Metabolic States', 'During a fast, glucagon, cortisol, epinephrine, norepinephrine, and growth hormone all rise together. What is the net, coordinated effect of these counter-regulatory hormones, and how do they achieve it?', '[{"label": "A", "text": "They raise blood glucose by jointly stimulating hepatic glycogenolysis and gluconeogenesis while promoting lipolysis to supply alternative fuels and gluconeogenic substrate."}, {"label": "B", "text": "They raise blood glucose primarily by stimulating insulin-independent glucose uptake into muscle and fat."}, {"label": "C", "text": "They lower blood glucose by driving tissue glucose uptake to oppose hyperglycemia."}, {"label": "D", "text": "They raise blood glucose solely through hepatic gluconeogenesis, with no effect on glycogen stores or fat."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because the counter-regulatory hormones act in concert to defend blood glucose during a fast: they drive hepatic glycogenolysis and gluconeogenesis to output glucose, and they promote adipose lipolysis to supply peripheral tissues with fatty-acid fuel and to feed the liver gluconeogenic glycerol.

(Choice B) is incorrect: stimulating tissue glucose uptake is insulin''s role, and muscle and fat take up glucose through insulin-dependent GLUT4; the counter-regulatory hormones oppose insulin and do not push glucose into muscle and fat. Driving glucose into tissues would also lower, not raise, blood glucose.

(Choice C) is incorrect: their net effect raises blood glucose to protect the glucose-dependent brain, so ''lowering'' glucose reverses their purpose.

(Choice A) is correct: the coordinated response combines liver glucose output (both glycogenolysis and gluconeogenesis) with lipolysis, integrating multiple tissues to sustain blood glucose.

(Choice D) is incorrect: gluconeogenesis is only part of the response; ignoring glycogenolysis (the first and fastest glucose source in early fasting) and lipolysis misses the coordinated, multi-pathway nature of the effect.

This item rewards Skill 2 (Scientific Reasoning and Problem-Solving): you must synthesize the combined action of several hormones on multiple tissues into a single net outcome rather than recall one hormone''s action.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'counter-regulatory hormones boost glucose uptake' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'hormones lower blood glucose' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'gluconeogenesis only, ignores glycogenolysis and lipolysis' FROM q;

-- Q30 [E8 · Multi-Tissue Coordination] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'A healthy adult eats a large carbohydrate-rich meal, and one to two hours later blood insulin is high. Which description correctly pairs the liver, skeletal muscle, and adipose tissue with the dominant activity each carries out in this absorptive state?', '[{"label": "A", "text": "The liver exports free glucose produced by glycogenolysis; muscle releases its amino acids for hepatic gluconeogenesis; adipose hydrolyzes stored triacylglycerol to free fatty acids."}, {"label": "B", "text": "The liver stores glucose as glycogen and converts excess to fatty acids exported as VLDL; muscle takes up glucose via GLUT4 for glycogen and protein synthesis; adipose esterifies fatty acids into stored triacylglycerol."}, {"label": "C", "text": "The liver stores glycogen but oxidizes fatty acids for its own energy; muscle takes up glucose for glycogen yet degrades protein to amino acids; adipose stores triacylglycerol."}, {"label": "D", "text": "The liver takes up glucose for glycogen and lipogenesis; muscle stores glycogen from glucose; adipose mobilizes fatty acids to fuel the periphery during the absorptive state."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because after a carbohydrate-rich meal insulin is high, and its job is to store fuel: the liver packs glucose into glycogen and channels the surplus into fatty acids exported as VLDL, muscle pulls glucose in through GLUT4 to build glycogen and (with amino acids) protein, and adipose esterifies fatty acids into triacylglycerol — every tissue is in net storage mode.

(Choice A) is incorrect: exporting glucose, mobilizing amino acids, and hydrolyzing triacylglycerol is the counter-regulatory (fasting) program run under low insulin and high glucagon, the opposite of the absorptive state described.

(Choice B) is correct: it correctly assigns glycogen plus lipogenesis to the liver, GLUT4 uptake for glycogen and protein synthesis to muscle, and triacylglycerol storage to adipose — the coordinated high-insulin response.

(Choice C) is incorrect: the well-fed liver covers its own energy needs by oxidizing surplus amino acids (sparing fat for export), not by burning fatty acids, and fed muscle synthesizes protein rather than degrading it.

(Choice D) is incorrect: under high insulin adipose stores triacylglycerol; mobilizing fatty acids to fuel the periphery is a low-insulin behavior, so this reverses the adipose response even though its liver and muscle clauses are correct.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by making you apply insulin''s integrated anabolic signal across three tissues at once rather than recall one pathway.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'applies the fasting/counter-regulatory program to the fed state' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'well-fed liver burns fat instead of surplus amino acids; fed muscle catabolizes protein' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'adipose mobilizes fat instead of storing it under high insulin' FROM q;

-- Q31 [E9 · Multi-Tissue Coordination] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'A healthy adult who last ate 18 hours ago has a near-normal blood glucose level despite the fast. Which description best captures how the liver, adipose tissue, and skeletal muscle coordinate to keep blood glucose stable?', '[{"label": "A", "text": "The liver stores incoming glucose as glycogen; adipose esterifies fatty acids into triacylglycerol; muscle takes up glucose through GLUT4 for glycogen synthesis."}, {"label": "B", "text": "The liver converts amino acids to glucose; muscle releases free fatty acids from its own triacylglycerol stores for hepatic use; adipose exports alanine to carry nitrogen to the liver."}, {"label": "C", "text": "The liver releases glucose by glycogenolysis and gluconeogenesis; adipose lipolysis supplies free fatty acids and glycerol; muscle oxidizes fatty acids and releases amino acids, sparing glucose for the brain."}, {"label": "D", "text": "The liver releases glucose by gluconeogenesis and adipose releases fatty acids, but skeletal muscle preferentially consumes blood glucose to power itself rather than sparing it."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because during a fast insulin falls and glucagon rises, so tissues divide labor to protect blood glucose for the brain: the liver exports glucose (first by glycogenolysis, then gluconeogenesis), adipose lipolysis supplies free fatty acids and glycerol, and muscle switches to oxidizing those fatty acids while exporting amino acids as gluconeogenic substrate — sparing glucose for the brain.

(Choice A) is incorrect: storing glucose as glycogen, esterifying fatty acids, and GLUT4 uptake for glycogen is the fed, high-insulin anabolic program, not the response to fasting.

(Choice B) is incorrect: it swaps tissue roles — muscle is not a major triacylglycerol depot and does not supply fatty acids to the liver, and it is muscle (not adipose) that exports alanine to carry nitrogen.

(Choice D) is incorrect: the liver and adipose steps are right, but if muscle kept consuming blood glucose it would compete with the brain; the point of fasting integration is that muscle burns fatty acids to spare glucose.

(Choice C) is correct: it captures the coordinated division of labor — hepatic glucose output, adipose lipolysis, and muscle fatty-acid oxidation with amino-acid export — that sustains blood glucose.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by requiring you to integrate three tissues'' fasting responses toward one shared goal, protecting the glucose supply.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'applies the fed/insulin anabolic program during a fast' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'swaps muscle and adipose roles (muscle as fat depot, adipose as nitrogen carrier)' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'muscle keeps burning glucose instead of switching to fatty acids to spare it' FROM q;

-- Q32 [E10 · Multi-Tissue Coordination] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'During an all-out sprint, skeletal muscle produces ATP anaerobically and releases lactate into the blood; the lactate is taken up by the liver and the resulting glucose returns to the muscle. Which statement best explains what this inter-organ (Cori) cycle accomplishes and where its energetic cost falls?', '[{"label": "A", "text": "The cycle yields net ATP for the whole body because hepatic gluconeogenesis fully recaptures the energy stored in lactate, so both the muscle and the liver come out ahead."}, {"label": "B", "text": "Lactate carries amino nitrogen to the liver, where that nitrogen enters the urea cycle and the carbon skeleton is remade into glucose, so the liver bears a nitrogen-disposal cost."}, {"label": "C", "text": "The liver simply oxidizes the incoming lactate fully to CO2 for its own ATP and returns pyruvate to the muscle, so the two organs share the energy cost equally."}, {"label": "D", "text": "Muscle makes lactate to regenerate NAD+ so anaerobic glycolysis can continue, and the liver spends ATP rebuilding that lactate into glucose, so the cycle''s energy cost falls on the liver."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because anaerobic muscle makes ATP by glycolysis but must reoxidize NADH to NAD+ to keep going, which it does by reducing pyruvate to lactate; shipping that lactate to the liver lets the liver rebuild glucose by gluconeogenesis — a process that costs \(6\) ATP per glucose versus the \(2\) ATP glycolysis produced — so the cycle is net ATP-consuming and the liver pays that bill.

(Choice D) is correct: muscle offloads lactate and regenerates NAD+ to sustain glycolysis, and the liver spends the ATP to remake glucose, placing the energy cost on the liver.

(Choice A) is incorrect: the Cori cycle does not create energy — hepatic gluconeogenesis consumes more ATP than muscle glycolysis released, so the cycle is a net drain, not a net gain.

(Choice B) is incorrect: lactate carries no amino nitrogen; transferring nitrogen for urea synthesis while making glucose describes the glucose-alanine cycle, not the Cori cycle.

(Choice C) is incorrect: the liver does not oxidize the lactate to CO2 for ATP — it runs gluconeogenesis to regenerate glucose, and the cost is not shared equally but falls on the liver.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to trace the redox and energy logic linking two organs rather than recall the cycle''s name.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats the Cori cycle as net ATP-yielding rather than ATP-consuming' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'imports glucose-alanine nitrogen logic into the Cori cycle' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'liver oxidizes lactate instead of running gluconeogenesis' FROM q;

-- Q33 [E11 · Multi-Tissue Coordination] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'In fasting muscle, amino acids released by protein breakdown donate their amino groups to pyruvate, forming alanine that travels to the liver; glucose then returns to the muscle. Which statement best explains what this glucose-alanine cycle accomplishes?', '[{"label": "A", "text": "It ferries amino nitrogen from muscle to liver as nontoxic alanine, whose nitrogen enters the urea cycle while its carbon skeleton feeds gluconeogenesis."}, {"label": "B", "text": "It regenerates NAD+ in muscle by shuttling lactate to the liver, letting anaerobic glycolysis continue while the liver remakes glucose."}, {"label": "C", "text": "It delivers free ammonia directly to the liver for urea synthesis, sparing muscle the cost of transamination."}, {"label": "D", "text": "It exchanges muscle glucose for hepatic fatty acids, coupling gluconeogenesis to adipose lipolysis so muscle receives fat while the liver receives glucose."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because muscle protein breakdown generates amino groups that must reach the liver for disposal, but free ammonia is toxic; transaminating pyruvate to alanine packages that nitrogen safely, and in the liver the alanine is split so its nitrogen enters the urea cycle while its carbon skeleton (pyruvate) feeds gluconeogenesis — one cycle accomplishing safe nitrogen transport and glucose synthesis.

(Choice B) is incorrect: shuttling lactate to regenerate NAD+ for continued glycolysis describes the Cori cycle; the glucose-alanine cycle transports nitrogen, not reducing equivalents.

(Choice C) is incorrect: the whole purpose of using alanine is to avoid releasing toxic free ammonia into the blood, so delivering free ammonia is the opposite of what the cycle achieves.

(Choice A) is correct: it identifies both jobs — nontoxic nitrogen transport as alanine feeding the urea cycle and a carbon skeleton feeding gluconeogenesis.

(Choice D) is incorrect: there is no glucose-for-fatty-acid swap; the cycle moves alanine one way and returns glucose, not fatty acids, to muscle.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by making you reason out the dual purpose of an inter-organ cycle rather than restate a definition.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'conflates the glucose-alanine cycle with the Cori (redox) cycle' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'transports free ammonia — the exact toxicity the cycle exists to avoid' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'fabricates a glucose-for-fatty-acid inter-organ swap' FROM q;

-- Q34 [E12 · Multi-Tissue Coordination] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'A patient with untreated type 1 diabetes has almost no circulating insulin. Which statement correctly describes how the brain and red blood cells handle glucose under these conditions?', '[{"label": "A", "text": "Both depend on insulin-stimulated GLUT4 for glucose uptake, so when insulin is low their glucose use drops sharply just as it does in muscle and adipose tissue."}, {"label": "B", "text": "Both keep taking up glucose without insulin, and red blood cells, lacking mitochondria, metabolize it anaerobically to lactate in every metabolic state."}, {"label": "C", "text": "Red blood cells oxidize glucose fully to CO2 for maximal ATP, while the brain relies on anaerobic glycolysis."}, {"label": "D", "text": "Both switch to oxidizing fatty acids when insulin falls, sparing glucose for gluconeogenesis."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the brain and red blood cells take up glucose through insulin-independent transporters (GLUT1/GLUT3), so even with almost no insulin they keep drawing glucose; and because red blood cells have no mitochondria, they can only run glycolysis — metabolizing glucose anaerobically to lactate in every metabolic state.

(Choice B) is correct: both tissues take up glucose without insulin, and mitochondria-free red blood cells are obligate anaerobic glucose users regardless of state.

(Choice A) is incorrect: brain and red blood cells do not rely on insulin-stimulated GLUT4 (that is muscle and adipose), so low insulin does not shut off their glucose uptake.

(Choice C) is incorrect: it reverses their metabolism — red blood cells cannot oxidize glucose to CO2 because they lack mitochondria, whereas the brain fully oxidizes glucose.

(Choice D) is incorrect: red blood cells and neurons cannot oxidize fatty acids (fatty acids do not effectively cross the blood-brain barrier and red cells lack mitochondria), so they do not switch to fat when insulin falls.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by making you reason from tissue architecture — transporters and mitochondria — to fuel use under low insulin.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'treats brain/RBC glucose uptake as insulin-dependent (GLUT4)' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'swaps RBC and brain glucose metabolism despite RBCs lacking mitochondria' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'assumes RBCs and neurons can burn fatty acids' FROM q;

-- Q35 [E13 · Multi-Tissue Coordination] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'Skeletal muscle holds a large glycogen store, yet during hypoglycemia only hepatic glycogen — not muscle glycogen — can raise blood glucose. Which statement best explains why muscle glycogen cannot contribute free glucose to the blood?', '[{"label": "A", "text": "Skeletal muscle lacks glycogen phosphorylase, so it cannot mobilize its glycogen and must instead import glucose from the liver."}, {"label": "B", "text": "Muscle glycogen stays bound to glycogenin and cannot be released without glucagon receptors, which muscle lacks."}, {"label": "C", "text": "Skeletal muscle lacks glucose-6-phosphatase, so the glucose-6-phosphate freed from its glycogen cannot be dephosphorylated and released into the blood."}, {"label": "D", "text": "Muscle exports its glucose-6-phosphate to the liver, which dephosphorylates it and releases free glucose once hepatic glycogen is spent."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because releasing free glucose into blood requires removing the phosphate from glucose-6-phosphate, and only the liver (and kidney) express glucose-6-phosphatase; skeletal muscle lacks this enzyme, so the glucose-6-phosphate liberated from muscle glycogen stays charged and trapped inside the cell, where it can only feed the muscle''s own glycolysis — it can never raise blood glucose.

(Choice A) is incorrect: muscle does have glycogen phosphorylase and readily breaks down its glycogen; the limitation is downstream, at dephosphorylation, not mobilization.

(Choice B) is incorrect: muscle does lack glucagon receptors (it responds to epinephrine instead), but that is not why its glucose stays trapped — even fully mobilized, the phosphorylated glucose cannot exit without glucose-6-phosphatase.

(Choice D) is incorrect: phosphorylated sugars cannot cross the plasma membrane, so muscle cannot ship glucose-6-phosphate to the liver for release.

(Choice C) is correct: without glucose-6-phosphatase muscle cannot dephosphorylate glucose-6-phosphate, so the trapped sugar serves only the muscle and muscle glycogen cannot buffer blood glucose.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by making you connect a single missing enzyme to the whole-body role of muscle versus liver glycogen.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'claims muscle has no glycogen phosphorylase' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'true fact (muscle lacks glucagon receptors) offered as the wrong cause' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'phosphorylated glucose crosses membranes and travels to the liver' FROM q;

-- Q36 [E14 · Multi-Tissue Coordination] hard skill4 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Multi-Tissue Coordination', 'A researcher uses arteriovenous concentration differences to measure the net exchange of three fuels across four tissues in a resting subject. Positive values indicate net release into the blood and negative values indicate net uptake (arbitrary units, mmol/min); no ketone bodies were detectable.

| Tissue | Glucose | Fatty acids | Amino acids |
| --- | --- | --- | --- |
| Liver | +2.4 | -1.2 | -1.0 |
| Adipose | -0.1 | +1.9 | 0.0 |
| Skeletal muscle | -0.3 | -1.5 | +0.8 |
| Brain | -1.8 | 0.0 | 0.0 |

Which conclusion is best supported by the flux data?', '[{"label": "A", "text": "The subject is in the fed (absorptive) state, with insulin driving hepatic glucose uptake and glycogen storage."}, {"label": "B", "text": "The subject is in prolonged starvation, in which the brain has switched to ketone bodies to spare glucose."}, {"label": "C", "text": "Adipose tissue is sustaining the blood glucose supply, exporting both glucose and fatty acids to the periphery."}, {"label": "D", "text": "The subject is in the postabsorptive (fasting) state, with the liver as the sole net glucose exporter and the periphery mobilizing adipose fatty acids."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the liver shows net glucose release (+2.4) while every other tissue shows net glucose uptake, adipose shows large net fatty-acid release (+1.9, i.e., lipolysis), muscle takes up fatty acids (-1.5) and releases amino acids (+0.8), and the brain still consumes glucose (-1.8) with no ketones detectable — the signature of the postabsorptive (fasting) state, in which the liver exports glucose while peripheral tissues shift to fat.

(Choice A) is incorrect: in the fed state the liver takes up glucose, but the data show it releasing glucose (+2.4), so the subject cannot be absorptive.

(Choice D) is correct: the liver as the sole net glucose exporter, adipose lipolysis, and muscle fatty-acid oxidation with amino-acid release together identify early fasting.

(Choice B) is incorrect: in prolonged starvation the brain draws on ketones and spares glucose, but here the brain is still the largest net glucose consumer (-1.8) and no ketones are present, so the data do not support starvation.

(Choice C) is incorrect: adipose glucose flux is essentially zero (-0.1); it exports fatty acids, not glucose, so it is not sustaining blood glucose — the liver is.

This question tests Skill 4 (Data-Based and Statistical Reasoning) by requiring you to read arteriovenous flux signs across tissues and infer the metabolic state rather than recall it.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'reads the liver''s net glucose release as fed-state uptake' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'assumes the starvation ketone switch despite brain still consuming glucose and no ketones present' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'treats adipose as a glucose exporter' FROM q;

-- Q37 [F15 · Exercise & Scenario Integration] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'A competitive rower begins an all-out 45-second effort. Stored ATP and the creatine phosphate pool are spent within the first several seconds, and oxidative phosphorylation has not yet ramped up to meet the maximal ATP demand. During the remainder of this 45-second effort, which process supplies most of the muscle''s ATP?', '[{"label": "A", "text": "Anaerobic glycolysis of muscle glycogen, generating lactate"}, {"label": "B", "text": "Regeneration of ATP from the remaining creatine phosphate pool"}, {"label": "C", "text": "Complete oxidation of plasma free fatty acids in muscle mitochondria"}, {"label": "D", "text": "Hepatic gluconeogenesis exporting glucose to the working muscle"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because the scenario places the effort in the window after the several-second creatine phosphate pool is exhausted but before oxidative phosphorylation can meet a maximal demand; in that gap the muscle regenerates ATP fastest by anaerobically breaking down its own glycogen to lactate.

(Choice A) is correct: anaerobic glycolysis of stored muscle glycogen regenerates ATP quickly without waiting on oxygen delivery, which is why it dominates the intense 30-60 s range and produces the lactate that accumulates.
(Choice B) is incorrect: the creatine phosphate pool powers only the first several seconds and, per the stem, is already depleted, so it cannot supply most of this effort.
(Choice C) is incorrect: complete oxidation of fatty acids is the endurance fuel; it is far too slow to meet the ATP demand of an all-out burst and predominates only during sustained lower-intensity work.
(Choice D) is incorrect: hepatic gluconeogenesis (e.g., recycling lactate through the Cori cycle) operates over minutes to hours and cannot acutely fuel a muscle contracting maximally for under a minute.

This item rewards Skill 2 (reasoning) by asking the student to match a described duration and intensity to the one fuel system that can meet that specific ATP demand.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'process_step_confusion', 'earlier creatine-phosphate phase assumed to persist' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'endurance oxidative fuel used for a short all-out burst' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Cori-cycle hepatic output on the wrong timescale' FROM q;

-- Q38 [F16 · Exercise & Scenario Integration] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'A track athlete first runs an all-out 100-meter sprint (about 10 seconds) and, an hour later, completes a steady 10-kilometer run (about 50 minutes). Which option correctly pairs the predominant muscle fuel system with each event?', '[{"label": "A", "text": "Sprint: oxidative metabolism of fatty acids; 10-km run: anaerobic glycolysis of muscle glycogen"}, {"label": "B", "text": "Sprint: creatine phosphate and anaerobic glycolysis; 10-km run: oxidative metabolism of fatty acids and glucose"}, {"label": "C", "text": "Sprint: hepatic gluconeogenesis; 10-km run: creatine phosphate"}, {"label": "D", "text": "Both events: primarily oxidation of ketone bodies"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because an all-out ~10 s sprint outstrips oxygen delivery and must draw on the immediate anaerobic systems (creatine phosphate, then anaerobic glycolysis), whereas a ~50 min steady run is submaximal enough for mitochondria to keep pace, so it runs on the oxidative burning of fatty acids and glucose.

(Choice B) is correct: brief maximal work relies on anaerobic/creatine-phosphate energy while prolonged steady work relies on oxidative metabolism of fat and glucose — the intensity-to-system pairing is right for both events.
(Choice A) is incorrect: it reverses the two systems; oxidative fat-burning is too slow to fuel a sprint, and anaerobic glycolysis cannot be sustained for a 50-minute run without fatiguing lactate accumulation.
(Choice C) is incorrect: hepatic gluconeogenesis is a slow inter-organ process, not the sprinter''s immediate fuel, and creatine phosphate lasts only seconds, so it cannot power a 50-minute run.
(Choice D) is incorrect: ketone bodies become a major fuel only in prolonged fasting, not during either exercise bout in a fed athlete.

This item rewards Skill 2 (reasoning) by requiring the student to map exercise intensity and duration onto the fuel systems that can meet each demand.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'sprint and endurance fuel systems swapped' FROM q
  UNION ALL
  SELECT id, 'C', 'process_step_confusion', 'fuel systems assigned to the wrong event and timescale' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'ketones cast as the fuel that powers exercise' FROM q;

-- Q39 [F17 · Exercise & Scenario Integration] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'A hiker is startled by a bear and sprints away. Within seconds, circulating epinephrine surges. Which combination of tissue responses best accounts for the rapid rise in fuels made available to the working skeletal muscle?', '[{"label": "A", "text": "Hepatic glycogen synthesis and adipose triacylglycerol storage sequester fuels for later use"}, {"label": "B", "text": "Muscle glycogenolysis releases free glucose into the blood while the liver takes up fatty acids"}, {"label": "C", "text": "Hepatic glycogenolysis raises blood glucose while adipose lipolysis releases free fatty acids"}, {"label": "D", "text": "Pancreatic insulin release drives glucose into muscle while hepatic ketogenesis supplies the brain"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because epinephrine is a catabolic stress hormone that acts on several tissues at once: it drives hepatic glycogenolysis to push glucose into the blood and adipose lipolysis to release free fatty acids, delivering both fuels to the sprinting muscle within seconds.

(Choice C) is correct: liver glycogenolysis plus adipose lipolysis is exactly the two-tissue mobilization epinephrine triggers, raising circulating glucose and fatty acids for immediate use.
(Choice A) is incorrect: storing fuel through glycogen and triacylglycerol synthesis is the anabolic, insulin-driven program — the opposite of what a stress hormone does.
(Choice B) is incorrect: skeletal muscle lacks glucose-6-phosphatase, so its glycogen cannot release free glucose into the blood; muscle glycogen serves the muscle itself.
(Choice D) is incorrect: insulin is suppressed, not released, during acute stress; epinephrine, not insulin, governs this response, and rapid ketogenesis is not the acute mechanism.

This item rewards Skill 2 (reasoning) by asking the student to integrate the coordinated liver-and-adipose actions of a single stress hormone.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'anabolic storage attributed to a catabolic stress hormone' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'muscle glycogen raises blood glucose despite lacking glucose-6-phosphatase' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'insulin treated as the acute stress hormone' FROM q;

-- Q40 [F18 · Exercise & Scenario Integration] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'After a protein-rich meal, the liver is actively synthesizing glycogen and exporting triacylglycerol as VLDL, yet it meets most of its own ATP needs by oxidizing amino acids rather than the glucose or fatty acids it is processing. Which rationale best explains this arrangement?', '[{"label": "A", "text": "While insulin is elevated, hepatocytes cannot oxidize glucose or fatty acids, so amino acids are the only fuel available"}, {"label": "B", "text": "Amino acid oxidation yields far more ATP per carbon than glucose or fatty acids, making it the efficient choice"}, {"label": "C", "text": "The liver lacks the enzymes for glycolysis and beta-oxidation, forcing reliance on amino acid catabolism"}, {"label": "D", "text": "Burning the excess dietary amino acids lets the liver reserve glucose and fat for storage and export to other tissues"}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the fed liver is committed to storing and exporting carbohydrate and fat for the rest of the body, so burning the abundant incoming amino acids for its own ATP lets it avoid consuming the very glucose and fat it is packaging as glycogen and VLDL.

(Choice D) is correct: oxidizing surplus dietary amino acids spares glucose and fat for storage and export, matching the liver''s role as the body''s fuel-distribution hub.
(Choice A) is incorrect: insulin does not block hepatic oxidation of glucose or fatty acids; the liver is able to oxidize them but preferentially spares them for other tissues.
(Choice B) is incorrect: amino acids are not more energy-dense per carbon than fatty acids; the logic here is sparing-for-export, not a superior ATP yield.
(Choice C) is incorrect: the liver is fully equipped for glycolysis and beta-oxidation; it simply chooses to reserve those substrates rather than lacking the machinery.

This item rewards Skill 2 (reasoning) by requiring the student to explain a fed-state choice from the liver''s whole-body storage-and-export role.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'insulin assumed to block all hepatic glucose and fat oxidation' FROM q
  UNION ALL
  SELECT id, 'B', 'scale_unit_error', 'amino acids treated as a more energy-dense fuel per carbon' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'liver claimed to lack glycolysis and beta-oxidation enzymes' FROM q;

-- Q41 [F19 · Exercise & Scenario Integration] hard skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'A patient with type 1 diabetes accidentally injects too much insulin, and blood glucose begins falling toward hypoglycemic levels. Which statement best captures the coordinated counter-regulatory response and why it must act quickly?', '[{"label": "A", "text": "Glucagon and epinephrine drive hepatic glycogenolysis and gluconeogenesis to restore blood glucose, because the brain normally depends on glucose and cannot switch to ketones within minutes"}, {"label": "B", "text": "Insulin secretion increases to accelerate hepatic glucose output and resupply the brain"}, {"label": "C", "text": "The brain immediately switches to oxidizing plasma free fatty acids, so restoring blood glucose is not time-critical"}, {"label": "D", "text": "Rising cortisol stimulates muscle glycogenolysis to release free glucose directly into the blood for the brain"}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because a falling glucose is sensed by hypothalamic (and pancreatic) centers that drive glucagon and epinephrine, which stimulate hepatic glycogenolysis and gluconeogenesis; the response is urgent because the brain relies on glucose minute-to-minute and needs days—not minutes—to adapt to ketones.

(Choice A) is correct: it links the counter-regulatory hormones to hepatic glucose output and explains the urgency through the brain''s acute glucose dependence.
(Choice B) is incorrect: insulin lowers blood glucose and would deepen the hypoglycemia; it is suppressed, not raised, in this response.
(Choice C) is incorrect: free fatty acids do not cross the blood-brain barrier, so the brain cannot switch to them acutely — which is precisely why restoring glucose is time-critical.
(Choice D) is incorrect: skeletal muscle lacks glucose-6-phosphatase and cannot release free glucose into the blood; only the liver (and kidney) can do so.

This item rewards Skill 2 (reasoning) by requiring the student to assemble the hormonal, hepatic, and neurological pieces of the hypoglycemia defense into a coherent, time-sensitive response.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'insulin cast as a counter-regulatory hormone' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'brain assumed to oxidize fatty acids acutely' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'muscle glycogen assumed to release free blood glucose' FROM q;

-- Q42 [F20 · Exercise & Scenario Integration] medium skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'An endurance cyclist who last ate 5 hours ago is 3 hours into a hard ride. Blood drawn mid-ride shows low insulin; elevated glucagon and epinephrine; elevated free fatty acids and glycerol; rising lactate; and only slightly reduced blood glucose. Which description best integrates the dominant fuel logic across this athlete''s tissues?', '[{"label": "A", "text": "The elevated free fatty acids are taken up by the brain and red blood cells, which oxidize them to spare the remaining blood glucose for muscle"}, {"label": "B", "text": "Glucagon and epinephrine sustain blood glucose via hepatic glycogenolysis and gluconeogenesis, while adipose lipolysis feeds fatty acids that working muscle oxidizes"}, {"label": "C", "text": "Rising insulin is recruiting GLUT4 and stimulating hepatic glycogen synthesis, so the athlete''s tissues are shifting into an anabolic, fuel-storage mode"}, {"label": "D", "text": "Working muscle exports free glucose into the blood through its glucose-6-phosphatase, supplying the liver with the gluconeogenic substrate it needs for the Cori cycle"}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the panel—low insulin with high glucagon and epinephrine, elevated free fatty acids and glycerol, rising lactate, and near-normal blood glucose—describes the counter-regulatory, fuel-mobilizing state of prolonged exercise: adipose lipolysis feeds fatty acids to working muscle whose own glycogen is falling, while the liver holds blood glucose steady through glycogenolysis and gluconeogenesis using Cori-cycle lactate and glycerol.

(Choice B) is correct: it links the low-insulin, high-glucagon-and-epinephrine signal to hepatic glucose output and adipose lipolysis, and to the endurance muscle''s shift toward fat oxidation, integrating hormones, fuels, and tissues.
(Choice A) is incorrect: the brain cannot oxidize fatty acids because they do not cross the blood-brain barrier, and red blood cells have no mitochondria, so neither tissue can burn the elevated free fatty acids.
(Choice C) is incorrect: insulin is low, not rising, so the anabolic, GLUT4-recruiting, glycogen-storing fed pattern is exactly the state being suppressed here.
(Choice D) is incorrect: skeletal muscle lacks glucose-6-phosphatase and cannot release free glucose, and the Cori cycle runs the other way—muscle exports lactate to the liver, which makes the glucose.

This item rewards Skill 4 (data-based reasoning) by requiring the student to read the hormone and metabolite panel, identify the exercise fuel-mobilization state, and integrate the fuel choices of liver, adipose, and muscle.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'elevated fatty acids assumed usable by brain and red blood cells' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'anabolic fed/insulin storage pattern applied during fuel-mobilizing exercise' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'muscle assumed to release free glucose via glucose-6-phosphatase, with Cori cycle reversed' FROM q;

-- Q43 [F21 · Exercise & Scenario Integration] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Exercise & Scenario Integration', 'A subject who has fasted for two days eats a large carbohydrate meal. Blood glucose rises and insulin surges. Which coordinated set of changes marks the reversal from the catabolic fasting state to an anabolic fed state?', '[{"label": "A", "text": "Gluconeogenesis and lipolysis accelerate while glycogen and fat synthesis remain suppressed"}, {"label": "B", "text": "Hepatic ketogenesis increases to clear the incoming glucose load"}, {"label": "C", "text": "Glycogen and triacylglycerol synthesis resume while gluconeogenesis and lipolysis are shut down"}, {"label": "D", "text": "Glucagon rises alongside insulin so the two jointly promote hepatic glycogen storage"}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because the insulin surge after refeeding is the master anabolic signal: it switches on glycogen and triacylglycerol synthesis and simultaneously switches off the fasting programs of gluconeogenesis and lipolysis, reversing catabolism to anabolism.

(Choice C) is correct: resumed glycogen and triacylglycerol synthesis with gluconeogenesis and lipolysis shut down is the defining catabolic-to-anabolic reversal that insulin produces.
(Choice A) is incorrect: it keeps the fasting (catabolic) program running, which is exactly what the insulin surge terminates.
(Choice B) is incorrect: high insulin suppresses ketogenesis, so ketone production falls, not rises, upon refeeding; ketogenesis also does not dispose of a glucose load.
(Choice D) is incorrect: glucagon falls as insulin rises — the two hormones oppose each other — and glucagon drives glycogenolysis, not storage, so it does not co-drive glycogen storage here.

This item rewards Skill 2 (reasoning) by asking the student to trace how a single hormonal signal flips the direction of multiple pathways at once.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'catabolic fasting program persists after refeeding' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'refeeding assumed to raise ketogenesis' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'glucagon and insulin assumed to rise and cooperate' FROM q;

-- Q44 [G1 · Insulin & Glucagon] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'Shortly after a carbohydrate-rich meal, blood glucose rises and the pancreas releases insulin. Within the hepatocyte, insulin activates glucokinase and glycogen synthase while inhibiting glycogen phosphorylase and glucose-6-phosphatase. Which explanation best accounts for how these four coordinated enzyme changes together produce net hepatic glycogen storage?', '[{"label": "A", "text": "This is the enzyme pattern glucagon imposes during a fast: the liver breaks glycogen down and dephosphorylates glucose-6-phosphate so free glucose can be exported, raising blood glucose."}, {"label": "B", "text": "Free glucose entering the hepatocyte polymerizes directly into glycogen; because glucokinase is held inactive, the glucose is never phosphorylated and therefore cannot leak back out, which is what favors storage."}, {"label": "C", "text": "Net glycogen storage results solely from activating glycogen synthase; the changes to glucokinase, phosphorylase, and glucose-6-phosphatase are incidental and do not affect the direction of glycogen metabolism."}, {"label": "D", "text": "Glucokinase traps incoming glucose as glucose-6-phosphate and glycogen synthase channels it into glycogen, while inhibited glycogen phosphorylase halts breakdown and inhibited glucose-6-phosphatase blocks glucose export — so net flux runs toward glycogen storage."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because after a carbohydrate meal the hepatocyte''s job is to convert incoming glucose into stored glycogen, and insulin''s four enzyme changes all push flux in that single direction. Activated glucokinase phosphorylates glucose to glucose-6-phosphate, trapping it inside the cell; activated glycogen synthase incorporates that glucose-6-phosphate (carried by UDP-glucose) into glycogen; inhibited glycogen phosphorylase can no longer break glycogen back down; and inhibited glucose-6-phosphatase can no longer regenerate free glucose for export. The combined result is net glycogen synthesis with glucose held inside the liver.

(Choice A) is incorrect: this describes the fasting, glucagon-driven pattern — glycogen breakdown plus dephosphorylation of glucose-6-phosphate so free glucose can leave the cell. Insulin, released when blood glucose is high, runs the opposite program of storage, not mobilization.

(Choice B) is incorrect: glucokinase is activated, not held inactive, and free glucose cannot polymerize into glycogen directly. Glucose must first be phosphorylated to glucose-6-phosphate before glycogen synthase can add it, and that phosphorylation by glucokinase is exactly what traps the glucose in the cell.

(Choice D) is correct: glucokinase traps glucose as glucose-6-phosphate, glycogen synthase channels it into glycogen, inhibited phosphorylase halts breakdown, and inhibited glucose-6-phosphatase blocks glucose export — four changes converging on net glycogen storage.

(Choice C) is incorrect: activating glycogen synthase alone would be undercut if phosphorylase kept degrading glycogen and glucose-6-phosphatase kept exporting glucose. The net direction is set by all four coordinated changes acting together, not by glycogen synthase in isolation.

This question rewards Skill 2 (reasoning): you had to trace how several coordinated enzyme changes combine to determine the net direction of hepatic glycogen metabolism rather than recall a single fact.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Assigns the insulin fed-state enzyme pattern the glucagon fasting direction' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'Believes glucokinase is inhibited and free glucose polymerizes without phosphorylation' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Credits only glycogen synthase, ignoring the coordinated trapping and anti-breakdown steps' FROM q;

-- Q45 [G2 · Insulin & Glucagon] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'A patient''s blood is drawn 90 minutes after a large mixed meal, and insulin is high. Considering insulin''s coordinated actions on lipid metabolism — its effects on lipoprotein lipase, adipose lipolysis, hepatic and adipose lipogenesis, and ketone-body formation — which set of changes best describes the direction of lipid handling in this fed, high-insulin state?', '[{"label": "A", "text": "Lipoprotein lipase activity is increased (clearing triacylglycerols from circulating VLDL and chylomicrons), triacylglycerol synthesis (lipogenesis) is promoted in adipose and liver, adipose lipolysis is suppressed, and hepatic ketone-body formation is lowered — the net direction is fat storage."}, {"label": "B", "text": "Lipoprotein lipase is suppressed, adipose lipolysis is accelerated to release free fatty acids, and the liver ramps up ketone-body production — the net direction is fat mobilization to supply fuel."}, {"label": "C", "text": "Adipose lipolysis is suppressed and lipogenesis is promoted, but lipoprotein lipase is simultaneously inhibited so that circulating VLDL and chylomicron triacylglycerols are left in the blood rather than cleared."}, {"label": "D", "text": "Lipoprotein lipase is increased and lipogenesis promoted, but hepatic ketone-body formation also rises because the newly stored fat is immediately oxidized in the liver to ketones."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because a high insulin level signals the fed state, and insulin directs lipids toward storage on every front. It raises lipoprotein lipase activity so that triacylglycerols in circulating VLDL and chylomicrons are hydrolyzed and their fatty acids taken up; it promotes triacylglycerol synthesis (lipogenesis) in adipose tissue and liver; it suppresses adipose lipolysis so stored fat is not released; and it lowers hepatic ketone-body formation. Together these move lipid into storage.

(Choice A) is correct: increased lipoprotein lipase, promoted lipogenesis, suppressed lipolysis, and reduced ketogenesis are the coordinated fed-state actions, and their net direction is fat storage.

(Choice B) is incorrect: suppressed lipoprotein lipase, accelerated lipolysis, and increased ketogenesis are the low-insulin, high-glucagon fasting pattern of fat mobilization — the opposite of what a high-insulin state produces.

(Choice C) is incorrect: insulin increases, not inhibits, lipoprotein lipase; leaving VLDL and chylomicron triacylglycerols uncleared would contradict insulin''s role in delivering those fatty acids to tissues for storage.

(Choice D) is incorrect: insulin lowers ketone-body formation. It would be self-contradictory for the liver to store fat while simultaneously oxidizing it to ketones; ketogenesis rises in the fasting state, not the fed state.

This question rewards Skill 2 (reasoning): from a described high-insulin state you had to deduce the coordinated direction of lipid handling across several tissues, not restate a definition.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Gives the fasting fat-mobilization direction for a fed, high-insulin state' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'Right on storage but wrongly keeps lipoprotein lipase inhibited so lipoproteins aren''t cleared' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'Correct storage direction but adds simultaneous ketogenesis, contradicting insulin''s ketone suppression' FROM q;

-- Q46 [G3 · Insulin & Glucagon] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'A healthy person drinks a glucose solution and blood glucose climbs. Given that plasma glucose concentration is the principal controller of insulin secretion, which sequence best describes what follows and returns blood glucose toward baseline?', '[{"label": "A", "text": "The rising glucose enters muscle and adipose cells by simple diffusion down its gradient; insulin is released only later, after glucose has already fallen, to end the response."}, {"label": "B", "text": "The beta cells of the pancreatic islets sense the elevated plasma glucose and secrete insulin in proportion to it; insulin then drives GLUT4-mediated glucose uptake into muscle and adipose tissue, returning blood glucose toward baseline."}, {"label": "C", "text": "The elevated glucose suppresses beta-cell insulin output; with insulin low, muscle and adipose take up the excess glucose on their own, returning blood glucose to baseline."}, {"label": "D", "text": "The alpha cells sense the elevated plasma glucose and secrete glucagon, which drives glucose uptake into muscle and adipose tissue to lower blood glucose."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because plasma glucose is the principal trigger for insulin secretion, so a glucose load sets off a sense-and-respond loop. The beta cells of the pancreatic islets detect the elevated glucose and secrete insulin roughly in proportion to it. Insulin then recruits GLUT4 transporters in resting skeletal muscle and adipose tissue, increasing glucose uptake into those insulin-dependent tissues and bringing blood glucose back toward baseline.

(Choice A) is incorrect: resting muscle and adipose are insulin-dependent tissues — they take up glucose through GLUT4 only after insulin recruits those transporters to the membrane, so uptake is not simple diffusion that precedes insulin release.

(Choice B) is correct: beta cells sense the rise in glucose, secrete insulin in proportion to it, and the insulin drives GLUT4-mediated uptake into muscle and adipose, lowering blood glucose.

(Choice C) is incorrect: a rise in glucose stimulates insulin secretion, it does not suppress it. And insulin-dependent tissues cannot clear the glucose load on their own without insulin to mobilize GLUT4.

(Choice D) is incorrect: the beta cells and insulin, not the alpha cells and glucagon, respond to high glucose. Glucagon is released when glucose is low and would raise, not lower, blood glucose.

This question rewards Skill 2 (reasoning): you had to assemble the correct causal chain from a glucose rise to insulin release to tissue uptake, rather than recall an isolated fact.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Thinks insulin-dependent tissues take up glucose without insulin, insulin acting only afterward' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'Inverts secretion control, claiming high glucose lowers insulin' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'Substitutes alpha cells and glucagon for beta cells and insulin' FROM q;

-- Q47 [G4 · Insulin & Glucagon] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'Twelve hours into an overnight fast, blood glucose has begun to fall and glucagon is elevated. Acting on the hepatocyte, how does glucagon coordinate the liver''s output to defend blood glucose as the fast continues?', '[{"label": "A", "text": "Glucagon drives glycogenolysis to release stored glucose (activating glycogen phosphorylase), but it does not engage gluconeogenesis; once liver glycogen is exhausted, hepatic glucose output ceases entirely."}, {"label": "B", "text": "Glucagon stimulates glycogen synthesis and lipogenesis in the liver (activating glycogen synthase), storing the incoming fuel so a steady reserve is available as the fast continues."}, {"label": "C", "text": "Glucagon simultaneously activates glycogenolysis, gluconeogenesis (via PEP carboxykinase and fructose-1,6-bisphosphatase), and ketogenesis — together sustaining hepatic glucose output."}, {"label": "D", "text": "Glucagon promotes gluconeogenesis (via PEP carboxykinase) and ketogenesis but inhibits glycogen phosphorylase, so glycogen is spared while new glucose is built from amino acids."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because during a fast the liver must keep exporting glucose, and glucagon coordinates three hepatic programs to do so. It activates glycogenolysis to release stored glucose immediately; it stimulates gluconeogenesis, building new glucose from precursors through key enzymes such as PEP carboxykinase and fructose-1,6-bisphosphatase; and it drives ketogenesis, supplying ketone bodies as an alternative fuel that spares glucose for the brain. These act together to sustain hepatic glucose output.

(Choice A) is incorrect: it correctly has glucagon turning on glycogenolysis via glycogen phosphorylase, but glucagon also engages gluconeogenesis. If output depended on glycogen alone it would fail once glycogen ran out; gluconeogenesis lets the liver keep producing glucose deep into a fast.

(Choice B) is incorrect: glycogen synthesis and lipogenesis (and activation of glycogen synthase) are insulin''s fed-state storage actions. During a fast glucagon does the opposite — it mobilizes fuel rather than storing it.

(Choice D) is incorrect: it is right that glucagon promotes gluconeogenesis (via PEP carboxykinase) and ketogenesis, but glucagon ACTIVATES glycogen phosphorylase rather than inhibiting it, so glycogen is mobilized, not spared.

(Choice C) is correct: simultaneous glycogenolysis, gluconeogenesis, and ketogenesis are the coordinated hepatic response to glucagon that defends blood glucose through a fast.

This question rewards Skill 2 (reasoning): you had to integrate three coordinated hepatic pathways into a single fasting output rather than recall one pathway.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'Captures glycogenolysis but omits gluconeogenesis, so output wrongly stops when glycogen runs out' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'Assigns glucagon insulin''s anabolic storage actions (glycogen synthesis, lipogenesis, glycogen synthase activation)' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'Correct on gluconeogenesis and ketones but wrongly has glucagon inhibiting rather than activating glycogen phosphorylase' FROM q;

-- Q48 [G5 · Insulin & Glucagon] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'During a fast, glucagon raises blood glucose by mobilizing liver glycogen, yet the large glycogen stores in skeletal muscle contribute essentially no free glucose to the bloodstream. Which explanation best accounts for this difference?', '[{"label": "A", "text": "Muscle glycogen is a chemically distinct polymer that muscle phosphorylase cannot break down, so glucagon has no glycogen to act on in muscle."}, {"label": "B", "text": "Glucagon acts as strongly on muscle as on liver, but the myocyte immediately burns any liberated glucose for contraction, leaving none to export."}, {"label": "C", "text": "Muscle responds to glucagon as strongly as the liver and exports its glucose-6-phosphate to the liver, which dephosphorylates it and releases the resulting free glucose."}, {"label": "D", "text": "The hepatocyte is glucagon''s main target, and only the liver has glucose-6-phosphatase, so muscle cannot dephosphorylate its glycogen-derived glucose-6-phosphate for export."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because two facts together explain why only the liver defends blood glucose. First, glucagon''s primary target is the hepatocyte, not the myocyte, so glucagon drives glycogenolysis chiefly in the liver. Second, the liver contains glucose-6-phosphatase and can dephosphorylate glucose-6-phosphate to free glucose for export, whereas skeletal muscle lacks this enzyme — so even when muscle glycogen is broken down, the glucose-6-phosphate stays trapped inside the cell and is oxidized internally rather than released to the blood.

(Choice A) is incorrect: muscle glycogen is the same molecule as liver glycogen and is readily cleaved by muscle glycogen phosphorylase. The barrier is the missing glucose-6-phosphatase and muscle''s lack of glucagon responsiveness, not any difference in the glycogen itself.

(Choice B) is incorrect: skeletal muscle is not a significant glucagon target (it lacks glucagon receptors). Muscle-derived glucose stays internal because muscle has no glucose-6-phosphatase, not because a strong glucagon signal is being consumed by contraction. Note also that muscle glycogenolysis liberates glucose-6-phosphate, not free glucose.

(Choice D) is correct: the hepatocyte is glucagon''s primary target and the liver alone has glucose-6-phosphatase to release free glucose, while muscle lacks that enzyme and cannot export glucose derived from its glycogen.

(Choice C) is incorrect on two counts. Muscle is not a strong glucagon target — the hepatocyte is — so glucagon does not drive muscle glycogenolysis the way it drives the liver''s. Just as importantly, phosphorylated glucose-6-phosphate is not shuttled out of the myocyte to the liver; charged phosphosugars do not cross the membrane, and muscle instead keeps its glucose-6-phosphate for in-situ glycolysis. The carbon that muscle does hand to the liver travels as lactate (Cori cycle) or alanine (glucose-alanine cycle), not as glucose-6-phosphate.

This question rewards Skill 2 (reasoning): you had to combine target specificity with a tissue-specific enzyme difference to explain why only the liver defends blood glucose.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'Invents a chemical difference in muscle glycogen instead of the receptor and enzyme basis' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'Claims muscle is a strong glucagon target that simply burns the glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Invents a phosphosugar export pathway shuttling muscle glucose-6-phosphate to the liver' FROM q;

-- Q49 [G6 · Insulin & Glucagon] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'In hepatocytes, glycolysis and gluconeogenesis oppose each other at one step. Phosphofructokinase-1 (PFK-1) catalyzes the glycolytic reaction fructose-6-phosphate + ATP → fructose-1,6-bisphosphate + ADP (favored by insulin), while fructose-1,6-bisphosphatase (FBPase-1) catalyzes the gluconeogenic reverse reaction fructose-1,6-bisphosphate + H2O → fructose-6-phosphate + Pi (favored by glucagon). Insulin and glucagon normally control these two enzymes reciprocally. If a hepatocyte had both enzymes fully active at the same time, what would be the net metabolic result, and why does reciprocal control normally prevent it?', '[{"label": "A", "text": "Fructose-6-phosphate would be cycled to fructose-1,6-bisphosphate and back with no net product, yet each turn hydrolyzes one ATP to ADP + Pi as heat; reciprocal control prevents this futile cycle."}, {"label": "B", "text": "The ATP that PFK-1 spends would be recaptured when FBPase-1 runs the reverse reaction, so the cycle is energy-neutral with no net product; reciprocal control only sets the direction of carbon flow."}, {"label": "C", "text": "Running both would roughly double glycolytic flux and yield extra ATP from the additional fructose-1,6-bisphosphate; reciprocal control exists mainly to keep glycolysis from outrunning the electron transport chain."}, {"label": "D", "text": "The two opposing reactions would quickly reach equilibrium and stop with no ATP consumed; reciprocal control merely accelerates whichever direction is thermodynamically favored at the moment."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because summing the two supplied reactions shows that a fructose-6-phosphate molecule is pushed forward to fructose-1,6-bisphosphate by PFK-1 and then hydrolyzed straight back to fructose-6-phosphate by FBPase-1, leaving no net change in the carbon metabolite. Adding the two equations, the only net transformation is \(\text{ATP} + \text{H}_2\text{O} \rightarrow \text{ADP} + \text{P}_i\): one ATP is hydrolyzed per cycle and its energy is released as heat. Running both enzymes together therefore accomplishes nothing but ATP waste — a futile (substrate) cycle. Reciprocal control, in which insulin turns PFK-1 on while turning FBPase-1 off (and glucagon does the reverse), keeps the two enzymes from being fully active at once, so the cell nets flux in a single direction without burning ATP for no product.

(Choice A) is correct: the carbon is cycled with no net product while each turn nets the hydrolysis of one ATP to ADP + Pi, dissipating energy as heat, which reciprocal control exists to prevent.

(Choice B) is incorrect: FBPase-1 hydrolyzes the C1 phosphate and releases inorganic phosphate; it does not run PFK-1 in reverse and cannot regenerate ATP. Only substrate-level or oxidative phosphorylation makes ATP, so the ATP PFK-1 spends is lost, not recaptured — the cycle is energy-consuming, not energy-neutral.

(Choice C) is incorrect: FBPase-1 is a gluconeogenic enzyme that opposes PFK-1, so having both active cancels net flux rather than doubling glycolysis, and the shared step consumes ATP rather than yielding extra ATP.

(Choice D) is incorrect: each of these reactions is strongly exergonic and effectively irreversible in its own direction, so they do not settle at equilibrium and stop — they keep turning and keep hydrolyzing ATP. Reciprocal control works by switching one enzyme off, not by speeding a thermodynamically favored direction.

This question rewards Skill 2 (reasoning): you had to add the two supplied reaction equations, recognize that the carbon metabolite is unchanged while one ATP is hydrolyzed each cycle, identify that as a futile cycle, and infer why reciprocal hormonal control exists to prevent it.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'Treats FBPase-1 as running PFK-1 in reverse and regenerating ATP, making the cycle energy-neutral instead of ATP-consuming' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Assumes both enzymes active adds to glycolysis and makes extra ATP, ignoring that FBPase-1 opposes PFK-1' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Right that there is no net product but wrongly concludes the reactions equilibrate and stop with no ATP spent' FROM q;

-- Q50 [G7 · Insulin & Glucagon] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'As a person moves from the fed, absorptive state into a fast, blood glucose gradually falls and the pancreatic islet reprograms the whole body from fuel storage toward fuel mobilization. Within a single islet, insulin-secreting beta cells and glucagon-secreting alpha cells sit side by side and both respond to blood glucose. Which feature of the islet best explains how it acts as the body''s master fed-versus-fasted sensor?', '[{"label": "A", "text": "As glucose falls, beta cells instead raise their insulin output while alpha cells lower their glucagon output, so it is a rising insulin-to-glucagon ratio that commands the liver to switch over to mobilizing its stored fuel."}, {"label": "B", "text": "The same falling glucose drives the two cell types oppositely — beta-cell insulin falls while alpha-cell glucagon rises — so one signal swings the insulin-to-glucagon ratio toward glucagon and flips the liver from storage to output."}, {"label": "C", "text": "Falling glucose makes both alpha and beta cells secrete more at once, so insulin and glucagon climb together, and it is this rise in the islet''s total hormone output — rather than any change in their ratio — that registers the onset of the fast."}, {"label": "D", "text": "Only the beta cells actually sense glucose; alpha-cell glucagon holds essentially constant across the transition, so the shift toward mobilization is produced entirely by the withdrawal of insulin, with the reciprocal rise in glucagon contributing nothing."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the pancreatic islet places two glucose-responsive cell types side by side and wires them to the same signal in opposite directions. As blood glucose falls across the fed-to-fasted transition, the beta cells sense the drop and cut insulin secretion, while the alpha cells respond to that same fall by increasing glucagon secretion. Because one input moves the two hormones in opposite directions, the insulin-to-glucagon ratio swings sharply and unambiguously toward glucagon — and it is that ratio, not either hormone alone, that flips the liver out of anabolic storage and into catabolic mobilization. This reciprocal, ratio-based readout of a single blood-glucose signal is exactly what lets the islet serve as the body''s master fed-versus-fasted sensor.

(Choice B) is correct: the same falling glucose lowers beta-cell insulin and raises alpha-cell glucagon, so one signal drives the insulin-to-glucagon ratio toward glucagon and switches the liver from storage to output.

(Choice A) is incorrect: it reverses the direction of both hormones. In the fed state insulin is high and glucagon low; as glucose FALLS insulin drops and glucagon rises, so the fasting signal is a FALLING insulin-to-glucagon ratio. A rising ratio would command storage, not mobilization.

(Choice C) is incorrect: alpha and beta cells do not both increase their output together — if they did, the two opposing hormones would tend to cancel. Their reciprocal movement (insulin down, glucagon up) is precisely what makes the ratio, rather than the total amount of islet hormone, the meaningful fed/fasted signal.

(Choice D) is incorrect: insulin withdrawal is only half of the switch. Alpha cells actively raise glucagon as glucose falls, and this reciprocal rise is needed to drive hepatic glucose output, so glucagon is not a passive constant across the transition.

This question rewards Skill 2 (reasoning): you had to see that two cell types reading one glucose signal in opposite directions turn the insulin-to-glucagon ratio into a bidirectional fed/fasted switch, rather than recall a single hormone''s action.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Reverses the direction of both hormones, having insulin rise and glucagon fall as glucose drops' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'Denies islet reciprocity, having both cells raise output so total hormone rather than the ratio signals the fast' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'Keeps only insulin withdrawal and treats alpha-cell glucagon as an unchanging constant, dropping the reciprocal rise' FROM q;

-- Q51 [G8 · Insulin & Glucagon] hard skill4 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Insulin & Glucagon', 'An investigator records plasma insulin and glucagon in one subject at two moments:

| Time point | Insulin | Glucagon | Insulin-to-glucagon ratio |
| --- | --- | --- | --- |
| I — after a meal | 60 µU/mL | 40 pg/mL | high |
| II — 18-hour fast | 5 µU/mL | 120 pg/mL | low |

Hepatic glycogen synthase and glycogen phosphorylase are under reciprocal covalent control, with phosphorylation activating phosphorylase and inactivating synthase. Using the data at time point II, which prediction of the two enzymes'' activities and the net direction of glycogen metabolism is correct?', '[{"label": "A", "text": "The low insulin-to-glucagon ratio means insulin dominates; glycogen synthase is active and phosphorylase inactive, so the liver is net synthesizing glycogen."}, {"label": "B", "text": "Glucagon dominates and phosphorylates the enzymes, but phosphorylation activates glycogen synthase and inactivates phosphorylase, so the liver is net storing glycogen."}, {"label": "C", "text": "The low insulin-to-glucagon ratio means glucagon dominates and drives phosphorylation; glycogen phosphorylase is active and glycogen synthase inactive, so the liver is net breaking glycogen down."}, {"label": "D", "text": "Both glycogen synthase and glycogen phosphorylase are active because both hormones are present, so synthesis and breakdown proceed at equal rates and there is no net change in glycogen."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because at time point II the insulin-to-glucagon ratio is low, meaning glucagon dominates the liver. Glucagon acts on the hepatocyte through cAMP to drive phosphorylation of the glycogen-handling enzymes, and the stem states that phosphorylation activates glycogen phosphorylase and inactivates glycogen synthase. So at time point II phosphorylase is active and synthase is inactive, and the liver is net breaking glycogen down (glycogenolysis) — the expected response to an 18-hour fast.

(Choice A) is incorrect: a low insulin-to-glucagon ratio means glucagon, not insulin, dominates (insulin is the numerator, so a low ratio reflects low insulin relative to glucagon). The active-synthase, inactive-phosphorylase storage pattern belongs to the high-ratio fed state at time point I, not to the fasting time point II.

(Choice C) is correct: the low ratio makes glucagon dominant, phosphorylation activates phosphorylase and inactivates synthase, and the net direction is glycogen breakdown.

(Choice B) is incorrect: it correctly has glucagon phosphorylating the enzymes but then flips the effect the stem specifies — phosphorylation activates phosphorylase and inactivates synthase, so the result is breakdown, not storage.

(Choice D) is incorrect: reciprocal covalent control holds the two enzymes in opposite activity states, so they are not both active. Simultaneous full synthesis and breakdown would be a futile cycle, which the covalent switch is designed to avoid.

This question rewards Skill 4 (data-based reasoning): you had to read the insulin-to-glucagon ratio from the table, decide which hormone dominates, and apply the stated phosphorylation rule to predict each enzyme''s activity and the net direction of glycogen metabolism.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'Reads the low insulin-to-glucagon ratio as insulin-dominant' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'Correct that glucagon phosphorylates but flips which enzyme each modification activates' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'Treats coexisting hormones as equal, predicting a no-net-change futile cycle' FROM q;

-- Q52 [H9 · Counter-Regulatory Hormones] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'A graduate student endures several weeks of intense, unrelenting psychological stress, during which plasma cortisol stays persistently elevated. Reasoning from cortisol''s coordinated actions on skeletal muscle, adipose tissue, and the liver, which set of changes best describes the net metabolic effect of this sustained cortisol elevation?', '[{"label": "A", "text": "Muscle protein synthesis rises, adipose lipolysis falls, hepatic gluconeogenesis falls, and blood glucose drops."}, {"label": "B", "text": "Muscle protein is broken down and hepatic gluconeogenesis rises, but adipose lipolysis is suppressed, so plasma fatty acids fall."}, {"label": "C", "text": "Adipose lipolysis and hepatic gluconeogenesis both rise, but enhanced peripheral glucose uptake prevents blood glucose from climbing."}, {"label": "D", "text": "Muscle protein is degraded, adipose lipolysis rises, hepatic gluconeogenesis climbs, and peripheral glucose uptake falls, so blood glucose rises."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because sustained stress keeps cortisol chronically elevated, and cortisol''s job is to mobilize fuel and defend blood glucose. It degrades muscle protein to release amino acids, stimulates adipose lipolysis, channels those amino acids into hepatic gluconeogenesis, and inhibits glucose uptake by peripheral tissues. Together these push blood glucose up while raising circulating amino acids and fatty acids.

(Choice D) is correct: it captures all four coordinated actions — proteolysis, lipolysis, hepatic gluconeogenesis, and suppressed peripheral uptake — that jointly elevate blood glucose.
(Choice A) is incorrect: this describes an insulin-like, anabolic profile (protein synthesis, fat storage, lower glucose), the opposite of cortisol''s catabolic, glucose-raising effect.
(Choice B) is incorrect: cortisol does not spare fat; it increases lipolysis, so plasma fatty acids rise rather than fall.
(Choice C) is incorrect: cortisol inhibits peripheral glucose uptake — it does not enhance it — which is one reason blood glucose climbs.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to integrate cortisol''s separate tissue-level actions into a single net metabolic prediction.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'cortisol modeled as anabolic/insulin-like' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'cortisol wrongly spares fat' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'cortisol boosts peripheral glucose uptake' FROM q;

-- Q53 [H10 · Counter-Regulatory Hormones] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'A patient with adrenal insufficiency has very low cortisol. When given a standard dose of glucagon, the patient''s blood glucose rises far less than it does in a healthy person, even though the patient''s plasma glucagon level and hepatic glucagon receptors are normal. Which statement best explains cortisol''s role in this outcome?', '[{"label": "A", "text": "Cortisol need not trigger the response itself, but it must be present for glucagon to act fully."}, {"label": "B", "text": "Cortisol and glucagon compete for the same hepatic receptor, so low cortisol frees more sites for glucagon."}, {"label": "C", "text": "The blunted rise reflects only cortisol''s own missing glucose contribution; glucagon''s effect is fully intact."}, {"label": "D", "text": "Cortisol normally restrains glucagon''s action, so cortisol deficiency should amplify the glucose response."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because the defining feature of a permissive hormone is that it need not initiate a response itself, yet its presence is required for another hormone to act fully. With cortisol deficient, glucagon and its receptors are normal, but glucagon cannot produce its full glycemic effect, so the same dose raises blood glucose far less.

(Choice A) is correct: it states the permissive relationship — cortisol enables glucagon''s full effect without necessarily triggering it.
(Choice B) is incorrect: cortisol (a steroid acting on gene transcription) and glucagon (a peptide acting on a surface cAMP receptor) do not share a receptor, so competition for binding sites is not the mechanism; furthermore, competition would free sites and amplify the response, the opposite of what is observed.
(Choice C) is incorrect: if the deficit were merely cortisol''s own missing glucose contribution, glucagon''s effect would be unchanged; here the measured rise after glucagon is itself diminished, which additive reasoning cannot explain.
(Choice D) is incorrect: cortisol enhances, not restrains, glucagon, so its absence blunts rather than amplifies the response.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to reason from an observed blunted response to the concept of a permissive hormone.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'cortisol and glucagon share a receptor' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'additive contribution, not permissive' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'permissive read as inhibitory' FROM q;

-- Q54 [H11 · Counter-Regulatory Hormones] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'At the sound of the starting gun, a sprinter''s adrenal medulla releases a surge of epinephrine into her bloodstream — even before her leg muscles have begun any heavy contractile work. Apart from its well-known role in mobilizing fuel by activating glycogenolysis and lipolysis, this catecholamine also acts on beta-adrenergic receptors of the sympathetic "fight-or-flight" system to ready the body for the effort ahead. Reasoning from the beta-adrenergic actions of a catecholamine, which statement best explains how epinephrine prepares the sprinter''s body for the physical exertion about to come?', '[{"label": "A", "text": "Epinephrine acts through parasympathetic pathways to slow the heart and reduce cardiac output, conserving oxygen and lowering metabolic rate until the muscles actually begin their heavy contractile work."}, {"label": "B", "text": "Beta-adrenergic stimulation raises heart rate and contractile force, increasing cardiac output, and simultaneously lifts metabolic rate, so more oxygen-rich blood and heat reach the tissues for the coming exertion."}, {"label": "C", "text": "Beta-adrenergic stimulation speeds the heart and raises cardiac output, but it leaves whole-body metabolic rate and oxygen consumption completely unchanged, so no additional heat is generated during the stress response."}, {"label": "D", "text": "Epinephrine enters cardiac muscle cells and acts through a slow genomic mechanism, driving synthesis of new contractile proteins over several hours to gradually strengthen each future heartbeat."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because epinephrine is a catecholamine of the sympathetic fight-or-flight response, and its beta-adrenergic actions ready the body for exertion in two complementary ways. Acting on beta-1 receptors in the heart, it increases heart rate (positive chronotropy) and contractile force (positive inotropy); because cardiac output equals heart rate times stroke volume, both effects together raise cardiac output and deliver more oxygenated blood to the muscles each minute. Acting through beta-adrenergic stimulation more broadly, it also raises basal metabolic rate, increasing whole-body oxygen consumption and heat production (thermogenesis). Because catecholamines signal through fast cell-surface receptors and cAMP rather than slow gene transcription, these changes develop within seconds, well before the leg muscles begin heavy work.

(Choice B) is correct: raising heart rate and contractility increases cardiac output while a higher metabolic rate raises oxygen consumption and heat, so the cardiovascular and thermogenic arms of the sympathetic response prime the body for imminent work.
(Choice A) is incorrect: epinephrine drives the sympathetic, not the parasympathetic, response; it speeds and strengthens the heartbeat and raises metabolic rate rather than slowing the heart and conserving energy — the direction of every effect is reversed here.
(Choice C) is incorrect: it correctly captures the rise in cardiac output but wrongly denies the thermogenic effect. Catecholamines raise basal metabolic rate, so oxygen consumption and heat production climb rather than staying unchanged.
(Choice D) is incorrect: epinephrine is a fast-acting amine that works through rapid beta-adrenergic cell-surface signaling, not a slow genomic mechanism. New contractile-protein synthesis would take hours and cannot explain a cardiovascular and metabolic response that appears within seconds of the starting gun.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to reason from the beta-adrenergic sympathetic role of a catecholamine to explain how epinephrine raises cardiac output and metabolic rate to prepare the body for physical exertion.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'sympathetic catecholamine action reversed into parasympathetic slowing of the heart and lowered metabolic rate' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'cardiac-output rise correct but the thermogenic/BMR-raising effect wrongly denied' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'fast beta-adrenergic catecholamine misclassified as a slow genomic/transcriptional signal' FROM q;

-- Q55 [H12 · Counter-Regulatory Hormones] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'A patient develops a thyroid nodule that steadily oversecretes thyroid hormone. Reasoning from thyroid hormone''s core metabolic action, which set of resting changes is expected?', '[{"label": "A", "text": "Resting O2 consumption and heat production both fall, lowering basal metabolic rate."}, {"label": "B", "text": "O2 consumption rises, but heat production falls as the extra energy is stored rather than dissipated."}, {"label": "C", "text": "Resting O2 consumption and heat production both rise, increasing basal metabolic rate."}, {"label": "D", "text": "Basal metabolic rate is unchanged; thyroid hormone instead acts acutely, like epinephrine, to trigger rapid glycogenolysis."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because thyroid hormone''s core metabolic action is to raise basal metabolic rate. When output increases, tissues consume more \(O_2\) and generate more heat, so resting energy expenditure climbs (clinically, heat intolerance and weight loss).

(Choice C) is correct: increased \(O_2\) consumption and heat production are the direct read-outs of a higher basal metabolic rate.
(Choice A) is incorrect: falling \(O_2\) consumption and heat production describe hypothyroidism (reduced output), the opposite of the scenario.
(Choice B) is incorrect: the extra energy of a raised metabolic rate appears largely as heat; \(O_2\) consumption and heat production move together, they do not diverge.
(Choice D) is incorrect: thyroid hormone acts slowly at the level of gene transcription to set metabolic rate; it does not act acutely like epinephrine to trigger glycogenolysis.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to reason from a change in thyroid output to its whole-body metabolic consequence.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'hypothyroid (low-BMR) picture' FROM q
  UNION ALL
  SELECT id, 'B', 'partial_truth', 'energy stored rather than released as heat' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'thyroid acts acutely like a catecholamine' FROM q;

-- Q56 [H13 · Thyroid Hormone Regulation] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Thyroid Hormone Regulation', 'Blood measurements show that the thyroid gland secretes mostly T4 (thyroxine), yet most of the more potent T3 that acts at target tissues is generated outside the gland, and T3''s effects appear and subside faster than those of T4. Which explanation best accounts for the relationship between T4 and T3?', '[{"label": "A", "text": "T4 is the biologically active hormone and T3 is an inactive fragment left over as T4 is degraded, so maintaining T4 is what directly sustains hormone activity in tissues."}, {"label": "B", "text": "The thyroid gland converts T4 to T3 internally before secreting it, so the faster, stronger effects come only from gland-made T3 and peripheral tissues cannot generate active hormone."}, {"label": "C", "text": "T4 and T3 are equally potent and T4 is never converted to T3; target tissues respond directly to circulating T4, so no peripheral processing is involved."}, {"label": "D", "text": "T4 is a longer-acting prohormone that serves as a reservoir, and peripheral tissues convert it to the more active, faster-acting T3, generated mostly outside the gland."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because T4 (thyroxine) is the predominant secreted, longer-acting form that functions as a circulating prohormone reservoir, while peripheral tissues remove one iodine to convert it into the more active, faster-acting T3 — which is exactly why most of the active T3 is generated outside the gland and why its effects turn on and off more quickly than those of the longer-lived T4.

(Choice D) is correct: it captures the prohormone-reservoir model — T4 is the predominant secreted, long-acting form, and deiodination in peripheral tissues (liver, kidney, and others) yields the more potent, faster-acting T3, so most active T3 arises outside the gland and its effects come on and fade quickly.
(Choice A) is incorrect: it reverses which form is active — T3, not T4, is the more potent hormone at the receptor; T4 is the less-active prohormone, and T3 is the product of an activating conversion rather than an inactive degradation fragment.
(Choice B) is incorrect: the T4-to-T3 conversion occurs mainly in peripheral tissues via deiodinase enzymes, not inside the gland before secretion; the gland secretes mostly T4 while target tissues make their own T3, contradicting the claim that peripheral tissues cannot generate active hormone.
(Choice C) is incorrect: T4 and T3 are not equally potent, and T4 is in fact converted to T3 peripherally; treating them as interchangeable and denying any conversion ignores the reservoir/prohormone relationship that lets a steady pool of T4 supply active T3 on demand.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to integrate several observations — that the gland secretes mostly T4, that most active T3 is produced peripherally, and that T3 acts faster — into the prohormone-to-active-hormone relationship between T4 and T3.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'T4/T3 potency inverted — T4 cast as the active hormone and T3 as an inactive breakdown product' FROM q
  UNION ALL
  SELECT id, 'B', 'process_step_confusion', 'T4-to-T3 conversion misplaced inside the gland rather than in peripheral tissues' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'T4 and T3 treated as equipotent with no peripheral conversion' FROM q;

-- Q57 [H14 · Counter-Regulatory Hormones] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'During a near-miss traffic accident, a surge of epinephrine — a catecholamine — floods the driver''s bloodstream as part of the fight-or-flight response. The same stressor also raises cortisol. Which statement best predicts the tempo and tissue pattern by which epinephrine mobilizes fuel?', '[{"label": "A", "text": "It works within seconds, because the hormone acts on cell-surface receptors and cAMP to break down both liver glycogen and adipose fat."}, {"label": "B", "text": "It works over several hours, because the hormone must enter cells and switch on new genes for gluconeogenic enzymes before blood glucose can rise."}, {"label": "C", "text": "It works within seconds through cAMP, but it releases glucose from liver glycogen only and leaves adipose fat stores untouched."}, {"label": "D", "text": "It works within seconds through cAMP, but it drives glucose and fatty acids into storage rather than releasing them into the blood."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because epinephrine is a water-soluble catecholamine that binds cell-surface (beta-adrenergic) receptors and raises cAMP. A second-messenger cascade needs no new gene transcription, so it acts within seconds — the tempo demanded by fight-or-flight — and it simultaneously activates glycogen phosphorylase in the liver and hormone-sensitive lipase in adipose, releasing glucose and free fatty acids at the same time. That fast, cAMP-driven, multi-tissue catabolic profile is the reasoning the scenario asks you to predict.

(Choice A) is correct: a cell-surface receptor plus cAMP means no transcription is required, so fuel is mobilized in seconds, and the catecholamine drives hepatic glycogenolysis and adipose lipolysis together — exactly the pattern that fits an acute stressor.
(Choice B) is incorrect: an hours-long, transcription-dependent tempo describes a slow steroid such as cortisol, which the same stressor also releases; a water-soluble amine cannot act through gene induction and would be far too slow to power fight-or-flight.
(Choice C) is incorrect: the fast cAMP mechanism is right, but restricting fuel release to the hepatocyte describes glucagon; a catecholamine also mobilizes adipose fat (and skeletal-muscle glycogen), so leaving adipose untouched contradicts its role.
(Choice D) is incorrect: the tempo is right, but the direction is reversed — epinephrine mobilizes (releases) fuel into the blood, whereas driving glucose and fatty acids into storage is the anabolic, insulin-directed fed-state response.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) by asking you to reason from a hormone''s chemical class to the tempo and tissue pattern of its metabolic action, and to contrast it with the slower steroid response, rather than recalling where it is made.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'steroid/genomic tempo misapplied to a catecholamine' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'hepatocyte-only mobilization (glucagon pattern)' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'catabolic-to-anabolic direction reversal (insulin pattern)' FROM q;

-- Q58 [H15 · Counter-Regulatory Hormones] hard skill4 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Counter-Regulatory Hormones', 'During the same ordeal, the trapped hiker is monitored continuously and her plasma insulin stays low throughout. Two counter-regulatory hormones are tracked — epinephrine from the adrenal medulla and cortisol from the adrenal cortex (growth hormone rises on a similarly slow timescale) — along with her blood glucose and remaining liver glycogen at three time points after the stress began:

| Time after onset | Epinephrine (× rest) | Cortisol (× rest) | Blood glucose (mg/dL) | Liver glycogen (% of rest) |
|---|---|---|---|---|
| 2 min | 8 | 1 | 120 | 95 |
| 30 min | 5 | 3 | 140 | 60 |
| 3 h | 2 | 6 | 115 | 15 |

Resting blood glucose is about 90 mg/dL. Epinephrine acts within seconds through a cAMP second-messenger cascade, whereas cortisol acts over hours by inducing synthesis of new gluconeogenic enzymes. Which interpretation of this two-phase defense of blood glucose is best supported by the data?', '[{"label": "A", "text": "The 2-minute glucose rise comes from cortisol''s transcriptional induction of gluconeogenic enzymes, while the glucose held at 3 hours reflects the delayed onset of catecholamine-driven hepatic glycogenolysis."}, {"label": "B", "text": "The early glucose reflects fast cAMP-driven catecholamine glycogenolysis, whereas the glucose held at 3 hours, after liver glycogen has fallen, reflects cortisol''s slower transcriptional gluconeogenesis."}, {"label": "C", "text": "Both the early and the 3-hour glucose elevations arise from epinephrine-stimulated glycogenolysis alone; the rising cortisol adds no separate glucose-generating pathway to the response."}, {"label": "D", "text": "Because cortisol is a lipophilic steroid, its gluconeogenic action is complete within seconds, so the 2-minute glucose already comes from cortisol rather than from catecholamines."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the two hormones defend glucose on different timescales through different mechanisms, and the data separate the phases. At 2 minutes epinephrine is 8x above rest while cortisol is still at baseline (1x); blood glucose has already climbed to 120 mg/dL and liver glycogen is nearly full (95%). A fast cAMP cascade driving hepatic glycogenolysis explains this early rise. By 3 hours the picture inverts: epinephrine has fallen to 2x, liver glycogen is nearly gone (15%), yet blood glucose is still elevated (115 mg/dL) and cortisol has peaked at 6x. With glycogen depleted, the sustained glucose cannot come from glycogenolysis; it must come from gluconeogenesis, which cortisol supports slowly by inducing new enzyme synthesis over hours. One stressor, two mechanisms, two timescales.

(Choice B) is correct: it assigns the early glucose to fast catecholamine-driven glycogenolysis and the hours-later glucose (after glycogen falls) to slow cortisol-driven gluconeogenesis, matching the measured hormone kinetics and the glycogen trajectory.
(Choice A) is incorrect: it reverses the timescales. Cortisol is only 1x at 2 minutes and acts by gene transcription over hours, so it cannot produce the immediate rise, and epinephrine is already 8x at 2 minutes, so its action is not delayed.
(Choice C) is incorrect: glycogenolysis alone cannot explain the 3-hour glucose, because liver glycogen has fallen to 15% while blood glucose is still elevated; a gluconeogenic source is required, and cortisol (peaking at 6x) is not incidental.
(Choice D) is incorrect: cortisol is a steroid that acts by inducing enzyme synthesis over hours, not within seconds; the data show it still at baseline (1x) at 2 minutes, so the earliest glucose cannot be cortisol-driven.

This question tests Skill 4 (Data-Based and Statistical Reasoning) by requiring you to read a hormone-and-substrate time course and infer which mechanism defends blood glucose in each phase rather than restating any single value.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'timescales swapped — cortisol fast, catecholamine delayed' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'glycogenolysis alone explains the entire time course' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'steroid cortisol acts within seconds, not over hours' FROM q;

-- Q59 [I16 · Transporters & Signaling] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'During a fast, plasma insulin falls to low levels. A researcher measures glucose uptake across tissues and finds that neurons continue to import glucose at nearly the same rate as in the fed state, whereas resting skeletal muscle sharply reduces its glucose uptake. Which statement best explains this difference?', '[{"label": "A", "text": "Neurons express the high-Km GLUT2 sensor, which only saturates at very high glucose, so the fall in insulin cannot affect them, whereas resting muscle relies on an insulin-dependent GLUT2."}, {"label": "B", "text": "Insulin normally suppresses neuronal glucose uptake, so the fall in insulin during fasting is what keeps the brain importing glucose while muscle uptake declines."}, {"label": "C", "text": "Neurons take up glucose through GLUT1/GLUT3, which are insulin-independent and remain in the membrane regardless of insulin, whereas resting muscle needs insulin to recruit GLUT4 to its surface."}, {"label": "D", "text": "Both tissues take up glucose through GLUT4, but neurons keep more of it in the membrane at rest, making them only slightly sensitive to the drop in insulin."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because when insulin falls during a fast, only tissues whose glucose uptake does not require insulin can keep importing glucose at an unchanged rate. Neurons carry GLUT1 and GLUT3, which sit in the membrane constitutively, so their uptake is indifferent to insulin; resting skeletal muscle relies on insulin to translocate GLUT4 to the cell surface, so its uptake falls as insulin drops.

(Choice A) is incorrect: the brain does not use GLUT2. GLUT2 is the high-Km sensor of the liver and pancreatic beta cell, and resting muscle depends on insulin-dependent GLUT4, not an insulin-dependent GLUT2.
(Choice C) is correct: GLUT1/GLUT3 are insulin-independent and always present, so neuronal uptake persists as insulin falls, whereas muscle GLUT4 must be recruited by insulin and therefore declines during the fast.
(Choice B) is incorrect: insulin does not suppress neuronal uptake; the brain is simply indifferent to insulin, so falling insulin neither drives nor blocks its glucose entry.
(Choice D) is incorrect: neurons do not use GLUT4, so their steady uptake cannot be explained by retaining GLUT4 in the membrane.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it requires reasoning from a described metabolic state (falling insulin during a fast) to which transporter systems are affected, rather than recalling a transporter label.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'brain uses GLUT2 sensor' FROM q
  UNION ALL
  SELECT id, 'B', 'reversed_relationship', 'insulin inhibits brain uptake' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'both tissues use GLUT4' FROM q;

-- Q60 [I17 · Transporters & Signaling] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'In a hepatocyte, glucagon and insulin change the activity of the same set of metabolic enzymes within seconds to minutes, and the changes can be undone just as quickly, all without altering the amount of enzyme present. Which mechanism best accounts for this rapid, reversible switching?', '[{"label": "A", "text": "Each hormone induces transcription of new enzyme isoforms with different activities, which replace the old enzymes within minutes."}, {"label": "B", "text": "Glucagon and insulin enter the hepatocyte and bind the metabolic enzymes directly, acting as allosteric effectors."}, {"label": "C", "text": "The cascades work by degrading the existing enzymes, so any change in activity persists until the enzymes are resynthesized."}, {"label": "D", "text": "Both hormones act through cell-surface receptors whose cascades add and remove phosphate groups on enzymes that are already present, and this covalent modification is readily reversible."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the observations — a change in seconds, no change in enzyme amount, and rapid reversibility — point to covalent modification of pre-existing enzymes. Insulin acts through a receptor tyrosine kinase and glucagon through a GPCR/cAMP cascade, and both converge on adding or removing phosphate groups. Because phosphate can be put on and taken off, the same enzyme is toggled between active and inactive states almost instantly.

(Choice A) is incorrect: making new enzyme by transcription and translation takes hours and would change the amount of enzyme, contradicting the fast, amount-neutral switching described.
(Choice B) is incorrect: glucagon and insulin are water-soluble peptides that do not cross the membrane; they act through surface receptors, not by entering and binding enzymes directly. The true allosteric effectors of these enzymes are small metabolites, not the hormones themselves.
(Choice D) is correct: reversible phosphorylation/dephosphorylation of enzymes already present allows activity to be flipped rapidly and undone just as fast, exactly matching the described behavior.
(Choice C) is incorrect: degrading enzymes would be slow and effectively irreversible until resynthesis, the opposite of the rapid, reversible switching observed.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it asks you to infer the underlying signaling mechanism from features of the response (speed, reversibility, constant enzyme amount) rather than to restate how a receptor works.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'regulation by new transcription' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'peptide hormone enters cell' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'irreversible enzyme degradation' FROM q;

-- Q61 [I18 · Transporters & Signaling] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'After a carbohydrate-rich meal, insulin rises and glucose uptake into resting skeletal muscle and adipocytes increases several-fold within a few minutes. In a cell-culture experiment, this rapid rise still occurs when transcription and translation are blocked, and antibody labeling shows that the total amount of GLUT4 protein per cell is unchanged before and after insulin — what changes is that GLUT4 shifts from the cytoplasm to the plasma membrane. Which explanation best accounts for how insulin raises glucose uptake so quickly?', '[{"label": "A", "text": "Insulin signaling drives pre-formed GLUT4 transporters out of intracellular storage vesicles to the plasma membrane, so the number of surface transporters rises within minutes with no new protein made."}, {"label": "B", "text": "Insulin rapidly switches on transcription of the GLUT4 gene, and the newly synthesized transporters travel out to the plasma membrane within minutes, which is what raises glucose uptake so quickly."}, {"label": "C", "text": "Insulin covalently activates the GLUT4 transporters already sitting in the plasma membrane, increasing each one''s turnover rate while their number at the surface stays constant."}, {"label": "D", "text": "Insulin pulls GLUT4 transporters out of the plasma membrane and into storage vesicles, and this internalization is what accelerates glucose entry into the cell."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because insulin raises glucose uptake into skeletal muscle and adipose tissue on a timescale of minutes by relocating transporters that already exist, not by making new ones. When insulin binds its cell-surface receptor, the downstream signaling cascade triggers GLUT4-containing storage vesicles to fuse with the plasma membrane, increasing the number of GLUT4 transporters at the cell surface so that facilitated glucose entry climbs almost at once. The experiment nails the mechanism: the rise still occurs when transcription and translation are blocked, and the total amount of GLUT4 per cell is unchanged — only its location shifts from cytoplasm to membrane. Because no new protein is required, the response is fast, and it reverses just as quickly when insulin falls and the transporters are internalized again.

(Choice A) is correct: insulin recruits pre-formed GLUT4 from intracellular vesicles to the surface, raising transporter number within minutes without new synthesis, exactly matching the unchanged total GLUT4 and the shift in location.
(Choice B) is incorrect: building new transporters requires transcription and translation, yet the stem shows the rise persists when both are blocked and the total amount of GLUT4 does not change, so newly synthesized protein cannot explain the minutes-fast response.
(Choice C) is incorrect: the data show GLUT4 moving from cytoplasm to the membrane — the number of surface transporters increases — so the effect is not merely speeding up transporters already at the surface while their number stays constant.
(Choice D) is incorrect: pulling GLUT4 off the surface into storage vesicles would lower glucose entry, the opposite of the observed shift toward the plasma membrane and the observed rise in uptake.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it asks you to infer insulin''s mechanism from experimental observations — an unchanged total transporter amount, a shift in transporter location, and persistence when synthesis is blocked — rather than recalling a memorized fact.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'rapid effect from new GLUT4 transcription/synthesis' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'activates existing surface transporters'' turnover, number unchanged' FROM q
  UNION ALL
  SELECT id, 'D', 'reversed_relationship', 'GLUT4 internalized rather than exposed at surface' FROM q;

-- Q62 [I19 · Transporters & Signaling] hard skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'A pancreatic beta cell secretes insulin in rough proportion to plasma glucose across the whole physiological range. This graded response depends on the cell importing glucose through the high-Km (low-affinity) GLUT2 transporter rather than a low-Km one. How does a high-Km transporter let secretion track the prevailing glucose level?', '[{"label": "A", "text": "Because a high-Km transporter saturates at low glucose, uptake is already maximal at every physiological level, so the beta cell secretes a fixed amount of insulin no matter the glucose."}, {"label": "B", "text": "Because GLUT2''s Km sits well above normal blood glucose, the transporter stays far from saturation, so glucose entry — and the ATP signal it generates — rises almost in step with plasma glucose."}, {"label": "C", "text": "Because GLUT2 is insulin-dependent, rising insulin recruits more GLUT2 to the membrane, so a feed-forward loop between insulin and glucose entry sets the beta cell''s secretion rate."}, {"label": "D", "text": "Because GLUT2 actively pumps glucose against its gradient at a rate set by blood glucose, it directly drives insulin secretion in proportion to the prevailing blood level."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because a transporter carries substrate in proportion to its concentration only while it is well below saturation. GLUT2 has a Km well above normal blood glucose (roughly \( 15\text{--}20\,\text{mM} \) versus a plasma glucose near \( 5\,\text{mM} \)), so across the physiological range it never approaches \( V_{max} \). Glucose entry therefore rises nearly linearly with plasma glucose, glycolytic ATP production rises with it, and the resulting ATP signal (closing K_ATP channels, depolarizing the cell, and admitting Ca\(^{2+}\)) scales insulin secretion to the prevailing glucose level.

(Choice B) is correct: staying far from saturation is exactly what lets uptake — and the downstream ATP trigger — increase in step with blood glucose, matching secretion to the glucose level.
(Choice A) is incorrect: it inverts the meaning of a high Km. A high Km means the transporter saturates only at high glucose, so at physiological levels it is not maximal, uptake is not constant, and secretion is graded rather than fixed.
(Choice C) is incorrect: GLUT2 is insulin-independent, not insulin-dependent; the beta cell senses glucose directly, without needing insulin to recruit its transporter (that recruitment describes GLUT4 in muscle and fat).
(Choice D) is incorrect: its conclusion is right but its mechanism is wrong — GLUT transporters move glucose by facilitated diffusion down its gradient, not by active transport against a gradient.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it asks you to reason from a transporter''s kinetic property (high Km) to the physiological behavior it produces (graded, glucose-proportional secretion).', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'high Km means saturates at low glucose' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'GLUT2 is insulin-dependent' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'active transport not facilitated diffusion' FROM q;

-- Q63 [I20 · Transporters & Signaling] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'Circulating epinephrine acts at nanomolar concentrations, yet within minutes it can mobilize a large fraction of the liver''s glycogen. Which feature of its signaling pathway best explains how so few hormone molecules produce such a large metabolic output?', '[{"label": "A", "text": "The hormone binds its target enzymes one-to-one, and those enzymes are simply exceptionally fast catalysts, so only a small amount of hormone is needed for the response."}, {"label": "B", "text": "Epinephrine crosses into the hepatocyte and accumulates to a high intracellular concentration, then acts directly and stoichiometrically on the stored glycogen."}, {"label": "C", "text": "Each bound receptor activates many G proteins and cyclase molecules, each activated kinase phosphorylates many enzymes, and each enzyme converts many substrates — a catalytic cascade multiplying one binding event into a large output."}, {"label": "D", "text": "A single hormone molecule is released and rebinds thousands of receptors one after another, and this repeated recycling is what multiplies the response."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because a small hormone signal becomes a large response only when each step of the pathway is catalytic and multiplies the one before it. A single bound receptor activates many G proteins and adenylyl cyclase molecules; each generates many cAMP; each cAMP-activated protein kinase A phosphorylates many downstream enzymes (for example, phosphorylase kinase, then glycogen phosphorylase); and each activated enzyme processes many substrate molecules. Multiplying these gains together converts one hormone-receptor binding event into the breakdown of a large amount of glycogen.

(Choice A) is incorrect: one-to-one binding provides no amplification, so even extremely fast catalysts could activate at most as much enzyme as there is hormone — nanomolar hormone still could not mobilize a large glycogen pool.
(Choice B) is incorrect: epinephrine is a water-soluble catecholamine that acts at cell-surface receptors; it does not enter the cell to act stoichiometrically on glycogen.
(Choice C) is correct: the multi-step catalytic cascade amplifies a single hormone-receptor interaction into a very large number of product molecules.
(Choice D) is incorrect: sequential rebinding of one molecule is far too slow and inefficient to explain the response; amplification arises within the intracellular cascade, not from hormone recycling.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it asks you to reason from the catalytic structure of a signaling cascade to the disproportion between hormone concentration and metabolic output.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'one-to-one, no cascade' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'catecholamine enters cell, acts stoichiometrically' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'amplification from hormone recycling' FROM q;

-- Q64 [I21 · Transporters & Signaling] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Transporters & Signaling', 'A physiology student studies how the liver sustains blood glucose during a prolonged fast. Glucagon raises hepatic glucose output within minutes, but cortisol''s contribution to gluconeogenesis becomes important only after several hours and keeps building over a day or more. Measuring the gluconeogenic enzyme PEPCK (phosphoenolpyruvate carboxykinase), the student finds that glucagon increases flux through gluconeogenesis without changing the total amount of PEPCK protein, whereas cortisol markedly raises the amount of PEPCK protein. Which explanation best accounts for why cortisol''s effect on gluconeogenic capacity is so much slower to develop than glucagon''s?', '[{"label": "A", "text": "Cortisol is delayed mainly by the time it takes to diffuse across the plasma and nuclear membranes to reach the DNA, whereas glucagon binds its surface receptor at once; both hormones ultimately change the activity of enzymes already present in the cell."}, {"label": "B", "text": "Cortisol travels bound to plasma carrier proteins and is cleared slowly, so it simply takes longer to reach an effective blood concentration, whereas the short half-life of glucagon lets it raise hepatic glucose output almost immediately."}, {"label": "C", "text": "Glucagon is delayed because it must first trigger a second-messenger cascade that transcribes new gluconeogenic enzymes, whereas cortisol directly activates enzymes already present in the hepatocyte, giving it the faster onset during a fast."}, {"label": "D", "text": "Cortisol acts through an intracellular receptor to increase transcription of gluconeogenic enzymes, so its effect on capacity must wait for new enzyme protein to be synthesized and accumulate, whereas glucagon uses cAMP to covalently activate enzymes already present, acting within minutes."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the data pin each hormone''s tempo to its mechanism. Glucagon raised gluconeogenic flux without changing the amount of PEPCK, meaning it acted on enzyme molecules that were already there: working through a cell-surface receptor and cAMP, it covalently modifies (phosphorylates/activates) pre-existing enzymes, so its effect appears within minutes. Cortisol instead raised the amount of PEPCK protein. As a steroid it binds an intracellular (nuclear) receptor and increases transcription of gluconeogenic enzymes, so its effect on capacity cannot appear until that new protein is transcribed, translated, and accumulates — a genomic process that takes hours to days. Building new enzyme capacity, rather than switching existing enzymes on, is exactly why cortisol''s contribution to the fasting fuel response ramps up slowly and acts in a sustained, permissive way alongside the fast-acting glucagon.

(Choice D) is correct: cortisol must synthesize new gluconeogenic enzyme protein through its nuclear-receptor/transcriptional mechanism (slow), while glucagon covalently activates enzymes that already exist via cAMP (fast), matching the observed rise in PEPCK amount versus flux.
(Choice A) is incorrect: crossing the membranes and reaching the DNA takes only seconds and is not the rate-limiting step; the delay is the time needed to make new protein. This choice also wrongly claims both hormones merely change the activity of pre-existing enzymes, which contradicts the finding that cortisol increased the amount of PEPCK.
(Choice B) is incorrect: the difference in time course is set by mechanism, not by carrier-protein binding or half-life. Even at a fully effective cortisol concentration, the effect on gluconeogenic capacity would still wait on transcription and translation of new enzyme.
(Choice C) is incorrect: it reverses the two mechanisms. Glucagon uses cAMP to act fast on existing enzymes, whereas cortisol is the one that transcribes new enzymes and is slow; this option also contradicts the data, since glucagon did not change the amount of PEPCK.

This question tests Skill 2 (Scientific Reasoning and Problem-Solving) because it asks you to infer, from measurements of enzyme amount versus flux, why a transcriptional hormone''s contribution to the fasting fuel response develops over hours-to-days while a cAMP hormone acts within minutes.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'process_step_confusion', 'delay attributed to membrane diffusion/transit time rather than new protein synthesis' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'tempo set by hormone half-life / carrier-protein clearance rather than mechanism' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'glucagon builds new enzymes and is slow while cortisol acts fast on existing enzymes' FROM q;

-- Q65 [J1 · Tissue-Specific Metabolism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'A metabolic study tracks a healthy adult''s liver across a 24-hour span that includes a large lunch followed by an overnight fast. Throughout this period the person''s blood glucose stays within a narrow range. Which combination of hepatic activities best accounts for this stability across both the fed and fasted phases?', '[{"label": "A", "text": "After the meal the liver withdraws the excess glucose from the blood for storage, and during the fast it releases glucose back into the blood."}, {"label": "B", "text": "In both phases the liver withdraws glucose from the blood and packs it away as glycogen."}, {"label": "C", "text": "In both phases the liver releases glucose into the blood, so blood glucose simply tracks the rate of hepatic export."}, {"label": "D", "text": "The liver neither takes up nor releases glucose; it only oxidizes amino acids while other tissues buffer blood glucose."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because holding blood glucose steady across opposite conditions requires a two-way response: when a meal drives glucose up, the liver must remove the surplus, and when a fast drives glucose down, the liver must add glucose back. After the meal the liver extracts excess glucose to refill glycogen (and converts the remainder to fat), and during the fast it supplies glucose by glycogenolysis and then gluconeogenesis. Taking glucose up when it is high and giving it back when it is low is exactly the behavior of a buffer.

(Choice A) is correct: the liver acts as a bidirectional glucose buffer, removing glucose after a meal and releasing it during a fast, which keeps blood glucose stable across both states.

(Choice B) is incorrect: a liver that only ever stored glucose would let blood glucose collapse during the overnight fast, because nothing would replace the glucose consumed by other tissues.

(Choice C) is incorrect: a liver that only ever released glucose would let blood glucose spike after the meal instead of clearing the dietary load; the fed liver must take glucose up.

(Choice D) is incorrect: the liver is the primary glucose buffer, and while it does oxidize amino acids for its own energy in the fed state, that activity does not stabilize blood glucose.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the requirement of stable blood glucose across fed and fasted states to the liver''s bidirectional buffering role.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'storage-only liver' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'export-only liver' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'amino-acid oxidation as buffer' FROM q;

-- Q66 [J2 · Tissue-Specific Metabolism] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'A high-protein, high-carbohydrate meal sends a surge of amino acids to the liver through the portal vein. Tracer studies show that inside the hepatocyte the alpha-amino group of these amino acids is stripped off and its nitrogen is recovered in urea, while the leftover carbon skeletons are funneled into fatty-acid synthesis. Skeletal muscle also takes up amino acids after the meal and readily transaminates them, yet it does not convert their nitrogen into urea. Which explanation best accounts for why disposal of amino-acid nitrogen as urea is centered in the liver rather than in muscle?', '[{"label": "A", "text": "Skeletal muscle lacks aminotransferases, so it cannot remove the alpha-amino group from amino acids and therefore never generates any free nitrogen that would need to be disposed of."}, {"label": "B", "text": "Urea-cycle enzymes are essentially confined to the liver, so muscle must instead ship its surplus amino nitrogen to the liver, as alanine and glutamine, for conversion to urea."}, {"label": "C", "text": "Only the liver ever receives dietary amino acids, because portal blood delivers them straight to hepatocytes and none of them reaches skeletal muscle through the systemic circulation afterward."}, {"label": "D", "text": "Muscle disposes of its own excess amino nitrogen by converting it into uric acid for excretion, so it has no need to rely on the hepatic urea cycle."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because free ammonia liberated when an amino acid is deaminated is toxic and must be packaged into urea, but the full complement of urea-cycle enzymes (beginning with carbamoyl phosphate synthetase I) is essentially restricted to hepatocytes. Muscle transaminates amino acids freely, yet because it cannot build urea it exports the collected amino nitrogen to the liver as alanine (the glucose-alanine cycle) and as glutamine. In the fed liver the nitrogen is therefore split off and routed to urea, while the carbon skeletons are kept for lipogenesis and energy. Reasoning from where the disposal machinery actually resides identifies the liver as the site of nitrogen disposal.

(Choice B) is correct: the liver is the tissue that holds the urea-cycle machinery, so muscle must hand off its surplus nitrogen (as alanine and glutamine) to the liver, which converts it to urea while retaining the carbon skeletons for fatty-acid synthesis.

(Choice A) is incorrect: skeletal muscle is rich in aminotransferases and transaminates amino acids heavily after a meal; the stem itself notes that muscle readily transaminates them. The issue is not that muscle fails to remove nitrogen but that it cannot package that nitrogen into urea.

(Choice C) is incorrect: although portal blood does give the liver first access to dietary amino acids, plenty of amino acids pass into the systemic circulation and are taken up by muscle after a meal. Exclusive delivery is not the reason; the localization of the urea-cycle enzymes is.

(Choice D) is incorrect: uric acid is the end product of purine (nucleotide) catabolism, not of amino-acid nitrogen disposal. Muscle does not detoxify its amino nitrogen as uric acid; it ships that nitrogen to the liver for incorporation into urea.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the described split fate of nitrogen versus carbon, and from where the disposal enzymes reside, to why the liver rather than muscle handles nitrogen excretion.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'muscle lacks aminotransferases' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'portal delivery makes liver the only tissue exposed to amino acids' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'muscle excretes nitrogen as uric acid' FROM q;

-- Q67 [J3 · Tissue-Specific Metabolism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'In a fasting person, skeletal muscle breaks down protein and exports the amino acid alanine to the liver. Investigators isotopically label two parts of that alanine — its amino nitrogen and its three-carbon skeleton — and follow where each ends up after the liver processes it. Which result is expected?', '[{"label": "A", "text": "The amino nitrogen appears in newly synthesized glucose, and the carbon skeleton is returned to muscle protein."}, {"label": "B", "text": "The amino nitrogen is stored as muscle glycogen, and the carbon skeleton is fully oxidized to carbon dioxide for ATP."}, {"label": "C", "text": "The amino nitrogen appears in urea, and the carbon skeleton appears in newly synthesized glucose."}, {"label": "D", "text": "Both the nitrogen and the carbon skeleton appear in ketone bodies that the liver exports to the brain."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because muscle-derived alanine is the vehicle of the glucose-alanine cycle. In the liver a transaminase strips alanine''s amino group, leaving pyruvate; the freed nitrogen enters the urea cycle for safe disposal, while the pyruvate carbon skeleton feeds gluconeogenesis to make new blood glucose. In one step this lets muscle unload amino nitrogen and hand the liver gluconeogenic carbon.

(Choice C) is correct: the nitrogen is excreted as urea while the three-carbon skeleton is rebuilt into glucose.

(Choice A) is incorrect: glucose contains no nitrogen, so the amino group cannot end up in the sugar, and the liver keeps the carbon skeleton for gluconeogenesis rather than shipping it back to muscle protein (fasting is catabolic for muscle, not anabolic).

(Choice B) is incorrect: glycogen is a pure glucose polymer that holds no nitrogen, and if the carbon were fully oxidized to \(\text{CO}_2\) none would remain to synthesize glucose — the opposite of what the cycle accomplishes.

(Choice D) is incorrect: ketone bodies contain no nitrogen, and alanine is a glucogenic (not ketogenic) amino acid, so its carbon is routed toward glucose rather than toward ketones.

This item tests Skill 2 (scientific reasoning and problem-solving): you trace labeled atoms through an inter-organ cycle to predict where the nitrogen and carbon of muscle alanine end up.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'amino nitrogen built into glucose while carbon is returned to muscle' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'amino nitrogen stored as glycogen and alanine carbon fully oxidized' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'glucogenic alanine converted to nitrogen-containing ketone bodies' FROM q;

-- Q68 [J4 · Tissue-Specific Metabolism] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'After a carbohydrate-rich meal, insulin is high and lipoprotein lipase is active at the surface of adipose capillaries. In this hormonal state, which set of adipocyte activities is favored?', '[{"label": "A", "text": "Adipocytes activate hormone-sensitive lipase to hydrolyze their triacylglycerol and release fatty acids for other tissues to burn."}, {"label": "B", "text": "Adipocytes export their stored triacylglycerol intact into the blood for delivery to the liver."}, {"label": "C", "text": "Adipocytes take up glucose but block fatty-acid uptake, so any triacylglycerol they build comes only from glucose-derived glycerol."}, {"label": "D", "text": "Adipocytes take up glucose and capture fatty acids freed from circulating lipoproteins, re-esterifying them into stored triacylglycerol while fatty-acid release is suppressed."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because a high-insulin, active-lipoprotein-lipase state is the storage signal for adipose tissue. Insulin drives glucose uptake, lipoprotein lipase liberates fatty acids from circulating VLDL and chylomicrons for the adipocyte to take up, and those fatty acids are re-esterified into triacylglycerol; at the same time insulin suppresses fatty-acid release, so the net direction is storage.

(Choice D) is correct: glucose uptake plus lipoprotein-lipase-mediated fatty-acid capture and re-esterification into triacylglycerol, with release suppressed, is the fed storage program.

(Choice A) is incorrect: activating hormone-sensitive lipase to release fatty acids is the fasting, low-insulin response, the opposite of what high insulin promotes.

(Choice B) is incorrect: adipocytes do not export intact triacylglycerol into the blood; they store it and, when needed, release free fatty acids.

(Choice C) is incorrect: in the fed state adipocytes actively take up fatty acids freed by lipoprotein lipase, so fatty-acid uptake is not blocked and storage is not limited to glucose-derived glycerol.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from a high-insulin hormonal state to the storage direction of adipose metabolism.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'HSL release in fed state' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'adipocytes export intact TAG' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'fatty-acid uptake blocked when fed' FROM q;

-- Q69 [J5 · Tissue-Specific Metabolism] easy skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'During a prolonged overnight fast, low insulin and high epinephrine drive adipose lipolysis, releasing glycerol and free fatty acids into the blood. Because these two products have different chemical properties, they meet different fates in other tissues. Which statement best describes what happens to them?', '[{"label": "A", "text": "The glycerol travels to the liver as a gluconeogenic substrate, while the fatty acids are oxidized for ATP by tissues such as skeletal muscle."}, {"label": "B", "text": "The fatty acids travel to the liver, where they are converted into glucose, while the glycerol is oxidized by skeletal muscle for ATP."}, {"label": "C", "text": "Both the glycerol and the fatty acids are taken up by the brain, which oxidizes them directly to spare its glucose demand."}, {"label": "D", "text": "Both the glycerol and the fatty acids are taken back up by adipocytes and re-esterified into stored triacylglycerol."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because the two products of adipose lipolysis are handled differently by the body. Glycerol is a three-carbon backbone that the liver feeds into gluconeogenesis to help maintain blood glucose during the fast, whereas the free fatty acids are taken up by tissues such as skeletal muscle and the liver and oxidized through \(\beta\)-oxidation to generate ATP. This division of labor across organs is the integrated fasting response.

(Choice A) is correct: glycerol serves as a gluconeogenic substrate in the liver, while the fatty acids are oxidized for ATP by muscle and other tissues.

(Choice B) is incorrect: it reverses the two fates. Even-chain fatty acids cannot be converted into net glucose, and it is glycerol—not the fatty acids—that supplies carbon for hepatic gluconeogenesis.

(Choice C) is incorrect: the brain cannot oxidize free fatty acids because they do not cross the blood-brain barrier, and it does not burn glycerol directly; the brain relies on glucose, using ketones only in prolonged starvation.

(Choice D) is incorrect: re-esterifying the released products back into stored triacylglycerol is a fed, high-insulin storage response; during a fast the tissues consume these products rather than re-store them.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the chemical properties of glycerol and fatty acids to their distinct fates across liver and muscle during a fast.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'swapped fates — fatty acids make glucose, glycerol oxidized for ATP' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'brain directly oxidizes free fatty acids and glycerol' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'released products re-esterified into storage (fed-state direction)' FROM q;

-- Q70 [J6 · Tissue-Specific Metabolism] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'Immediately after finishing an all-out 400-meter sprint, a runner stops moving and stands at the finish line, but her breathing stays heavy and she keeps consuming oxygen well above her resting rate for several minutes before slowly returning to baseline. Because she is no longer performing any mechanical work, which change best explains why her oxygen uptake remains elevated throughout this recovery period?', '[{"label": "A", "text": "Her resting muscle keeps generating ATP through anaerobic glycolysis, and it is this continued lactate-forming pathway that consumes the extra oxygen and keeps her breathing heavy."}, {"label": "B", "text": "Aerobic metabolism stays elevated to repay the oxygen debt, oxidizing the accumulated lactate and rebuilding the spent creatine phosphate and glycogen stores."}, {"label": "C", "text": "Creatine phosphate continues to be hydrolyzed for several minutes after she stops, and this ongoing breakdown is what draws the sustained above-resting oxygen uptake."}, {"label": "D", "text": "The extra oxygen is simply being stockpiled in myoglobin and hemoglobin as a reserve for her next effort, rather than consumed by any metabolic process."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the oxygen uptake that persists after the sprint is the repayment of the oxygen debt (the excess post-exercise oxygen consumption): during the near-maximal effort the muscle leaned on oxygen-independent pathways, leaving behind accumulated lactate and depleted creatine phosphate and glycogen. Restoring order costs ATP, and that ATP is supplied by oxidative phosphorylation, so the mitochondria keep drawing oxygen above the resting rate even though she has stopped moving, until the debt is settled.

(Choice B) is correct: once the effort ends, aerobic metabolism continues at an elevated rate to clear the lactate (partly by oxidizing it and partly by hepatic conversion back to glucose through the Cori cycle) and to regenerate the spent creatine phosphate and glycogen stores; each of these restorative steps consumes ATP made by oxidative phosphorylation, which is why oxygen uptake and breathing stay high after she stops.

(Choice A) is incorrect: anaerobic glycolysis, by definition, regenerates ATP without using oxygen, so it cannot be the pathway that consumes the extra oxygen; in reality the elevated oxygen is used aerobically to clear the lactate that glycolysis had produced, not to run more glycolysis.

(Choice C) is incorrect: during recovery creatine phosphate is being resynthesized, not hydrolyzed, and that resynthesis costs ATP; furthermore, the hydrolysis of creatine phosphate is itself an oxygen-independent reaction, so it could not account for the sustained oxygen uptake.

(Choice D) is incorrect: the oxygen bound to myoglobin and hemoglobin is a very small store that refills within seconds, so topping it off cannot explain minutes of elevated uptake; the extra oxygen is actively consumed in metabolism to repay the debt, not passively stockpiled.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the fact that oxygen uptake stays high after mechanical work has ceased to identify the restorative, ATP-requiring processes that continue to draw on oxidative metabolism during recovery.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'anaerobic glycolysis wrongly said to consume oxygen, when it is the aerobic clearance of its lactate product that does' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'creatine phosphate treated as being broken down during recovery when it is actually being resynthesized (and its hydrolysis uses no oxygen)' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'elevated recovery oxygen attributed to refilling tiny myoglobin/hemoglobin reserves rather than to metabolic debt repayment' FROM q;

-- Q71 [J7 · Tissue-Specific Metabolism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'Unlike most tissues, cardiac muscle continues to draw the majority of its energy from fatty acids even shortly after a meal, when blood glucose and insulin are elevated. Which explanation best accounts for this preference in the fed state?', '[{"label": "A", "text": "The heart lacks insulin-responsive glucose transporters, so it physically cannot import glucose from the blood in the fed state."}, {"label": "B", "text": "Cardiac muscle cannot store any glycogen, so no glucose is ever available to it and it is forced to burn fatty acids."}, {"label": "C", "text": "The heart contracts without rest and is dense with mitochondria, and fatty acids yield the most ATP through aerobic beta-oxidation, matching its demand."}, {"label": "D", "text": "Fatty acids can be broken down anaerobically, letting the heart make ATP without a continuous supply of oxygen."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because the heart never rests and is exceptionally rich in mitochondria, so it favors the fuel that delivers the most ATP per molecule through aerobic metabolism. Fatty acids yield the greatest ATP via sustained beta-oxidation, which fits the heart''s steady, high, oxygen-supplied energy demand, so the heart uses them preferentially even when glucose is abundant after a meal.

(Choice C) is correct: continuous contraction, high mitochondrial density, and the high ATP yield of fatty-acid oxidation together explain the heart''s fatty-acid preference in the fed state.

(Choice A) is incorrect: cardiac muscle does possess insulin-responsive glucose transporters and can take up glucose; it prefers fatty acids by choice, not because glucose import is impossible.

(Choice B) is incorrect: the heart does hold some glycogen and does have access to blood glucose, so a claim that no glucose is ever available is false.

(Choice D) is incorrect: fatty-acid oxidation is strictly aerobic and requires a continuous oxygen supply, so ''anaerobic fatty-acid metabolism'' is not a real basis for the preference.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the heart''s continuous workload and aerobic capacity to why it selects fatty acids over glucose when fed.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'heart lacks glucose transporters' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'heart stores no glycogen' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'anaerobic fatty-acid oxidation' FROM q;

-- Q72 [J8 · Tissue-Specific Metabolism] hard skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'In heart failure, myocardial fuel use shifts away from its normal preference: reliance on beta-oxidation of fatty acids declines while glucose oxidation increases. Which explanation is most consistent with why a failing, energetically stressed heart would make this switch?', '[{"label": "A", "text": "Fatty acids yield more ATP per molecule of oxygen than glucose, so the failing heart switches to glucose to spare fatty acids for storage."}, {"label": "B", "text": "The failing heart can no longer take up fatty acids because its lipoprotein lipase has been inactivated."}, {"label": "C", "text": "Glucose oxidation, unlike beta-oxidation, does not require mitochondria, letting the damaged heart bypass its failing mitochondria."}, {"label": "D", "text": "Oxidizing glucose yields more ATP per molecule of oxygen consumed than oxidizing fatty acids, so an oxygen-limited heart shifts toward the more oxygen-efficient fuel."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because the key variable for a stressed, oxygen-limited heart is how much ATP it can extract per unit of oxygen. Glucose oxidation produces more ATP per molecule of oxygen consumed than fatty-acid oxidation does, so a failing heart shifts toward glucose to squeeze more energy out of its limited oxygen supply, which explains the observed rise in glucose oxidation and fall in beta-oxidation.

(Choice D) is correct: glucose is the more oxygen-efficient fuel, so an oxygen-limited failing heart favors it over fatty acids.

(Choice A) is incorrect: it reverses the oxygen efficiency; fatty acids consume more oxygen per ATP, not less, so this rationale contradicts the direction of the shift.

(Choice B) is incorrect: reduced fatty-acid oxidation in the failing heart is a regulatory metabolic shift, not the result of lipoprotein lipase being switched off blocking fatty-acid uptake.

(Choice C) is incorrect: glucose oxidation still occurs in mitochondria (pyruvate oxidation and the citric acid cycle), so it cannot bypass failing mitochondria.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the oxygen cost of each fuel to why a compromised heart shifts toward glucose.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'fatty acids more oxygen-efficient' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'LPL inactivation blocks uptake' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'glucose oxidation needs no mitochondria' FROM q;

-- Q73 [J9 · Tissue-Specific Metabolism] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'A few hours after a meal, the brain still requires a steady supply of glucose and, unlike resting muscle, cannot switch to burning fatty acids to spare it. Why is the brain glucose-dependent in this between-meal window?', '[{"label": "A", "text": "Fatty acids cannot cross the blood-brain barrier, and ketone use develops only after a prolonged fast, so between meals the brain relies on glucose from the liver."}, {"label": "B", "text": "The brain has no mitochondria, so it can only ferment glucose to lactate and cannot oxidize any other fuel."}, {"label": "C", "text": "Because neuronal glucose uptake is insulin-independent, the brain is locked out of importing any fuel other than glucose between meals."}, {"label": "D", "text": "The blood-brain barrier admits fatty acids freely, but neurons lack the enzymes of beta-oxidation, forcing glucose use."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because two facts pin the brain to glucose between meals: fatty acids cannot cross the blood-brain barrier, so the brain simply cannot burn them, and the capacity to use ketone bodies emerges only after a prolonged fast, not a few hours after eating. That leaves glucose, delivered by hepatic glycogenolysis and gluconeogenesis, as the brain''s required fuel in the between-meal window.

(Choice A) is correct: the blood-brain barrier excludes fatty acids and ketone use is not yet available, so the between-meal brain depends on liver-supplied glucose.

(Choice B) is incorrect: neurons are packed with mitochondria and fully oxidize glucose (and, later, ketones); having no mitochondria describes the red blood cell, not the brain.

(Choice C) is incorrect: neuronal glucose uptake really is insulin-independent, but that is not what restricts the brain to glucose. What excludes other fuels is the blood-brain barrier''s block on fatty acids, not anything to do with insulin signaling.

(Choice D) is incorrect: the premise is wrong because the blood-brain barrier does not admit fatty acids freely; their exclusion, not a missing enzyme set, is why the brain cannot use them.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the transport barrier and the timing of ketone adaptation to why the brain needs glucose between meals.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'misconception', 'brain has no mitochondria' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'insulin-independence forces glucose' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'barrier admits fatty acids' FROM q;

-- Q74 [J10 · Tissue-Specific Metabolism] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'Whether a person is fed, fasting, or exercising, a red blood cell keeps relying on anaerobic glycolysis of glucose and never switches to fatty acids or ketone bodies. What best accounts for this fuel restriction across every metabolic state?', '[{"label": "A", "text": "Red blood cells have mitochondria but lack the transporters needed to import fatty acids and ketones for oxidation."}, {"label": "B", "text": "Red blood cells lack mitochondria, where fatty-acid and ketone oxidation occur, so only cytoplasmic glycolysis of glucose remains."}, {"label": "C", "text": "Fatty acids and ketone bodies cannot cross the red-cell membrane, whereas glucose is readily taken up."}, {"label": "D", "text": "Oxidizing fatty acids would consume the oxygen bound to hemoglobin, so red cells avoid it to protect that cargo."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because the mature red blood cell has no mitochondria, and both fatty-acid oxidation (beta-oxidation) and ketone-body oxidation are mitochondrial processes. Without mitochondria the cell can only run cytoplasmic glycolysis, so it depends on glucose broken down anaerobically to lactate regardless of the body''s overall metabolic state.

(Choice B) is correct: the absence of mitochondria rules out fatty-acid and ketone oxidation and leaves anaerobic glycolysis of glucose as the only pathway available.

(Choice A) is incorrect: the red blood cell has no mitochondria at all, so the limitation is the missing organelle, not a missing transporter in a mitochondrion-containing cell.

(Choice C) is incorrect: the restriction is set by the lack of mitochondria to oxidize these fuels, not by a membrane that selectively excludes them (in fact ketone bodies enter via the same monocarboxylate transporter the cell uses to export lactate).

(Choice D) is incorrect: the red cell performs no aerobic oxidation at all because it has no mitochondria, so protecting hemoglobin-bound oxygen is not the reason it avoids fatty acids.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the red cell''s lack of mitochondria to why it cannot use fatty acids or ketones in any metabolic state.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'has mitochondria but no transporters' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'membrane excludes fatty acids/ketones' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'oxygen-protection rationale' FROM q;

-- Q75 [J11 · Tissue-Specific Metabolism] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'The body maintains two large glycogen depots: roughly 100 g in the liver and a considerably larger total distributed across skeletal muscle. During an overnight fast, circulating glucose is held within a narrow range so that the brain and red blood cells — tissues that must draw on blood glucose to function — keep working. Considering how each depot is actually used, which statement best captures the division of labor between liver and muscle glycogen that makes this possible?', '[{"label": "A", "text": "Muscle glycogen is the body''s main blood-glucose buffer during fasting, while liver glycogen is set aside to power skeletal muscle contraction."}, {"label": "B", "text": "Both depots continuously feed glucose into the blood, with the liver drawn down first only because its store is the smaller of the two."}, {"label": "C", "text": "Only liver glycogen supplies glucose to the bloodstream for other tissues; muscle glycogen is reserved for the muscle''s own contraction."}, {"label": "D", "text": "The two glycogen stores are functionally interchangeable, so any tissue can pull glucose from either the liver or the muscle depot as needed."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because the two glycogen depots exist to do different jobs. Blood glucose must be held steady for tissues that depend on it — notably the brain and red blood cells, which cannot burn fatty acids — and the liver''s glycogen is the store that is broken down and released as free glucose to keep that circulating supply topped up between meals. The reason for the split is enzymatic: only the liver (and kidney) possesses glucose-6-phosphatase, the enzyme needed to strip the phosphate from glucose-6-phosphate so free glucose can leave the cell and enter the blood. Skeletal muscle lacks this enzyme, so it cannot export glucose at all; it keeps its glycogen as a private fuel depot, breaking it down to glucose-6-phosphate that stays trapped inside the muscle and is burned in situ to power contraction. That split — liver serving the whole body, muscle serving itself — is precisely what lets an overnight fast protect the brain and RBCs.

(Choice C) is correct: liver glycogen is mobilized to sustain blood glucose for glucose-dependent tissues, while muscle glycogen is a dedicated local reserve consumed by the muscle itself, which is the division of labor the stem describes.

(Choice A) is incorrect: it reverses the two roles. Muscle glycogen is not the body''s blood-glucose buffer, and liver glycogen is not held back to power muscle contraction; it is the liver, not muscle, that defends circulating glucose for the rest of the body.

(Choice B) is incorrect: muscle glycogen does not feed the bloodstream at all — lacking glucose-6-phosphatase, muscle cannot release free glucose — so the two pools do not both supply blood glucose, and the liver being drawn on first reflects its role as the systemic glucose buffer, not simply its being the smaller depot.

(Choice D) is incorrect: the stores are not interchangeable or shared. Each tissue manages its own glycogen for its own purpose, and only the liver''s contribution ever reaches the general circulation as free glucose.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the whole-body need to protect glucose-dependent tissues during a fast to infer why the liver and muscle maintain functionally distinct glycogen reserves.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'liver and muscle glycogen roles swapped' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'muscle glycogen also supplies blood glucose' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'glycogen stores shared across all tissues' FROM q;

-- Q76 [J12 · Tissue-Specific Metabolism] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'As starvation progresses, most tissues curb their glucose use: skeletal muscle turns heavily to fatty acids and ketone bodies, and even the brain comes to rely substantially on ketone bodies, sparing glucose for the tissues that still require it. Mature red blood cells cannot make this switch and keep consuming glucose at essentially their usual rate. Which feature of the red blood cell best explains why it cannot spare glucose the way these other tissues do?', '[{"label": "A", "text": "Their glucose uptake is insulin-independent, so unlike the other tissues they never receive a hormonal signal to switch fuels."}, {"label": "B", "text": "Their plasma membrane lacks transporters for fatty acids and ketone bodies, leaving glucose as the only fuel they can take up."}, {"label": "C", "text": "They carry unusually many mitochondria specialized for glucose oxidation, which locks them into consuming glucose."}, {"label": "D", "text": "They lack mitochondria, so they cannot oxidize fatty acids or ketones and must rely on anaerobic glycolysis of glucose."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because oxidizing fatty acids and ketone bodies requires mitochondrial pathways — beta-oxidation, the citric acid cycle, and the electron transport chain. Mature red blood cells have extruded their mitochondria, so they cannot burn either fuel and are confined to anaerobic glycolysis, which can only use glucose. That is why an RBC cannot spare glucose during starvation the way muscle or the ketone-adapted brain can, and why the liver and kidney must keep producing glucose even in prolonged fasting.

(Choice D) is correct: without mitochondria the cell has no way to oxidize fatty acids or ketones, leaving glycolysis of glucose as its only ATP source.

(Choice A) is incorrect: red-cell glucose uptake is indeed insulin-independent (via GLUT1), but insulin-independence governs how glucose gets into the cell, not whether the cell could oxidize an alternative fuel; the other tissues switch fuels because they can run beta-oxidation and ketone oxidation, not because they receive an insulin "switch" signal the RBC lacks. Note that the brain is also insulin-independent yet still switches, which shows insulin-independence is not the deciding factor.

(Choice B) is incorrect: the limiting problem is fuel oxidation, not fuel import — even if fatty acids or ketones entered the cell, an RBC has no mitochondria to oxidize them, so adding transporters would not let it spare glucose.

(Choice C) is incorrect: it states the opposite of the truth; mature red blood cells contain no mitochondria at all, which is precisely why they are restricted to glucose-based glycolysis.

This item tests Skill 2 (scientific reasoning and problem-solving): you reason from the absence of mitochondria to the red cell''s obligate, non-sparable dependence on glucose, integrating tissue-specific fuel use across the fasting state.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'insulin-independence mistaken for why RBC cannot switch fuels' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'blames missing fatty-acid/ketone transporters instead of missing mitochondria' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'RBC packed with glucose-oxidizing mitochondria' FROM q;

-- Q77 [J13 · Tissue-Specific Metabolism] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Tissue-Specific Metabolism', 'A physiologist tracks how four tissues fuel themselves as a subject moves from the well-fed state into prolonged fasting. For each tissue, the tables below give the approximate share of that tissue''s ATP production supplied by each fuel (percent), first in the well-fed state and then after several weeks of total starvation.

Well-fed state (% of ATP from each fuel):

| Tissue | Glucose | Fatty acids | Ketone bodies |
|---|---|---|---|
| W | 100 | 0 | 0 |
| X | 100 | 0 | 0 |
| Y | 30 | 70 | 0 |
| Z | 45 | 55 | 0 |

After several weeks of total starvation (% of ATP from each fuel):

| Tissue | Glucose | Fatty acids | Ketone bodies |
|---|---|---|---|
| W | 40 | 0 | 60 |
| X | 100 | 0 | 0 |
| Y | 10 | 60 | 30 |
| Z | 5 | 65 | 30 |

Based on how each tissue''s fuel mix does or does not change between the two states, which tissue is most consistent with the brain?', '[{"label": "A", "text": "Tissue W, because it uses no fatty acids yet switches from glucose to ketones while fasting."}, {"label": "B", "text": "Tissue X, because it uses only glucose in every state and never oxidizes ketone bodies."}, {"label": "C", "text": "Tissue Y, because it relies on fatty acids even in the fed state and adds ketone bodies while fasting."}, {"label": "D", "text": "Tissue Z, because it splits its fuel between glucose and fatty acids and shifts toward ketones while fasting."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because the brain has two defining fuel constraints: it cannot oxidize fatty acids (they do not cross the blood-brain barrier), and during prolonged fasting it adapts to draw much of its energy from ketone bodies instead of glucose. Tissue W is the only row satisfying both: fatty-acid use is \(0\) in both states, and its fuel mix switches from \(100\%\) glucose when fed to a \(60\%\) ketone-body share deep into prolonged starvation. Note that in the fed state W and X look identical (both \(100\%\) glucose); it is the fasting switch, not the fed data, that identifies the brain.

(Choice A) is correct: tissue W uses no fatty acids in either state yet shifts from glucose to ketone bodies as the fast proceeds, the signature of the fasting-adapted brain.

(Choice B) is incorrect: tissue X uses only glucose in every state and never oxidizes ketone bodies, the profile of a red blood cell, which lacks mitochondria and cannot make the glucose-to-ketone switch. It shares the brain''s fed-state glucose dependence, but the missing switch rules it out.

(Choice C) is incorrect: tissue Y relies on fatty acids even in the fed state (\(70\%\)), so it cannot be the brain, which never uses fatty acids; this fatty-acid-preferring pattern fits cardiac muscle.

(Choice D) is incorrect: tissue Z splits its fed-state fuel between glucose and fatty acids and moves toward fatty acids and ketones while fasting; its fatty-acid use excludes the brain and fits resting skeletal muscle.

This item tests Skill 4 (data-based and statistical reasoning): you compare two-state fuel data, recognize that the fed-state values alone cannot separate the brain from the red cell, and use the fasting fuel switch to make the identification.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'partial_truth', 'red-cell glucose-only profile lacking the ketone switch' FROM q
  UNION ALL
  SELECT id, 'C', 'adjacent_fact', 'cardiac fatty-acid-preferring profile' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'resting skeletal-muscle mixed-fuel profile' FROM q;

-- Q78 [K14 · Energy Balance & Appetite] easy skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'A person carefully tracks their daily energy and finds that, week after week, they take in noticeably more food energy than they expend through activity and metabolism. Over the coming months, what is the most likely consequence for their body?', '[{"label": "A", "text": "Body mass falls as stored triacylglycerol is mobilized for fuel."}, {"label": "B", "text": "Fat stores gradually accumulate and body mass rises."}, {"label": "C", "text": "Body mass stays constant because expenditure automatically rises to match intake exactly."}, {"label": "D", "text": "Lean muscle is preferentially broken down while fat stores are spared."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because a sustained surplus—taking in more energy than is expended over a significant period—means the unused energy is deposited, chiefly as triacylglycerol in adipose tissue, so fat stores accumulate and body mass rises.

(Choice B) is correct: when intake exceeds expenditure week after week, the extra energy is stored as fat, so adipose stores grow and body mass climbs.
(Choice A) is incorrect: mobilizing stored triacylglycerol and losing mass is the consequence of a deficit (intake below expenditure), which is the opposite of the described surplus.
(Choice C) is incorrect: although basal metabolic rate does rise somewhat as body mass increases, expenditure does not instantly and exactly cancel a chronic surplus, so weight does not stay perfectly constant.
(Choice D) is incorrect: preferential breakdown of lean muscle occurs during an energy deficit or starvation, not during a surplus in which energy is being stored as fat.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must reason from the described intake-versus-expenditure situation to its body-mass consequence rather than recall a definition.', 'easy', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 60)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'treats a surplus as a deficit' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'assumes perfect homeostatic compensation' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'fat spared, muscle lost during a surplus' FROM q;

-- Q79 [K15 · Energy Balance & Appetite] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'A researcher studies why patients with an overactive thyroid feel warm and run a higher resting energy demand even when body mass and lean mass are unchanged. In isolated cells exposed to excess thyroid hormone, resting oxygen consumption climbs while very little extra ATP accumulates, and cell membranes show markedly increased ion-pumping activity. Which molecular effect of thyroid hormone best accounts for this pattern of raised heat output that is largely uncoupled from net ATP gain?', '[{"label": "A", "text": "It tightens mitochondrial coupling so nearly all oxidized substrate is captured as ATP rather than heat."}, {"label": "B", "text": "It suppresses Na+/K+-ATPase activity, lowering the resting energy the cell must spend on ion gradients."}, {"label": "C", "text": "It increases Na+/K+-ATPase turnover and promotes mild mitochondrial uncoupling, so more substrate is oxidized and released as heat."}, {"label": "D", "text": "It blocks resting oxygen consumption, forcing the cell to meet its energy needs by anaerobic glycolysis."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because the data describe rising oxygen consumption with little extra ATP and heightened ion pumping—the signature of thyroid hormone speeding up Na+/K+-ATPase turnover (which continuously burns ATP to maintain gradients) while also causing mild mitochondrial uncoupling, so oxidized substrate is dissipated as heat rather than banked as ATP.

(Choice C) is correct: raising Na+/K+-ATPase turnover raises the ATP-consuming workload of the resting cell, and mild uncoupling lets oxidation proceed while releasing energy as heat, matching the observed high \(O_2\) use, low ATP gain, and increased ion pumping.
(Choice A) is incorrect: tighter coupling would channel oxidation into ATP and produce little heat, the opposite of the low-ATP, high-heat pattern described.
(Choice B) is incorrect: the cells show increased, not decreased, ion-pumping activity, so suppressing Na+/K+-ATPase cannot explain the higher resting oxygen demand.
(Choice D) is incorrect: oxygen consumption rises rather than being blocked, so the cell is not shifting toward anaerobic glycolysis; thyroid hormone drives aerobic oxidation and heat output.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must infer the underlying mechanism from a described pattern of oxygen use, ATP yield, and ion-pump activity rather than recall that thyroid hormone raises BMR.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'thyroid tightens coupling, stores energy as ATP' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'thyroid suppresses Na/K-ATPase to save energy' FROM q
  UNION ALL
  SELECT id, 'D', 'process_step_confusion', 'thyroid blocks aerobic O2 use, forces anaerobic glycolysis' FROM q;

-- Q80 [K16 · Energy Balance & Appetite] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'Just before lunch, the smell of food causes a person''s stomach to release increasing amounts of ghrelin, even though they have not yet eaten anything. What is the most likely effect on the person''s appetite in this pre-meal window?', '[{"label": "A", "text": "Appetite decreases, because ghrelin signals that the fat stores are full."}, {"label": "B", "text": "Appetite is unchanged until food actually reaches the stomach."}, {"label": "C", "text": "Appetite increases, but only because ghrelin suppresses orexin."}, {"label": "D", "text": "Appetite increases, and ghrelin stimulates orexin to further drive hunger."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because ghrelin is released by the stomach in anticipation of a meal and its role is to increase appetite, partly by stimulating orexin; so the rising pre-meal ghrelin makes the person hungrier even before any food is eaten.

(Choice D) is correct: ghrelin drives hunger and stimulates orexin, so anticipatory ghrelin amplifies appetite in the pre-meal window.
(Choice A) is incorrect: signaling that fat stores are full and reducing appetite describes leptin, not ghrelin.
(Choice B) is incorrect: ghrelin is deliberately secreted before food arrives (triggered by cues such as smell and sight), so appetite rises during this anticipatory phase, not only after ingestion.
(Choice C) is incorrect: ghrelin stimulates orexin rather than suppressing it; suppression of orexin is leptin''s action.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must reason from a described pre-meal ghrelin rise to its effect on hunger rather than recall a label.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'misconception', 'ghrelin acts as a fat-store/satiety signal (leptin)' FROM q
  UNION ALL
  SELECT id, 'B', 'adjacent_fact', 'appetite change requires ingestion first' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'ghrelin suppresses rather than stimulates orexin' FROM q;

-- Q81 [K17 · Energy Balance & Appetite] medium skill2 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'Over several months, a person''s adipose tissue expands substantially. Because leptin secretion tracks the size of the fat stores, how would this rising fat mass be expected to affect appetite through leptin?', '[{"label": "A", "text": "Appetite decreases, because more leptin suppresses orexin production."}, {"label": "B", "text": "Appetite increases, because more leptin stimulates orexin production."}, {"label": "C", "text": "Appetite decreases, because the expanding fat stores raise ghrelin release."}, {"label": "D", "text": "Appetite is unaffected, because leptin acts on wakefulness rather than hunger."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because leptin is secreted by adipocytes in proportion to fat-store size and it lowers appetite by suppressing orexin; as fat mass expands, more leptin is released, orexin is suppressed more strongly, and appetite falls.

(Choice A) is correct: greater fat mass raises leptin, which suppresses orexin and thereby reduces appetite.
(Choice B) is incorrect: leptin suppresses orexin, so more leptin lowers appetite; it does not stimulate orexin.
(Choice C) is incorrect: ghrelin is released by the stomach in anticipation of meals, not by expanding fat stores, and ghrelin raises appetite; the satiety here is a leptin effect, not a ghrelin one.
(Choice D) is incorrect: promoting wakefulness is orexin''s role; leptin acts on appetite by suppressing orexin, so it is not appetite-neutral.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must reason from a described change in fat mass to the appetite consequence through leptin rather than recall a definition.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'leptin stimulates orexin' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'attributes satiety to raised ghrelin' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'assigns leptin the orexin arousal role' FROM q;

-- Q82 [K18 · Energy Balance & Appetite] medium skill2 ans=B
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'A student who skipped breakfast develops a falling blood-glucose level by mid-morning, which triggers the release of orexin. Given orexin''s actions, what dual effect is this low-glucose state most likely to produce?', '[{"label": "A", "text": "Increased appetite together with greater drowsiness and sleep drive."}, {"label": "B", "text": "Increased appetite together with heightened alertness and wakefulness."}, {"label": "C", "text": "Decreased appetite together with heightened alertness and wakefulness."}, {"label": "D", "text": "Decreased appetite together with greater drowsiness and sleep drive."}]'::jsonb, 'B', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is B because orexin both increases appetite and promotes alertness/wakefulness, and it is released in response to falling blood glucose; the hypoglycemic state therefore produces hunger together with heightened arousal.

(Choice B) is correct: low glucose triggers orexin, which simultaneously raises appetite and heightens alertness.
(Choice A) is incorrect: orexin promotes wakefulness, not drowsiness; the appetite half is right but the arousal half is reversed.
(Choice C) is incorrect: orexin increases appetite; the arousal half is right but the appetite half is reversed.
(Choice D) is incorrect: this reverses both of orexin''s actions—it increases appetite and promotes wakefulness, not the opposite of each.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must reason from a described low-glucose state to orexin''s paired appetite-and-arousal effects rather than recall a single fact.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'partial_truth', 'correct appetite, reversed arousal effect' FROM q
  UNION ALL
  SELECT id, 'C', 'reversed_relationship', 'correct arousal, reversed appetite effect' FROM q
  UNION ALL
  SELECT id, 'D', 'misconception', 'reverses both of orexin''s actions' FROM q;

-- Q83 [K19 · Energy Balance & Appetite] medium skill2 ans=C
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'A person with long-standing obesity has a large adipose mass and, as expected, markedly elevated circulating leptin. In a lean person, leptin of this magnitude would strongly blunt hunger by suppressing hypothalamic orexin. Yet this individual remains persistently hungry and keeps overeating, and repeat blood tests confirm the leptin level is genuinely high. Which explanation best accounts for the high leptin failing to curb this person''s appetite?', '[{"label": "A", "text": "High leptin drives appetite upward by directly stimulating orexin, which is why the hunger persists here."}, {"label": "B", "text": "The fat cells have stopped secreting functional leptin, so no satiety signal is available to suppress this appetite."}, {"label": "C", "text": "The hypothalamus no longer responds to leptin, so its high level cannot suppress orexin or curb appetite."}, {"label": "D", "text": "Leptin reports only the most recent meal, so a high reading tells the brain to keep eating."}]'::jsonb, 'C', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is C because leptin secretion tracks fat stores, so a large adipose mass correctly drives leptin high; normally that high leptin suppresses hypothalamic orexin and curbs appetite. Because appetite persists even though the measured leptin is genuinely high, the problem cannot be too little hormone—it must lie downstream, in the target tissue''s response. The hypothalamus has become unresponsive to leptin (leptin resistance), so the satiety signal is never delivered despite abundant hormone. This ineffective-yet-abundant leptin is the hallmark pattern in obesity.

(Choice C) is correct: leptin is present in excess, but the hypothalamus no longer responds to it, so orexin is not suppressed and appetite is not curbed—this loss of target-tissue responsiveness is leptin resistance.
(Choice A) is incorrect: leptin SUPPRESSES orexin rather than stimulating it, so high leptin does not push appetite up; this reverses leptin''s normal action on orexin.
(Choice B) is incorrect: the leptin level is confirmed high, so the fat cells are clearly still secreting it—the defect is a failure to respond to leptin, not a failure to produce it (absent leptin would be leptin deficiency, a distinct condition).
(Choice D) is incorrect: leptin reflects long-term fat stores, not the size of the last meal, and a high leptin normally signals satiety (eat less), not a cue to keep eating.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must recognize that when an abundant hormone fails to produce its normal effect, the lesion lies in target-tissue responsiveness rather than in hormone supply, and apply that logic to leptin resistance in obesity.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'high leptin stimulates orexin to raise appetite (leptin actually suppresses orexin)' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'leptin resistance confused with leptin deficiency—claims fat cells no longer secrete leptin despite the high measured level' FROM q
  UNION ALL
  SELECT id, 'D', 'adjacent_fact', 'leptin misread as a short-term recent-meal signal rather than a long-term fat-store signal' FROM q;

-- Q84 [K20 · Energy Balance & Appetite] medium skill2 ans=D
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'Two people are identical except that one has gained a substantial amount of body mass over the past year. At complete rest, how does the heavier person''s basal energy expenditure most likely compare with the lighter person''s?', '[{"label": "A", "text": "Lower, because a larger body mass lowers the basal metabolic rate."}, {"label": "B", "text": "Identical, because BMR is fixed and independent of body mass."}, {"label": "C", "text": "Higher, but only during activity; at complete rest the two expend the same energy."}, {"label": "D", "text": "Higher, because a larger body mass raises the basal metabolic rate."}]'::jsonb, 'D', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is D because basal metabolic rate rises as body mass increases; the person who gained substantial mass therefore expends more energy at complete rest than the otherwise-identical lighter person.

(Choice D) is correct: greater body mass raises BMR, so the heavier person''s resting energy expenditure is higher.
(Choice A) is incorrect: increasing body mass raises, not lowers, the basal metabolic rate.
(Choice B) is incorrect: BMR is not fixed—it tracks body size (as well as lean mass and thyroid hormone), so it is not independent of body mass.
(Choice C) is incorrect: the increased expenditure applies to the resting baseline itself (the BMR), not only to periods of activity.

This item tests Scientific Reasoning and Problem-Solving (Skill 2): you must reason from a described change in body mass to the resting energy-expenditure consequence rather than recall a fact.', 'medium', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 2, 80)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'A', 'reversed_relationship', 'more mass lowers BMR' FROM q
  UNION ALL
  SELECT id, 'B', 'misconception', 'BMR fixed and independent of mass' FROM q
  UNION ALL
  SELECT id, 'C', 'partial_truth', 'restricts the mass effect to activity, not rest' FROM q;

-- Q85 [K21 · Energy Balance & Appetite] hard skill4 ans=A
WITH q AS (
  INSERT INTO questions (section, topic, subtopic, question_text, options, correct_answer, explanation, difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES ('bio_biochem', 'Bioenergetics and Regulation of Metabolism', 'Energy Balance & Appetite', 'The table shows measurements taken from one individual at a single moment, alongside typical reference values.

| Measurement | This individual | Typical reference |
| --- | --- | --- |
| Plasma ghrelin | High | Low–normal |
| Plasma leptin | Low | Normal |
| Blood glucose | Low | Normal |

Based on these values, which state is this individual most likely in, and why?', '[{"label": "A", "text": "Hunger-promoting: high ghrelin and low glucose both drive orexin, while the low leptin does little to suppress it."}, {"label": "B", "text": "Satiety-promoting: the low leptin and low glucose together dampen appetite."}, {"label": "C", "text": "Satiety-promoting: the high ghrelin indicates the stomach is full and signals fullness."}, {"label": "D", "text": "Hunger-promoting, but only because glucose is low; the ghrelin and leptin values would each oppose hunger."}]'::jsonb, 'A', 'This is a Biochemistry question that falls under the content category ''Hormonal Regulation and Integration of Metabolism.''

The answer is A because all three readings point the same way: high ghrelin and low blood glucose each stimulate orexin, while the low leptin means orexin is poorly suppressed—together a clearly hunger-promoting state.

(Choice A) is correct: high ghrelin drives orexin, low glucose triggers orexin, and low leptin removes the suppression of orexin, so every value favors hunger.
(Choice B) is incorrect: low leptin and low glucose promote hunger—a weak satiety signal plus an orexin trigger—rather than dampening appetite.
(Choice C) is incorrect: high ghrelin is a hunger signal released by the stomach in anticipation of a meal, not a fullness signal.
(Choice D) is incorrect: the state is hunger-promoting, but not by glucose alone—the high ghrelin and low leptin also promote hunger rather than opposing it.

This item tests Data-Based and Statistical Reasoning (Skill 4): you must integrate three tabulated values to infer the individual''s appetite state rather than read a single remembered label.', 'hard', '1D', 'Hormonal Regulation and Integration of Metabolism', 'biochemistry', 4, 100)
  RETURNING id
)
INSERT INTO question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT id, 'B', 'reversed_relationship', 'low leptin and low glucose read as satiety signals' FROM q
  UNION ALL
  SELECT id, 'C', 'misconception', 'high ghrelin misread as a fullness signal' FROM q
  UNION ALL
  SELECT id, 'D', 'partial_truth', 'right state, but claims ghrelin/leptin oppose hunger' FROM q;

COMMIT;
