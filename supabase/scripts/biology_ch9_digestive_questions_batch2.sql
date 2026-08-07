-- Biology Chapter 9: The Digestive System, standalone questions
-- BATCH 2 of 3 (25 questions): control signalling, the exocrine pancreas, and the start of absorption.
--   Units: the gut's own nerve network and the enterogastric reflex . the two duodenal hormones .
--          anticipatory and appetite signals . the exocrine pancreas as two cell populations .
--          failure of the autodigestion safeguard and where the last enzymes sit . saliva and
--          absorptive surface area . how sugars cross the absorptive cell
--
-- !! RUN AFTER BATCH 1 !!
-- No DELETE here: batch 1 owns the chapter-scoped DELETE. Re-running this file alone would
-- duplicate its 25 questions.

BEGIN;

-- B2 Q1 . Complete reflex arcs within the gut wall . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Complete reflex arcs within the gut wall$q$,
    $q$A length of small intestine is transplanted into a recipient, and the nerve trunks that formerly ran to it from elsewhere in the body are cut at surgery. In this procedure those trunks never re-establish contact with the graft. Within weeks the graft is moving material along its length in an orderly, propagated fashion. Which feature of the intestinal wall accounts for this?$q$,
    $q$[{"label":"A","text":"The muscle coats of the graft become continuous with those of the recipient's own bowel at the surgical join, which carries each wave across."},{"label":"B","text":"Signals reaching the graft in the bloodstream drive each individual contraction as it occurs."},{"label":"C","text":"The wall itself holds sensory, integrating and motor neurons together, so a complete arc can be closed locally with no input from beyond the organ."},{"label":"D","text":"Fibres from the recipient regrow into the graft and restore the divided connections."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests how the nervous tissue of the digestive tube is arranged and what that arrangement lets the tube accomplish unaided. The answer is C because the wall carries detecting, integrating and commanding elements side by side, so a full arc can be closed inside the tissue with no traffic to or from the central nervous system. The tube from oesophagus to anus holds on the order of a hundred million nerve cells embedded in its own layers, and that population is not purely motor: it includes cells that read the state of the lumen, cells that integrate those readings, and cells that instruct the muscle coats and the glands. Because all three classes sit within the tissue, a stimulus arising at one point can be detected, processed and answered on the spot. Connections from outside adjust how vigorously the wall works, but they are not needed to generate the basic ordered sequence, which is precisely why a graft cut off from them still propels its load.

(Choice A) Continuity of the muscle layers across a join could at best conduct activity from the recipient's own bowel into the graft. It cannot explain an ordered sequence that begins and ends inside the graft itself, and the same behaviour appears in preparations with no such continuity at all.

(Choice B) Bloodborne messengers do reach the graft and do modulate how briskly it works, but a circulating signal arrives at every part of the graft at once. It cannot specify that one point shortens while the point just ahead of it yields, and spatial sequencing of that kind demands a circuit built into the tissue.

(Choice D) Regrowth of severed fibres is a common assumption, but the stem removes that possibility, and the behaviour appears anyway. Treating outside innervation as indispensable inverts the actual dependence: the local circuitry is the engine and the outside supply is the throttle.

This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall how the neural equipment of the digestive tube is composed and to apply that composition to an organ deliberately isolated from every connection outside itself.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q2 . Positional inference for two wall networks . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Positional inference for two wall networks$q$,
    $q$A toxin selectively destroys the neurons of the nerve network lying in the layer of dense connective tissue that separates the mucosal lining of the small intestine from the muscle coats. The separate network lying between the circular and the longitudinal muscle coats is left untouched, and both muscle coats and the mucosal lining remain structurally normal. Which of the following outcomes would be expected?

I. The watery fluid released into the lumen after a meal is reduced in volume.
II. Rhythmic propulsion of material along the segment is abolished.
III. The force developed by the two muscle coats during mixing is reduced.$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests the division of labour between the two intramural nerve networks, inferred from where each one sits rather than from a memorised label. The answer is A because a network embedded in the connective tissue just under the lining is positioned to reach the glands and the absorptive surface, whereas the network sandwiched between the two muscle coats is the one wired to the contractile machinery, and that second network is spared here. Position dictates access. Neurons whose processes end among the glands and the vascular bed of that connective tissue layer can modulate how much fluid and enzyme is delivered into the lumen and can respond to what the lining detects. Neurons whose cell bodies and processes lie in the plane separating the circular and longitudinal coats are the ones able to set the rhythm and the force of shortening in those coats. Because the lesion spares that second plane entirely, everything that depends on the muscle continues, and only the output aimed at the lining is lost.

(Choice B) This adds a motor loss to a correct secretory loss. Propulsion depends on the network left intact and on muscle that the stem states is structurally normal, so ordered movement along the segment persists.

(Choice C) This assigns motility to the network that was destroyed and drops the one genuine consequence. It reverses the mapping between depth in the wall and function, which is the single inference the item is built around.

(Choice D) Selecting everything treats damage to one network as damage to the whole wall. The two networks are anatomically separate populations at different depths, and a lesion confined to one of them cannot abolish functions served by the other.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict which functions survive a lesion by reasoning from the anatomical layer each network occupies to the structures its processes can actually reach.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q3 . Feedback braking of gastric outflow . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Feedback braking of gastric outflow$q$,
    $q$In an animal preparation the pathway carrying signals from stretch receptors in the wall of the first part of the small intestine back to the gastric musculature is interrupted. Acid output per meal, measured directly, is unchanged from baseline, and no other pathway is disturbed. Over several weeks these animals develop erosions in the lining a short distance beyond the stomach. Which change most directly accounts for the erosions?$q$,
    $q$[{"label":"A","text":"The stomach now produces more acid per meal, so the total amount reaching the intestine rises."},{"label":"B","text":"The stomach now empties more slowly, holding its contents against the lining for longer before release."},{"label":"C","text":"The gate at the stomach outlet loses its tone, so intestinal contents wash backward into the stomach."},{"label":"D","text":"Each emptying event now delivers a larger bolus, so material arrives faster than the receiving tissue can neutralise and absorb it."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests a negative feedback loop that matches the rate of delivery out of one organ to the processing capacity of the next, and asks the student to work backwards from an injury to the loop that failed. The answer is D because interrupting the feedback removes the brake on outflow, and unbraked outflow overwhelms a downstream segment that can only handle a small parcel at a time. Under normal conditions the arrival of a parcel in the first portion of the intestine is sensed by wall receptors, and that sensing feeds back to slow the pump and tighten the outlet, so the next parcel waits until the previous one has been dealt with. Only about three millilitres are handed over per cycle, and that trickle is what allows incoming acid to be buffered and nutrients to be broken down and taken up. Remove the feedback limb and the pump empties without restraint, so the delivered flux rises even though the amount of acid made is identical. The lesion is therefore a rate problem, not a production problem, which is exactly why the unchanged acid measurement is the discriminating fact rather than a throwaway detail.

(Choice A) The stem reports acid output per meal as unchanged, so the total load is the same; what has altered is how quickly it is handed over. Students who assume any downstream ulceration means excess secretion skip the measurement that rules it out.

(Choice B) This has the direction backwards. Losing the inhibitory feedback speeds handover rather than slowing it, and slower handover would protect the downstream lining rather than damage it.

(Choice C) Backward washing would expose the stomach, which is built to withstand its own secretion, and it would not concentrate injury just beyond the outlet. The reflex arm in question governs forward handover, not retrograde flow.

This is a Scientific Reasoning and Problem Solving question because it asks the student to infer, from an observed pattern of injury plus one measurement that eliminates the obvious alternative, which direction a disrupted feedback loop must have shifted the rate of delivery.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q;

-- B2 Q4 . Ruling out a purely muscular explanation . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Ruling out a purely muscular explanation$q$,
    $q$An excised loop of small intestine is suspended in a warmed, oxygenated bath. Gentle distension applied at one point of the wall reliably evokes shortening on the upstream side and lengthening on the downstream side, and the pattern is reproducible across trials. The investigators conclude that the ordered response is neurally driven. Which control is most necessary before that conclusion is accepted?$q$,
    $q$[{"label":"A","text":"Confirm that the bath stayed oxygenated and at body temperature for the whole protocol."},{"label":"B","text":"Apply the identical stimulus again after abolishing conduction in the neurons of the preparation, since the contractile layers acting alone would yield the same observation."},{"label":"C","text":"Set the distending force to several different magnitudes and record how the reaction scales with it."},{"label":"D","text":"Show that direct stimulation of the muscle coats on their own evokes no shortening, which would exclude a muscular contribution."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests experimental logic: whether the stated conclusion is the only account of the result, and what manipulation is needed to eliminate the competing account. The answer is B because the observation as it stands does not separate a response built by nerve cells from one generated by the contractile layers on their own, and only silencing signalling in the neurons of the preparation can tell those two mechanisms apart. A local deformation that is answered by shortening on one side and yielding on the other looks like a circuit at work, but a wholly non-neural mechanism intrinsic to the coats could produce the same directional pattern, and nothing in the protocol so far excludes it. The decisive test is therefore to abolish conduction in the nerve cells and repeat the identical stimulus: if the ordered reaction vanishes, nerve cells are required, and if it survives unchanged, the investigators' conclusion is wrong. Without this manipulation the data are compatible with two mechanisms and cannot select between them.

(Choice A) Viability matters, but a vigorous, reproducible reaction is already evidence that the tissue was alive and working. This control guards against a false negative, whereas the threat to this conclusion is a false attribution of a positive result.

(Choice C) Varying the magnitude of the stimulus describes how the reaction scales with input. It is a useful characterisation but it leaves both candidate mechanisms standing, because a non-neural reaction would also vary with the stimulus.

(Choice D) This inverts which element should be silenced, and it demands an outcome that contradicts the data already in hand. The wall visibly shortens, so the muscle coats plainly can contract; showing that they cannot would falsify the observation rather than test its cause.

This is a Reasoning about the Design and Execution of Research question because it asks the student to identify the rival non-neural explanation left open by the existing protocol and to select the specific manipulation that discriminates between the two.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', NULL FROM q;

-- B2 Q5 . Self-limiting feedback in secretin release . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Self-limiting feedback in secretin release$q$,
    $q$In an anaesthetised animal, a catheter delivers acid into the lumen of the first segment of the small intestine at a steady rate while a strong buffer holds that lumen at pH 3.0 no matter what the animal secretes. Pancreatic duct output and blood secretin are followed for one hour, and duct output rises promptly and stays raised. Over that hour, blood secretin will most likely do which of the following?$q$,
    $q$[{"label":"A","text":"Return toward its starting value within a few minutes, since bicarbonate reaches the lumen normally"},{"label":"B","text":"Rise only once the fat portion of a meal reaches the same region"},{"label":"C","text":"Stay high throughout, because the alkaline load it calls for can no longer erase the signal that caused its own release"},{"label":"D","text":"Fall steadily as the cells that release it are exhausted by the constant stimulus"}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests negative feedback in the hormonal control of exocrine pancreatic secretion. The answer is C because holding the lumen at pH 3.0 removes the one event that would normally switch the loop off. Acid arriving from the stomach triggers release of this peptide from cells in the intestinal wall, and the peptide calls for a watery, bicarbonate rich juice from the duct cells of the pancreas. That juice raises luminal pH, and a raised pH is exactly the condition under which further release stops. The loop therefore closes on itself: the response abolishes the very stimulus that produced it. That is why the normal burst is brief, and why the quantity released tracks the acid load delivered rather than running on indefinitely. In this preparation the buffer fixes pH regardless of how much base the duct cells deliver, so the off switch never arrives and release continues for as long as acid is infused. The effector arm is working perfectly, as the sustained duct output shows. It is the feedback arm alone that the experiment has cut, and separating those two arms is the whole point of the manipulation.

(Choice A) Bicarbonate does reach the lumen here, and in an intact animal that delivery would end the episode within minutes. It ends the episode only by changing pH, however, and pH cannot change in this preparation, so delivery by itself is not sufficient to shut off release.

(Choice B) Fat arriving in this region triggers a different duodenal peptide, the one that calls for enzyme rich juice and gallbladder emptying. This animal is receiving acid alone and no meal, so that trigger is never engaged.

(Choice D) Endocrine cells of the gut wall do not fatigue over a single hour of stimulation. A falling level would require the stimulus to be withdrawn or the cells to be destroyed, and neither occurs in this setup.

This is a Scientific Reasoning and Problem Solving question because it asks the student to predict how a hormone's time course changes when an experimental manipulation prevents that hormone's own effect from acting back on the signal that released it.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q6 . Duodenal acid restrains gastric acid output . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Duodenal acid restrains gastric acid output$q$,
    $q$In a perfused preparation, the stomach and the first segment of the small intestine share one blood supply, but their lumens are sealed off from one another so that nothing placed in either can pass into the other. A protein rich mixture is placed in the stomach and the acid the stomach produces is collected and titrated. The run is then repeated with the same mixture in the stomach while dilute acid is perfused through the lumen of the intestinal segment. Compared with the first run, acid output from the stomach during the second run will most likely be which of the following?$q$,
    $q$[{"label":"A","text":"Lower, since acid bathing the duodenum releases a peptide into the blood that restrains the parietal cells"},{"label":"B","text":"Higher, since a duodenum held at low pH calls for a faster supply of acid to keep digestion moving"},{"label":"C","text":"Unchanged, since the parietal cells answer only to conditions inside the stomach itself"},{"label":"D","text":"Lower, since bicarbonate called for by the duodenum reaches the stomach and neutralises the acid before it is collected"}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests the cross organ arm of the acid triggered duodenal signal. The answer is A because the acid perfused through the intestinal lumen releases a peptide that circulates back to the stomach and cuts acid production there, and the shared blood supply is the only route left by which the two organs can still influence each other. Acid arriving in the first segment of the small intestine is sensed by endocrine cells in its wall, which put secretin into the blood. The best known job of that peptide is to call for a watery, bicarbonate rich juice from the duct cells of the pancreas, which titrates the acid already delivered. It has a second job as well: it acts back on the stomach and damps the output of hydrochloric acid. The two jobs pull in the same direction. One removes acid that has already arrived; the other cuts the supply at its source, so that less acid arrives in the first place. This preparation is built to expose the second job on its own. The stomach's own stimulus, protein sitting in its lumen, is identical in both runs, and no fluid can move between the lumens, so any fall in the acid the stomach produces must have been carried by the blood.

(Choice B) This reverses the sign of the signal. Acid persisting in the intestinal lumen reports that the load already delivered exceeds what has been neutralised, and the useful response is to slow the supply rather than to raise it.

(Choice C) Distension and protein in the stomach are genuine stimuli for acid output, but they are not the only inputs. Conditions downstream feed back on the stomach as well, which is exactly what this preparation is designed to reveal.

(Choice D) Pancreatic bicarbonate is delivered into the intestinal lumen, not into the stomach, and the sealed lumens forbid any movement between the two here. What is measured is also the acid the stomach produces, not the acid that survives downstream.

This is a Scientific Reasoning and Problem Solving question because it asks the student to attribute a change in one organ's output to a blood borne signal after the design has closed off every other route between the two organs.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q7 . Dual organ targets of one signal . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Dual organ targets of one signal$q$,
    $q$A researcher infuses a synthetic peptide into a fasting animal. Within minutes the muscular sac tucked beneath the liver squeezes down, and fluid entering the small intestine proves rich in digestive enzymes yet no more alkaline than before. Which luminal event does this peptide most likely reproduce?$q$,
    $q$[{"label":"A","text":"A drop in pH as gastric contents cross into the small intestine"},{"label":"B","text":"Stretch of the stomach wall as meal volume builds"},{"label":"C","text":"Glucose accumulating in the lumen as starch is broken down"},{"label":"D","text":"Fatty acids and amino acids arriving from a meal rich in fat and protein"}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests recognition of the duodenal signal that coordinates two separate deliveries from two separate organs. The answer is D because contraction of the gallbladder paired with an enzyme rich but not notably alkaline secretion is the fingerprint of the signal released by the fat and protein content of a meal. Cells in the wall of the duodenum respond to fatty acids and amino acids in the lumen by releasing cholecystokinin into the blood. That hormone acts on two targets at once. At the pancreas it drives the acinar cells, which supply the digestive enzymes, rather than the duct cells, which supply the watery bicarbonate. At the gallbladder it drives contraction of the smooth muscle of the wall, pushing the stored contents down the duct system into the duodenum. Both deliveries are worth making only when fat and protein are actually present, which is why their arrival, and not the arrival of a meal in general, is the trigger. The absence of any rise in alkalinity is the detail that separates this signal from the acid triggered one.

(Choice A) A falling pH is the trigger for the other duodenal peptide, and the secretion that follows it is watery and rich in bicarbonate. The fluid described here gained no alkalinity at all, which rules that trigger out.

(Choice B) This steps back to the gastric phase. Distension of the stomach wall drives gastrin release and gastric acid output; it does not empty the gallbladder, and this animal is fasting with nothing in the stomach to stretch it.

(Choice C) Products of starch breakdown do not command gallbladder contraction. A glucose load in the lumen calls for none of the deliveries observed in this experiment.

This is a Scientific Reasoning and Problem Solving question because it asks the student to infer an upstream trigger from the specific combination of downstream responses that were observed.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q8 . Fat load, CCK and stomach exit rate . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Fat load, CCK and stomach exit rate$q$,
    $q$Four test meals of equal volume and equal energy content were given to the same volunteers on separate days, differing only in the share of energy supplied as fat. Blood CCK at 30 minutes and the time needed to clear half the meal from the stomach were measured.

| Meal | Fat (% of energy) | CCK in blood (pmol/L) | Time to clear half the meal (min) |
|---|---|---|---|
| 1 | 5 | 2 | 45 |
| 2 | 20 | 6 | 78 |
| 3 | 40 | 11 | 120 |
| 4 | 60 | 15 | 155 |

Meal 4 is then repeated while the volunteers receive a drug that prevents CCK from acting on its target tissues. Which result best fits the pattern in the table?$q$,
    $q$[{"label":"A","text":"Roughly 155 min to clear half the meal, with CCK near 15 pmol/L"},{"label":"B","text":"Roughly 50 min to clear half the meal, with CCK near 15 pmol/L"},{"label":"C","text":"Roughly 50 min to clear half the meal, with CCK near 2 pmol/L"},{"label":"D","text":"Roughly 120 min to clear half the meal, with CCK near 11 pmol/L"}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the use of paired measurements to identify a hormone as the mediator of an observed effect. The answer is B because the drug cuts the last link in the chain while leaving the first two links untouched. Across the four meals, fat share, hormone level and stomach clearance time rise together, which is consistent with a chain running from luminal fat to hormone release to a restraining influence on the stomach. Silencing the target tissues does not stop the lining of the duodenum from sensing fat and putting the hormone into the blood, so a meal with 60 percent of its energy as fat should still push the measured level to about 15 pmol/L. What the drug removes is the ability of the target tissue to respond, so the restraint disappears and the meal should leave at roughly the pace of the fat poor meal, near 45 to 50 min. That is the physiological point of the loop: the more fat that has already arrived, the slower the rate at which the rest is permitted to follow, so delivery stays matched to the capacity available to process it.

(Choice A) This predicts no change at all, which would mean fat slows clearance by its bulk or its physical properties rather than through a signal. If that were true, silencing the hormone's action could not matter, yet the tight pairing of hormone level with clearance time across the table points to a mediated effect.

(Choice C) This treats the hormone level as a downstream consequence of slow clearance rather than its cause. The drug acts on the tissues receiving the message, not on the cells sending it, so the measured level should not collapse.

(Choice D) This concedes only a partial effect, shifting the response one row up the table as though the drug had reduced the fat content of the meal. Silencing the response removes it rather than scaling it back by one step, and the fat delivered is unchanged.

This is a Data-based and Statistical Reasoning question because it asks the student to read a trend across two paired columns and then predict both values for a condition that does not appear in the table.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q9 . Route dependent amplification of nutrient signalling . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Route dependent amplification of nutrient signalling$q$,
    $q$On two separate days, healthy volunteers took in sugar by two different routes. On one day they swallowed 50 g of sugar. On the other day sugar was delivered into a forearm vein, and the infusion rate was adjusted continuously so that the blood sugar curve reproduced the swallowed day point for point. Plasma insulin was measured as the readout.

| Time (min) | Blood sugar, swallowed (mg/dL) | Blood sugar, vein (mg/dL) | Insulin, swallowed (uU/mL) | Insulin, vein (uU/mL) |
|---|---|---|---|---|
| 0 | 88 | 88 | 9 | 9 |
| 30 | 141 | 140 | 74 | 38 |
| 60 | 128 | 129 | 62 | 30 |
| 120 | 96 | 95 | 21 | 12 |

Which conclusion do these paired curves support?$q$,
    $q$[{"label":"A","text":"The swallowed load was taken up faster, so it drove a higher peak blood sugar level than the vein load did."},{"label":"B","text":"Starch breakdown beginning in the mouth released extra absorbable sugar that the vein route could not supply."},{"label":"C","text":"Passage of the load through the gut lumen liberates a circulating messenger that acts in addition to the rise in blood sugar itself."},{"label":"D","text":"Blood sugar concentration is the only stimulus at work, and the swallowed day simply exposed the target to that stimulus for longer."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the incretin principle: using two routes of nutrient delivery to isolate a contribution that originates in the gut rather than in the bloodstream. The answer is C because the two blood sugar curves are essentially superimposable while the measured readout on the swallowed day runs roughly twice as high, so the extra output cannot be attributed to the sugar level and must arise from a factor generated when the load travelled along the gut lumen. The design deliberately clamps one variable: by titrating the infusion until the vein day traced the swallowed day point for point, the investigators removed sugar concentration as a possible explanation for any difference that remained. At 30 minutes both days sit near 140 mg/dL, yet the readout is 74 against 38, and a similar twofold gap persists at 60 and at 120 minutes. A difference that survives after the stimulus has been matched in both magnitude and duration points to a second, additive stimulus present on one day only. Cells scattered through the lining of the upper small bowel discharge peptides when nutrients physically transit past them, and those peptides travel in the blood to reach their target, which is exactly the extra input this paired design exposes. (Choice A) Faster uptake would show up as higher values in the second column, and it does not: 141 against 140 at 30 minutes, then 128 against 129 at 60 minutes. The matched curves were engineered specifically to exclude this reading. (Choice B) Salivary breakdown of starch is real, but the material given here was already sugar, and any extra absorbable sugar it released would have lifted the swallowed day curve above the vein day curve. The table shows no such separation. (Choice D) This choice is false rather than merely incomplete, because it asserts that sugar concentration is the only stimulus at work. Sugar concentration was matched in both level and duration across the two days, so an exclusive account predicts identical readouts, yet the readouts differ roughly twofold at every sampling point after baseline. This is a Data-based and Statistical Reasoning question because it asks the student to identify which column was experimentally held equal, quantify the gap in the column that was not, and infer an unmeasured circulating signal from the size and persistence of that gap.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q10 . Anticipatory stomach signal versus fuel gauge . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Anticipatory stomach signal versus fuel gauge$q$,
    $q$Volunteers on a fixed meal schedule had a peptide made in the stomach lining measured every 20 minutes. Its level climbed steadily between meals, reached its highest value in the sample drawn immediately ahead of each scheduled meal, and fell by more than half within an hour of the first bite. On a separate day the volunteers were told that the next meal would be served two hours later than usual, and the high point shifted to match the new time. What does this pattern indicate about the quantity the peptide reports?$q$,
    $q$[{"label":"A","text":"It encodes a prediction of when food will arrive, so it can drive food seeking in advance of any shortfall in stored fuel."},{"label":"B","text":"It reports how much fuel is on hand, rising as reserves run down and falling once they are replenished."},{"label":"C","text":"It operates over weeks, setting long term body mass rather than the timing of any one meal."},{"label":"D","text":"It is released only once nutrients reach the small bowel, so the rise ahead of a meal is the tail of the previous one."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests what the time course of a hormone reveals about the variable it encodes, using a stomach derived appetite signal. The answer is A because the high point relocates when the only thing that changed was the announced timing of the next meal, and an announcement alters nothing about the body's stored fuel. Two features of the record separate a forecast from a measurement. A gauge of stored fuel can change only when stored fuel changes, so it should be completely indifferent to being told that the meal has moved, and it should keep falling for several hours after eating while absorption slowly rebuilds the reserve. Neither holds here: the whole waveform moves with the expectation, and the decline begins essentially at the first bite and is more than half complete within an hour. The controlled variable is therefore the predicted delivery of food rather than the present state of the body's supply, which is the signature of a feed forward, anticipatory arm of control that prepares the animal to seek and take in food ahead of any registered deficit. (Choice B) This is the intuitive reading, and the climb between meals is consistent with it. It fails the decisive test: no account based on depletion of reserves can explain why merely announcing a later meal moves the high point, since the announcement changes no reserve. (Choice C) Long term regulation of body mass is a real control problem, but it is handled over weeks by different signals. The record here resolves changes over tens of minutes and is locked to individual meals, so the timescale in this choice is wrong by orders of magnitude. (Choice D) This misplaces both the site and the trigger of release. The peptide is made proximally, in the stomach lining, not in the small bowel, and its highest values occur when the tract is emptiest rather than after material has moved downstream. This is a Scientific Reasoning and Problem Solving question because it asks the student to use the shape of the rise and fall, together with the effect of moving the announced meal time, to decide between two competing meanings for one hormonal signal.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'scale_unit_error', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q11 . Why the final digestive phase inhibits . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Why the final digestive phase inhibits$q$,
    $q$The last phase of gastric control is set off when chyme distends the duodenum, and on balance it slows emptying and damps secretion rather than driving them. A student objects that ending a control sequence with a phase made mostly of brakes wastes an opportunity. What is the strongest functional justification for the arrangement?$q$,
    $q$[{"label":"A","text":"Holding material back gives the stomach longer to reduce the meal to fine particles, the step that limits the whole process."},{"label":"B","text":"The receiving segment can neutralise and work on only so much material per minute, so it must be able to throttle what is sent to it."},{"label":"C","text":"Quicker delivery would raise the fraction of a meal taken up, so the brakes exist to hold total uptake down."},{"label":"D","text":"The braking signals act over days, setting how often meals are taken rather than governing the meal presently in transit."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the design logic of the terminal phase of gastric control, in which inhibition rather than stimulation predominates. The answer is B because the compartment that receives the material has a ceiling on how fast it can buffer, dilute and act on what arrives, and the dependable way to defend that ceiling is a signal running backwards from the consumer to the supplier. Any control system feeding a rate limited downstream stage needs negative feedback from the stage that carries the load. The stomach can present material far faster than the next compartment can cope with: acid has to be buffered, a concentrated load has to be diluted with secreted fluid, and enzymes have to be delivered and given time to act. If delivery outran that ceiling, poorly buffered and poorly diluted material would sweep past the surface where it could be handled, and net uptake would fall even though the meal was moving faster. Braking is therefore not a wasted opportunity but the mechanism that matches supply to throughput, and it belongs last because only the receiving compartment can register how much has already arrived. (Choice A) Extra mechanical reduction does continue while material is retained, so this is a genuine side benefit rather than the justification. The brake is generated by what has reached the receiving segment rather than by particle size in the stomach, and it is applied even to a meal that is already liquid and needs no further mechanical reduction. (Choice C) This reverses the purpose of the restraint. Slowing delivery protects uptake rather than limiting it, because material presented faster than it can be handled passes the absorbing surface in a form that cannot be taken up. (Choice D) The feedback here operates minute by minute during a single meal and is generated by material currently in the tract. Setting how frequently meals are taken is a far slower control problem handled by separate signals. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general principle that a downstream compartment with a limited processing rate must be able to govern its own rate of input.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    65
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- B2 Q12 . Division of secretory labour within pancreas . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Division of secretory labour within pancreas$q$,
    $q$The exocrine pancreas is built from grape-like end clusters whose cells are packed with secretory granules of digestive enzymes, and these clusters empty into a branching tree of fine tubes lined by a flatter cell type. In a healthy adult, a meal rich in fat and amino acids drives heavy granule release from the end clusters, whereas a strongly acidic load drives a large watery, alkaline flow from the tube lining. What does this separation of control allow the gland to do?$q$,
    $q$[{"label":"A","text":"Vary the ratio of catalyst to buffer in what it delivers, not merely how much juice it delivers."},{"label":"B","text":"Raise the granule content of the juice when acid arrives, and raise its volume when fat and amino acids arrive."},{"label":"C","text":"Change only the total quantity of juice delivered, since both cell types are always recruited together."},{"label":"D","text":"Generate, from the tube lining, the pressure that opens the muscular gate at the intestinal opening."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests the functional logic behind splitting exocrine pancreatic secretion across two separately controlled cell populations. The answer is A because two independently driven arms let one gland change what its juice is made of, not merely how much of it arrives. The granule filled end clusters contribute the catalytic component of the juice, while the flatter cells lining the fine tubes contribute the watery, buffer rich fluid that carries it. Since fat and amino acids recruit the first population and acid recruits the second, the organ can send out a large, weakly catalytic, strongly buffering flow when a very acidic load arrives, and a smaller, catalytically dense flow when the load is mostly substrate. If one cell type performed both jobs, the only available adjustment would be to turn a single fixed recipe up or down, so the proportion of catalyst to buffer would be locked no matter what the intestine received. The two population design is therefore not redundancy, it is the mechanism by which a single duct can carry two different things in two different proportions. (Choice B) reverses the pairing given in the setup, since the acidic stimulus drives the fluid arm and the nutrient stimulus drives the granule arm, and swapping them would flood an acidic intestine with catalyst and a protein rich one with plain fluid. (Choice C) asserts the opposite of what separate control means, and a gland built that way could vary only how much juice it made, never what was in it. (Choice D) describes a plumbing function that belongs to the smooth muscle gate at the shared intestinal opening rather than to the secretory epithelium, and even if it were true it would say nothing about why two distinct cell types exist. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to apply the general principle that separately regulated secretory populations give a gland control over the makeup of its product rather than only over its quantity.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B2 Q13 . Timing of alkaline delivery to duodenum . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Timing of alkaline delivery to duodenum$q$,
    $q$A researcher perfuses an anaesthetised animal's proximal duodenum with acidic chyme at a constant rate through an indwelling catheter and leaves the gut free to contract. A dose of pancreatic protease labelled with a non-absorbable dye is delivered through that same catheter at time zero. Sodium bicarbonate is then delivered through the catheter either at time zero or twenty minutes later. With simultaneous delivery, the dyed segment measures pH 7.3. With the delay, the dyed segment still measures pH 2.4 at every sampling point after the bicarbonate went in, while a segment nearer the stomach reads pH 7.6 at those same sampling points. What explains the failure of the late dose to reach the dyed segment?$q$,
    $q$[{"label":"A","text":"Bicarbonate crosses the duodenal wall within seconds of entering, so a late dose is taken up before it can act on anything."},{"label":"B","text":"Luminal contents advance steadily in one direction, so a dose given later trails behind the tagged bolus and never mixes back into it."},{"label":"C","text":"The continuous acid perfusion consumed the entire late dose before it could raise pH anywhere in the gut."},{"label":"D","text":"Chyme is normally brought to neutral pH while still in the stomach, so bicarbonate placed beyond it acts at the wrong stage whatever the timing."}]$q$::jsonb,
    'B',
    $q$This Organ Systems item tests the delivery problem created by the fact that the buffering arm and the granule arm of pancreatic juice leave the gland through one opening, and it is answered from the geometry of a moving lumen rather than from any chemical property of what was instilled. The answer is B because gut contents travel as a one way procession, so material added twenty minutes late joins a different parcel of that column and simply follows the earlier parcel downstream. The dye marks one parcel and travels with it. During the twenty minute wait that parcel is carried well past the catheter tip, so the alkali is deposited into fluid that is behind it and moving in the same direction at roughly the same speed, which is why it never catches up. The reading of pH 7.6 nearer the stomach is the decisive observation, because the alkali plainly did raise pH somewhere, just in the wrong parcel of fluid. This is why the alkaline component of pancreatic juice must be delivered with, or ahead of, the granule component through the same opening, since a buffer that arrives afterwards is chasing contents it can no longer overtake. (Choice A) states a common belief about how bicarbonate is handled but is refuted by the data, because a dose that vanished into the wall within seconds could not have produced a zone at pH 7.6. (Choice C) is defensible until that same measurement is applied, since a dose fully neutralised by the incoming acid would leave no alkaline zone anywhere, and one was found. (Choice D) puts neutralisation at the wrong stage, since the gastric compartment is where the load is acidified and the correction happens downstream of it, so moving that step upstream does not explain a spatial separation within the gut. This is a Scientific Reasoning and Problem Solving question because it asks the student to use one internal contradiction in the measurements, an alkaline zone in the wrong place, to reject the chemical explanations and settle on a transport and timing explanation.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'process_step_confusion', NULL FROM q;

-- B2 Q14 . Anion exchange and blocked ductal secretion . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Anion exchange and blocked ductal secretion$q$,
    $q$Duct cells of the exocrine pancreas run a carrier on the duct face that expels one buffering anion into the fluid for every chloride ion it draws into the cell, and a second protein in that same face feeds chloride back out to keep the carrier stocked. When that second protein is absent from the membrane, the gland's secretion becomes thick and clogs the small ducts, and the granule products made upstream are held back inside the organ. An experimental compound inserts an unrelated anion channel into the duct face of cells that lack the missing protein. What change in secretion is predicted, and on what basis?$q$,
    $q$[{"label":"A","text":"Output volume falls, because the added anion flow drives the carrier backwards and pulls the buffering anion into the cell."},{"label":"B","text":"Output volume is unchanged, because water crosses this epithelium through dedicated pores whose flow is set independently of solute movement."},{"label":"C","text":"Output volume rises, because the swap can resume once its partner ion is available in the duct fluid again, and water follows the osmotic load."},{"label":"D","text":"Output volume rises only after several weeks, because the compound acts by raising synthesis of the carrier rather than by changing ion flow."}]$q$::jsonb,
    'C',
    $q$This Organ Systems item tests the ion exchange that generates the watery alkaline arm of pancreatic juice and the failure that follows when its supporting anion channel is lost. The answer is C because the carrier is an exchanger, so it can only export one anion if the partner anion keeps arriving on the duct side, and any route that resupplies that partner restores the whole sequence. In an intact duct cell the missing protein is a recycling loop: it returns chloride to the duct fluid so the exchanger can pick it up again and push out another buffering anion. Remove that loop and chloride on the duct side is quickly exhausted, the exchanger stalls, the alkaline solute stops entering the fluid, and the water that would have followed that solute osmotically never appears. What remains in the duct is the concentrated granule product with too little fluid to carry it, which is why the secretion thickens and the ducts plug. Restoring any luminal anion conductance re-establishes the recycling step, the exchanger turns over again, solute enters, and water flow returns, which is the logic behind supplying a replacement conductance when the native one is missing. (Choice A) links the right variables in the wrong direction, since supplying the exchanger's incoming substrate promotes forward turnover rather than reversing it. (Choice B) rests on the belief that epithelial water movement is independently regulated, whereas water follows the osmotic gradient that the transported solute creates. (Choice D) applies correct reasoning at the wrong timescale and the wrong level, because inserting a channel changes ion flux within minutes and does not work by altering how much carrier protein the cell builds. This is a Scientific Reasoning and Problem Solving question because it asks the student to trace a directional chain from one restored ion supply through exchanger turnover to osmotic water flow and predict the effect on secretion volume.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- B2 Q15 . Attributing a juice change to one cell arm . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Attributing a juice change to one cell arm$q$,
    $q$An investigator tests whether a new compound stimulates the granule secreting cell population of the exocrine pancreas. Juice is sampled from the gland's duct after a standard meal, once without the compound and once during it, and the level of a granule protein in that juice is reported for each run. The level doubles under the compound, and the investigator concludes that the granule cells were stimulated. What additional measurement is required before that conclusion can stand?$q$,
    $q$[{"label":"A","text":"Confirm that the compound actually reaches the gland by assaying it in pancreatic tissue, since a substance absent from the organ cannot act on it."},{"label":"B","text":"Confirm that a second granule marker rose by the same factor, since two markers moving together establish that those cells were the source."},{"label":"C","text":"Confirm that the compound leaves the sample's pH unchanged, since protein readings are not valid in an alkaline sample."},{"label":"D","text":"Track the volume of juice obtained over the same interval, since a fall in the watery arm alone would raise a dissolved solute's level with no extra output from the cells in question."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests whether a measured change in pancreatic juice can be attributed to one of the two exocrine cell populations, which turns out to be a question about what the measurement actually is. The answer is D because the quantity reported is an amount per unit of fluid, so it rises whenever the numerator rises or the denominator falls, and only the fluid collected over the same interval separates those two possibilities. The gland's two arms are driven separately, so the watery, buffer rich arm can slow while the granule arm holds steady. When that happens, the same amount of granule product is dissolved in less fluid, and its level in the sample doubles even though the cells under test released nothing extra. Adding the fluid measurement converts the reading into an output per unit time, which is the quantity the investigator's conclusion is actually about. Without it, a compound that merely suppressed the fluid arm would be reported as a stimulant of the granule arm, which is the opposite of the truth. (Choice A) proposes a sensible general control, confirming that the compound reaches the organ, but a positive result there is compatible with both explanations and so does not resolve the ambiguity in the reading. (Choice B) is the most tempting option, since agreement between two markers feels like corroboration, yet a drop in fluid concentrates every dissolved granule product by the same factor, so two markers rising together is exactly what the rival explanation also predicts. (Choice C) rests on a false premise, because pancreatic juice is normally alkaline and protein measurements are not invalidated by that, so this adds nothing about the source of the change. This is a Reasoning about the Design and Execution of Research question because it asks the student to recognise that a concentration measurement confounds amount with dilution and to name the additional measurement that removes the confound.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q16 . Gastric self-digestion and the maintained lining . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Gastric self-digestion and the maintained lining$q$,
    $q$The wall of the stomach is itself built from protein, and it sits in a fluid containing both a strong acid and a protein splitting activity capable of breaking that wall down. A patient takes a drug for several weeks that thins the slippery film covering the wall and also slows division of the stem cells that renew its innermost sheet of cells. Shallow erosions appear. Which arrangement best accounts for why this damage does not normally occur and for why it occurs now?$q$,
    $q$[{"label":"A","text":"The wall is made of a protein that the gastric protein splitting activity cannot cleave, and the drug converts it into a cleavable form."},{"label":"B","text":"The film is impermeable to acid, so the cells beneath it never encounter a low pH, and the drug simply opens gaps in an otherwise permanent shield."},{"label":"C","text":"A sheet of dead, hardened cells covers the innermost layer and absorbs the damage, and the drug prevents that sheet from forming."},{"label":"D","text":"The lining has no chemical resistance of its own: a buffer loaded coating blunts the corrosive strength right at the surface, and cells lost anyway are replaced within days, so integrity depends on continuous upkeep."}]$q$::jsonb,
    'D',
    $q$This question falls under Organ Systems and tests why an organ built of protein survives daily immersion in a fluid designed to break protein down, and what happens when the arrangement that permits this is interfered with. The answer is D because the wall is not chemically special, so it must be defended by two active, ongoing processes rather than by any fixed property of the tissue itself. The first is a thick secreted layer carrying dissolved buffer, which does not have to exclude acid completely: it only has to keep the corrosive strength low in the thin zone immediately against the cells. The second is replacement, since the innermost sheet of cells is shed and rebuilt over a matter of days, so damage that does occur is outrun by construction. Both are maintenance, and maintenance can be starved. The drug in this patient degrades both at once, which is why erosions follow, and it also explains the pattern of the injury: shallow at first, because the loss begins at the exposed surface and works inward only as the deficit persists. Read the other way, if either defence alone were sufficient, a drug that impaired only one of them would be harmless, and it is not.

(Choice A) Tissue protein is not exempt from attack. The stomach wall is ordinary protein and would be broken down exactly like a meal if it were exposed, which is precisely why an ongoing defence is needed at all.

(Choice B) Half right, and the half it omits is what the question turns on. A secreted layer does contribute, but it works by neutralising within itself rather than by being a sealed wall, and treating it as a permanent shield leaves no reason why slowing the renewal of cells should matter, when in this patient it clearly does.

(Choice C) This borrows a genuine feature of other linings. Surfaces built to take mechanical abuse do carry a sacrificial hardened layer, but the surface in question here is a living secretory sheet, and its protection comes from being rebuilt rather than from being dead.

This is a Scientific Reasoning and Problem Solving question because it asks you to work backwards from a drug that disables two maintenance processes at once to the arrangement that must ordinarily be keeping an organ from consuming itself.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    100
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q;

-- B2 Q17 . Separating enzyme loss from bile loss . hard . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Separating enzyme loss from bile loss$q$,
    $q$Two adults are evaluated for bulky, greasy stools. Neither has had abdominal surgery, both eat the same standardised diet, and both have a normal small intestinal biopsy. Laboratory results are shown below.

| Measurement | Reference | Patient 1 | Patient 2 |
|---|---|---|---|
| Faecal fat (g/day) | under 7 | 24 | 22 |
| Faecal nitrogen (g/day) | under 2 | 6.1 | 1.6 |
| Undigested starch granules | absent | present | absent |

Which conclusion is best supported by these results?$q$,
    $q$[{"label":"A","text":"Both have the same underlying deficiency, and patient 2 is simply at an earlier and milder stage of it."},{"label":"B","text":"Patient 1 has lost a gland supplying catalysts for protein and carbohydrate as well as lipid, whereas patient 2 has lost a secretion that assists lipid handling alone."},{"label":"C","text":"Patient 1 has lost a secretion that assists lipid handling alone, whereas patient 2 has lost a gland supplying catalysts for several classes of nutrient."},{"label":"D","text":"The normal nitrogen value in patient 2 shows that protein handling is finished in the stomach rather than beyond it."}]$q$::jsonb,
    'B',
    $q$This question falls under Organ Systems and tests the difference between fat loss in the stool caused by a missing set of catalysts and fat loss caused by a missing biliary contribution. The answer is B because the two patients lose fat to the same degree but differ on every other marker, and only one of the two candidate sources contributes to the handling of all three classes of nutrient. The pancreas supplies the catalysts that act on lipid, on protein and on starch, so when that gland fails all three markers move together, exactly the pattern in patient 1: fat high, nitrogen triple the upper limit, and starch granules surviving into the stool. The biliary contribution, by contrast, is a mixture of salts, pigments and lipids that carries no catalytic activity at all, so its absence can degrade lipid handling while leaving protein and starch handling untouched, which is the isolated fat elevation seen in patient 2. The normal biopsies rule out a defect of the absorbing surface itself in both, and identical diets rule out an intake difference, so it is the pattern across markers, not the fat value, that assigns each patient to an organ. A practical corollary is that oral replacement of the missing catalysts would correct patient 1 but not patient 2.

(Choice A) A single deficiency of differing severity would scale all markers together. Patient 2 has fat almost as high as patient 1 yet nitrogen inside the reference range, which is a qualitative difference in pattern, not a difference in degree.

(Choice C) This assigns the two patients to the wrong sources. It predicts that the person with normal nitrogen and no starch granules has lost the multi nutrient catalyst supply, which contradicts both of those normal markers.

(Choice D) Protein handling is not finished in the stomach; a large share happens beyond it. Patient 2's normal nitrogen shows that whatever is missing in that patient does not touch protein, not that the stomach completes the job.

This is a Data-based and Statistical Reasoning question because it asks you to compare three measured markers across two patients and use the overall pattern, rather than the single shared abnormal value, to assign each patient to a different failing source.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    110
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'reversed_relationship', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q18 . Membrane anchored final digestion step . medium . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Membrane anchored final digestion step$q$,
    $q$An investigator asks whether the catalysts responsible for the last step of sugar and small peptide breakdown are released into the gut fluid or held on the surface of the absorbing cells. Three observations from an animal model are available.

I. Fluid drawn from the gut and cleared of all cells splits almost none of an added disaccharide.
II. Membrane fragments stripped from the epithelial surface and washed repeatedly still split the disaccharide.
III. Monosaccharide appears in the venous blood draining an intact loop after a disaccharide is placed inside that loop.

Which observations distinguish between the two possibilities?$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"II only"},{"label":"C","text":"I and II only"},{"label":"D","text":"I and III only"}]$q$::jsonb,
    'C',
    $q$This question falls under Organ Systems and tests whether the final step of carbohydrate and small peptide breakdown happens free in the lumen or on the absorbing cell surface, and how an experiment could tell the two apart. The answer is C because observation I removes the free fluid hypothesis and observation II places the activity on the washed membrane, while observation III is compatible with either arrangement and therefore settles nothing. Cell free fluid that fails to split the disaccharide shows that nothing capable of the final cut is dissolved in the gut contents, which is the prediction the free fluid hypothesis makes and fails. Washed membrane fragments that keep the activity show the opposite: the activity travels with the membrane through repeated washes, which is what anchoring means operationally. Together the two observations force the conclusion that the last cut is made at the surface itself, which leaves the products of that cut a fraction of a micrometre from the machinery that carries them inward. Breakdown and uptake are therefore not sequential events in separate places but neighbouring events at one location, so the monomer released never has to survive a trip across the lumen.

(Choice A) Observation I alone is correct but incomplete. It shows that the free fluid is inactive, yet on its own it leaves open the possibility that the disaccharide is taken up whole and split somewhere inside the cell, so it cannot establish a surface location.

(Choice B) Observation II alone is also incomplete. A membrane preparation could in principle carry adsorbed material that had originally been released into the fluid, so without observation I the free fluid alternative is not excluded.

(Choice D) Observation III is a true result but does not discriminate. Monomer reaching the blood after disaccharide is placed in an intact loop is expected whether the cut happens in the fluid, on the surface, or inside the cell, so pairing it with I adds no discriminating power.

This is a Reasoning about the Design and Execution of Research question because it asks you to judge which of three results actually discriminate between two competing locations for an enzymatic step and which one merely confirms that the overall process works.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    90
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'adjacent_fact', NULL FROM q;

-- B2 Q19 . Starch relay across the acidic compartment . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Starch relay across the acidic compartment$q$,
    $q$A patient's salivary glands are lost to radiation, so food leaving the mouth carries no starch splitting enzyme. Over a standard meal, measured starch digestion is nonetheless close to normal. Which explanation best accounts for this result?$q$,
    $q$[{"label":"A","text":"The enzyme added in the mouth is inactivated soon after the meal is acidified, and a gland emptying further down the tract does most of the work anyway."},{"label":"B","text":"Starch is taken up whole by the absorbing cells and split apart inside them."},{"label":"C","text":"The gastric lining releases its own starch splitting enzyme that takes over whenever the oral supply is missing."},{"label":"D","text":"The oral contribution handles only a minor share of a meal, so the assay is not sensitive enough to register its loss."}]$q$::jsonb,
    'A',
    $q$This question falls under Organ Systems and tests the relay by which starch breakdown is begun at one site, halted at a second, and resumed at a third. The answer is A because the enzyme released with saliva survives only until the meal is acidified in the stomach, so even in a healthy person its window of action is brief, and the bulk of starch breakdown is performed by a similar enzyme delivered into the small bowel from an accessory gland. Losing the oral source therefore removes a short opening contribution rather than the main one, and the total measured over a whole meal barely changes. The sequence matters more than the chemistry: site one starts the job, the acidic compartment ends that first attempt, and the third site restarts the same job with a fresh supply delivered into surroundings where it keeps working until the job is done. This organisation is why losing saliva causes swallowing difficulty and dental problems rather than carbohydrate malnutrition, and it is why the patient who passes undigested starch is the one who has lost the downstream accessory gland, not the salivary glands.

(Choice B) Starch is far too large to cross the absorbing membrane, and no route exists for importing an intact polysaccharide for later breakdown inside the cell. Only the single sugar products are transported.

(Choice C) This names the wrong stage as the rescuer. The stomach contributes a protein splitting activity and an acidic environment, and that acidity ends starch breakdown for the duration of gastric residence rather than continuing it.

(Choice D) The premise is right and the conclusion is wrong. The oral contribution is indeed a minor share, but the reason the measurement stays normal is that another gland genuinely completes the job, not that the measurement is too blunt to notice a real shortfall.

This is a Scientific Reasoning and Problem Solving question because it asks you to explain a preserved outcome after one contributor is removed by tracing where along the tract the same job is started, stopped, and taken up again.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'partial_truth', NULL FROM q;

-- B2 Q20 . Consequence of losing salivary secretion . easy . skill 1
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Consequence of losing salivary secretion$q$,
    $q$Radiation treatment for a neck tumour destroys most of a patient's salivary tissue. She now finds that dry foods are hard to gather and move around inside her mouth and that her oral lining feels raw after meals, yet a starch-rich breakfast still raises her blood glucose on a normal time course. Which single account fits both the mechanical difficulty and the preserved glucose response?$q$,
    $q$[{"label":"A","text":"What was lost is mainly water and mucin, which wet the meal and hold the fragments together, whereas the enzymatic step begun in the mouth is duplicated further along by the exocrine pancreas."},{"label":"B","text":"Most dietary starch is normally digested in the mouth, so the intact glucose response indicates that a substantial amount of secreting tissue survived the treatment."},{"label":"C","text":"The buffering of oral pH is the function that was lost; the secretion's principal job is protecting tooth enamel rather than handling the meal itself."},{"label":"D","text":"The deficit is one of total fluid volume for the whole tract, so the same dryness will slow the movement of intestinal contents to an equal degree."}]$q$::jsonb,
    'A',
    $q$This item sits in the Organ Systems category and tests what the fluid bathing the oral cavity contributes to a meal apart from the enzyme it carries. The answer is A because that fluid is overwhelmingly water carrying mucin, so its loss removes wetting and cohesion immediately, while the carbohydrate-splitting activity it supplies is reproduced further along the tract by pancreatic secretion. Between one and one and a half litres are produced daily and about ninety-nine percent of that volume is water; the mucin fraction is what makes chewed fragments stick into a single soft mass and what keeps the mucosal surfaces sliding past one another without abrasion. No other gland replaces that mechanical service in the oral cavity, which is why dryness shows up first as difficulty manipulating dry food and as a sore, easily abraded lining. The enzyme carried in that fluid, by contrast, is redundant: an equivalent starch-splitting activity is delivered into the small intestine by the exocrine pancreas, and it is there that most carbohydrate is actually reduced to absorbable units, so a normal post-meal glucose curve is exactly what one should expect. The pattern of symptoms therefore separates the irreplaceable role from the duplicated one. (Choice B) This overstates oral digestion. Food spends far too little time in the mouth for more than a small fraction of dietary starch to be broken down there, and the activity is halted once the material meets gastric acid, so a normal glucose response is not evidence that glandular tissue survived. (Choice C) Buffering does occur and does help protect enamel, but this is a true statement about a different consequence of the same fluid and does nothing to explain why the patient cannot manage a dry cracker or why her lining is raw. (Choice D) This generalises a local defect to the whole tract. The fluid in question is delivered into the oral cavity only; downstream segments receive their own copious watery secretions, so intestinal contents remain fluid even when the mouth is dry. This is a Knowledge of Scientific Concepts and Principles question because it asks the student to recall which of this secretion's several jobs has no substitute elsewhere in the tract and therefore surfaces as a symptom when the secretion is gone.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    1,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', NULL FROM q;

-- B2 Q21 . Multiplicative tiers of absorptive surface . medium . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Multiplicative tiers of absorptive surface$q$,
    $q$Model a length of small intestine first as a smooth-walled cylinder. The permanent ridges of its wall raise the inner surface about threefold; the small vascularised projections carried on those ridges raise it about tenfold beyond that; and the finer extensions on the exposed face of every absorptive cell raise it roughly twentyfold again. Approximately how much greater is the real absorptive surface than that of the smooth cylinder?$q$,
    $q$[{"label":"A","text":"About 33 times greater"},{"label":"B","text":"About 200 times greater"},{"label":"C","text":"About 600 times greater"},{"label":"D","text":"About 6,000 times greater"}]$q$::jsonb,
    'C',
    $q$This item sits in the Organ Systems category and tests how nested structural elaborations of a lining combine to amplify absorptive area. The answer is C because each tier operates on the surface generated by the tier above it, so the three factors compose by multiplication: three times ten times twenty gives roughly six hundred. The reason the amplification is multiplicative rather than additive is geometric. The ridges enlarge the wall of the tube; the projections then stand on that already enlarged wall, so they multiply whatever area the ridges produced rather than adding a fixed increment to it; and the finest extensions decorate the exposed face of each cell covering those projections, multiplying again. Ordering the tiers by size makes the nesting explicit: a ridge is a gross fold of the wall, a projection is roughly half a millimetre to a millimetre long, and the finest extensions are on the order of a micrometre, with about two hundred million of them per square millimetre. A single tube a few centimetres in diameter therefore presents an absorptive surface out of all proportion to its external dimensions, which is what permits a meal to be taken up during a transit of only a few hours. (Choice A) Adding the three factors gives 33 and treats each tier as an independent patch of extra lining bolted onto a smooth tube. That misreads the geometry: the tiers are stacked on one another, not laid side by side, so their contributions compound. (Choice B) Multiplying only the two finer tiers gives 200 and silently discards the gross folding of the wall. That folding is a real and independent contribution, and dropping it understates the total by the same factor of three it supplies. (Choice D) This carries an extra factor of ten and lands an order of magnitude above the true amplification. Anchoring the estimate matters, because the accepted figure for the combined effect of the three tiers is a few hundredfold rather than several thousandfold. This is a Scientific Reasoning and Problem Solving question because it asks the student to decide whether three nested amplification factors combine by addition or by multiplication and then to carry that combination through to a numerical estimate.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    85
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'D', 'scale_unit_error', NULL FROM q;

-- B2 Q22 . Surface loss and membrane-stage digestion . hard . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Surface loss and membrane-stage digestion$q$,
    $q$An immune reaction to a dietary protein progressively flattens the finger-like projections of the duodenal and upper jejunal lining, while output from the exocrine pancreas stays normal. After a bowl of oatmeal a patient with this condition passes watery stools, and hydrogen appears in her breath, a gas produced when colonic bacteria ferment sugars that were never taken up further upstream. Which failure best accounts for the sugar reaching the colon?$q$,
    $q$[{"label":"A","text":"The lesion shrinks the area available for water reclamation, and that reduction by itself accounts for everything she passes."},{"label":"B","text":"The meal's starch is never reduced to two-sugar units at all, because the flattened lining can no longer release its secretions into the lumen."},{"label":"C","text":"The affected region moves its contents along too rapidly for uptake, so transit speed rather than any chemical step is limiting."},{"label":"D","text":"The last cleavage step, which turns two-sugar units into transportable single units, is done by enzymes anchored in the cell-surface membrane the lesion removes, so digestion halts one stage short."}]$q$::jsonb,
    'D',
    $q$This item sits in the Organ Systems category and tests where the final stage of carbohydrate breakdown physically happens and what fails when that site is lost. The answer is D because the enzymes that split two-sugar units are fixed to the membrane covering the finest extensions of the absorptive cells, so destroying that membrane removes the final catalytic step even when everything upstream of it is intact. The stem supplies the two facts needed to localise the fault. Pancreatic output is normal, so the luminal phase of starch breakdown proceeds and delivers short sugar units to the lining as usual; and fermentable sugar reaches the colon, so the material clearly was not taken up. Since the pancreas contributes enzymes to the lumen but not to the cell surface, the failure has to lie at the membrane-bound stage that follows. Unabsorbed sugar then holds water osmotically in the lumen, producing watery stools, and bacterial fermentation of that sugar releases hydrogen, some of which is taken into the blood and exhaled. The same injury also removes an enormous amount of absorptive area, but it is the loss of the membrane-anchored catalytic step that specifically explains why a digestible sugar arrives intact in the colon. (Choice A) Reduced water reclamation is real and does contribute to stool volume, but it is incomplete in a way that changes the answer: a pure water-handling defect would not leave fermentable sugar in the lumen, and it cannot explain the exhaled gas. (Choice B) This misplaces the failed stage. The stem states that exocrine output is normal, and that secretion comes from a gland lying outside the intestinal wall, so the luminal phase of starch breakdown is unaffected by loss of the lining's surface elaborations. (Choice C) Rapid transit can limit uptake in other settings, but nothing here indicates accelerated movement, and speed alone would leave partially processed sugars of every size rather than the specific failure of one catalytic step. This is a Scientific Reasoning and Problem Solving question because it asks the student to work backwards from an unabsorbed sugar and an exhaled fermentation product to the one digestive step that the destroyed surface had been performing.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', NULL FROM q
  UNION ALL SELECT q.id, 'B', 'process_step_confusion', NULL FROM q
  UNION ALL SELECT q.id, 'C', 'misconception', NULL FROM q;

-- B2 Q23 . Energy source behind uphill sugar uptake . hard . skill 3
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Energy source behind uphill sugar uptake$q$,
    $q$Absorptive intestinal cells are grown as a sealed sheet on a porous filter, so that the bath on the lumen facing side and the bath on the blood facing side can be sampled and changed independently. Sugar is supplied to the lumen facing bath, and after an hour the cells hold sugar at roughly ten times the level measured in either bath. Investigators wish to show that this build up draws on an energy supply rather than on the properties of the sugar carrier alone.

Which of the numbered manipulations would be expected to abolish the build up?

I. Adding a blocker of the ion pump to the blood facing bath only
II. Replacing the sodium of the lumen facing bath with an equal amount of a cation the cells cannot transport
III. Adding a blocker of the sugar carrier in the blood facing membrane$q$,
    $q$[{"label":"A","text":"I only"},{"label":"B","text":"I and II only"},{"label":"C","text":"II and III only"},{"label":"D","text":"I, II, and III"}]$q$::jsonb,
    'B',
    $q$This Organ Systems question tests where the free energy for uphill sugar entry at the lumen facing membrane of an absorptive cell actually originates. The answer is B because manipulations I and II each strip away part of the ion driving force, whereas manipulation III acts on a later step and would leave the cells holding more sugar rather than less. The carrier at the lumen facing membrane does not split ATP itself. It binds an ion and a sugar together, and the downhill slide of that ion into the cell supplies the work that drags sugar inward even after the lumen has been picked nearly clean. That slide exists only because a pump on the opposite membrane keeps expelling the ion, so the pump is the ultimate energy source even though it never touches a sugar molecule. This is why a blocker placed only in the blood facing bath shuts down entry occurring at the opposite face of the cell, which is the classic fingerprint of an energy supply that arrives secondhand. Removing the coupling ion from the lumen bath attacks the same dependence from the other end and is equally decisive.

(Choice A) Manipulation I alone does demonstrate a dependence on the pump, but stopping there understates the experiment. Manipulation II removes the coupling ion at the site of entry and abolishes the build up just as surely, and running both closes the loophole that the pump blocker acted on the sugar carrier directly.

(Choice C) Manipulation II belongs in the answer, but pairing it with III mistakes a downstream event for the one that requires work. The step that consumes free energy is the one at the lumen facing membrane, and it stays fully intact when the far membrane is blocked.

(Choice D) Including III assumes that anything interrupting the path from lumen to blood must lower the sugar held inside. Closing the exit instead traps sugar in the cytoplasm, so the level inside would rise, which is the opposite of abolishing the build up.

This is a Reasoning about the Design and Execution of Research question because it asks the student to judge which experimental manipulations genuinely test the proposed energy dependence and which one perturbs a step that carries no energetic burden.$q$,
    'hard',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    3,
    105
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'partial_truth', $q$incomplete_set$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$wrong_step_targeted$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'misconception', $q$any_block_lowers_all$q$ FROM q;

-- B2 Q24 . Ceiling on uncoupled monosaccharide uptake . medium . skill 4
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Ceiling on uncoupled monosaccharide uptake$q$,
    $q$Sealed loops of small intestine were filled on the lumen side with 5.0 mM of monosaccharide P, and a matched set was filled with 5.0 mM of monosaccharide Q. Sodium was present in every loop. The fluid bathing the blood facing side was left undisturbed, so nothing was carried away from it. Lumen fluid and epithelial cells were sampled at intervals.

| Time (min) | P in lumen (mM) | P in cell (mM) | Q in lumen (mM) | Q in cell (mM) |
| --- | --- | --- | --- | --- |
| 0 | 5.0 | 0.0 | 5.0 | 0.0 |
| 15 | 2.1 | 6.8 | 2.8 | 2.6 |
| 30 | 0.9 | 9.1 | 2.7 | 2.7 |
| 60 | 0.4 | 9.6 | 2.7 | 2.7 |

If the loops were left for several more hours, which outcome is best supported by these results?$q$,
    $q$[{"label":"A","text":"P would fall closer to zero in the lumen fluid, while Q would stay near the point it has already reached."},{"label":"B","text":"Both sugars would end up near zero in the lumen fluid, Q merely taking longer to get there."},{"label":"C","text":"Q would climb inside the cells until it matched P, since sodium was supplied to both sets of loops."},{"label":"D","text":"Q would drain back out of the cells until its lumen figure returned toward 5.0 mM."}]$q$::jsonb,
    'A',
    $q$This Organ Systems item tests what sets the limit on a membrane crossing that has no energy input behind it. The answer is A because P is still being carried inward at 60 minutes while the lumen holds only a small fraction of what the cell holds, whereas Q stopped changing after 15 minutes and has no gradient left to exploit. Follow each sugar across the sampling times. P drops from 2.1 to 0.9 to 0.4 in the lumen while the cell figure climbs to 9.6, so P is being taken up at a moment when the source fluid holds roughly one part for every twenty four parts at the destination. Nothing but an outside supply of free energy can sustain that arrangement, and here it is the inward slide of an ion on the shared carrier, paid for in the end by the pump that keeps expelling that ion. Q instead flattens at 2.7 on both sides and does not budge between 30 and 60 minutes, which is exactly what a plain facilitating protein does: it speeds passage in both directions and stalls the instant the two sides match. Because the fluid on the blood side is never drained, nothing can re establish a gradient for Q, so more time buys nothing. The physiological consequence is that a heavy dietary load of a sugar carried this way leaves a residue in the gut and passes onward, whereas a coupled sugar is taken up essentially to completion.

(Choice B) Speed and stopping point are different properties, and only the second is at issue. Q was not even markedly slower over the first 15 minutes, since its lumen figure fell 2.2 mM while P fell 2.9 mM. Q simply ran out of gradient, and a protein with no energy behind it never carries anything past the point where the two sides match, so extra hours cannot close the gap.

(Choice C) Sodium was indeed supplied to both sets of loops, but that fact alone settles nothing. Had Q been coupled to the ion, it would have been dragged past the matching point as P was, even if less far. The flat pair of 2.7 values shows that no additional pull was acting on Q at all.

(Choice D) This reverses the direction of net movement. Where the two sides match there is no net flux either way, so Q has no tendency to run back into the lumen, and the unchanging pair of figures between 30 and 60 minutes rules out any such drift.

This is a Data-based and Statistical Reasoning question because it asks the student to read a time course, distinguish a carrier that has plateaued from one that is still working, and extrapolate each trend beyond the final sampling point.$q$,
    'medium',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    4,
    95
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'B', 'misconception', $q$rate_versus_endpoint$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'adjacent_fact', $q$everything_is_coupled$q$ FROM q
  UNION ALL SELECT q.id, 'D', 'reversed_relationship', $q$backflux_prediction$q$ FROM q;

-- B2 Q25 . Why the exit step needs no coupling . easy . skill 2
WITH q AS (
  INSERT INTO public.questions
    (section, topic, subtopic, question_text, options, correct_answer, explanation,
     difficulty, foundation, content_category, discipline, cognitive_skill, estimated_time_seconds)
  VALUES (
    'bio_biochem',
    'The Digestive System',
    $q$Why the exit step needs no coupling$q$,
    $q$In an intestinal cell that is actively absorbing, the carrier at the lumen facing membrane admits sodium and sugar together, and it keeps drawing sugar in long after the fluid in the lumen has been picked nearly clean. A student argues that the protein handling sugar exit at the blood facing membrane must therefore also be tied to sodium entry. Which objection to that argument is strongest?$q$,
    $q$[{"label":"A","text":"Proteins that bind sodium can only bring material into a cell and cannot carry anything the other way."},{"label":"B","text":"The fluid on the blood side holds more sugar than the cell does, so exit would have to be driven uphill as well."},{"label":"C","text":"Exit does need a protein, but the cell simply reuses the one from the lumen facing membrane at the other face."},{"label":"D","text":"Sugar has piled up inside the cell, so its passage outward at that face runs downhill and needs no extra push behind it."}]$q$::jsonb,
    'D',
    $q$This Organ Systems item tests why the two faces of an absorptive cell confront different transport problems and therefore use different machinery. The answer is D because a cell that keeps collecting sugar from an almost empty lumen must end up holding far more sugar than the fluid it delivers into, so the final step is a downhill one that needs nothing more than a protein that lets the molecule slide. Uphill work is demanded only at the lumen facing membrane, where sugar has to be taken from a source that has been stripped nearly bare. Coupling to an ion solves that specific problem, and the cell pays for it indirectly through the pump that restores the ion gradient. Repeating the same arrangement at the far membrane would be wasted expense, and worse than wasted: a protein that brought an ion inward there would tend to drag sugar back into the cell instead of releasing it toward the blood. The general principle is that a transport protein is matched to the direction and the steepness of the task in front of it, not to the identity of the molecule it happens to move.

(Choice A) Ion coupled proteins are perfectly capable of running outward as well as inward, and exchangers that expel one solute while admitting an ion are common in many tissues. The reason coupling is unnecessary at the blood facing face is the favorable arrangement of sugar across it, not a restriction on what such proteins can do.

(Choice B) This inverts the actual situation. The absorbing cell builds sugar up to a level well above that of the fluid beyond the blood facing membrane, which is precisely why exit poses no energetic difficulty and why the cell can unload sugar continuously into the circulation.

(Choice C) The two faces carry distinct proteins suited to distinct jobs, and reusing the entry protein would not help. A protein tuned to admit sugar alongside an ion, working at a face where that ion is not being replenished from outside, is poorly matched to the task of releasing sugar outward.

This is a Scientific Reasoning and Problem Solving question because it asks the student to compare the energetic demands at two faces of a single cell and to decide which one requires an added driving force.$q$,
    'easy',
    '3B',
    $q$Organ Systems$q$,
    'biology',
    2,
    70
  )
  RETURNING id
)
INSERT INTO public.question_distractor_metadata (question_id, choice_label, distractor_category, archetype)
  SELECT q.id, 'A', 'misconception', $q$coupling_is_import_only$q$ FROM q
  UNION ALL SELECT q.id, 'B', 'reversed_relationship', $q$inverted_gradient$q$ FROM q
  UNION ALL SELECT q.id, 'C', 'process_step_confusion', $q$same_protein_both_faces$q$ FROM q;

COMMIT;

-- Verification: after batches 1 and 2, expect 50 questions and 150 distractor rows.
SELECT
  (SELECT COUNT(*) FROM public.questions WHERE topic = 'The Digestive System') AS questions,
  (SELECT COUNT(*) FROM public.question_distractor_metadata m
     JOIN public.questions x ON x.id = m.question_id
   WHERE x.topic = 'The Digestive System') AS distractor_rows;
