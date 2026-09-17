-- General Chemistry Chapter 5: Chemical Kinetics, standalone questions (prompt v7)
-- BATCH 3 of 3 (24 questions): Energy Profiles, Transition States & Mechanisms (12) .
--   Catalysts (12). Six drafter slices of 4; energy profiles are TEXT-DESCRIBED per the plan,
--   no tables and no figure_svg; calculator-free arithmetic throughout.
--
-- CHAPTER COMPLETE at 72 with this file. Batch 1 owns the chapter-wide DELETE and must run
-- first. Like batch 2, this file deletes only the two subtopics it writes, so it can be re-run
-- on its own. Do not re-run batch 1 after it.
--
-- THE CATALYST SUBTOPIC IS THE TIGHTEST SEAM IN THE CHAPTER. Biochem Ch2 spends 100 questions
-- on enzymes and already keys, verbatim, everything most people would write here: bare "lowers
-- the activation energy" (Q1), transition-state stabilization (Q4), the catalyzed-versus-
-- uncatalyzed single-peak overlay (Q5/Q6), and "catalyst leaves delta-G and the equilibrium
-- position unchanged" including add-catalyst-at-equilibrium (Q3/Q7/Q25). None of that may be
-- re-keyed. The plan enumerates the five lanes that remain open, and every catalyst question
-- below sits in one of them:
--   (i)   catalyst versus intermediate in a written multistep mechanism   . Q61, Q62, Q63
--   (ii)  homogeneous versus heterogeneous, and the adsorption sequence   . Q64, Q65, Q71
--   (iii) the equal-factor k_forward / k_reverse mechanism, nonenzymatic  . Q67
--   (iv)  the quantitative effect of an Ea drop on k through the exponent . Q68
--   (v)   a catalyst appearing in an experimental rate law                . Q69
-- plus regeneration as the defining property (Q66), the quantitatively dressed
-- catalysts-do-not-confer-feasibility item (Q70), and two design-of-research items (Q71, Q72).
--
-- OTHER SEAMS, unchanged from batches 1 and 2:
--   . No enzyme key anywhere. Enzymes appear as passing scenery at most.
--   . No delta-G definition, sign or computation. Biochem Ch12 owns the qualitative
--     spontaneous-is-not-fast prize; here delta-G is stem scenery only, and the endpoint
--     reading keyed in Q51 is delta-H, which is what the AAMC outline specifies.
--   . No equilibrium constant, expression or shift direction. Reserved forward for GenChem Ch6.
--     Equilibrium appears only as the destination a catalyst reaches sooner.
--   . Rate-constant units by order stay keyed in batch 1 and are not re-keyed.
--   . Fast pre-equilibrium mechanisms are deliberately ABSENT: deriving a rate law through one
--     requires equilibrium machinery that belongs to Ch6. Every mechanism below has its slow
--     step first, or asks only about consistency with an observed rate law.
--
-- See genchem_ch5_kinetics_questions.plan.md for the Step 1 pre-flight and boundary rules, and
-- genchem_ch5_kinetics_questions_batch2.verification.md for the skill ledger this batch closes.

BEGIN;

DELETE FROM public.questions
  WHERE topic = 'Chemical Kinetics'
    AND subtopic IN ('Energy Profiles, Transition States & Mechanisms',
                     'Catalysts');

-- ── Slice 1: reading a described energy profile ─────────────────────────────

-- Q49 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$A two-step reaction has an energy profile with two maxima separated by a shallow minimum. A chemist hopes to cool the reaction mid-course, trap a species, and characterize it by spectroscopy. Which species could in principle be trapped?$q$,
    $q$[{"label":"A","text":"The species at the shallow minimum"},{"label":"B","text":"The species at the first maximum"},{"label":"C","text":"The species at the higher of the two maxima"},{"label":"D","text":"None; every species between reactants and products is untrappable"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because a minimum on the profile is an INTERMEDIATE: a real chemical species sitting in an energy well, with finite bonds and a finite lifetime. Being in a well means it resists change in either direction, which is exactly what makes trapping and characterizing it conceivable. The maxima are transition states, which sit at the top of the barrier rather than in a well; they are configurations in the act of becoming something else, they exist for roughly the duration of a bond vibration, and they cannot be isolated even in principle.

(Choice B) The first maximum is a transition state. It occupies the summit of a barrier, so any nudge in either direction sends it downhill; there is no well to hold it and nothing to cool it into.

(Choice C) Picking the higher maximum identifies the rate-determining step's transition state, which is a real and useful thing to know, but it is still a summit rather than a well and is no more isolable than the other one.

(Choice D) An intermediate is genuinely trappable, and chemists routinely detect them by cooling, by flow methods, or by spectroscopy on short timescales. Treating everything between reactants and products as ephemeral erases the distinction the profile is drawn to show.

This is a Scientific Reasoning and Problem Solving question because you must map a physical experiment onto the difference between a well and a summit on an energy profile.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$treats a transition state as isolable$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$identifies the rate-determining summit instead of the well$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$denies intermediates any real existence$q$ FROM q;

-- Q50 . Energy Profiles, Transition States & Mechanisms . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$A single-step gas-phase reaction has an energy profile in which the reactants sit at \(50\ \text{kJ mol}^{-1}\), the single maximum sits at \(170\ \text{kJ mol}^{-1}\), and the products sit at \(20\ \text{kJ mol}^{-1}\). What is the activation energy of the REVERSE reaction?$q$,
    $q$[{"label":"A","text":"\\(30\\ \\text{kJ mol}^{-1}\\)"},{"label":"B","text":"\\(120\\ \\text{kJ mol}^{-1}\\)"},{"label":"C","text":"\\(150\\ \\text{kJ mol}^{-1}\\)"},{"label":"D","text":"\\(170\\ \\text{kJ mol}^{-1}\\)"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because an activation energy is always measured from the starting side UP to the summit, and the reverse reaction starts from the products. Climbing from \(20\) to \(170\ \text{kJ mol}^{-1}\) requires \(150\ \text{kJ mol}^{-1}\). Both directions share the same summit but begin at different heights, which is why the two activation energies differ: the forward climb is \(170 - 50 = 120\ \text{kJ mol}^{-1}\) and the reverse climb is larger because the products sit lower.

(Choice A) The value \(30\ \text{kJ mol}^{-1}\) is the gap between reactants and products, \(50 - 20\), which is the enthalpy change rather than a barrier. Endpoint separation says nothing about how high the summit stands above either one.

(Choice B) \(120\ \text{kJ mol}^{-1}\) is the FORWARD activation energy, the climb from reactants to the summit. The question asks for the reverse direction, which starts from the other side.

(Choice D) \(170\ \text{kJ mol}^{-1}\) is the absolute height of the transition state on this axis, not a climb. An activation energy is always a difference between two levels, never a single level read off directly.

This is a Data-based and Statistical Reasoning question because you must read three levels off a described profile and take the correct difference for the direction asked.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$reports the endpoint difference as a barrier$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$gives the forward barrier for the reverse direction$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$reads an absolute level instead of a difference$q$ FROM q;

-- Q51 . Energy Profiles, Transition States & Mechanisms . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$For a single-step reaction, the forward activation energy is \(150\ \text{kJ mol}^{-1}\) and the reverse activation energy is \(80\ \text{kJ mol}^{-1}\). What is \(\Delta H\) for the forward reaction?$q$,
    $q$[{"label":"A","text":"\\(+70\\ \\text{kJ mol}^{-1}\\)"},{"label":"B","text":"\\(-70\\ \\text{kJ mol}^{-1}\\)"},{"label":"C","text":"\\(+230\\ \\text{kJ mol}^{-1}\\)"},{"label":"D","text":"\\(+115\\ \\text{kJ mol}^{-1}\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because both directions climb to the same summit, so the difference between the two barriers is exactly the difference between the two endpoints: \(\Delta H = E_{a,\text{forward}} - E_{a,\text{reverse}} = 150 - 80 = +70\ \text{kJ mol}^{-1}\). A forward climb that is the longer of the two means the products sit ABOVE the reactants, so the reaction absorbs heat and \(\Delta H\) is positive. The summit's own height never enters the calculation, which is why it need not be supplied.

(Choice B) A negative sign reverses the subtraction and describes a reaction giving out heat. That would require the reverse barrier to be the larger of the two, which is the opposite of what the stem reports.

(Choice C) Adding the two barriers has no physical meaning. The forward and reverse paths share one summit rather than climbing two separate ones, so their heights are not additive.

(Choice D) Averaging the two barriers produces a number that corresponds to nothing on the profile. \(\Delta H\) is the separation of the endpoints, which the difference captures and the mean does not.

This is a Data-based and Statistical Reasoning question because you must convert two measured barriers into an endpoint separation and assign its sign correctly.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$subtracts in the wrong order$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$adds the two barriers$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$averages the two barriers$q$ FROM q;

-- Q52 . Energy Profiles, Transition States & Mechanisms . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$An energy profile rises from reactants at \(30\ \text{kJ mol}^{-1}\) to a maximum at \(150\), falls to a minimum at \(90\), rises again to a maximum at \(130\), and settles at products at \(60\ \text{kJ mol}^{-1}\). How many intermediates and transition states does this mechanism have?$q$,
    $q$[{"label":"A","text":"2 intermediates and 1 transition state"},{"label":"B","text":"1 intermediate and 2 transition states"},{"label":"C","text":"2 intermediates and 2 transition states"},{"label":"D","text":"1 intermediate and 1 transition state"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because each maximum on a profile is a transition state and each minimum BETWEEN the endpoints is an intermediate. This profile has two maxima, at \(150\) and \(130\ \text{kJ mol}^{-1}\), and one interior minimum at \(90\ \text{kJ mol}^{-1}\), giving two transition states and one intermediate. The count also tells you the number of elementary steps: two barriers means two steps, and a mechanism of n steps always has n transition states and n minus one intermediates.

(Choice A) This reverses the two counts. Peaks outnumber interior valleys in any mechanism, so intermediates can never exceed transition states.

(Choice C) Counting two intermediates would require two interior minima. The reactant and product levels are endpoints of the whole profile, not intermediates, because they are the species the overall equation begins and ends with.

(Choice D) Counting one transition state ignores the second barrier. The profile clearly rises twice, and each rise is a separate elementary step with its own summit.

This is a Data-based and Statistical Reasoning question because you must translate the shape of a described profile into counts of two different kinds of species.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    80
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', $q$swaps the two counts$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$counts an endpoint as an intermediate$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$misses the second barrier$q$ FROM q;

-- ── Slice 2: which step sets the pace, and what it predicts ─────────────────

-- Q53 . Energy Profiles, Transition States & Mechanisms . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$A two-step mechanism has a profile running from reactants at \(40\ \text{kJ mol}^{-1}\) up to \(120\), down to an intermediate at \(80\), up to \(180\), and finally down to products at \(50\ \text{kJ mol}^{-1}\). Which step is rate-determining, and what is its barrier?$q$,
    $q$[{"label":"A","text":"The first step; \\(80\\ \\text{kJ mol}^{-1}\\)"},{"label":"B","text":"The first step; \\(120\\ \\text{kJ mol}^{-1}\\)"},{"label":"C","text":"The second step; \\(180\\ \\text{kJ mol}^{-1}\\)"},{"label":"D","text":"The second step; \\(100\\ \\text{kJ mol}^{-1}\\)"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because each step's barrier is measured from its own starting level, and the slower step is the one with the larger climb. Step one climbs from \(40\) to \(120\), a barrier of \(80\ \text{kJ mol}^{-1}\). Step two climbs from the intermediate at \(80\) to \(180\), a barrier of \(100\ \text{kJ mol}^{-1}\). The second step demands more and therefore sets the pace of the whole reaction, in the same way that the narrowest point of a road determines how fast traffic gets through.

(Choice A) The barrier \(80\ \text{kJ mol}^{-1}\) is correctly computed, but it belongs to the FIRST step, which is the easier of the two. The easier step cannot be the bottleneck.

(Choice B) The value \(120\) is the absolute height of the first summit, not a climb. Subtracting the level the step starts from is what converts a summit into a barrier.

(Choice C) Likewise \(180\) is the absolute height of the second summit. The step is correctly identified, but a barrier is always a difference, here \(180 - 80\).

This is a Data-based and Statistical Reasoning question because you must convert described levels into two separate barriers and compare them, rather than compare summit heights directly.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$right arithmetic, wrong step$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', $q$reads a summit height as a barrier$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$right step, summit height instead of barrier$q$ FROM q;

-- Q54 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$A reaction proceeds by the mechanism below, with the first step slow and the second fast. Step 1: \(\text{NO}_2 + \text{F}_2 \rightarrow \text{NO}_2\text{F} + \text{F}\). Step 2: \(\text{NO}_2 + \text{F} \rightarrow \text{NO}_2\text{F}\). What rate law does this mechanism predict?$q$,
    $q$[{"label":"A","text":"rate \\(= k[\\text{NO}_2]\\)"},{"label":"B","text":"rate \\(= k[\\text{NO}_2][\\text{F}_2]\\)"},{"label":"C","text":"rate \\(= k[\\text{NO}_2]^2[\\text{F}_2]\\)"},{"label":"D","text":"rate \\(= k[\\text{NO}_2][\\text{F}_2]^2\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because the whole reaction can proceed no faster than its slowest step, so the rate law comes from that step alone. Step 1 is an elementary process, and for an elementary step, and only for an elementary step, the coefficients ARE the exponents: one \(\text{NO}_2\) and one \(\text{F}_2\) collide, giving rate \(= k[\text{NO}_2][\text{F}_2]\). The fast second step consumes the fluorine atom as soon as it appears and so cannot limit anything.

(Choice A) Dropping \(\text{F}_2\) leaves out one of the two species that must meet in the slow step. Both partners in a bimolecular elementary step appear in its rate law.

(Choice C) The exponent 2 on \(\text{NO}_2\) comes from the OVERALL equation, \(2\text{NO}_2 + \text{F}_2 \rightarrow 2\text{NO}_2\text{F}\), obtained by adding the steps. Overall coefficients never set rate-law exponents; that is exactly the shortcut a mechanism question is built to punish.

(Choice D) Squaring \(\text{F}_2\) has no basis in either the slow step or the overall equation. Only one \(\text{F}_2\) is consumed in the entire reaction.

This is a Scientific Reasoning and Problem Solving question because you must select the correct step and apply molecularity to it rather than read coefficients off the overall equation.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$keeps one partner of the slow step and drops the other$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$reads exponents off the overall equation$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$invents an exponent with no source$q$ FROM q;

-- Q55 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$Proposed mechanisms rarely contain a termolecular elementary step. Why?$q$,
    $q$[{"label":"A","text":"Such a step would violate conservation of energy"},{"label":"B","text":"Rate laws cannot carry an overall order above two"},{"label":"C","text":"Three particles must meet at one instant with workable geometry, which is improbable"},{"label":"D","text":"Termolecular steps have no activation energy, so they cannot be rate-determining"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because molecularity counts the particles that must collide simultaneously in a single elementary event. Two-body encounters are common; three bodies arriving at the same place, at the same instant, and all correctly oriented is a far rarer coincidence. Chemists therefore prefer mechanisms built from unimolecular and bimolecular steps, reaching an overall third-order rate law through a SEQUENCE of such steps rather than through one three-body collision.

(Choice A) Nothing about a three-body collision offends conservation of energy. It is improbable, not impossible, and termolecular steps do occasionally appear in accepted mechanisms.

(Choice B) Overall reaction orders of three are perfectly ordinary and are measured experimentally. The rarity is in the elementary step, not in the order the experiment reports.

(Choice D) Every elementary step has an activation energy, termolecular ones included. Having no barrier would make a step fast, which is the opposite of a reason to exclude it from mechanisms.

This is a Scientific Reasoning and Problem Solving question because you must reason from collision probability to the shape mechanisms are allowed to take.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$upgrades improbable to impossible$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$confuses elementary molecularity with measured order$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$grants a step zero activation energy$q$ FROM q;

-- Q56 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$Experiment establishes that a reaction obeys rate \(= k[\text{A}]\). A student proposes a mechanism whose slow FIRST step is \(\text{A} + \text{B} \rightarrow \text{C}\), followed by fast steps. Is the proposal acceptable?$q$,
    $q$[{"label":"A","text":"Yes, because A appears in both the mechanism and the rate law"},{"label":"B","text":"Yes, provided the steps add up to the balanced overall equation"},{"label":"C","text":"No, because an acceptable mechanism must contain at least two slow steps"},{"label":"D","text":"No, because that slow step predicts a rate law containing \\([\\text{B}]\\)"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because a mechanism has to reproduce the measured rate law, and this one does not. A slow bimolecular step consuming one A and one B predicts rate \(= k[\text{A}][\text{B}]\), so the rate would fall when B was diluted. The experiment says otherwise: only A appears. A mechanism is a hypothesis, and a rate law it cannot reproduce is the one piece of evidence that refutes it outright.

(Choice A) Appearing somewhere in the rate law is not the test. The mechanism must predict the rate law EXACTLY, including which species are absent from it, and this one adds a dependence that experiment rules out.

(Choice B) Adding up to the correct overall equation is necessary but nowhere near sufficient. Many mechanisms balance correctly and still predict the wrong kinetics; balancing is the first screen, not the last.

(Choice C) Nothing requires two slow steps, and a mechanism with two comparably slow steps is harder to analyze rather than more acceptable. One clearly slowest step is the ordinary and convenient case.

This is a Scientific Reasoning and Problem Solving question because you must test a proposed mechanism against experimental evidence rather than against its own internal tidiness.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$accepts partial agreement with the rate law$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$treats balancing as sufficient$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$invents a two-slow-step requirement$q$ FROM q;

-- ── Slice 3: barrier versus endpoint, and testing a mechanism ───────────────

-- Q57 . Energy Profiles, Transition States & Mechanisms . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$Two uncatalyzed gas-phase reactions run at the same temperature with comparable frequency factors. Reaction P releases \(120\ \text{kJ mol}^{-1}\) and has \(E_a = 140\ \text{kJ mol}^{-1}\). Reaction Q releases \(15\ \text{kJ mol}^{-1}\) and has \(E_a = 45\ \text{kJ mol}^{-1}\). Which proceeds faster?$q$,
    $q$[{"label":"A","text":"Q, because its barrier is far lower"},{"label":"B","text":"P, because it releases much more energy"},{"label":"C","text":"Neither can be ranked without the frequency factors"},{"label":"D","text":"They proceed at the same rate, since both release energy"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because rate is governed by the barrier a reaction must climb, not by how far downhill it eventually falls. Reaction Q faces \(45\ \text{kJ mol}^{-1}\) while reaction P faces \(140\), and since the barrier sits in the exponent of \(k = Ae^{-E_a/RT}\), that difference is enormous at a shared temperature. The energy released describes the endpoints and belongs to a different question entirely: how far the reaction goes, not how quickly it gets there.

(Choice B) Releasing more energy makes reaction P the more downhill of the two, and downhill says nothing about the climb. A reaction can be strongly favorable and still crawl, which is why diamond does not turn into graphite on your desk.

(Choice C) The stem states the frequency factors are comparable, which is exactly the condition under which the exponential decides the comparison. Withholding a ranking here declines to use the information given.

(Choice D) Both releasing energy tells you both are downhill; it does not make their barriers equal. Rates here differ by many orders of magnitude.

This is a Scientific Reasoning and Problem Solving question because you must separate a thermodynamic quantity used as scenery from the kinetic quantity that actually sets the rate.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$ranks rate by energy released$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$declines a ranking the stem has enabled$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$equates being downhill with being equally fast$q$ FROM q;

-- Q58 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$A student sketches an energy profile for a one-step reaction and places the transition state BELOW the level of the reactants. What is wrong with the sketch?$q$,
    $q$[{"label":"A","text":"Nothing is wrong; this is how an exothermic reaction is drawn"},{"label":"B","text":"A point below the reactants is not a maximum, so the sketch shows no barrier at all"},{"label":"C","text":"The reaction would then have to be endothermic"},{"label":"D","text":"The transition state would survive longer than a bond vibration"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because a transition state is DEFINED as the maximum along the reaction path, and a point lower than where you started cannot be a maximum on the way there. Drawn as sketched, the path runs downhill from the outset, so there is no barrier to climb and no activation energy to speak of. The transition state must sit above both the reactants and the products, whatever the overall energy change happens to be.

(Choice A) Exothermic means the PRODUCTS end up below the reactants. The summit between them still rises above both; lowering the summit itself is a different claim and a wrong one.

(Choice C) The direction of the overall energy change is a separate matter from where the summit sits. Endothermic and exothermic reactions alike have a transition state above both endpoints.

(Choice D) Lifetime is not what the sketch gets wrong. A transition state is fleeting because it sits on a summit with nothing to hold it, which is precisely the geometry the sketch has abandoned.

This is a Scientific Reasoning and Problem Solving question because you must apply the definition of a transition state to a drawing rather than to a sentence.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$confuses a low summit with a low product level$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$answers about the endpoints instead of the summit$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$raises lifetime rather than geometry$q$ FROM q;

-- Q59 . Energy Profiles, Transition States & Mechanisms . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$For an elementary reaction whose products lie below its reactants, how do the forward and reverse activation energies compare?$q$,
    $q$[{"label":"A","text":"They are equal, since both directions pass through the same transition state"},{"label":"B","text":"The forward barrier is the larger of the two"},{"label":"C","text":"The reverse barrier is the larger of the two"},{"label":"D","text":"They cannot be compared without the height of the transition state"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because both directions climb to the SAME summit but start from different levels, and the products start lower. A longer climb from below means the reverse barrier exceeds the forward one. The relationship \(\Delta H = E_{a,\text{forward}} - E_{a,\text{reverse}}\) says the same thing arithmetically: products below reactants make \(\Delta H\) negative, which requires the reverse barrier to be the bigger number.

(Choice A) Sharing a transition state is true and is exactly why the barriers differ. A shared summit measured from two different floors gives two different climbs.

(Choice B) A larger forward barrier would place the products ABOVE the reactants, describing a reaction that absorbs energy. The stem specifies the opposite arrangement.

(Choice D) The summit height is not needed. Whatever its absolute value, it is common to both directions and cancels out of the comparison; only the relative position of the two endpoints matters.

This is a Scientific Reasoning and Problem Solving question because you must reason from a shared summit and two different starting levels to a comparison of barriers.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$true premise, wrong conclusion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$puts the products above the reactants$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$asks for a quantity that cancels$q$ FROM q;

-- Q60 . Energy Profiles, Transition States & Mechanisms . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Energy Profiles, Transition States & Mechanisms$q$,
    $q$Two mechanisms are proposed for the same overall reaction. Mechanism I has a slow step consuming one A and one B. Mechanism II has a slow step consuming two A and no B. Both add up to the same balanced equation. Which experiment best distinguishes them?$q$,
    $q$[{"label":"A","text":"Measure the overall enthalpy change of the reaction"},{"label":"B","text":"Confirm that both mechanisms sum to the balanced overall equation"},{"label":"C","text":"Measure the rate at two temperatures and extract the activation energy"},{"label":"D","text":"Vary \\([\\text{B}]\\) with \\([\\text{A}]\\) held constant and watch the initial rate"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the two mechanisms disagree about exactly one observable thing: whether B appears in the rate law. Mechanism I predicts the rate rises with \([\text{B}]\); mechanism II predicts changing \([\text{B}]\) does nothing. Holding \([\text{A}]\) fixed isolates that single variable, so the result points at one hypothesis and away from the other. A good discriminating experiment is built on the point where two hypotheses make different predictions, and this is the only such point available.

(Choice A) Enthalpy is a property of the reactants and products alone, so both mechanisms predict the identical value. A measurement that comes out the same either way cannot discriminate.

(Choice B) The stem already grants that both mechanisms balance. Re-checking a shared property tests nothing, and balancing was never the disputed claim.

(Choice C) An activation energy characterizes the barrier of whichever step is slowest, but it does not reveal WHICH SPECIES that step consumes. Both mechanisms are free to have similar barriers, so the measurement is compatible with either.

This is a Reasoning about the Design and Execution of Research question because you must locate the single observable on which two hypotheses diverge and design the manipulation that isolates it.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$measures a quantity both hypotheses share$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$re-tests an undisputed property$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$characterizes the barrier but not the step's composition$q$ FROM q;

-- ── Slice 4: telling a catalyst from an intermediate ────────────────────────

-- Q61 . Catalysts . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$Sulfur dioxide is oxidized industrially by the two-step sequence below. Step 1: \(\text{NO}_2 + \text{SO}_2 \rightarrow \text{NO} + \text{SO}_3\). Step 2: \(2\text{NO} + \text{O}_2 \rightarrow 2\text{NO}_2\). Which species acts as the catalyst?$q$,
    $q$[{"label":"A","text":"\\(\\text{NO}_2\\)"},{"label":"B","text":"\\(\\text{NO}\\)"},{"label":"C","text":"\\(\\text{SO}_3\\)"},{"label":"D","text":"\\(\\text{O}_2\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because a catalyst is consumed EARLY and handed back LATER, so it enters as a reactant and leaves as a product across the sequence. \(\text{NO}_2\) is used up in step 1 and remade in step 2, so the sequence returns as much as it borrowed and \(\text{NO}_2\) never appears in the overall equation, \(2\text{SO}_2 + \text{O}_2 \rightarrow 2\text{SO}_3\). Reading the order is the whole trick: consumed then regenerated is a catalyst, produced then consumed is an intermediate.

(Choice B) \(\text{NO}\) runs the other way round. It is produced in step 1 and consumed in step 2, which makes it an intermediate: something the mechanism creates for its own use and then spends.

(Choice C) \(\text{SO}_3\) is produced and never consumed, which makes it a product of the overall reaction. Products survive to the end rather than cycling.

(Choice D) \(\text{O}_2\) is consumed and never regenerated, which makes it a reactant. It appears on the left of the overall equation for exactly that reason.

This is a Scientific Reasoning and Problem Solving question because you must track a species across steps and classify it by the ORDER in which it is used and returned.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', $q$intermediate mistaken for catalyst$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$names an overall product$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$names an overall reactant$q$ FROM q;

-- Q62 . Catalysts . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$Chloroform is chlorinated by the mechanism below. Step 1: \(\text{Cl}_2 \rightarrow 2\text{Cl}\). Step 2: \(\text{Cl} + \text{CHCl}_3 \rightarrow \text{HCl} + \text{CCl}_3\). Step 3: \(\text{CCl}_3 + \text{Cl} \rightarrow \text{CCl}_4\). Which species is an intermediate?$q$,
    $q$[{"label":"A","text":"\\(\\text{Cl}_2\\)"},{"label":"B","text":"\\(\\text{CCl}_3\\)"},{"label":"C","text":"\\(\\text{CHCl}_3\\)"},{"label":"D","text":"\\(\\text{CCl}_4\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because an intermediate is MADE by one step and USED by a later one, so it never survives to the overall equation. \(\text{CCl}_3\) is produced in step 2 and consumed in step 3, which is precisely that pattern. Adding the three steps gives \(\text{Cl}_2 + \text{CHCl}_3 \rightarrow \text{HCl} + \text{CCl}_4\), in which neither \(\text{CCl}_3\) nor the chlorine atoms appear.

(Choice A) \(\text{Cl}_2\) is consumed in step 1 and never handed back, so it is a reactant of the overall reaction. Appearing only on the left is the definition of a reactant.

(Choice C) \(\text{CHCl}_3\) is consumed in step 2 and never regenerated, making it the other overall reactant. It is the starting material the whole sequence exists to convert.

(Choice D) \(\text{CCl}_4\) is produced in step 3 and never consumed, which makes it the product. A product is what the mechanism leaves behind, not something it spends.

This is a Scientific Reasoning and Problem Solving question because you must follow a species through three steps and decide whether the mechanism creates it, spends it, or both.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$names an overall reactant$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$names the other overall reactant$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$names the overall product$q$ FROM q;

-- Q63 . Catalysts . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$In a proposed mechanism, a species appears as a reactant in the first step and as a product in the last, in equal amounts. Why is it absent from the overall balanced equation?$q$,
    $q$[{"label":"A","text":"It is present in too small a quantity to be written"},{"label":"B","text":"It is an intermediate, and intermediates are never written in overall equations"},{"label":"C","text":"It is consumed and regenerated in equal amounts, so it cancels when the steps are added"},{"label":"D","text":"Overall equations list only species whose concentrations change measurably"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because building the overall equation means adding the steps and striking anything that appears identically on both sides. A species borrowed at the start and returned at the end shows up once on the left and once on the right in the same amount, so it cancels exactly. Its absence from the overall equation is the arithmetic consequence of being returned unchanged, which is also what makes it a catalyst rather than a reagent.

(Choice A) Quantity is not the criterion. A catalyst would cancel out of the overall equation even if it were present in enormous excess, because what matters is that it is returned, not how much of it there is.

(Choice B) An intermediate is produced FIRST and consumed later, the reverse of the order described. Both intermediates and catalysts cancel, but calling this species an intermediate misreads which way round it appears.

(Choice D) Concentrations of catalysts are measurable and often matter a great deal to the rate. Overall equations report net chemical change, and this species undergoes none.

This is a Scientific Reasoning and Problem Solving question because you must explain a bookkeeping outcome by the chemistry that produces it rather than by a rule of notation.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$makes quantity the criterion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$reverses catalyst and intermediate$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$invents a measurability rule$q$ FROM q;

-- Q64 . Catalysts . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$Sulfuric acid dissolved in an aqueous reaction mixture accelerates one reaction. Powdered platinum suspended in a stream of gases accelerates another. How are these two catalysts classified?$q$,
    $q$[{"label":"A","text":"Both are homogeneous"},{"label":"B","text":"Both are heterogeneous"},{"label":"C","text":"The acid is heterogeneous; the platinum is homogeneous"},{"label":"D","text":"The acid is homogeneous; the platinum is heterogeneous"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the classification turns on one question: is the catalyst in the same phase as the reactants? Sulfuric acid dissolved in the same solution as its reactants is one liquid phase throughout, which is homogeneous. Solid platinum meeting gaseous reactants is two phases, so the chemistry happens at an interface, which is heterogeneous. The distinction is practical rather than cosmetic: a heterogeneous catalyst can be filtered out and reused, and its rate depends on available surface area.

(Choice A) Calling the platinum homogeneous ignores that a solid and a gas cannot be one phase. The reactants never dissolve into the metal; they meet it at its surface.

(Choice B) Dissolved sulfuric acid is not a separate phase. Once in solution it is mixed at the molecular level with what it is catalyzing.

(Choice C) This inverts both cases. Nothing about being an acid makes a catalyst heterogeneous, and nothing about being a metal makes it homogeneous; only the phase relationship decides.

This is a Knowledge of Scientific Concepts and Principles question because you must recall that the homogeneous and heterogeneous labels describe phase relationships rather than chemical identity.$q$,
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
  SELECT q.id, 'A', 'partial_truth', $q$correct for the acid, wrong for the metal$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', $q$correct for the metal, wrong for the acid$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$inverts both classifications$q$ FROM q;

-- ── Slice 5: surfaces, both directions, and what a lower barrier buys ───────

-- Q65 . Catalysts . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$A reaction is run over a solid metal catalyst. A trace impurity in the feed gas binds irreversibly to the metal, and the rate collapses. Which part of the catalytic sequence has been blocked?$q$,
    $q$[{"label":"A","text":"Adsorption of the reactants onto the surface"},{"label":"B","text":"Desorption of the products from the surface"},{"label":"C","text":"Diffusion of the products away through the gas"},{"label":"D","text":"The collision frequency of reactant molecules in the gas phase"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because heterogeneous catalysis runs in a fixed order: reactants adsorb onto the surface, react while held there, and then desorb as products. An impurity bound irreversibly occupies the very sites reactants need, so the sequence cannot start. This is what catalyst poisoning means, and it is also why heterogeneous catalysts are rated by the surface area they make available rather than by their mass.

(Choice B) Blocked desorption would leave products stuck to a surface that is otherwise working, and the tell would be a catalyst progressively covered in product. The impurity described binds first, before any chemistry happens.

(Choice C) Diffusion through the gas is a transport step that happens away from the metal entirely. An impurity stuck to the surface cannot reach out and impede it.

(Choice D) Gas-phase collision frequency is set by concentration and temperature. It is unchanged by what is or is not bound to a solid surface, and in any case the catalyzed route does not depend on reactants colliding with each other in the gas.

This is a Scientific Reasoning and Problem Solving question because you must locate a described interference within the ordered sequence a surface catalyst follows.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'process_step_confusion', $q$blocks the last step instead of the first$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$names a transport step away from the surface$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$names a gas-phase property the surface cannot touch$q$ FROM q;

-- Q66 . Catalysts . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$What distinguishes a catalyst from a reagent that speeds a reaction up by being used in it?$q$,
    $q$[{"label":"A","text":"A catalyst must be a solid"},{"label":"B","text":"A catalyst is returned unchanged and can act again"},{"label":"C","text":"A catalyst is required in larger amounts than a reagent"},{"label":"D","text":"A catalyst appears in the overall balanced equation"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because regeneration is the defining property. A catalyst enters the mechanism, does its work, and is handed back in its original form, so one molecule of it can turn over many molecules of substrate before anything wears out. A reagent that accelerates a reaction by being consumed is spent once and must be replaced in proportion to how much reaction you want.

(Choice A) Catalysts come in every phase. Dissolved acids, gaseous nitrogen oxides and solid metals all catalyze reactions, and the solid case is simply the most familiar one.

(Choice C) The opposite is closer to the truth. Because a catalyst is reused, it is typically present in far smaller amounts than the substrate it processes, which is one of the reasons catalysis is economically attractive.

(Choice D) A catalyst is consumed and regenerated in equal amounts, so it cancels out when the steps are added and does NOT appear in the overall equation. That absence is a consequence of being returned unchanged.

This is a Knowledge of Scientific Concepts and Principles question because you must recall the property that defines catalysis rather than a feature that merely often accompanies it.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$restricts catalysis to solids$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$reverses the usual amount required$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$puts the catalyst in the overall equation$q$ FROM q;

-- Q67 . Catalysts . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$In an industrial gas-phase process, introducing a solid catalyst multiplies the forward rate constant by \(10^{4}\). What happens to the rate constant of the reverse reaction?$q$,
    $q$[{"label":"A","text":"It is unchanged"},{"label":"B","text":"It is divided by \\(10^{4}\\)"},{"label":"C","text":"It falls to zero while the forward reaction is running"},{"label":"D","text":"It is multiplied by \\(10^{4}\\), because both directions cross the same lowered summit"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the forward and reverse reactions travel the same path over the same summit, in opposite directions. Lowering that summit shortens BOTH climbs by the same number of kilojoules, and since each rate constant carries that barrier in the exponent of \(e^{-E_a/RT}\), each is multiplied by the same factor. The practical consequence is that the mixture arrives at its destination sooner: the catalyst changes how quickly the journey is made, not where it ends.

(Choice A) Leaving the reverse constant alone would mean the catalyst offers a new low route in one direction and not the other. A path is open in both directions by construction, and a molecule at the product end finds the same lowered summit waiting.

(Choice B) Dividing the reverse constant would describe something that speeds one direction by hindering the other. Lowering a barrier cannot raise the climb from the far side, since both climbs are measured to the same point.

(Choice C) A rate constant does not switch off. Reverse events keep happening throughout, and are simply outnumbered by forward ones while reactant is plentiful.

This is a Scientific Reasoning and Problem Solving question because you must reason from a shared transition state to the effect a lowered barrier has on both directions at once.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$opens the low route in one direction only$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$speeds one direction by hindering the other$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$switches a rate constant off$q$ FROM q;

-- Q68 . Catalysts . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$At \(300\ \text{K}\), where \(RT = 2.5\ \text{kJ mol}^{-1}\), a catalyst lowers the activation energy of a gas-phase reaction by \(5.0\ \text{kJ mol}^{-1}\). The frequency factor is unchanged. By approximately what factor does the rate constant increase?$q$,
    $q$[{"label":"A","text":"About 2"},{"label":"B","text":"About 5"},{"label":"C","text":"About 7"},{"label":"D","text":"About 20"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the two rate constants differ only through their exponentials, so their ratio is \(\frac{k_{\text{cat}}}{k_{\text{uncat}}} = e^{\Delta E_a / RT}\). Here \(\frac{5.0}{2.5} = 2\), so the ratio is \(e^{2} \approx 7.4\). The frequency factor cancels because the stem holds it fixed. Note how steep the exponential is: a barrier reduction of only \(5\ \text{kJ mol}^{-1}\), small beside a typical barrier, already multiplies the rate constant sevenfold.

(Choice A) The value 2 is the EXPONENT, \(\frac{\Delta E_a}{RT}\), and stopping there omits the exponentiation. The energies enter the rate constant through a power of \(e\), never as a plain ratio.

(Choice B) Reading the factor straight off the \(5.0\ \text{kJ mol}^{-1}\) drop treats an energy as though it were a multiplier. The two have different units and different roles.

(Choice D) About 20 is \(e^{3}\), which would follow from an \(RT\) near \(1.7\ \text{kJ mol}^{-1}\) rather than the \(2.5\) the stem supplies. Using the given \(RT\) is what keeps the exponent at 2.

This is a Data-based and Statistical Reasoning question because you must form a ratio of two Arrhenius expressions from supplied numbers and carry the calculation through the exponential.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$stops at the exponent$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', $q$reads an energy as a multiplier$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$uses the wrong RT$q$ FROM q;

-- ── Slice 6: the rate law's tell, surface area, and two designed tests ──────

-- Q69 . Catalysts . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$Hydrogen peroxide decomposes by \(2\text{H}_2\text{O}_2 \rightarrow 2\text{H}_2\text{O} + \text{O}_2\). With iodide present, the experimentally determined rate law is rate \(= k[\text{H}_2\text{O}_2][\text{I}^-]\), yet iodide appears nowhere in that overall equation. What does this indicate?$q$,
    $q$[{"label":"A","text":"Iodide takes part in the rate-determining step and is regenerated later"},{"label":"B","text":"The rate law must be in error, since only species in the overall equation may appear"},{"label":"C","text":"Iodide is an intermediate generated during the decomposition"},{"label":"D","text":"Iodide alters the stoichiometry of the overall reaction"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because a species earns its place in a rate law by participating at or before the slowest step, not by surviving into the overall equation. Iodide is consumed in the slow step and handed back by a later fast one, so the rate depends on how much of it is present while the net equation records no change in it. A catalyst appearing in the experimental rate law is common and is one of the clearest signatures that a species is doing mechanistic work.

(Choice B) Rate laws are measured, not derived from the balanced equation, and this is exactly the case that shows why. A species absent from the overall equation can still control the rate, and no rule of stoichiometry forbids it.

(Choice C) An intermediate is PRODUCED first and consumed later, so its concentration is set by the mechanism rather than by the chemist. Iodide is added deliberately at a known concentration and recovered at the end, which is the opposite pattern.

(Choice D) The stoichiometry is fixed by the overall equation and is the same with or without iodide: two peroxide molecules still give two waters and one oxygen. What iodide changes is the route and the speed.

This is a Data-based and Statistical Reasoning question because you must interpret an experimentally measured rate law against a balanced equation that disagrees with it.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$derives the rate law from the balanced equation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', $q$catalyst mistaken for intermediate$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$lets a catalyst change stoichiometry$q$ FROM q;

-- Q70 . Catalysts . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$A solid catalyst supplied as coarse pellets is reground into a fine powder. The same total mass is loaded into the same reactor under the same conditions. What happens to the rate, and why?$q$,
    $q$[{"label":"A","text":"It is unchanged, because the mass of catalyst is the same"},{"label":"B","text":"It rises, because more catalytic surface is exposed"},{"label":"C","text":"It falls, because each particle now carries less mass"},{"label":"D","text":"It rises, because grinding lowers the activation energy further"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because a heterogeneous catalyst works only where reactants can touch it, so the rate scales with exposed surface rather than with bulk. Grinding the same mass into smaller particles multiplies the total surface area enormously, and metal buried inside a pellet, which no reactant could reach, is brought to the outside. Nothing about the chemistry has changed; there is simply more of the catalyst actually available to do it.

(Choice A) Equal mass would settle the question for a homogeneous catalyst dissolved among its reactants, where every molecule is accessible. On a solid, most of the mass sits in the interior and contributes nothing until it is exposed.

(Choice C) Particle mass is not what limits a surface reaction. Many small particles have the same total mass as a few large ones and a far larger combined surface.

(Choice D) The barrier is a property of the catalyzed pathway and is the same on a powder as on a pellet. More sites means more places where that same barrier is being crossed, not a lower one.

This is a Scientific Reasoning and Problem Solving question because you must attribute a rate change to available surface rather than to mass or to the barrier.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$treats bulk mass as the active quantity$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$makes particle mass the limiting factor$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right direction, wrong cause$q$ FROM q;

-- Q71 . Catalysts . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$A newly prepared additive accelerates a reaction in solution, and a chemist wants to establish whether it acts as a heterogeneous catalyst. Which observation would settle it?$q$,
    $q$[{"label":"A","text":"Adding more of the additive makes the reaction faster"},{"label":"B","text":"The additive can be recovered unchanged once the reaction is over"},{"label":"C","text":"Filtering the mixture removes a suspended solid, and the filtrate loses its catalytic activity"},{"label":"D","text":"The reaction reaches the same final composition with or without the additive"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the question at issue is one of PHASE, and filtration is the manipulation that separates phases. If the activity leaves with a solid caught on the filter, the catalysis was happening on that solid's surface and the catalyst is heterogeneous. If the filtrate stayed active, the catalyst would be dissolved among its reactants and therefore homogeneous. A discriminating experiment has to act on the property in dispute, and this one does.

(Choice A) More catalyst giving more rate is true of homogeneous and heterogeneous catalysts alike, since both provide more of whatever is doing the work. An observation shared by both hypotheses separates neither.

(Choice B) Recovery unchanged establishes that the additive is a catalyst rather than a reagent, which is a different question and one the stem has already granted. Homogeneous catalysts are recoverable too.

(Choice D) Reaching the same destination with or without the additive is expected of any catalyst. It speaks to what catalysis does not change, and says nothing about which phase the catalyst occupies.

This is a Reasoning about the Design and Execution of Research question because you must choose the manipulation that acts on the disputed property rather than one that confirms something already agreed.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$observation shared by both hypotheses$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$answers a different question$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$true of catalysis generally$q$ FROM q;

-- Q72 . Catalysts . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Catalysts$q$,
    $q$A species X makes a reaction go faster. Which result would best demonstrate that X is a true catalyst rather than a reagent that is consumed while doing the job?$q$,
    $q$[{"label":"A","text":"The reaction runs faster whenever X is present"},{"label":"B","text":"X appears in the experimentally determined rate law"},{"label":"C","text":"Removing X stops the reaction entirely"},{"label":"D","text":"A small amount of X converts far more substrate than itself, and X remains at the end"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because it is the only result a consumed reagent could not produce. Turnover, one small portion of X processing many times its own amount of substrate, requires that X be handed back after each cycle; a reagent used up in the reaction would run out in strict proportion and stop. Finding X still present at the end closes the argument by confirming the regeneration directly rather than inferring it.

(Choice A) Going faster in the presence of X is exactly what a consumed accelerant does too. The observation is the reason for the investigation, not its resolution.

(Choice B) A species is in the rate law when it participates at or before the slow step, and a consumed reagent participating there would appear in it as well. Rate-law membership shows involvement, not recovery.

(Choice C) A reagent consumed by the reaction would also bring it to a halt once absent. Necessity does not distinguish something reused from something spent.

This is a Reasoning about the Design and Execution of Research question because you must select the result that only one of two competing explanations can produce.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    3,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$restates the premise$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$shows involvement, not recovery$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$necessity does not imply reuse$q$ FROM q;

COMMIT;
