-- General Chemistry Chapter 5: Chemical Kinetics, standalone questions (prompt v7)
-- BATCH 1 of 3 (24 questions): Reaction Rates & Rate Laws (12) . Reaction Order & the Method of
--   Initial Rates (12). Six drafter slices of 4; compact in-stem LaTeX trial lines, no tables,
--   no figures; calculator-free arithmetic throughout.
--
-- CHAPTER SIZE: 72 questions in three batches of 24, per the Step 1 pre-flight: kinetics is
-- virgin territory in the question bank (zero prior hits for rate law, rate constant, half-life,
-- collision, or reaction order), while the edges are owned: Biochem Ch2 keys the classic
-- catalyst/enzyme recall, Biochem Ch12 keys the qualitative spontaneous-is-not-fast prize and
-- all delta-G, and the equilibrium machinery is RESERVED FORWARD for the future GenChem Ch6
-- bank. Source errata refereed: the optimal-temperature and frequency-factor-concentration
-- claims are designed distractors, never credited. See genchem_ch5_kinetics_questions.plan.md.
--
-- !! BATCH 1 OWNS THE CHAPTER DELETE !! Batches 2-3 are pure INSERTs and run after this file.

BEGIN;

DELETE FROM public.questions WHERE topic = 'Chemical Kinetics';

-- Q1 . Reaction Rates & Rate Laws . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Ammonia is synthesized industrially according to \(\text{N}_2(g) + 3\text{H}_2(g) \rightarrow 2\text{NH}_3(g)\). Which expression equals the rate of this reaction?$q$,
    $q$[{"label":"A","text":"\\(\\frac{1}{3}\\frac{\\Delta[\\text{H}_2]}{\\Delta t}\\)"},{"label":"B","text":"\\(-\\frac{1}{2}\\frac{\\Delta[\\text{NH}_3]}{\\Delta t}\\)"},{"label":"C","text":"\\(-\\frac{1}{3}\\frac{\\Delta[\\text{H}_2]}{\\Delta t}\\)"},{"label":"D","text":"\\(-3\\frac{\\Delta[\\text{H}_2]}{\\Delta t}\\)"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the rate of a reaction is defined as a single positive quantity that every species must report identically. Since \(\text{H}_2\) is a reactant, \([\text{H}_2]\) decreases as the reaction proceeds, so \(\frac{\Delta[\text{H}_2]}{\Delta t}\) is intrinsically negative; a leading negative sign is required to convert it into a positive rate. In addition, three moles of \(\text{H}_2\) are consumed for every mole of reaction, so the concentration change must also be divided by the coefficient 3 to place all species on a common scale: rate \(= -\frac{\Delta[\text{N}_2]}{\Delta t} = -\frac{1}{3}\frac{\Delta[\text{H}_2]}{\Delta t} = \frac{1}{2}\frac{\Delta[\text{NH}_3]}{\Delta t}\). Only choice C applies both the correct sign and the correct coefficient scaling to \(\text{H}_2\).

(Choice A) A positive sign attached to a reactant term yields a negative number, because \([\text{H}_2]\) falls with time. A rate reported this way would be negative, violating the convention that reaction rates are positive quantities.

(Choice B) The negative sign belongs only on species that disappear. \(\text{NH}_3\) is a product whose concentration rises, so \(\frac{\Delta[\text{NH}_3]}{\Delta t}\) is already positive; the correct product expression is \(+\frac{1}{2}\frac{\Delta[\text{NH}_3]}{\Delta t}\). Adding a negative sign here produces a negative value for the rate.

(Choice D) The stoichiometric coefficient enters the rate expression as a divisor, not a multiplier. Multiplying \(\frac{\Delta[\text{H}_2]}{\Delta t}\) by 3 instead of dividing by 3 overstates the reaction rate by a factor of 9 relative to the properly normalized value, even though the sign is handled correctly.

This is a Knowledge of Scientific Concepts and Principles question because you must recall the sign convention and coefficient normalization that define a single reaction rate from any species' measured concentration change.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$sign dropped on reactant$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$minus sign on every species$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$coefficient as multiplier not divisor$q$ FROM q;

-- Q2 . Reaction Rates & Rate Laws . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Ozone decomposes in an irradiated reaction vessel according to \(2\text{O}_3(g) \rightarrow 3\text{O}_2(g)\). During one measurement interval, \(\frac{\Delta[\text{O}_2]}{\Delta t} = +6.0 \times 10^{-5}\ \text{M s}^{-1}\). What is the value of \(\frac{\Delta[\text{O}_3]}{\Delta t}\) over the same interval?$q$,
    $q$[{"label":"A","text":"\\(-9.0 \\times 10^{-5}\\ \\text{M s}^{-1}\\)"},{"label":"B","text":"\\(-4.0 \\times 10^{-5}\\ \\text{M s}^{-1}\\)"},{"label":"C","text":"\\(+4.0 \\times 10^{-5}\\ \\text{M s}^{-1}\\)"},{"label":"D","text":"\\(-6.0 \\times 10^{-5}\\ \\text{M s}^{-1}\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because two separate operations must be applied to the measured oxygen datum: coefficient scaling and the sign logic for a disappearing species. The single reaction rate obtained from the product is rate \(= \frac{1}{3}\frac{\Delta[\text{O}_2]}{\Delta t} = \frac{1}{3}(6.0 \times 10^{-5}\ \text{M s}^{-1}) = 2.0 \times 10^{-5}\ \text{M s}^{-1}\). The ozone term relates to this same rate through its own coefficient: rate \(= -\frac{1}{2}\frac{\Delta[\text{O}_3]}{\Delta t}\), so \(\frac{\Delta[\text{O}_3]}{\Delta t} = -2 \times (2.0 \times 10^{-5}\ \text{M s}^{-1}) = -4.0 \times 10^{-5}\ \text{M s}^{-1}\). The negative value is required because \(\text{O}_3\) is consumed, so its concentration falls throughout the interval. Equivalently, only \(\frac{2}{3}\) as much ozone is destroyed as oxygen is created, and the change carries the opposite sign.

(Choice A) A magnitude of \(9.0 \times 10^{-5}\ \text{M s}^{-1}\) comes from applying the coefficient ratio upside down, multiplying by \(\frac{3}{2}\) instead of \(\frac{2}{3}\). Two moles of ozone yield three moles of oxygen, so the ozone concentration must change more slowly than the oxygen concentration, not faster.

(Choice C) The magnitude \(4.0 \times 10^{-5}\ \text{M s}^{-1}\) is correct, but a positive sign asserts that \([\text{O}_3]\) is increasing. Ozone is the species being destroyed, so \(\frac{\Delta[\text{O}_3]}{\Delta t}\) must be negative.

(Choice D) Setting the ozone change equal in magnitude to the oxygen change ignores the \(2{:}3\) stoichiometry entirely. Species change at identical magnitudes only when their coefficients are equal, which is not the case here.

This is a Data-based and Statistical Reasoning question because you must calculate one species' rate of concentration change from another species' measured value using the balanced equation.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$inverted mole ratio$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$sign of change reversed$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$coefficients ignored$q$ FROM q;

-- Q3 . Reaction Rates & Rate Laws . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Propane burns completely in a rigid vessel according to \(\text{C}_3\text{H}_8(g) + 5\text{O}_2(g) \rightarrow 3\text{CO}_2(g) + 4\text{H}_2\text{O}(g)\). While the reaction proceeds, the concentration of which species changes with the greatest magnitude per unit time?$q$,
    $q$[{"label":"A","text":"\\(\\text{C}_3\\text{H}_8\\)"},{"label":"B","text":"\\(\\text{CO}_2\\)"},{"label":"C","text":"\\(\\text{H}_2\\text{O}\\)"},{"label":"D","text":"\\(\\text{O}_2\\)"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because at any instant every species' concentration changes in direct proportion to its stoichiometric coefficient, and \(\text{O}_2\) carries the largest coefficient in the equation. For each mole of propane consumed, 5 moles of \(\text{O}_2\) are consumed while 3 moles of \(\text{CO}_2\) and 4 moles of \(\text{H}_2\text{O}\) are produced. Written against the single reaction rate, \(\left|\frac{\Delta[\text{O}_2]}{\Delta t}\right| = 5 \times \text{rate}\), compared with 1, 3, and 4 times the rate for the other species. Whether a species is appearing or disappearing is irrelevant to a magnitude comparison; the coefficient alone sets how steeply each concentration versus time curve rises or falls. The oxygen concentration therefore falls faster than any other concentration in the vessel changes in either direction.

(Choice A) Propane is the fuel, but its coefficient is 1, the smallest in the equation, so \([\text{C}_3\text{H}_8]\) changes more slowly than any other concentration. Being the substance that is burned does not confer a faster concentration change; only the coefficient matters.

(Choice B) \(\text{CO}_2\) is frequently the product monitored in combustion experiments, but its coefficient of 3 makes it neither the fastest appearing product nor the fastest changing species overall.

(Choice C) \(\text{H}_2\text{O}\) is the fastest appearing product, since its coefficient of 4 exceeds that of \(\text{CO}_2\). The comparison, however, spans both sides of the equation, and the reactant \(\text{O}_2\), with coefficient 5, changes with a still greater magnitude.

This is a Scientific Reasoning and Problem Solving question because you are asked to apply stoichiometric coefficients to predict which species' concentration changes most rapidly.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$fuel governs speed$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$familiar monitored species$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$right within products only$q$ FROM q;

-- Q4 . Reaction Rates & Rate Laws . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$A zinc strip is dropped into a beaker of hydrochloric acid, and \(0.20\ \text{mol}\) of \(\text{HCl}\) is consumed over \(50\ \text{s}\). Which additional quantity is required to express the disappearance of \(\text{HCl}\) as a rate in \(\text{M s}^{-1}\)?$q$,
    $q$[{"label":"A","text":"The volume of the acid solution"},{"label":"B","text":"The molar mass of \\(\\text{HCl}\\)"},{"label":"C","text":"The temperature of the solution"},{"label":"D","text":"The stoichiometric coefficients of the balanced equation"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because a rate expressed in \(\text{M s}^{-1}\) is a change in concentration per unit time, not a change in amount per unit time. The data supplied give only an amount change per time: \(\frac{0.20\ \text{mol}}{50\ \text{s}} = 4.0 \times 10^{-3}\ \text{mol s}^{-1}\). Molarity is moles per liter of solution, so converting this amount based quantity into a concentration based one requires dividing by the solution volume. For example, if the acid volume were \(2.0\ \text{L}\), the disappearance rate would be \(\frac{4.0 \times 10^{-3}\ \text{mol s}^{-1}}{2.0\ \text{L}} = 2.0 \times 10^{-3}\ \text{M s}^{-1}\). Without the volume, no value in \(\text{M s}^{-1}\) can be computed at all, which is precisely the distinction between an amount consumed and a reaction rate: the same \(0.20\ \text{mol}\) consumed in a smaller volume corresponds to a larger concentration change and therefore a larger rate.

(Choice B) The molar mass converts between moles and grams. The amount change is already given in moles, and neither molarity nor the rate involves mass, so the molar mass contributes nothing to the required conversion.

(Choice C) Temperature influences how fast the reaction actually proceeds, so it would change the measured numbers themselves, but it plays no role in converting an already measured molar amount and elapsed time into concentration per second.

(Choice D) Stoichiometric coefficients are needed to relate the rate of one species to that of a different species, for example zinc to \(\text{HCl}\). They are not needed to express the disappearance of \(\text{HCl}\) itself once its own amount change, the elapsed time, and the volume are known.

This is a Scientific Reasoning and Problem Solving question because you are asked to apply unit reasoning to determine what converts an amount change per time into a concentration change per time.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'scale_unit_error', $q$wrong unit conversion$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$true fact, wrong role$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$cross-species step misapplied$q$ FROM q;

-- Q5 . Reaction Rates & Rate Laws . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$The oxidation of bromide by bromate in acidic aqueous solution, \(\text{BrO}_3^- + 5\text{Br}^- + 6\text{H}^+ \rightarrow 3\text{Br}_2 + 3\text{H}_2\text{O}\), obeys the experimentally determined rate law \(\text{rate} = k[\text{BrO}_3^-][\text{Br}^-][\text{H}^+]^2\). The exponent of 2 on \([\text{H}^+]\) signifies that:$q$,
    $q$[{"label":"A","text":"the rate doubles whenever \\([\\text{H}^+]\\) is doubled with the other concentrations held constant"},{"label":"B","text":"the overall reaction is second order"},{"label":"C","text":"the reaction is second order with respect to \\(\\text{H}^+\\), a dependence established by experiment rather than by the balanced coefficients"},{"label":"D","text":"two \\(\\text{H}^+\\) ions collide simultaneously with the other reactants in every reactive event"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because each exponent in a rate law of the general form \(\text{rate} = k[\text{A}]^x[\text{B}]^y\) is the order of the reaction with respect to that species, and every such exponent is a purely experimental quantity. An exponent of 2 on \([\text{H}^+]\) states that the measured initial rate varies with the square of the hydrogen ion concentration when the other concentrations are held fixed, which is exactly what second order with respect to \(\text{H}^+\) means. The balanced equation plays no role in assigning that exponent: the stoichiometric coefficient of \(\text{H}^+\) in this reaction is 6, yet initial rate experiments return an order of 2. Such mismatches are common and entirely legitimate, because orders reflect the pathway by which the reaction actually occurs rather than the overall stoichiometry, and they can be established only by measuring how the rate responds as each concentration is varied. (Choice A) A rate that doubles when a concentration doubles is the signature of first order dependence. Because this reaction is second order in \(\text{H}^+\), doubling \([\text{H}^+]\) alone multiplies the rate by \(2^2 = 4\), not by 2. (Choice B) The overall order is the sum of every exponent in the law, here \(1 + 1 + 2 = 4\), so the reaction is fourth order overall. A single exponent conveys only the order with respect to its own species and cannot be equated with the overall order. (Choice D) The number of particles that collide in one reactive event is the molecularity, a quantity defined only for an individual elementary step within a mechanism. An exponent in an overall rate law does not certify that two \(\text{H}^+\) ions participate in any single collision; multistep mechanisms routinely generate second order dependence without any high order simultaneous encounter occurring. This is a Knowledge of Scientific Concepts and Principles question because you must recall that a rate law exponent defines the experimentally determined order of reaction with respect to a single species.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$linear-scaling intuition$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$species order promoted to overall order$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$molecularity misapplied to an overall law$q$ FROM q;

-- Q6 . Reaction Rates & Rate Laws . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Gas phase fluorination of nitrogen dioxide, \(2\text{NO}_2 + \text{F}_2 \rightarrow 2\text{NO}_2\text{F}\), follows the experimentally measured rate law \(\text{rate} = k[\text{NO}_2][\text{F}_2]\). The first order dependence on \(\text{NO}_2\), despite its stoichiometric coefficient of 2, most strongly supports which conclusion?$q$,
    $q$[{"label":"A","text":"The measurements contain a systematic error, because rate law exponents equal the coefficients of the balanced equation"},{"label":"B","text":"Only one \\(\\text{NO}_2\\) molecule participates up through the rate determining step of the mechanism, with the second consumed in a later fast step"},{"label":"C","text":"\\(\\text{F}_2\\) was present in large excess, which lowered the observed order in \\(\\text{NO}_2\\) from 2 to 1"},{"label":"D","text":"Since the overall order is 2, each of the two reactants must contribute exactly first order behavior"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because rate law exponents are set by the reaction's mechanism, above all by its slowest step, so a measured order that differs from a coefficient carries mechanistic information rather than signaling a problem. A first order dependence on \(\text{NO}_2\) indicates that only one \(\text{NO}_2\) molecule is involved in the reaction up through the rate determining step; the second \(\text{NO}_2\) required by the stoichiometry is consumed in a fast subsequent step, which leaves no imprint on the measured law. A mechanism consistent with the data is a slow step \(\text{NO}_2 + \text{F}_2 \rightarrow \text{NO}_2\text{F} + \text{F}\) followed by a fast step \(\text{F} + \text{NO}_2 \rightarrow \text{NO}_2\text{F}\); the slow step alone reproduces \(\text{rate} = k[\text{NO}_2][\text{F}_2]\), while the two steps sum to the balanced overall equation. (Choice A) Rate law exponents are determined only by experiment and are not reliably predicted by the balanced overall equation. Agreement between an order and a coefficient is coincidence, so a mismatch is expected behavior for a multistep reaction, not evidence that the measurements are wrong. (Choice C) Flooding a system with a large excess of one reactant holds that reactant's own concentration nearly constant, hiding its dependence inside a pseudo order rate constant. Excess \(\text{F}_2\) could therefore mask the order in \(\text{F}_2\), but it cannot convert a genuine second order dependence on \(\text{NO}_2\) into first order, because the \(\text{NO}_2\) exponent is probed by varying \([\text{NO}_2]\) itself. (Choice D) Knowing that the overall order is \(1 + 1 = 2\) places no constraint on how that total is distributed among the reactants; overall order is obtained by summing individually measured orders, never by apportioning a total backward onto each species. Reactions of overall order 2 include those that are second order in one reactant and zero order in the other. This is a Scientific Reasoning and Problem Solving question because you are asked to apply the relationship between an observed rate law and the mechanism that produces it.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$central trap: exponents read from coefficients$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$pseudo-order flooding misapplied$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$overall order apportioned backward$q$ FROM q;

-- Q7 . Reaction Rates & Rate Laws . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Initial rate experiments on the gas phase reaction \(2\text{NO} + 2\text{H}_2 \rightarrow \text{N}_2 + 2\text{H}_2\text{O}\) yield the rate law \(\text{rate} = k[\text{NO}]^2[\text{H}_2]\). Relative to a reference trial, a new trial is prepared in which \([\text{NO}]\) is halved and \([\text{H}_2]\) is quadrupled. The initial rate of the new trial will:$q$,
    $q$[{"label":"A","text":"remain equal to the reference rate"},{"label":"B","text":"double relative to the reference rate"},{"label":"C","text":"quadruple relative to the reference rate"},{"label":"D","text":"fall to one fourth of the reference rate"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the supplied law fixes the outcome exactly. The ratio of the new rate to the reference rate is \(\frac{\text{rate}_{\text{new}}}{\text{rate}_{\text{ref}}} = \left(\tfrac{1}{2}\right)^2 \times 4 = \tfrac{1}{4} \times 4 = 1\). Halving \([\text{NO}]\) cuts the rate to one fourth of its reference value because the dependence on \(\text{NO}\) is second order, while quadrupling \([\text{H}_2]\) multiplies the rate by 4 because the dependence on \(\text{H}_2\) is first order. The two effects cancel exactly, so the initial rate is unchanged even though both concentrations were altered substantially. This cancellation is a direct consequence of the unequal orders; if the reaction were first order in both species, the same changes would instead produce a net factor of \(\tfrac{1}{2} \times 4 = 2\). Note also that the exponents used here come from the measured law, not from the balanced coefficients, which would wrongly suggest second order behavior in \(\text{H}_2\) as well. (Choice B) A factor of 2 results from treating the \(\text{NO}\) dependence as first order and computing \(\tfrac{1}{2} \times 4 = 2\). Because the reaction is second order in \(\text{NO}\), the halving must be squared before it is combined with the \(\text{H}_2\) factor. (Choice C) A fourfold increase accounts only for the change in \([\text{H}_2]\) and ignores the simultaneous halving of \([\text{NO}]\). Both concentration changes act on the rate at once, so both factors must be multiplied together. (Choice D) A fourfold decrease is the isolated effect of halving \([\text{NO}]\), since \(\left(\tfrac{1}{2}\right)^2 = \tfrac{1}{4}\); it omits the quadrupling of \([\text{H}_2]\), which exactly offsets that reduction. This is a Scientific Reasoning and Problem Solving question because you are asked to predict the net change in rate produced by simultaneous changes in two reactant concentrations.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$exponent skipped: NO treated as first order$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$only the H2 change applied$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$only the NO change applied$q$ FROM q;

-- Q8 . Reaction Rates & Rate Laws . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Mercury(II) chloride reacts with oxalate ion in aqueous solution according to the balanced equation \(2\,\text{HgCl}_2(aq) + \text{C}_2\text{O}_4^{2-}(aq) \rightarrow 2\,\text{Cl}^-(aq) + 2\,\text{CO}_2(g) + \text{Hg}_2\text{Cl}_2(s)\). The experimentally determined rate law for the reaction is \(\text{rate} = k[\text{HgCl}_2][\text{C}_2\text{O}_4^{2-}]^2\). Based on this rate law, which assignment of reaction orders is correct?$q$,
    $q$[{"label":"A","text":"The reaction is second order with respect to \\(\\text{HgCl}_2\\) and third order overall."},{"label":"B","text":"The reaction is second order with respect to \\(\\text{C}_2\\text{O}_4^{2-}\\) and second order overall."},{"label":"C","text":"The reaction is third order with respect to \\(\\text{C}_2\\text{O}_4^{2-}\\) and third order overall."},{"label":"D","text":"The reaction is first order with respect to \\(\\text{HgCl}_2\\) and third order overall."}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because reaction orders are defined by the exponents in the experimentally determined rate law, not by the coefficients of the balanced equation. In the rate law \(\text{rate} = k[\text{HgCl}_2][\text{C}_2\text{O}_4^{2-}]^2\), the exponent on \([\text{HgCl}_2]\) is 1, so the reaction is first order with respect to \(\text{HgCl}_2\), and the exponent on \([\text{C}_2\text{O}_4^{2-}]\) is 2, so the reaction is second order with respect to oxalate ion. The overall order is the sum of the individual orders: \(1 + 2 = 3\), making the reaction third order overall. Notice that the balanced equation assigns a coefficient of 2 to \(\text{HgCl}_2\) and 1 to \(\text{C}_2\text{O}_4^{2-}\), the reverse of the exponents; such mismatches are common because a rate law reflects the reaction mechanism and can be established only by experiment. Choice D is the only option that pairs a correct individual order with the correct overall order.

(Choice A) The reaction is not second order with respect to \(\text{HgCl}_2\). This choice reads the order from the stoichiometric coefficient of 2 in the balanced equation instead of the exponent of 1 in the rate law. The stated overall order of 3 is correct, but only coincidentally, because the coefficients also happen to sum to 3; the with-respect-to order is wrong.

(Choice B) Second order with respect to \(\text{C}_2\text{O}_4^{2-}\) is correct, but the overall order is not 2. This choice takes the largest single exponent as the overall order rather than summing all of the exponents; the overall order is \(1 + 2 = 3\).

(Choice C) The reaction is indeed third order overall, but an overall order describes the entire rate law, never a single reactant. This choice transfers the overall order onto \(\text{C}_2\text{O}_4^{2-}\), whose individual order is 2, conflating order with respect to one species with the overall order.

This is a Scientific Reasoning and Problem Solving question because you are asked to extract each individual reaction order from a supplied experimental rate law and then combine those orders into the overall order, recognizing that the exponents, not the balanced coefficients, define both quantities.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$orders read from balanced coefficients$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$correct individual order, wrong sum$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$with-respect-to and overall order swapped$q$ FROM q;

-- Q9 . Reaction Rates & Rate Laws . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Nitrogen dioxide decomposes in a sealed vessel held at \(300\ ^\circ\text{C}\) according to \(2\text{NO}_2 \rightarrow 2\text{NO} + \text{O}_2\), with the experimentally determined rate law \(\text{rate} = k[\text{NO}_2]^2\). Which intervention will increase the value of \(k\)?$q$,
    $q$[{"label":"A","text":"Injecting additional \\(\\text{NO}_2\\) into the vessel, since more molecules per unit volume increase the frequency factor \\(A\\)"},{"label":"B","text":"Raising the vessel temperature to \\(350\\ ^\\circ\\text{C}\\)"},{"label":"C","text":"Transferring the mixture to a vessel of half the volume so that \\(\\text{NO}_2\\) molecules collide more often"},{"label":"D","text":"Sampling the mixture during the first seconds of the reaction, when the rate is at its maximum"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The rate constant \(k\) is a proportionality constant that is specific to a given reaction at a given temperature. It is independent of the reactant concentrations, which influence the rate only through the concentration terms of the rate law. The answer to this question is B because temperature is the variable in this list that changes \(k\). According to the Arrhenius equation, \(k = A e^{-E_a/RT}\), raising the temperature from \(300\ ^\circ\text{C}\) to \(350\ ^\circ\text{C}\) increases the fraction of collisions that carry at least the activation energy \(E_a\), so the exponential factor grows and \(k\) takes a larger value. Every concentration-based intervention in the other choices changes the rate, not the rate constant. (Choice A) The frequency factor \(A\) is a constant of the Arrhenius equation that reflects the collision frequency and orientation requirements characteristic of the reaction itself; it is not increased by adding molecules to the vessel. Additional \(\text{NO}_2\) raises the rate through the \([\text{NO}_2]^2\) term of the rate law, while \(A\) and \(k\) remain unchanged. (Choice C) Halving the volume doubles \([\text{NO}_2]\) and therefore quadruples the rate through the squared concentration term, but this is a change in the rate, not in \(k\). The proportionality constant is untouched by compression at constant temperature. (Choice D) The rate is indeed greatest in the first seconds, when \([\text{NO}_2]\) is highest, but that early maximum reflects the concentration factor of the rate law, not its proportionality constant. Choosing an earlier sampling time changes which instantaneous rate is observed; it has no influence on \(k\), which is set by the identity of the reaction and the vessel temperature. This is a Scientific Reasoning and Problem Solving question because you are asked to predict which experimental change alters the rate constant rather than the rate.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$concentration routed through A$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$rate change misattributed to k$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$instantaneous rate confused with k$q$ FROM q;

-- Q10 . Reaction Rates & Rate Laws . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$In acidic solution, hydrogen peroxide oxidizes iodide ion with the experimentally determined rate law \(\text{rate} = k[\text{H}_2\text{O}_2][\text{I}^-]\), where \(k = 1.0 \times 10^{-2}\ \text{M}^{-1}\text{s}^{-1}\) at \(25\ ^\circ\text{C}\). What is the initial rate of the reaction in a mixture prepared with \([\text{H}_2\text{O}_2] = 0.20\ \text{M}\) and \([\text{I}^-] = 0.10\ \text{M}\)?$q$,
    $q$[{"label":"A","text":"\\(2.0 \\times 10^{-4}\\ \\text{M s}^{-1}\\)"},{"label":"B","text":"\\(2.0 \\times 10^{-3}\\ \\text{M s}^{-1}\\)"},{"label":"C","text":"\\(3.0 \\times 10^{-3}\\ \\text{M s}^{-1}\\)"},{"label":"D","text":"\\(2.0 \\times 10^{-2}\\ \\text{M s}^{-1}\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. A rate law converts a rate constant and a set of concentrations into a predicted rate, and every concentration that appears in the law must be substituted. The answer to this question is A because direct substitution gives \(\text{rate} = k[\text{H}_2\text{O}_2][\text{I}^-] = (1.0 \times 10^{-2}\ \text{M}^{-1}\text{s}^{-1})(0.20\ \text{M})(0.10\ \text{M})\). Multiplying the concentrations first, \(0.20 \times 0.10 = 2.0 \times 10^{-2}\), and then applying the rate constant gives \((1.0 \times 10^{-2}) \times (2.0 \times 10^{-2}) = 2.0 \times 10^{-4}\ \text{M s}^{-1}\). The units confirm the setup: \(\text{M}^{-1}\text{s}^{-1} \times \text{M} \times \text{M} = \text{M s}^{-1}\), the correct units for a rate. The \(\text{M}^{-1}\text{s}^{-1}\) units of \(k\) are themselves the signature of a reaction that is second order overall, consistent with a law that is first order in each of two reactants. (Choice B) This value results from omitting the iodide concentration entirely and computing \(k[\text{H}_2\text{O}_2] = (1.0 \times 10^{-2})(0.20) = 2.0 \times 10^{-3}\). Because \([\text{I}^-] = 0.10\ \text{M}\), skipping it inflates the answer by exactly one power of ten, and the units of the product would not reduce to \(\text{M s}^{-1}\). (Choice C) This value comes from adding the concentrations, \(0.20 + 0.10 = 0.30\), and multiplying the sum by \(k\). Concentration terms in a rate law are factors that multiply; they are never summed, because each reactant contributes independently to the collision probability. (Choice D) This value comes from dividing the concentrations, \(k \times \frac{0.20}{0.10} = (1.0 \times 10^{-2})(2.0) = 2.0 \times 10^{-2}\). A ratio of concentrations appears in comparisons between trials, not in the evaluation of a single rate from a single set of conditions. This is a Scientific Reasoning and Problem Solving question because you are asked to calculate an initial rate by substituting a rate constant and concentrations into an experimentally determined rate law.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$dropped concentration factor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$summed instead of multiplied$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$ratio in place of product$q$ FROM q;

-- Q11 . Reaction Rates & Rate Laws . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Ozone decomposes to oxygen in a darkened reaction chamber held at constant temperature, following the experimentally determined rate law \(\text{rate} = k[\text{O}_3]^2\). By the time \([\text{O}_3]\) has fallen to one third of its initial value, how have the instantaneous rate and the rate constant each changed from their values at the start of the run?$q$,
    $q$[{"label":"A","text":"The rate and \\(k\\) have both fallen to one ninth of their initial values"},{"label":"B","text":"The rate has fallen to one third of its initial value, and \\(k\\) is unchanged"},{"label":"C","text":"The rate is unchanged, and \\(k\\) has fallen to one ninth of its initial value"},{"label":"D","text":"The rate has fallen to one ninth of its initial value, and \\(k\\) is unchanged"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. This question turns on the distinction between the reaction rate, which changes continuously during a run, and the rate constant, which does not. The answer to this question is D because the two quantities behave differently as ozone is consumed. The instantaneous rate obeys \(\text{rate} = k[\text{O}_3]^2\), so when \([\text{O}_3]\) reaches one third of its initial value the rate falls by a factor of \(\left(\frac{1}{3}\right)^2 = \frac{1}{9}\). The rate constant, by contrast, is a proportionality constant fixed by the identity of the reaction and the temperature. Because the chamber is held at constant temperature, \(k\) keeps exactly the same value from the first instant of the run to the last; only the concentration factor in the rate law evolves with time, and it alone carries the slowdown. (Choice A) This treats \(k\) as if it tracked the measured rate. The rate does fall to one ninth of its initial value, but the decline is produced entirely by the \([\text{O}_3]^2\) term; \(k\) is independent of concentration and cannot decay as reactant is consumed. If \(k\) also fell ninefold, the observed rate would drop by a factor of \(81\), which contradicts the rate law. (Choice B) A rate reduced to one third would follow from a law that is first order in ozone. The experimentally determined law is second order in ozone, so the concentration ratio must be squared: the correct factor is \(\left(\frac{1}{3}\right)^2 = \frac{1}{9}\), not \(\frac{1}{3}\). The claim that \(k\) is unchanged is correct, but the rate portion fails. (Choice C) This reverses the two quantities. The concentration-dependent quantity is the rate, which necessarily slows as \([\text{O}_3]\) drops; the temperature-dependent quantity is \(k\), which would change only if the chamber temperature changed. A rate that stayed constant while concentration fell would violate the rate law itself. This is a Scientific Reasoning and Problem Solving question because you are asked to apply a second-order rate law to predict how the rate and the rate constant each change as a reaction proceeds at fixed temperature.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$k conflated with rate$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$exponent not applied$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$role reversal of rate and k$q$ FROM q;

-- Q12 . Reaction Rates & Rate Laws . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Rates & Rate Laws$q$,
    $q$Two solution-phase substitution reactions are each experimentally first order in each of their two reactants, and both are run at \(25\ ^\circ\text{C}\) with every reactant present at \(0.10\ \text{M}\). The measured initial rate of one reaction is roughly \(10^6\) times that of the other. What property of the faster reaction accounts for the difference?$q$,
    $q$[{"label":"A","text":"Its rate-law exponents are larger because its balanced equation has larger stoichiometric coefficients"},{"label":"B","text":"It is being run at its optimal temperature, whereas the slower reaction is not"},{"label":"C","text":"Its rate constant is far larger, reflecting a much smaller energy barrier that lets a vastly greater fraction of collisions react"},{"label":"D","text":"Its reactants are smaller molecules that diffuse through the solvent more rapidly"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. When two reactions share the same rate-law form, the same concentrations, and the same temperature, the concentration factors of their rate laws are numerically identical, so any remaining difference in rate must live in the rate constant. The answer to this question is C because \(k\) is the quantity that carries the chemistry of a particular reaction. In the Arrhenius equation, \(k = A e^{-E_a/RT}\), the exponential term is extraordinarily sensitive to the activation energy: a modest decrease in \(E_a\) produces an enormous increase in the fraction of collisions energetic enough to cross the barrier. A factor of \(10^6\) between two rate constants at \(25\ ^\circ\text{C}\) corresponds to a barrier difference of only a few tens of \(\text{kJ mol}^{-1}\), so reactions with identical conditions can easily differ a million-fold in rate simply because their intrinsic barriers differ. (Choice A) Rate-law exponents are experimental quantities determined from data such as initial-rate measurements; they cannot be read from the stoichiometric coefficients of the balanced equation. Moreover, the stem specifies that both reactions are first order in each reactant, so the exponents are identical and cannot explain any difference. (Choice B) Ordinary chemical reactions do not possess an optimal temperature; the Arrhenius equation predicts that the rate constant increases monotonically as temperature rises. Only enzyme-catalyzed reactions show a rate maximum, because the protein catalyst is structurally disrupted above a characteristic temperature. Both reactions here are at the same temperature in any case. (Choice D) Diffusion rates in solution do vary with molecular size, but only over a small range, far too narrow to produce a \(10^6\) ratio. Differences of that magnitude at fixed temperature and concentration reflect the exponential dependence of \(k\) on the energy barrier, not the transport of reactants to one another. This is a Knowledge of Scientific Concepts and Principles question because you must recall that the rate constant, through the Arrhenius equation, encodes the reaction-specific energy barrier that sets how fast a reaction proceeds under given conditions.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$stoichiometry-to-exponent trap$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$optimal-temperature erratum$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$transport misattribution$q$ FROM q;

-- Q13 . Reaction Order & the Method of Initial Rates . easy . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$At \(100\ ^\circ\text{C}\), the gas-phase reaction \(\text{NO}_2(g) + \text{CO}(g) \rightarrow \text{NO}(g) + \text{CO}_2(g)\) was studied by the method of initial rates.
Trial 1: \([\text{NO}_2] = 0.10\ \text{M}\), \([\text{CO}] = 0.20\ \text{M}\), initial rate \(= 4.0 \times 10^{-5}\ \text{M s}^{-1}\)
Trial 2: \([\text{NO}_2] = 0.20\ \text{M}\), \([\text{CO}] = 0.20\ \text{M}\), initial rate \(= 1.6 \times 10^{-4}\ \text{M s}^{-1}\)
What is the order of the reaction with respect to \(\text{NO}_2\)?$q$,
    $q$[{"label":"A","text":"Zero order"},{"label":"B","text":"First order"},{"label":"C","text":"Second order"},{"label":"D","text":"The order cannot be determined because \\([\\text{CO}]\\) was not varied"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the two trials isolate the effect of \(\text{NO}_2\) on the rate: \([\text{CO}]\) is fixed at \(0.20\ \text{M}\) in both trials, while \([\text{NO}_2]\) doubles from \(0.10\ \text{M}\) to \(0.20\ \text{M}\). Writing the rate law as \(\text{rate} = k[\text{NO}_2]^m[\text{CO}]^n\) and taking the ratio of the two trials cancels both \(k\) and the unchanged \([\text{CO}]^n\) factor, leaving \(\frac{1.6 \times 10^{-4}}{4.0 \times 10^{-5}} = 4 = 2^m\). Solving gives \(m = 2\): the reaction is second order in \(\text{NO}_2\), because doubling its concentration quadrupled the initial rate. Reaction orders are experimental quantities that describe how the measured rate responds to concentration changes, and a fourfold response to a twofold change is the signature of a squared concentration dependence.

(Choice A) If the reaction were zero order in \(\text{NO}_2\), the initial rate would be identical in both trials even though \([\text{NO}_2]\) doubled. The observed fourfold rate increase directly excludes a zero-order dependence; in this reaction it is \(\text{CO}\), not \(\text{NO}_2\), whose concentration has no effect on the rate.

(Choice B) First order corresponds to reading the exponent from the stoichiometric coefficient of \(\text{NO}_2\) in the balanced equation, which is 1. Rate-law exponents are never taken from a balanced overall equation; they must come from experiment. A genuine first-order dependence would have produced only a twofold rate increase, not the fourfold increase observed.

(Choice D) Varying \([\text{CO}]\) would be necessary to determine the order with respect to \(\text{CO}\), but it is not needed to find the order in \(\text{NO}_2\). Holding \([\text{CO}]\) constant is precisely what makes the comparison between the two trials a clean measurement of the \(\text{NO}_2\) dependence.

This is a Data-based and Statistical Reasoning question because you must calculate a reaction order from paired initial-rate data.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- Q14 . Reaction Order & the Method of Initial Rates . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$Initial-rate data were collected for the gas-phase reaction \(2\text{NO}(g) + 2\text{H}_2(g) \rightarrow \text{N}_2(g) + 2\text{H}_2\text{O}(g)\).
Trial 1: \([\text{NO}] = 0.10\ \text{M}\), \([\text{H}_2] = 0.10\ \text{M}\), initial rate \(= 2.0 \times 10^{-3}\ \text{M s}^{-1}\)
Trial 2: \([\text{NO}] = 0.20\ \text{M}\), \([\text{H}_2] = 0.10\ \text{M}\), initial rate \(= 8.0 \times 10^{-3}\ \text{M s}^{-1}\)
Trial 3: \([\text{NO}] = 0.10\ \text{M}\), \([\text{H}_2] = 0.20\ \text{M}\), initial rate \(= 4.0 \times 10^{-3}\ \text{M s}^{-1}\)
Which rate law is consistent with these data?$q$,
    $q$[{"label":"A","text":"\\(\\text{rate} = k[\\text{NO}][\\text{H}_2]\\)"},{"label":"B","text":"\\(\\text{rate} = k[\\text{NO}][\\text{H}_2]^2\\)"},{"label":"C","text":"\\(\\text{rate} = k[\\text{NO}]^2[\\text{H}_2]^2\\)"},{"label":"D","text":"\\(\\text{rate} = k[\\text{NO}]^2[\\text{H}_2]\\)"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because each reactant's order must be extracted from a trial pair in which only that reactant's concentration changes. Comparing Trials 1 and 2, \([\text{H}_2]\) is fixed while \([\text{NO}]\) doubles, and the rate ratio is \(\frac{8.0 \times 10^{-3}}{2.0 \times 10^{-3}} = 4 = 2^m\), so \(m = 2\). Comparing Trials 1 and 3, \([\text{NO}]\) is fixed while \([\text{H}_2]\) doubles, and the rate ratio is \(\frac{4.0 \times 10^{-3}}{2.0 \times 10^{-3}} = 2 = 2^n\), so \(n = 1\). Assembling the exponents gives \(\text{rate} = k[\text{NO}]^2[\text{H}_2]\): second order in \(\text{NO}\), first order in \(\text{H}_2\), and third order overall.

(Choice A) Assigning first order to each reactant follows from noticing that the rate increased whenever a concentration was raised, without quantifying the increase. The analysis must match the size of the rate change to the size of the concentration change: a doubled \([\text{NO}]\) produced a fourfold rate change, which first-order behavior cannot explain.

(Choice B) This choice swaps the two exponents, attributing the fourfold rate response to \(\text{H}_2\) and the twofold response to \(\text{NO}\). The trial pairing shows the opposite: the fourfold change occurs in the pair where \([\text{NO}]\) varies (Trials 1 and 2), and the twofold change occurs where \([\text{H}_2]\) varies (Trials 1 and 3).

(Choice C) Squaring both concentrations reproduces the stoichiometric coefficients of the balanced equation, both of which are 2. Rate-law exponents are experimental quantities and are under no obligation to match coefficients; here the data assign \(\text{H}_2\) an order of 1 even though its coefficient is 2.

This is a Data-based and Statistical Reasoning question because you must calculate both reaction orders from multi-trial initial-rate data and assemble them into a complete rate law.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- Q15 . Reaction Order & the Method of Initial Rates . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$Methanol reacts with ethyl acetate in solution: \(\text{CH}_3\text{OH} + \text{CH}_3\text{CH}_2\text{OCOCH}_3 \rightarrow \text{CH}_3\text{OCOCH}_3 + \text{CH}_3\text{CH}_2\text{OH}\). Initial rates were measured in three trials, with ethyl acetate abbreviated \(\text{EA}\).
Trial 1: \([\text{CH}_3\text{OH}] = 0.20\ \text{M}\), \([\text{EA}] = 0.20\ \text{M}\), initial rate \(= 1.5 \times 10^{-4}\ \text{M s}^{-1}\)
Trial 2: \([\text{CH}_3\text{OH}] = 0.40\ \text{M}\), \([\text{EA}] = 0.20\ \text{M}\), initial rate \(= 3.0 \times 10^{-4}\ \text{M s}^{-1}\)
Trial 3: \([\text{CH}_3\text{OH}] = 0.40\ \text{M}\), \([\text{EA}] = 0.40\ \text{M}\), initial rate \(= 3.0 \times 10^{-4}\ \text{M s}^{-1}\)
What is the overall order of this reaction?$q$,
    $q$[{"label":"A","text":"Zero order overall"},{"label":"B","text":"First order overall"},{"label":"C","text":"Second order overall"},{"label":"D","text":"The overall order cannot be determined because the rate did not change between Trials 2 and 3"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because the overall order is the sum of the individual orders, each of which must first be deduced from the trials. Between Trials 1 and 2, \([\text{EA}]\) is fixed while \([\text{CH}_3\text{OH}]\) doubles, and the rate doubles from \(1.5 \times 10^{-4}\ \text{M s}^{-1}\) to \(3.0 \times 10^{-4}\ \text{M s}^{-1}\); since \(2^1 = 2\), the reaction is first order in methanol. Between Trials 2 and 3, \([\text{CH}_3\text{OH}]\) is fixed while \([\text{EA}]\) doubles, and the rate is unchanged; since \(2^0 = 1\), the reaction is zero order in ethyl acetate. The rate law is \(\text{rate} = k[\text{CH}_3\text{OH}]^1[\text{EA}]^0 = k[\text{CH}_3\text{OH}]\), and the overall order is \(1 + 0 = 1\): the reaction is first order overall.

(Choice A) Zero order is the correct exponent for ethyl acetate alone, but the overall order sums every exponent in the rate law. Extending one reactant's zero-order behavior to the entire reaction ignores the first-order dependence on methanol demonstrated by Trials 1 and 2.

(Choice C) Second order results from adding the stoichiometric coefficients of the two reactants, each of which is 1. Rate-law exponents come only from experimental data, never from the balanced equation, and here the data assign ethyl acetate an exponent of zero despite its coefficient of 1.

(Choice D) An unchanged rate is not a failed or uninformative measurement; it is decisive data. When a reactant's concentration doubles and the rate does not respond, the exponent on that reactant is zero. The three trials therefore determine both orders completely, and the overall order follows directly.

This is a Data-based and Statistical Reasoning question because you must calculate the individual reaction orders from trial data and combine them into an overall order.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- Q16 . Reaction Order & the Method of Initial Rates . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$To determine the rate law for the aqueous reaction \(\text{OCl}^-(aq) + \text{I}^-(aq) \rightarrow \text{OI}^-(aq) + \text{Cl}^-(aq)\) by the method of initial rates, two trials at the same temperature are compared: \([\text{I}^-]\) is twice as large in the second trial, while \([\text{OCl}^-]\) is set to the same value in both. Why does this design allow the change in initial rate between the trials to be attributed to \(\text{I}^-\)?$q$,
    $q$[{"label":"A","text":"The contribution of \\([\\text{OCl}^-]\\) to the rate is identical in both trials, so it cancels when the two rates are compared, isolating the dependence on \\([\\text{I}^-]\\)"},{"label":"B","text":"Holding \\([\\text{OCl}^-]\\) constant is what keeps the rate constant \\(k\\) from changing between the two trials"},{"label":"C","text":"Holding \\([\\text{OCl}^-]\\) constant forces the exponent on \\([\\text{I}^-]\\) to equal its stoichiometric coefficient in the balanced equation"},{"label":"D","text":"Setting up the trials this way guarantees that the rate will double, confirming that the reaction is first order in \\(\\text{I}^-\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the method of initial rates is built on single-variable isolation. The rate law has the form \(\text{rate} = k[\text{OCl}^-]^x[\text{I}^-]^y\). When the ratio of the two trial rates is taken, every factor that is identical in both trials cancels: \(k\) cancels because the temperature is unchanged, and \([\text{OCl}^-]^x\) cancels because that concentration was deliberately set to the same value. What remains is \(\frac{\text{rate}_2}{\text{rate}_1} = \left(\frac{[\text{I}^-]_2}{[\text{I}^-]_1}\right)^y = 2^y\), so the entire measured rate change is attributable to the one variable that differed, and the exponent \(y\) can be read from the size of that change. If both concentrations varied at once, the two dependences would be confounded and neither exponent could be assigned from the pair.

(Choice B) The rate constant \(k\) is indeed the same in both trials, but not because \([\text{OCl}^-]\) was held constant. \(k\) is independent of reactant concentrations altogether; it varies with temperature. Concentration control cannot be the reason \(k\) stays fixed, so this cannot be the logic that validates the comparison.

(Choice C) No experimental design can force a rate-law exponent to equal a stoichiometric coefficient. Exponents are empirical quantities, and the purpose of the design is to measure them, whatever they turn out to be; measured orders frequently differ from the coefficients in the balanced equation.

(Choice D) The design guarantees nothing about the outcome. Doubling \([\text{I}^-]\) could leave the rate unchanged (zero order), double it (first order), or quadruple it (second order). Presuming the result inverts the logic of the experiment, which draws its conclusion from the observed rate change rather than dictating it in advance.

This is a Reasoning about the Design and Execution of Research question because you must evaluate why holding all other concentrations constant isolates a single variable in the experimental design.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    3,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- Q17 . Reaction Order & the Method of Initial Rates . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$In aqueous solution, peroxydisulfate ion oxidizes iodide ion according to \(\text{S}_2\text{O}_8^{2-} + 3\text{I}^- \rightarrow 2\text{SO}_4^{2-} + \text{I}_3^-\). Initial-rate data were collected at constant temperature. Trial 1: \([\text{S}_2\text{O}_8^{2-}] = 0.10\ \text{M}\), \([\text{I}^-] = 0.10\ \text{M}\), initial rate \(= 2.0 \times 10^{-4}\ \text{M s}^{-1}\). Trial 2: \([\text{S}_2\text{O}_8^{2-}] = 0.20\ \text{M}\), \([\text{I}^-] = 0.10\ \text{M}\), initial rate \(= 4.0 \times 10^{-4}\ \text{M s}^{-1}\). Trial 3: \([\text{S}_2\text{O}_8^{2-}] = 0.20\ \text{M}\), \([\text{I}^-] = 0.20\ \text{M}\), initial rate \(= 8.0 \times 10^{-4}\ \text{M s}^{-1}\). What is the value of the rate constant \(k\) for this reaction?$q$,
    $q$[{"label":"A","text":"\\(2.0 \\times 10^{-2}\\ \\text{s}^{-1}\\)"},{"label":"B","text":"\\(2.0 \\times 10^{-2}\\ \\text{M}^{-1}\\text{s}^{-1}\\)"},{"label":"C","text":"\\(2.0\\ \\text{M}^{-3}\\text{s}^{-1}\\)"},{"label":"D","text":"\\(2.0 \\times 10^{-3}\\ \\text{M}^{-1}\\text{s}^{-1}\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because the trial comparisons establish first-order dependence on each reactant, and substituting any single trial into the resulting law yields \(k = 2.0 \times 10^{-2}\ \text{M}^{-1}\text{s}^{-1}\). Comparing Trial 1 to Trial 2, \([\text{S}_2\text{O}_8^{2-}]\) doubles while \([\text{I}^-]\) is held constant, and the rate doubles from \(2.0 \times 10^{-4}\ \text{M s}^{-1}\) to \(4.0 \times 10^{-4}\ \text{M s}^{-1}\), so the reaction is first order in \(\text{S}_2\text{O}_8^{2-}\). Comparing Trial 2 to Trial 3, \([\text{I}^-]\) doubles at fixed \([\text{S}_2\text{O}_8^{2-}]\) and the rate doubles again, so the reaction is also first order in \(\text{I}^-\). The law is \(\text{rate} = k[\text{S}_2\text{O}_8^{2-}][\text{I}^-]\), and Trial 1 gives \(k = \frac{2.0 \times 10^{-4}\ \text{M s}^{-1}}{(0.10\ \text{M})(0.10\ \text{M})} = 2.0 \times 10^{-2}\ \text{M}^{-1}\text{s}^{-1}\). The units fall out of the arithmetic: \(\text{M s}^{-1}\) divided by \(\text{M}^2\) leaves \(\text{M}^{-1}\text{s}^{-1}\), the characteristic units of an overall second-order rate constant. (Choice A) The numerical value is correct, but \(\text{s}^{-1}\) is the unit set of a first-order rate constant. Dividing a rate in \(\text{M s}^{-1}\) by the product of two concentrations, with combined units of \(\text{M}^2\), necessarily leaves \(\text{M}^{-1}\text{s}^{-1}\); the units of \(k\) always encode the overall reaction order. (Choice C) This value arises from writing the law as \(\text{rate} = k[\text{S}_2\text{O}_8^{2-}][\text{I}^-]^3\), importing the exponent from the stoichiometric coefficient of \(\text{I}^-\) in the balanced equation. Rate-law exponents are experimental quantities: the data show that doubling \([\text{I}^-]\) merely doubles the rate, which is first-order behavior, not third-order behavior. (Choice D) This value results from dividing the initial rate by only one concentration factor of \(0.10\ \text{M}\) instead of by the product \((0.10\ \text{M})(0.10\ \text{M})\); the second-order units are copied correctly from the rate law, but the incomplete substitution makes the numerical value ten times too small. This is a Data-based and Statistical Reasoning question because you must calculate the rate constant and its units from experimental trial data.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$right number, wrong rate-constant units$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$stoichiometric-coefficient exponent (central trap)$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$incomplete denominator substitution$q$ FROM q;

-- Q18 . Reaction Order & the Method of Initial Rates . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$Chlorine dioxide reacts in basic solution according to \(2\text{ClO}_2 + 2\text{OH}^- \rightarrow \text{ClO}_3^- + \text{ClO}_2^- + \text{H}_2\text{O}\). Initial rates were measured at constant temperature. Trial 1: \([\text{ClO}_2] = 0.010\ \text{M}\), \([\text{OH}^-] = 0.030\ \text{M}\), initial rate \(= 3.0 \times 10^{-4}\ \text{M s}^{-1}\). Trial 2: \([\text{ClO}_2] = 0.030\ \text{M}\), \([\text{OH}^-] = 0.030\ \text{M}\), initial rate \(= 2.7 \times 10^{-3}\ \text{M s}^{-1}\). Trial 3: \([\text{ClO}_2] = 0.030\ \text{M}\), \([\text{OH}^-] = 0.090\ \text{M}\), initial rate \(= 8.1 \times 10^{-3}\ \text{M s}^{-1}\). What is the experimental rate law for this reaction?$q$,
    $q$[{"label":"A","text":"\\(\\text{rate} = k[\\text{ClO}_2]^2[\\text{OH}^-]\\)"},{"label":"B","text":"\\(\\text{rate} = k[\\text{ClO}_2]^2[\\text{OH}^-]^2\\)"},{"label":"C","text":"\\(\\text{rate} = k[\\text{ClO}_2]^3[\\text{OH}^-]\\)"},{"label":"D","text":"\\(\\text{rate} = k[\\text{ClO}_2][\\text{OH}^-]^2\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the trial ratios show second-order dependence on \(\text{ClO}_2\) and first-order dependence on \(\text{OH}^-\). Comparing Trial 1 to Trial 2, \([\text{ClO}_2]\) triples at constant \([\text{OH}^-]\) and the rate increases from \(3.0 \times 10^{-4}\ \text{M s}^{-1}\) to \(2.7 \times 10^{-3}\ \text{M s}^{-1}\), a factor of 9. Since \(3^m = 9\), the order is \(m = 2\). Comparing Trial 2 to Trial 3, \([\text{OH}^-]\) triples at constant \([\text{ClO}_2]\) and the rate increases from \(2.7 \times 10^{-3}\ \text{M s}^{-1}\) to \(8.1 \times 10^{-3}\ \text{M s}^{-1}\), a factor of 3, so \(3^n = 3\) and \(n = 1\). The experimental law is \(\text{rate} = k[\text{ClO}_2]^2[\text{OH}^-]\), third order overall. (Choice B) This law copies both stoichiometric coefficients from the balanced equation, and it survives the first comparison because it also predicts a ninefold increase when \([\text{ClO}_2]\) triples. It fails the second comparison: second-order dependence on \(\text{OH}^-\) would require the Trial 3 rate to be \(9 \times 2.7 \times 10^{-3}\ \text{M s}^{-1} = 2.43 \times 10^{-2}\ \text{M s}^{-1}\), not the observed \(8.1 \times 10^{-3}\ \text{M s}^{-1}\). Rate-law exponents come from data, never from coefficients. (Choice C) Third-order dependence on \(\text{ClO}_2\) results from treating the ninefold rate change as if the exponent were obtained by dividing 9 by the concentration factor of 3. The correct step solves \(3^m = 9\), giving \(m = 2\); a third-order dependence would have produced a factor of \(3^3 = 27\). (Choice D) Swapping the two orders predicts only a threefold rate increase when \([\text{ClO}_2]\) triples and a ninefold increase when \([\text{OH}^-]\) triples, the opposite of both observed ratios, even though this law has the same overall order of 3 as the correct one. This is a Data-based and Statistical Reasoning question because you must interpret initial-rate ratios across trials to extract each reaction order.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$stoichiometric-coefficient exponents (central trap)$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$factor-to-exponent step botched$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$orders exchanged between reactants$q$ FROM q;

-- Q19 . Reaction Order & the Method of Initial Rates . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$Acetone reacts with iodine in aqueous solution according to \(\text{CH}_3\text{COCH}_3 + \text{I}_2 \rightarrow \text{CH}_3\text{COCH}_2\text{I} + \text{HI}\). Initial rates were measured with all other conditions held constant. Trial 1: \([\text{CH}_3\text{COCH}_3] = 0.20\ \text{M}\), \([\text{I}_2] = 0.010\ \text{M}\), initial rate \(= 1.2 \times 10^{-5}\ \text{M s}^{-1}\). Trial 2: \([\text{CH}_3\text{COCH}_3] = 0.20\ \text{M}\), \([\text{I}_2] = 0.020\ \text{M}\), initial rate \(= 1.2 \times 10^{-5}\ \text{M s}^{-1}\). Trial 3: \([\text{CH}_3\text{COCH}_3] = 0.40\ \text{M}\), \([\text{I}_2] = 0.020\ \text{M}\), initial rate \(= 2.4 \times 10^{-5}\ \text{M s}^{-1}\). What is the order of the reaction with respect to \(\text{I}_2\)?$q$,
    $q$[{"label":"A","text":"First order"},{"label":"B","text":"Second order"},{"label":"C","text":"The order cannot be determined from initial-rate data alone"},{"label":"D","text":"Zero order"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the rate is unchanged when \([\text{I}_2]\) doubles, and invariance corresponds to an exponent of zero. Comparing Trial 1 to Trial 2, \([\text{I}_2]\) doubles from \(0.010\ \text{M}\) to \(0.020\ \text{M}\) while \([\text{CH}_3\text{COCH}_3]\) is held at \(0.20\ \text{M}\), yet the initial rate stays at \(1.2 \times 10^{-5}\ \text{M s}^{-1}\). The rate ratio is 1, and the only exponent satisfying \(2^n = 1\) is \(n = 0\): the reaction is zero order in \(\text{I}_2\), so \(\text{I}_2\) does not appear in the rate law even though it is consumed by the reaction. The remaining comparison confirms the method: doubling \([\text{CH}_3\text{COCH}_3]\) between Trials 2 and 3 doubles the rate, which is first-order behavior, giving \(\text{rate} = k[\text{CH}_3\text{COCH}_3]\) under these conditions. Zero-order dependence typically signals that the species becomes involved only after the rate-determining step of the mechanism. (Choice A) First-order dependence is what the balanced equation's coefficient of 1 for \(\text{I}_2\) would suggest, but rate-law exponents are determined experimentally, never read from stoichiometry. First order would require the rate to double along with \([\text{I}_2]\), which these data rule out. (Choice B) Second-order dependence would multiply the rate by \(2^2 = 4\) when the concentration doubles. This choice imports the outcome of the most familiar doubling experiments, in which a doubled concentration quadruples the rate, instead of reading the actual invariance in these trials. (Choice C) Initial-rate data cannot establish a mechanism, but they are exactly the experiment that establishes reaction orders. A controlled comparison in which one concentration changes while the measured rate does not is decisive: the exponent is zero. This is a Data-based and Statistical Reasoning question because you must interpret the invariance of measured rates across trials to assign a reaction order.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$stoichiometric-coefficient exponent (central trap)$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$pattern-matched to the familiar doubling outcome$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true limitation applied to the wrong question$q$ FROM q;

-- Q20 . Reaction Order & the Method of Initial Rates . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$For the gas-phase reaction \(\text{NO}_2 + \text{CO} \rightarrow \text{NO} + \text{CO}_2\) at \(100\ ^\circ\text{C}\), initial-rate experiments established the rate law \(\text{rate} = k[\text{NO}_2]^2\). In a reference run with \([\text{NO}_2] = 0.10\ \text{M}\) and \([\text{CO}] = 0.10\ \text{M}\), the initial rate was \(4.0 \times 10^{-4}\ \text{M s}^{-1}\). What initial rate is predicted when the reaction is run with \([\text{NO}_2] = 0.30\ \text{M}\) and \([\text{CO}] = 0.20\ \text{M}\)?$q$,
    $q$[{"label":"A","text":"\\(1.2 \\times 10^{-3}\\ \\text{M s}^{-1}\\)"},{"label":"B","text":"\\(7.2 \\times 10^{-3}\\ \\text{M s}^{-1}\\)"},{"label":"C","text":"\\(3.6 \\times 10^{-3}\\ \\text{M s}^{-1}\\)"},{"label":"D","text":"\\(3.6 \\times 10^{-2}\\ \\text{M s}^{-1}\\)"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the experimental law \(\text{rate} = k[\text{NO}_2]^2\) makes the rate depend on \([\text{NO}_2]\) alone. Rather than evaluating \(k\), compare the new conditions with the reference run as a ratio: \(\frac{\text{rate}_2}{\text{rate}_1} = \left(\frac{0.30\ \text{M}}{0.10\ \text{M}}\right)^2 = 3^2 = 9\). The doubling of \([\text{CO}]\) contributes a factor of \(2^0 = 1\) because the reaction is zero order in \(\text{CO}\); a species absent from the rate law cannot change the rate no matter how its concentration is varied. The predicted rate is therefore \(9 \times 4.0 \times 10^{-4}\ \text{M s}^{-1} = 3.6 \times 10^{-3}\ \text{M s}^{-1}\). This system is a standard reminder that the rate law is an experimental result: \(\text{CO}\) appears in the balanced equation with the same coefficient as \(\text{NO}_2\), yet the kinetics at this temperature are governed entirely by \(\text{NO}_2\). (Choice A) A rate of \(1.2 \times 10^{-3}\ \text{M s}^{-1}\) applies a factor of only 3 to the tripled \([\text{NO}_2]\), treating the reaction as first order in \(\text{NO}_2\) as its coefficient of 1 in the balanced equation might suggest. The stated law is second order in \(\text{NO}_2\), so tripling the concentration multiplies the rate by \(3^2 = 9\), not 3. (Choice B) A rate of \(7.2 \times 10^{-3}\ \text{M s}^{-1}\) handles \(\text{NO}_2\) correctly with a factor of 9 but then doubles the result for the doubled \([\text{CO}]\). Zero order in \(\text{CO}\) means its factor is \(2^0 = 1\), so no additional multiplication applies. (Choice D) A rate of \(3.6 \times 10^{-2}\ \text{M s}^{-1}\) follows the correct ninefold logic but misplaces a power of ten: \(9 \times 4.0 \times 10^{-4} = 3.6 \times 10^{-3}\), not \(3.6 \times 10^{-2}\). This is a Scientific Reasoning and Problem Solving question because you are asked to apply an experimentally determined rate law to predict the rate under new concentration conditions.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$stoichiometric-coefficient exponent (central trap)$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$right handling of one variable, spurious factor from the other$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$power-of-ten slip$q$ FROM q;

-- Q21 . Reaction Order & the Method of Initial Rates . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$In the stratosphere, nitric oxide destroys ozone through the reaction \(\text{NO} + \text{O}_3 \rightarrow \text{NO}_2 + \text{O}_2\). Initial-rate experiments establish that the reaction is first order in \(\text{NO}\) and first order in \(\text{O}_3\), with rates measured in \(\text{M s}^{-1}\). Which units must the rate constant \(k\) carry?$q$,
    $q$[{"label":"A","text":"\\(\\text{M}^{-1}\\text{s}^{-1}\\)"},{"label":"B","text":"\\(\\text{s}^{-1}\\)"},{"label":"C","text":"\\(\\text{M s}^{-1}\\)"},{"label":"D","text":"\\(\\text{M}^{2}\\text{s}^{-1}\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the experimental orders define the rate law \(\text{rate} = k[\text{NO}][\text{O}_3]\), which is second order overall, and the units of \(k\) must make both sides of that equation dimensionally consistent. Solving for the rate constant gives \(k = \frac{\text{rate}}{[\text{NO}][\text{O}_3]}\). Substituting units yields \(\frac{\text{M s}^{-1}}{(\text{M})(\text{M})} = \frac{\text{M s}^{-1}}{\text{M}^{2}} = \text{M}^{-1}\text{s}^{-1}\). This calculation illustrates the general pattern: for a reaction of overall order \(n\), the rate constant carries units of \(\text{M}^{1-n}\ \text{s}^{-1}\), so each additional power of concentration in the rate law strips one power of molarity from the units of \(k\). Because rate units are fixed at \(\text{M s}^{-1}\), the units of \(k\) are a fingerprint of the overall order. (Choice B) \(\text{s}^{-1}\) is the unit set for a reaction that is first order overall. This reaction is first order in each of two reactants, which makes it second order overall; treating first order in each reactant as if it meant first order overall drops one factor of \(\text{M}\) from the denominator of the unit calculation. (Choice C) \(\text{M s}^{-1}\) is the unit set for a zero-order rate constant, and it is also the unit of the reaction rate itself. The rate constant shares the units of the rate only in the zero-order case, where \(\text{rate} = k\); for any higher overall order, the concentration factors in the rate law force \(k\) into different units. (Choice D) \(\text{M}^{2}\text{s}^{-1}\) results from multiplying the rate units by the two concentration factors instead of dividing by them, which reverses the algebra of isolating \(k\) in \(\text{rate} = k[\text{NO}][\text{O}_3]\). This is a Scientific Reasoning and Problem Solving question because you are asked to apply dimensional analysis to an experimentally determined rate law to derive the units of the rate constant.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'adjacent_fact', $q$neighboring order's units$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$k given the rate's units$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$inverted unit algebra$q$ FROM q;

-- Q22 . Reaction Order & the Method of Initial Rates . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$For the gas-phase reaction \(2\,\text{X} + \text{Y} \rightarrow \text{products}\), a research group reports only that the experimentally measured rate constant is \(k = 5.0 \times 10^{-2}\ \text{M}^{-1}\text{s}^{-1}\), with rates expressed in \(\text{M s}^{-1}\). What overall order must the rate law have?$q$,
    $q$[{"label":"A","text":"Zero order"},{"label":"B","text":"First order"},{"label":"C","text":"Second order"},{"label":"D","text":"Third order"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the units of a rate constant encode the overall reaction order, so the reported units can be run backward to recover it. For a rate law \(\text{rate} = k[\text{X}]^{m}[\text{Y}]^{n}\), the left side carries \(\text{M s}^{-1}\), so \(k\) must carry \(\text{M}^{1-(m+n)}\ \text{s}^{-1}\). Setting \(\text{M}^{1-(m+n)}\text{s}^{-1} = \text{M}^{-1}\text{s}^{-1}\) requires \(1-(m+n) = -1\), so \(m+n = 2\): the reaction is second order overall. The forward check confirms it: any second-order rate law gives \(k = \frac{\text{M s}^{-1}}{\text{M}^{2}} = \text{M}^{-1}\text{s}^{-1}\). Note that the units fix only the sum \(m+n\); they cannot reveal how the order is distributed between \(\text{X}\) and \(\text{Y}\), which would require initial-rate experiments. (Choice A) A zero-order reaction has \(\text{rate} = k\), so its rate constant carries the rate's own units, \(\text{M s}^{-1}\). Selecting zero order misreads the reported \(\text{M}^{-1}\) as \(\text{M}^{1}\), a sign error on the molarity exponent. (Choice B) A first-order rate constant carries \(\text{s}^{-1}\), with no molarity dimension at all, because a single concentration factor exactly cancels the \(\text{M}\) in the rate units. The reported constant retains a factor of \(\text{M}^{-1}\), so one additional concentration power must be present in the rate law. (Choice D) Third order is the answer produced by summing the stoichiometric coefficients (\(2 + 1 = 3\)). Rate-law exponents are experimental quantities and cannot be read from a balanced equation; here the measurement itself rules the guess out, since a third-order reaction would require \(k\) in \(\text{M}^{-2}\text{s}^{-1}\). This is a Data-based and Statistical Reasoning question because you must interpret reported experimental data, the measured units of the rate constant, to calculate the overall order of the reaction.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'scale_unit_error', $q$exponent sign error$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$neighboring order's units$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$central trap: coefficients read as orders$q$ FROM q;

-- Q23 . Reaction Order & the Method of Initial Rates . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$Dinitrogen monoxide decomposes on a hot platinum surface with the experimentally determined rate law \(\text{rate} = k\). After three quarters of the initial \(\text{N}_2\text{O}\) has been consumed, how does the instantaneous rate compare with the rate at the start of the run?$q$,
    $q$[{"label":"A","text":"It is one quarter of the initial rate."},{"label":"B","text":"It is unchanged from the initial rate."},{"label":"C","text":"It is one sixteenth of the initial rate."},{"label":"D","text":"It has been declining smoothly toward zero as the reactant is depleted."}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because the rate law \(\text{rate} = k\) contains no concentration term at all: the reaction is zero order in \(\text{N}_2\text{O}\). Since no factor of \([\text{N}_2\text{O}]\) appears on the right side, the rate cannot respond to changes in the amount of reactant remaining. Whether the reactor holds all of its starting material or only one quarter of it, the rate stays fixed at the value of \(k\). A zero-order reaction therefore consumes its reactant at a constant rate for the entire run and stops abruptly only when the reactant is exhausted, or when the specific conditions that produce zero-order behavior in the first place no longer hold. (Choice A) A rate that falls to one quarter when one quarter of the reactant remains describes first-order behavior, where \(\text{rate} = k[\text{N}_2\text{O}]\) makes the rate directly proportional to concentration. That proportionality is exactly what the absence of a concentration term in \(\text{rate} = k\) rules out. (Choice C) One sixteenth is the remaining fraction squared, \((1/4)^2\), which is the second-order result from \(\text{rate} = k[\text{N}_2\text{O}]^2\). Squaring the remaining fraction applies the wrong rate law entirely. (Choice D) A smooth decline toward zero as reactant depletes is the signature of first-order and second-order kinetics, where the rate decays continuously with concentration. A zero-order rate does eventually reach zero, but it does so abruptly at the moment of exhaustion, holding constant until then rather than tapering. This is a Knowledge of Scientific Concepts and Principles question because you must recall that a zero-order reaction proceeds at a constant rate equal to \(k\), independent of the reactant concentration.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    60
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$first-order proportionality reflex$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$wrong-order computation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$true endpoint, wrong trajectory$q$ FROM q;

-- Q24 . Reaction Order & the Method of Initial Rates . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Reaction Order & the Method of Initial Rates$q$,
    $q$In an industrial reactor, ammonia decomposes on a heated tungsten filament by kinetics that are zero order in \(\text{NH}_3\) under the operating conditions. Which single adjustment will increase the rate at which the ammonia is consumed?$q$,
    $q$[{"label":"A","text":"Doubling the concentration of \\(\\text{NH}_3\\) in the reactor"},{"label":"B","text":"Raising the total pressure by injecting inert argon at constant volume"},{"label":"C","text":"Continuously withdrawing the \\(\\text{H}_2\\) product as it forms"},{"label":"D","text":"Operating the filament at a higher temperature"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because a zero-order reaction obeys \(\text{rate} = k\), so the only way to change the rate is to change \(k\) itself. The rate constant is independent of every concentration in the reactor, but it is not independent of temperature: raising the temperature increases \(k\), and with it the constant rate at which \(\text{NH}_3\) disappears. Temperature is therefore the lever available to the engineer, because it acts on the rate constant rather than on concentration terms that the rate law does not contain. (Choice A) Doubling \([\text{NH}_3]\) would double the rate of a first-order reaction, but the rate law here has no \([\text{NH}_3]\) term. Because the reaction is zero order in ammonia, the added reactant extends how long the constant rate persists before exhaustion, without making the rate itself any faster. (Choice B) Injecting inert argon raises total pressure but leaves \([\text{NH}_3]\) unchanged at constant volume, and even a change in reactant concentration would be irrelevant to a rate law that reads \(\text{rate} = k\). Added collisions with an unreactive gas do not enter the rate law. (Choice C) Withdrawing \(\text{H}_2\) changes the composition of the product side, but rate laws are built from the species whose concentrations the experiments show to matter, and this one contains no product term. Removing product therefore leaves the instantaneous decomposition rate exactly where it was. This is a Scientific Reasoning and Problem Solving question because you are asked to predict which experimental change can alter the rate of a zero-order reaction by acting on the rate constant itself.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    75
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$concentration reflex on a zero-order system$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$collision-theory overreach$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$product-side lever on a reactant-side law$q$ FROM q;

COMMIT;

-- Verification: expect 24 questions and 72 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'Chemical Kinetics') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'Chemical Kinetics') AS distractor_rows;
