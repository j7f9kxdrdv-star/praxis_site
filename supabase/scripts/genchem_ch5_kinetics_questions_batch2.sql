-- General Chemistry Chapter 5: Chemical Kinetics, standalone questions (prompt v7)
-- BATCH 2 of 3 (24 questions): Integrated Rate Laws & Half-Life (12) . Collision Theory & the
--   Arrhenius Equation (12). Six drafter slices of 4; compact in-stem LaTeX data lines, no
--   tables, no figures; calculator-free arithmetic throughout.
--
-- IDEMPOTENT ON ITS OWN TWO SUBTOPICS. Batch 1 owns the chapter-wide DELETE and must run first.
-- This file deletes only the two subtopics it writes, so it can be re-run without touching
-- batch 1's rows or duplicating its own. Do not re-run batch 1 after this file.
--
-- SEAMS ENFORCED, this batch:
--   . No enzyme key anywhere. Biochem Ch2 owns catalyst-lowers-Ea, TS stabilization, the
--     catalyzed-vs-uncatalyzed overlay, temperature optimum, denaturation and the 10 degree
--     doubling rule. Catalysts are batch 3's subtopic and are absent here.
--   . No delta-G definition, sign or computation. Biochem Ch12 owns the qualitative
--     spontaneous-is-not-fast prize.
--   . No equilibrium constant, expression or shift direction. Reserved forward for GenChem Ch6.
--   . Rate-constant UNITS by order are keyed in batch 1 (subtopic 2) and are not re-keyed here.
--   . Nuclear seam: exactly ONE radioisotope stem (Q34), first-order math only. No decay
--     particle identity, nuclear stability, binding energy or semi-log bookkeeping. Every row
--     carries foundation '5E'; none is tagged '4E'.
--
-- SOURCE ERRATA, refereed in the plan and used only as designed distractors:
--   . "All reactions experience an optimal temperature" is FALSE for ordinary reactions; only
--     enzyme-catalyzed rates peak. Keyed as a distractor in Q45, never credited.
--   . The frequency factor A is NOT raised by putting more molecules in the vessel.
--     Concentration enters through [A]^m in the rate law; A and k depend on temperature and the
--     barrier, not on concentration. Keyed as a distractor in Q46, never credited.
--
-- Deck alignment (general_chemistry_ch5_chemical_kinetics_flashcards.sql, live): slope signs
-- -k / -k / +k for [A], ln[A] and 1/[A] versus t (cards 11-13), first-order t1/2 independent of
-- concentration with second-order lengthening and zero-order shortening (cards 16-17),
-- radioactive decay as the classic first-order process (card 18), effective collision requires
-- orientation AND energy at least Ea (card 20), A as collision frequency times orientation
-- fraction (card 25).
--
-- See genchem_ch5_kinetics_questions.plan.md for the Step 1 pre-flight and boundary rules.

BEGIN;

DELETE FROM public.questions
  WHERE topic = 'Chemical Kinetics'
    AND subtopic IN ('Integrated Rate Laws & Half-Life',
                     'Collision Theory & the Arrhenius Equation');

-- ── Slice 1: which plot goes linear, and what its slope means ────────────────

-- Q25 . Integrated Rate Laws & Half-Life . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A chemist follows the disappearance of a reactant A and wants to confirm that the reaction is first order in A. Which graph should give a straight line?$q$,
    $q$[{"label":"A","text":"\\([\\text{A}]\\) versus \\(t\\)"},{"label":"B","text":"\\(\\ln[\\text{A}]\\) versus \\(t\\)"},{"label":"C","text":"\\(\\frac{1}{[\\text{A}]}\\) versus \\(t\\)"},{"label":"D","text":"\\([\\text{A}]^2\\) versus \\(t\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because each reaction order has one, and only one, concentration function that varies linearly with time, and integrating the first-order rate law gives \(\ln[\text{A}]_t = -kt + \ln[\text{A}]_0\). That expression has the form \(y = mx + b\) with \(y = \ln[\text{A}]\) and \(x = t\), so plotting the natural logarithm of concentration against time produces a straight line of slope \(-k\). Linearity of that particular plot is the operational test for first order: a chemist runs all three candidate plots and reports the order belonging to whichever one is straight.

(Choice A) A plot of \([\text{A}]\) against time is linear for a ZERO-order reaction, whose integrated law is \([\text{A}]_t = -kt + [\text{A}]_0\). For a first-order reaction this plot is a decaying curve, steep at first and flattening as reactant runs low.

(Choice C) A plot of \(\frac{1}{[\text{A}]}\) against time is linear for a SECOND-order reaction, where \(\frac{1}{[\text{A}]_t} = kt + \frac{1}{[\text{A}]_0}\). Using it here would produce a curve, not a line.

(Choice D) Squaring the concentration corresponds to no integrated rate law at all. The exponent 2 in a second-order rate law appears on the concentration inside the differential equation, and integration converts it into a reciprocal, not a square.

This is a Knowledge of Scientific Concepts and Principles question because you must recall which concentration function the integrated first-order rate law makes linear in time.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$zero-order plot offered for first order$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$second-order plot offered for first order$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$squares the concentration because the order is an exponent$q$ FROM q;

-- Q26 . Integrated Rate Laws & Half-Life . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A student monitors the decomposition of a compound A and prepares three plots from the same data set. Only the plot of \(\frac{1}{[\text{A}]}\) versus \(t\) is a straight line; it rises steadily with a slope of \(+0.40\ \text{M}^{-1}\text{s}^{-1}\). What are the reaction order and the rate constant?$q$,
    $q$[{"label":"A","text":"First order, \\(k = 0.40\\ \\text{M}^{-1}\\text{s}^{-1}\\)"},{"label":"B","text":"Second order, \\(k = -0.40\\ \\text{M}^{-1}\\text{s}^{-1}\\)"},{"label":"C","text":"Second order, \\(k = 0.40\\ \\text{M}^{-1}\\text{s}^{-1}\\)"},{"label":"D","text":"Zero order, \\(k = 0.40\\ \\text{M}^{-1}\\text{s}^{-1}\\)"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the reciprocal-concentration plot is the one that straightens for a second-order reaction, and for that plot alone the slope is \(+k\) rather than \(-k\). The integrated second-order law is \(\frac{1}{[\text{A}]_t} = kt + \frac{1}{[\text{A}]_0}\), so the line climbs as reactant is consumed and its slope is the rate constant itself: \(k = 0.40\ \text{M}^{-1}\text{s}^{-1}\). The rising direction reported in the stem is itself a consistency check, since \([\text{A}]\) falls with time and its reciprocal must therefore grow.

(Choice A) First order is diagnosed by a straight line on a plot of \(\ln[\text{A}]\) versus \(t\), not on a reciprocal plot. The stem states that this data set curves on the other two plots, which rules first order out.

(Choice B) Reading the slope as \(-k\) imports the sign convention that belongs to the zero- and first-order plots, where concentration functions fall with time. The reciprocal plot runs the other way, and a negative rate constant is in any case physically impossible.

(Choice D) Zero order is diagnosed by a straight line on a plot of \([\text{A}]\) itself against \(t\). A zero-order data set would curve on the reciprocal plot, and its rate constant would carry units of \(\text{M s}^{-1}\).

This is a Data-based and Statistical Reasoning question because you must read an order and a rate constant off which plotted transformation of the data turned out linear and in which direction its slope ran.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$assigns the reciprocal plot to first order$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$applies the minus-k convention to the rising plot$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$assigns the reciprocal plot to zero order$q$ FROM q;

-- Q27 . Integrated Rate Laws & Half-Life . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$For the gas-phase decomposition of a compound A, a plot of \(\ln[\text{A}]\) versus \(t\) is linear with a slope of \(-0.025\ \text{s}^{-1}\) and a vertical intercept of \(-2.30\). What is the rate constant?$q$,
    $q$[{"label":"A","text":"\\(0.025\\ \\text{s}^{-1}\\)"},{"label":"B","text":"\\(-0.025\\ \\text{s}^{-1}\\)"},{"label":"C","text":"\\(2.30\\ \\text{s}^{-1}\\)"},{"label":"D","text":"\\(0.011\\ \\text{s}^{-1}\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the integrated first-order law \(\ln[\text{A}]_t = -kt + \ln[\text{A}]_0\) assigns the slope of this plot the value \(-k\), so the rate constant is the magnitude of the slope with the sign removed: \(k = 0.025\ \text{s}^{-1}\). The intercept carries different information, namely \(\ln[\text{A}]_0\), and plays no part in extracting \(k\). A rate constant is a positive proportionality factor by definition; the negative slope reflects only that reactant is disappearing.

(Choice B) Reporting the slope itself as the rate constant keeps a minus sign that belongs to the direction of the concentration change, not to \(k\). A negative rate constant would describe a reaction running backward at all times, which the first-order model does not represent.

(Choice C) The magnitude \(2.30\) comes from the intercept, which equals \(\ln[\text{A}]_0 = -2.30\) and therefore fixes the starting concentration at \([\text{A}]_0 = e^{-2.30} \approx 0.10\ \text{M}\). The intercept says where the reaction began, not how fast it proceeds.

(Choice D) Dividing the intercept magnitude by 210, or otherwise combining slope and intercept, mixes two independent pieces of information. Slope and intercept are separately interpretable in a linearized rate law, and only the slope contains \(k\).

This is a Data-based and Statistical Reasoning question because you must extract a rate constant from the slope of a linearized plot and reject the intercept as the wrong parameter.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$keeps the minus sign in the rate constant$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$reads the intercept instead of the slope$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$combines slope and intercept arithmetically$q$ FROM q;

-- Q28 . Integrated Rate Laws & Half-Life . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A reaction consuming A is monitored on a surface. The following concentrations are recorded: at \(t = 0\ \text{s}\), \([\text{A}] = 0.80\ \text{M}\); at \(t = 100\ \text{s}\), \([\text{A}] = 0.60\ \text{M}\); at \(t = 200\ \text{s}\), \([\text{A}] = 0.40\ \text{M}\); at \(t = 300\ \text{s}\), \([\text{A}] = 0.20\ \text{M}\). What do these data indicate?$q$,
    $q$[{"label":"A","text":"The reaction is zero order, and its rate does not depend on \\([\\text{A}]\\)"},{"label":"B","text":"The reaction is first order, with a half-life of \\(100\\ \\text{s}\\)"},{"label":"C","text":"The reaction is second order, and it slows as \\([\\text{A}]\\) falls"},{"label":"D","text":"The reaction is first order, and its rate is proportional to \\([\\text{A}]\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the concentration falls by the same absolute amount, \(0.20\ \text{M}\), in every \(100\ \text{s}\) interval, which makes \([\text{A}]\) itself linear in time. That is the signature of zero order: the integrated law \([\text{A}]_t = -kt + [\text{A}]_0\) is already a straight line in concentration, and the underlying rate law is rate \(= k\), a constant. The rate here is \(2.0 \times 10^{-3}\ \text{M s}^{-1}\) throughout, even though the amount of A left has fallen to a quarter of its starting value, which is exactly what concentration independence looks like in data.

(Choice B) A first-order reaction loses a constant FRACTION per interval, not a constant amount. Were the half-life \(100\ \text{s}\), the readings would run \(0.80\), \(0.40\), \(0.20\), \(0.10\ \text{M}\). The observed series subtracts a fixed quantity instead of halving.

(Choice C) A second-order reaction slows sharply as reactant is consumed, so the drops would shrink markedly from one interval to the next. These drops are identical, and the reciprocal plot for these data curves rather than straightens.

(Choice D) Proportionality to \([\text{A}]\) would mean the reaction ran four times more slowly in the last interval than in the first, since \([\text{A}]\) has fallen by a factor of four. The measured decrease per interval never changes.

This is a Data-based and Statistical Reasoning question because you must recognize a constant absolute decrease, rather than a constant fractional decrease, as the fingerprint of zero-order kinetics.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$reads a constant absolute drop as a constant half-life$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$assigns decelerating behavior to a linear data set$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$defaults to first order for any decaying concentration$q$ FROM q;

-- ── Slice 2: half-life, and how it behaves order by order ───────────────────

-- Q29 . Integrated Rate Laws & Half-Life . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A drug is hydrolyzed in solution by a first-order process with \(k = 0.0693\ \text{s}^{-1}\). What is its half-life?$q$,
    $q$[{"label":"A","text":"\\(0.10\\ \\text{s}\\)"},{"label":"B","text":"\\(14\\ \\text{s}\\)"},{"label":"C","text":"It cannot be determined without \\([\\text{A}]_0\\)"},{"label":"D","text":"\\(10\\ \\text{s}\\)"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the first-order half-life follows \(t_{1/2} = \frac{\ln 2}{k} \approx \frac{0.693}{k}\), and dividing gives \(t_{1/2} = \frac{0.693}{0.0693\ \text{s}^{-1}} = 10.0\ \text{s}\). The rate constant alone is sufficient: no concentration appears anywhere in the first-order half-life expression, which is why a first-order process halves in the same time whether the sample is concentrated or nearly spent.

(Choice A) Computing \(\frac{k}{0.693}\) inverts the relationship. Dividing a rate constant by a dimensionless number yields something still carrying units of \(\text{s}^{-1}\), so the result is a reciprocal time rather than the time the question asks for.

(Choice B) The value \(14\ \text{s}\) is \(\frac{1}{k}\), the time for the concentration to fall to \(\frac{1}{e}\) of its starting value, roughly 37 percent remaining. That is a legitimate first-order time constant, but it is not the half-life; the factor \(\ln 2 \approx 0.693\) is what converts one to the other.

(Choice C) The starting concentration would be needed for a zero-order half-life, \(t_{1/2} = \frac{[\text{A}]_0}{2k}\), or a second-order one, \(t_{1/2} = \frac{1}{k[\text{A}]_0}\). Concentration independence is the defining convenience of first-order decay, and the stem states the process is first order.

This is a Scientific Reasoning and Problem Solving question because you must select the half-life relationship that matches the stated order and recognize that no concentration datum is required.$q$,
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
  SELECT q.id, 'A', 'reversed_relationship', $q$divides k by ln 2 instead of dividing into it$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$reports 1/k, the e-folding time, as the half-life$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$believes every half-life needs an initial concentration$q$ FROM q;

-- Q30 . Integrated Rate Laws & Half-Life . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A first-order decomposition is followed in a sealed flask. The reactant concentration falls from \(0.80\ \text{M}\) to \(0.10\ \text{M}\) over \(30\ \text{minutes}\). What is the half-life?$q$,
    $q$[{"label":"A","text":"\\(7.5\\ \\text{minutes}\\)"},{"label":"B","text":"\\(10\\ \\text{minutes}\\)"},{"label":"C","text":"\\(15\\ \\text{minutes}\\)"},{"label":"D","text":"\\(30\\ \\text{minutes}\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because a first-order process removes a constant fraction per unit time, so the drop should be counted in halvings rather than in molarity. Going \(0.80 \rightarrow 0.40 \rightarrow 0.20 \rightarrow 0.10\ \text{M}\) is three successive halvings, and three half-lives occupy the full \(30\ \text{minutes}\). Each therefore takes \(\frac{30}{3} = 10\ \text{minutes}\). No rate constant is needed, because counting halvings and dividing the elapsed time is the whole calculation.

(Choice A) Dividing \(30\) by four assumes four halvings. The concentration passed \(0.40\), \(0.20\) and \(0.10\ \text{M}\), which is three steps; a fourth would have carried it to \(0.05\ \text{M}\), below the reported endpoint.

(Choice C) Dividing \(30\) by two counts only the halvings to \(0.20\ \text{M}\) and stops one step early. The stem follows the reaction all the way to \(0.10\ \text{M}\).

(Choice D) Treating the entire interval as one half-life would require the concentration to end at \(0.40\ \text{M}\). An eightfold decrease is not a single halving.

This is a Data-based and Statistical Reasoning question because you must convert measured concentrations into a count of half-lives and divide the elapsed time accordingly.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$counts one halving too many$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$stops counting halvings one step early$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$treats the whole observation window as one half-life$q$ FROM q;

-- Q31 . Integrated Rate Laws & Half-Life . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$Two flasks of the same reactant are prepared, one at \(1.0\ \text{M}\) and one at \(0.10\ \text{M}\), and both are run under identical conditions. For which reaction order will the two samples take the same time to fall to half their starting concentrations?$q$,
    $q$[{"label":"A","text":"Zero order only"},{"label":"B","text":"Second order only"},{"label":"C","text":"Every order, because a half-life always removes the same fraction"},{"label":"D","text":"First order only"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because \(t_{1/2} = \frac{\ln 2}{k}\) for a first-order reaction contains no concentration term at all, so the two flasks halve in identical times despite a tenfold difference in loading. The other orders make the half-life explicitly concentration dependent: zero order gives \(t_{1/2} = \frac{[\text{A}]_0}{2k}\) and second order gives \(t_{1/2} = \frac{1}{k[\text{A}]_0}\), so changing \([\text{A}]_0\) changes how long the first halving takes.

(Choice A) A zero-order reaction consumes reactant at a fixed rate regardless of how much is present, so the more concentrated flask simply has more to get through. Its half-life is ten times longer here, since \(t_{1/2}\) is directly proportional to \([\text{A}]_0\).

(Choice B) A second-order half-life is inversely proportional to \([\text{A}]_0\), so the dilute flask is the slow one: with ten times less reactant, encounters between molecules are far rarer and the first halving takes ten times as long.

(Choice C) A half-life does always remove half the remaining reactant, by definition, but that says nothing about how LONG it takes. Only first-order kinetics makes that duration independent of how much material is present.

This is a Knowledge of Scientific Concepts and Principles question because you must recall which order's half-life expression omits the initial concentration.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$confuses a constant rate with a constant half-life$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$assigns concentration independence to second order$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$true that a half-life removes half, false that the time is fixed$q$ FROM q;

-- Q32 . Integrated Rate Laws & Half-Life . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A dimerization obeys rate \(= k[\text{A}]^2\). A chemist measures the time for the first halving, then the time for the next halving, then the one after that. How do these successive half-lives compare?$q$,
    $q$[{"label":"A","text":"They are all equal, as in first-order decay"},{"label":"B","text":"Each is half as long as the one before"},{"label":"C","text":"Each is twice as long as the one before"},{"label":"D","text":"Each is shorter, because reactant is steadily being used up"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the second-order half-life \(t_{1/2} = \frac{1}{k[\text{A}]_0}\) is inversely proportional to whatever concentration the interval starts from. Each halving leaves the reactant at half its previous value, so the concentration entering the next interval is halved and the next half-life is doubled. A reaction requiring two molecules of A to meet slows disproportionately as A is depleted, because the chance of an encounter falls with the square of concentration while only the first power appears in the amount remaining.

(Choice A) Constant successive half-lives are the hallmark of first-order decay, where \(t_{1/2} = \frac{\ln 2}{k}\) carries no concentration. That is precisely the behavior a second-order reaction does not show.

(Choice B) Halving each successive interval would mean the reaction accelerates as reactant disappears. Nothing in the rate law supports that: rate \(= k[\text{A}]^2\) falls monotonically as \([\text{A}]\) falls.

(Choice D) The premise is right and the conclusion is backward. Reactant is indeed being consumed, and that is exactly why each remaining halving takes LONGER, not less time.

This is a Scientific Reasoning and Problem Solving question because you must propagate the concentration dependence of the second-order half-life through successive intervals rather than recall a single formula.$q$,
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
  SELECT q.id, 'A', 'adjacent_fact', $q$imports first-order constancy into second order$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$has the reaction accelerate as reactant vanishes$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right premise, backward conclusion$q$ FROM q;

-- ── Slice 3: where zero order ends, and counting halvings ───────────────────

-- Q33 . Integrated Rate Laws & Half-Life . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$Ethanol is cleared from the bloodstream by a saturated pathway, so its removal is zero order over the relevant range. Starting from a high concentration, how do successive half-lives compare as clearance proceeds?$q$,
    $q$[{"label":"A","text":"Each is half as long as the one before"},{"label":"B","text":"Each is twice as long as the one before"},{"label":"C","text":"They are all equal"},{"label":"D","text":"They lengthen, because less reactant remains to react"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the zero-order half-life \(t_{1/2} = \frac{[\text{A}]_0}{2k}\) is directly proportional to the concentration the interval starts from. Each halving leaves half as much behind, so the next interval starts from half the concentration and takes half the time. The underlying reason is that the removal rate never changes: rate \(= k\) regardless of how much is present, so clearing a smaller amount simply takes proportionally less time.

(Choice B) Doubling successive half-lives is second-order behavior, where \(t_{1/2} = \frac{1}{k[\text{A}]_0}\) is inversely proportional to concentration. A zero-order process has the opposite dependence.

(Choice C) Equal successive half-lives belong to first order alone, where the half-life expression contains no concentration. A zero-order half-life is explicitly proportional to \([\text{A}]_0\).

(Choice D) The premise that less reactant remains is correct, but for a zero-order process that does not slow anything down. The rate is fixed by the saturated pathway, not by how much substrate is waiting, so a smaller remaining amount is cleared FASTER in absolute time, not more slowly.

This is a Scientific Reasoning and Problem Solving question because you must carry the concentration dependence of the zero-order half-life through successive intervals rather than assume all half-lives behave alike.$q$,
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
  SELECT q.id, 'B', 'adjacent_fact', $q$applies second-order lengthening to zero order$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$applies first-order constancy to zero order$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$correct premise, wrong direction for a saturated pathway$q$ FROM q;

-- Q34 . Integrated Rate Laws & Half-Life . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A radioactive tracer used in imaging decays by a first-order process. A freshly prepared sample is measured at \(24\ \text{hours}\) and found to retain one eighth of its original amount. What is the half-life of the tracer?$q$,
    $q$[{"label":"A","text":"\\(3\\ \\text{hours}\\)"},{"label":"B","text":"\\(8\\ \\text{hours}\\)"},{"label":"C","text":"\\(12\\ \\text{hours}\\)"},{"label":"D","text":"\\(24\\ \\text{hours}\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because one eighth is \(\left(\frac{1}{2}\right)^3\), so three half-lives have elapsed during the \(24\ \text{hours}\) of observation and each occupies \(\frac{24}{3} = 8\ \text{hours}\). Radioactive decay is the classic first-order process: the number of disintegrations per second is proportional to how much isotope is present, which is what makes the half-life a fixed interval rather than something that drifts as the sample is depleted.

(Choice A) The value \(3\ \text{hours}\) is the NUMBER of half-lives mistaken for their duration. Three halvings occurred, but the question asks how long each one took.

(Choice C) Dividing \(24\) by two counts only the halvings down to one quarter. Reaching one eighth requires a third halving.

(Choice D) Treating the whole interval as a single half-life would leave one half of the sample, not one eighth. An eightfold decrease cannot be one halving.

This is a Data-based and Statistical Reasoning question because you must convert a measured fraction remaining into a count of half-lives and divide the elapsed time by it.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$reports the count of half-lives as their duration$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$stops counting halvings at one quarter$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$treats the whole window as one half-life$q$ FROM q;

-- Q35 . Integrated Rate Laws & Half-Life . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A compound decomposes on a catalyst-coated surface with zero-order kinetics, \(k = 0.010\ \text{M s}^{-1}\), starting from \([\text{A}]_0 = 0.50\ \text{M}\). At what time is A completely consumed?$q$,
    $q$[{"label":"A","text":"\\(25\\ \\text{s}\\)"},{"label":"B","text":"\\(5.0\\ \\text{s}\\)"},{"label":"C","text":"\\(50\\ \\text{s}\\)"},{"label":"D","text":"Never; the concentration approaches zero asymptotically"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because a zero-order reaction removes reactant at a fixed rate, so the integrated law \([\text{A}]_t = -kt + [\text{A}]_0\) hits zero at a finite, calculable time. Setting \([\text{A}]_t = 0\) gives \(t = \frac{[\text{A}]_0}{k} = \frac{0.50\ \text{M}}{0.010\ \text{M s}^{-1}} = 50\ \text{s}\). This is a real difference between the orders rather than a bookkeeping detail: a zero-order reaction genuinely runs out, because nothing about the falling concentration slows it down on the way.

(Choice A) The value \(25\ \text{s}\) is the zero-order half-life, \(\frac{[\text{A}]_0}{2k}\), which is the time to reach \(0.25\ \text{M}\) rather than zero. Since the rate is constant, complete consumption takes exactly twice as long.

(Choice B) Dividing incorrectly by \(0.10\ \text{M s}^{-1}\) rather than \(0.010\ \text{M s}^{-1}\) shifts the answer by a factor of ten. Tracking the decimal place matters here because the rate constant is the only quantity converting concentration into time.

(Choice D) Asymptotic approach to zero is FIRST-order behavior, where each interval removes a fraction of what is left and something always remains. A constant removal rate has no such braking effect, so the line reaches the axis.

This is a Data-based and Statistical Reasoning question because you must apply the zero-order integrated law to an endpoint rather than a half-life and distinguish finite depletion from exponential approach.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$solves for the half-life instead of full depletion$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'scale_unit_error', $q$decimal slip in the rate constant$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$imports first-order asymptotic behavior into zero order$q$ FROM q;

-- Q36 . Integrated Rate Laws & Half-Life . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Integrated Rate Laws & Half-Life$q$,
    $q$A first-order decomposition has a half-life of \(12\ \text{minutes}\). What percentage of the original reactant is still present after \(36\ \text{minutes}\)?$q$,
    $q$[{"label":"A","text":"50%"},{"label":"B","text":"33%"},{"label":"C","text":"25%"},{"label":"D","text":"12.5%"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because \(36\ \text{minutes}\) contains \(\frac{36}{12} = 3\) half-lives, and each one multiplies what remains by \(\frac{1}{2}\). Three of them leave \(\left(\frac{1}{2}\right)^3 = \frac{1}{8}\), which is 12.5 percent. The halvings compound rather than add, which is the whole content of exponential decay: \([\text{A}]_t = [\text{A}]_0 e^{-kt}\) can never be handled by subtracting equal portions.

(Choice A) Fifty percent is the result of a single half-life. Stopping after one interval ignores the remaining \(24\ \text{minutes}\) of decomposition.

(Choice B) Thirty-three percent treats three half-lives as removing the material in thirds, so that one third survives. Half-lives remove half of what is currently present, not a fixed share of the original amount.

(Choice C) Twenty-five percent is the answer after two half-lives, or \(24\ \text{minutes}\). One further halving remains within the stated window.

This is a Scientific Reasoning and Problem Solving question because you must compound successive halvings rather than treat decay as a linear subtraction.$q$,
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
  SELECT q.id, 'A', 'process_step_confusion', $q$counts a single half-life$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$divides the original into thirds$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$stops one halving short$q$ FROM q;

-- ── Slice 4: what makes a collision work, and what the barrier costs ────────

-- Q37 . Collision Theory & the Arrhenius Equation . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$According to collision theory, what must be true of a collision between two reactant molecules for it to produce product?$q$,
    $q$[{"label":"A","text":"It must carry at least the activation energy and occur in a suitable orientation"},{"label":"B","text":"It must carry at least the activation energy, whatever the geometry"},{"label":"C","text":"It must occur in a suitable orientation, whatever the energy"},{"label":"D","text":"It must occur between molecules moving at identical speeds"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because collision theory imposes two independent requirements, and failing either one leaves the molecules to bounce apart unchanged. The energy criterion says the collision must supply at least \(E_a\), the minimum needed to reach the transition state. The orientation criterion says the reacting atoms must be presented to each other correctly, since a molecule struck on the wrong end cannot form the bond the reaction requires. Most collisions in a typical sample satisfy neither, which is why reaction rates are enormously smaller than collision frequencies.

(Choice B) Energy alone is not enough. Two molecules can meet with far more than \(E_a\) and still fail if they are oriented so that the reacting groups never come into contact.

(Choice C) Orientation alone is not enough either. A perfectly aligned but gentle encounter cannot climb the energy barrier, so the molecules separate without reacting.

(Choice D) Identical speeds are not required and would not help. What matters is the energy available in the collision relative to the barrier, not whether the two partners happen to be matched in speed.

This is a Knowledge of Scientific Concepts and Principles question because you must recall both criteria collision theory places on a reactive encounter.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    55
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', $q$energy criterion without orientation$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', $q$orientation criterion without energy$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$invents a speed-matching requirement$q$ FROM q;

-- Q38 . Collision Theory & the Arrhenius Equation . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$What does the activation energy of a reaction represent?$q$,
    $q$[{"label":"A","text":"The energy released when reactants are converted to products"},{"label":"B","text":"The minimum energy a collision must supply for reactants to be converted to products"},{"label":"C","text":"The average kinetic energy of the reactant molecules at a given temperature"},{"label":"D","text":"The total energy stored in the bonds of the reactant molecules"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because \(E_a\) is a threshold, not a quantity of energy the reaction possesses or releases. It is the height of the barrier separating reactants from products, and a colliding pair that cannot supply at least that much simply fails to react. Because it is a threshold, it controls how FAST a reaction goes rather than how far downhill it ends up: only the fraction of collisions clearing the barrier contributes to the rate.

(Choice A) The energy released describes the difference between the reactant and product energy levels, which fixes whether the reaction is exothermic or endothermic. That endpoint difference is unrelated to the height of the barrier between them.

(Choice C) Average kinetic energy is a property of the sample at a given temperature and is shared by all molecules present, reacting or not. \(E_a\) is a property of the reaction, fixed regardless of how hot the flask happens to be.

(Choice D) Total bond energy in the reactants is a thermochemical quantity describing stability. A reaction with very strong reactant bonds may still have a low barrier if its pathway is favorable.

This is a Knowledge of Scientific Concepts and Principles question because you must distinguish a kinetic threshold from the thermodynamic quantities that surround it.$q$,
    'easy',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    55
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', $q$confuses the barrier with the endpoint difference$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$confuses a reaction property with a sample property$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$offers a thermochemical quantity for a kinetic one$q$ FROM q;

-- Q39 . Collision Theory & the Arrhenius Equation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$A gas-phase reaction runs markedly faster when the vessel is warmed from \(300\ \text{K}\) to \(350\ \text{K}\), with no change in concentrations. What best accounts for the increase?$q$,
    $q$[{"label":"A","text":"The activation energy of the reaction falls as temperature rises"},{"label":"B","text":"The reaction becomes more exothermic at the higher temperature"},{"label":"C","text":"A larger fraction of collisions now carries energy at least equal to the activation energy"},{"label":"D","text":"The molecules collide less often, but each collision is more productive"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because temperature enters the Arrhenius equation \(k = Ae^{-E_a/RT}\) only through the exponential term, and raising \(T\) makes the exponent less negative. Physically, the distribution of molecular energies broadens and shifts upward with temperature, so the tail lying above \(E_a\) grows. Collisions do also become somewhat more frequent, but that effect is modest compared with the exponential growth in the fraction that clears the barrier, which is why the exponential term dominates the temperature response.

(Choice A) The activation energy is a fixed property of the reaction pathway. Heating supplies molecules with more energy to climb the barrier; it does not lower the barrier itself.

(Choice B) How exothermic a reaction is describes the energy difference between its endpoints and says nothing about its rate. A reaction can be strongly exothermic and still crawl if its barrier is high.

(Choice D) Collision frequency rises with temperature rather than falling, since molecules move faster. The claim reverses the frequency effect while correctly noting that individual collisions become more productive.

This is a Scientific Reasoning and Problem Solving question because you must locate temperature within the Arrhenius expression and identify which term the observed acceleration actually comes from.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$treats the barrier as temperature dependent$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$substitutes a thermodynamic change for a kinetic one$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$reverses the direction of the collision-frequency effect$q$ FROM q;

-- Q40 . Collision Theory & the Arrhenius Equation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$Two independent gas-phase reactions are run in separate vessels at the same temperature and with comparable frequency factors. Reaction X has \(E_a = 25\ \text{kJ mol}^{-1}\); reaction Y has \(E_a = 95\ \text{kJ mol}^{-1}\). What can be said about their rate constants?$q$,
    $q$[{"label":"A","text":"They are equal, because the two vessels are at the same temperature"},{"label":"B","text":"\\(k_Y > k_X\\), because a larger activation energy drives a faster reaction"},{"label":"C","text":"Neither can be compared without knowing whether each reaction is exothermic"},{"label":"D","text":"\\(k_X > k_Y\\), because a smaller barrier leaves a larger fraction of collisions able to react"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because \(E_a\) sits in a negative exponent, \(k = Ae^{-E_a/RT}\), so a smaller barrier makes the exponent less negative and the exponential factor larger. With comparable frequency factors and identical temperatures, the reaction with the lower barrier has the larger rate constant. In collision-theory language, the fraction of encounters carrying at least \(25\ \text{kJ mol}^{-1}\) is far greater than the fraction carrying at least \(95\ \text{kJ mol}^{-1}\), and that fraction is what the exponential term measures.

(Choice A) Equal temperatures fix the energy distribution the molecules are drawn from, but not the threshold each reaction demands of them. Two reactions sampling the same distribution with different barriers take different fractions from it.

(Choice B) This inverts the exponential. A larger \(E_a\) makes \(-\frac{E_a}{RT}\) more negative and the factor \(e^{-E_a/RT}\) smaller, so reaction Y is the slower of the two.

(Choice C) Whether a reaction gives out heat overall describes its endpoints, not its barrier. Rate constants follow \(E_a\), and the stem supplies both values.

This is a Scientific Reasoning and Problem Solving question because you must reason from the sign of the Arrhenius exponent to rank two rate constants.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$equal temperature taken to mean equal rate$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$reads the negative exponent backward$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$demands a thermodynamic datum for a kinetic comparison$q$ FROM q;

-- ── Slice 5: reading the Arrhenius plot ─────────────────────────────────────

-- Q41 . Collision Theory & the Arrhenius Equation . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$Rate constants for a gas-phase reaction are measured at several temperatures and plotted as \(\ln k\) versus \(\frac{1}{T}\). The plot is linear with a slope of \(-6.0 \times 10^{3}\ \text{K}\). Taking \(R = 8.3\ \text{J mol}^{-1}\text{K}^{-1}\), what is the activation energy?$q$,
    $q$[{"label":"A","text":"\\(50\\ \\text{kJ mol}^{-1}\\)"},{"label":"B","text":"\\(-50\\ \\text{kJ mol}^{-1}\\)"},{"label":"C","text":"\\(6.0\\ \\text{kJ mol}^{-1}\\)"},{"label":"D","text":"\\(0.72\\ \\text{kJ mol}^{-1}\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because taking the natural logarithm of \(k = Ae^{-E_a/RT}\) gives \(\ln k = -\frac{E_a}{R}\left(\frac{1}{T}\right) + \ln A\), a straight line in \(\frac{1}{T}\) whose slope is \(-\frac{E_a}{R}\). Solving for the barrier gives \(E_a = -(\text{slope}) \times R = (6.0 \times 10^{3}\ \text{K})(8.3\ \text{J mol}^{-1}\text{K}^{-1}) \approx 5.0 \times 10^{4}\ \text{J mol}^{-1}\), which is \(50\ \text{kJ mol}^{-1}\). The kelvin units of the slope cancel against the kelvin in \(R\), leaving an energy per mole as required.

(Choice B) Carrying the minus sign through into the answer confuses the slope with the barrier. The slope is negative because \(k\) falls as \(\frac{1}{T}\) grows, that is, as the sample cools; an activation energy is a barrier height and is positive.

(Choice C) Reporting \(6.0\ \text{kJ mol}^{-1}\) reads the slope magnitude directly as an energy and skips the multiplication by \(R\) entirely. The slope carries units of kelvin, not of energy, so a conversion factor is required.

(Choice D) Dividing by \(R\) rather than multiplying inverts the relationship. Since \(\text{slope} = -\frac{E_a}{R}\), recovering \(E_a\) requires multiplying the slope magnitude by \(R\).

This is a Data-based and Statistical Reasoning question because you must extract a physical constant from the slope of a linearized plot and handle both its sign and its units correctly.$q$,
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
  SELECT q.id, 'B', 'reversed_relationship', $q$keeps the slope's minus sign in the barrier$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$reads the slope as an energy without multiplying by R$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', $q$divides by R instead of multiplying$q$ FROM q;

-- Q42 . Collision Theory & the Arrhenius Equation . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$Rate constants for a reaction are measured at several temperatures and plotted as \(\ln k\) versus \(\frac{1}{T}\), giving a straight line. What does the vertical intercept of that line represent?$q$,
    $q$[{"label":"A","text":"\\(-\\frac{E_a}{R}\\)"},{"label":"B","text":"\\(\\ln A\\)"},{"label":"C","text":"\\(A\\)"},{"label":"D","text":"\\(E_a\\)"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because the linearized form \(\ln k = -\frac{E_a}{R}\left(\frac{1}{T}\right) + \ln A\) maps onto \(y = mx + b\) with \(b = \ln A\). The intercept is the value \(\ln k\) would take as \(\frac{1}{T}\) approaches zero, which is the infinite-temperature limit where the exponential term goes to one and \(k\) approaches \(A\) itself. Taking the logarithm of the whole Arrhenius expression is what separates the two parameters: the barrier lands in the slope and the frequency factor lands in the intercept.

(Choice A) The quantity \(-\frac{E_a}{R}\) is the SLOPE of this plot, not its intercept. Slope and intercept carry the two Arrhenius parameters separately, which is the reason for linearizing in the first place.

(Choice C) The intercept is \(\ln A\) rather than \(A\), because the entire vertical axis is logarithmic. Recovering \(A\) from the plot requires exponentiating the intercept.

(Choice D) The activation energy appears only in the slope, and even there divided by \(R\). It never appears on its own as a readable feature of this plot.

This is a Data-based and Statistical Reasoning question because you must map each Arrhenius parameter onto the specific feature of the linearized plot that carries it.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    4,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$swaps slope for intercept$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', $q$forgets the axis is logarithmic$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', $q$expects the barrier to be readable directly$q$ FROM q;

-- Q43 . Collision Theory & the Arrhenius Equation . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$Reaction X has \(E_a = 20\ \text{kJ mol}^{-1}\) and reaction Y has \(E_a = 80\ \text{kJ mol}^{-1}\). Both are warmed from \(300\ \text{K}\) to \(320\ \text{K}\). Which reaction's rate constant increases by the larger factor, and why?$q$,
    $q$[{"label":"A","text":"X, because a low barrier lets the reaction respond quickly to any change"},{"label":"B","text":"Neither; the same temperature change multiplies every rate constant equally"},{"label":"C","text":"Y, because the exponential term is more sensitive to temperature when the barrier is large"},{"label":"D","text":"Y, because its frequency factor rises faster with temperature"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the temperature response lives in the exponent \(-\frac{E_a}{RT}\), and the size of \(E_a\) sets how much that exponent moves for a given change in \(T\). A large barrier means only a tiny sliver of the energy distribution clears it at \(300\ \text{K}\); warming the sample enlarges that sliver proportionally far more than it enlarges the already generous fraction clearing a small barrier. Reaction Y remains the SLOWER reaction at both temperatures, but it is the one whose rate constant is multiplied by the larger factor.

(Choice A) A low barrier makes a reaction fast, not temperature sensitive. Because so many collisions already clear a \(20\ \text{kJ mol}^{-1}\) barrier, adding energy to the distribution has comparatively little left to recruit.

(Choice B) A given temperature change does not scale all rate constants alike, precisely because \(E_a\) appears in the exponent alongside \(T\). If it did, an Arrhenius plot would have the same slope for every reaction.

(Choice D) The frequency factor varies only weakly with temperature and is not what drives the response. Attributing the effect to \(A\) rather than to the exponential misplaces the entire temperature dependence of the Arrhenius equation.

This is a Scientific Reasoning and Problem Solving question because you must separate which reaction is faster from which reaction is more temperature sensitive, two different readings of the same exponent.$q$,
    'hard',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$conflates being fast with being temperature sensitive$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$treats temperature response as barrier independent$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', $q$right reaction, wrong Arrhenius term$q$ FROM q;

-- Q44 . Collision Theory & the Arrhenius Equation . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$In the Arrhenius equation \(k = Ae^{-E_a/RT}\), what does the pre-exponential factor \(A\) describe?$q$,
    $q$[{"label":"A","text":"The fraction of collisions carrying at least the activation energy"},{"label":"B","text":"The equilibrium position the reaction eventually reaches"},{"label":"C","text":"The total concentration of reactant in the vessel"},{"label":"D","text":"How often collisions occur and how often they are correctly oriented"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because \(A\), the frequency factor, collects the two parts of collision theory that are not about energy: how frequently reactant molecules encounter one another, and what fraction of those encounters present the molecules in a geometry capable of reacting. The energy requirement is handled separately by the exponential term, so the Arrhenius equation cleanly divides the two criteria between its two factors.

(Choice A) The fraction of collisions carrying at least \(E_a\) is exactly what the EXPONENTIAL term \(e^{-E_a/RT}\) measures. Assigning it to \(A\) would leave the exponential with nothing to describe and the orientation requirement unrepresented.

(Choice B) Where a reaction finally settles is a thermodynamic question, and no term of the Arrhenius equation addresses it. The equation describes a rate constant, which governs how quickly that destination is approached.

(Choice C) Concentration does not appear in \(A\) at all. It enters the rate through the concentration terms of the rate law, and \(k\) together with \(A\) remains the same whether the vessel is crowded or dilute.

This is a Knowledge of Scientific Concepts and Principles question because you must recall which of collision theory's requirements the pre-exponential factor carries.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'process_step_confusion', $q$assigns the exponential term's job to A$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', $q$offers a thermodynamic destination for a kinetic factor$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$routes concentration through the frequency factor$q$ FROM q;

-- ── Slice 6: the two refereed errata, orientation, and the kelvin rule ──────

-- Q45 . Collision Theory & the Arrhenius Equation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$A study guide states that every chemical reaction has an optimal temperature, above which its rate begins to fall. For an ordinary uncatalyzed gas-phase reaction, how should this claim be assessed?$q$,
    $q$[{"label":"A","text":"It is wrong; the rate rises continuously as temperature rises"},{"label":"B","text":"It is right; every reaction has a temperature at which its rate peaks"},{"label":"C","text":"It is right; above the optimum the activation energy begins to climb"},{"label":"D","text":"It is wrong; the rate stops changing once the temperature exceeds \\(E_a\\)"}]$q$::jsonb,
    'A',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is A because the Arrhenius equation contains nothing that can turn a rate constant around. As \(T\) rises, \(-\frac{E_a}{RT}\) rises monotonically toward zero, so \(e^{-E_a/RT}\) rises monotonically toward one and \(k\) increases without ever peaking. An ordinary reaction simply goes faster the hotter it gets, limited in practice only by the reactants decomposing or the vessel failing.

(Choice B) Rates that peak and then fall belong to reactions run by protein catalysts, whose three-dimensional structure is destroyed above a certain temperature. That behavior comes from the catalyst being ruined, not from kinetics, and it cannot be generalized to reactions with no such fragile machinery.

(Choice C) Activation energy is a fixed property of the reaction pathway and does not drift with temperature. Nothing in the Arrhenius expression allows \(E_a\) to respond to \(T\).

(Choice D) Temperature and activation energy are not comparable quantities, so a temperature cannot exceed an energy. Even setting that aside, the exponential approaches its ceiling gradually and never simply stops responding.

This is a Scientific Reasoning and Problem Solving question because you must test a stated generalization against the functional form of the Arrhenius equation rather than against a familiar special case.$q$,
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
  SELECT q.id, 'B', 'misconception', $q$generalizes catalyzed temperature optima to all reactions$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$lets the barrier drift with temperature$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', $q$compares a temperature with an energy$q$ FROM q;

-- Q46 . Collision Theory & the Arrhenius Equation . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$A first-order reaction is run twice at the same temperature, the second time with the reactant concentration doubled. The measured rate doubles. Which quantity changed between the two runs?$q$,
    $q$[{"label":"A","text":"The frequency factor \\(A\\) doubled, since more molecules were present to collide"},{"label":"B","text":"Neither \\(A\\) nor \\(k\\) changed; only the concentration term of the rate law did"},{"label":"C","text":"The rate constant \\(k\\) doubled, since rate and rate constant are proportional"},{"label":"D","text":"The activation energy fell, since collisions became more frequent"}]$q$::jsonb,
    'B',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is B because concentration enters the rate through the rate law, rate \(= k[\text{A}]\), and nowhere else. Doubling \([\text{A}]\) doubles the rate while leaving \(k\) untouched, and \(A\) inside \(k\) is equally untouched. Both \(A\) and \(k\) are properties of the reaction at a given temperature: they respond to the barrier and to \(T\), not to how much material is loaded into the flask. This is why a rate constant deserves its name, and why comparing two runs at different concentrations tells you about the rate law rather than about the constant.

(Choice A) The frequency factor is not a count of molecules. It describes how often a given pair encounters one another and how often such encounters are correctly oriented, both of which are already normalized for concentration. Routing a concentration effect through \(A\) would double-count it, since \([\text{A}]\) appears explicitly in the rate law.

(Choice C) Rate and rate constant are proportional only when concentration is held fixed, which is exactly what was changed here. Letting \(k\) absorb a concentration change would make it useless as a constant, since it would take a different value in every experiment.

(Choice D) The activation energy is set by the reaction pathway. Nothing about loading more reactant lowers the barrier those molecules must climb, and a doubling of the rate is fully accounted for by the concentration term.

This is a Scientific Reasoning and Problem Solving question because you must attribute an observed rate change to the correct factor in the rate law rather than to a parameter that is concentration independent.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$raises the frequency factor by adding molecules$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$lets the rate constant absorb a concentration change$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$lowers the barrier by crowding the vessel$q$ FROM q;

-- Q47 . Collision Theory & the Arrhenius Equation . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$Two bulky organic molecules react only at a single reactive site on each. Even at temperatures where most collisions carry well over the activation energy, the measured rate remains far below the rate at which the molecules collide. What best explains the shortfall?$q$,
    $q$[{"label":"A","text":"The activation energy rises with molecular size"},{"label":"B","text":"Collisions between large molecules transfer energy too slowly to matter"},{"label":"C","text":"Only a small fraction of collisions bring the two reactive sites together"},{"label":"D","text":"Large molecules collide far less often than small ones at the same concentration"}]$q$::jsonb,
    'C',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is C because the energy criterion and the orientation criterion are independent, and the stem has already granted the energy one. What remains to limit the rate is geometry: a bulky molecule presents mostly unreactive surface, so the great majority of sufficiently energetic collisions strike somewhere that cannot react. The orientation requirement is exactly the part of collision theory carried by the frequency factor \(A\), which is correspondingly small for reactions of this kind.

(Choice A) Activation energy is set by the bonds being made and broken at the reactive sites, not by the size of the scaffolding around them. The stem also specifies that the energy requirement is already being met.

(Choice B) Energy transfer in a collision is effectively instantaneous on the timescale of a reaction. Collision theory does not treat slow energy transfer as a separate obstacle.

(Choice D) At a given concentration, larger molecules present a larger cross section and so collide at least as often, not less. Frequency is not the shortfall here; productivity per collision is.

This is a Scientific Reasoning and Problem Solving question because you must identify which of collision theory's two criteria remains binding once the stem has satisfied the other.$q$,
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
  SELECT q.id, 'A', 'misconception', $q$ties the barrier to molecular size$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$invents a slow energy-transfer obstacle$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$reverses how size affects collision frequency$q$ FROM q;

-- Q48 . Collision Theory & the Arrhenius Equation . medium . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'chem_phys',
    'Chemical Kinetics',
    $q$Collision Theory & the Arrhenius Equation$q$,
    $q$A student substitutes values into \(k = Ae^{-E_a/RT}\) using \(R = 8.3\ \text{J mol}^{-1}\text{K}^{-1}\). What must be true of the temperature entered?$q$,
    $q$[{"label":"A","text":"It may be in degrees Celsius, provided \\(E_a\\) is expressed in \\(\\text{J mol}^{-1}\\)"},{"label":"B","text":"It must be the temperature at which \\(A\\) was originally measured"},{"label":"C","text":"Its scale does not matter, because temperature cancels within the exponent"},{"label":"D","text":"It must be expressed in kelvin"}]$q$::jsonb,
    'D',
    $q$This is a General Chemistry question that falls under the content category 'Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)'. The answer to this question is D because the exponent must come out dimensionless, and the only way \(\frac{E_a}{RT}\) does so is if the kelvin in the denominator of \(R\) is cancelled by a temperature on the same absolute scale. Celsius is an offset scale rather than an absolute one, so it does not cancel; entering it produces a meaningless exponent, and at \(0\ ^\circ\text{C}\) it would demand a division by zero. Kelvin is required by the units of \(R\) itself.

(Choice A) Matching the energy units fixes only half of the problem. \(R\) carries \(\text{K}^{-1}\) regardless of which energy unit accompanies it, so the temperature must still be absolute.

(Choice B) The Arrhenius equation is evaluated at whatever temperature the rate constant is wanted for. \(A\) is treated as essentially temperature independent, which is the entire convenience of the form.

(Choice C) Temperature does not cancel inside the exponent; it cancels against the \(\text{K}^{-1}\) in \(R\), which is precisely what forces the kelvin scale. If the scale truly did not matter, negative temperatures would be admissible and the exponential would change sign.

This is a Knowledge of Scientific Concepts and Principles question because you must recall that the units of the gas constant dictate the temperature scale the Arrhenius exponent requires.$q$,
    'medium',
    '5E',
    $q$Rate Processes in Chemical Reactions ― Kinetics and Equilibrium (GC)$q$,
    'general-chemistry',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$fixes the energy units but not the temperature scale$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', $q$pins the equation to one measurement temperature$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', $q$believes temperature cancels inside the exponent$q$ FROM q;

COMMIT;
